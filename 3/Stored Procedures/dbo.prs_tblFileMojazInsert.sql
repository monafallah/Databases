SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[prs_tblFileMojazInsert]
    @fldArchiveTreeId int,
    @fldFormatFileId int,
    
    @fldDesc nvarchar(100),
    @InputId int
AS 
	
	BEGIN TRAN
	declare @fldID int 
	SET @fldDesc=dbo.fn_TextNormalize(@fldDesc)
	select @fldID =ISNULL(max(fldId),0)+1 from tblFileMojaz 
	INSERT INTO tblFileMojaz ([fldId], [fldArchiveTreeId], [fldFormatFileId], [fldDesc])
	SELECT @fldId, @fldArchiveTreeId, @fldFormatFileId,  @fldDesc
	if (@@ERROR<>0)
		ROLLBACK
		

	COMMIT
GO
