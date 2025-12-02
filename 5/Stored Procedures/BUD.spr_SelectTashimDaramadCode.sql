SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE proc [BUD].[spr_SelectTashimDaramadCode]
@Year smallint,@Organid int
as
begin tran
--select 0 fldCodingAcc_DetailsId,N'' fldTitle,N'' fldCode,N'' fldDaramadCode
--,cast(0 as decimal(4, 2)) fldPercentHazine,cast(0 as decimal(4, 2)) fldPercentTamallok
--,'0' as fldHazine,'0' fldSarmaye,'0' as fldMali
--,'0' as fldHozeMasraf,'0' fldHozeMamooriyat

--declare @Year smallint=1403,@Organid int=1
create table #t (id  int identity,fldTypeId int,fldTypeName nvarchar(300),fldType smallint)
insert #t
select fldId,fldEnName
, 1 as fldType from bud.tblEtebarType
			union all
			select fldId, N'fldHozeMasraf' fldTitle, 2 as fldType  from bud.tblMasrafType
			union all
			select b.fldCodeingBudjeId,N'fldHozeMamooriyat', 3 as fldType from bud.tblCodingBudje_Details as b 
			inner join bud.tblCodingBudje_Header as bh on bh.fldHedaerId=b.fldHeaderId
			where bh.fldYear=@Year and bh.fldOrganId=@Organid and b.fldLevelId=1 


select fldCodingAcc_DetailsId,fldTitle,fldCode,fldDaramadCode,isnull(fldPercentHazine,0.0)fldPercentHazine,isnull(fldPercentTamallok,0.0)fldPercentTamallok
,isnull((substring(fldHazine,1,1)),0) as fldHazine,isnull((substring(fldSarmaye,1,1)),0) as fldSarmaye,isnull((substring(fldMali,1,1)),0) as fldMali
,substring(fldHozeMasraf,1,1) as fldHozeMasraf,fldHozeMamooriyat from(
select* from(
select d.fldId as fldCodingAcc_DetailsId,d.fldTitle,d.fldCode,d.fldDaramadCode 
,e.fldTypeName 
,--case when e.fldType=3 and b.fldCount=6 then '0' 
case when e.fldType=3 and  b.fldCount is null then '-1'
when e.fldType=3 and b.fldCount>0 then a.fldCodeingBudjeId
when e.fldTypeID is null then '0'
else isnull(cast(e.fldTypeID as varchar(10))+'_'+cast(e.fldType as varchar(10)),'0') end as fldTypeID
--,e.fldType,fldTypeID,b.fldCount, a.fldCodeingBudjeId
--,isnull(e.fldId,0) as fldId ,e.fldTitle,e.fldType 
--,cast(e.fldId as varchar(10))+'-'+cast(e.fldType as varchar(10)) as Id
--,isnull(m.fldId,0) as fldId,isnull(m.fldTitle,N'') as fldHozeMasraf,isnull(m.fldType,2) as fldType
--,isnull(b.fldId,0) as fldId,isnull(b.fldTitle,N'') as fldHozeMamooriyat,isnull(b.fldType,2) as fldType
,dc.fldPercentHazine,dc.fldPercentTamallok
from acc.tblCoding_Details as d
inner join acc.tblCoding_Header as h on h.fldId=d.fldHeaderCodId
left join acc.tblCoding_Details as c on d.fldHeaderCodId=c.fldHeaderCodId and c.fldCodeId.GetAncestor(1)=d.fldCodeId
cross apply    (select top 1 fldTempNameId from     
				 acc.tblCoding_Details as p   
				inner join acc.tblTemplateCoding as t on t.fldId=p.fldTempCodingId 
				where p.fldHeaderCodId=d.fldHeaderCodId and t.fldItemId=7 and d.fldCodeId.IsDescendantOf(p.fldCodeId) =1   )tempname 
outer apply(select a.fldTypeId ,fldTypeName,t.fldType
			from #t	as t
			left join bud.tblDaramadCodeDetails_ACC as a on a.fldTypeID=t.fldTypeId and a.fldType=t.fldType and a.fldCodingAcc_DetailsId=d.fldId
			) as e
/*outer apply(select  a.fldTypeID as fldId, fldTitle, 1 as fldType  from bud.tblEtebarType as m
			left join bud.tblDaramadCodeDetails_ACC as a on a.fldTypeID=m.fldId and fldType=1 and a.fldCodingAcc_DetailsId=d.fldId
		) as e
outer apply(select m.fldId,N'fldHozeMasraf' as fldTitle, 2 as fldType  from bud.tblMasrafType as m
			inner join bud.tblDaramadCodeDetails_ACC as a on a.fldTypeID=m.fldId and fldType=2 and a.fldCodingAcc_DetailsId=d.fldId
		) as m*/
outer apply(select count(*)  as fldCount 
			from bud.tblCodingBudje_Details as b 
			inner join bud.tblCodingBudje_Header as bh on bh.fldHedaerId=b.fldHeaderId
			inner join bud.tblDaramadCodeDetails_ACC as a on b.fldCodeingBudjeId=a.fldTypeID and  e.fldType=3 and fldType=3 
			where bh.fldYear=h.fldYear and bh.fldOrganId=h.fldOrganId  and a.fldCodingAcc_DetailsId=d.fldId and b.fldLevelId=1 	
			group by a.fldCodingAcc_DetailsId) as b
outer apply(select (select cast (fldCodeingBudjeId as varchar(10))+',' 
			from bud.tblCodingBudje_Details as b 
			inner join bud.tblCodingBudje_Header as bh on bh.fldHedaerId=b.fldHeaderId
			inner join bud.tblDaramadCodeDetails_ACC as a on b.fldCodeingBudjeId=a.fldTypeID and  e.fldType=3 and fldType=3 
			where bh.fldYear=h.fldYear and bh.fldOrganId=h.fldOrganId  and a.fldCodingAcc_DetailsId=d.fldId and b.fldLevelId=1 	
			 for xml path('')) as fldCodeingBudjeId) as a
left join bud.tblCodingAccPercent  as dc on dc.fldCodingAcc_DetailsId=d.fldId
where h.fldYear=@Year and h.fldOrganId=@Organid and c.fldId is null
)t
pivot( 
	max(fldTypeID) for fldTypeName in ([fldSarmaye],[fldMali],[fldHazine],[fldHozeMasraf],[fldHozeMamooriyat])

)p
)t2
order by fldDaramadCode
drop table #t
commit tran

GO
