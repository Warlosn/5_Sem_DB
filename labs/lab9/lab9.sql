alter session set "_ORACLE_SCRIPT"=true;
----------------------------TASK1-----------------------------
grant create any sequence to GISCORE1;
grant select any sequence to GISCORE1;
grant create cluster to GISCORE1;
grant create public synonym to GISCORE1;
grant create synonym to GISCORE1;
grant create materialized view to GISCORE1;
grant drop public synonym to GISCORE1;
alter user GISCORE1 quota unlimited on users;
----------------------------TASK2-----------------------------
create sequence S1_GISCORE1
increment by 10
start with 1000
nomaxvalue
nominvalue
nocycle
nocache
noorder;
select S1_GISCORE1.nextval from dual;
select S1_GISCORE1.currval from dual;
----------------------------TASK3-----------------------------
create sequence S2_GISCORE1
increment by 10
start with 10
maxvalue 100
nocycle;
----------------------------TASK4-----------------------------
select S2_GISCORE1.nextval from dual;
select S2_GISCORE1.currval from dual;
----------------------------TASK5-----------------------------
create sequence S3_GISCORE1
increment by -10
start with 10
maxvalue 11
minvalue -100
nocycle
order;
select S3_GISCORE1.nextval from dual;
select S3_GISCORE1.currval from dual;
----------------------------TASK6(error)-----------------------------
create sequence S4_GISCORE1
increment by 1
start with 1
maxvalue 10
cycle
cache 5
noorder;
select S4_GISCORE1.nextval from dual;
select S4_GISCORE1.currval from dual;
----------------------------TASK7-----------------------------
select * from sys.all_sequences where sequence_owner='GISCORE1';
----------------------------TASK8-----------------------------
 create table T1 (
    N1 number(20),
    N2 number(20),
    N3 number(20),
    N4 number(20)
    ) storage(buffer_pool keep) ;
   
    BEGIN
        FOR i IN 1..7 LOOP
        insert into T1(N1,N2,N3,N4) values (S1_GISCORE1.currval, S2_GISCORE1.currval, S3_GISCORE1.currval, S4_GISCORE1.currval);
        END LOOP;
    END;
    select * from T1;
----------------------------TASK9-----------------------------
    create cluster GISCORE1.ABC
    (
        x number(10),
        v varchar2(12)
    )
    hashkeys 200;
----------------------------TASK10-----------------------------
create table A(XA number(10), VA varchar(12), CA char(10)) cluster GISCORE1.ABC(XA,VA);
----------------------------TASK11-----------------------------
create table B(XB number(10), VB varchar(12), CB char(10)) cluster GISCORE1.ABC(XB,VB);
----------------------------TASK12-----------------------------
create table C(XC number(10), VC varchar(12), CC char(10)) cluster GISCORE1.ABC(XC,VC);
----------------------------TASK13-----------------------------
select cluster_name, owner from DBA_CLUSTERS;
select * from dba_tables where cluster_name='ABC';   
----------------------------TASK14(public in lections)-----------------------------
create synonym GISCORE_Syn1 for GISCORE1.C;
select * from GISCORE1.C;
select *from GISCORE_Syn1;
----------------------------TASK15-----------------------------
create public synonym GISCORE_Syn2 for GISCORE1.B;
select * from GISCORE1.B;
select *from GISCORE_Syn2;
----------------------------TASK16----------------------------
 create table Task16_1 (
        X number(20) primary key
        );
    create table Task16_2  (
        Y number(20),
        constraint fk_column
        foreign key (Y) references Task16_1(X)
        );
    insert into Task16_1(X) values (1);
    insert into Task16_1(X) values (2);
    insert into Task16_2(Y) values (1);
    insert into Task16_2(Y) values (2);
    create view V1
    as select X, Y from Task16_1 inner join Task16_2 on Task16_1.X=Task16_2.Y;
   
    select * from V1;
------------------------------TASK17------------------------------------------
    create materialized view MV
    build immediate
    refresh complete
    start with sysdate
    -- sysdate + Interval '1' minute
    next  sysdate + numtodsinterval(1, 'minute')
    as
    select Task16_1.X, Task16_2.Y
    from (select count(*) X from Task16_1) Task16_1,
         (select count(*) Y from Task16_2) Task16_2
    
    select * from MV;
    select * from Task16_1
    insert into Task16_1(X) values (5);
    commit

    drop materialized view MV;












