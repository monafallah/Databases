SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROC [chk].[spr_tblOlgoCheckDelete] 
	@fldID int,
	@fldUserID int
AS 
BEGIN TRAN
	DECLARE @fileId INT,@flag BIT=0
	SELECT @fileId=fldIdFile FROM chk.tblOlgoCheck WHERE fldid=@fldID
	UPDATE   chk.[tblOlgoCheck]
	SET fldUserId=@fldUserId , flddate=GETDATE()
	WHERE fldid=@fldID 

	DELETE
	FROM   [chk].[tblOlgoCheck]
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
