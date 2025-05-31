CREATE OR REPLACE PROCEDURE USER_CHESSRUSH.SP_APP_INS_MENU_ROLE_ALL (
   P_ROLE_ID      NUMBER,
   P_USERLOGIN    VARCHAR2
)
IS
BEGIN
   FOR I IN (SELECT   MENU_ID FROM APP_MENU)
   LOOP
      INSERT INTO APP_ROLE_MENU (ROLE_ID,
                                 MENU_ID,
                                 IS_SELECT,
                                 DATE_CREATE,
                                 USER_CREATE)
        VALUES   (P_ROLE_ID,
                  I.MENU_ID,
                  'N',
                  SYSDATE,
                  P_USERLOGIN);
   END LOOP;

   COMMIT;
END;
/


