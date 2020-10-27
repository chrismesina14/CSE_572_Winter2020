/* Christian Mesina (005319687)
   CSE 572
   Lab 7
   Created on 03/03/2020
*/

/* Question 1: Using a set operator, write a query to determine names that appear in both the city and 
               the state_province fields of the locations table. */
SELECT CITY
FROM HR.LOCATIONS
INTERSECT
SELECT STATE_PROVINCE
FROM HR.LOCATIONS;

/* Question 2: Write a query (using an inline view) that returns a count of how many distinct entries 
               appear in either the city and the state_province fields. */
SELECT COUNT(*)
FROM
(
    SELECT CITY
    FROM HR.LOCATIONS
    UNION
    SELECT STATE_PROVINCE
    FROM HR.LOCATIONS
);

/* Question 3: Write a query (using an inline view) that returns a count of how many total entries 
               appear in the city and the state_province fields combined. */
SELECT COUNT(*)
FROM
(
    SELECT CITY
    FROM HR.LOCATIONS
    UNION ALL
    SELECT STATE_PROVINCE
    FROM HR.LOCATIONS
);

/* Question 4: Find all employees work in department_id 10 just use minus operator. */
SELECT EMPLOYEE_ID
FROM HR.EMPLOYEES
WHERE DEPARTMENT_ID < 30
MINUS
SELECT EMPLOYEE_ID
FROM HR.EMPLOYEES
WHERE DEPARTMENT_ID = 20;

/* Question 5: Duplicate hr.employees as new table named empl_dup using create table <tablename> as <query>. */
CREATE TABLE EMPL_DUP AS
SELECT EMPLOYEE_ID,
       FIRST_NAME,
       LAST_NAME,
       EMAIL,
       PHONE_NUMBER,
       HIRE_DATE,
       JOB_ID,
       SALARY,
       COMMISSION_PCT,
       MANAGER_ID,
       DEPARTMENT_ID  
FROM 
       HR.EMPLOYEES;
       
SELECT * FROM EMPL_DUP;

/* Question 6: Recreate a view called EMPLOYEES_VU based on the employee numbers, employee names, 
               and department numbers from the empl_dup table. Change the heading for the employee name to EMPLOYEE. 
               Precede the CREATE VIEW command with the following comment lines. */
/* LAB07_6 

Mesina, Christian 

*/ 
CREATE OR REPLACE VIEW EMPLOYEES_VU AS
SELECT
    EMPLOYEE_ID,
    FIRST_NAME || ' ' || LAST_NAME AS "EMPLOYEE",
    DEPARTMENT_ID
FROM
    EMPL_DUP;

-- a.
SELECT * FROM EMPLOYEES_VU;
-- b.
SELECT VIEW_NAME, TEXT FROM USER_VIEWS;
-- c.
SELECT EMPLOYEE, DEPARTMENT_ID FROM EMPLOYEES_VU;

/* Question 7: Recreate a view named DEPT50 that contains the employee numbers, employee last names, 
               and department numbers for all employees in department 50. Label the view columns EMPNO, EMPLOYEE and DEPTNO. 
               Do not allowan employee to be re-assigned to another department through the view. */
/* LAB07_7 

Mesina, Christian 

*/ 
CREATE OR REPLACE VIEW DEPT50 AS
    SELECT
        LAST_NAME AS "EMPLOYEE",
        EMPLOYEE_ID AS "EMPNO",
        DEPARTMENT_ID AS "DEPTNO"
    FROM
        EMPL_DUP 
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