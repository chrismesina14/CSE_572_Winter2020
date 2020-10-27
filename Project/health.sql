create table userid (
    user_id number(6) not null
        constraint userid_user_id_PK PRIMARY KEY,
    username varchar(25) not null,
    contact_id number(4) not null
);

create table contact_info (
    contact_id number(4) not null
        constraint contactinfo_contact_id_PK PRIMARY KEY,
    phone varchar(10) not null,
    email varchar(50) not null,
    address_id number(3)
);

create table user_info (
    username varchar(50) not null
        constraint userinfo_username_PK PRIMARY KEY,
    fname varchar(25) not null,
    lname varchar(35) not null,
    dob DATE not null,
    height varchar(3) not null,
    weight number(3) not null,
    blood_type varchar(3) not null,
    user_id number(6) not null
);

create table address (
    address_id number(3) not null
        constraint address_address_id_PK PRIMARY KEY,
    street_number varchar(30) not null,
    zip number(5) not null
);

create table locations (
    zip number(5) not null
        constraint location_zip_PK PRIMARY KEY,
    city varchar(20) not null,
    state_province varchar(2) not null
);

create table social_media (
    user_id number(6) not null
        constraint socialmedia_user_id_PK PRIMARY KEY,
    friend number(4),
    access_level number(1) not null
);

create table patient_access (
    access_level number(1) not null
        constraint access_access_level_PK PRIMARY KEY,
    readings number(1) not null,
    med_schedule number(1) not null,
    appointments number(1) not null
);

create table readings (
    reading_type varchar(30) not null
        constraint readings_reading_types_PK PRIMARY KEY,
    measurements varchar(20) not null
);

create table take_readings (
    reading_id number(4) not null
        constraint take_readings_reading_id_PK PRIMARY KEY,
    reading_date date not null,
    reading_time timestamp not null,
    reading_type varchar(30) not null
);

create table doctor (
    dr_id number(4) not null
        constraint doctor_dr_id_PK PRIMARY KEY,
    specialty varchar(25) not null,
    phone varchar(10) not null,
    email varchar(50) not null,
    medical_group varchar(25) not null,
    address_id number(4) not null

);

create table appointment (
    appt_id number(4) not null
        constraint appointment_appt_id_PK PRIMARY KEY,
    appt_time timestamp not null,
    appt_date date not null,
    address_id varchar(4),
    dr_id number(3) not null
);

alter table appointment modify address_id number(4) not null;
desc appointment;
create table medication (
    med_name varchar(30) not null
        constraint medication_med_name_PK PRIMARY KEY,
    med_type varchar(30) not null
);

create table med_function (
    med_type varchar(30) not null
        constraint med_function_med_type_PK PRIMARY KEY,
    med_function varchar(30) not null
);

create table med_schedule (
    username varchar(25) not null 
        constraint med_schedule_username_PK PRIMARY KEY,
    med_name varchar(30) not null,
    amount_per_dose number(4) not null,
    times_per_day number(3) not null
);

create table prescribe (
    dr_id number(4) not null
        constraint prescribe_dr_id_PK PRIMARY KEY,
    med_name varchar(30) not null 
);

alter table userid
    add constraint userid_username_FK FOREIGN KEY(username) references user_info(username);
alter table userid
    add constraint userid_contact_id_FK FOREIGN KEY (contact_id) references contact_info(contact_id);
alter table contact_info
    add constraint contact_info_address_id_FK FOREIGN KEY (address_id) references address(address_id);
alter table user_info
    add constraint user_info_user_id_PK FOREIGN KEY (user_id) references social_media(user_id);
alter table address
    add constraint address_zip_FK FOREIGN KEY (zip) references locations(zip);
alter table social_media
    add constraint social_media_user_id_FK FOREIGN KEY (user_id) references userid(user_id);
alter table social_media
    add constraint social_media_friend_FK FOREIGN KEY (friend) references userid(user_id);
alter table take_readings
    add constraint take_readings_reading_type_FK FOREIGN KEY (reading_type) references readings(reading_type);
alter table doctor
    add constraint doctor_address_id_FK FOREIGN KEY (address_id) references address(address_id);
alter table appointment
    add constraint appointment_address_id_FK FOREIGN KEY (address_id) references address(address_id);
alter table appointment
    add constraint appointment_dr_id_FK FOREIGN KEY (dr_id) references doctor(dr_id);
