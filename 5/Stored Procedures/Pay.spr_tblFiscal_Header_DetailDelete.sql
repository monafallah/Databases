SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblFiscal_Header_DetailDelete] 
	@fldID int,
	@fldUserID int
AS 
	BEGIN TRAN
	DECLARE @flag BIT=0
	UPDATE  [Pay].[tblFiscal_Detail]
	SET fldUserId=@fldUserId , flddate=GETDATE()
	WHERE fldFiscalHeaderId=@fldID
	
	DELETE FROM Pay.tblFiscal_Detail
	WHERE fldFiscalHeaderId=@fldID
	IF(@@ERROR<>0)
	BEGIN
		ROLLBACK
		SET @flag=1
	END
	IF(@flag=0)
	BEGIN
	UPDATE  [Pay].[tblFiscal_Header]
	SET fldUserId=@fldUserId , flddate=GETDATE()
	WHERE  fldId = @fldId
	DELETE
	FROM   [Pay].[tblFiscal_Header]
	WHERE  fldId = @fldId
	END
	
	COMMIT
GO
