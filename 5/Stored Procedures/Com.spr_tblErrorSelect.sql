SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblErrorSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@h int
AS 
	BEGIN TRAN
	if (@h=0) set @h=2147483647
	SET @Value=Com.fn_TextNormalize(@Value)
	if (@fieldname=N'fldId')
	SELECT top(@h) fldId, fldUserName, fldMatn,dbo.Fn_AssembelyMiladiToShamsi( fldTarikh) AS fldTarikh, fldIP, fldUserId, fldDesc, fldDate 
	FROM   Com.tblError 
	WHERE  fldId = @Value
	order by fldId desc

		if (@fieldname=N'fldUserName')
	SELECT top(@h) fldId, fldUserName, fldMatn,dbo.Fn_AssembelyMiladiToShamsi( fldTarikh) AS fldTarikh, fldIP, fldUserId, fldDesc, fldDate 
	FROM   Com.tblError 
	WHERE  fldUserName like @Value
	order by fldId desc

	if (@fieldname=N'fldMatn')
	SELECT top(@h) fldId, fldUserName, fldMatn,dbo.Fn_AssembelyMiladiToShamsi( fldTarikh) AS fldTarikh, fldIP, fldUserId, fldDesc, fldDate 
	FROM   Com.tblError 
	WHERE  fldMatn like @Value
	order by fldId desc

	if (@fieldname=N'fldTarikh')
	SELECT top(@h) fldId, fldUserName, fldMatn,dbo.Fn_AssembelyMiladiToShamsi( fldTarikh) AS fldTarikh, fldIP, fldUserId, fldDesc, fldDate 
	FROM   Com.tblError 
	WHERE  dbo.Fn_AssembelyMiladiToShamsi( fldTarikh) like @Value
	order by fldId desc

		if (@fieldname=N'fldDesc')
	SELECT top(@h) fldId, fldUserName, fldMatn,dbo.Fn_AssembelyMiladiToShamsi( fldTarikh) AS fldTarikh, fldIP, fldUserId, fldDesc, fldDate 
	FROM   Com.tblError 
	WHERE  fldDesc like @Value
	order by fldId desc

	if (@fieldname=N'')
	SELECT top(@h) fldId, fldUserName, fldMatn,dbo.Fn_AssembelyMiladiToShamsi( fldTarikh) AS fldTarikh, fldIP, fldUserId, fldDesc, fldDate 
	FROM   Com.tblError 
	order by fldId desc

	COMMIT
GO
