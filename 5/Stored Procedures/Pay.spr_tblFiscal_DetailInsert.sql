SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblFiscal_DetailInsert] 
   
    @fldFiscalHeaderId int,
    @fldAmountFrom int,
    @fldAmountTo int,
    @fldPercentTaxOnWorkers decimal(8, 4),
    @fldTaxationOfEmployees decimal(8, 4),
    @fldTax int,
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	
	BEGIN TRAN
	declare @fldID int 
	SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
	select @fldID =ISNULL(max(fldId),0)+1 from [Pay].[tblFiscal_Detail] 
	INSERT INTO [Pay].[tblFiscal_Detail] ([fldId], [fldFiscalHeaderId], [fldAmountFrom], [fldAmountTo], [fldPercentTaxOnWorkers], [fldTaxationOfEmployees], [fldTax], [fldUserId], [fldDate], [fldDesc])
	SELECT @fldId, @fldFiscalHeaderId, @fldAmountFrom, @fldAmountTo, @fldPercentTaxOnWorkers, @fldTaxationOfEmployees, @fldTax, @fldUserId, GETDATE(), @fldDesc
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
