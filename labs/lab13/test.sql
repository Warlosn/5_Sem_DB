





















CREATE OR REPLACE FUNCTION Get_count_of_Teachers(PCODE TEACHER.PULPIT%TYPE)
  RETURN NUMBER IS
    tCount NUMBER;
BEGIN
  SELECT COUNT(*) INTO tCount FROM TEACHER WHERE PULPIT = PCODE;
  RETURN tCount;
END;-------------------
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