alter table med_schedule
    add constraint med_schedule_username_FK FOREIGN KEY (username) references user_info(username);
alter table med_schedule
    add constraint med_schedule_med_name_FK FOREIGN KEY (med_name) references medication(med_name);

/*USER ID TABLE*/
INSERT INTO userid(user_id,username,contact_id) VALUES (1,'SK',1);
INSERT INTO userid(user_id,username,contact_id) VALUES (2,'DL',2);
INSERT INTO userid(user_id,username,contact_id) VALUES (3,'PF',3);
INSERT INTO userid(user_id,username,contact_id) VALUES (4,'JT',4);
INSERT INTO userid(user_id,username,contact_id) VALUES (5,'EA',5);
INSERT INTO userid(user_id,username,contact_id) VALUES (6,'WG',6);
INSERT INTO userid(user_id,username,contact_id) VALUES (7,'JW',7);
INSERT INTO userid(user_id,username,contact_id) VALUES (8,'PV',8);


/*CONTACT INFO TABLE*/
INSERT INTO contact_info(contact_id,phone,email,address_id) VALUES (1,'909-000-001','steven@gmail.com',1);
INSERT INTO contact_info(contact_id,phone,email,address_id) VALUES (2,'909-000-002','diana@gmail.com',2);
INSERT INTO contact_info(contact_id,phone,email,address_id) VALUES (3,'909-000-003','pat@gmail.com',3);
INSERT INTO contact_info(contact_id,phone,email,address_id) VALUES (4,'909-000-004','jonathan@gmail.com',4);
INSERT INTO contact_info(contact_id,phone,email,address_id) VALUES (5,'909-000-005','ellen@gmail.com',5);
INSERT INTO contact_info(contact_id,phone,email,address_id) VALUES (6,'909-000-006','william@gmail.com',6);
INSERT INTO contact_info(contact_id,phone,email,address_id) VALUES (7,'909-000-007','jennifer@gmail.com',7);
INSERT INTO contact_info(contact_id,phone,email,address_id) VALUES (8,'909-000-008','peter@gmail.com',8);

/*USER INFORMATION TABLE*/
INSERT INTO user_info(username,fname,lname,dob,height,weight,blood_type,user_id) VALUES ('SK','Steven','King','01-JAN-1980','5''6''''',160,'A',1);
INSERT INTO user_info(username,fname,lname,dob,height,weight,blood_type,user_id) VALUES ('DL','Diana','Lorentz','02-JAN-1980','5''7''''',157,'B',2);
INSERT INTO user_info(username,fname,lname,dob,height,weight,blood_type,user_id) VALUES ('PF','Pat','Fay','03-JAN-1980','5''5''''',154,'AB',3);
INSERT INTO user_info(username,fname,lname,dob,height,weight,blood_type,user_id) VALUES ('JT','Jonathan','Taylor','04-JAN-1980','5''6''''',170,'O',4);
INSERT INTO user_info(username,fname,lname,dob,height,weight,blood_type,user_id) VALUES ('EA','Ellen','Abel','05-JAN-1980','5''7''''',165,'A',5);
INSERT INTO user_info(username,fname,lname,dob,height,weight,blood_type,user_id) VALUES ('WG','William','Gietz','06-JAN-1980','6''0''''',175,'B',6);
INSERT INTO user_info(username,fname,lname,dob,height,weight,blood_type,user_id) VALUES ('JW','Jennifer','Whalen','07-JAN-1980','5''9''''',171,'AB',7);
INSERT INTO user_info(username,fname,lname,dob,height,weight,blood_type,user_id) VALUES ('PV','Peter','Vargas','08-JAN-1980','5''8''''',169,'O',8);

