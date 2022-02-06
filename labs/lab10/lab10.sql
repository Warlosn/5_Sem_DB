set serveroutput on  for SQLPlus
alter session set NLS_LANGUAGE='AMERICAN';
------------------------TASK1------------------------------
begin 
    null;
end;
------------------------TASK2------------------------------
 begin
        dbms_output.put_line('Hello, world');
    end;
------------------------TASK3------------------------------
declare
        x number(3) := 3;
        y number(3) := 0;
        z number (10,2);
    begin
        z:=x/y;
        DBMS_OUTPUT.put_line(z);
        exception when others
           then dbms_output.put_line(sqlcode||': error = '||sqlerrm);
    end;
------------------------TASK4------------------------------
declare
        x number(3) := 3;
    begin
        begin
            declare x number(3) :=1;
            begin dbms_output.put_line('x = '||x); end;
        end;
        dbms_output.put_line('x = '||x);
    end;
------------------------TASK5------------------------------
alter system set plsql_warnings = 'ENABLE:INFORMATIONAL';
select name, value from v$parameter where name = 'plsql_warnings';
------------------------TASK6------------------------------
select keyword from v$reserved_words
        where length = 1 and keyword != 'A';
------------------------TASK7------------------------------
select keyword from v$reserved_words
        where length > 1 and keyword!='A' order by keyword;
------------------------TASK8------------------------------
select name,value from v$parameter
        where name like 'plsql%';
show parameter plsql;
------------------------TASK9-17------------------------------
declare
        t10 number(3):= 50;
        t11 number(3):=15;
        suma number(10,2);
        dwo number(10,2);
        t12 number(10,2):= 2.11;
        t13 number(10, -3):= 222999.45;
        t14 binary_float:= 123456789.123456789;
        t15 binary_double:= 123456789.123456789;
        t16 number(38,10):=12345E+10;
        t17 boolean:= true;
begin
    suma:=t10+t11;
    dwo:=mod(t10,t11);
    
         dbms_output.put_line('t10 = '||t10);
        dbms_output.put_line('t11 = '||t11);
        dbms_output.put_line('ostatok = '||dwo);
        dbms_output.put_line('suma = '||suma);
        dbms_output.put_line('fix = '||t12);
        dbms_output.put_line('okr = '||t13);
        dbms_output.put_line('binfl = '||t14);
        dbms_output.put_line('bindobuble = '||t15);
        dbms_output.put_line('E+10 = '||t16);
        if t17 then dbms_output.put_line('bool = '||'true'); end if;
        end;
------------------------TASK18------------------------------
 declare
        n1 constant number(5) := 5;
        v1 constant varchar(25) not null default 'Hello world';
        c1 constant char(7) := 'ivan';  
    begin
        dbms_output.put_line('v1 = '||v1);
        dbms_output.put_line('n1 = '||n1);
        dbms_output.put_line('c1 = '||c1);
        
       n1:=10
        exception when others
            then dbms_output.put_line('error = '||n1);
    end;
------------------------TASK19------------------------------
   declare
   subject GISCORE1.SUBJECT.SUBJECT%type;
   rec GISCORE1.FACULTY%rowtype;
begin
    subject :='DB';
    rec.FACULTY :='CTAE';
    rec.FACULTY_NAME:='Chemical technology and engineering';
   dbms_output.put_line('subject = '||subject);
   dbms_output.put_line(rtrim(rec.FACULTY)||':'||rec.FACULTY_NAME);
end;
------------------------TASK21------------------------------
declare
   x number := 15;
begin
   if 14>x then dbms_output.put_line('14>'||x);
   elsif 14=x then dbms_output.put_line('14='||x);
   else dbms_output.put_line('14<'||x);
   end if;
end;
------------------------TASK23------------------------------
declare
  x number := 1;
begin
  case x
     when 1 then dbms_output.put_line('1');
     when 2 then dbms_output.put_line('2');
     when 3 then dbms_output.put_line('3');
     else dbms_output.put_line('else');
  end case;
  case
      when 8>x then dbms_output.put_line('8>'||x);
      when x between 13 and 20 then dbms_output.put_line('13<='||x||'<=20');
      else dbms_output.put_line('else');
  end case;
end;
------------------------TASK24------------------------------
declare
  x pls_integer :=0;
begin
-----------------------------------
  loop x:=x+1;
     dbms_output.put(x);
    exit when x>5;
  end loop;
----------------------------------
  for k in 1..5
  loop 
        dbms_output.put(k); 
  end loop;
