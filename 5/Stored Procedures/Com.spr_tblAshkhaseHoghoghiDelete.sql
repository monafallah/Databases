SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblAshkhaseHoghoghiDelete] 
	@fldID int,
	@fldUserID int
AS 
	BEGIN TRAN
	DECLARE @flag BIT=0
	DELETE FROM Com.tblAshkhas
	WHERE fldHoghoghiId=@fldID
	IF(@@ERROR<>0)
	BEGIN
		SET @flag=1
		ROLLBACK
	END
	IF(@flag=0) 
	BEGIN
		DELETE
		FROM   [com].tblAshkhaseHoghoghi_Detail
		WHERE  fldAshkhaseHoghoghiId = @fldId
			IF(@@ERROR<>0)
			BEGIN
			ROLLBACK
			END
	end
	IF(@flag=0) 
	BEGIN
	UPDATE [com].[tblAshkhaseHoghoghi]
	SET fldUserId=@fldUserID,fldDate=GETDATE()
	WHERE fldId=@fldID
	DELETE
	FROM   [com].[tblAshkhaseHoghoghi]
	WHERE  fldId = @fldId
		IF(@@ERROR<>0)
		BEGIN
		
		ROLLBACK
		END
	end
	COMMIT
GO
