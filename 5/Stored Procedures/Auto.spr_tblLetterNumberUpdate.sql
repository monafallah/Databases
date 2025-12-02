SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
create PROC [Auto].[spr_tblLetterNumberUpdate] 
    @fldID int,
    @fldLetterId bigint,
    @fldUserID int,
	@fldOrganId int,
    @fldDesc nvarchar(100),
	@fldIP nvarchar(16)
AS 
	BEGIN TRAN
    set @fldDesc=com.fn_TextNormalize(@fldDesc)
	UPDATE [Auto].[tblLetterNumber]
	SET     [fldLetterID] = @fldLetterID, [fldDesc] = @fldDesc,fldUserId=@fldUserID,fldOrganId=@fldOrganId,fldIP=@fldIP
	
	WHERE  [fldID] = @fldID

	IF(@@ERROR<>0) ROLLBACK

	COMMIT TRAN

GO
