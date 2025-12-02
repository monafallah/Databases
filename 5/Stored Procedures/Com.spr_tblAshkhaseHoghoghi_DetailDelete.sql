SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblAshkhaseHoghoghi_DetailDelete] 
	@fldID int,
	@fldUserID int
AS 
	BEGIN TRAN
		UPDATE  [Com].[tblAshkhaseHoghoghi_Detail]
	SET fldUserId=@fldUserId , flddate=GETDATE()
	WHERE fldid=@fldID 
	DELETE
	FROM   [Com].[tblAshkhaseHoghoghi_Detail]
	WHERE  fldId = @fldId

	COMMIT
GO
