-- HR
grant select on employees to TEST;

grant execute on add_job_history to test;



-- SYSTEM
CREATE TABLESPACE tbs_test 
   DATAFILE 'tbs_test_file_01.dbf' SIZE 10M 
   ONLINE;
   
SELECT file_name from dba_data_files WHERE tablespace_name = 'TBS_TEST';

CREATE TABLESPACE tbs_idx_test 
   DATAFILE '/u01/app/oracle/oradata/ORCLCDB/orcl/tbs_idx_test_file_01.dbf' SIZE 10M 
   ONLINE;
   
SELECT file_name from dba_data_files WHERE tablespace_name = 'TBS_IDX_TEST';

CREATE USER TEST IDENTIFIED BY oracle
DEFAULT TABLESPACE tbs_test
TEMPORARY TABLESPACE TEMP;

ALTER USER TEST QUOTA UNLIMITED ON tbs_test;
ALTER USER TEST QUOTA UNLIMITED ON tbs_idx_test;

GRANT CONNECT, RESOURCE TO TEST;

select distinct segment_type from dba_segments
ORDER BY 1;


select PROFILE from dba_users where username = 'HR';

select distinct profile from dba_users;

select * from dba_profiles;

grant connect to test;

select * from dba_sys_privs;

grant create table, create view, create procedure, create trigger, create session to test;

grant update on hr.employees to test; 

select * from dba_tab_privs where grantee = 'TEST';

select * from dba_roles;

select * from dba_role_privs where grantee = 'TEST';

select * from role_role_privs where role = 'CONNECT';CREATE TABLESPACE tbs_test 
   DATAFILE 'tbs_test_file_01.dbf' SIZE 10M 
   ONLINE;
   
SELECT file_name from dba_data_files WHERE tablespace_name = 'TBS_TEST';

CREATE TABLESPACE tbs_idx_test 
   DATAFILE '/u01/app/oracle/oradata/ORCLCDB/orcl/tbs_idx_test_file_01.dbf' SIZE 10M 
   ONLINE;
   
SELECT file_name from dba_data_files WHERE tablespace_name = 'TBS_IDX_TEST';

CREATE USER TEST IDENTIFIED BY oracle
DEFAULT TABLESPACE tbs_test
TEMPORARY TABLESPACE TEMP;

ALTER USER TEST QUOTA UNLIMITED ON tbs_test;
ALTER USER TEST QUOTA UNLIMITED ON tbs_idx_test;

GRANT CONNECT, RESOURCE TO TEST;

select distinct segment_type from dba_segments
ORDER BY 1;


select PROFILE from dba_users where username = 'HR';

select distinct profile from dba_users;

select * from dba_profiles;

grant connect to test;

select * from dba_sys_privs;

grant create table, create view, create procedure, create trigger, create session to test;

grant update on hr.employees to test; 

select * from dba_tab_privs where grantee = 'TEST';

select * from dba_roles;

select * from dba_role_privs where grantee = 'TEST';

select * from role_role_privs where role = 'CONNECT';


-- TEST 
CREATE table t_test (
    id_test NUMBER GENERATED AS IDENTITY,
    libelle_test VARCHAR2(50),
    constraint pk_t_test PRIMARY KEY(id_test)
    using index tablespace tbs_idx_test);
    
insert into t_test (libelle_test) values('lundi');
insert into t_test (libelle_test) values('mardi');
insert into t_test (libelle_test) values('mercredi');
insert into t_test (libelle_test) values('jeudi');
insert into t_test (libelle_test) values('vendredi');
insert into t_test (libelle_test) values('samedi');
insert into t_test (libelle_test) values('dimanche');

commit;

select * from t_test;

select table_name as object_name, tablespace_name from user_tables
union
select index_name, tablespace_name from user_indexes;

CREATE TABLE toto (id_toto number)
tablespace USERS;

drop table toto;

select * from t_test;

select * from HR.employees;
