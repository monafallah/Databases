SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Arch].[spr_tblFileMojazInsert] 
    @fldArchiveTreeId int,
    @fldFormatFileId int,
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	
	BEGIN TRAN
	declare @fldID int 
	SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
	select @fldID =ISNULL(max(fldId),0)+1 from [Arch].[tblFileMojaz] 
	INSERT INTO [Arch].[tblFileMojaz] ([fldId], [fldArchiveTreeId], [fldFormatFileId], [fldUserId], [fldDesc], [fldDate])
	SELECT @fldId, @fldArchiveTreeId, @fldFormatFileId, @fldUserId, @fldDesc, GETDATE()
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
