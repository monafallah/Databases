SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblKalaGroupSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@OrganId int,
	@h int
AS 
	BEGIN TRAN
	if (@h=0) set @h=2147483647
	if (@fieldname=N'fldId')
	SELECT top(@h) [fldId], [fldName], [fldDesc], [fldDate], [fldIP], [fldUserId] 
	FROM   com.[tblKalaGroup] 
	WHERE  fldId = @Value and fldOrganId=@OrganId

		if (@fieldname=N'fldName')
	SELECT top(@h) [fldId], [fldName], [fldDesc], [fldDate], [fldIP], [fldUserId] 
	FROM   com.[tblKalaGroup] 
	WHERE  fldId = @Value and fldOrganId=@OrganId

	if (@fieldname=N'fldDesc')
	SELECT top(@h) [fldId], [fldName], [fldDesc], [fldDate], [fldIP], [fldUserId] 
	FROM   com.[tblKalaGroup] 
	WHERE fldDesc like  @Value and fldOrganId=@OrganId

	if (@fieldname=N'fldOrganId')
	SELECT top(@h) [fldId], [fldName], [fldDesc], [fldDate], [fldIP], [fldUserId] 
	FROM   com.[tblKalaGroup] 

	where  fldOrganId=@OrganId
	COMMIT
GO
