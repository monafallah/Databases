SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE proc [BUD].[SelectPishbiniBudje_SalGhabl]( @fieldName nvarchar(50),@Year varchar(4), @MotammamId int, @organid int)
as
--declare @fieldName nvarchar(50)='poroje',
-- @Year int=1403,
-- @MotammamId int=0,
-- @organid int=1
--select N''fldCode,N''fldTitle,cast(0 as bigint)[Col1],cast(0 as bigint)[Col10],cast(0 as bigint)[Col2],cast(0 as bigint)[Col3],cast(0 as bigint)[Col4]
--,cast(0 as bigint)[Col5],cast(0 as bigint)[Col6],cast(0 as bigint)[Col7],cast(0 as bigint)[Col8],cast(0 as bigint)[Col9],1 last,0 fldCodingId ,''fldNameDarasad
--,0fldflagSanad
begin tran
 -----------------------------------------------------------------------------------------------
declare @SalMali1sal int,@salmali2sal int,@Sal int=@Year
select @SalMali1sal=fldid from acc.tblFiscalYear where fldOrganId=@organId and fldYear=@Sal-1
select @salmali2sal=fldid from acc.tblFiscalYear where fldOrganId=@organId and fldYear=@Sal-2
----------------------------------------------------------------------------
declare @AzT9Mah varchar(10)='',@TaT9Mah varchar(10)=''
select @AzT9Mah=min(fldTarikh) from com.tblDateDim where fldSal=@Sal-1 and fldMah=4
select @TaT9Mah=max(fldTarikh) from com.tblDateDim where fldSal=@Sal-1 and fldMah=12 /*عملکرد 9 ماهه آخر سال قبل */
------------------------------------------------------------------------
declare @AzT2Sal varchar(10),@Tat2Sal varchar(10)
select @AzT2Sal=min(fldTarikh) from com.tblDateDim where fldSal=@Sal-2 and fldMah=1
select @Tat2Sal=max(fldTarikh) from com.tblDateDim where fldSal=@Sal-2 and fldMah=12/*عملکرد دو سال قبل*/
-------------------------------------------------------------------------
declare @AzT3Mah varchar(10)='',@TaT3mah varchar(10)=''
select @AzT3Mah=min(fldTarikh) from com.tblDateDim where fldSal=@Sal-2 and fldMah=10
select @TaT3mah=max(fldTarikh) from com.tblDateDim where fldSal=@Sal-2 and fldMah=12/*عملکرد سه ماهه آخر دو سال قبل*/
------------------------------------------------------------------------
--select @SalMali1sal,@salmali2sal,@AzT9Mah,@TaT9Mah,@AzT2Sal,@Tat2Sal,@AzT3Mah,@TaT3mah,@AzT1Sal,@TaT1Sal

create table #SalGhabl
(Hid HIERARCHYID,fldCode varchar(20),fldLevelId int,fldTitle nvarchar(300),fldId int,bed_g bigint,bes_g bigint,bed_m bigint,bes_m bigint,bed bigint,bes bigint,mbed bigint,mbes bigint,
fldCaseName nvarchar(500), fldflag tinyint,fldCaseTypeId tinyint,aztarikh varchar(10),tatarikh varchar(10))

create table #DataGhabl
( fldCode varchar(20),fldTitle nvarchar(300),mbed bigint,mbes bigint,fldid int,fldBudgetTypeId tinyint)

insert into #SalGhabl
exec [BUD].[spr_Taraz_Main_Pishbini] @AzT9Mah,@TaT9Mah,@SalMali1sal,@organId,1,6,0,0,0,2  /*عملکرد 9 ماهه آخر سال قبل */

insert into #SalGhabl
exec [BUD].[spr_Taraz_Main_Pishbini] @AzT2Sal,@Tat2Sal,@SalMali2sal,@organId,1,6,0,0,0,2/*عملکرد دو سال قبل*/


insert into #SalGhabl
exec [BUD].[spr_Taraz_Main_Pishbini] @AzT3Mah,@TaT3mah,@SalMali2sal,@organId,1,6,0,0,0,2 /*عملکرد سه ماهه آخر دو سال قبل*/

