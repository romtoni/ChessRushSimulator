CREATE OR REPLACE PROCEDURE USER_CHESSRUSH.SP_CRT_BD_SYNERGY_TMP (
   P_BUILD_ID     NUMBER,
   P_USERLOGIN    VARCHAR2
)
IS
   V_SYNERGY_ID_RACE        NUMBER;
   V_SYNERGY_ID_CLASS       NUMBER;
   V_COUNT_DEMONS           NUMBER;
   V_COUNT_SPECIAL_CLASS    NUMBER;
   V_SPECIAL_CLASS_ID       NUMBER;
   V_SPECIAL_CLASS_AMOUNT   NUMBER;
BEGIN
   --CHECK SYNERGY BY RACE
   FOR I IN (  SELECT   RACE_ID, COUNT ( * ) AS RACE_AMOUNT
                 FROM   V_TMP_BUILD_RACE
                WHERE   BUILD_ID = P_BUILD_ID
             GROUP BY   RACE_ID
             ORDER BY   RACE_ID)
   LOOP
      BEGIN
         SELECT   MAX (SYNERGY_ID)
           INTO   V_SYNERGY_ID_RACE
           FROM   (SELECT   SYNERGY_ID, SYNERGY_NAME, RACE_AMOUNT
                     FROM   CR_SYNERGY
                    WHERE       RACE_ID = I.RACE_ID
                            AND RACE_AMOUNT <= I.RACE_AMOUNT
                            AND RACE_ID NOT IN (0));
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            V_SYNERGY_ID_RACE := NULL;
      END;

      IF V_SYNERGY_ID_RACE IS NOT NULL
      THEN
         INSERT INTO CR_BUILD_DETAIL_SYNERGY_TMP (
                                                     BUILD_ID,
                                                     SYNERGY_ID,
                                                     USER_CREATE
                    )
           VALUES   (P_BUILD_ID, V_SYNERGY_ID_RACE, P_USERLOGIN);
      END IF;
   END LOOP;


   --CHECK SYNERGY BY CLASS
   FOR J IN (  SELECT   CLASS_ID, COUNT ( * ) AS CLASS_AMOUNT
                 FROM   V_TMP_BUILD_CLASS
                WHERE   BUILD_ID = P_BUILD_ID
             GROUP BY   CLASS_ID
             ORDER BY   CLASS_ID)
   LOOP
      BEGIN
         SELECT   MAX (SYNERGY_ID)
           INTO   V_SYNERGY_ID_CLASS
           FROM   (SELECT   SYNERGY_ID, SYNERGY_NAME, CLASS_AMOUNT
                     FROM   CR_SYNERGY
                    WHERE       CLASS_ID = J.CLASS_ID
                            AND CLASS_AMOUNT <= J.CLASS_AMOUNT
                            AND CLASS_ID NOT IN (0));
      EXCEPTION
         WHEN NO_DATA_FOUND
         THEN
            V_SYNERGY_ID_CLASS := NULL;
      END;

      IF V_SYNERGY_ID_CLASS IS NOT NULL
      THEN
         INSERT INTO CR_BUILD_DETAIL_SYNERGY_TMP (
                                                     BUILD_ID,
                                                     SYNERGY_ID,
                                                     USER_CREATE
                    )
           VALUES   (P_BUILD_ID, V_SYNERGY_ID_CLASS, P_USERLOGIN);
      END IF;
   END LOOP;

   --CHECK IF THERE IS 2 DEMONS OR MORE
   --IF THERE IS NO NIGHTINGALE AND THE DEVOURER THEN THE SYNERGY OF DEMON WILL BE GONE
   --ELSE IF THERE IS ONLY NIGHTINGALE OR THE DEVOURER THEN THE SYNERGY OF PUNISHER WILL FORCE TO THE LOWEST
   --ELSE CHECK MORE OF SYNERGY OF PUNISHER
   SELECT   COUNT ( * )
     INTO   V_COUNT_DEMONS
     FROM   CR_BUILD_DETAIL_HERO_TMP
    WHERE   BUILD_ID = P_BUILD_ID
            AND HERO_ID IN (SELECT   HERO_ID
                              FROM   CR_HERO
                             WHERE   RACE_ID = 8);

   IF V_COUNT_DEMONS > 1
   THEN
      SELECT   COUNT ( * )
        INTO   V_COUNT_SPECIAL_CLASS
        FROM   CR_BUILD_DETAIL_HERO_TMP
       WHERE   BUILD_ID = P_BUILD_ID AND HERO_ID IN (31, 43);

      IF V_COUNT_SPECIAL_CLASS = 0
      THEN
         --REMOVE SYNERGY OF DEMONS
         DELETE   CR_BUILD_DETAIL_SYNERGY_TMP
          WHERE   SYNERGY_ID IN (SELECT   SYNERGY_ID
                                   FROM   CR_SYNERGY
                                  WHERE   RACE_ID = 8);
      ELSE
         --CHECK IF THERE ONLY ONE PUNISHER
         SELECT   COUNT ( * )
           INTO   V_COUNT_SPECIAL_CLASS
           FROM   CR_BUILD_DETAIL_HERO_TMP
          WHERE   BUILD_ID = P_BUILD_ID
                  AND ( (HERO_ID IN (31) AND HERO_ID NOT IN (43))
                       OR (HERO_ID IN (43) AND HERO_ID NOT IN (31)));

         IF V_COUNT_SPECIAL_CLASS = 1
         THEN
            --REMOVE SYNERGY OF DEMONS
            DELETE   CR_BUILD_DETAIL_SYNERGY_TMP
             WHERE   SYNERGY_ID IN (SELECT   SYNERGY_ID
                                      FROM   CR_SYNERGY
                                     WHERE   RACE_ID = 8);

            --TAKE THE LOWEST SYNERGY OF PUNISHER
            SELECT   MIN (SYNERGY_ID)
              INTO   V_SYNERGY_ID_CLASS
              FROM   (SELECT   SYNERGY_ID, SYNERGY_NAME, CLASS_AMOUNT
                        FROM   CR_SYNERGY
                       WHERE   CLASS_ID = (SELECT   DISTINCT CLASS_ID
                                             FROM   CR_HERO
                                            WHERE   HERO_ID IN (31, 43)));

            --REMOVE ALL SYNERGY OF PUNISHER BEFORE
            DELETE FROM   CR_BUILD_DETAIL_SYNERGY_TMP
                  WHERE   SYNERGY_ID IN
                                (SELECT   SYNERGY_ID
                                   FROM   CR_SYNERGY
                                  WHERE   CLASS_ID =
                                             (SELECT   DISTINCT CLASS_ID
                                                FROM   CR_HERO
                                               WHERE   HERO_ID IN (31, 43)));

            --INSERT THE LOWEST SYNERGY OF PUNISHER
            INSERT INTO CR_BUILD_DETAIL_SYNERGY_TMP (
                                                        BUILD_ID,
                                                        SYNERGY_ID,
                                                        USER_CREATE
                       )
              VALUES   (P_BUILD_ID, V_SYNERGY_ID_CLASS, P_USERLOGIN);
         ELSE
              SELECT   CLASS_ID, COUNT ( * )
                INTO   V_SPECIAL_CLASS_ID, V_SPECIAL_CLASS_AMOUNT
                FROM   V_TMP_BUILD_CLASS_SPECIAL
               WHERE   BUILD_ID = P_BUILD_ID
            GROUP BY   CLASS_ID
            ORDER BY   CLASS_ID;

            BEGIN
               SELECT   MAX (SYNERGY_ID)
                 INTO   V_SYNERGY_ID_CLASS
                 FROM   (SELECT   SYNERGY_ID, SYNERGY_NAME, CLASS_AMOUNT
                           FROM   CR_SYNERGY
                          WHERE   CLASS_ID = V_SPECIAL_CLASS_ID
                                  AND CLASS_AMOUNT <= V_SPECIAL_CLASS_AMOUNT);
            EXCEPTION
               WHEN NO_DATA_FOUND
               THEN
                  V_SYNERGY_ID_CLASS := NULL;
            END;

            IF V_SYNERGY_ID_CLASS IS NOT NULL
            THEN
               --NEGATE LOWER SYNERGY OF PUNISHER
               DELETE FROM   CR_BUILD_DETAIL_SYNERGY_TMP
                     WHERE   SYNERGY_ID IN
                                   (SELECT   SYNERGY_ID
                                      FROM   CR_SYNERGY
                                     WHERE   CLASS_ID = V_SPECIAL_CLASS_ID
                                             AND CLASS_AMOUNT <=
                                                   V_SPECIAL_CLASS_AMOUNT
                                             AND SYNERGY_ID NOT IN
                                                      (V_SYNERGY_ID_CLASS));

               --INSERT THE HIGHER SYNERGY OF PUNISHER
               INSERT INTO CR_BUILD_DETAIL_SYNERGY_TMP (
                                                           BUILD_ID,
                                                           SYNERGY_ID,
                                                           USER_CREATE
                          )
                 VALUES   (P_BUILD_ID, V_SYNERGY_ID_CLASS, P_USERLOGIN);
            END IF;
         END IF;
      END IF;
   END IF;



   COMMIT;
END;
/


