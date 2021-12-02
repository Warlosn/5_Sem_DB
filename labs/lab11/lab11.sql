-------------------------------------TASK1-------------------------------------
declare 
  faculty_rec faculty%rowtype;
begin 
  select * into faculty_rec from faculty;
  dbms_output.put_line(faculty_rec.faculty ||' '||faculty_rec.faculty_name);
  exception
  when others
    then dbms_output.put_line(sqlerrm);
end;
-------------------------------------TASK2-------------------------------------
declare 
  faculty_rec faculty%rowtype;
begin 
  select * into faculty_rec from faculty;
  dbms_output.put_line(faculty_rec.faculty ||' '||faculty_rec.faculty_name);
  exception
  when others
    then dbms_output.put_line(sqlcode||' '||sqlerrm);
end;
-------------------------------------TASK3-------------------------------------
select * from faculty;
declare 
  faculty_rec faculty%rowtype;
begin 
  select * into faculty_rec from faculty;
  dbms_output.put_line(faculty_rec.faculty ||' '||faculty_rec.faculty_name);
  exception
  when too_many_rows
    then dbms_output.put_line(sqlcode||' '||sqlerrm);
end;
-------------------------------------TASK4-------------------------------------
declare 
  faculty_rec faculty%rowtype;
  b1 boolean;
  b2 boolean;
begin
  select * into faculty_rec from faculty where faculty = 'PAP';
  b1:= sql%found;
  b2:=sql%isopen;
  dbms_output.put_line(faculty_rec.faculty||' '||faculty_rec.faculty_name);
  if b1 then dbms_output.put_line('b1 = true');
  else dbms_output.put_line('b1 = fasle');
  end if;
  if b2 then dbms_output.put_line('b2 = true');
  else dbms_output.put_line('b2 = fasle');
  end if;
  exception
  when no_data_found
    then  dbms_output.put_line(sqlcode||' '||sqlerrm);
  when too_many_rows
    then dbms_output.put_line(sqlcode||' '||sqlerrm);
  when others
    then dbms_output.put_line(sqlcode||' '||sqlerrm);
end;
-------------------------------------TASK5/10 with exeptions--------------------------------------
select * from auditorium;
 declare
        sub auditorium%rowtype;
     begin
        --update auditorium set auditorium_capacity='A' where auditorium='206-1';
       -- insert into auditorium values (15, 15, 15, 15);
        --delete from auditorium where auditorium_capacity='A';
        select * into sub from auditorium where auditorium_name='206-1';
    exception
        when others then dbms_output.put_line(sqlerrm);
    end;
-------------------------------------TASK5/10 rollback-------------------------
select * from auditorium;
begin
        update auditorium set auditorium = '207-1' where auditorium = '206-1';
        --insert into auditorium values ('500-1', '301-1', 90, 'LH');
        --delete from auditorium where auditorium = '500-1';
        rollback;
    exception
        when others then dbms_output.put_line('error = '||sqlerrm);
    end;
-------------------------------------TASK11-------------------------------------
select * from TEACHER;
declare
        cursor task11 is select teacher, teacher_name, pulpit from TEACHER;
        m_teacher      teacher.teacher%type;
        m_name         teacher.teacher_name%type;
        m_pulpit       teacher.pulpit%type;
    begin
        open task11;
        dbms_output.put_line('rowcount = '||task11%rowcount);
        loop
            fetch task11 into m_teacher, m_name, m_pulpit;
            exit when task11%notfound;
            dbms_output.put_line(task11%rowcount||' '||m_teacher||' '||
                                 m_name||' '|| m_pulpit);
        end loop;
        dbms_output.put_line('rowcount = '||task11%rowcount);
        close task11;
    exception
        when others then dbms_output.put_line(sqlerrm);
    end;
-------------------------------------TASK12-------------------------------------
declare
        cursor task12 is select subject, subject_name, pulpit from SUBJECT;
        rec subject%rowtype;
    begin
        open task12;
        dbms_output.put_line('rowcount = '||task12%rowcount);
        fetch task12 into rec;
        while task12%found
            loop
            dbms_output.put_line(task12%rowcount||' '||rec.subject||' '||
                                 rec.subject_name||' '||rec.pulpit);
            fetch task12 into rec;
            end loop;
        dbms_output.put_line('rowcount = '||task12%rowcount);
        close task12;
    end;
