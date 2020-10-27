import java.sql.* ;
import java.util.Scanner;

public class Ex3 {
	
     public static void main(String args[]) {
        try {
            // step1 load the driver class
            Class.forName("oracle.jdbc.driver.OracleDriver");

            // step2 create the connection object
            Connection con = DriverManager.getConnection("jdbc:oracle:thin:@orafarm:1521:orcl", "cmesina", "mc9687");
            Question_1(con);
            Question_3(con);

        } catch (Exception e) {
            System.out.println(e);
        }
    }

     public static void Question_1(Connection con) 
     {
        System.out.print("Enter Employee Number: ");
        String Empno = System.console().readLine();
        String query = "Select * from emp where empno = " + Empno;
        ResultSet rs_employees = Query(con, query);
        printResult(rs_employees);
    }

    public static void Question_3(Connection con) {
        System.out.print("EMP_PROJ:\nEnter Employee Number: ");
        String Empno = System.console().readLine();
        System.out.print("Project Number: ");
        String projno = System.console().readLine();
        System.out.print("Update: ");
        String updateColumn = System.console().readLine();
        System.out.print("Hours Change: ");
        String updateinfo = System.console().readLine();
        String query = "UPDATE emp_proj SET " + updateColumn + " = " + updateinfo + " WHERE empno = " + Empno
                + " and projno = " + projno;
        System.out.println(query);
        Query(con, query);
    }

    public static ResultSet Query(Connection con, String query_state) {
        try {
            PreparedStatement prestat = con.prepareStatement(query_state);
            return prestat.executeQuery();
        } catch (Exception e) {
            System.out.println(e);
            return null;
        }
    }

    public static void printResult(ResultSet rs) {
        try {
            ResultSetMetaData rsmd = rs.getMetaData();
            int columnsNumber = rsmd.getColumnCount();
            System.out.print("\n");
            while (rs.next()) {
                for (int i = 1; i <= columnsNumber; i++) {
                    String columnValue = rs.getString(i);
                    System.out.print(rsmd.getColumnName(i) + ": " + columnValue + "\n");
                }
                System.out.println("");
            }
        } catch (Exception e) {
            System.out.println(e);
        }
    }
}
