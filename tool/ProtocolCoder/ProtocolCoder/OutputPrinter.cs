using System;
using System.Collections.Generic;
using System.Text;
using System.Collections;
using System.IO;

namespace ProtocolCoder
{
    class OutputPrinter
    {
        private string indent_;
        private bool at_start_of_line_;
        private StreamWriter output_;
        private char variable_delimiter_;

        /// <summary>
        ///  Create a printer that writes text to the given output stream.  Use the
        ///  given character as the delimiter for variables.
        /// </summary>
        /// <param name="OutputStream"></param>
        /// <param name="variable_delimiter"></param>
        public OutputPrinter(StreamWriter OutputStream, char variable_delimiter)
        {
            output_ = OutputStream;
            variable_delimiter_ = variable_delimiter;
            indent_ = "";
        }

        /// <summary>
        /// 输出字符串
        /// </summary>
        /// <param name="text"></param>
        public void Print(string text)
        {
            Print(null, text);
        }

        /// <summary>
        /// 输出字符串，delimiter之间的变量将被自动替换
        /// </summary>
        /// <param name="variables"></param>
        /// <param name="text"></param>
        public void Print(Hashtable variables, string text)
        {
            int size = text.Length;
            int pos = 0;  // The number of bytes we've written so far.

            for (int i = 0; i < size; i++) {
                if (text[i] == '\n')
                {
                    // Saw newline.  If there is more text, we may need to insert an indent
                    // here.  So, write what we have so far, including the '\n'.
                    Write(text.Substring(pos, i - pos + 1));
                    pos = i + 1;

                    // Setting this true will cause the next Write() to insert an indent
                    // first.
                    at_start_of_line_ = true;

                }
                else if (text[i] == variable_delimiter_ && variables != null)
                {
                    // Saw the start of a variable name.

                    // Write what we have so far.
                    Write(text.Substring(pos, i - pos));
                    pos = i + 1;

                    // Find closing delimiter.
                    int end = text.IndexOf(variable_delimiter_, pos);
                    if (end == -1)
                    {
                        Console.WriteLine(" Unclosed variable name.");
                        end = pos;
                    }

                    string varname = text.Substring(pos, end - pos);
                    if (varname.Length == 0)
                    {
                        // Two delimiters in a row reduce to a literal delimiter character.
                        Write(Convert.ToString(variable_delimiter_));
                    }
                    else
                    {
                        // Replace with the variable's value.
                        if (variables.ContainsKey(varname))
                            Write(Convert.ToString(variables[varname]));
                        else
                            Console.WriteLine(String.Format(" Undefined variable: {0}", varname));
                    }
                    // Advance past this variable.
                    i = end;
                    pos = end + 1;
                }
            }
            // Write the rest.
            Write(text.Substring(pos, size - pos));
        }  

        /// <summary>
        /// Indent
        /// </summary>
        public void Indent()
        {
            indent_ += "    ";
        }

        /// <summary>
        /// Outdent
        /// </summary>
        public void Outdent()
        {
            if (indent_.Length < 4)
            {
                Console.WriteLine(" Outdent() without matching Indent().");
                return;
            }
            indent_ = indent_.Substring(0, indent_.Length - 4);
        }

        /// <summary>
        /// 向输出流写入字符串
        /// </summary>
        /// <param name="text"></param>
        private void Write(string text)
        {
            if (text.Length == 0) return;

            if (at_start_of_line_)
            {
                // Insert an indent.
                at_start_of_line_ = false;
                Write(indent_);
            }

            output_.Write(text);
        }
    }
}
