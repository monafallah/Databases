SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Prs].[spr_Prs_tblPersonalInfoSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@OrganId INT,
	@h int
AS 
	BEGIN TRAN
	if (@h=0) set @h=2147483647
	SET @Value=Com.fn_TextNormalize(@Value)
	if (@fieldname=N'fldId')
SELECT    top(@h) Prs.Prs_tblPersonalInfo.fldId, Prs.Prs_tblPersonalInfo.fldEmployeeId, Com.tblEmployee_Detail.fldSh_Shenasname, 
                      Com.tblEmployee_Detail.fldTarikhTavalod, Com.tblEmployee_Detail.fldMahalTavalodId, Com.tblEmployee_Detail.fldMahalSodoorId, 
                      ISNULL(Com.tblEmployee_Detail.fldAddress,'')AS fldAddress, ISNULL(Com.tblEmployee_Detail.fldCodePosti,'') AS fldCodePosti, Prs.Prs_tblPersonalInfo.fldEsargariId, Prs.Prs_tblPersonalInfo.fldSharhEsargari, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali, t.fldMadrakId, t.fldReshteId, Com.tblEmployee_Detail.fldNezamVazifeId, 
                      Prs.Prs_tblPersonalInfo.fldOrganPostId, Prs.Prs_tblPersonalInfo.fldRasteShoghli, Prs.Prs_tblPersonalInfo.fldReshteShoghli, 
                      Prs.Prs_tblPersonalInfo.fldTarikhEstekhdam, tblOrganizationalPosts.fldChartOrganId, Prs.Prs_tblPersonalInfo.fldTabaghe, Com.tblEmployee_Detail.fldMeliyat, 
                      Prs.Prs_tblPersonalInfo.fldSh_MojavezEstekhdam, Prs.Prs_tblPersonalInfo.fldTarikhMajavezEstekhdam, Prs.Prs_tblPersonalInfo.fldUserId, 
                      Prs.Prs_tblPersonalInfo.fldDesc, Prs.Prs_tblPersonalInfo.fldDate, CASE WHEN fldMeliyat = 0 THEN N'غیر ایرانی' ELSE N'ایرانی' END AS fldMeliyatName, 
                      t.fldMadrakTahsiliTitle, Prs.tblVaziyatEsargari.fldTitle AS fldVaziyatEsargariTitle, ISNULL(Com.tblNezamVazife.fldTitle ,'') AS fldNezamVazifeTitle, 
                      Com.tblEmployee.fldName + '_' + Com.tblEmployee.fldFamily AS fldNameEmployee, Com.tblEmployee.fldName, Com.tblEmployee.fldFamily, 
                      Com.tblEmployee_Detail.fldFatherName, Com.tblEmployee_Detail.fldJensiyat, tblChartOrgan.fldTitle AS fldTitleChartOrgan, 
                      (SELECT Com.fn_stringDecode(tblOrganization.fldName) FROM Com.tblOrganization WHERE fldid = [Com].[fn_OrganName] (fldOrganPostId)) AS fldNameOrgan, Com.tblCity.fldName AS fldNameMahalTavalod, tblCity_1.fldName AS fldNameMahlSodoor, 
                      Com.tblEmployee.fldCodemeli, Com.tblEmployee_Detail.fldFileId, CASE WHEN fldJensiyat = 0 THEN N'زن' ELSE N'مرد' END AS fldNameJensiyat, 
                      tblOrganizationalPosts.fldTitle/*+'_'+tblOrganizationalPosts.fldOrgPostCode*/ AS NamePostOran, t.fldReshteTahsiliTitle, 
                      Com.tblEmployee.fldFamily + '_' + Com.tblEmployee.fldName + '(' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName_FamilyEmployee,  Com.tblEmployee_Detail.fldTel, Com.tblEmployee_Detail.fldMobile,
                      ISNULL(tblChartOrgan.fldOrganId, 0) AS fldOrganId, ISNULL
                          ((SELECT     TOP (1) fldId
                              FROM         Com.tblPersonalStatus
                              WHERE     (fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                              ORDER BY fldId DESC), 0) AS fldIdStatus, ISNULL
                          ((SELECT     TOP (1) fldNoeEstekhdamId
                              FROM         Prs.tblHistoryNoeEstekhdam
                              WHERE     (fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                              ORDER BY fldId DESC), 0) AS fldNoeEstekhdam,
                          (SELECT     TOP (1) Com.tblStatus.fldTitle
                            FROM          Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                                   Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                            WHERE      (tblPersonalStatus_1.fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                            ORDER BY tblPersonalStatus_1.fldId DESC) AS fldTitleStatus,fldTarikhSodoor,fldTaaholId,
                            ISNULL((SELECT     TOP (1)  Com.tblAnvaEstekhdam.fldTitle
FROM         Prs.tblHistoryNoeEstekhdam INNER JOIN
                      Com.tblAnvaEstekhdam ON Prs.tblHistoryNoeEstekhdam.fldNoeEstekhdamId = Com.tblAnvaEstekhdam.fldId
                              WHERE     (fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                              ORDER BY tblHistoryNoeEstekhdam.fldId DESC), '')AS TitleNoeEstekhdam,fldOrganPostEjraeeId
							  ,tblOrganizationalPostsEjraee.fldTitle+'_'+tblOrganizationalPostsEjraee.fldOrgPostCode AS TitleOrganPostEjraee,
							  Com.tblChartOrganEjraee.fldTitle AS TitleChartOrganEjraee

FROM         Prs.Prs_tblPersonalInfo INNER JOIN
                      Com.tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = Com.tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON Com.tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
                      Com.tblStatusTaahol ON Com.tblEmployee_Detail.fldTaaholId = Com.tblStatusTaahol.fldId INNER JOIN
                      Com.tblCity ON Com.tblEmployee_Detail.fldMahalTavalodId = Com.tblCity.fldId INNER JOIN
                      Com.tblCity AS tblCity_1 ON Com.tblEmployee_Detail.fldMahalSodoorId = tblCity_1.fldId INNER JOIN
                      Prs.tblVaziyatEsargari ON Prs.Prs_tblPersonalInfo.fldEsargariId = Prs.tblVaziyatEsargari.fldId INNER JOIN
                      Com.tblOrganizationalPosts ON Prs.Prs_tblPersonalInfo.fldOrganPostId = Com.tblOrganizationalPosts.fldId INNER JOIN
                      Com.tblChartOrgan ON Com.tblOrganizationalPosts.fldChartOrganId = Com.tblChartOrgan.fldId LEFT OUTER JOIN
					  Com.tblNezamVazife ON Com.tblEmployee_Detail.fldNezamVazifeId = Com.tblNezamVazife.fldId   LEFT outer JOIN
					  com.tblOrganizationalPostsEjraee ON Prs.Prs_tblPersonalInfo.fldOrganPostEjraeeId=com.tblOrganizationalPostsEjraee.fldId LEFT outer JOIN
					  com.tblChartOrganEjraee ON com.tblOrganizationalPostsEjraee.fldChartOrganId =	com.tblChartOrganEjraee.fldid
					   OUTER APPLY (SELECT top(1) t.fldMadrakId,t.fldReshteId,tblMadrakTahsili.fldTitle as fldMadrakTahsiliTitle,tblReshteTahsili.fldtitle as fldReshteTahsiliTitle
										from com.tblHistoryTahsilat as t inner join 
									    Com.tblMadrakTahsili ON t.fldMadrakId = Com.tblMadrakTahsili.fldId INNER JOIN
									    Com.tblReshteTahsili ON t.fldReshteId = Com.tblReshteTahsili.fldId 
									   where t.fldEmployeeId=tblEmployee.fldid order by T.fldTarikh DESC)t
                      	WHERE  Prs_tblPersonalInfo.fldId = @Value AND com.fn_organId(Prs_tblPersonalInfo.fldid) =@OrganId
                     ORDER BY Prs_tblPersonalInfo.fldId DESC

if (@fieldname=N'Mohassel')
SELECT    top(@h) Prs.Prs_tblPersonalInfo.fldId, Prs.Prs_tblPersonalInfo.fldEmployeeId, Com.tblEmployee_Detail.fldSh_Shenasname, 
                      Com.tblEmployee_Detail.fldTarikhTavalod, Com.tblEmployee_Detail.fldMahalTavalodId, Com.tblEmployee_Detail.fldMahalSodoorId, 
                      ISNULL(Com.tblEmployee_Detail.fldAddress,'')AS fldAddress, ISNULL(Com.tblEmployee_Detail.fldCodePosti,'') AS fldCodePosti, Prs.Prs_tblPersonalInfo.fldEsargariId, Prs.Prs_tblPersonalInfo.fldSharhEsargari, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali, t.fldMadrakId, t.fldReshteId, Com.tblEmployee_Detail.fldNezamVazifeId, 
                      Prs.Prs_tblPersonalInfo.fldOrganPostId, Prs.Prs_tblPersonalInfo.fldRasteShoghli, Prs.Prs_tblPersonalInfo.fldReshteShoghli, 
                      Prs.Prs_tblPersonalInfo.fldTarikhEstekhdam, tblOrganizationalPosts.fldChartOrganId, Prs.Prs_tblPersonalInfo.fldTabaghe, Com.tblEmployee_Detail.fldMeliyat, 
                      Prs.Prs_tblPersonalInfo.fldSh_MojavezEstekhdam, Prs.Prs_tblPersonalInfo.fldTarikhMajavezEstekhdam, Prs.Prs_tblPersonalInfo.fldUserId, 
                      Prs.Prs_tblPersonalInfo.fldDesc, Prs.Prs_tblPersonalInfo.fldDate, CASE WHEN fldMeliyat = 0 THEN N'غیر ایرانی' ELSE N'ایرانی' END AS fldMeliyatName, 
                      t.fldMadrakTahsiliTitle, Prs.tblVaziyatEsargari.fldTitle AS fldVaziyatEsargariTitle, ISNULL(Com.tblNezamVazife.fldTitle ,'') AS fldNezamVazifeTitle, 
                      Com.tblEmployee.fldName + '_' + Com.tblEmployee.fldFamily AS fldNameEmployee, Com.tblEmployee.fldName, Com.tblEmployee.fldFamily, 
                      Com.tblEmployee_Detail.fldFatherName, Com.tblEmployee_Detail.fldJensiyat, tblChartOrgan.fldTitle AS fldTitleChartOrgan, 
                      (SELECT Com.fn_stringDecode(tblOrganization.fldName) FROM Com.tblOrganization WHERE fldid = [Com].[fn_OrganName] (fldOrganPostId)) AS fldNameOrgan, Com.tblCity.fldName AS fldNameMahalTavalod, tblCity_1.fldName AS fldNameMahlSodoor, 
                      Com.tblEmployee.fldCodemeli, Com.tblEmployee_Detail.fldFileId, CASE WHEN fldJensiyat = 0 THEN N'زن' ELSE N'مرد' END AS fldNameJensiyat, 
                      tblOrganizationalPosts.fldTitle/*+'_'+tblOrganizationalPosts.fldOrgPostCode*/ AS NamePostOran, t.fldReshteTahsiliTitle, 
                      Com.tblEmployee.fldFamily + '_' + Com.tblEmployee.fldName + '(' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName_FamilyEmployee,  Com.tblEmployee_Detail.fldTel, Com.tblEmployee_Detail.fldMobile,
                      ISNULL(tblChartOrgan.fldOrganId, 0) AS fldOrganId, ISNULL
                          ((SELECT     TOP (1) fldId
                              FROM         Com.tblPersonalStatus
                              WHERE     (fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                              ORDER BY fldId DESC), 0) AS fldIdStatus, ISNULL
                          ((SELECT     TOP (1) fldNoeEstekhdamId
                              FROM         Prs.tblHistoryNoeEstekhdam
                              WHERE     (fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                              ORDER BY fldId DESC), 0) AS fldNoeEstekhdam,
                          (SELECT     TOP (1) Com.tblStatus.fldTitle
                            FROM          Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                                   Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                            WHERE      (tblPersonalStatus_1.fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                            ORDER BY tblPersonalStatus_1.fldId DESC) AS fldTitleStatus,fldTarikhSodoor,fldTaaholId,
                            ISNULL((SELECT     TOP (1)  Com.tblAnvaEstekhdam.fldTitle
FROM         Prs.tblHistoryNoeEstekhdam INNER JOIN
                      Com.tblAnvaEstekhdam ON Prs.tblHistoryNoeEstekhdam.fldNoeEstekhdamId = Com.tblAnvaEstekhdam.fldId
                              WHERE     (fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                              ORDER BY tblHistoryNoeEstekhdam.fldId DESC), '')AS TitleNoeEstekhdam,fldOrganPostEjraeeId
							  ,tblOrganizationalPostsEjraee.fldTitle+'_'+tblOrganizationalPostsEjraee.fldOrgPostCode AS TitleOrganPostEjraee,
							  Com.tblChartOrganEjraee.fldTitle AS TitleChartOrganEjraee

FROM         Prs.Prs_tblPersonalInfo INNER JOIN
                      Com.tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = Com.tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON Com.tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
                      Com.tblStatusTaahol ON Com.tblEmployee_Detail.fldTaaholId = Com.tblStatusTaahol.fldId INNER JOIN
                      Com.tblCity ON Com.tblEmployee_Detail.fldMahalTavalodId = Com.tblCity.fldId INNER JOIN
                      Com.tblCity AS tblCity_1 ON Com.tblEmployee_Detail.fldMahalSodoorId = tblCity_1.fldId INNER JOIN
                      Prs.tblVaziyatEsargari ON Prs.Prs_tblPersonalInfo.fldEsargariId = Prs.tblVaziyatEsargari.fldId INNER JOIN
                      Com.tblOrganizationalPosts ON Prs.Prs_tblPersonalInfo.fldOrganPostId = Com.tblOrganizationalPosts.fldId INNER JOIN
                      Com.tblChartOrgan ON Com.tblOrganizationalPosts.fldChartOrganId = Com.tblChartOrgan.fldId LEFT OUTER JOIN
					  Com.tblNezamVazife ON Com.tblEmployee_Detail.fldNezamVazifeId = Com.tblNezamVazife.fldId   LEFT outer JOIN
					  com.tblOrganizationalPostsEjraee ON Prs.Prs_tblPersonalInfo.fldOrganPostEjraeeId=com.tblOrganizationalPostsEjraee.fldId LEFT outer JOIN
					  com.tblChartOrganEjraee ON com.tblOrganizationalPostsEjraee.fldChartOrganId =	com.tblChartOrganEjraee.fldid
					   OUTER APPLY (SELECT top(1) t.fldMadrakId,t.fldReshteId,tblMadrakTahsili.fldTitle as fldMadrakTahsiliTitle,tblReshteTahsili.fldtitle as fldReshteTahsiliTitle
										from com.tblHistoryTahsilat as t inner join 
									    Com.tblMadrakTahsili ON t.fldMadrakId = Com.tblMadrakTahsili.fldId INNER JOIN
									    Com.tblReshteTahsili ON t.fldReshteId = Com.tblReshteTahsili.fldId 
									   where t.fldEmployeeId=tblEmployee.fldid order by T.fldTarikh DESC)t
                      	WHERE   com.fn_organId(Prs_tblPersonalInfo.fldid) =@OrganId and exists(select * from prs.tblAfradTahtePooshesh where fldPersonalId= Prs_tblPersonalInfo.fldId and fldNesbatShakhs=1)
                     ORDER BY fldFamily,fldName 

if (@fieldname=N'fldCodemeliـMohassel')
SELECT    top(@h) Prs.Prs_tblPersonalInfo.fldId, Prs.Prs_tblPersonalInfo.fldEmployeeId, Com.tblEmployee_Detail.fldSh_Shenasname, 
                      Com.tblEmployee_Detail.fldTarikhTavalod, Com.tblEmployee_Detail.fldMahalTavalodId, Com.tblEmployee_Detail.fldMahalSodoorId, 
                      ISNULL(Com.tblEmployee_Detail.fldAddress,'')AS fldAddress, ISNULL(Com.tblEmployee_Detail.fldCodePosti,'') AS fldCodePosti, Prs.Prs_tblPersonalInfo.fldEsargariId, Prs.Prs_tblPersonalInfo.fldSharhEsargari, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali, t.fldMadrakId, t.fldReshteId, Com.tblEmployee_Detail.fldNezamVazifeId, 
                      Prs.Prs_tblPersonalInfo.fldOrganPostId, Prs.Prs_tblPersonalInfo.fldRasteShoghli, Prs.Prs_tblPersonalInfo.fldReshteShoghli, 
                      Prs.Prs_tblPersonalInfo.fldTarikhEstekhdam, tblOrganizationalPosts.fldChartOrganId, Prs.Prs_tblPersonalInfo.fldTabaghe, Com.tblEmployee_Detail.fldMeliyat, 
                      Prs.Prs_tblPersonalInfo.fldSh_MojavezEstekhdam, Prs.Prs_tblPersonalInfo.fldTarikhMajavezEstekhdam, Prs.Prs_tblPersonalInfo.fldUserId, 
                      Prs.Prs_tblPersonalInfo.fldDesc, Prs.Prs_tblPersonalInfo.fldDate, CASE WHEN fldMeliyat = 0 THEN N'غیر ایرانی' ELSE N'ایرانی' END AS fldMeliyatName, 
                      t.fldMadrakTahsiliTitle, Prs.tblVaziyatEsargari.fldTitle AS fldVaziyatEsargariTitle, ISNULL(Com.tblNezamVazife.fldTitle ,'') AS fldNezamVazifeTitle, 
                      Com.tblEmployee.fldName + '_' + Com.tblEmployee.fldFamily AS fldNameEmployee, Com.tblEmployee.fldName, Com.tblEmployee.fldFamily, 
                      Com.tblEmployee_Detail.fldFatherName, Com.tblEmployee_Detail.fldJensiyat, tblChartOrgan.fldTitle AS fldTitleChartOrgan, 
                      (SELECT Com.fn_stringDecode(tblOrganization.fldName) FROM Com.tblOrganization WHERE fldid = [Com].[fn_OrganName] (fldOrganPostId)) AS fldNameOrgan, Com.tblCity.fldName AS fldNameMahalTavalod, tblCity_1.fldName AS fldNameMahlSodoor, 
                      Com.tblEmployee.fldCodemeli, Com.tblEmployee_Detail.fldFileId, CASE WHEN fldJensiyat = 0 THEN N'زن' ELSE N'مرد' END AS fldNameJensiyat, 
                      tblOrganizationalPosts.fldTitle/*+'_'+tblOrganizationalPosts.fldOrgPostCode*/ AS NamePostOran, t.fldReshteTahsiliTitle, 
                      Com.tblEmployee.fldFamily + '_' + Com.tblEmployee.fldName + '(' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName_FamilyEmployee,  Com.tblEmployee_Detail.fldTel, Com.tblEmployee_Detail.fldMobile,
                      ISNULL(tblChartOrgan.fldOrganId, 0) AS fldOrganId, ISNULL
                          ((SELECT     TOP (1) fldId
                              FROM         Com.tblPersonalStatus
                              WHERE     (fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                              ORDER BY fldId DESC), 0) AS fldIdStatus, ISNULL
                          ((SELECT     TOP (1) fldNoeEstekhdamId
                              FROM         Prs.tblHistoryNoeEstekhdam
                              WHERE     (fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                              ORDER BY fldId DESC), 0) AS fldNoeEstekhdam,
                          (SELECT     TOP (1) Com.tblStatus.fldTitle
                            FROM          Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                                   Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                            WHERE      (tblPersonalStatus_1.fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                            ORDER BY tblPersonalStatus_1.fldId DESC) AS fldTitleStatus,fldTarikhSodoor,fldTaaholId,
                            ISNULL((SELECT     TOP (1)  Com.tblAnvaEstekhdam.fldTitle
FROM         Prs.tblHistoryNoeEstekhdam INNER JOIN
                      Com.tblAnvaEstekhdam ON Prs.tblHistoryNoeEstekhdam.fldNoeEstekhdamId = Com.tblAnvaEstekhdam.fldId
                              WHERE     (fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                              ORDER BY tblHistoryNoeEstekhdam.fldId DESC), '')AS TitleNoeEstekhdam,fldOrganPostEjraeeId
							  ,tblOrganizationalPostsEjraee.fldTitle+'_'+tblOrganizationalPostsEjraee.fldOrgPostCode AS TitleOrganPostEjraee,
							  Com.tblChartOrganEjraee.fldTitle AS TitleChartOrganEjraee

FROM         Prs.Prs_tblPersonalInfo INNER JOIN
                      Com.tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = Com.tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON Com.tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
                      Com.tblStatusTaahol ON Com.tblEmployee_Detail.fldTaaholId = Com.tblStatusTaahol.fldId INNER JOIN
                      Com.tblCity ON Com.tblEmployee_Detail.fldMahalTavalodId = Com.tblCity.fldId INNER JOIN
                      Com.tblCity AS tblCity_1 ON Com.tblEmployee_Detail.fldMahalSodoorId = tblCity_1.fldId INNER JOIN
                      Prs.tblVaziyatEsargari ON Prs.Prs_tblPersonalInfo.fldEsargariId = Prs.tblVaziyatEsargari.fldId INNER JOIN
                      Com.tblOrganizationalPosts ON Prs.Prs_tblPersonalInfo.fldOrganPostId = Com.tblOrganizationalPosts.fldId INNER JOIN
                      Com.tblChartOrgan ON Com.tblOrganizationalPosts.fldChartOrganId = Com.tblChartOrgan.fldId LEFT OUTER JOIN
					  Com.tblNezamVazife ON Com.tblEmployee_Detail.fldNezamVazifeId = Com.tblNezamVazife.fldId   LEFT outer JOIN
					  com.tblOrganizationalPostsEjraee ON Prs.Prs_tblPersonalInfo.fldOrganPostEjraeeId=com.tblOrganizationalPostsEjraee.fldId LEFT outer JOIN
					  com.tblChartOrganEjraee ON com.tblOrganizationalPostsEjraee.fldChartOrganId =	com.tblChartOrganEjraee.fldid
					   OUTER APPLY (SELECT top(1) t.fldMadrakId,t.fldReshteId,tblMadrakTahsili.fldTitle as fldMadrakTahsiliTitle,tblReshteTahsili.fldtitle as fldReshteTahsiliTitle
										from com.tblHistoryTahsilat as t inner join 
									    Com.tblMadrakTahsili ON t.fldMadrakId = Com.tblMadrakTahsili.fldId INNER JOIN
									    Com.tblReshteTahsili ON t.fldReshteId = Com.tblReshteTahsili.fldId 
									   where t.fldEmployeeId=tblEmployee.fldid order by T.fldTarikh DESC)t
                      	WHERE  fldCodemeli like @Value and  com.fn_organId(Prs_tblPersonalInfo.fldid) =@OrganId and exists(select * from prs.tblAfradTahtePooshesh where fldPersonalId= Prs_tblPersonalInfo.fldId and fldNesbatShakhs=1)
                     ORDER BY fldFamily,fldName 

if (@fieldname=N'fldName_FamilyEmployeeـMohassel')
SELECT    top(@h) Prs.Prs_tblPersonalInfo.fldId, Prs.Prs_tblPersonalInfo.fldEmployeeId, Com.tblEmployee_Detail.fldSh_Shenasname, 
                      Com.tblEmployee_Detail.fldTarikhTavalod, Com.tblEmployee_Detail.fldMahalTavalodId, Com.tblEmployee_Detail.fldMahalSodoorId, 
                      ISNULL(Com.tblEmployee_Detail.fldAddress,'')AS fldAddress, ISNULL(Com.tblEmployee_Detail.fldCodePosti,'') AS fldCodePosti, Prs.Prs_tblPersonalInfo.fldEsargariId, Prs.Prs_tblPersonalInfo.fldSharhEsargari, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali, t.fldMadrakId, t.fldReshteId, Com.tblEmployee_Detail.fldNezamVazifeId, 
                      Prs.Prs_tblPersonalInfo.fldOrganPostId, Prs.Prs_tblPersonalInfo.fldRasteShoghli, Prs.Prs_tblPersonalInfo.fldReshteShoghli, 
                      Prs.Prs_tblPersonalInfo.fldTarikhEstekhdam, tblOrganizationalPosts.fldChartOrganId, Prs.Prs_tblPersonalInfo.fldTabaghe, Com.tblEmployee_Detail.fldMeliyat, 
                      Prs.Prs_tblPersonalInfo.fldSh_MojavezEstekhdam, Prs.Prs_tblPersonalInfo.fldTarikhMajavezEstekhdam, Prs.Prs_tblPersonalInfo.fldUserId, 
                      Prs.Prs_tblPersonalInfo.fldDesc, Prs.Prs_tblPersonalInfo.fldDate, CASE WHEN fldMeliyat = 0 THEN N'غیر ایرانی' ELSE N'ایرانی' END AS fldMeliyatName, 
                      t.fldMadrakTahsiliTitle, Prs.tblVaziyatEsargari.fldTitle AS fldVaziyatEsargariTitle, ISNULL(Com.tblNezamVazife.fldTitle ,'') AS fldNezamVazifeTitle, 
                      Com.tblEmployee.fldName + '_' + Com.tblEmployee.fldFamily AS fldNameEmployee, Com.tblEmployee.fldName, Com.tblEmployee.fldFamily, 
                      Com.tblEmployee_Detail.fldFatherName, Com.tblEmployee_Detail.fldJensiyat, tblChartOrgan.fldTitle AS fldTitleChartOrgan, 
                      (SELECT Com.fn_stringDecode(tblOrganization.fldName) FROM Com.tblOrganization WHERE fldid = [Com].[fn_OrganName] (fldOrganPostId)) AS fldNameOrgan, Com.tblCity.fldName AS fldNameMahalTavalod, tblCity_1.fldName AS fldNameMahlSodoor, 
                      Com.tblEmployee.fldCodemeli, Com.tblEmployee_Detail.fldFileId, CASE WHEN fldJensiyat = 0 THEN N'زن' ELSE N'مرد' END AS fldNameJensiyat, 
                      tblOrganizationalPosts.fldTitle/*+'_'+tblOrganizationalPosts.fldOrgPostCode*/ AS NamePostOran, t.fldReshteTahsiliTitle, 
                      Com.tblEmployee.fldFamily + '_' + Com.tblEmployee.fldName + '(' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName_FamilyEmployee,  Com.tblEmployee_Detail.fldTel, Com.tblEmployee_Detail.fldMobile,
                      ISNULL(tblChartOrgan.fldOrganId, 0) AS fldOrganId, ISNULL
                          ((SELECT     TOP (1) fldId
                              FROM         Com.tblPersonalStatus
                              WHERE     (fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                              ORDER BY fldId DESC), 0) AS fldIdStatus, ISNULL
                          ((SELECT     TOP (1) fldNoeEstekhdamId
                              FROM         Prs.tblHistoryNoeEstekhdam
                              WHERE     (fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                              ORDER BY fldId DESC), 0) AS fldNoeEstekhdam,
                          (SELECT     TOP (1) Com.tblStatus.fldTitle
                            FROM          Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                                   Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                            WHERE      (tblPersonalStatus_1.fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                            ORDER BY tblPersonalStatus_1.fldId DESC) AS fldTitleStatus,fldTarikhSodoor,fldTaaholId,
                            ISNULL((SELECT     TOP (1)  Com.tblAnvaEstekhdam.fldTitle
FROM         Prs.tblHistoryNoeEstekhdam INNER JOIN
                      Com.tblAnvaEstekhdam ON Prs.tblHistoryNoeEstekhdam.fldNoeEstekhdamId = Com.tblAnvaEstekhdam.fldId
                              WHERE     (fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                              ORDER BY tblHistoryNoeEstekhdam.fldId DESC), '')AS TitleNoeEstekhdam,fldOrganPostEjraeeId
							  ,tblOrganizationalPostsEjraee.fldTitle+'_'+tblOrganizationalPostsEjraee.fldOrgPostCode AS TitleOrganPostEjraee,
							  Com.tblChartOrganEjraee.fldTitle AS TitleChartOrganEjraee

FROM         Prs.Prs_tblPersonalInfo INNER JOIN
                      Com.tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = Com.tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON Com.tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
                      Com.tblStatusTaahol ON Com.tblEmployee_Detail.fldTaaholId = Com.tblStatusTaahol.fldId INNER JOIN
                      Com.tblCity ON Com.tblEmployee_Detail.fldMahalTavalodId = Com.tblCity.fldId INNER JOIN
                      Com.tblCity AS tblCity_1 ON Com.tblEmployee_Detail.fldMahalSodoorId = tblCity_1.fldId INNER JOIN
                      Prs.tblVaziyatEsargari ON Prs.Prs_tblPersonalInfo.fldEsargariId = Prs.tblVaziyatEsargari.fldId INNER JOIN
                      Com.tblOrganizationalPosts ON Prs.Prs_tblPersonalInfo.fldOrganPostId = Com.tblOrganizationalPosts.fldId INNER JOIN
                      Com.tblChartOrgan ON Com.tblOrganizationalPosts.fldChartOrganId = Com.tblChartOrgan.fldId LEFT OUTER JOIN
					  Com.tblNezamVazife ON Com.tblEmployee_Detail.fldNezamVazifeId = Com.tblNezamVazife.fldId   LEFT outer JOIN
					  com.tblOrganizationalPostsEjraee ON Prs.Prs_tblPersonalInfo.fldOrganPostEjraeeId=com.tblOrganizationalPostsEjraee.fldId LEFT outer JOIN
					  com.tblChartOrganEjraee ON com.tblOrganizationalPostsEjraee.fldChartOrganId =	com.tblChartOrganEjraee.fldid
					   OUTER APPLY (SELECT top(1) t.fldMadrakId,t.fldReshteId,tblMadrakTahsili.fldTitle as fldMadrakTahsiliTitle,tblReshteTahsili.fldtitle as fldReshteTahsiliTitle
										from com.tblHistoryTahsilat as t inner join 
									    Com.tblMadrakTahsili ON t.fldMadrakId = Com.tblMadrakTahsili.fldId INNER JOIN
									    Com.tblReshteTahsili ON t.fldReshteId = Com.tblReshteTahsili.fldId 
									   where t.fldEmployeeId=tblEmployee.fldid order by T.fldTarikh DESC)t
                      	WHERE Com.tblEmployee.fldName + '_' + Com.tblEmployee.fldFamily like @Value and  com.fn_organId(Prs_tblPersonalInfo.fldid) =@OrganId and exists(select * from prs.tblAfradTahtePooshesh where fldPersonalId= Prs_tblPersonalInfo.fldId and fldNesbatShakhs=1)
                     ORDER BY fldFamily,fldName 

                     
    if (@fieldname=N'fldDesc')
SELECT    top(@h) Prs.Prs_tblPersonalInfo.fldId, Prs.Prs_tblPersonalInfo.fldEmployeeId, Com.tblEmployee_Detail.fldSh_Shenasname, 
                      Com.tblEmployee_Detail.fldTarikhTavalod, Com.tblEmployee_Detail.fldMahalTavalodId, Com.tblEmployee_Detail.fldMahalSodoorId, 
                      ISNULL(Com.tblEmployee_Detail.fldAddress,'')AS fldAddress, ISNULL(Com.tblEmployee_Detail.fldCodePosti,'') AS fldCodePosti, Prs.Prs_tblPersonalInfo.fldEsargariId, Prs.Prs_tblPersonalInfo.fldSharhEsargari, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali, t.fldMadrakId, t.fldReshteId, Com.tblEmployee_Detail.fldNezamVazifeId, 
                      Prs.Prs_tblPersonalInfo.fldOrganPostId, Prs.Prs_tblPersonalInfo.fldRasteShoghli, Prs.Prs_tblPersonalInfo.fldReshteShoghli, 
                      Prs.Prs_tblPersonalInfo.fldTarikhEstekhdam, tblOrganizationalPosts.fldChartOrganId, Prs.Prs_tblPersonalInfo.fldTabaghe, Com.tblEmployee_Detail.fldMeliyat, 
                      Prs.Prs_tblPersonalInfo.fldSh_MojavezEstekhdam, Prs.Prs_tblPersonalInfo.fldTarikhMajavezEstekhdam, Prs.Prs_tblPersonalInfo.fldUserId, 
                      Prs.Prs_tblPersonalInfo.fldDesc, Prs.Prs_tblPersonalInfo.fldDate, CASE WHEN fldMeliyat = 0 THEN N'غیر ایرانی' ELSE N'ایرانی' END AS fldMeliyatName, 
                      t.fldMadrakTahsiliTitle, Prs.tblVaziyatEsargari.fldTitle AS fldVaziyatEsargariTitle, ISNULL(Com.tblNezamVazife.fldTitle ,'') AS fldNezamVazifeTitle, 
                      Com.tblEmployee.fldName + '_' + Com.tblEmployee.fldFamily AS fldNameEmployee, Com.tblEmployee.fldName, Com.tblEmployee.fldFamily, 
                      Com.tblEmployee_Detail.fldFatherName, Com.tblEmployee_Detail.fldJensiyat, tblChartOrgan.fldTitle AS fldTitleChartOrgan, 
                      (SELECT Com.fn_stringDecode(tblOrganization.fldName) FROM Com.tblOrganization WHERE fldid = [Com].[fn_OrganName] (fldOrganPostId)) AS fldNameOrgan, Com.tblCity.fldName AS fldNameMahalTavalod, tblCity_1.fldName AS fldNameMahlSodoor, 
                      Com.tblEmployee.fldCodemeli, Com.tblEmployee_Detail.fldFileId, CASE WHEN fldJensiyat = 0 THEN N'زن' ELSE N'مرد' END AS fldNameJensiyat, 
                      tblOrganizationalPosts.fldTitle+'_'+tblOrganizationalPosts.fldOrgPostCode AS NamePostOran, t.fldReshteTahsiliTitle, 
                      Com.tblEmployee.fldFamily + '_' + Com.tblEmployee.fldName + '(' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName_FamilyEmployee,  Com.tblEmployee_Detail.fldTel, Com.tblEmployee_Detail.fldMobile, 
                      ISNULL(tblChartOrgan.fldOrganId, 0) AS fldOrganId, ISNULL
                          ((SELECT     TOP (1) fldId
                              FROM         Com.tblPersonalStatus
                              WHERE     (fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                              ORDER BY fldId DESC), 0) AS fldIdStatus, ISNULL
                          ((SELECT     TOP (1) fldNoeEstekhdamId
                              FROM         Prs.tblHistoryNoeEstekhdam
                              WHERE     (fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                              ORDER BY fldId DESC), 0) AS fldNoeEstekhdam,
                          (SELECT     TOP (1) Com.tblStatus.fldTitle
                            FROM          Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                                   Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                            WHERE      (tblPersonalStatus_1.fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                            ORDER BY tblPersonalStatus_1.fldId DESC) AS fldTitleStatus,fldTarikhSodoor,fldTaaholId,
                            ISNULL((SELECT     TOP (1)  Com.tblAnvaEstekhdam.fldTitle
FROM         Prs.tblHistoryNoeEstekhdam INNER JOIN
                      Com.tblAnvaEstekhdam ON Prs.tblHistoryNoeEstekhdam.fldNoeEstekhdamId = Com.tblAnvaEstekhdam.fldId
                              WHERE     (fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                              ORDER BY tblHistoryNoeEstekhdam.fldId DESC), '')AS TitleNoeEstekhdam,fldOrganPostEjraeeId
							  ,tblOrganizationalPostsEjraee.fldTitle+'_'+tblOrganizationalPostsEjraee.fldOrgPostCode AS TitleOrganPostEjraee,
							  Com.tblChartOrganEjraee.fldTitle AS TitleChartOrganEjraee

FROM         Prs.Prs_tblPersonalInfo INNER JOIN
                      Com.tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = Com.tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON Com.tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
                      Com.tblStatusTaahol ON Com.tblEmployee_Detail.fldTaaholId = Com.tblStatusTaahol.fldId INNER JOIN
                      Com.tblCity ON Com.tblEmployee_Detail.fldMahalTavalodId = Com.tblCity.fldId INNER JOIN
                      Com.tblCity AS tblCity_1 ON Com.tblEmployee_Detail.fldMahalSodoorId = tblCity_1.fldId INNER JOIN
                      Prs.tblVaziyatEsargari ON Prs.Prs_tblPersonalInfo.fldEsargariId = Prs.tblVaziyatEsargari.fldId INNER JOIN
                      Com.tblOrganizationalPosts ON Prs.Prs_tblPersonalInfo.fldOrganPostId = Com.tblOrganizationalPosts.fldId INNER JOIN
                      Com.tblChartOrgan ON Com.tblOrganizationalPosts.fldChartOrganId = Com.tblChartOrgan.fldId LEFT OUTER JOIN
						Com.tblNezamVazife ON Com.tblEmployee_Detail.fldNezamVazifeId = Com.tblNezamVazife.fldId   LEFT outer JOIN
					  com.tblOrganizationalPostsEjraee ON Prs.Prs_tblPersonalInfo.fldOrganPostEjraeeId=com.tblOrganizationalPostsEjraee.fldId LEFT outer JOIN
					  com.tblChartOrganEjraee ON com.tblOrganizationalPostsEjraee.fldChartOrganId =	com.tblChartOrganEjraee.fldid
					   OUTER APPLY (SELECT top(1) t.fldMadrakId,t.fldReshteId,tblMadrakTahsili.fldTitle as fldMadrakTahsiliTitle,tblReshteTahsili.fldtitle as fldReshteTahsiliTitle
										from com.tblHistoryTahsilat as t inner join 
									    Com.tblMadrakTahsili ON t.fldMadrakId = Com.tblMadrakTahsili.fldId INNER JOIN
									    Com.tblReshteTahsili ON t.fldReshteId = Com.tblReshteTahsili.fldId 
									   where t.fldEmployeeId=tblEmployee.fldid order by T.fldTarikh DESC)t
                      	WHERE  Prs_tblPersonalInfo.fldDesc LIKE @Value 
                     ORDER BY Prs_tblPersonalInfo.fldId DESC


     	if (@fieldname=N'CheckId')
SELECT    top(@h) Prs.Prs_tblPersonalInfo.fldId, Prs.Prs_tblPersonalInfo.fldEmployeeId, Com.tblEmployee_Detail.fldSh_Shenasname, 
                      Com.tblEmployee_Detail.fldTarikhTavalod, Com.tblEmployee_Detail.fldMahalTavalodId, Com.tblEmployee_Detail.fldMahalSodoorId, 
                      ISNULL(Com.tblEmployee_Detail.fldAddress,'')AS fldAddress, ISNULL(Com.tblEmployee_Detail.fldCodePosti,'') AS fldCodePosti, Prs.Prs_tblPersonalInfo.fldEsargariId, Prs.Prs_tblPersonalInfo.fldSharhEsargari, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali, t.fldMadrakId, t.fldReshteId, Com.tblEmployee_Detail.fldNezamVazifeId, 
                      Prs.Prs_tblPersonalInfo.fldOrganPostId, Prs.Prs_tblPersonalInfo.fldRasteShoghli, Prs.Prs_tblPersonalInfo.fldReshteShoghli, 
                      Prs.Prs_tblPersonalInfo.fldTarikhEstekhdam, tblOrganizationalPosts.fldChartOrganId, Prs.Prs_tblPersonalInfo.fldTabaghe, Com.tblEmployee_Detail.fldMeliyat, 
                      Prs.Prs_tblPersonalInfo.fldSh_MojavezEstekhdam, Prs.Prs_tblPersonalInfo.fldTarikhMajavezEstekhdam, Prs.Prs_tblPersonalInfo.fldUserId, 
                      Prs.Prs_tblPersonalInfo.fldDesc, Prs.Prs_tblPersonalInfo.fldDate, CASE WHEN fldMeliyat = 0 THEN N'غیر ایرانی' ELSE N'ایرانی' END AS fldMeliyatName, 
                      t.fldMadrakTahsiliTitle, Prs.tblVaziyatEsargari.fldTitle AS fldVaziyatEsargariTitle, ISNULL(Com.tblNezamVazife.fldTitle ,'') AS fldNezamVazifeTitle, 
                      Com.tblEmployee.fldName + '_' + Com.tblEmployee.fldFamily AS fldNameEmployee, Com.tblEmployee.fldName, Com.tblEmployee.fldFamily, 
                      Com.tblEmployee_Detail.fldFatherName, Com.tblEmployee_Detail.fldJensiyat, tblChartOrgan.fldTitle AS fldTitleChartOrgan, 
                      (SELECT Com.fn_stringDecode(tblOrganization.fldName) FROM Com.tblOrganization WHERE fldid = [Com].[fn_OrganName] (fldOrganPostId)) AS fldNameOrgan, Com.tblCity.fldName AS fldNameMahalTavalod, tblCity_1.fldName AS fldNameMahlSodoor, 
                      Com.tblEmployee.fldCodemeli, Com.tblEmployee_Detail.fldFileId, CASE WHEN fldJensiyat = 0 THEN N'زن' ELSE N'مرد' END AS fldNameJensiyat, 
                      tblOrganizationalPosts.fldTitle+'_'+tblOrganizationalPosts.fldOrgPostCode AS NamePostOran, t.fldReshteTahsiliTitle, 
                      Com.tblEmployee.fldFamily + '_' + Com.tblEmployee.fldName + '(' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName_FamilyEmployee,  Com.tblEmployee_Detail.fldTel, Com.tblEmployee_Detail.fldMobile,
                      ISNULL(tblChartOrgan.fldOrganId, 0) AS fldOrganId, ISNULL
                          ((SELECT     TOP (1) fldId
                              FROM         Com.tblPersonalStatus
                              WHERE     (fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                              ORDER BY fldId DESC), 0) AS fldIdStatus, ISNULL
                          ((SELECT     TOP (1) fldNoeEstekhdamId
                              FROM         Prs.tblHistoryNoeEstekhdam
                              WHERE     (fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                              ORDER BY fldId DESC), 0) AS fldNoeEstekhdam,
                          (SELECT     TOP (1) Com.tblStatus.fldTitle
                            FROM          Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                                   Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                            WHERE      (tblPersonalStatus_1.fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                            ORDER BY tblPersonalStatus_1.fldId DESC) AS fldTitleStatus,fldTarikhSodoor,fldTaaholId,
                            ISNULL((SELECT     TOP (1)  Com.tblAnvaEstekhdam.fldTitle
FROM         Prs.tblHistoryNoeEstekhdam INNER JOIN
                      Com.tblAnvaEstekhdam ON Prs.tblHistoryNoeEstekhdam.fldNoeEstekhdamId = Com.tblAnvaEstekhdam.fldId
                              WHERE     (fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                              ORDER BY tblHistoryNoeEstekhdam.fldId DESC), '')AS TitleNoeEstekhdam,fldOrganPostEjraeeId
							  ,tblOrganizationalPostsEjraee.fldTitle+'_'+tblOrganizationalPostsEjraee.fldOrgPostCode AS TitleOrganPostEjraee,
							  Com.tblChartOrganEjraee.fldTitle AS TitleChartOrganEjraee

FROM         Prs.Prs_tblPersonalInfo INNER JOIN
                      Com.tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = Com.tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON Com.tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
                      Com.tblStatusTaahol ON Com.tblEmployee_Detail.fldTaaholId = Com.tblStatusTaahol.fldId INNER JOIN
                      Com.tblCity ON Com.tblEmployee_Detail.fldMahalTavalodId = Com.tblCity.fldId INNER JOIN
                      Com.tblCity AS tblCity_1 ON Com.tblEmployee_Detail.fldMahalSodoorId = tblCity_1.fldId INNER JOIN
                      Prs.tblVaziyatEsargari ON Prs.Prs_tblPersonalInfo.fldEsargariId = Prs.tblVaziyatEsargari.fldId INNER JOIN
                      Com.tblOrganizationalPosts ON Prs.Prs_tblPersonalInfo.fldOrganPostId = Com.tblOrganizationalPosts.fldId INNER JOIN
                      Com.tblChartOrgan ON Com.tblOrganizationalPosts.fldChartOrganId = Com.tblChartOrgan.fldId LEFT OUTER JOIN
						Com.tblNezamVazife ON Com.tblEmployee_Detail.fldNezamVazifeId = Com.tblNezamVazife.fldId   LEFT outer JOIN
					  com.tblOrganizationalPostsEjraee ON Prs.Prs_tblPersonalInfo.fldOrganPostEjraeeId=com.tblOrganizationalPostsEjraee.fldId LEFT outer JOIN
					  com.tblChartOrganEjraee ON com.tblOrganizationalPostsEjraee.fldChartOrganId =	com.tblChartOrganEjraee.fldid
					   OUTER APPLY (SELECT top(1) t.fldMadrakId,t.fldReshteId,tblMadrakTahsili.fldTitle as fldMadrakTahsiliTitle,tblReshteTahsili.fldtitle as fldReshteTahsiliTitle
										from com.tblHistoryTahsilat as t inner join 
									    Com.tblMadrakTahsili ON t.fldMadrakId = Com.tblMadrakTahsili.fldId INNER JOIN
									    Com.tblReshteTahsili ON t.fldReshteId = Com.tblReshteTahsili.fldId 
									   where t.fldEmployeeId=tblEmployee.fldid order by T.fldTarikh DESC)t
                      	WHERE  Prs_tblPersonalInfo.fldId = @Value 
                     ORDER BY Prs_tblPersonalInfo.fldId DESC                

  if (@fieldname=N'CheckEsargariId')
SELECT    top(@h) Prs.Prs_tblPersonalInfo.fldId, Prs.Prs_tblPersonalInfo.fldEmployeeId, Com.tblEmployee_Detail.fldSh_Shenasname, 
                      Com.tblEmployee_Detail.fldTarikhTavalod, Com.tblEmployee_Detail.fldMahalTavalodId, Com.tblEmployee_Detail.fldMahalSodoorId, 
                      ISNULL(Com.tblEmployee_Detail.fldAddress,'')AS fldAddress, ISNULL(Com.tblEmployee_Detail.fldCodePosti,'') AS fldCodePosti, Prs.Prs_tblPersonalInfo.fldEsargariId, Prs.Prs_tblPersonalInfo.fldSharhEsargari, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali, t.fldMadrakId, t.fldReshteId, Com.tblEmployee_Detail.fldNezamVazifeId, 
                      Prs.Prs_tblPersonalInfo.fldOrganPostId, Prs.Prs_tblPersonalInfo.fldRasteShoghli, Prs.Prs_tblPersonalInfo.fldReshteShoghli, 
                      Prs.Prs_tblPersonalInfo.fldTarikhEstekhdam, tblOrganizationalPosts.fldChartOrganId, Prs.Prs_tblPersonalInfo.fldTabaghe, Com.tblEmployee_Detail.fldMeliyat, 
                      Prs.Prs_tblPersonalInfo.fldSh_MojavezEstekhdam, Prs.Prs_tblPersonalInfo.fldTarikhMajavezEstekhdam, Prs.Prs_tblPersonalInfo.fldUserId, 
                      Prs.Prs_tblPersonalInfo.fldDesc, Prs.Prs_tblPersonalInfo.fldDate, CASE WHEN fldMeliyat = 0 THEN N'غیر ایرانی' ELSE N'ایرانی' END AS fldMeliyatName, 
                      t.fldMadrakTahsiliTitle, Prs.tblVaziyatEsargari.fldTitle AS fldVaziyatEsargariTitle, ISNULL(Com.tblNezamVazife.fldTitle ,'') AS fldNezamVazifeTitle, 
                      Com.tblEmployee.fldName + '_' + Com.tblEmployee.fldFamily AS fldNameEmployee, Com.tblEmployee.fldName, Com.tblEmployee.fldFamily, 
                      Com.tblEmployee_Detail.fldFatherName, Com.tblEmployee_Detail.fldJensiyat, tblChartOrgan.fldTitle AS fldTitleChartOrgan, 
                      (SELECT Com.fn_stringDecode(tblOrganization.fldName) FROM Com.tblOrganization WHERE fldid = [Com].[fn_OrganName] (fldOrganPostId)) AS fldNameOrgan, Com.tblCity.fldName AS fldNameMahalTavalod, tblCity_1.fldName AS fldNameMahlSodoor, 
                      Com.tblEmployee.fldCodemeli, Com.tblEmployee_Detail.fldFileId, CASE WHEN fldJensiyat = 0 THEN N'زن' ELSE N'مرد' END AS fldNameJensiyat, 
                      tblOrganizationalPosts.fldTitle+'_'+tblOrganizationalPosts.fldOrgPostCode AS NamePostOran, t.fldReshteTahsiliTitle, 
                      Com.tblEmployee.fldFamily + '_' + Com.tblEmployee.fldName + '(' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName_FamilyEmployee, Com.tblEmployee_Detail.fldTel, Com.tblEmployee_Detail.fldMobile,
                      ISNULL(tblChartOrgan.fldOrganId, 0) AS fldOrganId, ISNULL
                          ((SELECT     TOP (1) fldId
                              FROM         Com.tblPersonalStatus
                              WHERE     (fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                              ORDER BY fldId DESC), 0) AS fldIdStatus, ISNULL
                          ((SELECT     TOP (1) fldNoeEstekhdamId
                              FROM         Prs.tblHistoryNoeEstekhdam
                              WHERE     (fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                              ORDER BY fldId DESC), 0) AS fldNoeEstekhdam,
                          (SELECT     TOP (1) Com.tblStatus.fldTitle
                            FROM          Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                                   Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                            WHERE      (tblPersonalStatus_1.fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                            ORDER BY tblPersonalStatus_1.fldId DESC) AS fldTitleStatus,fldTarikhSodoor,fldTaaholId,
                            ISNULL((SELECT     TOP (1)  Com.tblAnvaEstekhdam.fldTitle
FROM         Prs.tblHistoryNoeEstekhdam INNER JOIN
                      Com.tblAnvaEstekhdam ON Prs.tblHistoryNoeEstekhdam.fldNoeEstekhdamId = Com.tblAnvaEstekhdam.fldId
                              WHERE     (fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                              ORDER BY tblHistoryNoeEstekhdam.fldId DESC), '')AS TitleNoeEstekhdam,fldOrganPostEjraeeId
							  ,tblOrganizationalPostsEjraee.fldTitle+'_'+tblOrganizationalPostsEjraee.fldOrgPostCode AS TitleOrganPostEjraee,
							  Com.tblChartOrganEjraee.fldTitle AS TitleChartOrganEjraee

FROM         Prs.Prs_tblPersonalInfo INNER JOIN
                      Com.tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = Com.tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON Com.tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
                      Com.tblStatusTaahol ON Com.tblEmployee_Detail.fldTaaholId = Com.tblStatusTaahol.fldId INNER JOIN
                      Com.tblCity ON Com.tblEmployee_Detail.fldMahalTavalodId = Com.tblCity.fldId INNER JOIN
                      Com.tblCity AS tblCity_1 ON Com.tblEmployee_Detail.fldMahalSodoorId = tblCity_1.fldId INNER JOIN
                      Prs.tblVaziyatEsargari ON Prs.Prs_tblPersonalInfo.fldEsargariId = Prs.tblVaziyatEsargari.fldId INNER JOIN
                      Com.tblOrganizationalPosts ON Prs.Prs_tblPersonalInfo.fldOrganPostId = Com.tblOrganizationalPosts.fldId INNER JOIN
                      Com.tblChartOrgan ON Com.tblOrganizationalPosts.fldChartOrganId = Com.tblChartOrgan.fldId LEFT OUTER JOIN
						Com.tblNezamVazife ON Com.tblEmployee_Detail.fldNezamVazifeId = Com.tblNezamVazife.fldId   LEFT outer JOIN
					  com.tblOrganizationalPostsEjraee ON Prs.Prs_tblPersonalInfo.fldOrganPostEjraeeId=com.tblOrganizationalPostsEjraee.fldId LEFT outer JOIN
					  com.tblChartOrganEjraee ON com.tblOrganizationalPostsEjraee.fldChartOrganId =	com.tblChartOrganEjraee.fldid
					  OUTER APPLY (SELECT top(1) t.fldMadrakId,t.fldReshteId,tblMadrakTahsili.fldTitle as fldMadrakTahsiliTitle,tblReshteTahsili.fldtitle as fldReshteTahsiliTitle
										from com.tblHistoryTahsilat as t inner join 
									    Com.tblMadrakTahsili ON t.fldMadrakId = Com.tblMadrakTahsili.fldId INNER JOIN
									    Com.tblReshteTahsili ON t.fldReshteId = Com.tblReshteTahsili.fldId 
									   where t.fldEmployeeId=tblEmployee.fldid order by T.fldTarikh DESC)t
                      WHERE  Prs_tblPersonalInfo.fldEsargariId = @Value 
                     ORDER BY Prs_tblPersonalInfo.fldId DESC    

                     if (@fieldname=N'CheckReshteTahsiliId')
SELECT    top(@h) Prs.Prs_tblPersonalInfo.fldId, Prs.Prs_tblPersonalInfo.fldEmployeeId, Com.tblEmployee_Detail.fldSh_Shenasname, 
                      Com.tblEmployee_Detail.fldTarikhTavalod, Com.tblEmployee_Detail.fldMahalTavalodId, Com.tblEmployee_Detail.fldMahalSodoorId, 
                      ISNULL(Com.tblEmployee_Detail.fldAddress,'')AS fldAddress, ISNULL(Com.tblEmployee_Detail.fldCodePosti,'') AS fldCodePosti, Prs.Prs_tblPersonalInfo.fldEsargariId, Prs.Prs_tblPersonalInfo.fldSharhEsargari, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali, t.fldMadrakId, t.fldReshteId, Com.tblEmployee_Detail.fldNezamVazifeId, 
                      Prs.Prs_tblPersonalInfo.fldOrganPostId, Prs.Prs_tblPersonalInfo.fldRasteShoghli, Prs.Prs_tblPersonalInfo.fldReshteShoghli, 
                      Prs.Prs_tblPersonalInfo.fldTarikhEstekhdam, tblOrganizationalPosts.fldChartOrganId, Prs.Prs_tblPersonalInfo.fldTabaghe, Com.tblEmployee_Detail.fldMeliyat, 
                      Prs.Prs_tblPersonalInfo.fldSh_MojavezEstekhdam, Prs.Prs_tblPersonalInfo.fldTarikhMajavezEstekhdam, Prs.Prs_tblPersonalInfo.fldUserId, 
                      Prs.Prs_tblPersonalInfo.fldDesc, Prs.Prs_tblPersonalInfo.fldDate, CASE WHEN fldMeliyat = 0 THEN N'غیر ایرانی' ELSE N'ایرانی' END AS fldMeliyatName, 
                      t.fldMadrakTahsiliTitle, Prs.tblVaziyatEsargari.fldTitle AS fldVaziyatEsargariTitle, ISNULL(Com.tblNezamVazife.fldTitle ,'') AS fldNezamVazifeTitle, 
                      Com.tblEmployee.fldName + '_' + Com.tblEmployee.fldFamily AS fldNameEmployee, Com.tblEmployee.fldName, Com.tblEmployee.fldFamily, 
                      Com.tblEmployee_Detail.fldFatherName, Com.tblEmployee_Detail.fldJensiyat, tblChartOrgan.fldTitle AS fldTitleChartOrgan, 
                      (SELECT Com.fn_stringDecode(tblOrganization.fldName) FROM Com.tblOrganization WHERE fldid = [Com].[fn_OrganName] (fldOrganPostId)) AS fldNameOrgan, Com.tblCity.fldName AS fldNameMahalTavalod, tblCity_1.fldName AS fldNameMahlSodoor, 
                      Com.tblEmployee.fldCodemeli, Com.tblEmployee_Detail.fldFileId, CASE WHEN fldJensiyat = 0 THEN N'زن' ELSE N'مرد' END AS fldNameJensiyat, 
                      tblOrganizationalPosts.fldTitle+'_'+tblOrganizationalPosts.fldOrgPostCode AS NamePostOran, t.fldReshteTahsiliTitle, 
                      Com.tblEmployee.fldFamily + '_' + Com.tblEmployee.fldName + '(' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName_FamilyEmployee, Com.tblEmployee_Detail.fldTel, Com.tblEmployee_Detail.fldMobile,
                      ISNULL(tblChartOrgan.fldOrganId, 0) AS fldOrganId, ISNULL
                          ((SELECT     TOP (1) fldId
                              FROM         Com.tblPersonalStatus
                              WHERE     (fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                              ORDER BY fldId DESC), 0) AS fldIdStatus, ISNULL
                          ((SELECT     TOP (1) fldNoeEstekhdamId
                              FROM         Prs.tblHistoryNoeEstekhdam
                              WHERE     (fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                              ORDER BY fldId DESC), 0) AS fldNoeEstekhdam,
                          (SELECT     TOP (1) Com.tblStatus.fldTitle
                            FROM          Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                                   Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                            WHERE      (tblPersonalStatus_1.fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                            ORDER BY tblPersonalStatus_1.fldId DESC) AS fldTitleStatus,fldTarikhSodoor,fldTaaholId,
                            ISNULL((SELECT     TOP (1)  Com.tblAnvaEstekhdam.fldTitle
FROM         Prs.tblHistoryNoeEstekhdam INNER JOIN
                      Com.tblAnvaEstekhdam ON Prs.tblHistoryNoeEstekhdam.fldNoeEstekhdamId = Com.tblAnvaEstekhdam.fldId
                              WHERE     (fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                              ORDER BY tblHistoryNoeEstekhdam.fldId DESC), '')AS TitleNoeEstekhdam,fldOrganPostEjraeeId
							  ,tblOrganizationalPostsEjraee.fldTitle+'_'+tblOrganizationalPostsEjraee.fldOrgPostCode AS TitleOrganPostEjraee,
							  Com.tblChartOrganEjraee.fldTitle AS TitleChartOrganEjraee

FROM         Prs.Prs_tblPersonalInfo INNER JOIN
                      Com.tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = Com.tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON Com.tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
                      Com.tblStatusTaahol ON Com.tblEmployee_Detail.fldTaaholId = Com.tblStatusTaahol.fldId INNER JOIN
                      Com.tblCity ON Com.tblEmployee_Detail.fldMahalTavalodId = Com.tblCity.fldId INNER JOIN
                      Com.tblCity AS tblCity_1 ON Com.tblEmployee_Detail.fldMahalSodoorId = tblCity_1.fldId INNER JOIN
                      Prs.tblVaziyatEsargari ON Prs.Prs_tblPersonalInfo.fldEsargariId = Prs.tblVaziyatEsargari.fldId INNER JOIN
                      Com.tblOrganizationalPosts ON Prs.Prs_tblPersonalInfo.fldOrganPostId = Com.tblOrganizationalPosts.fldId INNER JOIN
                      Com.tblChartOrgan ON Com.tblOrganizationalPosts.fldChartOrganId = Com.tblChartOrgan.fldId LEFT OUTER JOIN
						Com.tblNezamVazife ON Com.tblEmployee_Detail.fldNezamVazifeId = Com.tblNezamVazife.fldId   LEFT outer JOIN
					  com.tblOrganizationalPostsEjraee ON Prs.Prs_tblPersonalInfo.fldOrganPostEjraeeId=com.tblOrganizationalPostsEjraee.fldId LEFT outer JOIN
					  com.tblChartOrganEjraee ON com.tblOrganizationalPostsEjraee.fldChartOrganId =	com.tblChartOrganEjraee.fldid
					  OUTER APPLY (SELECT top(1) t.fldMadrakId,t.fldReshteId,tblMadrakTahsili.fldTitle as fldMadrakTahsiliTitle,tblReshteTahsili.fldtitle as fldReshteTahsiliTitle
										from com.tblHistoryTahsilat as t inner join 
									    Com.tblMadrakTahsili ON t.fldMadrakId = Com.tblMadrakTahsili.fldId INNER JOIN
									    Com.tblReshteTahsili ON t.fldReshteId = Com.tblReshteTahsili.fldId 
									   where t.fldEmployeeId=tblEmployee.fldid order by T.fldTarikh DESC)t
                      	WHERE  t.fldReshteId = @Value 
                     ORDER BY Prs_tblPersonalInfo.fldId DESC  

                     if (@fieldname=N'CheckOrganPostId')
SELECT    top(@h) Prs.Prs_tblPersonalInfo.fldId, Prs.Prs_tblPersonalInfo.fldEmployeeId, Com.tblEmployee_Detail.fldSh_Shenasname, 
                      Com.tblEmployee_Detail.fldTarikhTavalod, Com.tblEmployee_Detail.fldMahalTavalodId, Com.tblEmployee_Detail.fldMahalSodoorId, 
                      ISNULL(Com.tblEmployee_Detail.fldAddress,'')AS fldAddress, ISNULL(Com.tblEmployee_Detail.fldCodePosti,'') AS fldCodePosti, Prs.Prs_tblPersonalInfo.fldEsargariId, Prs.Prs_tblPersonalInfo.fldSharhEsargari, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali, t.fldMadrakId, t.fldReshteId, Com.tblEmployee_Detail.fldNezamVazifeId, 
                      Prs.Prs_tblPersonalInfo.fldOrganPostId, Prs.Prs_tblPersonalInfo.fldRasteShoghli, Prs.Prs_tblPersonalInfo.fldReshteShoghli, 
                      Prs.Prs_tblPersonalInfo.fldTarikhEstekhdam, tblOrganizationalPosts.fldChartOrganId, Prs.Prs_tblPersonalInfo.fldTabaghe, Com.tblEmployee_Detail.fldMeliyat, 
                      Prs.Prs_tblPersonalInfo.fldSh_MojavezEstekhdam, Prs.Prs_tblPersonalInfo.fldTarikhMajavezEstekhdam, Prs.Prs_tblPersonalInfo.fldUserId, 
                      Prs.Prs_tblPersonalInfo.fldDesc, Prs.Prs_tblPersonalInfo.fldDate, CASE WHEN fldMeliyat = 0 THEN N'غیر ایرانی' ELSE N'ایرانی' END AS fldMeliyatName, 
                      t.fldMadrakTahsiliTitle, Prs.tblVaziyatEsargari.fldTitle AS fldVaziyatEsargariTitle, ISNULL(Com.tblNezamVazife.fldTitle ,'') AS fldNezamVazifeTitle, 
                      Com.tblEmployee.fldName + '_' + Com.tblEmployee.fldFamily AS fldNameEmployee, Com.tblEmployee.fldName, Com.tblEmployee.fldFamily, 
                      Com.tblEmployee_Detail.fldFatherName, Com.tblEmployee_Detail.fldJensiyat, tblChartOrgan.fldTitle AS fldTitleChartOrgan, 
                      (SELECT Com.fn_stringDecode(tblOrganization.fldName) FROM Com.tblOrganization WHERE fldid = [Com].[fn_OrganName] (fldOrganPostId)) AS fldNameOrgan, Com.tblCity.fldName AS fldNameMahalTavalod, tblCity_1.fldName AS fldNameMahlSodoor, 
                      Com.tblEmployee.fldCodemeli, Com.tblEmployee_Detail.fldFileId, CASE WHEN fldJensiyat = 0 THEN N'زن' ELSE N'مرد' END AS fldNameJensiyat, 
                      tblOrganizationalPosts.fldTitle+'_'+tblOrganizationalPosts.fldOrgPostCode AS NamePostOran, t.fldReshteTahsiliTitle, 
                      Com.tblEmployee.fldFamily + '_' + Com.tblEmployee.fldName + '(' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName_FamilyEmployee, Com.tblEmployee_Detail.fldTel, Com.tblEmployee_Detail.fldMobile,
                      ISNULL(tblChartOrgan.fldOrganId, 0) AS fldOrganId, ISNULL
                          ((SELECT     TOP (1) fldId
                              FROM         Com.tblPersonalStatus
                              WHERE     (fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                              ORDER BY fldId DESC), 0) AS fldIdStatus, ISNULL
                          ((SELECT     TOP (1) fldNoeEstekhdamId
                              FROM         Prs.tblHistoryNoeEstekhdam
                              WHERE     (fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                              ORDER BY fldId DESC), 0) AS fldNoeEstekhdam,
                          (SELECT     TOP (1) Com.tblStatus.fldTitle
                            FROM          Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                                   Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                            WHERE      (tblPersonalStatus_1.fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                            ORDER BY tblPersonalStatus_1.fldId DESC) AS fldTitleStatus,fldTarikhSodoor,fldTaaholId,
                            ISNULL((SELECT     TOP (1)  Com.tblAnvaEstekhdam.fldTitle
FROM         Prs.tblHistoryNoeEstekhdam INNER JOIN
                      Com.tblAnvaEstekhdam ON Prs.tblHistoryNoeEstekhdam.fldNoeEstekhdamId = Com.tblAnvaEstekhdam.fldId
                              WHERE     (fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                              ORDER BY tblHistoryNoeEstekhdam.fldId DESC), '')AS TitleNoeEstekhdam,fldOrganPostEjraeeId
							  ,tblOrganizationalPostsEjraee.fldTitle+'_'+tblOrganizationalPostsEjraee.fldOrgPostCode AS TitleOrganPostEjraee,
							  Com.tblChartOrganEjraee.fldTitle AS TitleChartOrganEjraee

FROM         Prs.Prs_tblPersonalInfo INNER JOIN
                      Com.tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = Com.tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON Com.tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
                      Com.tblStatusTaahol ON Com.tblEmployee_Detail.fldTaaholId = Com.tblStatusTaahol.fldId INNER JOIN
                      Com.tblCity ON Com.tblEmployee_Detail.fldMahalTavalodId = Com.tblCity.fldId INNER JOIN
                      Com.tblCity AS tblCity_1 ON Com.tblEmployee_Detail.fldMahalSodoorId = tblCity_1.fldId INNER JOIN
                      Prs.tblVaziyatEsargari ON Prs.Prs_tblPersonalInfo.fldEsargariId = Prs.tblVaziyatEsargari.fldId INNER JOIN
                      Com.tblOrganizationalPosts ON Prs.Prs_tblPersonalInfo.fldOrganPostId = Com.tblOrganizationalPosts.fldId INNER JOIN
                      Com.tblChartOrgan ON Com.tblOrganizationalPosts.fldChartOrganId = Com.tblChartOrgan.fldId LEFT OUTER JOIN
						Com.tblNezamVazife ON Com.tblEmployee_Detail.fldNezamVazifeId = Com.tblNezamVazife.fldId   LEFT outer JOIN
					  com.tblOrganizationalPostsEjraee ON Prs.Prs_tblPersonalInfo.fldOrganPostEjraeeId=com.tblOrganizationalPostsEjraee.fldId LEFT outer JOIN
					  com.tblChartOrganEjraee ON com.tblOrganizationalPostsEjraee.fldChartOrganId =	com.tblChartOrganEjraee.fldid
					   OUTER APPLY (SELECT top(1) t.fldMadrakId,t.fldReshteId,tblMadrakTahsili.fldTitle as fldMadrakTahsiliTitle,tblReshteTahsili.fldtitle as fldReshteTahsiliTitle
										from com.tblHistoryTahsilat as t inner join 
									    Com.tblMadrakTahsili ON t.fldMadrakId = Com.tblMadrakTahsili.fldId INNER JOIN
									    Com.tblReshteTahsili ON t.fldReshteId = Com.tblReshteTahsili.fldId 
									   where t.fldEmployeeId=tblEmployee.fldid order by T.fldTarikh DESC)t
                      	WHERE  Prs_tblPersonalInfo.fldOrganPostId = @Value 
                     ORDER BY Prs_tblPersonalInfo.fldId DESC       

                     if (@fieldname=N'CheckNezamVazifeId')
SELECT    top(@h) Prs.Prs_tblPersonalInfo.fldId, Prs.Prs_tblPersonalInfo.fldEmployeeId, Com.tblEmployee_Detail.fldSh_Shenasname, 
                      Com.tblEmployee_Detail.fldTarikhTavalod, Com.tblEmployee_Detail.fldMahalTavalodId, Com.tblEmployee_Detail.fldMahalSodoorId, 
                      ISNULL(Com.tblEmployee_Detail.fldAddress,'')AS fldAddress, ISNULL(Com.tblEmployee_Detail.fldCodePosti,'') AS fldCodePosti, Prs.Prs_tblPersonalInfo.fldEsargariId, Prs.Prs_tblPersonalInfo.fldSharhEsargari, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali, t.fldMadrakId, t.fldReshteId, Com.tblEmployee_Detail.fldNezamVazifeId, 
                      Prs.Prs_tblPersonalInfo.fldOrganPostId, Prs.Prs_tblPersonalInfo.fldRasteShoghli, Prs.Prs_tblPersonalInfo.fldReshteShoghli, 
                      Prs.Prs_tblPersonalInfo.fldTarikhEstekhdam, tblOrganizationalPosts.fldChartOrganId, Prs.Prs_tblPersonalInfo.fldTabaghe, Com.tblEmployee_Detail.fldMeliyat, 
                      Prs.Prs_tblPersonalInfo.fldSh_MojavezEstekhdam, Prs.Prs_tblPersonalInfo.fldTarikhMajavezEstekhdam, Prs.Prs_tblPersonalInfo.fldUserId, 
                      Prs.Prs_tblPersonalInfo.fldDesc, Prs.Prs_tblPersonalInfo.fldDate, CASE WHEN fldMeliyat = 0 THEN N'غیر ایرانی' ELSE N'ایرانی' END AS fldMeliyatName, 
                      t.fldMadrakTahsiliTitle, Prs.tblVaziyatEsargari.fldTitle AS fldVaziyatEsargariTitle, ISNULL(Com.tblNezamVazife.fldTitle ,'') AS fldNezamVazifeTitle, 
                      Com.tblEmployee.fldName + '_' + Com.tblEmployee.fldFamily AS fldNameEmployee, Com.tblEmployee.fldName, Com.tblEmployee.fldFamily, 
                      Com.tblEmployee_Detail.fldFatherName, Com.tblEmployee_Detail.fldJensiyat, tblChartOrgan.fldTitle AS fldTitleChartOrgan, 
                      (SELECT Com.fn_stringDecode(tblOrganization.fldName) FROM Com.tblOrganization WHERE fldid = [Com].[fn_OrganName] (fldOrganPostId)) AS fldNameOrgan, Com.tblCity.fldName AS fldNameMahalTavalod, tblCity_1.fldName AS fldNameMahlSodoor, 
                      Com.tblEmployee.fldCodemeli, Com.tblEmployee_Detail.fldFileId, CASE WHEN fldJensiyat = 0 THEN N'زن' ELSE N'مرد' END AS fldNameJensiyat, 
                      tblOrganizationalPosts.fldTitle+'_'+tblOrganizationalPosts.fldOrgPostCode AS NamePostOran, t.fldReshteTahsiliTitle, 
                      Com.tblEmployee.fldFamily + '_' + Com.tblEmployee.fldName + '(' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName_FamilyEmployee, Com.tblEmployee_Detail.fldTel, Com.tblEmployee_Detail.fldMobile,
                      ISNULL(tblChartOrgan.fldOrganId, 0) AS fldOrganId, ISNULL
                          ((SELECT     TOP (1) fldId
                              FROM         Com.tblPersonalStatus
                              WHERE     (fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                              ORDER BY fldId DESC), 0) AS fldIdStatus, ISNULL
                          ((SELECT     TOP (1) fldNoeEstekhdamId
                              FROM         Prs.tblHistoryNoeEstekhdam
                              WHERE     (fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                              ORDER BY fldId DESC), 0) AS fldNoeEstekhdam,
                          (SELECT     TOP (1) Com.tblStatus.fldTitle
                            FROM          Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                                   Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                            WHERE      (tblPersonalStatus_1.fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                            ORDER BY tblPersonalStatus_1.fldId DESC) AS fldTitleStatus,fldTarikhSodoor,fldTaaholId,
                            ISNULL((SELECT     TOP (1)  Com.tblAnvaEstekhdam.fldTitle
FROM         Prs.tblHistoryNoeEstekhdam INNER JOIN
                      Com.tblAnvaEstekhdam ON Prs.tblHistoryNoeEstekhdam.fldNoeEstekhdamId = Com.tblAnvaEstekhdam.fldId
                              WHERE     (fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                              ORDER BY tblHistoryNoeEstekhdam.fldId DESC), '')AS TitleNoeEstekhdam,fldOrganPostEjraeeId
							  ,tblOrganizationalPostsEjraee.fldTitle+'_'+tblOrganizationalPostsEjraee.fldOrgPostCode AS TitleOrganPostEjraee,
							  Com.tblChartOrganEjraee.fldTitle AS TitleChartOrganEjraee

FROM         Prs.Prs_tblPersonalInfo INNER JOIN
                      Com.tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = Com.tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON Com.tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
                      Com.tblStatusTaahol ON Com.tblEmployee_Detail.fldTaaholId = Com.tblStatusTaahol.fldId INNER JOIN
                      Com.tblCity ON Com.tblEmployee_Detail.fldMahalTavalodId = Com.tblCity.fldId INNER JOIN
                      Com.tblCity AS tblCity_1 ON Com.tblEmployee_Detail.fldMahalSodoorId = tblCity_1.fldId INNER JOIN
                      Prs.tblVaziyatEsargari ON Prs.Prs_tblPersonalInfo.fldEsargariId = Prs.tblVaziyatEsargari.fldId INNER JOIN
                      Com.tblOrganizationalPosts ON Prs.Prs_tblPersonalInfo.fldOrganPostId = Com.tblOrganizationalPosts.fldId INNER JOIN
                      Com.tblChartOrgan ON Com.tblOrganizationalPosts.fldChartOrganId = Com.tblChartOrgan.fldId LEFT OUTER JOIN
						Com.tblNezamVazife ON Com.tblEmployee_Detail.fldNezamVazifeId = Com.tblNezamVazife.fldId   INNER JOIN 
					  com.tblOrganizationalPostsEjraee ON Prs.Prs_tblPersonalInfo.fldOrganPostEjraeeId=com.tblOrganizationalPostsEjraee.fldId INNER JOIN
					  com.tblChartOrganEjraee ON com.tblOrganizationalPostsEjraee.fldChartOrganId =	com.tblChartOrganEjraee.fldid
					   OUTER APPLY (SELECT top(1) t.fldMadrakId,t.fldReshteId,tblMadrakTahsili.fldTitle as fldMadrakTahsiliTitle,tblReshteTahsili.fldtitle as fldReshteTahsiliTitle
										from com.tblHistoryTahsilat as t inner join 
									    Com.tblMadrakTahsili ON t.fldMadrakId = Com.tblMadrakTahsili.fldId INNER JOIN
									    Com.tblReshteTahsili ON t.fldReshteId = Com.tblReshteTahsili.fldId 
									   where t.fldEmployeeId=tblEmployee.fldid order by T.fldTarikh DESC)t
                      	WHERE Com.tblEmployee_Detail.fldNezamVazifeId = @Value 
                     ORDER BY Prs_tblPersonalInfo.fldId DESC   

                     if (@fieldname=N'CheckMadrakId')
SELECT    top(@h) Prs.Prs_tblPersonalInfo.fldId, Prs.Prs_tblPersonalInfo.fldEmployeeId, Com.tblEmployee_Detail.fldSh_Shenasname, 
                      Com.tblEmployee_Detail.fldTarikhTavalod, Com.tblEmployee_Detail.fldMahalTavalodId, Com.tblEmployee_Detail.fldMahalSodoorId, 
                      ISNULL(Com.tblEmployee_Detail.fldAddress,'')AS fldAddress, ISNULL(Com.tblEmployee_Detail.fldCodePosti,'') AS fldCodePosti, Prs.Prs_tblPersonalInfo.fldEsargariId, Prs.Prs_tblPersonalInfo.fldSharhEsargari, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali, t.fldMadrakId, t.fldReshteId, Com.tblEmployee_Detail.fldNezamVazifeId, 
                      Prs.Prs_tblPersonalInfo.fldOrganPostId, Prs.Prs_tblPersonalInfo.fldRasteShoghli, Prs.Prs_tblPersonalInfo.fldReshteShoghli, 
                      Prs.Prs_tblPersonalInfo.fldTarikhEstekhdam, tblOrganizationalPosts.fldChartOrganId, Prs.Prs_tblPersonalInfo.fldTabaghe, Com.tblEmployee_Detail.fldMeliyat, 
                      Prs.Prs_tblPersonalInfo.fldSh_MojavezEstekhdam, Prs.Prs_tblPersonalInfo.fldTarikhMajavezEstekhdam, Prs.Prs_tblPersonalInfo.fldUserId, 
                      Prs.Prs_tblPersonalInfo.fldDesc, Prs.Prs_tblPersonalInfo.fldDate, CASE WHEN fldMeliyat = 0 THEN N'غیر ایرانی' ELSE N'ایرانی' END AS fldMeliyatName, 
                      t.fldMadrakTahsiliTitle, Prs.tblVaziyatEsargari.fldTitle AS fldVaziyatEsargariTitle, ISNULL(Com.tblNezamVazife.fldTitle ,'') AS fldNezamVazifeTitle, 
                      Com.tblEmployee.fldName + '_' + Com.tblEmployee.fldFamily AS fldNameEmployee, Com.tblEmployee.fldName, Com.tblEmployee.fldFamily, 
                      Com.tblEmployee_Detail.fldFatherName, Com.tblEmployee_Detail.fldJensiyat, tblChartOrgan.fldTitle AS fldTitleChartOrgan, 
                      (SELECT Com.fn_stringDecode(tblOrganization.fldName) FROM Com.tblOrganization WHERE fldid = [Com].[fn_OrganName] (fldOrganPostId)) AS fldNameOrgan, Com.tblCity.fldName AS fldNameMahalTavalod, tblCity_1.fldName AS fldNameMahlSodoor, 
                      Com.tblEmployee.fldCodemeli, Com.tblEmployee_Detail.fldFileId, CASE WHEN fldJensiyat = 0 THEN N'زن' ELSE N'مرد' END AS fldNameJensiyat, 
                      tblOrganizationalPosts.fldTitle+'_'+tblOrganizationalPosts.fldOrgPostCode AS NamePostOran, t.fldReshteTahsiliTitle, 
                      Com.tblEmployee.fldFamily + '_' + Com.tblEmployee.fldName + '(' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName_FamilyEmployee, Com.tblEmployee_Detail.fldTel, Com.tblEmployee_Detail.fldMobile,
                      ISNULL(tblChartOrgan.fldOrganId, 0) AS fldOrganId, ISNULL
                          ((SELECT     TOP (1) fldId
                              FROM         Com.tblPersonalStatus
                              WHERE     (fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                              ORDER BY fldId DESC), 0) AS fldIdStatus, ISNULL
                          ((SELECT     TOP (1) fldNoeEstekhdamId
                              FROM         Prs.tblHistoryNoeEstekhdam
                              WHERE     (fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                              ORDER BY fldId DESC), 0) AS fldNoeEstekhdam,
                          (SELECT     TOP (1) Com.tblStatus.fldTitle
                            FROM          Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                                   Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                            WHERE      (tblPersonalStatus_1.fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                            ORDER BY tblPersonalStatus_1.fldId DESC) AS fldTitleStatus,fldTarikhSodoor,fldTaaholId,
                            ISNULL((SELECT     TOP (1)  Com.tblAnvaEstekhdam.fldTitle
FROM         Prs.tblHistoryNoeEstekhdam INNER JOIN
                      Com.tblAnvaEstekhdam ON Prs.tblHistoryNoeEstekhdam.fldNoeEstekhdamId = Com.tblAnvaEstekhdam.fldId
                              WHERE     (fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                              ORDER BY tblHistoryNoeEstekhdam.fldId DESC), '')AS TitleNoeEstekhdam,fldOrganPostEjraeeId
							  ,tblOrganizationalPostsEjraee.fldTitle+'_'+tblOrganizationalPostsEjraee.fldOrgPostCode AS TitleOrganPostEjraee,
							  Com.tblChartOrganEjraee.fldTitle AS TitleChartOrganEjraee

FROM         Prs.Prs_tblPersonalInfo INNER JOIN
                      Com.tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = Com.tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON Com.tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
                      Com.tblStatusTaahol ON Com.tblEmployee_Detail.fldTaaholId = Com.tblStatusTaahol.fldId INNER JOIN
                      Com.tblCity ON Com.tblEmployee_Detail.fldMahalTavalodId = Com.tblCity.fldId INNER JOIN
                      Com.tblCity AS tblCity_1 ON Com.tblEmployee_Detail.fldMahalSodoorId = tblCity_1.fldId INNER JOIN
                      Prs.tblVaziyatEsargari ON Prs.Prs_tblPersonalInfo.fldEsargariId = Prs.tblVaziyatEsargari.fldId INNER JOIN
                      Com.tblOrganizationalPosts ON Prs.Prs_tblPersonalInfo.fldOrganPostId = Com.tblOrganizationalPosts.fldId INNER JOIN
                      Com.tblChartOrgan ON Com.tblOrganizationalPosts.fldChartOrganId = Com.tblChartOrgan.fldId LEFT OUTER JOIN
						Com.tblNezamVazife ON Com.tblEmployee_Detail.fldNezamVazifeId = Com.tblNezamVazife.fldId   LEFT outer JOIN
					  com.tblOrganizationalPostsEjraee ON Prs.Prs_tblPersonalInfo.fldOrganPostEjraeeId=com.tblOrganizationalPostsEjraee.fldId LEFT outer JOIN
					  com.tblChartOrganEjraee ON com.tblOrganizationalPostsEjraee.fldChartOrganId =	com.tblChartOrganEjraee.fldid    
					   OUTER APPLY (SELECT top(1) t.fldMadrakId,t.fldReshteId,tblMadrakTahsili.fldTitle as fldMadrakTahsiliTitle,tblReshteTahsili.fldtitle as fldReshteTahsiliTitle
										from com.tblHistoryTahsilat as t inner join 
									    Com.tblMadrakTahsili ON t.fldMadrakId = Com.tblMadrakTahsili.fldId INNER JOIN
									    Com.tblReshteTahsili ON t.fldReshteId = Com.tblReshteTahsili.fldId 
									   where t.fldEmployeeId=tblEmployee.fldid order by T.fldTarikh DESC)t
                      	WHERE  t.fldMadrakId = @Value 
                     ORDER BY Prs_tblPersonalInfo.fldId DESC 

                    if (@fieldname=N'CheckEmployeeId')
SELECT    top(@h) Prs.Prs_tblPersonalInfo.fldId, Prs.Prs_tblPersonalInfo.fldEmployeeId, Com.tblEmployee_Detail.fldSh_Shenasname, 
                      Com.tblEmployee_Detail.fldTarikhTavalod, Com.tblEmployee_Detail.fldMahalTavalodId, Com.tblEmployee_Detail.fldMahalSodoorId, 
                      ISNULL(Com.tblEmployee_Detail.fldAddress,'')AS fldAddress, ISNULL(Com.tblEmployee_Detail.fldCodePosti,'') AS fldCodePosti, Prs.Prs_tblPersonalInfo.fldEsargariId, Prs.Prs_tblPersonalInfo.fldSharhEsargari, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali, t.fldMadrakId, t.fldReshteId, Com.tblEmployee_Detail.fldNezamVazifeId, 
                      Prs.Prs_tblPersonalInfo.fldOrganPostId, Prs.Prs_tblPersonalInfo.fldRasteShoghli, Prs.Prs_tblPersonalInfo.fldReshteShoghli, 
                      Prs.Prs_tblPersonalInfo.fldTarikhEstekhdam, tblOrganizationalPosts.fldChartOrganId, Prs.Prs_tblPersonalInfo.fldTabaghe, Com.tblEmployee_Detail.fldMeliyat, 
                      Prs.Prs_tblPersonalInfo.fldSh_MojavezEstekhdam, Prs.Prs_tblPersonalInfo.fldTarikhMajavezEstekhdam, Prs.Prs_tblPersonalInfo.fldUserId, 
                      Prs.Prs_tblPersonalInfo.fldDesc, Prs.Prs_tblPersonalInfo.fldDate, CASE WHEN fldMeliyat = 0 THEN N'غیر ایرانی' ELSE N'ایرانی' END AS fldMeliyatName, 
                      t.fldMadrakTahsiliTitle, Prs.tblVaziyatEsargari.fldTitle AS fldVaziyatEsargariTitle, ISNULL(Com.tblNezamVazife.fldTitle ,'') AS fldNezamVazifeTitle, 
                      Com.tblEmployee.fldName + '_' + Com.tblEmployee.fldFamily AS fldNameEmployee, Com.tblEmployee.fldName, Com.tblEmployee.fldFamily, 
                      Com.tblEmployee_Detail.fldFatherName, Com.tblEmployee_Detail.fldJensiyat, tblChartOrgan.fldTitle AS fldTitleChartOrgan, 
                      (SELECT Com.fn_stringDecode(tblOrganization.fldName) FROM Com.tblOrganization WHERE fldid = [Com].[fn_OrganName] (fldOrganPostId)) AS fldNameOrgan, Com.tblCity.fldName AS fldNameMahalTavalod, tblCity_1.fldName AS fldNameMahlSodoor, 
                      Com.tblEmployee.fldCodemeli, Com.tblEmployee_Detail.fldFileId, CASE WHEN fldJensiyat = 0 THEN N'زن' ELSE N'مرد' END AS fldNameJensiyat, 
                      tblOrganizationalPosts.fldTitle+'_'+tblOrganizationalPosts.fldOrgPostCode AS NamePostOran, t.fldReshteTahsiliTitle, 
                      Com.tblEmployee.fldFamily + '_' + Com.tblEmployee.fldName + '(' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName_FamilyEmployee, Com.tblEmployee_Detail.fldTel, Com.tblEmployee_Detail.fldMobile,
                      ISNULL(tblChartOrgan.fldOrganId, 0) AS fldOrganId, ISNULL
                          ((SELECT     TOP (1) fldId
                              FROM         Com.tblPersonalStatus
                              WHERE     (fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                              ORDER BY fldId DESC), 0) AS fldIdStatus, ISNULL
                          ((SELECT     TOP (1) fldNoeEstekhdamId
                              FROM         Prs.tblHistoryNoeEstekhdam
                              WHERE     (fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                              ORDER BY fldId DESC), 0) AS fldNoeEstekhdam,
                          (SELECT     TOP (1) Com.tblStatus.fldTitle
                            FROM          Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                                   Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                            WHERE      (tblPersonalStatus_1.fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                            ORDER BY tblPersonalStatus_1.fldId DESC) AS fldTitleStatus,fldTarikhSodoor,fldTaaholId,
                            ISNULL((SELECT     TOP (1)  Com.tblAnvaEstekhdam.fldTitle
FROM         Prs.tblHistoryNoeEstekhdam INNER JOIN
                      Com.tblAnvaEstekhdam ON Prs.tblHistoryNoeEstekhdam.fldNoeEstekhdamId = Com.tblAnvaEstekhdam.fldId
                              WHERE     (fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                              ORDER BY tblHistoryNoeEstekhdam.fldId DESC), '')AS TitleNoeEstekhdam,fldOrganPostEjraeeId
							  ,tblOrganizationalPostsEjraee.fldTitle+'_'+tblOrganizationalPostsEjraee.fldOrgPostCode AS TitleOrganPostEjraee,
							  Com.tblChartOrganEjraee.fldTitle AS TitleChartOrganEjraee

FROM         Prs.Prs_tblPersonalInfo INNER JOIN
                      Com.tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = Com.tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON Com.tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
                      Com.tblStatusTaahol ON Com.tblEmployee_Detail.fldTaaholId = Com.tblStatusTaahol.fldId INNER JOIN
                      Com.tblCity ON Com.tblEmployee_Detail.fldMahalTavalodId = Com.tblCity.fldId INNER JOIN
                      Com.tblCity AS tblCity_1 ON Com.tblEmployee_Detail.fldMahalSodoorId = tblCity_1.fldId INNER JOIN
                      Prs.tblVaziyatEsargari ON Prs.Prs_tblPersonalInfo.fldEsargariId = Prs.tblVaziyatEsargari.fldId INNER JOIN
                      Com.tblOrganizationalPosts ON Prs.Prs_tblPersonalInfo.fldOrganPostId = Com.tblOrganizationalPosts.fldId INNER JOIN
                      Com.tblChartOrgan ON Com.tblOrganizationalPosts.fldChartOrganId = Com.tblChartOrgan.fldId LEFT OUTER JOIN
						Com.tblNezamVazife ON Com.tblEmployee_Detail.fldNezamVazifeId = Com.tblNezamVazife.fldId   LEFT outer JOIN
					  com.tblOrganizationalPostsEjraee ON Prs.Prs_tblPersonalInfo.fldOrganPostEjraeeId=com.tblOrganizationalPostsEjraee.fldId LEFT outer JOIN
					  com.tblChartOrganEjraee ON com.tblOrganizationalPostsEjraee.fldChartOrganId =	com.tblChartOrganEjraee.fldid
					   OUTER APPLY (SELECT top(1) t.fldMadrakId,t.fldReshteId,tblMadrakTahsili.fldTitle as fldMadrakTahsiliTitle,tblReshteTahsili.fldtitle as fldReshteTahsiliTitle
										from com.tblHistoryTahsilat as t inner join 
									    Com.tblMadrakTahsili ON t.fldMadrakId = Com.tblMadrakTahsili.fldId INNER JOIN
									    Com.tblReshteTahsili ON t.fldReshteId = Com.tblReshteTahsili.fldId 
									   where t.fldEmployeeId=tblEmployee.fldid order by T.fldTarikh DESC)t
                      	WHERE  Prs_tblPersonalInfo.fldEmployeeId = @Value 
                     ORDER BY Prs_tblPersonalInfo.fldId DESC   

                      if (@fieldname=N'CheckMahalTavalodId')
SELECT    top(@h) Prs.Prs_tblPersonalInfo.fldId, Prs.Prs_tblPersonalInfo.fldEmployeeId, Com.tblEmployee_Detail.fldSh_Shenasname, 
                      Com.tblEmployee_Detail.fldTarikhTavalod, Com.tblEmployee_Detail.fldMahalTavalodId, Com.tblEmployee_Detail.fldMahalSodoorId, 
                      ISNULL(Com.tblEmployee_Detail.fldAddress,'')AS fldAddress, ISNULL(Com.tblEmployee_Detail.fldCodePosti,'') AS fldCodePosti, Prs.Prs_tblPersonalInfo.fldEsargariId, Prs.Prs_tblPersonalInfo.fldSharhEsargari, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali, t.fldMadrakId, t.fldReshteId, Com.tblEmployee_Detail.fldNezamVazifeId, 
                      Prs.Prs_tblPersonalInfo.fldOrganPostId, Prs.Prs_tblPersonalInfo.fldRasteShoghli, Prs.Prs_tblPersonalInfo.fldReshteShoghli, 
                      Prs.Prs_tblPersonalInfo.fldTarikhEstekhdam, tblOrganizationalPosts.fldChartOrganId, Prs.Prs_tblPersonalInfo.fldTabaghe, Com.tblEmployee_Detail.fldMeliyat, 
                      Prs.Prs_tblPersonalInfo.fldSh_MojavezEstekhdam, Prs.Prs_tblPersonalInfo.fldTarikhMajavezEstekhdam, Prs.Prs_tblPersonalInfo.fldUserId, 
                      Prs.Prs_tblPersonalInfo.fldDesc, Prs.Prs_tblPersonalInfo.fldDate, CASE WHEN fldMeliyat = 0 THEN N'غیر ایرانی' ELSE N'ایرانی' END AS fldMeliyatName, 
                      t.fldMadrakTahsiliTitle, Prs.tblVaziyatEsargari.fldTitle AS fldVaziyatEsargariTitle, ISNULL(Com.tblNezamVazife.fldTitle ,'') AS fldNezamVazifeTitle, 
                      Com.tblEmployee.fldName + '_' + Com.tblEmployee.fldFamily AS fldNameEmployee, Com.tblEmployee.fldName, Com.tblEmployee.fldFamily, 
                      Com.tblEmployee_Detail.fldFatherName, Com.tblEmployee_Detail.fldJensiyat, tblChartOrgan.fldTitle AS fldTitleChartOrgan, 
                      (SELECT Com.fn_stringDecode(tblOrganization.fldName) FROM Com.tblOrganization WHERE fldid = [Com].[fn_OrganName] (fldOrganPostId)) AS fldNameOrgan, Com.tblCity.fldName AS fldNameMahalTavalod, tblCity_1.fldName AS fldNameMahlSodoor, 
                      Com.tblEmployee.fldCodemeli, Com.tblEmployee_Detail.fldFileId, CASE WHEN fldJensiyat = 0 THEN N'زن' ELSE N'مرد' END AS fldNameJensiyat, 
                      tblOrganizationalPosts.fldTitle+'_'+tblOrganizationalPosts.fldOrgPostCode AS NamePostOran, t.fldReshteTahsiliTitle, 
                      Com.tblEmployee.fldFamily + '_' + Com.tblEmployee.fldName + '(' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName_FamilyEmployee, Com.tblEmployee_Detail.fldTel, Com.tblEmployee_Detail.fldMobile,
                      ISNULL(tblChartOrgan.fldOrganId, 0) AS fldOrganId, ISNULL
                          ((SELECT     TOP (1) fldId
                              FROM         Com.tblPersonalStatus
                              WHERE     (fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                              ORDER BY fldId DESC), 0) AS fldIdStatus, ISNULL
                          ((SELECT     TOP (1) fldNoeEstekhdamId
                              FROM         Prs.tblHistoryNoeEstekhdam
                              WHERE     (fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                              ORDER BY fldId DESC), 0) AS fldNoeEstekhdam,
                          (SELECT     TOP (1) Com.tblStatus.fldTitle
                            FROM          Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                                   Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                            WHERE      (tblPersonalStatus_1.fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                            ORDER BY tblPersonalStatus_1.fldId DESC) AS fldTitleStatus,fldTarikhSodoor,fldTaaholId,
                            ISNULL((SELECT     TOP (1)  Com.tblAnvaEstekhdam.fldTitle
FROM         Prs.tblHistoryNoeEstekhdam INNER JOIN
                      Com.tblAnvaEstekhdam ON Prs.tblHistoryNoeEstekhdam.fldNoeEstekhdamId = Com.tblAnvaEstekhdam.fldId
                              WHERE     (fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                              ORDER BY tblHistoryNoeEstekhdam.fldId DESC), '')AS TitleNoeEstekhdam,fldOrganPostEjraeeId
							  ,tblOrganizationalPostsEjraee.fldTitle+'_'+tblOrganizationalPostsEjraee.fldOrgPostCode AS TitleOrganPostEjraee,
							  Com.tblChartOrganEjraee.fldTitle AS TitleChartOrganEjraee

FROM         Prs.Prs_tblPersonalInfo INNER JOIN
                      Com.tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = Com.tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON Com.tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
                      Com.tblStatusTaahol ON Com.tblEmployee_Detail.fldTaaholId = Com.tblStatusTaahol.fldId INNER JOIN
                      Com.tblCity ON Com.tblEmployee_Detail.fldMahalTavalodId = Com.tblCity.fldId INNER JOIN
                      Com.tblCity AS tblCity_1 ON Com.tblEmployee_Detail.fldMahalSodoorId = tblCity_1.fldId INNER JOIN
                      Prs.tblVaziyatEsargari ON Prs.Prs_tblPersonalInfo.fldEsargariId = Prs.tblVaziyatEsargari.fldId INNER JOIN
                      Com.tblOrganizationalPosts ON Prs.Prs_tblPersonalInfo.fldOrganPostId = Com.tblOrganizationalPosts.fldId INNER JOIN
                      Com.tblChartOrgan ON Com.tblOrganizationalPosts.fldChartOrganId = Com.tblChartOrgan.fldId LEFT OUTER JOIN
						Com.tblNezamVazife ON Com.tblEmployee_Detail.fldNezamVazifeId = Com.tblNezamVazife.fldId   LEFT outer JOIN
					  com.tblOrganizationalPostsEjraee ON Prs.Prs_tblPersonalInfo.fldOrganPostEjraeeId=com.tblOrganizationalPostsEjraee.fldId LEFT outer JOIN
					  com.tblChartOrganEjraee ON com.tblOrganizationalPostsEjraee.fldChartOrganId =	com.tblChartOrganEjraee.fldid 
					   OUTER APPLY (SELECT top(1) t.fldMadrakId,t.fldReshteId,tblMadrakTahsili.fldTitle as fldMadrakTahsiliTitle,tblReshteTahsili.fldtitle as fldReshteTahsiliTitle
										from com.tblHistoryTahsilat as t inner join 
									    Com.tblMadrakTahsili ON t.fldMadrakId = Com.tblMadrakTahsili.fldId INNER JOIN
									    Com.tblReshteTahsili ON t.fldReshteId = Com.tblReshteTahsili.fldId 
									   where t.fldEmployeeId=tblEmployee.fldid order by T.fldTarikh DESC)t
                      	WHERE  Com.tblEmployee_Detail.fldMahalTavalodId = @Value 
                     ORDER BY Prs_tblPersonalInfo.fldId DESC                


    if (@fieldname=N'fldTitleStatus')
SELECT     TOP (@h)* FROM (SELECT Prs.Prs_tblPersonalInfo.fldId, Prs.Prs_tblPersonalInfo.fldEmployeeId, Com.tblEmployee_Detail.fldSh_Shenasname, 
                      Com.tblEmployee_Detail.fldTarikhTavalod, Com.tblEmployee_Detail.fldMahalTavalodId, Com.tblEmployee_Detail.fldMahalSodoorId, 
                      ISNULL(Com.tblEmployee_Detail.fldAddress,'')AS fldAddress, ISNULL(Com.tblEmployee_Detail.fldCodePosti,'') AS fldCodePosti, Prs.Prs_tblPersonalInfo.fldEsargariId, Prs.Prs_tblPersonalInfo.fldSharhEsargari, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali, t.fldMadrakId, t.fldReshteId, Com.tblEmployee_Detail.fldNezamVazifeId, 
                      Prs.Prs_tblPersonalInfo.fldOrganPostId, Prs.Prs_tblPersonalInfo.fldRasteShoghli, Prs.Prs_tblPersonalInfo.fldReshteShoghli, 
                      Prs.Prs_tblPersonalInfo.fldTarikhEstekhdam, tblOrganizationalPosts.fldChartOrganId, Prs.Prs_tblPersonalInfo.fldTabaghe, Com.tblEmployee_Detail.fldMeliyat, 
                      Prs.Prs_tblPersonalInfo.fldSh_MojavezEstekhdam, Prs.Prs_tblPersonalInfo.fldTarikhMajavezEstekhdam, Prs.Prs_tblPersonalInfo.fldUserId, 
                      Prs.Prs_tblPersonalInfo.fldDesc, Prs.Prs_tblPersonalInfo.fldDate, CASE WHEN fldMeliyat = 0 THEN N'غیر ایرانی' ELSE N'ایرانی' END AS fldMeliyatName, 
                      t.fldMadrakTahsiliTitle, Prs.tblVaziyatEsargari.fldTitle AS fldVaziyatEsargariTitle, ISNULL(Com.tblNezamVazife.fldTitle ,'') AS fldNezamVazifeTitle, 
                      Com.tblEmployee.fldName + '_' + Com.tblEmployee.fldFamily AS fldNameEmployee, Com.tblEmployee.fldName, Com.tblEmployee.fldFamily, 
                      Com.tblEmployee_Detail.fldFatherName, Com.tblEmployee_Detail.fldJensiyat, tblChartOrgan.fldTitle AS fldTitleChartOrgan, 
                      (SELECT Com.fn_stringDecode(tblOrganization.fldName) FROM Com.tblOrganization WHERE fldid = [Com].[fn_OrganName] (fldOrganPostId)) AS fldNameOrgan, Com.tblCity.fldName AS fldNameMahalTavalod, tblCity_1.fldName AS fldNameMahlSodoor, 
                      Com.tblEmployee.fldCodemeli, Com.tblEmployee_Detail.fldFileId, CASE WHEN fldJensiyat = 0 THEN N'زن' ELSE N'مرد' END AS fldNameJensiyat, 
                      tblOrganizationalPosts.fldTitle+'_'+tblOrganizationalPosts.fldOrgPostCode AS NamePostOran, t.fldReshteTahsiliTitle, 
                      Com.tblEmployee.fldFamily + '_' + Com.tblEmployee.fldName + '(' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName_FamilyEmployee, Com.tblEmployee_Detail.fldTel, Com.tblEmployee_Detail.fldMobile,
                      ISNULL(tblChartOrgan.fldOrganId, 0) AS fldOrganId, ISNULL
                          ((SELECT     TOP (1) fldId
                              FROM         Com.tblPersonalStatus
                              WHERE     (fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                              ORDER BY fldId DESC), 0) AS fldIdStatus, ISNULL
                          ((SELECT     TOP (1) fldNoeEstekhdamId
                              FROM         Prs.tblHistoryNoeEstekhdam
                              WHERE     (fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                              ORDER BY fldId DESC), 0) AS fldNoeEstekhdam,
                          (SELECT     TOP (1) Com.tblStatus.fldTitle
                            FROM          Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                                   Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                            WHERE      (tblPersonalStatus_1.fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                            ORDER BY tblPersonalStatus_1.fldId DESC) AS fldTitleStatus,fldTarikhSodoor,fldTaaholId,
                            ISNULL((SELECT     TOP (1)  Com.tblAnvaEstekhdam.fldTitle
FROM         Prs.tblHistoryNoeEstekhdam INNER JOIN
                      Com.tblAnvaEstekhdam ON Prs.tblHistoryNoeEstekhdam.fldNoeEstekhdamId = Com.tblAnvaEstekhdam.fldId
                              WHERE     (fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                              ORDER BY tblHistoryNoeEstekhdam.fldId DESC), '')AS TitleNoeEstekhdam,fldOrganPostEjraeeId
							  ,tblOrganizationalPostsEjraee.fldTitle+'_'+tblOrganizationalPostsEjraee.fldOrgPostCode AS TitleOrganPostEjraee,
							  Com.tblChartOrganEjraee.fldTitle AS TitleChartOrganEjraee

FROM         Prs.Prs_tblPersonalInfo INNER JOIN
                      Com.tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = Com.tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON Com.tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
                      Com.tblStatusTaahol ON Com.tblEmployee_Detail.fldTaaholId = Com.tblStatusTaahol.fldId INNER JOIN
                      Com.tblCity ON Com.tblEmployee_Detail.fldMahalTavalodId = Com.tblCity.fldId INNER JOIN
                      Com.tblCity AS tblCity_1 ON Com.tblEmployee_Detail.fldMahalSodoorId = tblCity_1.fldId INNER JOIN
                      Prs.tblVaziyatEsargari ON Prs.Prs_tblPersonalInfo.fldEsargariId = Prs.tblVaziyatEsargari.fldId INNER JOIN
                      Com.tblOrganizationalPosts ON Prs.Prs_tblPersonalInfo.fldOrganPostId = Com.tblOrganizationalPosts.fldId INNER JOIN
                      Com.tblChartOrgan ON Com.tblOrganizationalPosts.fldChartOrganId = Com.tblChartOrgan.fldId LEFT OUTER JOIN
						Com.tblNezamVazife ON Com.tblEmployee_Detail.fldNezamVazifeId = Com.tblNezamVazife.fldId   LEFT outer JOIN
					  com.tblOrganizationalPostsEjraee ON Prs.Prs_tblPersonalInfo.fldOrganPostEjraeeId=com.tblOrganizationalPostsEjraee.fldId LEFT outer JOIN
					  com.tblChartOrganEjraee ON com.tblOrganizationalPostsEjraee.fldChartOrganId =	com.tblChartOrganEjraee.fldid
					   OUTER APPLY (SELECT top(1) t.fldMadrakId,t.fldReshteId,tblMadrakTahsili.fldTitle as fldMadrakTahsiliTitle,tblReshteTahsili.fldtitle as fldReshteTahsiliTitle
										from com.tblHistoryTahsilat as t inner join 
									    Com.tblMadrakTahsili ON t.fldMadrakId = Com.tblMadrakTahsili.fldId INNER JOIN
									    Com.tblReshteTahsili ON t.fldReshteId = Com.tblReshteTahsili.fldId 
									   where t.fldEmployeeId=tblEmployee.fldid order by T.fldTarikh DESC)t

                      	WHERE com.fn_organId(Prs_tblPersonalInfo.fldid) =@OrganId)ty
                      	WHERE  fldTitleStatus LIKE @Value  
                     ORDER BY fldId desc

   if (@fieldname=N'CheckSh_Personali')
SELECT    top(@h) Prs.Prs_tblPersonalInfo.fldId, Prs.Prs_tblPersonalInfo.fldEmployeeId, Com.tblEmployee_Detail.fldSh_Shenasname, 
                      Com.tblEmployee_Detail.fldTarikhTavalod, Com.tblEmployee_Detail.fldMahalTavalodId, Com.tblEmployee_Detail.fldMahalSodoorId, 
                      ISNULL(Com.tblEmployee_Detail.fldAddress,'')AS fldAddress, ISNULL(Com.tblEmployee_Detail.fldCodePosti,'') AS fldCodePosti, Prs.Prs_tblPersonalInfo.fldEsargariId, Prs.Prs_tblPersonalInfo.fldSharhEsargari, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali, t.fldMadrakId, t.fldReshteId, Com.tblEmployee_Detail.fldNezamVazifeId, 
                      Prs.Prs_tblPersonalInfo.fldOrganPostId, Prs.Prs_tblPersonalInfo.fldRasteShoghli, Prs.Prs_tblPersonalInfo.fldReshteShoghli, 
                      Prs.Prs_tblPersonalInfo.fldTarikhEstekhdam, tblOrganizationalPosts.fldChartOrganId, Prs.Prs_tblPersonalInfo.fldTabaghe, Com.tblEmployee_Detail.fldMeliyat, 
                      Prs.Prs_tblPersonalInfo.fldSh_MojavezEstekhdam, Prs.Prs_tblPersonalInfo.fldTarikhMajavezEstekhdam, Prs.Prs_tblPersonalInfo.fldUserId, 
                      Prs.Prs_tblPersonalInfo.fldDesc, Prs.Prs_tblPersonalInfo.fldDate, CASE WHEN fldMeliyat = 0 THEN N'غیر ایرانی' ELSE N'ایرانی' END AS fldMeliyatName, 
                      t.fldMadrakTahsiliTitle, Prs.tblVaziyatEsargari.fldTitle AS fldVaziyatEsargariTitle, ISNULL(Com.tblNezamVazife.fldTitle ,'') AS fldNezamVazifeTitle, 
                      Com.tblEmployee.fldName + '_' + Com.tblEmployee.fldFamily AS fldNameEmployee, Com.tblEmployee.fldName, Com.tblEmployee.fldFamily, 
                      Com.tblEmployee_Detail.fldFatherName, Com.tblEmployee_Detail.fldJensiyat, tblChartOrgan.fldTitle AS fldTitleChartOrgan, 
                      (SELECT Com.fn_stringDecode(tblOrganization.fldName) FROM Com.tblOrganization WHERE fldid = [Com].[fn_OrganName] (fldOrganPostId)) AS fldNameOrgan, Com.tblCity.fldName AS fldNameMahalTavalod, tblCity_1.fldName AS fldNameMahlSodoor, 
                      Com.tblEmployee.fldCodemeli, Com.tblEmployee_Detail.fldFileId, CASE WHEN fldJensiyat = 0 THEN N'زن' ELSE N'مرد' END AS fldNameJensiyat, 
                      tblOrganizationalPosts.fldTitle+'_'+tblOrganizationalPosts.fldOrgPostCode AS NamePostOran, t.fldReshteTahsiliTitle, 
                      Com.tblEmployee.fldFamily + '_' + Com.tblEmployee.fldName + '(' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName_FamilyEmployee, Com.tblEmployee_Detail.fldTel, Com.tblEmployee_Detail.fldMobile,
                      ISNULL(tblChartOrgan.fldOrganId, 0) AS fldOrganId, ISNULL
                          ((SELECT     TOP (1) fldId
                              FROM         Com.tblPersonalStatus
                              WHERE     (fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                              ORDER BY fldId DESC), 0) AS fldIdStatus, ISNULL
                          ((SELECT     TOP (1) fldNoeEstekhdamId
                              FROM         Prs.tblHistoryNoeEstekhdam
                              WHERE     (fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                              ORDER BY fldId DESC), 0) AS fldNoeEstekhdam,
                          (SELECT     TOP (1) Com.tblStatus.fldTitle
                            FROM          Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                                   Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                            WHERE      (tblPersonalStatus_1.fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                            ORDER BY tblPersonalStatus_1.fldId DESC) AS fldTitleStatus,fldTarikhSodoor,fldTaaholId,
                            ISNULL((SELECT     TOP (1)  Com.tblAnvaEstekhdam.fldTitle
FROM         Prs.tblHistoryNoeEstekhdam INNER JOIN
                      Com.tblAnvaEstekhdam ON Prs.tblHistoryNoeEstekhdam.fldNoeEstekhdamId = Com.tblAnvaEstekhdam.fldId
                              WHERE     (fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                              ORDER BY tblHistoryNoeEstekhdam.fldId DESC), '')AS TitleNoeEstekhdam,fldOrganPostEjraeeId
							  ,tblOrganizationalPostsEjraee.fldTitle+'_'+tblOrganizationalPostsEjraee.fldOrgPostCode AS TitleOrganPostEjraee,
							  Com.tblChartOrganEjraee.fldTitle AS TitleChartOrganEjraee

FROM         Prs.Prs_tblPersonalInfo INNER JOIN
                      Com.tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = Com.tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON Com.tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
                      Com.tblStatusTaahol ON Com.tblEmployee_Detail.fldTaaholId = Com.tblStatusTaahol.fldId INNER JOIN
                      Com.tblCity ON Com.tblEmployee_Detail.fldMahalTavalodId = Com.tblCity.fldId INNER JOIN
                      Com.tblCity AS tblCity_1 ON Com.tblEmployee_Detail.fldMahalSodoorId = tblCity_1.fldId INNER JOIN
                      Prs.tblVaziyatEsargari ON Prs.Prs_tblPersonalInfo.fldEsargariId = Prs.tblVaziyatEsargari.fldId INNER JOIN
                      Com.tblOrganizationalPosts ON Prs.Prs_tblPersonalInfo.fldOrganPostId = Com.tblOrganizationalPosts.fldId INNER JOIN
                      Com.tblChartOrgan ON Com.tblOrganizationalPosts.fldChartOrganId = Com.tblChartOrgan.fldId LEFT OUTER JOIN
						Com.tblNezamVazife ON Com.tblEmployee_Detail.fldNezamVazifeId = Com.tblNezamVazife.fldId   LEFT outer JOIN
					  com.tblOrganizationalPostsEjraee ON Prs.Prs_tblPersonalInfo.fldOrganPostEjraeeId=com.tblOrganizationalPostsEjraee.fldId LEFT outer JOIN
					  com.tblChartOrganEjraee ON com.tblOrganizationalPostsEjraee.fldChartOrganId =	com.tblChartOrganEjraee.fldid
					   OUTER APPLY (SELECT top(1) t.fldMadrakId,t.fldReshteId,tblMadrakTahsili.fldTitle as fldMadrakTahsiliTitle,tblReshteTahsili.fldtitle as fldReshteTahsiliTitle
										from com.tblHistoryTahsilat as t inner join 
									    Com.tblMadrakTahsili ON t.fldMadrakId = Com.tblMadrakTahsili.fldId INNER JOIN
									    Com.tblReshteTahsili ON t.fldReshteId = Com.tblReshteTahsili.fldId 
									   where t.fldEmployeeId=tblEmployee.fldid order by T.fldTarikh DESC)t

                       WHERE  right('0000000000'+Prs_tblPersonalInfo.fldSh_Personali,10)   = @Value 
                     ORDER BY Prs_tblPersonalInfo.fldId DESC              



		if (@fieldname=N'fldSh_Personali')
SELECT    top(@h) Prs.Prs_tblPersonalInfo.fldId, Prs.Prs_tblPersonalInfo.fldEmployeeId, Com.tblEmployee_Detail.fldSh_Shenasname, 
                      Com.tblEmployee_Detail.fldTarikhTavalod, Com.tblEmployee_Detail.fldMahalTavalodId, Com.tblEmployee_Detail.fldMahalSodoorId, 
                      ISNULL(Com.tblEmployee_Detail.fldAddress,'')AS fldAddress, ISNULL(Com.tblEmployee_Detail.fldCodePosti,'') AS fldCodePosti, Prs.Prs_tblPersonalInfo.fldEsargariId, Prs.Prs_tblPersonalInfo.fldSharhEsargari, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali, t.fldMadrakId, t.fldReshteId, Com.tblEmployee_Detail.fldNezamVazifeId, 
                      Prs.Prs_tblPersonalInfo.fldOrganPostId, Prs.Prs_tblPersonalInfo.fldRasteShoghli, Prs.Prs_tblPersonalInfo.fldReshteShoghli, 
                      Prs.Prs_tblPersonalInfo.fldTarikhEstekhdam, tblOrganizationalPosts.fldChartOrganId, Prs.Prs_tblPersonalInfo.fldTabaghe, Com.tblEmployee_Detail.fldMeliyat, 
                      Prs.Prs_tblPersonalInfo.fldSh_MojavezEstekhdam, Prs.Prs_tblPersonalInfo.fldTarikhMajavezEstekhdam, Prs.Prs_tblPersonalInfo.fldUserId, 
                      Prs.Prs_tblPersonalInfo.fldDesc, Prs.Prs_tblPersonalInfo.fldDate, CASE WHEN fldMeliyat = 0 THEN N'غیر ایرانی' ELSE N'ایرانی' END AS fldMeliyatName, 
                      t.fldMadrakTahsiliTitle, Prs.tblVaziyatEsargari.fldTitle AS fldVaziyatEsargariTitle, ISNULL(Com.tblNezamVazife.fldTitle ,'') AS fldNezamVazifeTitle, 
                      Com.tblEmployee.fldName + '_' + Com.tblEmployee.fldFamily AS fldNameEmployee, Com.tblEmployee.fldName, Com.tblEmployee.fldFamily, 
                      Com.tblEmployee_Detail.fldFatherName, Com.tblEmployee_Detail.fldJensiyat, tblChartOrgan.fldTitle AS fldTitleChartOrgan, 
                      (SELECT Com.fn_stringDecode(tblOrganization.fldName) FROM Com.tblOrganization WHERE fldid = [Com].[fn_OrganName] (fldOrganPostId)) AS fldNameOrgan, Com.tblCity.fldName AS fldNameMahalTavalod, tblCity_1.fldName AS fldNameMahlSodoor, 
                      Com.tblEmployee.fldCodemeli, Com.tblEmployee_Detail.fldFileId, CASE WHEN fldJensiyat = 0 THEN N'زن' ELSE N'مرد' END AS fldNameJensiyat, 
                      tblOrganizationalPosts.fldTitle+'_'+tblOrganizationalPosts.fldOrgPostCode AS NamePostOran, t.fldReshteTahsiliTitle, 
                      Com.tblEmployee.fldFamily + '_' + Com.tblEmployee.fldName + '(' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName_FamilyEmployee, Com.tblEmployee_Detail.fldTel, Com.tblEmployee_Detail.fldMobile,
                      ISNULL(tblChartOrgan.fldOrganId, 0) AS fldOrganId, ISNULL
                          ((SELECT     TOP (1) fldId
                              FROM         Com.tblPersonalStatus
                              WHERE     (fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                              ORDER BY fldId DESC), 0) AS fldIdStatus, ISNULL
                          ((SELECT     TOP (1) fldNoeEstekhdamId
                              FROM         Prs.tblHistoryNoeEstekhdam
                              WHERE     (fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                              ORDER BY fldId DESC), 0) AS fldNoeEstekhdam,
                          (SELECT     TOP (1) Com.tblStatus.fldTitle
                            FROM          Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                                   Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                            WHERE      (tblPersonalStatus_1.fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                            ORDER BY tblPersonalStatus_1.fldId DESC) AS fldTitleStatus,fldTarikhSodoor,fldTaaholId,
                            ISNULL((SELECT     TOP (1)  Com.tblAnvaEstekhdam.fldTitle
FROM         Prs.tblHistoryNoeEstekhdam INNER JOIN
                      Com.tblAnvaEstekhdam ON Prs.tblHistoryNoeEstekhdam.fldNoeEstekhdamId = Com.tblAnvaEstekhdam.fldId
                              WHERE     (fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                              ORDER BY tblHistoryNoeEstekhdam.fldId DESC), '')AS TitleNoeEstekhdam,fldOrganPostEjraeeId
							  ,tblOrganizationalPostsEjraee.fldTitle+'_'+tblOrganizationalPostsEjraee.fldOrgPostCode AS TitleOrganPostEjraee,
							  Com.tblChartOrganEjraee.fldTitle AS TitleChartOrganEjraee

FROM         Prs.Prs_tblPersonalInfo INNER JOIN
                      Com.tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = Com.tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON Com.tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
                      Com.tblStatusTaahol ON Com.tblEmployee_Detail.fldTaaholId = Com.tblStatusTaahol.fldId INNER JOIN
                      Com.tblCity ON Com.tblEmployee_Detail.fldMahalTavalodId = Com.tblCity.fldId INNER JOIN
                      Com.tblCity AS tblCity_1 ON Com.tblEmployee_Detail.fldMahalSodoorId = tblCity_1.fldId INNER JOIN
                      Prs.tblVaziyatEsargari ON Prs.Prs_tblPersonalInfo.fldEsargariId = Prs.tblVaziyatEsargari.fldId INNER JOIN
                      Com.tblOrganizationalPosts ON Prs.Prs_tblPersonalInfo.fldOrganPostId = Com.tblOrganizationalPosts.fldId INNER JOIN
                      Com.tblChartOrgan ON Com.tblOrganizationalPosts.fldChartOrganId = Com.tblChartOrgan.fldId LEFT OUTER JOIN
						Com.tblNezamVazife ON Com.tblEmployee_Detail.fldNezamVazifeId = Com.tblNezamVazife.fldId   LEFT outer JOIN
					  com.tblOrganizationalPostsEjraee ON Prs.Prs_tblPersonalInfo.fldOrganPostEjraeeId=com.tblOrganizationalPostsEjraee.fldId LEFT outer JOIN
					  com.tblChartOrganEjraee ON com.tblOrganizationalPostsEjraee.fldChartOrganId =	com.tblChartOrganEjraee.fldid
					   OUTER APPLY (SELECT top(1) t.fldMadrakId,t.fldReshteId,tblMadrakTahsili.fldTitle as fldMadrakTahsiliTitle,tblReshteTahsili.fldtitle as fldReshteTahsiliTitle
										from com.tblHistoryTahsilat as t inner join 
									    Com.tblMadrakTahsili ON t.fldMadrakId = Com.tblMadrakTahsili.fldId INNER JOIN
									    Com.tblReshteTahsili ON t.fldReshteId = Com.tblReshteTahsili.fldId 
									   where t.fldEmployeeId=tblEmployee.fldid order by T.fldTarikh DESC)t

                      WHERE  Prs_tblPersonalInfo.fldSh_Personali LIKE @Value AND com.fn_organId(Prs_tblPersonalInfo.fldid) =@OrganId
                          	        ORDER BY Prs_tblPersonalInfo.fldId desc

		if (@fieldname=N'fldNameEmployee')
SELECT    TOP (@h)  * FROM(SELECT    Prs.Prs_tblPersonalInfo.fldId, Prs.Prs_tblPersonalInfo.fldEmployeeId, Com.tblEmployee_Detail.fldSh_Shenasname, 
                      Com.tblEmployee_Detail.fldTarikhTavalod, Com.tblEmployee_Detail.fldMahalTavalodId, Com.tblEmployee_Detail.fldMahalSodoorId, 
                      ISNULL(Com.tblEmployee_Detail.fldAddress,'')AS fldAddress, ISNULL(Com.tblEmployee_Detail.fldCodePosti,'') AS fldCodePosti, Prs.Prs_tblPersonalInfo.fldEsargariId, Prs.Prs_tblPersonalInfo.fldSharhEsargari, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali, t.fldMadrakId, t.fldReshteId, Com.tblEmployee_Detail.fldNezamVazifeId, 
                      Prs.Prs_tblPersonalInfo.fldOrganPostId, Prs.Prs_tblPersonalInfo.fldRasteShoghli, Prs.Prs_tblPersonalInfo.fldReshteShoghli, 
                      Prs.Prs_tblPersonalInfo.fldTarikhEstekhdam, tblOrganizationalPosts.fldChartOrganId, Prs.Prs_tblPersonalInfo.fldTabaghe, Com.tblEmployee_Detail.fldMeliyat, 
                      Prs.Prs_tblPersonalInfo.fldSh_MojavezEstekhdam, Prs.Prs_tblPersonalInfo.fldTarikhMajavezEstekhdam, Prs.Prs_tblPersonalInfo.fldUserId, 
                      Prs.Prs_tblPersonalInfo.fldDesc, Prs.Prs_tblPersonalInfo.fldDate, CASE WHEN fldMeliyat = 0 THEN N'غیر ایرانی' ELSE N'ایرانی' END AS fldMeliyatName, 
                      t.fldMadrakTahsiliTitle, Prs.tblVaziyatEsargari.fldTitle AS fldVaziyatEsargariTitle, ISNULL(Com.tblNezamVazife.fldTitle ,'') AS fldNezamVazifeTitle, 
                      Com.tblEmployee.fldName + '_' + Com.tblEmployee.fldFamily AS fldNameEmployee, Com.tblEmployee.fldName, Com.tblEmployee.fldFamily, 
                      Com.tblEmployee_Detail.fldFatherName, Com.tblEmployee_Detail.fldJensiyat, tblChartOrgan.fldTitle AS fldTitleChartOrgan, 
                      (SELECT Com.fn_stringDecode(tblOrganization.fldName) FROM Com.tblOrganization WHERE fldid = [Com].[fn_OrganName] (fldOrganPostId)) AS fldNameOrgan, Com.tblCity.fldName AS fldNameMahalTavalod, tblCity_1.fldName AS fldNameMahlSodoor, 
                      Com.tblEmployee.fldCodemeli, Com.tblEmployee_Detail.fldFileId, CASE WHEN fldJensiyat = 0 THEN N'زن' ELSE N'مرد' END AS fldNameJensiyat, 
                      tblOrganizationalPosts.fldTitle+'_'+tblOrganizationalPosts.fldOrgPostCode AS NamePostOran, t.fldReshteTahsiliTitle, 
                      Com.tblEmployee.fldFamily + '_' + Com.tblEmployee.fldName + '(' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName_FamilyEmployee,Com.tblEmployee_Detail.fldTel, Com.tblEmployee_Detail.fldMobile, 
                      ISNULL(tblChartOrgan.fldOrganId, 0) AS fldOrganId, ISNULL
                          ((SELECT     TOP (1) fldId
                              FROM         Com.tblPersonalStatus
                              WHERE     (fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                              ORDER BY fldId DESC), 0) AS fldIdStatus, ISNULL
                          ((SELECT     TOP (1) fldNoeEstekhdamId
                              FROM         Prs.tblHistoryNoeEstekhdam
                              WHERE     (fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                              ORDER BY fldId DESC), 0) AS fldNoeEstekhdam,
                          (SELECT     TOP (1) Com.tblStatus.fldTitle
                            FROM          Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                                   Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                            WHERE      (tblPersonalStatus_1.fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                            ORDER BY tblPersonalStatus_1.fldId DESC) AS fldTitleStatus,fldTarikhSodoor,fldTaaholId,
                            ISNULL((SELECT     TOP (1)  Com.tblAnvaEstekhdam.fldTitle
FROM         Prs.tblHistoryNoeEstekhdam INNER JOIN
                      Com.tblAnvaEstekhdam ON Prs.tblHistoryNoeEstekhdam.fldNoeEstekhdamId = Com.tblAnvaEstekhdam.fldId
                              WHERE     (fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                              ORDER BY tblHistoryNoeEstekhdam.fldId DESC), '')AS TitleNoeEstekhdam,fldOrganPostEjraeeId
							  ,tblOrganizationalPostsEjraee.fldTitle+'_'+tblOrganizationalPostsEjraee.fldOrgPostCode AS TitleOrganPostEjraee,
							  Com.tblChartOrganEjraee.fldTitle AS TitleChartOrganEjraee

FROM         Prs.Prs_tblPersonalInfo INNER JOIN
                      Com.tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = Com.tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON Com.tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
                      Com.tblStatusTaahol ON Com.tblEmployee_Detail.fldTaaholId = Com.tblStatusTaahol.fldId INNER JOIN
                      Com.tblCity ON Com.tblEmployee_Detail.fldMahalTavalodId = Com.tblCity.fldId INNER JOIN
                      Com.tblCity AS tblCity_1 ON Com.tblEmployee_Detail.fldMahalSodoorId = tblCity_1.fldId INNER JOIN
                      Prs.tblVaziyatEsargari ON Prs.Prs_tblPersonalInfo.fldEsargariId = Prs.tblVaziyatEsargari.fldId INNER JOIN
                      Com.tblOrganizationalPosts ON Prs.Prs_tblPersonalInfo.fldOrganPostId = Com.tblOrganizationalPosts.fldId INNER JOIN
                      Com.tblChartOrgan ON Com.tblOrganizationalPosts.fldChartOrganId = Com.tblChartOrgan.fldId LEFT OUTER JOIN
						Com.tblNezamVazife ON Com.tblEmployee_Detail.fldNezamVazifeId = Com.tblNezamVazife.fldId   LEFT outer JOIN
					  com.tblOrganizationalPostsEjraee ON Prs.Prs_tblPersonalInfo.fldOrganPostEjraeeId=com.tblOrganizationalPostsEjraee.fldId LEFT outer JOIN
					  com.tblChartOrganEjraee ON com.tblOrganizationalPostsEjraee.fldChartOrganId =	com.tblChartOrganEjraee.fldid
					   OUTER APPLY (SELECT top(1) t.fldMadrakId,t.fldReshteId,tblMadrakTahsili.fldTitle as fldMadrakTahsiliTitle,tblReshteTahsili.fldtitle as fldReshteTahsiliTitle
										from com.tblHistoryTahsilat as t inner join 
									    Com.tblMadrakTahsili ON t.fldMadrakId = Com.tblMadrakTahsili.fldId INNER JOIN
									    Com.tblReshteTahsili ON t.fldReshteId = Com.tblReshteTahsili.fldId 
									   where t.fldEmployeeId=tblEmployee.fldid order by T.fldTarikh DESC)t

  )temp
                       	WHERE temp.fldNameEmployee LIKE @Value and  com.fn_organId(fldid)=@OrganId
                       	        ORDER BY fldId DESC

      	if (@fieldname=N'fldName_FamilyEmployee')
SELECT    TOP (@h) * FROM(SELECT    Prs.Prs_tblPersonalInfo.fldId, Prs.Prs_tblPersonalInfo.fldEmployeeId, Com.tblEmployee_Detail.fldSh_Shenasname, 
                      Com.tblEmployee_Detail.fldTarikhTavalod, Com.tblEmployee_Detail.fldMahalTavalodId, Com.tblEmployee_Detail.fldMahalSodoorId, 
                      ISNULL(Com.tblEmployee_Detail.fldAddress,'')AS fldAddress, ISNULL(Com.tblEmployee_Detail.fldCodePosti,'') AS fldCodePosti, Prs.Prs_tblPersonalInfo.fldEsargariId, Prs.Prs_tblPersonalInfo.fldSharhEsargari, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali, t.fldMadrakId, t.fldReshteId, Com.tblEmployee_Detail.fldNezamVazifeId, 
                      Prs.Prs_tblPersonalInfo.fldOrganPostId, Prs.Prs_tblPersonalInfo.fldRasteShoghli, Prs.Prs_tblPersonalInfo.fldReshteShoghli, 
                      Prs.Prs_tblPersonalInfo.fldTarikhEstekhdam, tblOrganizationalPosts.fldChartOrganId, Prs.Prs_tblPersonalInfo.fldTabaghe, Com.tblEmployee_Detail.fldMeliyat, 
                      Prs.Prs_tblPersonalInfo.fldSh_MojavezEstekhdam, Prs.Prs_tblPersonalInfo.fldTarikhMajavezEstekhdam, Prs.Prs_tblPersonalInfo.fldUserId, 
                      Prs.Prs_tblPersonalInfo.fldDesc, Prs.Prs_tblPersonalInfo.fldDate, CASE WHEN fldMeliyat = 0 THEN N'غیر ایرانی' ELSE N'ایرانی' END AS fldMeliyatName, 
                      t.fldMadrakTahsiliTitle, Prs.tblVaziyatEsargari.fldTitle AS fldVaziyatEsargariTitle, ISNULL(Com.tblNezamVazife.fldTitle ,'') AS fldNezamVazifeTitle, 
                      Com.tblEmployee.fldName + '_' + Com.tblEmployee.fldFamily AS fldNameEmployee, Com.tblEmployee.fldName, Com.tblEmployee.fldFamily, 
                      Com.tblEmployee_Detail.fldFatherName, Com.tblEmployee_Detail.fldJensiyat, tblChartOrgan.fldTitle AS fldTitleChartOrgan, 
                      (SELECT Com.fn_stringDecode(tblOrganization.fldName) FROM Com.tblOrganization WHERE fldid = [Com].[fn_OrganName] (fldOrganPostId)) AS fldNameOrgan, Com.tblCity.fldName AS fldNameMahalTavalod, tblCity_1.fldName AS fldNameMahlSodoor, 
                      Com.tblEmployee.fldCodemeli, Com.tblEmployee_Detail.fldFileId, CASE WHEN fldJensiyat = 0 THEN N'زن' ELSE N'مرد' END AS fldNameJensiyat, 
                      tblOrganizationalPosts.fldTitle+'_'+tblOrganizationalPosts.fldOrgPostCode AS NamePostOran, t.fldReshteTahsiliTitle, 
                      Com.tblEmployee.fldFamily + '_' + Com.tblEmployee.fldName + '(' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName_FamilyEmployee, Com.tblEmployee_Detail.fldTel, Com.tblEmployee_Detail.fldMobile,
                      ISNULL(tblChartOrgan.fldOrganId, 0) AS fldOrganId, ISNULL
                          ((SELECT     TOP (1) fldId
                              FROM         Com.tblPersonalStatus
                              WHERE     (fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                              ORDER BY fldId DESC), 0) AS fldIdStatus, ISNULL
                          ((SELECT     TOP (1) fldNoeEstekhdamId
                              FROM         Prs.tblHistoryNoeEstekhdam
                              WHERE     (fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                              ORDER BY fldId DESC), 0) AS fldNoeEstekhdam,
                          (SELECT     TOP (1) Com.tblStatus.fldTitle
                            FROM          Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                                   Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                            WHERE      (tblPersonalStatus_1.fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                            ORDER BY tblPersonalStatus_1.fldId DESC) AS fldTitleStatus,fldTarikhSodoor,fldTaaholId,
                            ISNULL((SELECT     TOP (1)  Com.tblAnvaEstekhdam.fldTitle
FROM         Prs.tblHistoryNoeEstekhdam INNER JOIN
                      Com.tblAnvaEstekhdam ON Prs.tblHistoryNoeEstekhdam.fldNoeEstekhdamId = Com.tblAnvaEstekhdam.fldId
                              WHERE     (fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                              ORDER BY tblHistoryNoeEstekhdam.fldId DESC), '')AS TitleNoeEstekhdam,fldOrganPostEjraeeId
							  ,tblOrganizationalPostsEjraee.fldTitle+'_'+tblOrganizationalPostsEjraee.fldOrgPostCode AS TitleOrganPostEjraee,
							  Com.tblChartOrganEjraee.fldTitle AS TitleChartOrganEjraee

FROM         Prs.Prs_tblPersonalInfo INNER JOIN
                      Com.tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = Com.tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON Com.tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
                      Com.tblStatusTaahol ON Com.tblEmployee_Detail.fldTaaholId = Com.tblStatusTaahol.fldId INNER JOIN
                      Com.tblCity ON Com.tblEmployee_Detail.fldMahalTavalodId = Com.tblCity.fldId INNER JOIN
                      Com.tblCity AS tblCity_1 ON Com.tblEmployee_Detail.fldMahalSodoorId = tblCity_1.fldId INNER JOIN
                      Prs.tblVaziyatEsargari ON Prs.Prs_tblPersonalInfo.fldEsargariId = Prs.tblVaziyatEsargari.fldId INNER JOIN
                      Com.tblOrganizationalPosts ON Prs.Prs_tblPersonalInfo.fldOrganPostId = Com.tblOrganizationalPosts.fldId INNER JOIN
                      Com.tblChartOrgan ON Com.tblOrganizationalPosts.fldChartOrganId = Com.tblChartOrgan.fldId LEFT OUTER JOIN
						Com.tblNezamVazife ON Com.tblEmployee_Detail.fldNezamVazifeId = Com.tblNezamVazife.fldId   LEFT outer JOIN
					  com.tblOrganizationalPostsEjraee ON Prs.Prs_tblPersonalInfo.fldOrganPostEjraeeId=com.tblOrganizationalPostsEjraee.fldId LEFT outer JOIN
					  com.tblChartOrganEjraee ON com.tblOrganizationalPostsEjraee.fldChartOrganId =	com.tblChartOrganEjraee.fldid
					   OUTER APPLY (SELECT top(1) t.fldMadrakId,t.fldReshteId,tblMadrakTahsili.fldTitle as fldMadrakTahsiliTitle,tblReshteTahsili.fldtitle as fldReshteTahsiliTitle
										from com.tblHistoryTahsilat as t inner join 
									    Com.tblMadrakTahsili ON t.fldMadrakId = Com.tblMadrakTahsili.fldId INNER JOIN
									    Com.tblReshteTahsili ON t.fldReshteId = Com.tblReshteTahsili.fldId 
									   where t.fldEmployeeId=tblEmployee.fldid order by T.fldTarikh DESC)t

  )temp
                       	WHERE temp.fldName_FamilyEmployee LIKE @Value and  com.fn_organId(fldid)=@OrganId
                       	        ORDER BY fldId desc



		if (@fieldname=N'fldMadrakTahsiliTitle')
SELECT    top(@h) Prs.Prs_tblPersonalInfo.fldId, Prs.Prs_tblPersonalInfo.fldEmployeeId, Com.tblEmployee_Detail.fldSh_Shenasname, 
                      Com.tblEmployee_Detail.fldTarikhTavalod, Com.tblEmployee_Detail.fldMahalTavalodId, Com.tblEmployee_Detail.fldMahalSodoorId, 
                      ISNULL(Com.tblEmployee_Detail.fldAddress,'')AS fldAddress, ISNULL(Com.tblEmployee_Detail.fldCodePosti,'') AS fldCodePosti, Prs.Prs_tblPersonalInfo.fldEsargariId, Prs.Prs_tblPersonalInfo.fldSharhEsargari, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali, t.fldMadrakId, t.fldReshteId, Com.tblEmployee_Detail.fldNezamVazifeId, 
                      Prs.Prs_tblPersonalInfo.fldOrganPostId, Prs.Prs_tblPersonalInfo.fldRasteShoghli, Prs.Prs_tblPersonalInfo.fldReshteShoghli, 
                      Prs.Prs_tblPersonalInfo.fldTarikhEstekhdam, tblOrganizationalPosts.fldChartOrganId, Prs.Prs_tblPersonalInfo.fldTabaghe, Com.tblEmployee_Detail.fldMeliyat, 
                      Prs.Prs_tblPersonalInfo.fldSh_MojavezEstekhdam, Prs.Prs_tblPersonalInfo.fldTarikhMajavezEstekhdam, Prs.Prs_tblPersonalInfo.fldUserId, 
                      Prs.Prs_tblPersonalInfo.fldDesc, Prs.Prs_tblPersonalInfo.fldDate, CASE WHEN fldMeliyat = 0 THEN N'غیر ایرانی' ELSE N'ایرانی' END AS fldMeliyatName, 
                      t.fldMadrakTahsiliTitle, Prs.tblVaziyatEsargari.fldTitle AS fldVaziyatEsargariTitle, ISNULL(Com.tblNezamVazife.fldTitle ,'') AS fldNezamVazifeTitle, 
                      Com.tblEmployee.fldName + '_' + Com.tblEmployee.fldFamily AS fldNameEmployee, Com.tblEmployee.fldName, Com.tblEmployee.fldFamily, 
                      Com.tblEmployee_Detail.fldFatherName, Com.tblEmployee_Detail.fldJensiyat, tblChartOrgan.fldTitle AS fldTitleChartOrgan, 
                      (SELECT Com.fn_stringDecode(tblOrganization.fldName) FROM Com.tblOrganization WHERE fldid = [Com].[fn_OrganName] (fldOrganPostId)) AS fldNameOrgan, Com.tblCity.fldName AS fldNameMahalTavalod, tblCity_1.fldName AS fldNameMahlSodoor, 
                      Com.tblEmployee.fldCodemeli, Com.tblEmployee_Detail.fldFileId, CASE WHEN fldJensiyat = 0 THEN N'زن' ELSE N'مرد' END AS fldNameJensiyat, 
                      tblOrganizationalPosts.fldTitle+'_'+tblOrganizationalPosts.fldOrgPostCode AS NamePostOran, t.fldReshteTahsiliTitle, 
                      Com.tblEmployee.fldFamily + '_' + Com.tblEmployee.fldName + '(' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName_FamilyEmployee, Com.tblEmployee_Detail.fldTel, Com.tblEmployee_Detail.fldMobile,
                      ISNULL(tblChartOrgan.fldOrganId, 0) AS fldOrganId, ISNULL
                          ((SELECT     TOP (1) fldId
                              FROM         Com.tblPersonalStatus
                              WHERE     (fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                              ORDER BY fldId DESC), 0) AS fldIdStatus, ISNULL
                          ((SELECT     TOP (1) fldNoeEstekhdamId
                              FROM         Prs.tblHistoryNoeEstekhdam
                              WHERE     (fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                              ORDER BY fldId DESC), 0) AS fldNoeEstekhdam,
                          (SELECT     TOP (1) Com.tblStatus.fldTitle
                            FROM          Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                                   Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                            WHERE      (tblPersonalStatus_1.fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                            ORDER BY tblPersonalStatus_1.fldId DESC) AS fldTitleStatus,fldTarikhSodoor,fldTaaholId,
                            ISNULL((SELECT     TOP (1)  Com.tblAnvaEstekhdam.fldTitle
FROM         Prs.tblHistoryNoeEstekhdam INNER JOIN
                      Com.tblAnvaEstekhdam ON Prs.tblHistoryNoeEstekhdam.fldNoeEstekhdamId = Com.tblAnvaEstekhdam.fldId
                              WHERE     (fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                              ORDER BY tblHistoryNoeEstekhdam.fldId DESC), '')AS TitleNoeEstekhdam,fldOrganPostEjraeeId
							  ,tblOrganizationalPostsEjraee.fldTitle+'_'+tblOrganizationalPostsEjraee.fldOrgPostCode AS TitleOrganPostEjraee,
							  Com.tblChartOrganEjraee.fldTitle AS TitleChartOrganEjraee

FROM         Prs.Prs_tblPersonalInfo INNER JOIN
                      Com.tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = Com.tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON Com.tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
                      Com.tblStatusTaahol ON Com.tblEmployee_Detail.fldTaaholId = Com.tblStatusTaahol.fldId INNER JOIN
                      Com.tblCity ON Com.tblEmployee_Detail.fldMahalTavalodId = Com.tblCity.fldId INNER JOIN
                      Com.tblCity AS tblCity_1 ON Com.tblEmployee_Detail.fldMahalSodoorId = tblCity_1.fldId INNER JOIN
                      Prs.tblVaziyatEsargari ON Prs.Prs_tblPersonalInfo.fldEsargariId = Prs.tblVaziyatEsargari.fldId INNER JOIN
                      Com.tblOrganizationalPosts ON Prs.Prs_tblPersonalInfo.fldOrganPostId = Com.tblOrganizationalPosts.fldId INNER JOIN
                      Com.tblChartOrgan ON Com.tblOrganizationalPosts.fldChartOrganId = Com.tblChartOrgan.fldId LEFT OUTER JOIN
						Com.tblNezamVazife ON Com.tblEmployee_Detail.fldNezamVazifeId = Com.tblNezamVazife.fldId   LEFT outer JOIN
					  com.tblOrganizationalPostsEjraee ON Prs.Prs_tblPersonalInfo.fldOrganPostEjraeeId=com.tblOrganizationalPostsEjraee.fldId LEFT outer JOIN
					  com.tblChartOrganEjraee ON com.tblOrganizationalPostsEjraee.fldChartOrganId =	com.tblChartOrganEjraee.fldid
					   OUTER APPLY (SELECT top(1) t.fldMadrakId,t.fldReshteId,tblMadrakTahsili.fldTitle as fldMadrakTahsiliTitle,tblReshteTahsili.fldtitle as fldReshteTahsiliTitle
										from com.tblHistoryTahsilat as t inner join 
									    Com.tblMadrakTahsili ON t.fldMadrakId = Com.tblMadrakTahsili.fldId INNER JOIN
									    Com.tblReshteTahsili ON t.fldReshteId = Com.tblReshteTahsili.fldId 
									   where t.fldEmployeeId=tblEmployee.fldid order by T.fldTarikh DESC)t

                       	WHERE  fldMadrakTahsiliTitle LIKE @Value AND com.fn_organId(Prs_tblPersonalInfo.fldid) =@OrganId
                       	        ORDER BY Prs_tblPersonalInfo.fldId desc

		if (@fieldname=N'fldReshteTahsiliId')
SELECT    top(@h) Prs.Prs_tblPersonalInfo.fldId, Prs.Prs_tblPersonalInfo.fldEmployeeId, Com.tblEmployee_Detail.fldSh_Shenasname, 
                      Com.tblEmployee_Detail.fldTarikhTavalod, Com.tblEmployee_Detail.fldMahalTavalodId, Com.tblEmployee_Detail.fldMahalSodoorId, 
                      ISNULL(Com.tblEmployee_Detail.fldAddress,'')AS fldAddress, ISNULL(Com.tblEmployee_Detail.fldCodePosti,'') AS fldCodePosti, Prs.Prs_tblPersonalInfo.fldEsargariId, Prs.Prs_tblPersonalInfo.fldSharhEsargari, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali, t.fldMadrakId, t.fldReshteId, Com.tblEmployee_Detail.fldNezamVazifeId, 
                      Prs.Prs_tblPersonalInfo.fldOrganPostId, Prs.Prs_tblPersonalInfo.fldRasteShoghli, Prs.Prs_tblPersonalInfo.fldReshteShoghli, 
                      Prs.Prs_tblPersonalInfo.fldTarikhEstekhdam, tblOrganizationalPosts.fldChartOrganId, Prs.Prs_tblPersonalInfo.fldTabaghe, Com.tblEmployee_Detail.fldMeliyat, 
                      Prs.Prs_tblPersonalInfo.fldSh_MojavezEstekhdam, Prs.Prs_tblPersonalInfo.fldTarikhMajavezEstekhdam, Prs.Prs_tblPersonalInfo.fldUserId, 
                      Prs.Prs_tblPersonalInfo.fldDesc, Prs.Prs_tblPersonalInfo.fldDate, CASE WHEN fldMeliyat = 0 THEN N'غیر ایرانی' ELSE N'ایرانی' END AS fldMeliyatName, 
                      t.fldMadrakTahsiliTitle, Prs.tblVaziyatEsargari.fldTitle AS fldVaziyatEsargariTitle, ISNULL(Com.tblNezamVazife.fldTitle ,'') AS fldNezamVazifeTitle, 
                      Com.tblEmployee.fldName + '_' + Com.tblEmployee.fldFamily AS fldNameEmployee, Com.tblEmployee.fldName, Com.tblEmployee.fldFamily, 
                      Com.tblEmployee_Detail.fldFatherName, Com.tblEmployee_Detail.fldJensiyat, tblChartOrgan.fldTitle AS fldTitleChartOrgan, 
                      (SELECT Com.fn_stringDecode(tblOrganization.fldName) FROM Com.tblOrganization WHERE fldid = [Com].[fn_OrganName] (fldOrganPostId)) AS fldNameOrgan, Com.tblCity.fldName AS fldNameMahalTavalod, tblCity_1.fldName AS fldNameMahlSodoor, 
                      Com.tblEmployee.fldCodemeli, Com.tblEmployee_Detail.fldFileId, CASE WHEN fldJensiyat = 0 THEN N'زن' ELSE N'مرد' END AS fldNameJensiyat, 
                      tblOrganizationalPosts.fldTitle+'_'+tblOrganizationalPosts.fldOrgPostCode AS NamePostOran, t.fldReshteTahsiliTitle, 
                      Com.tblEmployee.fldFamily + '_' + Com.tblEmployee.fldName + '(' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName_FamilyEmployee, Com.tblEmployee_Detail.fldTel, Com.tblEmployee_Detail.fldMobile,
                      ISNULL(tblChartOrgan.fldOrganId, 0) AS fldOrganId, ISNULL
                          ((SELECT     TOP (1) fldId
                              FROM         Com.tblPersonalStatus
                              WHERE     (fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                              ORDER BY fldId DESC), 0) AS fldIdStatus, ISNULL
                          ((SELECT     TOP (1) fldNoeEstekhdamId
                              FROM         Prs.tblHistoryNoeEstekhdam
                              WHERE     (fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                              ORDER BY fldId DESC), 0) AS fldNoeEstekhdam,
                          (SELECT     TOP (1) Com.tblStatus.fldTitle
                            FROM          Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                                   Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                            WHERE      (tblPersonalStatus_1.fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                            ORDER BY tblPersonalStatus_1.fldId DESC) AS fldTitleStatus,fldTarikhSodoor,fldTaaholId,
                            ISNULL((SELECT     TOP (1)  Com.tblAnvaEstekhdam.fldTitle
FROM         Prs.tblHistoryNoeEstekhdam INNER JOIN
                      Com.tblAnvaEstekhdam ON Prs.tblHistoryNoeEstekhdam.fldNoeEstekhdamId = Com.tblAnvaEstekhdam.fldId
                              WHERE     (fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                              ORDER BY tblHistoryNoeEstekhdam.fldId DESC), '')AS TitleNoeEstekhdam,fldOrganPostEjraeeId
							  ,tblOrganizationalPostsEjraee.fldTitle+'_'+tblOrganizationalPostsEjraee.fldOrgPostCode AS TitleOrganPostEjraee,
							  Com.tblChartOrganEjraee.fldTitle AS TitleChartOrganEjraee

FROM         Prs.Prs_tblPersonalInfo INNER JOIN
                      Com.tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = Com.tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON Com.tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
                      Com.tblStatusTaahol ON Com.tblEmployee_Detail.fldTaaholId = Com.tblStatusTaahol.fldId INNER JOIN
                      Com.tblCity ON Com.tblEmployee_Detail.fldMahalTavalodId = Com.tblCity.fldId INNER JOIN
                      Com.tblCity AS tblCity_1 ON Com.tblEmployee_Detail.fldMahalSodoorId = tblCity_1.fldId INNER JOIN
                      Prs.tblVaziyatEsargari ON Prs.Prs_tblPersonalInfo.fldEsargariId = Prs.tblVaziyatEsargari.fldId INNER JOIN
                      Com.tblOrganizationalPosts ON Prs.Prs_tblPersonalInfo.fldOrganPostId = Com.tblOrganizationalPosts.fldId INNER JOIN
                      Com.tblChartOrgan ON Com.tblOrganizationalPosts.fldChartOrganId = Com.tblChartOrgan.fldId LEFT OUTER JOIN
						Com.tblNezamVazife ON Com.tblEmployee_Detail.fldNezamVazifeId = Com.tblNezamVazife.fldId   LEFT outer JOIN
					  com.tblOrganizationalPostsEjraee ON Prs.Prs_tblPersonalInfo.fldOrganPostEjraeeId=com.tblOrganizationalPostsEjraee.fldId LEFT outer JOIN
					  com.tblChartOrganEjraee ON com.tblOrganizationalPostsEjraee.fldChartOrganId =	com.tblChartOrganEjraee.fldid
					   OUTER APPLY (SELECT top(1) t.fldMadrakId,t.fldReshteId,tblMadrakTahsili.fldTitle as fldMadrakTahsiliTitle,tblReshteTahsili.fldtitle as fldReshteTahsiliTitle
										from com.tblHistoryTahsilat as t inner join 
									    Com.tblMadrakTahsili ON t.fldMadrakId = Com.tblMadrakTahsili.fldId INNER JOIN
									    Com.tblReshteTahsili ON t.fldReshteId = Com.tblReshteTahsili.fldId 
									   where t.fldEmployeeId=tblEmployee.fldid order by T.fldTarikh DESC)t

                       	WHERE  t.fldReshteId LIKE @Value   AND com.fn_organId(Prs_tblPersonalInfo.fldid) =@OrganId
                       	        ORDER BY Prs_tblPersonalInfo.fldId desc

	if (@fieldname=N'fldEmployeeId')
SELECT    top(@h) Prs.Prs_tblPersonalInfo.fldId, Prs.Prs_tblPersonalInfo.fldEmployeeId, Com.tblEmployee_Detail.fldSh_Shenasname, 
                      Com.tblEmployee_Detail.fldTarikhTavalod, Com.tblEmployee_Detail.fldMahalTavalodId, Com.tblEmployee_Detail.fldMahalSodoorId, 
                      ISNULL(Com.tblEmployee_Detail.fldAddress,'')AS fldAddress, ISNULL(Com.tblEmployee_Detail.fldCodePosti,'') AS fldCodePosti, Prs.Prs_tblPersonalInfo.fldEsargariId, Prs.Prs_tblPersonalInfo.fldSharhEsargari, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali, t.fldMadrakId, t.fldReshteId, Com.tblEmployee_Detail.fldNezamVazifeId, 
                      Prs.Prs_tblPersonalInfo.fldOrganPostId, Prs.Prs_tblPersonalInfo.fldRasteShoghli, Prs.Prs_tblPersonalInfo.fldReshteShoghli, 
                      Prs.Prs_tblPersonalInfo.fldTarikhEstekhdam, tblOrganizationalPosts.fldChartOrganId, Prs.Prs_tblPersonalInfo.fldTabaghe, Com.tblEmployee_Detail.fldMeliyat, 
                      Prs.Prs_tblPersonalInfo.fldSh_MojavezEstekhdam, Prs.Prs_tblPersonalInfo.fldTarikhMajavezEstekhdam, Prs.Prs_tblPersonalInfo.fldUserId, 
                      Prs.Prs_tblPersonalInfo.fldDesc, Prs.Prs_tblPersonalInfo.fldDate, CASE WHEN fldMeliyat = 0 THEN N'غیر ایرانی' ELSE N'ایرانی' END AS fldMeliyatName, 
                      t.fldMadrakTahsiliTitle, Prs.tblVaziyatEsargari.fldTitle AS fldVaziyatEsargariTitle, ISNULL(Com.tblNezamVazife.fldTitle ,'') AS fldNezamVazifeTitle, 
                      Com.tblEmployee.fldName + '_' + Com.tblEmployee.fldFamily AS fldNameEmployee, Com.tblEmployee.fldName, Com.tblEmployee.fldFamily, 
                      Com.tblEmployee_Detail.fldFatherName, Com.tblEmployee_Detail.fldJensiyat, tblChartOrgan.fldTitle AS fldTitleChartOrgan, 
                      (SELECT Com.fn_stringDecode(tblOrganization.fldName) FROM Com.tblOrganization WHERE fldid = [Com].[fn_OrganName] (fldOrganPostId)) AS fldNameOrgan, Com.tblCity.fldName AS fldNameMahalTavalod, tblCity_1.fldName AS fldNameMahlSodoor, 
                      Com.tblEmployee.fldCodemeli, Com.tblEmployee_Detail.fldFileId, CASE WHEN fldJensiyat = 0 THEN N'زن' ELSE N'مرد' END AS fldNameJensiyat, 
                      tblOrganizationalPosts.fldTitle+'_'+tblOrganizationalPosts.fldOrgPostCode AS NamePostOran, t.fldReshteTahsiliTitle, 
                      Com.tblEmployee.fldFamily + '_' + Com.tblEmployee.fldName + '(' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName_FamilyEmployee, Com.tblEmployee_Detail.fldTel, Com.tblEmployee_Detail.fldMobile,
                      ISNULL(tblChartOrgan.fldOrganId, 0) AS fldOrganId, ISNULL
                          ((SELECT     TOP (1) fldId
                              FROM         Com.tblPersonalStatus
                              WHERE     (fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                              ORDER BY fldId DESC), 0) AS fldIdStatus, ISNULL
                          ((SELECT     TOP (1) fldNoeEstekhdamId
                              FROM         Prs.tblHistoryNoeEstekhdam
                              WHERE     (fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                              ORDER BY fldId DESC), 0) AS fldNoeEstekhdam,
                          (SELECT     TOP (1) Com.tblStatus.fldTitle
                            FROM          Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                                   Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                            WHERE      (tblPersonalStatus_1.fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                            ORDER BY tblPersonalStatus_1.fldId DESC) AS fldTitleStatus,fldTarikhSodoor,fldTaaholId,
                            ISNULL((SELECT     TOP (1)  Com.tblAnvaEstekhdam.fldTitle
FROM         Prs.tblHistoryNoeEstekhdam INNER JOIN
                      Com.tblAnvaEstekhdam ON Prs.tblHistoryNoeEstekhdam.fldNoeEstekhdamId = Com.tblAnvaEstekhdam.fldId
                              WHERE     (fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                              ORDER BY tblHistoryNoeEstekhdam.fldId DESC), '')AS TitleNoeEstekhdam,fldOrganPostEjraeeId
							  ,tblOrganizationalPostsEjraee.fldTitle+'_'+tblOrganizationalPostsEjraee.fldOrgPostCode AS TitleOrganPostEjraee,
							  Com.tblChartOrganEjraee.fldTitle AS TitleChartOrganEjraee

FROM         Prs.Prs_tblPersonalInfo INNER JOIN
                      Com.tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = Com.tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON Com.tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
                      Com.tblStatusTaahol ON Com.tblEmployee_Detail.fldTaaholId = Com.tblStatusTaahol.fldId INNER JOIN
                      Com.tblCity ON Com.tblEmployee_Detail.fldMahalTavalodId = Com.tblCity.fldId INNER JOIN
                      Com.tblCity AS tblCity_1 ON Com.tblEmployee_Detail.fldMahalSodoorId = tblCity_1.fldId INNER JOIN
                      Prs.tblVaziyatEsargari ON Prs.Prs_tblPersonalInfo.fldEsargariId = Prs.tblVaziyatEsargari.fldId INNER JOIN
                      Com.tblOrganizationalPosts ON Prs.Prs_tblPersonalInfo.fldOrganPostId = Com.tblOrganizationalPosts.fldId INNER JOIN
                      Com.tblChartOrgan ON Com.tblOrganizationalPosts.fldChartOrganId = Com.tblChartOrgan.fldId LEFT OUTER JOIN
						Com.tblNezamVazife ON Com.tblEmployee_Detail.fldNezamVazifeId = Com.tblNezamVazife.fldId   LEFT outer JOIN
					  com.tblOrganizationalPostsEjraee ON Prs.Prs_tblPersonalInfo.fldOrganPostEjraeeId=com.tblOrganizationalPostsEjraee.fldId LEFT outer JOIN
					  com.tblChartOrganEjraee ON com.tblOrganizationalPostsEjraee.fldChartOrganId =	com.tblChartOrganEjraee.fldid
					   OUTER APPLY (SELECT top(1) t.fldMadrakId,t.fldReshteId,tblMadrakTahsili.fldTitle as fldMadrakTahsiliTitle,tblReshteTahsili.fldtitle as fldReshteTahsiliTitle
										from com.tblHistoryTahsilat as t inner join 
									    Com.tblMadrakTahsili ON t.fldMadrakId = Com.tblMadrakTahsili.fldId INNER JOIN
									    Com.tblReshteTahsili ON t.fldReshteId = Com.tblReshteTahsili.fldId 
									   where t.fldEmployeeId=tblEmployee.fldid order by T.fldTarikh DESC)t

                       	WHERE  Prs_tblPersonalInfo.fldEmployeeId = @Value  AND com.fn_organId(Prs_tblPersonalInfo.fldid) =@OrganId
                       	        ORDER BY Prs_tblPersonalInfo.fldId desc

	if (@fieldname=N'fldMahalTavalodId')
SELECT    top(@h) Prs.Prs_tblPersonalInfo.fldId, Prs.Prs_tblPersonalInfo.fldEmployeeId, Com.tblEmployee_Detail.fldSh_Shenasname, 
                      Com.tblEmployee_Detail.fldTarikhTavalod, Com.tblEmployee_Detail.fldMahalTavalodId, Com.tblEmployee_Detail.fldMahalSodoorId, 
                      ISNULL(Com.tblEmployee_Detail.fldAddress,'')AS fldAddress, ISNULL(Com.tblEmployee_Detail.fldCodePosti,'') AS fldCodePosti, Prs.Prs_tblPersonalInfo.fldEsargariId, Prs.Prs_tblPersonalInfo.fldSharhEsargari, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali, t.fldMadrakId, t.fldReshteId, Com.tblEmployee_Detail.fldNezamVazifeId, 
                      Prs.Prs_tblPersonalInfo.fldOrganPostId, Prs.Prs_tblPersonalInfo.fldRasteShoghli, Prs.Prs_tblPersonalInfo.fldReshteShoghli, 
                      Prs.Prs_tblPersonalInfo.fldTarikhEstekhdam, tblOrganizationalPosts.fldChartOrganId, Prs.Prs_tblPersonalInfo.fldTabaghe, Com.tblEmployee_Detail.fldMeliyat, 
                      Prs.Prs_tblPersonalInfo.fldSh_MojavezEstekhdam, Prs.Prs_tblPersonalInfo.fldTarikhMajavezEstekhdam, Prs.Prs_tblPersonalInfo.fldUserId, 
                      Prs.Prs_tblPersonalInfo.fldDesc, Prs.Prs_tblPersonalInfo.fldDate, CASE WHEN fldMeliyat = 0 THEN N'غیر ایرانی' ELSE N'ایرانی' END AS fldMeliyatName, 
                      t.fldMadrakTahsiliTitle, Prs.tblVaziyatEsargari.fldTitle AS fldVaziyatEsargariTitle, ISNULL(Com.tblNezamVazife.fldTitle ,'') AS fldNezamVazifeTitle, 
                      Com.tblEmployee.fldName + '_' + Com.tblEmployee.fldFamily AS fldNameEmployee, Com.tblEmployee.fldName, Com.tblEmployee.fldFamily, 
                      Com.tblEmployee_Detail.fldFatherName, Com.tblEmployee_Detail.fldJensiyat, tblChartOrgan.fldTitle AS fldTitleChartOrgan, 
                      (SELECT Com.fn_stringDecode(tblOrganization.fldName) FROM Com.tblOrganization WHERE fldid = [Com].[fn_OrganName] (fldOrganPostId)) AS fldNameOrgan, Com.tblCity.fldName AS fldNameMahalTavalod, tblCity_1.fldName AS fldNameMahlSodoor, 
                      Com.tblEmployee.fldCodemeli, Com.tblEmployee_Detail.fldFileId, CASE WHEN fldJensiyat = 0 THEN N'زن' ELSE N'مرد' END AS fldNameJensiyat, 
                      tblOrganizationalPosts.fldTitle+'_'+tblOrganizationalPosts.fldOrgPostCode AS NamePostOran, t.fldReshteTahsiliTitle, 
                      Com.tblEmployee.fldFamily + '_' + Com.tblEmployee.fldName + '(' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName_FamilyEmployee, Com.tblEmployee_Detail.fldTel, Com.tblEmployee_Detail.fldMobile,
                      ISNULL(tblChartOrgan.fldOrganId, 0) AS fldOrganId, ISNULL
                          ((SELECT     TOP (1) fldId
                              FROM         Com.tblPersonalStatus
                              WHERE     (fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                              ORDER BY fldId DESC), 0) AS fldIdStatus, ISNULL
                          ((SELECT     TOP (1) fldNoeEstekhdamId
                              FROM         Prs.tblHistoryNoeEstekhdam
                              WHERE     (fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                              ORDER BY fldId DESC), 0) AS fldNoeEstekhdam,
                          (SELECT     TOP (1) Com.tblStatus.fldTitle
                            FROM          Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                                   Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                            WHERE      (tblPersonalStatus_1.fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                            ORDER BY tblPersonalStatus_1.fldId DESC) AS fldTitleStatus,fldTarikhSodoor,fldTaaholId,
                            ISNULL((SELECT     TOP (1)  Com.tblAnvaEstekhdam.fldTitle
FROM         Prs.tblHistoryNoeEstekhdam INNER JOIN
                      Com.tblAnvaEstekhdam ON Prs.tblHistoryNoeEstekhdam.fldNoeEstekhdamId = Com.tblAnvaEstekhdam.fldId
                              WHERE     (fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                              ORDER BY tblHistoryNoeEstekhdam.fldId DESC), '')AS TitleNoeEstekhdam,fldOrganPostEjraeeId
							  ,tblOrganizationalPostsEjraee.fldTitle+'_'+tblOrganizationalPostsEjraee.fldOrgPostCode AS TitleOrganPostEjraee,
							  Com.tblChartOrganEjraee.fldTitle AS TitleChartOrganEjraee

FROM         Prs.Prs_tblPersonalInfo INNER JOIN
                      Com.tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = Com.tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON Com.tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
                      Com.tblStatusTaahol ON Com.tblEmployee_Detail.fldTaaholId = Com.tblStatusTaahol.fldId INNER JOIN
                      Com.tblCity ON Com.tblEmployee_Detail.fldMahalTavalodId = Com.tblCity.fldId INNER JOIN
                      Com.tblCity AS tblCity_1 ON Com.tblEmployee_Detail.fldMahalSodoorId = tblCity_1.fldId INNER JOIN
                      Prs.tblVaziyatEsargari ON Prs.Prs_tblPersonalInfo.fldEsargariId = Prs.tblVaziyatEsargari.fldId INNER JOIN
                      Com.tblOrganizationalPosts ON Prs.Prs_tblPersonalInfo.fldOrganPostId = Com.tblOrganizationalPosts.fldId INNER JOIN
                      Com.tblChartOrgan ON Com.tblOrganizationalPosts.fldChartOrganId = Com.tblChartOrgan.fldId LEFT OUTER JOIN
						Com.tblNezamVazife ON Com.tblEmployee_Detail.fldNezamVazifeId = Com.tblNezamVazife.fldId   LEFT outer JOIN
					  com.tblOrganizationalPostsEjraee ON Prs.Prs_tblPersonalInfo.fldOrganPostEjraeeId=com.tblOrganizationalPostsEjraee.fldId LEFT outer JOIN
					  com.tblChartOrganEjraee ON com.tblOrganizationalPostsEjraee.fldChartOrganId =	com.tblChartOrganEjraee.fldid
					   OUTER APPLY (SELECT top(1) t.fldMadrakId,t.fldReshteId,tblMadrakTahsili.fldTitle as fldMadrakTahsiliTitle,tblReshteTahsili.fldtitle as fldReshteTahsiliTitle
										from com.tblHistoryTahsilat as t inner join 
									    Com.tblMadrakTahsili ON t.fldMadrakId = Com.tblMadrakTahsili.fldId INNER JOIN
									    Com.tblReshteTahsili ON t.fldReshteId = Com.tblReshteTahsili.fldId 
									   where t.fldEmployeeId=tblEmployee.fldid order by T.fldTarikh DESC)t

                       	WHERE  fldMahalTavalodId = @Value  AND com.fn_organId(Prs_tblPersonalInfo.fldid) =@OrganId
                       	        ORDER BY Prs_tblPersonalInfo.fldId desc

	if (@fieldname=N'fldMahlSodoorId')
SELECT    top(@h) Prs.Prs_tblPersonalInfo.fldId, Prs.Prs_tblPersonalInfo.fldEmployeeId, Com.tblEmployee_Detail.fldSh_Shenasname, 
                      Com.tblEmployee_Detail.fldTarikhTavalod, Com.tblEmployee_Detail.fldMahalTavalodId, Com.tblEmployee_Detail.fldMahalSodoorId, 
                      ISNULL(Com.tblEmployee_Detail.fldAddress,'')AS fldAddress, ISNULL(Com.tblEmployee_Detail.fldCodePosti,'') AS fldCodePosti, Prs.Prs_tblPersonalInfo.fldEsargariId, Prs.Prs_tblPersonalInfo.fldSharhEsargari, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali, t.fldMadrakId, t.fldReshteId, Com.tblEmployee_Detail.fldNezamVazifeId, 
                      Prs.Prs_tblPersonalInfo.fldOrganPostId, Prs.Prs_tblPersonalInfo.fldRasteShoghli, Prs.Prs_tblPersonalInfo.fldReshteShoghli, 
                      Prs.Prs_tblPersonalInfo.fldTarikhEstekhdam, tblOrganizationalPosts.fldChartOrganId, Prs.Prs_tblPersonalInfo.fldTabaghe, Com.tblEmployee_Detail.fldMeliyat, 
                      Prs.Prs_tblPersonalInfo.fldSh_MojavezEstekhdam, Prs.Prs_tblPersonalInfo.fldTarikhMajavezEstekhdam, Prs.Prs_tblPersonalInfo.fldUserId, 
                      Prs.Prs_tblPersonalInfo.fldDesc, Prs.Prs_tblPersonalInfo.fldDate, CASE WHEN fldMeliyat = 0 THEN N'غیر ایرانی' ELSE N'ایرانی' END AS fldMeliyatName, 
                      t.fldMadrakTahsiliTitle, Prs.tblVaziyatEsargari.fldTitle AS fldVaziyatEsargariTitle, ISNULL(Com.tblNezamVazife.fldTitle ,'') AS fldNezamVazifeTitle, 
                      Com.tblEmployee.fldName + '_' + Com.tblEmployee.fldFamily AS fldNameEmployee, Com.tblEmployee.fldName, Com.tblEmployee.fldFamily, 
                      Com.tblEmployee_Detail.fldFatherName, Com.tblEmployee_Detail.fldJensiyat, tblChartOrgan.fldTitle AS fldTitleChartOrgan, 
                      (SELECT Com.fn_stringDecode(tblOrganization.fldName) FROM Com.tblOrganization WHERE fldid = [Com].[fn_OrganName] (fldOrganPostId)) AS fldNameOrgan, Com.tblCity.fldName AS fldNameMahalTavalod, tblCity_1.fldName AS fldNameMahlSodoor, 
                      Com.tblEmployee.fldCodemeli, Com.tblEmployee_Detail.fldFileId, CASE WHEN fldJensiyat = 0 THEN N'زن' ELSE N'مرد' END AS fldNameJensiyat, 
                      tblOrganizationalPosts.fldTitle+'_'+tblOrganizationalPosts.fldOrgPostCode AS NamePostOran, t.fldReshteTahsiliTitle, 
                      Com.tblEmployee.fldFamily + '_' + Com.tblEmployee.fldName + '(' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName_FamilyEmployee, Com.tblEmployee_Detail.fldTel, Com.tblEmployee_Detail.fldMobile,
                      ISNULL(tblChartOrgan.fldOrganId, 0) AS fldOrganId, ISNULL
                          ((SELECT     TOP (1) fldId
                              FROM         Com.tblPersonalStatus
                              WHERE     (fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                              ORDER BY fldId DESC), 0) AS fldIdStatus, ISNULL
                          ((SELECT     TOP (1) fldNoeEstekhdamId
                              FROM         Prs.tblHistoryNoeEstekhdam
                              WHERE     (fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                              ORDER BY fldId DESC), 0) AS fldNoeEstekhdam,
                          (SELECT     TOP (1) Com.tblStatus.fldTitle
                            FROM          Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                                   Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                            WHERE      (tblPersonalStatus_1.fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                            ORDER BY tblPersonalStatus_1.fldId DESC) AS fldTitleStatus,fldTarikhSodoor,fldTaaholId,
                            ISNULL((SELECT     TOP (1)  Com.tblAnvaEstekhdam.fldTitle
FROM         Prs.tblHistoryNoeEstekhdam INNER JOIN
                      Com.tblAnvaEstekhdam ON Prs.tblHistoryNoeEstekhdam.fldNoeEstekhdamId = Com.tblAnvaEstekhdam.fldId
                              WHERE     (fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                              ORDER BY tblHistoryNoeEstekhdam.fldId DESC), '')AS TitleNoeEstekhdam,fldOrganPostEjraeeId
							  ,tblOrganizationalPostsEjraee.fldTitle+'_'+tblOrganizationalPostsEjraee.fldOrgPostCode AS TitleOrganPostEjraee,
							  Com.tblChartOrganEjraee.fldTitle AS TitleChartOrganEjraee

FROM         Prs.Prs_tblPersonalInfo INNER JOIN
                      Com.tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = Com.tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON Com.tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
                      Com.tblStatusTaahol ON Com.tblEmployee_Detail.fldTaaholId = Com.tblStatusTaahol.fldId INNER JOIN
                      Com.tblCity ON Com.tblEmployee_Detail.fldMahalTavalodId = Com.tblCity.fldId INNER JOIN
                      Com.tblCity AS tblCity_1 ON Com.tblEmployee_Detail.fldMahalSodoorId = tblCity_1.fldId INNER JOIN
                      Prs.tblVaziyatEsargari ON Prs.Prs_tblPersonalInfo.fldEsargariId = Prs.tblVaziyatEsargari.fldId INNER JOIN
                      Com.tblOrganizationalPosts ON Prs.Prs_tblPersonalInfo.fldOrganPostId = Com.tblOrganizationalPosts.fldId INNER JOIN
                      Com.tblChartOrgan ON Com.tblOrganizationalPosts.fldChartOrganId = Com.tblChartOrgan.fldId LEFT OUTER JOIN
						Com.tblNezamVazife ON Com.tblEmployee_Detail.fldNezamVazifeId = Com.tblNezamVazife.fldId   LEFT outer JOIN
					  com.tblOrganizationalPostsEjraee ON Prs.Prs_tblPersonalInfo.fldOrganPostEjraeeId=com.tblOrganizationalPostsEjraee.fldId LEFT outer JOIN
					  com.tblChartOrganEjraee ON com.tblOrganizationalPostsEjraee.fldChartOrganId =	com.tblChartOrganEjraee.fldid
					   OUTER APPLY (SELECT top(1) t.fldMadrakId,t.fldReshteId,tblMadrakTahsili.fldTitle as fldMadrakTahsiliTitle,tblReshteTahsili.fldtitle as fldReshteTahsiliTitle
										from com.tblHistoryTahsilat as t inner join 
									    Com.tblMadrakTahsili ON t.fldMadrakId = Com.tblMadrakTahsili.fldId INNER JOIN
									    Com.tblReshteTahsili ON t.fldReshteId = Com.tblReshteTahsili.fldId 
									   where t.fldEmployeeId=tblEmployee.fldid order by T.fldTarikh DESC)t

                       	WHERE  Com.tblEmployee_Detail.fldMahalSodoorId = @Value  AND com.fn_organId(Prs_tblPersonalInfo.fldid) =@OrganId
                       	        ORDER BY Prs_tblPersonalInfo.fldId desc

	if (@fieldname=N'fldEsargariId')
SELECT    top(@h) Prs.Prs_tblPersonalInfo.fldId, Prs.Prs_tblPersonalInfo.fldEmployeeId, Com.tblEmployee_Detail.fldSh_Shenasname, 
                      Com.tblEmployee_Detail.fldTarikhTavalod, Com.tblEmployee_Detail.fldMahalTavalodId, Com.tblEmployee_Detail.fldMahalSodoorId, 
                      ISNULL(Com.tblEmployee_Detail.fldAddress,'')AS fldAddress, ISNULL(Com.tblEmployee_Detail.fldCodePosti,'') AS fldCodePosti, Prs.Prs_tblPersonalInfo.fldEsargariId, Prs.Prs_tblPersonalInfo.fldSharhEsargari, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali, t.fldMadrakId, t.fldReshteId, Com.tblEmployee_Detail.fldNezamVazifeId, 
                      Prs.Prs_tblPersonalInfo.fldOrganPostId, Prs.Prs_tblPersonalInfo.fldRasteShoghli, Prs.Prs_tblPersonalInfo.fldReshteShoghli, 
                      Prs.Prs_tblPersonalInfo.fldTarikhEstekhdam, tblOrganizationalPosts.fldChartOrganId, Prs.Prs_tblPersonalInfo.fldTabaghe, Com.tblEmployee_Detail.fldMeliyat, 
                      Prs.Prs_tblPersonalInfo.fldSh_MojavezEstekhdam, Prs.Prs_tblPersonalInfo.fldTarikhMajavezEstekhdam, Prs.Prs_tblPersonalInfo.fldUserId, 
                      Prs.Prs_tblPersonalInfo.fldDesc, Prs.Prs_tblPersonalInfo.fldDate, CASE WHEN fldMeliyat = 0 THEN N'غیر ایرانی' ELSE N'ایرانی' END AS fldMeliyatName, 
                      t.fldMadrakTahsiliTitle, Prs.tblVaziyatEsargari.fldTitle AS fldVaziyatEsargariTitle, ISNULL(Com.tblNezamVazife.fldTitle ,'') AS fldNezamVazifeTitle, 
                      Com.tblEmployee.fldName + '_' + Com.tblEmployee.fldFamily AS fldNameEmployee, Com.tblEmployee.fldName, Com.tblEmployee.fldFamily, 
                      Com.tblEmployee_Detail.fldFatherName, Com.tblEmployee_Detail.fldJensiyat, tblChartOrgan.fldTitle AS fldTitleChartOrgan, 
                      (SELECT Com.fn_stringDecode(tblOrganization.fldName) FROM Com.tblOrganization WHERE fldid = [Com].[fn_OrganName] (fldOrganPostId)) AS fldNameOrgan, Com.tblCity.fldName AS fldNameMahalTavalod, tblCity_1.fldName AS fldNameMahlSodoor, 
                      Com.tblEmployee.fldCodemeli, Com.tblEmployee_Detail.fldFileId, CASE WHEN fldJensiyat = 0 THEN N'زن' ELSE N'مرد' END AS fldNameJensiyat, 
                      tblOrganizationalPosts.fldTitle+'_'+tblOrganizationalPosts.fldOrgPostCode AS NamePostOran, t.fldReshteTahsiliTitle, 
                      Com.tblEmployee.fldFamily + '_' + Com.tblEmployee.fldName + '(' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName_FamilyEmployee, Com.tblEmployee_Detail.fldTel, Com.tblEmployee_Detail.fldMobile,
                      ISNULL(tblChartOrgan.fldOrganId, 0) AS fldOrganId, ISNULL
                          ((SELECT     TOP (1) fldId
                              FROM         Com.tblPersonalStatus
                              WHERE     (fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                              ORDER BY fldId DESC), 0) AS fldIdStatus, ISNULL
                          ((SELECT     TOP (1) fldNoeEstekhdamId
                              FROM         Prs.tblHistoryNoeEstekhdam
                              WHERE     (fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                              ORDER BY fldId DESC), 0) AS fldNoeEstekhdam,
                          (SELECT     TOP (1) Com.tblStatus.fldTitle
                            FROM          Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                                   Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                            WHERE      (tblPersonalStatus_1.fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                            ORDER BY tblPersonalStatus_1.fldId DESC) AS fldTitleStatus,fldTarikhSodoor,fldTaaholId,
                            ISNULL((SELECT     TOP (1)  Com.tblAnvaEstekhdam.fldTitle
FROM         Prs.tblHistoryNoeEstekhdam INNER JOIN
                      Com.tblAnvaEstekhdam ON Prs.tblHistoryNoeEstekhdam.fldNoeEstekhdamId = Com.tblAnvaEstekhdam.fldId
                              WHERE     (fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                              ORDER BY tblHistoryNoeEstekhdam.fldId DESC), '')AS TitleNoeEstekhdam,fldOrganPostEjraeeId
							  ,tblOrganizationalPostsEjraee.fldTitle+'_'+tblOrganizationalPostsEjraee.fldOrgPostCode AS TitleOrganPostEjraee,
							  Com.tblChartOrganEjraee.fldTitle AS TitleChartOrganEjraee

FROM         Prs.Prs_tblPersonalInfo INNER JOIN
                      Com.tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = Com.tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON Com.tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
                      Com.tblStatusTaahol ON Com.tblEmployee_Detail.fldTaaholId = Com.tblStatusTaahol.fldId INNER JOIN
                      Com.tblCity ON Com.tblEmployee_Detail.fldMahalTavalodId = Com.tblCity.fldId INNER JOIN
                      Com.tblCity AS tblCity_1 ON Com.tblEmployee_Detail.fldMahalSodoorId = tblCity_1.fldId INNER JOIN
                      Prs.tblVaziyatEsargari ON Prs.Prs_tblPersonalInfo.fldEsargariId = Prs.tblVaziyatEsargari.fldId INNER JOIN
                      Com.tblOrganizationalPosts ON Prs.Prs_tblPersonalInfo.fldOrganPostId = Com.tblOrganizationalPosts.fldId INNER JOIN
                      Com.tblChartOrgan ON Com.tblOrganizationalPosts.fldChartOrganId = Com.tblChartOrgan.fldId LEFT OUTER JOIN
						Com.tblNezamVazife ON Com.tblEmployee_Detail.fldNezamVazifeId = Com.tblNezamVazife.fldId   LEFT outer JOIN
					  com.tblOrganizationalPostsEjraee ON Prs.Prs_tblPersonalInfo.fldOrganPostEjraeeId=com.tblOrganizationalPostsEjraee.fldId LEFT outer JOIN
					  com.tblChartOrganEjraee ON com.tblOrganizationalPostsEjraee.fldChartOrganId =	com.tblChartOrganEjraee.fldid
					   OUTER APPLY (SELECT top(1) t.fldMadrakId,t.fldReshteId,tblMadrakTahsili.fldTitle as fldMadrakTahsiliTitle,tblReshteTahsili.fldtitle as fldReshteTahsiliTitle
										from com.tblHistoryTahsilat as t inner join 
									    Com.tblMadrakTahsili ON t.fldMadrakId = Com.tblMadrakTahsili.fldId INNER JOIN
									    Com.tblReshteTahsili ON t.fldReshteId = Com.tblReshteTahsili.fldId 
									   where t.fldEmployeeId=tblEmployee.fldid order by T.fldTarikh DESC)t

                  	WHERE  fldEsargariId = @Value  AND com.fn_organId(Prs_tblPersonalInfo.fldid) =@OrganId
                       	        ORDER BY Prs_tblPersonalInfo.fldId desc

	if (@fieldname=N'fldMadrakId')
SELECT    top(@h) Prs.Prs_tblPersonalInfo.fldId, Prs.Prs_tblPersonalInfo.fldEmployeeId, Com.tblEmployee_Detail.fldSh_Shenasname, 
                      Com.tblEmployee_Detail.fldTarikhTavalod, Com.tblEmployee_Detail.fldMahalTavalodId, Com.tblEmployee_Detail.fldMahalSodoorId, 
                      ISNULL(Com.tblEmployee_Detail.fldAddress,'')AS fldAddress, ISNULL(Com.tblEmployee_Detail.fldCodePosti,'') AS fldCodePosti, Prs.Prs_tblPersonalInfo.fldEsargariId, Prs.Prs_tblPersonalInfo.fldSharhEsargari, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali, t.fldMadrakId, t.fldReshteId, Com.tblEmployee_Detail.fldNezamVazifeId, 
                      Prs.Prs_tblPersonalInfo.fldOrganPostId, Prs.Prs_tblPersonalInfo.fldRasteShoghli, Prs.Prs_tblPersonalInfo.fldReshteShoghli, 
                      Prs.Prs_tblPersonalInfo.fldTarikhEstekhdam, tblOrganizationalPosts.fldChartOrganId, Prs.Prs_tblPersonalInfo.fldTabaghe, Com.tblEmployee_Detail.fldMeliyat, 
                      Prs.Prs_tblPersonalInfo.fldSh_MojavezEstekhdam, Prs.Prs_tblPersonalInfo.fldTarikhMajavezEstekhdam, Prs.Prs_tblPersonalInfo.fldUserId, 
                      Prs.Prs_tblPersonalInfo.fldDesc, Prs.Prs_tblPersonalInfo.fldDate, CASE WHEN fldMeliyat = 0 THEN N'غیر ایرانی' ELSE N'ایرانی' END AS fldMeliyatName, 
                      t.fldMadrakTahsiliTitle, Prs.tblVaziyatEsargari.fldTitle AS fldVaziyatEsargariTitle, ISNULL(Com.tblNezamVazife.fldTitle ,'') AS fldNezamVazifeTitle, 
                      Com.tblEmployee.fldName + '_' + Com.tblEmployee.fldFamily AS fldNameEmployee, Com.tblEmployee.fldName, Com.tblEmployee.fldFamily, 
                      Com.tblEmployee_Detail.fldFatherName, Com.tblEmployee_Detail.fldJensiyat, tblChartOrgan.fldTitle AS fldTitleChartOrgan, 
                      (SELECT Com.fn_stringDecode(tblOrganization.fldName) FROM Com.tblOrganization WHERE fldid = [Com].[fn_OrganName] (fldOrganPostId)) AS fldNameOrgan, Com.tblCity.fldName AS fldNameMahalTavalod, tblCity_1.fldName AS fldNameMahlSodoor, 
                      Com.tblEmployee.fldCodemeli, Com.tblEmployee_Detail.fldFileId, CASE WHEN fldJensiyat = 0 THEN N'زن' ELSE N'مرد' END AS fldNameJensiyat, 
                      tblOrganizationalPosts.fldTitle+'_'+tblOrganizationalPosts.fldOrgPostCode AS NamePostOran, t.fldReshteTahsiliTitle, 
                      Com.tblEmployee.fldFamily + '_' + Com.tblEmployee.fldName + '(' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName_FamilyEmployee, Com.tblEmployee_Detail.fldTel, Com.tblEmployee_Detail.fldMobile,
                      ISNULL(tblChartOrgan.fldOrganId, 0) AS fldOrganId, ISNULL
                          ((SELECT     TOP (1) fldId
                              FROM         Com.tblPersonalStatus
                              WHERE     (fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                              ORDER BY fldId DESC), 0) AS fldIdStatus, ISNULL
                          ((SELECT     TOP (1) fldNoeEstekhdamId
                              FROM         Prs.tblHistoryNoeEstekhdam
                              WHERE     (fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                              ORDER BY fldId DESC), 0) AS fldNoeEstekhdam,
                          (SELECT     TOP (1) Com.tblStatus.fldTitle
                            FROM          Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                                   Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                            WHERE      (tblPersonalStatus_1.fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                            ORDER BY tblPersonalStatus_1.fldId DESC) AS fldTitleStatus,fldTarikhSodoor,fldTaaholId,
                            ISNULL((SELECT     TOP (1)  Com.tblAnvaEstekhdam.fldTitle
FROM         Prs.tblHistoryNoeEstekhdam INNER JOIN
                      Com.tblAnvaEstekhdam ON Prs.tblHistoryNoeEstekhdam.fldNoeEstekhdamId = Com.tblAnvaEstekhdam.fldId
                              WHERE     (fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                              ORDER BY tblHistoryNoeEstekhdam.fldId DESC), '')AS TitleNoeEstekhdam,fldOrganPostEjraeeId
							  ,tblOrganizationalPostsEjraee.fldTitle+'_'+tblOrganizationalPostsEjraee.fldOrgPostCode AS TitleOrganPostEjraee,
							  Com.tblChartOrganEjraee.fldTitle AS TitleChartOrganEjraee

FROM         Prs.Prs_tblPersonalInfo INNER JOIN
                      Com.tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = Com.tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON Com.tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
                      Com.tblStatusTaahol ON Com.tblEmployee_Detail.fldTaaholId = Com.tblStatusTaahol.fldId INNER JOIN
                      Com.tblCity ON Com.tblEmployee_Detail.fldMahalTavalodId = Com.tblCity.fldId INNER JOIN
                      Com.tblCity AS tblCity_1 ON Com.tblEmployee_Detail.fldMahalSodoorId = tblCity_1.fldId INNER JOIN
                      Prs.tblVaziyatEsargari ON Prs.Prs_tblPersonalInfo.fldEsargariId = Prs.tblVaziyatEsargari.fldId INNER JOIN
                      Com.tblOrganizationalPosts ON Prs.Prs_tblPersonalInfo.fldOrganPostId = Com.tblOrganizationalPosts.fldId INNER JOIN
                      Com.tblChartOrgan ON Com.tblOrganizationalPosts.fldChartOrganId = Com.tblChartOrgan.fldId LEFT OUTER JOIN
						Com.tblNezamVazife ON Com.tblEmployee_Detail.fldNezamVazifeId = Com.tblNezamVazife.fldId   LEFT outer JOIN
					  com.tblOrganizationalPostsEjraee ON Prs.Prs_tblPersonalInfo.fldOrganPostEjraeeId=com.tblOrganizationalPostsEjraee.fldId LEFT outer JOIN
					  com.tblChartOrganEjraee ON com.tblOrganizationalPostsEjraee.fldChartOrganId =	com.tblChartOrganEjraee.fldid
					    OUTER APPLY (SELECT top(1) t.fldMadrakId,t.fldReshteId,tblMadrakTahsili.fldTitle as fldMadrakTahsiliTitle,tblReshteTahsili.fldtitle as fldReshteTahsiliTitle
										from com.tblHistoryTahsilat as t inner join 
									    Com.tblMadrakTahsili ON t.fldMadrakId = Com.tblMadrakTahsili.fldId INNER JOIN
									    Com.tblReshteTahsili ON t.fldReshteId = Com.tblReshteTahsili.fldId 
									   where t.fldEmployeeId=tblEmployee.fldid order by T.fldTarikh DESC)t

                  	WHERE  t.fldMadrakId = @Value  AND com.fn_organId(Prs_tblPersonalInfo.fldid) =@OrganId
                       	        ORDER BY Prs_tblPersonalInfo.fldId desc

	if (@fieldname=N'fldNezamVazifeId')
SELECT    top(@h) Prs.Prs_tblPersonalInfo.fldId, Prs.Prs_tblPersonalInfo.fldEmployeeId, Com.tblEmployee_Detail.fldSh_Shenasname, 
                      Com.tblEmployee_Detail.fldTarikhTavalod, Com.tblEmployee_Detail.fldMahalTavalodId, Com.tblEmployee_Detail.fldMahalSodoorId, 
                      ISNULL(Com.tblEmployee_Detail.fldAddress,'')AS fldAddress, ISNULL(Com.tblEmployee_Detail.fldCodePosti,'') AS fldCodePosti, Prs.Prs_tblPersonalInfo.fldEsargariId, Prs.Prs_tblPersonalInfo.fldSharhEsargari, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali, t.fldMadrakId, t.fldReshteId, Com.tblEmployee_Detail.fldNezamVazifeId, 
                      Prs.Prs_tblPersonalInfo.fldOrganPostId, Prs.Prs_tblPersonalInfo.fldRasteShoghli, Prs.Prs_tblPersonalInfo.fldReshteShoghli, 
                      Prs.Prs_tblPersonalInfo.fldTarikhEstekhdam, tblOrganizationalPosts.fldChartOrganId, Prs.Prs_tblPersonalInfo.fldTabaghe, Com.tblEmployee_Detail.fldMeliyat, 
                      Prs.Prs_tblPersonalInfo.fldSh_MojavezEstekhdam, Prs.Prs_tblPersonalInfo.fldTarikhMajavezEstekhdam, Prs.Prs_tblPersonalInfo.fldUserId, 
                      Prs.Prs_tblPersonalInfo.fldDesc, Prs.Prs_tblPersonalInfo.fldDate, CASE WHEN fldMeliyat = 0 THEN N'غیر ایرانی' ELSE N'ایرانی' END AS fldMeliyatName, 
                      t.fldMadrakTahsiliTitle, Prs.tblVaziyatEsargari.fldTitle AS fldVaziyatEsargariTitle, ISNULL(Com.tblNezamVazife.fldTitle ,'') AS fldNezamVazifeTitle, 
                      Com.tblEmployee.fldName + '_' + Com.tblEmployee.fldFamily AS fldNameEmployee, Com.tblEmployee.fldName, Com.tblEmployee.fldFamily, 
                      Com.tblEmployee_Detail.fldFatherName, Com.tblEmployee_Detail.fldJensiyat, tblChartOrgan.fldTitle AS fldTitleChartOrgan, 
                      (SELECT Com.fn_stringDecode(tblOrganization.fldName) FROM Com.tblOrganization WHERE fldid = [Com].[fn_OrganName] (fldOrganPostId)) AS fldNameOrgan, Com.tblCity.fldName AS fldNameMahalTavalod, tblCity_1.fldName AS fldNameMahlSodoor, 
                      Com.tblEmployee.fldCodemeli, Com.tblEmployee_Detail.fldFileId, CASE WHEN fldJensiyat = 0 THEN N'زن' ELSE N'مرد' END AS fldNameJensiyat, 
                      tblOrganizationalPosts.fldTitle+'_'+tblOrganizationalPosts.fldOrgPostCode AS NamePostOran, t.fldReshteTahsiliTitle, 
                      Com.tblEmployee.fldFamily + '_' + Com.tblEmployee.fldName + '(' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName_FamilyEmployee, Com.tblEmployee_Detail.fldTel, Com.tblEmployee_Detail.fldMobile,
                      ISNULL(tblChartOrgan.fldOrganId, 0) AS fldOrganId, ISNULL
                          ((SELECT     TOP (1) fldId
                              FROM         Com.tblPersonalStatus
                              WHERE     (fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                              ORDER BY fldId DESC), 0) AS fldIdStatus, ISNULL
                          ((SELECT     TOP (1) fldNoeEstekhdamId
                              FROM         Prs.tblHistoryNoeEstekhdam
                              WHERE     (fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                              ORDER BY fldId DESC), 0) AS fldNoeEstekhdam,
                          (SELECT     TOP (1) Com.tblStatus.fldTitle
                            FROM          Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                                   Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                            WHERE      (tblPersonalStatus_1.fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                            ORDER BY tblPersonalStatus_1.fldId DESC) AS fldTitleStatus,fldTarikhSodoor,fldTaaholId,
                            ISNULL((SELECT     TOP (1)  Com.tblAnvaEstekhdam.fldTitle
FROM         Prs.tblHistoryNoeEstekhdam INNER JOIN
                      Com.tblAnvaEstekhdam ON Prs.tblHistoryNoeEstekhdam.fldNoeEstekhdamId = Com.tblAnvaEstekhdam.fldId
                              WHERE     (fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                              ORDER BY tblHistoryNoeEstekhdam.fldId DESC), '')AS TitleNoeEstekhdam,fldOrganPostEjraeeId
							  ,tblOrganizationalPostsEjraee.fldTitle+'_'+tblOrganizationalPostsEjraee.fldOrgPostCode AS TitleOrganPostEjraee,
							  Com.tblChartOrganEjraee.fldTitle AS TitleChartOrganEjraee

FROM         Prs.Prs_tblPersonalInfo INNER JOIN
                      Com.tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = Com.tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON Com.tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
                      Com.tblStatusTaahol ON Com.tblEmployee_Detail.fldTaaholId = Com.tblStatusTaahol.fldId INNER JOIN
                      Com.tblCity ON Com.tblEmployee_Detail.fldMahalTavalodId = Com.tblCity.fldId INNER JOIN
                      Com.tblCity AS tblCity_1 ON Com.tblEmployee_Detail.fldMahalSodoorId = tblCity_1.fldId INNER JOIN
                      Prs.tblVaziyatEsargari ON Prs.Prs_tblPersonalInfo.fldEsargariId = Prs.tblVaziyatEsargari.fldId INNER JOIN
                      Com.tblOrganizationalPosts ON Prs.Prs_tblPersonalInfo.fldOrganPostId = Com.tblOrganizationalPosts.fldId INNER JOIN
                      Com.tblChartOrgan ON Com.tblOrganizationalPosts.fldChartOrganId = Com.tblChartOrgan.fldId LEFT OUTER JOIN
						Com.tblNezamVazife ON Com.tblEmployee_Detail.fldNezamVazifeId = Com.tblNezamVazife.fldId   LEFT outer JOIN
					  com.tblOrganizationalPostsEjraee ON Prs.Prs_tblPersonalInfo.fldOrganPostEjraeeId=com.tblOrganizationalPostsEjraee.fldId LEFT outer JOIN
					  com.tblChartOrganEjraee ON com.tblOrganizationalPostsEjraee.fldChartOrganId =	com.tblChartOrganEjraee.fldid
					    OUTER APPLY (SELECT top(1) t.fldMadrakId,t.fldReshteId,tblMadrakTahsili.fldTitle as fldMadrakTahsiliTitle,tblReshteTahsili.fldtitle as fldReshteTahsiliTitle
										from com.tblHistoryTahsilat as t inner join 
									    Com.tblMadrakTahsili ON t.fldMadrakId = Com.tblMadrakTahsili.fldId INNER JOIN
									    Com.tblReshteTahsili ON t.fldReshteId = Com.tblReshteTahsili.fldId 
									   where t.fldEmployeeId=tblEmployee.fldid order by T.fldTarikh DESC)t
                      	WHERE  fldNezamVazifeId = @Value  AND com.fn_organId(Prs_tblPersonalInfo.fldid) =@OrganId
                       	        ORDER BY Prs_tblPersonalInfo.fldId desc

	if (@fieldname=N'fldChartOrganId')
SELECT    top(@h) Prs.Prs_tblPersonalInfo.fldId, Prs.Prs_tblPersonalInfo.fldEmployeeId, Com.tblEmployee_Detail.fldSh_Shenasname, 
                      Com.tblEmployee_Detail.fldTarikhTavalod, Com.tblEmployee_Detail.fldMahalTavalodId, Com.tblEmployee_Detail.fldMahalSodoorId, 
                      ISNULL(Com.tblEmployee_Detail.fldAddress,'')AS fldAddress, ISNULL(Com.tblEmployee_Detail.fldCodePosti,'') AS fldCodePosti, Prs.Prs_tblPersonalInfo.fldEsargariId, Prs.Prs_tblPersonalInfo.fldSharhEsargari, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali, t.fldMadrakId, t.fldReshteId, Com.tblEmployee_Detail.fldNezamVazifeId, 
                      Prs.Prs_tblPersonalInfo.fldOrganPostId, Prs.Prs_tblPersonalInfo.fldRasteShoghli, Prs.Prs_tblPersonalInfo.fldReshteShoghli, 
                      Prs.Prs_tblPersonalInfo.fldTarikhEstekhdam, tblOrganizationalPosts.fldChartOrganId, Prs.Prs_tblPersonalInfo.fldTabaghe, Com.tblEmployee_Detail.fldMeliyat, 
                      Prs.Prs_tblPersonalInfo.fldSh_MojavezEstekhdam, Prs.Prs_tblPersonalInfo.fldTarikhMajavezEstekhdam, Prs.Prs_tblPersonalInfo.fldUserId, 
                      Prs.Prs_tblPersonalInfo.fldDesc, Prs.Prs_tblPersonalInfo.fldDate, CASE WHEN fldMeliyat = 0 THEN N'غیر ایرانی' ELSE N'ایرانی' END AS fldMeliyatName, 
                      t.fldMadrakTahsiliTitle, Prs.tblVaziyatEsargari.fldTitle AS fldVaziyatEsargariTitle, ISNULL(Com.tblNezamVazife.fldTitle ,'') AS fldNezamVazifeTitle, 
                      Com.tblEmployee.fldName + '_' + Com.tblEmployee.fldFamily AS fldNameEmployee, Com.tblEmployee.fldName, Com.tblEmployee.fldFamily, 
                      Com.tblEmployee_Detail.fldFatherName, Com.tblEmployee_Detail.fldJensiyat, tblChartOrgan.fldTitle AS fldTitleChartOrgan, 
                      (SELECT Com.fn_stringDecode(tblOrganization.fldName) FROM Com.tblOrganization WHERE fldid = [Com].[fn_OrganName] (fldOrganPostId)) AS fldNameOrgan, Com.tblCity.fldName AS fldNameMahalTavalod, tblCity_1.fldName AS fldNameMahlSodoor, 
                      Com.tblEmployee.fldCodemeli, Com.tblEmployee_Detail.fldFileId, CASE WHEN fldJensiyat = 0 THEN N'زن' ELSE N'مرد' END AS fldNameJensiyat, 
                      tblOrganizationalPosts.fldTitle+'_'+tblOrganizationalPosts.fldOrgPostCode AS NamePostOran, t.fldReshteTahsiliTitle, 
                      Com.tblEmployee.fldFamily + '_' + Com.tblEmployee.fldName + '(' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName_FamilyEmployee, Com.tblEmployee_Detail.fldTel, Com.tblEmployee_Detail.fldMobile,
                      ISNULL(tblChartOrgan.fldOrganId, 0) AS fldOrganId, ISNULL
                          ((SELECT     TOP (1) fldId
                              FROM         Com.tblPersonalStatus
                              WHERE     (fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                              ORDER BY fldId DESC), 0) AS fldIdStatus, ISNULL
                          ((SELECT     TOP (1) fldNoeEstekhdamId
                              FROM         Prs.tblHistoryNoeEstekhdam
                              WHERE     (fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                              ORDER BY fldId DESC), 0) AS fldNoeEstekhdam,
                          (SELECT     TOP (1) Com.tblStatus.fldTitle
                            FROM          Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                                   Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                            WHERE      (tblPersonalStatus_1.fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                            ORDER BY tblPersonalStatus_1.fldId DESC) AS fldTitleStatus,fldTarikhSodoor,fldTaaholId,
                            ISNULL((SELECT     TOP (1)  Com.tblAnvaEstekhdam.fldTitle
FROM         Prs.tblHistoryNoeEstekhdam INNER JOIN
                      Com.tblAnvaEstekhdam ON Prs.tblHistoryNoeEstekhdam.fldNoeEstekhdamId = Com.tblAnvaEstekhdam.fldId
                              WHERE     (fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                              ORDER BY tblHistoryNoeEstekhdam.fldId DESC), '')AS TitleNoeEstekhdam,fldOrganPostEjraeeId
							  ,tblOrganizationalPostsEjraee.fldTitle+'_'+tblOrganizationalPostsEjraee.fldOrgPostCode AS TitleOrganPostEjraee,
							  Com.tblChartOrganEjraee.fldTitle AS TitleChartOrganEjraee

FROM         Prs.Prs_tblPersonalInfo INNER JOIN
                      Com.tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = Com.tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON Com.tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
                      Com.tblStatusTaahol ON Com.tblEmployee_Detail.fldTaaholId = Com.tblStatusTaahol.fldId INNER JOIN
                      Com.tblCity ON Com.tblEmployee_Detail.fldMahalTavalodId = Com.tblCity.fldId INNER JOIN
                      Com.tblCity AS tblCity_1 ON Com.tblEmployee_Detail.fldMahalSodoorId = tblCity_1.fldId INNER JOIN
                      Prs.tblVaziyatEsargari ON Prs.Prs_tblPersonalInfo.fldEsargariId = Prs.tblVaziyatEsargari.fldId INNER JOIN
                      Com.tblOrganizationalPosts ON Prs.Prs_tblPersonalInfo.fldOrganPostId = Com.tblOrganizationalPosts.fldId INNER JOIN
                      Com.tblChartOrgan ON Com.tblOrganizationalPosts.fldChartOrganId = Com.tblChartOrgan.fldId LEFT OUTER JOIN
						Com.tblNezamVazife ON Com.tblEmployee_Detail.fldNezamVazifeId = Com.tblNezamVazife.fldId   LEFT outer JOIN
					  com.tblOrganizationalPostsEjraee ON Prs.Prs_tblPersonalInfo.fldOrganPostEjraeeId=com.tblOrganizationalPostsEjraee.fldId LEFT outer JOIN
					  com.tblChartOrganEjraee ON com.tblOrganizationalPostsEjraee.fldChartOrganId =	com.tblChartOrganEjraee.fldid
					    OUTER APPLY (SELECT top(1) t.fldMadrakId,t.fldReshteId,tblMadrakTahsili.fldTitle as fldMadrakTahsiliTitle,tblReshteTahsili.fldtitle as fldReshteTahsiliTitle
										from com.tblHistoryTahsilat as t inner join 
									    Com.tblMadrakTahsili ON t.fldMadrakId = Com.tblMadrakTahsili.fldId INNER JOIN
									    Com.tblReshteTahsili ON t.fldReshteId = Com.tblReshteTahsili.fldId 
									   where t.fldEmployeeId=tblEmployee.fldid order by T.fldTarikh DESC)t

                       	WHERE  com.tblChartOrgan.fldid = @Value  AND  com.fn_organId(Prs_tblPersonalInfo.fldid) =@OrganId
                       	        ORDER BY Prs_tblPersonalInfo.fldId desc

		if (@fieldname=N'fldOrganPostId')
SELECT    top(@h) Prs.Prs_tblPersonalInfo.fldId, Prs.Prs_tblPersonalInfo.fldEmployeeId, Com.tblEmployee_Detail.fldSh_Shenasname, 
                      Com.tblEmployee_Detail.fldTarikhTavalod, Com.tblEmployee_Detail.fldMahalTavalodId, Com.tblEmployee_Detail.fldMahalSodoorId, 
                      ISNULL(Com.tblEmployee_Detail.fldAddress,'')AS fldAddress, ISNULL(Com.tblEmployee_Detail.fldCodePosti,'') AS fldCodePosti, Prs.Prs_tblPersonalInfo.fldEsargariId, Prs.Prs_tblPersonalInfo.fldSharhEsargari, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali, t.fldMadrakId, t.fldReshteId, Com.tblEmployee_Detail.fldNezamVazifeId, 
                      Prs.Prs_tblPersonalInfo.fldOrganPostId, Prs.Prs_tblPersonalInfo.fldRasteShoghli, Prs.Prs_tblPersonalInfo.fldReshteShoghli, 
                      Prs.Prs_tblPersonalInfo.fldTarikhEstekhdam, tblOrganizationalPosts.fldChartOrganId, Prs.Prs_tblPersonalInfo.fldTabaghe, Com.tblEmployee_Detail.fldMeliyat, 
                      Prs.Prs_tblPersonalInfo.fldSh_MojavezEstekhdam, Prs.Prs_tblPersonalInfo.fldTarikhMajavezEstekhdam, Prs.Prs_tblPersonalInfo.fldUserId, 
                      Prs.Prs_tblPersonalInfo.fldDesc, Prs.Prs_tblPersonalInfo.fldDate, CASE WHEN fldMeliyat = 0 THEN N'غیر ایرانی' ELSE N'ایرانی' END AS fldMeliyatName, 
                      t.fldMadrakTahsiliTitle, Prs.tblVaziyatEsargari.fldTitle AS fldVaziyatEsargariTitle, ISNULL(Com.tblNezamVazife.fldTitle ,'') AS fldNezamVazifeTitle, 
                      Com.tblEmployee.fldName + '_' + Com.tblEmployee.fldFamily AS fldNameEmployee, Com.tblEmployee.fldName, Com.tblEmployee.fldFamily, 
                      Com.tblEmployee_Detail.fldFatherName, Com.tblEmployee_Detail.fldJensiyat, tblChartOrgan.fldTitle AS fldTitleChartOrgan, 
                      (SELECT Com.fn_stringDecode(tblOrganization.fldName) FROM Com.tblOrganization WHERE fldid = [Com].[fn_OrganName] (fldOrganPostId)) AS fldNameOrgan, Com.tblCity.fldName AS fldNameMahalTavalod, tblCity_1.fldName AS fldNameMahlSodoor, 
                      Com.tblEmployee.fldCodemeli, Com.tblEmployee_Detail.fldFileId, CASE WHEN fldJensiyat = 0 THEN N'زن' ELSE N'مرد' END AS fldNameJensiyat, 
                      tblOrganizationalPosts.fldTitle+'_'+tblOrganizationalPosts.fldOrgPostCode AS NamePostOran, t.fldReshteTahsiliTitle, 
                      Com.tblEmployee.fldFamily + '_' + Com.tblEmployee.fldName + '(' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName_FamilyEmployee,Com.tblEmployee_Detail.fldTel, Com.tblEmployee_Detail.fldMobile, 
                      ISNULL(tblChartOrgan.fldOrganId, 0) AS fldOrganId, ISNULL
                          ((SELECT     TOP (1) fldId
                              FROM         Com.tblPersonalStatus
                              WHERE     (fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                              ORDER BY fldId DESC), 0) AS fldIdStatus, ISNULL
                          ((SELECT     TOP (1) fldNoeEstekhdamId
                              FROM         Prs.tblHistoryNoeEstekhdam
                              WHERE     (fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                              ORDER BY fldId DESC), 0) AS fldNoeEstekhdam,
                          (SELECT     TOP (1) Com.tblStatus.fldTitle
                            FROM          Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                                   Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                            WHERE      (tblPersonalStatus_1.fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                            ORDER BY tblPersonalStatus_1.fldId DESC) AS fldTitleStatus,fldTarikhSodoor,fldTaaholId,
                            ISNULL((SELECT     TOP (1)  Com.tblAnvaEstekhdam.fldTitle
FROM         Prs.tblHistoryNoeEstekhdam INNER JOIN
                      Com.tblAnvaEstekhdam ON Prs.tblHistoryNoeEstekhdam.fldNoeEstekhdamId = Com.tblAnvaEstekhdam.fldId
                              WHERE     (fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                              ORDER BY tblHistoryNoeEstekhdam.fldId DESC), '')AS TitleNoeEstekhdam,fldOrganPostEjraeeId
							  ,tblOrganizationalPostsEjraee.fldTitle+'_'+tblOrganizationalPostsEjraee.fldOrgPostCode AS TitleOrganPostEjraee,
							  Com.tblChartOrganEjraee.fldTitle AS TitleChartOrganEjraee

FROM         Prs.Prs_tblPersonalInfo INNER JOIN
                      Com.tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = Com.tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON Com.tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
                      Com.tblStatusTaahol ON Com.tblEmployee_Detail.fldTaaholId = Com.tblStatusTaahol.fldId INNER JOIN
                      Com.tblCity ON Com.tblEmployee_Detail.fldMahalTavalodId = Com.tblCity.fldId INNER JOIN
                      Com.tblCity AS tblCity_1 ON Com.tblEmployee_Detail.fldMahalSodoorId = tblCity_1.fldId INNER JOIN
                      Prs.tblVaziyatEsargari ON Prs.Prs_tblPersonalInfo.fldEsargariId = Prs.tblVaziyatEsargari.fldId INNER JOIN
                      Com.tblOrganizationalPosts ON Prs.Prs_tblPersonalInfo.fldOrganPostId = Com.tblOrganizationalPosts.fldId INNER JOIN
                      Com.tblChartOrgan ON Com.tblOrganizationalPosts.fldChartOrganId = Com.tblChartOrgan.fldId LEFT OUTER JOIN
						Com.tblNezamVazife ON Com.tblEmployee_Detail.fldNezamVazifeId = Com.tblNezamVazife.fldId   LEFT outer JOIN
					  com.tblOrganizationalPostsEjraee ON Prs.Prs_tblPersonalInfo.fldOrganPostEjraeeId=com.tblOrganizationalPostsEjraee.fldId LEFT outer JOIN
					  com.tblChartOrganEjraee ON com.tblOrganizationalPostsEjraee.fldChartOrganId =	com.tblChartOrganEjraee.fldid
					    OUTER APPLY (SELECT top(1) t.fldMadrakId,t.fldReshteId,tblMadrakTahsili.fldTitle as fldMadrakTahsiliTitle,tblReshteTahsili.fldtitle as fldReshteTahsiliTitle
										from com.tblHistoryTahsilat as t inner join 
									    Com.tblMadrakTahsili ON t.fldMadrakId = Com.tblMadrakTahsili.fldId INNER JOIN
									    Com.tblReshteTahsili ON t.fldReshteId = Com.tblReshteTahsili.fldId 
									   where t.fldEmployeeId=tblEmployee.fldid order by T.fldTarikh DESC)t

                      	WHERE  Prs_tblPersonalInfo.fldOrganPostId = @Value  AND  com.fn_organId(Prs_tblPersonalInfo.fldid) =@OrganId
                       	        ORDER BY Prs_tblPersonalInfo.fldId desc

			if (@fieldname=N'fldOrganPostEjraeeId')
SELECT    top(@h) Prs.Prs_tblPersonalInfo.fldId, Prs.Prs_tblPersonalInfo.fldEmployeeId, Com.tblEmployee_Detail.fldSh_Shenasname, 
                      Com.tblEmployee_Detail.fldTarikhTavalod, Com.tblEmployee_Detail.fldMahalTavalodId, Com.tblEmployee_Detail.fldMahalSodoorId, 
                      ISNULL(Com.tblEmployee_Detail.fldAddress,'')AS fldAddress, ISNULL(Com.tblEmployee_Detail.fldCodePosti,'') AS fldCodePosti, Prs.Prs_tblPersonalInfo.fldEsargariId, Prs.Prs_tblPersonalInfo.fldSharhEsargari, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali, t.fldMadrakId, t.fldReshteId, Com.tblEmployee_Detail.fldNezamVazifeId, 
                      Prs.Prs_tblPersonalInfo.fldOrganPostId, Prs.Prs_tblPersonalInfo.fldRasteShoghli, Prs.Prs_tblPersonalInfo.fldReshteShoghli, 
                      Prs.Prs_tblPersonalInfo.fldTarikhEstekhdam, tblOrganizationalPosts.fldChartOrganId, Prs.Prs_tblPersonalInfo.fldTabaghe, Com.tblEmployee_Detail.fldMeliyat, 
                      Prs.Prs_tblPersonalInfo.fldSh_MojavezEstekhdam, Prs.Prs_tblPersonalInfo.fldTarikhMajavezEstekhdam, Prs.Prs_tblPersonalInfo.fldUserId, 
                      Prs.Prs_tblPersonalInfo.fldDesc, Prs.Prs_tblPersonalInfo.fldDate, CASE WHEN fldMeliyat = 0 THEN N'غیر ایرانی' ELSE N'ایرانی' END AS fldMeliyatName, 
                      t.fldMadrakTahsiliTitle, Prs.tblVaziyatEsargari.fldTitle AS fldVaziyatEsargariTitle, ISNULL(Com.tblNezamVazife.fldTitle ,'') AS fldNezamVazifeTitle, 
                      Com.tblEmployee.fldName + '_' + Com.tblEmployee.fldFamily AS fldNameEmployee, Com.tblEmployee.fldName, Com.tblEmployee.fldFamily, 
                      Com.tblEmployee_Detail.fldFatherName, Com.tblEmployee_Detail.fldJensiyat, tblChartOrgan.fldTitle AS fldTitleChartOrgan, 
                      (SELECT Com.fn_stringDecode(tblOrganization.fldName) FROM Com.tblOrganization WHERE fldid = [Com].[fn_OrganName] (fldOrganPostId)) AS fldNameOrgan, Com.tblCity.fldName AS fldNameMahalTavalod, tblCity_1.fldName AS fldNameMahlSodoor, 
                      Com.tblEmployee.fldCodemeli, Com.tblEmployee_Detail.fldFileId, CASE WHEN fldJensiyat = 0 THEN N'زن' ELSE N'مرد' END AS fldNameJensiyat, 
                      tblOrganizationalPosts.fldTitle+'_'+tblOrganizationalPosts.fldOrgPostCode AS NamePostOran, t.fldReshteTahsiliTitle, 
                      Com.tblEmployee.fldFamily + '_' + Com.tblEmployee.fldName + '(' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName_FamilyEmployee, Com.tblEmployee_Detail.fldTel, Com.tblEmployee_Detail.fldMobile,
                      ISNULL(tblChartOrgan.fldOrganId, 0) AS fldOrganId, ISNULL
                          ((SELECT     TOP (1) fldId
                              FROM         Com.tblPersonalStatus
                              WHERE     (fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                              ORDER BY fldId DESC), 0) AS fldIdStatus, ISNULL
                          ((SELECT     TOP (1) fldNoeEstekhdamId
                              FROM         Prs.tblHistoryNoeEstekhdam
                              WHERE     (fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                              ORDER BY fldId DESC), 0) AS fldNoeEstekhdam,
                          (SELECT     TOP (1) Com.tblStatus.fldTitle
                            FROM          Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                                   Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                            WHERE      (tblPersonalStatus_1.fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                            ORDER BY tblPersonalStatus_1.fldId DESC) AS fldTitleStatus,fldTarikhSodoor,fldTaaholId,
                            ISNULL((SELECT     TOP (1)  Com.tblAnvaEstekhdam.fldTitle
FROM         Prs.tblHistoryNoeEstekhdam INNER JOIN
                      Com.tblAnvaEstekhdam ON Prs.tblHistoryNoeEstekhdam.fldNoeEstekhdamId = Com.tblAnvaEstekhdam.fldId
                              WHERE     (fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                              ORDER BY tblHistoryNoeEstekhdam.fldId DESC), '')AS TitleNoeEstekhdam,fldOrganPostEjraeeId
							  ,tblOrganizationalPostsEjraee.fldTitle+'_'+tblOrganizationalPostsEjraee.fldOrgPostCode AS TitleOrganPostEjraee,
							  Com.tblChartOrganEjraee.fldTitle AS TitleChartOrganEjraee

FROM         Prs.Prs_tblPersonalInfo INNER JOIN
                      Com.tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = Com.tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON Com.tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
                      Com.tblStatusTaahol ON Com.tblEmployee_Detail.fldTaaholId = Com.tblStatusTaahol.fldId INNER JOIN
                      Com.tblCity ON Com.tblEmployee_Detail.fldMahalTavalodId = Com.tblCity.fldId INNER JOIN
                      Com.tblCity AS tblCity_1 ON Com.tblEmployee_Detail.fldMahalSodoorId = tblCity_1.fldId INNER JOIN
                      Prs.tblVaziyatEsargari ON Prs.Prs_tblPersonalInfo.fldEsargariId = Prs.tblVaziyatEsargari.fldId INNER JOIN
                      Com.tblOrganizationalPosts ON Prs.Prs_tblPersonalInfo.fldOrganPostId = Com.tblOrganizationalPosts.fldId INNER JOIN
                      Com.tblChartOrgan ON Com.tblOrganizationalPosts.fldChartOrganId = Com.tblChartOrgan.fldId LEFT OUTER JOIN
						Com.tblNezamVazife ON Com.tblEmployee_Detail.fldNezamVazifeId = Com.tblNezamVazife.fldId   LEFT outer JOIN
					  com.tblOrganizationalPostsEjraee ON Prs.Prs_tblPersonalInfo.fldOrganPostEjraeeId=com.tblOrganizationalPostsEjraee.fldId LEFT outer JOIN
					  com.tblChartOrganEjraee ON com.tblOrganizationalPostsEjraee.fldChartOrganId =	com.tblChartOrganEjraee.fldid
					    OUTER APPLY (SELECT top(1) t.fldMadrakId,t.fldReshteId,tblMadrakTahsili.fldTitle as fldMadrakTahsiliTitle,tblReshteTahsili.fldtitle as fldReshteTahsiliTitle
										from com.tblHistoryTahsilat as t inner join 
									    Com.tblMadrakTahsili ON t.fldMadrakId = Com.tblMadrakTahsili.fldId INNER JOIN
									    Com.tblReshteTahsili ON t.fldReshteId = Com.tblReshteTahsili.fldId 
									   where t.fldEmployeeId=tblEmployee.fldid order by T.fldTarikh DESC)t

                      	WHERE  Prs_tblPersonalInfo.fldOrganPostEjraeeId = @Value  AND  com.fn_organId(Prs_tblPersonalInfo.fldid) =@OrganId
                       	        ORDER BY Prs_tblPersonalInfo.fldId desc

		if (@fieldname=N'fldCodemeli')
SELECT    top(@h) Prs.Prs_tblPersonalInfo.fldId, Prs.Prs_tblPersonalInfo.fldEmployeeId, Com.tblEmployee_Detail.fldSh_Shenasname, 
                      Com.tblEmployee_Detail.fldTarikhTavalod, Com.tblEmployee_Detail.fldMahalTavalodId, Com.tblEmployee_Detail.fldMahalSodoorId, 
                      ISNULL(Com.tblEmployee_Detail.fldAddress,'')AS fldAddress, ISNULL(Com.tblEmployee_Detail.fldCodePosti,'') AS fldCodePosti, Prs.Prs_tblPersonalInfo.fldEsargariId, Prs.Prs_tblPersonalInfo.fldSharhEsargari, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali, t.fldMadrakId, t.fldReshteId, Com.tblEmployee_Detail.fldNezamVazifeId, 
                      Prs.Prs_tblPersonalInfo.fldOrganPostId, Prs.Prs_tblPersonalInfo.fldRasteShoghli, Prs.Prs_tblPersonalInfo.fldReshteShoghli, 
                      Prs.Prs_tblPersonalInfo.fldTarikhEstekhdam, tblOrganizationalPosts.fldChartOrganId, Prs.Prs_tblPersonalInfo.fldTabaghe, Com.tblEmployee_Detail.fldMeliyat, 
                      Prs.Prs_tblPersonalInfo.fldSh_MojavezEstekhdam, Prs.Prs_tblPersonalInfo.fldTarikhMajavezEstekhdam, Prs.Prs_tblPersonalInfo.fldUserId, 
                      Prs.Prs_tblPersonalInfo.fldDesc, Prs.Prs_tblPersonalInfo.fldDate, CASE WHEN fldMeliyat = 0 THEN N'غیر ایرانی' ELSE N'ایرانی' END AS fldMeliyatName, 
                      t.fldMadrakTahsiliTitle, Prs.tblVaziyatEsargari.fldTitle AS fldVaziyatEsargariTitle, ISNULL(Com.tblNezamVazife.fldTitle ,'') AS fldNezamVazifeTitle, 
                      Com.tblEmployee.fldName + '_' + Com.tblEmployee.fldFamily AS fldNameEmployee, Com.tblEmployee.fldName, Com.tblEmployee.fldFamily, 
                      Com.tblEmployee_Detail.fldFatherName, Com.tblEmployee_Detail.fldJensiyat, tblChartOrgan.fldTitle AS fldTitleChartOrgan, 
                      (SELECT Com.fn_stringDecode(tblOrganization.fldName) FROM Com.tblOrganization WHERE fldid = [Com].[fn_OrganName] (fldOrganPostId)) AS fldNameOrgan, Com.tblCity.fldName AS fldNameMahalTavalod, tblCity_1.fldName AS fldNameMahlSodoor, 
                      Com.tblEmployee.fldCodemeli, Com.tblEmployee_Detail.fldFileId, CASE WHEN fldJensiyat = 0 THEN N'زن' ELSE N'مرد' END AS fldNameJensiyat, 
                      tblOrganizationalPosts.fldTitle+'_'+tblOrganizationalPosts.fldOrgPostCode AS NamePostOran, t.fldReshteTahsiliTitle, 
                      Com.tblEmployee.fldFamily + '_' + Com.tblEmployee.fldName + '(' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName_FamilyEmployee, Com.tblEmployee_Detail.fldTel, Com.tblEmployee_Detail.fldMobile,
                      ISNULL(tblChartOrgan.fldOrganId, 0) AS fldOrganId, ISNULL
                          ((SELECT     TOP (1) fldId
                              FROM         Com.tblPersonalStatus
                              WHERE     (fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                              ORDER BY fldId DESC), 0) AS fldIdStatus, ISNULL
                          ((SELECT     TOP (1) fldNoeEstekhdamId
                              FROM         Prs.tblHistoryNoeEstekhdam
                              WHERE     (fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                              ORDER BY fldId DESC), 0) AS fldNoeEstekhdam,
                          (SELECT     TOP (1) Com.tblStatus.fldTitle
                            FROM          Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                                   Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                            WHERE      (tblPersonalStatus_1.fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                            ORDER BY tblPersonalStatus_1.fldId DESC) AS fldTitleStatus,fldTarikhSodoor,fldTaaholId,
                            ISNULL((SELECT     TOP (1)  Com.tblAnvaEstekhdam.fldTitle
FROM         Prs.tblHistoryNoeEstekhdam INNER JOIN
                      Com.tblAnvaEstekhdam ON Prs.tblHistoryNoeEstekhdam.fldNoeEstekhdamId = Com.tblAnvaEstekhdam.fldId
                              WHERE     (fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                              ORDER BY tblHistoryNoeEstekhdam.fldId DESC), '')AS TitleNoeEstekhdam,fldOrganPostEjraeeId
							  ,tblOrganizationalPostsEjraee.fldTitle+'_'+tblOrganizationalPostsEjraee.fldOrgPostCode AS TitleOrganPostEjraee,
							  Com.tblChartOrganEjraee.fldTitle AS TitleChartOrganEjraee

FROM         Prs.Prs_tblPersonalInfo INNER JOIN
                      Com.tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = Com.tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON Com.tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
                      Com.tblStatusTaahol ON Com.tblEmployee_Detail.fldTaaholId = Com.tblStatusTaahol.fldId INNER JOIN
                      Com.tblCity ON Com.tblEmployee_Detail.fldMahalTavalodId = Com.tblCity.fldId INNER JOIN
                      Com.tblCity AS tblCity_1 ON Com.tblEmployee_Detail.fldMahalSodoorId = tblCity_1.fldId INNER JOIN
                      Prs.tblVaziyatEsargari ON Prs.Prs_tblPersonalInfo.fldEsargariId = Prs.tblVaziyatEsargari.fldId INNER JOIN
                      Com.tblOrganizationalPosts ON Prs.Prs_tblPersonalInfo.fldOrganPostId = Com.tblOrganizationalPosts.fldId INNER JOIN
                      Com.tblChartOrgan ON Com.tblOrganizationalPosts.fldChartOrganId = Com.tblChartOrgan.fldId LEFT OUTER JOIN
						Com.tblNezamVazife ON Com.tblEmployee_Detail.fldNezamVazifeId = Com.tblNezamVazife.fldId   LEFT outer JOIN
					  com.tblOrganizationalPostsEjraee ON Prs.Prs_tblPersonalInfo.fldOrganPostEjraeeId=com.tblOrganizationalPostsEjraee.fldId LEFT outer JOIN
					  com.tblChartOrganEjraee ON com.tblOrganizationalPostsEjraee.fldChartOrganId =	com.tblChartOrganEjraee.fldid
					    OUTER APPLY (SELECT top(1) t.fldMadrakId,t.fldReshteId,tblMadrakTahsili.fldTitle as fldMadrakTahsiliTitle,tblReshteTahsili.fldtitle as fldReshteTahsiliTitle
										from com.tblHistoryTahsilat as t inner join 
									    Com.tblMadrakTahsili ON t.fldMadrakId = Com.tblMadrakTahsili.fldId INNER JOIN
									    Com.tblReshteTahsili ON t.fldReshteId = Com.tblReshteTahsili.fldId 
									   where t.fldEmployeeId=tblEmployee.fldid order by T.fldTarikh DESC)t
                             WHERE fldCodemeli like @Value 
                              ORDER BY Prs_tblPersonalInfo.fldId DESC


    if (@fieldname=N'fldSh_Shenasname')
SELECT    top(@h) Prs.Prs_tblPersonalInfo.fldId, Prs.Prs_tblPersonalInfo.fldEmployeeId, Com.tblEmployee_Detail.fldSh_Shenasname, 
                      Com.tblEmployee_Detail.fldTarikhTavalod, Com.tblEmployee_Detail.fldMahalTavalodId, Com.tblEmployee_Detail.fldMahalSodoorId, 
                      ISNULL(Com.tblEmployee_Detail.fldAddress,'')AS fldAddress, ISNULL(Com.tblEmployee_Detail.fldCodePosti,'') AS fldCodePosti, Prs.Prs_tblPersonalInfo.fldEsargariId, Prs.Prs_tblPersonalInfo.fldSharhEsargari, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali, t.fldMadrakId, t.fldReshteId, Com.tblEmployee_Detail.fldNezamVazifeId, 
                      Prs.Prs_tblPersonalInfo.fldOrganPostId, Prs.Prs_tblPersonalInfo.fldRasteShoghli, Prs.Prs_tblPersonalInfo.fldReshteShoghli, 
                      Prs.Prs_tblPersonalInfo.fldTarikhEstekhdam, tblOrganizationalPosts.fldChartOrganId, Prs.Prs_tblPersonalInfo.fldTabaghe, Com.tblEmployee_Detail.fldMeliyat, 
                      Prs.Prs_tblPersonalInfo.fldSh_MojavezEstekhdam, Prs.Prs_tblPersonalInfo.fldTarikhMajavezEstekhdam, Prs.Prs_tblPersonalInfo.fldUserId, 
                      Prs.Prs_tblPersonalInfo.fldDesc, Prs.Prs_tblPersonalInfo.fldDate, CASE WHEN fldMeliyat = 0 THEN N'غیر ایرانی' ELSE N'ایرانی' END AS fldMeliyatName, 
                      t.fldMadrakTahsiliTitle, Prs.tblVaziyatEsargari.fldTitle AS fldVaziyatEsargariTitle, ISNULL(Com.tblNezamVazife.fldTitle ,'') AS fldNezamVazifeTitle, 
                      Com.tblEmployee.fldName + '_' + Com.tblEmployee.fldFamily AS fldNameEmployee, Com.tblEmployee.fldName, Com.tblEmployee.fldFamily, 
                      Com.tblEmployee_Detail.fldFatherName, Com.tblEmployee_Detail.fldJensiyat, tblChartOrgan.fldTitle AS fldTitleChartOrgan, 
                      (SELECT Com.fn_stringDecode(tblOrganization.fldName) FROM Com.tblOrganization WHERE fldid = [Com].[fn_OrganName] (fldOrganPostId)) AS fldNameOrgan, Com.tblCity.fldName AS fldNameMahalTavalod, tblCity_1.fldName AS fldNameMahlSodoor, 
                      Com.tblEmployee.fldCodemeli, Com.tblEmployee_Detail.fldFileId, CASE WHEN fldJensiyat = 0 THEN N'زن' ELSE N'مرد' END AS fldNameJensiyat, 
                      tblOrganizationalPosts.fldTitle+'_'+tblOrganizationalPosts.fldOrgPostCode AS NamePostOran, t.fldReshteTahsiliTitle, 
                      Com.tblEmployee.fldFamily + '_' + Com.tblEmployee.fldName + '(' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName_FamilyEmployee, Com.tblEmployee_Detail.fldTel, Com.tblEmployee_Detail.fldMobile,
                      ISNULL(tblChartOrgan.fldOrganId, 0) AS fldOrganId, ISNULL
                          ((SELECT     TOP (1) fldId
                              FROM         Com.tblPersonalStatus
                              WHERE     (fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                              ORDER BY fldId DESC), 0) AS fldIdStatus, ISNULL
                          ((SELECT     TOP (1) fldNoeEstekhdamId
                              FROM         Prs.tblHistoryNoeEstekhdam
                              WHERE     (fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                              ORDER BY fldId DESC), 0) AS fldNoeEstekhdam,
                          (SELECT     TOP (1) Com.tblStatus.fldTitle
                            FROM          Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                                   Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                            WHERE      (tblPersonalStatus_1.fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                            ORDER BY tblPersonalStatus_1.fldId DESC) AS fldTitleStatus,fldTarikhSodoor,fldTaaholId,
                            ISNULL((SELECT     TOP (1)  Com.tblAnvaEstekhdam.fldTitle
FROM         Prs.tblHistoryNoeEstekhdam INNER JOIN
                      Com.tblAnvaEstekhdam ON Prs.tblHistoryNoeEstekhdam.fldNoeEstekhdamId = Com.tblAnvaEstekhdam.fldId
                              WHERE     (fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                              ORDER BY tblHistoryNoeEstekhdam.fldId DESC), '')AS TitleNoeEstekhdam,fldOrganPostEjraeeId
							  ,tblOrganizationalPostsEjraee.fldTitle+'_'+tblOrganizationalPostsEjraee.fldOrgPostCode AS TitleOrganPostEjraee,
							  Com.tblChartOrganEjraee.fldTitle AS TitleChartOrganEjraee

FROM         Prs.Prs_tblPersonalInfo INNER JOIN
                      Com.tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = Com.tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON Com.tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
                      Com.tblStatusTaahol ON Com.tblEmployee_Detail.fldTaaholId = Com.tblStatusTaahol.fldId INNER JOIN
                      Com.tblCity ON Com.tblEmployee_Detail.fldMahalTavalodId = Com.tblCity.fldId INNER JOIN
                      Com.tblCity AS tblCity_1 ON Com.tblEmployee_Detail.fldMahalSodoorId = tblCity_1.fldId INNER JOIN
                      Prs.tblVaziyatEsargari ON Prs.Prs_tblPersonalInfo.fldEsargariId = Prs.tblVaziyatEsargari.fldId INNER JOIN
                      Com.tblOrganizationalPosts ON Prs.Prs_tblPersonalInfo.fldOrganPostId = Com.tblOrganizationalPosts.fldId INNER JOIN
                      Com.tblChartOrgan ON Com.tblOrganizationalPosts.fldChartOrganId = Com.tblChartOrgan.fldId LEFT OUTER JOIN
						Com.tblNezamVazife ON Com.tblEmployee_Detail.fldNezamVazifeId = Com.tblNezamVazife.fldId   LEFT outer JOIN
					  com.tblOrganizationalPostsEjraee ON Prs.Prs_tblPersonalInfo.fldOrganPostEjraeeId=com.tblOrganizationalPostsEjraee.fldId LEFT outer JOIN
					  com.tblChartOrganEjraee ON com.tblOrganizationalPostsEjraee.fldChartOrganId =	com.tblChartOrganEjraee.fldid
					  OUTER APPLY (SELECT top(1) t.fldMadrakId,t.fldReshteId,tblMadrakTahsili.fldTitle as fldMadrakTahsiliTitle,tblReshteTahsili.fldtitle as fldReshteTahsiliTitle
										from com.tblHistoryTahsilat as t inner join 
									    Com.tblMadrakTahsili ON t.fldMadrakId = Com.tblMadrakTahsili.fldId INNER JOIN
									    Com.tblReshteTahsili ON t.fldReshteId = Com.tblReshteTahsili.fldId 
									   where t.fldEmployeeId=tblEmployee.fldid order by T.fldTarikh DESC)t

                             WHERE fldSh_Shenasname like @Value 
                              ORDER BY Prs_tblPersonalInfo.fldId DESC



	if (@fieldname=N'fldReshteShoghli')
SELECT    top(@h) Prs.Prs_tblPersonalInfo.fldId, Prs.Prs_tblPersonalInfo.fldEmployeeId, Com.tblEmployee_Detail.fldSh_Shenasname, 
                      Com.tblEmployee_Detail.fldTarikhTavalod, Com.tblEmployee_Detail.fldMahalTavalodId, Com.tblEmployee_Detail.fldMahalSodoorId, 
                      ISNULL(Com.tblEmployee_Detail.fldAddress,'')AS fldAddress, ISNULL(Com.tblEmployee_Detail.fldCodePosti,'') AS fldCodePosti, Prs.Prs_tblPersonalInfo.fldEsargariId, Prs.Prs_tblPersonalInfo.fldSharhEsargari, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali, t.fldMadrakId, t.fldReshteId, Com.tblEmployee_Detail.fldNezamVazifeId, 
                      Prs.Prs_tblPersonalInfo.fldOrganPostId, Prs.Prs_tblPersonalInfo.fldRasteShoghli, Prs.Prs_tblPersonalInfo.fldReshteShoghli, 
                      Prs.Prs_tblPersonalInfo.fldTarikhEstekhdam, tblOrganizationalPosts.fldChartOrganId, Prs.Prs_tblPersonalInfo.fldTabaghe, Com.tblEmployee_Detail.fldMeliyat, 
                      Prs.Prs_tblPersonalInfo.fldSh_MojavezEstekhdam, Prs.Prs_tblPersonalInfo.fldTarikhMajavezEstekhdam, Prs.Prs_tblPersonalInfo.fldUserId, 
                      Prs.Prs_tblPersonalInfo.fldDesc, Prs.Prs_tblPersonalInfo.fldDate, CASE WHEN fldMeliyat = 0 THEN N'غیر ایرانی' ELSE N'ایرانی' END AS fldMeliyatName, 
                      t.fldMadrakTahsiliTitle, Prs.tblVaziyatEsargari.fldTitle AS fldVaziyatEsargariTitle, ISNULL(Com.tblNezamVazife.fldTitle ,'') AS fldNezamVazifeTitle, 
                      Com.tblEmployee.fldName + '_' + Com.tblEmployee.fldFamily AS fldNameEmployee, Com.tblEmployee.fldName, Com.tblEmployee.fldFamily, 
                      Com.tblEmployee_Detail.fldFatherName, Com.tblEmployee_Detail.fldJensiyat, tblChartOrgan.fldTitle AS fldTitleChartOrgan, 
                      (SELECT Com.fn_stringDecode(tblOrganization.fldName) FROM Com.tblOrganization WHERE fldid = [Com].[fn_OrganName] (fldOrganPostId)) AS fldNameOrgan, Com.tblCity.fldName AS fldNameMahalTavalod, tblCity_1.fldName AS fldNameMahlSodoor, 
                      Com.tblEmployee.fldCodemeli, Com.tblEmployee_Detail.fldFileId, CASE WHEN fldJensiyat = 0 THEN N'زن' ELSE N'مرد' END AS fldNameJensiyat, 
                      tblOrganizationalPosts.fldTitle+'_'+tblOrganizationalPosts.fldOrgPostCode AS NamePostOran, t.fldReshteTahsiliTitle, 
                      Com.tblEmployee.fldFamily + '_' + Com.tblEmployee.fldName + '(' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName_FamilyEmployee, Com.tblEmployee_Detail.fldTel, Com.tblEmployee_Detail.fldMobile,
                      ISNULL(tblChartOrgan.fldOrganId, 0) AS fldOrganId, ISNULL
                          ((SELECT     TOP (1) fldId
                              FROM         Com.tblPersonalStatus
                              WHERE     (fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                              ORDER BY fldId DESC), 0) AS fldIdStatus, ISNULL
                          ((SELECT     TOP (1) fldNoeEstekhdamId
                              FROM         Prs.tblHistoryNoeEstekhdam
                              WHERE     (fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                              ORDER BY fldId DESC), 0) AS fldNoeEstekhdam,
                          (SELECT     TOP (1) Com.tblStatus.fldTitle
                            FROM          Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                                   Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                            WHERE      (tblPersonalStatus_1.fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                            ORDER BY tblPersonalStatus_1.fldId DESC) AS fldTitleStatus,fldTarikhSodoor,fldTaaholId,
                            ISNULL((SELECT     TOP (1)  Com.tblAnvaEstekhdam.fldTitle
FROM         Prs.tblHistoryNoeEstekhdam INNER JOIN
                      Com.tblAnvaEstekhdam ON Prs.tblHistoryNoeEstekhdam.fldNoeEstekhdamId = Com.tblAnvaEstekhdam.fldId
                              WHERE     (fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                              ORDER BY tblHistoryNoeEstekhdam.fldId DESC), '')AS TitleNoeEstekhdam,fldOrganPostEjraeeId
							  ,tblOrganizationalPostsEjraee.fldTitle+'_'+tblOrganizationalPostsEjraee.fldOrgPostCode AS TitleOrganPostEjraee,
							  Com.tblChartOrganEjraee.fldTitle AS TitleChartOrganEjraee

FROM         Prs.Prs_tblPersonalInfo INNER JOIN
                      Com.tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = Com.tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON Com.tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
                      Com.tblStatusTaahol ON Com.tblEmployee_Detail.fldTaaholId = Com.tblStatusTaahol.fldId INNER JOIN
                      Com.tblCity ON Com.tblEmployee_Detail.fldMahalTavalodId = Com.tblCity.fldId INNER JOIN
                      Com.tblCity AS tblCity_1 ON Com.tblEmployee_Detail.fldMahalSodoorId = tblCity_1.fldId INNER JOIN
                      Prs.tblVaziyatEsargari ON Prs.Prs_tblPersonalInfo.fldEsargariId = Prs.tblVaziyatEsargari.fldId INNER JOIN
                      Com.tblOrganizationalPosts ON Prs.Prs_tblPersonalInfo.fldOrganPostId = Com.tblOrganizationalPosts.fldId INNER JOIN
                      Com.tblChartOrgan ON Com.tblOrganizationalPosts.fldChartOrganId = Com.tblChartOrgan.fldId LEFT OUTER JOIN
						Com.tblNezamVazife ON Com.tblEmployee_Detail.fldNezamVazifeId = Com.tblNezamVazife.fldId   LEFT outer JOIN
					  com.tblOrganizationalPostsEjraee ON Prs.Prs_tblPersonalInfo.fldOrganPostEjraeeId=com.tblOrganizationalPostsEjraee.fldId LEFT outer JOIN
					  com.tblChartOrganEjraee ON com.tblOrganizationalPostsEjraee.fldChartOrganId =	com.tblChartOrganEjraee.fldid
					    OUTER APPLY (SELECT top(1) t.fldMadrakId,t.fldReshteId,tblMadrakTahsili.fldTitle as fldMadrakTahsiliTitle,tblReshteTahsili.fldtitle as fldReshteTahsiliTitle
										from com.tblHistoryTahsilat as t inner join 
									    Com.tblMadrakTahsili ON t.fldMadrakId = Com.tblMadrakTahsili.fldId INNER JOIN
									    Com.tblReshteTahsili ON t.fldReshteId = Com.tblReshteTahsili.fldId 
									   where t.fldEmployeeId=tblEmployee.fldid order by T.fldTarikh DESC)t

                             WHERE fldReshteShoghli like @Value 
                              ORDER BY Prs_tblPersonalInfo.fldId desc


    if (@fieldname=N'fldSh_MojavezEstekhdam')
SELECT    top(@h) Prs.Prs_tblPersonalInfo.fldId, Prs.Prs_tblPersonalInfo.fldEmployeeId, Com.tblEmployee_Detail.fldSh_Shenasname, 
                      Com.tblEmployee_Detail.fldTarikhTavalod, Com.tblEmployee_Detail.fldMahalTavalodId, Com.tblEmployee_Detail.fldMahalSodoorId, 
                      ISNULL(Com.tblEmployee_Detail.fldAddress,'')AS fldAddress, ISNULL(Com.tblEmployee_Detail.fldCodePosti,'') AS fldCodePosti, Prs.Prs_tblPersonalInfo.fldEsargariId, Prs.Prs_tblPersonalInfo.fldSharhEsargari, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali, t.fldMadrakId, t.fldReshteId, Com.tblEmployee_Detail.fldNezamVazifeId, 
                      Prs.Prs_tblPersonalInfo.fldOrganPostId, Prs.Prs_tblPersonalInfo.fldRasteShoghli, Prs.Prs_tblPersonalInfo.fldReshteShoghli, 
                      Prs.Prs_tblPersonalInfo.fldTarikhEstekhdam, tblOrganizationalPosts.fldChartOrganId, Prs.Prs_tblPersonalInfo.fldTabaghe, Com.tblEmployee_Detail.fldMeliyat, 
                      Prs.Prs_tblPersonalInfo.fldSh_MojavezEstekhdam, Prs.Prs_tblPersonalInfo.fldTarikhMajavezEstekhdam, Prs.Prs_tblPersonalInfo.fldUserId, 
                      Prs.Prs_tblPersonalInfo.fldDesc, Prs.Prs_tblPersonalInfo.fldDate, CASE WHEN fldMeliyat = 0 THEN N'غیر ایرانی' ELSE N'ایرانی' END AS fldMeliyatName, 
                      t.fldMadrakTahsiliTitle, Prs.tblVaziyatEsargari.fldTitle AS fldVaziyatEsargariTitle, ISNULL(Com.tblNezamVazife.fldTitle ,'') AS fldNezamVazifeTitle, 
                      Com.tblEmployee.fldName + '_' + Com.tblEmployee.fldFamily AS fldNameEmployee, Com.tblEmployee.fldName, Com.tblEmployee.fldFamily, 
                      Com.tblEmployee_Detail.fldFatherName, Com.tblEmployee_Detail.fldJensiyat, tblChartOrgan.fldTitle AS fldTitleChartOrgan, 
                      (SELECT Com.fn_stringDecode(tblOrganization.fldName) FROM Com.tblOrganization WHERE fldid = [Com].[fn_OrganName] (fldOrganPostId)) AS fldNameOrgan, Com.tblCity.fldName AS fldNameMahalTavalod, tblCity_1.fldName AS fldNameMahlSodoor, 
                      Com.tblEmployee.fldCodemeli, Com.tblEmployee_Detail.fldFileId, CASE WHEN fldJensiyat = 0 THEN N'زن' ELSE N'مرد' END AS fldNameJensiyat, 
                      tblOrganizationalPosts.fldTitle+'_'+tblOrganizationalPosts.fldOrgPostCode AS NamePostOran, t.fldReshteTahsiliTitle, 
                      Com.tblEmployee.fldFamily + '_' + Com.tblEmployee.fldName + '(' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName_FamilyEmployee, Com.tblEmployee_Detail.fldTel, Com.tblEmployee_Detail.fldMobile,
                      ISNULL(tblChartOrgan.fldOrganId, 0) AS fldOrganId, ISNULL
                          ((SELECT     TOP (1) fldId
                              FROM         Com.tblPersonalStatus
                              WHERE     (fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                              ORDER BY fldId DESC), 0) AS fldIdStatus, ISNULL
                          ((SELECT     TOP (1) fldNoeEstekhdamId
                              FROM         Prs.tblHistoryNoeEstekhdam
                              WHERE     (fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                              ORDER BY fldId DESC), 0) AS fldNoeEstekhdam,
                          (SELECT     TOP (1) Com.tblStatus.fldTitle
                            FROM          Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                                   Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                            WHERE      (tblPersonalStatus_1.fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                            ORDER BY tblPersonalStatus_1.fldId DESC) AS fldTitleStatus,fldTarikhSodoor,fldTaaholId,
                            ISNULL((SELECT     TOP (1)  Com.tblAnvaEstekhdam.fldTitle
FROM         Prs.tblHistoryNoeEstekhdam INNER JOIN
                      Com.tblAnvaEstekhdam ON Prs.tblHistoryNoeEstekhdam.fldNoeEstekhdamId = Com.tblAnvaEstekhdam.fldId
                              WHERE     (fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                              ORDER BY tblHistoryNoeEstekhdam.fldId DESC), '')AS TitleNoeEstekhdam,fldOrganPostEjraeeId
							  ,tblOrganizationalPostsEjraee.fldTitle+'_'+tblOrganizationalPostsEjraee.fldOrgPostCode AS TitleOrganPostEjraee,
							  Com.tblChartOrganEjraee.fldTitle AS TitleChartOrganEjraee

FROM         Prs.Prs_tblPersonalInfo INNER JOIN
                      Com.tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = Com.tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON Com.tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
                      Com.tblStatusTaahol ON Com.tblEmployee_Detail.fldTaaholId = Com.tblStatusTaahol.fldId INNER JOIN
                      Com.tblCity ON Com.tblEmployee_Detail.fldMahalTavalodId = Com.tblCity.fldId INNER JOIN
                      Com.tblCity AS tblCity_1 ON Com.tblEmployee_Detail.fldMahalSodoorId = tblCity_1.fldId INNER JOIN
                      Prs.tblVaziyatEsargari ON Prs.Prs_tblPersonalInfo.fldEsargariId = Prs.tblVaziyatEsargari.fldId INNER JOIN
                      Com.tblOrganizationalPosts ON Prs.Prs_tblPersonalInfo.fldOrganPostId = Com.tblOrganizationalPosts.fldId INNER JOIN
                      Com.tblChartOrgan ON Com.tblOrganizationalPosts.fldChartOrganId = Com.tblChartOrgan.fldId LEFT OUTER JOIN
						Com.tblNezamVazife ON Com.tblEmployee_Detail.fldNezamVazifeId = Com.tblNezamVazife.fldId   LEFT outer JOIN
					  com.tblOrganizationalPostsEjraee ON Prs.Prs_tblPersonalInfo.fldOrganPostEjraeeId=com.tblOrganizationalPostsEjraee.fldId LEFT outer JOIN
					  com.tblChartOrganEjraee ON com.tblOrganizationalPostsEjraee.fldChartOrganId =	com.tblChartOrganEjraee.fldid
					   OUTER APPLY (SELECT top(1) t.fldMadrakId,t.fldReshteId,tblMadrakTahsili.fldTitle as fldMadrakTahsiliTitle,tblReshteTahsili.fldtitle as fldReshteTahsiliTitle
										from com.tblHistoryTahsilat as t inner join 
									    Com.tblMadrakTahsili ON t.fldMadrakId = Com.tblMadrakTahsili.fldId INNER JOIN
									    Com.tblReshteTahsili ON t.fldReshteId = Com.tblReshteTahsili.fldId 
									   where t.fldEmployeeId=tblEmployee.fldid order by T.fldTarikh DESC)t

                             WHERE fldSh_MojavezEstekhdam like @Value 
                              ORDER BY Prs_tblPersonalInfo.fldId desc


			if (@fieldname=N'fldFamilyEmployee')
SELECT     TOP (@h)* FROM (SELECT   Prs.Prs_tblPersonalInfo.fldId, Prs.Prs_tblPersonalInfo.fldEmployeeId, Com.tblEmployee_Detail.fldSh_Shenasname, 
                      Com.tblEmployee_Detail.fldTarikhTavalod, Com.tblEmployee_Detail.fldMahalTavalodId, Com.tblEmployee_Detail.fldMahalSodoorId, 
                      ISNULL(Com.tblEmployee_Detail.fldAddress,'')AS fldAddress, ISNULL(Com.tblEmployee_Detail.fldCodePosti,'') AS fldCodePosti, Prs.Prs_tblPersonalInfo.fldEsargariId, Prs.Prs_tblPersonalInfo.fldSharhEsargari, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali, t.fldMadrakId, t.fldReshteId, Com.tblEmployee_Detail.fldNezamVazifeId, 
                      Prs.Prs_tblPersonalInfo.fldOrganPostId, Prs.Prs_tblPersonalInfo.fldRasteShoghli, Prs.Prs_tblPersonalInfo.fldReshteShoghli, 
                      Prs.Prs_tblPersonalInfo.fldTarikhEstekhdam, tblOrganizationalPosts.fldChartOrganId, Prs.Prs_tblPersonalInfo.fldTabaghe, Com.tblEmployee_Detail.fldMeliyat, 
                      Prs.Prs_tblPersonalInfo.fldSh_MojavezEstekhdam, Prs.Prs_tblPersonalInfo.fldTarikhMajavezEstekhdam, Prs.Prs_tblPersonalInfo.fldUserId, 
                      Prs.Prs_tblPersonalInfo.fldDesc, Prs.Prs_tblPersonalInfo.fldDate, CASE WHEN fldMeliyat = 0 THEN N'غیر ایرانی' ELSE N'ایرانی' END AS fldMeliyatName, 
                      t.fldMadrakTahsiliTitle, Prs.tblVaziyatEsargari.fldTitle AS fldVaziyatEsargariTitle, ISNULL(Com.tblNezamVazife.fldTitle ,'') AS fldNezamVazifeTitle, 
                      Com.tblEmployee.fldName + '_' + Com.tblEmployee.fldFamily AS fldNameEmployee, Com.tblEmployee.fldName, Com.tblEmployee.fldFamily, 
                      Com.tblEmployee_Detail.fldFatherName, Com.tblEmployee_Detail.fldJensiyat, tblChartOrgan.fldTitle AS fldTitleChartOrgan, 
                      (SELECT Com.fn_stringDecode(tblOrganization.fldName) FROM Com.tblOrganization WHERE fldid = [Com].[fn_OrganName] (fldOrganPostId)) AS fldNameOrgan, Com.tblCity.fldName AS fldNameMahalTavalod, tblCity_1.fldName AS fldNameMahlSodoor, 
                      Com.tblEmployee.fldCodemeli, Com.tblEmployee_Detail.fldFileId, CASE WHEN fldJensiyat = 0 THEN N'زن' ELSE N'مرد' END AS fldNameJensiyat, 
                      tblOrganizationalPosts.fldTitle+'_'+tblOrganizationalPosts.fldOrgPostCode AS NamePostOran, t.fldReshteTahsiliTitle, 
                      Com.tblEmployee.fldFamily + '_' + Com.tblEmployee.fldName + '(' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName_FamilyEmployee, Com.tblEmployee_Detail.fldTel, Com.tblEmployee_Detail.fldMobile,
                      ISNULL(tblChartOrgan.fldOrganId, 0) AS fldOrganId, ISNULL
                          ((SELECT     TOP (1) fldId
                              FROM         Com.tblPersonalStatus
                              WHERE     (fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                              ORDER BY fldId DESC), 0) AS fldIdStatus, ISNULL
                          ((SELECT     TOP (1) fldNoeEstekhdamId
                              FROM         Prs.tblHistoryNoeEstekhdam
                              WHERE     (fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                              ORDER BY fldId DESC), 0) AS fldNoeEstekhdam,
                          (SELECT     TOP (1) Com.tblStatus.fldTitle
                            FROM          Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                                   Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                            WHERE      (tblPersonalStatus_1.fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                            ORDER BY tblPersonalStatus_1.fldId DESC) AS fldTitleStatus,fldTarikhSodoor,fldTaaholId,
                            ISNULL((SELECT     TOP (1)  Com.tblAnvaEstekhdam.fldTitle
FROM         Prs.tblHistoryNoeEstekhdam INNER JOIN
                      Com.tblAnvaEstekhdam ON Prs.tblHistoryNoeEstekhdam.fldNoeEstekhdamId = Com.tblAnvaEstekhdam.fldId
                              WHERE     (fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                              ORDER BY tblHistoryNoeEstekhdam.fldId DESC), '')AS TitleNoeEstekhdam,fldOrganPostEjraeeId
							  ,tblOrganizationalPostsEjraee.fldTitle+'_'+tblOrganizationalPostsEjraee.fldOrgPostCode AS TitleOrganPostEjraee,
							  Com.tblChartOrganEjraee.fldTitle AS TitleChartOrganEjraee

FROM         Prs.Prs_tblPersonalInfo INNER JOIN
                      Com.tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = Com.tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON Com.tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
                      Com.tblStatusTaahol ON Com.tblEmployee_Detail.fldTaaholId = Com.tblStatusTaahol.fldId INNER JOIN
                      Com.tblCity ON Com.tblEmployee_Detail.fldMahalTavalodId = Com.tblCity.fldId INNER JOIN
                      Com.tblCity AS tblCity_1 ON Com.tblEmployee_Detail.fldMahalSodoorId = tblCity_1.fldId INNER JOIN
                      Prs.tblVaziyatEsargari ON Prs.Prs_tblPersonalInfo.fldEsargariId = Prs.tblVaziyatEsargari.fldId INNER JOIN
                      Com.tblOrganizationalPosts ON Prs.Prs_tblPersonalInfo.fldOrganPostId = Com.tblOrganizationalPosts.fldId INNER JOIN
                      Com.tblChartOrgan ON Com.tblOrganizationalPosts.fldChartOrganId = Com.tblChartOrgan.fldId LEFT OUTER JOIN
						Com.tblNezamVazife ON Com.tblEmployee_Detail.fldNezamVazifeId = Com.tblNezamVazife.fldId   LEFT outer JOIN
					  com.tblOrganizationalPostsEjraee ON Prs.Prs_tblPersonalInfo.fldOrganPostEjraeeId=com.tblOrganizationalPostsEjraee.fldId LEFT outer JOIN
					  com.tblChartOrganEjraee ON com.tblOrganizationalPostsEjraee.fldChartOrganId =	com.tblChartOrganEjraee.fldid
					    OUTER APPLY (SELECT top(1) t.fldMadrakId,t.fldReshteId,tblMadrakTahsili.fldTitle as fldMadrakTahsiliTitle,tblReshteTahsili.fldtitle as fldReshteTahsiliTitle
										from com.tblHistoryTahsilat as t inner join 
									    Com.tblMadrakTahsili ON t.fldMadrakId = Com.tblMadrakTahsili.fldId INNER JOIN
									    Com.tblReshteTahsili ON t.fldReshteId = Com.tblReshteTahsili.fldId 
									   where t.fldEmployeeId=tblEmployee.fldid order by T.fldTarikh DESC)t

 )t
                      WHERE fldFamily LIKE @Value and  com.fn_organId(fldid)=@OrganId
                              ORDER BY fldId DESC

           if (@fieldname=N'fldTitleStatus')
SELECT     TOP (@h)* FROM (SELECT    Prs.Prs_tblPersonalInfo.fldId, Prs.Prs_tblPersonalInfo.fldEmployeeId, Com.tblEmployee_Detail.fldSh_Shenasname, 
                      Com.tblEmployee_Detail.fldTarikhTavalod, Com.tblEmployee_Detail.fldMahalTavalodId, Com.tblEmployee_Detail.fldMahalSodoorId, 
                      ISNULL(Com.tblEmployee_Detail.fldAddress,'')AS fldAddress, ISNULL(Com.tblEmployee_Detail.fldCodePosti,'') AS fldCodePosti, Prs.Prs_tblPersonalInfo.fldEsargariId, Prs.Prs_tblPersonalInfo.fldSharhEsargari, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali, t.fldMadrakId, t.fldReshteId, Com.tblEmployee_Detail.fldNezamVazifeId, 
                      Prs.Prs_tblPersonalInfo.fldOrganPostId, Prs.Prs_tblPersonalInfo.fldRasteShoghli, Prs.Prs_tblPersonalInfo.fldReshteShoghli, 
                      Prs.Prs_tblPersonalInfo.fldTarikhEstekhdam, tblOrganizationalPosts.fldChartOrganId, Prs.Prs_tblPersonalInfo.fldTabaghe, Com.tblEmployee_Detail.fldMeliyat, 
                      Prs.Prs_tblPersonalInfo.fldSh_MojavezEstekhdam, Prs.Prs_tblPersonalInfo.fldTarikhMajavezEstekhdam, Prs.Prs_tblPersonalInfo.fldUserId, 
                      Prs.Prs_tblPersonalInfo.fldDesc, Prs.Prs_tblPersonalInfo.fldDate, CASE WHEN fldMeliyat = 0 THEN N'غیر ایرانی' ELSE N'ایرانی' END AS fldMeliyatName, 
                      t.fldMadrakTahsiliTitle, Prs.tblVaziyatEsargari.fldTitle AS fldVaziyatEsargariTitle, ISNULL(Com.tblNezamVazife.fldTitle ,'') AS fldNezamVazifeTitle, 
                      Com.tblEmployee.fldName + '_' + Com.tblEmployee.fldFamily AS fldNameEmployee, Com.tblEmployee.fldName, Com.tblEmployee.fldFamily, 
                      Com.tblEmployee_Detail.fldFatherName, Com.tblEmployee_Detail.fldJensiyat, tblChartOrgan.fldTitle AS fldTitleChartOrgan, 
                      (SELECT Com.fn_stringDecode(tblOrganization.fldName) FROM Com.tblOrganization WHERE fldid = [Com].[fn_OrganName] (fldOrganPostId)) AS fldNameOrgan, Com.tblCity.fldName AS fldNameMahalTavalod, tblCity_1.fldName AS fldNameMahlSodoor, 
                      Com.tblEmployee.fldCodemeli, Com.tblEmployee_Detail.fldFileId, CASE WHEN fldJensiyat = 0 THEN N'زن' ELSE N'مرد' END AS fldNameJensiyat, 
                      tblOrganizationalPosts.fldTitle+'_'+tblOrganizationalPosts.fldOrgPostCode AS NamePostOran, t.fldReshteTahsiliTitle, 
                      Com.tblEmployee.fldFamily + '_' + Com.tblEmployee.fldName + '(' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName_FamilyEmployee, Com.tblEmployee_Detail.fldTel, Com.tblEmployee_Detail.fldMobile,
                      ISNULL(tblChartOrgan.fldOrganId, 0) AS fldOrganId, ISNULL
                          ((SELECT     TOP (1) fldId
                              FROM         Com.tblPersonalStatus
                              WHERE     (fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                              ORDER BY fldId DESC), 0) AS fldIdStatus, ISNULL
                          ((SELECT     TOP (1) fldNoeEstekhdamId
                              FROM         Prs.tblHistoryNoeEstekhdam
                              WHERE     (fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                              ORDER BY fldId DESC), 0) AS fldNoeEstekhdam,
                          (SELECT     TOP (1) Com.tblStatus.fldTitle
                            FROM          Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                                   Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                            WHERE      (tblPersonalStatus_1.fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                            ORDER BY tblPersonalStatus_1.fldId DESC) AS fldTitleStatus,fldTarikhSodoor,fldTaaholId,
                            ISNULL((SELECT     TOP (1)  Com.tblAnvaEstekhdam.fldTitle
FROM         Prs.tblHistoryNoeEstekhdam INNER JOIN
                      Com.tblAnvaEstekhdam ON Prs.tblHistoryNoeEstekhdam.fldNoeEstekhdamId = Com.tblAnvaEstekhdam.fldId
                              WHERE     (fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                              ORDER BY tblHistoryNoeEstekhdam.fldId DESC), '')AS TitleNoeEstekhdam,fldOrganPostEjraeeId
							  ,tblOrganizationalPostsEjraee.fldTitle+'_'+tblOrganizationalPostsEjraee.fldOrgPostCode AS TitleOrganPostEjraee,
							  Com.tblChartOrganEjraee.fldTitle AS TitleChartOrganEjraee

FROM         Prs.Prs_tblPersonalInfo INNER JOIN
                      Com.tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = Com.tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON Com.tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
                      Com.tblStatusTaahol ON Com.tblEmployee_Detail.fldTaaholId = Com.tblStatusTaahol.fldId INNER JOIN
                      Com.tblCity ON Com.tblEmployee_Detail.fldMahalTavalodId = Com.tblCity.fldId INNER JOIN
                      Com.tblCity AS tblCity_1 ON Com.tblEmployee_Detail.fldMahalSodoorId = tblCity_1.fldId INNER JOIN
                      Prs.tblVaziyatEsargari ON Prs.Prs_tblPersonalInfo.fldEsargariId = Prs.tblVaziyatEsargari.fldId INNER JOIN
                      Com.tblOrganizationalPosts ON Prs.Prs_tblPersonalInfo.fldOrganPostId = Com.tblOrganizationalPosts.fldId INNER JOIN
                      Com.tblChartOrgan ON Com.tblOrganizationalPosts.fldChartOrganId = Com.tblChartOrgan.fldId LEFT OUTER JOIN
						Com.tblNezamVazife ON Com.tblEmployee_Detail.fldNezamVazifeId = Com.tblNezamVazife.fldId   LEFT outer JOIN
					  com.tblOrganizationalPostsEjraee ON Prs.Prs_tblPersonalInfo.fldOrganPostEjraeeId=com.tblOrganizationalPostsEjraee.fldId LEFT outer JOIN
					  com.tblChartOrganEjraee ON com.tblOrganizationalPostsEjraee.fldChartOrganId =	com.tblChartOrganEjraee.fldid
					    OUTER APPLY (SELECT top(1) t.fldMadrakId,t.fldReshteId,tblMadrakTahsili.fldTitle as fldMadrakTahsiliTitle,tblReshteTahsili.fldtitle as fldReshteTahsiliTitle
										from com.tblHistoryTahsilat as t inner join 
									    Com.tblMadrakTahsili ON t.fldMadrakId = Com.tblMadrakTahsili.fldId INNER JOIN
									    Com.tblReshteTahsili ON t.fldReshteId = Com.tblReshteTahsili.fldId 
									   where t.fldEmployeeId=tblEmployee.fldid order by T.fldTarikh DESC)t

 )t
                      WHERE fldTitleStatus LIKE @Value and  com.fn_organId(fldid)=@OrganId
                              ORDER BY fldId desc



	if (@fieldname=N'PersonalActive')
SELECT    top(@h) * FROM (SELECT Prs.Prs_tblPersonalInfo.fldId, Prs.Prs_tblPersonalInfo.fldEmployeeId, Com.tblEmployee_Detail.fldSh_Shenasname, 
                      Com.tblEmployee_Detail.fldTarikhTavalod, Com.tblEmployee_Detail.fldMahalTavalodId, Com.tblEmployee_Detail.fldMahalSodoorId, 
                      ISNULL(Com.tblEmployee_Detail.fldAddress,'')AS fldAddress, ISNULL(Com.tblEmployee_Detail.fldCodePosti,'') AS fldCodePosti, Prs.Prs_tblPersonalInfo.fldEsargariId, Prs.Prs_tblPersonalInfo.fldSharhEsargari, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali, t.fldMadrakId, t.fldReshteId, Com.tblEmployee_Detail.fldNezamVazifeId, 
                      Prs.Prs_tblPersonalInfo.fldOrganPostId, Prs.Prs_tblPersonalInfo.fldRasteShoghli, Prs.Prs_tblPersonalInfo.fldReshteShoghli, 
                      Prs.Prs_tblPersonalInfo.fldTarikhEstekhdam, tblOrganizationalPosts.fldChartOrganId, Prs.Prs_tblPersonalInfo.fldTabaghe, Com.tblEmployee_Detail.fldMeliyat, 
                      Prs.Prs_tblPersonalInfo.fldSh_MojavezEstekhdam, Prs.Prs_tblPersonalInfo.fldTarikhMajavezEstekhdam, Prs.Prs_tblPersonalInfo.fldUserId, 
                      Prs.Prs_tblPersonalInfo.fldDesc, Prs.Prs_tblPersonalInfo.fldDate, CASE WHEN fldMeliyat = 0 THEN N'غیر ایرانی' ELSE N'ایرانی' END AS fldMeliyatName, 
                      t.fldMadrakTahsiliTitle, Prs.tblVaziyatEsargari.fldTitle AS fldVaziyatEsargariTitle, ISNULL(Com.tblNezamVazife.fldTitle ,'') AS fldNezamVazifeTitle, 
                      Com.tblEmployee.fldName + '_' + Com.tblEmployee.fldFamily AS fldNameEmployee, Com.tblEmployee.fldName, Com.tblEmployee.fldFamily, 
                      Com.tblEmployee_Detail.fldFatherName, Com.tblEmployee_Detail.fldJensiyat, tblChartOrgan.fldTitle AS fldTitleChartOrgan, 
                      (SELECT Com.fn_stringDecode(tblOrganization.fldName) FROM Com.tblOrganization WHERE fldid = [Com].[fn_OrganName] (fldOrganPostId)) AS fldNameOrgan, Com.tblCity.fldName AS fldNameMahalTavalod, tblCity_1.fldName AS fldNameMahlSodoor, 
                      Com.tblEmployee.fldCodemeli, Com.tblEmployee_Detail.fldFileId, CASE WHEN fldJensiyat = 0 THEN N'زن' ELSE N'مرد' END AS fldNameJensiyat, 
                      tblOrganizationalPosts.fldTitle+'_'+tblOrganizationalPosts.fldOrgPostCode AS NamePostOran, t.fldReshteTahsiliTitle, 
                      Com.tblEmployee.fldFamily + '_' + Com.tblEmployee.fldName + '(' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName_FamilyEmployee, Com.tblEmployee_Detail.fldTel, Com.tblEmployee_Detail.fldMobile,
                      ISNULL(tblChartOrgan.fldOrganId, 0) AS fldOrganId, ISNULL
                          ((SELECT     TOP (1) fldId
                              FROM         Com.tblPersonalStatus
                              WHERE     (fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                              ORDER BY fldId DESC), 0) AS fldIdStatus, ISNULL
                          ((SELECT     TOP (1) fldNoeEstekhdamId
                              FROM         Prs.tblHistoryNoeEstekhdam
                              WHERE     (fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                              ORDER BY tblHistoryNoeEstekhdam.fldId DESC), 0) AS fldNoeEstekhdam,
                          (SELECT     TOP (1) Com.tblStatus.fldTitle
                            FROM          Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                                   Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                            WHERE      (tblPersonalStatus_1.fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                            ORDER BY tblPersonalStatus_1.fldId DESC) AS fldTitleStatus,fldTarikhSodoor,fldTaaholId,
                            ISNULL((SELECT     TOP (1)  Com.tblAnvaEstekhdam.fldTitle
FROM         Prs.tblHistoryNoeEstekhdam INNER JOIN
                      Com.tblAnvaEstekhdam ON Prs.tblHistoryNoeEstekhdam.fldNoeEstekhdamId = Com.tblAnvaEstekhdam.fldId
                              WHERE     (fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                              ORDER BY tblHistoryNoeEstekhdam.fldId DESC), '')AS TitleNoeEstekhdam,fldOrganPostEjraeeId
							  ,tblOrganizationalPostsEjraee.fldTitle+'_'+tblOrganizationalPostsEjraee.fldOrgPostCode AS TitleOrganPostEjraee,
							  Com.tblChartOrganEjraee.fldTitle AS TitleChartOrganEjraee

FROM         Prs.Prs_tblPersonalInfo INNER JOIN
                      Com.tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = Com.tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON Com.tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
                      Com.tblStatusTaahol ON Com.tblEmployee_Detail.fldTaaholId = Com.tblStatusTaahol.fldId INNER JOIN
                      Com.tblCity ON Com.tblEmployee_Detail.fldMahalTavalodId = Com.tblCity.fldId INNER JOIN
                      Com.tblCity AS tblCity_1 ON Com.tblEmployee_Detail.fldMahalSodoorId = tblCity_1.fldId INNER JOIN
                      Prs.tblVaziyatEsargari ON Prs.Prs_tblPersonalInfo.fldEsargariId = Prs.tblVaziyatEsargari.fldId INNER JOIN
                      Com.tblOrganizationalPosts ON Prs.Prs_tblPersonalInfo.fldOrganPostId = Com.tblOrganizationalPosts.fldId INNER JOIN
                      Com.tblChartOrgan ON Com.tblOrganizationalPosts.fldChartOrganId = Com.tblChartOrgan.fldId LEFT OUTER JOIN
						Com.tblNezamVazife ON Com.tblEmployee_Detail.fldNezamVazifeId = Com.tblNezamVazife.fldId   LEFT outer JOIN
					  com.tblOrganizationalPostsEjraee ON Prs.Prs_tblPersonalInfo.fldOrganPostEjraeeId=com.tblOrganizationalPostsEjraee.fldId LEFT outer JOIN
					  com.tblChartOrganEjraee ON com.tblOrganizationalPostsEjraee.fldChartOrganId =	com.tblChartOrganEjraee.fldid
					    OUTER APPLY (SELECT top(1) t.fldMadrakId,t.fldReshteId,tblMadrakTahsili.fldTitle as fldMadrakTahsiliTitle,tblReshteTahsili.fldtitle as fldReshteTahsiliTitle
										from com.tblHistoryTahsilat as t inner join 
									    Com.tblMadrakTahsili ON t.fldMadrakId = Com.tblMadrakTahsili.fldId INNER JOIN
									    Com.tblReshteTahsili ON t.fldReshteId = Com.tblReshteTahsili.fldId 
									   where t.fldEmployeeId=tblEmployee.fldid order by T.fldTarikh DESC)t
                       WHERE   com.fn_organId(Prs_tblPersonalInfo.fldid)=@OrganId AND com.fn_MaxPersonalStatus(Prs_tblPersonalInfo.fldid,'kargozini')=1
                     )t WHERE  fldNoeEstekhdam=@value
                              ORDER BY fldId DESC





	if (@fieldname=N'')
SELECT    top(@h) Prs.Prs_tblPersonalInfo.fldId, Prs.Prs_tblPersonalInfo.fldEmployeeId, Com.tblEmployee_Detail.fldSh_Shenasname, 
                      Com.tblEmployee_Detail.fldTarikhTavalod, Com.tblEmployee_Detail.fldMahalTavalodId, Com.tblEmployee_Detail.fldMahalSodoorId, 
                      ISNULL(Com.tblEmployee_Detail.fldAddress,'')AS fldAddress, ISNULL(Com.tblEmployee_Detail.fldCodePosti,'') AS fldCodePosti, Prs.Prs_tblPersonalInfo.fldEsargariId, Prs.Prs_tblPersonalInfo.fldSharhEsargari, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali, t.fldMadrakId, t.fldReshteId, Com.tblEmployee_Detail.fldNezamVazifeId, 
                      Prs.Prs_tblPersonalInfo.fldOrganPostId, Prs.Prs_tblPersonalInfo.fldRasteShoghli, Prs.Prs_tblPersonalInfo.fldReshteShoghli, 
                      Prs.Prs_tblPersonalInfo.fldTarikhEstekhdam, tblOrganizationalPosts.fldChartOrganId, Prs.Prs_tblPersonalInfo.fldTabaghe, Com.tblEmployee_Detail.fldMeliyat, 
                      Prs.Prs_tblPersonalInfo.fldSh_MojavezEstekhdam, Prs.Prs_tblPersonalInfo.fldTarikhMajavezEstekhdam, Prs.Prs_tblPersonalInfo.fldUserId, 
                      Prs.Prs_tblPersonalInfo.fldDesc, Prs.Prs_tblPersonalInfo.fldDate, CASE WHEN fldMeliyat = 0 THEN N'غیر ایرانی' ELSE N'ایرانی' END AS fldMeliyatName, 
                      t.fldMadrakTahsiliTitle, Prs.tblVaziyatEsargari.fldTitle AS fldVaziyatEsargariTitle, ISNULL(Com.tblNezamVazife.fldTitle ,'') AS fldNezamVazifeTitle, 
                      Com.tblEmployee.fldName + '_' + Com.tblEmployee.fldFamily AS fldNameEmployee, Com.tblEmployee.fldName, Com.tblEmployee.fldFamily, 
                      Com.tblEmployee_Detail.fldFatherName, Com.tblEmployee_Detail.fldJensiyat, tblChartOrgan.fldTitle AS fldTitleChartOrgan, 
                      (SELECT Com.fn_stringDecode(tblOrganization.fldName) FROM Com.tblOrganization WHERE fldid = [Com].[fn_OrganName] (fldOrganPostId)) AS fldNameOrgan, Com.tblCity.fldName AS fldNameMahalTavalod, tblCity_1.fldName AS fldNameMahlSodoor, 
                      Com.tblEmployee.fldCodemeli, Com.tblEmployee_Detail.fldFileId, CASE WHEN fldJensiyat = 0 THEN N'زن' ELSE N'مرد' END AS fldNameJensiyat, 
                      tblOrganizationalPosts.fldTitle+'_'+tblOrganizationalPosts.fldOrgPostCode AS NamePostOran, t.fldReshteTahsiliTitle, 
                      Com.tblEmployee.fldFamily + '_' + Com.tblEmployee.fldName + '(' + Com.tblEmployee_Detail.fldFatherName + ')' AS fldName_FamilyEmployee, Com.tblEmployee_Detail.fldTel, Com.tblEmployee_Detail.fldMobile,
                      ISNULL(tblChartOrgan.fldOrganId, 0) AS fldOrganId, ISNULL
                          ((SELECT     TOP (1) fldId
                              FROM         Com.tblPersonalStatus
                              WHERE     (fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                              ORDER BY fldId DESC), 0) AS fldIdStatus, ISNULL
                          ((SELECT     TOP (1) fldNoeEstekhdamId
                              FROM         Prs.tblHistoryNoeEstekhdam
                              WHERE     (fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                              ORDER BY fldId DESC), 0) AS fldNoeEstekhdam,
                          (SELECT     TOP (1) Com.tblStatus.fldTitle
                            FROM          Com.tblPersonalStatus AS tblPersonalStatus_1 INNER JOIN
                                                   Com.tblStatus ON tblPersonalStatus_1.fldStatusId = Com.tblStatus.fldId
                            WHERE      (tblPersonalStatus_1.fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                            ORDER BY tblPersonalStatus_1.fldId DESC) AS fldTitleStatus,fldTarikhSodoor,fldTaaholId,
                            ISNULL((SELECT     TOP (1)  Com.tblAnvaEstekhdam.fldTitle
FROM         Prs.tblHistoryNoeEstekhdam INNER JOIN
                      Com.tblAnvaEstekhdam ON Prs.tblHistoryNoeEstekhdam.fldNoeEstekhdamId = Com.tblAnvaEstekhdam.fldId
                              WHERE     (fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                              ORDER BY tblHistoryNoeEstekhdam.fldId DESC), '')AS TitleNoeEstekhdam,fldOrganPostEjraeeId
							  ,tblOrganizationalPostsEjraee.fldTitle+'_'+tblOrganizationalPostsEjraee.fldOrgPostCode AS TitleOrganPostEjraee,
							  Com.tblChartOrganEjraee.fldTitle AS TitleChartOrganEjraee

FROM         Prs.Prs_tblPersonalInfo INNER JOIN
                      Com.tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = Com.tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON Com.tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
                      Com.tblStatusTaahol ON Com.tblEmployee_Detail.fldTaaholId = Com.tblStatusTaahol.fldId INNER JOIN
                      Com.tblCity ON Com.tblEmployee_Detail.fldMahalTavalodId = Com.tblCity.fldId INNER JOIN
                      Com.tblCity AS tblCity_1 ON Com.tblEmployee_Detail.fldMahalSodoorId = tblCity_1.fldId INNER JOIN
                      Prs.tblVaziyatEsargari ON Prs.Prs_tblPersonalInfo.fldEsargariId = Prs.tblVaziyatEsargari.fldId INNER JOIN
                      Com.tblOrganizationalPosts ON Prs.Prs_tblPersonalInfo.fldOrganPostId = Com.tblOrganizationalPosts.fldId INNER JOIN
                      Com.tblChartOrgan ON Com.tblOrganizationalPosts.fldChartOrganId = Com.tblChartOrgan.fldId LEFT OUTER JOIN
						Com.tblNezamVazife ON Com.tblEmployee_Detail.fldNezamVazifeId = Com.tblNezamVazife.fldId   LEFT outer JOIN
					  com.tblOrganizationalPostsEjraee ON Prs.Prs_tblPersonalInfo.fldOrganPostEjraeeId=com.tblOrganizationalPostsEjraee.fldId LEFT outer JOIN
					  com.tblChartOrganEjraee ON com.tblOrganizationalPostsEjraee.fldChartOrganId =	com.tblChartOrganEjraee.fldid
					    OUTER APPLY (SELECT top(1) t.fldMadrakId,t.fldReshteId,tblMadrakTahsili.fldTitle as fldMadrakTahsiliTitle,tblReshteTahsili.fldtitle as fldReshteTahsiliTitle
										from com.tblHistoryTahsilat as t inner join 
									    Com.tblMadrakTahsili ON t.fldMadrakId = Com.tblMadrakTahsili.fldId INNER JOIN
									    Com.tblReshteTahsili ON t.fldReshteId = Com.tblReshteTahsili.fldId 
									   where t.fldEmployeeId=tblEmployee.fldid order by T.fldTarikh DESC)t
                       WHERE   com.fn_organId(Prs_tblPersonalInfo.fldid)=@OrganId
                              ORDER BY Prs_tblPersonalInfo.fldId DESC

                       	COMMIT TRAN
GO
