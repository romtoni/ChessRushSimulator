CREATE OR REPLACE PROCEDURE USER_CHESSRUSH.SP_DEL_HERO_TAGLINE (
   P_HERO_TAGLINE_ID    NUMBER,
   P_USERLOGIN          VARCHAR2,
   P_REASON             VARCHAR2
)
IS
BEGIN
   INSERT INTO CR_HERO_TAGLINE_DEL
      SELECT   A.*,
               SYSDATE AS DATE_DELETE,
               P_USERLOGIN AS USER_DELETE,
               P_REASON AS REASON_DELETE
        FROM   CR_HERO_TAGLINE A
       WHERE   A.HERO_TAGLINE_ID = P_HERO_TAGLINE_ID;

   DELETE FROM   CR_HERO_TAGLINE
         WHERE   HERO_TAGLINE_ID = P_HERO_TAGLINE_ID;

   COMMIT;
END;
/


