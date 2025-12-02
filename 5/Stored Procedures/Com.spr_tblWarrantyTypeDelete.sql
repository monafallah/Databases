SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblWarrantyTypeDelete] 
	@fldID int,
	@fldUserID int
AS 
	BEGIN TRAN
	
	UPDATE com.tblWarrantyType
	SET fldUserId=@fldUserID,fldDate=GETDATE()
	WHERE fldId=@fldID
	
	DELETE
	FROM   [Com].[tblWarrantyType]
	WHERE  fldId = @fldId

	COMMIT
GO
