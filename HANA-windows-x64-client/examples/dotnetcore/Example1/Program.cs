using System;
using Sap.Data.Hana;

namespace Example1
{
    class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Enter the server address (e.g., myserver:30015):");
            var server = Console.ReadLine();
            Console.WriteLine("Enter the username:");
            var user = Console.ReadLine();
            Console.WriteLine("Enter the password:");
            var password = Console.ReadLine();

            try
            {
                using (var conn = new HanaConnection(string.Format("Server={0};UID={1};PWD={2}", server, user, password)))
                {
                    conn.Open();
                    Console.WriteLine("Connected to " + server);

                    Console.WriteLine("Enter the query:");
                    var query = Console.ReadLine().Trim();

                    if (query.Length > 0)
                    {
                        using (var cmd = new HanaCommand(query, conn))
                        using (var reader = cmd.ExecuteReader())
                        {
                            Console.WriteLine("Query result:");

                            // Print column names
                            var sbCol = new System.Text.StringBuilder();
                            for (var i = 0; i < reader.FieldCount; i++)
                            {
                                if (i > 0)
                                {
                                    sbCol.Append(", ");
                                }
                                sbCol.Append(reader.GetName(i));
                            }
                            Console.WriteLine(sbCol.ToString());

                            // Print rows
                            while (reader.Read())
                            {
                                var sbRow = new System.Text.StringBuilder();
                                for (var i = 0; i < reader.FieldCount; i++)
                                {
                                    if (i > 0)
                                    {
                                        sbRow.Append(", ");
                                    }
                                    sbRow.Append(reader[i]);
                                }
                                Console.WriteLine(sbRow.ToString());
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine("Error - " + ex.Message);
                Console.WriteLine(ex.ToString());
            }
        }
    }
}
