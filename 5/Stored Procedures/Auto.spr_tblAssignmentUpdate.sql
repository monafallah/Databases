SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROC [Auto].[spr_tblAssignmentUpdate] 
    @fldID int,
    @fldLetterID bigint,
	@fldMessageId int,
    @fldAnswerDate nvarchar(20),
    @fldSourceAssId	bigint,
    @fldUserID int,
    @fldDesc nvarchar(MAX),
	@fldOrganId INT,
	@fldIP nvarchar(16)
AS 
	BEGIN TRAN
    set @fldDesc=com.fn_TextNormalize(@fldDesc)
	UPDATE [Auto].[tblAssignment]
	SET    [fldLetterID] = @fldLetterID,fldMessageId=@fldMessageId, [fldAnswerDate] = @fldAnswerDate, [fldSourceAssId]=@fldSourceAssId,[fldDesc] = @fldDesc
	,fldUserID=@fldUserID,fldIP=@fldIP,fldDate=GETDATE(),fldOrganId=@fldOrganId
	WHERE  [fldID] = @fldID

	IF(@@ERROR<>0) ROLLBACK

	COMMIT TRAN

GO
