SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE proc [ACC].[spr_SelectHesabDaryaftani]
@fieldName varchar(50),@FiscalYearId int,@ShomareHesabId int
as 
BEGIN TRAN
--declare @FiscalYearId int=8,@ShomareHesabId int=1
if (@fieldName='Fish')
select * from (
select *,abs(fldBedehkar-fldBestankar) as fldMande from (
SELECT   fldSourceId as fldSerialFish,sum([fldBedehkar]) fldBedehkar, sum([fldBestankar])fldBestankar,e.fldId as fldElamAvarezId,0 as fldPardakhtFileId,N'' asfldDateSendFile
			,isnull([ACC].[fn_GetParvandeName](fldCaseTypeId,fldSourceId,h.fldOrganId),'')as  fldName,fldModuleErsalId
			,c.fldCode,c.fldTitle as fldNameCoding,Com.fn_NameAshkhasHaghighi_Hoghoghi(e.fldAshakhasID) as fldNameShakhs
			,N'' fldCaseTypeName
			FROM   [ACC].[tblDocumentRecord_Details] inner join 
			acc.tblDocumentRecord_Header as h on h.fldId=[tblDocumentRecord_Details].fldDocument_HedearId inner join 
			acc.tblDocumentRecord_Header1 as h1 on h1.fldDocument_HedearId=h.fldId inner join 
			[ACC].tblCase	on tblCase.fldId=tblDocumentRecord_Details.fldCaseId inner join 
			acc.tblCoding_Details c on c.fldid=fldCodingId inner join 
			acc.tblTemplateCoding as t on t.fldId=c.fldTempCodingId inner join 
			drd.tblSodoorFish as s on s.fldId=tblCase.fldSourceId  inner join 
			Drd.tblElamAvarez as e ON s.fldElamAvarezId = e.fldId 
			WHERE  fldFiscalYearId=@FiscalYearId and fldCaseTypeId=6 and fldItemId=14 
			and h1.fldDocumentNum>0 --and fldShenaseGhabz='' and fldShenasePardakht=''
			--and fldShomareHesabId=@ShomareHesabId 
			and (fldDocument_HedearId1=h1.fldId
			 or (not exists(select * from Acc.tblDocumentRecord_Details as d2 where d2.fldDocument_HedearId1=h1.fldId ) and fldDocument_HedearId1 is null )) 
			and not exists (select * from acc.tblArtiklMap as a 
							cross apply(select * from com.Split(a.fldSourceId,','))s
							inner join acc.tblCase as c on a.fldType=c.fldCaseTypeId and  c.fldSourceId=s.Item 
							where tblCase.fldId=c.fldId)
			
			group by fldCaseTypeId,fldSourceId,h.fldOrganId,c.fldCode,c.fldTitle,e.fldAshakhasID,fldModuleErsalId,e.fldId)t)t
			where fldMande<>0

if (@fieldName='Fish_PardakhtFile')
select * from (
select *,abs(fldBedehkar-fldBestankar) as fldMande from (
SELECT   fldSourceId as fldSerialFish,sum([fldBedehkar]) fldBedehkar, sum([fldBestankar])fldBestankar,e.fldId as fldElamAvarezId,d.fldPardakhtFileId,p.fldDateSendFile
			,isnull([ACC].[fn_GetParvandeName](fldCaseTypeId,fldSourceId,h.fldOrganId),'')as  fldName,fldModuleErsalId
			,c.fldCode,c.fldTitle as fldNameCoding,Com.fn_NameAshkhasHaghighi_Hoghoghi(e.fldAshakhasID) as fldNameShakhs
			,N'' fldCaseTypeName
			FROM   [ACC].[tblDocumentRecord_Details] inner join 
			acc.tblDocumentRecord_Header as h on h.fldId=[tblDocumentRecord_Details].fldDocument_HedearId inner join 
			acc.tblDocumentRecord_Header1 as h1 on h1.fldDocument_HedearId=h.fldId inner join 
			[ACC].tblCase	on tblCase.fldId=tblDocumentRecord_Details.fldCaseId inner join 
			acc.tblCoding_Details c on c.fldid=fldCodingId inner join 
			acc.tblTemplateCoding as t on t.fldId=c.fldTempCodingId inner join 
			drd.tblSodoorFish as s on s.fldId=tblCase.fldSourceId  inner join 
			Drd.tblElamAvarez as e ON s.fldElamAvarezId = e.fldId inner join
			drd.tblPardakhtFiles_Detail as d on d.fldShenaseGhabz=s.fldShenaseGhabz and d.fldShenasePardakht=s.fldShenasePardakht inner join
			drd.tblPardakhtFile as p on p.fldId=d.fldPardakhtFileId
			WHERE  fldFiscalYearId=@FiscalYearId and fldCaseTypeId=6 and fldItemId=14 
			and h1.fldDocumentNum>0
			--and fldShomareHesabId=@ShomareHesabId 
			and (fldDocument_HedearId1=h1.fldId
			 or (not exists(select * from Acc.tblDocumentRecord_Details as d2 where d2.fldDocument_HedearId1=h1.fldId ) and fldDocument_HedearId1 is null )) 
			and not exists (select * from acc.tblArtiklMap as a 
							cross apply(select * from com.Split(a.fldSourceId,','))s
							inner join acc.tblCase as c on a.fldType=c.fldCaseTypeId and  c.fldSourceId=s.Item 
							where tblCase.fldId=c.fldId)
			
			group by fldCaseTypeId,fldSourceId,h.fldOrganId,c.fldCode,c.fldTitle,e.fldAshakhasID,fldModuleErsalId,e.fldId,d.fldPardakhtFileId,p.fldDateSendFile)t)t
			where fldMande<>0

