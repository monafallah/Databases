SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblMaxBimeSelect] 
@fieldname nvarchar(50),
@value nvarchar(50),
@h int
AS 
 
	set @value=Com.fn_TextNormalize(@value)
	if (@h=0) set @h=2147483647 
	BEGIN TRAN
	if (@fieldname='fldId')
	SELECT top(@h)[fldId], [fldYear], [fldMablaghBime], [fldUserId], [fldDate], [fldIp] 
	FROM   [Pay].[tblMaxBime] 
	WHERE  fldId=@value
	
	if (@fieldname='fldYear')
	SELECT top(1)[fldId], [fldYear], [fldMablaghBime], [fldUserId], [fldDate], [fldIp] 
	FROM   [Pay].[tblMaxBime] 
	WHERE  fldYear=@value
	order by fldDate desc

	if (@fieldname='')
	SELECT  top(@h) [fldId], [fldYear], [fldMablaghBime], [fldUserId], [fldDate], [fldIp] 
	FROM   [Pay].[tblMaxBime] 
	


	COMMIT
GO
