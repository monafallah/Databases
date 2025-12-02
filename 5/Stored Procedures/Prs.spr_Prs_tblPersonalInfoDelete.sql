SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Prs].[spr_Prs_tblPersonalInfoDelete] 
	@fldID int,
	@fldUserID int
AS 
	BEGIN TRAN
	DECLARE @flag BIT=0
	DELETE FROM Prs.tblHistoryNoeEstekhdam
	WHERE fldPrsPersonalInfoId=@fldID
	IF(@@ERROR<>0)
	BEGIN
		SET @flag=1
		ROLLBACK
	END
	IF(@flag=0)
	BEGIN
	
	DELETE FROM Com.tblPersonalStatus
	WHERE fldPrsPersonalInfoId=@fldID
		IF(@@ERROR<>0)
	BEGIN
		SET @flag=1
		ROLLBACK
	END
	END
	IF(@flag=0)
	BEGIN
	UPDATE  [Prs].[Prs_tblPersonalInfo]
	SET fldUserId=@fldUserID ,fldDate=GETDATE()
	WHERE  fldId = @fldId
		IF(@@ERROR<>0)
	BEGIN
		SET @flag=1
		ROLLBACK
	END
	END
	IF(@flag=0)
	BEGIN
	DELETE
	FROM   [Prs].[Prs_tblPersonalInfo]
	WHERE  fldId = @fldId
		IF(@@ERROR<>0)
	BEGIN
		SET @flag=1
		ROLLBACK
	END
	END
	COMMIT
GO
