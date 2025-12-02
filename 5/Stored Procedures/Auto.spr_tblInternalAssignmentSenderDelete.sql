SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
create PROC [Auto].[spr_tblInternalAssignmentSenderDelete] 
    @fldId int,
    @fldUserID int
AS 
	BEGIN TRAN
	update [Auto].[tblInternalAssignmentSender]
	set fldUserId=@fldUserId,fldDate=getdate()
	where fldid=@fldid
	if (@@Error<>0)
	rollback
	else
	begin
	DELETE
	FROM   [Auto].[tblInternalAssignmentSender]

	WHERE  [fldID] = @fldID

	IF(@@ERROR<>0) ROLLBACK
end
	COMMIT TRAN

GO
