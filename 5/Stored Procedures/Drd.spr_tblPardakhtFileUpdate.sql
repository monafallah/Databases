SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblPardakhtFileUpdate] 
    @fldId int,
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
	UPDATE [Drd].[tblPardakhtFile]
	SET    [fldBankId] = @fldBankId, [fldFileName] = @fldFileName, [fldDateSendFile] = @fldDateSendFile, [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = GETDATE()
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
