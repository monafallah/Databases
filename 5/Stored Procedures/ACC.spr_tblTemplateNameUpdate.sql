SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [ACC].[spr_tblTemplateNameUpdate] 
    @fldId int,
    @fldName nvarchar(100),
    @fldAccountingTypeId INT,
    @fldDesc nvarchar(MAX),
    
    @fldIp varchar(16),
    @fldUserId int
AS 
	BEGIN TRAN
	SET @fldName=Com.fn_TextNormalize(@fldName)
	SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
	UPDATE [ACC].[tblTemplateName]
	SET    [fldId] = @fldId, [fldName] = @fldName,[fldAccountingTypeId]=@fldAccountingTypeId, [fldDesc] = @fldDesc, [fldDate] = GETDATE(), [fldIp] = @fldIp, [fldUserId] = @fldUserId
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
