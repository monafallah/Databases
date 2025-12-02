SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblKalaTreeSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@Value2 nvarchar(50),
	@OrganId int,
	@h int
AS 
	BEGIN TRAN
	if (@h=0) set @h=2147483647
	if (@fieldname=N'fldId')
	SELECT top(@h) [fldId], [fldPID], fldGroupId,[fldName], [fldDesc], [fldDate], [fldIP], [fldUserId],1 as fldNodeType 
	,fldOrganId
	FROM   [com].[tblKalaTree] 
	WHERE  fldId = @Value and fldOrganId=@OrganId

	if (@fieldname=N'fldPID')
	BEGIN
	
	if(@Value=0)
	begin
	SELECT top(@h) [fldId], [fldPID],fldGroupId, [fldName], [fldDesc], [fldDate], [fldIP], [fldUserId],1 as fldNodeType
			FROM   [com].[tblKalaTree] 
			,fldOrganId
			WHERE  fldPID IS NULL  AND fldGroupId=@Value2 and fldOrganId=@OrganId
			END 
			ELSE 
			
			BEGIN 
			SELECT top(@h) [fldId], [fldPID],fldGroupId, [fldName], [fldDesc], [fldDate], [fldIP], [fldUserId],1 as fldNodeType
			FROM   [com].[tblKalaTree] 
			,fldOrganId
			WHERE  fldPID = @Value  and fldOrganId=@OrganId
			union all
			SELECT    com.tblKala.fldId,tblkala_Tree.fldKalaTreeId, cast(@Value2 as int)fldGroupId,com.tblKala.fldName, com.tblKala.fldDesc, com.tblKala.fldDate, com.tblKala.fldIP, com.tblKala.fldUserId,2 as fldNodeType
			,fldOrganId
			FROM            com.tblKala INNER JOIN com.tblKala_Tree ON com.tblKala.fldId=tblkala_Tree.fldkalaId
			WHERE  tblKala_Tree.fldKalaTreeId = @Value and fldOrganId=@OrganId
	END
	end

	if(@fieldname=N'AllTree')
	begin
		;with temp
		as
		(
			select * from com.tblKalaTree where fldID=@Value  and fldOrganId=@OrganId
			union all
			select com.tblKalaTree.* from com.tblKalaTree inner join temp on com.tblKalaTree.fldPID=temp.fldId
			where  tblKalaTree.fldOrganId=@OrganId
		)
		select * from temp
	end

	if (@fieldname=N'root')
	SELECT top(@h) [fldId], [fldPID],fldGroupId, [fldName], [fldDesc], [fldDate], [fldIP], [fldUserId],1 as fldNodeType 
	,fldOrganId
	FROM   [com].[tblKalaTree] 
	where fldPID is null and fldOrganId=@OrganId

	if (@fieldname=N'root_fldId')
	SELECT top(@h) [fldId], [fldPID],fldGroupId, [fldName], [fldDesc], [fldDate], [fldIP], [fldUserId] ,1 as fldNodeType
	,fldOrganId
	FROM   [com].[tblKalaTree] 
	WHERE  fldPID is null and fldId=@Value and fldOrganId=@OrganId

	if (@fieldname=N'root_fldName')
	SELECT top(@h) [fldId], [fldPID],fldGroupId, [fldName], [fldDesc], [fldDate], [fldIP], [fldUserId] ,1 as fldNodeType
	,fldOrganId
	FROM   [com].[tblKalaTree] 
	WHERE  fldPID is null and fldName=@Value and fldOrganId=@OrganId

	if (@fieldname=N'root_fldDesc')
	SELECT top(@h) [fldId], [fldPID],fldGroupId, [fldName], [fldDesc], [fldDate], [fldIP], [fldUserId] ,1 as fldNodeType
	,fldOrganId
	FROM   [com].[tblKalaTree] 
	WHERE  fldPID is null and fldDesc=@Value and fldOrganId=@OrganId


	if (@fieldname=N'fldDesc')
	SELECT top(@h) [fldId], [fldPID], fldGroupId,[fldName], [fldDesc], [fldDate], [fldIP], [fldUserId] ,1 as fldNodeType
	,fldOrganId
	FROM   [com].[tblKalaTree] 
	WHERE fldDesc like  @Value and fldOrganId=@OrganId

	if (@fieldname=N'')
	SELECT top(@h) [fldId], [fldPID],fldGroupId, [fldName], [fldDesc], [fldDate], [fldIP], [fldUserId] ,1 as fldNodeType
	,fldOrganId
	FROM   [com].[tblKalaTree] 

		if (@fieldname=N'fldOrganId')
	SELECT top(@h) [fldId], [fldPID],fldGroupId, [fldName], [fldDesc], [fldDate], [fldIP], [fldUserId] ,1 as fldNodeType
	,fldOrganId
	FROM   [com].[tblKalaTree] 
	where fldOrganId =@OrganId

	
	if (@fieldname=N'fldGroupId')
	SELECT top(@h) [fldId], [fldPID], fldGroupId,[fldName], [fldDesc], [fldDate], [fldIP], [fldUserId] ,1 as fldNodeType
	,fldOrganId
	FROM   [com].[tblKalaTree] 
	WHERE fldGroupId like  @Value and fldOrganId=@OrganId
	

	COMMIT
GO
