SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblTypeFishDelete] 
	@fldID int,
	@fldUserID int
AS 
	BEGIN TRAN
		UPDATE    [Drd].[tblTypeFish]
		SET fldUserId=@fldUserId , flddate=GETDATE()
		WHERE  fldId = @fldId
	DELETE
	FROM   [Drd].[tblTypeFish]
	WHERE  fldId = @fldId

	COMMIT
GO
