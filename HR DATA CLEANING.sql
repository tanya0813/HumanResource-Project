create database hr_project;
use hr_project;	
select * from hr_project.hr;
alter table hr rename column ï»¿id to emp_id;
describe hr;
select birthdate from hr;

#set sql updates to 0 so that update can be done w/o any error or safety warnings , later on set with 1 to protect data.
set sql_safe_updates=0;
UPDATE hr
SET birthdate = CASE
	WHEN birthdate LIKE '%/%' THEN date_format(str_to_date(birthdate, '%m/%d/%Y'), '%Y-%m-%d')
	WHEN birthdate LIKE '%-%' THEN date_format(str_to_date(birthdate, '%m-%d-%Y'), '%Y-%m-%d')
    ELSE NULL
END;
alter table hr modify column birthdate Date;

UPDATE hr
SET hire_date= CASE
	WHEN hire_date LIKE '%/%' THEN date_format(str_to_date(hire_date, '%m/%d/%Y'), '%Y-%m-%d')
	WHEN hire_date LIKE '%-%' THEN date_format(str_to_date(hire_date, '%m-%d-%Y'), '%Y-%m-%d')
    ELSE NULL
END;

alter table hr modify column hire_date Date;
select hire_date from hr;

select termdate from hr;
#first, to disable the strict mode
set sql_mode='';

UPDATE hr
SET termdate = IF(termdate IS NOT NULL AND termdate != '', 
DATE(str_to_date(termdate, '%Y-%m-%d %H:%i:%s UTC')),'0000-00-00') 
WHERE TRUE;
ALTER TABLE hr
MODIFY COLUMN termdate DATE;

alter table hr add column age int;
select * from hr;

#to get the age , we used a function called timestampdiff- this will calculate age from birthdate to currentdate
update hr
set age= timestampdiff(Year,birthdate,curdate());

select birthdate,age from hr;

select 
min(age) as youngest,
max(age) as oldest
from hr;

select count(*) from hr where age <18;
