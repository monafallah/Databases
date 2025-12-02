SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE proc  [BUD].[SelectPishbiniBudje]
@fieldName nvarchar(50),
 @Year VARCHAR(4),
 @MotammamId int,
 @organid int

as

--declare @Year VARCHAR(4)=1404,@fieldName nvarchar(50)='Daramadi',@MotammamId int=0,@organid int=1--,@mid int= 1
declare @mid varchar (10)=@MotammamId
--select N''fldCode,cast(0 as smallint) as fldLevelId,N''fldTitle,cast(0 as bigint)[Col1],cast(0 as bigint)[Col10],cast(0 as bigint)[Col2],cast(0 as bigint)[Col3],cast(0 as bigint)[Col4]
--,cast(0 as bigint)[Col5],cast(0 as bigint)[Col6],cast(0 as bigint)[Col7],cast(0 as bigint)[Col8],cast(0 as bigint)[Col9],1 last,0 fldCodingId ,''fldNameDarasad,0fldflagSanad

declare @salmaliid varchar(4)
select @salmaliid=fldid from acc.tblFiscalYear where fldYear=@Year and fldOrganId=@organid
declare @SalGhabl varchar(4)=cast(@Year as int)-1,@2SalGhabl varchar(4)=cast(@Year as int)-2,@HeaderSalGhabl varchar(10)='0',@Header2SalGhabl varchar(10)='0'
 ,@Taikh9 varchar(10)='0' ,@Taikh2 varchar(10)='0',@HeaderSalGhablBud varchar(10)='0'
 set @Taikh9=@SalGhabl+'/09/30'
  set @Taikh2=@2SalGhabl+'/10/01'
 select @HeaderSalGhabl=fldId from acc.tblCoding_Header where fldYear=@SalGhabl and fldOrganId=@organid 
  select @Header2SalGhabl=fldId from acc.tblCoding_Header where fldYear=@2SalGhabl and fldOrganId=@organid 
select @HeaderSalGhablBud=fldHedaerId from bud.tblCodingBudje_Header where fldYear=@SalGhabl and fldOrganId=1 

DECLARE @cols AS NVARCHAR(MAX), @query  AS NVARCHAR(MAX),@darsad nvarchar(50)=N'دارای خدمت',@where varchar(100)=''
if (@MotammamId<>0)
set @where=  ' and fldMotammamId='+@mid

if (@MotammamId=0)
set  @where='  and fldMotammamId is null'

set @cols= STUFF((SELECT distinct ',' +'Col'+cast(c.fldid as varchar(2))          
  FROM bud.tblBudgetType c  
            FOR XML PATH(''), TYPE
            ).value('.', 'NVARCHAR(MAX)') 
        ,1,1,'')

