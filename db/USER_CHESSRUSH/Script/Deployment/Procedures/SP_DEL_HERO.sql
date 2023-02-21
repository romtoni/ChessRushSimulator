CREATE OR REPLACE PROCEDURE USER_CHESSRUSH.SP_DEL_HERO (P_HERO_ID      NUMBER,
                                         P_USERLOGIN    VARCHAR2,
                                         P_REASON       VARCHAR2)
IS
BEGIN
   INSERT INTO CR_HERO_DEL
      SELECT   A.*,
               SYSDATE AS DATE_DELETE,
               P_USERLOGIN AS USER_DELETE,
               P_REASON AS REASON_DELETE
        FROM   CR_HERO A
       WHERE   A.HERO_ID = P_HERO_ID;

   DELETE FROM   CR_HERO
         WHERE   HERO_ID = P_HERO_ID;

   COMMIT;
END;
/


