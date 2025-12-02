SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Auto].[spr_tblInternalAssignmentReceiverInsert] 
   
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
	
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [Auto].[tblInternalAssignmentReceiver] 

	INSERT INTO [Auto].[tblInternalAssignmentReceiver] ([fldID], [fldAssignmentID], [fldReceiverComisionId], [fldAssignmentStatusId], [fldAssignmentTypeID], [fldBoxId], [fldLetterReadDate], [fldShowTypeT_F], [fldUserID], [fldDesc], [fldDate], [fldOrganId], [fldIP])
	SELECT @fldID, @fldAssignmentID, @fldReceiverComisionId, @fldAssignmentStatusId, @fldAssignmentTypeID, @fldBoxId, @fldLetterReadDate, @fldShowTypeT_F, @fldUserID, @fldDesc, getdate(), @fldOrganId, @fldIP
	if(@@Error<>0)
        rollback       
	COMMIT
GO
