--------------------lection 7----------------------------
alter session set "_ORACLE_SCRIPT"=true;
------------------2---------------------------
show parameter instance;

-----------------3--------------------------
select * from v$tablespace;
select * from sys.dba_data_files;
select * from dba_role_privs;
select * from all_users;
-----------------4--------------------------
regedit
-------
set timing on
GIS_TABLE;
----------------------------
select *from dba_segments where OWNER ='GISCORE1';

create view lab8 as
select count(*) as count,
        sum(extents) as sum_extents,
        sum(blocks) as sum_blocks,
        sum(bytes/1024) as Kb from user_segments;
        
select * from lab8;  
drop view lab8;