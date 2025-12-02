SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [ACC].[spr_tblLevelsAccountingTypeUpdate] 
    @fldId int,
    @fldName nvarchar(100),
    @fldAccountTypeId int,
    @fldArghumNum int,
    @fldDesc nvarchar(MAX),
   
    @fldIp varchar(16),
    @fldUserId int
AS 
	BEGIN TRAN
	SET @fldName=Com.fn_TextNormalize(@fldName)
	SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
	UPDATE [ACC].[tblLevelsAccountingType]
	SET    [fldId] = @fldId, [fldName] = @fldName, [fldAccountTypeId] = @fldAccountTypeId, [fldArghumNum] = @fldArghumNum, [fldDesc] = @fldDesc, [flddate] = GETDATE(), [fldIp] = @fldIp, [fldUserId] = @fldUserId
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
