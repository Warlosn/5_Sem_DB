---------------------task1----------------------
alter session set nls_date_format = 'DD-MM-YYYY';
---------------------task2----------------------
select teacher_name from TEACHER;
---------------------task3----------------------
 select * from teacher
    where TO_CHAR((birthday), 'd') = 1;
---------------------task4----------------------
create view NextMonthBirth as
    select * from teacher
    where TO_CHAR(sysdate,'mm')+1 = TO_CHAR(birthday, 'mm');
    select * from NextMonthBirth;
---------------------task5----------------------
create view CountBirthday as
select extract(month from BIRTHDAY) as month,
       count(birthday) as n_teacher from teacher group by extract(month from birthday);
select * from CountBirthday;
---------------------task6----------------------

---------------------task7----------------------
---------------------task8----------------------
