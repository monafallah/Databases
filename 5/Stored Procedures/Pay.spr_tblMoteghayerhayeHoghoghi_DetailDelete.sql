SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblMoteghayerhayeHoghoghi_DetailDelete] 
	@FieldName NVARCHAR(50),
	@fldID int,
	@fldUserID int
AS 
	BEGIN TRAN
	IF(@FieldName='HeaderId')
	BEGIN
	UPDATE  Pay.tblMoteghayerhayeHoghoghi_Detail
	SET fldUserId=@fldUserId , flddate=GETDATE()
	WHERE   fldMoteghayerhayeHoghoghiId=@fldID
	DELETE FROM Pay.tblMoteghayerhayeHoghoghi_Detail
	WHERE fldMoteghayerhayeHoghoghiId=@fldID
	end
	IF(@FieldName='fldId')
	BEGIN
	UPDATE  Pay.tblMoteghayerhayeHoghoghi_Detail
	SET fldUserId=@fldUserId , flddate=GETDATE()
	WHERE  fldId = @fldId
	DELETE
	FROM   [Pay].[tblMoteghayerhayeHoghoghi_Detail]
	WHERE  fldId = @fldId
	END 
	COMMIT
GO
