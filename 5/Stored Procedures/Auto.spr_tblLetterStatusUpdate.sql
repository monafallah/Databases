SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
create PROC [Auto].[spr_tblLetterStatusUpdate] 
    @fldID int,
    @fldName nvarchar(500),
    @fldUserID int,
	@fldOrganId int,
    @fldDesc nvarchar(100),
	@fldIP nvarchar(16)
AS 
	BEGIN TRAN
	set @fldName=com.fn_TextNormalize(@fldName)
    set @fldDesc=com.fn_TextNormalize(@fldDesc)
	UPDATE [dbo].[tblLetterStatus]
	SET    [fldName] = @fldName, [fldDesc] = @fldDesc,fldUserId=@fldUserId,fldOrganId=@fldOrganId,fldIp=@fldIP
	,fldDate=Getdate()
	WHERE  [fldID] = @fldID

	IF(@@ERROR<>0) ROLLBACK

	COMMIT TRAN

GO