-------------------------------------------
   while (x>0)
      loop x:=x-1;
      dbms_output.put_line(x);
      end loop;
end;
-------------------------------DATABASE------------------------------
DROP TABLE FACULTY
CREATE TABLE FACULTY
  (
   FACULTY      CHAR(10)      NOT NULL,
   FACULTY_NAME VARCHAR2(50), 
   CONSTRAINT PK_FACULTY PRIMARY KEY(FACULTY) 
  );
select * from FACULTY;
delete FACULTY;
insert into FACULTY   (FACULTY,   FACULTY_NAME )
             values  ('PAP',   'Publishing and printing');
insert into FACULTY   (FACULTY,   FACULTY_NAME )
            values  ('CTAE',   'Chemical technology and engineering');
insert into FACULTY   (FACULTY,   FACULTY_NAME )
            values  ('FOF',     'Faculty of Forestry');
insert into FACULTY   (FACULTY,   FACULTY_NAME )
            values  ('FOEAE',     'Faculty of Engineering and Economics');
insert into FACULTY   (FACULTY,   FACULTY_NAME )
            values  ('TAEFFI',    'Technology and equipment of the forest industry');
insert into FACULTY   (FACULTY,   FACULTY_NAME )
            values  ('TOOS',     'Technology of organic substances');
--------------------------------------------------------------------------------------------
DROP TABLE PULPIT
CREATE TABLE PULPIT 
(
 PULPIT       CHAR(10)      NOT NULL,
 PULPIT_NAME  VARCHAR2(100), 
 FACULTY      CHAR(10)      NOT NULL, 
 CONSTRAINT FK_PULPIT_FACULTY FOREIGN KEY(FACULTY)   REFERENCES FACULTY(FACULTY), 
 CONSTRAINT PK_PULPIT PRIMARY KEY(PULPIT) 
 ); 
 select * from PULPIT;
delete PULPIT;  
insert into PULPIT   (PULPIT,    PULPIT_NAME,                                                   FACULTY )
             values  ('ISIT',    'Information systems and technologies',                         'PAP'  );
insert into PULPIT   (PULPIT,    PULPIT_NAME,                                                   FACULTY )
             values  ('PEAIPS', 'Printing equipment and information processing systems', 'PAP'  );
insert into PULPIT   (PULPIT,    PULPIT_NAME,                                                   FACULTY)
              values  ('FF',      'Forestry',                                                 'FOF') ;         
insert into PULPIT   (PULPIT,    PULPIT_NAME,                                                   FACULTY)
             values  ('HS',      'Hunting studies',                                                 'FOF') ;   
insert into PULPIT   (PULPIT,    PULPIT_NAME,                                                   FACULTY)
             values  ('FM',      'Forest management',                                              'FOF');           
insert into PULPIT   (PULPIT,    PULPIT_NAME,                                                   FACULTY)
             values  ('FPAWS',   'Forest protection and wood science',                               'FOF');                
insert into PULPIT   (PULPIT,    PULPIT_NAME,                                                   FACULTY)
             values  ('LDALC',  'Landscape design and landscape construction','FOF');                  
insert into PULPIT   (PULPIT,    PULPIT_NAME,                                                   FACULTY)
             values  ('FT',     'Forest transport',                                              'TAEFFI');                        
insert into PULPIT   (PULPIT,    PULPIT_NAME,                                                   FACULTY)
             values  ('FMALT',  'Forest machines and logging technologies',                      'TAEFFI');                        
insert into PULPIT   (PULPIT,    PULPIT_NAME,                                                   FACULTY)
             values  ('OC',     'Organic Chemistry',                                           'TOOS');            
insert into PULPIT   (PULPIT,    PULPIT_NAME,                                                              FACULTY)
             values  ('TOPSAPOPM','Technologies of petrochemical synthesis and processing of polymer materials','TOOS');             
insert into PULPIT   (PULPIT,    PULPIT_NAME,                                                      FACULTY)
             values  ('TOISAGCT','Technologies of inorganic substances and general chemical technology','CTAE');                    
insert into PULPIT   (PULPIT,    PULPIT_NAME,                                                                         FACULTY)
             values  ('CTOEPAMOEE','Chemistry technology of electrochemical production and materials of electronic equipment', 'CTAE');
insert into PULPIT   (PULPIT,    PULPIT_NAME,                                                      FACULTY)
             values  ('ETAM',    'economic theory and marketing',                              'FOEAE');   
