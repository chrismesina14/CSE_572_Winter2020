import java.sql.* ;
import java.util.Scanner;

public class Ex1 {
	
	 public static void main(String args[]) {
		 
		 try{  
 	    		//step1 load the driver class  
 			Class.forName("oracle.jdbc.driver.OracleDriver") ;
   
 			//step2 create  the connection object    
 			Connection con=DriverManager.getConnection("jdbc:oracle:thin:@orafarm:1521:orcl", "cmesina", "mc9687") ;
  
            Scanner input = new Scanner(System.in);

            System.out.print("Enter the empNo: ");
            String id = input.nextLine();

 			//step3 create the statement object
 			String query = "select empNo, fname, lname, address, sex, salary, pos, deptno, dob, hire_date from emp where empNo = " +id;
 			PreparedStatement pstmt_employees = con.prepareStatement(query);
            
 			//step4 execute query  
 			ResultSet rs_employees = pstmt_employees.executeQuery() ;
 			    					
 			while (rs_employees.next()){

 				System.out.println("Employee ID:" + rs_employees.getString(1));
 				System.out.println("Name: " + rs_employees.getString(2) + ", " + rs_employees.getString(3)) ;
 				System.out.println("Address: " + rs_employees.getString(4)) ;
 				System.out.println("Sex: " + rs_employees.getString(5)) ;
 				System.out.println("Salary: " + rs_employees.getString(6)) ;
 				System.out.println("Position: " + rs_employees.getString(7)) ;
 				System.out.println("Department #: " + rs_employees.getString(8)) ;
 				System.out.println("Date of Birth: " + rs_employees.getString(9)) ;
 				System.out.println("Hire Date: " + rs_employees.getString(10) + "\n") ;
 			
 			} 
		 } catch(Exception e){ System.out.println(e);}	
 
	 }

}
