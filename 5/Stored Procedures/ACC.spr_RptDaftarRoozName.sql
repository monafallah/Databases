SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE proc [ACC].[spr_RptDaftarRoozName](@Year smallint,@OrganId int,@ModuleSaveId int,@AzTarikh varchar(10),@TaTarikh varchar(10),@Type tinyint,@LevelId int)
As

begin Tran
--declare @Year smallint=1402,@OrganId int=1,@ModuleSaveId int=4,@AzTarikh varchar(10)='1402/01/01',@TaTarikh varchar(10)='1402/12/01',@Type TINYINT=2,@LevelId int=1
DECLARE @Space char(5)
SET @Space = '     '
select d.fldid,h1.fldDocumentNum,d.fldDescriptionDocu,h1.fldTarikhDocument 
,REPLACE(isnull(fldBedehkar,''), ';', CHAR(10)) fldBedehkar
,N'' fldBestankar
,REPLACE(isnull(fldDescriptionBedehkar,N''), ';', CHAR(10) /*+ CHAR(13)*/) fldDescriptionBedehkar
,N'' fldDescriptionBestankar
,Sumbed.fldBedehkar_sum,Sumbes.fldBestankar_sum,Sumbed.fldBedehkar_sum+Sumbes.fldBestankar_sum as fldTotal,fldDescription,1 as fldtype,fldBedehkar_int,0 fldBestankar_int
from acc.tblDocumentRecord_Header d
inner join acc.tblDocumentRecord_Header1 as h1 on h1.fldDocument_HedearId=d.fldid
outer apply (select replace(convert(varchar,cast(fldBedehkar as money),1), '.00','')  as fldBedehkar,fldDescriptionBedehkar,fldDescription,fldBedehkar as fldBedehkar_int
			from(	select sum(fldBedehkar) as fldBedehkar--,max(dd.flddate) as flddate
			, p.fldCode+'_'+p.fldTitle+' '+[ACC].[fn_GetParvandeName](c.fldCaseTypeId,c.fldSourceId,@OrganId)+';' fldDescriptionBedehkar,dd.fldDescription
			  from acc.tblDocumentRecord_Details dd
			  inner join acc.tblCoding_Details as cd on cd.fldId=dd.fldCodingId
			  inner join acc.tblCoding_Details as p on p.fldHeaderCodId=cd.fldHeaderCodId and cd.fldCodeId.IsDescendantOf(p.fldCodeId)=1
			  left join acc.tblCase as c on c.fldId=dd.fldCaseId
			 where  p.fldLevelId=@LevelId and  fldDocument_HedearId= d.fldid and (fldDocument_HedearId1=h1.fldId or 
					(not exists(select * from Acc.tblDocumentRecord_Details as d2 where d2.fldDocument_HedearId1=h1.fldId )   and fldDocument_HedearId1 is null)) 
					and fldBedehkar>0  group by p.fldCode,p.fldTitle,c.fldCaseTypeId,c.fldSourceId,dd.fldDescription)t 
					--order by fldDate  
			
			 )bed
outer apply (select  sum(fldBedehkar)as fldBedehkar_sum
			  from acc.tblDocumentRecord_Details
			 where fldDocument_HedearId= d.fldid and (fldDocument_HedearId1=h1.fldId or 
				(not exists(select * from Acc.tblDocumentRecord_Details as d2 where d2.fldDocument_HedearId1=h1.fldId )   and fldDocument_HedearId1 is null)) 
				and fldBedehkar>0  
			
			 )Sumbed
outer apply (select  sum(fldBestankar)as  fldBestankar_sum
			  from acc.tblDocumentRecord_Details
			 where fldDocument_HedearId= d.fldid and (fldDocument_HedearId1=h1.fldId or 
			(not exists(select * from Acc.tblDocumentRecord_Details as d2 where d2.fldDocument_HedearId1=h1.fldId )   and fldDocument_HedearId1 is null)) 
			and fldBestankar>0   
			 
			 )Sumbes

			 where d.fldYear=@Year and d.fldOrganId=@OrganId and h1.fldModuleSaveId=@ModuleSaveId and h1.fldDocumentNum<>0
			 and h1.fldTarikhDocument between @AzTarikh and @TaTarikh and (@Type=2 or (@Type<>2 and h1.fldAccept=@Type))
