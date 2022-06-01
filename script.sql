-- EXERCICE 1 :

-- Création utilisateur 

create user marchese identified by oracle;
grant all privileges to marchese;

-- 1. Créer repo GitHub : ok
-- 2. Création des tables

CREATE TABLE CLI
(NumCli integer PRIMARY KEY,
NomCli VARCHAR2(30),
Pays VARCHAR2(30),
Tel VARCHAR2(30),
Ville VARCHAR2(30),
Dept VARCHAR2(30),
Nat VARCHAR2(30)
);

CREATE TABLE COM 
(NumCom integer PRIMARY KEY,
NumCli integer REFERENCES CLI (NumCli), 
FraisPort VARCHAR2(30),
AnCom VARCHAR2(30),
Payement VARCHAR2(30)
);

CREATE TABLE FOU   
(NumFou integer PRIMARY KEY,
NomFou VARCHAR2(30),
Pays VARCHAR2(30),
Tel VARCHAR2(30)
);

CREATE TABLE PRO  
(NumPro integer PRIMARY KEY,
NumFou integer REFERENCES FOU (NumFou), 
NomPro VARCHAR2(30),
TypePro VARCHAR2(30),
PrixUnit VARCHAR2(30)
);

CREATE TABLE DET  
(NumCom integer PRIMARY KEY REFERENCES COM  (NumCom),
NumPro integer REFERENCES PRO  (NumPro), 
Qte VARCHAR2(30),
Remise VARCHAR2(30)
);

-- 3. Oui il y a un ordre a respecter pour pouvoir assigner les clés étrangeres, si l'ordre n'est pas respecter nous n'aurions pas pu assigner les clés étrangères
-- ordre : CLI, COM, FOU, PRO, DET

-- 4. SQL*plus

SQL> desc cli;
 Name					   Null?    Type
 ----------------------------------------- -------- ----------------------------
 NUMCLI 				   NOT NULL NUMBER(38)
 NOMCLI 					    VARCHAR2(30)
 PAYS						    VARCHAR2(30)
 TEL						    VARCHAR2(30)
 VILLE						    VARCHAR2(30)
 DEPT						    VARCHAR2(30)
 NAT						    VARCHAR2(30)

 SQL> desc com;
  Name					   Null?    Type
  ----------------------------------------- -------- ----------------------------
  NUMCOM 				   NOT NULL NUMBER(38)
  NUMCLI 					    NUMBER(38)
  FRAISPORT					    VARCHAR2(30)
  ANCOM						    VARCHAR2(30)
  PAYEMENT					    VARCHAR2(30)

 SQL> desc fou;
  Name					   Null?    Type
  ----------------------------------------- -------- ----------------------------
  NUMFOU 				   NOT NULL NUMBER(38)
  NOMFOU 					    VARCHAR2(30)
  PAYS						    VARCHAR2(30)
  TEL						    VARCHAR2(30)

 SQL> desc pro;
  Name					   Null?    Type
  ----------------------------------------- -------- ----------------------------
  NUMPRO 				   NOT NULL NUMBER(38)
  NUMFOU 					    NUMBER(38)
  NOMPRO 					    VARCHAR2(30)
  TYPEPRO					    VARCHAR2(30)
  PRIXUNIT					    VARCHAR2(30)

 SQL> desc det;
  Name					   Null?    Type
  ----------------------------------------- -------- ----------------------------
  NUMCOM 				   NOT NULL NUMBER(38)
  NUMPRO 					    NUMBER(38)
  QTE						    VARCHAR2(30)
  REMISE 					    VARCHAR2(30)


Insert

insert into cli values(1, 't', 't', 't', 't', 't', 't');
insert into cli values(2, 't', 't', 't', 't', 't', 't');



insert into com values(1, 1, 't', 't', 't');
insert into com values(2, 2, 't', 't', 't');


insert into fou values(1, 't', 't', 't');
insert into fou values(2, 't', 't', 't');


insert into pro values(1, 1, 't', 't', 't');
insert into pro values(2, 2, 't', 't', 't');


insert into det values(1, 1, 't', 't');
insert into det values(2, 2, 't', 't');


-- 5. Vider les tables
-- Oui l'ordre est important si il est pas respecter on risque de casser les clés étrangères

TRUNCATE TABLE det;
TRUNCATE TABLE pro;
TRUNCATE TABLE fou;
TRUNCATE TABLE com;
TRUNCATE TABLE cli;



-- EXERCICE 2 :

-- 1. Instalation Oracle SQL DEVELOPER : ok
-- 2. Port 1521 : ok
-- 3. Nombre de core et taille de RAM de la vm : ok
-- 4. Connexion schéma HR : ok
-- 5. Décrire objet : ok
-- 6. Générer DDL : ok
-- 7. Reverse engineering du modèle relationnel : ok



-- EXERCICE 3 :

-- 1. select FIRST_NAME, last_name, COMMISSION_PCT, DEPARTMENT_ID, HIRE_DATE, SALARY from employees 
--    where commission_pct is not null and salary between '10000' and '15000' and hire_date <= '05/06/2005'
-- 2. select department_id, AVG(salary), MEDIAN(salary), MIN(salary), MAX(salary) from employees group by department_id
-- 3. select job_title, AVG(min_salary+max_salary)/2, MEDIAN(min_salary+max_salary)from jobs group by job_title 
-- 4. select * from employees where job_id like 'IT%' and salary >= '6461'
-- 5. select first_name, last_name, hire_date from employees
