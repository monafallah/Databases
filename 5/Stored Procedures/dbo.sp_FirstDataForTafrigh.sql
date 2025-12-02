SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE proc  [dbo].[sp_FirstDataForTafrigh]
--declare 
 @aztarikh  char(10),@tatarikh  char(10),
 @salmaliID  tinyint,@organid  tinyint,
 @azsanad int,@tasanad int,@sanadtype tinyint,@Div int=1
 as
 begin
-- --initial value
-- select @aztarikh='',@tatarikh='',@salmaliID=8,@organid=1,
--@sanadtype=2
---------------------------------------------
declare @sal int--=cast(SUBSTRING(@tatarikh,1,4) as int)
select @sal=fldYear from acc.tblFiscalYear where fldid=@salmaliID
declare @accept1 tinyint,@accept2 tinyint

set @accept1=0
set @accept2=1
if (@sanadtype=1 or @sanadtype=0) 
begin
	set @accept1=@sanadtype
	set @accept2=@sanadtype
end
if (@azsanad = 0 or @azsanad is null) set @azsanad=1
if (@tasanad = 0 or @tasanad is null) set @tasanad=2147483647 

--header table=ACC.tblDocumentRecord_Header
--header main=ACC.tblDocumentRecord_Header1
;with Sanad
as
( 
SELECT       fldTarikhDocument, fldAccept, fldDocumentNum, h.fldId,hp.fldId as headerId1, hp.fldTypeSanadId
FROM         acc.tblDocumentRecord_Header as h inner join acc.tblDocumentRecord_Header1 AS hp ON hp.fldDocument_HedearId = h.fldId 
where  h.fldType = 1 
AND hp.fldDocumentNum > 0 
						AND h.fldFiscalYearId = @salmaliID /*5*/ AND h.fldOrganId =@organid /*1*/ AND 
                         hp.fldModuleSaveId = 4
						 and((@aztarikh='') or( fldTarikhDocument>=@aztarikh and fldTarikhDocument<=@tatarikh) )
						 and fldDocumentNum>=@azsanad and fldDocumentNum<=@tasanad and hp.fldAccept>=@accept1 and hp.fldAccept<=@accept2
						 and  hp.fldTypeSanadId not in (4,5)
)

