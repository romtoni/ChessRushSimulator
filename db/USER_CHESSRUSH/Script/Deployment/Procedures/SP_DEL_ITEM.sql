CREATE OR REPLACE PROCEDURE USER_CHESSRUSH.SP_DEL_ITEM (P_ITEM_ID      NUMBER,
                                         P_USERLOGIN    VARCHAR2,
                                         P_REASON       VARCHAR2)
IS
BEGIN
   INSERT INTO CR_ITEM_DEL
      SELECT   A.*,
               SYSDATE AS DATE_DELETE,
               P_USERLOGIN AS USER_DELETE,
               P_REASON AS REASON_DELETE
        FROM   CR_ITEM A
       WHERE   A.ITEM_ID = P_ITEM_ID;

   DELETE FROM   CR_ITEM
         WHERE   ITEM_ID = P_ITEM_ID;

   COMMIT;
END;
/


