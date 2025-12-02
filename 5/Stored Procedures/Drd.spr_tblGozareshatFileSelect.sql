SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblGozareshatFileSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@OrganId nvarchar(50),
	@h int
AS 
	BEGIN TRAN
	if (@h=0) set @h=2147483647
	if (@fieldname=N'fldId')
	SELECT        TOP (@h) Drd.tblGozareshatFile.fldId, Drd.tblGozareshatFile.fldGozareshatId, Drd.tblGozareshatFile.fldOrganId, Drd.tblGozareshatFile.fldReportFileId, Drd.tblGozareshatFile.fldUserId, 
                         Drd.tblGozareshatFile.fldDesc, Drd.tblGozareshatFile.fldDate, Com.fn_stringDecode(Com.tblOrganization.fldName) AS fldOrganName, Drd.tblGozareshat.fldTitle
FROM            Drd.tblGozareshatFile INNER JOIN
                         Com.tblOrganization ON Drd.tblGozareshatFile.fldOrganId = Com.tblOrganization.fldId INNER JOIN
                         Drd.tblGozareshat ON Drd.tblGozareshatFile.fldGozareshatId = Drd.tblGozareshat.fldId
	WHERE  Drd.tblGozareshatFile.fldId = @Value and fldOrganId=@OrganId

	if (@fieldname=N'fldDesc')
	SELECT        TOP (@h) Drd.tblGozareshatFile.fldId, Drd.tblGozareshatFile.fldGozareshatId, Drd.tblGozareshatFile.fldOrganId, Drd.tblGozareshatFile.fldReportFileId, Drd.tblGozareshatFile.fldUserId, 
                         Drd.tblGozareshatFile.fldDesc, Drd.tblGozareshatFile.fldDate, Com.fn_stringDecode(Com.tblOrganization.fldName) AS fldOrganName, Drd.tblGozareshat.fldTitle
FROM            Drd.tblGozareshatFile INNER JOIN
                         Com.tblOrganization ON Drd.tblGozareshatFile.fldOrganId = Com.tblOrganization.fldId INNER JOIN
                         Drd.tblGozareshat ON Drd.tblGozareshatFile.fldGozareshatId = Drd.tblGozareshat.fldId
	WHERE Drd.tblGozareshatFile.fldDesc like  @Value

	if (@fieldname=N'fldTitle')
	SELECT        TOP (@h) Drd.tblGozareshatFile.fldId, Drd.tblGozareshatFile.fldGozareshatId, Drd.tblGozareshatFile.fldOrganId, Drd.tblGozareshatFile.fldReportFileId, Drd.tblGozareshatFile.fldUserId, 
                         Drd.tblGozareshatFile.fldDesc, Drd.tblGozareshatFile.fldDate, Com.fn_stringDecode(Com.tblOrganization.fldName) AS fldOrganName, Drd.tblGozareshat.fldTitle
FROM            Drd.tblGozareshatFile INNER JOIN
                         Com.tblOrganization ON Drd.tblGozareshatFile.fldOrganId = Com.tblOrganization.fldId INNER JOIN
                         Drd.tblGozareshat ON Drd.tblGozareshatFile.fldGozareshatId = Drd.tblGozareshat.fldId
	WHERE fldTitle like  @Value and fldOrganId=@OrganId

	if (@fieldname=N'fldGozareshatId')
	SELECT        TOP (@h) Drd.tblGozareshatFile.fldId, Drd.tblGozareshatFile.fldGozareshatId, Drd.tblGozareshatFile.fldOrganId, Drd.tblGozareshatFile.fldReportFileId, Drd.tblGozareshatFile.fldUserId, 
                         Drd.tblGozareshatFile.fldDesc, Drd.tblGozareshatFile.fldDate, Com.fn_stringDecode(Com.tblOrganization.fldName) AS fldOrganName, Drd.tblGozareshat.fldTitle
FROM            Drd.tblGozareshatFile INNER JOIN
                         Com.tblOrganization ON Drd.tblGozareshatFile.fldOrganId = Com.tblOrganization.fldId INNER JOIN
                         Drd.tblGozareshat ON Drd.tblGozareshatFile.fldGozareshatId = Drd.tblGozareshat.fldId
	WHERE fldGozareshatId like  @Value and fldOrganId=@OrganId

	if (@fieldname=N'fldOrganName')
	SELECT * from(select       TOP (@h) Drd.tblGozareshatFile.fldId, Drd.tblGozareshatFile.fldGozareshatId, Drd.tblGozareshatFile.fldOrganId, Drd.tblGozareshatFile.fldReportFileId, Drd.tblGozareshatFile.fldUserId, 
                         Drd.tblGozareshatFile.fldDesc, Drd.tblGozareshatFile.fldDate, Com.fn_stringDecode(Com.tblOrganization.fldName) AS fldOrganName, Drd.tblGozareshat.fldTitle
FROM            Drd.tblGozareshatFile INNER JOIN
                         Com.tblOrganization ON Drd.tblGozareshatFile.fldOrganId = Com.tblOrganization.fldId INNER JOIN
                         Drd.tblGozareshat ON Drd.tblGozareshatFile.fldGozareshatId = Drd.tblGozareshat.fldId)temp
	WHERE temp.fldOrganName like  @Value and fldOrganId=@OrganId

		if (@fieldname=N'fldOrganId')
	select       TOP (@h) Drd.tblGozareshatFile.fldId, Drd.tblGozareshatFile.fldGozareshatId, Drd.tblGozareshatFile.fldOrganId, Drd.tblGozareshatFile.fldReportFileId, Drd.tblGozareshatFile.fldUserId, 
                         Drd.tblGozareshatFile.fldDesc, Drd.tblGozareshatFile.fldDate, Com.fn_stringDecode(Com.tblOrganization.fldName) AS fldOrganName, Drd.tblGozareshat.fldTitle
FROM            Drd.tblGozareshatFile INNER JOIN
                         Com.tblOrganization ON Drd.tblGozareshatFile.fldOrganId = Com.tblOrganization.fldId INNER JOIN
                         Drd.tblGozareshat ON Drd.tblGozareshatFile.fldGozareshatId = Drd.tblGozareshat.fldId
	WHERE fldOrganId like  @Value

	if (@fieldname=N'')
	SELECT        TOP (@h) Drd.tblGozareshatFile.fldId, Drd.tblGozareshatFile.fldGozareshatId, Drd.tblGozareshatFile.fldOrganId, Drd.tblGozareshatFile.fldReportFileId, Drd.tblGozareshatFile.fldUserId, 
                         Drd.tblGozareshatFile.fldDesc, Drd.tblGozareshatFile.fldDate, Com.fn_stringDecode(Com.tblOrganization.fldName) AS fldOrganName, Drd.tblGozareshat.fldTitle
FROM            Drd.tblGozareshatFile INNER JOIN
                         Com.tblOrganization ON Drd.tblGozareshatFile.fldOrganId = Com.tblOrganization.fldId INNER JOIN
                         Drd.tblGozareshat ON Drd.tblGozareshatFile.fldGozareshatId = Drd.tblGozareshat.fldId

	COMMIT
GO
