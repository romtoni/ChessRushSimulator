/* Formatted on 21/02/2023 21:52:03 (QP5 v5.114.809.3010) */
CREATE OR REPLACE FORCE VIEW USER_CHESSRUSH.V_PREVIEW_HERO
(
   SESSION_ID,
   HERO_ID,
   HERO_NAME,
   RACE_ID,
   RACE_NAME,
   CLASS_ID,
   CLASS_NAME,
   STAR_GRADE
)
AS
     SELECT   X.SESSION_ID,
              X.HERO_ID,
              X.HERO_NAME,
              X.RACE_ID,
              Y.RACE_NAME,
              X.CLASS_ID,
              Z.CLASS_NAME,
              X.STAR_GRADE
       FROM         (  SELECT   SESSION_ID,
                                HERO_ID,
                                HERO_NAME,
                                RACE_ID,
                                CLASS_ID,
                                MAX (STAR_GRADE) AS STAR_GRADE
                         FROM   (SELECT   A.SESSION_ID,
                                          A.HERO_ID,
                                          B.HERO_NAME,
                                          B.RACE_ID,
                                          B.CLASS_ID,
                                          A.STAR_GRADE
                                   FROM      (SELECT   SESSION_ID,
                                                       HERO_ID,
                                                       STAR_GRADE
                                                FROM   CR_PREVIEW_ARENA
                                              UNION ALL
                                              SELECT   SESSION_ID,
                                                       HERO_ID,
                                                       STAR_GRADE
                                                FROM   CR_PREVIEW_BENCH) A
                                          LEFT JOIN
                                             CR_HERO B
                                          ON B.HERO_ID = A.HERO_ID
                                 UNION
                                 SELECT   A.SESSION_ID,
                                          A.HERO_ID,
                                          B.HERO_NAME,
                                          B.RACE_ID_ALT AS RACE_ID,
                                          B.CLASS_ID_ALT AS CLASS_ID,
                                          A.STAR_GRADE
                                   FROM      (SELECT   SESSION_ID,
                                                       HERO_ID,
                                                       STAR_GRADE
                                                FROM   CR_PREVIEW_ARENA
                                              UNION ALL
                                              SELECT   SESSION_ID,
                                                       HERO_ID,
                                                       STAR_GRADE
                                                FROM   CR_PREVIEW_BENCH) A
                                          LEFT JOIN
                                             CR_HERO B
                                          ON B.HERO_ID = A.HERO_ID)
                     GROUP BY   SESSION_ID,
                                HERO_ID,
                                HERO_NAME,
                                RACE_ID,
                                CLASS_ID) X
                 LEFT JOIN
                    CR_HERO_RACE Y
                 ON Y.RACE_ID = X.RACE_ID
              LEFT JOIN
                 CR_HERO_CLASS Z
              ON Z.CLASS_ID = X.CLASS_ID
      WHERE   X.RACE_ID IS NOT NULL OR X.CLASS_ID IS NOT NULL
   ORDER BY   X.SESSION_ID ASC, DBMS_RANDOM.VALUE;


