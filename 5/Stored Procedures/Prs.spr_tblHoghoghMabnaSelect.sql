SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Prs].[spr_tblHoghoghMabnaSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@h int
AS 
	BEGIN TRAN
	if (@h=0) set @h=2147483647
	SET @Value=Com.fn_TextNormalize(@Value)
	if (@fieldname=N'fldId')
	SELECT top(@h) [fldId], [fldYear], [fldType], [fldUserId], [fldDate], [fldDesc] 
	,CASE WHEN fldType=0 THEN N'کارگری' ELSE N'کارمندی' END AS fldTypeName
	FROM   [Prs].[tblHoghoghMabna] 
	WHERE  fldId = @Value
	
	if (@fieldname=N'fldYear')
	SELECT top(@h) [fldId], [fldYear], [fldType], [fldUserId], [fldDate], [fldDesc] 
	,CASE WHEN fldType=0 THEN N'کارگری' ELSE N'کارمندی' END AS fldTypeName
	FROM   [Prs].[tblHoghoghMabna] 
	WHERE  fldYear LIKE @Value
	
	if (@fieldname=N'fldTypeName')
	SELECT top(@h)* from (SELECT [fldId], [fldYear], [fldType], [fldUserId], [fldDate], [fldDesc] 
	,CASE WHEN fldType=0 THEN N'کارگری' ELSE N'کارمندی' END AS fldTypeName
	FROM   [Prs].[tblHoghoghMabna] ) t
	WHERE  fldTypeName LIKE @Value
	
	if (@fieldname=N'fldDesc')
	SELECT top(@h) [fldId], [fldYear], [fldType], [fldUserId], [fldDate], [fldDesc] 
	,CASE WHEN fldType=0 THEN N'کارگری' ELSE N'کارمندی' END AS fldTypeName
	FROM   [Prs].[tblHoghoghMabna] 
	WHERE  fldDesc like @Value

	if (@fieldname=N'')
	SELECT top(@h) [fldId], [fldYear], [fldType], [fldUserId], [fldDate], [fldDesc] 
	,CASE WHEN fldType=0 THEN N'کارگری' ELSE N'کارمندی' END AS fldTypeName
	FROM   [Prs].[tblHoghoghMabna] 

	COMMIT
GO
