SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [ACC].[spr_tblBankBill_DetailsSelect] 
@fieldname nvarchar(50),
@value nvarchar(50),
@value2 nvarchar(50),
@h int
AS 
 
	set @value=com.fn_TextNormalize(@value)
	if (@h=0) set @h=2147483647 
	BEGIN TRAN
	if (@fieldname='fldId')
	SELECT top(@h)[fldId], [fldHedearId], [fldBedehkar], [fldBestankar], [fldMandeh], [fldTarikh], [fldTime], [fldCodePeygiri]
	FROM   [ACC].[tblBankBill_Details] 
	WHERE  fldId=@value

	if (@fieldname='fldHedearId')
	SELECT top(@h)[fldId], [fldHedearId], [fldBedehkar], [fldBestankar], [fldMandeh], [fldTarikh], [fldTime], [fldCodePeygiri]
	FROM   [ACC].[tblBankBill_Details] 
	WHERE  fldHedearId=@value
	
	if (@fieldname='fldShomareHesabId')/*فرق داره*/
	SELECT top(@h)d.[fldId], [fldHedearId], [fldBedehkar], [fldBestankar], [fldMandeh], [fldTarikh], [fldTime], [fldCodePeygiri]
	FROM   [ACC].[tblBankBill_Details]  as d
	inner join acc.tblBankBill_Header as h on h.fldId=d.fldHedearId
	WHERE  fldFiscalYearId=@value and fldShomareHesabId=@value2 and not exists (select * from acc.tblArtiklMap where fldBankBillId=d.fldId)


	if (@fieldname='')
	SELECT  top(@h) [fldId], [fldHedearId], [fldBedehkar], [fldBestankar], [fldMandeh], [fldTarikh], [fldTime], [fldCodePeygiri]
	FROM   [ACC].[tblBankBill_Details] 
	


	COMMIT
GO
