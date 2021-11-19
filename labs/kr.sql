----task1
select name from v$database;
----task3
select *from user_segments;
----task5
select *from dba_pdbs;
----task10
select * from v$sessions;
----task6
select * from v$log;
----task7
select * from v$pwfile_users;
----task9
select component, granule_size from v$sga_dynamic_components where current_size>0