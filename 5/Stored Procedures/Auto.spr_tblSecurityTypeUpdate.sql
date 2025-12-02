SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Auto].[spr_tblSecurityTypeUpdate] 
    @fldID int,
    @fldSecurityType nvarchar(50),
    @fldOrganID int,
    
    @fldUserID int,
    @fldDesc nvarchar(MAX),
    @fldIP varchar(15)
AS 
	BEGIN TRAN
	SET @fldSecurityType=com.fn_TextNormalize(@fldSecurityType)
	UPDATE [Auto].[tblSecurityType]
	SET    [fldID] = @fldID, [fldSecurityType] = @fldSecurityType, [fldOrganID] = @fldOrganID, [fldDate] = GETDATE(), [fldUserID] = @fldUserID, [fldDesc] = @fldDesc, [fldIP] = @fldIP
	WHERE  [fldID] = @fldID
	COMMIT TRAN
GO
