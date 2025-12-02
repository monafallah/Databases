SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [ACC].[spr_tblDocumentRecord_Header1Update] 
    @fldId int,
    @fldArchiveNum NVARCHAR(50),
	@fldShomareFaree int,
    @fldIP varchar(16),
    @fldUserId int
AS 
	BEGIN TRAN
	
	UPDATE [ACC].[tblDocumentRecord_Header1]
	SET     [fldArchiveNum] = @fldArchiveNum,[fldShomareFaree]= @fldShomareFaree, [fldDate] = GETDATE(), [fldIP] = @fldIP, [fldUserId] = @fldUserId
	WHERE  [fldId] = @fldId

	if (@@ERROR<>0)
		rollback
	
	COMMIT TRAN

GO
