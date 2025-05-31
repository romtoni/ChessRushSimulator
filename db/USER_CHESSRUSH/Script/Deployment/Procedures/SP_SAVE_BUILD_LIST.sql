CREATE OR REPLACE PROCEDURE USER_CHESSRUSH.SP_SAVE_BUILD_LIST (
   P_BUILD_ID     NUMBER,
   P_USERLOGIN    VARCHAR2
)
IS
   V_BUILD_NAME        VARCHAR2 (50 BYTE);
   V_HERO_SLOT_NO      NUMBER;
   V_SYNERGY_SLOT_NO   NUMBER;
BEGIN
   --CHECK TEMPORARY BUILD AVAILABILITY
   BEGIN
      SELECT   BUILD_NAME
        INTO   V_BUILD_NAME
        FROM   CR_BUILD_LIST_TMP
       WHERE   BUILD_ID = P_BUILD_ID AND USER_CREATE = P_USERLOGIN;
   EXCEPTION
      WHEN NO_DATA_FOUND
      THEN
         V_BUILD_NAME := NULL;
   END;

   --IF TEMPORARY BUILD STILL AVAILABLE THAN INSERT HERO AND SYNERGY FROM THAT BUILD
   IF V_BUILD_NAME IS NOT NULL
   THEN
      --INITIALIZE VARIABLE
      V_HERO_SLOT_NO := 0;
      V_SYNERGY_SLOT_NO := 0;

      INSERT INTO CR_SAVE_BUILD_LIST (BUILD_ID, BUILD_NAME, USER_CREATE)
        VALUES   (P_BUILD_ID, V_BUILD_NAME, P_USERLOGIN);


      FOR I IN (SELECT   HERO_ID, STAR_GRADE
                  FROM   CR_BUILD_DETAIL_HERO_TMP
                 WHERE   BUILD_ID = P_BUILD_ID)
      LOOP
         V_HERO_SLOT_NO := V_HERO_SLOT_NO + 1;

         CASE V_HERO_SLOT_NO
            WHEN 1
            THEN
               UPDATE   CR_SAVE_BUILD_LIST
                  SET   HERO_ID_1 = I.HERO_ID, STAR_GRADE_1 = I.STAR_GRADE
                WHERE   BUILD_ID = P_BUILD_ID;
            WHEN 2
            THEN
               UPDATE   CR_SAVE_BUILD_LIST
                  SET   HERO_ID_2 = I.HERO_ID, STAR_GRADE_2 = I.STAR_GRADE
                WHERE   BUILD_ID = P_BUILD_ID;
            WHEN 3
            THEN
               UPDATE   CR_SAVE_BUILD_LIST
                  SET   HERO_ID_3 = I.HERO_ID, STAR_GRADE_3 = I.STAR_GRADE
                WHERE   BUILD_ID = P_BUILD_ID;
            WHEN 4
            THEN
               UPDATE   CR_SAVE_BUILD_LIST
                  SET   HERO_ID_4 = I.HERO_ID, STAR_GRADE_4 = I.STAR_GRADE
                WHERE   BUILD_ID = P_BUILD_ID;
            WHEN 5
            THEN
               UPDATE   CR_SAVE_BUILD_LIST
                  SET   HERO_ID_5 = I.HERO_ID, STAR_GRADE_5 = I.STAR_GRADE
                WHERE   BUILD_ID = P_BUILD_ID;
            WHEN 6
            THEN
               UPDATE   CR_SAVE_BUILD_LIST
                  SET   HERO_ID_6 = I.HERO_ID, STAR_GRADE_6 = I.STAR_GRADE
                WHERE   BUILD_ID = P_BUILD_ID;
            WHEN 7
            THEN
               UPDATE   CR_SAVE_BUILD_LIST
                  SET   HERO_ID_7 = I.HERO_ID, STAR_GRADE_7 = I.STAR_GRADE
                WHERE   BUILD_ID = P_BUILD_ID;
            WHEN 8
            THEN
               UPDATE   CR_SAVE_BUILD_LIST
                  SET   HERO_ID_8 = I.HERO_ID, STAR_GRADE_8 = I.STAR_GRADE
                WHERE   BUILD_ID = P_BUILD_ID;
            WHEN 9
            THEN
               UPDATE   CR_SAVE_BUILD_LIST
                  SET   HERO_ID_9 = I.HERO_ID, STAR_GRADE_9 = I.STAR_GRADE
                WHERE   BUILD_ID = P_BUILD_ID;
            WHEN 10
            THEN
               UPDATE   CR_SAVE_BUILD_LIST
                  SET   HERO_ID_10 = I.HERO_ID, STAR_GRADE_10 = I.STAR_GRADE
                WHERE   BUILD_ID = P_BUILD_ID;
         END CASE;
      END LOOP;


      FOR I IN (SELECT   SYNERGY_ID
                  FROM   CR_BUILD_DETAIL_SYNERGY_TMP
                 WHERE   BUILD_ID = P_BUILD_ID)
      LOOP
         V_SYNERGY_SLOT_NO := V_SYNERGY_SLOT_NO + 1;

         CASE V_SYNERGY_SLOT_NO
            WHEN 1
            THEN
               UPDATE   CR_SAVE_BUILD_LIST
                  SET   SYNERGY_ID_1 = I.SYNERGY_ID
                WHERE   BUILD_ID = P_BUILD_ID;
            WHEN 2
            THEN
               UPDATE   CR_SAVE_BUILD_LIST
                  SET   SYNERGY_ID_2 = I.SYNERGY_ID
                WHERE   BUILD_ID = P_BUILD_ID;
            WHEN 3
            THEN
               UPDATE   CR_SAVE_BUILD_LIST
                  SET   SYNERGY_ID_3 = I.SYNERGY_ID
                WHERE   BUILD_ID = P_BUILD_ID;
            WHEN 4
            THEN
               UPDATE   CR_SAVE_BUILD_LIST
                  SET   SYNERGY_ID_4 = I.SYNERGY_ID
                WHERE   BUILD_ID = P_BUILD_ID;
            WHEN 5
            THEN
               UPDATE   CR_SAVE_BUILD_LIST
                  SET   SYNERGY_ID_5 = I.SYNERGY_ID
                WHERE   BUILD_ID = P_BUILD_ID;
            WHEN 6
            THEN
               UPDATE   CR_SAVE_BUILD_LIST
                  SET   SYNERGY_ID_6 = I.SYNERGY_ID
                WHERE   BUILD_ID = P_BUILD_ID;
            WHEN 7
            THEN
               UPDATE   CR_SAVE_BUILD_LIST
                  SET   SYNERGY_ID_7 = I.SYNERGY_ID
                WHERE   BUILD_ID = P_BUILD_ID;
            WHEN 8
            THEN
               UPDATE   CR_SAVE_BUILD_LIST
                  SET   SYNERGY_ID_8 = I.SYNERGY_ID
                WHERE   BUILD_ID = P_BUILD_ID;
            WHEN 9
            THEN
               UPDATE   CR_SAVE_BUILD_LIST
                  SET   SYNERGY_ID_9 = I.SYNERGY_ID
                WHERE   BUILD_ID = P_BUILD_ID;
            WHEN 10
            THEN
               UPDATE   CR_SAVE_BUILD_LIST
                  SET   SYNERGY_ID_10 = I.SYNERGY_ID
                WHERE   BUILD_ID = P_BUILD_ID;
         END CASE;
      END LOOP;
   END IF;

   --DELETE TEMPORARY BUILD
   SP_DEL_BUILD_TMP (P_USERLOGIN);
   COMMIT;
END;
/


