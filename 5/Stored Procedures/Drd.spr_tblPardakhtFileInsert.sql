SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblPardakhtFileInsert] 
    @fldId INT out,
    @fldBankId int,
    @fldFileName nvarchar(100),
    @fldDateSendFile nvarchar(10),
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	
	BEGIN TRAN
	set @fldFileName=com.fn_TextNormalize(@fldFileName)
	set @fldDateSendFile=com.fn_TextNormalize(@fldDateSendFile)
	set @fldDesc=com.fn_TextNormalize(@fldDesc)
	select @fldID =ISNULL(max(fldId),0)+1 from [Drd].[tblPardakhtFile] 
	INSERT INTO [Drd].[tblPardakhtFile] ([fldId], [fldBankId], [fldFileName], [fldDateSendFile], [fldUserId], [fldDesc], [fldDate])
	SELECT @fldId, @fldBankId, @fldFileName, @fldDateSendFile, @fldUserId, @fldDesc, GETDATE()
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
