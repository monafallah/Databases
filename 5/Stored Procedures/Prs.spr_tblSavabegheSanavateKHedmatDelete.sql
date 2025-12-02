SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Prs].[spr_tblSavabegheSanavateKHedmatDelete] 
	@fldID int,
	@fldUserID int
AS 
	BEGIN TRAN
	UPDATE  [Prs].[tblSavabegheSanavateKHedmat]
	SET fldUserId=@fldUserID ,fldDate=GETDATE()
	WHERE  fldId = @fldId
	DELETE
	FROM   [Prs].[tblSavabegheSanavateKHedmat]
	WHERE  fldId = @fldId

	COMMIT
GO
