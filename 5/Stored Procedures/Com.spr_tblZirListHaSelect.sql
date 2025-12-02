SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblZirListHaSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@h int
AS 
	BEGIN TRAN
	if (@h=0) set @h=2147483647
	SET @Value=Com.fn_TextNormalize(@Value)
	if (@fieldname=N'fldId')
	SELECT top(@h) [fldId], [fldReportId], [fldMasuolin_DetailId], [fldUserId], [fldDesc], [fldDate] 
	FROM   [Com].[tblZirListHa] 
	WHERE  fldId = @Value

	if (@fieldname=N'fldReportId')
	SELECT top(@h) [fldId], [fldReportId], [fldMasuolin_DetailId], [fldUserId], [fldDesc], [fldDate] 
	FROM   [Com].[tblZirListHa] 
	WHERE  fldReportId = @Value

	if (@fieldname=N'fldDesc')
	SELECT top(@h) [fldId], [fldReportId], [fldMasuolin_DetailId], [fldUserId], [fldDesc], [fldDate] 
	FROM   [Com].[tblZirListHa] 
	WHERE  fldDesc like @Value

	if (@fieldname=N'')
	SELECT top(@h) [fldId], [fldReportId], [fldMasuolin_DetailId], [fldUserId], [fldDesc], [fldDate] 
	FROM   [Com].[tblZirListHa] 

	COMMIT
GO
