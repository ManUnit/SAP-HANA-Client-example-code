using System;
using System.Data;
using Sap.Data.Hana;

namespace Example2
{
    class Program
    {
        static void Main(string[] args)
        {
            var table = "HANA_EXAMPLE_EMPLOYEES";
            var rows = new object[,]
            {
                { 102, "Fran", "Whitney" },
                { 105, "Matthew", "Cobb" },
                { 129, "Philip",  "Chin" },
                { 207, "Julie",   "Jordan" },
                { 243, "Robert",  "Breault" },
                { 247, "Melissa", "Espinoza" }
            };

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

                    // Drop existing table
                    var cmd = new HanaCommand("DROP TABLE " + table, conn);
                    try
                    {
                        cmd.ExecuteNonQuery();
                    }
                    catch (Exception)
                    {
                    }

                    // Create table
                    cmd.CommandText = string.Format("CREATE TABLE {0}(EMPLOYEEID integer primary key, GIVENNAME nvarchar(64), SURNAME nvarchar(64))", table);
                    cmd.ExecuteNonQuery();
                    Console.WriteLine(string.Format("Created table {0}", table));

                    // Insert rows
                    cmd.CommandText = string.Format("INSERT INTO {0} VALUES(?, ?, ?)", table);
                    for (var i = 0; i < rows.GetLength(0); i++)
                    {
                        var p0 = new HanaParameter("p0", HanaDbType.Integer);
                        p0.Value = rows[i, 0];
                        cmd.Parameters.Add(p0);
                        var p1 = new HanaParameter("p1", HanaDbType.NVarChar);
                        p1.Value = rows[i, 1];
                        cmd.Parameters.Add(p1);
                        var p2 = new HanaParameter("p2", HanaDbType.NVarChar);
                        p2.Value = rows[i, 2];
                        cmd.Parameters.Add(p2);
                    }
                    var rowsAffected = cmd.ExecuteNonQuery();
                    Console.WriteLine(string.Format("Inserted {0} rows:", rowsAffected));

                    // Print result
                    var result = new DataTable();
                    var adapter = new HanaDataAdapter("SELECT * FROM " + table, conn);
                    adapter.Fill(result);

                    // Print column names
                    var sbCol = new System.Text.StringBuilder();
                    for (var i = 0; i < result.Columns.Count; i++)
                    {
                        if (i > 0)
                        {
                            sbCol.Append(", ");
                        }
                        sbCol.Append(result.Columns[i].ColumnName);
                    }
                    Console.WriteLine(sbCol.ToString());

                    // Print rows
                    for (int i = 0; i < result.Rows.Count; i++)
                    {
                        var sbRow = new System.Text.StringBuilder();
                        for (var j = 0; j < result.Columns.Count; j++)
                        {
                            if (j > 0)
                            {
                                sbRow.Append(", ");
                            }
                            sbRow.Append(result.Rows[i][j]);
                        }
                        Console.WriteLine(sbRow.ToString());
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
