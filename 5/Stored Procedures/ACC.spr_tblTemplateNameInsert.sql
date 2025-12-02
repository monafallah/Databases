SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [ACC].[spr_tblTemplateNameInsert] 
    
    @fldName nvarchar(100),
    @fldAccountingTypeId INT,
    @fldDesc nvarchar(MAX),
    
    @fldIp varchar(16),
    @fldUserId int
AS 
	
	BEGIN TRAN
	SET @fldName=Com.fn_TextNormalize(@fldName)
	SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [ACC].[tblTemplateName] 
	INSERT INTO [ACC].[tblTemplateName] ([fldId], [fldName],[fldAccountingTypeId], [fldDesc], [fldDate], [fldIp], [fldUserId])
	SELECT @fldId, @fldName,@fldAccountingTypeId, @fldDesc,GETDATE(), @fldIp, @fldUserId
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
