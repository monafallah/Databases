SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Auto].[spr_tblProgramSettingSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@fldOrganID INT,
	@h int
AS 
	BEGIN TRAN
	SET @Value=com.fn_TextNormalize(@Value)
	if (@h=0) set @h=2147483647
	if (@fieldname=N'fldId')
	SELECT top(@h)p. [fldID],  [fldEmailAddress], [fldEmailPassword],[fldRecieveServer],
	 [fldSendServer], [fldSendPort], [fldSSL], [fldDelFax], [fldIsSigner], [fldFaxPath], 
	 [fldOrganID], p.[fldDate], p.[fldUserID], p.[fldDesc], [fldIP],[fldRecievePort] 
	 ,o.fldName as NameOrgan
	FROM   Auto.tblProgramSetting p inner join com.tblOrganization o
	on o.fldid=p.[fldOrganID]
	WHERE  p.fldId = @Value AND fldOrganID=@fldOrganID

	if (@fieldname=N'fldDesc')
	SELECT top(@h)p. [fldID],  [fldEmailAddress], [fldEmailPassword],[fldRecieveServer],
	 [fldSendServer], [fldSendPort], [fldSSL], [fldDelFax], [fldIsSigner], [fldFaxPath], 
	 [fldOrganID], p.[fldDate], p.[fldUserID], p.[fldDesc], [fldIP],[fldRecievePort] 
	 ,o.fldName as NameOrgan
	FROM   Auto.tblProgramSetting p inner join com.tblOrganization o
	on o.fldid=p.[fldOrganID]
	WHERE p.fldDesc like  @Value AND fldOrganID=@fldOrganID

	if (@fieldname=N'fldOrganID')
	SELECT top(@h)p. [fldID],  [fldEmailAddress], [fldEmailPassword],[fldRecieveServer],
	 [fldSendServer], [fldSendPort], [fldSSL], [fldDelFax], [fldIsSigner], [fldFaxPath], 
	 [fldOrganID], p.[fldDate], p.[fldUserID], p.[fldDesc], [fldIP],[fldRecievePort] 
	 ,o.fldName as NameOrgan
	FROM   Auto.tblProgramSetting p inner join com.tblOrganization o
	on o.fldid=p.[fldOrganID]
	WHERE  fldOrganID = @Value 

	if (@fieldname=N'')
	SELECT top(@h)p. [fldID],  [fldEmailAddress], [fldEmailPassword],[fldRecieveServer],
	 [fldSendServer], [fldSendPort], [fldSSL], [fldDelFax], [fldIsSigner], [fldFaxPath], 
	 [fldOrganID], p.[fldDate], p.[fldUserID], p.[fldDesc], [fldIP],[fldRecievePort] 
	 ,o.fldName as NameOrgan
	FROM   Auto.tblProgramSetting p inner join com.tblOrganization o
	on o.fldid=p.[fldOrganID]

	COMMIT
GO
