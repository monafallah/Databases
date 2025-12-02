SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblApplicationPartDelete] 
	@fldID int,
	@fldUserID int
AS 
	BEGIN TRAN
	UPDATE  [Com].[tblApplicationPart]
	SET fldUserId=@fldUserId , flddate=GETDATE()
	WHERE fldid=@fldID 
	DELETE
	FROM   [Com].[tblApplicationPart]
	WHERE  fldId = @fldId

	COMMIT
GO
