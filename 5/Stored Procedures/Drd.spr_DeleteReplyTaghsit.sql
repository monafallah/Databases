SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_DeleteReplyTaghsit](@RequestId INT)
as
DECLARE @IdStatus INT,@fldElamAvarezId INT,@Flag bit
SELECT @fldElamAvarezId=fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid =@RequestId
SELECT @IdStatus=fldId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId=@RequestId

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
DELETE FROM Drd.tblCodhayeDaramadiElamAvarez WHERE fldElamAvarezId=@fldElamAvarezId AND fldSharheCodeDaramad=N'کارمزد تقسیط'
		IF(@@ERROR<>0)
	BEGIN
		ROLLBACK
		SET @Flag=1
	END
END
GO