insert into #DataGhabl
select fldCode,fldTitle,mbed,mbes,fldid,case when aztarikh=@AzT9Mah and tatarikh=@TaT9Mah then 3 
			when aztarikh=@AzT2Sal and tatarikh=@Tat2Sal then 4
			when aztarikh=@AzT3Mah and tatarikh=@TaT3mah then 5 end
			from #SalGhabl

--select * from #DataGhabl
 --------------------------------------------------------------------------------------------------------------
declare @salmaliid int
select @salmaliid=fldid from acc.tblFiscalYear where fldYear=@sal-1 and fldOrganId=@organid

if (@fieldName='daramadi')

select fldCode ,fldTitle ,Col1,Col10,Col2,Col3,Col4,Col5,Col6,Col7,Col8,Col9,last,fldid as fldCodingId,fldNameDarasad,0 fldflagSanad 
from (select d.fldId,d.fldCode,d.fldTitle,isnull((p.fldMablagh),0)  as fldMablagh,isnull(NameDarasad,'')fldNameDarasad
,'Col'+cast(fldBudgetTypeId as varchar(2)) fldBudgetTypeId,isnull([last],0)[last]
from acc.tblCoding_Header as h 
inner join acc.tblCoding_Details as d on d.fldHeaderCodId=h.fldId
inner join acc.tblTemplateCoding as c on c.fldId=d.fldTempCodingId
cross apply  
			(select top 1 fldTempNameId from     
			 acc.tblCoding_Details as p   
			inner join acc.tblTemplateCoding as t on t.fldId=p.fldTempCodingId 
			where p.fldHeaderCodId=d.fldHeaderCodId and t.fldItemId=7 and d.fldCodeId.IsDescendantOf(p.fldCodeId) =1  
		 )tempname 

outer apply (
			select mbes fldMablagh,fldBudgetTypeId
			from #DataGhabl  s 
			inner join acc.tblCoding_Details c2 on c2.fldid=s.fldid  
			inner join acc.tblTemplateCoding t4 on t4.fldid=c2.fldTempCodingId
			cross apply (select l.fldStrhid from acc.tblTemplateCoding l where fldItemId=7  and l.fldTempNameId=t4.fldTempNameId )q1
			where t4.fldCodeBudget=c.fldCodeBudget  and  t4.fldStrhid like q1.fldStrhid +'%'
			 

			union all
			select  fldMablagh, fldBudgetTypeId 
			from acc.tblCoding_Details as co 
			inner join acc.tblCoding_Header ch on ch.fldid=co.fldHeaderCodId
			inner join acc.tblTemplateCoding tc on tc.fldid=co.fldTempCodingId    
			cross apply (select l.fldStrhid from acc.tblTemplateCoding l where fldItemId=7  and l.fldTempNameId=tc.fldTempNameId )q
			cross apply (select sum( isnull(fldMablagh,0)) as fldMablagh,fldBudgetTypeId 
						 from acc.tblCoding_Details as c2     
						 left join bud.tblPishbini as i on i.fldCodingAcc_DetailsId=c2.fldId     
						 where  c2.fldCodeId.IsDescendantOf(co.fldCodeId)=1 and c2.fldHeaderCodId=co.fldHeaderCodId 
						 and fldMotammamId is null  and fldBudgetTypeId in (6,2)    
						 group by fldBudgetTypeId)pish
			where  tc.fldCodeBudget=c.fldCodeBudget and ch.fldYear=@sal-1 /*مصوب و مصوب سال قبل*/and ch.fldOrganId=@organid  and tc.fldStrhid like q.fldStrhid +'%'
			
			
	)p

outer apply (
			 select 1 last from  acc.tblCoding_Details d1 left join  acc.tblCoding_Details p1 
			 on  p1.fldCodeId.GetAncestor(1)=d1.fldCodeId and d1.fldHeaderCodId=h.fldid
			where   p1.fldid is null and d1.fldid=d.fldid
		 )lastnod

outer apply (select top(1) N'دارای خدمت' NameDarasad  from bud.tblBudje_khedmatDarsadId  t1 where t1.fldCodingAcc_detailId=d.fldid ) darasad
where h.fldYear=@sal and h.fldOrganId=@organid )
x
            pivot 
            (
                 sum(fldMablagh)
                for fldBudgetTypeId in (Col1,Col10,Col2,Col3,Col4,Col5,Col6,Col7,Col8,Col9)
            ) p



