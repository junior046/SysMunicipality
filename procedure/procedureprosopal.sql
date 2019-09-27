CREATE OR REPLACE PROCEDURE insertproposal (
    vtitle           IN   proposal.proposal_title%TYPE,
    vdescription     IN   proposal.proposal_description%TYPE,
    vqualification   IN   proposal.qualification%TYPE,
    vbudget          IN   proposal.budget%TYPE,
    vpersonid        IN   proposal.id_person%type,
    vcommunityid     IN   proposal.id_community%TYPE
) IS
    ppersonid      proposal.id_person%TYPE;
    pcommunityid   proposal.id_community%TYPE;
BEGIN
    SELECT
        id_person
    INTO ppersonid
    FROM
        person
    WHERE
        vpersonid = id_person;

    SELECT
        id_community
    INTO pcommunityid
    FROM
        community
    WHERE
        vcommunityid = id_community;

    INSERT INTO proposal (
        id_proposal,
        proposal_title,
        proposal_description,
        qualification,
        budget,
        id_person,
        id_community
    ) VALUES (
        s_proposal.NEXTVAL,
        vtitle,
        vdescription,
        vqualification,
        vbudget,
        vpersonid,
        vcommunityid
    );

    COMMIT;
EXCEPTION
    WHEN no_data_found THEN
        dbms_output.put_line('La persona o la comunidad que desea ingresaar no son válidos');
END insertproposal;