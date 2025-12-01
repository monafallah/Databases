SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[prs_tblTicketPermissionSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@Value2 nvarchar(50),
	@h int
AS 
	BEGIN TRAN
	SET @Value=dbo.fn_TextNormalize(@Value)
	SET @Value2=dbo.fn_TextNormalize(@Value2)
	if (@h=0) set @h=2147483647
	if (@fieldname=N'fldId')
	SELECT top(@h) [fldId], [fldCategoryId], [fldTicketUserId], [fldSee], [fldAnswer],  [fldDesc]
	FROM   [dbo].[tblTicketPermission] 
	WHERE  fldId = @Value

	if (@fieldname=N'fldCategoryId')
	SELECT top(@h) [fldId], [fldCategoryId], [fldTicketUserId], [fldSee], [fldAnswer],[fldDesc]
	FROM   [dbo].[tblTicketPermission] 
	WHERE  fldCategoryId like @Value

	if (@fieldname=N'fldCategoryId_User')
	SELECT top(@h) [fldId], [fldCategoryId], [fldTicketUserId], [fldSee], [fldAnswer],[fldDesc]
	FROM   [dbo].[tblTicketPermission] 
	WHERE  fldCategoryId = @Value and fldTicketUserId=@Value2

	if (@fieldname=N'fldTicketUserId')
	SELECT top(@h) [fldId], [fldCategoryId], [fldTicketUserId], [fldSee], [fldAnswer],[fldDesc]
	FROM   [dbo].[tblTicketPermission] 
	WHERE  fldTicketUserId=@Value

	if (@fieldname=N'')
	SELECT top(@h) [fldId], [fldCategoryId], [fldTicketUserId], [fldSee], [fldAnswer],[fldDesc]
	FROM   [dbo].[tblTicketPermission] 

	COMMIT
GO
