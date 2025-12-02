SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblOrganizationSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@UserId INT,
	@h int
AS 
	BEGIN TRAN
	if (@h=0) set @h=2147483647
	SET @Value=Com.fn_TextNormalize(@Value)
	if (@fieldname=N'fldId')
SELECT TOP (@h) Com.tblOrganization.fldId, Com.fn_stringDecode(Com.tblOrganization.fldName) AS fldName, Com.tblOrganization.fldPId, Com.tblOrganization.fldFileId, 
                  Com.tblOrganization.fldCityId, Com.tblOrganization.fldUserId, Com.tblOrganization.fldDesc, Com.tblOrganization.fldDate, Com.tblCity.fldName AS fldCityName, 
                  Com.tblOrganization.fldCodAnformatic, Com.tblOrganization.fldCodKhedmat, ISNULL(Com.tblAshkhaseHoghoghi.fldShomareSabt,'') AS fldShomareSabt, ISNULL(Com.tblAshkhaseHoghoghi.fldShenaseMelli,'') AS fldShenaseMelli, 
                  ISNULL(Com.tblAshkhaseHoghoghi_Detail.fldCodEghtesadi,'') AS fldCodEghtesadi, ISNULL(Com.tblAshkhaseHoghoghi_Detail.fldAddress,'') AS fldAddress,ISNULL( Com.tblAshkhaseHoghoghi_Detail.fldShomareTelephone,'') AS fldTelphon, 
                  ISNULL(Com.tblAshkhaseHoghoghi_Detail.fldCodePosti,'') AS fldCodePosti, Com.tblOrganization.fldAshkhaseHoghoghiId, Com.tblAshkhaseHoghoghi.fldName AS FldNameAshkhaseHoghoghi
				  ,fldStateId
FROM     Com.tblOrganization INNER JOIN
                  Com.tblCity ON Com.tblOrganization.fldCityId = Com.tblCity.fldId INNER JOIN
                  Com.tblAshkhaseHoghoghi ON Com.tblOrganization.fldAshkhaseHoghoghiId = Com.tblAshkhaseHoghoghi.fldId INNER JOIN
                  Com.tblAshkhaseHoghoghi_Detail ON Com.tblAshkhaseHoghoghi.fldId = Com.tblAshkhaseHoghoghi_Detail.fldAshkhaseHoghoghiId
	WHERE ( (SELECT COUNT(*) FROM Com.tblUser_Group WHERE fldUserGroupId=1 AND fldUserSelectId=@UserId )>0 OR tblOrganization.fldUserId=@UserId or tblOrganization.fldId IN (SELECT fldOrganId FROM Com.tblModule_Organ WHERE fldId IN (SELECT fldModuleOrganId FROM Com.tblUserGroup_ModuleOrgan  WHERE fldUserGroupId IN (SELECT fldUserGroupId FROM Com.tblUser_Group WHERE fldUserSelectId=@UserId) ) ))
	AND tblOrganization.fldid=@Value	
	
		IF (@fieldname=N'UserId')
SELECT TOP (@h) Com.tblOrganization.fldId, Com.fn_stringDecode(Com.tblOrganization.fldName) AS fldName, Com.tblOrganization.fldPId, Com.tblOrganization.fldFileId, 
                  Com.tblOrganization.fldCityId, Com.tblOrganization.fldUserId, Com.tblOrganization.fldDesc, Com.tblOrganization.fldDate, Com.tblCity.fldName AS fldCityName, 
                  Com.tblOrganization.fldCodAnformatic, Com.tblOrganization.fldCodKhedmat, ISNULL(Com.tblAshkhaseHoghoghi.fldShomareSabt,'') AS fldShomareSabt, ISNULL(Com.tblAshkhaseHoghoghi.fldShenaseMelli,'') AS fldShenaseMelli, 
                  ISNULL(Com.tblAshkhaseHoghoghi_Detail.fldCodEghtesadi,'') AS fldCodEghtesadi, ISNULL(Com.tblAshkhaseHoghoghi_Detail.fldAddress,'') AS fldAddress,ISNULL( Com.tblAshkhaseHoghoghi_Detail.fldShomareTelephone,'') AS fldTelphon, 
                  ISNULL(Com.tblAshkhaseHoghoghi_Detail.fldCodePosti,'') AS fldCodePosti, Com.tblOrganization.fldAshkhaseHoghoghiId, Com.tblAshkhaseHoghoghi.fldName AS FldNameAshkhaseHoghoghi
				   ,fldStateId
