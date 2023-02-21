/* Formatted on 21/02/2023 21:52:01 (QP5 v5.114.809.3010) */
CREATE OR REPLACE FORCE VIEW USER_CHESSRUSH.V_PREVIEW_COMBINE_HERO_RACE
(
   SESSION_ID,
   RACE_ID,
   RACE_NAME,
   RACE_AMOUNT
)
AS
     SELECT   SESSION_ID,
              RACE_ID,
              RACE_NAME,
              COUNT (RACE_ID) AS RACE_AMOUNT
       FROM   (  SELECT   A.SESSION_ID,
                          A.RACE_ID,
                          A.RACE_NAME,
                          A.HERO_ID
                   FROM   V_PREVIEW_COMBINE_HERO A
                  WHERE   A.RACE_ID IS NOT NULL
               GROUP BY   A.SESSION_ID,
                          A.RACE_ID,
                          A.RACE_NAME,
                          A.HERO_ID)
   GROUP BY   SESSION_ID, RACE_ID, RACE_NAME;