/*ADDRESS TABLE*/
INSERT INTO address(address_id,street_number,zip) VALUES (1, '731 Fondren', 75001);
INSERT INTO address(address_id,street_number,zip) VALUES (2, '638 Voss', 75002);
INSERT INTO address(address_id,street_number,zip) VALUES (3, '3321 Castle', 75003);
INSERT INTO address(address_id,street_number,zip) VALUES (4, '561 Rice', 75004);
INSERT INTO address(address_id,street_number,zip) VALUES (5, '890 Stone', 75005);
INSERT INTO address(address_id,street_number,zip) VALUES (6, '450 Berry', 75006);
INSERT INTO address(address_id,street_number,zip) VALUES (7, '980 Fire Oak', 75007);
INSERT INTO address(address_id,street_number,zip) VALUES (8, '975 Dallas', 75008);
INSERT INTO address(address_id,street_number,zip) VALUES (9, '9 Dallas', 75008);
INSERT INTO address(address_id,street_number,zip) VALUES (10, '7 Fondren', 75001);
INSERT INTO address(address_id,street_number,zip) VALUES (11, '3 Castle', 75003);
INSERT INTO address(address_id,street_number,zip) VALUES (12, '4 Berry', 75006);
INSERT INTO address(address_id,street_number,zip) VALUES (13, '5 Rice', 75004);
INSERT INTO address(address_id,street_number,zip) VALUES (14, '99 Dallas', 75008);
INSERT INTO address(address_id,street_number,zip) VALUES (15, '77 Fondren', 75001);
INSERT INTO address(address_id,street_number,zip) VALUES (16, '33 Castle', 75003);
INSERT INTO address(address_id,street_number,zip) VALUES (17, '44 Berry', 75006);
INSERT INTO address(address_id,street_number,zip) VALUES (18, '55 Rice', 75004);


/*LOCATIONS TABLE*/
INSERT INTO location(zip,city,state) VALUES (95001,'Houston','TX');
INSERT INTO location(zip,city,state) VALUES (95002,'Dallas','TX');
INSERT INTO location(zip,city,state) VALUES (95003,'Spring','TX');
INSERT INTO location(zip,city,state) VALUES (95004,'Fontana','CA');
INSERT INTO location(zip,city,state) VALUES (95005,'Los Angeles','CA');
INSERT INTO location(zip,city,state) VALUES (95006,'Bellaire','TX');
INSERT INTO location(zip,city,state) VALUES (95007,'Humble','TX');
INSERT INTO location(zip,city,state) VALUES (95008,'Seattle','WA');

/*SOCIAL MEDIA TABLE*/
INSERT INTO social_media(user_id,friend,access_level) VALUES (1,2,0);
INSERT INTO social_media(user_id,friend,access_level) VALUES (2,3,1);
INSERT INTO social_media(user_id,friend,access_level) VALUES (3,4,2);
INSERT INTO social_media(user_id,friend,access_level) VALUES (4,5,3);
INSERT INTO social_media(user_id,friend,access_level) VALUES (5,6,4);
INSERT INTO social_media(user_id,friend,access_level) VALUES (6,7,5);
INSERT INTO social_media(user_id,friend,access_level) VALUES (7,8,6);
INSERT INTO social_media(user_id,friend,access_level) VALUES (8,1,7);

/*PATIENT ACCESS TABLE*/
INSERT INTO patient_access(access_level,readings,med_schedule,appointments) VALUES (0,0,0,0);
INSERT INTO patient_access(access_level,readings,med_schedule,appointments) VALUES (1,0,0,1);
INSERT INTO patient_access(access_level,readings,med_schedule,appointments) VALUES (2,0,1,0);
INSERT INTO patient_access(access_level,readings,med_schedule,appointments) VALUES (3,0,1,1);
INSERT INTO patient_access(access_level,readings,med_schedule,appointments) VALUES (4,1,0,0);
INSERT INTO patient_access(access_level,readings,med_schedule,appointments) VALUES (5,1,0,1);
INSERT INTO patient_access(access_level,readings,med_schedule,appointments) VALUES (6,1,1,0);
INSERT INTO patient_access(access_level,readings,med_schedule,appointments) VALUES (7,1,1,1);

/*READINGS TABLE*/
INSERT INTO readings(reading_type,measurements) VALUES ('blood glucose','60 mg/dL');
INSERT INTO readings(reading_type,measurements) VALUES ('systolic blood pressure','110 mmHg');
INSERT INTO readings(reading_type,measurements) VALUES ('diastolic blood pressure','70 mmHg');
INSERT INTO readings(reading_type,measurements) VALUES ('heart rate','80 bpm');
INSERT INTO readings(reading_type,measurements) VALUES ('hemoglobin','15 gm/dL');