if (@fieldName='Eghtesadi')

select fldCode ,fldTitle ,Col1,Col10,Col2,Col3,Col4,Col5,Col6,Col7,Col8,Col9,last,fldid as fldCodingId,fldNameDarasad,fldflagSanad 
from (select d.fldId,d.fldCode,d.fldTitle,isnull((p.fldMablagh),0)  as fldMablagh,isnull(NameDarasad,'')fldNameDarasad
,'Col'+cast(fldBudgetTypeId as varchar(2)) fldBudgetTypeId ,isnull(fldFlag,0) fldflagSanad,isnull(last,0)last
from acc.tblCoding_Header as h 
inner join acc.tblCoding_Details as d on d.fldHeaderCodId=h.fldId
inner join acc.tblTemplateCoding as c on c.fldId=d.fldTempCodingId
cross apply  (
				select top 1 fldTempNameId from   acc.tblCoding_Details as p2   
				 inner join acc.tblTemplateCoding as t on t.fldId=p2.fldTempCodingId 
				 where p2.fldHeaderCodId=d.fldHeaderCodId and t.fldItemId=10 and d.fldCodeId.IsDescendantOf(p2.fldCodeId) =1   
		   )tempname  

outer apply (
				select mbed fldMablagh,fldBudgetTypeId,s.fldId fldCodingAcc_DetailsId
				from #DataGhabl  s 
				inner join acc.tblCoding_Details c2 on c2.fldid=s.fldid  
				inner join acc.tblTemplateCoding te on te.fldid=c2.fldTempCodingId 
				cross apply (select l.fldStrhid from acc.tblTemplateCoding l where fldItemId=10  and l.fldTempNameId=te.fldTempNameId )q1
				where te.fldCodeBudget=c.fldCodeBudget 
		union all
			select  fldMablagh, fldBudgetTypeId 
			from acc.tblCoding_Details as co 
			inner join acc.tblCoding_Header ch on ch.fldid=co.fldHeaderCodId
			inner join acc.tblTemplateCoding tc on tc.fldid=co.fldTempCodingId    
			cross apply (select l.fldStrhid from acc.tblTemplateCoding l where fldItemId=10  and l.fldTempNameId=tc.fldTempNameId )q
			cross apply (select sum( isnull(fldMablagh,0)) as fldMablagh,fldBudgetTypeId 
						 from acc.tblCoding_Details as c2     
						 left join bud.tblPishbini as i on i.fldCodingAcc_DetailsId=c2.fldId     
						 where  c2.fldCodeId.IsDescendantOf(co.fldCodeId)=1 and c2.fldHeaderCodId=co.fldHeaderCodId 
						 and fldMotammamId is null  and fldBudgetTypeId in (6,2)    
						 group by fldBudgetTypeId)pish
			where  tc.fldCodeBudget=c.fldCodeBudget and ch.fldYear=@sal-1 /*مصوب و مصوب سال قبل*/and ch.fldOrganId=@organid  and tc.fldStrhid like q.fldStrhid +'%'

				
			)p

outer apply (
				select 1 last from  acc.tblCoding_Details d1 left join  acc.tblCoding_Details p1 
				on  p1.fldCodeId.GetAncestor(1)=d1.fldCodeId  and p1.fldHeaderCodId=d1.fldHeaderCodId
				where  p1.fldid is null and d1.fldid=d.fldid
			)lastnod

outer apply (select top(1) N'دارای خدمت'NameDarasad  from bud.tblBudje_khedmatDarsadId  t5 where t5.fldCodingAcc_detailId=d.fldid ) darasad

outer apply (
				select top(1) 1 fldFlag from acc.tblDocumentRecord_Details d2
				inner join acc.tblDocumentRecord_Header h2 on h2.fldid=d2.fldDocument_HedearId
				inner join acc.tblDocumentRecord_Header1 AS hp ON hp.fldDocument_HedearId = h2.fldId 
				where d2.fldCodingId=d.fldid and not exists (select * from bud.tblBudje_khedmatDarsadId a
															 where a.fldCodingAcc_detailId=d.fldid)
					and h2.fldType = 1 AND hp.fldDocumentNum > 0 and   hp.fldModuleSaveId = 4 and 
					h2.fldFiscalYearId =@salmaliid AND h2.fldOrganId =  @organid
				)Sanad

where h.fldYear=@sal and h.fldOrganId=@organid)
x
            pivot 
            (
                 sum(fldMablagh)
                for fldBudgetTypeId in (Col1,Col10,Col2,Col3,Col4,Col5,Col6,Col7,Col8,Col9)
            ) p
