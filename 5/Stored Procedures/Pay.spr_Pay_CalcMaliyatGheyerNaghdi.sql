SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_Pay_CalcMaliyatGheyerNaghdi]
 @Year NVARCHAR(8),
 @Mablagh INT,
 @TypeEstekhdam INT
AS 
BEGIN TRAN
IF(@TypeEstekhdam=1)
SELECT     TOP (1) Pay.tblFiscal_Detail.fldId, Pay.tblFiscal_Detail.fldFiscalHeaderId, Pay.tblFiscal_Detail.fldAmountFrom, Pay.tblFiscal_Detail.fldAmountTo, 
                      Pay.tblFiscal_Detail.fldPercentTaxOnWorkers AS Darsad, Pay.tblFiscal_Detail.fldTax, Pay.tblFiscal_Detail.fldUserId, Pay.tblFiscal_Detail.fldDate, 
                      Pay.tblFiscal_Detail.fldDesc, Pay.tblFiscal_Header.fldEffectiveDate, Pay.tblFiscal_Header.fldDateOfIssue
FROM         Pay.tblFiscal_Header INNER JOIN
                      Pay.tblFiscal_Detail ON Pay.tblFiscal_Header.fldId = Pay.tblFiscal_Detail.fldFiscalHeaderId INNER JOIN
                      Pay.tblFiscalTitle ON Pay.tblFiscal_Header.fldId = Pay.tblFiscalTitle.fldFiscalHeaderId INNER JOIN
                      Com.tblAnvaEstekhdam ON Pay.tblFiscalTitle.fldAnvaEstekhdamId = Com.tblAnvaEstekhdam.fldId
                      WHERE fldEffectiveDate LIKE @Year AND fldAmountFrom <=@Mablagh AND fldAmountTo>=@Mablagh AND tblAnvaEstekhdam.fldNoeEstekhdamId=@TypeEstekhdam
 
ELSE
SELECT     TOP (1) Pay.tblFiscal_Detail.fldId, Pay.tblFiscal_Detail.fldFiscalHeaderId, Pay.tblFiscal_Detail.fldAmountFrom, Pay.tblFiscal_Detail.fldAmountTo, 
                      Pay.tblFiscal_Detail.fldTaxationOfEmployees AS Darsad, Pay.tblFiscal_Detail.fldTax, Pay.tblFiscal_Detail.fldUserId, Pay.tblFiscal_Detail.fldDate, 
                      Pay.tblFiscal_Detail.fldDesc, Pay.tblFiscal_Header.fldEffectiveDate, Pay.tblFiscal_Header.fldDateOfIssue
FROM         Pay.tblFiscal_Header INNER JOIN
                      Pay.tblFiscal_Detail ON Pay.tblFiscal_Header.fldId = Pay.tblFiscal_Detail.fldFiscalHeaderId INNER JOIN
                      Pay.tblFiscalTitle ON Pay.tblFiscal_Header.fldId = Pay.tblFiscalTitle.fldFiscalHeaderId INNER JOIN
                      Com.tblAnvaEstekhdam ON Pay.tblFiscalTitle.fldAnvaEstekhdamId = Com.tblAnvaEstekhdam.fldId
                      WHERE fldEffectiveDate LIKE @Year AND fldAmountFrom <=@Mablagh AND fldAmountTo>=@Mablagh  AND tblAnvaEstekhdam.fldNoeEstekhdamId=@TypeEstekhdam                  
COMMIT
GO
