SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Cntr].[spr_tblContract_FactorSelect] 
@fieldname nvarchar(50),
@value nvarchar(50),
@oganId int,
@h int
AS 
 
	set @value=com.fn_TextNormalize(@value)
	if (@h=0) set @h=2147483647 
	BEGIN TRAN
	if (@fieldname='fldId')
	SELECT top(@h)[fldId], [fldContractId], [fldFactorId], [fldUserId], [fldOrganID], [fldIP], [fldDesc], [fldDate] 
	FROM   [Cntr].[tblContract_Factor] 
	WHERE  fldId=@value
	
	if (@fieldname='')
	SELECT  top(@h) [fldId], [fldContractId], [fldFactorId], [fldUserId], [fldOrganID], [fldIP], [fldDesc], [fldDate] 
	FROM   [Cntr].[tblContract_Factor] 
	
	if (@fieldname='fldOrganID')
	SELECT top(@h)[fldId], [fldContractId], [fldFactorId], [fldUserId], [fldOrganID], [fldIP], [fldDesc], [fldDate] 
	FROM   [Cntr].[tblContract_Factor] 
	WHERE  fldOrganID=@oganId


	if (@fieldname='fldContractId')
	SELECT top(@h)[fldId], [fldContractId], [fldFactorId], [fldUserId], [fldOrganID], [fldIP], [fldDesc], [fldDate] 
	FROM   [Cntr].[tblContract_Factor] 
	WHERE  fldContractId=@value and fldOrganID=@oganId


	if (@fieldname='fldFactorId')
	SELECT top(@h)[fldId], [fldContractId], [fldFactorId], [fldUserId], [fldOrganID], [fldIP], [fldDesc], [fldDate] 
	FROM   [Cntr].[tblContract_Factor] 
	WHERE  fldFactorId=@value and fldOrganID=@oganId

	


	COMMIT
GO
