SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
create PROC [Auto].[spr_tblAssignmentStatusInsert] 
    @fldName nvarchar(50),
    @fldUserID int,
    @fldDesc nvarchar(100),
	@fldOrganId int,
	@fldIP nvarchar(16)
AS 
	DECLARE @fldID int
	select @fldId =ISNULL(max(fldId),0)+1 from [dbo].[tblAssignmentStatus]
	set @fldName=com.fn_TextNormalize(@fldName)
    set @fldDesc=com.fn_TextNormalize(@fldDesc)
	BEGIN TRAN
	
	INSERT INTO [dbo].[tblAssignmentStatus] ([fldID], [fldName], [fldDate], [fldUserID], [fldDesc],fldOrganId ,fldIp)
	
	SELECT @fldID, @fldName, GETDATE(), @fldUserID, @fldDesc,@fldOrganId,@fldIP
         
	IF(@@ERROR<>0) ROLLBACK

	COMMIT TRAN

GO
