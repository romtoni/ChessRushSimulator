CREATE OR REPLACE PROCEDURE USER_CHESSRUSH.SP_CRT_SLOT_BENCH (P_SESSION_ID    NUMBER,
                                               P_USERLOGIN     VARCHAR2)
IS
   V_COUNT   NUMBER;
BEGIN
   SELECT   COUNT ( * )
     INTO   V_COUNT
     FROM   CR_PREVIEW_BENCH
    WHERE   SESSION_ID = P_SESSION_ID;

   IF V_COUNT = 0
   THEN
      FOR I IN 1 .. 8
      LOOP
         INSERT INTO CR_PREVIEW_BENCH (SESSION_ID,
                                       SLOT_NO,
                                       DATE_CREATE,
                                       USER_CREATE)
           VALUES   (P_SESSION_ID,
                     I,
                     SYSDATE,
                     P_USERLOGIN);
      END LOOP;
   END IF;
   
   COMMIT;
END;
/


