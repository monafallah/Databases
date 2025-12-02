SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblKala_TreeSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@OrganId int,
	@h int
AS 
	BEGIN TRAN
	if (@h=0) set @h=2147483647
	if (@fieldname=N'fldId')
	SELECT top(@h) [fldId], [fldKalaId], [fldKalaTreeId], [fldDesc], [fldDate], [fldIP], [fldUserId] 
	,fldOrganId
	FROM   com.[tblKala_Tree] 
	WHERE  fldId = @Value and fldOrganId=@OrganId

	if (@fieldname=N'fldDesc')
	SELECT top(@h) [fldId], [fldKalaId], [fldKalaTreeId], [fldDesc], [fldDate], [fldIP], [fldUserId] 
	,fldOrganId
	FROM   com.[tblKala_Tree] 
	WHERE fldDesc like  @Value  and fldOrganId=@OrganId

	if (@fieldname=N'fldOrganId')
	SELECT top(@h) [fldId], [fldKalaId], [fldKalaTreeId], [fldDesc], [fldDate], [fldIP], [fldUserId] 
	,fldOrganId
	FROM   com.[tblKala_Tree] 
	WHERE fldOrganId like  @OrganId

	if (@fieldname=N'')
	SELECT top(@h) [fldId], [fldKalaId], [fldKalaTreeId], [fldDesc], [fldDate], [fldIP], [fldUserId] 
	,fldOrganId
	FROM   com.[tblKala_Tree] 

	COMMIT
GO
