create table T_Range( id number, time_id date) tablespace TS_GIS
    partition by range(id)
    (
    Partition sales_q1 values less than (100) tablespace data00,
    Partition sales_q2 values less than (200) tablespace data01,
    Partition sales_q3 values less than (300) tablespace data02,
    Partition sales_q3 values less than (400) tablespace data03,
    Partition sales_q4 values less than (maxvalue) tablespace data04
    );