FROM     Com.tblOrganization INNER JOIN
                  Com.tblCity ON Com.tblOrganization.fldCityId = Com.tblCity.fldId INNER JOIN
                  Com.tblAshkhaseHoghoghi ON Com.tblOrganization.fldAshkhaseHoghoghiId = Com.tblAshkhaseHoghoghi.fldId INNER JOIN
                  Com.tblAshkhaseHoghoghi_Detail ON Com.tblAshkhaseHoghoghi.fldId = Com.tblAshkhaseHoghoghi_Detail.fldAshkhaseHoghoghiId
	WHERE tblOrganization.fldId IN (SELECT fldOrganId FROM Com.tblModule_Organ WHERE fldId IN (SELECT fldModuleOrganId FROM Com.tblUserGroup_ModuleOrgan  WHERE fldUserGroupId IN (SELECT fldUserGroupId FROM Com.tblUser_Group WHERE fldUserSelectId=@UserId) ) )
	
		if (@fieldname=N'fldTreeOrgan')
SELECT TOP (@h) Com.tblOrganization.fldId, Com.fn_stringDecode(Com.tblOrganization.fldName) AS fldName, Com.tblOrganization.fldPId, Com.tblOrganization.fldFileId, 
                  Com.tblOrganization.fldCityId, Com.tblOrganization.fldUserId, Com.tblOrganization.fldDesc, Com.tblOrganization.fldDate, Com.tblCity.fldName AS fldCityName, 
                  Com.tblOrganization.fldCodAnformatic, Com.tblOrganization.fldCodKhedmat, ISNULL(Com.tblAshkhaseHoghoghi.fldShomareSabt,'') AS fldShomareSabt, ISNULL(Com.tblAshkhaseHoghoghi.fldShenaseMelli,'') AS fldShenaseMelli, 
                  ISNULL(Com.tblAshkhaseHoghoghi_Detail.fldCodEghtesadi,'') AS fldCodEghtesadi, ISNULL(Com.tblAshkhaseHoghoghi_Detail.fldAddress,'') AS fldAddress,ISNULL( Com.tblAshkhaseHoghoghi_Detail.fldShomareTelephone,'') AS fldTelphon, 
                  ISNULL(Com.tblAshkhaseHoghoghi_Detail.fldCodePosti,'') AS fldCodePosti, Com.tblOrganization.fldAshkhaseHoghoghiId, Com.tblAshkhaseHoghoghi.fldName AS FldNameAshkhaseHoghoghi
					,fldStateId
FROM     Com.tblOrganization INNER JOIN
                  Com.tblCity ON Com.tblOrganization.fldCityId = Com.tblCity.fldId INNER JOIN
                  Com.tblAshkhaseHoghoghi ON Com.tblOrganization.fldAshkhaseHoghoghiId = Com.tblAshkhaseHoghoghi.fldId INNER JOIN
                  Com.tblAshkhaseHoghoghi_Detail ON Com.tblAshkhaseHoghoghi.fldId = Com.tblAshkhaseHoghoghi_Detail.fldAshkhaseHoghoghiId
	WHERE  tblOrganization.fldId IN (SELECT fldOrganId FROM Com.tblModule_Organ WHERE fldId IN (SELECT fldModuleOrganId FROM Com.tblUserGroup_ModuleOrgan  WHERE fldUserGroupId IN (SELECT fldUserGroupId FROM Com.tblUser_Group WHERE fldUserSelectId=@UserId) ) )
	
	
			if (@fieldname=N'fldPIdOrgan')/*این select متفاوت است*/
	SELECT TOP (1) Com.tblOrganization.fldId, Com.fn_stringDecode(Com.tblOrganization.fldName) AS fldName, Com.tblOrganization.fldPId, Com.tblOrganization.fldFileId, 
                  Com.tblOrganization.fldCityId, Com.tblOrganization.fldUserId, Com.tblOrganization.fldDesc, Com.tblOrganization.fldDate, Com.tblCity.fldName AS fldCityName, 
                  Com.tblOrganization.fldCodAnformatic, Com.tblOrganization.fldCodKhedmat, ISNULL(Com.tblAshkhaseHoghoghi.fldShomareSabt,'') AS fldShomareSabt, ISNULL(Com.tblAshkhaseHoghoghi.fldShenaseMelli,'') AS fldShenaseMelli, 
                  ISNULL(Com.tblAshkhaseHoghoghi_Detail.fldCodEghtesadi,'') AS fldCodEghtesadi, ISNULL(Com.tblAshkhaseHoghoghi_Detail.fldAddress,'') AS fldAddress,ISNULL( Com.tblAshkhaseHoghoghi_Detail.fldShomareTelephone,'') AS fldTelphon, 
                  ISNULL(Com.tblAshkhaseHoghoghi_Detail.fldCodePosti,'') AS fldCodePosti, Com.tblOrganization.fldAshkhaseHoghoghiId, Com.tblAshkhaseHoghoghi.fldName AS FldNameAshkhaseHoghoghi
		,fldStateId
