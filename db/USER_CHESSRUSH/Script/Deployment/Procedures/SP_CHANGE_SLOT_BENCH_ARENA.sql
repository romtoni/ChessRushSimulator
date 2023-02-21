CREATE OR REPLACE PROCEDURE USER_CHESSRUSH.SP_CHANGE_SLOT_BENCH_ARENA (
   P_SESSION_ID      NUMBER,
   P_SLOT_NO_1       NUMBER,
   P_HERO_ID_1       NUMBER,
   P_STAR_GRADE_1    NUMBER,
   P_SLOT_NO_2       NUMBER,
   P_HERO_ID_2       NUMBER,
   P_STAR_GRADE_2    NUMBER,
   P_USERLOGIN       VARCHAR2
)
IS
   V_COUNT_BENCH   NUMBER;
   V_COUNT_ARENA   NUMBER;
BEGIN
   --CHECK FIRST SLOT NO
   SELECT   COUNT ( * )
     INTO   V_COUNT_ARENA
     FROM   CR_PREVIEW_ARENA
    WHERE   SESSION_ID = P_SESSION_ID AND SLOT_NO = P_SLOT_NO_1;

   IF V_COUNT_ARENA > 0
   THEN
      SP_UPD_SLOT_ARENA (P_SESSION_ID,
                         P_SLOT_NO_1,
                         P_HERO_ID_1,
                         P_STAR_GRADE_1,
                         P_USERLOGIN);
   ELSE
      SELECT   COUNT ( * )
        INTO   V_COUNT_BENCH
        FROM   CR_PREVIEW_BENCH
       WHERE   SESSION_ID = P_SESSION_ID AND SLOT_NO = P_SLOT_NO_1;

      IF V_COUNT_BENCH > 0
      THEN
         SP_UPD_SLOT_BENCH (P_SESSION_ID,
                            P_SLOT_NO_1,
                            P_HERO_ID_1,
                            P_STAR_GRADE_1,
                            P_USERLOGIN);
      END IF;
   END IF;

   --CHECK SECOND SLOT NO
   SELECT   COUNT ( * )
     INTO   V_COUNT_ARENA
     FROM   CR_PREVIEW_ARENA
    WHERE   SESSION_ID = P_SESSION_ID AND SLOT_NO = P_SLOT_NO_2;

   IF V_COUNT_ARENA > 0
   THEN
      SP_UPD_SLOT_ARENA (P_SESSION_ID,
                         P_SLOT_NO_2,
                         P_HERO_ID_2,
                         P_STAR_GRADE_2,
                         P_USERLOGIN);
   ELSE
      SELECT   COUNT ( * )
        INTO   V_COUNT_BENCH
        FROM   CR_PREVIEW_BENCH
       WHERE   SESSION_ID = P_SESSION_ID AND SLOT_NO = P_SLOT_NO_2;

      IF V_COUNT_BENCH > 0
      THEN
         SP_UPD_SLOT_BENCH (P_SESSION_ID,
                            P_SLOT_NO_2,
                            P_HERO_ID_2,
                            P_STAR_GRADE_2,
                            P_USERLOGIN);
      END IF;
   END IF;

   COMMIT;
END;
/


