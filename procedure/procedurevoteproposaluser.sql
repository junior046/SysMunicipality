CREATE OR REPLACE PROCEDURE insertvoteproposaluser (
    vproposalid   IN   vote_proposal_x_user.id_proposal%TYPE,
    vuser_id      IN   vote_proposal_x_user.id_user%TYPE,
    vvote         IN   vote_proposal_x_user.vote%TYPE
) IS
    pproposalid   vote_proposal_x_user.id_proposal%TYPE;
    puser_id      vote_proposal_x_user.id_user%TYPE;
BEGIN
    SELECT
        id_proposal
    INTO pproposalid
    FROM
        proposal
    WHERE
        vproposalid = id_proposal;

    SELECT
        id_user
    INTO puser_id
    FROM
        p_user
    WHERE
        vuser_id = id_user;

    INSERT INTO vote_proposal_x_user (
        id_proposal,
        id_user,
        vote
    ) VALUES (
        vproposalid,
        vuser_id,
        vvote
    );

    COMMIT;
EXCEPTION
    WHEN no_data_found THEN
        dbms_output.put_line('Lapropuesta o user no existe');
    WHEN OTHERS THEN
        dbms_output.put_line('CODIGO:' || sqlcode);
        dbms_output.put_line('MENSAJE:' || sqlerrm);
---
END insertvoteproposaluser;