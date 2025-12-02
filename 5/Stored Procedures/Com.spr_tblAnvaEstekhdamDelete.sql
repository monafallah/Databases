SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblAnvaEstekhdamDelete] 
	@fldID int,
	@fldUserID int
AS 
	BEGIN TRAN
	UPDATE  [Com].[tblAnvaEstekhdam]
	SET fldUserId=@fldUserId , flddate=GETDATE()
	WHERE fldid=@fldID 
	DELETE
	FROM    [Com].[tblAnvaEstekhdam]
	WHERE  fldId = @fldId

	COMMIT
GO
