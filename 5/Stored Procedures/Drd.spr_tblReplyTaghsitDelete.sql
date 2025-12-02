SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblReplyTaghsitDelete] 
	@fldID int,
	@fldUserID int
AS 
	BEGIN TRAN
	DECLARE @IdStatus INT,@fldElamAvarezId INT,@Flag BIT=0
	SELECT @fldElamAvarezId=fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid =@fldID
	SELECT @IdStatus=fldId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId=@fldID

	DELETE FROM Drd.tblReplyTaghsit WHERE fldStatusId=@IdStatus
	IF(@@ERROR<>0)
	BEGIN
		ROLLBACK
		SET @Flag=1
	END
	IF(@Flag=0)
	BEGIN
	DELETE FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId=@IdStatus
		IF(@@ERROR<>0)
		BEGIN
			ROLLBACK
			SET @Flag=1
		END
	END
	IF(@Flag=0)
	BEGIN
		UPDATE  Drd.tblCodhayeDaramadiElamAvarez
		SET fldUserId=@fldUserId , flddate=GETDATE()
		WHERE  fldElamAvarezId=@fldElamAvarezId AND fldSharheCodeDaramad=N'کارمزد تقسیط'
		
	DELETE FROM Drd.tblCodhayeDaramadiElamAvarez WHERE fldElamAvarezId=@fldElamAvarezId AND fldSharheCodeDaramad=N'کارمزد تقسیط'
			IF(@@ERROR<>0)
		BEGIN
			ROLLBACK
			SET @Flag=1
		END
	END

	COMMIT
GO
