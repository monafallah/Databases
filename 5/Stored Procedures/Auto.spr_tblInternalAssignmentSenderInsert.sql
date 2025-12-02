SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
create PROC [Auto].[spr_tblInternalAssignmentSenderInsert] 
    @fldAssignmentID bigint,
    @fldSenderComisionID int,
    @fldBoxID int,
	@fldOrganId int,
    @fldUserID int,
    @fldDesc nvarchar(100),
	@fldIP nvarchar(16)
AS 
	DECLARE @fldID int
	select @fldId =ISNULL(max(fldId),0)+1 from [Auto].[tblInternalAssignmentSender]
    set @fldDesc=com.fn_TextNormalize(@fldDesc)
	BEGIN TRAN
	
	INSERT INTO [Auto].[tblInternalAssignmentSender] ([fldID], [fldAssignmentID], [fldSenderComisionID], [fldBoxID], [fldDate], [fldUserID], [fldDesc],fldIP,fldOrganId )
	
	SELECT @fldID, @fldAssignmentID, @fldSenderComisionID, @fldBoxID, GETDATE(), @fldUserID, @fldDesc,@fldIP,@fldOrganId
         
	IF(@@ERROR<>0) ROLLBACK

	COMMIT TRAN

GO
