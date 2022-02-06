ALTER SESSION SET nls_date_format='yyyy-mm-dd';
----------------------------------------------TASK2---------------------------------------------
 create table teacher_dbms_job (
  teacher      char(10),
  teacher_name nvarchar2(50),
  pulpit       char(10),
  birthday date,
  salary      number
);
create table job_status (
  status   nvarchar2(50),
  datetime timestamp default current_timestamp
);
----------------------------------------------------------------------
select * from teacher_dbms_job;
select * from TEACHER;
select * from job_status;
---------------------------------PROCEDURE-----------------------------
create or replace procedure copy_teachers is
  cursor teachercursor is select * from TEACHER where salary > 900;
  begin
    for n in teachercursor
      loop
        insert into teacher_dbms_job (teacher, teacher_name, pulpit, birthday, salary)
        values (n.teacher, n.teacher_name, n.pulpit, n.birthday, n.salary);
      end loop;
    --delete from TEACHER where salary > 900;
    insert into job_status (status) values ('SUCCESS');
    commit;
    exception when others then insert into job_status (status) values ('FAIL');
end;
--------------------------------------------CREATE JOB--------------------------------------------------
declare  job_number user_jobs.job%type;
begin
    dbms_job.submit(job_number, 'begin copy_teachers; end;',
            SYSDATE, 'SYSDATE + 7');
    commit;
    SYS.DBMS_OUTPUT.PUT_LINE(job_number);
end;
--------------------------------------CHECK------------------------------------------
select job, what,last_date, last_sec, next_sec, broken from user_jobs where job =21;
------------------------------------REMOVE/BROKEN_JOB---------------------------------------
begin
    dbms_job.REMOVE(41);
end;
commit;
begin
    dbms_job.BROKEN(41, TRUE, NULL);
end;
commit;
-------------------------------------------CHANGE-------------------------------------------
declare  job_number user_jobs.job%type;
begin
    dbms_job.CHANGE(41, null,null, 'SYSDATE + 2/24');
end;
----------------------------------------DBMS_SHEDULER----------------------------------
create table teacher_dbms_scheduler (
  teacher      char(10),
  teacher_name nvarchar2(50),
  pulpit       char(10),
  birthday date,
  salary      number
);

create or replace procedure copy_teacher_shedule is
  cursor teachercursor2 is select * from teacher where salary < 700;
  begin
    for n in teachercursor2
      loop
        insert into teacher_dbms_scheduler (teacher, teacher_name, pulpit, birthday, salary)
        values (n.teacher, n.teacher_name, n.pulpit, n.birthday, n.salary);
      end loop;
    --delete from teacher where salary < 700;
    insert into job_status (status) values ('SUCCESS');
    commit;
    exception when others then insert into job_status (status) values ('FAIL');
end;
select * from TEACHER;
select * from teacher_dbms_scheduler;
select * from job_status;
    begin
  copy_teacher_shedule();
end;
---------------------------------shedule-----------------------------
begin
  dbms_scheduler.create_schedule(
      schedule_name => 'Sch_1',
      start_date => sysdate,
      repeat_interval => 'FREQ=DAILY;',--every day
      comments => 'Sch_1 DAILY now'
  );
end;
select  * from user_jobs;
SELECT * FROM USER_SCHEDULER_SCHEDULES;
SELECT * FROM USER_SCHEDULER_PROGRAMS;
SELECT * FROM USER_SCHEDULER_JOBS;
SELECT * FROM USER_SCHEDULER_JOB_LOG;
-------------------------------------program--------------------------
begin
  dbms_scheduler.create_program(
      program_name => 'Pr_1',
      program_type => 'STORED_PROCEDURE',
      program_action => 'up_teachers_job',
      number_of_arguments => 0,
      enabled => false,
      comments => 'up_teachers_job'
  );
end;
-------------------------------------job--------------------------------
begin
  dbms_scheduler.create_job(
      job_name => 'jsh_1',
      program_name =>'Pr_1',
      schedule_name => 'Sch_1',
      enabled => true);
end;
select * from teacher_dbms_scheduler;
select * from job_status;
