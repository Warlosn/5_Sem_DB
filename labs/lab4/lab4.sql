alter session set "_ORACLE_SCRIPT"=true;
----------------task1------------------
select pdb_id, pdb_name, status  from SYS.DBA_PDBS;
----------------task2-------------------
select INSTANCE_NAME from v$instance;
----------------task3-------------------
select * from PRODUCT_COMPONENT_VERSION;
select * from SYS.DBA_REGISTRY;
----------------task4-------------------
--in database configuration assistant
----------------task5-------------------
select pdb_id, pdb_name, status  from SYS.DBA_PDBS where PDB_NAME = 'GIS_PDB';
----------------task6-------------------
create role U1_RL_GISCORE

grant   create session,
        create table, drop any table,           -- table
        create view, drop any view,             -- view
        create procedure, drop any procedure    -- procedure
to U1_RL_GISCORE;
select * from dba_roles ;                                   -- all roles
select * from dba_roles where role = 'U1_RL_GISCORE';
select * from dba_sys_privs where grantee = 'U1_RL_GISCORE';   -- privilege RL_GISCORE

-- ACTION Create table spaces
create tablespace TS_GIS_PDB
    datafile 'C:\app\ora_instal_user\oradata\orcl\GIS_PDB\TS_GIS_PDB.DBF'
    size 10M
    autoextend on next 5M
    maxsize 20M;

-- ACTION Create TABLE TEMPORARY
create temporary tablespace TS_GIS_TEMP_PDB
    tempfile 'C:\app\ora_instal_user\oradata\orcl\GIS_PDB\TS_GIS_TEMP.DBF'
    size 5M
    autoextend on next 5M
    maxsize 20M;

-- ACTION create profile
create profile U1_PF_GISCORE limit
    password_life_time unlimited
    sessions_per_user 3
    failed_login_attempts 30
    password_lock_time 1
    password_reuse_time 10
    connect_time 180
    idle_time 30;
    
    select * from DBA_PROFILES where profile ='U1_PF_GISCORE';

grant U1_RL_GISCORE to U1_GIS_PDB;


----------------task7-------------------
alter tablespace TS_GIS_PDB online;

alter user U1_GIS_PDB quota 2m on TS_GIS_PDB;
select *from dba_tablespaces;

create table GIS_table
(teacher_id number(10) not null primary key,
teacher_name varchar(20) not null,
teacher_age number(10) not null) tablespace TS_GIS_PDB;

insert into GIS_table(teacher_id,teacher_name,teacher_age)
    values (1,'Ivan',20);
insert into GIS_table(teacher_id,teacher_name,teacher_age)
    values (2,'Sergey',10);
insert into GIS_table(teacher_id,teacher_name,teacher_age)
	values (3,'Kirill',18);

select * from GIS_table;
----------------task8----------------dont view all from U1_GIS_PDB
select * from ALL_USERS; --dba_users;
select * from DBA_TABLESPACES;
select * from DBA_DATA_FILES; 
select * from DBA_TEMP_FILES; 
select * from DBA_ROLES; 
select GRANTEE, PRIVILEGE from DBA_SYS_PRIVS;
select * from DBA_PROFILES; 
----------------task9-------------------
show con_name;
create user c##GIS identified by Dfyef2001;
drop user c##GIS;
----------------task11-------------------
select * from v$session where USERNAME is not null;

