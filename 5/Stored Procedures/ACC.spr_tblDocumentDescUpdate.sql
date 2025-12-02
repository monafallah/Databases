SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [ACC].[spr_tblDocumentDescUpdate] 
    @fldId int,
    @fldName nvarchar(200),
    @fldDocDesc nvarchar(MAX),
    @fldDesc nvarchar(MAX),
	@fldFlag bit,
    @fldIP varchar(16),
    @fldUserId int
AS 
	BEGIN TRAN
	
	SET @fldName=Com.fn_TextNormalize(@fldName)
	SET @fldDocDesc=Com.fn_TextNormalize(@fldDocDesc)
	SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
	UPDATE [ACC].[tblDocumentDesc]
	SET    [fldName] = @fldName, [fldDocDesc] = @fldDocDesc, [fldDesc] = @fldDesc, [fldDate] = GETDATE(), [fldIP] = @fldIP, [fldUserId] = @fldUserId,fldFlag=@fldFlag
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
