SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Prs].[spr_tblMohaseleenSelect] 
@fieldname nvarchar(50),
@value nvarchar(50),
@h int
AS 
 
	set @value=dbo.fn_TextNormalize(@value)
	if (@h=0) set @h=2147483647 
	BEGIN TRAN
	if (@fieldname='fldId')
	SELECT top(@h)[fldId], [fldAfradTahtePoosheshId], [fldTarikh], [fldUserId], [fldDate] 
	FROM   [Prs].[tblMohaseleen] 
	WHERE  fldId=@value

	if (@fieldname='fldAfradTahtePoosheshId')
	SELECT  top(@h) [fldId], [fldAfradTahtePoosheshId], [fldTarikh] , [fldUserId], [fldDate] 
	FROM   [Prs].[tblMohaseleen] 
	where  fldAfradTahtePoosheshId =@value

	if (@fieldname='fldTarikh')
	SELECT  top(@h) [fldId], [fldAfradTahtePoosheshId], [fldTarikh] , [fldUserId], [fldDate] 
	FROM   [Prs].[tblMohaseleen] 
	where  fldTarikh =@value

	if (@fieldname='')
	SELECT  top(@h) [fldId], [fldAfradTahtePoosheshId], [fldTarikh], [fldUserId], [fldDate] 
	FROM   [Prs].[tblMohaseleen] 
	


	COMMIT
GO
