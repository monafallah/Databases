SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [ACC].[spr_tblDocumentDescSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@h int
AS 
	BEGIN TRAN
	
	
	SET @Value=Com.fn_TextNormalize(@Value)
	if (@h=0) set @h=2147483647
	if (@fieldname=N'fldId')
	SELECT top(@h) [fldId], [fldName], [fldDocDesc], [fldDesc], [fldDate], [fldIP], [fldUserId] 
	,fldFlag ,case when fldFlag=1 then N'شرح کلی' when fldFlag=0 then N'شرح آرتیکل'end as fldFlagName
	FROM   [ACC].[tblDocumentDesc] 
	WHERE  fldId = @Value

	if (@fieldname=N'fldDocDesc')
	SELECT top(@h) [fldId], [fldName], [fldDocDesc], [fldDesc], [fldDate], [fldIP], [fldUserId]
		,fldFlag ,case when fldFlag=1 then N'شرح کلی' when fldFlag=0 then N'شرح آرتیکل'end as fldFlagName 
	FROM   [ACC].[tblDocumentDesc] 
	WHERE fldDocDesc like  @Value

	if (@fieldname=N'fldName')
	SELECT top(@h) [fldId], [fldName], [fldDocDesc], [fldDesc], [fldDate], [fldIP], [fldUserId]
		,fldFlag ,case when fldFlag=1 then N'شرح کلی' when fldFlag=0 then N'شرح آرتیکل'end as fldFlagName 
	FROM   [ACC].[tblDocumentDesc] 
	WHERE fldName like  @Value

		if (@fieldname=N'fldFlag')
	SELECT top(@h) [fldId], [fldName], [fldDocDesc], [fldDesc], [fldDate], [fldIP], [fldUserId]
		,fldFlag ,case when fldFlag=1 then N'شرح کلی' when fldFlag=0 then N'شرح آرتیکل'end as fldFlagName 
	FROM   [ACC].[tblDocumentDesc] 
	WHERE fldFlag like  @Value

	if (@fieldname=N'fldDesc')
	SELECT top(@h) [fldId], [fldName], [fldDocDesc], [fldDesc], [fldDate], [fldIP], [fldUserId] 
		,fldFlag ,case when fldFlag=1 then N'شرح کلی' when fldFlag=0 then N'شرح آرتیکل'end as fldFlagName
	FROM   [ACC].[tblDocumentDesc] 
	WHERE fldDesc like  @Value

	if (@fieldname=N'')
	SELECT top(@h) [fldId], [fldName], [fldDocDesc], [fldDesc], [fldDate], [fldIP], [fldUserId] 
		,fldFlag ,case when fldFlag=1 then N'شرح کلی' when fldFlag=0 then N'شرح آرتیکل'end as fldFlagName
	FROM   [ACC].[tblDocumentDesc] 
	
	
	if (@fieldname=N'fldName')
	SELECT top(@h) [fldId], [fldName], [fldDocDesc], [fldDesc], [fldDate], [fldIP], [fldUserId] 
		,fldFlag ,case when fldFlag=1 then N'شرح کلی' when fldFlag=0 then N'شرح آرتیکل'end as fldFlagName
	FROM   [ACC].[tblDocumentDesc] 
	WHERE fldName like  @Value
	

	COMMIT
GO
