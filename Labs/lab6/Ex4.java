import java.sql.* ;
import java.util.Scanner;

public class Ex4 {
	
     public static void main(String args[]) {
        try {
            // step1 load the driver class
            Class.forName("oracle.jdbc.driver.OracleDriver");

            // step2 create the connection object
            Connection con = DriverManager.getConnection("jdbc:oracle:thin:@orafarm:1521:orcl", "cmesina", "mc9687");
            Question_4(con);

        } catch (Exception e) {
            System.out.println(e);
        }
    }
 
    public static void Question_4(Connection con) {
        System.out.print("Employee Number: ");
        String empno = System.console().readLine();
        String query = "Select (hourlyrate * 2) as \"Overtime Hourly Rate\" from Hourly_rate where empno = " + empno;
        String query2 = "Select ot.empno  as \"Employee number\", ot.hourot as \"Hours Overtime\", round(ot.hourot * ((e.salary/408) * 2)) as \"Total Overtime pay\" from emp_proj_overtime ot join emp e on e.empno = ot.empno where ot.empno = "
                + empno;
        ResultSet rs_employees = Query(con, query);
        ResultSet rs_overtime_pay = Query(con, query2);
        printResult(rs_employees);
        printResult(rs_overtime_pay);
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