-------------------------------------TASK13-------------------------------------
declare
        cursor task13
            is select pulpit.pulpit, teacher.teacher_name
            from pulpit inner join teacher on pulpit.pulpit=teacher.pulpit;
        rec task13%rowtype;
    begin
        for rec in task13
        loop
            dbms_output.put_line(task13%rowcount||' '||rec.teacher_name||' '||rec.pulpit);
        end loop;
    end;
-------------------------------------TASK14-------------------------------------
select * from auditorium;
declare 
      cursor task14(cap1 auditorium.auditorium%type,cap2 auditorium.auditorium%type)
        is select auditorium, auditorium_capacity
          from auditorium
          where auditorium_capacity >=cap1 and AUDITORIUM_CAPACITY <= cap2;
    begin
      dbms_output.put_line('Capicity <20 :');
      for aum in task14(0,20)
      loop dbms_output.put(aum.auditorium||' '); end loop;   
      dbms_output.put_line(chr(10)||'Capicity 20-30 :');
      for aum in task14(21,30)
      loop dbms_output.put(aum.auditorium||' '); end loop;    
       dbms_output.put_line(chr(10)||'Capicity 30-60 :');
      for aum in task14(31,60)
      loop dbms_output.put(aum.auditorium||' '); end loop;   
       dbms_output.put_line(chr(10)||'Capicity 60-80 :');
      for aum in task14(61,80)
      loop dbms_output.put(aum.auditorium||' '); end loop;  
      dbms_output.put_line(chr(10)||'Capicity more than 80 :');
      for aum in task14(81,100)
      loop dbms_output.put(aum.auditorium||' '); end loop;   
       dbms_output.put_line(chr(10));
    end;
-------------------------------------TASK15-------------------------------------
variable x refcursor;
declare 
  type teacher_name is ref cursor return teacher%rowtype;
  xcurs teacher_name;
begin
  open xcurs for select * from GISCORE1.teacher;
  :x :=xcurs;
end;
    /
print x;
-------------------------------------TASK16-------------------------------------
declare 
        cursor task16_aut is select auditorium_type,
              cursor (select auditorium from auditorium aum
                      where aut.auditorium_type = aum.auditorium_type)
                      from auditorium_type aut;
        task16_aum sys_refcursor;
        aut auditorium_type.auditorium_type%type;
        aum auditorium.auditorium%type;
        txt varchar2(1000);
    begin
    open task16_aut;
    fetch task16_aut into aut, task16_aum;
    while(task16_aut%found)
    loop
    txt:=rtrim(aut)||':';
    loop
        fetch task16_aum into aum;
        exit when task16_aum%notfound;
        txt:=txt||','||rtrim(aum);
        end loop;
        DBMS_OUTPUT.PUT_line(txt);
        fetch task16_aut into aut, task16_aum;
        end loop;
        close task16_aut;
        exception when others
        then dbms_output.put_line(sqlerrm);
        end;
-------------------------------------TASK17-------------------------------------
select * from AUDITORIUM;
 declare 
      cursor cur(cap1 auditorium.auditorium%type, cap2 auditorium.auditorium%type)
            is select auditorium, auditorium_capacity from auditorium
            where auditorium_capacity between cap1 and cap2 for update;
      aum auditorium.auditorium%type;
      cap auditorium.auditorium_capacity%type;
    begin
      open cur(40,80);
      fetch cur into aum, cap;
      while(cur%found)
      loop
          cap := cap * 0.9;
          update auditorium
          set auditorium_capacity = cap
          where current of cur;
          dbms_output.put_line(' '||aum||' '||cap);
          fetch cur into aum, cap;
      end loop;
      close cur; rollback;
   end;
-------------------------------------TASK18-------------------------------------
declare 
      cursor cur(cap1 auditorium.auditorium%type,cap2 auditorium.auditorium%type)
            is select auditorium, auditorium_capacity from auditorium
            where auditorium_capacity between cap1 and cap2 for update;
      aum auditorium.auditorium%type;
      cap auditorium.auditorium_capacity%type;
    begin
      open cur(0,20);
      fetch cur into aum, cap;
      while(cur%found)
      loop
          delete auditorium where current of cur;
          fetch cur into aum, cap;
      end loop;
      close cur;
      
      for pp in cur(0,120) loop
        dbms_output.put_line(pp.auditorium||' '||pp.auditorium_capacity);
      end loop; rollback;
    end;
