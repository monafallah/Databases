SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE proc [ACC].[spr_RptMoeenTafsili]
 @CodeId int,@AzSanad int,@TaSanad int
 as

declare @Year smallint,@FiscalYearId int
--,@CodeId int=1491,@AzSanad int=0,@TaSanad int=1000

begin tran

select @FiscalYearId=f.fldId,@Year=f.fldYear from acc.tblCoding_Details as d
inner join acc.tblCoding_Header as h on h.fldId=d.fldHeaderCodId
inner join acc.tblFiscalYear as f on f.fldYear=h.fldYear and f.fldOrganId=h.fldOrganId
where d.fldId=@CodeId


select fldCode,fldTitle, fldBedehkar, fldBestankar,fldDocumentNum,fldTarikhDocument,fldDescriptionDocu,abs(sum(mande) over (order by id)) as fldMande
from(
select ROW_NUMBER() over (ORDER BY fldcode,fldTarikhDocument,fldDocumentNum ) as id, fldBedehkar-fldBestankar  as mande,*
from(
select d.fldCode,d.fldTitle, fldBedehkar, fldBestankar,d.fldDocumentNum,d.fldTarikhDocument,d.fldDescriptionDocu
from acc.tblCoding_Details as p
inner join acc.tblCoding_Header as ch on ch.fldId=p.fldHeaderCodId
cross apply(select c.fldCode,c.fldTitle,sum(fldBedehkar) as fldBedehkar,sum(fldBestankar) as fldBestankar,h1.fldDocumentNum,h1.fldTarikhDocument,h.fldDescriptionDocu
			from acc.tblDocumentRecord_Header as h
			inner join acc.tblDocumentRecord_Details as d on d.fldDocument_HedearId=h.fldId
			inner join acc.tblDocumentRecord_Header1 as h1 on h1.fldDocument_HedearId=h.fldId
			inner join acc.tblFiscalYear as f on f.fldId=h.fldFiscalYearId
			inner join acc.tblCoding_Details as c on c.fldId=d.fldCodingId 
			where c.fldHeaderCodId=p.fldHeaderCodId and c.fldCodeId.IsDescendantOf(p.fldCodeId)=1 and h.fldFiscalYearId=@FiscalYearId 
			and fldDocumentNum between @AzSanad and @TaSanad and fldModuleSaveId=4
			group by c.fldCode,c.fldTitle,h1.fldDocumentNum,h1.fldTarikhDocument,h.fldDescriptionDocu)d
where p.fldId=@CodeId)t
)t2
order by fldcode,fldTarikhDocument,fldDocumentNum

commit tran


GO
