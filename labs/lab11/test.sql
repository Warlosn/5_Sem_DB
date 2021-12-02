select * from FACULTY;

declare cur1 FACULTY%rowtype;
    begin
select * into cur1 from FACULTY where FACULTY='PAP';
DBMS_OUTPUT.PUT_LINE(cur1.FACULTY_NAME||cur1.FACULTY);
exception
    when no_data_found then
    DBMS_OUTPUT.put_Line(sqlerrm||sqlcode);
    when too_many_rows then
    DBMS_OUTPUT.put_Line(sqlerrm||sqlcode);
when others then
    DBMS_OUTPUT.put_Line(sqlerrm||sqlcode);
end;

declare  cursor cur2 is select PULPIT.PULPIT, TEACHER.TEACHER_NAME
    from PULPIT inner join TEACHER on PULPIT.PULPIT=TEACHER.PULPIT;
    rec cur2%rowtype;
    begin
    for rec in cur2
    loop
        DBMS_OUTPUT.put_line(rec.PULPIT||' '||rec.TEACHER_NAME);
        end loop;
end;
declare  cursor cur2 is select PULPIT.PULPIT, TEACHER.TEACHER_NAME
    from PULPIT inner join TEACHER on PULPIT.PULPIT=TEACHER.PULPIT;
    rec cur2%rowtype;
    begin
    open cur2;
    fetch cur2 into rec;
    while cur2%found
    loop
        DBMS_OUTPUT.put_line(rec.PULPIT||' '||rec.TEACHER_NAME);
        fetch cur2 into rec;
        end loop;
end;