SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [ACC].[spr_tblTree_CenterCostUpdate] 
    @fldId int,
    @fldCenterCoId int,
    @fldCostTreeId int,
    @fldDesc nvarchar(MAX),
    
    @fldIP varchar(16),
    @fldUserId int
AS 
	BEGIN TRAN
	
	
	SET @fldDesc=Com.fn_TextNormalize(@fldDesc) 
	UPDATE [ACC].[tblTree_CenterCost]
	SET    [fldId] = @fldId, [fldCenterCoId] = @fldCenterCoId, [fldCostTreeId] = @fldCostTreeId, [fldDesc] = @fldDesc, [fldDate] = GETDATE(), [fldIP] = @fldIP, [fldUserId] = @fldUserId
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