FROM     Com.tblOrganization INNER JOIN
                  Com.tblCity ON Com.tblOrganization.fldCityId = Com.tblCity.fldId INNER JOIN
                  Com.tblAshkhaseHoghoghi ON Com.tblOrganization.fldAshkhaseHoghoghiId = Com.tblAshkhaseHoghoghi.fldId INNER JOIN
                  Com.tblAshkhaseHoghoghi_Detail ON Com.tblAshkhaseHoghoghi.fldId = Com.tblAshkhaseHoghoghi_Detail.fldAshkhaseHoghoghiId
	WHERE  tblOrganization.fldId IN (SELECT fldOrganId FROM Com.tblModule_Organ WHERE fldId IN (SELECT fldModuleOrganId FROM Com.tblUserGroup_ModuleOrgan  WHERE fldUserGroupId IN (SELECT fldUserGroupId FROM Com.tblUser_Group WHERE fldUserSelectId=@UserId) ) )
	
	if (@fieldname=N'fldCityId')
	SELECT TOP (@h) Com.tblOrganization.fldId, Com.fn_stringDecode(Com.tblOrganization.fldName) AS fldName, Com.tblOrganization.fldPId, Com.tblOrganization.fldFileId, 
                  Com.tblOrganization.fldCityId, Com.tblOrganization.fldUserId, Com.tblOrganization.fldDesc, Com.tblOrganization.fldDate, Com.tblCity.fldName AS fldCityName, 
                  Com.tblOrganization.fldCodAnformatic, Com.tblOrganization.fldCodKhedmat, ISNULL(Com.tblAshkhaseHoghoghi.fldShomareSabt,'') AS fldShomareSabt, ISNULL(Com.tblAshkhaseHoghoghi.fldShenaseMelli,'') AS fldShenaseMelli, 
                  ISNULL(Com.tblAshkhaseHoghoghi_Detail.fldCodEghtesadi,'') AS fldCodEghtesadi, ISNULL(Com.tblAshkhaseHoghoghi_Detail.fldAddress,'') AS fldAddress,ISNULL( Com.tblAshkhaseHoghoghi_Detail.fldShomareTelephone,'') AS fldTelphon, 
                  ISNULL(Com.tblAshkhaseHoghoghi_Detail.fldCodePosti,'') AS fldCodePosti, Com.tblOrganization.fldAshkhaseHoghoghiId, Com.tblAshkhaseHoghoghi.fldName AS FldNameAshkhaseHoghoghi
					,fldStateId
FROM     Com.tblOrganization INNER JOIN
                  Com.tblCity ON Com.tblOrganization.fldCityId = Com.tblCity.fldId INNER JOIN
                  Com.tblAshkhaseHoghoghi ON Com.tblOrganization.fldAshkhaseHoghoghiId = Com.tblAshkhaseHoghoghi.fldId INNER JOIN
                  Com.tblAshkhaseHoghoghi_Detail ON Com.tblAshkhaseHoghoghi.fldId = Com.tblAshkhaseHoghoghi_Detail.fldAshkhaseHoghoghiId
	WHERE tblOrganization. fldCityId = @Value AND tblOrganization.fldId IN (SELECT fldOrganId FROM Com.tblModule_Organ WHERE fldId IN (SELECT fldModuleOrganId FROM Com.tblUserGroup_ModuleOrgan  WHERE fldUserGroupId IN (SELECT fldUserGroupId FROM Com.tblUser_Group WHERE fldUserSelectId=@UserId) ) )
	
	if (@fieldname=N'CheckCityId')
