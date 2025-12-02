SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Arch].[spr_tblFileMojazUpdate] 
    @fldId int,
    @fldArchiveTreeId int,
    @fldFormatFileId int,
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	BEGIN TRAN
	SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
	UPDATE [Arch].[tblFileMojaz]
	SET    [fldArchiveTreeId] = @fldArchiveTreeId, [fldFormatFileId] = @fldFormatFileId, [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = GETDATE()
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
