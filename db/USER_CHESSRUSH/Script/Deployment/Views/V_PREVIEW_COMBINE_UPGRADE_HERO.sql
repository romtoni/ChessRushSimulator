/* Formatted on 21/02/2023 21:52:02 (QP5 v5.114.809.3010) */
CREATE OR REPLACE FORCE VIEW USER_CHESSRUSH.V_PREVIEW_COMBINE_UPGRADE_HERO
(
   SESSION_ID,
   HERO_ID,
   HERO_NAME,
   STAR_GRADE_OLD,
   HERO_AMOUNT_BEFORE,
   TOTAL_MANA_CRYSTAL_BEFORE,
   STAR_GRADE_NEW,
   HERO_AMOUNT_GONE,
   TOTAL_MANA_CRYSTAL_GONE,
   REST_STAR_GRADE,
   REST_HERO_AMOUNT,
   REST_MANA_CRYSTAL
)
AS
   SELECT   Z.SESSION_ID,
            Z.HERO_ID,
            Z.HERO_NAME,
            Z.STAR_GRADE AS STAR_GRADE_OLD,
            Z.HERO_AMOUNT AS HERO_AMOUNT_BEFORE,
            Z.TOTAL_MANA_CRYSTAL AS TOTAL_MANA_CRYSTAL_BEFORE,
            Z.STAR_UPGRADE AS STAR_GRADE_NEW,
            Z.HERO_AMOUNT_UPGRADE AS HERO_AMOUNT_GONE,
            Z.TOTAL_MANA_CRYSTAL_UPGRADE AS TOTAL_MANA_CRYSTAL_GONE,
            DECODE (
               (Z.TOTAL_MANA_CRYSTAL - Z.TOTAL_MANA_CRYSTAL_UPGRADE),
               0,
               NULL,
               ( (SELECT   STAR_GRADE
                    FROM   V_MST_HERO_PROFILE
                   WHERE   HERO_ID = Z.HERO_ID
                           AND MANA_CRYSTAL =
                                 ( (Z.TOTAL_MANA_CRYSTAL
                                    - Z.TOTAL_MANA_CRYSTAL_UPGRADE)
                                  / (Z.HERO_AMOUNT - Z.HERO_AMOUNT_UPGRADE))))
            )
               AS REST_STAR_GRADE,
            (Z.HERO_AMOUNT - Z.HERO_AMOUNT_UPGRADE) AS REST_HERO_AMOUNT,
            (Z.TOTAL_MANA_CRYSTAL - Z.TOTAL_MANA_CRYSTAL_UPGRADE)
               AS REST_MANA_CRYSTAL
     FROM   (SELECT   A.SESSION_ID,
                      A.HERO_ID,
                      A.HERO_NAME,
                      A.STAR_GRADE,
                      A.HERO_AMOUNT,
                      A.TOTAL_MANA_CRYSTAL,
                      A.STAR_UPGRADE,
                      CASE
                         WHEN A.CLASS_ID = 8 AND C.CLASS_AMOUNT >= 2
                         THEN
                            POWER (3 - 1, (A.STAR_UPGRADE - A.STAR_GRADE))
                         ELSE
                            POWER (3, (A.STAR_UPGRADE - A.STAR_GRADE))
                      END
                         AS HERO_AMOUNT_UPGRADE,
                      CASE
                         WHEN A.CLASS_ID = 8 AND C.CLASS_AMOUNT >= 2
                         THEN
                            B.MANA_CRYSTAL
                            - (1
                               * (SELECT   MANA_CRYSTAL
                                    FROM   V_MST_HERO_PROFILE
                                   WHERE   HERO_ID = A.HERO_ID
                                           AND STAR_GRADE = A.STAR_GRADE))
                         ELSE
                            B.MANA_CRYSTAL
                      END
                         AS TOTAL_MANA_CRYSTAL_UPGRADE
               FROM         (  SELECT   DISTINCT
                                        SESSION_ID,
                                        HERO_ID,
                                        HERO_NAME,
                                        STAR_GRADE,
                                        HERO_AMOUNT,
                                        TOTAL_MANA_CRYSTAL,
                                        F_PREVIEW_COMBINE_HERO (
                                           SESSION_ID,
                                           HERO_ID,
                                           TOTAL_MANA_CRYSTAL,
                                           STAR_GRADE
                                        )
                                           AS STAR_UPGRADE,
                                        CLASS_ID
                                 FROM   V_PREVIEW_COMBINE_HERO
                                WHERE   TOTAL_MANA_CRYSTAL IS NOT NULL
                             ORDER BY   SESSION_ID ASC,
                                        HERO_ID ASC,
                                        STAR_GRADE ASC) A
                         LEFT JOIN
                            V_MST_HERO_PROFILE B
                         ON B.HERO_ID = A.HERO_ID
                            AND B.STAR_GRADE = A.STAR_UPGRADE
                      LEFT JOIN
                         V_PREVIEW_COMBINE_HERO_CLASS C
                      ON C.CLASS_ID = A.CLASS_ID
              WHERE   A.STAR_UPGRADE IS NOT NULL) Z;


