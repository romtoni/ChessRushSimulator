CREATE OR REPLACE PROCEDURE USER_CHESSRUSH.SP_DEL_HERO_CLASS (P_CLASS_ID      NUMBER,
                                               P_USERLOGIN    VARCHAR2,
                                               P_REASON       VARCHAR2)
IS
BEGIN
   INSERT INTO CR_HERO_CLASS_DEL
      SELECT   A.*,
               SYSDATE AS DATE_DELETE,
               P_USERLOGIN AS USER_DELETE,
               P_REASON AS REASON_DELETE
        FROM   CR_HERO_CLASS A
       WHERE   A.CLASS_ID = P_CLASS_ID;

   DELETE FROM   CR_HERO_CLASS
         WHERE   CLASS_ID = P_CLASS_ID;

   COMMIT;
END;
/


