/* Formatted on 21/02/2023 21:52:00 (QP5 v5.114.809.3010) */
CREATE OR REPLACE FORCE VIEW USER_CHESSRUSH.V_PREVIEW_COMBINE_HERO_CLASS
(
   SESSION_ID,
   CLASS_ID,
   CLASS_NAME,
   CLASS_AMOUNT
)
AS
     SELECT   SESSION_ID,
              CLASS_ID,
              CLASS_NAME,
              COUNT (CLASS_ID) AS CLASS_AMOUNT
       FROM   (  SELECT   A.SESSION_ID,
                          A.CLASS_ID,
                          A.CLASS_NAME,
                          A.HERO_ID
                   FROM   V_PREVIEW_COMBINE_HERO A
                  WHERE   A.CLASS_ID IS NOT NULL
               GROUP BY   A.SESSION_ID,
                          A.CLASS_ID,
                          A.CLASS_NAME,
                          A.HERO_ID)
   GROUP BY   SESSION_ID, CLASS_ID, CLASS_NAME;


