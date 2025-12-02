SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Auto].[spr_tblLetterFollowInsert] 
    @fldLetterID bigint,
	@fldLetterText nvarchar(500),
    
    @fldUserID int,
	@fldOrganId int,
    @fldDesc nvarchar(100),
	@fldIP nvarchar(16)
AS 
	DECLARE @fldID int
	select @fldId =ISNULL(max(fldId),0)+1 from [Auto].[tblLetterFollow]
    set @fldDesc=com.fn_TextNormalize(@fldDesc)
	set @fldLetterText=com.fn_TextNormalize(@fldLetterText)
	BEGIN TRAN
	
	INSERT INTO [Auto].[tblLetterFollow] ([fldID], [fldLetterText], [fldLetterID], [fldDate], [fldUserID], [fldDesc],fldOrganId,fldIP)
	
	SELECT @fldID, @fldLetterText, @fldLetterID, GETDATE(), @fldUserID, @fldDesc,@fldOrganId,@fldIP
         
	IF(@@ERROR<>0) ROLLBACK

	COMMIT TRAN

GO
