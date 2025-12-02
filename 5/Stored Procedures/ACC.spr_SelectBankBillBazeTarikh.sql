SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE proc [ACC].[spr_SelectBankBillBazeTarikh]
 @FiscalYearId int, @ShomareHesabId INT
  as
  begin tran
	select min(fldTarikh) as fldMinTarikh,max(fldTarikh)  as fldMaxTarikh 
	from acc.tblBankBill_Details as d
	inner join acc.tblBankBill_Header as h on h.fldId=d.fldHedearId
	where fldFiscalYearId= @FiscalYearId and fldShomareHesabId=@ShomareHesabId
commit tran
GO
