SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [ACC].[spr_tblDocumentDescDelete] 
	@fldID int,
	@fldUserID int
AS 
	BEGIN TRAN
	update [ACC].[tblDocumentDesc] set [fldDate] = GETDATE(), [fldUserId] = @fldUserId
	WHERE  fldId = @fldId
	DELETE
	FROM   [ACC].[tblDocumentDesc]
	WHERE  fldId = @fldId

	COMMIT
GO
