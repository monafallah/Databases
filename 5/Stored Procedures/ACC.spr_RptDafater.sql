SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE proc [ACC].[spr_RptDafater]
 @AzCodde varchar(50),@TaCode varchar(50),@AzSanad int,@TaSanad int,@Group tinyint,@FiscalYearId int,@CaseTypeId int , @SourceId int
 as

declare @Year smallint,@OrganId int,@AzPid varchar(100),@TaPid varchar(100),@ParvaneName nvarchar(500)=N''
--,@AzCodde varchar(50)='1',@TaCode varchar(50)='131001',@AzSanad int=0,@TaSanad int=10000,@Group tinyint=1,@FiscalYearId int=5
--,@CaseTypeId int=0 , @SourceId int=0
begin tran

select @OrganId=f.fldOrganId,@Year=f.fldYear from  acc.tblFiscalYear as f 
where fldId=@FiscalYearId

select top 1 @AzPid=c.fldStrhid from acc.tblCoding_Details as c
inner join acc.tblCoding_Header as h on h.fldId=c.fldHeaderCodId
--inner join acc.tblCoding_Details as p on c.fldCodeId.IsDescendantOf(p.fldCodeId)=1 and c.fldHeaderCodId=p.fldHeaderCodId
where c.fldCode=@AzCodde and h.fldYear=@Year and h.fldOrganId=@OrganId
--order by p.fldid


select  @TaPid=c.fldStrhid from acc.tblCoding_Details as c
inner join acc.tblCoding_Header as h on h.fldId=c.fldHeaderCodId
--inner join acc.tblCoding_Details as p on c.fldCodeId.IsDescendantOf(p.fldCodeId)=1 and c.fldHeaderCodId=p.fldHeaderCodId
where c.fldCode=@TaCode and h.fldYear=@Year and h.fldOrganId=@OrganId
--order by p.fldid
if(@SourceId<>0)
set @ParvaneName=[ACC].[fn_GetParvandeName](@CaseTypeId,@SourceId,@OrganId)

if(@Group=1)/*براساس شماره سند*/
begin
	select fldCode,fldTitle+N' '+@ParvaneName as fldTitle, fldBedehkar, fldBestankar,fldDocumentNum,fldTarikhDocument,fldDescriptionDocu
	,abs(sum(mande) over (order by id)) as fldMande
	from(
	select ROW_NUMBER() over (ORDER BY fldDocumentNum ,fldTarikhDocument,fldcode ) as id, fldBedehkar-fldBestankar  as mande,*
	from(
	select distinct p.fldCode,p.fldTitle, fldBedehkar, fldBestankar,d.fldDocumentNum,d.fldTarikhDocument,d.fldDescriptionDocu
	from acc.tblCoding_Details as p
	inner join acc.tblCoding_Header as ch on ch.fldId=p.fldHeaderCodId	
	--cross apply(select top 1 parent.fldStrhid from acc.tblCoding_Details as parent where p.fldCodeId.IsDescendantOf(parent.fldCodeId)=1 and p.fldHeaderCodId=parent.fldHeaderCodId  order by parent.fldId)parent
	cross apply(select sum(fldBedehkar) as fldBedehkar,sum(fldBestankar) as fldBestankar,h1.fldDocumentNum,h1.fldTarikhDocument,h.fldDescriptionDocu
				from acc.tblDocumentRecord_Header as h
				inner join acc.tblDocumentRecord_Details as d on d.fldDocument_HedearId=h.fldId
				inner join acc.tblDocumentRecord_Header1 as h1 on h1.fldDocument_HedearId=h.fldId
				inner join acc.tblFiscalYear as f on f.fldId=h.fldFiscalYearId
				inner join acc.tblCoding_Details as c on c.fldId=d.fldCodingId 
				left join  acc.tblCase as ca on ca.fldId=d.fldCaseId
				where c.fldHeaderCodId=p.fldHeaderCodId and c.fldCodeId.IsDescendantOf(p.fldCodeId)=1 
				and h.fldFiscalYearId=@FiscalYearId 
				and (@CaseTypeId=0 or (fldCaseTypeId=@CaseTypeId and fldSourceId=@SourceId))
				and (fldDocument_HedearId1=h1.fldId or 
					(not exists(select * from Acc.tblDocumentRecord_Details as d2 where d2.fldDocument_HedearId1=h1.fldId )   and fldDocument_HedearId1 is null))
				and fldDocumentNum between @AzSanad and @TaSanad and fldModuleSaveId=4
				group by h1.fldDocumentNum,h1.fldTarikhDocument,h.fldDescriptionDocu)d
	where cast(p.fldCode as bigint) >= @AzCodde and cast(p.fldCode as bigint)<= @TaCode 
	and (p.fldStrhid >=@AzPid and p.fldStrhid <=@TaPid) 
	 and fldOrganId=@OrganId
	)t
	)t2
	order by fldDocumentNum,fldTarikhDocument,fldcode
end
else if(@Group=2)/*براساس کدینگ جسابداری*/
begin
	select fldCode,fldTitle+N' '+@ParvaneName as fldTitle, fldBedehkar, fldBestankar,fldDocumentNum,fldTarikhDocument,fldDescriptionDocu,abs(sum(mande) over (order by id)) as fldMande
	from(
	select ROW_NUMBER() over (ORDER BY fldcode,fldTarikhDocument,fldDocumentNum ) as id, fldBedehkar-fldBestankar  as mande,*
	from(
	select distinct p.fldCode,p.fldTitle, fldBedehkar, fldBestankar,d.fldDocumentNum,d.fldTarikhDocument,d.fldDescriptionDocu
	from acc.tblCoding_Details as p
	inner join acc.tblCoding_Header as ch on ch.fldId=p.fldHeaderCodId
	cross apply(select sum(fldBedehkar) as fldBedehkar,sum(fldBestankar) as fldBestankar,h1.fldDocumentNum,h1.fldTarikhDocument,h.fldDescriptionDocu
				from acc.tblDocumentRecord_Header as h
				inner join acc.tblDocumentRecord_Details as d on d.fldDocument_HedearId=h.fldId
				inner join acc.tblDocumentRecord_Header1 as h1 on h1.fldDocument_HedearId=h.fldId
				inner join acc.tblFiscalYear as f on f.fldId=h.fldFiscalYearId
				inner join acc.tblCoding_Details as c on c.fldId=d.fldCodingId 
				left join  acc.tblCase as ca on ca.fldId=d.fldCaseId
				where c.fldHeaderCodId=p.fldHeaderCodId and c.fldCodeId.IsDescendantOf(p.fldCodeId)=1 
				and h.fldFiscalYearId=@FiscalYearId 
				and (@CaseTypeId=0 or (fldCaseTypeId=@CaseTypeId and fldSourceId=@SourceId))
				and (fldDocument_HedearId1=h1.fldId or 
					(not exists(select * from Acc.tblDocumentRecord_Details as d2 where d2.fldDocument_HedearId1=h1.fldId )   and fldDocument_HedearId1 is null))
					and fldDocumentNum between @AzSanad and @TaSanad and fldModuleSaveId=4
				group by h1.fldDocumentNum,h1.fldTarikhDocument,h.fldDescriptionDocu)d
	where cast(p.fldCode as bigint) >= @AzCodde and cast(p.fldCode as bigint)<= @TaCode
	and (p.fldStrhid >=@AzPid and p.fldStrhid <=@TaPid) and fldOrganId=@OrganId)t
	)t2
	order by fldcode,fldTarikhDocument,fldDocumentNum
end
commit tran


GO