SELECT TOP (@h) Com.tblOrganization.fldId, Com.fn_stringDecode(Com.tblOrganization.fldName) AS fldName, Com.tblOrganization.fldPId, Com.tblOrganization.fldFileId, 
                  Com.tblOrganization.fldCityId, Com.tblOrganization.fldUserId, Com.tblOrganization.fldDesc, Com.tblOrganization.fldDate, Com.tblCity.fldName AS fldCityName, 
                  Com.tblOrganization.fldCodAnformatic, Com.tblOrganization.fldCodKhedmat, ISNULL(Com.tblAshkhaseHoghoghi.fldShomareSabt,'') AS fldShomareSabt, ISNULL(Com.tblAshkhaseHoghoghi.fldShenaseMelli,'') AS fldShenaseMelli, 
                  ISNULL(Com.tblAshkhaseHoghoghi_Detail.fldCodEghtesadi,'') AS fldCodEghtesadi, ISNULL(Com.tblAshkhaseHoghoghi_Detail.fldAddress,'') AS fldAddress,ISNULL( Com.tblAshkhaseHoghoghi_Detail.fldShomareTelephone,'') AS fldTelphon, 
                  ISNULL(Com.tblAshkhaseHoghoghi_Detail.fldCodePosti,'') AS fldCodePosti, Com.tblOrganization.fldAshkhaseHoghoghiId, Com.tblAshkhaseHoghoghi.fldName AS FldNameAshkhaseHoghoghi
				  ,fldStateId
FROM     Com.tblOrganization INNER JOIN
                  Com.tblCity ON Com.tblOrganization.fldCityId = Com.tblCity.fldId INNER JOIN
                  Com.tblAshkhaseHoghoghi ON Com.tblOrganization.fldAshkhaseHoghoghiId = Com.tblAshkhaseHoghoghi.fldId INNER JOIN
                  Com.tblAshkhaseHoghoghi_Detail ON Com.tblAshkhaseHoghoghi.fldId = Com.tblAshkhaseHoghoghi_Detail.fldAshkhaseHoghoghiId
	WHERE tblOrganization. fldCityId = @Value 
	
	if (@fieldname=N'fldPId')
	SELECT TOP (@h) Com.tblOrganization.fldId, Com.fn_stringDecode(Com.tblOrganization.fldName) AS fldName, Com.tblOrganization.fldPId, Com.tblOrganization.fldFileId, 
                  Com.tblOrganization.fldCityId, Com.tblOrganization.fldUserId, Com.tblOrganization.fldDesc, Com.tblOrganization.fldDate, Com.tblCity.fldName AS fldCityName, 
                  Com.tblOrganization.fldCodAnformatic, Com.tblOrganization.fldCodKhedmat, ISNULL(Com.tblAshkhaseHoghoghi.fldShomareSabt,'') AS fldShomareSabt, ISNULL(Com.tblAshkhaseHoghoghi.fldShenaseMelli,'') AS fldShenaseMelli, 
                  ISNULL(Com.tblAshkhaseHoghoghi_Detail.fldCodEghtesadi,'') AS fldCodEghtesadi, ISNULL(Com.tblAshkhaseHoghoghi_Detail.fldAddress,'') AS fldAddress,ISNULL( Com.tblAshkhaseHoghoghi_Detail.fldShomareTelephone,'') AS fldTelphon, 
                  ISNULL(Com.tblAshkhaseHoghoghi_Detail.fldCodePosti,'') AS fldCodePosti, Com.tblOrganization.fldAshkhaseHoghoghiId, Com.tblAshkhaseHoghoghi.fldName AS FldNameAshkhaseHoghoghi
				  ,fldStateId
