SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblMonasebatTypeSelect] 
@fieldname nvarchar(50),
@value nvarchar(50),
@h int
AS 
 
	set @value=com.fn_TextNormalize(@value)
	if (@h=0) set @h=2147483647 
	BEGIN TRAN
	if (@fieldname='fldId')
	SELECT top(@h)[fldId], [fldName], [fldIP], [fldUserId], [fldDesc], [fldDate] 
	FROM   [Pay].[tblMonasebatType] 
	WHERE  fldId=@value
	
	if (@fieldname='fldName')
	SELECT top(@h)[fldId], [fldName], [fldIP], [fldUserId], [fldDesc], [fldDate] 
	FROM   [Pay].[tblMonasebatType] 
	WHERE  fldName like @value

	if (@fieldname='')
	SELECT  top(@h) [fldId], [fldName], [fldIP], [fldUserId], [fldDesc], [fldDate] 
	FROM   [Pay].[tblMonasebatType] 
	


	COMMIT
GO
