SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [ACC].[spr_tblAccountingLevelUpdate] 
    @fldId int,
    @fldName NVARCHAR(50),
    @fldOrganId int,
    @fldYear smallint,
    @fldArghamNum int,
    @fldDesc nvarchar(MAX),
    @fldIP varchar(16),
    @fldUserId int
AS 
	BEGIN TRAN
	SET @fldName=Com.fn_TextNormalize(@fldName)
	SET @fldDesc=Com.fn_TextNormalize(@fldDesc) 
	
	UPDATE [ACC].[tblAccountingLevel]
	SET    [fldId] = @fldId,[fldName]=@fldName, [fldOrganId] = @fldOrganId, [fldYear] = @fldYear, [fldArghamNum] = @fldArghamNum,  [fldDesc] = @fldDesc, [fldDate] = GETDATE(), [fldIP] = @fldIP, [fldUserId] = @fldUserId
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
