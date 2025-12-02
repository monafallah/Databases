SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Prs].[spr_Prs_tblPersonalInfoSelect_Hokm] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@OrganId INT,
	@Userid int,
	@h int
AS 

if (@h=0) set @h=2147483647
	SET @Value=Com.fn_TextNormalize(@Value)

	if (@fieldname=N'fldId')
SELECT    top(@h)* from (select  Prs.Prs_tblPersonalInfo.fldId, Prs.Prs_tblPersonalInfo.fldEmployeeId, Com.tblEmployee_Detail.fldSh_Shenasname, 
                      Com.tblEmployee_Detail.fldTarikhTavalod, Com.tblEmployee_Detail.fldMahalTavalodId, Com.tblEmployee_Detail.fldMahalSodoorId, 
                      ISNULL(Com.tblEmployee_Detail.fldAddress,'')AS fldAddress, ISNULL(Com.tblEmployee_Detail.fldCodePosti,'') AS fldCodePosti, Prs.Prs_tblPersonalInfo.fldEsargariId, Prs.Prs_tblPersonalInfo.fldSharhEsargari, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali, Com.tblEmployee_Detail.fldMadrakId, Com.tblEmployee_Detail.fldReshteId, Com.tblEmployee_Detail.fldNezamVazifeId, 
                      Prs.Prs_tblPersonalInfo.fldOrganPostId, Prs.Prs_tblPersonalInfo.fldRasteShoghli, Prs.Prs_tblPersonalInfo.fldReshteShoghli, 
                      Prs.Prs_tblPersonalInfo.fldTarikhEstekhdam, tblOrganizationalPosts.fldChartOrganId, Prs.Prs_tblPersonalInfo.fldTabaghe, Com.tblEmployee_Detail.fldMeliyat, 
                      Prs.Prs_tblPersonalInfo.fldSh_MojavezEstekhdam, Prs.Prs_tblPersonalInfo.fldTarikhMajavezEstekhdam, Prs.Prs_tblPersonalInfo.fldUserId, 
                      Prs.Prs_tblPersonalInfo.fldDesc, Prs.Prs_tblPersonalInfo.fldDate, CASE WHEN fldMeliyat = 0 THEN N'غیر ایرانی' ELSE N'ایرانی' END AS fldMeliyatName, 
                      Com.tblMadrakTahsili.fldTitle AS fldMadrakTahsiliTitle, Prs.tblVaziyatEsargari.fldTitle AS fldVaziyatEsargariTitle, ISNULL(Com.tblNezamVazife.fldTitle ,'') AS fldNezamVazifeTitle, 
                      Com.tblEmployee.fldName + '_' + Com.tblEmployee.fldFamily AS fldNameEmployee, Com.tblEmployee.fldName, Com.tblEmployee.fldFamily, 
                      Com.tblEmployee_Detail.fldFatherName, Com.tblEmployee_Detail.fldJensiyat, tblChartOrgan.fldTitle AS fldTitleChartOrgan, 
                      (SELECT Com.fn_stringDecode(tblOrganization.fldName) FROM Com.tblOrganization WHERE fldid = [Com].[fn_OrganName] (fldOrganPostId)) AS fldNameOrgan, Com.tblCity.fldName AS fldNameMahalTavalod, tblCity_1.fldName AS fldNameMahlSodoor, 
                      Com.tblEmployee.fldCodemeli, Com.tblEmployee_Detail.fldFileId, CASE WHEN fldJensiyat = 0 THEN N'زن' ELSE N'مرد' END AS fldNameJensiyat, 
                      tblOrganizationalPosts.fldTitle/*+'_'+tblOrganizationalPosts.fldOrgPostCode*/ AS NamePostOran, Com.tblReshteTahsili.fldTitle AS fldReshteTahsiliTitle, 
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
                      Com.tblMadrakTahsili ON Com.tblEmployee_Detail.fldMadrakId = Com.tblMadrakTahsili.fldId INNER JOIN
                      Com.tblReshteTahsili ON Com.tblEmployee_Detail.fldReshteId = Com.tblReshteTahsili.fldId INNER JOIN
                      Com.tblCity ON Com.tblEmployee_Detail.fldMahalTavalodId = Com.tblCity.fldId INNER JOIN
                      Com.tblCity AS tblCity_1 ON Com.tblEmployee_Detail.fldMahalSodoorId = tblCity_1.fldId INNER JOIN
                      Prs.tblVaziyatEsargari ON Prs.Prs_tblPersonalInfo.fldEsargariId = Prs.tblVaziyatEsargari.fldId INNER JOIN
                      Com.tblOrganizationalPosts ON Prs.Prs_tblPersonalInfo.fldOrganPostId = Com.tblOrganizationalPosts.fldId INNER JOIN
                      Com.tblChartOrgan ON Com.tblOrganizationalPosts.fldChartOrganId = Com.tblChartOrgan.fldId LEFT OUTER JOIN
						Com.tblNezamVazife ON Com.tblEmployee_Detail.fldNezamVazifeId = Com.tblNezamVazife.fldId   LEFT outer JOIN
					  com.tblOrganizationalPostsEjraee ON Prs.Prs_tblPersonalInfo.fldOrganPostEjraeeId=com.tblOrganizationalPostsEjraee.fldId LEFT outer JOIN
					  com.tblChartOrganEjraee ON com.tblOrganizationalPostsEjraee.fldChartOrganId =	com.tblChartOrganEjraee.fldid

                      	WHERE  Prs_tblPersonalInfo.fldId = @Value AND com.fn_organId(Prs_tblPersonalInfo.fldid) =@OrganId)t
						cross apply ( select t.fldTypeEstekhamId from com.tblUser_Group u
											inner join pay.tblTypeEstekhdam_UserGroup t on t.fldUseGroupId=u.fldUserGroupId
											where fldUserSelectId=@userId and t.fldTypeEstekhamId=fldNoeEstekhdam
											group by  t.fldTypeEstekhamId )typeestekhdam
                     ORDER BY t.fldId DESC


	if (@fieldname=N'fldSh_Personali')
