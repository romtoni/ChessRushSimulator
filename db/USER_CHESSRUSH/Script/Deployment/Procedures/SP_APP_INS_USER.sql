CREATE OR REPLACE PROCEDURE USER_CHESSRUSH.SP_APP_INS_USER (
   P_USER_NAME    VARCHAR2,
   P_PASSWORD     VARCHAR2,
   P_ROLE_ID      NUMBER,
   P_EMAIL        VARCHAR2,
   P_USERLOGIN    VARCHAR2
)
IS
   V_USER_ID   NUMBER;
BEGIN
   INSERT INTO APP_USER (USER_NAME,
                         PASSWORD,
                         ROLE_ID,
                         EMAIL,
                         DATE_CREATE,
                         USER_CREATE)
     VALUES   (P_USER_NAME,
               P_PASSWORD,
               P_ROLE_ID,
               P_EMAIL,
               SYSDATE,
               P_USERLOGIN);

   SELECT   SQ_USER_ID.CURRVAL INTO V_USER_ID FROM DUAL;

   SP_APP_INS_USER_ACTIVATION (V_USER_ID, P_USERLOGIN);

   COMMIT;
END;
/


