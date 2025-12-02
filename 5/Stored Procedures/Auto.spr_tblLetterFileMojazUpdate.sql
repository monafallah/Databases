SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Auto].[spr_tblLetterFileMojazUpdate] 
    @fldId int,
    @fldFormatFileId int,
	@fldType tinyint,
    @fldUserId int,
    @fldDesc nvarchar(MAX),
   
    @fldOrganId int,
    @fldIP nvarchar(15)
AS 

	BEGIN TRAN
	set @fldDesc=com.fn_TextNormalize(@fldDesc)
	UPDATE [Auto].[tblLetterFileMojaz]
	SET    [fldFormatFileId] = @fldFormatFileId,fldType=@fldType, [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = getdate(), [fldOrganId] = @fldOrganId, [fldIP] = @fldIP
	WHERE  fldId=@fldId
	if(@@Error<>0)
        rollback   

	COMMIT
GO