order by fldCode



if (@fieldName='poroje')


select fldBudCode fldCode ,fldTitle ,Col1,Col10,Col2,Col3,Col4,Col5,Col6,Col7,Col8,Col9,last,fldid as fldCodingId,fldNameDarasad,0 fldflagSanad from (
select d.fldCodeingBudjeId fldId,d.fldBudCode ,d.fldTitle,isnull((fldMablagh),0)  as fldMablagh,isnull(NameDarasad,'')fldNameDarasad
,'Col'+cast(fldBudgetTypeId as varchar(2)) fldBudgetTypeId ,d.fldStrHid
,case when d.fldLevelId=4 and d.fldTarh_KhedmatTypeId=1 then 1 else 0 END as last
from [BUD].[tblCodingBudje_Header] as h 
inner join [BUD].[tblCodingBudje_Details] as d on d.[fldHeaderId]=h.[fldHedaerId]

cross apply  (
				select top 1 d1.fldHeaderId from  [BUD].[tblCodingBudje_Header] as h1 
						inner join [BUD].[tblCodingBudje_Details] as d1 on d1.[fldHeaderId]=h.[fldHedaerId]
				 where h1.fldHedaerId=d.fldHeaderId and  d1.fldhierarchyidId.IsDescendantOf(d.fldhierarchyidId) =1    and d1.fldLevelId=4 and d1.fldTarh_KhedmatTypeId=1  
		   )tempname  

outer apply 
			(
			
			 select fldMablagh,fldBudgetTypeId,fldBudCode
			 from [BUD].[tblCodingBudje_Header] as h1 
			 inner join [BUD].[tblCodingBudje_Details] as d1 on d1.[fldHeaderId]=h1.[fldHedaerId]
			 cross apply (select sum( isnull(fldMablagh,0)) as fldMablagh,fldBudgetTypeId 
							from bud.tblCodingBudje_Details as c
							left join bud.tblPishbini as i on i.fldCodingBudje_DetailsId=c.fldCodeingBudjeId 
							where  c.fldhierarchyidId.IsDescendantOf(d1.fldhierarchyidId)=1 and c.fldHeaderId=d1.fldHeaderId and c.fldLevelId=4 and c.fldTarh_KhedmatTypeId=1    
							and fldMotammamId is null  and fldBudgetTypeId in (6,2)
							group by fldBudgetTypeId
						)p
			 where  h1.fldYear=@Sal-1 and h1.fldOrganId=@organid  ANd d1.fldBudCode=d.fldBudCode
			)rt
outer apply  (select top(1) N'دارای خدمت'NameDarasad  from bud.tblBudje_khedmatDarsadId  t 
					where t.[fldCodingBudje_DetailsId]=d.fldCodeingBudjeId ) darasad
where h.fldYear=@sal and h.fldOrganId=@organId)
x
            pivot 
            (
                 sum(fldMablagh)
                for fldBudgetTypeId in (Col1,Col10,Col2,Col3,Col4,Col5,Col6,Col7,Col8,Col9)
            ) p
			order by fldBudCode



--drop table #DataGhabl
--drop table #SalGhabl

commit






GO
