SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [ACC].[spr_tblDocumentRecorde_FileUpdate] 
    @fldId int,
    @fldDocumentHeaderId int,
    @fldFileId int,
    @fldUserId int,
    @fldDesc nvarchar(100)
AS 

	BEGIN TRAN

	UPDATE [ACC].[tblDocumentRecorde_File]
	SET    [fldDocumentHeaderId] = @fldDocumentHeaderId, [fldFileId] = @fldFileId, [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = getdate()
	WHERE  fldId=@fldId
	if(@@Error<>0)
        rollback   

	COMMIT
GO
