SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [ACC].[spr_tblMahiyatDelete] 
	@fldID int,
	@fldUserID int
AS 
	BEGIN TRAN
	UPDATE ACC.tblMahiyat
	SET fldUserId=@fldUserID,fldDate=GETDATE()
	WHERE fldId=@fldID
	DELETE
	FROM   [ACC].[tblMahiyat]
	WHERE  fldId = @fldId

	COMMIT
GO
