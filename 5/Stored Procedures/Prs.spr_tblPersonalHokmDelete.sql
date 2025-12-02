SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Prs].[spr_tblPersonalHokmDelete] 
	@fldID int,
	@fldUserID int
AS 
	BEGIN TRAN
	DECLARE @flag BIT=0
	UPDATE Prs.tblHokm_Item
	SET fldUserId=@fldUserID ,fldDate=GETDATE()
	WHERE  fldId = @fldId
	DELETE FROM Prs.tblHokm_Item
	WHERE fldPersonalHokmId=@fldID
		IF(@@ERROR<>0)
	BEGIN
		ROLLBACK
		SET @flag=1
	END
	IF(@flag=0)
	BEGIN
	UPDATE Prs.tblHokm_InfoPersonal_History
	SET fldUserId=@fldUserID ,fldDate=GETDATE()
	WHERE  fldId = @fldId
	DELETE FROM Prs.tblHokm_InfoPersonal_History
	WHERE fldPersonalHokmId=@fldID
	IF(@@ERROR<>0)
	BEGIN
		ROLLBACK
		SET @flag=1
	END
	end
	IF(@flag=0)
	BEGIN
	UPDATE [Prs].[tblPersonalHokm]
	SET fldUserId=@fldUserID ,fldDate=GETDATE()
	WHERE  fldId = @fldId
	DELETE
	FROM   [Prs].[tblPersonalHokm]
	WHERE  fldId = @fldId
	end
	COMMIT
GO
