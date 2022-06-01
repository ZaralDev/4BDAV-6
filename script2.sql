-- EXERCICE 1 :

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
