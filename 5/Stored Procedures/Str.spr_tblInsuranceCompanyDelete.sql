SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
create PROC [Str].[spr_tblInsuranceCompanyDelete] 
	@fldID int,
	@fldUserID int
AS 
	BEGIN TRAN
	DECLARE @fileId INT,@flag BIT=0
	SELECT @fileId=fldFileId FROM [Str].[tblInsuranceCompany] WHERE fldid=@fldID
	UPDATE   [Str].[tblInsuranceCompany]
	SET fldUserId=@fldUserId , flddate=GETDATE()
	WHERE fldid=@fldID 
	
	DELETE
	FROM   [Str].[tblInsuranceCompany]
	WHERE  fldId = @fldId
	IF(@@ERROR<>0)
	BEGIN
		ROLLBACK
		SET @flag=1
	END
	IF(@flag=0)
	DELETE FROM  Com.tblFile
	WHERE fldid=@fileId
	COMMIT
GO
