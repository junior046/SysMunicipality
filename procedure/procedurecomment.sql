create or replace PROCEDURE insertpcomment (
    vcomment       IN   p_comment.id_comment%TYPE,
    vid_user       IN   p_comment.id_user%TYPE,
    vid_proposal   IN   p_comment.id_proposal%TYPE
) IS
    piduser       p_comment.id_user%TYPE;
    pidprosopal   p_comment.id_proposal%TYPE;
BEGIN
 IF length(vcomment ) > 200 THEN
        raise_application_error(-2030, 'El commentario es muy largo.');
    END IF;
    SELECT
        id_user
    INTO piduser 
    FROM
        p_user
    WHERE
        vid_user = id_user;

    SELECT
        id_proposal
    INTO pidprosopal
    FROM
        proposal
    WHERE
        vid_proposal = id_proposal;

    INSERT INTO p_comment (
        id_comment,
        p_comment,
        date_comment,
        id_user,
        id_proposal
    ) VALUES (
        s_pcomment.NEXTVAL,
        vcomment,
        sysdate,
        vid_user,
        vid_proposal
    );
    commit;

EXCEPTION
    WHEN no_data_found THEN
        dbms_output.put_line('EL user o proposal no existe');
    WHEN OTHERS THEN
        dbms_output.put_line('CODIGO:' || sqlcode);
        dbms_output.put_line('MENSAJE:' || sqlerrm);
END insertpcomment;