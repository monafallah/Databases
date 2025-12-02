SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Str].[spr_tblAnbarTreeSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@Value2 nvarchar(50),
	@h int
AS 
	BEGIN TRAN
	Declare @Nod int
	if (@h=0) set @h=2147483647
	if (@fieldname=N'fldId')
	SELECT top(@h) [fldId], [fldPID],fldGroupId, [fldName], [fldDesc], [fldDate], [fldIP], [fldUserId],1 as fldNodeType ,0 fldAnbar_treeId
	FROM   [Str].[tblAnbarTree] 
	WHERE  fldId = @Value


	if (@fieldname=N'fldPID')
	begin
		if(@Value=0)
		begin
			SELECT top(@h) [fldId], [fldPID],fldGroupId, [fldName], [fldDesc], [fldDate], [fldIP], [fldUserId],1 as fldNodeType,0 fldAnbar_treeId
			FROM   [Str].[tblAnbarTree] 
			WHERE  fldPID is null and fldGroupId=@Value2
		end
		else
		begin
			SELECT top(@h) [fldId], [fldPID],fldGroupId, [fldName], [fldDesc], [fldDate], [fldIP], [fldUserId],1 as fldNodeType,0 fldAnbar_treeId
			FROM   [Str].[tblAnbarTree] 
			WHERE  fldPID = @Value
			union all
			SELECT    Str.tblAnbar.fldId,tblAnbar_Tree.fldAnbarTreeId, cast(@Value2 as int)fldGroupId,tblAnbar.fldName, tblAnbar.fldDesc, tblAnbar.fldDate, tblAnbar.fldIP, tblAnbar.fldUserId,2 as fldNodeType,tblAnbar_Tree.fldId  fldAnbar_treeId
			FROM            Str.tblAnbar inner join tblAnbar_Tree on
			tblAnbar.fldId=tblAnbar_Tree.fldAnbarId
			WHERE  fldAnbarTreeId = @Value
		end
	end
	
	if (@fieldname=N'fldDesc')
	SELECT top(@h) [fldId], [fldPID],fldGroupId, [fldName], [fldDesc], [fldDate], [fldIP], [fldUserId],1 as fldNodeType ,0 fldAnbar_treeId
	FROM   [Str].[tblAnbarTree] 
	WHERE fldDesc like  @Value

	if (@fieldname=N'')
	SELECT top(@h) [fldId], [fldPID],fldGroupId, [fldName], [fldDesc], [fldDate], [fldIP], [fldUserId] ,1 as fldNodeType,0 fldAnbar_treeId
	FROM   [Str].[tblAnbarTree]
	
	
	if (@fieldname=N'fldName')
	SELECT top(@h) [fldId], [fldPID],fldGroupId, [fldName], [fldDesc], [fldDate], [fldIP], [fldUserId],1 as fldNodeType ,0 fldAnbar_treeId
	FROM   [Str].[tblAnbarTree] 
	WHERE  fldName = @Value 
	
	
	if (@fieldname=N'fldGroupId')
	SELECT top(@h) [fldId], [fldPID],fldGroupId, [fldName], [fldDesc], [fldDate], [fldIP], [fldUserId],1 as fldNodeType ,0 fldAnbar_treeId
	FROM   [Str].[tblAnbarTree] 
	WHERE  fldGroupId = @Value

	COMMIT
GO