SELECT    top(@h) * from (select Prs.Prs_tblPersonalInfo.fldId, Prs.Prs_tblPersonalInfo.fldEmployeeId, Com.tblEmployee_Detail.fldSh_Shenasname, 
                      Com.tblEmployee_Detail.fldTarikhTavalod, Com.tblEmployee_Detail.fldMahalTavalodId, Com.tblEmployee_Detail.fldMahalSodoorId, 
                      ISNULL(Com.tblEmployee_Detail.fldAddress,'')AS fldAddress, ISNULL(Com.tblEmployee_Detail.fldCodePosti,'') AS fldCodePosti, Prs.Prs_tblPersonalInfo.fldEsargariId, Prs.Prs_tblPersonalInfo.fldSharhEsargari, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali, Com.tblEmployee_Detail.fldMadrakId, Com.tblEmployee_Detail.fldReshteId, Com.tblEmployee_Detail.fldNezamVazifeId, 
                      Prs.Prs_tblPersonalInfo.fldOrganPostId, Prs.Prs_tblPersonalInfo.fldRasteShoghli, Prs.Prs_tblPersonalInfo.fldReshteShoghli, 
                      Prs.Prs_tblPersonalInfo.fldTarikhEstekhdam, tblOrganizationalPosts.fldChartOrganId, Prs.Prs_tblPersonalInfo.fldTabaghe, Com.tblEmployee_Detail.fldMeliyat, 
                      Prs.Prs_tblPersonalInfo.fldSh_MojavezEstekhdam, Prs.Prs_tblPersonalInfo.fldTarikhMajavezEstekhdam, Prs.Prs_tblPersonalInfo.fldUserId, 
                      Prs.Prs_tblPersonalInfo.fldDesc, Prs.Prs_tblPersonalInfo.fldDate, CASE WHEN fldMeliyat = 0 THEN N'غیر ایرانی' ELSE N'ایرانی' END AS fldMeliyatName, 
                      Com.tblMadrakTahsili.fldTitle AS fldMadrakTahsiliTitle, Prs.tblVaziyatEsargari.fldTitle AS fldVaziyatEsargariTitle, ISNULL(Com.tblNezamVazife.fldTitle ,'') AS fldNezamVazifeTitle, 
                      Com.tblEmployee.fldName + '_' + Com.tblEmployee.fldFamily AS fldNameEmployee, Com.tblEmployee.fldName, Com.tblEmployee.fldFamily, 
                      Com.tblEmployee_Detail.fldFatherName, Com.tblEmployee_Detail.fldJensiyat, tblChartOrgan.fldTitle AS fldTitleChartOrgan, 
                      (SELECT Com.fn_stringDecode(tblOrganization.fldName) FROM Com.tblOrganization WHERE fldid = [Com].[fn_OrganName] (fldOrganPostId)) AS fldNameOrgan, Com.tblCity.fldName AS fldNameMahalTavalod, tblCity_1.fldName AS fldNameMahlSodoor, 
                      Com.tblEmployee.fldCodemeli, Com.tblEmployee_Detail.fldFileId, CASE WHEN fldJensiyat = 0 THEN N'زن' ELSE N'مرد' END AS fldNameJensiyat, 
                      tblOrganizationalPosts.fldTitle+'_'+tblOrganizationalPosts.fldOrgPostCode AS NamePostOran, Com.tblReshteTahsili.fldTitle AS fldReshteTahsiliTitle, 
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
                      Com.tblMadrakTahsili ON Com.tblEmployee_Detail.fldMadrakId = Com.tblMadrakTahsili.fldId INNER JOIN
                      Com.tblReshteTahsili ON Com.tblEmployee_Detail.fldReshteId = Com.tblReshteTahsili.fldId INNER JOIN
                      Com.tblCity ON Com.tblEmployee_Detail.fldMahalTavalodId = Com.tblCity.fldId INNER JOIN
                      Com.tblCity AS tblCity_1 ON Com.tblEmployee_Detail.fldMahalSodoorId = tblCity_1.fldId INNER JOIN
                      Prs.tblVaziyatEsargari ON Prs.Prs_tblPersonalInfo.fldEsargariId = Prs.tblVaziyatEsargari.fldId INNER JOIN
                      Com.tblOrganizationalPosts ON Prs.Prs_tblPersonalInfo.fldOrganPostId = Com.tblOrganizationalPosts.fldId INNER JOIN
                      Com.tblChartOrgan ON Com.tblOrganizationalPosts.fldChartOrganId = Com.tblChartOrgan.fldId LEFT OUTER JOIN
						Com.tblNezamVazife ON Com.tblEmployee_Detail.fldNezamVazifeId = Com.tblNezamVazife.fldId   LEFT outer JOIN
					  com.tblOrganizationalPostsEjraee ON Prs.Prs_tblPersonalInfo.fldOrganPostEjraeeId=com.tblOrganizationalPostsEjraee.fldId LEFT outer JOIN
					  com.tblChartOrganEjraee ON com.tblOrganizationalPostsEjraee.fldChartOrganId =	com.tblChartOrganEjraee.fldid

                      WHERE  Prs_tblPersonalInfo.fldSh_Personali LIKE @Value AND com.fn_organId(Prs_tblPersonalInfo.fldid) =@OrganId
                         )t
						 		 cross apply ( select t.fldTypeEstekhamId from com.tblUser_Group u
											inner join pay.tblTypeEstekhdam_UserGroup t on t.fldUseGroupId=u.fldUserGroupId
											where fldUserSelectId=@userId and t.fldTypeEstekhamId=fldNoeEstekhdam
											group by  t.fldTypeEstekhamId)typeestekhdam 	   
							              ORDER BY t.fldId DESC


	if (@fieldname=N'fldNameEmployee')
