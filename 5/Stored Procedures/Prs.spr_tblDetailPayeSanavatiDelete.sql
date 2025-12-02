SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Prs].[spr_tblDetailPayeSanavatiDelete] 
	@fieldName NVARCHAR(50),
	@fldID int,
	@fldUserID int
AS 
	BEGIN TRAN
	IF(@fieldName='fldId')
	BEGIN
	UPDATE   [Prs].[tblDetailPayeSanavati]
	SET fldUserId=@fldUserID ,fldDate=GETDATE()
	WHERE  fldId = @fldId
	DELETE
	FROM   [Prs].[tblDetailPayeSanavati]
	WHERE  fldId = @fldId
	end
	IF(@fieldName='fldPayeSanavatiId')
	BEGIN
	UPDATE   [Prs].[tblDetailPayeSanavati]
	SET fldUserId=@fldUserID ,fldDate=GETDATE()
	WHERE  fldPayeSanavatiId = @fldId
	DELETE
	FROM   [Prs].[tblDetailPayeSanavati]
	WHERE  fldPayeSanavatiId = @fldId
	end
	COMMIT
GO
