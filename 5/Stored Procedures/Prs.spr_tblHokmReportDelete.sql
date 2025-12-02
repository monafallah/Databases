SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Prs].[spr_tblHokmReportDelete] 
	@fldID int,
	@fldUserID int
AS 
	BEGIN TRAN
	DECLARE @fileId INT,@flag BIT=0
	
	SELECT @fileId=fldFileId FROM Prs.tblHokmReport
	WHERE fldid=@fldID
	
	UPDATE [Prs].[tblHokmReport]
	SET fldUserId=@fldUserID ,fldDate=GETDATE()
	WHERE  fldId = @fldId
	DELETE
	FROM   [Prs].[tblHokmReport]
	WHERE  fldId = @fldId
	IF(@@ERROR<>0)
	BEGIN
		ROLLBACK
		SET @flag=1
	END
	IF(@flag=0)
	
	DELETE FROM Com.tblFile
	WHERE fldid=@fileId

	COMMIT
GO
