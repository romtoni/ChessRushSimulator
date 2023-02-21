CREATE TABLE USER_CHESSRUSH.CR_HERO_SKILL_DEL
(
  HERO_SKILL_ID           NUMBER,
  HERO_ID                 NUMBER,
  HERO_SKILL_TYPE_ID      NUMBER,
  HERO_SKILL_ICON         VARCHAR2(4000 BYTE),
  HERO_SKILL_ICON_BLOB    BLOB,
  HERO_SKILL_NAME         VARCHAR2(50 BYTE),
  HERO_SKILL_DESCRIPTION  VARCHAR2(4000 BYTE),
  DATE_CREATE             DATE                  DEFAULT SYSDATE,
  USER_CREATE             VARCHAR2(50 BYTE)     DEFAULT 'DBA',
  DATE_DELETE             DATE                  DEFAULT SYSDATE,
  USER_DELETE             VARCHAR2(50 BYTE)     DEFAULT 'DBA',
  REASON_DELETE           VARCHAR2(100 BYTE)
)
LOGGING 
NOCOMPRESS 
LOB (HERO_SKILL_ICON_BLOB) STORE AS 
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