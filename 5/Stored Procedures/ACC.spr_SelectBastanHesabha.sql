SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE proc [ACC].[spr_SelectBastanHesabha]
@FiscalYearId int
as 
BEGIN TRAN
--declare @FiscalYearId int=8
select fldCodingId,fldTitle,N'' as fldDescription
,case when mande>0 then mande else 0 end as fldBestankar   
,case when mande<0 then abs(mande) else 0 end as fldBedehkar
,0 as  fldCenterCoId,0 fldCaseId,fldName_CodeDetail,isnull(fldCaseTypeId,0) as fldCaseTypeId ,isnull(fldSourceId,0) fldSourceId, isnull(fldName,N'')fldName
from (
select sum(fldBedehkar) -sum(fldBestankar) as mande,fldCodingId,c.fldTitle,'('+c.fldCode+')'+c.fldTitle as fldName_CodeDetail  
,fldCaseTypeId,fldSourceId,isnull([ACC].[fn_GetParvandeName](fldCaseTypeId,fldSourceId,h.fldOrganId),'')as  fldName
from acc.tblDocumentRecord_Header as h
inner join acc.tblDocumentRecord_Details as d on d.fldDocument_HedearId=h.fldId
inner join acc.tblDocumentRecord_Header1 as h1 on h1.fldDocument_HedearId=h.fldId
inner join acc.tblFiscalYear as f on f.fldId=h.fldFiscalYearId
inner join acc.tblCoding_Details as c on c.fldId=d.fldCodingId
left join acc.tblcase as ca on ca.fldId=d.fldCaseId
cross apply    (select top 1 parent.fldid from     
				acc.tblCoding_Details as p   
				inner join acc.tblTemplateCoding as t on t.fldId=p.fldTempCodingId 
				inner join acc.tblItemNecessary as i on i.fldId=t.fldItemId
				inner join acc.tblItemNecessary as parent on  i.fldItemId.IsDescendantOf(parent.fldItemId) =1
				where p.fldHeaderCodId=c.fldHeaderCodId and parent.fldId  in (7,8)  and c.fldCodeId.IsDescendantOf(p.fldCodeId) =1   
				)tempname 
where  (d.fldDocument_HedearId1=h1.fldId or 
			(not exists(select * from Acc.tblDocumentRecord_Details as d2 where d2.fldDocument_HedearId1=h1.fldId )   and d.fldDocument_HedearId1 is null)) 
			and fldFiscalYearId=@FiscalYearId and h1.fldTypeSanadId in (1,2,3) and fldDocumentNum>0 and fldModuleSaveId=4

group by fldCodingId,c.fldTitle,c.fldCode,fldCaseTypeId,fldSourceId,h.fldOrganId
)t
where mande<>0
union all
select fldCodingId,fldTitle,N'' as fldDescription
--0 as fldBedehkar, mande  as fldBestankar 
,case when mande<0 then abs(mande) else 0 end as  fldBedehkar 
,case when mande>0 then mande else 0 end as   fldBestankar
,0 as  fldCenterCoId,0 fldCaseId,fldName_CodeDetail,0 as fldCaseTypeId ,0 fldSourceId, N'' fldName
from (
select sum(fldBedehkar) -sum(fldBestankar) as mande,n.fldId fldCodingId,n.fldTitle,'('+n.fldCode+')'+n.fldTitle as fldName_CodeDetail

from acc.tblDocumentRecord_Header as h
inner join acc.tblDocumentRecord_Details as d on d.fldDocument_HedearId=h.fldId
inner join acc.tblDocumentRecord_Header1 as h1 on h1.fldDocument_HedearId=h.fldId
inner join acc.tblFiscalYear as f on f.fldId=h.fldFiscalYearId
inner join acc.tblCoding_Details as c on c.fldId=d.fldCodingId
left join acc.tblcase as ca on ca.fldId=d.fldCaseId
cross apply    (select top 1 fldTempNameId from     
		acc.tblCoding_Details as p   
	inner join acc.tblTemplateCoding as t on t.fldId=p.fldTempCodingId 
	inner join acc.tblItemNecessary as i on i.fldId=t.fldItemId
	inner join acc.tblItemNecessary as parent on  i.fldItemId.IsDescendantOf(parent.fldItemId) =1
	where p.fldHeaderCodId=c.fldHeaderCodId  and parent.fldId  in (7,8) and c.fldCodeId.IsDescendantOf(p.fldCodeId) =1   )tempname 
cross apply    (select top 1 p.fldId,p.fldTitle,p.fldCode from     
		acc.tblCoding_Details as p   
		inner join acc.tblTemplateCoding as t on t.fldId=p.fldTempCodingId 
		where p.fldHeaderCodId=c.fldHeaderCodId and  t.fldItemId  = 36 order by p.fldid desc )n
where (d.fldDocument_HedearId1=h1.fldId or 
			(not exists(select * from Acc.tblDocumentRecord_Details as d2 where d2.fldDocument_HedearId1=h1.fldId )   and d.fldDocument_HedearId1 is null)) 
			and  fldFiscalYearId=@FiscalYearId and h1.fldTypeSanadId in (1,2,3) and fldDocumentNum>0 and fldModuleSaveId=4
group by n.fldId,n.fldTitle,n.fldCode
)t
where mande<>0

/*select * from acc.tblCoding_Details where fldid=1115  or fldStrhid='/8/1/'
select * from acc.tblTemplateCoding where fldid=452 or fldStrhid='/8/1/'

select * from acc.tblItemNecessary

select  * --top 1 fldTempNameId,i.fldid,parent.fldid 
from     
				acc.tblCoding_Details as p   
				inner join acc.tblCoding_Details as c on c.fldCodeId.IsDescendantOf(p.fldCodeId) =1 and c.fldHeaderCodId=2
				inner join acc.tblTemplateCoding as t on t.fldId=p.fldTempCodingId 
				--inner join acc.tblItemNecessary as i on i.fldId=t.fldItemId
				--inner join acc.tblItemNecessary as parent on  i.fldItemId.IsDescendantOf(parent.fldItemId) =1 and parent.fldLevelId>0
				where p.fldHeaderCodId=2 and c.fldid=1115 and c.fldCodeId.IsDescendantOf(p.fldCodeId) =1 
				--order by parent.fldid*/



	
	commit tran
GO
