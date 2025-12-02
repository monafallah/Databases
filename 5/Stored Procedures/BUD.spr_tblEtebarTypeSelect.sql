SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [BUD].[spr_tblEtebarTypeSelect] 
    @fieldname nvarchar(50),
	@Value nvarchar(50),
	@fldOrganId int,
	@h int
AS 
 

	BEGIN TRAN
	
	SET @Value=Com.fn_TextNormalize(@Value)
	IF (@h=0) set @h=2147483647
	IF ( @fieldname=N'fldId')
	SELECT TOP(@h)[fldId], [fldTitle], [fldOrganId], [fldDate], [fldDesc], [fldUserId] 
	FROM   [BUD].[tblEtebarType] 
	WHERE  ([fldId] LIKE  @Value AND fldOrganId LIKE @fldOrganId ) 
	
	IF ( @fieldname=N'fldTitle')
	SELECT TOP(@h)[fldId], [fldTitle], [fldOrganId], [fldDate], [fldDesc], [fldUserId] 
	FROM   [BUD].[tblEtebarType] 
	WHERE  ([fldTitle] like @Value AND fldOrganId LIKE @fldOrganId ) 
	
	
	IF ( @fieldname=N'fldDesc')
	SELECT TOP(@h) [fldId], [fldTitle], [fldOrganId], [fldDate], [fldDesc], [fldUserId] 
	FROM   [BUD].[tblEtebarType] 
	WHERE  ([fldDesc]  LIKE  @Value AND fldOrganId LIKE @fldOrganId) 

	IF ( @fieldname=N'fldOrganId')
	SELECT TOP(@h) [fldId], [fldTitle], [fldOrganId], [fldDate], [fldDesc], [fldUserId] 
	FROM   [BUD].[tblEtebarType] 
	WHERE fldOrganId LIKE @fldOrganId 
	
	IF ( @fieldname=N'')
	SELECT TOP(@h)[fldId], [fldTitle], [fldOrganId], [fldDate], [fldDesc], [fldUserId] 
	FROM   [BUD].[tblEtebarType] 
	 

	COMMIT
GO
