SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROC [Auto].[spr_tblLetterBoxUpdate] 
    @fldID int,
	    @fldBoxID int,
    @fldLetterID bigint,
	@fldMessageId int,

    @fldUserID int,
	@fldOrganId int,
		@fldIP nvarchar(16),
    @fldDesc nvarchar(100)

AS 
	BEGIN TRAN
    set @fldDesc=com.fn_TextNormalize(@fldDesc)
	UPDATE [aUto].[tblLetterBox]
	SET    [fldLetterID] = @fldLetterID, [fldBoxID] = @fldBoxID, [fldDesc] = @fldDesc,fldDate=getdate()
	,fldMessageId=@fldMessageId,fldOrganId=@fldOrganId,fldIP=@fldIp

	WHERE  [fldID] = @fldID

	IF(@@ERROR<>0) ROLLBACK

	COMMIT TRAN

GO
