CREATE OR REPLACE PROCEDURE insertcategoryproposal (
    vcategorytype   IN   category_proposal.category_type%TYPE,
    vproposal_id    IN   category_proposal.id_proposal%TYPE
) IS
    vidproposal category_proposal.id_proposal%TYPE;
BEGIN
    SELECT
        id_proposal
    INTO vidproposal
    FROM
        proposal
    WHERE
        vproposal_id = id_proposal;

    IF length(vcategorytype) > 25 THEN
        raise_application_error(-20002, 'La nombre de tipo es muy larga');
    END IF;

    INSERT INTO category_proposal (
        id_category,
        category_type,
        id_proposal
    ) VALUES (
        s_categoryproposal.NEXTVAL,
        vcategorytype,
        vproposal_id
    );

    COMMIT;
EXCEPTION
    WHEN no_data_found THEN
        dbms_output.put_line('EL prosopal  no existe');
    WHEN OTHERS THEN
        dbms_output.put_line('CODIGO:' || sqlcode);
        dbms_output.put_line('MENSAJE:' || sqlerrm);
---
END insertcategoryproposal;
/