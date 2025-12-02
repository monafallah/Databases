SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblNezamVazifeDelete] 
	@fldID TINYINT,
	@fldUserID int
AS 
	BEGIN TRAN
	UPDATE   [Com].[tblNezamVazife]
	SET fldUserId=@fldUserId , flddate=GETDATE()
	WHERE fldid=@fldID
	DELETE
	FROM   [Com].[tblNezamVazife]
	WHERE  fldId = @fldId

	COMMIT
GO
