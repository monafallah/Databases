SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblShomareHesabsDelete] 
	@fldID int,
	@fldUserID int
AS 
	BEGIN TRAN
	DECLARE @flag BIT=0
	UPDATE [Com].[tblShomareHesabeOmoomi]
	SET fldUserId=@fldUserID ,fldDate=GETDATE()
	WHERE  fldId = @fldId
	
	DELETE FROM Com.tblShomareHesabOmoomi_Detail
	WHERE fldShomareHesabId=@fldID
	IF (@@ERROR<>0)
	BEGIN
		SET @flag=1
		ROLLBACK
	END
	IF (@flag=0)
	BEGIN
	DELETE
	FROM   [Com].[tblShomareHesabeOmoomi]
	WHERE  fldId = @fldId
	IF(@@ERROR<>0)
	ROLLBACK
	END 

	COMMIT
GO
