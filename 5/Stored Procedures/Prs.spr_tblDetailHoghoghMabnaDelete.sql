SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Prs].[spr_tblDetailHoghoghMabnaDelete] 
	@FieldName NVARCHAR(50),
	@fldID int,
	@fldUserID int
AS 
	BEGIN TRAN
	IF(@FieldName='fldId')
	BEGIN
	UPDATE   [Prs].[tblDetailHoghoghMabna]
	SET fldUserId=@fldUserID ,fldDate=GETDATE()
	WHERE  fldId = @fldId
	DELETE
	FROM   [Prs].[tblDetailHoghoghMabna]
	WHERE  fldId = @fldId
	end
	IF(@FieldName='fldHoghoghMabnaId')
	BEGIN
	UPDATE   [Prs].[tblDetailHoghoghMabna]
	SET fldUserId=@fldUserID ,fldDate=GETDATE()
	WHERE   fldHoghoghMabnaId = @fldId
	DELETE
	FROM   [Prs].[tblDetailHoghoghMabna]
	WHERE  fldHoghoghMabnaId = @fldId
	end
	COMMIT
GO
