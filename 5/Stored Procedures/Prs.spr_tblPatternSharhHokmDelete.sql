SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Prs].[spr_tblPatternSharhHokmDelete] 
	@fldID int,
	@fldUserID int
AS 
	BEGIN TRAN
	UPDATE [Prs].[tblPatternSharhHokm]
	SET fldUserId=@fldUserID ,fldDate=GETDATE()
	WHERE  fldId = @fldId
	DELETE
	FROM   [Prs].[tblPatternSharhHokm]
	WHERE  fldId = @fldId

	COMMIT
GO
