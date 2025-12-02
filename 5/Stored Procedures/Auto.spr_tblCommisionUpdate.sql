SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Auto].[spr_tblCommisionUpdate] 
    @fldID int,
    @fldAshkhasID int,
    @fldOrganizPostEjraeeID int,
    @fldStartDate CHAR(10),
    @fldEndDate CHAR(10),
    @fldOrganicNumber nvarchar(100),
		@fldSign bit,
    @fldOrganID int,
    
    @fldUserID int,
    @fldDesc nvarchar(MAX),
    @fldIP varchar(15)
AS 
	BEGIN TRAN
	SET @fldOrganicNumber=com.fn_TextNormalize(@fldOrganicNumber)
	UPDATE [Auto].[tblCommision]
	SET    [fldID] = @fldID, [fldAshkhasID] = @fldAshkhasID, [fldOrganizPostEjraeeID] = @fldOrganizPostEjraeeID, [fldStartDate] = @fldStartDate, [fldEndDate] = @fldEndDate, [fldOrganicNumber] = @fldOrganicNumber, [fldOrganID] = @fldOrganID, [fldDate] = GETDATE(), [fldUserID] = @fldUserID, [fldDesc] = @fldDesc, [fldIP] = @fldIP
	,fldSign=@fldSign
	WHERE  [fldID] = @fldID
	COMMIT TRAN
GO