SELECT    TOP (@h)  * FROM(SELECT    Prs.Prs_tblPersonalInfo.fldId, Prs.Prs_tblPersonalInfo.fldEmployeeId, Com.tblEmployee_Detail.fldSh_Shenasname, 
                      Com.tblEmployee_Detail.fldTarikhTavalod, Com.tblEmployee_Detail.fldMahalTavalodId, Com.tblEmployee_Detail.fldMahalSodoorId, 
                      ISNULL(Com.tblEmployee_Detail.fldAddress,'')AS fldAddress, ISNULL(Com.tblEmployee_Detail.fldCodePosti,'') AS fldCodePosti, Prs.Prs_tblPersonalInfo.fldEsargariId, Prs.Prs_tblPersonalInfo.fldSharhEsargari, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali, Com.tblEmployee_Detail.fldMadrakId, Com.tblEmployee_Detail.fldReshteId, Com.tblEmployee_Detail.fldNezamVazifeId, 
                      Prs.Prs_tblPersonalInfo.fldOrganPostId, Prs.Prs_tblPersonalInfo.fldRasteShoghli, Prs.Prs_tblPersonalInfo.fldReshteShoghli, 
                      Prs.Prs_tblPersonalInfo.fldTarikhEstekhdam, tblOrganizationalPosts.fldChartOrganId, Prs.Prs_tblPersonalInfo.fldTabaghe, Com.tblEmployee_Detail.fldMeliyat, 
                      Prs.Prs_tblPersonalInfo.fldSh_MojavezEstekhdam, Prs.Prs_tblPersonalInfo.fldTarikhMajavezEstekhdam, Prs.Prs_tblPersonalInfo.fldUserId, 
                      Prs.Prs_tblPersonalInfo.fldDesc, Prs.Prs_tblPersonalInfo.fldDate, CASE WHEN fldMeliyat = 0 THEN N'غیر ایرانی' ELSE N'ایرانی' END AS fldMeliyatName, 
                      Com.tblMadrakTahsili.fldTitle AS fldMadrakTahsiliTitle, Prs.tblVaziyatEsargari.fldTitle AS fldVaziyatEsargariTitle, ISNULL(Com.tblNezamVazife.fldTitle ,'') AS fldNezamVazifeTitle, 
                      Com.tblEmployee.fldName + '_' + Com.tblEmployee.fldFamily AS fldNameEmployee, Com.tblEmployee.fldName, Com.tblEmployee.fldFamily, 
                      Com.tblEmployee_Detail.fldFatherName, Com.tblEmployee_Detail.fldJensiyat, tblChartOrgan.fldTitle AS fldTitleChartOrgan, 
                      (SELECT Com.fn_stringDecode(tblOrganization.fldName) FROM Com.tblOrganization WHERE fldid = [Com].[fn_OrganName] (fldOrganPostId)) AS fldNameOrgan, Com.tblCity.fldName AS fldNameMahalTavalod, tblCity_1.fldName AS fldNameMahlSodoor, 
                      Com.tblEmployee.fldCodemeli, Com.tblEmployee_Detail.fldFileId, CASE WHEN fldJensiyat = 0 THEN N'زن' ELSE N'مرد' END AS fldNameJensiyat, 
                      tblOrganizationalPosts.fldTitle+'_'+tblOrganizationalPosts.fldOrgPostCode AS NamePostOran, Com.tblReshteTahsili.fldTitle AS fldReshteTahsiliTitle, 
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
                      Com.tblMadrakTahsili ON Com.tblEmployee_Detail.fldMadrakId = Com.tblMadrakTahsili.fldId INNER JOIN
                      Com.tblReshteTahsili ON Com.tblEmployee_Detail.fldReshteId = Com.tblReshteTahsili.fldId INNER JOIN
                      Com.tblCity ON Com.tblEmployee_Detail.fldMahalTavalodId = Com.tblCity.fldId INNER JOIN
                      Com.tblCity AS tblCity_1 ON Com.tblEmployee_Detail.fldMahalSodoorId = tblCity_1.fldId INNER JOIN
                      Prs.tblVaziyatEsargari ON Prs.Prs_tblPersonalInfo.fldEsargariId = Prs.tblVaziyatEsargari.fldId INNER JOIN
                      Com.tblOrganizationalPosts ON Prs.Prs_tblPersonalInfo.fldOrganPostId = Com.tblOrganizationalPosts.fldId INNER JOIN
                      Com.tblChartOrgan ON Com.tblOrganizationalPosts.fldChartOrganId = Com.tblChartOrgan.fldId LEFT OUTER JOIN
						Com.tblNezamVazife ON Com.tblEmployee_Detail.fldNezamVazifeId = Com.tblNezamVazife.fldId   LEFT outer JOIN
					  com.tblOrganizationalPostsEjraee ON Prs.Prs_tblPersonalInfo.fldOrganPostEjraeeId=com.tblOrganizationalPostsEjraee.fldId LEFT outer JOIN
					  com.tblChartOrganEjraee ON com.tblOrganizationalPostsEjraee.fldChartOrganId =	com.tblChartOrganEjraee.fldid

  )temp
   cross apply ( select t.fldTypeEstekhamId from com.tblUser_Group u
											inner join pay.tblTypeEstekhdam_UserGroup t on t.fldUseGroupId=u.fldUserGroupId
											where fldUserSelectId=@userId and t.fldTypeEstekhamId=fldNoeEstekhdam
											group by  t.fldTypeEstekhamId)typeestekhdam 
                       	WHERE temp.fldName LIKE @Value and  com.fn_organId(fldid)=@OrganId
                       	        ORDER BY fldId DESC


