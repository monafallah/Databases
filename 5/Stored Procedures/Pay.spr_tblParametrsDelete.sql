SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblParametrsDelete] 
	@fldID int,
	@fldUserID int
AS 
	BEGIN TRAN
	DECLARE  @flag BIT=0
	UPDATE  [Pay].[tblParameteriItemsFormul]
	SET fldUserId=@fldUserID ,fldDate=GETDATE()
	WHERE     fldParametrId = @fldID
	DELETE
	FROM   [Pay].[tblParameteriItemsFormul]
	WHERE  fldParametrId = @fldID
	IF(@@ERROR<>0)
	BEGIN
		SET @flag=1
		ROLLBACK
	END
	IF(@flag=0)
	BEGIN
	UPDATE  [Pay].[tblParametrs]
	SET fldUserId=@fldUserID ,fldDate=GETDATE()
	WHERE    fldId = @fldId
	DELETE
	FROM   [Pay].[tblParametrs]
	WHERE  fldId = @fldId
	IF(@@ERROR<>0)
	ROLLBACK
	END
	COMMIT
GO