insert into PULPIT   (PULPIT,    PULPIT_NAME,                                                      FACULTY)
             values  ('MAEOEM',   'Management and economics of environmental management',                      'FOEAE');    
------------------------------------------------------------------------------------------------------------------------        
 DROP  TABLE TEACHER
CREATE TABLE TEACHER
 ( 
  TEACHER       CHAR(10) NOT  NULL,
  TEACHER_NAME  VARCHAR2(50), 
  PULPIT        CHAR(10) NOT NULL, 
  CONSTRAINT PK_TEACHER  PRIMARY KEY(TEACHER), 
  CONSTRAINT FK_TEACHER_PULPIT FOREIGN   KEY(PULPIT)   REFERENCES PULPIT(PULPIT)
 ) ;
 
 
delete  TEACHER;
insert into  TEACHER    (TEACHER,   TEACHER_NAME, PULPIT, BIRTHDAY,SALARY)
                       values  ('SVV',    'Smelov Vladimir Vladimirovich',  'ISIT', '1988-12-01', 870);
insert into  TEACHER    (TEACHER,  TEACHER_NAME, PULPIT, BIRTHDAY,SALARY )
                       values  ('ASI',    'Akynovich Stanislav Ivanovich',  'ISIT',  '1988-12-25', 790);
insert into  TEACHER    (TEACHER,  TEACHER_NAME, PULPIT, BIRTHDAY,SALARY )
                       values  ('KLV',    'Kolesnikov Leonid Valerevich',  'ISIT',  '1955-12-22', 780);
insert into  TEACHER    (TEACHER,  TEACHER_NAME, PULPIT , BIRTHDAY,SALARY)
                       values  ('GOV',    'German Oleg Vitoldovich',  'ISIT',  '1988-02-02', 760);
insert into  TEACHER    (TEACHER,  TEACHER_NAME, PULPIT , BIRTHDAY,SALARY)
                       values  ('LAP',    'Lashenko Anatoliy Pavlovich',  'ISIT',  '1988-08-28', 888);
insert into  TEACHER    (TEACHER,  TEACHER_NAME, PULPIT , BIRTHDAY,SALARY)
                       values  ('BAV',    'Brakovich Andrey Victorovich',  'ISIT',  '1988-12-01', 750);
insert into  TEACHER    (TEACHER,  TEACHER_NAME, PULPIT , BIRTHDAY,SALARY)
                       values  ('DDA',     'Dedko Alexander Arkadevich',  'ISIT',  '1966-12-22', 740);
insert into  TEACHER    (TEACHER,  TEACHER_NAME, PULPIT , BIRTHDAY,SALARY)
                       values  ('KAS',     'Kabaylo Alexander Seraphimovich',  'ISIT',  '1992-06-23', 850);
insert into  TEACHER    (TEACHER,  TEACHER_NAME, PULPIT , BIRTHDAY,SALARY)
                       values  ('YPP',     'Yrbanovich Pavel Pavlovich',  'ISIT',  '1982-12-01', 670);
insert into  TEACHER    (TEACHER,  TEACHER_NAME, PULPIT , BIRTHDAY,SALARY)
                       values  ('RDM',     'Romanenko Dmitriy Mihaylovich',  'ISIT',  '1981-10-01', 960);
insert into  TEACHER    (TEACHER,  TEACHER_NAME, PULPIT , BIRTHDAY,SALARY)
                       values  ('PNN',  'Pystovalova Natalia Nikolaevna', 'ISIT' ,  '1989-12-07', 876);
insert into  TEACHER    (TEACHER,  TEACHER_NAME, PULPIT , BIRTHDAY,SALARY)
                       values  ('BSA',   'Bartashevich Svytoslav Alexandrovich',  'PEAIPS',  '1988-11-01', 865);
insert into  TEACHER    (TEACHER,  TEACHER_NAME, PULPIT , BIRTHDAY,SALARY)
                       values  ('BSI',   'Baranovskiy Stasislav Ivanovich',  'ETAM',  '1987-12-22', 830);
insert into  TEACHER    (TEACHER,  TEACHER_NAME, PULPIT , BIRTHDAY,SALARY)
                       values  ('NAV',   'Neverov Alexander Vasilevich',  'MAEOEM',  '1984-11-11', 690);
insert into  TEACHER    (TEACHER,  TEACHER_NAME, PULPIT , BIRTHDAY,SALARY)
                       values  ('RAI',   'Rokovich Andrey Ivanovich',  'HS',  '1992-03-01', 720);
