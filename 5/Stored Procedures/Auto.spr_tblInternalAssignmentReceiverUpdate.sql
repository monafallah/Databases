SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Auto].[spr_tblInternalAssignmentReceiverUpdate] 
    @fldID int,
    @fldAssignmentID int,
    @fldReceiverComisionId int,
    @fldAssignmentStatusId int,
    @fldAssignmentTypeID int,
    @fldBoxId int,
    @fldLetterReadDate nvarchar(20) = NULL,
    @fldShowTypeT_F bit,
    @fldUserID int,
    @fldDesc nvarchar(100) = NULL,
  
    @fldOrganId int,
    @fldIP nvarchar(16)
AS 

	BEGIN TRAN

	UPDATE [Auto].[tblInternalAssignmentReceiver]
	SET    [fldAssignmentID] = @fldAssignmentID, [fldReceiverComisionId] = @fldReceiverComisionId, [fldAssignmentStatusId] = @fldAssignmentStatusId, [fldAssignmentTypeID] = @fldAssignmentTypeID, [fldBoxId] = @fldBoxId, [fldLetterReadDate] = @fldLetterReadDate, [fldShowTypeT_F] = @fldShowTypeT_F, [fldUserID] = @fldUserID, [fldDesc] = @fldDesc, [fldDate] = getdate(), [fldOrganId] = @fldOrganId, [fldIP] = @fldIP
	WHERE  fldId=@fldId
	if(@@Error<>0)
        rollback   

	COMMIT
GO