if (@fieldname=N'fldCodemeli')
SELECT    top(@h)* from (select  Prs.Prs_tblPersonalInfo.fldId, Prs.Prs_tblPersonalInfo.fldEmployeeId, Com.tblEmployee_Detail.fldSh_Shenasname, 
                      Com.tblEmployee_Detail.fldTarikhTavalod, Com.tblEmployee_Detail.fldMahalTavalodId, Com.tblEmployee_Detail.fldMahalSodoorId, 
                      ISNULL(Com.tblEmployee_Detail.fldAddress,'')AS fldAddress, ISNULL(Com.tblEmployee_Detail.fldCodePosti,'') AS fldCodePosti, Prs.Prs_tblPersonalInfo.fldEsargariId, Prs.Prs_tblPersonalInfo.fldSharhEsargari, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali, Com.tblEmployee_Detail.fldMadrakId, Com.tblEmployee_Detail.fldReshteId, Com.tblEmployee_Detail.fldNezamVazifeId, 
                      Prs.Prs_tblPersonalInfo.fldOrganPostId, Prs.Prs_tblPersonalInfo.fldRasteShoghli, Prs.Prs_tblPersonalInfo.fldReshteShoghli, 
                      Prs.Prs_tblPersonalInfo.fldTarikhEstekhdam, tblOrganizationalPosts.fldChartOrganId, Prs.Prs_tblPersonalInfo.fldTabaghe, Com.tblEmployee_Detail.fldMeliyat, 
                      Prs.Prs_tblPersonalInfo.fldSh_MojavezEstekhdam, Prs.Prs_tblPersonalInfo.fldTarikhMajavezEstekhdam, Prs.Prs_tblPersonalInfo.fldUserId, 
                      Prs.Prs_tblPersonalInfo.fldDesc, Prs.Prs_tblPersonalInfo.fldDate, CASE WHEN fldMeliyat = 0 THEN N'غیر ایرانی' ELSE N'ایرانی' END AS fldMeliyatName, 
                      Com.tblMadrakTahsili.fldTitle AS fldMadrakTahsiliTitle, Prs.tblVaziyatEsargari.fldTitle AS fldVaziyatEsargariTitle, ISNULL(Com.tblNezamVazife.fldTitle ,'') AS fldNezamVazifeTitle, 
                      Com.tblEmployee.fldName + '_' + Com.tblEmployee.fldFamily AS fldNameEmployee, Com.tblEmployee.fldName, Com.tblEmployee.fldFamily, 
                      Com.tblEmployee_Detail.fldFatherName, Com.tblEmployee_Detail.fldJensiyat, tblChartOrgan.fldTitle AS fldTitleChartOrgan, 
                      (SELECT Com.fn_stringDecode(tblOrganization.fldName) FROM Com.tblOrganization WHERE fldid = [Com].[fn_OrganName] (fldOrganPostId)) AS fldNameOrgan, Com.tblCity.fldName AS fldNameMahalTavalod, tblCity_1.fldName AS fldNameMahlSodoor, 
                      Com.tblEmployee.fldCodemeli, Com.tblEmployee_Detail.fldFileId, CASE WHEN fldJensiyat = 0 THEN N'زن' ELSE N'مرد' END AS fldNameJensiyat, 
                      tblOrganizationalPosts.fldTitle+'_'+tblOrganizationalPosts.fldOrgPostCode AS NamePostOran, Com.tblReshteTahsili.fldTitle AS fldReshteTahsiliTitle, 
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
                      Com.tblMadrakTahsili ON Com.tblEmployee_Detail.fldMadrakId = Com.tblMadrakTahsili.fldId INNER JOIN
                      Com.tblReshteTahsili ON Com.tblEmployee_Detail.fldReshteId = Com.tblReshteTahsili.fldId INNER JOIN
                      Com.tblCity ON Com.tblEmployee_Detail.fldMahalTavalodId = Com.tblCity.fldId INNER JOIN
                      Com.tblCity AS tblCity_1 ON Com.tblEmployee_Detail.fldMahalSodoorId = tblCity_1.fldId INNER JOIN
                      Prs.tblVaziyatEsargari ON Prs.Prs_tblPersonalInfo.fldEsargariId = Prs.tblVaziyatEsargari.fldId INNER JOIN
                      Com.tblOrganizationalPosts ON Prs.Prs_tblPersonalInfo.fldOrganPostId = Com.tblOrganizationalPosts.fldId INNER JOIN
                      Com.tblChartOrgan ON Com.tblOrganizationalPosts.fldChartOrganId = Com.tblChartOrgan.fldId LEFT OUTER JOIN
						Com.tblNezamVazife ON Com.tblEmployee_Detail.fldNezamVazifeId = Com.tblNezamVazife.fldId   LEFT outer JOIN
					  com.tblOrganizationalPostsEjraee ON Prs.Prs_tblPersonalInfo.fldOrganPostEjraeeId=com.tblOrganizationalPostsEjraee.fldId LEFT outer JOIN
					  com.tblChartOrganEjraee ON com.tblOrganizationalPostsEjraee.fldChartOrganId =	com.tblChartOrganEjraee.fldid
                             WHERE fldCodemeli like @Value 
                            )t 
							 cross apply ( select t.fldTypeEstekhamId from com.tblUser_Group u
											inner join pay.tblTypeEstekhdam_UserGroup t on t.fldUseGroupId=u.fldUserGroupId
											where fldUserSelectId=@userId and t.fldTypeEstekhamId=fldNoeEstekhdam
											group by  t.fldTypeEstekhamId)typeestekhdam 
							        ORDER BY t.fldId DESC


