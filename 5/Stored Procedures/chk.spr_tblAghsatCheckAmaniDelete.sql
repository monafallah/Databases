SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [chk].[spr_tblAghsatCheckAmaniDelete] 
	@fldID int,
	@fldUserID int
AS 
	BEGIN TRAN
	DELETE
	FROM   [chk].[tblAghsatCheckAmani]
	WHERE  fldId = @fldId

	COMMIT
GO
