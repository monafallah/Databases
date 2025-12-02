SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblComputationFormulaDelete] 
	@fldID int,
	@fldUserID int
AS 
	BEGIN TRAN
	UPDATE    [Com].[tblComputationFormula]
	SET fldUserId=@fldUserId , flddate=GETDATE()
	WHERE fldid=@fldID
	DELETE
	FROM    [Com].[tblComputationFormula]
	WHERE  fldId = @fldId

	COMMIT
GO
