CREATE OR REPLACE FUNCTION USER_CHESSRUSH.F_APP_LAST_TOKEN (P_STRING VARCHAR2)
   RETURN VARCHAR2
IS
   V_TOKEN   VARCHAR2 (100);
   V_NO   NUMBER;
BEGIN
   SELECT   TOKEN, NO
     INTO   V_TOKEN, V_NO
     FROM   (    SELECT   REGEXP_SUBSTR (P_STRING,
                                         '[^,/]+',
                                         1,
                                         LEVEL)
                             AS TOKEN, ROWNUM AS NO
                   FROM   DUAL
             CONNECT BY   REGEXP_SUBSTR (P_STRING,
                                         '[^,/]+',
                                         1,
                                         LEVEL) IS NOT NULL)
    WHERE   NO = (    SELECT   MAX (ROWNUM)
                           FROM   DUAL
                     CONNECT BY   REGEXP_SUBSTR (P_STRING,
                                                 '[^,/]+',
                                                 1,
                                                 LEVEL) IS NOT NULL);

   RETURN V_TOKEN;
END ;
/


