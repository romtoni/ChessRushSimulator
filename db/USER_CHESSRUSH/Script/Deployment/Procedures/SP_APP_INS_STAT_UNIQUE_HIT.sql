CREATE OR REPLACE PROCEDURE USER_CHESSRUSH.SP_APP_INS_STAT_UNIQUE_HIT (
   P_IP_ADDRESS    VARCHAR2,
   P_COUNTRY       VARCHAR2
)
IS
   V_COUNT_IP   NUMBER;
BEGIN
   SELECT   COUNT ( * )
     INTO   V_COUNT_IP
     FROM   APP_STATISTIC_UNIQUE_HIT
    WHERE   UNIQUE_IP_ADDRESS = P_IP_ADDRESS;

   IF V_COUNT_IP = 0
   THEN
      INSERT INTO APP_STATISTIC_UNIQUE_HIT (
                                               UNIQUE_DATE_HIT,
                                               UNIQUE_IP_ADDRESS,
                                               COUNTRY
                 )
        VALUES   (SYSDATE, P_IP_ADDRESS, P_COUNTRY);
   END IF;

   COMMIT;
END;
/


