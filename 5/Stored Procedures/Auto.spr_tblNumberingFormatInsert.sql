SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Auto].[spr_tblNumberingFormatInsert] 
    
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
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [Auto].[tblNumberingFormat] 
	INSERT INTO [Auto].[tblNumberingFormat] ([fldID], [fldYear], [fldSecretariatID], [fldNumberFormat], [fldStartNumber], [fldOrganID], [fldDate], [fldUserID], [fldDesc], [fldIP])
	SELECT @fldID, @fldYear, @fldSecretariatID, @fldNumberFormat, @fldStartNumber, @fldOrganID, GETDATE(), @fldUserID, @fldDesc, @fldIP
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
