SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Auto].[spr_tblSecretariat_OrganizationUnitDelete] 
	@fldID int,
	@fldUserID INT,
	@fieldname nvarchar(50)
AS 
	BEGIN TRAN
	
	
	UPDATE Auto.tblSecretariat_OrganizationUnit
	SET [fldUserId]=@fldUserID,[fldDate]=GETDATE()
	WHERE fldId=@fldID
	
	IF(@fieldname=N'fldId')
	DELETE
	FROM   [Auto].[tblSecretariat_OrganizationUnit]
	WHERE  fldId = @fldId
	
	
	IF(@fieldname=N'fldSecretariatId')
	DELETE
	FROM Auto.tblSecretariat_OrganizationUnit
	WHERE fldSecretariatID=@fldId

	COMMIT
GO
