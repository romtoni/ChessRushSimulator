SET DEFINE OFF;
--
--SQL Statement which produced this data:
--  SELECT * FROM USER_CHESSRUSH.CR_HERO_STAT_TYPE
--
Insert into USER_CHESSRUSH.CR_HERO_STAT_TYPE
   (STAT_TYPE_ID, STAT_TYPE_NAME, DATE_CREATE, USER_CREATE)
 Values
   (1, 'PHYSICAL', TO_DATE('10/06/2019 17:24:26', 'MM/DD/YYYY HH24:MI:SS'), 'DBA');
Insert into USER_CHESSRUSH.CR_HERO_STAT_TYPE
   (STAT_TYPE_ID, STAT_TYPE_NAME, DATE_CREATE, USER_CREATE)
 Values
   (2, 'MAGICAL', TO_DATE('10/06/2019 17:24:26', 'MM/DD/YYYY HH24:MI:SS'), 'DBA');
COMMIT;
