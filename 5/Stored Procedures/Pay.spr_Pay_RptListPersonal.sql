SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_Pay_RptListPersonal](@value INT,@h INT,@organId INT)
AS
IF(@h=0) SET @h=2147483647
IF(@value=0)
SELECT   distinct  Pay.Pay_tblPersonalInfo.fldId, tblEmployee.fldFamily + '_' + tblEmployee.fldName AS fldName_Family, Com.tblEmployee_Detail.fldFatherName, 
                      tblEmployee.fldCodemeli, CASE WHEN fldJensiyat = 0 THEN N'زن' ELSE N'مرد' END AS fldNameJensiyat, Com.tblEmployee_Detail.fldSh_Shenasname, 
                      Com.tblEmployee_Detail.fldTarikhTavalod, Com.tblMadrakTahsili.fldTitle AS fldMadrakTahsili, Pay.tblCostCenter.fldTitle AS fldCostCenterTitle, 
                      Com.tblTypeBime.fldTitle AS fldTypeBimeTitle, Prs.tblVaziyatEsargari.fldTitle AS fldVaziyatEsargariTitle, Com.tblNezamVazife.fldTitle AS fldNezamVazifeTitle, 
                      tblMahaleTavalod.fldName AS fldMahaleTavalodName, tblMahaleSodoor.fldName AS fldMahaleSodoorName, Com.tblStatusTaahol.fldTitle AS fldStatusTaaholTitle,
                          (SELECT     Com.tblStatus.fldTitle
                            FROM          Com.tblPersonalStatus INNER JOIN
                                                   Com.tblStatus ON Com.tblPersonalStatus.fldStatusId = Com.tblStatus.fldId
                            WHERE      (Com.tblPersonalStatus.fldId IN
                                                       (SELECT top(1)    Id
                                                         FROM          Com.fn_MaxPersonalStatusTable(Pay.Pay_tblPersonalInfo.fldId) AS fn_MaxPersonalStatusTable_1  order by id desc))) AS fldStatusTitle, 
                      Pay.Pay_tblPersonalInfo.fldShomareBime, Prs.Prs_tblPersonalInfo.fldTarikhEstekhdam, Prs.Prs_tblPersonalInfo.fldRasteShoghli, ISNULL
                          ((SELECT     TOP (1) Com.tblAnvaEstekhdam.fldTitle
                              FROM         Prs.tblPersonalHokm AS tblPersonalHokm_1 INNER JOIN
                                                    Com.tblAnvaEstekhdam ON tblPersonalHokm_1.fldAnvaeEstekhdamId = Com.tblAnvaEstekhdam.fldId
                              WHERE     (tblPersonalHokm_1.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                              ORDER BY tblPersonalHokm_1.fldId DESC), '') AS fldAnvaEstekhdamTitle, Prs.Prs_tblPersonalInfo.fldSh_Personali,
                          (SELECT     fldImage
                            FROM          Com.tblFile
                            WHERE      (fldId = Com.tblEmployee_Detail.fldFileId)) AS fldImage, Com.fn_MaxPersonalStatus(Pay.Pay_tblPersonalInfo.fldId, N'hoghoghi') AS fldStatusId, 
                       Com.tblShomareHesabeOmoomi.fldShomareHesab AS fldShomareHesabPersonal, tblShomareHesabeOmoomi_1.fldShomareHesab AS fldShomareHesabKarfarma, 
                      Com.fn_stringDecode(tblOrganization.fldName) + '_' + tblChartOrgan.fldTitle AS fldMahaleKhedmat
FROM         Pay.Pay_tblPersonalInfo INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblTypeBime ON Pay.Pay_tblPersonalInfo.fldTypeBimeId = Com.tblTypeBime.fldId INNER JOIN
                      Pay.tblCostCenter ON Pay.Pay_tblPersonalInfo.fldCostCenterId = Pay.tblCostCenter.fldId INNER JOIN
                      Prs.tblVaziyatEsargari ON Prs.Prs_tblPersonalInfo.fldEsargariId = Prs.tblVaziyatEsargari.fldId INNER JOIN
                      Com.tblOrganizationalPosts AS tblOrganizationalPosts ON Prs.Prs_tblPersonalInfo.fldOrganPostId = tblOrganizationalPosts.fldId INNER JOIN
                      Com.tblChartOrgan AS tblChartOrgan ON tblOrganizationalPosts.fldChartOrganId = tblChartOrgan.fldId INNER JOIN
                      Com.tblOrganization AS tblOrganization ON tblChartOrgan.fldOrganId = tblOrganization.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
                      Com.tblCity AS tblMahaleTavalod ON Com.tblEmployee_Detail.fldMahalTavalodId = tblMahaleTavalod.fldId INNER JOIN
                      Com.tblCity AS tblMahaleSodoor ON Com.tblEmployee_Detail.fldMahalSodoorId = tblMahaleSodoor.fldId INNER JOIN
                      Com.tblMadrakTahsili ON Com.tblEmployee_Detail.fldMadrakId = Com.tblMadrakTahsili.fldId INNER JOIN
                      Com.tblNezamVazife ON Com.tblEmployee_Detail.fldNezamVazifeId = Com.tblNezamVazife.fldId INNER JOIN
                      Com.tblStatusTaahol ON Com.tblEmployee_Detail.fldTaaholId = Com.tblStatusTaahol.fldId INNER JOIN
                      Com.tblAshkhas ON tblEmployee.fldId = Com.tblAshkhas.fldHaghighiId INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Com.tblAshkhas.fldId = Com.tblShomareHesabeOmoomi.fldAshkhasId INNER JOIN
                      Pay.tblShomareHesabPasAndaz ON Com.tblShomareHesabeOmoomi.fldId = Pay.tblShomareHesabPasAndaz.fldShomareHesabPersonalId INNER JOIN
                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON 
                      tblShomareHesabeOmoomi_1.fldId = Pay.tblShomareHesabPasAndaz.fldShomareHesabKarfarmaId
                      WHERE Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId)=@organId
  ELSE
