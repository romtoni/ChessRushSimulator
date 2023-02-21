CREATE OR REPLACE PROCEDURE USER_CHESSRUSH.SP_APP_INS_ROLE (P_ROLE_NAME      VARCHAR2,
                                             P_ROLE_STATUS    VARCHAR2,
                                             P_USERLOGIN      VARCHAR2)
IS
   V_ROLE_ID   NUMBER;
BEGIN
   INSERT INTO APP_ROLE (ROLE_NAME,
                         ROLE_STATUS,
                         DATE_CREATE,
                         USER_CREATE)
     VALUES   (P_ROLE_NAME,
               P_ROLE_STATUS,
               SYSDATE,
               P_USERLOGIN);

   SELECT   SQ_ROLE_ID.CURRVAL INTO V_ROLE_ID FROM DUAL;

   SP_APP_INS_MENU_ROLE_ALL (V_ROLE_ID, P_USERLOGIN);
   COMMIT;
END;
/


