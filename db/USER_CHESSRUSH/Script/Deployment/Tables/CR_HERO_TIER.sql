CREATE TABLE USER_CHESSRUSH.CR_HERO_TIER
(
  HERO_TIER_ID    NUMBER,
  HERO_TIER_NAME  VARCHAR2(50 BYTE),
  MANA_CRYSTAL    NUMBER,
  DATE_CREATE     DATE                          DEFAULT SYSDATE,
  USER_CREATE     VARCHAR2(50 BYTE)             DEFAULT 'DBA'
)
LOGGING 
NOCOMPRESS 
NOCACHE
NOPARALLEL
MONITORING;