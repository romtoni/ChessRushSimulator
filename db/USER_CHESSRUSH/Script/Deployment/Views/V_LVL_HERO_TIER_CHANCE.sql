/* Formatted on 21/02/2023 21:51:55 (QP5 v5.114.809.3010) */
CREATE OR REPLACE FORCE VIEW USER_CHESSRUSH.V_LVL_HERO_TIER_CHANCE
(
   LEVEL_NO,
   HERO_TIER_1,
   HERO_TIER_CHANCE_1,
   HERO_TIER_2,
   HERO_TIER_CHANCE_2,
   HERO_TIER_3,
   HERO_TIER_CHANCE_3,
   HERO_TIER_4,
   HERO_TIER_CHANCE_4,
   HERO_TIER_5,
   HERO_TIER_CHANCE_5
)
AS
   SELECT   LEVEL_NO,
            HERO_TIER_1,
            DECODE (HERO_TIER_CHANCE_1,
                    0, 0,
                    F_LVL_CHECK_CHANCE (HERO_TIER_CHANCE_1,
                                        HERO_TIER_CHANCE_2,
                                        HERO_TIER_CHANCE_3,
                                        HERO_TIER_CHANCE_4,
                                        HERO_TIER_CHANCE_5))
               AS HERO_TIER_CHANCE_1,
            HERO_TIER_2,
            DECODE (HERO_TIER_CHANCE_2,
                    0, 0,
                    F_LVL_CHECK_CHANCE (HERO_TIER_CHANCE_1,
                                        HERO_TIER_CHANCE_2,
                                        HERO_TIER_CHANCE_3,
                                        HERO_TIER_CHANCE_4,
                                        HERO_TIER_CHANCE_5))
               AS HERO_TIER_CHANCE_2,
            HERO_TIER_3,
            DECODE (HERO_TIER_CHANCE_3,
                    0, 0,
                    F_LVL_CHECK_CHANCE (HERO_TIER_CHANCE_1,
                                        HERO_TIER_CHANCE_2,
                                        HERO_TIER_CHANCE_3,
                                        HERO_TIER_CHANCE_4,
                                        HERO_TIER_CHANCE_5))
               AS HERO_TIER_CHANCE_3,
            HERO_TIER_4,
            DECODE (HERO_TIER_CHANCE_4,
                    0, 0,
                    F_LVL_CHECK_CHANCE (HERO_TIER_CHANCE_1,
                                        HERO_TIER_CHANCE_2,
                                        HERO_TIER_CHANCE_3,
                                        HERO_TIER_CHANCE_4,
                                        HERO_TIER_CHANCE_5))
               AS HERO_TIER_CHANCE_4,
            HERO_TIER_5,
            DECODE (HERO_TIER_CHANCE_5,
                    0, 0,
                    F_LVL_CHECK_CHANCE (HERO_TIER_CHANCE_1,
                                        HERO_TIER_CHANCE_2,
                                        HERO_TIER_CHANCE_3,
                                        HERO_TIER_CHANCE_4,
                                        HERO_TIER_CHANCE_5))
               AS HERO_TIER_CHANCE_5
     FROM   (SELECT   LEVEL_NO,
                      HERO_TIER_1,
                      CASE WHEN HERO_TIER_CHANCE_1 < 0 THEN 0 ELSE 1 END
                         AS HERO_TIER_CHANCE_1,
                      HERO_TIER_2,
                      CASE WHEN HERO_TIER_CHANCE_2 < 0 THEN 0 ELSE 1 END
                         AS HERO_TIER_CHANCE_2,
                      HERO_TIER_3,
                      CASE WHEN HERO_TIER_CHANCE_3 < 0 THEN 0 ELSE 1 END
                         AS HERO_TIER_CHANCE_3,
                      HERO_TIER_4,
                      CASE WHEN HERO_TIER_CHANCE_4 < 0 THEN 0 ELSE 1 END
                         AS HERO_TIER_CHANCE_4,
                      HERO_TIER_5,
                      CASE WHEN HERO_TIER_CHANCE_5 < 0 THEN 0 ELSE 1 END
                         AS HERO_TIER_CHANCE_5
               FROM   (SELECT   LEVEL_NO,
                                HERO_TIER_1,
                                HERO_TIER_2,
                                HERO_TIER_3,
                                HERO_TIER_4,
                                HERO_TIER_5,
                                FLOOR(DBMS_RANDOM.VALUE (
                                         1,
                                         HERO_TIER_CHANCE_1 * 100
                                      ))
                                   AS HERO_TIER_CHANCE_1,
                                FLOOR(DBMS_RANDOM.VALUE (
                                         1,
                                         (HERO_TIER_CHANCE_1
                                          + HERO_TIER_CHANCE_2)
                                         * 100
                                      ))
                                - HERO_TIER_CHANCE_1 * 100
                                   AS HERO_TIER_CHANCE_2,
                                FLOOR(DBMS_RANDOM.VALUE (
                                         1,
                                         (  HERO_TIER_CHANCE_1
                                          + HERO_TIER_CHANCE_2
                                          + HERO_TIER_CHANCE_3)
                                         * 100
                                      ))
                                - (HERO_TIER_CHANCE_1 + HERO_TIER_CHANCE_2)
                                  * 100
                                   AS HERO_TIER_CHANCE_3,
                                FLOOR(DBMS_RANDOM.VALUE (
                                         1,
                                         (  HERO_TIER_CHANCE_1
                                          + HERO_TIER_CHANCE_2
                                          + HERO_TIER_CHANCE_3
                                          + HERO_TIER_CHANCE_4)
                                         * 100
                                      ))
                                - (  HERO_TIER_CHANCE_1
                                   + HERO_TIER_CHANCE_2
                                   + HERO_TIER_CHANCE_3)
                                  * 100
                                   AS HERO_TIER_CHANCE_4,
                                FLOOR(DBMS_RANDOM.VALUE (
                                         1,
                                         (  HERO_TIER_CHANCE_1
                                          + HERO_TIER_CHANCE_2
                                          + HERO_TIER_CHANCE_3
                                          + HERO_TIER_CHANCE_4
                                          + HERO_TIER_CHANCE_5)
                                         * 100
                                      ))
                                - (  HERO_TIER_CHANCE_1
                                   + HERO_TIER_CHANCE_2
                                   + HERO_TIER_CHANCE_3
                                   + HERO_TIER_CHANCE_4)
                                  * 100
                                   AS HERO_TIER_CHANCE_5
                         FROM   CR_LEVEL_RARITY));


