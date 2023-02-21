/* Formatted on 21/02/2023 21:52:06 (QP5 v5.114.809.3010) */
CREATE OR REPLACE FORCE VIEW USER_CHESSRUSH.V_TMP_BUILD_CLASS
(
   BUILD_ID,
   BUILD_NAME,
   BUILD_CREATOR,
   HERO_ID,
   CLASS_ID,
   CLASS_NAME
)
AS
   SELECT   C.BUILD_ID,
            C.BUILD_NAME,
            C.USER_CREATE AS BUILD_CREATOR,
            A.HERO_ID,
            B.CLASS_ID,
            D.CLASS_NAME
     FROM            CR_BUILD_DETAIL_HERO_TMP A
                  LEFT JOIN
                     CR_HERO B
                  ON B.HERO_ID = A.HERO_ID
               LEFT JOIN
                  CR_BUILD_LIST_TMP C
               ON C.BUILD_ID = A.BUILD_ID
            LEFT JOIN
               CR_HERO_CLASS D
            ON D.CLASS_ID = B.CLASS_ID
   UNION
   SELECT   C.BUILD_ID,
            C.BUILD_NAME,
            C.USER_CREATE AS BUILD_CREATOR,
            A.HERO_ID,
            B.CLASS_ID_ALT,
            D.CLASS_NAME
     FROM            CR_BUILD_DETAIL_HERO_TMP A
                  LEFT JOIN
                     CR_HERO B
                  ON B.HERO_ID = A.HERO_ID
               LEFT JOIN
                  CR_BUILD_LIST_TMP C
               ON C.BUILD_ID = A.BUILD_ID
            LEFT JOIN
               CR_HERO_CLASS D
            ON D.CLASS_ID = B.CLASS_ID_ALT
    WHERE   A.HERO_ID NOT IN (SELECT   HERO_ID
                                FROM   CR_HERO
                               WHERE   CLASS_ID_ALT = 9);


