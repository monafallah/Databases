SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE proc [ACC].[spr_RptDaftarKol]
 @FiscalYearId int
 as

declare @Year smallint,@OrganId int
--,@FiscalYearId int=5
begin tran
select @Year=fldYear,@OrganId=fldOrganId from acc.tblFiscalYear where fldId=@FiscalYearId

select fldCode,fldTitle, fldBedehkar, fldBestankar,fldDocumentNum,fldTarikhDocument,fldDescriptionDocu,abs(sum(mande) over (order by id)) as fldMande
from(
select ROW_NUMBER() over (ORDER BY (fldTarikhDocument) ) as id, fldBedehkar-fldBestankar  as mande,*
from(
select p.fldCode,p.fldTitle, fldBedehkar, fldBestankar,d.fldDocumentNum,d.fldTarikhDocument,d.fldDescriptionDocu
from acc.tblCoding_Details as p
inner join acc.tblCoding_Header as ch on ch.fldId=p.fldHeaderCodId
cross apply(select sum(fldBedehkar) as fldBedehkar,sum(fldBestankar) as fldBestankar,h1.fldDocumentNum,h1.fldTarikhDocument,h.fldDescriptionDocu
			from acc.tblDocumentRecord_Header as h
			inner join acc.tblDocumentRecord_Details as d on d.fldDocument_HedearId=h.fldId
			inner join acc.tblDocumentRecord_Header1 as h1 on h1.fldDocument_HedearId=h.fldId
			inner join acc.tblFiscalYear as f on f.fldId=h.fldFiscalYearId
			inner join acc.tblCoding_Details as c on c.fldId=d.fldCodingId 
			where (d.fldDocument_HedearId1=h1.fldId or 
			(not exists(select * from Acc.tblDocumentRecord_Details as d2 where d2.fldDocument_HedearId1=h1.fldId )   and d.fldDocument_HedearId1 is null)) 
			and  c.fldHeaderCodId=p.fldHeaderCodId and c.fldCodeId.IsDescendantOf(p.fldCodeId)=1 and h.fldFiscalYearId=@FiscalYearId
			 and fldModuleSaveId=4
			group by h1.fldDocumentNum,h1.fldTarikhDocument,h.fldDescriptionDocu)d
where ch.fldYear=@Year and p.fldLevelId=3 and fldOrganId=@OrganId)t)t2

commit tran


GO
