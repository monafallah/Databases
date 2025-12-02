SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblMasuolinSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@OrganId INT,
	@h int
AS 
	BEGIN TRAN
	if (@h=0) set @h=2147483647
	SET @Value=Com.fn_TextNormalize(@Value)
	if (@fieldname=N'fldId')
	SELECT     TOP (@h) tblMasuolin.fldId, tblMasuolin.fldTarikhEjra, tblMasuolin.fldModule_OrganId, tblMasuolin.fldUserId, tblMasuolin.fldDesc, tblMasuolin.fldDate, 
                      tblModule.fldTitle + '(' + Com.fn_stringDecode(tblOrganization.fldName) + ')' + '_' + tblMasuolin.fldTarikhEjra AS fldTitleModule,
                         tblModule.fldTitle + '(' + Com.fn_stringDecode(tblOrganization.fldName)  + ')' AS fldModule_OrganName
FROM         tblModule_Organ INNER JOIN
                      tblModule ON tblModule_Organ.fldModuleId = tblModule.fldId INNER JOIN
                      tblOrganization ON tblModule_Organ.fldOrganId = tblOrganization.fldId INNER JOIN
                      tblMasuolin ON tblModule_Organ.fldId = tblMasuolin.fldModule_OrganId
	WHERE  tblMasuolin.fldId = @Value AND fldOrganId =@OrganId
	ORDER BY fldTarikhEjra desc
	
	if (@fieldname=N'fldTarikhEjra')
SELECT     TOP (@h) tblMasuolin.fldId, tblMasuolin.fldTarikhEjra, tblMasuolin.fldModule_OrganId, tblMasuolin.fldUserId, tblMasuolin.fldDesc, tblMasuolin.fldDate, 
                      tblModule.fldTitle + '(' + Com.fn_stringDecode(tblOrganization.fldName) + ')' + '_' + tblMasuolin.fldTarikhEjra AS fldTitleModule,
                        tblModule.fldTitle + '(' + Com.fn_stringDecode(tblOrganization.fldName)+ ')' AS fldModule_OrganName
FROM         tblModule_Organ INNER JOIN
                      tblModule ON tblModule_Organ.fldModuleId = tblModule.fldId INNER JOIN
                      tblOrganization ON tblModule_Organ.fldOrganId = tblOrganization.fldId INNER JOIN
                      tblMasuolin ON tblModule_Organ.fldId = tblMasuolin.fldModule_OrganId
	WHERE  [fldTarikhEjra] LIKE @Value AND    fldOrganId =@OrganId
ORDER BY fldTarikhEjra DESC

if (@fieldname=N'CheckTarikhEjra')
SELECT     TOP (@h) tblMasuolin.fldId, tblMasuolin.fldTarikhEjra, tblMasuolin.fldModule_OrganId, tblMasuolin.fldUserId, tblMasuolin.fldDesc, tblMasuolin.fldDate, 
                      tblModule.fldTitle + '(' + Com.fn_stringDecode(tblOrganization.fldName) + ')' + '_' + tblMasuolin.fldTarikhEjra AS fldTitleModule,
                        tblModule.fldTitle + '(' + Com.fn_stringDecode(tblOrganization.fldName) + ')' AS fldModule_OrganName
FROM         tblModule_Organ INNER JOIN
                      tblModule ON tblModule_Organ.fldModuleId = tblModule.fldId INNER JOIN
                      tblOrganization ON tblModule_Organ.fldOrganId = tblOrganization.fldId INNER JOIN
                      tblMasuolin ON tblModule_Organ.fldId = tblMasuolin.fldModule_OrganId
	WHERE  [fldTarikhEjra] LIKE @Value
ORDER BY fldTarikhEjra DESC

if (@fieldname=N'fldModule_OrganId')
SELECT     TOP (@h) tblMasuolin.fldId, tblMasuolin.fldTarikhEjra, tblMasuolin.fldModule_OrganId, tblMasuolin.fldUserId, tblMasuolin.fldDesc, tblMasuolin.fldDate, 
                      tblModule.fldTitle + '(' + Com.fn_stringDecode(tblOrganization.fldName) + ')' + '_' + tblMasuolin.fldTarikhEjra AS fldTitleModule,
                        tblModule.fldTitle + '(' + Com.fn_stringDecode(tblOrganization.fldName) + ')' AS fldModule_OrganName
