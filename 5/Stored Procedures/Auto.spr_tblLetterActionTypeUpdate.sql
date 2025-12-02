SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Auto].[spr_tblLetterActionTypeUpdate] 
    @fldId int,
    @fldTitleActionType nvarchar(200),
    @fldUserId int,
    @fldOrganId int,
    @fldDesc nvarchar(100),
  
    @fldIP nvarchar(16)
AS 

	BEGIN TRAN
	set @fldTitleActionType=com.fn_TextNormalize(@fldTitleActionType)
	set @fldDesc=com.fn_TextNormalize(@fldDesc)
	UPDATE [Auto].[tblLetterActionType]
	SET    [fldTitleActionType] = @fldTitleActionType, [fldUserId] = @fldUserId, [fldOrganId] = @fldOrganId, [fldDesc] = @fldDesc, [fldDate] = getdate(), [fldIP] = @fldIP
	WHERE  fldId=@fldId
	if(@@Error<>0)
        rollback   

	COMMIT
GO
