SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblFiscal_DetailSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@h int
AS 
	BEGIN TRAN
	if (@h=0) set @h=2147483647
	SET @Value=Com.fn_TextNormalize(@Value)
	if (@fieldname=N'fldId')
	SELECT     TOP (@h) Pay.tblFiscal_Detail.fldId, Pay.tblFiscal_Detail.fldFiscalHeaderId, Pay.tblFiscal_Detail.fldAmountFrom, Pay.tblFiscal_Detail.fldAmountTo, 
                      Pay.tblFiscal_Detail.fldPercentTaxOnWorkers, Pay.tblFiscal_Detail.fldTaxationOfEmployees, Pay.tblFiscal_Detail.fldTax, Pay.tblFiscal_Detail.fldUserId, 
                      Pay.tblFiscal_Detail.fldDate, Pay.tblFiscal_Detail.fldDesc, fldEffectiveDate, fldDateOfIssue
	FROM         Pay.tblFiscal_Detail INNER JOIN
                      Pay.tblFiscal_Header ON Pay.tblFiscal_Detail.fldFiscalHeaderId = Pay.tblFiscal_Header.fldId
	WHERE  Pay.tblFiscal_Detail.fldId = @Value
	order by fldFiscalHeaderId
	
	if (@fieldname=N'fldFiscalHeaderId')
	SELECT     TOP (@h) Pay.tblFiscal_Detail.fldId, Pay.tblFiscal_Detail.fldFiscalHeaderId, Pay.tblFiscal_Detail.fldAmountFrom, Pay.tblFiscal_Detail.fldAmountTo, 
                      Pay.tblFiscal_Detail.fldPercentTaxOnWorkers, Pay.tblFiscal_Detail.fldTaxationOfEmployees, Pay.tblFiscal_Detail.fldTax, Pay.tblFiscal_Detail.fldUserId, 
                      Pay.tblFiscal_Detail.fldDate, Pay.tblFiscal_Detail.fldDesc, fldEffectiveDate, fldDateOfIssue
	FROM         Pay.tblFiscal_Detail INNER JOIN
                      Pay.tblFiscal_Header ON Pay.tblFiscal_Detail.fldFiscalHeaderId = Pay.tblFiscal_Header.fldId
	WHERE  Pay.tblFiscal_Detail.fldFiscalHeaderId = @Value
	order by fldFiscalHeaderId
	
	if (@fieldname=N'fldAmountFrom')
		SELECT     TOP (@h) Pay.tblFiscal_Detail.fldId, Pay.tblFiscal_Detail.fldFiscalHeaderId, Pay.tblFiscal_Detail.fldAmountFrom, Pay.tblFiscal_Detail.fldAmountTo, 
                      Pay.tblFiscal_Detail.fldPercentTaxOnWorkers, Pay.tblFiscal_Detail.fldTaxationOfEmployees, Pay.tblFiscal_Detail.fldTax, Pay.tblFiscal_Detail.fldUserId, 
                      Pay.tblFiscal_Detail.fldDate, Pay.tblFiscal_Detail.fldDesc, fldEffectiveDate, fldDateOfIssue
	FROM         Pay.tblFiscal_Detail INNER JOIN
                      Pay.tblFiscal_Header ON Pay.tblFiscal_Detail.fldFiscalHeaderId = Pay.tblFiscal_Header.fldId
	WHERE  Pay.tblFiscal_Detail.fldAmountFrom like @Value
	order by fldFiscalHeaderId
	
	if (@fieldname=N'fldAmountTo')
		SELECT     TOP (@h) Pay.tblFiscal_Detail.fldId, Pay.tblFiscal_Detail.fldFiscalHeaderId, Pay.tblFiscal_Detail.fldAmountFrom, Pay.tblFiscal_Detail.fldAmountTo, 
                      Pay.tblFiscal_Detail.fldPercentTaxOnWorkers, Pay.tblFiscal_Detail.fldTaxationOfEmployees, Pay.tblFiscal_Detail.fldTax, Pay.tblFiscal_Detail.fldUserId, 
                      Pay.tblFiscal_Detail.fldDate, Pay.tblFiscal_Detail.fldDesc, fldEffectiveDate, fldDateOfIssue
	FROM         Pay.tblFiscal_Detail INNER JOIN
                      Pay.tblFiscal_Header ON Pay.tblFiscal_Detail.fldFiscalHeaderId = Pay.tblFiscal_Header.fldId
	WHERE  Pay.tblFiscal_Detail.fldAmountTo like @Value
	order by fldFiscalHeaderId
	
	if (@fieldname=N'fldPercentTaxOnWorkers')
		SELECT     TOP (@h) Pay.tblFiscal_Detail.fldId, Pay.tblFiscal_Detail.fldFiscalHeaderId, Pay.tblFiscal_Detail.fldAmountFrom, Pay.tblFiscal_Detail.fldAmountTo, 
                      Pay.tblFiscal_Detail.fldPercentTaxOnWorkers, Pay.tblFiscal_Detail.fldTaxationOfEmployees, Pay.tblFiscal_Detail.fldTax, Pay.tblFiscal_Detail.fldUserId, 
                      Pay.tblFiscal_Detail.fldDate, Pay.tblFiscal_Detail.fldDesc, fldEffectiveDate, fldDateOfIssue
	FROM         Pay.tblFiscal_Detail INNER JOIN
                      Pay.tblFiscal_Header ON Pay.tblFiscal_Detail.fldFiscalHeaderId = Pay.tblFiscal_Header.fldId
	WHERE  Pay.tblFiscal_Detail.fldAmountFrom like @Value
	order by fldFiscalHeaderId
	
	if (@fieldname=N'fldTaxationOfEmployees')
		SELECT     TOP (@h) Pay.tblFiscal_Detail.fldId, Pay.tblFiscal_Detail.fldFiscalHeaderId, Pay.tblFiscal_Detail.fldAmountFrom, Pay.tblFiscal_Detail.fldAmountTo, 
                      Pay.tblFiscal_Detail.fldPercentTaxOnWorkers, Pay.tblFiscal_Detail.fldTaxationOfEmployees, Pay.tblFiscal_Detail.fldTax, Pay.tblFiscal_Detail.fldUserId, 
                      Pay.tblFiscal_Detail.fldDate, Pay.tblFiscal_Detail.fldDesc, fldEffectiveDate, fldDateOfIssue
	FROM         Pay.tblFiscal_Detail INNER JOIN
                      Pay.tblFiscal_Header ON Pay.tblFiscal_Detail.fldFiscalHeaderId = Pay.tblFiscal_Header.fldId
	WHERE  Pay.tblFiscal_Detail.fldAmountFrom like @Value
	order by fldFiscalHeaderId
	
	if (@fieldname=N'fldTax')
		SELECT     TOP (@h) Pay.tblFiscal_Detail.fldId, Pay.tblFiscal_Detail.fldFiscalHeaderId, Pay.tblFiscal_Detail.fldAmountFrom, Pay.tblFiscal_Detail.fldAmountTo, 
                      Pay.tblFiscal_Detail.fldPercentTaxOnWorkers, Pay.tblFiscal_Detail.fldTaxationOfEmployees, Pay.tblFiscal_Detail.fldTax, Pay.tblFiscal_Detail.fldUserId, 
                      Pay.tblFiscal_Detail.fldDate, Pay.tblFiscal_Detail.fldDesc, fldEffectiveDate, fldDateOfIssue
	FROM         Pay.tblFiscal_Detail INNER JOIN
                      Pay.tblFiscal_Header ON Pay.tblFiscal_Detail.fldFiscalHeaderId = Pay.tblFiscal_Header.fldId
	WHERE  Pay.tblFiscal_Detail.fldTax like @Value
	order by fldFiscalHeaderId

	if (@fieldname=N'')
	SELECT     TOP (@h) Pay.tblFiscal_Detail.fldId, Pay.tblFiscal_Detail.fldFiscalHeaderId, Pay.tblFiscal_Detail.fldAmountFrom, Pay.tblFiscal_Detail.fldAmountTo, 
                      Pay.tblFiscal_Detail.fldPercentTaxOnWorkers, Pay.tblFiscal_Detail.fldTaxationOfEmployees, Pay.tblFiscal_Detail.fldTax, Pay.tblFiscal_Detail.fldUserId, 
                      Pay.tblFiscal_Detail.fldDate, Pay.tblFiscal_Detail.fldDesc, fldEffectiveDate, fldDateOfIssue
	FROM         Pay.tblFiscal_Detail INNER JOIN
                      Pay.tblFiscal_Header ON Pay.tblFiscal_Detail.fldFiscalHeaderId = Pay.tblFiscal_Header.fldId
    order by fldFiscalHeaderId
    
    	if (@fieldname=N'fldDesc')
	SELECT     TOP (@h) Pay.tblFiscal_Detail.fldId, Pay.tblFiscal_Detail.fldFiscalHeaderId, Pay.tblFiscal_Detail.fldAmountFrom, Pay.tblFiscal_Detail.fldAmountTo, 
                      Pay.tblFiscal_Detail.fldPercentTaxOnWorkers, Pay.tblFiscal_Detail.fldTaxationOfEmployees, Pay.tblFiscal_Detail.fldTax, Pay.tblFiscal_Detail.fldUserId, 
                      Pay.tblFiscal_Detail.fldDate, Pay.tblFiscal_Detail.fldDesc, fldEffectiveDate, fldDateOfIssue
	FROM         Pay.tblFiscal_Detail INNER JOIN
                      Pay.tblFiscal_Header ON Pay.tblFiscal_Detail.fldFiscalHeaderId = Pay.tblFiscal_Header.fldId
                      WHERE Pay.tblFiscal_Detail.fldDesc LIKE @Value
    order by fldFiscalHeaderId

	COMMIT
GO
