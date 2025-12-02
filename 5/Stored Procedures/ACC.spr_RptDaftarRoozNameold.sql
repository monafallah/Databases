SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE proc [ACC].[spr_RptDaftarRoozNameold](@Year smallint,@OrganId int,@ModuleSaveId int,@AzTarikh varchar(10),@TaTarikh varchar(10),@Type tinyint)
As

begin Tran
--declare @Year smallint=1401,@OrganId int=1,@ModuleSaveId int=4,@AzTarikh varchar(10)='1401/01/01',@TaTarikh varchar(10)='1401/12/01'
DECLARE @Space char(5)
SET @Space = '     '
select d.fldid,h1.fldDocumentNum,d.fldDescriptionDocu,h1.fldTarikhDocument 
,REPLACE(isnull(fldBedehkar,''), ';', CHAR(10)) fldBedehkar
,@Space+REPLACE(isnull(fldBestankar,''), ';', CHAR(10)+@Space)fldBestankar
,REPLACE(isnull(fldDescriptionBedehkar,N''), ',', CHAR(10) /*+ CHAR(13)*/) fldDescriptionBedehkar
,@Space+REPLACE(isnull(fldDescriptionBestankar,N''), ',', CHAR(10)+@Space /*+ CHAR(13)*/) fldDescriptionBestankar
,Sumbed.fldBedehkar_sum,Sumbes.fldBestankar_sum,Sumbed.fldBedehkar_sum+Sumbes.fldBestankar_sum as fldTotal
from acc.tblDocumentRecord_Header d
inner join acc.tblDocumentRecord_Header1 as h1 on h1.fldDocument_HedearId=d.fldid
outer apply (select  stuff((select ';'+replace(convert(varchar,cast(fldBedehkar as money),1), '.00','')
			  from acc.tblDocumentRecord_Details
			 where fldDocument_HedearId= d.fldid and (fldDocument_HedearId1=h1.fldId or 
					(not exists(select * from Acc.tblDocumentRecord_Details as d2 where d2.fldDocument_HedearId1=h1.fldId )   and fldDocument_HedearId1 is null)) 
					and fldBedehkar>0  order by fldDate for xml path('')),1,1,'') as fldBedehkar
			
			 )bed
