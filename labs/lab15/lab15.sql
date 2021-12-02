---------------------------------------------------TASK1---------------------------------------------------------------
create table student(
    id int primary key,
    name varchar2(50),
    lastname varchar2(50)
    );
---------------------------------------------------TASK2---------------------------------------------------------------
insert into student(id,name, lastname) values (1,'Ivan', 'Grishin');
insert into student(id,name, lastname) values (2,'Kirill', 'Kravchenko');
insert into student(id,name, lastname) values (3,'Nikita', 'Kravchenko');
insert into student(id,name, lastname) values (4,'Dima', 'Kaminskiy');
insert into student(id,name, lastname) values (5,'Karolina', 'Mergel');
insert into student(id,name, lastname) values (6,'Danila', 'Apolonik');
insert into student(id,name, lastname) values (7,'Dima', 'Karelin');
insert into student(id,name, lastname) values (8,'Anna', 'Gybar');
insert into student(id,name, lastname) values (9,'Maxim', 'Malinovskiy');
insert into student(id,name, lastname) values (10,'Sasha', 'Polevoda');
---------------------------------------------------TASK3---------------------------------------------------------------
create or replace trigger student_before_dml
    before insert or update or delete on student
begin
    SYS.DBMS_OUTPUT.PUT_LINE('before trigger event dml operator lvl');
end;
insert into student(id,name, lastname) values (13,'Liza', 'Zinovich');
delete student where name ='Liza';
---------------------------------------------------TASK5---------------------------------------------------------------
create or replace trigger student_before_rows
    before insert or update or delete
        on student for each row
begin
    SYS.DBMS_OUTPUT.PUT_LINE('before trigger event dml row lvl');
end;
---------------------------------------------------TASK6---------------------------------------------------------------
drop trigger student_before_dml;
drop trigger student_before_rows;
create or replace trigger student_before_predicate
    before insert or update or delete on student
begin
  if INSERTING then
    SYS.DBMS_OUTPUT.PUT_LINE('insert into student');
  elsif UPDATING then
    SYS.DBMS_OUTPUT.PUT_LINE('update in student');
  elsif DELETING then
    SYS.DBMS_OUTPUT.PUT_LINE('delete from student');
  end if;
end;
drop trigger student_before_predicate;
---------------------------------------------------TASK7---------------------------------------------------------------
create or replace trigger student_after_insert
    after insert on student
begin
    SYS.DBMS_OUTPUT.PUT_LINE('after insert  trigger operator lvl');
end;

create or replace trigger student_after_update
    after update on student
begin
    SYS.DBMS_OUTPUT.PUT_LINE('after update trigger operator lvl');
end;

create or replace trigger student_after_delete
    after delete on student
begin
    SYS.DBMS_OUTPUT.PUT_LINE('after delete trigger operator lvl');
end;
drop trigger student_after_insert;
drop trigger student_after_update;
drop trigger student_after_delete;
---------------------------------------------------TASK8---------------------------------------------------------------
create or replace trigger student_after_insert_eachRows
    after insert on student
    for each row
begin
    SYS.DBMS_OUTPUT.PUT_LINE('after insert  trigger row lvl');
end;

create or replace trigger student_after_update_eachRows
    after update on student
      for each row
begin
    SYS.DBMS_OUTPUT.PUT_LINE('after update trigger row lvl');
end;

create or replace trigger student_after_delete_eachRows
    after delete on student
      for each row
begin
    SYS.DBMS_OUTPUT.PUT_LINE('after delete trigger row lvl');
end;
drop trigger student_after_insert_eachRows;
drop trigger student_after_update_eachRows;
drop trigger student_after_delete_eachRows;
---------------------------------------------------TASK9----------------------------------------------------------------
CREATE TABLE AUDIT_9
(
    OperationDate date,
    OperationType varchar2(10 char),
    TriggerName varchar(50 char),
    DATA varchar2(200 char)
);

---------------------------------------------------TASK10---------------------------------------------------------------
create or replace trigger student_logger
    before insert or update or delete on student
        for each row
begin
    if inserting then
            insert into AUDIT_9 (OperationDate, OperationType, TriggerName, DATA)
                values (
                        sysdate,
                        'insert',
                        'student_logger',
                        'Old name: ' || :old.name || 'New name: ' || :new.name ||
                        'Old lastname: ' || :old.lastname || 'New lastname: ' || :new.lastname);
    elsif updating then
            insert into AUDIT_9 (OperationDate, OperationType, TriggerName, DATA)
                values (
                        sysdate,
                        'update',
                        'student_logger',
                        'Old name: ' || :old.name || 'New name: ' || :new.name ||
                        'Old lastname: ' || :old.lastname || 'New lastname: ' || :new.lastname);
    elsif deleting
        then
            insert into AUDIT_9 (OperationDate, OperationType, TriggerName, DATA)
                values (
                        sysdate,
                        'delete',
                        'student_logger',
                        'Old name: ' || :old.name || 'New name: ' || :new.name ||
                        'Old lastname: ' || :old.lastname || 'New lastname: ' || :new.lastname);
    end if;
end;
select * from user_triggers;
select * from AUDIT_9;
drop trigger student_logger;
insert into
---------------------------------------------------TASK11---------------------------------------------------------------
insert into student values (1, '', '');
select * from AUDIT_9;
---------------------------------------------------TASK12---------------------------------------------------------------
drop table student;
create or replace trigger ban_drop_student
  before drop on database
begin
    if(ORA_DICT_OBJ_NAME  = 'STUDENT') THEN
    SYS.DBMS_OUTPUT.PUT_LINE('delete function: banned');
    RAISE_APPLICATION_ERROR(-20000,'Cant delete this table');
    END IF;
END;
drop trigger ban_drop_student;
---------------------------------------------------TASK13---------------------------------------------------------------
drop table AUDIT_9;
---------------------------------------------------TASK14---------------------------------------------------------------
create view studentView as SELECT * FROM student;--only for views and each rows
drop view studentView;
select * from studentView;

create or replace trigger insteadof_insert_trigger
instead of insert on studentView
for each row
begin
 if inserting then dbms_output.put_line('insert');
  insert into student VALUES (12,'wow','wow');
 end if;
end insteadof_insert_trigger;

insert into student(ID,NAME,LASTNAME) values(14,'www','www');
commit;
select * from student;
select * from AUDIT_9;
