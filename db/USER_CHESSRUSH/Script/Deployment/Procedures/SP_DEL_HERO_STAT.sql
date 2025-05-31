CREATE OR REPLACE PROCEDURE USER_CHESSRUSH.SP_DEL_HERO_STAT (P_HERO_STAT_ID    NUMBER,
                                              P_USERLOGIN       VARCHAR2,
                                              P_REASON          VARCHAR2)
IS
BEGIN
   INSERT INTO CR_HERO_STAT_DEL
      SELECT   A.*,
               SYSDATE AS DATE_DELETE,
               P_USERLOGIN AS USER_DELETE,
               P_REASON AS REASON_DELETE
        FROM   CR_HERO_STAT A
       WHERE   A.HERO_STAT_ID = P_HERO_STAT_ID;

   DELETE FROM   CR_HERO_STAT
         WHERE   HERO_STAT_ID = P_HERO_STAT_ID;

   COMMIT;
END;
/


