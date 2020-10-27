/* Christian Mesina (005319687)
   CSE 572
   Lab 4
   Created on 02/04/2020
*/

CREATE TABLE EMP(
    empNo number(4)
        CONSTRAINT EMP_empNo_PK PRIMARY KEY,
    fname varchar2(20),
    lname varchar2(20),
    address varchar(50),
    sex varchar2(1),
    salary number(6)
        CONSTRAINT EMP_salary_CK CHECK (salary > 12000),
    pos varchar2(50),
    deptNo number(2)
    );
    
INSERT INTO EMP(empNo,fname,lname,address,sex,salary,pos,deptNo) VALUES ('1000','Steven','King','731 Fondren Houston, TX','M','30000','Programmer',60);
INSERT INTO EMP(empNo,fname,lname,address,sex,salary,pos,deptNo) VALUES ('1007','Diana','Lorentz','638 Voss Bellaire, TX','F','24000','Clerk',20);
INSERT INTO EMP(empNo,fname,lname,address,sex,salary,pos,deptNo) VALUES ('2002','Pat','Fay','3321 Castle Spring, TX','F','15000','Sales  Representative',80);
INSERT INTO EMP(empNo,fname,lname,address,sex,salary,pos,deptNo) VALUES ('1760','Jonathan','Taylor','561 Rice Houston, TX','M','60000','Manager',20);
INSERT INTO EMP(empNo,fname,lname,address,sex,salary,pos,deptNo) VALUES ('1740','Ellen','Abel','890 Stone Houston, TX','F','65000','Manager',60);
INSERT INTO EMP(empNo,fname,lname,address,sex,salary,pos,deptNo) VALUES ('2060','William','Gietz','450 Berry Bellaire, TX','M','65000','Manager',80);
INSERT INTO EMP(empNo,fname,lname,address,sex,salary,pos,deptNo) VALUES ('2000','Jennifer','Whalen','980 Fire Oak Humble, TX','F','28000','Clerk',60);
INSERT INTO EMP(empNo,fname,lname,address,sex,salary,pos,deptNo) VALUES ('1444','Peter','Vargas','975 Dallas Houston, TX','M','20000','Sales  Representative',80);

CREATE TABLE DEPT(
    deptNo number(2)
        CONSTRAINT DEPT_deptNo_PK PRIMARY KEY,
    deptName varchar2(20),
    Mgr number(4)
    );
    
INSERT INTO DEPT(deptNo,deptName,Mgr) VALUES ('20','Marketing','1760');
INSERT INTO DEPT(deptNo,deptName,Mgr) VALUES ('60','IT','1740');
INSERT INTO DEPT(deptNo,deptName,Mgr) VALUES ('80','Sales','2060');

CREATE TABLE PROJ(
    projNumber number(2)
        CONSTRAINT PROJ_projNumber_UK UNIQUE,
    projName varchar2(20),
    deptNum number(2)
    );

INSERT INTO PROJ(projNumber,projName,deptNum) VALUES ('10','Product X','20');
INSERT INTO PROJ(projNumber,projName,deptNum) VALUES ('20','Product Y','20');
INSERT INTO PROJ(projNumber,projName,deptNum) VALUES ('30','Computerization','60');
INSERT INTO PROJ(projNumber,projName,deptNum) VALUES ('40','Product Z','80');
INSERT INTO PROJ(projNumber,projName,deptNum) VALUES ('50','Mobile Apps','60');

CREATE TABLE EMP_PROJ(
    empNo number(4),
    projNo number(4),
    hoursWorked number(4,1),
            CONSTRAINT EMP_PROJ PRIMARY KEY (empNo,projNo)
    );
    
INSERT INTO EMP_PROJ(empNo,projNo,hoursWorked) VALUES ('1000','30','32.5');
INSERT INTO EMP_PROJ(empNo,projNo,hoursWorked) VALUES ('1000','50','7.5');
INSERT INTO EMP_PROJ(empNo,projNo,hoursWorked) VALUES ('2002','10','40');
INSERT INTO EMP_PROJ(empNo,projNo,hoursWorked) VALUES ('1444','20','20');
INSERT INTO EMP_PROJ(empNo,projNo,hoursWorked) VALUES ('1760','10','5');
INSERT INTO EMP_PROJ(empNo,projNo,hoursWorked) VALUES ('1760','20','10');
INSERT INTO EMP_PROJ(empNo,projNo,hoursWorked) VALUES ('1740','50','15');
INSERT INTO EMP_PROJ(empNo,projNo,hoursWorked) VALUES ('2060','40','12');

ALTER TABLE EMP
ADD CONSTRAINT EMP_deptNo_FK FOREIGN KEY(deptNo)
    REFERENCES DEPT(deptNo);
    
ALTER TABLE DEPT
ADD CONSTRAINT DEPT_Mgr_FK FOREIGN KEY(Mgr)
    REFERENCES EMP(empNo);
    
ALTER TABLE PROJ
ADD CONSTRAINT PROJ_deptNum_FK FOREIGN KEY(deptNum)
    REFERENCES DEPT(deptNo);

ALTER TABLE EMP_PROJ
ADD CONSTRAINT EMP_PROJ_empNo_FK FOREIGN KEY(empNo)
REFERENCES EMP(empNo);

ALTER TABLE EMP_PROJ
ADD CONSTRAINT EMP_PROJ_projNo_FK FOREIGN KEY(projNo)
REFERENCES PROJ(projNumber);

ALTER TABLE EMP
    DROP CONSTRAINT EMP_deptNo_FK;
    
ALTER TABLE DEPT
    DROP CONSTRAINT DEPT_Mgr_FK;
    
INSERT INTO EMP_PROJ(&empNo, &projNo, &hoursWorked);
/* After running this insert query statement, it outputted an error statement saying that it was invalid values. This insert
statement did not run because the requirements needed did not follow the correct parameter and its order. */

SELECT * FROM EMP_PROJ;

ALTER TABLE EMP
    ADD EMAIL VARCHAR2(50);

INSERT INTO EMP VALUES (1172, 'joe', 'Calvert', '672 White Pine, Austin, TX', 'X', 10000, 10);
/* The insert statement above doesn't have the right values for the given constraints of the table. Therefore, I added 
the necessary corrections to make the insert statement work which can be seen below: */

INSERT INTO EMP VALUES(5000 ,'JOE','Calvert', '672 White Pine, Austin, TX','M', 20000,'No Position',
10);

SELECT * FROM EMP;
