SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [ACC].[spr_tblFiscalYearUpdate] 
    @fldId int,
    @fldOrganId int,
    @fldYear smallint,
    @fldDesc nvarchar(MAX),
    
    @fldIP varchar(16),
    @fldUserId int
AS 
	BEGIN TRAN
	
	SET @fldDesc=Com.fn_TextNormalize(@fldDesc) 
	
	UPDATE [ACC].[tblFiscalYear]
	SET    [fldId] = @fldId, [fldOrganId] = @fldOrganId, [fldYear] = @fldYear, [fldDesc] = @fldDesc, [fldDate] = GETDATE(), [fldIP] = @fldIP, [fldUserId] = @fldUserId
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
