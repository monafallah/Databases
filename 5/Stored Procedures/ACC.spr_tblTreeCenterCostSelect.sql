SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [ACC].[spr_tblTreeCenterCostSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@Value2 NVARCHAR(50),
	@fldOrganId INT,
	@h int
AS 
	BEGIN TRAN
	
	SET @Value=Com.fn_TextNormalize(@Value)
	if (@h=0) set @h=2147483647
	if (@fieldname=N'fldId')
	SELECT top(@h) [fldId], [fldOrganId], [fldGroupCenterCoId],[fldPID], [fldName], [fldDesc], [fldDate], [fldIP], [fldUserId],1 as fldNodeType,0 fldCenter_treeId  
	FROM   [ACC].[tblTreeCenterCost] 
	WHERE  fldId = @Value AND fldOrganId=@fldOrganId
	
	
	IF (@fieldname=N'fldPID')
	BEGIN 
	IF (@Value=0)
	BEGIN
	SELECT top(@h) [fldId], [fldOrganId], [fldGroupCenterCoId],[fldPID], [fldName], [fldDesc], [fldDate], [fldIP], [fldUserId],1 as fldNodeType,0 fldCenter_treeId 
	FROM   [ACC].[tblTreeCenterCost] 
	WHERE  fldPID is null and fldGroupCenterCoId=@Value2
	END
	 
	ELSE
	begin
	SELECT top(@h) [fldId], [fldOrganId], [fldGroupCenterCoId],[fldPID], [fldName], [fldDesc], [fldDate], [fldIP], [fldUserId],1 as fldNodeType,0 fldCenter_treeId  
	FROM   [ACC].[tblTreeCenterCost] 
	WHERE fldPID=@Value AND fldOrganId=@fldOrganId
	
	UNION ALL
	
	
	SELECT ACC.tblTreeCenterCost.fldId,ACC.tblTree_CenterCost.fldCenterCoId,cast(@Value2 as int)fldGroupCenterCoId,ACC.tblTreeCenterCost.fldPID,
	ACC.tblTreeCenterCost.fldName,ACC.tblTreeCenterCost.fldDesc, ACC.tblTreeCenterCost.fldDate,ACC.tblTreeCenterCost.fldIP,
	 ACC.tblTreeCenterCost.fldUserId,2 as fldNodeType,ACC.tblTree_CenterCost.fldId  fldCenter_treeId
	 FROM ACC.tblTreeCenterCost INNER JOIN ACC.tblTree_CenterCost
	ON tblTree_CenterCost.fldCostTreeId = tblTreeCenterCost.fldId
	WHERE fldCenterCoId=@Value AND fldOrganId=@fldOrganId
	END
	end
	

	if (@fieldname=N'fldDesc')
	SELECT top(@h) [fldId], [fldOrganId], [fldGroupCenterCoId],[fldPID], [fldName], [fldDesc], [fldDate], [fldIP], [fldUserId],1 as fldNodeType,0 fldCenter_treeId  
	FROM   [ACC].[tblTreeCenterCost] 
	WHERE fldDesc like  @Value AND fldOrganId=@fldOrganId

	if (@fieldname=N'')
	SELECT top(@h) [fldId], [fldOrganId], [fldGroupCenterCoId],[fldPID], [fldName], [fldDesc], [fldDate], [fldIP], [fldUserId] ,1 as fldNodeType,0 fldCenter_treeId 
	FROM   [ACC].[tblTreeCenterCost] 
	
	
	if (@fieldname=N'fldGroupCenterCoId')
	SELECT top(@h) [fldId], [fldOrganId], [fldGroupCenterCoId],[fldPID], [fldName], [fldDesc], [fldDate], [fldIP], [fldUserId],1 as fldNodeType,0 fldCenter_treeId  
	FROM   [ACC].[tblTreeCenterCost] 
	WHERE fldGroupCenterCoId like  @Value

	COMMIT
GO
