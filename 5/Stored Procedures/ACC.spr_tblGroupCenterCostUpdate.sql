SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [ACC].[spr_tblGroupCenterCostUpdate] 
    @fldId int,
    @fldOrganId int,
    @fldNameGroup nvarchar(100),
    @fldDesc nvarchar(MAX),
   
    @fldIP varchar(16),
    @fldUserId int
AS 
	BEGIN TRAN
	SET @fldNameGroup=Com.fn_TextNormalize(@fldNameGroup)
	SET @fldDesc=Com.fn_TextNormalize(@fldDesc) 
	
	UPDATE [ACC].[tblGroupCenterCost]
	SET    [fldId] = @fldId, [fldOrganId] = @fldOrganId, [fldNameGroup] = @fldNameGroup, [fldDesc] = @fldDesc, [fldDate] = GETDATE(), [fldIP] = @fldIP, [fldUserId] = @fldUserId
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
