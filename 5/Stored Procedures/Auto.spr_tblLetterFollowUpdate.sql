SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Auto].[spr_tblLetterFollowUpdate] 
    @fldID int,
   @fldLetterID bigint,
    @fldLetterText nvarchar(500),
   
   
    @fldUserID int,
	@fldOrganId int,
    @fldDesc nvarchar(100),
	@fldIP nvarchar(16)
AS 
	BEGIN TRAN
    set @fldDesc=com.fn_TextNormalize(@fldDesc)
	    set @fldLetterText=com.fn_TextNormalize(@fldLetterText)
	UPDATE [auto].[tblLetterFollow]
	SET    [fldLetterText] = @fldLetterText, [fldLetterID] = @fldLetterID,[fldDesc] = @fldDesc,fldOrganId=@fldOrganId
	,fldIP=@fldIP
	
	WHERE  [fldID] = @fldID

	IF(@@ERROR<>0) ROLLBACK

	COMMIT TRAN

GO
