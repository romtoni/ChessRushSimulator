CREATE OR REPLACE PROCEDURE USER_CHESSRUSH.SP_UPGRADE_HERO_SPECIAL (
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
   V_COUNT_HERO_1       NUMBER;
   V_COUNT_HERO_2       NUMBER;
   V_LAST_SLOT_NO       NUMBER;
   V_COUNT_SLOT_ARENA   NUMBER;
   V_COUNT_SLOT_BENCH   NUMBER;
BEGIN
   --CHECK THE HERO THAT WANT TO UPGRADE IS AVAILABLE
   SELECT   COUNT ( * )
     INTO   V_COUNT_HERO_1
     FROM   (SELECT   SESSION_ID, HERO_ID, STAR_GRADE FROM CR_PREVIEW_ARENA
             UNION ALL
             SELECT   SESSION_ID, HERO_ID, STAR_GRADE FROM CR_PREVIEW_BENCH)
    WHERE       SESSION_ID = P_SESSION_ID
            AND HERO_ID = P_HERO_ID_1
            AND STAR_GRADE = P_STAR_GRADE_1;

   --CHECK THE GURRU IS AVAILABLE
   SELECT   COUNT ( * )
     INTO   V_COUNT_HERO_2
     FROM   (SELECT   SESSION_ID, HERO_ID, STAR_GRADE FROM CR_PREVIEW_ARENA
             UNION ALL
             SELECT   SESSION_ID, HERO_ID, STAR_GRADE FROM CR_PREVIEW_BENCH)
    WHERE       SESSION_ID = P_SESSION_ID
            AND HERO_ID = P_HERO_ID_2
            AND STAR_GRADE = P_STAR_GRADE_2
            AND HERO_ID = 17;

   --IF BOTH OF THEM IS EXIST THEN DO NEXT STEP
   --IF NOT, THEN NOTHING HAPPENS

   IF V_COUNT_HERO_1 > 0 AND V_COUNT_HERO_2 > 0
   THEN
      --CHECK GURRU LEVEL,
      --IF GURRU LEVEL IS 1 THEN REQUIRES 2 SLOTS OF UPGRADEABLE HERO WITH STAR GRADE 1
      --IF GURRU LEVEL IS 2 THEN REQUIRES 2 SLOTS OF UPGRADEABLE HERO WITH STAR GRADE 2
      --IF GURRU LEVEL IS 3 THEN ONLY REQUIRES 1 SLOT OF UPGRADEABLE HERO WITH STAR GRADE 2
      --OTHERWISE, CHANGE THEIR SLOT EACH OTHER

      IF ( (P_STAR_GRADE_2 = 2 AND P_STAR_GRADE_1 = 2)
          OR (P_STAR_GRADE_2 = 1 AND P_STAR_GRADE_1 = 1))
      THEN
         --CHECK IF NUMBER OF HERO HAS MEET REQUIREMENT TO UPGRADE
         SELECT   COUNT ( * )
           INTO   V_COUNT_HERO_1
           FROM   (SELECT   SESSION_ID, HERO_ID, STAR_GRADE
                     FROM   CR_PREVIEW_ARENA
                   UNION ALL
                   SELECT   SESSION_ID, HERO_ID, STAR_GRADE
                     FROM   CR_PREVIEW_BENCH)
          WHERE       SESSION_ID = P_SESSION_ID
                  AND HERO_ID = P_HERO_ID_1
                  AND STAR_GRADE = P_STAR_GRADE_1;


         --IF SAME HERO IS MORE THAN TWO  THEN ONLY UPGRADE TWO OF THEM
         --IF NOT, THEN CHANGE SLOT BETWEEN GURRU AND THAT HERO
         IF V_COUNT_HERO_1 >= 2
         THEN
            --CHECK IF THE SLOT IS EXIST IN THE ARENA, THEN UPGRADE THERE
            --IF NOT, CHECK IF THE SLOT IS EXIST IN THE BENCH, THEN UPGRADE THERE
            SELECT   COUNT ( * )
              INTO   V_COUNT_SLOT_ARENA
              FROM   CR_PREVIEW_ARENA
             WHERE   SESSION_ID = P_SESSION_ID AND SLOT_NO = P_SLOT_NO_1;

            IF V_COUNT_SLOT_ARENA > 0
            THEN
               SP_UPD_SLOT_ARENA (P_SESSION_ID,
                                  P_SLOT_NO_1,
                                  P_HERO_ID_1,
                                  P_STAR_GRADE_1 + 1,
                                  P_USERLOGIN);
            ELSE
               SELECT   COUNT ( * )
                 INTO   V_COUNT_SLOT_BENCH
                 FROM   CR_PREVIEW_BENCH
                WHERE   SESSION_ID = P_SESSION_ID AND SLOT_NO = P_SLOT_NO_1;

               IF V_COUNT_SLOT_BENCH > 0
               THEN
                  SP_UPD_SLOT_BENCH (P_SESSION_ID,
                                     P_SLOT_NO_1,
                                     P_HERO_ID_1,
                                     P_STAR_GRADE_1 + 1,
                                     P_USERLOGIN);
               END IF;
            END IF;

            --REMOVE THE SLOT OF SAME HERO WHERE EXCLUDE THE SLOT WITH HERO THAT ALREADY UPGRADED
            SELECT   MAX (SLOT_NO)
              INTO   V_LAST_SLOT_NO
              FROM   (SELECT   SESSION_ID,
                               SLOT_NO,
                               HERO_ID,
                               STAR_GRADE
                        FROM   (  SELECT   SESSION_ID,
                                           SLOT_NO,
                                           HERO_ID,
                                           STAR_GRADE
                                    FROM   (SELECT   SESSION_ID,
                                                     SLOT_NO,
                                                     HERO_ID,
                                                     STAR_GRADE
                                              FROM   CR_PREVIEW_BENCH
                                            UNION ALL
                                            SELECT   SESSION_ID,
                                                     SLOT_NO,
                                                     HERO_ID,
                                                     STAR_GRADE
                                              FROM   CR_PREVIEW_ARENA)
                                ORDER BY   SESSION_ID ASC, SLOT_NO DESC)
                       WHERE       SESSION_ID = P_SESSION_ID
                               AND HERO_ID = P_HERO_ID_1
                               AND STAR_GRADE = P_STAR_GRADE_1
                               AND SLOT_NO NOT IN (P_SLOT_NO_1)
                               AND ROWNUM <= 2);

            --CHECK IF THE SLOT IS EXIST IN THE ARENA, THEN UPGRADE THERE
            --IF NOT, CHECK IF THE SLOT IS EXIST IN THE BENCH, THEN UPGRADE THERE
            SELECT   COUNT ( * )
              INTO   V_COUNT_SLOT_ARENA
              FROM   CR_PREVIEW_ARENA
             WHERE   SESSION_ID = P_SESSION_ID AND SLOT_NO = V_LAST_SLOT_NO;

            IF V_COUNT_SLOT_ARENA > 0
            THEN
               SP_UPD_SLOT_ARENA (P_SESSION_ID,
                                  V_LAST_SLOT_NO,
                                  NULL,
                                  NULL,
                                  P_USERLOGIN);
            ELSE
               SELECT   COUNT ( * )
                 INTO   V_COUNT_SLOT_BENCH
                 FROM   CR_PREVIEW_BENCH
                WHERE   SESSION_ID = P_SESSION_ID
                        AND SLOT_NO = V_LAST_SLOT_NO;

               IF V_COUNT_SLOT_BENCH > 0
               THEN
                  SP_UPD_SLOT_BENCH (P_SESSION_ID,
                                     V_LAST_SLOT_NO,
                                     NULL,
                                     NULL,
                                     P_USERLOGIN);
               END IF;
            END IF;

            --REMOVE THE GURRU SLOT
            SELECT   COUNT ( * )
              INTO   V_COUNT_SLOT_ARENA
              FROM   CR_PREVIEW_ARENA
             WHERE       SESSION_ID = P_SESSION_ID
                     AND SLOT_NO = P_SLOT_NO_2
                     AND HERO_ID = 17;

            IF V_COUNT_SLOT_ARENA > 0
            THEN
               SP_UPD_SLOT_ARENA (P_SESSION_ID,
                                  P_SLOT_NO_2,
                                  NULL,
                                  NULL,
                                  P_USERLOGIN);
            ELSE
               SELECT   COUNT ( * )
                 INTO   V_COUNT_SLOT_BENCH
                 FROM   CR_PREVIEW_BENCH
                WHERE       SESSION_ID = P_SESSION_ID
                        AND SLOT_NO = P_SLOT_NO_2
                        AND HERO_ID = 17;

               IF V_COUNT_SLOT_BENCH > 0
               THEN
                  SP_UPD_SLOT_BENCH (P_SESSION_ID,
                                     P_SLOT_NO_2,
                                     NULL,
                                     NULL,
                                     P_USERLOGIN);
               END IF;
            END IF;
         ELSE
            --CHECK IF THAT BOTH SLOT IN PARAMETER EXIST ONLY IN THE ARENA
            --IF YES, THEN CHANGE THEM THERE
            SELECT   COUNT ( * )
              INTO   V_COUNT_SLOT_ARENA
              FROM   CR_PREVIEW_ARENA
             WHERE   SESSION_ID = P_SESSION_ID
                     AND SLOT_NO IN (P_SLOT_NO_1, P_SLOT_NO_2);

            IF V_COUNT_SLOT_ARENA = 2
            THEN
               SP_CHANGE_SLOT_ARENA (P_SESSION_ID,
                                     P_SLOT_NO_2,
                                     P_HERO_ID_2,
                                     P_STAR_GRADE_2,
                                     P_SLOT_NO_1,
                                     P_HERO_ID_1,
                                     P_STAR_GRADE_1,
                                     P_USERLOGIN);
            ELSE
               --CHECK IF THAT BOTH SLOT IN PARAMETER EXIST ONLY IN THE BENCH
               --IF YES, THEN CHANGE THEM THERE
               --IF NOT, THEN CHANGE THEN IN THE BENCH AND ARENA RESPECTIVELY
               SELECT   COUNT ( * )
                 INTO   V_COUNT_SLOT_BENCH
                 FROM   CR_PREVIEW_BENCH
                WHERE   SESSION_ID = P_SESSION_ID
                        AND SLOT_NO IN (P_SLOT_NO_1, P_SLOT_NO_2);

               IF V_COUNT_SLOT_BENCH = 2
               THEN
                  SP_CHANGE_SLOT_BENCH (P_SESSION_ID,
                                        P_SLOT_NO_2,
                                        P_HERO_ID_2,
                                        P_STAR_GRADE_2,
                                        P_SLOT_NO_1,
                                        P_HERO_ID_1,
                                        P_STAR_GRADE_1,
                                        P_USERLOGIN);
               ELSE
                  SP_CHANGE_SLOT_BENCH_ARENA (P_SESSION_ID,
                                              P_SLOT_NO_2,
                                              P_HERO_ID_2,
                                              P_STAR_GRADE_2,
                                              P_SLOT_NO_1,
                                              P_HERO_ID_1,
                                              P_STAR_GRADE_1,
                                              P_USERLOGIN);
               END IF;
            END IF;
         END IF;
      ELSIF P_STAR_GRADE_2 = 3 AND P_STAR_GRADE_1 = 2
      THEN
         --CHECK IF THE SLOT IS EXIST IN THE ARENA, THEN UPGRADE THERE
         --IF NOT, CHECK IF THE SLOT IS EXIST IN THE BENCH, THEN UPGRADE THERE
         SELECT   COUNT ( * )
           INTO   V_COUNT_SLOT_ARENA
           FROM   CR_PREVIEW_ARENA
          WHERE   SESSION_ID = P_SESSION_ID AND SLOT_NO = P_SLOT_NO_1;

         IF V_COUNT_SLOT_ARENA > 0
         THEN
            SP_UPD_SLOT_ARENA (P_SESSION_ID,
                               P_SLOT_NO_1,
                               P_HERO_ID_1,
                               P_STAR_GRADE_1 + 1,
                               P_USERLOGIN);
         ELSE
            SELECT   COUNT ( * )
              INTO   V_COUNT_SLOT_BENCH
              FROM   CR_PREVIEW_BENCH
             WHERE   SESSION_ID = P_SESSION_ID AND SLOT_NO = P_SLOT_NO_1;

            IF V_COUNT_SLOT_BENCH > 0
            THEN
               SP_UPD_SLOT_BENCH (P_SESSION_ID,
                                  P_SLOT_NO_1,
                                  P_HERO_ID_1,
                                  P_STAR_GRADE_1 + 1,
                                  P_USERLOGIN);
            END IF;
         END IF;

         --REMOVE THE GURRU SLOT
         SELECT   COUNT ( * )
           INTO   V_COUNT_SLOT_ARENA
           FROM   CR_PREVIEW_ARENA
          WHERE       SESSION_ID = P_SESSION_ID
                  AND SLOT_NO = P_SLOT_NO_2
                  AND HERO_ID = 17;

         IF V_COUNT_SLOT_ARENA > 0
         THEN
            SP_UPD_SLOT_ARENA (P_SESSION_ID,
                               P_SLOT_NO_2,
                               NULL,
                               NULL,
                               P_USERLOGIN);
         ELSE
            SELECT   COUNT ( * )
              INTO   V_COUNT_SLOT_BENCH
              FROM   CR_PREVIEW_BENCH
             WHERE       SESSION_ID = P_SESSION_ID
                     AND SLOT_NO = P_SLOT_NO_2
                     AND HERO_ID = 17;

            IF V_COUNT_SLOT_BENCH > 0
            THEN
               SP_UPD_SLOT_BENCH (P_SESSION_ID,
                                  P_SLOT_NO_2,
                                  NULL,
                                  NULL,
                                  P_USERLOGIN);
            END IF;
         END IF;
      ELSE
         --CHECK IF THAT TWO SLOT IN PARAMETER EXIST ONLY IN THE ARENA
         --IF YES, THEN CHANGE THEM THERE
         --IF NOT, THEN CHANGE THEN IN THE BENCH AND ARENA RESPECTIVELY
         SELECT   COUNT ( * )
           INTO   V_COUNT_SLOT_ARENA
           FROM   CR_PREVIEW_ARENA
          WHERE   SESSION_ID = P_SESSION_ID
                  AND SLOT_NO IN (P_SLOT_NO_1, P_SLOT_NO_2);

         IF V_COUNT_SLOT_ARENA = 2
         THEN
            SP_CHANGE_SLOT_ARENA (P_SESSION_ID,
                                  P_SLOT_NO_2,
                                  P_HERO_ID_1,
                                  P_STAR_GRADE_1,
                                  P_SLOT_NO_1,
                                  P_HERO_ID_2,
                                  P_STAR_GRADE_2,
                                  P_USERLOGIN);
         ELSE
            --CHECK IF THAT TWO SLOT IN PARAMETER EXIST ONLY IN THE BENCH
            --IF YES, THEN CHANGE THEM THERE
            SELECT   COUNT ( * )
              INTO   V_COUNT_SLOT_BENCH
              FROM   CR_PREVIEW_BENCH
             WHERE   SESSION_ID = P_SESSION_ID
                     AND SLOT_NO IN (P_SLOT_NO_1, P_SLOT_NO_2);

            IF V_COUNT_SLOT_BENCH = 2
            THEN
               SP_CHANGE_SLOT_BENCH (P_SESSION_ID,
                                     P_SLOT_NO_2,
                                     P_HERO_ID_1,
                                     P_STAR_GRADE_1,
                                     P_SLOT_NO_1,
                                     P_HERO_ID_2,
                                     P_STAR_GRADE_2,
                                     P_USERLOGIN);
            ELSE
               SP_CHANGE_SLOT_BENCH_ARENA (P_SESSION_ID,
                                           P_SLOT_NO_2,
                                           P_HERO_ID_1,
                                           P_STAR_GRADE_1,
                                           P_SLOT_NO_1,
                                           P_HERO_ID_2,
                                           P_STAR_GRADE_2,
                                           P_USERLOGIN);
            END IF;
         END IF;
      END IF;
   END IF;

   COMMIT;
END;
/


