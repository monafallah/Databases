SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
create PROC [Auto].[spr_UpdateInternalAssignmentReceiver](@fldId INT,@StatusID int)
AS
begin tran
UPDATE tblInternalAssignmentReceiver
SET fldAssignmentStatusID=@StatusID WHERE fldID=@fldId
if (@@error<>0)
rollback
commit
GO
