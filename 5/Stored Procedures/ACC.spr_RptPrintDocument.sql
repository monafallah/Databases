SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE proc [ACC].[spr_RptPrintDocument]
@DocumentHedearId int
as
begin tran
--declare @DocumentHedearId int=47
	declare @Setting varchar(10)='false',@Document_HedearId int=0,@Organ int=0

	select @Document_HedearId=h1.fldDocument_HedearId,@Organ=h.fldOrganId from acc.tblDocumentRecord_Header  as h
	inner join acc.tblDocumentRecord_Header1 as h1 on h1.fldDocument_HedearId=h.fldid
	where h1.fldId=@DocumentHedearId

	select @Setting=case when fldValue=1 then 'true' else 'false' end from com.tblGeneralSetting_Value  
	where fldGeneralSettingId=3 and fldOrganId=@Organ 

	

	
	select *,case when  bed_sum-bes_sum=0 then 1 else 0 end fldType from(
	select * 
	,sum(fldBedehkar) over(order by /*fldOrders,*/fldDate,fldId) as bed_sum,sum(fldBestankarInt)  over(order by /*fldOrders,*/fldDate,fldId) as bes_sum
	from(
	select fldDocumentNum,fldAtfNum,fldArchiveNum,fldShomareFaree,fldTarikhDocument,fldTypeName,fldDescriptionDocu,fldTypeSanadName,fldCode,fldDescriptionCoding,fldMablaghJoz
	,fldBedehkar,replace(convert(varchar,cast(fldBestankar as money),1), '.00','') as fldBestankar
	,fldNameParvande,case when t.fldBestankar>0 then  CHAR(9) +t.fldDescription else t.fldDescription end  as fldDescription,isnull(m.fldTitle,'') as fldModuleErsalName
	,fldBestankar as fldBestankarInt,t.fldorder,fldOrders,t.fldDate,t.fldId
	from 
	(
	select  h1.fldDocumentNum,a.atf as fldAtfNum,isnull(h1.fldArchiveNum,'') as fldArchiveNum,isnull((cast(h1.fldShomareFaree as varchar(100))),'') as fldShomareFaree
	,h1.fldModuleErsalId
	,h1.fldTarikhDocument,case when fldType=1 and fldaccept=1 then N'قطعی' when fldType=1 and fldaccept=0 then N'موقت' end as fldTypeName,
	h.fldDescriptionDocu,dt.fldName as fldTypeSanadName, cd.fldCode,
	case when @Setting='true' then cp.fldTileParent else cd.fldTitle end as fldDescriptionCoding,0 as fldMablaghJoz,d.fldBedehkar
	,d.fldBestankar  as fldBestankar
	--,e.fldName+'_'+e.fldFamily+'('+ed.fldFatherName+')' as fldNameParvande
	,[ACC].[fn_GetParvandeName](c.fldCaseTypeId,c.fldSourceId,h.fldOrganId)as fldNameParvande
	,d.fldDescription,d.fldorder,case when d.fldBedehkar<>0 then 1 else 2 end as fldOrders,d.fldDate,d.fldId
	from acc.tblDocumentRecord_Header as h
	inner join acc.tblDocumentRecord_Header1 as h1 on h1.fldDocument_HedearId=h.fldid
	inner join acc.tblDocumentType dt on dt.fldid=fldTypeSanadId
	inner join acc.tblDocumentRecord_Details as d on d.fldDocument_HedearId=h.fldId
	inner join acc.tblCoding_Details as cd on cd.fldId=d.fldCodingId
	left join acc.tblCase as c on c.fldId=d.fldCaseId
	--inner join Com.tblEmployee as e on e.fldId=c.fldSourceId
	--inner join com.tblEmployee_Detail as ed on ed.fldEmployeeId=e.fldId
	cross apply(select stuff((select N' ـ ' +p.fldTitle  from ACC.tblCoding_Details as p
						inner join ACC.tblCoding_Details as child on child.fldId=cd.fldId 
						where child.fldCodeId.IsDescendantOf(p.fldCodeId)=1  and child.fldHeaderCodId=p.fldHeaderCodId for xml path('')),1,2,'') as fldTileParent ) cp

	outer Apply(
				select atf from (select row_number()over (order by h12.fldId) atf,h12.fldid   
				from acc.tblDocumentRecord_Header h2
				inner join acc.tblDocumentRecord_Header1 as h12 on h12.fldDocument_HedearId=h2.fldid
				where h2.fldOrganId=h.fldOrganId and h2.fldYear=h.fldYear 
					and h12.fldModuleSaveId=h1.fldModuleSaveId and h12.fldDocumentNum <>0
					)t where t.fldId=h1.fldid)a
	where   h1.fldId=@DocumentHedearId 
	and (d.fldDocument_HedearId1=@DocumentHedearId or 
	(not exists(select * from Acc.tblDocumentRecord_Details as d2 where d2.fldDocument_HedearId1=@DocumentHedearId )  and d.fldDocument_HedearId=@Document_HedearId and d.fldDocument_HedearId1 is null)) 
	/*and c.fldCaseTypeId=1 
	union all
	select h1.fldDocumentNum,aa.atf as fldAtfNum,isnull(h1.fldArchiveNum,'') as fldArchiveNum,isnull((cast(h1.fldShomareFaree as varchar(100))),'') as fldShomareFaree,h1.fldModuleErsalId
	,h1.fldTarikhDocument,case when fldType=1 and fldaccept=1 then N'قطعی' when fldType=1 and fldaccept=0 then N'موقت' end as fldTypeName,
	h.fldDescriptionDocu,dt.fldName as fldTypeSanadName,cd.fldCode,
	case when @Setting='true' then cp.fldTileParent else cd.fldTitle end as fldDescriptionCoding,0 as fldMablaghJoz,d.fldBedehkar,d.fldBestankar 
	,a.fldName as fldNameParvande,d.fldDescription,d.fldorder,case when d.fldBedehkar<>0 then 1 else 2 end as fldOrders,d.fldDate,d.fldId
	from acc.tblDocumentRecord_Header as h
	inner join acc.tblDocumentRecord_Header1 as h1 on h1.fldDocument_HedearId=h.fldid
	inner join acc.tblDocumentType dt on dt.fldid=fldTypeSanadId
	inner join acc.tblDocumentRecord_Details as d on d.fldDocument_HedearId=h.fldId
	inner join acc.tblCoding_Details as cd on cd.fldId=d.fldCodingId
	inner join acc.tblCase as c on c.fldId=d.fldCaseId
	inner join Com.tblAshkhaseHoghoghi as a on a.fldId=c.fldSourceId
	cross apply(select stuff((select N' ـ ' +p.fldTitle  from ACC.tblCoding_Details as p
						inner join ACC.tblCoding_Details as child on child.fldId=cd.fldId 
						where child.fldCodeId.IsDescendantOf(p.fldCodeId)=1  and child.fldHeaderCodId=p.fldHeaderCodId for xml path('')),1,2,'') as fldTileParent ) cp
	
	outer Apply(
				select atf from (select row_number()over (order by h12.fldId) atf,h12.fldid   
				from acc.tblDocumentRecord_Header h2
				inner join acc.tblDocumentRecord_Header1 as h12 on h12.fldDocument_HedearId=h2.fldid
				where h2.fldOrganId=h.fldOrganId and h2.fldYear=h.fldYear 
					and h12.fldModuleSaveId=h1.fldModuleSaveId and h12.fldDocumentNum <>0
					)t where t.fldId=h1.fldid)aa
	where  h1.fldId=@DocumentHedearId 
		and (d.fldDocument_HedearId1=@DocumentHedearId 
		or (not exists(select * from Acc.tblDocumentRecord_Details as d2 where d2.fldDocument_HedearId1=@DocumentHedearId )  and d.fldDocument_HedearId=@Document_HedearId and d.fldDocument_HedearId1 is null))  
	and c.fldCaseTypeId=2 
	union all
	select h1.fldDocumentNum,a.atf as fldAtfNum,isnull(h1.fldArchiveNum,'') as fldArchiveNum,isnull((cast(h1.fldShomareFaree as varchar(100))),'') as fldShomareFaree,h1.fldModuleErsalId
	,h1.fldTarikhDocument,case when fldType=1 and fldaccept=1 then N'قطعی' when fldType=1 and fldaccept=0 then N'موقت' end as fldTypeName,
	h.fldDescriptionDocu,dt.fldName as fldTypeSanadName,cd.fldCode,
	case when @Setting='true' then cp.fldTileParent else cd.fldTitle end as fldDescriptionCoding,0 as fldMablaghJoz,d.fldBedehkar,d.fldBestankar 
	,r.fldSubject as fldNameParvande,d.fldDescription,d.fldorder,case when d.fldBedehkar<>0 then 1 else 2 end as fldOrders,d.fldDate,d.fldId
	from acc.tblDocumentRecord_Header as h
	inner join acc.tblDocumentRecord_Header1 as h1 on h1.fldDocument_HedearId=h.fldid
	inner join acc.tblDocumentType dt on dt.fldid=fldTypeSanadId
	inner join acc.tblDocumentRecord_Details as d on d.fldDocument_HedearId=h.fldId
	inner join acc.tblCoding_Details as cd on cd.fldId=d.fldCodingId
	inner join acc.tblCase as c on c.fldId=d.fldCaseId
	inner join Cntr.tblContracts as r on r.fldId=c.fldSourceId
	cross apply(select stuff((select N' ـ ' +p.fldTitle  from ACC.tblCoding_Details as p
						inner join ACC.tblCoding_Details as child on child.fldId=cd.fldId 
						where child.fldCodeId.IsDescendantOf(p.fldCodeId)=1  and child.fldHeaderCodId=p.fldHeaderCodId for xml path('')),1,2,'') as fldTileParent ) cp

	outer Apply(
				select atf from (select row_number()over (order by h12.fldId) atf,h12.fldid   
				from acc.tblDocumentRecord_Header h2
				inner join acc.tblDocumentRecord_Header1 as h12 on h12.fldDocument_HedearId=h2.fldid
				where h2.fldOrganId=h.fldOrganId and h2.fldYear=h.fldYear 
					and h12.fldModuleSaveId=h1.fldModuleSaveId and h12.fldDocumentNum <>0
					)t where t.fldId=h1.fldid)a
	where  h1.fldId=@DocumentHedearId 
		and (d.fldDocument_HedearId1=@DocumentHedearId 
		or (not exists(select * from Acc.tblDocumentRecord_Details as d2 where d2.fldDocument_HedearId1=@DocumentHedearId )  and d.fldDocument_HedearId=@Document_HedearId and d.fldDocument_HedearId1 is null)) 
	and c.fldCaseTypeId in (13,14)

	union all
	select h1.fldDocumentNum,a.atf as fldAtfNum,isnull(h1.fldArchiveNum,'') as fldArchiveNum,isnull((cast(h1.fldShomareFaree as varchar(100))),'') as fldShomareFaree,h1.fldModuleErsalId
	,h1.fldTarikhDocument,case when fldType=1 and fldaccept=1 then N'قطعی' when fldType=1 and fldaccept=0 then N'موقت' end as fldTypeName,
	h.fldDescriptionDocu,dt.fldName as fldTypeSanadName,cd.fldCode,
	case when @Setting='true' then cp.fldTileParent else cd.fldTitle end as fldDescriptionCoding,0 as fldMablaghJoz,d.fldBedehkar,d.fldBestankar 
	,fldShenaseKamelCheck+'('+fldBabat+')'  as fldNameParvande,d.fldDescription,d.fldorder,case when d.fldBedehkar<>0 then 1 else 2 end as fldOrders,d.fldDate,d.fldId
	from acc.tblDocumentRecord_Header as h
	inner join acc.tblDocumentRecord_Header1 as h1 on h1.fldDocument_HedearId=h.fldid
	inner join acc.tblDocumentType dt on dt.fldid=fldTypeSanadId
	inner join acc.tblDocumentRecord_Details as d on d.fldDocument_HedearId=h.fldId
	inner join acc.tblCoding_Details as cd on cd.fldId=d.fldCodingId
	inner join acc.tblCase as c on c.fldId=d.fldCaseId
	inner join chk.tblCheckHayeVarede as r on r.fldId=c.fldSourceId
	cross apply(select stuff((select N' ـ ' +p.fldTitle  from ACC.tblCoding_Details as p
						inner join ACC.tblCoding_Details as child on child.fldId=cd.fldId 
						where child.fldCodeId.IsDescendantOf(p.fldCodeId)=1  and child.fldHeaderCodId=p.fldHeaderCodId for xml path('')),1,2,'') as fldTileParent ) cp

	outer Apply(
				select atf from (select row_number()over (order by h12.fldId) atf,h12.fldid   
				from acc.tblDocumentRecord_Header h2
				inner join acc.tblDocumentRecord_Header1 as h12 on h12.fldDocument_HedearId=h2.fldid
				where h2.fldOrganId=h.fldOrganId and h2.fldYear=h.fldYear 
					and h12.fldModuleSaveId=h1.fldModuleSaveId and h12.fldDocumentNum <>0
					)t where t.fldId=h1.fldid)a
	where  h1.fldId=@DocumentHedearId 
		and (d.fldDocument_HedearId1=@DocumentHedearId 
		or (not exists(select * from Acc.tblDocumentRecord_Details as d2 where d2.fldDocument_HedearId1=@DocumentHedearId )  and d.fldDocument_HedearId=@Document_HedearId and d.fldDocument_HedearId1 is null)) 
	and c.fldCaseTypeId =3

	union all
	select h1.fldDocumentNum,a.atf as fldAtfNum,isnull(h1.fldArchiveNum,'') as fldArchiveNum,isnull((cast(h1.fldShomareFaree as varchar(100))),'') as fldShomareFaree,h1.fldModuleErsalId
	,h1.fldTarikhDocument,case when fldType=1 and fldaccept=1 then N'قطعی' when fldType=1 and fldaccept=0 then N'موقت' end as fldTypeName,
	h.fldDescriptionDocu,dt.fldName as fldTypeSanadName,cd.fldCode,
	case when @Setting='true' then cp.fldTileParent else cd.fldTitle end as fldDescriptionCoding,0 as fldMablaghJoz,d.fldBedehkar,d.fldBestankar 
	,fldShomareSanad+'('+fldBabat+')'  as fldNameParvande,d.fldDescription,d.fldorder,case when d.fldBedehkar<>0 then 1 else 2 end as fldOrders,d.fldDate,d.fldId
	from acc.tblDocumentRecord_Header as h
	inner join acc.tblDocumentRecord_Header1 as h1 on h1.fldDocument_HedearId=h.fldid
	inner join acc.tblDocumentType dt on dt.fldid=fldTypeSanadId
	inner join acc.tblDocumentRecord_Details as d on d.fldDocument_HedearId=h.fldId
	inner join acc.tblCoding_Details as cd on cd.fldId=d.fldCodingId
	inner join acc.tblCase as c on c.fldId=d.fldCaseId
	inner join drd.tblCheck as r on r.fldId=c.fldSourceId
	cross apply(select stuff((select N' ـ ' +p.fldTitle  from ACC.tblCoding_Details as p
						inner join ACC.tblCoding_Details as child on child.fldId=cd.fldId 
						where child.fldCodeId.IsDescendantOf(p.fldCodeId)=1  and child.fldHeaderCodId=p.fldHeaderCodId for xml path('')),1,2,'') as fldTileParent ) cp

	outer Apply(
				select atf from (select row_number()over (order by h12.fldId) atf,h12.fldid   
				from acc.tblDocumentRecord_Header h2
				inner join acc.tblDocumentRecord_Header1 as h12 on h12.fldDocument_HedearId=h2.fldid
				where h2.fldOrganId=h.fldOrganId and h2.fldYear=h.fldYear 
					and h12.fldModuleSaveId=h1.fldModuleSaveId and h12.fldDocumentNum <>0
					)t where t.fldId=h1.fldid)a
	where  h1.fldId=@DocumentHedearId 
		and (d.fldDocument_HedearId1=@DocumentHedearId 
		or (not exists(select * from Acc.tblDocumentRecord_Details as d2 where d2.fldDocument_HedearId1=@DocumentHedearId )  and d.fldDocument_HedearId=@Document_HedearId and d.fldDocument_HedearId1 is null)) 
	and c.fldCaseTypeId =4 and fldReplyTaghsitId is null

	union all
	select h1.fldDocumentNum,a.atf as fldAtfNum,isnull(h1.fldArchiveNum,'') as fldArchiveNum,isnull((cast(h1.fldShomareFaree as varchar(100))),'') as fldShomareFaree,h1.fldModuleErsalId
	,h1.fldTarikhDocument,case when h.fldType=1 and fldaccept=1 then N'قطعی' when h.fldType=1 and fldaccept=0 then N'موقت' end as fldTypeName,
	h.fldDescriptionDocu,dt.fldName as fldTypeSanadName,cd.fldCode,
	case when @Setting='true' then cp.fldTileParent else cd.fldTitle end as fldDescriptionCoding,0 as fldMablaghJoz,d.fldBedehkar,d.fldBestankar 
	,cast(c.fldid as varchar(30))+'_'+Nameshakhs.fldName+'('+Nameshakhs.fldCodemeli+')'  as fldNameParvande,d.fldDescription,d.fldorder,case when d.fldBedehkar<>0 then 1 else 2 end as fldOrders,d.fldDate,d.fldId
	from acc.tblDocumentRecord_Header as h
	inner join acc.tblDocumentRecord_Header1 as h1 on h1.fldDocument_HedearId=h.fldid
	inner join acc.tblDocumentType dt on dt.fldid=fldTypeSanadId
	inner join acc.tblDocumentRecord_Details as d on d.fldDocument_HedearId=h.fldId
	inner join acc.tblCoding_Details as cd on cd.fldId=d.fldCodingId
	inner join acc.tblCase as c on c.fldId=d.fldCaseId
	inner join drd.tblSodoorFish as r on r.fldId=c.fldSourceId
	inner join drd.tblElamAvarez e on e.fldid=fldElamAvarezId
	cross apply (
					select fldName collate SQL_Latin1_General_CP1_CI_AS +' '+fldFamily collate SQL_Latin1_General_CP1_CI_AS as fldName,isnull(fldCodemeli,fldCodeMoshakhase) as fldCodemeli from com.tblAshkhas a inner join com.tblEmployee e 
					on e.fldid=fldHaghighiId
					where a.fldid=fldAshakhasID
					union all
					select fldName,fldShenaseMelli as fldCodeMeli from com.tblAshkhas a inner join com.tblAshkhaseHoghoghi h 
					on h.fldid=fldHoghoghiId
					where a.fldid=fldAshakhasID
				)Nameshakhs
	cross apply(select stuff((select N' ـ ' +p.fldTitle  from ACC.tblCoding_Details as p
						inner join ACC.tblCoding_Details as child on child.fldId=cd.fldId 
						where child.fldCodeId.IsDescendantOf(p.fldCodeId)=1  and child.fldHeaderCodId=p.fldHeaderCodId for xml path('')),1,2,'') as fldTileParent ) cp

	outer Apply(
				select atf from (select row_number()over (order by h12.fldId) atf,h12.fldid   
				from acc.tblDocumentRecord_Header h2
				inner join acc.tblDocumentRecord_Header1 as h12 on h12.fldDocument_HedearId=h2.fldid
				where h2.fldOrganId=h.fldOrganId and h2.fldYear=h.fldYear 
					and h12.fldModuleSaveId=h1.fldModuleSaveId and h12.fldDocumentNum <>0
					)t where t.fldId=h1.fldid)a
	where  h1.fldId=@DocumentHedearId 
		and (d.fldDocument_HedearId1=@DocumentHedearId 
		or (not exists(select * from Acc.tblDocumentRecord_Details as d2 where d2.fldDocument_HedearId1=@DocumentHedearId )  and d.fldDocument_HedearId=@Document_HedearId and d.fldDocument_HedearId1 is null)) 
	and c.fldCaseTypeId =6 and not exists (select * from drd.tblEbtal where fldFishId=r.fldid) 


	union all
	select h1.fldDocumentNum,a.atf as fldAtfNum,isnull(h1.fldArchiveNum,'') as fldArchiveNum,isnull((cast(h1.fldShomareFaree as varchar(100))),'') as fldShomareFaree,h1.fldModuleErsalId
	,h1.fldTarikhDocument,case when h.fldType=1 and fldaccept=1 then N'قطعی' when h.fldType=1 and fldaccept=0 then N'موقت' end as fldTypeName,
	h.fldDescriptionDocu,dt.fldName as fldTypeSanadName,cd.fldCode,
	case when @Setting='true' then cp.fldTileParent else cd.fldTitle end as fldDescriptionCoding,0 as fldMablaghJoz,d.fldBedehkar,d.fldBestankar 
	,r.fldTitle  as fldNameParvande,d.fldDescription,d.fldorder,case when d.fldBedehkar<>0 then 1 else 2 end as fldOrders,d.fldDate,d.fldId
	from acc.tblDocumentRecord_Header as h
	inner join acc.tblDocumentRecord_Header1 as h1 on h1.fldDocument_HedearId=h.fldid
	inner join acc.tblDocumentType dt on dt.fldid=fldTypeSanadId
	inner join acc.tblDocumentRecord_Details as d on d.fldDocument_HedearId=h.fldId
	inner join acc.tblCoding_Details as cd on cd.fldId=d.fldCodingId
	inner join acc.tblCase as c on c.fldId=d.fldCaseId
	inner join bud.tblCodingBudje_Details as r on r.fldCodeingBudjeId=c.fldSourceId
	cross apply(select stuff((select N' ـ ' +p.fldTitle  from ACC.tblCoding_Details as p
						inner join ACC.tblCoding_Details as child on child.fldId=cd.fldId 
						where child.fldCodeId.IsDescendantOf(p.fldCodeId)=1  and child.fldHeaderCodId=p.fldHeaderCodId for xml path('')),1,2,'') as fldTileParent ) cp

	outer Apply(
				select atf from (select row_number()over (order by h12.fldId) atf,h12.fldid   
				from acc.tblDocumentRecord_Header h2
				inner join acc.tblDocumentRecord_Header1 as h12 on h12.fldDocument_HedearId=h2.fldid
				where h2.fldOrganId=h.fldOrganId and h2.fldYear=h.fldYear 
					and h12.fldModuleSaveId=h1.fldModuleSaveId and h12.fldDocumentNum <>0
					)t where t.fldId=h1.fldid)a
	where  h1.fldId=@DocumentHedearId 
		and (d.fldDocument_HedearId1=@DocumentHedearId 
		or (not exists(select * from Acc.tblDocumentRecord_Details as d2 where d2.fldDocument_HedearId1=@DocumentHedearId )  and d.fldDocument_HedearId=@Document_HedearId and d.fldDocument_HedearId1 is null)) 
	and c.fldCaseTypeId =15  and r.fldLevelId=4 and r.fldTarh_KhedmatTypeId=1

	union all
	select h1.fldDocumentNum,a.atf as fldAtfNum,isnull(h1.fldArchiveNum,'') as fldArchiveNum,isnull((cast(h1.fldShomareFaree as varchar(100))),'') as fldShomareFaree,h1.fldModuleErsalId
	,h1.fldTarikhDocument,case when h.fldType=1 and fldaccept=1 then N'قطعی' when h.fldType=1 and fldaccept=0 then N'موقت' end as fldTypeName,
	h.fldDescriptionDocu,dt.fldName as fldTypeSanadName,cd.fldCode,
	case when @Setting='true' then cp.fldTileParent else cd.fldTitle end as fldDescriptionCoding,0 as fldMablaghJoz,d.fldBedehkar,d.fldBestankar 
	, s.fldShomareHesab+'_'+b.fldBankName+'('+sh.fldName+')'  as fldNameParvande,d.fldDescription,d.fldorder,case when d.fldBedehkar<>0 then 1 else 2 end as fldOrders,d.fldDate,d.fldId
	from acc.tblDocumentRecord_Header as h
	inner join acc.tblDocumentRecord_Header1 as h1 on h1.fldDocument_HedearId=h.fldid
	inner join acc.tblDocumentType dt on dt.fldid=fldTypeSanadId
	inner join acc.tblDocumentRecord_Details as d on d.fldDocument_HedearId=h.fldId
	inner join acc.tblCoding_Details as cd on cd.fldId=d.fldCodingId
	inner join acc.tblCase as c on c.fldId=d.fldCaseId
	inner join com.tblShomareHesabeOmoomi as s on s.fldId=c.fldSourceId
	inner join com.tblAshkhas a1 on s.fldAshkhasId=a1.fldId
	inner join com.tblOrganization o on o.fldAshkhaseHoghoghiId=a1.fldHoghoghiId
	inner join com.tblAshkhaseHoghoghi ho on ho.fldid=fldAshkhaseHoghoghiId
	inner join com.tblSHobe sh on sh.fldid=fldShobeId
	inner join com.tblBank b on b.fldid=sh.fldBankId
	cross apply(select stuff((select N' ـ ' +p.fldTitle  from ACC.tblCoding_Details as p
						inner join ACC.tblCoding_Details as child on child.fldId=cd.fldId 
						where child.fldCodeId.IsDescendantOf(p.fldCodeId)=1  and child.fldHeaderCodId=p.fldHeaderCodId for xml path('')),1,2,'') as fldTileParent ) cp

	outer Apply(
				select atf from (select row_number()over (order by h12.fldId) atf,h12.fldid   
				from acc.tblDocumentRecord_Header h2
				inner join acc.tblDocumentRecord_Header1 as h12 on h12.fldDocument_HedearId=h2.fldid
				where h2.fldOrganId=h.fldOrganId and h2.fldYear=h.fldYear 
					and h12.fldModuleSaveId=h1.fldModuleSaveId and h12.fldDocumentNum <>0
					)t where t.fldId=h1.fldid)a
	where  h1.fldId=@DocumentHedearId 
		and (d.fldDocument_HedearId1=@DocumentHedearId 
		or (not exists(select * from Acc.tblDocumentRecord_Details as d2 where d2.fldDocument_HedearId1=@DocumentHedearId )  and d.fldDocument_HedearId=@Document_HedearId and d.fldDocument_HedearId1 is null)) 
	and c.fldCaseTypeId =5  and o.fldid=@Organ*/

	) t
	left join com.tblModule as m on m.fldId=t.fldModuleErsalId
	/*union all
	select h1.fldDocumentNum,a.atf as fldAtfNum,isnull(h1.fldArchiveNum,'') as fldArchiveNum,isnull((cast(h1.fldShomareFaree as varchar(100))),'') as fldShomareFaree
	,h1.fldTarikhDocument,case when fldType=1 and fldaccept=1 then N'قطعی' when fldType=1 and fldaccept=0 then N'موقت' end as fldTypeName,
	h.fldDescriptionDocu,dt.fldName as fldTypeSanadName,cd.fldCode,
	case when @Setting='true' then cp.fldTileParent else cd.fldTitle end as fldDescriptionCoding,0 as fldMablaghJoz,d.fldBedehkar
	,replace(convert(varchar,cast(fldBestankar as money),1), '.00','')as fldBestankar
	,N'' as fldNameParvande
	,case when d.fldBestankar>0 then  CHAR(9) +d.fldDescription else d.fldDescription end  as fldDescription,isnull(m.fldTitle,'') as fldModuleErsalName
	,fldBestankar,d.fldorder,case when d.fldBedehkar<>0 then 1 else 2 end as fldOrders,d.fldDate,d.fldId
	from acc.tblDocumentRecord_Header as h
	inner join acc.tblDocumentRecord_Header1 as h1 on h1.fldDocument_HedearId=h.fldid
	inner join acc.tblDocumentType dt on dt.fldid=fldTypeSanadId
	inner join acc.tblDocumentRecord_Details as d on d.fldDocument_HedearId=h.fldId 
	inner join acc.tblCoding_Details as cd on cd.fldId=d.fldCodingId
	cross apply(select stuff((select N' ـ ' +p.fldTitle  from ACC.tblCoding_Details as p
						inner join ACC.tblCoding_Details as child on child.fldId=cd.fldId 
						where child.fldCodeId.IsDescendantOf(p.fldCodeId)=1  and child.fldHeaderCodId=p.fldHeaderCodId for xml path('')),1,2,'') as fldTileParent ) cp
	
	outer Apply(
				select atf from (select row_number()over (order by h12.fldId) atf,h12.fldid   
				from acc.tblDocumentRecord_Header h2
				inner join acc.tblDocumentRecord_Header1 as h12 on h12.fldDocument_HedearId=h2.fldid
				where h2.fldOrganId=h.fldOrganId and h2.fldYear=h.fldYear 
					and h12.fldModuleSaveId=h1.fldModuleSaveId and h12.fldDocumentNum <>0
					)t where t.fldId=h1.fldid)a
	left join com.tblModule as m on m.fldId=h1.fldModuleErsalId
	where  h1.fldId=@DocumentHedearId 
		and (d.fldDocument_HedearId1=@DocumentHedearId 
		or (not exists(select * from Acc.tblDocumentRecord_Details as d2 where d2.fldDocument_HedearId1=@DocumentHedearId )  and d.fldDocument_HedearId=@Document_HedearId and d.fldDocument_HedearId1 is null)) 
	and d.fldCaseId is null*/
	)t2
	)t3
	order by /*fldorders,*/flddate,fldId


	
	

commit tran

GO
