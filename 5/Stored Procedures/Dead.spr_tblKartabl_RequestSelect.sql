SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Dead].[spr_tblKartabl_RequestSelect] 
@FieldName nvarchar(50),
@Value nvarchar(50),
@organId int,
@h int

AS 

	BEGIN TRAN
	if (@h=0) set @h=2147483647
	set @Value=com.fn_TextNormalize(@Value)

	if (@FieldName='fldId')
	SELECT top(@h) [fldId], [fldKartablId], [fldActionId], [fldRequestId], [fldUserId], [fldOrganId], [fldIP], [fldDesc], [fldDate] 
	,fldKartablNextId
	FROM   [Dead].[tblKartabl_Request] 
	WHERE  fldId=@Value and [fldOrganId]=@organId

	if (@FieldName='fldDesc')
	SELECT top(@h) [fldId], [fldKartablId], [fldActionId], [fldRequestId], [fldUserId], [fldOrganId], [fldIP], [fldDesc], [fldDate] 
	,fldKartablNextId
	FROM   [Dead].[tblKartabl_Request] 
	WHERE  fldDesc like @Value  and [fldOrganId]=@organId

	if (@FieldName='fldOrganId')
	SELECT top(@h) [fldId], [fldKartablId], [fldActionId], [fldRequestId], [fldUserId], [fldOrganId], [fldIP], [fldDesc], [fldDate] 
	,fldKartablNextId
	FROM   [Dead].[tblKartabl_Request] 
	WHERE  [fldOrganId]=@organId

	if (@FieldName='')
	SELECT top(@h) [fldId], [fldKartablId], [fldActionId], [fldRequestId], [fldUserId], [fldOrganId], [fldIP], [fldDesc], [fldDate] 
	,fldKartablNextId
	FROM   [Dead].[tblKartabl_Request]
	where   [fldOrganId]=@organId 

	if (@FieldName='CheckActionId')
	SELECT top(@h) [fldId], [fldKartablId], [fldActionId], [fldRequestId], [fldUserId], [fldOrganId], [fldIP], [fldDesc], [fldDate] 
	,fldKartablNextId
	FROM   [Dead].[tblKartabl_Request] 
	WHERE  fldActionId like @Value  

	if (@FieldName='CheckKartablId')
	SELECT top(@h) [fldId], [fldKartablId], [fldActionId], [fldRequestId], [fldUserId], [fldOrganId], [fldIP], [fldDesc], [fldDate] 
	,fldKartablNextId
	FROM   [Dead].[tblKartabl_Request] 
	WHERE  fldKartablId like @Value  
	
	COMMIT
GO
