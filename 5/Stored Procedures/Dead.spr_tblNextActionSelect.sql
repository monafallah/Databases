SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Dead].[spr_tblNextActionSelect] 
@FieldName nvarchar(50),
@Value nvarchar(50),
@OrganId int,
@h int

AS 

	BEGIN TRAN
	if (@h=0) set @h=2147483647
	set @Value= com.fn_TextNormalize(@Value)

	if (@FieldName='fldId')
	SELECT top(@h) n.[fldId], n.[fldAction_NextId], n.[fldKartablId], n.[fldUserId], n.[fldOrganId], n.[fldIP], n.[fldDesc], n.[fldDate] 
	,a.fldTitleAction,k.fldTitleKartabl
	FROM   [Dead].[tblNextAction] n 
	inner join dead.tblactions a on a.fldid=fldAction_NextId
	inner join dead.tblkartabl k on k.fldid=fldKartablId
	WHERE  n.fldId=@Value and n.[fldOrganId]=@OrganId

	if (@FieldName='fldAction_NextId')
	SELECT top(@h) n.[fldId], n.[fldAction_NextId], n.[fldKartablId], n.[fldUserId], n.[fldOrganId], n.[fldIP], n.[fldDesc], n.[fldDate] 
	,a.fldTitleAction,k.fldTitleKartabl
	FROM   [Dead].[tblNextAction] n 
	inner join dead.tblactions a on a.fldid=fldAction_NextId
	inner join dead.tblkartabl k on k.fldid=fldKartablId
	WHERE  n.fldAction_NextId=@Value and n.[fldOrganId]=@OrganId

	if (@FieldName='fldKartablId')
	SELECT top(@h) n.[fldId], n.[fldAction_NextId], n.[fldKartablId], n.[fldUserId], n.[fldOrganId], n.[fldIP], n.[fldDesc], n.[fldDate] 
	,a.fldTitleAction,k.fldTitleKartabl
	FROM   [Dead].[tblNextAction] n 
	inner join dead.tblactions a on a.fldid=fldAction_NextId
	inner join dead.tblkartabl k on k.fldid=fldKartablId
	WHERE  n.fldKartablId=@Value and n.[fldOrganId]=@OrganId

	if (@FieldName='fldDesc')
		SELECT top(@h) n.[fldId], n.[fldAction_NextId], n.[fldKartablId], n.[fldUserId], n.[fldOrganId], n.[fldIP], n.[fldDesc], n.[fldDate] 
	,a.fldTitleAction,k.fldTitleKartabl
	FROM   [Dead].[tblNextAction] n 
	inner join dead.tblactions a on a.fldid=fldAction_NextId
	inner join dead.tblkartabl k on k.fldid=fldKartablId
	WHERE  n.fldDesc like @Value and n.[fldOrganId]=@OrganId

		if (@FieldName='fldTitleAction')
		SELECT top(@h) n.[fldId], n.[fldAction_NextId], n.[fldKartablId], n.[fldUserId], n.[fldOrganId], n.[fldIP], n.[fldDesc], n.[fldDate] 
	,a.fldTitleAction,k.fldTitleKartabl
	FROM   [Dead].[tblNextAction] n 
	inner join dead.tblactions a on a.fldid=fldAction_NextId
	inner join dead.tblkartabl k on k.fldid=fldKartablId
	WHERE  a.fldTitleAction like @Value and n.[fldOrganId]=@OrganId


		if (@FieldName='fldTitleKartabl')
		SELECT top(@h) n.[fldId], n.[fldAction_NextId], n.[fldKartablId], n.[fldUserId], n.[fldOrganId], n.[fldIP], n.[fldDesc], n.[fldDate] 
	,a.fldTitleAction,k.fldTitleKartabl
	FROM   [Dead].[tblNextAction] n 
	inner join dead.tblactions a on a.fldid=fldAction_NextId
	inner join dead.tblkartabl k on k.fldid=fldKartablId
	WHERE  fldTitleKartabl like @Value and n.[fldOrganId]=@OrganId


	if (@FieldName='')
	SELECT top(@h) n.[fldId], n.[fldAction_NextId], n.[fldKartablId], n.[fldUserId], n.[fldOrganId], n.[fldIP], n.[fldDesc], n.[fldDate] 
	,a.fldTitleAction,k.fldTitleKartabl
	FROM   [Dead].[tblNextAction] n 
	inner join dead.tblactions a on a.fldid=fldAction_NextId
	inner join dead.tblkartabl k on k.fldid=fldKartablId
	where  n.[fldOrganId]=@OrganId

	if (@FieldName='fldOrganId')
	SELECT top(@h) n.[fldId], n.[fldAction_NextId], n.[fldKartablId], n.[fldUserId], n.[fldOrganId], n.[fldIP], n.[fldDesc], n.[fldDate] 
	,a.fldTitleAction,k.fldTitleKartabl
	FROM   [Dead].[tblNextAction] n 
	inner join dead.tblactions a on a.fldid=fldAction_NextId
	inner join dead.tblkartabl k on k.fldid=fldKartablId 
	where  n.[fldOrganId]=@OrganId


		if (@FieldName='CheckKartablId')
	SELECT top(@h) n.[fldId], n.[fldAction_NextId], n.[fldKartablId], n.[fldUserId], n.[fldOrganId], n.[fldIP], n.[fldDesc], n.[fldDate] 
	,a.fldTitleAction,k.fldTitleKartabl
	FROM   [Dead].[tblNextAction] n 
	inner join dead.tblactions a on a.fldid=fldAction_NextId
	inner join dead.tblkartabl k on k.fldid=fldKartablId 
	where  n.fldKartablId=@value
	

	
		if (@FieldName='CheckActionId')
	SELECT top(@h) n.[fldId], n.[fldAction_NextId], n.[fldKartablId], n.[fldUserId], n.[fldOrganId], n.[fldIP], n.[fldDesc], n.[fldDate] 
	,a.fldTitleAction,k.fldTitleKartabl
	FROM   [Dead].[tblNextAction] n 
	inner join dead.tblactions a on a.fldid=fldAction_NextId
	inner join dead.tblkartabl k on k.fldid=fldKartablId 
	where  n.fldAction_NextId=@value
	COMMIT
GO
