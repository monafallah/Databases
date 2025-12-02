SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblMaliyatArzesheAfzoodeDelete] 
	@fldID int,
	@fldUserID int
AS 
	BEGIN TRAN
	UPDATE    [Com].[tblMaliyatArzesheAfzoode]
	SET fldUserId=@fldUserId , flddate=GETDATE()
	WHERE fldid=@fldID
	DELETE
	FROM   [com].[tblMaliyatArzesheAfzoode]
	WHERE  fldId = @fldId

	COMMIT
GO