/*TAKE READINGS TABLE*/
INSERT INTO take_readings(reading_id,reading_date,reading_time,reading_type) VALUES (1,'01-MAR-2020','08:20:00','blood glucose');
INSERT INTO take_readings(reading_id,reading_date,reading_time,reading_type) VALUES (2,'02-MAR-2020','09:30:00','systolic blood pressure');
INSERT INTO take_readings(reading_id,reading_date,reading_time,reading_type) VALUES (3,'03-MAR-2020','10:40:30','diastolic blood pressure');
INSERT INTO take_readings(reading_id,reading_date,reading_time,reading_type) VALUES (4,'04-MAR-2020','12:10:50','heart rate');
INSERT INTO take_readings(reading_id,reading_date,reading_time,reading_type) VALUES (5,'05-MAR-2020','20:10:20','hemoglobin');
INSERT INTO doctor(dr_id,specialty,phone,email,medical_group,address_id) VALUES (1,'Allergist','909-100-001','dr1@gmail.com','Group1',9);
INSERT INTO doctor(dr_id,specialty,phone,email,medical_group,address_id) VALUES (2,'Dermatologist','909-100-002','dr2@gmail.com','Group2',10);
INSERT INTO doctor(dr_id,specialty,phone,email,medical_group,address_id) VALUES (3,'Ophthalmologist','909-100-003','dr3@gmail.com','Group1',11);
INSERT INTO doctor(dr_id,specialty,phone,email,medical_group,address_id) VALUES (4,'Cardiologist','909-100-004','dr4@gmail.com','Group3',12);
INSERT INTO doctor(dr_id,specialty,phone,email,medical_group,address_id) VALUES (5,'Gastroenterologist','909-100-005','dr5@gmail.com','Group2',13);

/*APPOINTMENTS TABLE*/
INSERT INTO appointment(appt_id,appt_time,appt_date,address_id,dr_id) VALUES (1,'10:20:00','10-MAR-2020',14,1);
INSERT INTO appointment(appt_id,appt_time,appt_date,address_id,dr_id) VALUES (2,'12:20:00','11-MAR-2020',15,2);
INSERT INTO appointment(appt_id,appt_time,appt_date,address_id,dr_id) VALUES (3,'14:20:00','12-MAR-2020',16,3);
INSERT INTO appointment(appt_id,appt_time,appt_date,address_id,dr_id) VALUES (4,'16:20:00','13-MAR-2020',17,4);
INSERT INTO appointment(appt_id,appt_time,appt_date,address_id,dr_id) VALUES (5,'18:20:00','14-MAR-2020',18,5);

/*MEDICATIONS TABLE*/
INSERT INTO medication(med_name,med_type) VALUES ('Tylenol','Pain Reliever');
INSERT INTO medication(med_name,med_type) VALUES ('Advil','Pain Reliever');
INSERT INTO medication(med_name,med_type) VALUES ('TopCare','Immune Support');
INSERT INTO medication(med_name,med_type) VALUES ('Emergen-C','Immune Support');
INSERT INTO med_function(med_type, med_function) VALUES ('Pain Reliever','Temporarily relieves minor ache and pains');
INSERT INTO med_function(med_type, med_function) VALUES ('Immune Support','Help support your immune system');

/*MEDICATION SCHEDULE TABLE*/
INSERT INTO med_schedule(username,med_name,amount_per_dose,times_per_day) VALUES ('SK','Tylenol',2,3);
INSERT INTO med_schedule(username,med_name,amount_per_dose,times_per_day) VALUES ('DL','Tylenol',3,3);
INSERT INTO med_schedule(username,med_name,amount_per_dose,times_per_day) VALUES ('PF','Advil',2,2);
INSERT INTO med_schedule(username,med_name,amount_per_dose,times_per_day) VALUES ('JT','Advil',2,3);
INSERT INTO med_schedule(username,med_name,amount_per_dose,times_per_day) VALUES ('EA','TopCare',1,2);
INSERT INTO med_schedule(username,med_name,amount_per_dose,times_per_day) VALUES ('WG','TopCare',1,2);
INSERT INTO med_schedule(username,med_name,amount_per_dose,times_per_day) VALUES ('JW','Emergen-C',1,3);
INSERT INTO med_schedule(username,med_name,amount_per_dose,times_per_day) VALUES ('PV','Emergen-C',1,1);


/*PRESCRIBE TABLE*/
INSERT INTO prescribe(dr_id,med_name) VALUES (1,'Tylenol');
INSERT INTO prescribe(dr_id,med_name) VALUES (2,'Advil');
INSERT INTO prescribe(dr_id,med_name) VALUES (3,'TopCare');
INSERT INTO prescribe(dr_id,med_name) VALUES (4,'Emergen-C');
INSERT INTO prescribe(dr_id,med_name) VALUES (5,'Advil');


/* CREATING VIEWS */
/* Create a view to show the detailed information of doctors. */
CREATE VIEW 
    Dr_info
