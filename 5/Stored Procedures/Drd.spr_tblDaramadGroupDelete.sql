SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblDaramadGroupDelete] 
	@fldID int,
	@fldUserID int
AS 
	BEGIN TRAN
	DECLARE @flag BIT=0
	UPDATE   [Drd].[tblDaramadGroup_Parametr]
		SET fldUserId=@fldUserId , flddate=GETDATE()
		WHERE fldDaramadGroupId = @fldId
	DELETE
	FROM   [Drd].[tblDaramadGroup_Parametr]
	WHERE  fldDaramadGroupId = @fldId
	IF(@@ERROR<>0)
	BEGIN
		ROLLBACK
		SET @flag=1
	END
	IF(@flag=0)
	BEGIN
		UPDATE    [Drd].[tblPatternFish_DaramadGroup]
		SET fldUserId=@fldUserId , flddate=GETDATE()
		WHERE fldDaramadGroupId = @fldId
	DELETE
	FROM   [Drd].[tblPatternFish_DaramadGroup]
	WHERE  fldDaramadGroupId = @fldId
		IF(@@ERROR<>0)
		BEGIN
		ROLLBACK
		SET @flag=1
		END
	END
	IF(@flag=0)
	BEGIN
		UPDATE     [Drd].[tblDaramadGroup]
		SET fldUserId=@fldUserId , flddate=GETDATE()
		WHERE  fldId = @fldId
	DELETE
	FROM   [Drd].[tblDaramadGroup]
	WHERE  fldId = @fldId
	IF(@@ERROR<>0)
		BEGIN
		ROLLBACK
		SET @flag=1
		END
	end

	
	COMMIT
GO
