SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [ACC].[spr_tblCaseTypeDelete] 
	@fldID int,
	@fldUserID int
AS 
	BEGIN TRAN
	DELETE
	FROM   [ACC].[tblCaseType]
	WHERE  fldId = @fldId

	COMMIT
GO