FROM     Com.tblOrganization INNER JOIN
                  Com.tblCity ON Com.tblOrganization.fldCityId = Com.tblCity.fldId INNER JOIN
                  Com.tblAshkhaseHoghoghi ON Com.tblOrganization.fldAshkhaseHoghoghiId = Com.tblAshkhaseHoghoghi.fldId INNER JOIN
                  Com.tblAshkhaseHoghoghi_Detail ON Com.tblAshkhaseHoghoghi.fldId = Com.tblAshkhaseHoghoghi_Detail.fldAshkhaseHoghoghiId
	WHERE tblOrganization. fldPId = @Value
	
			if (@fieldname=N'CheckName')
	SELECT     TOP (@h)* FROM (SELECT  Com.tblOrganization.fldId, Com.fn_stringDecode(Com.tblOrganization.fldName) AS fldName, Com.tblOrganization.fldPId, Com.tblOrganization.fldFileId, 
                  Com.tblOrganization.fldCityId, Com.tblOrganization.fldUserId, Com.tblOrganization.fldDesc, Com.tblOrganization.fldDate, Com.tblCity.fldName AS fldCityName, 
                  Com.tblOrganization.fldCodAnformatic, Com.tblOrganization.fldCodKhedmat, ISNULL(Com.tblAshkhaseHoghoghi.fldShomareSabt,'') AS fldShomareSabt, ISNULL(Com.tblAshkhaseHoghoghi.fldShenaseMelli,'') AS fldShenaseMelli, 
                  ISNULL(Com.tblAshkhaseHoghoghi_Detail.fldCodEghtesadi,'') AS fldCodEghtesadi, ISNULL(Com.tblAshkhaseHoghoghi_Detail.fldAddress,'') AS fldAddress,ISNULL( Com.tblAshkhaseHoghoghi_Detail.fldShomareTelephone,'') AS fldTelphon, 
                  ISNULL(Com.tblAshkhaseHoghoghi_Detail.fldCodePosti,'') AS fldCodePosti, Com.tblOrganization.fldAshkhaseHoghoghiId, Com.tblAshkhaseHoghoghi.fldName AS FldNameAshkhaseHoghoghi
				  ,fldStateId
FROM     Com.tblOrganization INNER JOIN
                  Com.tblCity ON Com.tblOrganization.fldCityId = Com.tblCity.fldId INNER JOIN
                  Com.tblAshkhaseHoghoghi ON Com.tblOrganization.fldAshkhaseHoghoghiId = Com.tblAshkhaseHoghoghi.fldId INNER JOIN
                  Com.tblAshkhaseHoghoghi_Detail ON Com.tblAshkhaseHoghoghi.fldId = Com.tblAshkhaseHoghoghi_Detail.fldAshkhaseHoghoghiId)t
                      WHERE fldName = @Value
	
		if (@fieldname=N'fldName')
SELECT TOP (@h) Com.tblOrganization.fldId, Com.fn_stringDecode(Com.tblOrganization.fldName) AS fldName, Com.tblOrganization.fldPId, Com.tblOrganization.fldFileId, 
                  Com.tblOrganization.fldCityId, Com.tblOrganization.fldUserId, Com.tblOrganization.fldDesc, Com.tblOrganization.fldDate, Com.tblCity.fldName AS fldCityName, 
                  Com.tblOrganization.fldCodAnformatic, Com.tblOrganization.fldCodKhedmat, ISNULL(Com.tblAshkhaseHoghoghi.fldShomareSabt,'') AS fldShomareSabt, ISNULL(Com.tblAshkhaseHoghoghi.fldShenaseMelli,'') AS fldShenaseMelli, 
                  ISNULL(Com.tblAshkhaseHoghoghi_Detail.fldCodEghtesadi,'') AS fldCodEghtesadi, ISNULL(Com.tblAshkhaseHoghoghi_Detail.fldAddress,'') AS fldAddress,ISNULL( Com.tblAshkhaseHoghoghi_Detail.fldShomareTelephone,'') AS fldTelphon, 
                  ISNULL(Com.tblAshkhaseHoghoghi_Detail.fldCodePosti,'') AS fldCodePosti, Com.tblOrganization.fldAshkhaseHoghoghiId, Com.tblAshkhaseHoghoghi.fldName AS FldNameAshkhaseHoghoghi
				  ,fldStateId
FROM     Com.tblOrganization INNER JOIN
                  Com.tblCity ON Com.tblOrganization.fldCityId = Com.tblCity.fldId INNER JOIN
                  Com.tblAshkhaseHoghoghi ON Com.tblOrganization.fldAshkhaseHoghoghiId = Com.tblAshkhaseHoghoghi.fldId INNER JOIN
                  Com.tblAshkhaseHoghoghi_Detail ON Com.tblAshkhaseHoghoghi.fldId = Com.tblAshkhaseHoghoghi_Detail.fldAshkhaseHoghoghiId
	WHERE  Com.fn_stringDecode(Com.tblOrganization.fldName) LIKE @Value AND ((SELECT COUNT(*) FROM Com.tblUser_Group WHERE fldUserGroupId=1 AND fldUserSelectId=@UserId )>0 OR tblOrganization.fldUserId=@UserId or tblOrganization.fldId IN (SELECT fldOrganId FROM Com.tblModule_Organ WHERE fldId IN (SELECT fldModuleOrganId FROM Com.tblUserGroup_ModuleOrgan  WHERE fldUserGroupId IN (SELECT fldUserGroupId FROM Com.tblUser_Group WHERE fldUserSelectId=@UserId) ) ))

	if (@fieldname=N'fldDesc')
