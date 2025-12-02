SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblGozareshatFileDelete] 
	@fldID int,
	@fldUserID int
AS BEGIN TRAN
  declare @fileID int,@flag bit=0
  select @fileID=fldReportFileId from tblGozareshatFile where fldId=@fldID
 IF(@@ERROR<>0)
	BEGIN
		SET @flag=1
		ROLLBACK
	END
	IF(@flag=0)
	BEGIN
	DELETE
	FROM   [Drd].[tblGozareshatFile]
	WHERE  fldId = @fldId
	UPDATE    [Com].[tblFile]
	SET fldUserId=@fldUserId , flddate=GETDATE()
	WHERE fldid=@fileId
	DELETE
	FROM   [Com].[tblFile]
	WHERE  fldId = @fileId
	end

	COMMIT
GO