insert into  TEACHER    (TEACHER,  TEACHER_NAME, PULPIT , BIRTHDAY,SALARY)
                       values  ('DMN', 'Demidko Marina Nikolaevna',  'LDALC',  '1988-02-01', 865);
insert into  TEACHER    (TEACHER,  TEACHER_NAME, PULPIT , BIRTHDAY,SALARY)
                       values  ('MVP',   'Mashkovskiy Vladimir Petrovich',  'FM',  '1966-03-22', 870);
insert into  TEACHER    (TEACHER,  TEACHER_NAME, PULPIT , BIRTHDAY,SALARY)
                       values  ('LKV',   'Laboha Konstantin Valentinovich',  'FF',  '1988-07-03', 780);
insert into  TEACHER    (TEACHER,  TEACHER_NAME, PULPIT , BIRTHDAY,SALARY)
                       values  ('ZVB',   'Zvyagincev Vacheslav Borisovich',  'FPAWS',  '1977-11-13', 750);
insert into  TEACHER    (TEACHER,  TEACHER_NAME, PULPIT , BIRTHDAY,SALARY)
                       values  ('BVS',   'Bezborodov Vladimir Stepanovic',  'OC', '1988-12-08', 670);
insert into  TEACHER    (TEACHER,  TEACHER_NAME, PULPIT , BIRTHDAY,SALARY)
                       values  ('PNR',   'Prokopchyk Nikalay Romanovich',  'TOPSAPOPM',  '1972-01-01', 760);
insert into  TEACHER    (TEACHER,  TEACHER_NAME, PULPIT , BIRTHDAY,SALARY)
                       values  ('NMT',   'Nasovec Mihail Trofimovich',  'FT',  '1983-11-01', 880);
insert into  TEACHER    (TEACHER,  TEACHER_NAME, PULPIT , BIRTHDAY,SALARY)
                       values  ('MSP',   'Mohov Sergey Petrovich',  'FMALT',  '1985-12-01', 777);
insert into  TEACHER    (TEACHER,  TEACHER_NAME, PULPIT , BIRTHDAY,SALARY)
                       values  ('ELS',   'Eshenko Ludmila Semenovna',  'TOISAGCT',  '1966-06-22', 666);
insert into  TEACHER    (TEACHER,  TEACHER_NAME, PULPIT , BIRTHDAY,SALARY)
                       values  ('JIM',   'Jarski Ivan Mihaylovich',  'CTOEPAMOEE',  '1998-10-03', 750);

---------------------------------------------------------------------------------------------------------------------
DROP TABLE SUBJECT 
CREATE TABLE SUBJECT
    (
     SUBJECT      CHAR(10)     NOT NULL, 
     SUBJECT_NAME VARCHAR2(50)  NOT NULL,
     PULPIT       CHAR(10)     NOT NULL,  
     CONSTRAINT PK_SUBJECT PRIMARY KEY(SUBJECT),
     CONSTRAINT FK_SUBJECT_PULPIT FOREIGN  KEY(PULPIT)  REFERENCES PULPIT(PULPIT)
    );
select * from SUBJECT;
delete SUBJECT;
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,        PULPIT )
                       values ('DMS',   'Database management systems',                   'ISIT');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,        PULPIT)
                       values ('DB',     'Data base',                                        'ISIT');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,        PULPIT )
                       values ('InfT',    'Information technology',                          'ISIT');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,        PULPIT )
                       values ('FOAAP',  'Fundamentals of algorithmization and programming',            'ISIT');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,        PULPIT )
                       values ('KRICS',     'Knowledge representation in computer systems',       'ISIT');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,        PULPIT )
                       values ('PNA',    'Programming network applications',                 'ISIT');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,        PULPIT )
                       values ('MOIPS',     'Modeling of information processing systems',        'ISIT');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,        PULPIT )
                       values ('ISD',     'Information systems design',              'ISIT');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,        PULPIT )
                       values ('CG',      'Computer geometry',                           'ISIT');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,        PULPIT )
                       values ('PMAMAPL',   'Printing machines automatic machines and production lines', 'PEAIPS');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,        PULPIT )
                       values ('CMS',     'Computer multimedia systems',               'ISIT');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,        PULPIT )
                       values ('OFPP',     'Organization of printing production',         'PEAIPS');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,        PULPIT )
                       values ('EOEM',     'Economics of environmental management',                       'MAEOEM');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,        PULPIT )
                       values ('ECT',     'Economic theory',                               'ETAM');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,        PULPIT )
                       values ('BOFAABW','Biology of forest animals and birds with osn hunting',      'HS');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,        PULPIT )
                       values ('FOGAF','Fundamentals of gardening and forestry',  'LDALC');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,        PULPIT )
                       values ('EG',     'Engineering geodesy',                              'FM');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,        PULPIT )
                       values ('FORE',    'Forestry',                                        'FPAWS');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,        PULPIT )
                       values ('ORGCH',    'Organic Chemistry',                                 'OC');   
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,        PULPIT )
                       values ('TORPR',    'Technology of rubber products',                      'TOPSAPOPM'); 
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,        PULPIT )
                       values ('WTOTF',    'Water transport of the forest',                             'FT');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,        PULPIT )
                       values ('LTAE',   'Logging technology and equipment',           'FMALT'); 
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,        PULPIT )
                       values ('MPT',   'Mineral processing technology',        'TOISAGCT');
