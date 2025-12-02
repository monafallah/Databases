SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Prs].[spr_tblHistoryNoeEstekhdamSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@OrganId INT,
	@h int
AS 
	BEGIN TRAN
	if (@h=0) set @h=2147483647
	SET @Value=Com.fn_TextNormalize(@Value)
	if (@fieldname=N'fldId')
	SELECT     TOP (@h) tblHistoryNoeEstekhdam.fldId, tblHistoryNoeEstekhdam.fldNoeEstekhdamId, tblHistoryNoeEstekhdam.fldPrsPersonalInfoId, 
                      tblHistoryNoeEstekhdam.fldTarikh, tblHistoryNoeEstekhdam.fldUserId, tblHistoryNoeEstekhdam.fldDesc, tblHistoryNoeEstekhdam.fldDate, 
                      Com.tblAnvaEstekhdam.fldTitle AS fldNoeEstekhdamTitle,Com.fn_FamilyEmployee(fldEmployeeId) AS fldNameEmployee
FROM         tblHistoryNoeEstekhdam INNER JOIN
                       Com.tblAnvaEstekhdam ON tblHistoryNoeEstekhdam.fldNoeEstekhdamId =  Com.tblAnvaEstekhdam.fldId INNER JOIN
                      Prs_tblPersonalInfo ON tblHistoryNoeEstekhdam.fldPrsPersonalInfoId = Prs_tblPersonalInfo.fldId
                      INNER JOIN Com.tblEmployee ON Prs_tblPersonalInfo.fldEmployeeId=Com.tblEmployee .fldId
	WHERE  tblHistoryNoeEstekhdam.fldId = @Value AND Com.fn_OrganId(fldPrsPersonalInfoId ) =@OrganId
	
	if (@fieldname=N'fldDesc')
	SELECT     TOP (@h) tblHistoryNoeEstekhdam.fldId, tblHistoryNoeEstekhdam.fldNoeEstekhdamId, tblHistoryNoeEstekhdam.fldPrsPersonalInfoId, 
                      tblHistoryNoeEstekhdam.fldTarikh, tblHistoryNoeEstekhdam.fldUserId, tblHistoryNoeEstekhdam.fldDesc, tblHistoryNoeEstekhdam.fldDate, 
                      Com.tblAnvaEstekhdam.fldTitle AS fldNoeEstekhdamTitle,Com.fn_FamilyEmployee(fldEmployeeId) AS fldNameEmployee
FROM         tblHistoryNoeEstekhdam INNER JOIN
                       Com.tblAnvaEstekhdam ON tblHistoryNoeEstekhdam.fldNoeEstekhdamId =  Com.tblAnvaEstekhdam.fldId INNER JOIN
                      Prs_tblPersonalInfo ON tblHistoryNoeEstekhdam.fldPrsPersonalInfoId = Prs_tblPersonalInfo.fldId
                      INNER JOIN Com.tblEmployee ON Prs_tblPersonalInfo.fldEmployeeId=Com.tblEmployee .fldId
	WHERE  tblHistoryNoeEstekhdam.fldDesc LIKE @Value


		if (@fieldname=N'fldNoeEstekhdamTitle')
	SELECT     TOP (@h) tblHistoryNoeEstekhdam.fldId, tblHistoryNoeEstekhdam.fldNoeEstekhdamId, tblHistoryNoeEstekhdam.fldPrsPersonalInfoId, 
                      tblHistoryNoeEstekhdam.fldTarikh, tblHistoryNoeEstekhdam.fldUserId, tblHistoryNoeEstekhdam.fldDesc, tblHistoryNoeEstekhdam.fldDate, 
                       Com.tblAnvaEstekhdam.fldTitle AS fldNoeEstekhdamTitle,Com.fn_FamilyEmployee(fldEmployeeId) AS fldNameEmployee
FROM         tblHistoryNoeEstekhdam INNER JOIN
                       Com.tblAnvaEstekhdam ON tblHistoryNoeEstekhdam.fldNoeEstekhdamId =  Com.tblAnvaEstekhdam.fldId INNER JOIN
                      Prs_tblPersonalInfo ON tblHistoryNoeEstekhdam.fldPrsPersonalInfoId = Prs_tblPersonalInfo.fldId
                      INNER JOIN Com.tblEmployee ON Prs_tblPersonalInfo.fldEmployeeId=Com.tblEmployee .fldId
	WHERE    Com.tblAnvaEstekhdam.fldTitle  LIKE @Value AND Com.fn_OrganId(fldPrsPersonalInfoId ) =@OrganId
	
	if (@fieldname=N'fldNoeEstekhdamTitleP')
	SELECT     TOP (@h) tblHistoryNoeEstekhdam.fldId, tblHistoryNoeEstekhdam.fldNoeEstekhdamId, tblHistoryNoeEstekhdam.fldPrsPersonalInfoId, 
                      tblHistoryNoeEstekhdam.fldTarikh, tblHistoryNoeEstekhdam.fldUserId, tblHistoryNoeEstekhdam.fldDesc, tblHistoryNoeEstekhdam.fldDate, 
                       Com.tblAnvaEstekhdam.fldTitle AS fldNoeEstekhdamTitle,Com.fn_FamilyEmployee(fldEmployeeId) AS fldNameEmployee
FROM         tblHistoryNoeEstekhdam INNER JOIN
                       Com.tblAnvaEstekhdam ON tblHistoryNoeEstekhdam.fldNoeEstekhdamId =  Com.tblAnvaEstekhdam.fldId INNER JOIN
                      Prs_tblPersonalInfo ON tblHistoryNoeEstekhdam.fldPrsPersonalInfoId = Prs_tblPersonalInfo.fldId
                      INNER JOIN Com.tblEmployee ON Prs_tblPersonalInfo.fldEmployeeId=Com.tblEmployee .fldId
	WHERE    Com.tblAnvaEstekhdam.fldTitle  LIKE @Value AND  tblHistoryNoeEstekhdam.fldPrsPersonalInfoId=@OrganId

	if (@fieldname=N'fldTarikhP')
	SELECT     TOP (@h) tblHistoryNoeEstekhdam.fldId, tblHistoryNoeEstekhdam.fldNoeEstekhdamId, tblHistoryNoeEstekhdam.fldPrsPersonalInfoId, 
                      tblHistoryNoeEstekhdam.fldTarikh, tblHistoryNoeEstekhdam.fldUserId, tblHistoryNoeEstekhdam.fldDesc, tblHistoryNoeEstekhdam.fldDate, 
                       Com.tblAnvaEstekhdam.fldTitle AS fldNoeEstekhdamTitle,Com.fn_FamilyEmployee(fldEmployeeId) AS fldNameEmployee
FROM         tblHistoryNoeEstekhdam INNER JOIN
                       Com.tblAnvaEstekhdam ON tblHistoryNoeEstekhdam.fldNoeEstekhdamId =  Com.tblAnvaEstekhdam.fldId INNER JOIN
                      Prs_tblPersonalInfo ON tblHistoryNoeEstekhdam.fldPrsPersonalInfoId = Prs_tblPersonalInfo.fldId
                      INNER JOIN Com.tblEmployee ON Prs_tblPersonalInfo.fldEmployeeId=Com.tblEmployee .fldId
	WHERE    tblHistoryNoeEstekhdam.fldTarikh  LIKE @Value AND tblHistoryNoeEstekhdam.fldPrsPersonalInfoId =@OrganId

	if (@fieldname=N'CheckTarikhTasvie')
	SELECT     TOP (@h) tblHistoryNoeEstekhdam.fldId, tblHistoryNoeEstekhdam.fldNoeEstekhdamId, tblHistoryNoeEstekhdam.fldPrsPersonalInfoId, 
                      tblHistoryNoeEstekhdam.fldTarikh, tblHistoryNoeEstekhdam.fldUserId, tblHistoryNoeEstekhdam.fldDesc, tblHistoryNoeEstekhdam.fldDate, 
                       Com.tblAnvaEstekhdam.fldTitle AS fldNoeEstekhdamTitle,Com.fn_FamilyEmployee(fldEmployeeId) AS fldNameEmployee
FROM         tblHistoryNoeEstekhdam INNER JOIN
                       Com.tblAnvaEstekhdam ON tblHistoryNoeEstekhdam.fldNoeEstekhdamId =  Com.tblAnvaEstekhdam.fldId INNER JOIN
                      Prs_tblPersonalInfo ON tblHistoryNoeEstekhdam.fldPrsPersonalInfoId = Prs_tblPersonalInfo.fldId
                      INNER JOIN Com.tblEmployee ON Prs_tblPersonalInfo.fldEmployeeId=Com.tblEmployee .fldId
	WHERE    tblHistoryNoeEstekhdam.fldTarikh >= @Value AND tblHistoryNoeEstekhdam.fldPrsPersonalInfoId =@OrganId

	if (@fieldname=N'fldNameEmployee')
	SELECT     TOP (@h)*FROM(SELECT tblHistoryNoeEstekhdam.fldId, tblHistoryNoeEstekhdam.fldNoeEstekhdamId, tblHistoryNoeEstekhdam.fldPrsPersonalInfoId, 
                      tblHistoryNoeEstekhdam.fldTarikh, tblHistoryNoeEstekhdam.fldUserId, tblHistoryNoeEstekhdam.fldDesc, tblHistoryNoeEstekhdam.fldDate, 
                       Com.tblAnvaEstekhdam.fldTitle AS fldNoeEstekhdamTitle,Com.fn_FamilyEmployee(fldEmployeeId) AS fldNameEmployee
FROM         tblHistoryNoeEstekhdam INNER JOIN
                       Com.tblAnvaEstekhdam ON tblHistoryNoeEstekhdam.fldNoeEstekhdamId =  Com.tblAnvaEstekhdam.fldId INNER JOIN
                      Prs_tblPersonalInfo ON tblHistoryNoeEstekhdam.fldPrsPersonalInfoId = Prs_tblPersonalInfo.fldId
                      INNER JOIN Com.tblEmployee ON Prs_tblPersonalInfo.fldEmployeeId=Com.tblEmployee .fldId) temp
	WHERE  temp.fldNameEmployee LIKE @Value AND Com.fn_OrganId(fldPrsPersonalInfoId ) =@OrganId
	
if (@fieldname=N'CheckPrsPersonalInfoId')
	SELECT     TOP (@h) tblHistoryNoeEstekhdam.fldId, tblHistoryNoeEstekhdam.fldNoeEstekhdamId, tblHistoryNoeEstekhdam.fldPrsPersonalInfoId, 
                      tblHistoryNoeEstekhdam.fldTarikh, tblHistoryNoeEstekhdam.fldUserId, tblHistoryNoeEstekhdam.fldDesc, tblHistoryNoeEstekhdam.fldDate, 
                       Com.tblAnvaEstekhdam.fldTitle AS fldNoeEstekhdamTitle,Com.fn_FamilyEmployee(fldEmployeeId) AS fldNameEmployee
FROM         tblHistoryNoeEstekhdam INNER JOIN
                       Com.tblAnvaEstekhdam ON tblHistoryNoeEstekhdam.fldNoeEstekhdamId =  Com.tblAnvaEstekhdam.fldId INNER JOIN
                      Prs_tblPersonalInfo ON tblHistoryNoeEstekhdam.fldPrsPersonalInfoId = Prs_tblPersonalInfo.fldId
                      INNER JOIN Com.tblEmployee ON Prs_tblPersonalInfo.fldEmployeeId=Com.tblEmployee .fldId
	WHERE  fldPrsPersonalInfoId = @OrganId and tblHistoryNoeEstekhdam.fldTarikh>=@Value
	
	union all
	select * from	(SELECT     TOP (1) tblHistoryNoeEstekhdam.fldId, tblHistoryNoeEstekhdam.fldNoeEstekhdamId, tblHistoryNoeEstekhdam.fldPrsPersonalInfoId, 
                      tblHistoryNoeEstekhdam.fldTarikh, tblHistoryNoeEstekhdam.fldUserId, tblHistoryNoeEstekhdam.fldDesc, tblHistoryNoeEstekhdam.fldDate, 
                       Com.tblAnvaEstekhdam.fldTitle AS fldNoeEstekhdamTitle,Com.fn_FamilyEmployee(fldEmployeeId) AS fldNameEmployee
FROM         tblHistoryNoeEstekhdam INNER JOIN
                       Com.tblAnvaEstekhdam ON tblHistoryNoeEstekhdam.fldNoeEstekhdamId =  Com.tblAnvaEstekhdam.fldId INNER JOIN
                      Prs_tblPersonalInfo ON tblHistoryNoeEstekhdam.fldPrsPersonalInfoId = Prs_tblPersonalInfo.fldId
                      INNER JOIN Com.tblEmployee ON Prs_tblPersonalInfo.fldEmployeeId=Com.tblEmployee .fldId
	WHERE  fldPrsPersonalInfoId = @OrganId 
	
	order by tblHistoryNoeEstekhdam.fldTarikh desc,tblHistoryNoeEstekhdam.fldDate DESC)t

	if (@fieldname=N'CheckPrsPersonalInfoId_Tarikh')
	SELECT     TOP (@h) tblHistoryNoeEstekhdam.fldId, tblHistoryNoeEstekhdam.fldNoeEstekhdamId, tblHistoryNoeEstekhdam.fldPrsPersonalInfoId, 
                      tblHistoryNoeEstekhdam.fldTarikh, tblHistoryNoeEstekhdam.fldUserId, tblHistoryNoeEstekhdam.fldDesc, tblHistoryNoeEstekhdam.fldDate, 
                       Com.tblAnvaEstekhdam.fldTitle AS fldNoeEstekhdamTitle,Com.fn_FamilyEmployee(fldEmployeeId) AS fldNameEmployee
FROM         tblHistoryNoeEstekhdam INNER JOIN
                       Com.tblAnvaEstekhdam ON tblHistoryNoeEstekhdam.fldNoeEstekhdamId =  Com.tblAnvaEstekhdam.fldId INNER JOIN
                      Prs_tblPersonalInfo ON tblHistoryNoeEstekhdam.fldPrsPersonalInfoId = Prs_tblPersonalInfo.fldId
                      INNER JOIN Com.tblEmployee ON Prs_tblPersonalInfo.fldEmployeeId=Com.tblEmployee .fldId
	WHERE  fldPrsPersonalInfoId = @OrganId and tblHistoryNoeEstekhdam.fldTarikh=@Value

	if (@fieldname=N'fldPrsPersonalInfoId')
	SELECT     TOP (@h) tblHistoryNoeEstekhdam.fldId, tblHistoryNoeEstekhdam.fldNoeEstekhdamId, tblHistoryNoeEstekhdam.fldPrsPersonalInfoId, 
                      tblHistoryNoeEstekhdam.fldTarikh, tblHistoryNoeEstekhdam.fldUserId, tblHistoryNoeEstekhdam.fldDesc, tblHistoryNoeEstekhdam.fldDate, 
                       Com.tblAnvaEstekhdam.fldTitle AS fldNoeEstekhdamTitle,Com.fn_FamilyEmployee(fldEmployeeId) AS fldNameEmployee
FROM         tblHistoryNoeEstekhdam INNER JOIN
                       Com.tblAnvaEstekhdam ON tblHistoryNoeEstekhdam.fldNoeEstekhdamId =  Com.tblAnvaEstekhdam.fldId INNER JOIN
                      Prs_tblPersonalInfo ON tblHistoryNoeEstekhdam.fldPrsPersonalInfoId = Prs_tblPersonalInfo.fldId
                      INNER JOIN Com.tblEmployee ON Prs_tblPersonalInfo.fldEmployeeId=Com.tblEmployee .fldId
	WHERE  fldPrsPersonalInfoId = @Value AND Com.fn_OrganId(fldPrsPersonalInfoId ) =@OrganId
	union all
	SELECT     TOP (@h) tblTasviehHesab.fldId, 0 fldNoeEstekhdamId, tblTasviehHesab.fldPrsPersonalInfoId, 
                      tblTasviehHesab.fldTarikh, tblTasviehHesab.fldUserId, tblTasviehHesab.fldDesc, tblTasviehHesab.fldDate, 
                      N'تسویه شده' AS fldNoeEstekhdamTitle,Com.fn_FamilyEmployee(fldEmployeeId) AS fldNameEmployee
FROM         tblTasviehHesab INNER JOIN
                      Prs_tblPersonalInfo ON tblTasviehHesab.fldPrsPersonalInfoId = Prs_tblPersonalInfo.fldId
                      INNER JOIN Com.tblEmployee ON Prs_tblPersonalInfo.fldEmployeeId=Com.tblEmployee .fldId
WHERE  fldPrsPersonalInfoId = @Value AND Com.fn_OrganId(fldPrsPersonalInfoId ) =@OrganId
order by fldTarikh

		if (@fieldname=N'CheckNoeEstekhdamId')
	SELECT     TOP (@h) tblHistoryNoeEstekhdam.fldId, tblHistoryNoeEstekhdam.fldNoeEstekhdamId, tblHistoryNoeEstekhdam.fldPrsPersonalInfoId, 
                      tblHistoryNoeEstekhdam.fldTarikh, tblHistoryNoeEstekhdam.fldUserId, tblHistoryNoeEstekhdam.fldDesc, tblHistoryNoeEstekhdam.fldDate, 
                       Com.tblAnvaEstekhdam.fldTitle AS fldNoeEstekhdamTitle,Com.fn_FamilyEmployee(fldEmployeeId) AS fldNameEmployee
FROM         tblHistoryNoeEstekhdam INNER JOIN
                       Com.tblAnvaEstekhdam ON tblHistoryNoeEstekhdam.fldNoeEstekhdamId =  Com.tblAnvaEstekhdam.fldId INNER JOIN
                      Prs_tblPersonalInfo ON tblHistoryNoeEstekhdam.fldPrsPersonalInfoId = Prs_tblPersonalInfo.fldId
                      INNER JOIN Com.tblEmployee ON Prs_tblPersonalInfo.fldEmployeeId=Com.tblEmployee .fldId
	WHERE  tblHistoryNoeEstekhdam.fldNoeEstekhdamId = @Value
	
	
	if (@fieldname=N'fldNoeEstekhdamId')
	SELECT     TOP (@h) tblHistoryNoeEstekhdam.fldId, tblHistoryNoeEstekhdam.fldNoeEstekhdamId, tblHistoryNoeEstekhdam.fldPrsPersonalInfoId, 
                      tblHistoryNoeEstekhdam.fldTarikh, tblHistoryNoeEstekhdam.fldUserId, tblHistoryNoeEstekhdam.fldDesc, tblHistoryNoeEstekhdam.fldDate, 
                       Com.tblAnvaEstekhdam.fldTitle AS fldNoeEstekhdamTitle,Com.fn_FamilyEmployee(fldEmployeeId) AS fldNameEmployee
FROM         tblHistoryNoeEstekhdam INNER JOIN
                       Com.tblAnvaEstekhdam ON tblHistoryNoeEstekhdam.fldNoeEstekhdamId =  Com.tblAnvaEstekhdam.fldId INNER JOIN
                      Prs_tblPersonalInfo ON tblHistoryNoeEstekhdam.fldPrsPersonalInfoId = Prs_tblPersonalInfo.fldId
                      INNER JOIN Com.tblEmployee ON Prs_tblPersonalInfo.fldEmployeeId=Com.tblEmployee .fldId
	WHERE  tblHistoryNoeEstekhdam.fldNoeEstekhdamId = @Value AND Com.fn_OrganId(fldPrsPersonalInfoId ) =@OrganId
	
	
	if (@fieldname=N'MaxTarikh')
	SELECT     TOP (1) tblHistoryNoeEstekhdam.fldId, tblHistoryNoeEstekhdam.fldNoeEstekhdamId, tblHistoryNoeEstekhdam.fldPrsPersonalInfoId, 
                      tblHistoryNoeEstekhdam.fldTarikh, tblHistoryNoeEstekhdam.fldUserId, tblHistoryNoeEstekhdam.fldDesc, tblHistoryNoeEstekhdam.fldDate, 
                       Com.tblAnvaEstekhdam.fldTitle AS fldNoeEstekhdamTitle,Com.fn_FamilyEmployee(fldEmployeeId) AS fldNameEmployee
FROM         tblHistoryNoeEstekhdam INNER JOIN
                       Com.tblAnvaEstekhdam ON tblHistoryNoeEstekhdam.fldNoeEstekhdamId =  Com.tblAnvaEstekhdam.fldId INNER JOIN
                      Prs_tblPersonalInfo ON tblHistoryNoeEstekhdam.fldPrsPersonalInfoId = Prs_tblPersonalInfo.fldId
                      INNER JOIN Com.tblEmployee ON Prs_tblPersonalInfo.fldEmployeeId=Com.tblEmployee .fldId
	where 	fldPrsPersonalInfoId=@Value
	order by fldTarikh desc

if (@fieldname=N'ALL')
	SELECT     TOP (@h) tblHistoryNoeEstekhdam.fldId, tblHistoryNoeEstekhdam.fldNoeEstekhdamId, tblHistoryNoeEstekhdam.fldPrsPersonalInfoId, 
                      tblHistoryNoeEstekhdam.fldTarikh, tblHistoryNoeEstekhdam.fldUserId, tblHistoryNoeEstekhdam.fldDesc, tblHistoryNoeEstekhdam.fldDate, 
                       Com.tblAnvaEstekhdam.fldTitle AS fldNoeEstekhdamTitle,Com.fn_FamilyEmployee(fldEmployeeId) AS fldNameEmployee
FROM         tblHistoryNoeEstekhdam INNER JOIN
                       Com.tblAnvaEstekhdam ON tblHistoryNoeEstekhdam.fldNoeEstekhdamId =  Com.tblAnvaEstekhdam.fldId INNER JOIN
                      Prs_tblPersonalInfo ON tblHistoryNoeEstekhdam.fldPrsPersonalInfoId = Prs_tblPersonalInfo.fldId
                      INNER JOIN Com.tblEmployee ON Prs_tblPersonalInfo.fldEmployeeId=Com.tblEmployee .fldId
 

	if (@fieldname=N'')
	SELECT     TOP (@h) tblHistoryNoeEstekhdam.fldId, tblHistoryNoeEstekhdam.fldNoeEstekhdamId, tblHistoryNoeEstekhdam.fldPrsPersonalInfoId, 
                      tblHistoryNoeEstekhdam.fldTarikh, tblHistoryNoeEstekhdam.fldUserId, tblHistoryNoeEstekhdam.fldDesc, tblHistoryNoeEstekhdam.fldDate, 
                       Com.tblAnvaEstekhdam.fldTitle AS fldNoeEstekhdamTitle,Com.fn_FamilyEmployee(fldEmployeeId) AS fldNameEmployee
FROM         tblHistoryNoeEstekhdam INNER JOIN
                       Com.tblAnvaEstekhdam ON tblHistoryNoeEstekhdam.fldNoeEstekhdamId =  Com.tblAnvaEstekhdam.fldId INNER JOIN
                      Prs_tblPersonalInfo ON tblHistoryNoeEstekhdam.fldPrsPersonalInfoId = Prs_tblPersonalInfo.fldId
                      INNER JOIN Com.tblEmployee ON Prs_tblPersonalInfo.fldEmployeeId=Com.tblEmployee .fldId
                      where Com.fn_OrganId(fldPrsPersonalInfoId ) =@OrganId
	union all
	SELECT     TOP (@h) tblTasviehHesab.fldId, 0 fldNoeEstekhdamId, tblTasviehHesab.fldPrsPersonalInfoId, 
                      tblTasviehHesab.fldTarikh, tblTasviehHesab.fldUserId, tblTasviehHesab.fldDesc, tblTasviehHesab.fldDate, 
                      N'تسویه شده' AS fldNoeEstekhdamTitle,Com.fn_FamilyEmployee(fldEmployeeId) AS fldNameEmployee
FROM         tblTasviehHesab INNER JOIN
                      Prs_tblPersonalInfo ON tblTasviehHesab.fldPrsPersonalInfoId = Prs_tblPersonalInfo.fldId
                      INNER JOIN Com.tblEmployee ON Prs_tblPersonalInfo.fldEmployeeId=Com.tblEmployee .fldId
					   where Com.fn_OrganId(fldPrsPersonalInfoId ) =@OrganId
						order by fldTarikh
	COMMIT
GO
