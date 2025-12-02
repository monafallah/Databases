SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE proc [ACC].[spr_SelectMoghayeratBanki]
@fieldname nvarchar(50), @FiscalYearId int,@AzTarikh varchar(10),@TaTarikh varchar(10), @ShomareHesabId INT
as
begin tran
--,@fieldname nvarchar(50),@HeaderId int

if (@fieldname=N'BankBill')
select bd.fldBedehkar,bd.fldBestankar ,bd.fldTarikh,fldCodePeygiri,fldMandeh,N'' fldTitle,0 fldDocumentNum,N''fldCode
from acc.tblBankBill_Header as b
inner join acc.tblBankBill_Details as bd on bd.fldHedearId=b.fldId
where b.fldFiscalYearId=@FiscalYearId and fldShomareHesabId=@ShomareHesabId and fldTarikh>=@AzTarikh and fldTarikh<=@TaTarikh and
not exists(select * from acc.tblDocumentRecord_Header as h 
									inner join acc.tblDocumentRecord_Details as d on d.fldDocument_HedearId=h.fldId
									inner join acc.tblCase as c on c.fldId=d.fldCaseId and c.fldCaseTypeId=5 and c.fldSourceId=@ShomareHesabId
									where  h.fldFiscalYearId=@FiscalYearId 
									and bd.fldBestankar=d.fldBestankar and bd.fldBedehkar=d.fldBedehkar)

if (@fieldname=N'DocumentRecord')
select fldBedehkar,fldBestankar,h1.fldTarikhDocument fldTarikh,N'' as fldCodePeygiri,
cast(abs(fldBedehkar-fldBestankar)as bigint) as fldMandeh,cd.fldTitle,fldDocumentNum,fldCode 
from acc.tblDocumentRecord_Header as h 
inner join acc.tblDocumentRecord_Details as d on d.fldDocument_HedearId=h.fldId
inner join acc.tblCoding_Details as cd on cd.fldId=d.fldCodingId
inner join acc.tblDocumentRecord_Header1 as h1 on h1.fldDocument_HedearId=h.fldId
inner join acc.tblCase as c on c.fldId=d.fldCaseId and c.fldCaseTypeId=5  and c.fldSourceId=@ShomareHesabId
where  h.fldFiscalYearId=@FiscalYearId
and not exists(select * from acc.tblBankBill_Header as b
			inner join acc.tblBankBill_Details as bd on bd.fldHedearId=b.fldId
			where  b.fldFiscalYearId=@FiscalYearId and b.fldShomareHesabId=@ShomareHesabId 
			and fldTarikh>=@AzTarikh and fldTarikh<=@TaTarikh 
			and bd.fldBestankar=d.fldBestankar and bd.fldBedehkar=d.fldBedehkar)

commit tran
GO