union all
			 select d.fldid,h1.fldDocumentNum,d.fldDescriptionDocu,h1.fldTarikhDocument 
,N'' fldBedehkar
,REPLACE(isnull(fldBestankar,''), ';', CHAR(10))fldBestankar
,@Space+REPLACE(isnull(fldDescriptionBestankar,N''), ';', CHAR(10) /*+ CHAR(13)*/)  fldDescriptionBedehkar
,@Space+REPLACE(isnull(fldDescriptionBestankar,N''), ';', CHAR(10) /*+ CHAR(13)*/) fldDescriptionBestankar
,Sumbed.fldBedehkar_sum,Sumbes.fldBestankar_sum,Sumbed.fldBedehkar_sum+Sumbes.fldBestankar_sum as fldTotal,fldDescription,2 as fldType,0 as fldBedehkar_int,fldBestankar_int
from acc.tblDocumentRecord_Header d
inner join acc.tblDocumentRecord_Header1 as h1 on h1.fldDocument_HedearId=d.fldid
outer apply (select  replace(convert(varchar,cast((fldBestankar) as money),1), '.00','')as fldBestankar,fldDescriptionBestankar,fldDescription,fldBestankar as fldBestankar_int
			from(	select sum(fldBestankar) as fldBestankar--,max(dd.flddate) as flddate
			,p.fldCode+'_'+p.fldTitle+' '+[ACC].[fn_GetParvandeName](c.fldCaseTypeId,c.fldSourceId,@OrganId)+';' fldDescriptionBestankar
			,dd.fldDescription
			  from acc.tblDocumentRecord_Details as dd
			  inner join acc.tblCoding_Details as cd on cd.fldId=dd.fldCodingId
			  inner join acc.tblCoding_Details as p on p.fldHeaderCodId=cd.fldHeaderCodId and cd.fldCodeId.IsDescendantOf(p.fldCodeId)=1
			  left join acc.tblCase as c on c.fldId=dd.fldCaseId
			 where  p.fldLevelId=@LevelId and fldDocument_HedearId= d.fldid and (fldDocument_HedearId1=h1.fldId or 
			(not exists(select * from Acc.tblDocumentRecord_Details as d2 where d2.fldDocument_HedearId1=h1.fldId )   and fldDocument_HedearId1 is null)) 
			and fldBestankar>0  group by p.fldCode,p.fldTitle,c.fldCaseTypeId,c.fldSourceId,dd.fldDescription)t --order by t.fldDate
			 
			 )bes
outer apply (select  sum(fldBedehkar)as fldBedehkar_sum
			  from acc.tblDocumentRecord_Details
			 where fldDocument_HedearId= d.fldid and (fldDocument_HedearId1=h1.fldId or 
				(not exists(select * from Acc.tblDocumentRecord_Details as d2 where d2.fldDocument_HedearId1=h1.fldId )   and fldDocument_HedearId1 is null)) 
				and fldBedehkar>0  
			
			 )Sumbed
outer apply (select  sum(fldBestankar)as  fldBestankar_sum
			  from acc.tblDocumentRecord_Details
			 where fldDocument_HedearId= d.fldid and (fldDocument_HedearId1=h1.fldId or 
			(not exists(select * from Acc.tblDocumentRecord_Details as d2 where d2.fldDocument_HedearId1=h1.fldId )   and fldDocument_HedearId1 is null)) 
			and fldBestankar>0   
			 
			 )Sumbes


			 where d.fldYear=@Year and d.fldOrganId=@OrganId and h1.fldModuleSaveId=@ModuleSaveId and h1.fldDocumentNum<>0
			 and h1.fldTarikhDocument between @AzTarikh and @TaTarikh and (@Type=2 or (@Type<>2 and h1.fldAccept=@Type))
			 order by fldTarikhDocument,fldDocumentNum,fldType


commit

			

GO
