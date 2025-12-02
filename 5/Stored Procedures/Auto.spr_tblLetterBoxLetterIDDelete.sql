SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Auto].[spr_tblLetterBoxLetterIDDelete] 
    @fieldName nvarchar(50),
	@fldId bigint,
    @fldUserID int
AS 
	BEGIN TRAN
	if (@fieldName='Letter')
	begin
	update  [Auto].[tblLetterBox]
	set fldUserID=@fldUserID,fldDate=getdate()
	where  fldLetterID = @fldID
	if (@@ERROR<>0)
	rollback
	else
	begin
	DELETE
	FROM   [Auto].[tblLetterBox]
	
	WHERE  fldLetterID = @fldID

	IF(@@ERROR<>0) ROLLBACK
	end
	end
	if (@fieldName ='Mesage')
	begin
	update  [Auto].[tblLetterBox]
	set fldUserID=@fldUserID,fldDate=getdate()
	where  fldMessageId = @fldID
	if (@@ERROR<>0)
	rollback
	else
	begin
	DELETE
	FROM   [Auto].[tblLetterBox]
	
	WHERE  fldMessageId = @fldID

	IF(@@ERROR<>0) ROLLBACK
	end
	end
	COMMIT TRAN

GO
