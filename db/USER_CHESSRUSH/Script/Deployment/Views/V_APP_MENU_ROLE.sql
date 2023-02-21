/* Formatted on 21/02/2023 21:51:48 (QP5 v5.114.809.3010) */
CREATE OR REPLACE FORCE VIEW USER_CHESSRUSH.V_APP_MENU_ROLE
(
   ROLE_ID,
   ROLE_NAME,
   PARENT_MENU_ID,
   MENU_ID,
   MENU_NAME,
   LINK,
   IS_SELECT,
   SORT_NO
)
AS
   SELECT   A.ROLE_ID,
            A.ROLE_NAME,
            C.PARENT_MENU_ID,
            B.MENU_ID,
            C.MENU_NAME,
            C.LINK,
            B.IS_SELECT,
            C.SORT_NO
     FROM         APP_ROLE A
               LEFT JOIN
                  APP_ROLE_MENU B
               ON A.ROLE_ID = B.ROLE_ID
            LEFT JOIN
               APP_MENU C
            ON B.MENU_ID = C.MENU_ID;


