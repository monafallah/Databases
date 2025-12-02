SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblMoteghayerhayeHoghoghiDelete] 
	@fldID int,
	@fldUserID int
AS 
	BEGIN TRAN
	DECLARE @flag BIT=0
	UPDATE  Pay.tblMoteghayerhayeHoghoghi_Detail
	SET fldUserId=@fldUserId , flddate=GETDATE()
	WHERE   fldMoteghayerhayeHoghoghiId=@fldID
	DELETE FROM Pay.tblMoteghayerhayeHoghoghi_Detail
	WHERE fldMoteghayerhayeHoghoghiId=@fldID
	IF(@@ERROR<>0)
	BEGIN
		ROLLBACK
		SET @flag=1
	END
	IF(@flag=0)
	BEGIN
		UPDATE   [Pay].[tblMoteghayerhayeHoghoghi]
		SET fldUserId=@fldUserId , flddate=GETDATE()
		WHERE  fldId = @fldId
		DELETE
		FROM   [Pay].[tblMoteghayerhayeHoghoghi]
		WHERE  fldId = @fldId
		IF(@@ERROR<>0)
		ROLLBACK
	end

	COMMIT
GO
