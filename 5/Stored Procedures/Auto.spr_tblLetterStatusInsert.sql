SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
create PROC [Auto].[spr_tblLetterStatusInsert] 
    @fldName nvarchar(500),
    @fldUserID int,
	@fldOrganId int,
    @fldDesc nvarchar(100),
	@fldIP nvarchar(16)
AS 
	DECLARE @fldID int
	select @fldId =ISNULL(max(fldId),0)+1 from [Auto].[tblLetterStatus]
	set @fldName=com.fn_TextNormalize(@fldName)
    set @fldDesc=com.fn_TextNormalize(@fldDesc)
	BEGIN TRAN
	
	INSERT INTO [Auto].[tblLetterStatus] ([fldID], [fldName], [fldDate], [fldUserID], [fldDesc],fldorganId,fldIP)
	
	SELECT @fldID, @fldName, GETDATE(), @fldUserID, @fldDesc,@fldorganId,@fldIP
         
	IF(@@ERROR<>0) ROLLBACK

	COMMIT TRAN

GO
