CREATE OR REPLACE PROCEDURE USER_CHESSRUSH.SP_RESAVE_BUILD_LIST (
   P_USERLOGIN    VARCHAR2,
   P_REASON       VARCHAR2
)
IS
BEGIN
   --TEMPORARY DISABLE TRIGGER
   EXECUTE IMMEDIATE 'ALTER TRIGGER TRG_BUILD_ID DISABLE';

   FOR I IN (SELECT   BUILD_ID,
                      BUILD_NAME,
                      HERO_ID_1,
                      HERO_ID_2,
                      HERO_ID_3,
                      HERO_ID_4,
                      HERO_ID_5,
                      HERO_ID_6,
                      HERO_ID_7,
                      HERO_ID_8,
                      HERO_ID_9,
                      HERO_ID_10,
                      STAR_GRADE_1,
                      STAR_GRADE_2,
                      STAR_GRADE_3,
                      STAR_GRADE_4,
                      STAR_GRADE_5,
                      STAR_GRADE_6,
                      STAR_GRADE_7,
                      STAR_GRADE_8,
                      STAR_GRADE_9,
                      STAR_GRADE_10
               FROM   CR_SAVE_BUILD_LIST)
   LOOP
      --RE INSERT BUILD NAME
      INSERT INTO CR_BUILD_LIST_TMP (BUILD_ID,
                                     BUILD_NAME,
                                     DATE_CREATE,
                                     USER_CREATE)
        VALUES   (I.BUILD_ID,
                  I.BUILD_NAME,
                  SYSDATE,
                  P_USERLOGIN);

      --RE INSERT HERO ID
      INSERT INTO CR_BUILD_DETAIL_HERO_TMP (BUILD_ID,
                                            HERO_ID,
                                            STAR_GRADE,
                                            DATE_CREATE,
                                            USER_CREATE)
        VALUES   (I.BUILD_ID,
                  I.HERO_ID_1,
                  I.STAR_GRADE_1,
                  SYSDATE,
                  P_USERLOGIN);

      INSERT INTO CR_BUILD_DETAIL_HERO_TMP (BUILD_ID,
                                            HERO_ID,
                                            STAR_GRADE,
                                            DATE_CREATE,
                                            USER_CREATE)
        VALUES   (I.BUILD_ID,
                  I.HERO_ID_2,
                  I.STAR_GRADE_2,
                  SYSDATE,
                  P_USERLOGIN);


      INSERT INTO CR_BUILD_DETAIL_HERO_TMP (BUILD_ID,
                                            HERO_ID,
                                            STAR_GRADE,
                                            DATE_CREATE,
                                            USER_CREATE)
        VALUES   (I.BUILD_ID,
                  I.HERO_ID_3,
                  I.STAR_GRADE_3,
                  SYSDATE,
                  P_USERLOGIN);

      INSERT INTO CR_BUILD_DETAIL_HERO_TMP (BUILD_ID,
                                            HERO_ID,
                                            STAR_GRADE,
                                            DATE_CREATE,
                                            USER_CREATE)
        VALUES   (I.BUILD_ID,
                  I.HERO_ID_4,
                  I.STAR_GRADE_4,
                  SYSDATE,
                  P_USERLOGIN);

      INSERT INTO CR_BUILD_DETAIL_HERO_TMP (BUILD_ID,
                                            HERO_ID,
                                            STAR_GRADE,
                                            DATE_CREATE,
                                            USER_CREATE)
        VALUES   (I.BUILD_ID,
                  I.HERO_ID_5,
                  I.STAR_GRADE_5,
                  SYSDATE,
                  P_USERLOGIN);

      INSERT INTO CR_BUILD_DETAIL_HERO_TMP (BUILD_ID,
                                            HERO_ID,
                                            STAR_GRADE,
                                            DATE_CREATE,
                                            USER_CREATE)
        VALUES   (I.BUILD_ID,
                  I.HERO_ID_6,
                  I.STAR_GRADE_6,
                  SYSDATE,
                  P_USERLOGIN);

      INSERT INTO CR_BUILD_DETAIL_HERO_TMP (BUILD_ID,
                                            HERO_ID,
                                            STAR_GRADE,
                                            DATE_CREATE,
                                            USER_CREATE)
        VALUES   (I.BUILD_ID,
                  I.HERO_ID_7,
                  I.STAR_GRADE_7,
                  SYSDATE,
                  P_USERLOGIN);

      INSERT INTO CR_BUILD_DETAIL_HERO_TMP (BUILD_ID,
                                            HERO_ID,
                                            STAR_GRADE,
                                            DATE_CREATE,
                                            USER_CREATE)
        VALUES   (I.BUILD_ID,
                  I.HERO_ID_8,
                  I.STAR_GRADE_8,
                  SYSDATE,
                  P_USERLOGIN);

      INSERT INTO CR_BUILD_DETAIL_HERO_TMP (BUILD_ID,
                                            HERO_ID,
                                            STAR_GRADE,
                                            DATE_CREATE,
                                            USER_CREATE)
        VALUES   (I.BUILD_ID,
                  I.HERO_ID_9,
                  I.STAR_GRADE_9,
                  SYSDATE,
                  P_USERLOGIN);

      INSERT INTO CR_BUILD_DETAIL_HERO_TMP (BUILD_ID,
                                            HERO_ID,
                                            STAR_GRADE,
                                            DATE_CREATE,
                                            USER_CREATE)
        VALUES   (I.BUILD_ID,
                  I.HERO_ID_10,
                  I.STAR_GRADE_10,
                  SYSDATE,
                  P_USERLOGIN);

      --CREATE NEW SYNERGY
      SP_CRT_BD_SYNERGY_TMP (I.BUILD_ID, P_USERLOGIN);

      --DELETE OLD SAVE BUILD
      SP_DEL_BUILD_LIST (I.BUILD_ID, P_USERLOGIN, P_REASON);

      --INSERT NEW SAVE BUILD
      SP_SAVE_BUILD_LIST (I.BUILD_ID, P_USERLOGIN);
   END LOOP;

   --RE-ENABLE TRIGGER
   EXECUTE IMMEDIATE 'ALTER TRIGGER TRG_BUILD_ID ENABLE';

   COMMIT;
END;
/


