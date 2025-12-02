SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [ACC].[spr_tblCenterCostSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@fldOrganId INT,
	@h int
AS 
	BEGIN TRAN
	
	SET @Value=Com.fn_TextNormalize(@Value)
	if (@h=0) set @h=2147483647
	if (@fieldname=N'fldId')
	SELECT top(@h) [fldId], [fldOrganId], [fldNameCenter], [fldDesc], [fldDate], [fldIP], [fldUserId] 
	FROM   [ACC].[tblCenterCost] 
	WHERE  fldId = @Value AND fldOrganId=@fldOrganId

	if (@fieldname=N'fldDesc')
	SELECT top(@h) [fldId], [fldOrganId], [fldNameCenter], [fldDesc], [fldDate], [fldIP], [fldUserId] 
	FROM   [ACC].[tblCenterCost] 
	WHERE fldDesc like  @Value AND fldOrganId=@fldOrganId

	if (@fieldname=N'fldOrganId')
	SELECT top(@h) [fldId], [fldOrganId], [fldNameCenter], [fldDesc], [fldDate], [fldIP], [fldUserId] 
	FROM   [ACC].[tblCenterCost] 
	WHERE fldOrganId=@fldOrganId

	if (@fieldname=N'')
	SELECT top(@h) [fldId], [fldOrganId], [fldNameCenter], [fldDesc], [fldDate], [fldIP], [fldUserId] 
	FROM   [ACC].[tblCenterCost]
	where fldOrganId=@fldOrganId
	
	
	if (@fieldname=N'fldNameCenter')
	SELECT top(@h) [fldId], [fldOrganId], [fldNameCenter], [fldDesc], [fldDate], [fldIP], [fldUserId] 
	FROM   [ACC].[tblCenterCost] 
	WHERE fldNameCenter like  @Value AND fldOrganId=@fldOrganId 

	COMMIT
GO
