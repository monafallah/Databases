SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE proc [ACC].[spr_RptPrintDocument_Group]
@FromDocumentNum int,
@ToDocumentNum int,
@Year smallint,
@OrganId int,
@ModuleSaveId int,
@Type tinyint
as
begin tran
--declare @FromDocumentNum int=1,@ToDocumentNum int=5,@Year smallint=1402,@OrganId int=1,@ModuleSaveId int=4,@Type tinyint=2
	declare @Setting varchar(10)='false'
	select @Setting=fldValue from com.tblGeneralSetting_Value  
	where fldGeneralSettingId=3 and fldOrganId=@OrganId

	select *,case when  bed_sum-bes_sum=0 then 1 else 0 end fldType from(
	select * 
	,sum(fldBedehkar) over(PARTITION BY fldId  order by /*fldOrders,*/fldId,fldDate,fldDocument_DetailsId) as bed_sum
	,sum(fldBestankarInt)  over(PARTITION BY fldId order by /*fldOrders,*/fldId,fldDate,fldDocument_DetailsId) as bes_sum
	from(
	select t.fldId,fldDocumentNum,fldAtfNum,fldArchiveNum,fldShomareFaree,fldTarikhDocument,fldTypeName,fldDescriptionDocu,fldTypeSanadName
	,fldCode,fldDescriptionCoding,fldMablaghJoz	,fldBedehkar
	,replace(convert(varchar,cast(fldBestankar as money),1), '.00','') as fldBestankar
	,fldNameParvande,case when t.fldBestankar>0 then  CHAR(9) +t.fldDescription else t.fldDescription end  as fldDescription,isnull(m.fldTitle,'') as fldModuleErsalName
	,fldBestankar as fldBestankarInt,t.fldorder,fldOrders,t.fldDate,t.fldDocument_DetailsId,t.fldTypeSanadName_Pid
	from 
	(
/*tblEmployee*/ select h.fldId,h1.fldDocumentNum,a.atf as fldAtfNum,isnull(h1.fldArchiveNum,'') as fldArchiveNum,isnull((cast(h1.fldShomareFaree as varchar(100))),'') as fldShomareFaree
	,h1.fldModuleErsalId
	,h1.fldTarikhDocument,case when fldType=1 and fldaccept=1 then N'قطعی' when fldType=1 and fldaccept=0 then N'موقت' end as fldTypeName,
	h.fldDescriptionDocu,dt.fldName as fldTypeSanadName, cd.fldCode,
	case when @Setting='true' then cp.fldTileParent else cd.fldTitle end as fldDescriptionCoding,0 as fldMablaghJoz,d.fldBedehkar
	,d.fldBestankar  as fldBestankar
	--,e.fldName+'_'+e.fldFamily+'('+ed.fldFatherName+')' as fldNameParvande
	,[ACC].[fn_GetParvandeName](c.fldCaseTypeId,c.fldSourceId,@OrganId) as fldNameParvande
	,d.fldDescription,d.fldorder,case when d.fldBedehkar<>0 then 1 else 2 end as fldOrders,d.fldDate,d.fldId as fldDocument_DetailsId 
	,case when Typesanad.fldTypeSanadId_Pid is null then N'ارسال نشده' when Typesanad.fldTypeSanadId_Pid<>3 then N'ارسال شده' else sanadName.fldTypeSanadId_Pid end fldTypeSanadName_Pid
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
	--outer apply (select  cast(row_number()over (order by h2.fldId) as int) atf from  acc.tblDocumentRecord_Header h2 inner join acc.tblFiscalYear f
	--			on h2.fldFiscalYearId=f.fldid
	--			where  h2.fldId=h.fldId and f.fldYear=h2.fldYear and h2.fldDocumentNum <>0 and (@Type=2 or (@Type<>2 and h2.fldAccept=@Type))
	--			)a
	outer Apply(
				select atf from (select row_number()over (order by h12.fldId) atf,h12.fldid   
				from acc.tblDocumentRecord_Header h2
				inner join acc.tblDocumentRecord_Header1 as h12 on h12.fldDocument_HedearId=h2.fldid
				where h2.fldOrganId=h.fldOrganId and h2.fldYear=h.fldYear 
					and h12.fldModuleSaveId=h1.fldModuleSaveId and h12.fldDocumentNum <>0
					)t where t.fldId=h1.fldid)a
	outer apply(select top (1)  h12.fldTypeSanadId as fldTypeSanadId_Pid 
					from acc.tblDocumentRecord_Header as h2 
					inner join acc.tblDocumentRecord_Header1 as h12 on h12.fldDocument_HedearId=h2.fldid
					where h12.fldPId=h1.fldId  order by h12.fldId desc )Typesanad
	outer apply(select (select top(1)  N'مرجوع شده (مرتبه ' +cast( ROW_NUMBER() over (order by h12.fldid) as varchar(10))+')' 
				from acc.tblDocumentRecord_Header as h2 
				inner join acc.tblDocumentRecord_Header1 as h12 on h12.fldDocument_HedearId=h2.fldid
				where h12.fldPId=h1.fldId and h12.fldTypeSanadId=3 order by h12.fldid desc) as fldTypeSanadId_Pid) sanadName

	where   (d.fldDocument_HedearId1=h1.fldId or 
	(not exists(select * from Acc.tblDocumentRecord_Details as d2 where d2.fldDocument_HedearId1=h1.fldId )   and d.fldDocument_HedearId1 is null)) 
	and h.fldYear=@Year and h.fldOrganId=@OrganId and h1.fldModuleSaveId=@ModuleSaveId and h1.fldDocumentNum between @FromDocumentNum and @ToDocumentNum --and c.fldCaseTypeId=1 
	 and (@Type=2 or (@Type<>2 and h1.fldAccept=@Type))
	/*union all
/*tblAshkhaseHoghoghi*/	select  h.fldId,h1.fldDocumentNum,aa.atf as fldAtfNum,isnull(h1.fldArchiveNum,'') as fldArchiveNum,isnull((cast(h1.fldShomareFaree as varchar(100))),'') as fldShomareFaree,h1.fldModuleErsalId
	,h1.fldTarikhDocument,case when fldType=1 and fldaccept=1 then N'قطعی' when fldType=1 and fldaccept=0 then N'موقت' end as fldTypeName,
	h.fldDescriptionDocu,dt.fldName as fldTypeSanadName,cd.fldCode,
	case when @Setting='true' then cp.fldTileParent else cd.fldTitle end as fldDescriptionCoding,0 as fldMablaghJoz,d.fldBedehkar,d.fldBestankar 
	,a.fldName as fldNameParvande,d.fldDescription,d.fldorder,case when d.fldBedehkar<>0 then 1 else 2 end as fldOrders,d.fldDate,d.fldId as fldDocument_DetailsId 
	,case when Typesanad.fldTypeSanadId_Pid is null then N'ارسال نشده' when Typesanad.fldTypeSanadId_Pid<>3 then N'ارسال شده' else sanadName.fldTypeSanadId_Pid end fldTypeSanadName_Pid
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
	--outer apply (select  cast(row_number()over (order by h2.fldId) as int) atf from  acc.tblDocumentRecord_Header h2 inner join acc.tblFiscalYear f
	--			on h2.fldFiscalYearId=f.fldid
	--			where  h2.fldId=h.fldId and f.fldYear=h2.fldYear and h2.fldDocumentNum <>0 and (@Type=2 or (@Type<>2 and h2.fldAccept=@Type))
	--			)aa
	outer Apply(
				select atf from (select row_number()over (order by h12.fldId) atf,h12.fldid   
				from acc.tblDocumentRecord_Header h2
				inner join acc.tblDocumentRecord_Header1 as h12 on h12.fldDocument_HedearId=h2.fldid
				where h2.fldOrganId=h.fldOrganId and h2.fldYear=h.fldYear 
					and h12.fldModuleSaveId=h1.fldModuleSaveId and h12.fldDocumentNum <>0
					)t where t.fldId=h1.fldid)aa
	outer apply(select top (1)  h12.fldTypeSanadId as fldTypeSanadId_Pid 
					from acc.tblDocumentRecord_Header as h2 
					inner join acc.tblDocumentRecord_Header1 as h12 on h12.fldDocument_HedearId=h2.fldid
					where h12.fldPId=h1.fldId  order by h12.fldId desc )Typesanad
	outer apply(select (select top(1)  N'مرجوع شده (مرتبه ' +cast( ROW_NUMBER() over (order by h12.fldid) as varchar(10))+')' 
				from acc.tblDocumentRecord_Header as h2 
				inner join acc.tblDocumentRecord_Header1 as h12 on h12.fldDocument_HedearId=h2.fldid
				where h12.fldPId=h1.fldId and h12.fldTypeSanadId=3 order by h12.fldid desc) as fldTypeSanadId_Pid) sanadName
	where    (d.fldDocument_HedearId1=h1.fldId or 
	(not exists(select * from Acc.tblDocumentRecord_Details as d2 where d2.fldDocument_HedearId1=h1.fldId )   and d.fldDocument_HedearId1 is null)) 
	and h.fldYear=@Year and h.fldOrganId=@OrganId and h1.fldModuleSaveId=@ModuleSaveId and  h1.fldDocumentNum between @FromDocumentNum and @ToDocumentNum  and c.fldCaseTypeId=2 
	 and (@Type=2 or (@Type<>2 and h1.fldAccept=@Type))
	union all
/*tblContracts*/	select  h.fldId,h1.fldDocumentNum,a.atf as fldAtfNum,isnull(h1.fldArchiveNum,'') as fldArchiveNum,isnull((cast(h1.fldShomareFaree as varchar(100))),'') as fldShomareFaree,h1.fldModuleErsalId
	,h1.fldTarikhDocument,case when fldType=1 and fldaccept=1 then N'قطعی' when fldType=1 and fldaccept=0 then N'موقت' end as fldTypeName,
	h.fldDescriptionDocu,dt.fldName as fldTypeSanadName,cd.fldCode,
	case when @Setting='true' then cp.fldTileParent else cd.fldTitle end as fldDescriptionCoding,0 as fldMablaghJoz,d.fldBedehkar,d.fldBestankar 
	,r.fldSubject as fldNameParvande,d.fldDescription,d.fldorder,case when d.fldBedehkar<>0 then 1 else 2 end as fldOrders,d.fldDate,d.fldId as fldDocument_DetailsId 
	,case when Typesanad.fldTypeSanadId_Pid is null then N'ارسال نشده' when Typesanad.fldTypeSanadId_Pid<>3 then N'ارسال شده' else sanadName.fldTypeSanadId_Pid end fldTypeSanadName_Pid
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
	--outer apply (select  cast(row_number()over (order by h2.fldId) as int) atf from  acc.tblDocumentRecord_Header h2 inner join acc.tblFiscalYear f
	--			on h2.fldFiscalYearId=f.fldid
	--			where  h2.fldId=h.fldId and f.fldYear=h2.fldYear and h2.fldDocumentNum <>0 and (@Type=2 or (@Type<>2 and h2.fldAccept=@Type))
	--			)a
outer Apply(
				select atf from (select row_number()over (order by h12.fldId) atf,h12.fldid   
				from acc.tblDocumentRecord_Header h2
				inner join acc.tblDocumentRecord_Header1 as h12 on h12.fldDocument_HedearId=h2.fldid
				where h2.fldOrganId=h.fldOrganId and h2.fldYear=h.fldYear 
					and h12.fldModuleSaveId=h1.fldModuleSaveId and h12.fldDocumentNum <>0
					)t where t.fldId=h1.fldid)a
	outer apply(select top (1)  h12.fldTypeSanadId as fldTypeSanadId_Pid 
					from acc.tblDocumentRecord_Header as h2 
					inner join acc.tblDocumentRecord_Header1 as h12 on h12.fldDocument_HedearId=h2.fldid
					where h12.fldPId=h1.fldId  order by h12.fldId desc )Typesanad
	outer apply(select (select top(1)  N'مرجوع شده (مرتبه ' +cast( ROW_NUMBER() over (order by h12.fldid) as varchar(10))+')' 
				from acc.tblDocumentRecord_Header as h2 
				inner join acc.tblDocumentRecord_Header1 as h12 on h12.fldDocument_HedearId=h2.fldid
				where h12.fldPId=h1.fldId and h12.fldTypeSanadId=3 order by h12.fldid desc) as fldTypeSanadId_Pid) sanadName
	where   (d.fldDocument_HedearId1=h1.fldId or 
	(not exists(select * from Acc.tblDocumentRecord_Details as d2 where d2.fldDocument_HedearId1=h1.fldId )   and d.fldDocument_HedearId1 is null)) 
	and h.fldYear=@Year and h.fldOrganId=@OrganId and h1.fldModuleSaveId=@ModuleSaveId and  h1.fldDocumentNum between @FromDocumentNum and @ToDocumentNum  and c.fldCaseTypeId in (13,14)
	 and (@Type=2 or (@Type<>2 and h1.fldAccept=@Type))

	union all
/*tblCheckHayeVarede*/	select  h.fldId,h1.fldDocumentNum,a.atf as fldAtfNum,isnull(h1.fldArchiveNum,'') as fldArchiveNum,isnull((cast(h1.fldShomareFaree as varchar(100))),'') as fldShomareFaree,h1.fldModuleErsalId
	,h1.fldTarikhDocument,case when fldType=1 and fldaccept=1 then N'قطعی' when fldType=1 and fldaccept=0 then N'موقت' end as fldTypeName,
	h.fldDescriptionDocu,dt.fldName as fldTypeSanadName,cd.fldCode,
	case when @Setting='true' then cp.fldTileParent else cd.fldTitle end as fldDescriptionCoding,0 as fldMablaghJoz,d.fldBedehkar,d.fldBestankar 
	,fldShenaseKamelCheck+'('+fldBabat+')' as fldNameParvande,d.fldDescription,d.fldorder,case when d.fldBedehkar<>0 then 1 else 2 end as fldOrders,d.fldDate,d.fldId as fldDocument_DetailsId 
	,case when Typesanad.fldTypeSanadId_Pid is null then N'ارسال نشده' when Typesanad.fldTypeSanadId_Pid<>3 then N'ارسال شده' else sanadName.fldTypeSanadId_Pid end fldTypeSanadName_Pid
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
	--outer apply (select  cast(row_number()over (order by h2.fldId) as int) atf from  acc.tblDocumentRecord_Header h2 inner join acc.tblFiscalYear f
	--			on h2.fldFiscalYearId=f.fldid
	--			where  h2.fldId=h.fldId and f.fldYear=h2.fldYear and h2.fldDocumentNum <>0 and (@Type=2 or (@Type<>2 and h2.fldAccept=@Type))
	--			)a
outer Apply(
				select atf from (select row_number()over (order by h12.fldId) atf,h12.fldid   
				from acc.tblDocumentRecord_Header h2
				inner join acc.tblDocumentRecord_Header1 as h12 on h12.fldDocument_HedearId=h2.fldid
				where h2.fldOrganId=h.fldOrganId and h2.fldYear=h.fldYear 
					and h12.fldModuleSaveId=h1.fldModuleSaveId and h12.fldDocumentNum <>0
					)t where t.fldId=h1.fldid)a
	outer apply(select top (1)  h12.fldTypeSanadId as fldTypeSanadId_Pid 
					from acc.tblDocumentRecord_Header as h2 
					inner join acc.tblDocumentRecord_Header1 as h12 on h12.fldDocument_HedearId=h2.fldid
					where h12.fldPId=h1.fldId  order by h12.fldId desc )Typesanad
	outer apply(select (select top(1)  N'مرجوع شده (مرتبه ' +cast( ROW_NUMBER() over (order by h12.fldid) as varchar(10))+')' 
				from acc.tblDocumentRecord_Header as h2 
				inner join acc.tblDocumentRecord_Header1 as h12 on h12.fldDocument_HedearId=h2.fldid
				where h12.fldPId=h1.fldId and h12.fldTypeSanadId=3 order by h12.fldid desc) as fldTypeSanadId_Pid) sanadName
	where   (d.fldDocument_HedearId1=h1.fldId or 
	(not exists(select * from Acc.tblDocumentRecord_Details as d2 where d2.fldDocument_HedearId1=h1.fldId )   and d.fldDocument_HedearId1 is null)) 
	and h.fldYear=@Year and h.fldOrganId=@OrganId and h1.fldModuleSaveId=@ModuleSaveId and  h1.fldDocumentNum between @FromDocumentNum and @ToDocumentNum  and c.fldCaseTypeId=3
	 and (@Type=2 or (@Type<>2 and h1.fldAccept=@Type))
union all
/*tblCheck*/	select  h.fldId,h1.fldDocumentNum,a.atf as fldAtfNum,isnull(h1.fldArchiveNum,'') as fldArchiveNum,isnull((cast(h1.fldShomareFaree as varchar(100))),'') as fldShomareFaree,h1.fldModuleErsalId
	,h1.fldTarikhDocument,case when fldType=1 and fldaccept=1 then N'قطعی' when fldType=1 and fldaccept=0 then N'موقت' end as fldTypeName,
	h.fldDescriptionDocu,dt.fldName as fldTypeSanadName,cd.fldCode,
	case when @Setting='true' then cp.fldTileParent else cd.fldTitle end as fldDescriptionCoding,0 as fldMablaghJoz,d.fldBedehkar,d.fldBestankar 
	,r.fldShomareSanad+'('+fldBabat+')' as fldNameParvande,d.fldDescription,d.fldorder,case when d.fldBedehkar<>0 then 1 else 2 end as fldOrders,d.fldDate,d.fldId as fldDocument_DetailsId 
	,case when Typesanad.fldTypeSanadId_Pid is null then N'ارسال نشده' when Typesanad.fldTypeSanadId_Pid<>3 then N'ارسال شده' else sanadName.fldTypeSanadId_Pid end fldTypeSanadName_Pid
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
	--outer apply (select  cast(row_number()over (order by h2.fldId) as int) atf from  acc.tblDocumentRecord_Header h2 inner join acc.tblFiscalYear f
	--			on h2.fldFiscalYearId=f.fldid
	--			where  h2.fldId=h.fldId and f.fldYear=h2.fldYear and h2.fldDocumentNum <>0 and (@Type=2 or (@Type<>2 and h2.fldAccept=@Type))
	--			)a
outer Apply(
				select atf from (select row_number()over (order by h12.fldId) atf,h12.fldid   
				from acc.tblDocumentRecord_Header h2
				inner join acc.tblDocumentRecord_Header1 as h12 on h12.fldDocument_HedearId=h2.fldid
				where h2.fldOrganId=h.fldOrganId and h2.fldYear=h.fldYear 
					and h12.fldModuleSaveId=h1.fldModuleSaveId and h12.fldDocumentNum <>0
					)t where t.fldId=h1.fldid)a
	outer apply(select top (1)  h12.fldTypeSanadId as fldTypeSanadId_Pid 
					from acc.tblDocumentRecord_Header as h2 
					inner join acc.tblDocumentRecord_Header1 as h12 on h12.fldDocument_HedearId=h2.fldid
					where h12.fldPId=h1.fldId  order by h12.fldId desc )Typesanad
	outer apply(select (select top(1)  N'مرجوع شده (مرتبه ' +cast( ROW_NUMBER() over (order by h12.fldid) as varchar(10))+')' 
				from acc.tblDocumentRecord_Header as h2 
				inner join acc.tblDocumentRecord_Header1 as h12 on h12.fldDocument_HedearId=h2.fldid
				where h12.fldPId=h1.fldId and h12.fldTypeSanadId=3 order by h12.fldid desc) as fldTypeSanadId_Pid) sanadName
	where   (d.fldDocument_HedearId1=h1.fldId or 
	(not exists(select * from Acc.tblDocumentRecord_Details as d2 where d2.fldDocument_HedearId1=h1.fldId )   and d.fldDocument_HedearId1 is null)) 
	and h.fldYear=@Year and h.fldOrganId=@OrganId and h1.fldModuleSaveId=@ModuleSaveId and  h1.fldDocumentNum between @FromDocumentNum and @ToDocumentNum  and c.fldCaseTypeId=4
	 and (@Type=2 or (@Type<>2 and h1.fldAccept=@Type)) and fldReplyTaghsitId is null

	 union all
/*tblSodoorFish*/	select  h.fldId,h1.fldDocumentNum,a.atf as fldAtfNum,isnull(h1.fldArchiveNum,'') as fldArchiveNum,isnull((cast(h1.fldShomareFaree as varchar(100))),'') as fldShomareFaree,h1.fldModuleErsalId
	,h1.fldTarikhDocument,case when h.fldType=1 and fldaccept=1 then N'قطعی' when h.fldType=1 and fldaccept=0 then N'موقت' end as fldTypeName,
	h.fldDescriptionDocu,dt.fldName as fldTypeSanadName,cd.fldCode,
	case when @Setting='true' then cp.fldTileParent else cd.fldTitle end as fldDescriptionCoding,0 as fldMablaghJoz,d.fldBedehkar,d.fldBestankar 
	,cast(r.fldid as varchar(30))+'_'+Nameshakhs.fldName+'('+Nameshakhs.fldCodemeli+')' as fldNameParvande,d.fldDescription,d.fldorder,case when d.fldBedehkar<>0 then 1 else 2 end as fldOrders,d.fldDate,d.fldId as fldDocument_DetailsId 
	,case when Typesanad.fldTypeSanadId_Pid is null then N'ارسال نشده' when Typesanad.fldTypeSanadId_Pid<>3 then N'ارسال شده' else sanadName.fldTypeSanadId_Pid end fldTypeSanadName_Pid
	from acc.tblDocumentRecord_Header as h
	inner join acc.tblDocumentRecord_Header1 as h1 on h1.fldDocument_HedearId=h.fldid
	inner join acc.tblDocumentType dt on dt.fldid=fldTypeSanadId
	inner join acc.tblDocumentRecord_Details as d on d.fldDocument_HedearId=h.fldId
	inner join acc.tblCoding_Details as cd on cd.fldId=d.fldCodingId
	inner join acc.tblCase as c on c.fldId=d.fldCaseId
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
	cross apply(select stuff((select N' ـ ' +p.fldTitle  from ACC.tblCoding_Details as p
						inner join ACC.tblCoding_Details as child on child.fldId=cd.fldId 
						where child.fldCodeId.IsDescendantOf(p.fldCodeId)=1  and child.fldHeaderCodId=p.fldHeaderCodId for xml path('')),1,2,'') as fldTileParent ) cp
	--outer apply (select  cast(row_number()over (order by h2.fldId) as int) atf from  acc.tblDocumentRecord_Header h2 inner join acc.tblFiscalYear f
	--			on h2.fldFiscalYearId=f.fldid
	--			where  h2.fldId=h.fldId and f.fldYear=h2.fldYear and h2.fldDocumentNum <>0 and (@Type=2 or (@Type<>2 and h2.fldAccept=@Type))
	--			)a
outer Apply(
				select atf from (select row_number()over (order by h12.fldId) atf,h12.fldid   
				from acc.tblDocumentRecord_Header h2
				inner join acc.tblDocumentRecord_Header1 as h12 on h12.fldDocument_HedearId=h2.fldid
				where h2.fldOrganId=h.fldOrganId and h2.fldYear=h.fldYear 
					and h12.fldModuleSaveId=h1.fldModuleSaveId and h12.fldDocumentNum <>0
					)t where t.fldId=h1.fldid)a
	outer apply(select top (1)  h12.fldTypeSanadId as fldTypeSanadId_Pid 
					from acc.tblDocumentRecord_Header as h2 
					inner join acc.tblDocumentRecord_Header1 as h12 on h12.fldDocument_HedearId=h2.fldid
					where h12.fldPId=h1.fldId  order by h12.fldId desc )Typesanad
	outer apply(select (select top(1)  N'مرجوع شده (مرتبه ' +cast( ROW_NUMBER() over (order by h12.fldid) as varchar(10))+')' 
				from acc.tblDocumentRecord_Header as h2 
				inner join acc.tblDocumentRecord_Header1 as h12 on h12.fldDocument_HedearId=h2.fldid
				where h12.fldPId=h1.fldId and h12.fldTypeSanadId=3 order by h12.fldid desc) as fldTypeSanadId_Pid) sanadName
	where   (d.fldDocument_HedearId1=h1.fldId or 
	(not exists(select * from Acc.tblDocumentRecord_Details as d2 where d2.fldDocument_HedearId1=h1.fldId )   and d.fldDocument_HedearId1 is null)) 
	and h.fldYear=@Year and h.fldOrganId=@OrganId and h1.fldModuleSaveId=@ModuleSaveId and  h1.fldDocumentNum between @FromDocumentNum and @ToDocumentNum  and c.fldCaseTypeId=6
	 and (@Type=2 or (@Type<>2 and h1.fldAccept=@Type))  and not exists (select * from drd.tblEbtal where fldFishId=r.fldid)

union all
/*tblProject_Faaliyat*/	select  h.fldId,h1.fldDocumentNum,a.atf as fldAtfNum,isnull(h1.fldArchiveNum,'') as fldArchiveNum,isnull((cast(h1.fldShomareFaree as varchar(100))),'') as fldShomareFaree,h1.fldModuleErsalId
	,h1.fldTarikhDocument,case when h.fldType=1 and fldaccept=1 then N'قطعی' when h.fldType=1 and fldaccept=0 then N'موقت' end as fldTypeName,
	h.fldDescriptionDocu,dt.fldName as fldTypeSanadName,cd.fldCode,
	case when @Setting='true' then cp.fldTileParent else cd.fldTitle end as fldDescriptionCoding,0 as fldMablaghJoz,d.fldBedehkar,d.fldBestankar 
	,p.fldTitle as fldNameParvande,d.fldDescription,d.fldorder,case when d.fldBedehkar<>0 then 1 else 2 end as fldOrders,d.fldDate,d.fldId as fldDocument_DetailsId 
	,case when Typesanad.fldTypeSanadId_Pid is null then N'ارسال نشده' when Typesanad.fldTypeSanadId_Pid<>3 then N'ارسال شده' else sanadName.fldTypeSanadId_Pid end fldTypeSanadName_Pid
	from acc.tblDocumentRecord_Header as h
	inner join acc.tblDocumentRecord_Header1 as h1 on h1.fldDocument_HedearId=h.fldid
	inner join acc.tblDocumentType dt on dt.fldid=fldTypeSanadId
	inner join acc.tblDocumentRecord_Details as d on d.fldDocument_HedearId=h.fldId
	inner join acc.tblCoding_Details as cd on cd.fldId=d.fldCodingId
	inner join acc.tblCase as c on c.fldId=d.fldCaseId
	inner join bud.tblCodingBudje_Details as p on p.fldCodeingBudjeId=c.fldSourceId
	cross apply(select stuff((select N' ـ ' +p.fldTitle  from ACC.tblCoding_Details as p
						inner join ACC.tblCoding_Details as child on child.fldId=cd.fldId 
						where child.fldCodeId.IsDescendantOf(p.fldCodeId)=1  and child.fldHeaderCodId=p.fldHeaderCodId for xml path('')),1,2,'') as fldTileParent ) cp
	--outer apply (select  cast(row_number()over (order by h2.fldId) as int) atf from  acc.tblDocumentRecord_Header h2 inner join acc.tblFiscalYear f
	--			on h2.fldFiscalYearId=f.fldid
	--			where  h2.fldId=h.fldId and f.fldYear=h2.fldYear and h2.fldDocumentNum <>0 and (@Type=2 or (@Type<>2 and h2.fldAccept=@Type))
	--			)a
outer Apply(
				select atf from (select row_number()over (order by h12.fldId) atf,h12.fldid   
				from acc.tblDocumentRecord_Header h2
				inner join acc.tblDocumentRecord_Header1 as h12 on h12.fldDocument_HedearId=h2.fldid
				where h2.fldOrganId=h.fldOrganId and h2.fldYear=h.fldYear 
					and h12.fldModuleSaveId=h1.fldModuleSaveId and h12.fldDocumentNum <>0
					)t where t.fldId=h1.fldid)a
	outer apply(select top (1)  h12.fldTypeSanadId as fldTypeSanadId_Pid 
					from acc.tblDocumentRecord_Header as h2 
					inner join acc.tblDocumentRecord_Header1 as h12 on h12.fldDocument_HedearId=h2.fldid
					where h12.fldPId=h1.fldId  order by h12.fldId desc )Typesanad
	outer apply(select (select top(1)  N'مرجوع شده (مرتبه ' +cast( ROW_NUMBER() over (order by h12.fldid) as varchar(10))+')' 
				from acc.tblDocumentRecord_Header as h2 
				inner join acc.tblDocumentRecord_Header1 as h12 on h12.fldDocument_HedearId=h2.fldid
				where h12.fldPId=h1.fldId and h12.fldTypeSanadId=3 order by h12.fldid desc) as fldTypeSanadId_Pid) sanadName
	where   (d.fldDocument_HedearId1=h1.fldId or 
	(not exists(select * from Acc.tblDocumentRecord_Details as d2 where d2.fldDocument_HedearId1=h1.fldId )   and d.fldDocument_HedearId1 is null)) 
	and h.fldYear=@Year and h.fldOrganId=@OrganId and h1.fldModuleSaveId=@ModuleSaveId and  h1.fldDocumentNum between @FromDocumentNum and @ToDocumentNum  and c.fldCaseTypeId=15
	 and (@Type=2 or (@Type<>2 and h1.fldAccept=@Type))   and p.fldLevelId=4 and p.fldTarh_KhedmatTypeId=1

union all
/*tblShomareHesabeOmoomi*/	select  h.fldId,h1.fldDocumentNum,a.atf as fldAtfNum,isnull(h1.fldArchiveNum,'') as fldArchiveNum,isnull((cast(h1.fldShomareFaree as varchar(100))),'') as fldShomareFaree,h1.fldModuleErsalId
	,h1.fldTarikhDocument,case when h.fldType=1 and fldaccept=1 then N'قطعی' when h.fldType=1 and fldaccept=0 then N'موقت' end as fldTypeName,
	h.fldDescriptionDocu,dt.fldName as fldTypeSanadName,cd.fldCode,
	case when @Setting='true' then cp.fldTileParent else cd.fldTitle end as fldDescriptionCoding,0 as fldMablaghJoz,d.fldBedehkar,d.fldBestankar 
	,s.fldShomareHesab+'_'+b.fldBankName+'('+sh.fldName+')' as fldNameParvande,d.fldDescription,d.fldorder,case when d.fldBedehkar<>0 then 1 else 2 end as fldOrders,d.fldDate,d.fldId as fldDocument_DetailsId 
	,case when Typesanad.fldTypeSanadId_Pid is null then N'ارسال نشده' when Typesanad.fldTypeSanadId_Pid<>3 then N'ارسال شده' else sanadName.fldTypeSanadId_Pid end fldTypeSanadName_Pid
	from acc.tblDocumentRecord_Header as h
	inner join acc.tblDocumentRecord_Header1 as h1 on h1.fldDocument_HedearId=h.fldid
	inner join acc.tblDocumentType dt on dt.fldid=fldTypeSanadId
	inner join acc.tblDocumentRecord_Details as d on d.fldDocument_HedearId=h.fldId
	inner join acc.tblCoding_Details as cd on cd.fldId=d.fldCodingId
	inner join acc.tblCase as c on c.fldId=d.fldCaseId
	inner join com.tblShomareHesabeOmoomi as s on s.fldId=c.fldSourceId
	inner join com.tblAshkhas ah on s.fldAshkhasId=ah.fldId
	inner join com.tblOrganization o on o.fldAshkhaseHoghoghiId=ah.fldHoghoghiId
	inner join com.tblAshkhaseHoghoghi ho on ho.fldid=fldAshkhaseHoghoghiId
	inner join com.tblSHobe sh on sh.fldid=fldShobeId
	inner join com.tblBank b on b.fldid=sh.fldBankId
	cross apply(select stuff((select N' ـ ' +p.fldTitle  from ACC.tblCoding_Details as p
						inner join ACC.tblCoding_Details as child on child.fldId=cd.fldId 
						where child.fldCodeId.IsDescendantOf(p.fldCodeId)=1  and child.fldHeaderCodId=p.fldHeaderCodId for xml path('')),1,2,'') as fldTileParent ) cp
	--outer apply (select  cast(row_number()over (order by h2.fldId) as int) atf from  acc.tblDocumentRecord_Header h2 inner join acc.tblFiscalYear f
	--			on h2.fldFiscalYearId=f.fldid
	--			where  h2.fldId=h.fldId and f.fldYear=h2.fldYear and h2.fldDocumentNum <>0 and (@Type=2 or (@Type<>2 and h2.fldAccept=@Type))
	--			)a
outer Apply(
				select atf from (select row_number()over (order by h12.fldId) atf,h12.fldid   
				from acc.tblDocumentRecord_Header h2
				inner join acc.tblDocumentRecord_Header1 as h12 on h12.fldDocument_HedearId=h2.fldid
				where h2.fldOrganId=h.fldOrganId and h2.fldYear=h.fldYear 
					and h12.fldModuleSaveId=h1.fldModuleSaveId and h12.fldDocumentNum <>0
					)t where t.fldId=h1.fldid)a
	outer apply(select top (1)  h12.fldTypeSanadId as fldTypeSanadId_Pid 
					from acc.tblDocumentRecord_Header as h2 
					inner join acc.tblDocumentRecord_Header1 as h12 on h12.fldDocument_HedearId=h2.fldid
					where h12.fldPId=h1.fldId  order by h12.fldId desc )Typesanad
	outer apply(select (select top(1)  N'مرجوع شده (مرتبه ' +cast( ROW_NUMBER() over (order by h12.fldid) as varchar(10))+')' 
				from acc.tblDocumentRecord_Header as h2 
				inner join acc.tblDocumentRecord_Header1 as h12 on h12.fldDocument_HedearId=h2.fldid
				where h12.fldPId=h1.fldId and h12.fldTypeSanadId=3 order by h12.fldid desc) as fldTypeSanadId_Pid) sanadName
	where   (d.fldDocument_HedearId1=h1.fldId or 
	(not exists(select * from Acc.tblDocumentRecord_Details as d2 where d2.fldDocument_HedearId1=h1.fldId )   and d.fldDocument_HedearId1 is null)) 
	and h.fldYear=@Year and h.fldOrganId=@OrganId and h1.fldModuleSaveId=@ModuleSaveId and  h1.fldDocumentNum between @FromDocumentNum and @ToDocumentNum  and c.fldCaseTypeId=5
	 and (@Type=2 or (@Type<>2 and h1.fldAccept=@Type)) and o.fldid=@OrganId*/


	) t
	left join com.tblModule as m on m.fldId=t.fldModuleErsalId


	/*union all
/**/	select  h.fldId,h1.fldDocumentNum,a.atf as fldAtfNum,isnull(h1.fldArchiveNum,'') as fldArchiveNum,isnull((cast(h1.fldShomareFaree as varchar(100))),'') as fldShomareFaree
	,h1.fldTarikhDocument,case when fldType=1 and fldaccept=1 then N'قطعی' when fldType=1 and fldaccept=0 then N'موقت' end as fldTypeName,
	h.fldDescriptionDocu,dt.fldName as fldTypeSanadName,cd.fldCode,
	case when @Setting='true' then cp.fldTileParent else cd.fldTitle end as fldDescriptionCoding,0 as fldMablaghJoz,d.fldBedehkar
	,replace(convert(varchar,cast(fldBestankar as money),1), '.00','')as fldBestankar
	,N'' as fldNameParvande
	,case when d.fldBestankar>0 then  CHAR(9) +d.fldDescription else d.fldDescription end  as fldDescription,isnull(m.fldTitle,'') as fldModuleErsalName
	,fldBestankar,d.fldorder,case when d.fldBedehkar<>0 then 1 else 2 end as fldOrders,d.fldDate,d.fldId as fldDocument_DetailsId
	,case when Typesanad.fldTypeSanadId_Pid is null then N'ارسال نشده' when Typesanad.fldTypeSanadId_Pid<>3 then N'ارسال شده' else sanadName.fldTypeSanadId_Pid end fldTypeSanadName_Pid
	from acc.tblDocumentRecord_Header as h
	inner join acc.tblDocumentRecord_Header1 as h1 on h1.fldDocument_HedearId=h.fldid
	inner join acc.tblDocumentType dt on dt.fldid=fldTypeSanadId
	inner join acc.tblDocumentRecord_Details as d on d.fldDocument_HedearId=h.fldId 
	inner join acc.tblCoding_Details as cd on cd.fldId=d.fldCodingId
	cross apply(select stuff((select N' ـ ' +p.fldTitle  from ACC.tblCoding_Details as p
						inner join ACC.tblCoding_Details as child on child.fldId=cd.fldId 
						where child.fldCodeId.IsDescendantOf(p.fldCodeId)=1  and child.fldHeaderCodId=p.fldHeaderCodId for xml path('')),1,2,'') as fldTileParent ) cp
	--outer apply (select  cast(row_number()over (order by h2.fldId) as int) atf from  acc.tblDocumentRecord_Header h2 inner join acc.tblFiscalYear f
	--			on h2.fldFiscalYearId=f.fldid
	--			where  h2.fldId=h.fldId and f.fldYear=h2.fldYear and h2.fldDocumentNum <>0  and (@Type=2 or (@Type<>2 and h2.fldAccept=@Type))
	--			)a
	outer Apply(
				select atf from (select row_number()over (order by h12.fldId) atf,h12.fldid   
				from acc.tblDocumentRecord_Header h2
				inner join acc.tblDocumentRecord_Header1 as h12 on h12.fldDocument_HedearId=h2.fldid
				where h2.fldOrganId=h.fldOrganId and h2.fldYear=h.fldYear 
					and h12.fldModuleSaveId=h1.fldModuleSaveId and h12.fldDocumentNum <>0
					)t where t.fldId=h1.fldid)a
	outer apply(select top (1)  h12.fldTypeSanadId as fldTypeSanadId_Pid 
					from acc.tblDocumentRecord_Header as h2 
					inner join acc.tblDocumentRecord_Header1 as h12 on h12.fldDocument_HedearId=h2.fldid
					where h12.fldPId=h1.fldId  order by h12.fldId desc )Typesanad
	outer apply(select (select top(1)  N'مرجوع شده (مرتبه ' +cast( ROW_NUMBER() over (order by h12.fldid) as varchar(10))+')' 
				from acc.tblDocumentRecord_Header as h2 
				inner join acc.tblDocumentRecord_Header1 as h12 on h12.fldDocument_HedearId=h2.fldid
				where h12.fldPId=h1.fldId and h12.fldTypeSanadId=3 order by h12.fldid desc) as fldTypeSanadId_Pid) sanadName
	left join com.tblModule as m on m.fldId=h1.fldModuleErsalId
	where   (d.fldDocument_HedearId1=h1.fldId or 
	(not exists(select * from Acc.tblDocumentRecord_Details as d2 where d2.fldDocument_HedearId1=h1.fldId )   and d.fldDocument_HedearId1 is null)) 
	and h.fldYear=@Year and h.fldOrganId=@OrganId and h1.fldModuleSaveId=@ModuleSaveId and   h1.fldDocumentNum between @FromDocumentNum and @ToDocumentNum  and d.fldCaseId is null
	 and (@Type=2 or (@Type<>2 and h1.fldAccept=@Type))*/
	)t2
	)t3
	order by -- /*fldOrders,*/fldId,fldDate,fldDocument_DetailsId
	fldTarikhDocument,fldDocumentNum

	

commit tran

GO
