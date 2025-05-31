CREATE OR REPLACE PROCEDURE USER_CHESSRUSH.SP_DEL_HERO_TIER (P_HERO_TIER_ID    NUMBER,
                                              P_USERLOGIN       VARCHAR2,
                                              P_REASON          VARCHAR2)
IS
BEGIN
   INSERT INTO CR_HERO_TIER_DEL
      SELECT   A.*,
               SYSDATE AS DATE_DELETE,
               P_USERLOGIN AS USER_DELETE,
               P_REASON AS REASON_DELETE
        FROM   CR_HERO_TIER A
       WHERE   A.HERO_TIER_ID = P_HERO_TIER_ID;

   DELETE FROM   CR_HERO_TIER
         WHERE   HERO_TIER_ID = P_HERO_TIER_ID;

   COMMIT;
END;
/


