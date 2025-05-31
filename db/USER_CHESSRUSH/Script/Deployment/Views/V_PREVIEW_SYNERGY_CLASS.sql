/* Formatted on 21/02/2023 21:52:04 (QP5 v5.114.809.3010) */
CREATE OR REPLACE FORCE VIEW USER_CHESSRUSH.V_PREVIEW_SYNERGY_CLASS
(
   SESSION_ID,
   CLASS_IMAGE,
   CLASS_IMAGE_BLOB,
   CLASS_ID,
   CLASS_NAME,
   CLASS_AMOUNT,
   SYNERGY_ID,
   SYNERGY_NAME,
   SYNERGY_BENEFIT,
   SYNERGY_EFFECT_NAME
)
AS
     SELECT   Z.SESSION_ID,
              X.CLASS_IMAGE,
              X.CLASS_IMAGE_BLOB,
              Z.CLASS_ID,
              Z.CLASS_NAME,
              Z.CLASS_AMOUNT,
              Y.SYNERGY_ID,
              Y.SYNERGY_NAME,
              Y.SYNERGY_BENEFIT,
              V.SYNERGY_EFFECT_NAME
       FROM            (  SELECT   SESSION_ID,
                                   CLASS_ID,
                                   COUNT (CLASS_ID) AS CLASS_AMOUNT,
                                   CLASS_NAME,
                                   F_PREVIEW_SYNERGY_CLASS (CLASS_ID,
                                                            COUNT (CLASS_ID))
                                      AS SYNERGY_ID
                            FROM   (SELECT   A.SESSION_ID,
                                             A.CLASS_ID,
                                             B.CLASS_NAME
                                      FROM      V_PREVIEW_HERO A
                                             LEFT JOIN
                                                CR_HERO_CLASS B
                                             ON B.CLASS_ID = A.CLASS_ID
                                     WHERE   A.CLASS_ID IS NOT NULL)
                        GROUP BY   SESSION_ID, CLASS_ID, CLASS_NAME) Z
                    LEFT JOIN
                       CR_SYNERGY Y
                    ON Y.SYNERGY_ID = Z.SYNERGY_ID
                 LEFT JOIN
                    CR_HERO_CLASS X
                 ON X.CLASS_ID = Z.CLASS_ID
              LEFT JOIN
                 CR_SYNERGY_EFFECT V
              ON V.SYNERGY_EFFECT_ID = Y.SYNERGY_EFFECT_ID
   ORDER BY   Z.SESSION_ID ASC, Z.CLASS_ID ASC;


