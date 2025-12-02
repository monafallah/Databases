SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblTakhfifDelete] 
	@fldID int,
	@fldUserID int
AS 
	BEGIN TRAN
	DECLARE @flag INT=0
	DELETE Drd.tblTakhfifDetail
	WHERE fldTakhfifId=@fldID
	if(@@Error<>0)
	BEGIN
		SET @flag=1
		ROLLBACK
	END

	IF(@flag=0)
	BEGIN 
		UPDATE   [Drd].[tblTakhfif]
		SET fldUserId=@fldUserId , flddate=GETDATE()
		WHERE  fldId = @fldId
		DELETE
		FROM   [Drd].[tblTakhfif]
		WHERE  fldId = @fldId
		if(@@Error<>0)
		BEGIN
			ROLLBACK
		END
	END 
	COMMIT
GO
