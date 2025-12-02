SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
create PROC [Auto].[spr_tblArchiveUpdate] 
    @fldID int,
    @fldName nvarchar(50),
    @fldPID int,
	@fldOrganId int,
    @fldUserID int,
    @fldDesc nvarchar(100),
	@fldIP nvarchar(16)

AS 
	BEGIN TRAN
	set @fldName=com.fn_TextNormalize(@fldName)
    set @fldDesc=com.fn_TextNormalize(@fldDesc)
	UPDATE [Auto].[tblArchive]
	SET     [fldName] = @fldName, [fldPID] = @fldPID, [fldDesc] = @fldDesc,fldUserId=@fldUserID,fldDate=GETDATE(),fldIp=@fldIP,@fldOrganId=@fldOrganId
	
	WHERE  [fldID] = @fldID

	IF(@@ERROR<>0) ROLLBACK

	COMMIT TRAN

GO