if (@fieldName='Check_Varede')
select * from (
select *,abs(fldBedehkar-fldBestankar) as fldMande from (
SELECT   fldSourceId as fldSerialFish,sum([fldBedehkar]) fldBedehkar, sum([fldBestankar])fldBestankar,e.fldId as fldElamAvarezId,0 as fldPardakhtFileId,N'' asfldDateSendFile
			,isnull([ACC].[fn_GetParvandeName](fldCaseTypeId,fldSourceId,h.fldOrganId),'')as  fldName,fldModuleErsalId
			,c.fldCode,c.fldTitle as fldNameCoding,Com.fn_NameAshkhasHaghighi_Hoghoghi(e.fldAshakhasID) as fldNameShakhs
			,cc.fldName fldCaseTypeName
			FROM   [ACC].[tblDocumentRecord_Details] inner join 
			acc.tblDocumentRecord_Header as h on h.fldId=[tblDocumentRecord_Details].fldDocument_HedearId inner join 
			acc.tblDocumentRecord_Header1 as h1 on h1.fldDocument_HedearId=h.fldId inner join 
			[ACC].tblCase	on tblCase.fldId=tblDocumentRecord_Details.fldCaseId inner join 
			acc.tblCaseType cc on cc.fldid=tblCase.fldCaseTypeId inner join 
			acc.tblCoding_Details c on c.fldid=fldCodingId inner join 
			acc.tblTemplateCoding as t on t.fldId=c.fldTempCodingId inner join 
			drd.tblCheck as s on s.fldId=tblCase.fldSourceId  inner join 
			drd.tblReplyTaghsit r1 on r1.fldid=s.fldReplyTaghsitId inner join
			drd.tblStatusTaghsit_Takhfif s2 on s2.fldid=r1.fldStatusId inner join 
			drd.tblRequestTaghsit_Takhfif r2 on r2.fldid=s2.fldRequestId inner join
			Drd.tblElamAvarez as e ON r2.fldElamAvarezId = e.fldId 
			outer apply(select top 1 fldStatus from chk.tblCheckStatus  as cs where cs.fldCheckVaredeId=s.fldId order by cs.fldDate desc)cs
			WHERE  fldFiscalYearId=@FiscalYearId and fldCaseTypeId=3 and fldItemId=38 
			and h1.fldDocumentNum>0 and s.fldTypeSanad=0 and cs.fldStatus<>3
			--and fldShomareHesabId=@ShomareHesabId 
			and (fldDocument_HedearId1=h1.fldId
			 or (not exists(select * from Acc.tblDocumentRecord_Details as d2 where d2.fldDocument_HedearId1=h1.fldId ) and fldDocument_HedearId1 is null )) 
			and not exists (select * from acc.tblArtiklMap as a 
							cross apply(select * from com.Split(a.fldSourceId,','))s
							inner join acc.tblCase as c on a.fldType=c.fldCaseTypeId and  c.fldSourceId=s.Item 
							where tblCase.fldId=c.fldId)
			
			group by fldCaseTypeId,fldSourceId,h.fldOrganId,c.fldCode,c.fldTitle,e.fldAshakhasID,fldModuleErsalId,e.fldId,cc.fldName)t)t
			
			where fldMande<>0

			if (@fieldName='Check_Sadere')
select * from (
select *,abs(fldBedehkar-fldBestankar) as fldMande from (
SELECT   fldSourceId as fldSerialFish,sum([fldBedehkar]) fldBedehkar, sum([fldBestankar])fldBestankar,0 as fldElamAvarezId,0 as fldPardakhtFileId,N'' asfldDateSendFile
			,isnull([ACC].[fn_GetParvandeName](fldCaseTypeId,fldSourceId,h.fldOrganId),'')as  fldName,fldModuleErsalId
			,c.fldCode,c.fldTitle as fldNameCoding,Com.fn_NameAshkhasHaghighi_Hoghoghi(s.fldAshkhasId) as fldNameShakhs
			,cc.fldName fldCaseTypeName
			FROM   [ACC].[tblDocumentRecord_Details] inner join 
			acc.tblDocumentRecord_Header as h on h.fldId=[tblDocumentRecord_Details].fldDocument_HedearId inner join 
			acc.tblDocumentRecord_Header1 as h1 on h1.fldDocument_HedearId=h.fldId inner join 
			[ACC].tblCase	on tblCase.fldId=tblDocumentRecord_Details.fldCaseId inner join 
			acc.tblCaseType cc on cc.fldid=tblCase.fldCaseTypeId inner join 
			acc.tblCoding_Details c on c.fldid=fldCodingId inner join 
			acc.tblTemplateCoding as t on t.fldId=c.fldTempCodingId inner join 
			chk.tblSodorCheck as s on s.fldId=tblCase.fldSourceId  
			
			WHERE  fldFiscalYearId=@FiscalYearId and fldCaseTypeId=4 and fldItemId=46 
			and h1.fldDocumentNum>0 --and s.fldTypeSanad=0
			--and fldShomareHesabId=@ShomareHesabId 
			and (fldDocument_HedearId1=h1.fldId
			 or (not exists(select * from Acc.tblDocumentRecord_Details as d2 where d2.fldDocument_HedearId1=h1.fldId ) and fldDocument_HedearId1 is null )) 
			and not exists (select * from acc.tblArtiklMap as a 
							cross apply(select * from com.Split(a.fldSourceId,','))s
							inner join acc.tblCase as c on a.fldType=c.fldCaseTypeId and  c.fldSourceId=s.Item 
							where tblCase.fldId=c.fldId)
			
			group by fldCaseTypeId,fldSourceId,h.fldOrganId,c.fldCode,c.fldTitle,s.fldAshkhasId,fldModuleErsalId,cc.fldName)t)t
			
			where fldMande<>0
commit tran
GO
