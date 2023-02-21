/* Formatted on 21/02/2023 21:51:58 (QP5 v5.114.809.3010) */
CREATE OR REPLACE FORCE VIEW USER_CHESSRUSH.V_MST_BUILD_SYNERGY
(
   BUILD_ID,
   BUILD_NAME,
   RACE_IMAGE_1,
   RACE_IMAGE_BLOB_1,
   CLASS_IMAGE_1,
   CLASS_IMAGE_BLOB_1,
   SYNERGY_NAME_1,
   SYNERGY_BENEFIT_1,
   SYNERGY_EFFECT_1,
   RACE_IMAGE_2,
   RACE_IMAGE_BLOB_2,
   CLASS_IMAGE_2,
   CLASS_IMAGE_BLOB_2,
   SYNERGY_NAME_2,
   SYNERGY_BENEFIT_2,
   SYNERGY_EFFECT_2,
   RACE_IMAGE_3,
   RACE_IMAGE_BLOB_3,
   CLASS_IMAGE_3,
   CLASS_IMAGE_BLOB_3,
   SYNERGY_NAME_3,
   SYNERGY_BENEFIT_3,
   SYNERGY_EFFECT_3,
   RACE_IMAGE_4,
   RACE_IMAGE_BLOB_4,
   CLASS_IMAGE_4,
   CLASS_IMAGE_BLOB_4,
   SYNERGY_NAME_4,
   SYNERGY_BENEFIT_4,
   SYNERGY_EFFECT_4,
   RACE_IMAGE_5,
   RACE_IMAGE_BLOB_5,
   CLASS_IMAGE_5,
   CLASS_IMAGE_BLOB_5,
   SYNERGY_NAME_5,
   SYNERGY_BENEFIT_5,
   SYNERGY_EFFECT_5,
   RACE_IMAGE_6,
   RACE_IMAGE_BLOB_6,
   CLASS_IMAGE_6,
   CLASS_IMAGE_BLOB_6,
   SYNERGY_NAME_6,
   SYNERGY_BENEFIT_6,
   SYNERGY_EFFECT_6,
   RACE_IMAGE_7,
   RACE_IMAGE_BLOB_7,
   CLASS_IMAGE_7,
   CLASS_IMAGE_BLOB_7,
   SYNERGY_NAME_7,
   SYNERGY_BENEFIT_7,
   SYNERGY_EFFECT_7,
   RACE_IMAGE_8,
   RACE_IMAGE_BLOB_8,
   CLASS_IMAGE_8,
   CLASS_IMAGE_BLOB_8,
   SYNERGY_NAME_8,
   SYNERGY_BENEFIT_8,
   SYNERGY_EFFECT_8,
   RACE_IMAGE_9,
   RACE_IMAGE_BLOB_9,
   CLASS_IMAGE_9,
   CLASS_IMAGE_BLOB_9,
   SYNERGY_NAME_9,
   SYNERGY_BENEFIT_9,
   SYNERGY_EFFECT_9,
   RACE_IMAGE_10,
   RACE_IMAGE_BLOB_10,
   CLASS_IMAGE_10,
   CLASS_IMAGE_BLOB_10,
   SYNERGY_NAME_10,
   SYNERGY_BENEFIT_10,
   SYNERGY_EFFECT_10
)
AS
     SELECT   A.BUILD_ID,
              A.BUILD_NAME,
              RB.RACE_IMAGE AS RACE_IMAGE_1,
              RB.RACE_IMAGE_BLOB AS RACE_IMAGE_BLOB_1,
              CB.CLASS_IMAGE AS CLASS_IMAGE_1,
              CB.CLASS_IMAGE_BLOB AS CLASS_IMAGE_BLOB_1,
              B.SYNERGY_NAME AS SYNERGY_NAME_1,
              B.SYNERGY_BENEFIT AS SYNERGY_BENEFIT_1,
              SEB.SYNERGY_EFFECT_NAME AS SYNERGY_EFFECT_1,
              RC.RACE_IMAGE AS RACE_IMAGE_2,
              RC.RACE_IMAGE_BLOB AS RACE_IMAGE_BLOB_2,
              CC.CLASS_IMAGE AS CLASS_IMAGE_2,
              CC.CLASS_IMAGE_BLOB AS CLASS_IMAGE_BLOB_2,
              C.SYNERGY_NAME AS SYNERGY_NAME_2,
              C.SYNERGY_BENEFIT AS SYNERGY_BENEFIT_2,
              SEC.SYNERGY_EFFECT_NAME AS SYNERGY_EFFECT_2,
              RD.RACE_IMAGE AS RACE_IMAGE_3,
              RD.RACE_IMAGE_BLOB AS RACE_IMAGE_BLOB_3,
              CD.CLASS_IMAGE AS CLASS_IMAGE_3,
              CD.CLASS_IMAGE_BLOB AS CLASS_IMAGE_BLOB_3,
              D.SYNERGY_NAME AS SYNERGY_NAME_3,
              D.SYNERGY_BENEFIT AS SYNERGY_BENEFIT_3,
              SED.SYNERGY_EFFECT_NAME AS SYNERGY_EFFECT_3,
              RE.RACE_IMAGE AS RACE_IMAGE_4,
              RE.RACE_IMAGE_BLOB AS RACE_IMAGE_BLOB_4,
              CE.CLASS_IMAGE AS CLASS_IMAGE_4,
              CE.CLASS_IMAGE_BLOB AS CLASS_IMAGE_BLOB_4,
              E.SYNERGY_NAME AS SYNERGY_NAME_4,
              E.SYNERGY_BENEFIT AS SYNERGY_BENEFIT_4,
              SEE.SYNERGY_EFFECT_NAME AS SYNERGY_EFFECT_4,
              RF.RACE_IMAGE AS RACE_IMAGE_5,
              RF.RACE_IMAGE_BLOB AS RACE_IMAGE_BLOB_5,
              CF.CLASS_IMAGE AS CLASS_IMAGE_5,
              CF.CLASS_IMAGE_BLOB AS CLASS_IMAGE_BLOB_5,
              F.SYNERGY_NAME AS SYNERGY_NAME_5,
              F.SYNERGY_BENEFIT AS SYNERGY_BENEFIT_5,
              SEF.SYNERGY_EFFECT_NAME AS SYNERGY_EFFECT_5,
              RG.RACE_IMAGE AS RACE_IMAGE_6,
              RG.RACE_IMAGE_BLOB AS RACE_IMAGE_BLOB_6,
              CG.CLASS_IMAGE AS CLASS_IMAGE_6,
              CG.CLASS_IMAGE_BLOB AS CLASS_IMAGE_BLOB_6,
              G.SYNERGY_NAME AS SYNERGY_NAME_6,
              G.SYNERGY_BENEFIT AS SYNERGY_BENEFIT_6,
              SEG.SYNERGY_EFFECT_NAME AS SYNERGY_EFFECT_6,
              RH.RACE_IMAGE AS RACE_IMAGE_7,
              RH.RACE_IMAGE_BLOB AS RACE_IMAGE_BLOB_7,
              CH.CLASS_IMAGE AS CLASS_IMAGE_7,
              CH.CLASS_IMAGE_BLOB AS CLASS_IMAGE_BLOB_7,
              H.SYNERGY_NAME AS SYNERGY_NAME_7,
              H.SYNERGY_BENEFIT AS SYNERGY_BENEFIT_7,
              SEH.SYNERGY_EFFECT_NAME AS SYNERGY_EFFECT_7,
              RI.RACE_IMAGE AS RACE_IMAGE_8,
              RI.RACE_IMAGE_BLOB AS RACE_IMAGE_BLOB_8,
              CI.CLASS_IMAGE AS CLASS_IMAGE_8,
              CI.CLASS_IMAGE_BLOB AS CLASS_IMAGE_BLOB_8,
              I.SYNERGY_NAME AS SYNERGY_NAME_8,
              I.SYNERGY_BENEFIT AS SYNERGY_BENEFIT_8,
              SEI.SYNERGY_EFFECT_NAME AS SYNERGY_EFFECT_8,
              RJ.RACE_IMAGE AS RACE_IMAGE_9,
              RJ.RACE_IMAGE_BLOB AS RACE_IMAGE_BLOB_9,
              CJ.CLASS_IMAGE AS CLASS_IMAGE_9,
              CJ.CLASS_IMAGE_BLOB AS CLASS_IMAGE_BLOB_9,
              J.SYNERGY_NAME AS SYNERGY_NAME_9,
              J.SYNERGY_BENEFIT AS SYNERGY_BENEFIT_9,
              SEJ.SYNERGY_EFFECT_NAME AS SYNERGY_EFFECT_9,
              RK.RACE_IMAGE AS RACE_IMAGE_10,
              RK.RACE_IMAGE_BLOB AS RACE_IMAGE_BLOB_10,
              CK.CLASS_IMAGE AS CLASS_IMAGE_10,
              CK.CLASS_IMAGE_BLOB AS CLASS_IMAGE_BLOB_10,
              K.SYNERGY_NAME AS SYNERGY_NAME_10,
              K.SYNERGY_BENEFIT AS SYNERGY_BENEFIT_10,
              SEK.SYNERGY_EFFECT_NAME AS SYNERGY_EFFECT_10
       FROM                                                                                                                           CR_SAVE_BUILD_LIST A
                                                                                                                                   LEFT JOIN
                                                                                                                                      CR_SYNERGY B
                                                                                                                                   ON B.SYNERGY_ID =
                                                                                                                                         A.SYNERGY_ID_1
                                                                                                                                LEFT JOIN
                                                                                                                                   CR_SYNERGY C
                                                                                                                                ON C.SYNERGY_ID =
                                                                                                                                      A.SYNERGY_ID_2
                                                                                                                             LEFT JOIN
                                                                                                                                CR_SYNERGY D
                                                                                                                             ON D.SYNERGY_ID =
                                                                                                                                   A.SYNERGY_ID_3
                                                                                                                          LEFT JOIN
                                                                                                                             CR_SYNERGY E
                                                                                                                          ON E.SYNERGY_ID =
                                                                                                                                A.SYNERGY_ID_4
                                                                                                                       LEFT JOIN
                                                                                                                          CR_SYNERGY F
                                                                                                                       ON F.SYNERGY_ID =
                                                                                                                             A.SYNERGY_ID_5
                                                                                                                    LEFT JOIN
                                                                                                                       CR_SYNERGY G
                                                                                                                    ON G.SYNERGY_ID =
                                                                                                                          A.SYNERGY_ID_6
                                                                                                                 LEFT JOIN
                                                                                                                    CR_SYNERGY H
                                                                                                                 ON H.SYNERGY_ID =
                                                                                                                       A.SYNERGY_ID_7
                                                                                                              LEFT JOIN
                                                                                                                 CR_SYNERGY I
                                                                                                              ON I.SYNERGY_ID =
                                                                                                                    A.SYNERGY_ID_8
                                                                                                           LEFT JOIN
                                                                                                              CR_SYNERGY J
                                                                                                           ON J.SYNERGY_ID =
                                                                                                                 A.SYNERGY_ID_9
                                                                                                        LEFT JOIN
                                                                                                           CR_SYNERGY K
                                                                                                        ON K.SYNERGY_ID =
                                                                                                              A.SYNERGY_ID_10
                                                                                                     LEFT JOIN
                                                                                                        CR_HERO_RACE RB
                                                                                                     ON RB.RACE_ID =
                                                                                                           B.RACE_ID
                                                                                                  LEFT JOIN
                                                                                                     CR_HERO_RACE RC
                                                                                                  ON RC.RACE_ID =
                                                                                                        C.RACE_ID
                                                                                               LEFT JOIN
                                                                                                  CR_HERO_RACE RD
                                                                                               ON RD.RACE_ID =
                                                                                                     D.RACE_ID
                                                                                            LEFT JOIN
                                                                                               CR_HERO_RACE RE
                                                                                            ON RE.RACE_ID =
                                                                                                  E.RACE_ID
                                                                                         LEFT JOIN
                                                                                            CR_HERO_RACE RF
                                                                                         ON RF.RACE_ID =
                                                                                               F.RACE_ID
                                                                                      LEFT JOIN
                                                                                         CR_HERO_RACE RG
                                                                                      ON RG.RACE_ID =
                                                                                            G.RACE_ID
                                                                                   LEFT JOIN
                                                                                      CR_HERO_RACE RH
                                                                                   ON RH.RACE_ID =
                                                                                         H.RACE_ID
                                                                                LEFT JOIN
                                                                                   CR_HERO_RACE RI
                                                                                ON RI.RACE_ID =
                                                                                      I.RACE_ID
                                                                             LEFT JOIN
                                                                                CR_HERO_RACE RJ
                                                                             ON RJ.RACE_ID =
                                                                                   J.RACE_ID
                                                                          LEFT JOIN
                                                                             CR_HERO_RACE RK
                                                                          ON RK.RACE_ID =
                                                                                K.RACE_ID
                                                                       LEFT JOIN
                                                                          CR_HERO_CLASS CB
                                                                       ON CB.CLASS_ID =
                                                                             B.CLASS_ID
                                                                    LEFT JOIN
                                                                       CR_HERO_CLASS CC
                                                                    ON CC.CLASS_ID =
                                                                          C.CLASS_ID
                                                                 LEFT JOIN
                                                                    CR_HERO_CLASS CD
                                                                 ON CD.CLASS_ID =
                                                                       D.CLASS_ID
                                                              LEFT JOIN
                                                                 CR_HERO_CLASS CE
                                                              ON CE.CLASS_ID =
                                                                    E.CLASS_ID
                                                           LEFT JOIN
                                                              CR_HERO_CLASS CF
                                                           ON CF.CLASS_ID =
                                                                 F.CLASS_ID
                                                        LEFT JOIN
                                                           CR_HERO_CLASS CG
                                                        ON CG.CLASS_ID =
                                                              G.CLASS_ID
                                                     LEFT JOIN
                                                        CR_HERO_CLASS CH
                                                     ON CH.CLASS_ID =
                                                           H.CLASS_ID
                                                  LEFT JOIN
                                                     CR_HERO_CLASS CI
                                                  ON CI.CLASS_ID = I.CLASS_ID
                                               LEFT JOIN
                                                  CR_HERO_CLASS CJ
                                               ON CJ.CLASS_ID = J.CLASS_ID
                                            LEFT JOIN
                                               CR_HERO_CLASS CK
                                            ON CK.CLASS_ID = K.CLASS_ID
                                         LEFT JOIN
                                            CR_SYNERGY_EFFECT SEB
                                         ON SEB.SYNERGY_EFFECT_ID =
                                               B.SYNERGY_EFFECT_ID
                                      LEFT JOIN
                                         CR_SYNERGY_EFFECT SEC
                                      ON SEC.SYNERGY_EFFECT_ID =
                                            C.SYNERGY_EFFECT_ID
                                   LEFT JOIN
                                      CR_SYNERGY_EFFECT SED
                                   ON SED.SYNERGY_EFFECT_ID =
                                         D.SYNERGY_EFFECT_ID
                                LEFT JOIN
                                   CR_SYNERGY_EFFECT SEE
                                ON SEE.SYNERGY_EFFECT_ID = E.SYNERGY_EFFECT_ID
                             LEFT JOIN
                                CR_SYNERGY_EFFECT SEF
                             ON SEF.SYNERGY_EFFECT_ID = F.SYNERGY_EFFECT_ID
                          LEFT JOIN
                             CR_SYNERGY_EFFECT SEG
                          ON SEG.SYNERGY_EFFECT_ID = G.SYNERGY_EFFECT_ID
                       LEFT JOIN
                          CR_SYNERGY_EFFECT SEH
                       ON SEH.SYNERGY_EFFECT_ID = H.SYNERGY_EFFECT_ID
                    LEFT JOIN
                       CR_SYNERGY_EFFECT SEI
                    ON SEI.SYNERGY_EFFECT_ID = I.SYNERGY_EFFECT_ID
                 LEFT JOIN
                    CR_SYNERGY_EFFECT SEJ
                 ON SEJ.SYNERGY_EFFECT_ID = J.SYNERGY_EFFECT_ID
              LEFT JOIN
                 CR_SYNERGY_EFFECT SEK
              ON SEK.SYNERGY_EFFECT_ID = K.SYNERGY_EFFECT_ID
   ORDER BY   A.BUILD_ID;


