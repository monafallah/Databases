SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Auto].[spr_tblReceiverAssignmentTypeUpdate] 
    @fldID int,
    @fldAssignmentID int,
    @fldReceiverComisionID int,
    @fldAssignmentStatusID int,
    @fldAssignmentTypeID int,
    @fldBoxID int,
    @fldLetterReadDate nvarchar(20),
    @fldShowTypeT_F bit,
  
    @fldUserID int,
    @fldOrganId int,
    @fldDesc nvarchar(100),
    @fldIP nvarchar(16)
AS 

	BEGIN TRAN

	UPDATE [Auto].[tblReceiverAssignmentType]
	SET    [fldAssignmentID] = @fldAssignmentID, [fldReceiverComisionID] = @fldReceiverComisionID, [fldAssignmentStatusID] = @fldAssignmentStatusID, [fldAssignmentTypeID] = @fldAssignmentTypeID, [fldBoxID] = @fldBoxID, [fldLetterReadDate] = @fldLetterReadDate, [fldShowTypeT_F] = @fldShowTypeT_F, [fldDate] = getdATE(), [fldUserID] = @fldUserID, [fldOrganId] = @fldOrganId, [fldDesc] = @fldDesc, [fldIP] = @fldIP
	WHERE  fldId=@fldId
	if(@@Error<>0)
        rollback   

	COMMIT
GO
