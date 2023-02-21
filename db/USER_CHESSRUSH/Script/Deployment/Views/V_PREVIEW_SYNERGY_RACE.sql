/* Formatted on 21/02/2023 21:52:05 (QP5 v5.114.809.3010) */
CREATE OR REPLACE FORCE VIEW USER_CHESSRUSH.V_PREVIEW_SYNERGY_RACE
(
   SESSION_ID,
   RACE_IMAGE,
   RACE_IMAGE_BLOB,
   RACE_ID,
   RACE_NAME,
   RACE_AMOUNT,
   SYNERGY_ID,
   SYNERGY_NAME,
   SYNERGY_BENEFIT,
   SYNERGY_EFFECT_NAME
)
AS
     SELECT   Z.SESSION_ID,
              X.RACE_IMAGE,
              X.RACE_IMAGE_BLOB,
              Z.RACE_ID,
              Z.RACE_NAME,
              Z.RACE_AMOUNT,
              Y.SYNERGY_ID,
              Y.SYNERGY_NAME,
              Y.SYNERGY_BENEFIT,
              V.SYNERGY_EFFECT_NAME
       FROM            (  SELECT   SESSION_ID,
                                   RACE_ID,
                                   COUNT (RACE_ID) AS RACE_AMOUNT,
                                   RACE_NAME,
                                   F_PREVIEW_SYNERGY_RACE (RACE_ID,
                                                           COUNT (RACE_ID))
                                      AS SYNERGY_ID
                            FROM   (SELECT   A.SESSION_ID, A.RACE_ID, B.RACE_NAME
                                      FROM      V_PREVIEW_HERO A
                                             LEFT JOIN
                                                CR_HERO_RACE B
                                             ON B.RACE_ID = A.RACE_ID
                                     WHERE   A.RACE_ID IS NOT NULL)
                        GROUP BY   SESSION_ID, RACE_ID, RACE_NAME) Z
                    LEFT JOIN
                       CR_SYNERGY Y
                    ON Y.SYNERGY_ID = Z.SYNERGY_ID
                 LEFT JOIN
                    CR_HERO_RACE X
                 ON X.RACE_ID = Z.RACE_ID
              LEFT JOIN
                 CR_SYNERGY_EFFECT V
              ON V.SYNERGY_EFFECT_ID = Y.SYNERGY_EFFECT_ID
   ORDER BY   Z.SESSION_ID ASC, Z.RACE_ID ASC;


