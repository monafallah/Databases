SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblShomareHesabeOmoomiDelete] 
	@fldID int,
	@fldUserID int
AS 
	BEGIN TRAN
	DECLARE @flag BIT=0
	DELETE FROM Com.tblShomareHesabOmoomi_Detail
	WHERE fldShomareHesabId=@fldID
	IF(@@ERROR<>0)
	BEGIN
		SET @flag=1
		ROLLBACK
	END
    IF(@flag=0)
	BEGIN
	UPDATE [com].[tblShomareHesabeOmoomi]
	SET fldUserId=@fldUserId , flddate=GETDATE()
	WHERE  fldId = @fldId
	
	DELETE
	FROM   [com].[tblShomareHesabeOmoomi]
	WHERE  fldId = @fldId
	IF(@@ERROR<>0)
	BEGIN

		ROLLBACK
	END
	end
	COMMIT
GO
