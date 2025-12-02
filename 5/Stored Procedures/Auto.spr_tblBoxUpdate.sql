SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Auto].[spr_tblBoxUpdate] 
    @fldID int,
    @fldName nvarchar(50),
    @fldComisionID int,
    @fldBoxTypeID int,
    @fldPID int,
    @fldOrganID int,
    
    @fldUserID int,
    @fldDesc nvarchar(MAX),
    @fldIP varchar(15)
AS 
	BEGIN TRAN
	SET @fldName=com.fn_TextNormalize(@fldName)
	UPDATE [Auto].[tblBox]
	SET    [fldID] = @fldID, [fldName] = @fldName, [fldComisionID] = @fldComisionID, [fldBoxTypeID] = @fldBoxTypeID, [fldPID] = @fldPID, [fldOrganID] = @fldOrganID, [fldDate] = GETDATE(), [fldUserID] = @fldUserID, [fldDesc] = @fldDesc, [fldIP] = @fldIP
	WHERE  [fldID] = @fldID
	COMMIT TRAN
GO
