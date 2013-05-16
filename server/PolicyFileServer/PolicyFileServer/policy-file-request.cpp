// policy-file-request.cpp : 定义控制台应用程序的入口点。
//

#include "stdafx.h"
#include <ctime>
#include <iostream>
#include <string>
#include <fstream>
#include <boost/bind.hpp>
#include <boost/shared_ptr.hpp>
#include <boost/enable_shared_from_this.hpp>
#include <boost/asio.hpp>

#include <boost/property_tree/ptree.hpp>
#include <boost/property_tree/ini_parser.hpp>

#define MAX_RCV_BUF_SIZE 1024

using boost::asio::ip::tcp;
using namespace std;

typedef unsigned int uint;

class tcp_connection
    : public boost::enable_shared_from_this<tcp_connection>
{
public:
    typedef boost::shared_ptr<tcp_connection> pointer;

    static pointer create(boost::asio::io_service& io_service)
    {
        return pointer(new tcp_connection(io_service));
    }

    tcp::socket& socket()
    {
        return socket_;
    }

    void start()
    {
        //_send_response();
        _receive();
    }

    void disconnect()
    {
        socket_.close();
        cout << "disconnect" <<endl;
    }

private:
    tcp_connection(boost::asio::io_service& io_service)
        : socket_(io_service)
    {
        recv_buffer_used_ = 0;
        memset(recv_buffer_, 0, MAX_RCV_BUF_SIZE);
    }

    void handle_write(const boost::system::error_code& /*error*/,
        size_t bytes_transferred)
    {
        cout << "sent:" << bytes_transferred << " bytes" <<endl;
        //disconnect();
    }
    void _send_response()
    {
        message_ = "<?xml version=\"1.0\"?>"
            "<cross-domain-policy>"
            "<allow-access-from domain=\"*\" to-ports=\"*\"/>"
            "</cross-domain-policy>";
        message_ += '\0';
        boost::asio::async_write(socket_, boost::asio::buffer(message_),
            boost::bind(&tcp_connection::handle_write, shared_from_this(),
            boost::asio::placeholders::error,
            boost::asio::placeholders::bytes_transferred));
    }

    void _receive()
    {
        socket_.async_receive(
            boost::asio::buffer(recv_buffer_ + recv_buffer_used_ ,MAX_RCV_BUF_SIZE - recv_buffer_used_),
            boost::bind(&tcp_connection::_receive_handler, shared_from_this(),
            boost::asio::placeholders::error,
            boost::asio::placeholders::bytes_transferred)
            );
    }

    void _decode(size_t bytes_transferred)
    {
        using namespace std;
        cout << "receive " << bytes_transferred << endl;

        size_t decoded_buffer_size = 0;
        std::string request = "<policy-file-request/>";
        
        recv_buffer_used_ += bytes_transferred;
        if (recv_buffer_used_ >= request.length())
        {
            if (recv_buffer_ == request)
            {
                _send_response();

                decoded_buffer_size += request.length();
                std::cout << "send the info" << std::endl;
            }
        }

        if (decoded_buffer_size > 0)
        {
            if (decoded_buffer_size != recv_buffer_used_)
                memmove(recv_buffer_, recv_buffer_ + decoded_buffer_size, recv_buffer_used_ - decoded_buffer_size);
            recv_buffer_used_-= decoded_buffer_size;
        }

        if (recv_buffer_used_ > 0)
            cout << recv_buffer_ << endl;
    }

    void _receive_handler(const boost::system::error_code &error, size_t bytes_transferred)
    {
        if ( !error )
        {
            if ( bytes_transferred > 0)
            {
                _decode(bytes_transferred);
                _receive();
                return;
            }
        }
        else if ( error == boost::asio::error::eof )
        {
            cout  << error.message() << endl;
            disconnect();

        }
        else
        {
            cout << "quit" <<endl;
            disconnect();
        }
    }

    tcp::socket socket_;
    char recv_buffer_[MAX_RCV_BUF_SIZE];
    size_t recv_buffer_used_;
    std::string message_;
};

class tcp_server
{
public:
    tcp_server(boost::asio::io_service& io_service, boost::uint16_t port)
        : acceptor_(io_service, tcp::endpoint(tcp::v4(), port))
    {
        start_accept();
    }

private:
    void start_accept()
    {
        tcp_connection::pointer new_connection =
            tcp_connection::create(acceptor_.get_io_service());

        acceptor_.async_accept(new_connection->socket(),
            boost::bind(&tcp_server::handle_accept, this, new_connection,
            boost::asio::placeholders::error));
    }

    void handle_accept(tcp_connection::pointer new_connection,
        const boost::system::error_code& error)
    {
        if (!error)
        {
            new_connection->start();
            UpdateLogFile();
            time_t now = time(0);
            m_fsOutput << std::string(ctime(&now)).substr(11, 9);
            m_fsOutput << new_connection->socket().remote_endpoint().address().to_string() << std::endl;
            m_fsOutput.flush();

            start_accept();
        }
    }

    static void UpdateLogFile()
    {
        //time_t now = time(0);
        std::string strFilePath;
        time_t t = time(NULL);    
        tm ptm;
        uint temp = (uint)(t / 86400);

        if (m_strFileName.empty())
        {
            char szToday[74] = {0};
#ifdef WIN32
            localtime_s(&ptm, &t);
            ::_snprintf(szToday, 64, "user_%d_%.2d_%.2d.log", ptm.tm_year+1900, ptm.tm_mon+1, ptm.tm_mday);
#else
            localtime_r(&t, &ptm);
            snprintf(szToday, 64, "user_%d_%.2d_%.2d.log", ptm.tm_year+1900, ptm.tm_mon+1, ptm.tm_mday);
#endif
            m_nLastDate = temp;// get the date
            strFilePath = szToday;
            m_strFileName = szToday;
            m_fsOutput.open(strFilePath.c_str(), std::ios_base::app);
        }
        else
        {
            if (m_nLastDate != temp)
            {
                char szToday[74] = {0};
#ifdef WIN32
                localtime_s(&ptm, &t);
                ::_snprintf(szToday, 64, "user_%d_%.2d_%.2d.log", ptm.tm_year+1900, ptm.tm_mon+1, ptm.tm_mday);
#else
                localtime_r(&t, &ptm);
                snprintf(szToday, 64, "user_%d_%.2d_%.2d.log", ptm.tm_year+1900, ptm.tm_mon+1, ptm.tm_mday);
#endif
                m_nLastDate = temp;
                strFilePath = szToday;
                m_strFileName = szToday;
                m_fsOutput.close();
                m_fsOutput.open(strFilePath.c_str(), std::ios_base::app);
            }
        }
    }

    tcp::acceptor acceptor_;
    static std::string m_strFileName;
    static uint        m_nLastDate; 
    static std::ofstream m_fsOutput;
};

std::string tcp_server::m_strFileName;
uint tcp_server::m_nLastDate; 
std::ofstream tcp_server::m_fsOutput;

int main()
{
    try
    {
        namespace pt = boost::property_tree;
        pt::ptree   conf;
        try
        {
            pt::ini_parser::read_ini("conf.ini",conf);
        }
        catch( const std::exception& e )
        {
            std::cerr << e.what() << std::endl;
        }
        boost::uint16_t port = conf.get<boost::uint16_t>("net.port",9843);

        std::cout << "Listen on port: " << port << std::endl;

        boost::asio::io_service io_service;
        tcp_server server(io_service,port);
        io_service.run();
    }
    catch (std::exception& e)
    {
        std::cerr << e.what() << std::endl;
    }

    return 0;
}


