CREATE OR REPLACE PROCEDURE USER_CHESSRUSH.SP_DEL_HERO_SKILL (P_HERO_SKILL_ID    NUMBER,
                                               P_USERLOGIN        VARCHAR2,
                                               P_REASON           VARCHAR2)
IS
BEGIN
   INSERT INTO CR_HERO_SKILL_DEL
      SELECT   A.*,
               SYSDATE AS DATE_DELETE,
               P_USERLOGIN AS USER_DELETE,
               P_REASON AS REASON_DELETE
        FROM   CR_HERO_SKILL A
       WHERE   A.HERO_SKILL_ID = P_HERO_SKILL_ID;

   DELETE FROM   CR_HERO_SKILL
         WHERE   HERO_SKILL_ID = P_HERO_SKILL_ID;

   COMMIT;
END;
/