if (@fieldname=N'fldFamilyEmployee')
SELECT     TOP (@h)* FROM (SELECT   Prs.Prs_tblPersonalInfo.fldId, Prs.Prs_tblPersonalInfo.fldEmployeeId, Com.tblEmployee_Detail.fldSh_Shenasname, 
                      Com.tblEmployee_Detail.fldTarikhTavalod, Com.tblEmployee_Detail.fldMahalTavalodId, Com.tblEmployee_Detail.fldMahalSodoorId, 
                      ISNULL(Com.tblEmployee_Detail.fldAddress,'')AS fldAddress, ISNULL(Com.tblEmployee_Detail.fldCodePosti,'') AS fldCodePosti, Prs.Prs_tblPersonalInfo.fldEsargariId, Prs.Prs_tblPersonalInfo.fldSharhEsargari, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali, Com.tblEmployee_Detail.fldMadrakId, Com.tblEmployee_Detail.fldReshteId, Com.tblEmployee_Detail.fldNezamVazifeId, 
                      Prs.Prs_tblPersonalInfo.fldOrganPostId, Prs.Prs_tblPersonalInfo.fldRasteShoghli, Prs.Prs_tblPersonalInfo.fldReshteShoghli, 
                      Prs.Prs_tblPersonalInfo.fldTarikhEstekhdam, tblOrganizationalPosts.fldChartOrganId, Prs.Prs_tblPersonalInfo.fldTabaghe, Com.tblEmployee_Detail.fldMeliyat, 
                      Prs.Prs_tblPersonalInfo.fldSh_MojavezEstekhdam, Prs.Prs_tblPersonalInfo.fldTarikhMajavezEstekhdam, Prs.Prs_tblPersonalInfo.fldUserId, 
                      Prs.Prs_tblPersonalInfo.fldDesc, Prs.Prs_tblPersonalInfo.fldDate, CASE WHEN fldMeliyat = 0 THEN N'غیر ایرانی' ELSE N'ایرانی' END AS fldMeliyatName, 
                      Com.tblMadrakTahsili.fldTitle AS fldMadrakTahsiliTitle, Prs.tblVaziyatEsargari.fldTitle AS fldVaziyatEsargariTitle, ISNULL(Com.tblNezamVazife.fldTitle ,'') AS fldNezamVazifeTitle, 
                      Com.tblEmployee.fldName + '_' + Com.tblEmployee.fldFamily AS fldNameEmployee, Com.tblEmployee.fldName, Com.tblEmployee.fldFamily, 
                      Com.tblEmployee_Detail.fldFatherName, Com.tblEmployee_Detail.fldJensiyat, tblChartOrgan.fldTitle AS fldTitleChartOrgan, 
                      (SELECT Com.fn_stringDecode(tblOrganization.fldName) FROM Com.tblOrganization WHERE fldid = [Com].[fn_OrganName] (fldOrganPostId)) AS fldNameOrgan, Com.tblCity.fldName AS fldNameMahalTavalod, tblCity_1.fldName AS fldNameMahlSodoor, 
                      Com.tblEmployee.fldCodemeli, Com.tblEmployee_Detail.fldFileId, CASE WHEN fldJensiyat = 0 THEN N'زن' ELSE N'مرد' END AS fldNameJensiyat, 
                      tblOrganizationalPosts.fldTitle+'_'+tblOrganizationalPosts.fldOrgPostCode AS NamePostOran, Com.tblReshteTahsili.fldTitle AS fldReshteTahsiliTitle, 
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
                      Com.tblMadrakTahsili ON Com.tblEmployee_Detail.fldMadrakId = Com.tblMadrakTahsili.fldId INNER JOIN
                      Com.tblReshteTahsili ON Com.tblEmployee_Detail.fldReshteId = Com.tblReshteTahsili.fldId INNER JOIN
                      Com.tblCity ON Com.tblEmployee_Detail.fldMahalTavalodId = Com.tblCity.fldId INNER JOIN
                      Com.tblCity AS tblCity_1 ON Com.tblEmployee_Detail.fldMahalSodoorId = tblCity_1.fldId INNER JOIN
                      Prs.tblVaziyatEsargari ON Prs.Prs_tblPersonalInfo.fldEsargariId = Prs.tblVaziyatEsargari.fldId INNER JOIN
                      Com.tblOrganizationalPosts ON Prs.Prs_tblPersonalInfo.fldOrganPostId = Com.tblOrganizationalPosts.fldId INNER JOIN
                      Com.tblChartOrgan ON Com.tblOrganizationalPosts.fldChartOrganId = Com.tblChartOrgan.fldId LEFT OUTER JOIN
						Com.tblNezamVazife ON Com.tblEmployee_Detail.fldNezamVazifeId = Com.tblNezamVazife.fldId   LEFT outer JOIN
					  com.tblOrganizationalPostsEjraee ON Prs.Prs_tblPersonalInfo.fldOrganPostEjraeeId=com.tblOrganizationalPostsEjraee.fldId LEFT outer JOIN
					  com.tblChartOrganEjraee ON com.tblOrganizationalPostsEjraee.fldChartOrganId =	com.tblChartOrganEjraee.fldid

 )t
  cross apply ( select t.fldTypeEstekhamId from com.tblUser_Group u
											inner join pay.tblTypeEstekhdam_UserGroup t on t.fldUseGroupId=u.fldUserGroupId
											where fldUserSelectId=@userId and t.fldTypeEstekhamId=fldNoeEstekhdam
											group by  t.fldTypeEstekhamId)typeestekhdam 
                      WHERE fldFamily LIKE @Value and  com.fn_organId(fldid)=@OrganId
                                  ORDER BY t.fldId DESC




