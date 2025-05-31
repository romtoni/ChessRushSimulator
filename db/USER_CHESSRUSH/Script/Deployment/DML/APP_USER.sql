SET DEFINE OFF;
--
--SQL Statement which produced this data:
--  SELECT * FROM USER_CHESSRUSH.APP_USER
--
Insert into USER_CHESSRUSH.APP_USER
   (USER_ID, USER_NAME, PASSWORD, ROLE_ID, EMAIL, USER_STATUS, DATE_CREATE, USER_CREATE)
 Values
   (1, 'admin', 'p4$$w0Rd', 1, 'romtoni21@gmail.com', 'A', TO_DATE('11/09/2019 09:37:25', 'MM/DD/YYYY HH24:MI:SS'), 'DBA');
COMMIT;
