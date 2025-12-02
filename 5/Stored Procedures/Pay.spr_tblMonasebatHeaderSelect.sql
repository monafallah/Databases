SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblMonasebatHeaderSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@h int
AS 
	BEGIN TRAN
	if (@h=0) set @h=2147483647
	if (@fieldname=N'fldId')
	SELECT top(@h) [fldId], [fldActiveDate], [fldDeactiveDate], [fldActive], [fldIP], [fldUserId], [fldDate] 
	,case when fldActive=1 then N'فعال' else N'غیرفعال' end fldActiveName
	FROM   [Pay].[tblMonasebatHeader] 
	WHERE  fldId = @Value


	if (@fieldname=N'fldActiveDate')
		SELECT top(@h) [fldId], [fldActiveDate], [fldDeactiveDate], [fldActive], [fldIP], [fldUserId], [fldDate] 
	,case when fldActive=1 then N'فعال' else N'غیرفعال' end fldActiveName
	FROM   [Pay].[tblMonasebatHeader] 
	WHERE fldActiveDate like  @Value

	if (@fieldname=N'fldDeactiveDate')
		SELECT top(@h) [fldId], [fldActiveDate], [fldDeactiveDate], [fldActive], [fldIP], [fldUserId], [fldDate] 
	,case when fldActive=1 then N'فعال' else N'غیرفعال' end fldActiveName
	FROM   [Pay].[tblMonasebatHeader] 
	WHERE fldDeactiveDate like  @Value

	if (@fieldname=N'')
		SELECT top(@h) [fldId], [fldActiveDate], [fldDeactiveDate], [fldActive], [fldIP], [fldUserId], [fldDate] 
	,case when fldActive=1 then N'فعال' else N'غیرفعال' end fldActiveName
	FROM   [Pay].[tblMonasebatHeader] 

	COMMIT
GO
