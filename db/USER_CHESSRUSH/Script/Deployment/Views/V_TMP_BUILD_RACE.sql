/* Formatted on 21/02/2023 21:52:07 (QP5 v5.114.809.3010) */
CREATE OR REPLACE FORCE VIEW USER_CHESSRUSH.V_TMP_BUILD_RACE
(
   BUILD_ID,
   BUILD_NAME,
   BUILD_CREATOR,
   HERO_ID,
   RACE_ID,
   RACE_NAME
)
AS
   SELECT   C.BUILD_ID,
            C.BUILD_NAME,
            C.USER_CREATE AS BUILD_CREATOR,
            A.HERO_ID,
            B.RACE_ID,
            D.RACE_NAME
     FROM            CR_BUILD_DETAIL_HERO_TMP A
                  LEFT JOIN
                     CR_HERO B
                  ON B.HERO_ID = A.HERO_ID
               LEFT JOIN
                  CR_BUILD_LIST_TMP C
               ON C.BUILD_ID = A.BUILD_ID
            LEFT JOIN
               CR_HERO_RACE D
            ON D.RACE_ID = B.RACE_ID
   UNION
   SELECT   C.BUILD_ID,
            C.BUILD_NAME,
            C.USER_CREATE AS BUILD_CREATOR,
            A.HERO_ID,
            B.RACE_ID_ALT,
            D.RACE_NAME
     FROM            CR_BUILD_DETAIL_HERO_TMP A
                  LEFT JOIN
                     CR_HERO B
                  ON B.HERO_ID = A.HERO_ID
               LEFT JOIN
                  CR_BUILD_LIST_TMP C
               ON C.BUILD_ID = A.BUILD_ID
            LEFT JOIN
               CR_HERO_RACE D
            ON D.RACE_ID = B.RACE_ID_ALT;


