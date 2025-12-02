SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Arch].[spr_tblArchiveTreeDelete] 
	@fldID int,
	@fldUserID int
AS 
	BEGIN TRAN
	DELETE
	FROM   [Arch].[tblArchiveTree]
	WHERE  fldId = @fldId

	COMMIT
GO
