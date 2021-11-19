--------------------TASK1---------------------videlen,razdelen
select *from v$bgprocess;
--------------------TASK2---------------------
select name, description from v$bgprocess where paddr!=hextoraw('00') order by name;
--------------------TASK3---------------------
select *from (select name, description from v$bgprocess where paddr!=hextoraw('00')) where name like 'DBW%' order by name;
--------------------TASK4---------------------
SELECT * FROM V$INSTANCE;
--------------------TASK6---------------------
select * from V$SERVICES ; 
--------------------TASK7---------------------
SELECT * FROM V$DISPATCHER;
show parameter DISPATCHERS;
alter system set max dispatchers=10;
--------------------TASK9---------------------
SELECT * FROM V$SESSION;

--C:\app\ora_instal_user\product\12.1.0\dbhome_1\NETWORK\ADMIN

--C:\app\ora_instal_user\product\12.1.0\dbhome_1\BIN\LSNECRL.EXE