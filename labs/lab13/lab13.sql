------------------------------------------------------task1-------------------------------------------------------------
  CREATE OR REPLACE PROCEDURE GET_TEACHERS (PCODE TEACHER.PULPIT%TYPE) IS
  CURSOR my_curs IS SELECT TEACHER_NAME, TEACHER FROM TEACHER WHERE PULPIT = PCODE;
  t_name TEACHER.TEACHER_NAME%type;
  t_code TEACHER.TEACHER%type;
BEGIN
  OPEN my_curs;
  LOOP
    DBMS_OUTPUT.PUT_LINE(t_code||' '||t_name);
    FETCH my_curs INTO t_name, t_code;
    EXIT WHEN my_curs%notfound;
  END LOOP;
  CLOSE my_curs;
END;
    BEGIN
    GET_TEACHERS('ISIT');
END;
------------------------------------------------------task2-------------------------------------------------------------
CREATE OR REPLACE FUNCTION Get_count_of_Teachers(PCODE TEACHER.PULPIT%TYPE)
  RETURN NUMBER IS
    tCount NUMBER;
BEGIN
  SELECT COUNT(*) INTO tCount FROM TEACHER WHERE PULPIT = PCODE;
  RETURN tCount;
END;
BEGIN
  DBMS_OUTPUT.PUT_LINE(Get_count_of_Teachers('ISIT'));
END;
------------------------------------------------------task4-------------------------------------------------------------
create or replace procedure GET_TEACHERS(FCODE FACULTY.FACULTY % type)
is
    cursor c_teacher is select * from TEACHER
        inner join PULPIT on TEACHER.PULPIT = PULPIT.PULPIT
            inner join FACULTY on PULPIT.FACULTY = FACULTY.FACULTY
                where FACULTY.FACULTY = FCODE;
BEGIN
    for row_teacer in c_teacher
        loop
            DBMS_OUTPUT.PUT_LINE
                (
                    row_teacer.TEACHER ||' '||
                    row_teacer.TEACHER_NAME ||' '||
                    row_teacer.SALARY || ' ' ||
                    row_teacer.BIRTHDAY
                );
        end loop;
END;
BEGIN
    GET_TEACHERS('PAP');
END;
--------------------------------
create or replace procedure GET_SUBJECTS (PCODE SUBJECT.PULPIT % type)
is
    cursor c_subject is select * from SUBJECT
        where SUBJECT.PULPIT = PCODE;
BEGIN
    DBMS_OUTPUT.PUT_LINE('PULPIT : ' || PCODE);

    for row_subject in c_subject
        loop
            DBMS_OUTPUT.PUT_LINE
                (
                    'SUBJECT: ' || trim(row_subject.SUBJECT_NAME)
                );
        end loop;
END;
    begin
    GET_SUBJECTS('ISIT');
    end;
------------------------------------------------------task5-------------------------------------------------------------
create or replace function GET_NUM_TEACHERS (FCODE FACULTY.FACULTY % type)
            return number
                is
            COUNTER number := 0;
        begin
        select COUNT(*) into COUNTER from  TEACHER
            inner join PULPIT on TEACHER.PULPIT = PULPIT.PULPIT
                inner join FACULTY on PULPIT.FACULTY = FACULTY.FACULTY
                    where FACULTY.FACULTY = FCODE;
        return COUNTER;
        end;
    begin
        DBMS_OUTPUT.PUT_LINE(GET_NUM_TEACHERS('PAP'));
    end;
---------------
create or replace function GET_NUM_SUBJECTS (PCODE SUBJECT.PULPIT % type)
            return NUMBER is
            COUNTER number := 0;
    BEGIN
       select COUNT(*) into COUNTER from SUBJECT
            where SUBJECT.PULPIT = PCODE;
       return COUNTER;
    END;
    begin
        DBMS_OUTPUT.PUT_LINE(GET_NUM_SUBJECTS('ISIT'));
    end;
------------------------------------------------------task6-------------------------------------------------------------
create or replace package TEACHERS
    as
    procedure  GET_TEACHERS(FCODE FACULTY.FACULTY % type);
    procedure  GET_SUBJECTS(PCODE SUBJECT.PULPIT % type);
    function GET_NUM_TEACHERS (FCODE FACULTY.FACULTY % TYPE) return number;
    function GET_NUM_SUBJECTS(PCODE SUBJECT.PULPIT % type) return number;
end TEACHERS;
------------------------------------------------------task7-------------------------------------------------------------
create or replace package body TEACHERS
        is
    procedure GET_TEACHERS(FCODE FACULTY.FACULTY % type)
        is
        cursor c_teacher is select * from TEACHER
            inner join PULPIT on TEACHER.PULPIT = PULPIT.PULPIT
                inner join FACULTY on PULPIT.FACULTY = FACULTY.FACULTY
                    where FACULTY.FACULTY = FCODE;
    BEGIN
        for row_teacer in c_teacher
            loop
               DBMS_OUTPUT.PUT_LINE
                    (
                        row_teacer.TEACHER ||' '||
                        row_teacer.TEACHER_NAME ||' '||
                        row_teacer.SALARY || ' ' ||
                        row_teacer.BIRTHDAY
                    );
            end loop;
    END;

        procedure GET_SUBJECTS (PCODE SUBJECT.PULPIT % type)
            is
            cursor c_subject is select * from SUBJECT
                where SUBJECT.PULPIT = PCODE;
        BEGIN
            DBMS_OUTPUT.PUT_LINE('PULPIT : ' || PCODE);

        for row_subject in c_subject
            loop
                DBMS_OUTPUT.PUT_LINE
                    (
                        'SUBJECT: ' || trim(row_subject.SUBJECT_NAME)
                    );
            end loop;
        END;

        function GET_NUM_TEACHERS (FCODE FACULTY.FACULTY % TYPE)
            return number
                is
            COUNTER number := 0;
        BEGIN
            select COUNT(*) into COUNTER from  TEACHER
                inner join PULPIT on TEACHER.PULPIT = PULPIT.PULPIT
                    inner join FACULTY on PULPIT.FACULTY = FACULTY.FACULTY
                        where FACULTY.FACULTY = FCODE;
            return COUNTER;
        END;

        function GET_NUM_SUBJECTS(PCODE SUBJECT.PULPIT % type)
            return number is
        COUNTER number := 0;
            BEGIN
                select COUNT(*) into COUNTER from SUBJECT
                    where SUBJECT.PULPIT = PCODE;
                return COUNTER;
        END;
end;
-----------
BEGIN
    TEACHERS.GET_TEACHERS('PAP');
    DBMS_OUTPUT.PUT_LINE('--------------------------------------------------------------------');
    TEACHERS.GET_SUBJECTS('ISIT');
    DBMS_OUTPUT.PUT_LINE('--------------------------------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('NUMBER OF SUBJECT AT THE PUPLIT ISIT:'||TEACHERS.GET_NUM_SUBJECTS('ISIT'));
    DBMS_OUTPUT.PUT_LINE('--------------------------------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('NUMBER OF TEACHERS AT THE FACULTY PAP:'|| TEACHERS.GET_NUM_TEACHERS('PAP'));
END;
select * from TEACHER;
select * from SUBJECT;
select * from FACULTY;
select * from PULPIT;

