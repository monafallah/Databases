SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblMadrakTahsiliDelete] 
	@fldID int,
	@fldUserID int
AS 
	BEGIN TRAN
	UPDATE    [Com].[tblMadrakTahsili]
	SET fldUserId=@fldUserId , flddate=GETDATE()
	WHERE fldid=@fldID
	DELETE
	FROM   [Com].[tblMadrakTahsili]
	WHERE  fldId = @fldId

	COMMIT
GO
