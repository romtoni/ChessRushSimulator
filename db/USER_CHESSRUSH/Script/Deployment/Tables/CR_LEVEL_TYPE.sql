CREATE TABLE USER_CHESSRUSH.CR_LEVEL_TYPE
(
  LEVEL_TYPE_ID    NUMBER,
  LEVEL_TYPE_NAME  VARCHAR2(20 BYTE),
  DATE_CREATE      DATE                         DEFAULT SYSDATE,
  USER_CREATE      VARCHAR2(20 BYTE)            DEFAULT 'DBA'
)
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING;