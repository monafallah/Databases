SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE proc [BUD].[Spr_TafrighFinal]
 @aztarikh  char(10),@tatarikh  char(10),
 @salmaliID  tinyint,@organid  tinyint,
 @azsanad int,@tasanad int,@sanadtype tinyint
 ,@Div int
 as
 begin
 --initial value
-- select @aztarikh='1402/01/01',@tatarikh='1402/05/31',@salmaliID=5,@organid=1,
--@sanadtype=2
--declare
-- @aztarikh  char(10),@tatarikh  char(10),
-- @salmaliID  tinyint,@organid  tinyint,
-- @azsanad int,@tasanad int,@sanadtype tinyint,@Div int=1000
-- set @aztarikh=''
-- set @tatarikh=''
-- set @salmaliID=5
-- set @organid=1
-- set @azsanad=1
-- set @tasanad=100000
-- set @sanadtype=2
IF 1=0 BEGIN
SET FMTONLY OFF
END
create	table	#tblData (fldaccID int,fldbudID int,fldnecid int ,fldcol1 bigint,fldcol2 bigint,fldcol3 bigint,fldcol4 bigint,fldcol5 bigint
,fldcol6 bigint,fldcol7 bigint,fldcol8 bigint,fldcol9 bigint,fldcol10 bigint,fldcol11 bigint,fldcol12 bigint,fldcol13 bigint,fldcol14 bigint)
declare @year smallint=0
select @year=fldYear from acc.tblFiscalYear where fldId=@salmaliID
insert into #tblData
 exec dbo.sp_FirstDataForTafrigh
  @aztarikh,@tatarikh,@salmaliID,@organid,@azsanad,@tasanad,@sanadtype,@Div

