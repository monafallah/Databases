SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [BUD].[spr_tblDaramadCodeDetails_ACCDelete] 
	@fldID int,
	@fldUserID int
AS 
	BEGIN TRAN
	update [BUD].[tblDaramadCodeDetails_ACC] set  [fldUserId] = @fldUserId, [fldDate] = GETDATE()
	WHERE  fldId = @fldId
	DELETE
	FROM   [BUD].[tblDaramadCodeDetails_ACC]
	WHERE  fldId = @fldId

	COMMIT
GO
