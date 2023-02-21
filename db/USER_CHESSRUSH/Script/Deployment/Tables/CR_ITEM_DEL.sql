CREATE TABLE USER_CHESSRUSH.CR_ITEM_DEL
(
  ITEM_ID         NUMBER,
  ITEM_ICON       VARCHAR2(4000 BYTE),
  ITEM_ICON_BLOB  BLOB,
  ITEM_NAME       VARCHAR2(50 BYTE),
  DATE_CREATE     DATE                          DEFAULT SYSDATE,
  USER_CREATE     VARCHAR2(50 BYTE)             DEFAULT 'DBA',
  DATE_DELETE     DATE                          DEFAULT SYSDATE,
  USER_DELETE     VARCHAR2(50 BYTE)             DEFAULT 'DBA',
  REASON_DELETE   VARCHAR2(100 BYTE)
)
LOGGING 
NOCOMPRESS 
LOB (ITEM_ICON_BLOB) STORE AS 
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