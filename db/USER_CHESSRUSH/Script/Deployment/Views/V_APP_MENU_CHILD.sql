/* Formatted on 21/02/2023 21:51:47 (QP5 v5.114.809.3010) */
CREATE OR REPLACE FORCE VIEW USER_CHESSRUSH.V_APP_MENU_CHILD
(
   MENU_ID,
   MENU_NAME
)
AS
   SELECT   A.MENU_ID,
            DECODE (
               (SELECT   MENU_NAME
                  FROM   APP_MENU
                 WHERE   MENU_ID =
                            (SELECT   PARENT_MENU_ID
                               FROM   APP_MENU
                              WHERE   MENU_ID =
                                         (SELECT   PARENT_MENU_ID
                                            FROM   APP_MENU
                                           WHERE   MENU_ID =
                                                      (SELECT   PARENT_MENU_ID
                                                         FROM   APP_MENU
                                                        WHERE   MENU_ID =
                                                                   A.PARENT_MENU_ID)))),
               NULL,
               NULL,
               (SELECT   MENU_NAME
                  FROM   APP_MENU
                 WHERE   MENU_ID =
                            (SELECT   PARENT_MENU_ID
                               FROM   APP_MENU
                              WHERE   MENU_ID =
                                         (SELECT   PARENT_MENU_ID
                                            FROM   APP_MENU
                                           WHERE   MENU_ID =
                                                      (SELECT   PARENT_MENU_ID
                                                         FROM   APP_MENU
                                                        WHERE   MENU_ID =
                                                                   A.PARENT_MENU_ID))))
               || ' -> '
            )
            || DECODE (
                  (SELECT   MENU_NAME
                     FROM   APP_MENU
                    WHERE   MENU_ID =
                               (SELECT   PARENT_MENU_ID
                                  FROM   APP_MENU
                                 WHERE   MENU_ID =
                                            (SELECT   PARENT_MENU_ID
                                               FROM   APP_MENU
                                              WHERE   MENU_ID =
                                                         A.PARENT_MENU_ID))),
                  NULL,
                  NULL,
                  (SELECT   MENU_NAME
                     FROM   APP_MENU
                    WHERE   MENU_ID =
                               (SELECT   PARENT_MENU_ID
                                  FROM   APP_MENU
                                 WHERE   MENU_ID =
                                            (SELECT   PARENT_MENU_ID
                                               FROM   APP_MENU
                                              WHERE   MENU_ID =
                                                         A.PARENT_MENU_ID)))
                  || ' -> '
               )
            || DECODE (
                  (SELECT   MENU_NAME
                     FROM   APP_MENU
                    WHERE   MENU_ID = (SELECT   PARENT_MENU_ID
                                         FROM   APP_MENU
                                        WHERE   MENU_ID = A.PARENT_MENU_ID)),
                  NULL,
                  NULL,
                  (SELECT   MENU_NAME
                     FROM   APP_MENU
                    WHERE   MENU_ID = (SELECT   PARENT_MENU_ID
                                         FROM   APP_MENU
                                        WHERE   MENU_ID = A.PARENT_MENU_ID))
                  || ' -> '
               )
            || DECODE ( (SELECT   MENU_NAME
                           FROM   APP_MENU
                          WHERE   MENU_ID = A.PARENT_MENU_ID),
                       NULL, NULL,
                       (SELECT   MENU_NAME
                          FROM   APP_MENU
                         WHERE   MENU_ID = A.PARENT_MENU_ID)
                       || ' -> ')
            || A.MENU_NAME
               AS MENU_NAME
     FROM   APP_MENU A;


