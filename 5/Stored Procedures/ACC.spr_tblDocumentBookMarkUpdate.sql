SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [ACC].[spr_tblDocumentBookMarkUpdate] 
    @fldId int,
    @fldDocumentRecordeId int,
    @fldArchiveTreeId int,
    @fldUserId int,
    @fldOrganId int,
    @fldDesc nvarchar(100),
   
    @fldIP varchar(16)
AS 

	BEGIN TRAN

	UPDATE [ACC].[tblDocumentBookMark]
	SET    [fldDocumentRecordeId] = @fldDocumentRecordeId, [fldArchiveTreeId] = @fldArchiveTreeId, [fldUserId] = @fldUserId, [fldOrganId] = @fldOrganId, [fldDesc] = @fldDesc, [fldDate] = getdate(), [fldIP] = @fldIP
	WHERE  fldId=@fldId
	if(@@Error<>0)
        rollback   

	COMMIT
GO
