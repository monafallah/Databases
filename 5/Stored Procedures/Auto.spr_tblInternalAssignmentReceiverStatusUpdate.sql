SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE proc [Auto].[spr_tblInternalAssignmentReceiverStatusUpdate](@fldId int,@StatusId int,@fldUserID int)
as 
	BEGIN TRAN
		if(@StatusId<>2)
		begin
			UPDATE [Auto].[tblInternalAssignmentReceiver]
			SET    [fldAssignmentStatusID] = @StatusId
			output inserted.[fldID], inserted.[fldAssignmentID], inserted.[fldReceiverComisionID], inserted.[fldAssignmentStatusID], inserted.[fldAssignmentTypeID], inserted.[fldBoxID], inserted.[fldLetterReadDate], inserted.[fldShowTypeT_F], GETDATE(), @fldUserID, inserted.[fldDesc],2 into tblInternalAssignmentReceiver_Log
			WHERE  [fldID] = @fldId
		end
		else
		begin
		declare @tarikh nvarchar(20)=dbo.Fn_AssembelyMiladiToShamsi(getdate())+' '+ cast(cast(getdate() as time (0))as nvarchar(8)) 
			UPDATE [Auto].[tblInternalAssignmentReceiver]
			SET    [fldAssignmentStatusID] = @StatusId,[fldLetterReadDate]=@tarikh
		
			WHERE  [fldID] = @fldId
		end
		IF(@@ERROR<>0) ROLLBACK

	COMMIT TRAN
GO
