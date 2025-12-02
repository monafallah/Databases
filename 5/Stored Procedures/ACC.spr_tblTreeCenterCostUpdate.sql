SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [ACC].[spr_tblTreeCenterCostUpdate] 
    @fldId int,
    @fldOrganId int,
    @fldGroupCenterCoId int,
    
    @fldName nvarchar(50),
    @fldDesc nvarchar(MAX),
    
    @fldIP varchar(16),
    @fldUserId int
AS 
	BEGIN TRAN
	SET @fldName=Com.fn_TextNormalize(@fldName)
	SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
	
	
	UPDATE [ACC].[tblTreeCenterCost]
	SET    [fldId] = @fldId, [fldOrganId] = @fldOrganId, [fldGroupCenterCoId] = @fldGroupCenterCoId, [fldName] = @fldName, [fldDesc] = @fldDesc, [fldDate] = GETDATE(), [fldIP] = @fldIP, [fldUserId] = @fldUserId
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
