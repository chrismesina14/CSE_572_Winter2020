import java.sql.* ;
import java.util.Scanner;

public class Ex2 {
	
     public static void main(String args[]) {
        try {
            // step1 load the driver class
            Class.forName("oracle.jdbc.driver.OracleDriver");

            // step2 create the connection object
            Connection con = DriverManager.getConnection("jdbc:oracle:thin:@orafarm:1521:orcl", "cmesina", "mc9687");
            Question_1(con);
            Question_2(con);

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

    public static void Question_2(Connection con) 
    {
        System.out.print("Update or Insert: ");
        String choice = System.console().readLine();
        if (choice.equalsIgnoreCase("Update")) {
            Update(con);
        } else if (choice.equalsIgnoreCase("Insert")) {
            Insert(con);
        } else {
            return;
        }
    }

    public static void Insert(Connection con) {
        System.out.print("Enter Employee Number: ");
        String empno = System.console().readLine();
        System.out.print("First Name: ");
        String fname = System.console().readLine();
        System.out.print("Last Name: ");
        String lname = System.console().readLine();
        System.out.print("Address: ");
        String address = System.console().readLine();
        System.out.print("M or F: ");
        String sex = System.console().readLine();
        System.out.print("Salary: ");
        String salary = System.console().readLine();
        System.out.print("Position: ");
        String position = System.console().readLine();
        System.out.print("Department Number: ");
        String deptno = System.console().readLine();
        System.out.print("Email: ");
        String email = System.console().readLine();
        System.out.print("DOB: ");
        String dob = System.console().readLine();
        System.out.print("Hire Date: ");
        String hire_date = System.console().readLine();
        String query = "INSERT INTO EMP (empNo,fname,lname,address,sex,salary,pos,deptNo,email,dob,hire_date) VALUES ("
                + empno + ",'" + fname + "','" + lname + "','" + address + "','" + sex + "'," + salary + ",'" + position
                + "'," + deptno + ",'" + email + "','" + dob + "','" + hire_date + "')";
        System.out.println(query);
        Query(con, query);
    }
    
    public static void Update(Connection con) {
        System.out.print("Enter Employee Number: ");
        String Empno = System.console().readLine();
        System.out.print("Update: ");
        String updateColumn = System.console().readLine();
        String updateinfo = System.console().readLine();
        String query = "UPDATE emp SET " + updateColumn + " = '" + updateinfo + "' WHERE empno = " + Empno;
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