if (@fieldname=N'')
SELECT    top(@h)* from (select  Prs.Prs_tblPersonalInfo.fldId, Prs.Prs_tblPersonalInfo.fldEmployeeId, Com.tblEmployee_Detail.fldSh_Shenasname, 
                      Com.tblEmployee_Detail.fldTarikhTavalod, Com.tblEmployee_Detail.fldMahalTavalodId, Com.tblEmployee_Detail.fldMahalSodoorId, 
                      ISNULL(Com.tblEmployee_Detail.fldAddress,'')AS fldAddress, ISNULL(Com.tblEmployee_Detail.fldCodePosti,'') AS fldCodePosti, Prs.Prs_tblPersonalInfo.fldEsargariId, Prs.Prs_tblPersonalInfo.fldSharhEsargari, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali, Com.tblEmployee_Detail.fldMadrakId, Com.tblEmployee_Detail.fldReshteId, Com.tblEmployee_Detail.fldNezamVazifeId, 
                      Prs.Prs_tblPersonalInfo.fldOrganPostId, Prs.Prs_tblPersonalInfo.fldRasteShoghli, Prs.Prs_tblPersonalInfo.fldReshteShoghli, 
                      Prs.Prs_tblPersonalInfo.fldTarikhEstekhdam, tblOrganizationalPosts.fldChartOrganId, Prs.Prs_tblPersonalInfo.fldTabaghe, Com.tblEmployee_Detail.fldMeliyat, 
                      Prs.Prs_tblPersonalInfo.fldSh_MojavezEstekhdam, Prs.Prs_tblPersonalInfo.fldTarikhMajavezEstekhdam, Prs.Prs_tblPersonalInfo.fldUserId, 
                      Prs.Prs_tblPersonalInfo.fldDesc, Prs.Prs_tblPersonalInfo.fldDate, CASE WHEN fldMeliyat = 0 THEN N'غیر ایرانی' ELSE N'ایرانی' END AS fldMeliyatName, 
                      Com.tblMadrakTahsili.fldTitle AS fldMadrakTahsiliTitle, Prs.tblVaziyatEsargari.fldTitle AS fldVaziyatEsargariTitle, ISNULL(Com.tblNezamVazife.fldTitle ,'') AS fldNezamVazifeTitle, 
                      Com.tblEmployee.fldName + '_' + Com.tblEmployee.fldFamily AS fldNameEmployee, Com.tblEmployee.fldName, Com.tblEmployee.fldFamily, 
                      Com.tblEmployee_Detail.fldFatherName, Com.tblEmployee_Detail.fldJensiyat, tblChartOrgan.fldTitle AS fldTitleChartOrgan, 
                      (SELECT Com.fn_stringDecode(tblOrganization.fldName) FROM Com.tblOrganization WHERE fldid = [Com].[fn_OrganName] (fldOrganPostId)) AS fldNameOrgan, Com.tblCity.fldName AS fldNameMahalTavalod, tblCity_1.fldName AS fldNameMahlSodoor, 
                      Com.tblEmployee.fldCodemeli, Com.tblEmployee_Detail.fldFileId, CASE WHEN fldJensiyat = 0 THEN N'زن' ELSE N'مرد' END AS fldNameJensiyat, 
                      tblOrganizationalPosts.fldTitle+'_'+tblOrganizationalPosts.fldOrgPostCode AS NamePostOran, Com.tblReshteTahsili.fldTitle AS fldReshteTahsiliTitle, 
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
                      Com.tblMadrakTahsili ON Com.tblEmployee_Detail.fldMadrakId = Com.tblMadrakTahsili.fldId INNER JOIN
                      Com.tblReshteTahsili ON Com.tblEmployee_Detail.fldReshteId = Com.tblReshteTahsili.fldId INNER JOIN
                      Com.tblCity ON Com.tblEmployee_Detail.fldMahalTavalodId = Com.tblCity.fldId INNER JOIN
                      Com.tblCity AS tblCity_1 ON Com.tblEmployee_Detail.fldMahalSodoorId = tblCity_1.fldId INNER JOIN
                      Prs.tblVaziyatEsargari ON Prs.Prs_tblPersonalInfo.fldEsargariId = Prs.tblVaziyatEsargari.fldId INNER JOIN
                      Com.tblOrganizationalPosts ON Prs.Prs_tblPersonalInfo.fldOrganPostId = Com.tblOrganizationalPosts.fldId INNER JOIN
                      Com.tblChartOrgan ON Com.tblOrganizationalPosts.fldChartOrganId = Com.tblChartOrgan.fldId LEFT OUTER JOIN
						Com.tblNezamVazife ON Com.tblEmployee_Detail.fldNezamVazifeId = Com.tblNezamVazife.fldId   LEFT outer JOIN
					  com.tblOrganizationalPostsEjraee ON Prs.Prs_tblPersonalInfo.fldOrganPostEjraeeId=com.tblOrganizationalPostsEjraee.fldId LEFT outer JOIN
					  com.tblChartOrganEjraee ON com.tblOrganizationalPostsEjraee.fldChartOrganId =	com.tblChartOrganEjraee.fldid
                       WHERE   com.fn_organId(Prs_tblPersonalInfo.fldid)=@OrganId)y
					    cross apply ( select t.fldTypeEstekhamId from com.tblUser_Group u
											inner join pay.tblTypeEstekhdam_UserGroup t on t.fldUseGroupId=u.fldUserGroupId
											where fldUserSelectId=@userId and t.fldTypeEstekhamId=fldNoeEstekhdam
											group by  t.fldTypeEstekhamId)typeestekhdam 
                                ORDER BY fldId DESC

                       	COMMIT TRAN
GO
