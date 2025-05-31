/* Formatted on 21/02/2023 21:51:57 (QP5 v5.114.809.3010) */
CREATE OR REPLACE FORCE VIEW USER_CHESSRUSH.V_MST_BUILD_HERO
(
   BUILD_ID,
   BUILD_NAME,
   BUILD_VALUE,
   HERO_IMAGE_1,
   HERO_IMAGE_BLOB_1,
   HERO_NAME_1,
   HERO_IMAGE_2,
   HERO_IMAGE_BLOB_2,
   HERO_NAME_2,
   HERO_IMAGE_3,
   HERO_IMAGE_BLOB_3,
   HERO_NAME_3,
   HERO_IMAGE_4,
   HERO_IMAGE_BLOB_4,
   HERO_NAME_4,
   HERO_IMAGE_5,
   HERO_IMAGE_BLOB_5,
   HERO_NAME_5,
   HERO_IMAGE_6,
   HERO_IMAGE_BLOB_6,
   HERO_NAME_6,
   HERO_IMAGE_7,
   HERO_IMAGE_BLOB_7,
   HERO_NAME_7,
   HERO_IMAGE_8,
   HERO_IMAGE_BLOB_8,
   HERO_NAME_8,
   HERO_IMAGE_9,
   HERO_IMAGE_BLOB_9,
   HERO_NAME_9,
   HERO_IMAGE_10,
   HERO_IMAGE_BLOB_10,
   HERO_NAME_10
)
AS
     SELECT   A.BUILD_ID,
              A.BUILD_NAME,
                NVL (B.MANA_CRYSTAL, 0)
              + NVL (C.MANA_CRYSTAL, 0)
              + NVL (D.MANA_CRYSTAL, 0)
              + NVL (E.MANA_CRYSTAL, 0)
              + NVL (F.MANA_CRYSTAL, 0)
              + NVL (G.MANA_CRYSTAL, 0)
              + NVL (H.MANA_CRYSTAL, 0)
              + NVL (I.MANA_CRYSTAL, 0)
              + NVL (J.MANA_CRYSTAL, 0)
              + NVL (K.MANA_CRYSTAL, 0)
                 AS BUILD_VALUE,
              B.HERO_IMAGE AS HERO_IMAGE_1,
              B.HERO_IMAGE_BLOB AS HERO_IMAGE_BLOB_1,
              B.HERO_NAME AS HERO_NAME_1,
              C.HERO_IMAGE AS HERO_IMAGE_2,
              C.HERO_IMAGE_BLOB AS HERO_IMAGE_BLOB_2,
              C.HERO_NAME AS HERO_NAME_2,
              D.HERO_IMAGE AS HERO_IMAGE_3,
              D.HERO_IMAGE_BLOB AS HERO_IMAGE_BLOB_3,
              D.HERO_NAME AS HERO_NAME_3,
              E.HERO_IMAGE AS HERO_IMAGE_4,
              E.HERO_IMAGE_BLOB AS HERO_IMAGE_BLOB_4,
              E.HERO_NAME AS HERO_NAME_4,
              F.HERO_IMAGE AS HERO_IMAGE_5,
              F.HERO_IMAGE_BLOB AS HERO_IMAGE_BLOB_5,
              F.HERO_NAME AS HERO_NAME_5,
              G.HERO_IMAGE AS HERO_IMAGE_6,
              G.HERO_IMAGE_BLOB AS HERO_IMAGE_BLOB_6,
              G.HERO_NAME AS HERO_NAME_6,
              H.HERO_IMAGE AS HERO_IMAGE_7,
              H.HERO_IMAGE_BLOB AS HERO_IMAGE_BLOB_7,
              H.HERO_NAME AS HERO_NAME_7,
              I.HERO_IMAGE AS HERO_IMAGE_8,
              I.HERO_IMAGE_BLOB AS HERO_IMAGE_BLOB_8,
              I.HERO_NAME AS HERO_NAME_8,
              J.HERO_IMAGE AS HERO_IMAGE_9,
              J.HERO_IMAGE_BLOB AS HERO_IMAGE_BLOB_9,
              J.HERO_NAME AS HERO_NAME_9,
              K.HERO_IMAGE AS HERO_IMAGE_10,
              K.HERO_IMAGE_BLOB AS HERO_IMAGE_BLOB_10,
              K.HERO_NAME AS HERO_NAME_10
       FROM                                 CR_SAVE_BUILD_LIST A
                                         LEFT JOIN
                                            V_MST_HERO_PROFILE B
                                         ON B.HERO_ID = A.HERO_ID_1
                                            AND B.STAR_GRADE = A.STAR_GRADE_1
                                      LEFT JOIN
                                         V_MST_HERO_PROFILE C
                                      ON C.HERO_ID = A.HERO_ID_2
                                         AND C.STAR_GRADE = A.STAR_GRADE_2
                                   LEFT JOIN
                                      V_MST_HERO_PROFILE D
                                   ON D.HERO_ID = A.HERO_ID_3
                                      AND D.STAR_GRADE = A.STAR_GRADE_3
                                LEFT JOIN
                                   V_MST_HERO_PROFILE E
                                ON E.HERO_ID = A.HERO_ID_4
                                   AND E.STAR_GRADE = A.STAR_GRADE_4
                             LEFT JOIN
                                V_MST_HERO_PROFILE F
                             ON F.HERO_ID = A.HERO_ID_5
                                AND F.STAR_GRADE = A.STAR_GRADE_5
                          LEFT JOIN
                             V_MST_HERO_PROFILE G
                          ON G.HERO_ID = A.HERO_ID_6
                             AND G.STAR_GRADE = A.STAR_GRADE_6
                       LEFT JOIN
                          V_MST_HERO_PROFILE H
                       ON H.HERO_ID = A.HERO_ID_7
                          AND H.STAR_GRADE = A.STAR_GRADE_7
                    LEFT JOIN
                       V_MST_HERO_PROFILE I
                    ON I.HERO_ID = A.HERO_ID_8
                       AND I.STAR_GRADE = A.STAR_GRADE_8
                 LEFT JOIN
                    V_MST_HERO_PROFILE J
                 ON J.HERO_ID = A.HERO_ID_9 AND J.STAR_GRADE = A.STAR_GRADE_9
              LEFT JOIN
                 V_MST_HERO_PROFILE K
              ON K.HERO_ID = A.HERO_ID_10 AND K.STAR_GRADE = A.STAR_GRADE_10
   ORDER BY   A.BUILD_ID;


