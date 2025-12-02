SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [ACC].[spr_tblCenterCostUpdate] 
    @fldId int,
    @fldOrganId int,
    @fldNameCenter nvarchar(100),
    @fldDesc nvarchar(MAX),
    
    @fldIP varchar(16),
    @fldUserId int
AS 
	BEGIN TRAN
	
	SET @fldNameCenter=Com.fn_TextNormalize(@fldNameCenter)
	SET @fldDesc=Com.fn_TextNormalize(@fldDesc) 
	
	UPDATE [ACC].[tblCenterCost]
	SET    [fldId] = @fldId, [fldOrganId] = @fldOrganId, [fldNameCenter] = @fldNameCenter, [fldDesc] = @fldDesc, [fldDate] = GETDATE(), [fldIP] = @fldIP, [fldUserId] = @fldUserId
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
