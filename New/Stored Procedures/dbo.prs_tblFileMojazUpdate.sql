SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[prs_tblFileMojazUpdate]
    @fldId int,
    @fldArchiveTreeId int,
    @fldFormatFileId int,
   
    @fldDesc nvarchar(100),
    @InputId int
AS 
	BEGIN TRAN
	SET @fldDesc=dbo.fn_TextNormalize(@fldDesc)
	UPDATE tblFileMojaz
	SET    [fldArchiveTreeId] = @fldArchiveTreeId, [fldFormatFileId] = @fldFormatFileId, [fldDesc] = @fldDesc
	WHERE  [fldId] = @fldId
	IF (@@ERROR<>0)
			ROLLBACK
		
	COMMIT TRAN
GO
