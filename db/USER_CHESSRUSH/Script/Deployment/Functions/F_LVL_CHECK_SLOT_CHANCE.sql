CREATE OR REPLACE FUNCTION USER_CHESSRUSH.F_LVL_CHECK_SLOT_CHANCE (
   P_HERO_TIER_SLOT_1    NUMBER,
   P_HERO_TIER_SLOT_2    NUMBER,
   P_HERO_TIER_SLOT_3    NUMBER,
   P_HERO_TIER_SLOT_4    NUMBER,
   P_HERO_TIER_SLOT_5    NUMBER
)
   RETURN NUMBER
IS
   V_HERO_TIER_SLOT   NUMBER;
   V_CHANCE_ACTIVE    VARCHAR2 (1 BYTE);
BEGIN
   SELECT   HERO_TIER_SLOT, CHANCE_ACTIVE
     INTO   V_HERO_TIER_SLOT, V_CHANCE_ACTIVE
     FROM   (  SELECT   HERO_TIER_SLOT, CHANCE_ACTIVE
                 FROM   (SELECT   P_HERO_TIER_SLOT_1 AS HERO_TIER_SLOT,
                                  DECODE (P_HERO_TIER_SLOT_1, 0, 'N', 'Y')
                                     AS CHANCE_ACTIVE
                           FROM   DUAL
                         UNION
                         SELECT   P_HERO_TIER_SLOT_2 AS HERO_TIER_SLOT,
                                  DECODE (P_HERO_TIER_SLOT_2, 0, 'N', 'Y')
                                     AS CHANCE_ACTIVE
                           FROM   DUAL
                         UNION
                         SELECT   P_HERO_TIER_SLOT_3 AS HERO_TIER_SLOT,
                                  DECODE (P_HERO_TIER_SLOT_3, 0, 'N', 'Y')
                                     AS CHANCE_ACTIVE
                           FROM   DUAL
                         UNION
                         SELECT   P_HERO_TIER_SLOT_4 AS HERO_TIER_SLOT,
                                  DECODE (P_HERO_TIER_SLOT_4, 0, 'N', 'Y')
                                     AS CHANCE_ACTIVE
                           FROM   DUAL
                         UNION
                         SELECT   P_HERO_TIER_SLOT_5 AS HERO_TIER_SLOT,
                                  DECODE (P_HERO_TIER_SLOT_5, 0, 'N', 'Y')
                                     AS CHANCE_ACTIVE
                           FROM   DUAL)
                WHERE   CHANCE_ACTIVE = 'Y'
             ORDER BY   DBMS_RANDOM.VALUE)
    WHERE   ROWNUM = 1;

   RETURN V_HERO_TIER_SLOT;
END;
/


