/* Christian Mesina (005319687)
   CSE 572
   Lab 5
   Created on 02/18//2020
*/

SELECT * FROM EMP;
SELECT * FROM DEPT;
SELECT * FROM EMP_PROJ;
SELECT * FROM EMP_PROJ_OVERTIME;
SELECT * FROM PROJ;

/* Question 1: List all project names and manager names in charge projects. */
SELECT 
    P.PROJNAME,
    M.FNAME || ' ' || M.LNAME AS "Manager Names"
FROM
   EMP M JOIN EMP_PROJ EP
        ON M.EMPNO = EP.EMPNO
    JOIN PROJ P
        ON P.PROJNUMBER = EP.PROJNO;
        
/* Question 2: Calculate total hours to all projects based on each employee. */
SELECT 
   E.FNAME || ' ' || E.LNAME AS "Employee",
   P.PROJNAME AS "Project",
   SUM(EP.HOURSWORKED) AS "Total Hours"
FROM
    EMP E JOIN PROJ P
        ON E.DEPTNO = P.DEPTNUM
    JOIN EMP_PROJ EP
        ON EP.EMPNO = E.EMPNO
    GROUP BY  E.FNAME || ' ' || E.LNAME, P.PROJNAME;
    
/* Question 3: Suppose there are 408 work hours per year, create a view to display employee hourly rate. */
CREATE OR REPLACE VIEW HOURLY_RATE AS
SELECT 
    E.FNAME || ' ' || E.LNAME AS "Employee",
    E.EMPNO,
    ROUND(E.SALARY/408, 2) AS HourlyRate
FROM 
    EMP E;
    
SELECT * FROM HOURLY_RATE;

/* Question 4: Find out the total labor cost per employee, per project. */
SELECT
    E.FNAME || ' ' || E.LNAME AS "Employee",
    P.PROJNAME AS "Project",
    (EP.HOURSWORKED * H.HOURLYRATE) AS "Total Labor Cost"
FROM
    EMP E JOIN HOURLY_RATE H
        ON E.EMPNO = H.EMPNO
    JOIN EMP_PROJ EP
        ON H.EMPNO = EP.EMPNO
    JOIN PROJ P
        ON P.PROJNUMBER = EP.PROJNO;

/* Question 5: Alter the table employees and add column to store date of birth and hire date. 
               Update the table with the provided data. */
ALTER TABLE EMP
    ADD(DOB date, Hire_date date);

UPDATE EMP SET DOB = '30-Apr-95', Hire_date = '1-May-10' WHERE empNo = 1000;
UPDATE EMP SET DOB = '31-Dec-86', Hire_date = '2-Jan-18' WHERE empNo = 1007;
UPDATE EMP SET DOB = '12-Jul-64', Hire_date = '15-Oct-14' WHERE empNo = 2002;
UPDATE EMP SET DOB = '28-Feb-76', Hire_date = '15-Jun-09' WHERE empNo = 1760;
UPDATE EMP SET DOB = '10-Sep-90', Hire_date = '2-Sep-11' WHERE empNo = 1740;
UPDATE EMP SET DOB = '25-Jun-80', Hire_date = '1-Apr-13' WHERE empNo = 2060;
UPDATE EMP SET DOB = '5-May-99', Hire_date = '1-Aug-19' WHERE empNo = 2000;
UPDATE EMP SET DOB = '24-Jan-93', Hire_date = '15-Jul-12' WHERE empNo = 1444;

/* Question 6: Create a new table named emp_proj_overtime */
CREATE TABLE EMP_PROJ_OVERTIME(
    empNo number(4), 
    projNo number(4), 
    hourOt number(4),
        CONSTRAINT EMP_PROJ_OVERTIME PRIMARY KEY (empNo,projNo)
    );
SELECT * FROM EMP_PROJ_OVERTIME;

/* Question 7: Assume each employee has a cap of 100 hours per project, develop a trigger 
               to track overtime hours when employee exceed the cap for the project. */
/*CREATE OR REPLACE TRIGGER OT_TRIGGER
AFTER INSERT OR UPDATE OF HOURSWORKED ON EMP_PROJ
REFERENCING OLD AS old NEW AS new
FOR EACH ROW WHEN (NEW.HOURSWORKED > 100)
BEGIN 
INSERT INTO EMP_PROJ_OVERTIME(empNo, projNo, hourOt) VALUES (:new.empNo, :new.projNo, :new.HOURSWORKED - 100);
    EXCEPTION  WHEN DUP_VAL_ON_INDEX THEN
        UPDATE EMP_PROJ_OVERTIME EPO SET EPO.hourOt = :new.HOURSWORKED - 100 WHERE EPO.empNo = :old.empNo AND EPO.projNo = :old.projNo;
    COMMIT;
END;*/

/* Question 8: If the overtime pay is twice of regular hourly rate, 
               modify the query from question 4 and add the factor of overtime. */
SELECT
    E.FNAME || ' ' || E.LNAME AS "Employee",
    EP.PROJNO,
    ROUND(SUM(EP.HOURSWORKED * (2 * HR.HOURLYRATE) + EPO.hourOt), 2) AS "Total Labor Cost"
FROM
    EMP E JOIN HOURLY_RATE HR
        ON E.EMPNO = HR.EMPNO
    JOIN EMP_PROJ EP
        ON HR.EMPNO = EP.EMPNO
    JOIN EMP_PROJ_OVERTIME EPO
        ON EPO.PROJNO = EP.PROJNO
GROUP BY
    E.FNAME || ' ' || E.LNAME, EP.PROJNO;
