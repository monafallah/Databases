SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblBankDelete] 
	@fldID int,
	@fldUserID int
AS 
	BEGIN TRAN
	DECLARE @fileId INT,@flag BIT=0
	SELECT @fileId=fldFileId FROM Com.tblBank WHERE fldid=@fldID
	UPDATE   [Com].[tblBank]
	SET fldUserId=@fldUserId , flddate=GETDATE()
	WHERE fldid=@fldID 
	
	DELETE
	FROM   [Com].[tblBank]
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