-------------------------------------TASK19-------------------------------------
declare
    cursor cur(capacity auditorium.auditorium%type)
            is select auditorium, auditorium_capacity, rowid
            from auditorium
            where auditorium_capacity >=capacity for update;
      aum auditorium.auditorium%type;
      cap auditorium.auditorium_capacity%type;
    begin
      for xxx in cur(80)
      loop
        if xxx.auditorium_capacity >=80
          then update auditorium
          set auditorium_capacity = auditorium_capacity+3
          where rowid = xxx.rowid;
        end if;
      end loop;
      for yyy in cur(80)
      loop
        dbms_output.put_line(yyy.auditorium||' '||yyy.auditorium_capacity);
      end loop; rollback;
   end;
  select * from auditorium;
-------------------------------------TAS20-------------------------------------
select * from teacher;
declare 
      cursor curs_teacher is select teacher, teacher_name, pulpit
          from teacher;
      m_teacher teacher.teacher%type;
      m_teacher_name teacher.teacher_name%type;
      m_pulpit teacher.pulpit%type;
      k integer :=1;
    begin
    open curs_teacher;
    loop
    fetch curs_teacher into m_teacher, m_teacher_name, m_pulpit;
    exit when curs_teacher%notfound;
    DBMS_OUTPUT.PUT_LINE(' '||curs_teacher%rowcount||' '
                          ||m_teacher||' '
                          ||m_teacher_name||' '
                          ||m_pulpit);
    if (k mod 3 = 0) then DBMS_OUTPUT.PUT_LINE('-------------------------------------------'); end if;
    k:=k+1;
    end loop;
     DBMS_OUTPUT.PUT_LINE('rowcount = '|| curs_teacher%rowcount);
     close curs_teacher;
    exception
    when others
    then  DBMS_OUTPUT.PUT_LINE(sqlerrm);
    end;
----------------------------------------------------------
----------------------------------------------------------
----------------------------------------------------------
----------------------------------------------------------
----------------------------------------------------------
---------------------------for answer---------------------
declare 
  faculty_rec faculty%rowtype;
  b1 boolean;
  b2 boolean;
begin
  select * into faculty_rec from faculty where faculty = 'PAP';
  b1:= sql%found;
  b2:=sql%isopen;
  dbms_output.put_line(faculty_rec.faculty||' '||faculty_rec.faculty_name);
  if b1 then dbms_output.put_line('b1 = true');
  else dbms_output.put_line('b1 = fasle');
  end if;
  if b2 then dbms_output.put_line('b2 = true');
  else dbms_output.put_line('b2 = fasle');
  end if;
  exception
  when no_data_found
    then  dbms_output.put_line(sqlcode||' '||sqlerrm);
  when too_many_rows
    then dbms_output.put_line(sqlcode||' '||sqlerrm);
  when others
    then dbms_output.put_line(sqlcode||' '||sqlerrm);
end;
----------------------------------------
declare
        cursor task13
            is select pulpit.pulpit, teacher.teacher_name
            from pulpit inner join teacher on pulpit.pulpit=teacher.pulpit;
        rec task13%rowtype;
    begin
        for rec in task13
        loop
            dbms_output.put_line(task13%rowcount||' '||rec.teacher_name||' '||rec.pulpit);
        end loop;
    end;
-----------------------------------------
declare
        cursor task13
            is select pulpit.pulpit, teacher.teacher_name
            from pulpit inner join teacher on pulpit.pulpit=teacher.pulpit;
        rec task13%rowtype;
    begin
        open task13;
      fetch task13 into rec;
     while task13%found
        loop
            dbms_output.put_line(rec.TEACHER_NAME);
            fetch task13 into rec;
            --exit when task13%notfound;
        end loop;
        close task13;
    end;
---------------------------------------------
alter session set NLS_LANGUAGE='AMERICAN';
declare cursor
       cur(cap1 auditorium.auditorium%type,cap2 auditorium.auditorium%type)
            is select auditorium, auditorium_capacity from auditorium
            where auditorium_capacity between cap1 and cap2 for update;
    begin
      for pp in cur(0,120) loop
        dbms_output.put_line(pp.auditorium||' '||pp.auditorium_capacity);
      end loop;
    end;






