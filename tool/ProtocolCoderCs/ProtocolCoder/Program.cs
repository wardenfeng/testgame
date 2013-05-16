using System;
using System.Collections.Generic;
using System.Text;
using System.Xml;
using System.IO;
using System.Text.RegularExpressions;
using System.Diagnostics;
using System.Collections;

namespace ProtocolCoder
{
    class Program
    {
        static string szInputFileName = "";
        static string szOutputDirectory = "";
        static string szProtocolBufferContent = "";
        static Hashtable Variables = new Hashtable();
        static ArrayList MessageNames = new ArrayList();
        static Hashtable MessageInfosFromName = new Hashtable();
        static Hashtable MessageInfosFromID = new Hashtable();
        public static HashSet<string> ProtoFiles = new HashSet<string>();
        
        static bool IsServerProto;

        /// <summary>
        /// 解析命令行参数
        /// </summary>
        /// <param name="args">命令行参数</param>
        /// <returns>非help的成功解析返回true,否则返回false</returns>
        static bool AnalyzeCommandLine(string [] args)
        {
            bool bNeedHelp = false;

            string szHelp =
"Usage: " + Path.GetFileName(Process.GetCurrentProcess().MainModule.FileName) + " [OPTIONS] XMLFILE\n" +
"--help              Show this text and exit.\n" +
"--out_dir=OUT_DIR   Set the output directory. Leave this blank and set the \n" +
"                    default directory same with the input XML file"
;
            IsServerProto = false;
            for (int i = 0; i < args.GetLength(0); i++)
            {
                if (args[i] == "--help")
                {
                    bNeedHelp = true;
                    break;
                }

                if (args[i].ToLower() == "--server")
                    IsServerProto = true;

                if (args[i].ToLower() == "--client")
                    IsServerProto = false;

                if (args[i].ToLower().IndexOf(".xml") != -1)
                    szInputFileName = args[i];

                string szParam = "--out_dir=";
                if (args[i].ToLower().IndexOf(szParam) == 0)
                    szOutputDirectory = args[i].Substring(szParam.Length);
            }

            if (bNeedHelp)
            {
                Console.Write(szHelp);
                return false;
            }

            if (!File.Exists(szInputFileName))
            {
                Console.WriteLine(szInputFileName + "does not exist.");
                return false;
            }
            else
            {
                if (!System.IO.Path.IsPathRooted(szInputFileName))
                    szInputFileName = System.IO.Directory.GetCurrentDirectory() + "\\" +szInputFileName;
            }

            if (!System.IO.Path.IsPathRooted(szOutputDirectory))
            {
                // get the absolute directory
                szOutputDirectory = System.IO.Directory.GetCurrentDirectory() + "\\" + szOutputDirectory;
            }

            if (!System.IO.Directory.Exists(szOutputDirectory))
            {
                Console.WriteLine(szOutputDirectory + " does not exit.");
                return false;
            }

            Variables["InputFile"] = System.IO.Path.GetFileNameWithoutExtension(szInputFileName);

            return true;

        }

        /// <summary>
        /// 获取protocolbuffers节点内容
        /// </summary>
        /// <param name="coderNode">coder根节点</param>
        /// <returns>获取成功返回true</returns>
        static bool GetProtocolBufferContent(XmlNode coderNode)
        {
            try
            {
                szProtocolBufferContent = coderNode["protocolbuffers"].InnerText;
                if (szProtocolBufferContent.Length == 0)
                    throw new Exception("protocolbuffers节点内容为空");
                return true;
            }
            catch (System.Exception)
            {
                Console.WriteLine("无法找到protocolbuffers节点,或者节点内容为空");
                return false;	
            }
        }



        

        

        /// <summary>
        /// 分析protocol buffers内容，主要是为了得到message信息
        /// </summary>
        /// <returns></returns>
        static bool GetMessagesFromProtocolBuffers()
        {
            ProtoAnalyzer analyzer = new ProtoAnalyzer(szProtocolBufferContent);
            foreach (string str in analyzer.MessageNames)
                MessageNames.Add(str);
            return true;
        }

