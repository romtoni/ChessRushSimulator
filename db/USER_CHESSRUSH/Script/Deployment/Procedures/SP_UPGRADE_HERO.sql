CREATE OR REPLACE PROCEDURE USER_CHESSRUSH.SP_UPGRADE_HERO (
   P_SESSION_ID    NUMBER,
   P_USERLOGIN     VARCHAR2
)
IS
   V_SLOT_NO            NUMBER;
   V_HERO_ID            NUMBER;
   V_STAR_GRADE_OLD     NUMBER;
   V_STAR_GRADE_NEW     NUMBER;
   V_HERO_AMOUNT_GONE   NUMBER;
BEGIN
   FOR I IN (SELECT   SESSION_ID,
                      FLAG_SLOT,
                      SLOT_NO,
                      HERO_ID,
                      STAR_GRADE_OLD,
                      STAR_GRADE_NEW,
                      HERO_AMOUNT_GONE
               FROM   V_PREVIEW_COMBINE_UPGRADE_SLOT
              WHERE   SESSION_ID = P_SESSION_ID)
   LOOP
      --UPDATE NEW STAR GRADE OF HERO IN THE LAST SLOT NUMBER
      IF I.FLAG_SLOT = 'ARENA'
      THEN
         UPDATE   CR_PREVIEW_ARENA
            SET   STAR_GRADE = I.STAR_GRADE_NEW,
                  DATE_MODIFY = SYSDATE,
                  USER_MODIFY = P_USERLOGIN
          WHERE       SLOT_NO = I.SLOT_NO
                  AND HERO_ID = I.HERO_ID
                  AND STAR_GRADE = I.STAR_GRADE_OLD;
      END IF;

      IF I.FLAG_SLOT = 'BENCH'
      THEN
         UPDATE   CR_PREVIEW_BENCH
            SET   STAR_GRADE = I.STAR_GRADE_NEW,
                  DATE_MODIFY = SYSDATE,
                  USER_MODIFY = P_USERLOGIN
          WHERE       SLOT_NO = I.SLOT_NO
                  AND HERO_ID = I.HERO_ID
                  AND STAR_GRADE = I.STAR_GRADE_OLD;
      END IF;

      --EMPTY THE HERO SLOT THAT REQUIRED FOR UPGRADE
      FOR J
      IN (SELECT   SESSION_ID,
                   FLAG_SLOT,
                   SLOT_NO,
                   HERO_ID,
                   STAR_GRADE
            FROM   (SELECT   SESSION_ID,
                             FLAG_SLOT,
                             SLOT_NO,
                             HERO_ID,
                             STAR_GRADE
                      FROM   (  SELECT   SESSION_ID,
                                         FLAG_SLOT,
                                         SLOT_NO,
                                         HERO_ID,
                                         STAR_GRADE
                                  FROM   (SELECT   SESSION_ID,
                                                   'ARENA' AS FLAG_SLOT,
                                                   SLOT_NO,
                                                   HERO_ID,
                                                   STAR_GRADE
                                            FROM   CR_PREVIEW_ARENA
                                          UNION
                                          SELECT   SESSION_ID,
                                                   'BENCH' AS FLAG_SLOT,
                                                   SLOT_NO,
                                                   HERO_ID,
                                                   STAR_GRADE
                                            FROM   CR_PREVIEW_BENCH)
                              ORDER BY   SLOT_NO DESC)
                     WHERE       HERO_ID = I.HERO_ID
                             AND STAR_GRADE = I.STAR_GRADE_OLD
                             AND ROWNUM <= I.HERO_AMOUNT_GONE-1)
           WHERE   SLOT_NO NOT IN (I.SLOT_NO))
      LOOP
         --EMPTY HERO SLOT
         IF J.FLAG_SLOT = 'ARENA'
         THEN
            UPDATE   CR_PREVIEW_ARENA
               SET   HERO_ID = NULL,
                     STAR_GRADE = NULL,
                     DATE_MODIFY = SYSDATE,
                     USER_MODIFY = P_USERLOGIN
             WHERE       SLOT_NO = J.SLOT_NO
                     AND HERO_ID = J.HERO_ID
                     AND STAR_GRADE = J.STAR_GRADE;
         END IF;

         IF J.FLAG_SLOT = 'BENCH'
         THEN
            UPDATE   CR_PREVIEW_BENCH
               SET   HERO_ID = NULL,
                     STAR_GRADE = NULL,
                     DATE_MODIFY = SYSDATE,
                     USER_MODIFY = P_USERLOGIN
             WHERE       SLOT_NO = J.SLOT_NO
                     AND HERO_ID = J.HERO_ID
                     AND STAR_GRADE = J.STAR_GRADE;
         END IF;
      END LOOP;
   END LOOP;

   COMMIT;
END;
/


