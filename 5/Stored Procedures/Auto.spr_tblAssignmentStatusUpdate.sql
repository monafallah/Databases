SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
create PROC [Auto].[spr_tblAssignmentStatusUpdate] 
    @fldID int,
    @fldName nvarchar(50),
    @fldUserID int,
    @fldDesc nvarchar(100),
@fldOrganId int,
@fldIP nvarchar(16)
AS 
	BEGIN TRAN
	set @fldName=com.fn_TextNormalize(@fldName)
    set @fldDesc=com.fn_TextNormalize(@fldDesc)
	UPDATE Auto.[tblAssignmentStatus]
	SET     [fldName] = @fldName, [fldDesc] = @fldDesc
	
	WHERE  [fldID] = @fldID

	IF(@@ERROR<>0) ROLLBACK

	COMMIT TRAN

GO