SELECT TOP (@h) Com.tblOrganization.fldId, Com.fn_stringDecode(Com.tblOrganization.fldName) AS fldName, Com.tblOrganization.fldPId, Com.tblOrganization.fldFileId, 
                  Com.tblOrganization.fldCityId, Com.tblOrganization.fldUserId, Com.tblOrganization.fldDesc, Com.tblOrganization.fldDate, Com.tblCity.fldName AS fldCityName, 
                  Com.tblOrganization.fldCodAnformatic, Com.tblOrganization.fldCodKhedmat, ISNULL(Com.tblAshkhaseHoghoghi.fldShomareSabt,'') AS fldShomareSabt, ISNULL(Com.tblAshkhaseHoghoghi.fldShenaseMelli,'') AS fldShenaseMelli, 
                  ISNULL(Com.tblAshkhaseHoghoghi_Detail.fldCodEghtesadi,'') AS fldCodEghtesadi, ISNULL(Com.tblAshkhaseHoghoghi_Detail.fldAddress,'') AS fldAddress,ISNULL( Com.tblAshkhaseHoghoghi_Detail.fldShomareTelephone,'') AS fldTelphon, 
                  ISNULL(Com.tblAshkhaseHoghoghi_Detail.fldCodePosti,'') AS fldCodePosti, Com.tblOrganization.fldAshkhaseHoghoghiId, Com.tblAshkhaseHoghoghi.fldName AS FldNameAshkhaseHoghoghi
				  ,fldStateId
FROM     Com.tblOrganization INNER JOIN
                  Com.tblCity ON Com.tblOrganization.fldCityId = Com.tblCity.fldId INNER JOIN
                  Com.tblAshkhaseHoghoghi ON Com.tblOrganization.fldAshkhaseHoghoghiId = Com.tblAshkhaseHoghoghi.fldId INNER JOIN
                  Com.tblAshkhaseHoghoghi_Detail ON Com.tblAshkhaseHoghoghi.fldId = Com.tblAshkhaseHoghoghi_Detail.fldAshkhaseHoghoghiId
	WHERE Com.tblOrganization.fldDesc like @Value 
	
	if (@fieldname=N'fldCodAnformatic')
SELECT TOP (@h) Com.tblOrganization.fldId, Com.fn_stringDecode(Com.tblOrganization.fldName) AS fldName, Com.tblOrganization.fldPId, Com.tblOrganization.fldFileId, 
                  Com.tblOrganization.fldCityId, Com.tblOrganization.fldUserId, Com.tblOrganization.fldDesc, Com.tblOrganization.fldDate, Com.tblCity.fldName AS fldCityName, 
                  Com.tblOrganization.fldCodAnformatic, Com.tblOrganization.fldCodKhedmat, ISNULL(Com.tblAshkhaseHoghoghi.fldShomareSabt,'') AS fldShomareSabt, ISNULL(Com.tblAshkhaseHoghoghi.fldShenaseMelli,'') AS fldShenaseMelli, 
                  ISNULL(Com.tblAshkhaseHoghoghi_Detail.fldCodEghtesadi,'') AS fldCodEghtesadi, ISNULL(Com.tblAshkhaseHoghoghi_Detail.fldAddress,'') AS fldAddress,ISNULL( Com.tblAshkhaseHoghoghi_Detail.fldShomareTelephone,'') AS fldTelphon, 
                  ISNULL(Com.tblAshkhaseHoghoghi_Detail.fldCodePosti,'') AS fldCodePosti, Com.tblOrganization.fldAshkhaseHoghoghiId, Com.tblAshkhaseHoghoghi.fldName AS FldNameAshkhaseHoghoghi
				  ,fldStateId
FROM     Com.tblOrganization INNER JOIN
                  Com.tblCity ON Com.tblOrganization.fldCityId = Com.tblCity.fldId INNER JOIN
                  Com.tblAshkhaseHoghoghi ON Com.tblOrganization.fldAshkhaseHoghoghiId = Com.tblAshkhaseHoghoghi.fldId INNER JOIN
                  Com.tblAshkhaseHoghoghi_Detail ON Com.tblAshkhaseHoghoghi.fldId = Com.tblAshkhaseHoghoghi_Detail.fldAshkhaseHoghoghiId
	WHERE Com.tblOrganization.fldCodAnformatic like @Value 

	if (@fieldname=N'fldShenaseMelli')
