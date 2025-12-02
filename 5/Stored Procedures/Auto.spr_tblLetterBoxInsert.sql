SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
create PROC [Auto].[spr_tblLetterBoxInsert] 
      @fldBoxId int,
    @fldLetterId bigint,
	@fldMessageId int,
    @fldUserID int,
	@fldOrganId int,
    @fldDesc nvarchar(100),
	@fldIP nvarchar(16)
AS 
declare @fldId int
	select @fldId =ISNULL(max(fldId),0)+1 from [Auto].[tblLetterBox]
    set @fldDesc=com.fn_TextNormalize(@fldDesc)
	BEGIN TRAN
	
	INSERT INTO [Auto].[tblLetterBox] ([fldID], [fldLetterID], fldMessageId ,[fldBoxID], [fldDate], [fldUserID], [fldDesc],fldOrganId ,fldIP)
	
	SELECT @fldID, @fldLetterID,@fldMessageId, @fldBoxID, GETDATE(), @fldUserID, @fldDesc,@fldOrganId ,@fldIP
         
	IF(@@ERROR<>0) ROLLBACK

	COMMIT TRAN

GO
