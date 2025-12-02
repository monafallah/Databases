SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [ACC].[spr_tblBankBill_HeaderInsert] 
    @fldid int out,
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
--declare @fldid int
	select @fldid=isnull(max(fldId),0)+1  FROM   [ACC].[tblBankBill_Header] 
	INSERT INTO [ACC].[tblBankBill_Header] ([fldId], [fldName],  [fldShomareHesabId], [fldFiscalYearId], [fldJsonFile], [fldDesc], [fldDate], [fldIP], [fldUserId],fldPatternId)
	SELECT @fldId, @fldName,  @fldShomareHesabId, @fldFiscalYearId, @fldJsonFile, @fldDesc, getdate(), @fldIP, @fldUserId,@fldPatternId
	
	if (@@error<>0)
		rollback
		
				
               
	COMMIT
GO