,AccCodingTemp(fldId,fldCode, fldCodeId,fldLevelId,fldTitle,fldDaramadCode,fldnecTitle,fldnecID,fldHnecID)
as
(
	select d.fldId,d.fldCode,d.fldCodeId,d.fldLevelId,d.fldTitle,d.fldDaramadCode,i.fldNameItem,i.fldId fldnecid,i.fldItemId
	from ACC.tblCoding_Details d inner join acc.tblCoding_Header h
	on d.fldHeaderCodId=h.fldId left join ACC.tblTemplateCoding t
    on t.fldId=d.fldTempCodingId left join ACC.tblItemNecessary i on t.fldItemId=i.fldId 
	 where h.fldYear=@sal and h.fldOrganId=@OrganId 
)
,AcccodingTemp2 (fldId,fldCode, fldCodeId,fldLevelId,fldTitle,fldDaramadCode,fldnecTitle,fldnecID,fldHnecID)
as
(
select d.fldId,d.fldCode,d.fldCodeId,d.fldLevelId,d.fldTitle,d.fldDaramadCode,isnull(i.fldNameItem,p.fldNameItem)fldNameItem
--,isnull(i.fldId,p.fldId) fldnecid,isnull(i.fldItemId ,p.fldItemId)as fldItemId
,p.fldId fldnecid,isnull(i.fldItemId ,p.fldItemId)as fldItemId
from ACC.tblCoding_Details d 
inner join acc.tblCoding_Header h	on d.fldHeaderCodId=h.fldId 
left join ACC.tblTemplateCoding t   on t.fldId=d.fldTempCodingId 
left join ACC.tblItemNecessary i on t.fldItemId=i.fldId 
cross apply (select top (1) ip.fldNameItem,ip.fldid,ip.fldItemId from ACC.tblCoding_Details p 
			inner join ACC.tblTemplateCoding tp   on tp.fldId=p.fldTempCodingId 
			inner join ACC.tblItemNecessary ip on tp.fldItemId=ip.fldId
			where d.fldHeaderCodId=p.fldHeaderCodId and d.fldCodeId.IsDescendantOf(p.fldCodeId)=1 order by p.fldId desc )p
	 where h.fldYear=@sal and h.fldOrganId=@OrganId 
/*union 
select d.fldId,d.fldCode,d.fldCodeId,d.fldLevelId,d.fldTitle,d.fldDaramadCode,isnull(i.fldNameItem,p.fldNameItem)fldNameItem
,isnull(i.fldId,p.fldId) fldnecid,isnull(i.fldItemId ,p.fldItemId)as fldItemId
from ACC.tblCoding_Details d 
inner join acc.tblCoding_Header h	on d.fldHeaderCodId=h.fldId 
left join ACC.tblTemplateCoding t   on t.fldId=d.fldTempCodingId 
left join ACC.tblItemNecessary i on t.fldItemId=i.fldId 
cross apply (select top (1) ip.fldNameItem,ip.fldid,ip.fldItemId from ACC.tblCoding_Details p 
			inner join ACC.tblTemplateCoding tp   on tp.fldId=p.fldTempCodingId 
			inner join ACC.tblItemNecessary ip on tp.fldItemId=ip.fldId
			where d.fldHeaderCodId=p.fldHeaderCodId and d.fldCodeId.IsDescendantOf(p.fldCodeId)=1 and ip.fldStrhid like '/7/%' order by ip.fldId desc )p
	 where h.fldYear=@sal and h.fldOrganId=@OrganId */

	--select * from AccCodingTemp where  fldnecid is not null
	--union all
	--select c1.fldId,c1.fldCode, c1.fldCodeId,c1.fldLevelId,c1.fldTitle,c1.fldDaramadCode,
	--c2.fldnecTitle,c2.fldnecID,c2.fldHnecID from AccCodingTemp c1 
	--inner join AcccodingTemp2 c2 on c1.fldCodeId.GetAncestor(1)=c2.fldCodeId
	-- and c1.fldnecid is null 
 )
 ,Acccoding
 as
 (
	select *,case when fldHnecID.IsDescendantOf(0x94)=1 then 1 else -1 end fldnectype  
	from (select * from AcccodingTemp2 where fldHnecID.IsDescendantOf(0x94)=1
	or  fldHnecID.IsDescendantOf(0x9C)=1) c
 )--select * from Acccoding
 ,Artikl
 as
 (
	SELECT        Acccoding.fldId as fldCodingId, (fldBestankar-fldBedehkar)*fldnectype fldmablagh,fldCaseId,case when fldCaseTypeId=15 then 15 else null end fldCaseTypeId,case when fldCaseTypeId=15 then  fldSourceId else null end fldSourceId,Acccoding.fldnectype
FROM           Acccoding
				left join sanad a  
				inner join ACC.tblDocumentRecord_Details as d on d.fldDocument_HedearId=a.fldId 

				on d.fldCodingId=Acccoding.fldId 
				left join ACC.tblCase ca on d.fldCaseId=ca.fldId
				where   (d.fldDocument_HedearId1=a.headerId1 or 
			(not exists(select * from Acc.tblDocumentRecord_Details as d2 where d2.fldDocument_HedearId1=a.headerId1 )   and d.fldDocument_HedearId1 is null))
 )--select * from Artikl
 ,ArtiklSum
 as
 (
	select c.*,a.fldnectype,a.fldCodeId,a.fldnecID,bd.fldCodeingBudjeId,bd.fldEtebarTypeId from(
	select fldCodingId as fldAccID,fldCaseTypeId,fldSourceId, sum(fldmablagh) fldmablagh 
	from Artikl group by fldCodingId,fldCaseTypeId,fldSourceId) c
	 inner join Acccoding a on c.fldAccID=a.fldId
	 left join BUD.tblCodingBudje_Details bd on   c.fldCaseTypeId=15 and c.fldSourceId=bd.fldCodeingBudjeId
 ),pishbini
 as
 (
	select p.fldBudgetTypeId,a.fldId as fldCodingAcc_DetailsId,p.fldCodingBudje_DetailsId,p.fldMablagh,p.fldMotammamId,p.fldpishbiniId,a.fldCodeId
	,a.fldnecID 
	from BUD.tblPishbini p right join Acccoding a on p.fldCodingAcc_DetailsId=a.fldId 
 )
 ,ArtiklSumFinalll
 as
 (
	select a.*,case when p.fldCodingAcc_DetailsId is null  then 1 
					when a.fldnecID=11 and fldEtebarTypeId!=2 then 2 
					when a.fldnecID=12 and fldEtebarTypeId!=3 then 3 
	else 0 end fldError from ArtiklSum a left join pishbini p on a.fldCodeId.IsDescendantOf(p.fldCodeId)=1
 )--select * from pishbini
 ,AllPishbiniAmalkard
 as
 (
	select fldpishbiniId,p.fldCodeId, fldCodingAcc_DetailsId,fldCodingBudje_DetailsId,fldBudgetTypeId,fldMablagh,p.fldnecID from pishbini as p
	inner join AccCoding a  on a.fldId=p.fldCodingAcc_DetailsId
	union all
	select (ROW_NUMBER() over (order by fldAccID))*-1,p.fldCodeId,fldAccID,fldCodeingBudjeId,8,fldMablagh,p.fldnecID from ArtiklSum as p
	inner join AccCoding a  on a.fldId=p.fldAccID

 )
 --مبالغ پیش بینی شده صرفا برای سال جاری
