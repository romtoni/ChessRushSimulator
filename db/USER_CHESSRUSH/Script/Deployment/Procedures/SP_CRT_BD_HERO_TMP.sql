CREATE OR REPLACE PROCEDURE USER_CHESSRUSH.SP_CRT_BD_HERO_TMP (
   P_BUILD_ID      NUMBER,
   P_HERO_ID       NUMBER,
   P_STAR_GRADE    NUMBER,
   P_USERLOGIN     VARCHAR2
)
IS
   V_TOTAL_HERO_AMOUNT   NUMBER;
BEGIN
   --MAX HERO AMOUNT MUST BE 10 ONLY
   SELECT   COUNT ( * )
     INTO   V_TOTAL_HERO_AMOUNT
     FROM   CR_BUILD_DETAIL_HERO_TMP
    WHERE   BUILD_ID = P_BUILD_ID;

   IF V_TOTAL_HERO_AMOUNT <= 10
   THEN
      --CREATE HERO LIST BY BUILD ID
      INSERT INTO CR_BUILD_DETAIL_HERO_TMP (BUILD_ID,
                                            HERO_ID,
                                            STAR_GRADE,
                                            USER_CREATE)
        VALUES   (P_BUILD_ID,
                  P_HERO_ID,
                  P_STAR_GRADE,
                  P_USERLOGIN);
   END IF;

   COMMIT;
END;
/


