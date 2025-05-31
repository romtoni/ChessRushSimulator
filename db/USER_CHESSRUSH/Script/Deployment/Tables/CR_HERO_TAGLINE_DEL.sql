CREATE TABLE USER_CHESSRUSH.CR_HERO_TAGLINE_DEL
(
  HERO_TAGLINE_ID           NUMBER,
  HERO_TAGLINE_ENTRANCE     VARCHAR2(200 BYTE),
  HERO_TAGLINE_WINNING      VARCHAR2(200 BYTE),
  HERO_VOICE_ENTRANCE       VARCHAR2(4000 BYTE),
  HERO_VOICE_WINNING        VARCHAR2(4000 BYTE),
  HERO_VOICE_ENTRANCE_BLOB  BLOB,
  HERO_VOICE_WINNING_BLOB   BLOB,
  DATE_CREATE               DATE                DEFAULT SYSDATE,
  USER_CREATE               VARCHAR2(50 BYTE)   DEFAULT 'DBA',
  DATE_DELETE               DATE                DEFAULT SYSDATE,
  USER_DELETE               VARCHAR2(50 BYTE)   DEFAULT 'DBA',
  REASON_DELETE             VARCHAR2(100 BYTE)
)
LOGGING 
NOCOMPRESS 
LOB (HERO_VOICE_WINNING_BLOB) STORE AS 
      ( TABLESPACE  USERS 
        ENABLE      STORAGE IN ROW
        CHUNK       8192
        RETENTION
        NOCACHE
        INDEX       (
          TABLESPACE USERS
          STORAGE    (
                      INITIAL          64K
                      NEXT             1
                      MINEXTENTS       1
                      MAXEXTENTS       UNLIMITED
                      PCTINCREASE      0
                      BUFFER_POOL      DEFAULT
                     ))
        STORAGE    (
                    INITIAL          64K
                    MINEXTENTS       1
                    MAXEXTENTS       UNLIMITED
                    PCTINCREASE      0
                    BUFFER_POOL      DEFAULT
                   )
      )
  LOB (HERO_VOICE_ENTRANCE_BLOB) STORE AS 
      ( TABLESPACE  USERS 
        ENABLE      STORAGE IN ROW
        CHUNK       8192
        RETENTION
        NOCACHE
        INDEX       (
          TABLESPACE USERS
          STORAGE    (
                      INITIAL          64K
                      NEXT             1
                      MINEXTENTS       1
                      MAXEXTENTS       UNLIMITED
                      PCTINCREASE      0
                      BUFFER_POOL      DEFAULT
                     ))
        STORAGE    (
                    INITIAL          64K
                    MINEXTENTS       1
                    MAXEXTENTS       UNLIMITED
                    PCTINCREASE      0
                    BUFFER_POOL      DEFAULT
                   )
      )
NOCACHE
NOPARALLEL
MONITORING;