,AccCodingBudje--(fldpishbiniId,fldcodingAcc_DetailsId,fldcodingBudje_detailsId,fldBudgetTypeId,fldMablagh,flddarsad,fldrow)
as
(
	select p.fldpishbiniId,p.fldCodingAcc_DetailsId
	,case when
	 p.fldCodingBudje_DetailsId is not null then p.fldCodingBudje_DetailsId 
	 when darsad.fldCodingBudje_DetailsId is not null then
	  darsad.fldCodingBudje_DetailsId else null end fldCodingBudje_DetailsId
	,p.fldBudgetTypeId,p.fldMablagh,ISNULL(darsad.fldDarsad,100) as flddarsad
	,ROW_NUMBER() over (partition by p.fldpishbiniId,p.fldBudgetTypeId
	order by p.fldCodingBudje_DetailsId) fldrow
	,p.fldnecID from AllPishbiniAmalkard p
	--AccCoding a 
	--inner join AllPishbiniAmalkard p on a.fldId=p.fldCodingAcc_DetailsId
	 left join BUD.tblBudje_khedmatDarsadId darsad
	  on p.fldCodingAcc_DetailsId=darsad.fldCodingAcc_detailId 
	 
)--select* from AccCodingBudje   order by fldpishbiniId
,AccCodingBudjeDarsad
as
(
	select *,flddarsad*fldMablagh/100.0 flddarsadmablagh from AccCodingBudje
)--select * from AccCodingBudjeDarsad
,AccCodingBudjeDarsadTemp
as
(
	select *,sum(flddarsadmablagh) over (partition by fldpishbiniId,fldBudgetTypeId) fldnewmablagh from AccCodingBudjeDarsad
)--select * from AccCodingBudjeDarsadTemp
,AccCodingBudjeDarsadFinal
as
(
	select fldpishbiniId,fldCodingAcc_DetailsId,fldCodingBudje_DetailsId,fldBudgetTypeId,fldnecID
	,case when fldrow=1 then flddarsadmablagh+(fldMablagh-fldnewmablagh) else flddarsadmablagh end fldmablagh from AccCodingBudjeDarsadTemp
)--select * from AccCodingBudjeDarsadFinal --where fldBudgetTypeId=8 and fldnecID!=7
,
AccCodingAllcols
as
(
  select fldCodingAcc_DetailsId,fldCodingBudje_DetailsId,fldnecID
		, case when fldBudgetTypeId=1 then fldmablagh/@Div else 0 end fldcol1
		,case when fldBudgetTypeId=2 then fldmablagh/@Div else 0 end fldcol2
		,case when fldBudgetTypeId=3 then fldmablagh/@Div else 0 end fldcol3
		,case when fldBudgetTypeId=4 then fldmablagh/@Div else 0 end fldcol4
		,case when fldBudgetTypeId=5 then fldmablagh/@Div else 0 end fldcol5
		,case when fldBudgetTypeId=6 then fldmablagh/@Div else 0 end fldcol6
		,case when fldBudgetTypeId=7 then fldmablagh/@Div else 0 end fldcol7
		,case when fldBudgetTypeId=8 then fldmablagh/@Div else 0 end fldcol8
		,case when fldBudgetTypeId=9 then fldmablagh/@Div else 0 end fldcol9
		,case when fldBudgetTypeId=10 then fldmablagh/@Div else 0 end fldcol10
		,case when fldBudgetTypeId=11 then fldmablagh/@Div else 0 end fldcol11
		,case when fldBudgetTypeId=12 then fldmablagh/@Div else 0 end fldcol12
	 from AccCodingBudjeDarsadFinal 
)select *,case when fldcol6+fldcol9-fldcol10-fldcol8>0 then fldcol6+fldcol9-fldcol10-fldcol8 else 0 end col13
,case  when fldcol8-fldcol6+fldcol9-fldcol10>0 then fldcol8-fldcol6+fldcol9-fldcol10 else 0 end  col14 from AccCodingAllcols
order by fldCodingAcc_DetailsId
end
--,Budcoding
--as
--(
--	select d.* from BUD.tblCodingBudje_Details d inner join BUD.tblCodingBudje_Header h on
--	d.fldHeaderId=h.fldHedaerId and h.fldYear=@sal and h.fldOrganId=@organid 
--)
--,BudcodingTemp
--as
--(
--	select  fldcode,fldCodeingBudjeId,fldhierarchyidId,fldLevelId from Budcoding where fldLevelId=1
--	union all
--	select cast(b2.fldCode+b1.fldCode as varchar(100)),b1.fldCodeingBudjeId,b1.fldhierarchyidId,b1.fldLevelId from Budcoding b1 inner join BudcodingTemp b2 on b1.fldhierarchyidId.GetAncestor(1)=b2.fldhierarchyidId and b1.fldLevelId=b2.fldLevelId+1
--)
--,
--BudjeTemp
--as
--(
--	select fldCodingBudje_DetailsId ,(select a.fldhierarchyidId from BudcodingTemp a where a.fldCodeingBudjeId=fldCodingBudje_DetailsId) fldhierarchyidId,fldBudgetTypeId,sum(fldmablagh) fldmablagh,1 flag from AccCodingBudjeDarsadFinal  group by fldCodingBudje_DetailsId,fldBudgetTypeId 
--	union all
--	select a.fldCodeingBudjeId,a.fldhierarchyidId,b.fldBudgetTypeId,b.fldmablagh,0 flag from BudcodingTemp a inner join BudjeTemp b on b.fldhierarchyidId.GetAncestor(1)=a.fldhierarchyidId

--) 
--,
--Budje
--as
--(
--	select fldCodingBudje_DetailsId ,fldBudgetTypeId,sum(fldmablagh) fldmablagh,flag from BudjeTemp  group by fldCodingBudje_DetailsId,fldBudgetTypeId,flag 


--) 
--,BudjeFinal
--as
--(
--	select b.*,t.fldCode,a.fldLevelId,a.fldTitle,a.fldStrhid from Budje b inner join Budcoding a on b.fldCodingBudje_DetailsId=a.fldCodeingBudjeId inner join BudcodingTemp t on b.fldCodingBudje_DetailsId=t.fldCodeingBudjeId
--)select *  from BudjeFinal --where  fldLevelId=1 and fldBudgetTypeId=1



GO
