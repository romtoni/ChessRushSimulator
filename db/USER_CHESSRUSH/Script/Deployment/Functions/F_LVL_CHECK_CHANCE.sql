CREATE OR REPLACE FUNCTION USER_CHESSRUSH.F_LVL_CHECK_CHANCE (P_CHANCE_1    NUMBER,
                                               P_CHANCE_2    NUMBER,
                                               P_CHANCE_3    NUMBER,
                                               P_CHANCE_4    NUMBER,
                                               P_CHANCE_5    NUMBER)
   RETURN NUMBER
IS
   V_TOTAL_CHANCE              NUMBER;
   V_SHARE_PERCENTAGE_CHANCE   NUMBER;
BEGIN
   V_TOTAL_CHANCE :=
      P_CHANCE_1 + P_CHANCE_2 + P_CHANCE_3 + P_CHANCE_4 + P_CHANCE_5;

   V_SHARE_PERCENTAGE_CHANCE := ROUND ( (1 / V_TOTAL_CHANCE), 2);

   RETURN V_SHARE_PERCENTAGE_CHANCE;
END;
/


