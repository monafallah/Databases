SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblShomareHesabOmoomi_DetailDelete] 
	@fldID int,
	@fldUserID int
AS 
	BEGIN TRAN
	UPDATE [Com].[tblShomareHesabOmoomi_Detail]
	SET fldUserId=@fldUserId , flddate=GETDATE()
	WHERE  fldId = @fldId
	DELETE
	FROM   [Com].[tblShomareHesabOmoomi_Detail]
	WHERE  fldId = @fldId

	COMMIT
GO