select m.*,d.fldCode  fldcode,d.fldTitle ,fldDaramadCode fldBudjecode,1 as fldAcctype,fldLevelId fldLevel,-1 fldTarh_KhedmatTypeId
,case when child.fldId is null then 1 else 0 end fldflag
,isnull(e1.fldType,0) as fldHazine,isnull(e2.fldType,0) as fldSarmaye,isnull(e3.fldType,0) as fldMali,isnull(t.fldTitle,N'') as fldHozeMasraf
,case when c.fldCount=6 then N'ماموریت های شش گانه' else isnull(b.fldHoseMamooryat,N'') end fldHoseMamooryat
,dc.fldPercentHazine,dc.fldPercentTamallok,0 fldItemId
from(
	select t1.*
	--,case when t2.fldaccID is null then 0 else 1 end 
	
	from (
		select d2.fldId,t.fldnecid,SUM(fldcol1) fldcol1,SUM(fldcol2) fldcol2,SUM(fldcol3) fldcol3,SUM(fldcol4) fldcol4,SUM(fldcol5) fldcol5,
			SUM(fldcol6) fldcol6,SUM(fldcol7) fldcol7,SUM(fldcol8) fldcol8,SUM(fldcol9) fldcol9,SUM(fldcol10) fldcol10,SUM(fldcol11) fldcol11,SUM(fldcol12) fldcol12
			,SUM(fldcol13) fldcol13,SUM(fldcol14) fldcol14
		, sum((fldcol1+fldcol9-fldcol10)*dc.fldPercentHazine/100.0) as fldMablaghHazine 
		,sum((fldcol1+fldcol9-fldcol10)*dc.fldPercentTamallok/100.0) as fldMablaghTamalok
		from #tblData t 
inner join acc.tblCoding_Details d on t.fldaccID=d.fldId  
inner join ACC.tblCoding_Details d2 on d.fldCodeId.IsDescendantOf(d2.fldCodeId)=1 and d.fldHeaderCodId=d2.fldHeaderCodId
left join bud.tblCodingAccPercent  as dc on dc.fldCodingAcc_DetailsId=d.fldId
  group by d2.fldId,t.fldnecid ) t1 
left join (select fldaccID,fldnecid from #tblData group by fldaccID,fldnecid) t2 
on t1.fldId=t2.fldaccID 
) m 
inner join ACC.tblCoding_Details d on m.fldId=d.fldId
left join bud.tblCodingAccPercent  as dc on dc.fldCodingAcc_DetailsId=d.fldId
left join bud.tblDaramadCodeDetails_ACC as e1 on e1.fldCodingAcc_DetailsId=d.fldId and e1.fldType=1 and e1.fldTypeID=1
left join bud.tblDaramadCodeDetails_ACC as e2 on e2.fldCodingAcc_DetailsId=d.fldId and e2.fldType=1 and e2.fldTypeID=2
left join bud.tblDaramadCodeDetails_ACC as e3 on e3.fldCodingAcc_DetailsId=d.fldId and e3.fldType=1 and e3.fldTypeID=3
outer apply(select t.fldTitle from bud.tblDaramadCodeDetails_ACC as a 
			inner join bud.tblMasrafType as t on t.fldId=a.fldTypeID
			where a.fldCodingAcc_DetailsId=d.fldId and a.fldType=2 )t
outer apply(select (select b.fldTitle+','  from bud.tblDaramadCodeDetails_ACC as a
			inner join bud.tblCodingBudje_Details as b on b.fldCodeingBudjeId=a.fldTypeID
			where a.fldCodingAcc_DetailsId=d.fldId and a.fldType=3  for xml path('')) as fldHoseMamooryat)b
outer apply(select count(*) as  fldCount from bud.tblDaramadCodeDetails_ACC as a
			inner join bud.tblCodingBudje_Details as b on b.fldCodeingBudjeId=a.fldTypeID
			where a.fldCodingAcc_DetailsId=d.fldId and a.fldType=3 )c
outer apply(select top(1) fldid from ACC.tblCoding_Details as c where c.fldHeaderCodId=d.fldHeaderCodId and c.fldCodeId.GetAncestor(1)=d.fldCodeId)child


union all
select m.*,d.fldCode  fldcode,fldTitle ,fldBudCode fldBudjecode,0 as fldAcctype,fldLevelId fldLevel,0 fldTarh_KhedmatTypeId 
,case when child.fldId is null then 1 else 0 end fldflag ,0 as fldHazine,0 as fldSarmaye,0 as fldMali,N'' as fldHozeMasraf
,N'' fldHoseMamooryat,0.0 fldPercentHazine,0.0 fldPercentTamallok,0 fldItemId
from(
select t1.*--,case when t2.fldbudID is null then 0 else 1 end fldflag 
from (select d2.fldCodeingBudjeId,d2.fldTarh_KhedmatTypeId as fldnecID,SUM(fldcol1) fldcol1,SUM(fldcol2) fldcol2,SUM(fldcol3) fldcol3
,SUM(fldcol4) fldcol4,SUM(fldcol5) fldcol5,
SUM(fldcol6) fldcol6,SUM(fldcol7) fldcol7,SUM(fldcol8) fldcol8,SUM(fldcol9) fldcol9,SUM(fldcol10) fldcol10,SUM(fldcol11) fldcol11,SUM(fldcol12) fldcol12
,SUM(fldcol13) fldcol13,SUM(fldcol14) fldcol14
,0.0 as fldPercentTamallok, 0.0 as fldMablaghTamalok
from #tblData t 
right join BUD.tblCodingBudje_Details d on t.fldbudID=d.fldCodeingBudjeId and t.fldbudID is not null 
inner join bud.tblCodingBudje_Header as h on h.fldHedaerId=d.fldHeaderId
inner join BUD.tblCodingBudje_Details d2 on d.fldhierarchyidId.IsDescendantOf(d2.fldhierarchyidId)=1 and d.fldHeaderId=d2.fldHeaderId  
where h.fldYear=@year  and (d2.fldLevelId=1 or t.fldbudID is not null)
group by d2.fldCodeingBudjeId,d2.fldTarh_KhedmatTypeId) t1  
left join (select fldbudID from #tblData group by fldbudID) t2 on t1.fldCodeingBudjeId=t2.fldbudID) m 
inner join BUD.tblCodingBudje_Details d on m.fldCodeingBudjeId=d.fldCodeingBudjeId
outer apply(select top(1) c.fldCodeingBudjeId as fldid from BUD.tblCodingBudje_Details as c where c.fldHeaderId=d.fldHeaderId and c.fldhierarchyidId.GetAncestor(1)=d.fldhierarchyidId)child

union all
select m.*,d.fldCode  fldcode,fldTitle ,fldBudCode fldBudjecode,0 as fldAcctype,fldLevelId fldLevel,1 fldTarh_KhedmatTypeId 
,case when child.fldId is null then 1 else 0 end fldflag 
,0 as fldHazine,0 as fldSarmaye,0 as fldMali,N'' as fldHozeMasraf,N'' fldHoseMamooryat,0.0 fldPercentHazine,0.0 fldPercentTamallok
,0 fldItemId
from(
select t1.*--,case when t2.fldbudID is null then 0 else 1 end fldflag 
from (select d2.fldCodeingBudjeId,d2.fldTarh_KhedmatTypeId as fldnecID,SUM(fldcol1) fldcol1,SUM(fldcol2) fldcol2,SUM(fldcol3) fldcol3
,SUM(fldcol4) fldcol4,SUM(fldcol5) fldcol5,
SUM(fldcol6) fldcol6,SUM(fldcol7) fldcol7,SUM(fldcol8) fldcol8,SUM(fldcol9) fldcol9,SUM(fldcol10) fldcol10,SUM(fldcol11) fldcol11,SUM(fldcol12) fldcol12
,SUM(fldcol13) fldcol13,SUM(fldcol14) fldcol14
,0.0 as fldPercentTamallok, 0.0 as fldMablaghTamalok
from #tblData t 
right join BUD.tblCodingBudje_Details d on t.fldbudID=d.fldCodeingBudjeId and t.fldbudID is not null and d.fldTarh_KhedmatTypeId=1
inner join bud.tblCodingBudje_Header as h on h.fldHedaerId=d.fldHeaderId
inner join BUD.tblCodingBudje_Details d2 on d.fldhierarchyidId.IsDescendantOf(d2.fldhierarchyidId)=1 and d.fldHeaderId=d2.fldHeaderId 
where h.fldYear=@year  and (d2.fldLevelId=1 or t.fldbudID is not null)
group by d2.fldCodeingBudjeId,d2.fldTarh_KhedmatTypeId) t1  
left join (select fldbudID from #tblData group by fldbudID) t2 on t1.fldCodeingBudjeId=t2.fldbudID) m 
inner join BUD.tblCodingBudje_Details d on m.fldCodeingBudjeId=d.fldCodeingBudjeId
outer apply(select top(1) c.fldCodeingBudjeId as fldid from BUD.tblCodingBudje_Details as c where c.fldHeaderId=d.fldHeaderId and c.fldhierarchyidId.GetAncestor(1)=d.fldhierarchyidId)child

union all
select m.*,d.fldCode  fldcode,fldTitle ,fldBudCode fldBudjecode,0 as fldAcctype,fldLevelId fldLevel,2 fldTarh_KhedmatTypeId 
,case when child.fldId is null then 1 else 0 end fldflag 
,0 as fldHazine,0 as fldSarmaye,0 as fldMali,N'' as fldHozeMasraf,N'' fldHoseMamooryat,0.0 fldPercentHazine,0.0 fldPercentTamallok
,0 fldItemId
from(
select t1.*--,case when t2.fldbudID is null then 0 else 1 end fldflag 
from (select d2.fldCodeingBudjeId,d2.fldTarh_KhedmatTypeId as fldnecID,SUM(fldcol1) fldcol1,SUM(fldcol2) fldcol2,SUM(fldcol3) fldcol3
,SUM(fldcol4) fldcol4,SUM(fldcol5) fldcol5,
SUM(fldcol6) fldcol6,SUM(fldcol7) fldcol7,SUM(fldcol8) fldcol8,SUM(fldcol9) fldcol9,SUM(fldcol10) fldcol10,SUM(fldcol11) fldcol11,SUM(fldcol12) fldcol12
,SUM(fldcol13) fldcol13,SUM(fldcol14) fldcol14
,0.0 as fldPercentTamallok, 0.0 as fldMablaghTamalok
from #tblData t 
right join BUD.tblCodingBudje_Details d on t.fldbudID=d.fldCodeingBudjeId and t.fldbudID is not null and d.fldTarh_KhedmatTypeId=2
inner join bud.tblCodingBudje_Header as h on h.fldHedaerId=d.fldHeaderId
inner join BUD.tblCodingBudje_Details d2 on d.fldhierarchyidId.IsDescendantOf(d2.fldhierarchyidId)=1 and d.fldHeaderId=d2.fldHeaderId  
where h.fldYear=@year  and (d2.fldLevelId=1 or t.fldbudID is not null)
group by d2.fldCodeingBudjeId,d2.fldTarh_KhedmatTypeId) t1  
left join (select fldbudID from #tblData group by fldbudID) t2 on t1.fldCodeingBudjeId=t2.fldbudID) m 
inner join BUD.tblCodingBudje_Details d on m.fldCodeingBudjeId=d.fldCodeingBudjeId
outer apply(select top(1) c.fldCodeingBudjeId as fldid from BUD.tblCodingBudje_Details as c where c.fldHeaderId=d.fldHeaderId and c.fldhierarchyidId.GetAncestor(1)=d.fldhierarchyidId)child

union all
select m.*,d.fldCode  fldcode,fldTitle ,fldBudCode fldBudjecode,0 as fldAcctype,fldLevelId fldLevel,2 fldTarh_KhedmatTypeId 
,case when child.fldId is null then 1 else 0 end fldflag 
,0 as fldHazine,0 as fldSarmaye,0 as fldMali,N'' as fldHozeMasraf,N'' fldHoseMamooryat,0.0 fldPercentHazine,0.0 fldPercentTamallok
,isnull(fldnecID,0)fldItemId
from(
select t1.*--,case when t2.fldbudID is null then 0 else 1 end fldflag 
from (select d2.fldCodeingBudjeId,p.fldItemId as  fldnecID,SUM(fldcol1) fldcol1,SUM(fldcol2) fldcol2,SUM(fldcol3) fldcol3
,SUM(fldcol4) fldcol4,SUM(fldcol5) fldcol5,
SUM(fldcol6) fldcol6,SUM(fldcol7) fldcol7,SUM(fldcol8) fldcol8,SUM(fldcol9) fldcol9,SUM(fldcol10) fldcol10,SUM(fldcol11) fldcol11,SUM(fldcol12) fldcol12
,SUM(fldcol13) fldcol13,SUM(fldcol14) fldcol14
,0.0 as fldPercentTamallok, 0.0 as fldMablaghTamalok
from #tblData t 
right join BUD.tblCodingBudje_Details d on t.fldbudID=d.fldCodeingBudjeId and t.fldbudID is not null --and d.fldTarh_KhedmatTypeId=2
inner join bud.tblCodingBudje_Header as h on h.fldHedaerId=d.fldHeaderId
inner join BUD.tblCodingBudje_Details d2 on d.fldhierarchyidId.IsDescendantOf(d2.fldhierarchyidId)=1 and d.fldHeaderId=d2.fldHeaderId  
cross apply(select top 1 t.fldItemId from bud.tblPishbini as p 
			inner join acc.tblCoding_Details as c on c.fldId=p.fldCodingAcc_DetailsId 
			inner join acc.tblCoding_Details as parent on c.fldHeaderCodId=parent.fldHeaderCodId and c.fldCodeId.IsDescendantOf(parent.fldCodeId)=1
			inner join acc.tblTemplateCoding as t on t.fldId=parent.fldTempCodingId
			inner join bud.tblCodingBudje_Details as b on b.fldCodeingBudjeId=p.fldCodingBudje_DetailsId
			inner join bud.tblCodingBudje_Details as bp on b.fldHeaderId=bp.fldHeaderId and b.fldhierarchyidId.IsDescendantOf(bp.fldhierarchyidId)=1
			where  bp.fldCodeingBudjeId=d.fldCodeingBudjeId and t.fldItemId=12)p
where h.fldYear=@year  and (d2.fldLevelId=1 or t.fldbudID is not null)
group by d2.fldCodeingBudjeId,p.fldItemId) t1  
left join (select fldbudID from #tblData group by fldbudID) t2 on t1.fldCodeingBudjeId=t2.fldbudID) m 
inner join BUD.tblCodingBudje_Details d on m.fldCodeingBudjeId=d.fldCodeingBudjeId
outer apply(select top(1) c.fldCodeingBudjeId as fldid from BUD.tblCodingBudje_Details as c where c.fldHeaderId=d.fldHeaderId and c.fldhierarchyidId.GetAncestor(1)=d.fldhierarchyidId)child



drop table #tblData
end
-----test
--go
--declare
-- @aztarikh  char(10),@tatarikh  char(10),
-- @salmaliID  tinyint,@organid  tinyint,
-- @azsanad int,@tasanad int,@sanadtype tinyint
-- exec BUD.Spr_TafrighFinal @aztarikh='1402/01/01',@tatarikh='1402/05/31',@salmaliID=5,@organid=1,@azsanad=1,@tasanad=100000,@sanadtype=2
GO