AS  SELECT 
    d.dr_id,
    d.specialty,
    d.phone,
    d.email,
    d.medical_group,
    d.address_id,
    a.street_number,
    a.zip,
    l.city,
    l.state
FROM
    doctor d,
    address a,
    location l
WHERE
    d.address_id = a.address_id
    and a.zip = l.zip;




/* Create a view to show the detailed information of users. */
CREATE VIEW
    User_med_schedule
AS SELECT
    ms.username,
    ui.fname,
    ui.lname,
    c.phone,
    c.email,
    ui.dob,
    ui.height,
    ui.weight,
    ui.blood_type,
    ms.med_name,
    ms.amount_per_dose,
    ms.times_per_day   
FROM 
    med_schedule ms,
    userid u,
    user_info ui,
    contact_info c
WHERE
    u.username = ui.username
    and ms.username = u.username
    and u.contact_id = c.contact_id;


/* Show the amount of medication per day for users whose weight is greater or equal than 165 order by their name. */
SELECT
    fname,
    lname,
    weight,
    sum(amount_per_dose * times_per_day) AS Amount_per_day
FROM
    User_med_schedule
GROUP BY
    fname,
    lname,
    weight
HAVING
    weight >= 165
ORDER BY
    fname,
    lname;


/* Show the amount of group numbers in each group where the size is larger than 1 order by medical_group name. */
SELECT
    medical_group,
    count(medical_group) AS Number_of_group_member
FROM
    Dr_info
GROUP BY
    medical_group
HAVING
    count(medical_group) > 1
ORDER BY
    medical_group;

/* Show the information in table prescribe join with table doctor, table medication and table med_function. */
SELECT
    p.dr_id,
    d.specialty,
    d.phone,
    d.email,
    d.medical_group,
    p.med_name,
    m.med_type,
    mf.med_function   
FROM
    prescribe p
    left join
    doctor d
        on p.dr_id = d.dr_id
    left join
    medication m
        on p.med_name = m.med_name
    left join
    med_function mf
        on m.med_type = mf.med_type;

/* Show the access level of every user and their friends by join the table social_media, table userid and table patient_access. And the result means have access if 1 and no access if 0 */
SELECT
    sm.user_id,
    u.username,
    sm.friend AS friend_id,
    sm.access_level,
    a.readings,
    a.med_schedule,
    a.appointments
FROM
    social_media sm
    left join
    userid u
        on sm.user_id = u.user_id
    left join
    patient_access a
        on sm.access_level = a.access_level;


/* Count the number of appointments where the address zip of appointment is larger than 95003. */
SELECT 
    COUNT(*) AS Number_of_appointments
FROM
    appointment a,
    address ad,
    location l
WHERE
    a.address_id = ad.address_id
    and ad.zip = l.zip
    and ad.zip > 95003;


/* Find how many medications named ‘Tylenol’ are taken by all users per day. */
SELECT
    med_name,
    SUM(amount_per_dose * times_per_day) AS Total_med_type_taken
FROM
    med_schedule
WHERE
    med_name = 'Tylenol'
GROUP BY
    med_name;


/* Update the user info of JW, change blood_type to O and change date of birth to 07-FEB-1980.*/
UPDATE 
    user_info
SET
    blood_type = 'O',
    dob = '07-FEB-1980'
WHERE
    username = 'JW'
    and fname = 'Jennifer'
    and lname = 'Whalen';

/* Update the medication schedule of user ‘JT’ and change med_name to ‘Tylenol’ and times_per_day to 2. */
UPDATE 
    med_schedule
SET
    med_name = 'Tylenol',
    times_per_day = 2
WHERE
    username = 'JT';



/* Insert into table address and location new data. */
INSERT INTO address(address_id,street_number,zip) VALUES (19, '5500 University', 92407);
INSERT INTO location(zip, city, state) VALUES (92407, 'San Bernardino', 'CA');


/*DELETION OF ALL TABLES*/
DROP TABLE userid;
DROP TABLE contact_info;
DROP TABLE user_info;
DROP TABLE address;
DROP TABLE location;
DROP TABLE social_media;
DROP TABLE patient_access;
DROP TABLE readings;
DROP TABLE take_readings;
DROP TABLE doctor;
DROP TABLE appointment;
DROP TABLE medication;
DROP TABLE med_function;
DROP TABLE med_schedule;
DROP TABLE prescribe;


