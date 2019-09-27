CREATE OR REPLACE PROCEDURE insertpuser (
    vusername        IN   p_user.user_name%TYPE,
    vuserpassword    IN   p_user.user_password%TYPE,
    vadministrator   IN   p_user.administrator%TYPE,
    vidperson        IN   p_user.id_person%TYPE
) IS
    pidperson p_user.id_person%TYPE;
BEGIN
    SELECT
        id_person
    INTO pidperson
    FROM
        person
    WHERE
        vidperson = id_person;
    INSERT INTO p_user (
        id_user,
        user_name,
        user_password,
        administrator,
        id_person
    ) VALUES (
        s_puser.NEXTVAL,
        vusername,
        vuserpassword,
        vadministrator,
        vidperson
    );

    COMMIT;
EXCEPTION
    WHEN no_data_found THEN
        dbms_output.put_line('La persona no existe');
    WHEN OTHERS THEN
        dbms_output.put_line('CODIGO:' || sqlcode);
        dbms_output.put_line('MENSAJE:' || sqlerrm);
END insertpuser;