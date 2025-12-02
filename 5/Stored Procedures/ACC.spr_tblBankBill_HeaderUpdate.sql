SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [ACC].[spr_tblBankBill_HeaderUpdate] 
    @fldId int,
    @fldName nvarchar(200),
    @fldShomareHesabId int,
    @fldFiscalYearId int,
    @fldJsonFile nvarchar(MAX),
    @fldDesc nvarchar(200),
    @fldIP varchar(16),
    @fldUserId int,
	@fldPatternId int
AS 
	 
	
	BEGIN TRAN

	UPDATE [ACC].[tblBankBill_Header]
	SET    [fldName] = @fldName,  [fldShomareHesabId] = @fldShomareHesabId, [fldFiscalYearId] = @fldFiscalYearId, [fldJsonFile] = @fldJsonFile, [fldDesc] = @fldDesc, [fldDate] = getdate(), [fldIP] = @fldIP, [fldUserId] = @fldUserId
	,fldPatternId=@fldPatternId
	WHERE  [fldId] = @fldId
	
	if (@@error<>0)
		rollback

	COMMIT
GO
