---------------------task1----------------------
alter session set nls_date_format = 'DD-MM-YYYY';
---------------------task2----------------------
DECLARE
    LastName   GISCORE1.TEACHER.TEACHER_NAME % type;
    FirstName  GISCORE1.TEACHER.TEACHER_NAME % type;
    Patronymic GISCORE1.TEACHER.TEACHER_NAME % type;
    pos_name INT:= 0;
    pos_patronymic INT:= 0;
    CURSOR c_teacher IS SELECT TEACHER_NAME FROM TEACHER;
BEGIN
        for l_teachername in c_teacher
        loop
            pos_name := INSTR(l_teachername.TEACHER_NAME, ' ');
            pos_patronymic := INSTR(l_teachername.TEACHER_NAME, ' ', pos_name + 1);

            LastName := SUBSTR(l_teachername.TEACHER_NAME, 1, pos_name);

            FirstName := SUBSTR(l_teachername.TEACHER_NAME, pos_name, pos_patronymic-1);
            FirstName := SUBSTR(FirstName, 1, 2);

            Patronymic := SUBSTR(l_teachername.TEACHER_NAME, pos_patronymic);
            Patronymic := SUBSTR(Patronymic, 1, 2);

            SYS.DBMS_OUTPUT.PUT_LINE(LastName||' '||FirstName||'.'||Patronymic||'.');

        END LOOP;
END;
---------------------task3----------------------
 select * from teacher
    where TO_CHAR((birthday), 'd') = 1;
---------------------task4--prosit izmenit' tk s decabrya ne perehodit na yandar'(12-13 mecyac)
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
select * from TEACHER;
DECLARE
    YEAR_BIRTHDAY int;
    cursor c_teacher is select * from TEACHER;
    row_teacher TEACHER % rowtype;
BEGIN
    for row_teacher in c_teacher
        loop
            YEAR_BIRTHDAY := (to_number(to_char(sysdate, 'YYYY')) + 1) - to_number(to_char(row_teacher.BIRTHDAY, 'YYYY'));

            if (mod(YEAR_BIRTHDAY,10) = 0)
                then
                    SYS.DBMS_OUTPUT.PUT_LINE(row_teacher.TEACHER_NAME|| ' '|| row_teacher.BIRTHDAY|| ' years: '|| YEAR_BIRTHDAY);
            end if;
        end loop;
END;
---------------------task7----------------------
DECLARE
    SUM_SALARY INT := 0;
    QUANTITY_IN_FACULTY INT := 0;
    cursor c_teacher is select * from TEACHER;
    cursor c_pulpit is select * from PULPIT;
    cursor c_faculty is select * from FACULTY;
BEGIN
    SYS.DBMS_OUTPUT.PUT_LINE('-------------------------------avg pulpit-------------------------------------');

    for row_pulpit in c_pulpit
        loop
            for row_teacher in c_teacher
            loop
                if row_teacher.PULPIT = row_pulpit.PULPIT
                        then
                        SUM_SALARY := SUM_SALARY + row_teacher.SALARY;
                        QUANTITY_IN_FACULTY := QUANTITY_IN_FACULTY + 1;
                end if;
                end loop;

            SYS.DBMS_OUTPUT.PUT_LINE(row_pulpit.PULPIT_NAME ||' '||'AVG SALARY = '|| floor(SUM_SALARY/QUANTITY_IN_FACULTY));
            QUANTITY_IN_FACULTY := 0;
            SUM_SALARY := 0;

        end loop;

    SYS.DBMS_OUTPUT.PUT_LINE('-------------------------------avg faculty-------------------------------------');
    for row_faculty in c_faculty
        loop
            for row_pulpit in c_pulpit
                loop
                    if row_faculty.FACULTY = row_pulpit.FACULTY
                        then
                            for row_teacher in c_teacher
                                loop
                                    if row_teacher.PULPIT = row_pulpit.PULPIT
                                        then
                                            SUM_SALARY := SUM_SALARY + row_teacher.SALARY;
                                            QUANTITY_IN_FACULTY := QUANTITY_IN_FACULTY + 1;
                                    end if;
                            end loop;

                    end if;
            end loop;
        SYS.DBMS_OUTPUT.PUT_LINE(row_faculty.FACULTY_NAME ||' '||'AVG SALARY = '|| floor(SUM_SALARY/QUANTITY_IN_FACULTY));
        QUANTITY_IN_FACULTY := 0;
        SUM_SALARY := 0;
    end loop;

    DBMS_OUTPUT.PUT_LINE('-------------------------------avg all faculty-------------------------------------');
    for row_teacher in c_teacher
        loop
            SUM_SALARY := SUM_SALARY +row_teacher.SALARY;
            QUANTITY_IN_FACULTY := QUANTITY_IN_FACULTY + 1;
    end loop;

    SYS.DBMS_OUTPUT.PUT_LINE('ALL AVG FACULTY SALARY = '|| floor(SUM_SALARY/QUANTITY_IN_FACULTY));
END;
---------------------task8----------------------
 DECLARE

    TYPE DETAIL_STUDENT IS RECORD
    (
         FACULTY GISCORE1.FACULTY.FACULTY % type,
         COURSE INT
    );

    TYPE STUDENT IS RECORD
    (
        NAME VARCHAR2(30),
        LASTNAME VARCHAR2(30),
        DETAIL DETAIL_STUDENT
    );
    student_1 STUDENT;
    student_2 STUDENT;
BEGIN
    student_1.NAME := 'David';
    student_1.LASTNAME := 'Hammerstein';
    student_1.DETAIL.FACULTY := 'FIT';
    student_1.DETAIL.COURSE := 3;

    student_2 := student_1;

    SYS.DBMS_OUTPUT.PUT_LINE
        (
            'Name: ' || student_2.NAME ||' '||
            'Lastname: ' || student_2.LASTNAME ||' '||
            'Faculty: ' || student_2.DETAIL.FACULTY ||' '||
            'Course: ' || student_2.DETAIL.COURSE
        );

END;

select * from TEACHER

------------------------------
 select TEACHER.BIRTHDAY, TO_CHAR(sysdate,'mm')+1,  TO_CHAR(birthday, 'mm') from teacher;

    select * from TEACHER
        where to_char(BIRTHDAY,'Month') = to_char(sysdate + 60,'Month');

