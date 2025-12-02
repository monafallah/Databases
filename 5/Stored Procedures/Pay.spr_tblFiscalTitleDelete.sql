SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblFiscalTitleDelete] 
	@fieldname NVARCHAR(50),
	@value1 NVARCHAR(50),
	@fldID int,
	@fldUserID INT
	
AS 
	BEGIN TRAN
	IF(@fieldname='fldId')
	BEGIN
	UPDATE  [Pay].[tblFiscalTitle]
	SET fldUserId=@fldUserId , flddate=GETDATE()
	WHERE  fldId = @fldId
	DELETE
	FROM   [Pay].[tblFiscalTitle]
	WHERE  fldId = @fldId
	end
	IF (@fieldname='fldHeaderId')
	BEGIN
	UPDATE   [Pay].[tblFiscalTitle]
	SET fldUserId=@fldUserId , flddate=GETDATE()
	WHERE  fldFiscalHeaderId = @fldId AND fldAnvaEstekhdamId=@value1
	DELETE
	FROM   [Pay].[tblFiscalTitle]
	WHERE  fldFiscalHeaderId = @fldId AND fldAnvaEstekhdamId=@value1
	END 
	COMMIT
GO
