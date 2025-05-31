CREATE TABLE USER_CHESSRUSH.CR_HERO_PHOTO_DEL
(
  HERO_PHOTO_ID          NUMBER,
  HERO_ID                NUMBER,
  STAR_GRADE             NUMBER,
  HERO_ICON              VARCHAR2(4000 BYTE),
  HERO_ICON_BLOB         BLOB,
  HERO_IMAGE             VARCHAR2(4000 BYTE),
  HERO_IMAGE_BLOB        BLOB,
  HERO_IMAGE_ARENA       VARCHAR2(4000 BYTE),
  HERO_IMAGE_ARENA_BLOB  BLOB,
  DATE_CREATE            DATE                   DEFAULT SYSDATE,
  USER_CREATE            VARCHAR2(50 BYTE)      DEFAULT 'DBA',
  DATE_DELETE            DATE,
  USER_DELETE            VARCHAR2(50 BYTE),
  REASON_DELETE          VARCHAR2(100 BYTE)
)
LOGGING 
NOCOMPRESS 
LOB (HERO_ICON_BLOB) STORE AS 
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
  LOB (HERO_IMAGE_BLOB) STORE AS 
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
  LOB (HERO_IMAGE_ARENA_BLOB) STORE AS 
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