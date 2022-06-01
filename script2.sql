-- EXERCICE 1 :
-- Déclaration bloc anonyme
set serveroutput on;
DECLARE
    v_countries int;
    v_departments int;
    v_employees int;
    v_job_history int;
    v_jobs int;
    v_locations int;
    v_regions int;
    somme int; 
    v_manager int;
    
BEGIN
    SELECT COUNT(*) 
    INTO v_countries
    FROM COUNTRIES;
    DBMS_OUTPUT.PUT_LINE('Il y a ' || v_countries || ' enregistrement dans la table employees');
    
    SELECT COUNT(*) 
    INTO v_departments
    FROM DEPARTMENTS;
    DBMS_OUTPUT.PUT_LINE('Il y a ' || v_departments || ' enregistrement dans la table employees');
    
    SELECT COUNT(*) 
    INTO v_employees
    FROM EMPLOYEES;
    DBMS_OUTPUT.PUT_LINE('Il y a ' || v_employees || ' enregistrement dans la table employees');
    
    SELECT COUNT(*) 
    INTO v_job_history
    FROM JOB_HISTORY;
    DBMS_OUTPUT.PUT_LINE('Il y a ' || v_job_history || ' enregistrement dans la table job_history');
    
    SELECT COUNT(*) 
    INTO v_jobs
    FROM JOBS;
    DBMS_OUTPUT.PUT_LINE('Il y a ' || v_jobs || ' enregistrement dans la table jobs');
    
    SELECT COUNT(*) 
    INTO v_locations
    FROM LOCATIONS;
    DBMS_OUTPUT.PUT_LINE('Il y a ' || v_locations || ' enregistrement dans la table locations');
    
    SELECT COUNT(*) 
    INTO v_regions
    FROM REGIONS;
    DBMS_OUTPUT.PUT_LINE('Il y a ' || v_regions || ' enregistrement dans la table regions');

    somme := v_countries + v_departments + v_employees + v_job_history + v_jobs + v_locations + v_regions;
    DBMS_OUTPUT.PUT_LINE('Il y a donc ' || somme || ' enregistrements dans toutes les tables du schéma HR');
    
    SELECT COUNT(*) 
    INTO v_manager
    FROM EMPLOYEES 
    WHERE JOB_ID
    LIKE '%MAN' 
    OR JOB_ID 
    LIKE'%MGR';
    
    DBMS_OUTPUT.PUT_LINE('Il y a ' || v_manager || ' manager dans la table employees');
    
    DBMS_OUTPUT.PUT_LINE('Il y a ' || v_manager*100/v_employees || '% de manger');
        
END;

-- EXERCICE 2 :
-- Déclaration bloc anonyme
set serveroutput on;
DECLARE
   
     nom_objet  user_objects.object_name%TYPE;
     type_objet user_objects.object_type%TYPE;
    
BEGIN
    for rec in(
        SELECT object_name, object_type
        FROM user_objects
        ORDER BY 2,1)LOOP
        DBMS_OUTPUT.put_line(rec.object_name || '   ' || rec.object_type); 
    END LOOP;

END;

--EXERCICE 3 :
CREATE TABLE VOL (
    Idvol VARCHAR(30),
    Date_heure_depart TIMESTAMP,
    Date_heure_arrive TIMESTAMP,
    Ville_depart VARCHAR(30),
    Ville_arrive VARCHAR(30));
    
set serveroutput on;
DECLARE
    Idvol varchar2(100);
    Date_heure_depart Date;
    Date_heure_arrive Date;
    Ville_depart varchar2(100);
    Ville_arrive varchar2(100);
    
BEGIN
    INSERT INTO VOL(Idvol, Date_heure_depart, Date_heure_arrive, Ville_depart, Ville_arrive) 
    VALUES('BA270', TO_DATE('10:15:00', 'HH:MI:SS'), TO_DATE('12:15:00', 'HH:MI:SS'), 'Rome', 'Paris');
END;
/
SELECT * FROM VOL;


-- EXERCICE 4 : 
CREATE TABLE PILOTE (
    Matricule VARCHAR(30),
    Nom VARCHAR(30),
    Ville VARCHAR(30),
    Age NUMBER,
    Salaire NUMBER);

insert into pilote values('1','JEAN PAUL','Rennes', 45, 5000);
insert into pilote values('2','JEAN LUC','Rennes', 50, 3500);
insert into pilote values('3','LOUIS','Rennes', 35, 4800);
insert into pilote values('4','LUCAS','Rennes', 46, 4600);
insert into pilote values('5','SAMUEL','Rennes', 51, 8200);
insert into pilote values('6','LUCAS','Rennes', 35, 3700);
insert into pilote values('7','QUENTIN','Rennes', 48, 4000);
insert into pilote values('8','JEAN','Rennes', 52, 2500);
insert into pilote values('9','PAUL','Rennes', 49, 3700);
insert into pilote values('10','LUC','Rennes', 56, 7000);

set serveroutput on;
DECLARE
    salaire_annuel int;
    mean_salaire int;
BEGIN
    SELECT AVG(SALAIRE)
    INTO mean_salaire
    FROM PILOTE
    WHERE AGE BETWEEN '45' AND '55';
    DBMS_OUTPUT.put_line('Le salaire moyen des pilotes âgés entre 45 et 55 ans est de : ' || mean_salaire || '€');    
END;
