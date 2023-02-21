CREATE OR REPLACE PROCEDURE USER_CHESSRUSH.SP_DEL_HERO_PHOTO (P_HERO_PHOTO_ID    NUMBER,
                                               P_USERLOGIN        VARCHAR2,
                                               P_REASON           VARCHAR2)
IS
BEGIN
   INSERT INTO CR_HERO_PHOTO_DEL
      SELECT   A.*,
               SYSDATE AS DATE_DELETE,
               P_USERLOGIN AS USER_DELETE,
               P_REASON AS REASON_DELETE
        FROM   CR_HERO_PHOTO A
       WHERE   A.HERO_PHOTO_ID = P_HERO_PHOTO_ID;

   DELETE FROM   CR_HERO_PHOTO
         WHERE   HERO_PHOTO_ID = P_HERO_PHOTO_ID;

   COMMIT;
END;
/


