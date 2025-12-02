SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblFiscal_Header_DetailUpdate] 
    @fldId int,
    @fldEffectiveDate nvarchar(10),
    @fldDateOfIssue nvarchar(10),
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
	UPDATE [Pay].[tblFiscal_Header]
	SET    [fldId] = @fldId, [fldEffectiveDate] = @fldEffectiveDate, [fldDateOfIssue] = @fldDateOfIssue, [fldUserId] = @fldUserId, [fldDate] = GETDATE(), [fldDesc] = @fldDesc
	WHERE  [fldId] = @fldId
	
	UPDATE [Pay].[tblFiscal_Detail]
	SET    [fldAmountFrom] = @fldAmountFrom, [fldAmountTo] = @fldAmountTo, [fldPercentTaxOnWorkers] = @fldPercentTaxOnWorkers, [fldTaxationOfEmployees] = @fldTaxationOfEmployees, [fldTax] = @fldTax, [fldUserId] = @fldUserId, [fldDate] = GETDATE(), [fldDesc] = @fldDesc
	WHERE   [fldFiscalHeaderId] = @fldId

	
	COMMIT TRAN
GO
