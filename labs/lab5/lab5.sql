alter session set "_ORACLE_SCRIPT"=true;
-------------- TASK 1-------------
select file_name, tablespace_name, status from  dba_data_files
union
select file_name, tablespace_name, status from dba_temp_files;
-------------- TASK 2-------------
create tablespace GIS_QDATA
datafile 'C:\labs\lab5\GIS_QDATA.dbf'
size 10 m
autoextend on next 5 m
maxsize 20m
offline;

alter tablespace GIS_QDATA online;
alter user GISCORE1 quota 2m on GIS_QDATA;

create table Task2Lab5
(student_id int not null primary key,
student_name varchar(20) not null) tablespace GIS_QDATA;

insert into Task2Lab5(student_id,student_name)
    values (1,'Ivan');
insert into Task2Lab5(student_id,student_name)
    values (2,'Dima');
insert into Task2Lab5(student_id,student_name)
    values (3,'Kirill');
select * from Task2Lab5;
-------------- TASK 3-------------
select * from dba_segments where TABLESPACE_NAME = 'GIS_QDATA';
-------------- TASK 4-------------
drop table Task2Lab5;
select * from dba_segments where TABLESPACE_NAME = 'GIS_QDATA';
SELECT * FROM RECYCLEBIN;
PURGE RECYCLEBIN;
-------------- TASK 5-------------
flashback table Task2Lab5 to before drop;
-------------- TASK 6-------------
begin
for i in 1..1000
loop
insert into Task2Lab5(student_id,student_name)
    values (i,'Name');
    end loop;
    end;
-------------- TASK 7-------------
select  segment_name, segment_type,tablespace_name, bytes,
blocks, extents, buffer_pool from dba_segments where tablespace_name='GIS_QDATA';
select *from user_extents where tablespace_name ='GIS_QDATA';
select *from dba_extents where tablespace_name ='GIS_QDATA';
-------------- TASK 8-------------
drop tablespace GIS_QDATA including contents and datafiles;
-------------- TASK 9-------------
select * from v$log;
select * from v$log where STATUS= 'CURRENT';
-------------- TASK 10-------------
select *from v$logfile;
-------------- TASK 11-------------
alter system switch logfile; --11:37
select GROUP#, SEQUENCE#, BYTES, MEMBERS, STATUS, FIRST_CHANGE# from v$log;
-------------- TASK 12-------------
alter database add logfile group 4 'C:\labs\lab5\RED004.LOG' size 50m blocksize 512;

alter database add logfile member 'C:\labs\lab5\RED0041.LOG' to GROUP 4;
alter database add logfile member 'C:\labs\lab5\RED0042.LOG' to GROUP 4;
alter database add logfile member 'C:\labs\lab5\RED0043.LOG' to GROUP 4;

select * from v$log;
select * from v$logfile;
alter system switch logfile; 
select GROUP#, SEQUENCE#, BYTES, MEMBERS, STATUS, FIRST_CHANGE# from v$log;
-------------- TASK 13-------------
alter system checkpoint;
alter database drop logfile member 'C:\labs\lab5\RED004.LOG';
alter database drop logfile member 'C:\labs\lab5\RED0041.LOG';
alter database drop logfile member 'C:\labs\lab5\RED0042.LOG';
alter database drop logfile member 'C:\labs\lab5\RED0043.LOG';
alter database drop Logfile group 4;
select GROUP#, SEQUENCE#, BYTES, MEMBERS, STATUS, FIRST_CHANGE# from v$log;
-------------- TASK 14-------------
select * from V$DATABASE;
select instance_name, archiver, active_state from v$instance;
-------------- TASK 15-------------
select * from V$ARCHIVED_LOG;
-------------- TASK 16-------------
select name, log_mode from v$database;
select instance_name,  archiver, active_state from v$instance;
-------------- TASK 17-------------
select * from v$log;
alter system switch logfile;
select * from v$archived_log;
archive LOG LIST;
show parameter db_recovery;
-------------- TASK 18-------------
select name, log_mode from v$database;
select instance_name,  archiver, active_state from v$instance;
-------------- TASK 19-------------
SELECT status, name, is_recovery_dest_file FROM V$CONTROLFILE;
-------------- TASK 20-------------
-------------- TASK 19-------------
-------------- TASK 19-------------
-------------- TASK 19-------------
-------------- TASK 19-------------
-------------- TASK 19-------------
-------------- TASK 19-------------





    