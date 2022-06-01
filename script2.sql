-- EXERCICE 1 :
DECLARE
    v_countries int := 25 ;
    v_departments int := 27;
    v_employee_id int := 107;
    v_job_history int :=  10;
    v_jobs int := 29;
    v_locations int := 23;
    v_regions int := 4;
    somme int; 
    
BEGIN
    somme := v_countries + v_departments + v_employee_id + v_job_history + v_jobs + v_locations + v_regions;
    DBMS_OUTPUT.PUT_LINE('Il y a ' || somme || ' enregistrements dans toutes les tables du schéma HR');
END;