SELECT TOP (@h) Com.tblOrganization.fldId, Com.fn_stringDecode(Com.tblOrganization.fldName) AS fldName, Com.tblOrganization.fldPId, Com.tblOrganization.fldFileId, 
                  Com.tblOrganization.fldCityId, Com.tblOrganization.fldUserId, Com.tblOrganization.fldDesc, Com.tblOrganization.fldDate, Com.tblCity.fldName AS fldCityName, 
                  Com.tblOrganization.fldCodAnformatic, Com.tblOrganization.fldCodKhedmat, ISNULL(Com.tblAshkhaseHoghoghi.fldShomareSabt,'') AS fldShomareSabt, ISNULL(Com.tblAshkhaseHoghoghi.fldShenaseMelli,'') AS fldShenaseMelli, 
                  ISNULL(Com.tblAshkhaseHoghoghi_Detail.fldCodEghtesadi,'') AS fldCodEghtesadi, ISNULL(Com.tblAshkhaseHoghoghi_Detail.fldAddress,'') AS fldAddress,ISNULL( Com.tblAshkhaseHoghoghi_Detail.fldShomareTelephone,'') AS fldTelphon, 
                  ISNULL(Com.tblAshkhaseHoghoghi_Detail.fldCodePosti,'') AS fldCodePosti, Com.tblOrganization.fldAshkhaseHoghoghiId, Com.tblAshkhaseHoghoghi.fldName AS FldNameAshkhaseHoghoghi
				  ,fldStateId
FROM     Com.tblOrganization INNER JOIN
                  Com.tblCity ON Com.tblOrganization.fldCityId = Com.tblCity.fldId INNER JOIN
                  Com.tblAshkhaseHoghoghi ON Com.tblOrganization.fldAshkhaseHoghoghiId = Com.tblAshkhaseHoghoghi.fldId INNER JOIN
                  Com.tblAshkhaseHoghoghi_Detail ON Com.tblAshkhaseHoghoghi.fldId = Com.tblAshkhaseHoghoghi_Detail.fldAshkhaseHoghoghiId
                  WHERE  fldShenaseMelli LIKE @Value AND ((SELECT COUNT(*) FROM Com.tblUser_Group WHERE fldUserGroupId=1 AND fldUserSelectId=@UserId )>0 OR tblOrganization.fldUserId=@UserId or tblOrganization.fldId IN (SELECT fldOrganId FROM Com.tblModule_Organ WHERE fldId IN (SELECT fldModuleOrganId FROM Com.tblUserGroup_ModuleOrgan  WHERE fldUserGroupId IN (SELECT fldUserGroupId FROM Com.tblUser_Group WHERE fldUserSelectId=@UserId) ) ))
	
	
	
if (@fieldname=N'')
SELECT TOP (@h) Com.tblOrganization.fldId, Com.fn_stringDecode(Com.tblOrganization.fldName) AS fldName, Com.tblOrganization.fldPId, Com.tblOrganization.fldFileId, 
                  Com.tblOrganization.fldCityId, Com.tblOrganization.fldUserId, Com.tblOrganization.fldDesc, Com.tblOrganization.fldDate, Com.tblCity.fldName AS fldCityName, 
                  Com.tblOrganization.fldCodAnformatic, Com.tblOrganization.fldCodKhedmat, ISNULL(Com.tblAshkhaseHoghoghi.fldShomareSabt,'') AS fldShomareSabt, ISNULL(Com.tblAshkhaseHoghoghi.fldShenaseMelli,'') AS fldShenaseMelli, 
                  ISNULL(Com.tblAshkhaseHoghoghi_Detail.fldCodEghtesadi,'') AS fldCodEghtesadi, ISNULL(Com.tblAshkhaseHoghoghi_Detail.fldAddress,'') AS fldAddress,ISNULL( Com.tblAshkhaseHoghoghi_Detail.fldShomareTelephone,'') AS fldTelphon, 
                  ISNULL(Com.tblAshkhaseHoghoghi_Detail.fldCodePosti,'') AS fldCodePosti, Com.tblOrganization.fldAshkhaseHoghoghiId, Com.tblAshkhaseHoghoghi.fldName AS FldNameAshkhaseHoghoghi
				  ,fldStateId
