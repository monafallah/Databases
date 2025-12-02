SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblTypeNesbatSelect] 
@fieldname nvarchar(50),
@value nvarchar(50),
@h int
AS 
 
	set @value=com.fn_TextNormalize(@value)
	if (@h=0) set @h=2147483647 
	BEGIN TRAN
	if (@fieldname='fldId')
	SELECT top(@h)[fldId], [fldTypeName] 
	FROM   [Pay].[tblTypeNesbat] 
	WHERE  fldId=@value
	
	if (@fieldname='fldId')
	SELECT top(@h)[fldId], [fldTypeName] 
	FROM   [Pay].[tblTypeNesbat] 
	WHERE  fldTypeName like @value

	if (@fieldname='')
	SELECT  top(@h) [fldId], [fldTypeName] 
	FROM   [Pay].[tblTypeNesbat] 
	


	COMMIT
GO
