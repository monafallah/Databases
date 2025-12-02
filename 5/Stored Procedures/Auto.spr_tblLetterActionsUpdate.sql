SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Auto].[spr_tblLetterActionsUpdate] 
    @fldId int,
    @fldLetterId bigint,
    @fldTarikhAnjam nvarchar(10),
    @fldTimeAnjam nvarchar(8),
    @fldLetterActionTypeId int,
    @fldUserId int,
    @fldOrganId int,
    @fldDesc nvarchar(100),
    @fldDate datetime,
    @fldIP nvarchar(16)
AS 

	BEGIN TRAN

	UPDATE [Auto].[tblLetterActions]
	SET    [fldLetterId] = @fldLetterId, [fldTarikhAnjam] = @fldTarikhAnjam, [fldTimeAnjam] = @fldTimeAnjam, [fldLetterActionTypeId] = @fldLetterActionTypeId, [fldUserId] = @fldUserId, [fldOrganId] = @fldOrganId, [fldDesc] = @fldDesc, [fldDate] = @fldDate, [fldIP] = @fldIP
	WHERE  fldId=@fldId
	if(@@Error<>0)
        rollback   

	COMMIT
GO
