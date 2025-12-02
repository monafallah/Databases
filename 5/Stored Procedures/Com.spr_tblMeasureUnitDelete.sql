SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblMeasureUnitDelete] 
	@fldID int,
	@fldUserID int
AS 
	BEGIN TRAN
		UPDATE [com].[tblMeasureUnit]
		SET fldUserId=@fldUserId , flddate=GETDATE()
		WHERE fldid=@fldID
	DELETE
	FROM   [com].[tblMeasureUnit]
	WHERE  fldId = @fldId

	COMMIT
GO
