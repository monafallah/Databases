SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [BUD].[spr_tblCodingLevelUpdate] 
    @fldId int,
    @fldName nvarchar(300),
    @fldFiscalBudjeId int,
    @fldArghamNum int,
    @fldOrganId int,
    @fldDesc nvarchar(50),
    @fldUserId int,
 
    @fldIP nvarchar(16)
AS 

	BEGIN TRAN
	
	set @fldName=com.fn_TextNormalize(@fldName)

	UPDATE [BUD].[tblCodingLevel]
	SET    [fldName] = @fldName, [fldFiscalBudjeId] = @fldFiscalBudjeId, [fldArghamNum] = @fldArghamNum, [fldOrganId] = @fldOrganId, [fldDesc] = @fldDesc, [fldUserId] = @fldUserId, [fldDate] = getdate(), [fldIP] = @fldIP
	WHERE  fldId=@fldId
	if(@@Error<>0)
        rollback   

	COMMIT
GO
