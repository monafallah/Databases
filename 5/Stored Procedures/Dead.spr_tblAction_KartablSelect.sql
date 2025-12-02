SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Dead].[spr_tblAction_KartablSelect] 
@FieldName nvarchar(50),
@Value nvarchar(50),
@OrganId int,
@h int

AS 

	BEGIN TRAN
	if (@h=0) set @h=2147483647
	set @Value=com.fn_TextNormalize(@Value)

	if (@FieldName='fldId')
	SELECT top(@h) [tblAction_Kartabl].[fldId], [tblAction_Kartabl].[fldActionId], [tblAction_Kartabl].[fldKartablId], [tblAction_Kartabl].[fldUserId],[tblAction_Kartabl]. [fldIP], [tblAction_Kartabl].[fldDesc], [tblAction_Kartabl].[fldDate] ,[tblAction_Kartabl].fldOrganId 
	,fldTitleAction,fldTitleKartabl
	FROM   [Dead].[tblAction_Kartabl]
	inner join dead.tblactions a on a.fldid= fldActionId
	inner join dead.tblkartabl k on k.fldid=fldKartablId
	WHERE  [tblAction_Kartabl].fldId=@Value and [tblAction_Kartabl].fldOrganId=@OrganId

	if (@FieldName='fldActionId')
	SELECT top(@h) [tblAction_Kartabl].[fldId], [tblAction_Kartabl].[fldActionId], [tblAction_Kartabl].[fldKartablId], [tblAction_Kartabl].[fldUserId],[tblAction_Kartabl]. [fldIP], [tblAction_Kartabl].[fldDesc], [tblAction_Kartabl].[fldDate] ,[tblAction_Kartabl].fldOrganId 
	,fldTitleAction,fldTitleKartabl
	FROM   [Dead].[tblAction_Kartabl]
	inner join dead.tblactions a on a.fldid= fldActionId
	inner join dead.tblkartabl k on k.fldid=fldKartablId
	WHERE  [tblAction_Kartabl].fldActionId=@Value and [tblAction_Kartabl].fldOrganId=@OrganId

		if (@FieldName='fldKartablId')
	SELECT top(@h) [tblAction_Kartabl].[fldId], [tblAction_Kartabl].[fldActionId], [tblAction_Kartabl].[fldKartablId], [tblAction_Kartabl].[fldUserId],[tblAction_Kartabl]. [fldIP], [tblAction_Kartabl].[fldDesc], [tblAction_Kartabl].[fldDate] ,[tblAction_Kartabl].fldOrganId 
	,fldTitleAction,fldTitleKartabl
	FROM   [Dead].[tblAction_Kartabl]
	inner join dead.tblactions a on a.fldid= fldActionId
	inner join dead.tblkartabl k on k.fldid=fldKartablId
	WHERE  [tblAction_Kartabl].fldKartablId=@Value and [tblAction_Kartabl].fldOrganId=@OrganId

		if (@FieldName='fldTitleAction')
	SELECT top(@h) [tblAction_Kartabl].[fldId], [tblAction_Kartabl].[fldActionId], [tblAction_Kartabl].[fldKartablId], [tblAction_Kartabl].[fldUserId],[tblAction_Kartabl]. [fldIP], [tblAction_Kartabl].[fldDesc], [tblAction_Kartabl].[fldDate] ,[tblAction_Kartabl].fldOrganId 
	,fldTitleAction,fldTitleKartabl
	FROM   [Dead].[tblAction_Kartabl]
	inner join dead.tblactions a on a.fldid= fldActionId
	inner join dead.tblkartabl k on k.fldid=fldKartablId
	WHERE  fldTitleKartabl like @Value and [tblAction_Kartabl].fldOrganId=@OrganId

	if (@FieldName='fldTitleKartabl')
	SELECT top(@h) [tblAction_Kartabl].[fldId], [tblAction_Kartabl].[fldActionId], [tblAction_Kartabl].[fldKartablId], [tblAction_Kartabl].[fldUserId],[tblAction_Kartabl]. [fldIP], [tblAction_Kartabl].[fldDesc], [tblAction_Kartabl].[fldDate] ,[tblAction_Kartabl].fldOrganId 
	,fldTitleAction,fldTitleKartabl
	FROM   [Dead].[tblAction_Kartabl]
	inner join dead.tblactions a on a.fldid= fldActionId
	inner join dead.tblkartabl k on k.fldid=fldKartablId
	WHERE  fldTitleKartabl like @Value and [tblAction_Kartabl].fldOrganId=@OrganId


	if (@FieldName='fldDesc')
	SELECT top(@h) [tblAction_Kartabl].[fldId], [tblAction_Kartabl].[fldActionId], [tblAction_Kartabl].[fldKartablId], [tblAction_Kartabl].[fldUserId],[tblAction_Kartabl]. [fldIP], [tblAction_Kartabl].[fldDesc], [tblAction_Kartabl].[fldDate] ,[tblAction_Kartabl].fldOrganId 
	,fldTitleAction,fldTitleKartabl
	FROM   [Dead].[tblAction_Kartabl]
	inner join dead.tblactions a on a.fldid= fldActionId
	inner join dead.tblkartabl k on k.fldid=fldKartablId
	WHERE  [tblAction_Kartabl].fldDesc like @Value and [tblAction_Kartabl].fldOrganId=@OrganId

	if (@FieldName='')
	SELECT top(@h) [tblAction_Kartabl].[fldId], [tblAction_Kartabl].[fldActionId], [tblAction_Kartabl].[fldKartablId], [tblAction_Kartabl].[fldUserId],[tblAction_Kartabl]. [fldIP], [tblAction_Kartabl].[fldDesc], [tblAction_Kartabl].[fldDate] ,[tblAction_Kartabl].fldOrganId 
	,fldTitleAction,fldTitleKartabl
	FROM   [Dead].[tblAction_Kartabl]
	inner join dead.tblactions a on a.fldid= fldActionId
	inner join dead.tblkartabl k on k.fldid=fldKartablId
	where  [tblAction_Kartabl].fldOrganId=@OrganId

	if (@FieldName='fldOrganId')
	SELECT top(@h) [tblAction_Kartabl].[fldId], [tblAction_Kartabl].[fldActionId], [tblAction_Kartabl].[fldKartablId], [tblAction_Kartabl].[fldUserId],[tblAction_Kartabl]. [fldIP], [tblAction_Kartabl].[fldDesc], [tblAction_Kartabl].[fldDate] ,[tblAction_Kartabl].fldOrganId 
	,fldTitleAction,fldTitleKartabl
	FROM   [Dead].[tblAction_Kartabl]
	inner join dead.tblactions a on a.fldid= fldActionId
	inner join dead.tblkartabl k on k.fldid=fldKartablId 
	where  [tblAction_Kartabl].fldOrganId=@OrganId

	if (@FieldName='CheckActionId')
	SELECT top(@h) [tblAction_Kartabl].[fldId], [tblAction_Kartabl].[fldActionId], [tblAction_Kartabl].[fldKartablId], [tblAction_Kartabl].[fldUserId],[tblAction_Kartabl]. [fldIP], [tblAction_Kartabl].[fldDesc], [tblAction_Kartabl].[fldDate] ,[tblAction_Kartabl].fldOrganId 
	,fldTitleAction,fldTitleKartabl
	FROM   [Dead].[tblAction_Kartabl]
	inner join dead.tblactions a on a.fldid= fldActionId
	inner join dead.tblkartabl k on k.fldid=fldKartablId 
	where  [tblAction_Kartabl].fldActionId=@value


		if (@FieldName='CheckKartablId')
	SELECT top(@h) [tblAction_Kartabl].[fldId], [tblAction_Kartabl].[fldActionId], [tblAction_Kartabl].[fldKartablId], [tblAction_Kartabl].[fldUserId],[tblAction_Kartabl]. [fldIP], [tblAction_Kartabl].[fldDesc], [tblAction_Kartabl].[fldDate] ,[tblAction_Kartabl].fldOrganId 
	,fldTitleAction,fldTitleKartabl
	FROM   [Dead].[tblAction_Kartabl]
	inner join dead.tblactions a on a.fldid= fldActionId
	inner join dead.tblkartabl k on k.fldid=fldKartablId 
	where  [tblAction_Kartabl].fldKartablId=@value

	
	COMMIT
GO
