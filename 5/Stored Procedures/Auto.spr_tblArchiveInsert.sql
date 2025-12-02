SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
create PROC [Auto].[spr_tblArchiveInsert] 
    @fldName nvarchar(50),
    @fldPID int,
	@fldOrganId int,
    @fldUserID int,
    @fldDesc nvarchar(MAX),
	@fldIP nvarchar(16)
	
AS 
	DECLARE @fldID int
	select @fldId =ISNULL(max(fldId),0)+1 from [auto].[tblArchive]
	set @fldName=com.fn_TextNormalize(@fldName)
    set @fldDesc=com.fn_TextNormalize(@fldDesc)
	BEGIN TRAN
	
	INSERT INTO [dbo].[tblArchive] ([fldID], [fldName], [fldPID], [fldDate], [fldUserID], [fldDesc],fldOrganId,fldIP)
	
	SELECT @fldID, @fldName, @fldPID, GETDATE(), @fldUserID, @fldDesc,@fldOrganId,@fldIP
         
	IF(@@ERROR<>0) ROLLBACK

	COMMIT TRAN

GO
