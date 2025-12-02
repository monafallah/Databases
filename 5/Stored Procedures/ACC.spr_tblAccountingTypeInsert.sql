SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [ACC].[spr_tblAccountingTypeInsert] 
    
    @fldName nvarchar(50),
    @fldDesc nvarchar(MAX),
    
    @fldIP varchar(16),
    @fldUserId int
AS 
	
	BEGIN TRAN
	SET @fldName=Com.fn_TextNormalize(@fldName)
	SET @fldDesc=Com.fn_TextNormalize(@fldDesc) 
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [ACC].[tblAccountingType] 
	INSERT INTO [ACC].[tblAccountingType] ([fldId], [fldName], [fldDesc], [fldDate], [fldIP], [fldUserId])
	SELECT @fldId, @fldName, @fldDesc, GETDATE(), @fldIP, @fldUserId
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
