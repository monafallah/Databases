SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [ACC].[spr_tblLevelsAccountingTypeInsert] 
   
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
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [ACC].[tblLevelsAccountingType] 
	INSERT INTO [ACC].[tblLevelsAccountingType] ([fldId], [fldName], [fldAccountTypeId], [fldArghumNum], [fldDesc], [flddate], [fldIp], [fldUserId])
	SELECT @fldId, @fldName, @fldAccountTypeId, @fldArghumNum, @fldDesc, GETDATE(), @fldIp, @fldUserId
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