SELECT     Pay.Pay_tblPersonalInfo.fldId, tblEmployee.fldFamily + '_' + tblEmployee.fldName AS fldName_Family, Com.tblEmployee_Detail.fldFatherName, 
                      tblEmployee.fldCodemeli, CASE WHEN fldJensiyat = 0 THEN N'زن' ELSE N'مرد' END AS fldNameJensiyat, Com.tblEmployee_Detail.fldSh_Shenasname, 
                      Com.tblEmployee_Detail.fldTarikhTavalod, Com.tblMadrakTahsili.fldTitle AS fldMadrakTahsili, Pay.tblCostCenter.fldTitle AS fldCostCenterTitle, 
                      Com.tblTypeBime.fldTitle AS fldTypeBimeTitle, Prs.tblVaziyatEsargari.fldTitle AS fldVaziyatEsargariTitle, Com.tblNezamVazife.fldTitle AS fldNezamVazifeTitle, 
                      tblMahaleTavalod.fldName AS fldMahaleTavalodName, tblMahaleSodoor.fldName AS fldMahaleSodoorName, Com.tblStatusTaahol.fldTitle AS fldStatusTaaholTitle,
                          (SELECT     Com.tblStatus.fldTitle
                            FROM          Com.tblPersonalStatus INNER JOIN
                                                   Com.tblStatus ON Com.tblPersonalStatus.fldStatusId = Com.tblStatus.fldId
                            WHERE      (Com.tblPersonalStatus.fldId IN
                                                       (SELECT   top(1)  Id
                                                         FROM          Com.fn_MaxPersonalStatusTable(Pay.Pay_tblPersonalInfo.fldId) AS fn_MaxPersonalStatusTable_1 order by id desc))) AS fldStatusTitle, 
                      Pay.Pay_tblPersonalInfo.fldShomareBime, Prs.Prs_tblPersonalInfo.fldTarikhEstekhdam, Prs.Prs_tblPersonalInfo.fldRasteShoghli, ISNULL
                          ((SELECT     TOP (1) Com.tblAnvaEstekhdam.fldTitle
                              FROM         Prs.tblPersonalHokm AS tblPersonalHokm_1 INNER JOIN
                                                    Com.tblAnvaEstekhdam ON tblPersonalHokm_1.fldAnvaeEstekhdamId = Com.tblAnvaEstekhdam.fldId
                              WHERE     (tblPersonalHokm_1.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                              ORDER BY tblPersonalHokm_1.fldId DESC), '') AS fldAnvaEstekhdamTitle, Prs.Prs_tblPersonalInfo.fldSh_Personali,
                          (SELECT     fldImage
                            FROM          Com.tblFile
                            WHERE      (fldId = Com.tblEmployee_Detail.fldFileId)) AS fldImage, Com.fn_MaxPersonalStatus(Pay.Pay_tblPersonalInfo.fldId, N'hoghoghi') AS fldStatusId, 
                       Com.tblShomareHesabeOmoomi.fldShomareHesab AS fldShomareHesabPersonal, tblShomareHesabeOmoomi_1.fldShomareHesab AS fldShomareHesabKarfarma, 
                      Com.fn_stringDecode(tblOrganization.fldName) + '_' + tblChartOrgan.fldTitle AS fldMahaleKhedmat
FROM         Pay.Pay_tblPersonalInfo INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblTypeBime ON Pay.Pay_tblPersonalInfo.fldTypeBimeId = Com.tblTypeBime.fldId INNER JOIN
                      Pay.tblCostCenter ON Pay.Pay_tblPersonalInfo.fldCostCenterId = Pay.tblCostCenter.fldId INNER JOIN
                      Prs.tblVaziyatEsargari ON Prs.Prs_tblPersonalInfo.fldEsargariId = Prs.tblVaziyatEsargari.fldId INNER JOIN
                      Com.tblOrganizationalPosts AS tblOrganizationalPosts ON Prs.Prs_tblPersonalInfo.fldOrganPostId = tblOrganizationalPosts.fldId INNER JOIN
                      Com.tblChartOrgan AS tblChartOrgan ON tblOrganizationalPosts.fldChartOrganId = tblChartOrgan.fldId INNER JOIN
                      Com.tblOrganization AS tblOrganization ON tblChartOrgan.fldOrganId = tblOrganization.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
                      Com.tblCity AS tblMahaleTavalod ON Com.tblEmployee_Detail.fldMahalTavalodId = tblMahaleTavalod.fldId INNER JOIN
                      Com.tblCity AS tblMahaleSodoor ON Com.tblEmployee_Detail.fldMahalSodoorId = tblMahaleSodoor.fldId INNER JOIN
                      Com.tblMadrakTahsili ON Com.tblEmployee_Detail.fldMadrakId = Com.tblMadrakTahsili.fldId INNER JOIN
                      Com.tblNezamVazife ON Com.tblEmployee_Detail.fldNezamVazifeId = Com.tblNezamVazife.fldId INNER JOIN
                      Com.tblStatusTaahol ON Com.tblEmployee_Detail.fldTaaholId = Com.tblStatusTaahol.fldId INNER JOIN
                      Com.tblAshkhas ON tblEmployee.fldId = Com.tblAshkhas.fldHaghighiId INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Com.tblAshkhas.fldId = Com.tblShomareHesabeOmoomi.fldAshkhasId INNER JOIN
                      Pay.tblShomareHesabPasAndaz ON Com.tblShomareHesabeOmoomi.fldId = Pay.tblShomareHesabPasAndaz.fldShomareHesabPersonalId INNER JOIN
                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON 
                      tblShomareHesabeOmoomi_1.fldId = Pay.tblShomareHesabPasAndaz.fldShomareHesabKarfarmaId
                     WHERE Pay.Pay_tblPersonalInfo.fldId=@value  AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId)=@organId  
GO
