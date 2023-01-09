package dbconsole;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class hana {
    public static void main(String[] args) {
        // Replace <host>, <port>, <database_name>, <user>, and <password> with the appropriate values
        String jdbcUrl = "jdbc:sap://<host>:<port>/<database>";
        String user = "<user>";
        String password = "<password>";
        
        try {
            // Load the SAP HANA JDBC driver
            Class.forName("com.sap.db.jdbc.Driver");

            // Create a connection to the database
            Connection conn = DriverManager.getConnection(jdbcUrl, user, password);

            // Do something with the connection here...
            Statement stmt = conn.createStatement();

            // Execute the SELECT query
            ResultSet rs = stmt.executeQuery("SELECT * FROM USERS");

            // Process the results
            while (rs.next()) {
                // Get the values from the current row
                int column1 = rs.getInt(1);
                String column2 = rs.getString(2);
                String column3 = rs.getString(3);
                String column4 = rs.getString(4);
                String column5 = rs.getString(5);
                String column6 = rs.getString(6);
                System.out.println(column1  + "\t"  +  column2 + "\t" + column3 +"\t" + column4 +"\t" + column5  +"\t" + column6  ) ; 
                // ...
            }

            // Close the result set, statement, and connection
            rs.close();
            stmt.close();
            // Close the connection
           
            conn.close();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
