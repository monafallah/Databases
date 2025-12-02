SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [ACC].[spr_tblTree_CenterCostInsert] 
  
    @fldCenterCoId int,
    @fldCostTreeId int,
    @fldDesc nvarchar(MAX),
    
    @fldIP varchar(16),
    @fldUserId int
AS 
	
	BEGIN TRAN
	
	
	SET @fldDesc=Com.fn_TextNormalize(@fldDesc) 
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [ACC].[tblTree_CenterCost] 
	INSERT INTO [ACC].[tblTree_CenterCost] ([fldId], [fldCenterCoId], [fldCostTreeId], [fldDesc], [fldDate], [fldIP], [fldUserId])
	SELECT @fldId, @fldCenterCoId, @fldCostTreeId, @fldDesc, GETDATE(), @fldIP, @fldUserId
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
