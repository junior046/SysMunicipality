CREATE OR REPLACE PROCEDURE insertfavoritecategoryxuser (
    vcategoryid   IN   favorite_category_x_user.id_category%TYPE,
    vuser_id      IN   favorite_category_x_user.id_user%TYPE
) IS
    pcategoryid   favorite_category_x_user.id_category%TYPE;
    piduser       favorite_category_x_user.id_user%TYPE;
BEGIN
    SELECT
        id_category
    INTO pcategoryid
    FROM
        category_proposal
    WHERE
        vcategoryid = id_category;
    SELECT
        id_user
    INTO piduser 
    FROM
        p_user
    WHERE
        vuser_id  = id_user;
    
    INSERT INTO favorite_category_x_user (
        id_category,
        id_user
    ) VALUES (
        vcategoryid ,
        vuser_id  
        
    );

    COMMIT;
EXCEPTION
    WHEN no_data_found THEN
        dbms_output.put_line('La category o user no existe');
    WHEN OTHERS THEN
        dbms_output.put_line('CODIGO:' || sqlcode);
        dbms_output.put_line('MENSAJE:' || sqlerrm);
---
END insertfavoritecategoryxuser;
/