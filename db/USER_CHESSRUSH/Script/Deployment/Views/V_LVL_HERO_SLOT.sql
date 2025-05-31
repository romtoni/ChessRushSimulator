/* Formatted on 21/02/2023 21:51:54 (QP5 v5.114.809.3010) */
CREATE OR REPLACE FORCE VIEW USER_CHESSRUSH.V_LVL_HERO_SLOT
(
   LEVEL_NO,
   HERO_SLOT_1,
   HERO_TIER_NAME_1,
   HERO_IMAGE_1,
   HERO_IMAGE_BLOB_1,
   HERO_NAME_1,
   HERO_MANA_CRYSTAL_1,
   HERO_SLOT_2,
   HERO_TIER_NAME_2,
   HERO_IMAGE_2,
   HERO_IMAGE_BLOB_2,
   HERO_NAME_2,
   HERO_MANA_CRYSTAL_2,
   HERO_SLOT_3,
   HERO_TIER_NAME_3,
   HERO_IMAGE_3,
   HERO_IMAGE_BLOB_3,
   HERO_NAME_3,
   HERO_MANA_CRYSTAL_3,
   HERO_SLOT_4,
   HERO_TIER_NAME_4,
   HERO_IMAGE_4,
   HERO_IMAGE_BLOB_4,
   HERO_NAME_4,
   HERO_MANA_CRYSTAL_4,
   HERO_SLOT_5,
   HERO_TIER_NAME_5,
   HERO_IMAGE_5,
   HERO_IMAGE_BLOB_5,
   HERO_NAME_5,
   HERO_MANA_CRYSTAL_5
)
AS
     SELECT   A.LEVEL_NO,
              A.HERO_SLOT_1,
              B.HERO_TIER_NAME AS HERO_TIER_NAME_1,
              B.HERO_IMAGE AS HERO_IMAGE_1,
              B.HERO_IMAGE_BLOB AS HERO_IMAGE_BLOB_1,
              B.HERO_NAME AS HERO_NAME_1,
              B.MANA_CRYSTAL AS HERO_MANA_CRYSTAL_1,
              A.HERO_SLOT_2,
              C.HERO_TIER_NAME AS HERO_TIER_NAME_2,
              C.HERO_IMAGE AS HERO_IMAGE_2,
              C.HERO_IMAGE_BLOB AS HERO_IMAGE_BLOB_2,
              C.HERO_NAME AS HERO_NAME_2,
              C.MANA_CRYSTAL AS HERO_MANA_CRYSTAL_2,
              A.HERO_SLOT_3,
              D.HERO_TIER_NAME AS HERO_TIER_NAME_3,
              D.HERO_IMAGE AS HERO_IMAGE_3,
              D.HERO_IMAGE_BLOB AS HERO_IMAGE_BLOB_3,
              D.HERO_NAME AS HERO_NAME_3,
              D.MANA_CRYSTAL AS HERO_MANA_CRYSTAL_3,
              A.HERO_SLOT_4,
              E.HERO_TIER_NAME AS HERO_TIER_NAME_4,
              E.HERO_IMAGE AS HERO_IMAGE_4,
              E.HERO_IMAGE_BLOB AS HERO_IMAGE_BLOB_4,
              E.HERO_NAME AS HERO_NAME_4,
              E.MANA_CRYSTAL AS HERO_MANA_CRYSTAL_4,
              A.HERO_SLOT_5,
              F.HERO_TIER_NAME AS HERO_TIER_NAME_5,
              F.HERO_IMAGE AS HERO_IMAGE_5,
              F.HERO_IMAGE_BLOB AS HERO_IMAGE_BLOB_5,
              F.HERO_NAME AS HERO_NAME_5,
              F.MANA_CRYSTAL AS HERO_MANA_CRYSTAL_5
       FROM                  (SELECT   LEVEL_NO,
                                       F_LVL_CHECK_HERO_SLOT_CHANCE (
                                          HERO_TIER_SLOT_1
                                       )
                                          AS HERO_SLOT_1,
                                       F_LVL_CHECK_HERO_SLOT_CHANCE (
                                          HERO_TIER_SLOT_2
                                       )
                                          AS HERO_SLOT_2,
                                       F_LVL_CHECK_HERO_SLOT_CHANCE (
                                          HERO_TIER_SLOT_3
                                       )
                                          AS HERO_SLOT_3,
                                       F_LVL_CHECK_HERO_SLOT_CHANCE (
                                          HERO_TIER_SLOT_4
                                       )
                                          AS HERO_SLOT_4,
                                       F_LVL_CHECK_HERO_SLOT_CHANCE (
                                          HERO_TIER_SLOT_5
                                       )
                                          AS HERO_SLOT_5
                                FROM   V_LVL_HERO_TIER_SLOT) A
                          LEFT JOIN
                             V_MST_HERO_PROFILE B
                          ON B.HERO_ID = A.HERO_SLOT_1 AND B.STAR_GRADE = 1
                       LEFT JOIN
                          V_MST_HERO_PROFILE C
                       ON C.HERO_ID = A.HERO_SLOT_2 AND C.STAR_GRADE = 1
                    LEFT JOIN
                       V_MST_HERO_PROFILE D
                    ON D.HERO_ID = A.HERO_SLOT_3 AND D.STAR_GRADE = 1
                 LEFT JOIN
                    V_MST_HERO_PROFILE E
                 ON E.HERO_ID = A.HERO_SLOT_4 AND E.STAR_GRADE = 1
              LEFT JOIN
                 V_MST_HERO_PROFILE F
              ON F.HERO_ID = A.HERO_SLOT_5 AND F.STAR_GRADE = 1
   ORDER BY   LEVEL_NO ASC;


