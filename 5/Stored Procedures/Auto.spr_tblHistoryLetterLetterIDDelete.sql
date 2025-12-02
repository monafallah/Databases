SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
create PROC [Auto].[spr_tblHistoryLetterLetterIDDelete] 
    @fldId BIGINT,
    @fldUserID INT
AS 
BEGIN TRAN
	update    [Auto].[tblHistoryLetter]
	set fldUserId=@fldUserID,fldDate=getdate()
	WHERE  [fldCurrentLetter_Id] = @fldId
	if (@@error<>0)
	rollback
	else 
	begin
	DELETE
	FROM   [Auto].[tblHistoryLetter]
	WHERE  [fldCurrentLetter_Id] = @fldId
	end
IF(@@ERROR<>0)
  ROLLBACK
COMMIT TRAN
GO
