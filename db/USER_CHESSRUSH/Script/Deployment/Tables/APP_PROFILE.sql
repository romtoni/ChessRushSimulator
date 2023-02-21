CREATE TABLE USER_CHESSRUSH.APP_PROFILE
(
  FIRST_NAME   VARCHAR2(20 BYTE),
  LAST_NAME    VARCHAR2(20 BYTE),
  PHOTO        VARCHAR2(4000 BYTE),
  PHOTO_BLOB   BLOB,
  PROFILE      VARCHAR2(4000 BYTE),
  DATE_CREATE  DATE                             DEFAULT SYSDATE,
  USER_CREATE  VARCHAR2(50 BYTE)                DEFAULT 'DBA'
)
LOGGING 
NOCOMPRESS 
LOB (PHOTO_BLOB) STORE AS 
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