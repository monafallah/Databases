SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Prs].[spr_PersonalInfo](@value NVARCHAR(50),@OrganId INT)
AS

IF(@value<>0)
SELECT * FROM ( SELECT Prs.Prs_tblPersonalInfo.fldId, Prs.Prs_tblPersonalInfo.fldEmployeeId, fldSh_Shenasname, fldTarikhTavalod, 
                      fldMahalTavalodId,fldmahalsodoorId AS  fldMahlSodoorId, ISNULL(Com.tblEmployee_Detail.fldAddress,'')fldAddress,ISNULL(Com.tblEmployee_Detail.fldCodePosti,'')fldCodePosti, 
                      Prs.Prs_tblPersonalInfo.fldEsargariId, Prs.Prs_tblPersonalInfo.fldSharhEsargari, Prs.Prs_tblPersonalInfo.fldSh_Personali, fldMadrakId, 
                      fldreshteId AS  fldReshteTahsiliId,isnull( fldNezamVazifeId,0)fldNezamVazifeId, Prs.Prs_tblPersonalInfo.fldOrganPostId, Prs.Prs_tblPersonalInfo.fldRasteShoghli, 
                      Prs.Prs_tblPersonalInfo.fldReshteShoghli, Prs.Prs_tblPersonalInfo.fldTarikhEstekhdam, tblOrganizationalPosts.fldChartOrganId, Prs.Prs_tblPersonalInfo.fldTabaghe, 
                      fldMeliyat, Prs.Prs_tblPersonalInfo.fldSh_MojavezEstekhdam, Prs.Prs_tblPersonalInfo.fldTarikhMajavezEstekhdam, Prs.Prs_tblPersonalInfo.fldUserId, 
                      Prs.Prs_tblPersonalInfo.fldDesc, Prs.Prs_tblPersonalInfo.fldDate, CASE WHEN fldMeliyat = 0 THEN N'غیر ایرانی' ELSE N'ایرانی' END AS fldMeliyatName, 
                      tblMadrakTahsili.fldTitle AS fldMadrakTahsiliTitle, tblVaziyatEsargari.fldTitle AS fldVaziyatEsargariTitle,isnull( tblNezamVazife.fldTitle,'') AS fldNezamVazifeTitle, 
                      Com.tblEmployee.fldName + '_' + Com.tblEmployee.fldFamily AS fldNameEmployee, 
                      Com.tblEmployee.fldName, Com.tblEmployee.fldFamily, fldFatherName, 
                      fldJensiyat, tblChartOrgan.fldTitle AS fldTitleChartOrgan, Com.fn_stringDecode(tblOrganization.fldName) AS fldNameOrgan, 
                      Com.tblCity.fldName AS fldNameMahalTavalod, tblCity_1.fldName AS fldNameMahlSodoor, Com.tblEmployee.fldCodemeli, 
                      Com.tblEmployee_Detail.fldFileId, CASE WHEN fldJensiyat = 0 THEN N'زن' ELSE N'مرد' END AS fldNameJensiyat, 
                      tblOrganizationalPosts.fldTitle AS NamePostOran, tblReshteTahsili.fldTitle AS fldReshteTahsiliTitle, 
                      Com.tblEmployee.fldName + '_' + Com.tblEmployee.fldFamily + '(' + fldFatherName + ')'
                       AS fldName_FamilyEmployee, tblChartOrgan.fldOrganId,
                          (SELECT     TOP (1) Com.tblStatus.fldId
                            FROM          Com.tblPersonalStatus INNER JOIN
                                                   Com.tblStatus ON Com.tblPersonalStatus.fldStatusId = Com.tblStatus.fldId
                            WHERE      (Com.tblPersonalStatus.fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                            ORDER BY Com.tblPersonalStatus.fldId DESC) AS fldIdStatus,
                          (SELECT     TOP (1) Com.tblAnvaEstekhdam.fldTitle
                            FROM          Prs.tblHistoryNoeEstekhdam INNER JOIN
                                                   Com.tblAnvaEstekhdam ON Prs.tblHistoryNoeEstekhdam.fldNoeEstekhdamId = Com.tblAnvaEstekhdam.fldId
                            WHERE      (tblHistoryNoeEstekhdam.fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                            ORDER BY tblHistoryNoeEstekhdam.fldId DESC) AS fldNoeEstekhdamTitle,
                          (SELECT     TOP (1) tblStatus_2.fldTitle
                            FROM          Com.tblPersonalStatus AS tblPersonalStatus_2 INNER JOIN
                                                   Com.tblStatus AS tblStatus_2 ON tblPersonalStatus_2.fldStatusId = tblStatus_2.fldId
                            WHERE      (tblPersonalStatus_2.fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                            ORDER BY tblPersonalStatus_2.fldId DESC) AS fldTitleStatus, Pay.Pay_tblPersonalInfo.fldJobeCode,
                          (SELECT     TOP (1) tblAnvaEstekhdam_1.fldId
                            FROM          Prs.tblHistoryNoeEstekhdam AS tblHistoryNoeEstekhdam_1 INNER JOIN
                                                   Com.tblAnvaEstekhdam AS tblAnvaEstekhdam_1 ON tblHistoryNoeEstekhdam_1.fldNoeEstekhdamId =tblAnvaEstekhdam_1.fldId
                            WHERE      (tblHistoryNoeEstekhdam_1.fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                            ORDER BY tblHistoryNoeEstekhdam_1.fldId DESC) AS fldNoeEstekhdamId

FROM         Pay.Pay_tblPersonalInfo INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = Com.tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON Com.tblEmployee_Detail.fldEmployeeId = Com.tblEmployee.fldId INNER JOIN
                      Com.tblOrganizationalPosts ON Prs.Prs_tblPersonalInfo.fldOrganPostId = Com.tblOrganizationalPosts.fldId INNER JOIN
                      Com.tblChartOrgan ON Com.tblOrganizationalPosts.fldChartOrganId = Com.tblChartOrgan.fldId INNER JOIN
                      Com.tblOrganization ON Com.tblChartOrgan.fldOrganId = Com.tblOrganization.fldId INNER JOIN
                      Com.tblCity ON Com.tblEmployee_Detail.fldMahalTavalodId = Com.tblCity.fldId INNER JOIN
                      Com.tblCity AS tblCity_1 ON Com.tblEmployee_Detail.fldMahalSodoorId = tblCity_1.fldId INNER JOIN
                      Com.tblMadrakTahsili ON Com.tblEmployee_Detail.fldMadrakId = Com.tblMadrakTahsili.fldId INNER JOIN
                      Com.tblReshteTahsili ON Com.tblEmployee_Detail.fldReshteId = Com.tblReshteTahsili.fldId left JOIN
                      Com.tblNezamVazife ON Com.tblEmployee_Detail.fldNezamVazifeId = Com.tblNezamVazife.fldId left  JOIN
                      Com.tblStatusTaahol ON Com.tblEmployee_Detail.fldTaaholId = Com.tblStatusTaahol.fldId left JOIN
                      Prs.tblVaziyatEsargari ON Prs.Prs_tblPersonalInfo.fldEsargariId = Prs.tblVaziyatEsargari.fldId
					WHERE tblOrganization.fldId =@OrganId  and com.fn_MaxPersonalStatus(Prs.Prs_tblPersonalInfo.fldid,'kargozini')=1)t
					WHERE fldNoeEstekhdamId=@value 
					ORDER BY t.fldFamily DESC,t.fldName desc
else
 SELECT Prs.Prs_tblPersonalInfo.fldId, Prs.Prs_tblPersonalInfo.fldEmployeeId, fldSh_Shenasname, fldTarikhTavalod, 
                      fldMahalTavalodId,fldmahalsodoorId AS  fldMahlSodoorId, ISNULL(Com.tblEmployee_Detail.fldAddress,'')fldAddress,ISNULL(Com.tblEmployee_Detail.fldCodePosti,'')fldCodePosti, 
                      Prs.Prs_tblPersonalInfo.fldEsargariId, Prs.Prs_tblPersonalInfo.fldSharhEsargari, Prs.Prs_tblPersonalInfo.fldSh_Personali, fldMadrakId, 
                      fldreshteId AS  fldReshteTahsiliId,isnull( fldNezamVazifeId,0)fldNezamVazifeId, Prs.Prs_tblPersonalInfo.fldOrganPostId, Prs.Prs_tblPersonalInfo.fldRasteShoghli, 
                      Prs.Prs_tblPersonalInfo.fldReshteShoghli, Prs.Prs_tblPersonalInfo.fldTarikhEstekhdam, tblOrganizationalPosts.fldChartOrganId, Prs.Prs_tblPersonalInfo.fldTabaghe, 
                      fldMeliyat, Prs.Prs_tblPersonalInfo.fldSh_MojavezEstekhdam, Prs.Prs_tblPersonalInfo.fldTarikhMajavezEstekhdam, Prs.Prs_tblPersonalInfo.fldUserId, 
                      Prs.Prs_tblPersonalInfo.fldDesc, Prs.Prs_tblPersonalInfo.fldDate, CASE WHEN fldMeliyat = 0 THEN N'غیر ایرانی' ELSE N'ایرانی' END AS fldMeliyatName, 
                      tblMadrakTahsili.fldTitle AS fldMadrakTahsiliTitle, tblVaziyatEsargari.fldTitle AS fldVaziyatEsargariTitle,isnull( tblNezamVazife.fldTitle,'') AS fldNezamVazifeTitle, 
                      Com.tblEmployee.fldName + '_' + Com.tblEmployee.fldFamily AS fldNameEmployee, 
                      Com.tblEmployee.fldName, Com.tblEmployee.fldFamily, fldFatherName, 
                      fldJensiyat, tblChartOrgan.fldTitle AS fldTitleChartOrgan, Com.fn_stringDecode(tblOrganization.fldName) AS fldNameOrgan, 
                      Com.tblCity.fldName AS fldNameMahalTavalod, tblCity_1.fldName AS fldNameMahlSodoor, Com.tblEmployee.fldCodemeli, 
                      Com.tblEmployee_Detail.fldFileId, CASE WHEN fldJensiyat = 0 THEN N'زن' ELSE N'مرد' END AS fldNameJensiyat, 
                      tblOrganizationalPosts.fldTitle AS NamePostOran, tblReshteTahsili.fldTitle AS fldReshteTahsiliTitle, 
                      Com.tblEmployee.fldName + '_' + Com.tblEmployee.fldFamily + '(' + fldFatherName + ')'
                       AS fldName_FamilyEmployee, tblChartOrgan.fldOrganId,
                          (SELECT     TOP (1) Com.tblStatus.fldId
                            FROM          Com.tblPersonalStatus INNER JOIN
                                                   Com.tblStatus ON Com.tblPersonalStatus.fldStatusId = Com.tblStatus.fldId
                            WHERE      (Com.tblPersonalStatus.fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                            ORDER BY Com.tblPersonalStatus.fldId DESC) AS fldIdStatus,
                          (SELECT     TOP (1) Com.tblAnvaEstekhdam.fldTitle
                            FROM          Prs.tblHistoryNoeEstekhdam INNER JOIN
                                                   Com.tblAnvaEstekhdam ON Prs.tblHistoryNoeEstekhdam.fldNoeEstekhdamId = Com.tblAnvaEstekhdam.fldId
                            WHERE      (tblHistoryNoeEstekhdam.fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                            ORDER BY tblHistoryNoeEstekhdam.fldId DESC) AS fldNoeEstekhdamTitle,
                          (SELECT     TOP (1) tblStatus_2.fldTitle
                            FROM          Com.tblPersonalStatus AS tblPersonalStatus_2 INNER JOIN
                                                   Com.tblStatus AS tblStatus_2 ON tblPersonalStatus_2.fldStatusId = tblStatus_2.fldId
                            WHERE      (tblPersonalStatus_2.fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                            ORDER BY tblPersonalStatus_2.fldId DESC) AS fldTitleStatus, Pay.Pay_tblPersonalInfo.fldJobeCode,
                          (SELECT     TOP (1) tblAnvaEstekhdam_1.fldId
                            FROM          Prs.tblHistoryNoeEstekhdam AS tblHistoryNoeEstekhdam_1 INNER JOIN
                                                   Com.tblAnvaEstekhdam AS tblAnvaEstekhdam_1 ON tblHistoryNoeEstekhdam_1.fldNoeEstekhdamId =tblAnvaEstekhdam_1.fldId
                            WHERE      (tblHistoryNoeEstekhdam_1.fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                            ORDER BY tblHistoryNoeEstekhdam_1.fldId DESC) AS fldNoeEstekhdamId
FROM         Pay.Pay_tblPersonalInfo INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = Com.tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON Com.tblEmployee_Detail.fldEmployeeId = Com.tblEmployee.fldId INNER JOIN
                      Com.tblOrganizationalPosts ON Prs.Prs_tblPersonalInfo.fldOrganPostId = Com.tblOrganizationalPosts.fldId INNER JOIN
                      Com.tblChartOrgan ON Com.tblOrganizationalPosts.fldChartOrganId = Com.tblChartOrgan.fldId INNER JOIN
                      Com.tblOrganization ON Com.tblChartOrgan.fldOrganId = Com.tblOrganization.fldId INNER JOIN
                      Com.tblCity ON Com.tblEmployee_Detail.fldMahalTavalodId = Com.tblCity.fldId INNER JOIN
                      Com.tblCity AS tblCity_1 ON Com.tblEmployee_Detail.fldMahalSodoorId = tblCity_1.fldId INNER JOIN
                      Com.tblMadrakTahsili ON Com.tblEmployee_Detail.fldMadrakId = Com.tblMadrakTahsili.fldId INNER JOIN
                      Com.tblReshteTahsili ON Com.tblEmployee_Detail.fldReshteId = Com.tblReshteTahsili.fldId left JOIN
                      Com.tblNezamVazife ON Com.tblEmployee_Detail.fldNezamVazifeId = Com.tblNezamVazife.fldId left JOIN
                      Com.tblStatusTaahol ON Com.tblEmployee_Detail.fldTaaholId = Com.tblStatusTaahol.fldId left JOIN
                      Prs.tblVaziyatEsargari ON Prs.Prs_tblPersonalInfo.fldEsargariId = Prs.tblVaziyatEsargari.fldId
                     WHERE  tblOrganization.fldId =@OrganId and com.fn_MaxPersonalStatus(Prs.Prs_tblPersonalInfo.fldid,'kargozini')=1
                     				ORDER BY fldFamily DESC,fldName desc
GO
