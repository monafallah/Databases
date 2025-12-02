SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
create PROC [Auto].[spr_tblInternalAssignmentSenderUpdate] 
    @fldID int,
    @fldAssignmentID bigint,
    @fldSenderComisionID int,
    @fldBoxID int,
	@fldOrganId int,
    @fldUserID int,
    @fldDesc nvarchar(100),
	@fldIP nvarchAR(16)
AS 
	BEGIN TRAN
    set @fldDesc=COM.fn_TextNormalize(@fldDesc)
	UPDATE [dbo].[tblInternalAssignmentSender]
	SET    [fldAssignmentID] = @fldAssignmentID, [fldSenderComisionID] = @fldSenderComisionID, [fldBoxID] = @fldBoxID, [fldDesc] = @fldDesc
,fldOrganId=@fldOrganId,fldIP=@fldIP
	WHERE  [fldID] = @fldID

	IF(@@ERROR<>0) ROLLBACK

	COMMIT TRAN

GO
