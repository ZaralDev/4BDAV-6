Création utilisateur 

create user marchese identified by oracle;
grant all privileges to marchese;



Création des tables

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




3. Oui il y a un ordre a respecter pour pouvoir assigner les clés étrangeres



4. sqlplus

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



TRUNCATE TABLE det;
TRUNCATE TABLE pro;
TRUNCATE TABLE fou;
TRUNCATE TABLE com;
TRUNCATE TABLE cli;



Oui pour ne pas casser les clés étrangeres



