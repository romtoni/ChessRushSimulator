CREATE TABLE USER_CHESSRUSH.CR_HERO_CLASS
(
  CLASS_ID           NUMBER,
  CLASS_IMAGE        VARCHAR2(4000 BYTE),
  CLASS_IMAGE_BLOB   BLOB,
  CLASS_NAME         VARCHAR2(50 BYTE),
  CLASS_DESCRIPTION  VARCHAR2(4000 BYTE),
  DATE_CREATE        DATE                       DEFAULT SYSDATE,
  USER_CREATE        VARCHAR2(50 BYTE)          DEFAULT 'DBA'
)
LOGGING 
NOCOMPRESS 
LOB (CLASS_IMAGE_BLOB) STORE AS 
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