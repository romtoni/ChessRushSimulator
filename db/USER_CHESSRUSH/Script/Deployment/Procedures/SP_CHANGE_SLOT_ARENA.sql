CREATE OR REPLACE PROCEDURE USER_CHESSRUSH.SP_CHANGE_SLOT_ARENA (P_SESSION_ID      NUMBER,
                                                  P_SLOT_NO_1       NUMBER,
                                                  P_HERO_ID_1       NUMBER,
                                                  P_STAR_GRADE_1    NUMBER,
                                                  P_SLOT_NO_2       NUMBER,
                                                  P_HERO_ID_2       NUMBER,
                                                  P_STAR_GRADE_2    NUMBER,
                                                  P_USERLOGIN       VARCHAR2)
IS
BEGIN
   SP_UPD_SLOT_ARENA (P_SESSION_ID,
                      P_SLOT_NO_1,
                      P_HERO_ID_1,
                      P_STAR_GRADE_1,
                      P_USERLOGIN);
   SP_UPD_SLOT_ARENA (P_SESSION_ID,
                      P_SLOT_NO_2,
                      P_HERO_ID_2,
                      P_STAR_GRADE_2,
                      P_USERLOGIN);

   COMMIT;
END;
/


