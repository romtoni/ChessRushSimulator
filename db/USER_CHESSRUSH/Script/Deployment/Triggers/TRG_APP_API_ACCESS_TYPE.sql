CREATE OR REPLACE TRIGGER USER_CHESSRUSH.TRG_APP_API_ACCESS_TYPE
BEFORE INSERT
ON USER_CHESSRUSH.APP_API_ACCESS_TYPE 
REFERENCING NEW AS New OLD AS Old
FOR EACH ROW
DECLARE
tmpVar NUMBER;

BEGIN
   tmpVar := 0;

   SELECT SQ_ACCESS_TYPE_ID.NEXTVAL INTO tmpVar FROM dual;
   :NEW.ACCESS_TYPE_ID := tmpVar;

   EXCEPTION
     WHEN OTHERS THEN
       -- Consider logging the error and then re-raise
       RAISE;
END ;
/


