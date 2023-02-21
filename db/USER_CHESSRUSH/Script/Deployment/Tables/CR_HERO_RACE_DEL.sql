CREATE TABLE USER_CHESSRUSH.CR_HERO_RACE_DEL
(
  RACE_ID           NUMBER,
  RACE_IMAGE        VARCHAR2(4000 BYTE),
  RACE_IMAGE_BLOB   BLOB,
  RACE_NAME         VARCHAR2(50 BYTE),
  RACE_DESCRIPTION  VARCHAR2(4000 BYTE),
  DATE_CREATE       DATE                        DEFAULT SYSDATE,
  USER_CREATE       VARCHAR2(50 BYTE)           DEFAULT 'DBA',
  DATE_DELETE       DATE                        DEFAULT SYSDATE,
  USER_DELETE       VARCHAR2(50 BYTE)           DEFAULT 'DBA',
  REASON_DELETE     VARCHAR2(100 BYTE)
)
LOGGING 
NOCOMPRESS 
LOB (RACE_IMAGE_BLOB) STORE AS 
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