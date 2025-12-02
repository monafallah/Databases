SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Auto].[spr_tblAssignmentTypeUpdate] 
    @fldID int,
    @fldType nvarchar(250),
    @fldOrganID int,
    
    @fldUserID int,
    @fldDesc nvarchar(MAX),
    @fldIP varchar(15)
AS 
	BEGIN TRAN
	SET @fldType=com.fn_TextNormalize(@fldType)
	UPDATE [Auto].[tblAssignmentType]
	SET    [fldID] = @fldID, [fldType] = @fldType, [fldOrganID] = @fldOrganID, [fldDate] = GETDATE(), [fldUserID] = @fldUserID, [fldDesc] = @fldDesc, [fldIP] = @fldIP
	WHERE  [fldID] = @fldID
	COMMIT TRAN
GO
