/* Formatted on 21/02/2023 21:52:02 (QP5 v5.114.809.3010) */
CREATE OR REPLACE FORCE VIEW USER_CHESSRUSH.V_PREVIEW_COMBINE_UPGRADE_SLOT
(
   SESSION_ID,
   FLAG_SLOT,
   SLOT_NO,
   HERO_ID,
   HERO_NAME,
   HERO_AMOUNT_BEFORE,
   STAR_GRADE_OLD,
   HERO_AMOUNT_GONE,
   STAR_GRADE_NEW
)
AS
   SELECT   A.SESSION_ID,
            C.FLAG_SLOT,
            A.LAST_SLOT_NO AS SLOT_NO,
            A.HERO_ID,
            B.HERO_NAME,
            B.HERO_AMOUNT_BEFORE,
            B.STAR_GRADE_OLD,
            B.HERO_AMOUNT_GONE,
            B.STAR_GRADE_NEW
     FROM         (  SELECT   SESSION_ID,
                              HERO_ID,
                              STAR_GRADE,
                              MAX (SLOT_NO) AS LAST_SLOT_NO
                       FROM   (SELECT   SESSION_ID,
                                        HERO_ID,
                                        STAR_GRADE,
                                        SLOT_NO
                                 FROM   CR_PREVIEW_ARENA
                               UNION
                               SELECT   SESSION_ID,
                                        HERO_ID,
                                        STAR_GRADE,
                                        SLOT_NO
                                 FROM   CR_PREVIEW_BENCH)
                   GROUP BY   SESSION_ID, HERO_ID, STAR_GRADE
                   ORDER BY   SESSION_ID, HERO_ID) A
               LEFT JOIN
                  V_PREVIEW_COMBINE_UPGRADE_HERO B
               ON     B.SESSION_ID = A.SESSION_ID
                  AND B.HERO_ID = A.HERO_ID
                  AND B.STAR_GRADE_OLD = A.STAR_GRADE
            LEFT JOIN
               (SELECT   'ARENA' AS FLAG_SLOT, SLOT_NO FROM CR_PREVIEW_ARENA
                UNION
                SELECT   'BENCH' AS FLAG_SLOT, SLOT_NO FROM CR_PREVIEW_BENCH)
               C
            ON C.SLOT_NO = A.LAST_SLOT_NO
    WHERE   B.STAR_GRADE_NEW IS NOT NULL;