        /// <summary>
        /// 得到Message的具体信息
        /// </summary>
        /// <param name="coderNode"></param>
        /// <returns></returns>
        static bool GetMessageInfos(XmlNode coderNode)
        {
            bool bFlag = true;
            foreach(XmlNode node in coderNode["messages"])
            {
                if (node.NodeType != XmlNodeType.Element)
                    continue;

                MessageInfo info = new MessageInfo();
                info.Name = node.Attributes["name"].Value;
                info.ID = Convert.ToInt32(node.Attributes["id"].Value);
                info.Type = node.Attributes["type"].Value;
                if (node.Attributes["proc_fun"] != null)
                    info.func = node.Attributes["proc_fun"].Value;
                info.ByServer = node.Attributes["by"].Value.ToLower() == "server";

                if (MessageInfosFromName.ContainsKey(info.Name))
                {
                    Console.WriteLine(String.Format("错误 {0}:name重复定义:{0}", node.OuterXml));
                    bFlag = false;
                }

                MessageInfosFromName[info.Name] = info;

                if (MessageInfosFromID.ContainsKey(info.ID))
                {
                    Console.WriteLine(String.Format("错误 {0}:id重复定义:{0}", node.OuterXml));
                    bFlag = false;
                }

                if (!MessageNames.Contains(info.Type))
                {
                    Console.WriteLine(String.Format("错误 {0}: type没有在protocolbuffers中定义", node.OuterXml));
                    bFlag = false;
                }

                MessageInfosFromID[info.ID] = info;
                if (info.ID > Convert.ToInt32(Variables["MaxIndex"]))
                    Variables["MaxIndex"] = info.ID;

            }

            return bFlag;
        }

        /// <summary>
        /// 分析输入文件
        /// </summary>
        /// <param name="filename"></param>
        /// <returns></returns>
        static bool AnalyzeInputDocument(string filename)
        {
            try
            {
                XmlDocument xmlDoc = new XmlDocument();
                xmlDoc.Load(szInputFileName);
                XmlNode root = xmlDoc["coder"];
                // add prefix "C" to indicate it's type is class
                Variables["FactoryName"] = "C" + root.Attributes["name"].Value;
                Variables["FileName"] = root.Attributes["name"].Value;
                Variables["Version"] = root.Attributes["version"].Value;
                Variables["FILENAME"] = root.Attributes["name"].Value.ToUpper();

                XmlNode typenode = null;
                if (IsServerProto)
                    typenode = root["server"];
                else
                    typenode = root["client"];

                Variables["ProcessorClass"] = typenode.Attributes["processor"].Value;
                string strNamespace = typenode.Attributes["namespace"].Value;
                Variables["NameSpace"] = strNamespace;
                string [] IncFiles = new string [0];
                if (typenode.Attributes["include"] != null)
                    IncFiles = typenode.Attributes["include"].Value.Split(new char[] { ';' });
                if (IncFiles.Length > 0)
                    foreach (string str in IncFiles)
                        Variables["Include"] += string.Format("from {0} import *\n", str);
                else
                    Variables["Include"] = "";
                if (!GetProtocolBufferContent(root))
                    return false;

                // 分析protocol buffers内容，主要是为了得到message信息，以便对应MsgID检查
                GetMessagesFromProtocolBuffers();

                Variables["MaxIndex"] = -1;
                if (!GetMessageInfos(root))
                    return false;

                return true;
            }
            catch (System.Exception e)
            {
                Console.WriteLine(e.Message);
                return false;
            }
        }

        /// <summary>
        /// 生成protocol buffers内容
        /// </summary>
        static void GenerateProtocolBuffersFiles()
        {
            string szOutputProtoFile = szOutputDirectory + System.IO.Path.GetFileNameWithoutExtension(szInputFileName) + ".proto";
            using (StreamWriter sw = new StreamWriter(szOutputProtoFile, false, Encoding.GetEncoding("gb2312")))
            {
                if (Variables.Contains("NameSpace"))
                    sw.WriteLine("package " + Variables["NameSpace"]+';');
                sw.Write(szProtocolBufferContent);
            }
            string param = System.IO.Path.GetFileName(szOutputProtoFile);
            foreach (string s in ProtoFiles)
            {
                param += " " + s;
            }
            ProcessStartInfo startInfo = new ProcessStartInfo("ProtoGen.exe", param);
            startInfo.RedirectStandardError = true;
            startInfo.UseShellExecute = false;
            Process process = new Process();
            process.StartInfo = startInfo;
            process.Start();
            StreamReader myStreamReader = process.StandardError;
            process.WaitForExit();
            //process.Dispose();
            string error_string = myStreamReader.ReadLine();
            if (error_string != null && error_string.Length > 0)
            {
                throw new Exception(error_string);
            }
            //Process.Start("protoc.exe", arguments);
            System.IO.File.Move(System.IO.Path.GetFileNameWithoutExtension(szOutputProtoFile) + ".cs",
                szOutputDirectory + System.IO.Path.GetFileNameWithoutExtension(szOutputProtoFile) + ".cs");
        }

        static void Main(string[] args)
        {
            try
            {
                if (!AnalyzeCommandLine(args))
                    return;

                AnalyzeInputDocument(szInputFileName);

                GenerateProtocolBuffersFiles();

                Generator generator = new Generator(szOutputDirectory, Variables, MessageInfosFromName, IsServerProto);
                generator.Run();
            }
            catch (System.Exception e)
            {
                Console.WriteLine(e.Message);
            }
        }
    }

    struct MessageInfo 
    {
        public string Name;
        public int ID;
        public string Type;
        public string func;
        public bool ByServer;
    }
}
