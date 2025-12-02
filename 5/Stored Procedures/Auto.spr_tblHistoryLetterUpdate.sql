SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Auto].[spr_tblHistoryLetterUpdate] 
    @fldId int,
    @fldCurrentLetter_Id bigint,
    @fldHistoryType_Id int,
    @fldHistoryLetter_Id bigint,
    @fldUserId int,
    @fldOrganId int,
    @fldDesc nvarchar(100) = NULL,
 
    @fldIP nvarchar(16)
AS 

	BEGIN TRAN

	UPDATE [Auto].[tblHistoryLetter]
	SET    [fldCurrentLetter_Id] = @fldCurrentLetter_Id, [fldHistoryType_Id] = @fldHistoryType_Id, [fldHistoryLetter_Id] = @fldHistoryLetter_Id, [fldUserId] = @fldUserId, [fldOrganId] = @fldOrganId, [fldDesc] = @fldDesc, [fldDate] = getdate(), [fldIP] = @fldIP
	WHERE  fldId=@fldId
	if(@@Error<>0)
        rollback   

	COMMIT
GO