if (@fieldName='Daramadi')
begin
set @query=' select fldCode ,fldLevelId,fldTitle ,' + @cols + ',last,fldid as fldCodingId,fldNameDarasad,0 fldflagSanad from 
  (  select d.fldId,d.fldLevelId,d.fldCode,d.fldTitle,
  case when  p.fldMablagh is null and fldBudgetTypeId=2 then pSalghabl.fldMablagh
when p.fldMablagh is null and fldBudgetTypeId=3 then p9Salghabl.fldMablagh
/*when p.fldMablagh is null and fldBudgetTypeId=4 then p2Salghabl.fldMablagh
when p.fldMablagh is null and fldBudgetTypeId=5 then p3Salghabl.fldMablagh*/
else isnull((p.fldMablagh),0) end as fldMablagh
  ,isnull(NameDarasad,'''')fldNameDarasad  
  ,''Col''+cast(fldBudgetTypeId as varchar(2)) fldBudgetTypeId  ,isnull(last,0)last  
  from acc.tblCoding_Header as h   
  inner join acc.tblCoding_Details as d on d.fldHeaderCodId=h.fldId  
  left join acc.tblTemplateCoding as c on c.fldId=d.fldTempCodingId  
	cross apply    (select top 1 fldTempNameId from     
		 acc.tblCoding_Details as p   
		inner join acc.tblTemplateCoding as t on t.fldId=p.fldTempCodingId 
		where p.fldHeaderCodId=d.fldHeaderCodId and t.fldItemId=7 and d.fldCodeId.IsDescendantOf(p.fldCodeId) =1   )tempname 
cross apply(select fldId as fldBudgetTypeId from bud.tblBudgetType )bt
  outer apply (select sum( isnull(fldMablagh,0)) as fldMablagh from acc.tblCoding_Details as c     
				left join bud.tblPishbini as i on i.fldCodingAcc_DetailsId=c.fldId     
				where  c.fldCodeId.IsDescendantOf(d.fldCodeId)=1 and i.fldBudgetTypeId=bt.fldBudgetTypeId and c.fldHeaderCodId=d.fldHeaderCodId 
				  '+@where +'      group by i.fldBudgetTypeId)p  
outer apply (select sum((case when i.fldBudgetTypeId=12 then isnull(fldMablagh,0)*-1 else isnull(fldMablagh,0) end)) as fldMablagh 
			from  acc.tblCoding_Details as d2 
			inner join  acc.tblCoding_Details as c on c.fldHeaderCodId=d2.fldHeaderCodId and  c.fldCodeId.IsDescendantOf(d2.fldCodeId)=1            
			 left join bud.tblPishbini as i on i.fldCodingAcc_DetailsId=c.fldId           
			cross apply    (select top 1 fldTempNameId from          acc.tblCoding_Details as parent       
							 inner join acc.tblTemplateCoding as t on t.fldId=parent.fldTempCodingId     
							 where parent.fldHeaderCodId=d2.fldHeaderCodId and t.fldItemId=7 	and d2.fldCodeId.IsDescendantOf(parent.fldCodeId) =1   )tempname1
			where d2.fldDaramadCode=d.fldDaramadCode and  d2.fldHeaderCodId='+@HeaderSalGhabl+' and i.fldBudgetTypeId in (6,11,12)      
			 )pSalghabl 
outer apply (select abs(sum( isnull(fldBedehkar,0)-isnull(fldBestankar,0))) as fldMablagh 
			from acc.tblCoding_Details as d2 
			inner join  acc.tblCoding_Details as c on c.fldHeaderCodId=d2.fldHeaderCodId and  c.fldCodeId.IsDescendantOf(d2.fldCodeId)=1        
			 inner join acc.tblDocumentRecord_Details as dd on dd.fldCodingId=c.fldId     
			 inner join acc.tblDocumentRecord_Header as dh on dh.fldId=dd.fldDocument_HedearId
			inner join acc.tblDocumentRecord_Header1 as h1 on h1.fldDocument_HedearId=dh.fldId 
			cross apply    (select top 1 fldTempNameId from          acc.tblCoding_Details as parent       
							 inner join acc.tblTemplateCoding as t on t.fldId=parent.fldTempCodingId     
							 where parent.fldHeaderCodId=d2.fldHeaderCodId and t.fldItemId=7 	and d2.fldCodeId.IsDescendantOf(parent.fldCodeId) =1   )tempname1         
			 where  d2.fldDaramadCode=d.fldDaramadCode and d2.fldHeaderCodId='+@HeaderSalGhabl+' and fldTarikhDocument<='''+@Taikh9+''' 
			 and dh.fldType = 1 and fldYear='+@SalGhabl+' and fldOrganId='+cast(@organid as varchar(10))+'
			 AND h1.fldDocumentNum > 0 and  h1.fldModuleSaveId = 4 and  h1.fldTypeSanadId not in (4,5) and  (fldDocument_HedearId1=h1.fldId or 
					(not exists(select * from Acc.tblDocumentRecord_Details as dd2 where dd2.fldDocument_HedearId1=h1.fldId )   and fldDocument_HedearId1 is null))
			 )p9Salghabl 

outer apply (select abs(sum( isnull(fldBedehkar,0)-isnull(fldBestankar,0))) as fldMablagh 
			from acc.tblCoding_Details as d2 
			inner join  acc.tblCoding_Details as c on c.fldHeaderCodId=d2.fldHeaderCodId and  c.fldCodeId.IsDescendantOf(d2.fldCodeId)=1        
			 inner join acc.tblDocumentRecord_Details as dd on dd.fldCodingId=c.fldId     
			 inner join acc.tblDocumentRecord_Header as dh on dh.fldId=dd.fldDocument_HedearId
			inner join acc.tblDocumentRecord_Header1 as h1 on h1.fldDocument_HedearId=dh.fldId 
			cross apply    (select top 1 fldTempNameId from          acc.tblCoding_Details as parent       
							 inner join acc.tblTemplateCoding as t on t.fldId=parent.fldTempCodingId     
							 where parent.fldHeaderCodId=d2.fldHeaderCodId and t.fldItemId=7 	and d2.fldCodeId.IsDescendantOf(parent.fldCodeId) =1   )tempname1         
			 where  d2.fldDaramadCode=d.fldDaramadCode and d2.fldHeaderCodId='+@Header2SalGhabl +'  
			 and dh.fldType = 1 and fldYear='+@2SalGhabl+' and fldOrganId='+cast(@organid as varchar(10))+'
			 AND h1.fldDocumentNum > 0 and  h1.fldModuleSaveId = 4 and  h1.fldTypeSanadId not in (4,5) and h1.fldModuleSaveId = 4 and  h1.fldTypeSanadId not in (4,5) and  (fldDocument_HedearId1=h1.fldId or 
					(not exists(select * from Acc.tblDocumentRecord_Details as dd2 where dd2.fldDocument_HedearId1=h1.fldId )   and fldDocument_HedearId1 is null))
			 )p2Salghabl	
outer apply (select abs(sum( isnull(fldBedehkar,0)-isnull(fldBestankar,0))) as fldMablagh 
			from acc.tblCoding_Details as d2 
			inner join  acc.tblCoding_Details as c on c.fldHeaderCodId=d2.fldHeaderCodId and  c.fldCodeId.IsDescendantOf(d2.fldCodeId)=1        
			 inner join acc.tblDocumentRecord_Details as dd on dd.fldCodingId=c.fldId     
			 inner join acc.tblDocumentRecord_Header as dh on dh.fldId=dd.fldDocument_HedearId
			inner join acc.tblDocumentRecord_Header1 as h1 on h1.fldDocument_HedearId=dh.fldId 
			cross apply    (select top 1 fldTempNameId from          acc.tblCoding_Details as parent       
							 inner join acc.tblTemplateCoding as t on t.fldId=parent.fldTempCodingId     
							 where parent.fldHeaderCodId=d2.fldHeaderCodId and t.fldItemId=7 	and d2.fldCodeId.IsDescendantOf(parent.fldCodeId) =1   )tempname1         
			 where  d2.fldDaramadCode=d.fldDaramadCode and d2.fldHeaderCodId='+@Header2SalGhabl+'   and fldTarikhDocument>='''+@Taikh2 +'''
			 and dh.fldType = 1 and fldYear='+@2SalGhabl+' and fldOrganId='+cast(@organid as varchar(10))+'
			 AND h1.fldDocumentNum > 0 and  h1.fldModuleSaveId = 4 and  h1.fldTypeSanadId not in (4,5) and  (fldDocument_HedearId1=h1.fldId or 
					(not exists(select * from Acc.tblDocumentRecord_Details as dd2 where dd2.fldDocument_HedearId1=h1.fldId )   and fldDocument_HedearId1 is null))
			 )p3Salghabl
 outer apply (select   1 last from  acc.tblCoding_Details p
				left join  acc.tblCoding_Details c on  c.fldCodeId.GetAncestor(1)=p.fldCodeId  and c.fldHeaderCodId=p.fldHeaderCodId
				where p.fldId=d.fldid and c.fldid is null )lastnod 
  outer apply  (select top(1) N'''+@darsad+''' NameDarasad  from bud.tblBudje_khedmatDarsadId  t       
  where t.fldCodingAcc_detailId=d.fldId ) darasad  
  where fldYear='+@Year+' and fldOrganId='+cast(@organid as varchar(4))+')  x              
  pivot               (                   sum(fldMablagh)                  for fldBudgetTypeId in (' + @cols + ')            
  ) p
  order by fldCode'
  --select @query
--set @query='
--select fldCode ,fldTitle ,' + @cols + ',last,fldid as fldCodingId,fldNameDarasad,0 fldflagSanad from (
--select d.fldId,d.fldCode,d.fldTitle,isnull((p.fldMablagh),0)  as fldMablagh,isnull(NameDarasad,'''')fldNameDarasad
--,''Col''+cast(fldBudgetTypeId as varchar(2)) fldBudgetTypeId
--,isnull(last,0)last
--from acc.tblCoding_Header as h 
--inner join acc.tblCoding_Details as d on d.fldHeaderCodId=h.fldId
--inner join acc.tblTemplateCoding as c on c.fldId=d.fldTempCodingId
--cross apply
--	 (select fldTempNameId from 
--		 acc.tblCoding_Header as h 
--		inner join acc.tblCoding_Details as d on d.fldHeaderCodId=h.fldId
--		inner join acc.tblTemplateCoding as c on c.fldId=d.fldTempCodingId and fldItemId=7
--		where fldYear='+@Year+' and fldOrganId='+cast(@organid as varchar(4))+' group by fldTempNameId 
--		)tempname
--inner join acc.tblTemplateCoding as t on t.fldItemId=7  and t.fldTempNameId=tempname.fldTempNameId
--outer apply (
--				select p.fldMablagh,b.fldid fldBudgetTypeId,fldCodingAcc_DetailsId from  bud.tblPishbini as p 
--				inner join bud.tblBudgetType as b on b.fldId=p.fldBudgetTypeId
--				where  p.fldCodingAcc_DetailsId=d.fldId  '+@where +'
--				group by p.fldMablagh,b.fldid,fldCodingAcc_DetailsId
--			)p
--outer apply (select 1 last from  acc.tblCoding_Details d1 
--left join  acc.tblCoding_Details p1 on  p1.fldCodeId.GetAncestor(1)=d1.fldCodeId
--where d1.fldHeaderCodId=h.fldid and p1.fldid is null and d1.fldid=d.fldid)lastnod

--outer apply  (select top(1) N'''+@darsad+'''NameDarasad  from bud.tblBudje_khedmatDarsadId  t 
--					where t.fldCodingAcc_detailId=p.[fldCodingAcc_DetailsId] ) darasad
--where h.fldYear='+@Year+' and h.fldOrganId='+cast(@organid as varchar(4))+' and c.fldTempCodeId.IsDescendantOf(t.fldTempCodeId)=1)
--x
--            pivot 
--            (
--                 sum(fldMablagh)
--                for fldBudgetTypeId in (' + @cols + ')
--            ) p'

--if (@MotammamId<>0)
--set @query= @query+ ' where fldMotammamId='+@mid

--if (@MotammamId=0)
--set @query= @query+ '  where fldMotammamId is null'
end
if (@fieldName='Eghtesadi')
begin
set @query='select fldCode ,fldLevelId,fldTitle  ,' + @cols + ',last,fldid as fldCodingId,fldNameDarasad,fldflagSanad 
	from (  select d.fldId,d.fldLevelId,d.fldCode,d.fldTitle,
	 case when  p.fldMablagh is null and fldBudgetTypeId=2 then pSalghabl.fldMablagh
when p.fldMablagh is null and fldBudgetTypeId=3 then p9Salghabl.fldMablagh
/*when p.fldMablagh is null and fldBudgetTypeId=4 then p2Salghabl.fldMablagh
when p.fldMablagh is null and fldBudgetTypeId=5 then p3Salghabl.fldMablagh*/
else isnull((p.fldMablagh),0) end as fldMablagh
,isnull(NameDarasad,'''')fldNameDarasad  
	,''Col''+cast(fldBudgetTypeId as varchar(2)) fldBudgetTypeId ,isnull(fldFlag,0) fldflagSanad  ,isnull(last,0)last  
	from acc.tblCoding_Header as h   
	inner join acc.tblCoding_Details as d on d.fldHeaderCodId=h.fldId  
	left join acc.tblTemplateCoding as c on c.fldId=d.fldTempCodingId  
	cross apply    (select top 1 fldTempNameId from     
		 acc.tblCoding_Details as p   
		inner join acc.tblTemplateCoding as t on t.fldId=p.fldTempCodingId 
		where p.fldHeaderCodId=d.fldHeaderCodId and t.fldItemId=10 and d.fldCodeId.IsDescendantOf(p.fldCodeId) =1   )tempname  
	cross apply(select fldId as fldBudgetTypeId from bud.tblBudgetType )bt
	 outer apply (select sum( isnull(fldMablagh,0)) as fldMablagh from acc.tblCoding_Details as c     
				left join bud.tblPishbini as i on i.fldCodingAcc_DetailsId=c.fldId     
				where  c.fldCodeId.IsDescendantOf(d.fldCodeId)=1  and i.fldBudgetTypeId=bt.fldBudgetTypeId and c.fldHeaderCodId=d.fldHeaderCodId 
				'+@where +'      group by i.fldBudgetTypeId)p  
	outer apply (select sum((case when i.fldBudgetTypeId=12 then isnull(fldMablagh,0)*-1 else isnull(fldMablagh,0) end)) as fldMablagh 
			from  acc.tblCoding_Details as d2 
			inner join  acc.tblCoding_Details as c on c.fldHeaderCodId=d2.fldHeaderCodId and  c.fldCodeId.IsDescendantOf(d2.fldCodeId)=1            
			 left join bud.tblPishbini as i on i.fldCodingAcc_DetailsId=c.fldId           
			cross apply    (select top 1 fldTempNameId from          acc.tblCoding_Details as parent       
							 inner join acc.tblTemplateCoding as t on t.fldId=parent.fldTempCodingId     
							 where parent.fldHeaderCodId=d2.fldHeaderCodId and t.fldItemId=10 	and d2.fldCodeId.IsDescendantOf(parent.fldCodeId) =1   )tempname1
			where d2.fldDaramadCode=d.fldDaramadCode and  d2.fldHeaderCodId='+@HeaderSalGhabl+' and i.fldBudgetTypeId in (6,11,12)      
			 )pSalghabl 
outer apply (select abs(sum( isnull(fldBedehkar,0)-isnull(fldBestankar,0))) as fldMablagh 
			from acc.tblCoding_Details as d2 
			inner join  acc.tblCoding_Details as c on c.fldHeaderCodId=d2.fldHeaderCodId and  c.fldCodeId.IsDescendantOf(d2.fldCodeId)=1        
			 inner join acc.tblDocumentRecord_Details as dd on dd.fldCodingId=c.fldId     
			 inner join acc.tblDocumentRecord_Header as dh on dh.fldId=dd.fldDocument_HedearId
			inner join acc.tblDocumentRecord_Header1 as h1 on h1.fldDocument_HedearId=dh.fldId 
			cross apply    (select top 1 fldTempNameId from          acc.tblCoding_Details as parent       
							 inner join acc.tblTemplateCoding as t on t.fldId=parent.fldTempCodingId     
							 where parent.fldHeaderCodId=d2.fldHeaderCodId and t.fldItemId=10 	and d2.fldCodeId.IsDescendantOf(parent.fldCodeId) =1   )tempname1         
			 where  d2.fldDaramadCode=d.fldDaramadCode and d2.fldHeaderCodId='+@HeaderSalGhabl+' and fldTarikhDocument<='''+@Taikh9+''' 
			 and dh.fldType = 1 and fldYear='+@SalGhabl+' and fldOrganId='+cast(@organid as varchar(10))+'
			 AND h1.fldDocumentNum > 0 and  h1.fldModuleSaveId = 4 and  h1.fldTypeSanadId not in (4,5) and  (fldDocument_HedearId1=h1.fldId or 
					(not exists(select * from Acc.tblDocumentRecord_Details as dd2 where dd2.fldDocument_HedearId1=h1.fldId )   and fldDocument_HedearId1 is null))
			 )p9Salghabl 

outer apply (select abs(sum( isnull(fldBedehkar,0)-isnull(fldBestankar,0))) as fldMablagh 
			from acc.tblCoding_Details as d2 
			inner join  acc.tblCoding_Details as c on c.fldHeaderCodId=d2.fldHeaderCodId and  c.fldCodeId.IsDescendantOf(d2.fldCodeId)=1        
			 inner join acc.tblDocumentRecord_Details as dd on dd.fldCodingId=c.fldId     
			 inner join acc.tblDocumentRecord_Header as dh on dh.fldId=dd.fldDocument_HedearId
			inner join acc.tblDocumentRecord_Header1 as h1 on h1.fldDocument_HedearId=dh.fldId 
			cross apply    (select top 1 fldTempNameId from          acc.tblCoding_Details as parent       
							 inner join acc.tblTemplateCoding as t on t.fldId=parent.fldTempCodingId     
							 where parent.fldHeaderCodId=d2.fldHeaderCodId and t.fldItemId=10 	and d2.fldCodeId.IsDescendantOf(parent.fldCodeId) =1   )tempname1         
			 where  d2.fldDaramadCode=d.fldDaramadCode and d2.fldHeaderCodId='+@Header2SalGhabl +'  
			 and dh.fldType = 1 and fldYear='+@2SalGhabl+' and fldOrganId='+cast(@organid as varchar(10))+'
			 AND h1.fldDocumentNum > 0 and  h1.fldModuleSaveId = 4 and  h1.fldTypeSanadId not in (4,5) and h1.fldModuleSaveId = 4 and  h1.fldTypeSanadId not in (4,5) and  (fldDocument_HedearId1=h1.fldId or 
					(not exists(select * from Acc.tblDocumentRecord_Details as dd2 where dd2.fldDocument_HedearId1=h1.fldId )   and fldDocument_HedearId1 is null))
			 )p2Salghabl	
outer apply (select abs(sum( isnull(fldBedehkar,0)-isnull(fldBestankar,0))) as fldMablagh 
			from acc.tblCoding_Details as d2 
			inner join  acc.tblCoding_Details as c on c.fldHeaderCodId=d2.fldHeaderCodId and  c.fldCodeId.IsDescendantOf(d2.fldCodeId)=1        
			 inner join acc.tblDocumentRecord_Details as dd on dd.fldCodingId=c.fldId     
			 inner join acc.tblDocumentRecord_Header as dh on dh.fldId=dd.fldDocument_HedearId
			inner join acc.tblDocumentRecord_Header1 as h1 on h1.fldDocument_HedearId=dh.fldId 
			cross apply    (select top 1 fldTempNameId from          acc.tblCoding_Details as parent       
							 inner join acc.tblTemplateCoding as t on t.fldId=parent.fldTempCodingId     
							 where parent.fldHeaderCodId=d2.fldHeaderCodId and t.fldItemId=10 	and d2.fldCodeId.IsDescendantOf(parent.fldCodeId) =1   )tempname1         
			 where  d2.fldDaramadCode=d.fldDaramadCode and d2.fldHeaderCodId='+@Header2SalGhabl+'   and fldTarikhDocument>='''+@Taikh2 +'''
			 and dh.fldType = 1 and fldYear='+@2SalGhabl+' and fldOrganId='+cast(@organid as varchar(10))+'
			 AND h1.fldDocumentNum > 0 and  h1.fldModuleSaveId = 4 and  h1.fldTypeSanadId not in (4,5) and  (fldDocument_HedearId1=h1.fldId or 
					(not exists(select * from Acc.tblDocumentRecord_Details as dd2 where dd2.fldDocument_HedearId1=h1.fldId )   and fldDocument_HedearId1 is null))
			 )p3Salghabl
	outer apply (select   1 last from  acc.tblCoding_Details p
				left join  acc.tblCoding_Details c on  c.fldCodeId.GetAncestor(1)=p.fldCodeId  and c.fldHeaderCodId=p.fldHeaderCodId
				where p.fldId=d.fldid and c.fldid is null )lastnod 
	outer apply  (select top(1) N'''+@darsad+'''NameDarasad  from bud.tblBudje_khedmatDarsadId  t        
					where t.fldCodingAcc_detailId=d.fldId ) darasad  
	outer apply (select top(1) 1 fldFlag from acc.tblDocumentRecord_Details d1       
				inner join acc.tblDocumentRecord_Header h on h.fldid=d1.fldDocument_HedearId      
				inner join acc.tblDocumentRecord_Header1 AS hp ON hp.fldDocument_HedearId = h.fldId       
				where d1.fldCodingId=d.fldid and not exists (select * from bud.tblBudje_khedmatDarsadId                 
				where fldCodingAcc_detailId=d.fldid)        and h.fldType = 1 AND hp.fldDocumentNum > 0 and   hp.fldModuleSaveId = 4 
				and         h.fldFiscalYearId ='+ @salmaliID+' AND h.fldOrganId =  '+cast(@organid as varchar(4))+'      )Sanad  
	where fldYear='+@Year+' and fldOrganId='+cast(@organid as varchar(4))+')  x             
	pivot               (                   sum(fldMablagh)                  for fldBudgetTypeId in (' + @cols + ')   ) p
 
	order by fldCode'
--select fldCode ,fldTitle ,' + @cols + ',last,fldid as fldCodingId,fldNameDarasad,fldflagSanad from (
--select d.fldId,d.fldCode,d.fldTitle,isnull((p.fldMablagh),0)  as fldMablagh,isnull(NameDarasad,'''')fldNameDarasad
--,''Col''+cast(fldBudgetTypeId as varchar(2)) fldBudgetTypeId ,isnull(fldFlag,0) fldflagSanad
--,isnull(last,0)last
--from acc.tblCoding_Header as h 
--inner join acc.tblCoding_Details as d on d.fldHeaderCodId=h.fldId
--inner join acc.tblTemplateCoding as c on c.fldId=d.fldTempCodingId
--cross apply
--	 (select fldTempNameId from 
--		 acc.tblCoding_Header as h 
--		inner join acc.tblCoding_Details as d on d.fldHeaderCodId=h.fldId
--		inner join acc.tblTemplateCoding as c on c.fldId=d.fldTempCodingId --and fldItemId=8
--		cross apply (select fldstrhid from acc.tblTemplateCoding where flditemid=10)r
--		where fldYear='+@Year+' and fldOrganId='+cast(@organid as varchar(4))+' and c.fldstrhid like r.fldstrhid+''%'' group by fldTempNameId 
--		)tempname
--inner join acc.tblTemplateCoding as t on t.fldItemId=10  and t.fldTempNameId=tempname.fldTempNameId
--/*left join bud.tblPishbini as p 
--inner join bud.tblBudgetType as b on b.fldId=p.fldBudgetTypeId
--on p.fldCodingAcc_DetailsId=d.fldId*/
--outer apply (
--				select p.fldMablagh,b.fldid fldBudgetTypeId,fldCodingAcc_DetailsId from  bud.tblPishbini as p 
--				inner join bud.tblBudgetType as b on b.fldId=p.fldBudgetTypeId
--				where  p.fldCodingAcc_DetailsId=d.fldId  '+@where +'
--				group by p.fldMablagh,b.fldid,fldCodingAcc_DetailsId
--			)p
--outer apply (select 1 last from  acc.tblCoding_Details d1 
--left join  acc.tblCoding_Details p1 on  p1.fldCodeId.GetAncestor(1)=d1.fldCodeId
--where d1.fldHeaderCodId=h.fldid and p1.fldid is null and d1.fldid=d.fldid)lastnod
--outer apply  (select top(1) N'''+@darsad+'''NameDarasad  from bud.tblBudje_khedmatDarsadId  t 
--					where t.fldCodingAcc_detailId=p.[fldCodingAcc_DetailsId] ) darasad
--outer apply (select top(1) 1 fldFlag from acc.tblDocumentRecord_Details d1 
--				inner join acc.tblDocumentRecord_Header h on h.fldid=d1.fldDocument_HedearId
--				inner join acc.tblDocumentRecord_Header1 AS hp ON hp.fldDocument_HedearId = h.fldId 
--				where d1.fldCodingId=d.fldid and not exists (select * from bud.tblBudje_khedmatDarsadId
--																where fldCodingAcc_detailId=d.fldid)
--						and h.fldType = 1 AND hp.fldDocumentNum > 0 and   hp.fldModuleSaveId = 4 and 
--						h.fldFiscalYearId ='+ @salmaliID+' AND h.fldOrganId =  '+cast(@organid as varchar(4))+'
--				)Sanad
--where h.fldYear='+@Year+' and h.fldOrganId='+cast(@organid as varchar(4))+' and c.fldTempCodeId.IsDescendantOf(t.fldTempCodeId)=1)
--x
--            pivot 
--            (
--                 sum(fldMablagh)
--                for fldBudgetTypeId in (' + @cols + ')
--            ) p'

--if (@MotammamId<>0)
--set @query= @query+ ' where fldMotammamId='+@mid

--if (@MotammamId=0)
--set @query= @query+ '  where fldMotammamId is null'
end
			
if (@fieldName='Poroje')
begin
set @query='
select fldBudCode fldCode,fldLevelId ,fldTitle ,' + @cols + ',last,fldid as fldCodingId,fldNameDarasad,0 fldflagSanad from (
select d.fldCodeingBudjeId fldId,d.fldLevelId,d.fldBudCode ,d.fldTitle,
case when  p.fldMablagh is null and fldBudgetTypeId=2 then  cast( isnull((pSalghabl.fldMablagh),0)as bigint)
	 when p.fldMablagh is null and fldBudgetTypeId=3 then   cast(isnull((p9Salghabl.fldMablagh),0)as bigint)
	 /*when p.fldMablagh is null and fldBudgetTypeId=4 then   cast(isnull((p2Salghabl.fldMablagh),0)as bigint)
	 when p.fldMablagh is null and fldBudgetTypeId=5 then   cast(isnull((p3Salghabl.fldMablagh),0)as bigint)*/
	 else isnull((p.fldMablagh),0) end as fldMablagh 
,isnull(NameDarasad,'''')fldNameDarasad
,''Col''+cast(fldBudgetTypeId as varchar(2)) fldBudgetTypeId ,d.fldStrHid
/*,isnull(last,0)last*/ ,case when d.fldLevelId=4 and d.fldTarh_KhedmatTypeId=1 then 1 else 0 END as last
from [BUD].[tblCodingBudje_Header] as h 
inner join [BUD].[tblCodingBudje_Details] as d on d.[fldHeaderId]=h.[fldHedaerId]
cross apply(select fldId as fldBudgetTypeId from bud.tblBudgetType )bt
outer apply (select sum( isnull(fldMablagh,0)) as fldMablagh from bud.tblCodingBudje_Details as c
	  left join bud.tblPishbini as i on i.fldCodingBudje_DetailsId=c.fldCodeingBudjeId 
	  where  c.fldhierarchyidId.IsDescendantOf(d.fldhierarchyidId)=1 and c.fldHeaderId=d.fldHeaderId and i.fldBudgetTypeId=bt.fldBudgetTypeId and c.fldLevelId=4 and c.fldTarh_KhedmatTypeId=1  '+@where +'  
	  group by i.fldBudgetTypeId)p
outer apply (select sum((case when i.fldBudgetTypeId=12 then isnull(fldMablagh,0)*-1 else isnull(fldMablagh,0) end)) as fldMablagh 
					 from  bud.tblCodingBudje_Details as d2      
					 inner join  bud.tblCodingBudje_Details as c on c.fldHeaderId=d2.fldHeaderId  and  c.fldhierarchyidId.IsDescendantOf(d2.fldhierarchyidId)=1                  
					 inner join bud.tblPishbini as i on i.fldCodingBudje_DetailsId=c.fldCodeingBudjeId 
					 where d2.fldBudCode=d.fldBudCode and  d2.fldHeaderId='+@HeaderSalGhablBud+' and i.fldBudgetTypeId in (6,11,12)            
					 )pSalghabl   
	 outer apply (select abs(sum( isnull(fldBedehkar,0)-isnull(fldBestankar,0)*isnull(k.fldDarsad,100)/100.0)) as fldMablagh     
				 from  acc.tblCoding_Details as c  
				 inner join acc.tblDocumentRecord_Details as dd on dd.fldCodingId=c.fldId           
				 inner join acc.tblDocumentRecord_Header as dh on dh.fldId=dd.fldDocument_HedearId     
				 inner join acc.tblDocumentRecord_Header1 as h1 on h1.fldDocument_HedearId=dh.fldId  
				 inner join acc.tblCase as ca on ca.fldId=dd.fldCaseId
				 inner join bud.tblCodingBudje_Details as b on b.fldCodeingBudjeId=ca.fldSourceId 
				 inner join bud.tblCodingBudje_Details as bp on b.fldHeaderId=bp.fldHeaderId and  b.fldhierarchyidId.IsDescendantOf(bp.fldhierarchyidId)=1 
				 left join bud.tblBudje_khedmatDarsadId as k on k.fldCodingBudje_DetailsId=b.fldCodeingBudjeId and k.fldCodingAcc_detailId=c.fldId
				 where  bp.fldBudCode=d.fldBudCode and c.fldHeaderCodId='+@HeaderSalGhabl+' and ca.fldCaseTypeId=15 and fldTarikhDocument<='''+@Taikh9+'''      
				 and dh.fldType = 1 and fldYear='+@SalGhabl+' and fldOrganId='+cast(@organid as varchar(10))+'     AND h1.fldDocumentNum > 0 and  h1.fldModuleSaveId = 4 
				 and  h1.fldTypeSanadId not in (4,5) 
				 and  (fldDocument_HedearId1=h1.fldId or       (not exists(select * from Acc.tblDocumentRecord_Details as dd2 where dd2.fldDocument_HedearId1=h1.fldId )   and fldDocument_HedearId1 is null))      
	 )p9Salghabl     
	outer apply (select abs(sum( isnull(fldBedehkar,0)-isnull(fldBestankar,0)*isnull(k.fldDarsad,100)/100.0)) as fldMablagh      
	from acc.tblCoding_Details as c 
					 inner join acc.tblDocumentRecord_Details as dd on dd.fldCodingId=c.fldId           
					 inner join acc.tblDocumentRecord_Header as dh on dh.fldId=dd.fldDocument_HedearId     
					 inner join acc.tblDocumentRecord_Header1 as h1 on h1.fldDocument_HedearId=dh.fldId
					inner join acc.tblCase as ca on ca.fldId=dd.fldCaseId
				 inner join bud.tblCodingBudje_Details as b on b.fldCodeingBudjeId=ca.fldSourceId 
				 inner join bud.tblCodingBudje_Details as bp on b.fldHeaderId=bp.fldHeaderId and  b.fldhierarchyidId.IsDescendantOf(bp.fldhierarchyidId)=1 
				 left join bud.tblBudje_khedmatDarsadId as k on k.fldCodingBudje_DetailsId=b.fldCodeingBudjeId and k.fldCodingAcc_detailId=c.fldId
				 where  bp.fldBudCode=d.fldBudCode
				 and c.fldHeaderCodId='+@Header2SalGhabl+'    and ca.fldCaseTypeId=15     and dh.fldType = 1 and fldYear='+@2SalGhabl+' and fldOrganId='+cast(@organid as varchar(10))+'    
						 AND h1.fldDocumentNum > 0 and  h1.fldModuleSaveId = 4 and  h1.fldTypeSanadId not in (4,5) and h1.fldModuleSaveId = 4 
						 and  h1.fldTypeSanadId not in (4,5) 
						 and  (fldDocument_HedearId1=h1.fldId or       (not exists(select * from Acc.tblDocumentRecord_Details as dd2 where dd2.fldDocument_HedearId1=h1.fldId )   and fldDocument_HedearId1 is null))      
	 )p2Salghabl   
	 outer apply (select abs(sum( isnull(fldBedehkar,0)-isnull(fldBestankar,0)*isnull(k.fldDarsad,100)/100.0)) as fldMablagh      
					from acc.tblCoding_Details as c 
					inner join acc.tblDocumentRecord_Details as dd on dd.fldCodingId=c.fldId           
					inner join acc.tblDocumentRecord_Header as dh on dh.fldId=dd.fldDocument_HedearId     
					inner join acc.tblDocumentRecord_Header1 as h1 on h1.fldDocument_HedearId=dh.fldId 
					inner join acc.tblCase as ca on ca.fldId=dd.fldCaseId
				 inner join bud.tblCodingBudje_Details as b on b.fldCodeingBudjeId=ca.fldSourceId 
				 inner join bud.tblCodingBudje_Details as bp on b.fldHeaderId=bp.fldHeaderId and  b.fldhierarchyidId.IsDescendantOf(bp.fldhierarchyidId)=1 
				 left join bud.tblBudje_khedmatDarsadId as k on k.fldCodingBudje_DetailsId=b.fldCodeingBudjeId and k.fldCodingAcc_detailId=c.fldId
				 where  bp.fldBudCode=d.fldBudCode and c.fldHeaderCodId='+@Header2SalGhabl+'   and ca.fldCaseTypeId=15  and fldTarikhDocument>='''+@Taikh2+'''      
			 and dh.fldType = 1 and fldYear='+@2SalGhabl+' and fldOrganId='+cast(@organid as varchar(10))+'     AND h1.fldDocumentNum > 0 and  h1.fldModuleSaveId = 4 
			 and  h1.fldTypeSanadId not in (4,5) 
			 and  (fldDocument_HedearId1=h1.fldId or       (not exists(select * from Acc.tblDocumentRecord_Details as dd2 where dd2.fldDocument_HedearId1=h1.fldId )   and fldDocument_HedearId1 is null))      
	 )p3Salghabl 
cross apply(select top(1) b.fldTitle from [BUD].[tblCodingBudje_Details] as b 
				where b.fldhierarchyidId.IsDescendantOf(d.fldhierarchyidId)=1 and b.fldHeaderId=d.fldHeaderId
				and (d.fldTarh_KhedmatTypeId=1 or b.fldTarh_KhedmatTypeId=1)) as child
outer apply  (select top(1) N'''+@darsad+'''NameDarasad  from bud.tblBudje_khedmatDarsadId  t 
					where t.[fldCodingBudje_DetailsId]=d.fldCodeingBudjeId ) darasad
where h.fldYear='+@Year+' and h.fldOrganId='+cast(@organid as varchar(4))+')
x
            pivot 
            (
                 sum(fldMablagh)
                for fldBudgetTypeId in (' + @cols + ')
            ) p
			order by fldBudCode'
--set @query='
--select fldBudCode fldCode ,fldTitle ,' + @cols + ',last,fldid as fldCodingId,fldNameDarasad,0 fldflagSanad from (
--select d.fldCodeingBudjeId fldId,d.fldBudCode ,d.fldTitle,isnull((p.fldMablagh),0)  as fldMablagh,isnull(NameDarasad,'''')fldNameDarasad
--,''Col''+cast(fldBudgetTypeId as varchar(2)) fldBudgetTypeId ,d.fldStrHid
--/*,isnull(last,0)last*/ ,case when d.fldLevelId=4 and d.fldTarh_KhedmatTypeId=1 then 1 else 0 END as last
--from [BUD].[tblCodingBudje_Header] as h 
--inner join [BUD].[tblCodingBudje_Details] as d on d.[fldHeaderId]=h.[fldHedaerId]
--cross apply (select pf.fldhierarchyidId 
--			from  bud.tblCodingBudje_Details pf inner join [BUD].[tblCodingBudje_Header] hh
--			on pf.[fldHeaderId]=hh.[fldHedaerId]
--where hh.fldYear='+@Year+' and hh.fldOrganId='+cast(@organid as varchar(4))+' and fldTarh_KhedmatTypeId=1 and fldLevelId=4)pf
--outer apply (
--				select p.fldMablagh,b.fldid fldBudgetTypeId,fldCodingAcc_DetailsId,[fldCodingBudje_DetailsId] from  bud.tblPishbini as p 
--				inner join bud.tblBudgetType as b on b.fldId=p.fldBudgetTypeId
--				where   p.[fldCodingBudje_DetailsId]=d.[fldCodeingBudjeId]  '+@where +'
--			)p
--outer apply (select 1 last from  [BUD].[tblCodingBudje_Details] d1 
--left join  [BUD].[tblCodingBudje_Details] p1 on  p1.[fldhierarchyidId].GetAncestor(1)=d1.[fldhierarchyidId]
--where d1.fldHeaderId=h.fldHedaerId and p1.fldCodeingBudjeId is null and d1.fldCodeingBudjeId=d.fldCodeingBudjeId)lastnod

--outer apply  (select top(1) N'''+@darsad+'''NameDarasad  from bud.tblBudje_khedmatDarsadId  t 
--					where t.[fldCodingBudje_DetailsId]=p.[fldCodingBudje_DetailsId] ) darasad
--where h.fldYear='+@Year+' and h.fldOrganId='+cast(@organid as varchar(4))+'  and   pf.fldhierarchyidId.IsDescendantOf(d.fldhierarchyidId)=1)
--x
--            pivot 
--            (
--                 sum(fldMablagh)
--                for fldBudgetTypeId in (' + @cols + ')
--            ) p
--			order by fldStrHid'


--if (@MotammamId<>0)
--set @query= @query+ ' where fldMotammamId='+@mid

--if (@MotammamId=0)
--set @query= @query+ '  where fldMotammamId is null'
end
			--select @query

			execute(@query)
GO
