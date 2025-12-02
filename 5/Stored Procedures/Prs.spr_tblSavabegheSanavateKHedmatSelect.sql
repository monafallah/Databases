SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Prs].[spr_tblSavabegheSanavateKHedmatSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@value1 NVARCHAR(50) ,
	@value2 NVARCHAR(50) ,
	@OrganId INT,
	@h int
AS 
	BEGIN TRAN
	if (@h=0) set @h=2147483647
	SET @Value=Com.fn_TextNormalize(@Value)
	if (@fieldname=N'fldId')
	SELECT top(@h) [fldId], [fldPersonalId], [fldNoeSabeghe], [fldAzTarikh], [fldTaTarikh], [fldUserId], [fldDesc], [fldDate],case when (fldNoeSabeghe=0) then N'خدمت سربازی' else  N'انتقال از سازمان دیگر' end as fldNoeSabegheName 
	FROM   [Prs].[tblSavabegheSanavateKHedmat] 
	WHERE  fldId = @Value AND Com.fn_OrganId(fldPersonalId) =@OrganId
	
		if (@fieldname=N'fldDesc')
	SELECT top(@h) [fldId], [fldPersonalId], [fldNoeSabeghe], [fldAzTarikh], [fldTaTarikh], [fldUserId], [fldDesc], [fldDate],case when (fldNoeSabeghe=0) then N'خدمت سربازی' else  N'انتقال از سازمان دیگر' end as fldNoeSabegheName 
	FROM   [Prs].[tblSavabegheSanavateKHedmat] 
	WHERE  fldDesc LIKE @Value 
	

	if (@fieldname=N'fldPersonalId')
	SELECT top(@h) [fldId], [fldPersonalId], [fldNoeSabeghe], [fldAzTarikh], [fldTaTarikh], [fldUserId], [fldDesc], [fldDate],case when (fldNoeSabeghe=0) then N'خدمت سربازی' else  N'انتقال از سازمان دیگر' end as fldNoeSabegheName 
	FROM   [Prs].[tblSavabegheSanavateKHedmat] 
	WHERE  fldPersonalId = @Value AND Com.fn_OrganId(fldPersonalId) =@OrganId
	
	if (@fieldname=N'CheckPersonalId')
	SELECT top(@h) [fldId], [fldPersonalId], [fldNoeSabeghe], [fldAzTarikh], [fldTaTarikh], [fldUserId], [fldDesc], [fldDate],case when (fldNoeSabeghe=0) then N'خدمت سربازی' else  N'انتقال از سازمان دیگر' end as fldNoeSabegheName 
	FROM   [Prs].[tblSavabegheSanavateKHedmat] 
	WHERE  fldPersonalId = @Value
	
	if (@fieldname=N'CheckPersonal')
	SELECT top(@h) [fldId], [fldPersonalId], [fldNoeSabeghe], [fldAzTarikh], [fldTaTarikh], [fldUserId], [fldDesc], [fldDate],case when (fldNoeSabeghe=0) then N'خدمت سربازی' else  N'انتقال از سازمان دیگر' end as fldNoeSabegheName 
	FROM   [Prs].[tblSavabegheSanavateKHedmat] 
	WHERE  fldPersonalId = @Value AND ((fldAzTarikh  BETWEEN @value1 AND @value2) OR (fldTaTarikh BETWEEN @value1 AND @value2))

	
	if (@fieldname=N'fldAzTarikh')
	SELECT top(@h) [fldId], [fldPersonalId], [fldNoeSabeghe], [fldAzTarikh], [fldTaTarikh], [fldUserId], [fldDesc], [fldDate],case when (fldNoeSabeghe=0) then N'خدمت سربازی' else  N'انتقال از سازمان دیگر' end as fldNoeSabegheName 
	FROM   [Prs].[tblSavabegheSanavateKHedmat] 
	WHERE  fldAzTarikh like @Value AND Com.fn_OrganId(fldPersonalId) =@OrganId
	
	if (@fieldname=N'fldTaTarikh')
	SELECT top(@h) [fldId], [fldPersonalId], [fldNoeSabeghe], [fldAzTarikh], [fldTaTarikh], [fldUserId], [fldDesc], [fldDate],case when (fldNoeSabeghe=0) then N'خدمت سربازی' else  N'انتقال از سازمان دیگر' end as fldNoeSabegheName 
	FROM   [Prs].[tblSavabegheSanavateKHedmat] 
	WHERE  fldTaTarikh like @Value AND Com.fn_OrganId(fldPersonalId) =@OrganId
	
	if (@fieldname=N'fldNoeSabegheName')
	SELECT top(@h)* from(select  [fldId], [fldPersonalId], [fldNoeSabeghe], [fldAzTarikh], [fldTaTarikh], [fldUserId], [fldDesc], [fldDate],case when (fldNoeSabeghe=0) then N'خدمت سربازی' else  N'انتقال از سازمان دیگر' end as fldNoeSabegheName 
	FROM   [Prs].[tblSavabegheSanavateKHedmat] )temp
	WHERE  fldNoeSabegheName like @Value AND Com.fn_OrganId(fldPersonalId) =@OrganId
	
	if (@fieldname=N'')
	SELECT top(@h) [fldId], [fldPersonalId], [fldNoeSabeghe], [fldAzTarikh], [fldTaTarikh], [fldUserId], [fldDesc], [fldDate] ,case when (fldNoeSabeghe=0) then N'خدمت سربازی' else  N'انتقال از سازمان دیگر' end as fldNoeSabegheName
	FROM   [Prs].[tblSavabegheSanavateKHedmat] 
	where  Com.fn_OrganId(fldPersonalId) =@OrganId
	
		if (@fieldname=N'All')
	SELECT top(@h) [fldId], [fldPersonalId], [fldNoeSabeghe], [fldAzTarikh], [fldTaTarikh], [fldUserId], [fldDesc], [fldDate] ,case when (fldNoeSabeghe=0) then N'خدمت سربازی' else  N'انتقال از سازمان دیگر' end as fldNoeSabegheName
	FROM   [Prs].[tblSavabegheSanavateKHedmat] 

	COMMIT
GO
