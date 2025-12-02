SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblFiscal_DetailUpdate] 
    @fldId int,
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
	SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
	UPDATE [Pay].[tblFiscal_Detail]
	SET    [fldId] = @fldId, [fldFiscalHeaderId] = @fldFiscalHeaderId, [fldAmountFrom] = @fldAmountFrom, [fldAmountTo] = @fldAmountTo, [fldPercentTaxOnWorkers] = @fldPercentTaxOnWorkers, [fldTaxationOfEmployees] = @fldTaxationOfEmployees, [fldTax] = @fldTax, [fldUserId] = @fldUserId, [fldDate] = GETDATE(), [fldDesc] = @fldDesc
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
