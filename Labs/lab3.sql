/* Christian Mesina (005319687)
   CSE 572
   Lab 3
   Created on 01/28/2020
*/

/* Question 1: Create a query to display the last name, department number and department name for all employees. */
SELECT
    E.LAST_NAME,
    E.DEPARTMENT_ID,
    D.DEPARTMENT_NAME
FROM
    HR.EMPLOYEES E INNER JOIN
    HR.DEPARTMENTS D
        ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
ORDER BY DEPARTMENT_ID DESC;

/* Question 2: Create a unique listing of all jobs that in department 80. 
               Include the location of the department in the output.
*/
SELECT DISTINCT
    E.JOB_ID, 
    J.JOB_TITLE,
    D.LOCATION_ID,
    L.STREET_ADDRESS,
    L.POSTAL_CODE,
    L.CITY,
    L.STATE_PROVINCE,
    L.COUNTRY_ID
FROM
    HR.EMPLOYEES E JOIN HR.JOBS J
        ON E.JOB_ID = J.JOB_ID
    JOIN HR.DEPARTMENTS D
        ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
    JOIN HR.LOCATIONS L
        ON D.LOCATION_ID = L.LOCATION_ID
    WHERE E.DEPARTMENT_ID = 80;
    
/* Question 3: Create a query to display the employee’s last name, department name, location ID 
               and city of all employees who earn a commission.
*/
SELECT 
    E.LAST_NAME,
    D.DEPARTMENT_NAME,
    D.LOCATION_ID,
    L.CITY
FROM
    HR.EMPLOYEES E INNER JOIN HR.DEPARTMENTS D 
        ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
    INNER JOIN HR.LOCATIONS L 
        ON D.LOCATION_ID = L.LOCATION_ID 
    WHERE COMMISSION_PCT IS NOT NULL;
      
/* Question 4: For each employee who has an ‘a’ (lowercase) in his/her last name, 
               display the employee’s last name and department name.
*/
SELECT 
    E.LAST_NAME,
    D.DEPARTMENT_NAME
FROM
    HR.EMPLOYEES E INNER JOIN
    HR.DEPARTMENTS D
        ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
    WHERE LAST_NAME LIKE '%a%';
    
/* Question 5: Write a query that displays the last name, job, department number and department name 
               for all employees who work in Toronto.
*/
SELECT 
    E.LAST_NAME,
    J.JOB_TITLE,
    E.DEPARTMENT_ID,
    D.DEPARTMENT_NAME
FROM
    HR.EMPLOYEES E INNER JOIN HR.DEPARTMENTS D
        ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
    INNER JOIN HR.LOCATIONS L 
        ON D.LOCATION_ID = L.LOCATION_ID
    INNER JOIN HR.JOBS J
        ON E.JOB_ID = J.JOB_ID
    WHERE L.CITY = 'Toronto';
    
/* Question 6: Create a query to display the employee’s last name and employee number along with his/her manager’s 
               last name and manager number. Label the columns Employee, Emp#, Manager and Mgr#, respectively.
*/
SELECT
    E.LAST_NAME AS "Employee",
    E.EMPLOYEE_ID AS "Emp#",
    E.MANAGER_ID AS "Mgr#",
    M.LAST_NAME AS "Manager"
FROM 
    HR.EMPLOYEES E JOIN HR.EMPLOYEES M
        ON E.MANAGER_ID = M.EMPLOYEE_ID;

/* Question 7: Modify Question 6 to display all employees including King, who has no manager. 
               Order the results by the employee number.
*/
SELECT
    E.LAST_NAME AS "Employee",
    E.EMPLOYEE_ID AS "Emp#",
    E.MANAGER_ID AS "Mgr#",
    M.LAST_NAME AS "Manager"
FROM 
    HR.EMPLOYEES E LEFT OUTER JOIN HR.EMPLOYEES M
        ON E.MANAGER_ID = M.EMPLOYEE_ID
    ORDER BY E.EMPLOYEE_ID;

/* Question 9: Create a query to display the name and hire date of any employee hired after Davies. */
SELECT
    E.FIRST_NAME,
    E.LAST_NAME,
    E.HIRE_DATE
FROM
    HR.EMPLOYEES E JOIN HR.EMPLOYEES DAVIES
        ON DAVIES.LAST_NAME = 'Davies'
    WHERE DAVIES.HIRE_DATE < E.HIRE_DATE;

/* Question 10: Display the names and hire dates for all employees who were hired before their managers,
                along with their manager’s names and hire dates. Label the columns Employee, Emp Hired, Manager,
                and Mgr Hired, respectively.
*/
SELECT
    E.FIRST_NAME || ' ' || E.LAST_NAME AS "Employee",
    E.HIRE_DATE AS "Emp Hired",
    M.FIRST_NAME || ' ' || M.LAST_NAME AS "Manager",
    M.HIRE_DATE AS "Mgr Hired"
FROM
    HR.EMPLOYEES E JOIN HR.EMPLOYEES M
        ON E.MANAGER_ID = M.EMPLOYEE_ID
    WHERE 
        E.HIRE_DATE < M.HIRE_DATE;

/* Question 11: Create a view called EMPLOYEES_VU based on the employee numbers, employee names, 
                and department numbers from the HR.EMPLOYEES table.
                Change the heading for the employee name to EMPLOYEE. After the view created, 
                please write queries to answer following questions:
                a. Display the contents of the EMPLOYEES_VU view 
                b. Select the view name and text from the USER_VIEWS data dictionary view. 
                c. Using your EMPLOYEES_VU view, enter a query to display all employee names and department numbers. 
*/

/* LAB03_11
   Mesina, Christian
*/
CREATE OR REPLACE VIEW EMPLOYEES_VU AS
    SELECT 
        FIRST_NAME || ' ' || LAST_NAME AS "EMPLOYEE",
        EMPLOYEE_ID,
        DEPARTMENT_ID
    FROM
        HR.EMPLOYEES;
 
-- a.        
SELECT * FROM EMPLOYEES_VU;
-- b.
SELECT VIEW_NAME, TEXT FROM USER_VIEWS;
-- c.
SELECT EMPLOYEE, DEPARTMENT_ID FROM EMPLOYEES_VU;

/* Question 12: Create a view named DEPT50 that contains the employee numbers, employee last names,
                and department numbers for all employees in department 50. 
                Label the view columns EMPNO, EMPLOYEE and DEPTNO. Do not allow an employee to be re-assigned
                to another department through the view. 
                After the view created, please write queries to answer following questions:
                a. Display the structure and contents of DEPT50 view. 
                b. Select the view name and text from the USER_VIEWS data dictionary view. 
                c. Attempt to re-assign Matos to department 80 by doing an update command.
*/

/* LAB03_12
   Mesina, Christian
*/
CREATE OR REPLACE VIEW DEPT50 AS
    SELECT
        LAST_NAME AS "EMPLOYEE",
        EMPLOYEE_ID AS "EMPNO",
        DEPARTMENT_ID AS "DEPTNO"
    FROM
        HR.EMPLOYEES 
        WHERE DEPARTMENT_ID = 50
        WITH CHECK OPTION CONSTRAINT EMP_DEPT_50;
        
-- a. 
SELECT * FROM DEPT50;
-- b. 
SELECT VIEW_NAME, TEXT FROM USER_VIEWS;
-- c. Update doesn't work because there is a constraint placed on the create query

UPDATE DEPT50
SET DEPTNO = 80
WHERE EMPLOYEE = 'Matos';