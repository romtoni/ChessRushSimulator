/* Formatted on 21/02/2023 21:51:58 (QP5 v5.114.809.3010) */
CREATE OR REPLACE FORCE VIEW USER_CHESSRUSH.V_MST_HERO_PROFILE
(
   HERO_ID,
   STAR_GRADE,
   HERO_STATUS_NAME,
   HERO_IMAGE,
   HERO_IMAGE_BLOB,
   HERO_IMAGE_ARENA,
   HERO_IMAGE_ARENA_BLOB,
   HERO_NAME,
   RACE_ID,
   RACE_NAME,
   RACE_ID_ALT,
   RACE_NAME_ALT,
   CLASS_ID,
   CLASS_NAME,
   CLASS_ID_ALT,
   CLASS_NAME_ALT,
   HERO_TIER_ID,
   HERO_TIER_NAME,
   ITEM_NAME_REC_1,
   ITEM_NAME_REC_2,
   ITEM_NAME_REC_3,
   MANA_CRYSTAL,
   HERO_TAGLINE_ENTRANCE,
   HERO_TAGLINE_WINNING,
   HERO_SKILL_TYPE_NAME,
   HERO_SKILL_ICON,
   HERO_SKILL_ICON_BLOB,
   HERO_SKILL_NAME,
   HERO_SKILL_DESCRIPTION,
   HEALTH_POINT,
   ARMOR_LEVEL,
   MAGIC_RESIST,
   ATTACK_DAMAGE,
   ATTACK_SPEED,
   ATTACK_RANGE
)
AS
     SELECT   Z.HERO_ID,
              Z.STAR_GRADE,
              I.HERO_STATUS_NAME,
              Y.HERO_IMAGE,
              Y.HERO_IMAGE_BLOB,
              Y.HERO_IMAGE_ARENA,
              Y.HERO_IMAGE_ARENA_BLOB,
              A.HERO_NAME,
              A.RACE_ID,
              B.RACE_NAME,
              A.RACE_ID_ALT,
              C.RACE_NAME AS RACE_NAME_ALT,
              A.CLASS_ID,
              D.CLASS_NAME,
              A.CLASS_ID_ALT,
              E.CLASS_NAME AS CLASS_NAME_ALT,
              A.HERO_TIER_ID,
              G.HERO_TIER_NAME,
              K.ITEM_NAME AS ITEM_NAME_REC_1,
              L.ITEM_NAME AS ITEM_NAME_REC_2,
              M.ITEM_NAME AS ITEM_NAME_REC_3,
              G.MANA_CRYSTAL * DECODE (Z.STAR_GRADE, 3, 9, 2, 3, 1)
                 AS MANA_CRYSTAL,
              H.HERO_TAGLINE_ENTRANCE,
              H.HERO_TAGLINE_WINNING,
              J.SKILL_TYPE_NAME AS HERO_SKILL_TYPE_NAME,
              F.HERO_SKILL_ICON,
              F.HERO_SKILL_ICON_BLOB,
              F.HERO_SKILL_NAME,
              F.HERO_SKILL_DESCRIPTION,
              Z.HEALTH_POINT,
              Z.ARMOR_LEVEL,
              Z.MAGIC_RESIST,
              Z.ATTACK_DAMAGE,
              Z.ATTACK_SPEED,
              Z.ATTACK_RANGE
       FROM                                             CR_HERO_STAT Z
                                                     LEFT JOIN
                                                        CR_HERO_PHOTO Y
                                                     ON Y.HERO_ID = Z.HERO_ID
                                                        AND Y.STAR_GRADE =
                                                              Z.STAR_GRADE
                                                  LEFT JOIN
                                                     CR_HERO A
                                                  ON A.HERO_ID = Z.HERO_ID
                                               LEFT JOIN
                                                  CR_HERO_RACE B
                                               ON B.RACE_ID = A.RACE_ID
                                            LEFT JOIN
                                               CR_HERO_RACE C
                                            ON C.RACE_ID = A.RACE_ID_ALT
                                         LEFT JOIN
                                            CR_HERO_CLASS D
                                         ON D.CLASS_ID = A.CLASS_ID
                                      LEFT JOIN
                                         CR_HERO_CLASS E
                                      ON E.CLASS_ID = A.CLASS_ID_ALT
                                   LEFT JOIN
                                      CR_HERO_SKILL F
                                   ON F.HERO_ID = A.HERO_ID
                                LEFT JOIN
                                   CR_HERO_TIER G
                                ON G.HERO_TIER_ID = A.HERO_TIER_ID
                             LEFT JOIN
                                CR_HERO_TAGLINE H
                             ON H.HERO_TAGLINE_ID = A.HERO_TAGLINE_ID
                          LEFT JOIN
                             CR_HERO_STATUS I
                          ON I.HERO_STATUS_CODE = A.HERO_STATUS_CODE
                       LEFT JOIN
                          CR_HERO_SKILL_TYPE J
                       ON J.SKILL_TYPE_ID = F.HERO_SKILL_TYPE_ID
                    LEFT JOIN
                       CR_ITEM K
                    ON K.ITEM_ID = A.ITEM_ID_REC_1
                 LEFT JOIN
                    CR_ITEM L
                 ON L.ITEM_ID = A.ITEM_ID_REC_2
              LEFT JOIN
                 CR_ITEM M
              ON M.ITEM_ID = A.ITEM_ID_REC_3
   ORDER BY   Z.HERO_ID ASC, Z.STAR_GRADE ASC;


