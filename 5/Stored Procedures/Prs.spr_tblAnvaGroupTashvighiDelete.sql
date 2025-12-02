SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Prs].[spr_tblAnvaGroupTashvighiDelete] 
	@fldID TINYINT,
	@fldUserID int
AS 
	BEGIN TRAN
	UPDATE   [Prs].[tblAnvaGroupTashvighi]
	SET fldUserId=@fldUserID ,fldDate=GETDATE()
	WHERE  fldId = @fldId
	DELETE
	FROM   [Prs].[tblAnvaGroupTashvighi]
	WHERE  fldId = @fldId

	COMMIT
GO
