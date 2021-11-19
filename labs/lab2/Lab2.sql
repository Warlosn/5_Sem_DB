alter session set "_ORACLE_SCRIPT"=true;
-------------Task1-----------------
CREATE TABLESPACE TS_GIS
Datafile 'C:\labs\lab2\TS_GIS.dbf' 
size 7 m 
autoextend ON NEXT 5 m
maxsize 20 m;
-------------Task2-----------------
CREATE TEMPORARY TABLESPACE TS_GIS_TEMP 
tempfile 'C:\labs\lab2\TS_GIS_TEMP.dbf' 
size 5 m 
autoextend ON NEXT 3 m
maxsize 30 m
extent management local;
-------------Task3-----------------
  SELECT tablespace_name, STATUS, contents logging FROM sys.dba_tablespaces;

  SELECT file_name,
    tablespace_name,
    status,
    maxbytes,
    user_bytes
  FROM DBA_DATA_FILES
  UNION
  SELECT file_name,
    tablespace_name,
    status,
    maxbytes,
    user_bytes
  FROM DBA_TEMP_FILES;
-------------Task4-----------------
CREATE role C##RL_GISCORE;
  SELECT * FROM dba_roles WHERE role like 'C##RL%';
  GRANT
CREATE session,
  CREATE TABLE,
  CREATE VIEW, CREATE PROCEDURE TO C##RL_GISCORE;
  -------------Task5-----------------
  select * from DBA_SYS_PRIVS where GRANTEE = 'C##RL_GISCORE';
 -------------Task6-----------------
create profile C##PF_GISCORE limit
  password_life_time 180
  sessions_per_user 3
  failed_login_attempts 7
  password_lock_time 1
  password_reuse_time 10
  password_grace_time default
  connect_time 180
  idle_time 30
  -------------Task7-----------------
  select * from DBA_PROFILES;
  select * from DBA_PROFILES where PROFILE = 'C##PF_GISCORE';
  select * from DBA_PROFILES where profile = 'DEFAULT';
-------------Task8-----------------
create user GISCORE1 IDENTIFIED BY 12345
default TABLESPACE TS_GIS quota unlimited on TS_GIS
temporary TABLESPACE TS_GIS_TEMP 
PROFILE C##PF_GISCORE
ACCOUNT UNLOCK
PASSWORD EXPIRE;

GRANT C##RL_GISCORE TO GISCORE1;
-------------Task10-----------------
create table students
(student_id number(10) not null,
student_name varchar(20) not null,
student_group number(10)
);
create view task10 as 
select students.student_id,students.student_name, students.student_group
from students;
-------------Task11-----------------
create tablespace GIS_QDATA
datafile 'C:\labs\lab2\GIS_QDATA.dbf'
size 10 m
autoextend on next 5 m
maxsize 20m
offline;
alter tablespace GIS_QDATA online;

alter user GISCORE1 quota 2m on GIS_QDATA;


create table T1
(teacher_id number(10) not null primary key,
teacher_name varchar(20) not null,
teacher_age number(10) not null);

insert into T1(teacher_id,teacher_name,teacher_age)
    values (1,'Ivan',19);
insert into T1(teacher_id,teacher_name,teacher_age)
    values (2,'Dima',20);
insert into T1(teacher_id,teacher_name,teacher_age)
	values (3,'Kirill',18);

select * from T1;


