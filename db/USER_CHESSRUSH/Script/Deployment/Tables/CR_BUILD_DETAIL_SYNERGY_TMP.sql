CREATE TABLE USER_CHESSRUSH.CR_BUILD_DETAIL_SYNERGY_TMP
(
  BD_SYNERGY_ID  NUMBER,
  BUILD_ID       NUMBER,
  SYNERGY_ID     NUMBER,
  DATE_CREATE    DATE                           DEFAULT SYSDATE,
  USER_CREATE    VARCHAR2(50 BYTE)              DEFAULT 'USER'
)
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING;