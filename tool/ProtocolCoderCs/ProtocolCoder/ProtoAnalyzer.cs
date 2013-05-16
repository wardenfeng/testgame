using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Collections;
using System.IO;

namespace ProtocolCoder
{
    /************************************************************************/
    /* 用来解析XML文件                                                      */
    /************************************************************************/
    class ProtoAnalyzer
    {
        private int nCurrentPos = 0;

        private string szProtocolBufferContent;

        public ArrayList MessageNames = new ArrayList();

        private ArrayList ProtoAnalyzers = new ArrayList();

        public ProtoAnalyzer(string protoContent)
        {
            szProtocolBufferContent = protoContent;

            AnalyzeImport();
            string MessageName;
            while (GetNextMessageName(out MessageName))
            {
                MessageNames.Add(MessageName);
            }

            foreach (ProtoAnalyzer analyzer in ProtoAnalyzers)
            {
                foreach (string str in analyzer.MessageNames)
                    MessageNames.Add(str);
            }
        }

        /// <summary>
        /// 得到protocol buffers 中下一个message名称
        /// </summary>
        /// <param name="MessageName"></param>
        /// <returns></returns>
        private bool GetNextMessageName(out string MessageName)
        {
            MessageName = "";
            int pos1 = GetNextMessageTag();

            if (pos1 == -1)
                return false;

            if (MoveToNextIndentOutdentTag() != '{')
                return false;

            int pos2 = nCurrentPos - 1;
            int count = 1;
            MessageName = szProtocolBufferContent.Substring(pos1, pos2 - pos1).Replace('\n', ' ').Replace('\r', ' ').Trim();

            while (count > 0)
            {
                char tag = MoveToNextIndentOutdentTag();
                switch (tag)
                {
                    case '{':
                        count++;
                        break;
                    case '}':
                        count--;
                        break;
                    default:
                        return false;
                }
            }

            return true;
        }

        /// <summary>
        /// 得到protocolbuffers 中下一个message关键字
        /// </summary>
        /// <returns>message关键字后的位置</returns>
        int GetNextMessageTag()
        {
            int pos = szProtocolBufferContent.IndexOf("message", nCurrentPos);
            if (pos != -1)
            {
                nCurrentPos = pos;
                return pos + 7;
            }
            return -1;
        }

        /// <summary>
        /// 移到下一个 {
        /// </summary>
        /// <returns></returns>
        char MoveToNextIndentOutdentTag()
        {
            int pos1 = szProtocolBufferContent.IndexOf('{', nCurrentPos);
            int pos2 = szProtocolBufferContent.IndexOf('}', nCurrentPos);
            int pos;
            if (pos1 == -1)
                pos1 = pos2;
            if (pos2 == -1)
                pos2 = pos1;
            if (pos1 < pos2)
                pos = pos1;
            else
                pos = pos2;
            if (pos == -1)
                return ' ';

            nCurrentPos = pos + 1;
            return szProtocolBufferContent[pos];
        }

        void AnalyzeImport()
        {
            int pos = 0, pos1;
            pos1 = szProtocolBufferContent.IndexOf("import", pos);
            while (pos1 != -1)
            {
                pos = pos1 + 6;
                pos1 = szProtocolBufferContent.IndexOf("\"", pos);
                if (pos1 == -1)
                    return;
                pos = pos1 + 1;
                pos1 = szProtocolBufferContent.IndexOf("\"", pos);
                if (pos1 == -1)
                    return;
                string protoFileName = szProtocolBufferContent.Substring(pos, pos1 - pos);
                if (protoFileName.Substring(protoFileName.Length - 6) != ".proto")
                {
                    Console.WriteLine("{0} is not legal proto file", protoFileName);
                    return;
                }
                else
                {
                    Program.ProtoFiles.Add(protoFileName);
                    using (StreamReader reader = new StreamReader(protoFileName))
                    {
                        string str = reader.ReadToEnd();
                        ProtoAnalyzers.Add(new ProtoAnalyzer(str));
                    }

                }
                pos = pos1 + 1;
                pos1 = szProtocolBufferContent.IndexOf("import", pos);
            }
        }


    }
}
