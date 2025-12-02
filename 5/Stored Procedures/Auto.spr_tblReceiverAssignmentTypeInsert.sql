SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Auto].[spr_tblReceiverAssignmentTypeInsert] 
  
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
	
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [Auto].[tblReceiverAssignmentType] 

	INSERT INTO [Auto].[tblReceiverAssignmentType] ([fldID], [fldAssignmentID], [fldReceiverComisionID], [fldAssignmentStatusID], [fldAssignmentTypeID], [fldBoxID], [fldLetterReadDate], [fldShowTypeT_F], [fldDate], [fldUserID], [fldOrganId], [fldDesc], [fldIP])
	SELECT @fldID, @fldAssignmentID, @fldReceiverComisionID, @fldAssignmentStatusID, @fldAssignmentTypeID, @fldBoxID, @fldLetterReadDate, @fldShowTypeT_F, getdate(), @fldUserID, @fldOrganId, @fldDesc, @fldIP
	if(@@Error<>0)
        rollback       
	COMMIT
GO
