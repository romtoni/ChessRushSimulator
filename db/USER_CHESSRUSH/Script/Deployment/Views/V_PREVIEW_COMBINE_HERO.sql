/* Formatted on 21/02/2023 21:51:59 (QP5 v5.114.809.3010) */
CREATE OR REPLACE FORCE VIEW USER_CHESSRUSH.V_PREVIEW_COMBINE_HERO
(
   SESSION_ID,
   HERO_ID,
   HERO_NAME,
   STAR_GRADE,
   RACE_ID,
   RACE_NAME,
   CLASS_ID,
   CLASS_NAME,
   MANA_CRYSTAL,
   HERO_AMOUNT,
   TOTAL_MANA_CRYSTAL
)
AS
     SELECT   A.SESSION_ID,
              A.HERO_ID,
              B.HERO_NAME,
              A.STAR_GRADE,
              B.RACE_ID,
              B.RACE_NAME,
              B.CLASS_ID,
              B.CLASS_NAME,
              B.MANA_CRYSTAL,
              COUNT ( * ) AS HERO_AMOUNT,
              (B.MANA_CRYSTAL * COUNT ( * )) AS TOTAL_MANA_CRYSTAL
       FROM      (SELECT   SESSION_ID,
                           SLOT_NO,
                           HERO_ID,
                           STAR_GRADE
                    FROM   (SELECT   SESSION_ID,
                                     SLOT_NO,
                                     HERO_ID,
                                     STAR_GRADE
                              FROM   CR_PREVIEW_ARENA
                            UNION ALL
                            SELECT   SESSION_ID,
                                     SLOT_NO,
                                     HERO_ID,
                                     STAR_GRADE
                              FROM   CR_PREVIEW_BENCH)
                   WHERE   HERO_ID IS NOT NULL) A
              LEFT JOIN
                 V_MST_HERO_PROFILE B
              ON B.HERO_ID = A.HERO_ID AND B.STAR_GRADE = A.STAR_GRADE
   GROUP BY   A.SESSION_ID,
              A.HERO_ID,
              B.HERO_NAME,
              A.STAR_GRADE,
              B.RACE_ID,
              B.RACE_NAME,
              B.CLASS_ID,
              B.CLASS_NAME,
              B.MANA_CRYSTAL
   UNION
     SELECT   A.SESSION_ID,
              A.HERO_ID,
              B.HERO_NAME,
              A.STAR_GRADE,
              B.RACE_ID_ALT AS RACE_ID,
              B.RACE_NAME_ALT AS RACE_NAME,
              B.CLASS_ID_ALT AS CLASS_ID_,
              B.CLASS_NAME_ALT AS CLASS_NAME,
              CASE
                 WHEN B.RACE_ID_ALT IS NULL OR B.CLASS_ID_ALT IS NULL THEN NULL
                 ELSE B.MANA_CRYSTAL
              END
                 AS MANA_CRYSTAL,
              CASE
                 WHEN B.RACE_ID_ALT IS NULL OR B.CLASS_ID_ALT IS NULL THEN NULL
                 ELSE COUNT ( * )
              END
                 AS HERO_AMOUNT,
              CASE
                 WHEN B.RACE_ID_ALT IS NULL OR B.CLASS_ID_ALT IS NULL THEN NULL
                 ELSE (B.MANA_CRYSTAL * COUNT ( * ))
              END
                 AS TOTAL_MANA_CRYSTAL
       FROM      (SELECT   SESSION_ID,
                           SLOT_NO,
                           HERO_ID,
                           STAR_GRADE
                    FROM   (SELECT   SESSION_ID,
                                     SLOT_NO,
                                     HERO_ID,
                                     STAR_GRADE
                              FROM   CR_PREVIEW_ARENA
                            UNION ALL
                            SELECT   SESSION_ID,
                                     SLOT_NO,
                                     HERO_ID,
                                     STAR_GRADE
                              FROM   CR_PREVIEW_BENCH)
                   WHERE   HERO_ID IS NOT NULL) A
              LEFT JOIN
                 V_MST_HERO_PROFILE B
              ON B.HERO_ID = A.HERO_ID AND B.STAR_GRADE = A.STAR_GRADE
   GROUP BY   A.SESSION_ID,
              A.HERO_ID,
              B.HERO_NAME,
              A.STAR_GRADE,
              B.RACE_ID_ALT,
              B.RACE_NAME_ALT,
              B.CLASS_ID_ALT,
              B.CLASS_NAME_ALT,
              B.MANA_CRYSTAL;


