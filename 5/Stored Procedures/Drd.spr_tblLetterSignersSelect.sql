SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblLetterSignersSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@h int
AS 
	BEGIN TRAN
	set  @Value=com.fn_TextNormalize(@Value)
	if (@h=0) set @h=2147483647
	if (@fieldname=N'fldId')
	SELECT top(@h) [fldId], [fldLetterMinutId], [fldOrganizationalPostsId], [fldUserId], [fldDesc], [fldDate] 
	FROM   [Drd].[tblLetterSigners] 
	WHERE  fldId = @Value

	if (@fieldname=N'fldDesc')
	SELECT top(@h) [fldId], [fldLetterMinutId], [fldOrganizationalPostsId], [fldUserId], [fldDesc], [fldDate] 
	FROM   [Drd].[tblLetterSigners] 
	WHERE  fldDesc like @Value

	if (@fieldname=N'fldLetterMinutId')
	SELECT top(@h) [fldId], [fldLetterMinutId], [fldOrganizationalPostsId], [fldUserId], [fldDesc], [fldDate] 
	FROM   [Drd].[tblLetterSigners] 
	WHERE  fldLetterMinutId = @Value

	if (@fieldname=N'fldOrganizationalPostsId')
	SELECT top(@h) [fldId], [fldLetterMinutId], [fldOrganizationalPostsId], [fldUserId], [fldDesc], [fldDate] 
	FROM   [Drd].[tblLetterSigners] 
	WHERE  fldOrganizationalPostsId = @Value

	if (@fieldname=N'')
	SELECT top(@h) [fldId], [fldLetterMinutId], [fldOrganizationalPostsId], [fldUserId], [fldDesc], [fldDate] 
	FROM   [Drd].[tblLetterSigners] 

	COMMIT
GO