insert into SUBJECT   (SUBJECT,   SUBJECT_NAME,        PULPIT )
                       values ('AELEC',    'Applied Electrochemistry',                           'CTOEPAMOEE');          
---------------------------------------------------------------------------------------------------------------------
 DROP TABLE AUDITORIUM_TYPE 
create table AUDITORIUM_TYPE 
(
  AUDITORIUM_TYPE   char(10) constraint AUDITORIUM_TYPE_PK  primary key,  
  AUDITORIUM_TYPENAME  varchar(30) constraint AUDITORIUM_TYPENAME_NOT_NULL not null         
);

delete AUDITORIUM_TYPE;
select * from AUDITORIUM_TYPE;
insert into AUDITORIUM_TYPE   (AUDITORIUM_TYPE,   AUDITORIUM_TYPENAME )
                       values  ('LH',   'Lecture hall');
insert into AUDITORIUM_TYPE   (AUDITORIUM_TYPE,   AUDITORIUM_TYPENAME )
                       values  ('LEWC', 'Lecture with comp');
insert into AUDITORIUM_TYPE   (AUDITORIUM_TYPE,   AUDITORIUM_TYPENAME )
                       values  ('CHLA', 'chemistry lab');
insert into AUDITORIUM_TYPE   (AUDITORIUM_TYPE,   AUDITORIUM_TYPENAME )
                       values  ('SCS', 'spec comp class');
---------------------------------------------------------------------------------------------------------------------
 DROP TABLE AUDITORIUM 
create table AUDITORIUM 
(
 AUDITORIUM           char(10) primary key,  -- код аудитории
 AUDITORIUM_NAME      varchar2(200),          -- аудитория 
 AUDITORIUM_CAPACITY  number(4),              -- вместимость
 AUDITORIUM_TYPE      char(10) not null      -- тип аудитории
                      references AUDITORIUM_TYPE(AUDITORIUM_TYPE)  
);

delete  AUDITORIUM;
select * from  AUDITORIUM;
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY )
                       values  ('206-1',   '206-1', 'LH', 15);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY)
                       values  ('301-1',   '301-1', 'LEWC', 15);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY )
                       values  ('236-1',   '236-1', 'LH',   60);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY )
                       values  ('313-1',   '313-1', 'LH',   60);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY )
                       values  ('324-1',   '324-1', 'LH',   50);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY )
                       values  ('413-1',   '413-1', 'LEWC', 15);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY )
                       values  ('423-1',   '423-1', 'LEWC', 90);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY )
                       values  ('408-2',   '408-2', 'LH',  90);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY )
                       values  ('103-4',   '103-4', 'LH',  90);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY )
                       values  ('105-4',   '105-4', 'LH',  90);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY )
                       values  ('107-4',   '107-4', 'LH',  90);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY )
                       values  ('110-4',   '110-4', 'LH',  30);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY )
                       values  ('111-4',   '111-4', 'LH',  30);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY )
                      values  ('114-4',   '114-4', 'LEWC',  90 );
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY )
                       values ('132-4',   '132-4', 'LEWC',   90);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY )
                       values ('02Б-4',   '02Б-4', 'LH',   90);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY )
                       values ('229-4',   '229-4', 'LH',   90);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY )
                       values  ('304-4',   '304-4','LEWC', 90);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY )
                       values  ('314-4',   '314-4', 'LH',  90);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY )
                       values  ('320-4',   '320-4', 'LH',  90);
insert into  AUDITORIUM   (AUDITORIUM,   AUDITORIUM_NAME, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY )
                       values  ('429-4',   '429-4', 'LH',  90);
-----------------------------------------------------------------------------------------------------------------------







 




 

 
