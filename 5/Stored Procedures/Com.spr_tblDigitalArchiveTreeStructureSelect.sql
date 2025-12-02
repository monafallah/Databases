SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblDigitalArchiveTreeStructureSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	--@value2 NVARCHAR(50),
	@h int
AS 
	BEGIN TRAN
	if (@h=0) set @h=2147483647
	if (@fieldname=N'fldId')
	SELECT     TOP (@h) tblDigitalArchiveTreeStructure.fldId, tblDigitalArchiveTreeStructure.fldTitle, tblDigitalArchiveTreeStructure.fldPID, tblDigitalArchiveTreeStructure.fldModuleId, 
                      tblDigitalArchiveTreeStructure.fldAttachFile, tblDigitalArchiveTreeStructure.fldUserId, tblDigitalArchiveTreeStructure.fldDesc, 
                      tblDigitalArchiveTreeStructure.fldDate,Com.tblModule.fldTitle AS fldModuleName
FROM         tblDigitalArchiveTreeStructure LEFT OUTER JOIN
                      tblModule ON tblDigitalArchiveTreeStructure.fldModuleId = tblModule.fldId
	WHERE  tblDigitalArchiveTreeStructure.fldId = @Value
	
	if (@fieldname=N'fldTitle')
	SELECT     TOP (@h) tblDigitalArchiveTreeStructure.fldId, tblDigitalArchiveTreeStructure.fldTitle, tblDigitalArchiveTreeStructure.fldPID, tblDigitalArchiveTreeStructure.fldModuleId, 
                      tblDigitalArchiveTreeStructure.fldAttachFile, tblDigitalArchiveTreeStructure.fldUserId, tblDigitalArchiveTreeStructure.fldDesc, 
                      tblDigitalArchiveTreeStructure.fldDate,Com.tblModule.fldTitle AS fldModuleName
FROM         tblDigitalArchiveTreeStructure LEFT OUTER JOIN
                      tblModule ON tblDigitalArchiveTreeStructure.fldModuleId = tblModule.fldId
	WHERE  tblDigitalArchiveTreeStructure.fldTitle LIKE @Value

	if (@fieldname=N'fldModuleId')
		SELECT     TOP (@h) tblDigitalArchiveTreeStructure.fldId, tblDigitalArchiveTreeStructure.fldTitle, tblDigitalArchiveTreeStructure.fldPID, tblDigitalArchiveTreeStructure.fldModuleId, 
                      tblDigitalArchiveTreeStructure.fldAttachFile, tblDigitalArchiveTreeStructure.fldUserId, tblDigitalArchiveTreeStructure.fldDesc, 
                      tblDigitalArchiveTreeStructure.fldDate,Com.tblModule.fldTitle AS fldModuleName
FROM         tblDigitalArchiveTreeStructure LEFT OUTER JOIN
                      tblModule ON tblDigitalArchiveTreeStructure.fldModuleId = tblModule.fldId
	WHERE  fldModuleId = @Value 
	
		if (@fieldname=N'fldAttacheFile')
		SELECT     TOP (10) tblDigitalArchiveTreeStructure.fldId, tblDigitalArchiveTreeStructure.fldTitle, tblDigitalArchiveTreeStructure.fldPID, tblDigitalArchiveTreeStructure.fldModuleId, 
                      tblDigitalArchiveTreeStructure.fldAttachFile, tblDigitalArchiveTreeStructure.fldUserId, tblDigitalArchiveTreeStructure.fldDesc, 
                      tblDigitalArchiveTreeStructure.fldDate,Com.tblModule.fldTitle AS fldModuleName
FROM         tblDigitalArchiveTreeStructure LEFT OUTER JOIN
                      tblModule ON tblDigitalArchiveTreeStructure.fldModuleId = tblModule.fldId
	WHERE  fldAttachFile = 1 
	
	if (@fieldname=N'fldPID')
		SELECT     TOP (@h) tblDigitalArchiveTreeStructure.fldId, tblDigitalArchiveTreeStructure.fldTitle, tblDigitalArchiveTreeStructure.fldPID, tblDigitalArchiveTreeStructure.fldModuleId, 
                      tblDigitalArchiveTreeStructure.fldAttachFile, tblDigitalArchiveTreeStructure.fldUserId, tblDigitalArchiveTreeStructure.fldDesc, 
                      tblDigitalArchiveTreeStructure.fldDate,Com.tblModule.fldTitle AS fldModuleName
FROM         tblDigitalArchiveTreeStructure LEFT OUTER JOIN
                      tblModule ON tblDigitalArchiveTreeStructure.fldModuleId = tblModule.fldId
	WHERE  fldPID = @Value 
	
	if (@fieldname=N'fldPID_ModuleId')/*زیر شاخه های هر گره را نشان میدهد*/
	SELECT     TOP (@h) tblDigitalArchiveTreeStructure.fldId, tblDigitalArchiveTreeStructure.fldTitle, tblDigitalArchiveTreeStructure.fldPID, tblDigitalArchiveTreeStructure.fldModuleId, 
                      tblDigitalArchiveTreeStructure.fldAttachFile, tblDigitalArchiveTreeStructure.fldUserId, tblDigitalArchiveTreeStructure.fldDesc, 
                      tblDigitalArchiveTreeStructure.fldDate,Com.tblModule.fldTitle AS fldModuleName
FROM         tblDigitalArchiveTreeStructure LEFT OUTER JOIN
                      tblModule ON tblDigitalArchiveTreeStructure.fldModuleId = tblModule.fldId
	WHERE   fldPID IN(SELECT fldid FROM Com.tblDigitalArchiveTreeStructure WHERE fldModuleId=@value)
	
	
		if (@fieldname=N'fldDesc')
	SELECT     TOP (@h) tblDigitalArchiveTreeStructure.fldId, tblDigitalArchiveTreeStructure.fldTitle, tblDigitalArchiveTreeStructure.fldPID, tblDigitalArchiveTreeStructure.fldModuleId, 
                      tblDigitalArchiveTreeStructure.fldAttachFile, tblDigitalArchiveTreeStructure.fldUserId, tblDigitalArchiveTreeStructure.fldDesc, 
                      tblDigitalArchiveTreeStructure.fldDate,Com.tblModule.fldTitle AS fldModuleName
FROM         tblDigitalArchiveTreeStructure LEFT OUTER JOIN
                      tblModule ON tblDigitalArchiveTreeStructure.fldModuleId = tblModule.fldId
	WHERE  tblDigitalArchiveTreeStructure.fldDesc like @Value



	if (@fieldname=N'')
	SELECT     TOP (@h) tblDigitalArchiveTreeStructure.fldId, tblDigitalArchiveTreeStructure.fldTitle, tblDigitalArchiveTreeStructure.fldPID, tblDigitalArchiveTreeStructure.fldModuleId, 
                      tblDigitalArchiveTreeStructure.fldAttachFile, tblDigitalArchiveTreeStructure.fldUserId, tblDigitalArchiveTreeStructure.fldDesc, 
                      tblDigitalArchiveTreeStructure.fldDate,Com.tblModule.fldTitle AS fldModuleName
FROM         tblDigitalArchiveTreeStructure LEFT OUTER JOIN
                      tblModule ON tblDigitalArchiveTreeStructure.fldModuleId = tblModule.fldId
	WHERE fldPID IS NULL

	COMMIT
GO