FROM     Com.tblOrganization INNER JOIN
                  Com.tblCity ON Com.tblOrganization.fldCityId = Com.tblCity.fldId INNER JOIN
                  Com.tblAshkhaseHoghoghi ON Com.tblOrganization.fldAshkhaseHoghoghiId = Com.tblAshkhaseHoghoghi.fldId INNER JOIN
                  Com.tblAshkhaseHoghoghi_Detail ON Com.tblAshkhaseHoghoghi.fldId = Com.tblAshkhaseHoghoghi_Detail.fldAshkhaseHoghoghiId
                  WHERE fldPId IS NULL AND ((SELECT COUNT(*) FROM Com.tblUser_Group WHERE fldUserGroupId=1 AND fldUserSelectId=@UserId )>0 OR tblOrganization.fldUserId=@UserId or tblOrganization.fldId IN (SELECT fldOrganId FROM Com.tblModule_Organ WHERE fldId IN (SELECT fldModuleOrganId FROM Com.tblUserGroup_ModuleOrgan  WHERE fldUserGroupId IN (SELECT fldUserGroupId FROM Com.tblUser_Group WHERE fldUserSelectId=@UserId) ) ))



if (@fieldname=N'Baskool')
SELECT TOP (@h) Com.tblOrganization.fldId, Com.fn_stringDecode(Com.tblOrganization.fldName) AS fldName, Com.tblOrganization.fldPId, Com.tblOrganization.fldFileId, 
                  Com.tblOrganization.fldCityId, Com.tblOrganization.fldUserId, Com.tblOrganization.fldDesc, Com.tblOrganization.fldDate, Com.tblCity.fldName AS fldCityName, 
                  Com.tblOrganization.fldCodAnformatic, Com.tblOrganization.fldCodKhedmat, ISNULL(Com.tblAshkhaseHoghoghi.fldShomareSabt,'') AS fldShomareSabt, ISNULL(Com.tblAshkhaseHoghoghi.fldShenaseMelli,'') AS fldShenaseMelli, 
                  ISNULL(Com.tblAshkhaseHoghoghi_Detail.fldCodEghtesadi,'') AS fldCodEghtesadi, ISNULL(Com.tblAshkhaseHoghoghi_Detail.fldAddress,'') AS fldAddress,ISNULL( Com.tblAshkhaseHoghoghi_Detail.fldShomareTelephone,'') AS fldTelphon, 
                  ISNULL(Com.tblAshkhaseHoghoghi_Detail.fldCodePosti,'') AS fldCodePosti, Com.tblOrganization.fldAshkhaseHoghoghiId, Com.tblAshkhaseHoghoghi.fldName AS FldNameAshkhaseHoghoghi
				  ,fldStateId
FROM     Com.tblOrganization INNER JOIN
                  Com.tblCity ON Com.tblOrganization.fldCityId = Com.tblCity.fldId INNER JOIN
                  Com.tblAshkhaseHoghoghi ON Com.tblOrganization.fldAshkhaseHoghoghiId = Com.tblAshkhaseHoghoghi.fldId INNER JOIN
                  Com.tblAshkhaseHoghoghi_Detail ON Com.tblAshkhaseHoghoghi.fldId = Com.tblAshkhaseHoghoghi_Detail.fldAshkhaseHoghoghiId
                  cross apply (select m.fldid from com.tblUserGroup_ModuleOrgan  mu inner join com.tblUser_Group u
								on u.fldUserGroupId=mu.fldUserGroupId inner join com.tblModule_Organ m
								on m.fldid=mu.fldModuleOrganId
								where fldModuleId=16 and fldUserSelectId=@UserId and m.fldOrganId=tblOrganization.fldid)MaduleOrgan
				  WHERE ((SELECT COUNT(*) FROM Com.tblUser_Group WHERE fldUserGroupId=1 AND fldUserSelectId=@UserId )>0 OR tblOrganization.fldUserId=@UserId or tblOrganization.fldId IN (SELECT fldOrganId FROM Com.tblModule_Organ WHERE fldId IN (SELECT fldModuleOrganId FROM Com.tblUserGroup_ModuleOrgan  WHERE fldUserGroupId IN (SELECT fldUserGroupId FROM Com.tblUser_Group WHERE fldUserSelectId=@UserId) ) ))
			

              
	COMMIT
GO
