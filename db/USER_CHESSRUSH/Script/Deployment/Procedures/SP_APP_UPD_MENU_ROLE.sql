CREATE OR REPLACE PROCEDURE USER_CHESSRUSH.SP_APP_UPD_MENU_ROLE (P_MENU_ID      NUMBER,
                                                  P_ROLE_ID      NUMBER,
                                                  P_IS_SELECT    VARCHAR2,
                                                  P_USERLOGIN    VARCHAR2)
IS
BEGIN
   UPDATE   APP_ROLE_MENU
      SET   IS_SELECT = P_IS_SELECT,
            DATE_MODIFY = SYSDATE,
            USER_MODIFY = P_USERLOGIN
    WHERE   MENU_ID = P_MENU_ID AND ROLE_ID = P_ROLE_ID;

   COMMIT;
END;
/


