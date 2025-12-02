SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROC [Auto].[spr_tblNumberingFormatUpdate] 
    @fldID int,
    @fldYear int,
    @fldSecretariatID int,
    @fldNumberFormat nvarchar(100),
    @fldStartNumber int,
    @fldOrganID int,
    
    @fldUserID int,
    @fldDesc nvarchar(MAX),
    @fldIP varchar(15)
AS 
	BEGIN TRAN
	SET @fldNumberFormat=com.fn_TextNormalize(@fldNumberFormat)
	UPDATE [Auto].[tblNumberingFormat]
	SET    [fldID] = @fldID, [fldYear] = @fldYear, [fldSecretariatID] = @fldSecretariatID, [fldNumberFormat] = @fldNumberFormat, [fldStartNumber] = @fldStartNumber, [fldOrganID] = @fldOrganID, [fldDate] = GETDATE(), [fldUserID] = @fldUserID, [fldDesc] = @fldDesc, [fldIP] = @fldIP
	WHERE  [fldID] = @fldID
	COMMIT TRAN
GO
