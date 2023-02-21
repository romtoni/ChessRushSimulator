CREATE OR REPLACE PROCEDURE USER_CHESSRUSH.SP_DEL_HERO_RACE (P_RACE_ID      NUMBER,
                                              P_USERLOGIN    VARCHAR2,
                                              P_REASON       VARCHAR2)
IS
BEGIN
   INSERT INTO CR_HERO_RACE_DEL
      SELECT   A.*,
               SYSDATE AS DATE_DELETE,
               P_USERLOGIN AS USER_DELETE,
               P_REASON AS REASON_DELETE
        FROM   CR_HERO_RACE A
       WHERE   A.RACE_ID = P_RACE_ID;

   DELETE FROM   CR_HERO_RACE
         WHERE   RACE_ID = P_RACE_ID;

   COMMIT;
END;
/


