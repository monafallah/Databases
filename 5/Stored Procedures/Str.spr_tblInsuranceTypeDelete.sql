SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Str].[spr_tblInsuranceTypeDelete] 
	@fldID int,
	@fldUserID int
AS 
	BEGIN TRAN
	UPDATE   [Str].[tblInsuranceType]
	SET fldUserId=@fldUserId , flddate=GETDATE()
	WHERE fldid=@fldID
	DELETE
	FROM   [Str].[tblInsuranceType]
	WHERE  fldId = @fldId

	COMMIT
GO
