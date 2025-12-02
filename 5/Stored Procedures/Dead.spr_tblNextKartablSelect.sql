SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Dead].[spr_tblNextKartablSelect] 
@FieldName nvarchar(50),
@Value nvarchar(50),
@organId int,
@h int

AS 

	BEGIN TRAN
	if (@h=0) set @h=2147483647
	set @Value=com.fn_TextNormalize(@Value)

	if (@FieldName='fldId')
	SELECT top(@h) n.[fldId], [fldKartablNextId], [fldActionId], n.[fldUserId], n.[fldOrganId], n.[fldDesc], n.[fldDate], n.[fldIP] 
	,a.fldTitleAction,k.fldTitleKartabl
	FROM   [Dead].[tblNextKartabl] n 
	inner join dead.tblactions a on a.fldid=fldActionId
	inner join dead.tblkartabl k on k.fldid=fldKartablNextId
	WHERE  n.fldId=@Value and n.fldOrganId=@organId

	if (@FieldName='fldKartablNextId')
	SELECT top(@h) n.[fldId], [fldKartablNextId], [fldActionId], n.[fldUserId], n.[fldOrganId], n.[fldDesc], n.[fldDate], n.[fldIP] 
	,a.fldTitleAction,k.fldTitleKartabl
	FROM   [Dead].[tblNextKartabl] n 
	inner join dead.tblactions a on a.fldid=fldActionId
	inner join dead.tblkartabl k on k.fldid=fldKartablNextId
	WHERE  fldKartablNextId=@Value and n.fldOrganId=@organId


	if (@FieldName='fldActionId')
	SELECT top(@h) n.[fldId], [fldKartablNextId], [fldActionId], n.[fldUserId], n.[fldOrganId], n.[fldDesc], n.[fldDate], n.[fldIP] 
	,a.fldTitleAction,k.fldTitleKartabl
	FROM   [Dead].[tblNextKartabl] n 
	inner join dead.tblactions a on a.fldid=fldActionId
	inner join dead.tblkartabl k on k.fldid=fldKartablNextId 
	WHERE  fldActionId=@Value and n.fldOrganId=@organId


	if (@FieldName='fldDesc')
	SELECT top(@h) n.[fldId], [fldKartablNextId], [fldActionId], n.[fldUserId], n.[fldOrganId], n.[fldDesc], n.[fldDate], n.[fldIP] 
	,a.fldTitleAction,k.fldTitleKartabl
	FROM   [Dead].[tblNextKartabl] n 
	inner join dead.tblactions a on a.fldid=fldActionId
	inner join dead.tblkartabl k on k.fldid=fldKartablNextId 
	WHERE n.fldDesc like @Value  and n.fldOrganId=@organId

	if (@FieldName='')
	SELECT top(@h) n.[fldId], [fldKartablNextId], [fldActionId], n.[fldUserId], n.[fldOrganId], n.[fldDesc], n.[fldDate], n.[fldIP] 
	,a.fldTitleAction,k.fldTitleKartabl
	FROM   [Dead].[tblNextKartabl] n 
	inner join dead.tblactions a on a.fldid=fldActionId
	inner join dead.tblkartabl k on k.fldid=fldKartablNextId 
	where   n.fldOrganId=@organId
	
	if (@FieldName='fldOrganId')
	SELECT top(@h) n.[fldId], [fldKartablNextId], [fldActionId], n.[fldUserId], n.[fldOrganId], n.[fldDesc], n.[fldDate], n.[fldIP] 
	,a.fldTitleAction,k.fldTitleKartabl
	FROM   [Dead].[tblNextKartabl] n 
	inner join dead.tblactions a on a.fldid=fldActionId
	inner join dead.tblkartabl k on k.fldid=fldKartablNextId 
	where   n.fldOrganId=@organId


		
	if (@FieldName='CheckActionId')
	SELECT top(@h) n.[fldId], [fldKartablNextId], [fldActionId], n.[fldUserId], n.[fldOrganId], n.[fldDesc], n.[fldDate], n.[fldIP] 
	,a.fldTitleAction,k.fldTitleKartabl
	FROM   [Dead].[tblNextKartabl] n 
	inner join dead.tblactions a on a.fldid=fldActionId
	inner join dead.tblkartabl k on k.fldid=fldKartablNextId 
	where fldActionId=@value


	if (@FieldName='CheckKartablNextId')
	SELECT top(@h) n.[fldId], [fldKartablNextId], [fldActionId], n.[fldUserId], n.[fldOrganId], n.[fldDesc], n.[fldDate], n.[fldIP] 
	,a.fldTitleAction,k.fldTitleKartabl
	FROM   [Dead].[tblNextKartabl] n 
	inner join dead.tblactions a on a.fldid=fldActionId
	inner join dead.tblkartabl k on k.fldid=fldKartablNextId 
	where fldKartablNextId=@value


	
	COMMIT
GO
