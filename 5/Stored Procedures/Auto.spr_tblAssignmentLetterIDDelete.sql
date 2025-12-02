SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
create PROC [Auto].[spr_tblAssignmentLetterIDDelete] 
    @fldId bigint,
    @fldUserID int
AS 
	BEGIN TRAN
	DECLARE @fldAssignmentId INT
	SELECT    @fldAssignmentId=fldID
FROM         tblAssignment
WHERE fldLetterID=@fldId

	DELETE
	FROM   [Auto].[tblInternalAssignmentReceiver]
	
	WHERE  fldAssignmentID = @fldAssignmentId
	IF(@@ERROR<>0) ROLLBACK
	else
	begin
		DELETE
		FROM   [Auto].[tblInternalAssignmentSender]
		
		WHERE  fldAssignmentID = @fldAssignmentId
		IF(@@ERROR<>0) ROLLBACK
		begin
			update   [Auto].[tblAssignment]
			set flduserId=@fldUserID,fldDate-=getdate()
			WHERE  [fldLetterID] = @fldID
			IF(@@ERROR<>0) ROLLBACK
			else 
				begin
				DELETE
				FROM   [Auto].[tblAssignment]
				WHERE  [fldLetterID] = @fldID

				IF(@@ERROR<>0) ROLLBACK
				end
			end
	end
	COMMIT TRAN
GO