outer apply (select  stuff((select ';'+replace(convert(varchar,cast(fldBestankar as money),1), '.00','')
			  from acc.tblDocumentRecord_Details
			 where fldDocument_HedearId= d.fldid and (fldDocument_HedearId1=h1.fldId or 
			(not exists(select * from Acc.tblDocumentRecord_Details as d2 where d2.fldDocument_HedearId1=h1.fldId )   and fldDocument_HedearId1 is null)) 
			and fldBestankar>0  order by fldDate for xml path('')),1,1,'') as fldBestankar
			 
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
outer apply (select  (select (t.fldCode+'_'+t.fldTitle+' '+t.fldName)+','   
			  
			  from(select cd.fldCode,cd.fldTitle,e.fldName+' '+fldFamily as fldName,dd.fldDate 
			  from acc.tblDocumentRecord_Details as dd
			  inner join acc.tblCoding_Details as cd on cd.fldId=dd.fldCodingId
			  inner join acc.tblCase as c on c.fldId=dd.fldCaseId
			  inner join Com.tblEmployee as e on e.fldId=c.fldSourceId 
			  where dd.fldDocument_HedearId= d.fldid and (fldDocument_HedearId1=h1.fldId or 
			(not exists(select * from Acc.tblDocumentRecord_Details as d2 where d2.fldDocument_HedearId1=h1.fldId )   and fldDocument_HedearId1 is null)) 
			and dd.fldBedehkar>0 and c.fldCaseTypeId=1  --حقیقی
			   union all
			   select cd.fldCode,cd.fldTitle,a.fldName,dd.fldDate 
			  from acc.tblDocumentRecord_Details as dd
			  inner join acc.tblCoding_Details as cd on cd.fldId=dd.fldCodingId
			  inner join acc.tblCase as c on c.fldId=dd.fldCaseId
			  inner join Com.tblAshkhaseHoghoghi as a on a.fldId=c.fldSourceId
			  where dd.fldDocument_HedearId= d.fldid and (fldDocument_HedearId1=h1.fldId or 
			(not exists(select * from Acc.tblDocumentRecord_Details as d2 where d2.fldDocument_HedearId1=h1.fldId )   and fldDocument_HedearId1 is null)) 
			and dd.fldBedehkar>0 and c.fldCaseTypeId=2 --حقوقی
			 
			   union all
			   select cd.fldCode,cd.fldTitle,r.fldSubject,dd.fldDate 
			  from acc.tblDocumentRecord_Details as dd
			  inner join acc.tblCoding_Details as cd on cd.fldId=dd.fldCodingId
			  inner join acc.tblCase as c on c.fldId=dd.fldCaseId
			  inner join Cntr.tblContracts as r on r.fldId=c.fldSourceId
			  where dd.fldDocument_HedearId= d.fldid and (fldDocument_HedearId1=h1.fldId or 
			(not exists(select * from Acc.tblDocumentRecord_Details as d2 where d2.fldDocument_HedearId1=h1.fldId )   and fldDocument_HedearId1 is null)) 
			and dd.fldBedehkar>0 and c.fldCaseTypeId in (13,14)-- قرارداد وارده و صادره

			 union all
			   select cd.fldCode,cd.fldTitle,r.fldShomareSanad+'('+fldBabat+')'fldBabat,dd.fldDate 
			  from acc.tblDocumentRecord_Details as dd
			  inner join acc.tblCoding_Details as cd on cd.fldId=dd.fldCodingId
			  inner join acc.tblCase as c on c.fldId=dd.fldCaseId
			  inner join drd.tblCheck as r on r.fldId=c.fldSourceId
			  where dd.fldDocument_HedearId= d.fldid and (fldDocument_HedearId1=h1.fldId or 
			(not exists(select * from Acc.tblDocumentRecord_Details as d2 where d2.fldDocument_HedearId1=h1.fldId )   and fldDocument_HedearId1 is null)) 
			and dd.fldBedehkar>0 and c.fldCaseTypeId=3 /*and fldReplyTaghsitId is null*/ --چک وارده
			 
			 union all
			   select cd.fldCode,cd.fldTitle,r.fldCodeSerialCheck+'('+fldBabat+')'fldBabat,dd.fldDate 
			  from acc.tblDocumentRecord_Details as dd
			  inner join acc.tblCoding_Details as cd on cd.fldId=dd.fldCodingId
			  inner join acc.tblCase as c on c.fldId=dd.fldCaseId
			  inner join chk.tblSodorCheck as r on r.fldId=c.fldSourceId
			  where dd.fldDocument_HedearId= d.fldid and (fldDocument_HedearId1=h1.fldId or 
			(not exists(select * from Acc.tblDocumentRecord_Details as d2 where d2.fldDocument_HedearId1=h1.fldId )   and fldDocument_HedearId1 is null)) 
			and dd.fldBedehkar>0 and c.fldCaseTypeId=4  --چک صادره

			 union all
			  select cd.fldCode,cd.fldTitle,cast(r.fldid as varchar(30))+'_'+Nameshakhs.fldName+'('+Nameshakhs.fldCodemeli+')'shomare,dd.fldDate 
			  from acc.tblDocumentRecord_Details as dd
			  inner join acc.tblCoding_Details as cd on cd.fldId=dd.fldCodingId
			  inner join acc.tblCase as c on c.fldId=dd.fldCaseId
			  inner join drd.tblSodoorFish as r on r.fldId=c.fldSourceId
			  inner join drd.tblElamAvarez e on e.fldid=fldElamAvarezId
			  cross apply (
					select fldName collate SQL_Latin1_General_CP1_CI_AS+' '+fldFamily collate SQL_Latin1_General_CP1_CI_AS as fldName,isnull(fldCodemeli,fldCodeMoshakhase) as fldCodemeli from com.tblAshkhas a inner join com.tblEmployee e 
					on e.fldid=fldHaghighiId
					where a.fldid=fldAshakhasID
					union all
					select fldName,fldShenaseMelli as fldCodeMeli from com.tblAshkhas a inner join com.tblAshkhaseHoghoghi h 
					on h.fldid=fldHoghoghiId
					where a.fldid=fldAshakhasID
				)Nameshakhs
			  where dd.fldDocument_HedearId= d.fldid and (fldDocument_HedearId1=h1.fldId or 
			(not exists(select * from Acc.tblDocumentRecord_Details as d2 where d2.fldDocument_HedearId1=h1.fldId )   and fldDocument_HedearId1 is null)) 
			and dd.fldBedehkar>0 and c.fldCaseTypeId=6  and not exists (select * from drd.tblEbtal where fldFishId=r.fldid)--فیش

			union all
			  select cd.fldCode,cd.fldTitle,p.fldTitle,dd.fldDate 
			  from acc.tblDocumentRecord_Details as dd
			  inner join acc.tblCoding_Details as cd on cd.fldId=dd.fldCodingId
			  inner join acc.tblCase as c on c.fldId=dd.fldCaseId
			  inner join bud.tblCodingBudje_Details as p on p.fldCodeingBudjeId=c.fldSourceId
			  where dd.fldDocument_HedearId= d.fldid and (fldDocument_HedearId1=h1.fldId or 
			(not exists(select * from Acc.tblDocumentRecord_Details as d2 where d2.fldDocument_HedearId1=h1.fldId )   and fldDocument_HedearId1 is null)) 
			and dd.fldBedehkar>0 and c.fldCaseTypeId=15 and  p.fldLevelId=4 and p.fldTarh_KhedmatTypeId=1
				
			union all
			  select cd.fldCode,cd.fldTitle,s.fldShomareHesab+'_'+b.fldBankName+'('+sh.fldName+')' shomare,dd.fldDate 
			  from acc.tblDocumentRecord_Details as dd
			  inner join acc.tblCoding_Details as cd on cd.fldId=dd.fldCodingId
			  inner join acc.tblCase as c on c.fldId=dd.fldCaseId
			  inner join com.tblShomareHesabeOmoomi as s on s.fldId=c.fldSourceId
			  inner join com.tblAshkhas a on s.fldAshkhasId=a.fldId
			  inner join com.tblOrganization o on o.fldAshkhaseHoghoghiId=a.fldHoghoghiId
			  inner join com.tblAshkhaseHoghoghi h on h.fldid=fldAshkhaseHoghoghiId
			  inner join com.tblSHobe sh on sh.fldid=fldShobeId
			  inner join com.tblBank b on b.fldid=sh.fldBankId
			  where dd.fldDocument_HedearId= d.fldid and (fldDocument_HedearId1=h1.fldId or 
			(not exists(select * from Acc.tblDocumentRecord_Details as d2 where d2.fldDocument_HedearId1=h1.fldId )   and fldDocument_HedearId1 is null)) 
			and dd.fldBedehkar>0 and c.fldCaseTypeId=5


			   union all
			   select cd.fldCode,cd.fldTitle,N'' as fldName,dd.fldDate 
			  from acc.tblDocumentRecord_Details as dd
			  inner join acc.tblCoding_Details as cd on cd.fldId=dd.fldCodingId
			  where dd.fldDocument_HedearId= d.fldid and (fldDocument_HedearId1=h1.fldId or 
			(not exists(select * from Acc.tblDocumentRecord_Details as d2 where d2.fldDocument_HedearId1=h1.fldId )   and fldDocument_HedearId1 is null)) 
			and dd.fldBedehkar>0 and dd.fldCaseId is null
			 )t   order by t.fldDate
			 for xml path('')) as fldDescriptionBedehkar 
			 )beddesc
outer apply (select  (select (t.fldCode+'_'+t.fldTitle+' '+t.fldName)+','   
			  
			  from(select cd.fldCode,cd.fldTitle,e.fldName+' '+fldFamily as fldName,dd.fldDate 
			  from acc.tblDocumentRecord_Details as dd
			  inner join acc.tblCoding_Details as cd on cd.fldId=dd.fldCodingId
			  inner join acc.tblCase as c on c.fldId=dd.fldCaseId
			  inner join Com.tblEmployee as e on e.fldId=c.fldSourceId 
			  where dd.fldDocument_HedearId= d.fldid and (fldDocument_HedearId1=h1.fldId or 
			(not exists(select * from Acc.tblDocumentRecord_Details as d2 where d2.fldDocument_HedearId1=h1.fldId )   and fldDocument_HedearId1 is null)) 
			and dd.fldBestankar>0 and c.fldCaseTypeId=1  
			   union all
			   select cd.fldCode,cd.fldTitle,a.fldName,dd.fldDate 
			  from acc.tblDocumentRecord_Details as dd
			  inner join acc.tblCoding_Details as cd on cd.fldId=dd.fldCodingId
			  inner join acc.tblCase as c on c.fldId=dd.fldCaseId
			  inner join Com.tblAshkhaseHoghoghi as a on a.fldId=c.fldSourceId
			  where dd.fldDocument_HedearId= d.fldid and (fldDocument_HedearId1=h1.fldId or 
			(not exists(select * from Acc.tblDocumentRecord_Details as d2 where d2.fldDocument_HedearId1=h1.fldId )   and fldDocument_HedearId1 is null)) 
			and dd.fldBestankar>0 and c.fldCaseTypeId=2
			 
			   union all
			   select cd.fldCode,cd.fldTitle,r.fldSubject,dd.fldDate 
			  from acc.tblDocumentRecord_Details as dd
			  inner join acc.tblCoding_Details as cd on cd.fldId=dd.fldCodingId
			  inner join acc.tblCase as c on c.fldId=dd.fldCaseId
			  inner join Cntr.tblContracts as r on r.fldId=c.fldSourceId
			  where dd.fldDocument_HedearId= d.fldid and (fldDocument_HedearId1=h1.fldId or 
			(not exists(select * from Acc.tblDocumentRecord_Details as d2 where d2.fldDocument_HedearId1=h1.fldId )   and fldDocument_HedearId1 is null)) 
			and dd.fldBestankar>0 and c.fldCaseTypeId in (13,14)

			 union all
			   select cd.fldCode,cd.fldTitle,r.fldShenaseKamelCheck+'('+fldBabat+')'fldBabat,dd.fldDate 
			  from acc.tblDocumentRecord_Details as dd
			  inner join acc.tblCoding_Details as cd on cd.fldId=dd.fldCodingId
			  inner join acc.tblCase as c on c.fldId=dd.fldCaseId
			  inner join chk.tblCheckHayeVarede as r on r.fldId=c.fldSourceId
			   where dd.fldDocument_HedearId= d.fldid and (fldDocument_HedearId1=h1.fldId or 
			  (not exists(select * from Acc.tblDocumentRecord_Details as d2 where d2.fldDocument_HedearId1=h1.fldId )   and fldDocument_HedearId1 is null)) 
			and dd.fldBestankar>0 and c.fldCaseTypeId =3

			union all
			   select cd.fldCode,cd.fldTitle,r.fldShomareSanad+'('+fldBabat+')'fldBabat,dd.fldDate 
			  from acc.tblDocumentRecord_Details as dd
			  inner join acc.tblCoding_Details as cd on cd.fldId=dd.fldCodingId
			  inner join acc.tblCase as c on c.fldId=dd.fldCaseId
			  inner join drd.tblCheck as r on r.fldId=c.fldSourceId
			   where dd.fldDocument_HedearId= d.fldid and (fldDocument_HedearId1=h1.fldId or 
			  (not exists(select * from Acc.tblDocumentRecord_Details as d2 where d2.fldDocument_HedearId1=h1.fldId )   and fldDocument_HedearId1 is null)) 
			and dd.fldBestankar>0 and c.fldCaseTypeId =4 and fldReplyTaghsitId is null
			
			union all
			   select cd.fldCode,cd.fldTitle,cast(r.fldid as varchar(30))+'_'+Nameshakhs.fldName+'('+Nameshakhs.fldCodemeli+')'shomare,dd.fldDate 
			  from acc.tblDocumentRecord_Details as dd
			  inner join acc.tblCoding_Details as cd on cd.fldId=dd.fldCodingId
			  inner join acc.tblCase as c on c.fldId=dd.fldCaseId
			   inner join drd.tblSodoorFish as r on r.fldId=c.fldSourceId
			  inner join drd.tblElamAvarez e on e.fldid=fldElamAvarezId
			  cross apply (
					select fldName collate SQL_Latin1_General_CP1_CI_AS+' '+fldFamily collate SQL_Latin1_General_CP1_CI_AS as fldName,isnull(fldCodemeli,fldCodeMoshakhase) as fldCodemeli from com.tblAshkhas a inner join com.tblEmployee e 
					on e.fldid=fldHaghighiId
					where a.fldid=fldAshakhasID
					union all
					select fldName,fldShenaseMelli as fldCodeMeli from com.tblAshkhas a inner join com.tblAshkhaseHoghoghi h 
					on h.fldid=fldHoghoghiId
					where a.fldid=fldAshakhasID
				)Nameshakhs
			   where dd.fldDocument_HedearId= d.fldid and (fldDocument_HedearId1=h1.fldId or 
			  (not exists(select * from Acc.tblDocumentRecord_Details as d2 where d2.fldDocument_HedearId1=h1.fldId )   and fldDocument_HedearId1 is null)) 
			and dd.fldBestankar>0 and c.fldCaseTypeId =6  and not exists (select * from drd.tblEbtal where fldFishId=r.fldid)
 

			union all
			   select cd.fldCode,cd.fldTitle,r.fldTitle,dd.fldDate 
			  from acc.tblDocumentRecord_Details as dd
			  inner join acc.tblCoding_Details as cd on cd.fldId=dd.fldCodingId
			  inner join acc.tblCase as c on c.fldId=dd.fldCaseId
			  inner join bud.tblCodingBudje_Details as r on r.fldCodeingBudjeId=c.fldSourceId
			   where dd.fldDocument_HedearId= d.fldid and (fldDocument_HedearId1=h1.fldId or 
			  (not exists(select * from Acc.tblDocumentRecord_Details as d2 where d2.fldDocument_HedearId1=h1.fldId )   and fldDocument_HedearId1 is null)) 
			and dd.fldBestankar>0 and c.fldCaseTypeId =15    and r.fldLevelId=4 and r.fldTarh_KhedmatTypeId=1 


			
			union all
			   select cd.fldCode,cd.fldTitle,s.fldShomareHesab+'_'+b.fldBankName+'('+sh.fldName+')' shomare,dd.fldDate 
			  from acc.tblDocumentRecord_Details as dd
			  inner join acc.tblCoding_Details as cd on cd.fldId=dd.fldCodingId
			  inner join acc.tblCase as c on c.fldId=dd.fldCaseId
			  inner join com.tblShomareHesabeOmoomi as s on s.fldId=c.fldSourceId
			  inner join com.tblAshkhas a on s.fldAshkhasId=a.fldId
			  inner join com.tblOrganization o on o.fldAshkhaseHoghoghiId=a.fldHoghoghiId
			  inner join com.tblAshkhaseHoghoghi h on h.fldid=fldAshkhaseHoghoghiId
			  inner join com.tblSHobe sh on sh.fldid=fldShobeId
			  inner join com.tblBank b on b.fldid=sh.fldBankId
			   where dd.fldDocument_HedearId= d.fldid and (fldDocument_HedearId1=h1.fldId or 
			  (not exists(select * from Acc.tblDocumentRecord_Details as d2 where d2.fldDocument_HedearId1=h1.fldId )   and fldDocument_HedearId1 is null)) 
			and dd.fldBestankar>0 and c.fldCaseTypeId =5

			   union all
			   select cd.fldCode,cd.fldTitle,N'' as fldName,dd.fldDate 
			  from acc.tblDocumentRecord_Details as dd
			  inner join acc.tblCoding_Details as cd on cd.fldId=dd.fldCodingId
			  where dd.fldDocument_HedearId= d.fldid and (fldDocument_HedearId1=h1.fldId or 
			(not exists(select * from Acc.tblDocumentRecord_Details as d2 where d2.fldDocument_HedearId1=h1.fldId )   and fldDocument_HedearId1 is null)) 
			and dd.fldBestankar>0  and dd.fldCaseId is null
			 )t   order by t.fldDate
			 for xml path('')) as fldDescriptionBestankar
			)besdesc
--cross Apply(
--				select atf from (select row_number()over (order by fldId) atf,fldid  from acc.tblDocumentRecord_Header  h
--				where h.fldOrganId=d.fldOrganId and h.fldYear=d.fldYear 
--					and h.fldModuleSaveId=d.fldModuleSaveId
--					)t where t.fldid=d.fldid)atfNum
			 where d.fldYear=@Year and d.fldOrganId=@OrganId and h1.fldModuleSaveId=@ModuleSaveId and h1.fldDocumentNum<>0
			 and h1.fldTarikhDocument between @AzTarikh and @TaTarikh and (@Type=2 or (@Type<>2 and h1.fldAccept=@Type))
			 order by fldTarikhDocument,fldDocumentNum


commit

			
GO
