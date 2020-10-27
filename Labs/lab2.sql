-- Christian Mesina (005319687)
-- CSE 572
-- lab2.sql
-- Created on 01/21/2020

-- Question 1
SELECT * FROM HR.DEPARTMENTS;

-- Question 2
SELECT COUNT (*) FROM HR.EMPLOYEES;
SELECT COUNT (*) FROM HR.EMPLOYEES WHERE SALARY > '15000';
SELECT COUNT (*) FROM HR.EMPLOYEES WHERE HIRE_DATE BETWEEN '01-JAN-02' AND '01-JAN-05';
SELECT COUNT (*) FROM HR.EMPLOYEES WHERE PHONE_NUMBER NOT LIKE '515%';

-- Question 3
SELECT FIRST_NAME || ' ' || LAST_NAME AS Name FROM HR.EMPLOYEES WHERE DEPARTMENT_ID =
    (SELECT DEPARTMENT_ID FROM HR.DEPARTMENTS WHERE DEPARTMENT_NAME = 'Finance') ORDER BY LAST_NAME, FIRST_NAME;
    
-- Question 4    
SELECT L.CITY AS "City", L.STATE_PROVINCE AS "State", C.COUNTRY_NAME AS "Country" FROM HR.LOCATIONS L JOIN HR.COUNTRIES C 
    ON L.COUNTRY_ID = C.COUNTRY_ID WHERE REGION_ID = '3';

-- Question 5
SELECT * FROM HR.LOCATIONS WHERE STATE_PROVINCE IS NULL;

-- Question 6
SELECT MAX(SALARY) AS "Maximum", MIN(SALARY) AS "Minimum", SUM(SALARY) AS "Sum", AVG(SALARY) AS "Average" FROM HR.EMPLOYEES;

-- Question 7
-- The DUAL table in Oracle os a special table that belongs to the schema of the user SYS but is accessible to all users. 
-- The DUAL table has one column named DUMMY whose data type is VARCHAR2() and contains one row with a value x.
-- Because DUAL has only one row, the constant is returned only once. Because of the DUAL table, you can call many functions
-- like UPPER(), CONCAT(), SUBSTR() and many more. Besides calling built-in function, you can use expressions in the SELECT 
-- clause of a query that accesses the DUAL table like doing SELECT (10 + 5) / 2 FROM DUAL;
-- The DUAL table is most simple one because it was designed for fast access.