FROM         tblModule_Organ INNER JOIN
                      tblModule ON tblModule_Organ.fldModuleId = tblModule.fldId INNER JOIN
                      tblOrganization ON tblModule_Organ.fldOrganId = tblOrganization.fldId INNER JOIN
                      tblMasuolin ON tblModule_Organ.fldId = tblMasuolin.fldModule_OrganId
	WHERE  tblMasuolin.fldModule_OrganId LIKE @Value
ORDER BY fldTarikhEjra DESC

	if (@fieldname=N'fldModule_OrganName')
SELECT     TOP (@h)* FROM (SELECT tblMasuolin.fldId, tblMasuolin.fldTarikhEjra, tblMasuolin.fldModule_OrganId, tblMasuolin.fldUserId, tblMasuolin.fldDesc, tblMasuolin.fldDate, 
                      tblModule.fldTitle + '(' + Com.fn_stringDecode(tblOrganization.fldName) + ')' + '_' + tblMasuolin.fldTarikhEjra AS fldTitleModule,
                        tblModule.fldTitle + '(' + Com.fn_stringDecode(tblOrganization.fldName) + ')' AS fldModule_OrganName
FROM         tblModule_Organ INNER JOIN
                      tblModule ON tblModule_Organ.fldModuleId = tblModule.fldId INNER JOIN
                      tblOrganization ON tblModule_Organ.fldOrganId = tblOrganization.fldId INNER JOIN
                      tblMasuolin ON tblModule_Organ.fldId = tblMasuolin.fldModule_OrganId
	WHERE   fldOrganId =@OrganId)t
	WHERE fldModule_OrganName LIKE @Value
ORDER BY fldTarikhEjra DESC

	if (@fieldname=N'fldDesc')
	SELECT     TOP (@h) tblMasuolin.fldId, tblMasuolin.fldTarikhEjra, tblMasuolin.fldModule_OrganId, tblMasuolin.fldUserId, tblMasuolin.fldDesc, tblMasuolin.fldDate, 
                      tblModule.fldTitle + '(' + Com.fn_stringDecode(tblOrganization.fldName) + ')' + '_' + tblMasuolin.fldTarikhEjra AS fldTitleModule,
                         tblModule.fldTitle + '(' + Com.fn_stringDecode(tblOrganization.fldName)  + ')' AS fldModule_OrganName
FROM         tblModule_Organ INNER JOIN
                      tblModule ON tblModule_Organ.fldModuleId = tblModule.fldId INNER JOIN
                      tblOrganization ON tblModule_Organ.fldOrganId = tblOrganization.fldId INNER JOIN
                      tblMasuolin ON tblModule_Organ.fldId = tblMasuolin.fldModule_OrganId
	WHERE  tblMasuolin.fldDesc like @Value AND fldOrganId =@OrganId
	ORDER BY fldTarikhEjra desc

	if (@fieldname=N'')
SELECT     TOP (@h) tblMasuolin.fldId, tblMasuolin.fldTarikhEjra, tblMasuolin.fldModule_OrganId, tblMasuolin.fldUserId, tblMasuolin.fldDesc, tblMasuolin.fldDate, 
                      tblModule.fldTitle + '(' + Com.fn_stringDecode(tblOrganization.fldName) + ')' + '_' + tblMasuolin.fldTarikhEjra AS fldTitleModule,
                        tblModule.fldTitle + '(' + Com.fn_stringDecode(tblOrganization.fldName) + ')' AS fldModule_OrganName
FROM         tblModule_Organ INNER JOIN
                      tblModule ON tblModule_Organ.fldModuleId = tblModule.fldId INNER JOIN
                      tblOrganization ON tblModule_Organ.fldOrganId = tblOrganization.fldId INNER JOIN
                      tblMasuolin ON tblModule_Organ.fldId = tblMasuolin.fldModule_OrganId
                      WHERE   fldOrganId =@OrganId
ORDER BY fldTarikhEjra desc
	COMMIT
GO
