alter session set "_ORACLE_SCRIPT"=true;
-------------LECTION5----------------
--------------TASK1------------------bibliot, slovarya dannix, ypravl str.
select * from v$sga;--fix oblast', razdel, big, java, buffer, buffer jyrnala povtora
select sum(value) from v$sga;
--------------TASK2------------------      
select * from v$sga_dynamic_components where current_size > 0;
--------------TASK3------------------      
select COMPONENT, GRANULE_SIZE from v$sga_dynamic_components where current_size > 0;
--------------TASK4------------------      
select *  v$sga_dynamic_free_memory;
--------------TASK5------------------      
select component, current_size, min_size from v$sga_dynamic_components where component ='KEEP buffer cache' or component = 'DEFAULT buffer cache' or component = 'RECYCLE buffer cache';
--------------TASK6------------------      
create table L6T6(x int) storage(buffer_pool keep) tablespace TS_GIS;
insert into L6T6 values(1);
commit;
select *from L6T6;
select segment_name, segment_type, tablespace_name, buffer_pool from user_segments where segment_name='L6T6';
--------------TASK7------------------      
create table L6T7(x int) storage(buffer_pool default) tablespace TS_GIS;
insert into L6T7 values(1);
select *from L6T7;
commit;
select segment_name, segment_type, tablespace_name, buffer_pool from user_segments where segment_name='L6T7';
--------------TASK8------------------
show parameter log_buffer;
--------------TASK9------------------      
select *from (select pool, name, bytes from v$sgastat where pool = 'shared pool' order by bytes desc) where rownum <=10;
--------------TASK10------------------  
select *from v$sgastat;
select *from v$sgastat where pool ='large pool';
select pool, name, bytes from v$sgastat where pool = 'large pool' and name = 'free memory';
--------------TASK11------------------  
select * from v$session;
--------------TASK13------------------  
select owner, executions, name from v$db_object_cache  order by executions;--something like this
select * from v$sgastat; --- voobshe ne to
select *from dba_objects; -- only last ddl_time
