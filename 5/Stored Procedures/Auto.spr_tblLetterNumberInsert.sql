SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
create PROC [Auto].[spr_tblLetterNumberInsert] 
    @fldLetterID bigint,
	@fldNumber int out,
	@fldStartNumber int,
    @fldUserID int,
	@fldOrganId int,
    @fldDesc nvarchar(100),
	@fldIP nvarchar(16)
AS 
	DECLARE @fldID bigint,@fldYear int
	select @fldYear=fldyear from tblLetter where fldid=@fldLetterID
	select @fldNumber=ISNULL(max(fldNumber),@fldStartNumber-1)+1 from [tblLetterNumber] where fldYear=@fldYear
	select @fldId =ISNULL(max(fldId),0)+1 from [Auto].[tblLetterNumber]
    set @fldDesc=com.fn_TextNormalize(@fldDesc)
	BEGIN TRAN
	
	INSERT INTO [Auto].[tblLetterNumber] ([fldID], [fldLetterID],fldYear,fldNumber, [fldDate], [fldUserID], [fldDesc],fldOrganId ,fldIP)
	
	SELECT @fldID, @fldLetterID,@fldYear,@fldNumber, GETDATE(), @fldUserID, @fldDesc,@fldOrganId ,@fldIP
         
	IF(@@ERROR<>0) ROLLBACK

	COMMIT TRAN

GO
