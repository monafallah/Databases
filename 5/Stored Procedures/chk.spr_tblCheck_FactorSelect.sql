SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [chk].[spr_tblCheck_FactorSelect] 
@fieldname nvarchar(50),
@value nvarchar(50),
@h int
AS 
 
	set @value=com.fn_TextNormalize(@value)
	if (@h=0) set @h=2147483647 
	BEGIN TRAN
	if (@fieldname='fldId')
	SELECT top(@h)[fldId], [fldCheckSadereId], [fldFactorId], [fldContractId], [fldTankhahGroupId], [fldDate], [fldUserId] 
	FROM   [chk].[tblCheck_Factor] 
	WHERE  fldId=@value

	if (@fieldname='fldTankhahGroupId')
	SELECT top(@h)[fldId], [fldCheckSadereId], [fldFactorId], [fldContractId], [fldTankhahGroupId], [fldDate], [fldUserId] 
	FROM   [chk].[tblCheck_Factor] 
	WHERE  fldTankhahGroupId=@value

	if (@fieldname='fldContractId')
	SELECT top(@h)[fldId], [fldCheckSadereId], [fldFactorId], [fldContractId], [fldTankhahGroupId], [fldDate], [fldUserId] 
	FROM   [chk].[tblCheck_Factor] 
	WHERE  fldContractId=@value

	if (@fieldname='fldFactorId')
	SELECT top(@h)[fldId], [fldCheckSadereId], [fldFactorId], [fldContractId], [fldTankhahGroupId], [fldDate], [fldUserId] 
	FROM   [chk].[tblCheck_Factor] 
	WHERE  fldFactorId=@value

	if (@fieldname='fldCheckSadereId')
	SELECT top(@h)[fldId], [fldCheckSadereId], [fldFactorId], [fldContractId], [fldTankhahGroupId], [fldDate], [fldUserId] 
	FROM   [chk].[tblCheck_Factor] 
	WHERE  fldCheckSadereId=@value
	
	if (@fieldname='')
	SELECT  top(@h) [fldId], [fldCheckSadereId], [fldFactorId], [fldContractId], [fldTankhahGroupId], [fldDate], [fldUserId] 
	FROM   [chk].[tblCheck_Factor] 
	


	COMMIT
GO
