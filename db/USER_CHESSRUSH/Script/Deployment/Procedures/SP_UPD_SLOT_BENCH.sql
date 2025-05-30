CREATE OR REPLACE PROCEDURE USER_CHESSRUSH.SP_UPD_SLOT_BENCH (
   P_SESSION_ID    NUMBER,
   P_SLOT_NO       NUMBER,
   P_HERO_ID       NUMBER,
   P_STAR_GRADE    NUMBER,
   P_USERLOGIN     VARCHAR2
)
IS
BEGIN
   UPDATE   CR_PREVIEW_BENCH
      SET   HERO_ID = P_HERO_ID,
            STAR_GRADE = P_STAR_GRADE,
            DATE_MODIFY = SYSDATE,
            USER_MODIFY = P_USERLOGIN
    WHERE   SESSION_ID = P_SESSION_ID AND SLOT_NO = P_SLOT_NO;

   COMMIT;
END;
/


