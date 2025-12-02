SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblReshteTahsiliDelete] 
	@fldID int,
	@fldUserID int
AS 
	BEGIN TRAN
	UPDATE     [Com].[tblReshteTahsili]
	SET fldUserId=@fldUserId , flddate=GETDATE()
	WHERE  fldId = @fldId
	DELETE
	FROM   [Com].[tblReshteTahsili]
	WHERE  fldId = @fldId

	COMMIT
GO
