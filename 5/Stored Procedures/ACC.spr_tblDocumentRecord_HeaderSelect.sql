SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [ACC].[spr_tblDocumentRecord_HeaderSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@value1 NVARCHAR(50),
	@value2 NVARCHAR(50),
	@fldOrganId INT,
	@fldYear smallint,
	@fldMadule int,
	@typeorder tinyint,
	@h int
AS 
	BEGIN TRAN
	
	SET @Value=Com.fn_TextNormalize(@Value)
	if (@h=0) set @h=2147483647
	if (@typeorder=1)
	begin
	if (@fieldname=N'fldId')
	SELECT  h1.[fldId], [fldDocumentNum],cast(atf as int ) [fldAtfNum], [fldArchiveNum], [fldDescriptionDocu],header.[fldOrganId] ,[fldTarikhDocument],header.[fldDesc], header.[fldDate], header.[fldIP], header.[fldUserId],[fldAccept] 
	,fldType,case when fldType=1 and fldaccept=1 then N'قطعی' when fldType=1 and fldaccept=0 then N'موقت' when fldType=2 then N'یادداشت' end as fldTypeName
	,cast(ShomareRoozane as int)ShomareRoozane,fldShomareFaree,f.fldYear,fldFiscalYearId
	,fldTypeSanadId as fldTypeSanad ,d.fldName    as fldTypeSanadName,m.fldTitle as fldNameModule,fldModuleErsalId,isnull(fldExistsFile,cast(0 as bit))fldIsArchive
	,case when h1.fldPId is null or fldTypeSanadId<>3 then 0 else Doc_Pid.fldDocumentNum_Pid end fldDocumentNum_Pid,isnull(h1.fldPId,0)fldPId,case when Typesanad.fldTypeSanadId_Pid is null then N'ارسال نشده' when Typesanad.fldTypeSanadId_Pid<>3 then N'ارسال شده' else sanadName.fldTypeSanadId_Pid end fldTypeSanadName_Pid
	,case when fldModuleErsalId in (5,12,13) then ACC.fn_GetSourceId(fldModuleErsalId,header.fldId)	
	when fldPId is null  or fldModuleErsalId=fldModuleSaveId  then fldDocumentNum  
	else (select h.fldDocumentNum from acc.tblDocumentRecord_Header1 as h where h1.fldPId=h.fldid) end fldMainDocNum,isnull(flag.fldFlag,0) as fldFlag, ACC.fn_GetArtiklMap( header.fldId, h1.fldId,h1.fldModuleErsalId) as fldIsMap
	,fldEdit,case when fldModuleErsalId in(12,13) then ACC.[fn_GetCaseTypeId](fldModuleErsalId,header.fldId) else 0 end as fldCaseTypeId

	FROM   [ACC].[tblDocumentRecord_Header] header 
	inner join acc.tblFiscalYear f on header.fldFiscalYearId=f.fldid 
	inner join acc.tblDocumentRecord_Header1 as h1 on h1.fldDocument_HedearId=header.fldid
	inner join[ACC].[tblDocumentType] d on d.fldid=h1.fldTypeSanadId
	left join com.tblModule m on m.fldid=h1.fldModuleErsalId
	outer Apply(
				select atf from (select row_number()over (order by h2.fldId) atf,h2.fldid   
				from acc.tblDocumentRecord_Header h
				inner join acc.tblFiscalYear f1 on h.fldFiscalYearId=f1.fldid
				inner join acc.tblDocumentRecord_Header1 as h2 on h2.fldDocument_HedearId=h.fldid
				where h.fldOrganId=header.fldOrganId and f1.fldYear=f.fldYear 
					and h2.fldModuleSaveId=h1.fldModuleSaveId and fldDocumentNum <>0
					)t where t.fldid=h1.fldid)atfNum

		outer apply (select ShomareRoozane from (select row_number()over (order by h2.fldDate) ShomareRoozane,h2.fldid  
				from acc.tblDocumentRecord_Header h
				inner join acc.tblFiscalYear f1 on h.fldFiscalYearId=f1.fldid
				inner join acc.tblDocumentRecord_Header1 as h2 on h2.fldDocument_HedearId=h.fldid
				where h.fldOrganId=header.fldOrganId and f1.fldYear=f.fldYear 
					and h2.fldModuleSaveId=h1.fldModuleSaveId and cast(h2.fldDate as date)=cast(h1.fldDate as date) 	
					and fldDocumentNum <>0)t where t.fldid=h1.fldid)Roozane

	outer apply(select top(1) cast(1 as bit)fldExistsFile from acc.tblDocumentRecorde_File where fldDocumentHeaderId=header.fldid)Doc_File
	cross apply(select max(fldDate) as maxDate from
			(select max(h.fldDate) fldDate from acc.tblDocumentRecord_Header1 as h where h.fldId=h1.fldId
			union all
			select max(l.fldDate) fldDate from acc.tblDocument_HeaderLog as L where l.fldHeaderId =h1.fldId
			union all
			select max(f.fldDate) fldDate from acc.tblDocumentRecorde_File as f where f.fldDocumentHeaderId=header.fldId
			union all
			select max(b.fldDate) fldDate from acc.tblDocumentRecorde_File as f 
			inner join acc.tblDocumentBookMark as b on b.fldDocumentRecordeId=f.fldId
			where f.fldDocumentHeaderId=header.fldId)t)md
outer apply(select top 1  h.fldDocumentNum as fldDocumentNum_Pid from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldPId and h.fldId<h1.fldId order by h.fldId desc )Doc_Pid
outer apply(select top 1  h.fldTypeSanadId as fldTypeSanadId_Pid from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldId  order by h.fldId desc )Typesanad
outer APPLY(select (select top(1)  N'مرجوع شده (مرتبه ' +cast( ROW_NUMBER() over (order by h.fldid) as varchar(10))+')' from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldId and h.fldTypeSanadId=3 order by h.fldid desc) as fldTypeSanadId_Pid) sanadName
outer APPLY(select top(1) 1 as fldFlag
			FROM   [ACC].[tblDocumentRecord_Details] as d
			inner join acc.tblDocumentRecord_Header as h on h.fldId=d.fldDocument_HedearId
			inner join acc.[tblArtiklMap] as a on a.fldDocumentRecord_DetailsId=d.fldId
			WHERE   fldDocument_HedearId=header.fldId  
			and (fldDocument_HedearId1=h1.fldId
			 or (not exists(select * from Acc.tblDocumentRecord_Details as d2 where d2.fldDocument_HedearId1=h1.fldId ) and fldDocument_HedearId1 is null )) ) flag
	WHERE  h1.fldId = @Value AND header.fldOrganId=@fldOrganId and header.fldYear=@fldYear and fldModuleSaveId=@fldMadule
	--order by fldTarikhDocument,case when fldDocumentNum=0 then 1 else 0 end ,fldDocumentNum
	order by   md.maxDate desc,fldDocumentNum desc

	if (@fieldname=N'Mortabet')/*فرق داره*/
	SELECT  h1.[fldId], [fldDocumentNum],cast(atf as int ) [fldAtfNum], [fldArchiveNum], [fldDescriptionDocu],header.[fldOrganId] ,[fldTarikhDocument],header.[fldDesc], header.[fldDate], header.[fldIP], header.[fldUserId],[fldAccept] 
	,fldType,case when fldType=1 and fldaccept=1 then N'قطعی' when fldType=1 and fldaccept=0 then N'موقت' when fldType=2 then N'یادداشت' end as fldTypeName
	,cast(ShomareRoozane as int)ShomareRoozane,fldShomareFaree,f.fldYear,fldFiscalYearId
	,fldTypeSanadId as fldTypeSanad ,d.fldName    as fldTypeSanadName,m.fldTitle as fldNameModule,fldModuleErsalId,isnull(fldExistsFile,cast(0 as bit))fldIsArchive
	,case when h1.fldPId is null or fldTypeSanadId<>3 then 0 else Doc_Pid.fldDocumentNum_Pid end fldDocumentNum_Pid,isnull(h1.fldPId,0)fldPId
	,case when Typesanad.fldTypeSanadId_Pid is null then N'ارسال نشده' when Typesanad.fldTypeSanadId_Pid<>3 then N'ارسال شده' else sanadName.fldTypeSanadId_Pid end fldTypeSanadName_Pid
	,case when fldModuleErsalId in (5,12,13) then ACC.fn_GetSourceId(fldModuleErsalId,header.fldId)	when fldPId is null  or fldModuleErsalId=fldModuleSaveId  then fldDocumentNum  
	else (select h.fldDocumentNum from acc.tblDocumentRecord_Header1 as h where h1.fldPId=h.fldid) end fldMainDocNum,isnull(flag.fldFlag,0) as fldFlag
	, ACC.fn_GetArtiklMap( header.fldId, h1.fldId,h1.fldModuleErsalId) as fldIsMap,fldEdit,case when fldModuleErsalId in(12,13) then ACC.[fn_GetCaseTypeId](fldModuleErsalId,header.fldId) else 0 end as fldCaseTypeId

	FROM   [ACC].[tblDocumentRecord_Header] header 
	inner join acc.tblFiscalYear f on header.fldFiscalYearId=f.fldid 
	inner join acc.tblDocumentRecord_Header1 as h1 on h1.fldDocument_HedearId=header.fldid
	inner join[ACC].[tblDocumentType] d on d.fldid=h1.fldTypeSanadId
	left join com.tblModule m on m.fldid=h1.fldModuleErsalId
	outer Apply(
				select atf from (select row_number()over (order by h2.fldId) atf,h2.fldid   
				from acc.tblDocumentRecord_Header h
				inner join acc.tblFiscalYear f1 on h.fldFiscalYearId=f1.fldid
				inner join acc.tblDocumentRecord_Header1 as h2 on h2.fldDocument_HedearId=h.fldid
				where h.fldOrganId=header.fldOrganId and f1.fldYear=f.fldYear 
					and h2.fldModuleSaveId=h1.fldModuleSaveId and fldDocumentNum <>0
					)t where t.fldid=h1.fldid)atfNum

		outer apply (select ShomareRoozane from (select row_number()over (order by h2.fldDate) ShomareRoozane,h2.fldid  
				from acc.tblDocumentRecord_Header h
				inner join acc.tblFiscalYear f1 on h.fldFiscalYearId=f1.fldid
				inner join acc.tblDocumentRecord_Header1 as h2 on h2.fldDocument_HedearId=h.fldid
				where h.fldOrganId=header.fldOrganId and f1.fldYear=f.fldYear 
					and h2.fldModuleSaveId=h1.fldModuleSaveId and cast(h2.fldDate as date)=cast(h1.fldDate as date) 	
					and fldDocumentNum <>0)t where t.fldid=h1.fldid)Roozane

	outer apply(select top(1) cast(1 as bit)fldExistsFile from acc.tblDocumentRecorde_File where fldDocumentHeaderId=header.fldid)Doc_File
	cross apply(select max(fldDate) as maxDate from
			(select max(h.fldDate) fldDate from acc.tblDocumentRecord_Header1 as h where h.fldId=h1.fldId
			union all
			select max(l.fldDate) fldDate from acc.tblDocument_HeaderLog as L where l.fldHeaderId =h1.fldId
			union all
			select max(f.fldDate) fldDate from acc.tblDocumentRecorde_File as f where f.fldDocumentHeaderId=header.fldId
			union all
			select max(b.fldDate) fldDate from acc.tblDocumentRecorde_File as f 
			inner join acc.tblDocumentBookMark as b on b.fldDocumentRecordeId=f.fldId
			where f.fldDocumentHeaderId=header.fldId)t)md
outer apply(select top 1  h.fldDocumentNum as fldDocumentNum_Pid from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldPId and h.fldId<h1.fldId order by h.fldId desc )Doc_Pid
outer apply(select top 1  h.fldTypeSanadId as fldTypeSanadId_Pid from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldId  order by h.fldId desc )Typesanad
outer APPLY(select (select top(1)  N'مرجوع شده (مرتبه ' +cast( ROW_NUMBER() over (order by h.fldid) as varchar(10))+')' from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldId and h.fldTypeSanadId=3 order by h.fldid desc) as fldTypeSanadId_Pid) sanadName
outer APPLY(select top(1) 1 as fldFlag
			FROM   [ACC].[tblDocumentRecord_Details] as d
			inner join acc.tblDocumentRecord_Header as h on h.fldId=d.fldDocument_HedearId
			inner join acc.[tblArtiklMap] as a on a.fldDocumentRecord_DetailsId=d.fldId
			WHERE   fldDocument_HedearId=header.fldId  
			and (fldDocument_HedearId1=h1.fldId
			 or (not exists(select * from Acc.tblDocumentRecord_Details as d2 where d2.fldDocument_HedearId1=h1.fldId ) and fldDocument_HedearId1 is null )) ) flag
cross apply (
select distinct h1.fldid from (
select c.fldId
			FROM   [ACC].[tblDocumentRecord_Details] as d
			inner join acc.tblCase as c on c.fldId=d.fldCaseId			
			inner join acc.tblCoding_Details as cd on cd.fldId=d.fldCodingId
			inner join acc.tblTemplateCoding as t on t.fldId=cd.fldTempCodingId
			inner join acc.[tblArtiklMap] as a on a.fldType=c.fldCaseTypeId
			inner join acc.tblDocumentRecord_Header as h2 on h2.fldId=d.fldDocument_HedearId			
			inner join acc.tblDocumentRecord_Header1 as h21 on h2.fldId=h21.fldDocument_HedearId
			cross apply(select * from com.Split(a.fldSourceId,','))s 
			WHERE  h21.fldId = @Value 
			and     c.fldSourceId=s.Item and s.Item<>''  and fldItemId=14 and fldCaseTypeId=6 and fldModuleSaveId=@fldMadule
			and (fldDocument_HedearId1=h21.fldId
			 or (not exists(select * from Acc.tblDocumentRecord_Details as d2 where d2.fldDocument_HedearId1=h21.fldId ) and fldDocument_HedearId1 is null ))
			)c
			inner join [ACC].[tblDocumentRecord_Details] as d on c.fldId=d.fldCaseId
			inner join acc.tblCoding_Details as cd on cd.fldId=d.fldCodingId
			inner join acc.tblTemplateCoding as t on t.fldId=cd.fldTempCodingId
			inner join acc.tblDocumentRecord_Header as h on h.fldId=d.fldDocument_HedearId			
			inner join acc.tblDocumentRecord_Header1 as h1 on h.fldId=h1.fldDocument_HedearId
			where fldItemId=14 and fldModuleSaveId=@fldMadule
			and (fldDocument_HedearId1=h1.fldId
			 or (not exists(select * from Acc.tblDocumentRecord_Details as d2 where d2.fldDocument_HedearId1=h1.fldId ) and fldDocument_HedearId1 is null ))
)map
where h1.fldId=map.fldId and Typesanad.fldTypeSanadId_Pid is null
	--order by fldTarikhDocument,case when fldDocumentNum=0 then 1 else 0 end ,fldDocumentNum
	order by md.maxDate desc,fldDocumentNum desc


	if (@fieldname=N'SanadNumbers')
	SELECT top(100) h1.[fldId], [fldDocumentNum],cast(atf as int ) [fldAtfNum], [fldArchiveNum], [fldDescriptionDocu],header.[fldOrganId] ,[fldTarikhDocument],header.[fldDesc], header.[fldDate], header.[fldIP], header.[fldUserId],[fldAccept] 
	,fldType,case when fldType=1 and fldaccept=1 then N'قطعی' when fldType=1 and fldaccept=0 then N'موقت' when fldType=2 then N'یادداشت' end as fldTypeName
	,cast(ShomareRoozane as int)ShomareRoozane,fldShomareFaree,f.fldYear,fldFiscalYearId
	,fldTypeSanadId as fldTypeSanad ,d.fldName    as fldTypeSanadName,m.fldTitle as fldNameModule,fldModuleErsalId,isnull(fldExistsFile,cast(0 as bit))fldIsArchive
	,case when h1.fldPId is null or fldTypeSanadId<>3 then 0 else Doc_Pid.fldDocumentNum_Pid end fldDocumentNum_Pid,isnull(h1.fldPId,0)fldPId,case when Typesanad.fldTypeSanadId_Pid is null then N'ارسال نشده' when Typesanad.fldTypeSanadId_Pid<>3 then N'ارسال شده' else sanadName.fldTypeSanadId_Pid end fldTypeSanadName_Pid
	,case when fldModuleErsalId in (5,12,13) then ACC.fn_GetSourceId(fldModuleErsalId,header.fldId) when fldPId is null  or fldModuleErsalId=fldModuleSaveId then fldDocumentNum  else (select h.fldDocumentNum from acc.tblDocumentRecord_Header1 as h where h1.fldPId=h.fldid) end fldMainDocNum,isnull(flag.fldFlag,0) as fldFlag, ACC.fn_GetArtiklMap( header.fldId, h1.fldId,h1.fldModuleErsalId) as fldIsMap,fldEdit,case when fldModuleErsalId in(12,13) then ACC.[fn_GetCaseTypeId](fldModuleErsalId,header.fldId) else 0 end as fldCaseTypeId
	FROM   [ACC].[tblDocumentRecord_Header] header 
	inner join acc.tblFiscalYear f on header.fldFiscalYearId=f.fldid 
	inner join acc.tblDocumentRecord_Header1 as h1 on h1.fldDocument_HedearId=header.fldid
	inner join[ACC].[tblDocumentType] d on d.fldid=h1.fldTypeSanadId
	left join com.tblModule m on m.fldid=h1.fldModuleErsalId
	outer Apply(
				select atf from (select row_number()over (order by h2.fldId) atf,h2.fldid   
				from acc.tblDocumentRecord_Header h
				inner join acc.tblFiscalYear f1 on h.fldFiscalYearId=f1.fldid
				inner join acc.tblDocumentRecord_Header1 as h2 on h2.fldDocument_HedearId=h.fldid
				where h.fldOrganId=header.fldOrganId and f1.fldYear=f.fldYear 
					and h2.fldModuleSaveId=h1.fldModuleSaveId and fldDocumentNum <>0
					)t where t.fldid=h1.fldid)atfNum

		outer apply (select ShomareRoozane from (select row_number()over (order by h2.fldDate) ShomareRoozane,h2.fldid  
				from acc.tblDocumentRecord_Header h
				inner join acc.tblFiscalYear f1 on h.fldFiscalYearId=f1.fldid
				inner join acc.tblDocumentRecord_Header1 as h2 on h2.fldDocument_HedearId=h.fldid
				where h.fldOrganId=header.fldOrganId and f1.fldYear=f.fldYear 
					and h2.fldModuleSaveId=h1.fldModuleSaveId and cast(h2.fldDate as date)=cast(h1.fldDate as date) 	
					and fldDocumentNum <>0)t where t.fldid=h1.fldid)Roozane

	outer apply(select top(1) cast(1 as bit)fldExistsFile from acc.tblDocumentRecorde_File where fldDocumentHeaderId=header.fldid)Doc_File
	cross apply(select max(fldDate) as maxDate from
			(select max(h.fldDate) fldDate from acc.tblDocumentRecord_Header1 as h where h.fldId=h1.fldId
			union all
			select max(l.fldDate) fldDate from acc.tblDocument_HeaderLog as L where l.fldHeaderId =h1.fldId
			union all
			select max(f.fldDate) fldDate from acc.tblDocumentRecorde_File as f where f.fldDocumentHeaderId=header.fldId
			union all
			select max(b.fldDate) fldDate from acc.tblDocumentRecorde_File as f 
			inner join acc.tblDocumentBookMark as b on b.fldDocumentRecordeId=f.fldId
			where f.fldDocumentHeaderId=header.fldId)t)md
outer apply(select top 1  h.fldDocumentNum as fldDocumentNum_Pid from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldPId and h.fldId<h1.fldId order by h.fldId desc )Doc_Pid
outer apply(select top 1  h.fldTypeSanadId as fldTypeSanadId_Pid from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldId  order by h.fldId desc )Typesanad
outer APPLY(select (select top(1)  N'مرجوع شده (مرتبه ' +cast( ROW_NUMBER() over (order by h.fldid) as varchar(10))+')' from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldId and h.fldTypeSanadId=3 order by h.fldid desc) as fldTypeSanadId_Pid) sanadName
outer APPLY(select top(1) 1 as fldFlag
			FROM   [ACC].[tblDocumentRecord_Details] as d
			inner join acc.tblDocumentRecord_Header as h on h.fldId=d.fldDocument_HedearId
			inner join acc.[tblArtiklMap] as a on a.fldDocumentRecord_DetailsId=d.fldId
			WHERE   fldDocument_HedearId=header.fldId  
			and (fldDocument_HedearId1=h1.fldId
			 or (not exists(select * from Acc.tblDocumentRecord_Details as d2 where d2.fldDocument_HedearId1=h1.fldId ) and fldDocument_HedearId1 is null )) ) flag
	WHERE   cast(h1.fldid  as varchar(10)) in (select top(1 )* from com.Split(@value,';')
	where item=h1.fldid)  /*AND header.fldOrganId=@fldOrganIdand header.fldYear=@fldYear and fldModuleSaveId=@fldMadule
	--order by fldTarikhDocument,case when fldDocumentNum=0 then 1 else 0 end ,fldDocumentNum*/
	order by md.maxDate desc,fldDocumentNum desc



	if (@fieldname=N'fldPId')
	SELECT  h1.[fldId], [fldDocumentNum],cast(atf as int ) [fldAtfNum], [fldArchiveNum], [fldDescriptionDocu],header.[fldOrganId] ,[fldTarikhDocument],header.[fldDesc], header.[fldDate], header.[fldIP], header.[fldUserId],[fldAccept] 
	,fldType,case when fldType=1 and fldaccept=1 then N'قطعی' when fldType=1 and fldaccept=0 then N'موقت' when fldType=2 then N'یادداشت' end as fldTypeName
	,cast(ShomareRoozane as int)ShomareRoozane,fldShomareFaree,f.fldYear,fldFiscalYearId
	,fldTypeSanadId as fldTypeSanad ,d.fldName    as fldTypeSanadName,m.fldTitle as fldNameModule,fldModuleErsalId,isnull(fldExistsFile,cast(0 as bit))fldIsArchive
	,case when h1.fldPId is null or fldTypeSanadId<>3 then 0 else Doc_Pid.fldDocumentNum_Pid end fldDocumentNum_Pid,isnull(h1.fldPId,0)fldPId,case when Typesanad.fldTypeSanadId_Pid is null then N'ارسال نشده' when Typesanad.fldTypeSanadId_Pid<>3 then N'ارسال شده' else sanadName.fldTypeSanadId_Pid end fldTypeSanadName_Pid
	,case when fldModuleErsalId in (5,12,13) then ACC.fn_GetSourceId(fldModuleErsalId,header.fldId) when fldPId is null  or fldModuleErsalId=fldModuleSaveId then fldDocumentNum  else (select h.fldDocumentNum from acc.tblDocumentRecord_Header1 as h where h1.fldPId=h.fldid) end fldMainDocNum,isnull(flag.fldFlag,0) as fldFlag, ACC.fn_GetArtiklMap( header.fldId, h1.fldId,h1.fldModuleErsalId) as fldIsMap,fldEdit,case when fldModuleErsalId in(12,13) then ACC.[fn_GetCaseTypeId](fldModuleErsalId,header.fldId) else 0 end as fldCaseTypeId
	FROM   [ACC].[tblDocumentRecord_Header] header 
	inner join acc.tblFiscalYear f on header.fldFiscalYearId=f.fldid
	inner join acc.tblDocumentRecord_Header1 as h1 on h1.fldDocument_HedearId=header.fldid
	inner join[ACC].[tblDocumentType] d on d.fldid=fldTypeSanadId
	left join com.tblModule m on m.fldid=fldModuleErsalId
	outer Apply(
				select atf from (select row_number()over (order by h2.fldId) atf,h2.fldid   
				from acc.tblDocumentRecord_Header h
				inner join acc.tblFiscalYear f1 on h.fldFiscalYearId=f1.fldid
				inner join acc.tblDocumentRecord_Header1 as h2 on h2.fldDocument_HedearId=h.fldid
				where h.fldOrganId=header.fldOrganId and f1.fldYear=f.fldYear 
					and h2.fldModuleSaveId=h1.fldModuleSaveId and fldDocumentNum <>0
					)t where t.fldid=h1.fldid)atfNum

		outer apply (select ShomareRoozane from (select row_number()over (order by h2.fldDate) ShomareRoozane,h2.fldid  
				from acc.tblDocumentRecord_Header h
				inner join acc.tblFiscalYear f1 on h.fldFiscalYearId=f1.fldid
				inner join acc.tblDocumentRecord_Header1 as h2 on h2.fldDocument_HedearId=h.fldid
				where h.fldOrganId=header.fldOrganId and f1.fldYear=f.fldYear 
					and h2.fldModuleSaveId=h1.fldModuleSaveId and cast(h2.fldDate as date)=cast(h1.fldDate as date) 	
					and fldDocumentNum <>0)t where t.fldid=h1.fldid)Roozane

	outer apply(select top(1) cast(1 as bit)fldExistsFile from acc.tblDocumentRecorde_File where fldDocumentHeaderId=header.fldid)Doc_File
	cross apply(select max(fldDate) as maxDate from
			(select max(h.fldDate) fldDate from acc.tblDocumentRecord_Header1 as h where h.fldId=h1.fldId
			union all
			select max(l.fldDate) fldDate from acc.tblDocument_HeaderLog as L where l.fldHeaderId =h1.fldId
			union all
			select max(f.fldDate) fldDate from acc.tblDocumentRecorde_File as f where f.fldDocumentHeaderId=header.fldId
			union all
			select max(b.fldDate) fldDate from acc.tblDocumentRecorde_File as f 
			inner join acc.tblDocumentBookMark as b on b.fldDocumentRecordeId=f.fldId
			where f.fldDocumentHeaderId=header.fldId)t)md
outer apply(select top 1  h.fldDocumentNum as fldDocumentNum_Pid from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldPId and h.fldId<h1.fldId order by h.fldId desc )Doc_Pid
outer apply(select top 1  h.fldTypeSanadId as fldTypeSanadId_Pid from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldId  order by h.fldId desc )Typesanad
outer apply(select (select top(1)  N'مرجوع شده (مرتبه ' +cast( ROW_NUMBER() over (order by h.fldid) as varchar(10))+')' from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldId and h.fldTypeSanadId=3 order by h.fldid desc) as fldTypeSanadId_Pid) sanadName
outer APPLY(select top(1) 1 as fldFlag
			FROM   [ACC].[tblDocumentRecord_Details] as d
			inner join acc.tblDocumentRecord_Header as h on h.fldId=d.fldDocument_HedearId
			inner join acc.[tblArtiklMap] as a on a.fldDocumentRecord_DetailsId=d.fldId
			WHERE   fldDocument_HedearId=header.fldId  
			and (fldDocument_HedearId1=h1.fldId
			 or (not exists(select * from Acc.tblDocumentRecord_Details as d2 where d2.fldDocument_HedearId1=h1.fldId ) and fldDocument_HedearId1 is null )) ) flag
	WHERE  h1.fldPId = @Value /*چک کردن ارسال سند به حسابداری*/
	--order by fldTarikhDocument,case when fldDocumentNum=0 then 1 else 0 end ,fldDocumentNum
	order by md.maxDate desc,fldDocumentNum desc



	if (@fieldname=N'fldDesc')
		SELECT top(@h) h1.[fldId], [fldDocumentNum],cast(atf as int ) [fldAtfNum], [fldArchiveNum], [fldDescriptionDocu],header.[fldOrganId] ,[fldTarikhDocument],header.[fldDesc], header.[fldDate], header.[fldIP], header.[fldUserId],[fldAccept] 
	,fldType,case when fldType=1 and fldaccept=1 then N'قطعی' when fldType=1 and fldaccept=0 then N'موقت' when fldType=2 then N'یادداشت' end as fldTypeName
	,cast(ShomareRoozane as int)ShomareRoozane,fldShomareFaree,f.fldYear,fldFiscalYearId
	,fldTypeSanadId as fldTypeSanad ,d.fldName    as fldTypeSanadName,m.fldTitle as fldNameModule,fldModuleErsalId,isnull(fldExistsFile,cast(0 as bit))fldIsArchive
	,case when h1.fldPId is null or fldTypeSanadId<>3 then 0 else Doc_Pid.fldDocumentNum_Pid end fldDocumentNum_Pid,isnull(h1.fldPId,0)fldPId,case when Typesanad.fldTypeSanadId_Pid is null then N'ارسال نشده' when Typesanad.fldTypeSanadId_Pid<>3 then N'ارسال شده' else sanadName.fldTypeSanadId_Pid end fldTypeSanadName_Pid
	,case when fldModuleErsalId in (5,12,13) then ACC.fn_GetSourceId(fldModuleErsalId,header.fldId) when fldPId is null  or fldModuleErsalId=fldModuleSaveId then fldDocumentNum  else (select h.fldDocumentNum from acc.tblDocumentRecord_Header1 as h where h1.fldPId=h.fldid) end fldMainDocNum,isnull(flag.fldFlag,0) as fldFlag, ACC.fn_GetArtiklMap( header.fldId, h1.fldId,h1.fldModuleErsalId) as fldIsMap,fldEdit,case when fldModuleErsalId in(12,13) then ACC.[fn_GetCaseTypeId](fldModuleErsalId,header.fldId) else 0 end as fldCaseTypeId
	FROM   [ACC].[tblDocumentRecord_Header] header 
	inner join acc.tblFiscalYear f on header.fldFiscalYearId=f.fldid
	inner join acc.tblDocumentRecord_Header1 as h1 on h1.fldDocument_HedearId=header.fldid
	inner join[ACC].[tblDocumentType] d on d.fldid=fldTypeSanadId
	left join com.tblModule m on m.fldid=fldModuleErsalId
	outer Apply(
				select atf from (select row_number()over (order by h2.fldId) atf,h2.fldid   
				from acc.tblDocumentRecord_Header h
				inner join acc.tblFiscalYear f1 on h.fldFiscalYearId=f1.fldid
				inner join acc.tblDocumentRecord_Header1 as h2 on h2.fldDocument_HedearId=h.fldid
				where h.fldOrganId=header.fldOrganId and f1.fldYear=f.fldYear 
					and h2.fldModuleSaveId=h1.fldModuleSaveId and fldDocumentNum <>0
					)t where t.fldid=h1.fldid)atfNum

		outer apply (select ShomareRoozane from (select row_number()over (order by h2.fldDate) ShomareRoozane,h2.fldid  
				from acc.tblDocumentRecord_Header h
				inner join acc.tblFiscalYear f1 on h.fldFiscalYearId=f1.fldid
				inner join acc.tblDocumentRecord_Header1 as h2 on h2.fldDocument_HedearId=h.fldid
				where h.fldOrganId=header.fldOrganId and f1.fldYear=f.fldYear 
					and h2.fldModuleSaveId=h1.fldModuleSaveId and cast(h2.fldDate as date)=cast(h1.fldDate as date) 	
					and fldDocumentNum <>0)t where t.fldid=h1.fldid)Roozane

	outer apply(select top(1) cast(1 as bit)fldExistsFile from acc.tblDocumentRecorde_File where fldDocumentHeaderId=header.fldid)Doc_File
	cross apply(select max(fldDate) as maxDate from
			(select max(h.fldDate) fldDate from acc.tblDocumentRecord_Header1 as h where h.fldId=h1.fldId
			union all
			select max(l.fldDate) fldDate from acc.tblDocument_HeaderLog as L where l.fldHeaderId =h1.fldId
			union all
			select max(f.fldDate) fldDate from acc.tblDocumentRecorde_File as f where f.fldDocumentHeaderId=header.fldId
			union all
			select max(b.fldDate) fldDate from acc.tblDocumentRecorde_File as f 
			inner join acc.tblDocumentBookMark as b on b.fldDocumentRecordeId=f.fldId
			where f.fldDocumentHeaderId=header.fldId)t)md
outer apply(select top 1  h.fldDocumentNum as fldDocumentNum_Pid from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldPId and h.fldId<h1.fldId order by h.fldId desc )Doc_Pid
outer apply(select top 1  h.fldTypeSanadId as fldTypeSanadId_Pid from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldId  order by h.fldId desc )Typesanad
outer apply(select (select top(1)  N'مرجوع شده (مرتبه ' +cast( ROW_NUMBER() over (order by h.fldid) as varchar(10))+')' from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldId and h.fldTypeSanadId=3 order by h.fldid desc) as fldTypeSanadId_Pid) sanadName	--order by fldTarikhDocument,case when fldDocumentNum=0 then 1 else 0 end ,fldDocumentNum
outer APPLY(select top(1) 1 as fldFlag
			FROM   [ACC].[tblDocumentRecord_Details] as d
			inner join acc.tblDocumentRecord_Header as h on h.fldId=d.fldDocument_HedearId
			inner join acc.[tblArtiklMap] as a on a.fldDocumentRecord_DetailsId=d.fldId
			WHERE   fldDocument_HedearId=header.fldId  
			and (fldDocument_HedearId1=h1.fldId
			 or (not exists(select * from Acc.tblDocumentRecord_Details as d2 where d2.fldDocument_HedearId1=h1.fldId ) and fldDocument_HedearId1 is null )) ) flag
	order by md.maxDate desc,fldDocumentNum desc

	if (@fieldname=N'CheckYear')
		SELECT top(@h) h1.[fldId], [fldDocumentNum],cast(atf as int ) [fldAtfNum], [fldArchiveNum], [fldDescriptionDocu],header.[fldOrganId] ,[fldTarikhDocument],header.[fldDesc], header.[fldDate], header.[fldIP], header.[fldUserId],[fldAccept] 
	,fldType,case when fldType=1 and fldaccept=1 then N'قطعی' when fldType=1 and fldaccept=0 then N'موقت' when fldType=2 then N'یادداشت' end as fldTypeName
	,cast(ShomareRoozane as int)ShomareRoozane,fldShomareFaree,f.fldYear,fldFiscalYearId
	,fldTypeSanadId as fldTypeSanad ,d.fldName    as fldTypeSanadName,m.fldTitle as fldNameModule,fldModuleErsalId,isnull(fldExistsFile,cast(0 as bit))fldIsArchive
	,case when h1.fldPId is null or fldTypeSanadId<>3 then 0 else Doc_Pid.fldDocumentNum_Pid end fldDocumentNum_Pid,isnull(h1.fldPId,0)fldPId,case when Typesanad.fldTypeSanadId_Pid is null then N'ارسال نشده' when Typesanad.fldTypeSanadId_Pid<>3 then N'ارسال شده' else sanadName.fldTypeSanadId_Pid end fldTypeSanadName_Pid
	,case when fldModuleErsalId in (5,12,13) then ACC.fn_GetSourceId(fldModuleErsalId,header.fldId) when fldPId is null  or fldModuleErsalId=fldModuleSaveId then fldDocumentNum  else (select h.fldDocumentNum from acc.tblDocumentRecord_Header1 as h where h1.fldPId=h.fldid) end fldMainDocNum,isnull(flag.fldFlag,0) as fldFlag, ACC.fn_GetArtiklMap( header.fldId, h1.fldId,h1.fldModuleErsalId) as fldIsMap,fldEdit,case when fldModuleErsalId in(12,13) then ACC.[fn_GetCaseTypeId](fldModuleErsalId,header.fldId) else 0 end as fldCaseTypeId
	FROM   [ACC].[tblDocumentRecord_Header] header 
	inner join acc.tblFiscalYear f on header.fldFiscalYearId=f.fldid
	inner join acc.tblDocumentRecord_Header1 as h1 on h1.fldDocument_HedearId=header.fldid
	inner join[ACC].[tblDocumentType] d on d.fldid=fldTypeSanadId
	left join com.tblModule m on m.fldid=fldModuleErsalId
	outer Apply(
				select atf from (select row_number()over (order by h2.fldId) atf,h2.fldid   
				from acc.tblDocumentRecord_Header h
				inner join acc.tblFiscalYear f1 on h.fldFiscalYearId=f1.fldid
				inner join acc.tblDocumentRecord_Header1 as h2 on h2.fldDocument_HedearId=h.fldid
				where h.fldOrganId=header.fldOrganId and f1.fldYear=f.fldYear 
					and h2.fldModuleSaveId=h1.fldModuleSaveId and fldDocumentNum <>0
					)t where t.fldid=h1.fldid)atfNum

		outer apply (select ShomareRoozane from (select row_number()over (order by h2.fldDate) ShomareRoozane,h2.fldid  
				from acc.tblDocumentRecord_Header h
				inner join acc.tblFiscalYear f1 on h.fldFiscalYearId=f1.fldid
				inner join acc.tblDocumentRecord_Header1 as h2 on h2.fldDocument_HedearId=h.fldid
				where h.fldOrganId=header.fldOrganId and f1.fldYear=f.fldYear 
					and h2.fldModuleSaveId=h1.fldModuleSaveId and cast(h2.fldDate as date)=cast(h1.fldDate as date) 	
					and fldDocumentNum <>0)t where t.fldid=h1.fldid)Roozane

	outer apply(select  top(1) cast(1 as bit)fldExistsFile from acc.tblDocumentRecorde_File where fldDocumentHeaderId=header.fldid)Doc_File
	cross apply(select max(fldDate) as maxDate from
			(select max(h.fldDate) fldDate from acc.tblDocumentRecord_Header1 as h where h.fldId=h1.fldId
			union all
			select max(l.fldDate) fldDate from acc.tblDocument_HeaderLog as L where l.fldHeaderId =h1.fldId
			union all
			select max(f.fldDate) fldDate from acc.tblDocumentRecorde_File as f where f.fldDocumentHeaderId=header.fldId
			union all
			select max(b.fldDate) fldDate from acc.tblDocumentRecorde_File as f 
			inner join acc.tblDocumentBookMark as b on b.fldDocumentRecordeId=f.fldId
			where f.fldDocumentHeaderId=header.fldId)t)md
	outer apply(select top 1  h.fldDocumentNum as fldDocumentNum_Pid from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldPId and h.fldId<h1.fldId order by h.fldId desc )Doc_Pid
outer apply(select top 1  h.fldTypeSanadId as fldTypeSanadId_Pid from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldId  order by h.fldId desc )Typesanad
outer apply(select (select top(1)  N'مرجوع شده (مرتبه ' +cast( ROW_NUMBER() over (order by h.fldid) as varchar(10))+')' from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldId and h.fldTypeSanadId=3 order by h.fldid desc) as fldTypeSanadId_Pid) sanadName
outer APPLY(select top(1) 1 as fldFlag
			FROM   [ACC].[tblDocumentRecord_Details] as d
			inner join acc.tblDocumentRecord_Header as h on h.fldId=d.fldDocument_HedearId
			inner join acc.[tblArtiklMap] as a on a.fldDocumentRecord_DetailsId=d.fldId
			WHERE   fldDocument_HedearId=header.fldId  
			and (fldDocument_HedearId1=h1.fldId
			 or (not exists(select * from Acc.tblDocumentRecord_Details as d2 where d2.fldDocument_HedearId1=h1.fldId ) and fldDocument_HedearId1 is null )) ) flag
WHERE fldFiscalYearId like  @Value --AND fldOrganId=@fldOrganId  and fldYear=@fldYear and fldModuleSaveId=@fldMadule
	--order by fldTarikhDocument,case when fldDocumentNum=0 then 1 else 0 end ,fldDocumentNum
	order by md.maxDate desc,fldDocumentNum desc

	if (@fieldname=N'fldCaseId')
		SELECT top(@h) h1.[fldId], [fldDocumentNum],cast(atf as int ) [fldAtfNum], [fldArchiveNum], [fldDescriptionDocu],header.[fldOrganId] ,[fldTarikhDocument],header.[fldDesc], header.[fldDate], header.[fldIP], header.[fldUserId],[fldAccept] 
	,fldType,case when fldType=1 and fldaccept=1 then N'قطعی' when fldType=1 and fldaccept=0 then N'موقت' when fldType=2 then N'یادداشت' end as fldTypeName
	,cast(ShomareRoozane as int)ShomareRoozane,fldShomareFaree,f.fldYear,fldFiscalYearId
	,fldTypeSanadId as fldTypeSanad ,d.fldName    as fldTypeSanadName,m.fldTitle as fldNameModule,fldModuleErsalId,isnull(fldExistsFile,cast(0 as bit))fldIsArchive
	,case when h1.fldPId is null or fldTypeSanadId<>3 then 0 else Doc_Pid.fldDocumentNum_Pid end fldDocumentNum_Pid,isnull(h1.fldPId,0)fldPId,case when Typesanad.fldTypeSanadId_Pid is null then N'ارسال نشده' when Typesanad.fldTypeSanadId_Pid<>3 then N'ارسال شده' else sanadName.fldTypeSanadId_Pid end fldTypeSanadName_Pid
	,case when fldModuleErsalId in (5,12,13) then ACC.fn_GetSourceId(fldModuleErsalId,header.fldId) when fldPId is null  or fldModuleErsalId=fldModuleSaveId then fldDocumentNum  else (select h.fldDocumentNum from acc.tblDocumentRecord_Header1 as h where h1.fldPId=h.fldid) end fldMainDocNum,isnull(flag.fldFlag,0) as fldFlag, ACC.fn_GetArtiklMap( header.fldId, h1.fldId,h1.fldModuleErsalId) as fldIsMap,fldEdit,case when fldModuleErsalId in(12,13) then ACC.[fn_GetCaseTypeId](fldModuleErsalId,header.fldId) else 0 end as fldCaseTypeId
	FROM   [ACC].[tblDocumentRecord_Header] header 
	inner join acc.tblFiscalYear f on header.fldFiscalYearId=f.fldid
	inner join acc.tblDocumentRecord_Header1 as h1 on h1.fldDocument_HedearId=header.fldid
	inner join[ACC].[tblDocumentType] d on d.fldid=fldTypeSanadId
	inner join acc.tblDocumentRecord_Details as dd on dd.fldDocument_HedearId=header.fldId
	inner join acc.tblCoding_Details as cd on cd.fldId=dd.fldCodingId
	inner join acc.tblTemplateCoding as t on t.fldId=cd.fldTempCodingId
	left join com.tblModule m on m.fldid=fldModuleErsalId
	outer Apply(
				select atf from (select row_number()over (order by h2.fldId) atf,h2.fldid   
				from acc.tblDocumentRecord_Header h
				inner join acc.tblFiscalYear f1 on h.fldFiscalYearId=f1.fldid
				inner join acc.tblDocumentRecord_Header1 as h2 on h2.fldDocument_HedearId=h.fldid
				where h.fldOrganId=header.fldOrganId and f1.fldYear=f.fldYear 
					and h2.fldModuleSaveId=h1.fldModuleSaveId and fldDocumentNum <>0
					)t where t.fldid=h1.fldid)atfNum

		outer apply (select ShomareRoozane from (select row_number()over (order by h2.fldDate) ShomareRoozane,h2.fldid  
				from acc.tblDocumentRecord_Header h
				inner join acc.tblFiscalYear f1 on h.fldFiscalYearId=f1.fldid
				inner join acc.tblDocumentRecord_Header1 as h2 on h2.fldDocument_HedearId=h.fldid
				where h.fldOrganId=header.fldOrganId and f1.fldYear=f.fldYear 
					and h2.fldModuleSaveId=h1.fldModuleSaveId and cast(h2.fldDate as date)=cast(h1.fldDate as date) 	
					and fldDocumentNum <>0)t where t.fldid=h1.fldid)Roozane

	outer apply(select  top(1) cast(1 as bit)fldExistsFile from acc.tblDocumentRecorde_File where fldDocumentHeaderId=header.fldid)Doc_File
	cross apply(select max(fldDate) as maxDate from
			(select max(h.fldDate) fldDate from acc.tblDocumentRecord_Header1 as h where h.fldId=h1.fldId
			union all
			select max(l.fldDate) fldDate from acc.tblDocument_HeaderLog as L where l.fldHeaderId =h1.fldId
			union all
			select max(f.fldDate) fldDate from acc.tblDocumentRecorde_File as f where f.fldDocumentHeaderId=header.fldId
			union all
			select max(b.fldDate) fldDate from acc.tblDocumentRecorde_File as f 
			inner join acc.tblDocumentBookMark as b on b.fldDocumentRecordeId=f.fldId
			where f.fldDocumentHeaderId=header.fldId)t)md
	outer apply(select top 1  h.fldDocumentNum as fldDocumentNum_Pid from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldPId and h.fldId<h1.fldId order by h.fldId desc )Doc_Pid
outer apply(select top 1  h.fldTypeSanadId as fldTypeSanadId_Pid from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldId  order by h.fldId desc )Typesanad
outer apply(select (select top(1)  N'مرجوع شده (مرتبه ' +cast( ROW_NUMBER() over (order by h.fldid) as varchar(10))+')' from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldId and h.fldTypeSanadId=3 order by h.fldid desc) as fldTypeSanadId_Pid) sanadName
outer APPLY(select top(1) 1 as fldFlag
			FROM   [ACC].[tblDocumentRecord_Details] as d
			inner join acc.tblDocumentRecord_Header as h on h.fldId=d.fldDocument_HedearId
			inner join acc.[tblArtiklMap] as a on a.fldDocumentRecord_DetailsId=d.fldId
			WHERE   fldDocument_HedearId=header.fldId  
			and (fldDocument_HedearId1=h1.fldId
			 or (not exists(select * from Acc.tblDocumentRecord_Details as d2 where d2.fldDocument_HedearId1=h1.fldId ) and fldDocument_HedearId1 is null )) ) flag
WHERE fldFiscalYearId =  @Value AND dd.fldCaseId=@value1 and t.fldItemId=@value2 and fldModuleSaveId=@fldMadule
and (fldDocument_HedearId1=h1.fldId
			 or (not exists(select * from Acc.tblDocumentRecord_Details as d2 where d2.fldDocument_HedearId1=h1.fldId ) and fldDocument_HedearId1 is null )) 

	order by md.maxDate desc,fldDocumentNum desc

	if (@fieldname=N'')
	SELECT top(@h) h1.[fldId], [fldDocumentNum],cast(atf as int ) [fldAtfNum], [fldArchiveNum], [fldDescriptionDocu],header.[fldOrganId] ,[fldTarikhDocument],header.[fldDesc], header.[fldDate], header.[fldIP], header.[fldUserId],[fldAccept] 
	,fldType,case when fldType=1 and fldaccept=1 then N'قطعی' when fldType=1 and fldaccept=0 then N'موقت' when fldType=2 then N'یادداشت' end as fldTypeName
	,cast(ShomareRoozane as int)ShomareRoozane,fldShomareFaree,f.fldYear,fldFiscalYearId
,fldTypeSanadId as fldTypeSanad ,d.fldName    as fldTypeSanadName,m.fldTitle as fldNameModule,fldModuleErsalId,isnull(fldExistsFile,cast(0 as bit))fldIsArchive
	,case when h1.fldPId is null or fldTypeSanadId<>3 then 0 else Doc_Pid.fldDocumentNum_Pid end fldDocumentNum_Pid,isnull(h1.fldPId,0)fldPId,case when Typesanad.fldTypeSanadId_Pid is null then N'ارسال نشده' when Typesanad.fldTypeSanadId_Pid<>3 then N'ارسال شده' else sanadName.fldTypeSanadId_Pid end fldTypeSanadName_Pid
	,case when fldModuleErsalId in (5,12,13) then ACC.fn_GetSourceId(fldModuleErsalId,header.fldId) when fldPId is null  or fldModuleErsalId=fldModuleSaveId then fldDocumentNum  else (select h.fldDocumentNum from acc.tblDocumentRecord_Header1 as h where h1.fldPId=h.fldid) end fldMainDocNum,isnull(flag.fldFlag,0) as fldFlag, ACC.fn_GetArtiklMap( header.fldId, h1.fldId,h1.fldModuleErsalId) as fldIsMap,fldEdit,case when fldModuleErsalId in(12,13) then ACC.[fn_GetCaseTypeId](fldModuleErsalId,header.fldId) else 0 end as fldCaseTypeId
	FROM   [ACC].[tblDocumentRecord_Header] header 
	inner join acc.tblFiscalYear f on header.fldFiscalYearId=f.fldid
	inner join acc.tblDocumentRecord_Header1 as h1 on h1.fldDocument_HedearId=header.fldid
	inner join[ACC].[tblDocumentType] d on d.fldid=fldTypeSanadId
	left join com.tblModule m on m.fldid=fldModuleErsalId
	outer Apply(
				select atf from (select row_number()over (order by h2.fldId) atf,h2.fldid   
				from acc.tblDocumentRecord_Header h
				inner join acc.tblFiscalYear f1 on h.fldFiscalYearId=f1.fldid
				inner join acc.tblDocumentRecord_Header1 as h2 on h2.fldDocument_HedearId=h.fldid
				where h.fldOrganId=header.fldOrganId and f1.fldYear=f.fldYear 
					and h2.fldModuleSaveId=h1.fldModuleSaveId and fldDocumentNum <>0
					)t where t.fldid=h1.fldid)atfNum

	outer apply (select ShomareRoozane from (select row_number()over (order by h2.fldDate) ShomareRoozane,h2.fldid  
				from acc.tblDocumentRecord_Header h
				inner join acc.tblFiscalYear f1 on h.fldFiscalYearId=f1.fldid
				inner join acc.tblDocumentRecord_Header1 as h2 on h2.fldDocument_HedearId=h.fldid
				where h.fldOrganId=header.fldOrganId and f1.fldYear=f.fldYear 
					and h2.fldModuleSaveId=h1.fldModuleSaveId and cast(h2.fldDate as date)=cast(h1.fldDate as date) 	
					and fldDocumentNum <>0)t where t.fldid=h1.fldid)Roozane

	outer apply(select  top(1) cast(1 as bit)fldExistsFile from acc.tblDocumentRecorde_File where fldDocumentHeaderId=header.fldid)Doc_File
	cross apply(select max(fldDate) as maxDate from
			(select max(h.fldDate) fldDate from acc.tblDocumentRecord_Header1 as h where h.fldId=h1.fldId
			union all
			select max(l.fldDate) fldDate from acc.tblDocument_HeaderLog as L where l.fldHeaderId =h1.fldId
			union all
			select max(f.fldDate) fldDate from acc.tblDocumentRecorde_File as f where f.fldDocumentHeaderId=header.fldId
			union all
			select max(b.fldDate) fldDate from acc.tblDocumentRecorde_File as f 
			inner join acc.tblDocumentBookMark as b on b.fldDocumentRecordeId=f.fldId
			where f.fldDocumentHeaderId=header.fldId)t)md
outer apply(select top 1  h.fldDocumentNum as fldDocumentNum_Pid from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldPId and h.fldId<h1.fldId order by h.fldId desc )Doc_Pid
outer apply(select top 1  h.fldTypeSanadId as fldTypeSanadId_Pid from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldId  order by h.fldId desc )Typesanad
outer apply(select (select top(1)  N'مرجوع شده (مرتبه ' +cast( ROW_NUMBER() over (order by h.fldid) as varchar(10))+')' from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldId and h.fldTypeSanadId=3 order by h.fldid desc) as fldTypeSanadId_Pid) sanadName
outer APPLY(select top(1) 1 as fldFlag
			FROM   [ACC].[tblDocumentRecord_Details] as d
			inner join acc.tblDocumentRecord_Header as h on h.fldId=d.fldDocument_HedearId
			inner join acc.[tblArtiklMap] as a on a.fldDocumentRecord_DetailsId=d.fldId
			WHERE   fldDocument_HedearId=header.fldId  
			and (fldDocument_HedearId1=h1.fldId
			 or (not exists(select * from Acc.tblDocumentRecord_Details as d2 where d2.fldDocument_HedearId1=h1.fldId ) and fldDocument_HedearId1 is null )) ) flag
					where header.fldOrganId=@fldOrganId  and f.fldYear=@fldYear and h1.fldModuleSaveId=@fldMadule
					--order by fldTarikhDocument,case when fldDocumentNum=0 then 1 else 0 end ,fldDocumentNum
			order by md.maxDate desc,fldDocumentNum desc


	
	if (@fieldname=N'fldTypeName')
	SELECT top(@h) [fldId], [fldDocumentNum], [fldAtfNum], [fldArchiveNum], [fldDescriptionDocu],[fldOrganId] ,[fldTarikhDocument],[fldDesc],[fldDate], [fldIP], [fldUserId],[fldAccept] 
	,fldType,fldTypeName
	,ShomareRoozane,fldShomareFaree,fldYear,fldFiscalYearId
	, fldTypeSanad , fldTypeSanadName, fldNameModule,fldModuleErsalId,fldIsArchive
	,fldDocumentNum_Pid
	, fldMainDocNum, fldFlag
	,fldPId, fldTypeSanadName_Pid from(	SELECT  h1.[fldId], [fldDocumentNum],cast(atf as int ) [fldAtfNum], [fldArchiveNum], [fldDescriptionDocu],header.[fldOrganId] ,[fldTarikhDocument],header.[fldDesc], header.[fldDate], header.[fldIP], header.[fldUserId],[fldAccept] 
	,fldType,case when fldType=1 and fldaccept=1 then N'قطعی' when fldType=1 and fldaccept=0 then N'موقت' when fldType=2 then N'یادداشت' end as fldTypeName
	,cast(ShomareRoozane as int)ShomareRoozane,fldShomareFaree,f.fldYear,fldFiscalYearId
	,fldTypeSanadId as fldTypeSanad ,d.fldName    as fldTypeSanadName,m.fldTitle as fldNameModule,fldModuleErsalId,isnull(fldExistsFile,cast(0 as bit))fldIsArchive
	,case when h1.fldPId is null or fldTypeSanadId<>3 then 0 else Doc_Pid.fldDocumentNum_Pid end fldDocumentNum_Pid
	,case when fldModuleErsalId in (5,12,13) then ACC.fn_GetSourceId(fldModuleErsalId,header.fldId) when fldPId is null  or fldModuleErsalId=fldModuleSaveId then fldDocumentNum  else (select h.fldDocumentNum from acc.tblDocumentRecord_Header1 as h where h1.fldPId=h.fldid) end fldMainDocNum,isnull(flag.fldFlag,0) as fldFlag, ACC.fn_GetArtiklMap( header.fldId, h1.fldId,h1.fldModuleErsalId) as fldIsMap,fldEdit,case when fldModuleErsalId in(12,13) then ACC.[fn_GetCaseTypeId](fldModuleErsalId,header.fldId) else 0 end as fldCaseTypeId
	,isnull(h1.fldPId,0)fldPId,case when Typesanad.fldTypeSanadId_Pid is null then N'ارسال نشده' when Typesanad.fldTypeSanadId_Pid<>3 then N'ارسال شده' else sanadName.fldTypeSanadId_Pid end fldTypeSanadName_Pid
	,h1.fldDocument_HedearId
	FROM   [ACC].[tblDocumentRecord_Header] header 
	inner join acc.tblFiscalYear f on header.fldFiscalYearId=f.fldid
	inner join acc.tblDocumentRecord_Header1 as h1 on h1.fldDocument_HedearId=header.fldid
	inner join[ACC].[tblDocumentType] d on d.fldid=fldTypeSanadId
	left join com.tblModule m on m.fldid=fldModuleErsalId
	outer Apply(
				select atf from (select row_number()over (order by h2.fldId) atf,h2.fldid   
				from acc.tblDocumentRecord_Header h
				inner join acc.tblFiscalYear f1 on h.fldFiscalYearId=f1.fldid
				inner join acc.tblDocumentRecord_Header1 as h2 on h2.fldDocument_HedearId=h.fldid
				where h.fldOrganId=header.fldOrganId and f1.fldYear=f.fldYear 
					and h2.fldModuleSaveId=h1.fldModuleSaveId and fldDocumentNum <>0
					)t where t.fldid=h1.fldid)atfNum
	outer apply (select ShomareRoozane from (select row_number()over (order by h2.fldDate) ShomareRoozane,h2.fldid  
				from acc.tblDocumentRecord_Header h
				inner join acc.tblFiscalYear f1 on h.fldFiscalYearId=f1.fldid
				inner join acc.tblDocumentRecord_Header1 as h2 on h2.fldDocument_HedearId=h.fldid
				where h.fldOrganId=header.fldOrganId and f1.fldYear=f.fldYear 
					and h2.fldModuleSaveId=h1.fldModuleSaveId and cast(h2.fldDate as date)=cast(h1.fldDate as date) 	
					and fldDocumentNum <>0)t where t.fldid=h1.fldid)Roozane

	outer apply(select  top(1) cast(1 as bit)fldExistsFile from acc.tblDocumentRecorde_File where fldDocumentHeaderId=header.fldid)Doc_File
	outer apply(select top 1  h.fldDocumentNum as fldDocumentNum_Pid from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldPId and h.fldId<h1.fldId order by h.fldId desc )Doc_Pid
outer apply(select top 1  h.fldTypeSanadId as fldTypeSanadId_Pid from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldId  order by h.fldId desc )Typesanad
outer apply(select (select top(1)  N'مرجوع شده (مرتبه ' +cast( ROW_NUMBER() over (order by h.fldid) as varchar(10))+')' from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldId and h.fldTypeSanadId=3 order by h.fldid desc) as fldTypeSanadId_Pid) sanadName
outer APPLY(select top(1) 1 as fldFlag
			FROM   [ACC].[tblDocumentRecord_Details] as d
			inner join acc.tblDocumentRecord_Header as h on h.fldId=d.fldDocument_HedearId
			inner join acc.[tblArtiklMap] as a on a.fldDocumentRecord_DetailsId=d.fldId
			WHERE   fldDocument_HedearId=header.fldId  
			and (fldDocument_HedearId1=h1.fldId
			 or (not exists(select * from Acc.tblDocumentRecord_Details as d2 where d2.fldDocument_HedearId1=h1.fldId ) and fldDocument_HedearId1 is null )) ) flag

					where header.fldOrganId=@fldOrganId  and f.fldYear=@fldYear and h1.fldModuleSaveId=@fldMadule
					)t
	cross apply(select max(fldDate) as maxDate from
			(select max(h.fldDate) fldDate from acc.tblDocumentRecord_Header1 as h where h.fldId=t.fldId
			union all
			select max(l.fldDate) fldDate from acc.tblDocument_HeaderLog as L where l.fldHeaderId =t.fldId
			union all
			select max(f.fldDate) fldDate from acc.tblDocumentRecorde_File as f where f.fldDocumentHeaderId=t.fldDocument_HedearId
			union all
			select max(b.fldDate) fldDate from acc.tblDocumentRecorde_File as f 
			inner join acc.tblDocumentBookMark as b on b.fldDocumentRecordeId=f.fldId
			where f.fldDocumentHeaderId=t.fldDocument_HedearId)t)md
	WHERE fldTypeName like  @Value 
	--order by fldTarikhDocument,case when fldDocumentNum=0 then 1 else 0 end ,fldDocumentNum
	order by md.maxDate desc,fldDocumentNum desc

	
	if (@fieldname=N'fldTypeSanadName_Pid')
	SELECT top(@h) [fldId], [fldDocumentNum], [fldAtfNum], [fldArchiveNum], [fldDescriptionDocu],[fldOrganId] ,[fldTarikhDocument],[fldDesc],[fldDate], [fldIP], [fldUserId],[fldAccept] 
	,fldType,fldTypeName
	,ShomareRoozane,fldShomareFaree,fldYear,fldFiscalYearId
	, fldTypeSanad , fldTypeSanadName, fldNameModule,fldModuleErsalId,fldIsArchive
	,fldDocumentNum_Pid
	, fldMainDocNum, fldFlag
	,fldPId, fldTypeSanadName_Pid
 from(	SELECT  h1.[fldId], [fldDocumentNum],cast(atf as int ) [fldAtfNum], [fldArchiveNum], [fldDescriptionDocu],header.[fldOrganId] ,[fldTarikhDocument],header.[fldDesc], header.[fldDate], header.[fldIP], header.[fldUserId],[fldAccept] 
	,fldType,case when fldType=1 and fldaccept=1 then N'قطعی' when fldType=1 and fldaccept=0 then N'موقت' when fldType=2 then N'یادداشت' end as fldTypeName
	,cast(ShomareRoozane as int)ShomareRoozane,fldShomareFaree,f.fldYear,fldFiscalYearId
	,fldTypeSanadId as fldTypeSanad ,d.fldName    as fldTypeSanadName,m.fldTitle as fldNameModule,fldModuleErsalId,isnull(fldExistsFile,cast(0 as bit))fldIsArchive
	,case when h1.fldPId is null or fldTypeSanadId<>3 then 0 else Doc_Pid.fldDocumentNum_Pid end fldDocumentNum_Pid
	,case when fldModuleErsalId in (5,12,13) then ACC.fn_GetSourceId(fldModuleErsalId,header.fldId) when fldPId is null  or fldModuleErsalId=fldModuleSaveId then fldDocumentNum  else (select h.fldDocumentNum from acc.tblDocumentRecord_Header1 as h where h1.fldPId=h.fldid) end fldMainDocNum,isnull(flag.fldFlag,0) as fldFlag, ACC.fn_GetArtiklMap( header.fldId, h1.fldId,h1.fldModuleErsalId) as fldIsMap,fldEdit,case when fldModuleErsalId in(12,13) then ACC.[fn_GetCaseTypeId](fldModuleErsalId,header.fldId) else 0 end as fldCaseTypeId
	,isnull(h1.fldPId,0)fldPId,case when Typesanad.fldTypeSanadId_Pid is null then N'ارسال نشده' when Typesanad.fldTypeSanadId_Pid<>3 then N'ارسال شده' else sanadName.fldTypeSanadId_Pid end fldTypeSanadName_Pid
	,h1.fldDocument_HedearId
	FROM   [ACC].[tblDocumentRecord_Header] header 
	inner join acc.tblFiscalYear f on header.fldFiscalYearId=f.fldid
	inner join acc.tblDocumentRecord_Header1 as h1 on h1.fldDocument_HedearId=header.fldid
	inner join[ACC].[tblDocumentType] d on d.fldid=fldTypeSanadId
	left join com.tblModule m on m.fldid=fldModuleErsalId
	outer Apply(
				select atf from (select row_number()over (order by h2.fldId) atf,h2.fldid   
				from acc.tblDocumentRecord_Header h
				inner join acc.tblFiscalYear f1 on h.fldFiscalYearId=f1.fldid
				inner join acc.tblDocumentRecord_Header1 as h2 on h2.fldDocument_HedearId=h.fldid
				where h.fldOrganId=header.fldOrganId and f1.fldYear=f.fldYear 
					and h2.fldModuleSaveId=h1.fldModuleSaveId and fldDocumentNum <>0
					)t where t.fldid=h1.fldid)atfNum
	outer apply (select ShomareRoozane from (select row_number()over (order by h2.fldDate) ShomareRoozane,h2.fldid  
				from acc.tblDocumentRecord_Header h
				inner join acc.tblFiscalYear f1 on h.fldFiscalYearId=f1.fldid
				inner join acc.tblDocumentRecord_Header1 as h2 on h2.fldDocument_HedearId=h.fldid
				where h.fldOrganId=header.fldOrganId and f1.fldYear=f.fldYear 
					and h2.fldModuleSaveId=h1.fldModuleSaveId and cast(h2.fldDate as date)=cast(h1.fldDate as date) 	
					and fldDocumentNum <>0)t where t.fldid=h1.fldid)Roozane

	outer apply(select  top(1) cast(1 as bit)fldExistsFile from acc.tblDocumentRecorde_File where fldDocumentHeaderId=header.fldid)Doc_File
	outer apply(select top 1  h.fldDocumentNum as fldDocumentNum_Pid from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldPId and h.fldId<h1.fldId order by h.fldId desc )Doc_Pid
outer apply(select top 1  h.fldTypeSanadId as fldTypeSanadId_Pid from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldId  order by h.fldId desc )Typesanad
outer apply(select (select top(1)  N'مرجوع شده (مرتبه ' +cast( ROW_NUMBER() over (order by h.fldid) as varchar(10))+')' from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldId and h.fldTypeSanadId=3 order by h.fldid desc) as fldTypeSanadId_Pid) sanadName
outer APPLY(select top(1) 1 as fldFlag
			FROM   [ACC].[tblDocumentRecord_Details] as d
			inner join acc.tblDocumentRecord_Header as h on h.fldId=d.fldDocument_HedearId
			inner join acc.[tblArtiklMap] as a on a.fldDocumentRecord_DetailsId=d.fldId
			WHERE   fldDocument_HedearId=header.fldId  
			and (fldDocument_HedearId1=h1.fldId
			 or (not exists(select * from Acc.tblDocumentRecord_Details as d2 where d2.fldDocument_HedearId1=h1.fldId ) and fldDocument_HedearId1 is null )) ) flag
					where header.fldOrganId=@fldOrganId  and f.fldYear=@fldYear and h1.fldModuleSaveId=@fldMadule
					)t
	cross apply(select max(fldDate) as maxDate from
			(select max(h.fldDate) fldDate from acc.tblDocumentRecord_Header1 as h where h.fldId=t.fldId
			union all
			select max(l.fldDate) fldDate from acc.tblDocument_HeaderLog as L where l.fldHeaderId =t.fldId
			union all
			select max(f.fldDate) fldDate from acc.tblDocumentRecorde_File as f where f.fldDocumentHeaderId=t.fldDocument_HedearId
			union all
			select max(b.fldDate) fldDate from acc.tblDocumentRecorde_File as f 
			inner join acc.tblDocumentBookMark as b on b.fldDocumentRecordeId=f.fldId
			where f.fldDocumentHeaderId=t.fldDocument_HedearId)t)md
	WHERE fldTypeSanadName_Pid like  @Value 
	--order by fldTarikhDocument,case when fldDocumentNum=0 then 1 else 0 end ,fldDocumentNum
	order by md.maxDate desc,fldDocumentNum desc

	if (@fieldname=N'fldMainDocNum')
	SELECT top(@h)  [fldId], [fldDocumentNum], [fldAtfNum], [fldArchiveNum], [fldDescriptionDocu],[fldOrganId] ,[fldTarikhDocument],[fldDesc],[fldDate], [fldIP], [fldUserId],[fldAccept] 
	,fldType,fldTypeName
	,ShomareRoozane,fldShomareFaree,fldYear,fldFiscalYearId
	, fldTypeSanad , fldTypeSanadName, fldNameModule,fldModuleErsalId,fldIsArchive
	,fldDocumentNum_Pid
	, fldMainDocNum, fldFlag
	,fldPId, fldTypeSanadName_Pid from(	SELECT  h1.[fldId], [fldDocumentNum],cast(atf as int ) [fldAtfNum], [fldArchiveNum], [fldDescriptionDocu],header.[fldOrganId] ,[fldTarikhDocument],header.[fldDesc], header.[fldDate], header.[fldIP], header.[fldUserId],[fldAccept] 
	,fldType,case when fldType=1 and fldaccept=1 then N'قطعی' when fldType=1 and fldaccept=0 then N'موقت' when fldType=2 then N'یادداشت' end as fldTypeName
	,cast(ShomareRoozane as int)ShomareRoozane,fldShomareFaree,f.fldYear,fldFiscalYearId
	,fldTypeSanadId as fldTypeSanad ,d.fldName    as fldTypeSanadName,m.fldTitle as fldNameModule,fldModuleErsalId,isnull(fldExistsFile,cast(0 as bit))fldIsArchive
	,case when h1.fldPId is null or fldTypeSanadId<>3 then 0 else Doc_Pid.fldDocumentNum_Pid end fldDocumentNum_Pid
	,case when fldModuleErsalId in (5,12,13) then ACC.fn_GetSourceId(fldModuleErsalId,header.fldId) when fldPId is null  or fldModuleErsalId=fldModuleSaveId then fldDocumentNum  
	else (select h.fldDocumentNum from acc.tblDocumentRecord_Header1 as h where h1.fldPId=h.fldid) end fldMainDocNum,isnull(flag.fldFlag,0) as fldFlag, ACC.fn_GetArtiklMap( header.fldId, h1.fldId,h1.fldModuleErsalId) as fldIsMap,fldEdit,case when fldModuleErsalId in(12,13) then ACC.[fn_GetCaseTypeId](fldModuleErsalId,header.fldId) else 0 end as fldCaseTypeId
	,isnull(h1.fldPId,0)fldPId,case when Typesanad.fldTypeSanadId_Pid is null then N'ارسال نشده' when Typesanad.fldTypeSanadId_Pid<>3 then N'ارسال شده' else sanadName.fldTypeSanadId_Pid end fldTypeSanadName_Pid
	,h1.fldDocument_HedearId
	FROM   [ACC].[tblDocumentRecord_Header] header inner join acc.tblFiscalYear f on header.fldFiscalYearId=f.fldid
	inner join acc.tblDocumentRecord_Header1 as h1 on h1.fldDocument_HedearId=header.fldid
	inner join[ACC].[tblDocumentType] d on d.fldid=fldTypeSanadId
	left join com.tblModule m on m.fldid=fldModuleErsalId
	outer Apply(
				select atf from (select row_number()over (order by h2.fldId) atf,h2.fldid   
				from acc.tblDocumentRecord_Header h
				inner join acc.tblFiscalYear f1 on h.fldFiscalYearId=f1.fldid
				inner join acc.tblDocumentRecord_Header1 as h2 on h2.fldDocument_HedearId=h.fldid
				where h.fldOrganId=header.fldOrganId and f1.fldYear=f.fldYear 
					and h2.fldModuleSaveId=h1.fldModuleSaveId and fldDocumentNum <>0
					)t where t.fldid=h1.fldid)atfNum
		outer apply (select ShomareRoozane from (select row_number()over (order by h2.fldDate) ShomareRoozane,h2.fldid  
				from acc.tblDocumentRecord_Header h
				inner join acc.tblFiscalYear f1 on h.fldFiscalYearId=f1.fldid
				inner join acc.tblDocumentRecord_Header1 as h2 on h2.fldDocument_HedearId=h.fldid
				where h.fldOrganId=header.fldOrganId and f1.fldYear=f.fldYear 
					and h2.fldModuleSaveId=h1.fldModuleSaveId and cast(h2.fldDate as date)=cast(h1.fldDate as date) 	
					and fldDocumentNum <>0)t where t.fldid=h1.fldid)Roozane

	outer apply(select  top(1) cast(1 as bit)fldExistsFile from acc.tblDocumentRecorde_File where fldDocumentHeaderId=header.fldid)Doc_File
	outer apply(select top 1  h.fldDocumentNum as fldDocumentNum_Pid from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldPId and h.fldId<h1.fldId order by h.fldId desc )Doc_Pid
outer apply(select top 1  h.fldTypeSanadId as fldTypeSanadId_Pid from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldId  order by h.fldId desc )Typesanad
outer apply(select (select top(1)  N'مرجوع شده (مرتبه ' +cast( ROW_NUMBER() over (order by h.fldid) as varchar(10))+')' from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldId and h.fldTypeSanadId=3 order by h.fldid desc) as fldTypeSanadId_Pid) sanadName
outer APPLY(select top(1) 1 as fldFlag
			FROM   [ACC].[tblDocumentRecord_Details] as d
			inner join acc.tblDocumentRecord_Header as h on h.fldId=d.fldDocument_HedearId
			inner join acc.[tblArtiklMap] as a on a.fldDocumentRecord_DetailsId=d.fldId
			WHERE   fldDocument_HedearId=header.fldId  
			and (fldDocument_HedearId1=h1.fldId
			 or (not exists(select * from Acc.tblDocumentRecord_Details as d2 where d2.fldDocument_HedearId1=h1.fldId ) and fldDocument_HedearId1 is null )) ) flag

					where header.fldOrganId=@fldOrganId  and f.fldYear=@fldYear and h1.fldModuleSaveId=@fldMadule
					)t
	cross apply(select max(fldDate) as maxDate from
			(select max(h.fldDate) fldDate from acc.tblDocumentRecord_Header1 as h where h.fldId=t.fldId
			union all
			select max(l.fldDate) fldDate from acc.tblDocument_HeaderLog as L where l.fldHeaderId =t.fldId
			union all
			select max(f.fldDate) fldDate from acc.tblDocumentRecorde_File as f where f.fldDocumentHeaderId=t.fldDocument_HedearId
			union all
			select max(b.fldDate) fldDate from acc.tblDocumentRecorde_File as f 
			inner join acc.tblDocumentBookMark as b on b.fldDocumentRecordeId=f.fldId
			where f.fldDocumentHeaderId=t.fldDocument_HedearId)t)md
	WHERE fldMainDocNum like  @Value 
	--order by fldTarikhDocument,case when fldDocumentNum=0 then 1 else 0 end ,fldDocumentNum
	order by md.maxDate desc,fldDocumentNum desc
	
	if (@fieldname=N'fldDocumentNum')
		SELECT top(@h) h1.[fldId], [fldDocumentNum],cast(atf as int ) [fldAtfNum], [fldArchiveNum], [fldDescriptionDocu],header.[fldOrganId] ,[fldTarikhDocument],header.[fldDesc], header.[fldDate], header.[fldIP], header.[fldUserId],[fldAccept] 
	,fldType,case when fldType=1 and fldaccept=1 then N'قطعی' when fldType=1 and fldaccept=0 then N'موقت' when fldType=2 then N'یادداشت' end as fldTypeName
	,cast(ShomareRoozane as int)ShomareRoozane,fldShomareFaree,f.fldYear,fldFiscalYearId
	,fldTypeSanadId as fldTypeSanad ,d.fldName    as fldTypeSanadName,m.fldTitle as fldNameModule,fldModuleErsalId,isnull(fldExistsFile,cast(0 as bit))fldIsArchive
	,case when h1.fldPId is null or fldTypeSanadId<>3 then 0 else Doc_Pid.fldDocumentNum_Pid end fldDocumentNum_Pid,isnull(h1.fldPId,0)fldPId,case when Typesanad.fldTypeSanadId_Pid is null then N'ارسال نشده' when Typesanad.fldTypeSanadId_Pid<>3 then N'ارسال شده' else sanadName.fldTypeSanadId_Pid end fldTypeSanadName_Pid
	,case when fldModuleErsalId in (5,12,13) then ACC.fn_GetSourceId(fldModuleErsalId,header.fldId) when fldPId is null  or fldModuleErsalId=fldModuleSaveId then fldDocumentNum  else (select h.fldDocumentNum from acc.tblDocumentRecord_Header1 as h where h1.fldPId=h.fldid) end fldMainDocNum,isnull(flag.fldFlag,0) as fldFlag, ACC.fn_GetArtiklMap( header.fldId, h1.fldId,h1.fldModuleErsalId) as fldIsMap,fldEdit,case when fldModuleErsalId in(12,13) then ACC.[fn_GetCaseTypeId](fldModuleErsalId,header.fldId) else 0 end as fldCaseTypeId
	FROM   [ACC].[tblDocumentRecord_Header] header inner join acc.tblFiscalYear f on header.fldFiscalYearId=f.fldid
	inner join acc.tblDocumentRecord_Header1 as h1 on h1.fldDocument_HedearId=header.fldid
	inner join[ACC].[tblDocumentType] d on d.fldid=fldTypeSanadId
	left join com.tblModule m on m.fldid=fldModuleErsalId
	outer Apply(
				select atf from (select row_number()over (order by h2.fldId) atf,h2.fldid   
				from acc.tblDocumentRecord_Header h
				inner join acc.tblFiscalYear f1 on h.fldFiscalYearId=f1.fldid
				inner join acc.tblDocumentRecord_Header1 as h2 on h2.fldDocument_HedearId=h.fldid
				where h.fldOrganId=header.fldOrganId and f1.fldYear=f.fldYear 
					and h2.fldModuleSaveId=h1.fldModuleSaveId and fldDocumentNum <>0
					)t where t.fldid=h1.fldid)atfNum

		outer apply (select ShomareRoozane from (select row_number()over (order by h2.fldDate) ShomareRoozane,h2.fldid  
				from acc.tblDocumentRecord_Header h
				inner join acc.tblFiscalYear f1 on h.fldFiscalYearId=f1.fldid
				inner join acc.tblDocumentRecord_Header1 as h2 on h2.fldDocument_HedearId=h.fldid
				where h.fldOrganId=header.fldOrganId and f1.fldYear=f.fldYear 
					and h2.fldModuleSaveId=h1.fldModuleSaveId and cast(h2.fldDate as date)=cast(h1.fldDate as date) 	
					and fldDocumentNum <>0)t where t.fldid=h1.fldid)Roozane

	outer apply(select  top(1) cast(1 as bit)fldExistsFile from acc.tblDocumentRecorde_File where fldDocumentHeaderId=header.fldid)Doc_File
	cross apply(select max(fldDate) as maxDate from
			(select max(h.fldDate) fldDate from acc.tblDocumentRecord_Header1 as h where h.fldId=h1.fldId
			union all
			select max(l.fldDate) fldDate from acc.tblDocument_HeaderLog as L where l.fldHeaderId =h1.fldId
			union all
			select max(f.fldDate) fldDate from acc.tblDocumentRecorde_File as f where f.fldDocumentHeaderId=header.fldId
			union all
			select max(b.fldDate) fldDate from acc.tblDocumentRecorde_File as f 
			inner join acc.tblDocumentBookMark as b on b.fldDocumentRecordeId=f.fldId
			where f.fldDocumentHeaderId=header.fldId)t)md
outer apply(select top 1  h.fldDocumentNum as fldDocumentNum_Pid from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldPId and h.fldId<h1.fldId order by h.fldId desc )Doc_Pid
outer apply(select top 1  h.fldTypeSanadId as fldTypeSanadId_Pid from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldId  order by h.fldId desc )Typesanad
outer apply(select (select top(1)  N'مرجوع شده (مرتبه ' +cast( ROW_NUMBER() over (order by h.fldid) as varchar(10))+')' from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldId and h.fldTypeSanadId=3 order by h.fldid desc) as fldTypeSanadId_Pid) sanadName
outer APPLY(select top(1) 1 as fldFlag
			FROM   [ACC].[tblDocumentRecord_Details] as d
			inner join acc.tblDocumentRecord_Header as h on h.fldId=d.fldDocument_HedearId
			inner join acc.[tblArtiklMap] as a on a.fldDocumentRecord_DetailsId=d.fldId
			WHERE   fldDocument_HedearId=header.fldId  
			and (fldDocument_HedearId1=h1.fldId
			 or (not exists(select * from Acc.tblDocumentRecord_Details as d2 where d2.fldDocument_HedearId1=h1.fldId ) and fldDocument_HedearId1 is null )) ) flag
WHERE fldDocumentNum like  @Value AND header.fldOrganId=@fldOrganId  and f.fldYear=@fldYear and h1.fldModuleSaveId=@fldMadule
	--order by fldTarikhDocument,case when fldDocumentNum=0 then 1 else 0 end ,fldDocumentNum
	order by md.maxDate desc,fldDocumentNum desc

	
	
	
	if (@fieldname=N'fldAtfNum')
		SELECT top(@h) h1.[fldId], [fldDocumentNum],cast(atf as int ) [fldAtfNum], [fldArchiveNum], [fldDescriptionDocu],header.[fldOrganId] ,[fldTarikhDocument],header.[fldDesc], header.[fldDate], header.[fldIP], header.[fldUserId],[fldAccept] 
	,fldType,case when fldType=1 and fldaccept=1 then N'قطعی' when fldType=1 and fldaccept=0 then N'موقت' when fldType=2 then N'یادداشت' end as fldTypeName
	,cast(ShomareRoozane as int)ShomareRoozane,fldShomareFaree,f.fldYear,fldFiscalYearId
	,fldTypeSanadId as fldTypeSanad ,d.fldName    as fldTypeSanadName,m.fldTitle as fldNameModule,fldModuleErsalId,isnull(fldExistsFile,cast(0 as bit))fldIsArchive
	,case when h1.fldPId is null or fldTypeSanadId<>3 then 0 else Doc_Pid.fldDocumentNum_Pid end fldDocumentNum_Pid,isnull(h1.fldPId,0)fldPId,case when Typesanad.fldTypeSanadId_Pid is null then N'ارسال نشده' when Typesanad.fldTypeSanadId_Pid<>3 then N'ارسال شده' else sanadName.fldTypeSanadId_Pid end fldTypeSanadName_Pid
	,case when fldModuleErsalId in (5,12,13) then ACC.fn_GetSourceId(fldModuleErsalId,header.fldId) when fldPId is null  or fldModuleErsalId=fldModuleSaveId then fldDocumentNum  else (select h.fldDocumentNum from acc.tblDocumentRecord_Header1 as h where h1.fldPId=h.fldid) end fldMainDocNum,isnull(flag.fldFlag,0) as fldFlag, ACC.fn_GetArtiklMap( header.fldId, h1.fldId,h1.fldModuleErsalId) as fldIsMap,fldEdit,case when fldModuleErsalId in(12,13) then ACC.[fn_GetCaseTypeId](fldModuleErsalId,header.fldId) else 0 end as fldCaseTypeId
	FROM   [ACC].[tblDocumentRecord_Header] header inner join acc.tblFiscalYear f on header.fldFiscalYearId=f.fldid
	inner join acc.tblDocumentRecord_Header1 as h1 on h1.fldDocument_HedearId=header.fldid
	inner join[ACC].[tblDocumentType] d on d.fldid=fldTypeSanadId
	left join com.tblModule m on m.fldid=fldModuleErsalId
	outer Apply(
				select atf from (select row_number()over (order by h2.fldId) atf,h2.fldid   
				from acc.tblDocumentRecord_Header h
				inner join acc.tblFiscalYear f1 on h.fldFiscalYearId=f1.fldid
				inner join acc.tblDocumentRecord_Header1 as h2 on h2.fldDocument_HedearId=h.fldid
				where h.fldOrganId=header.fldOrganId and f1.fldYear=f.fldYear 
					and h2.fldModuleSaveId=h1.fldModuleSaveId and fldDocumentNum <>0
					)t where t.fldid=h1.fldid)atfNum

	outer apply (select ShomareRoozane from (select row_number()over (order by h2.fldDate) ShomareRoozane,h2.fldid  
				from acc.tblDocumentRecord_Header h
				inner join acc.tblFiscalYear f1 on h.fldFiscalYearId=f1.fldid
				inner join acc.tblDocumentRecord_Header1 as h2 on h2.fldDocument_HedearId=h.fldid
				where h.fldOrganId=header.fldOrganId and f1.fldYear=f.fldYear 
					and h2.fldModuleSaveId=h1.fldModuleSaveId and cast(h2.fldDate as date)=cast(h1.fldDate as date) 	
					and fldDocumentNum <>0)t where t.fldid=h1.fldid)Roozane

	outer apply(select  top(1) cast(1 as bit)fldExistsFile from acc.tblDocumentRecorde_File where fldDocumentHeaderId=header.fldid)Doc_File
	cross apply(select max(fldDate) as maxDate from
			(select max(h.fldDate) fldDate from acc.tblDocumentRecord_Header1 as h where h.fldId=h1.fldId
			union all
			select max(l.fldDate) fldDate from acc.tblDocument_HeaderLog as L where l.fldHeaderId =h1.fldId
			union all
			select max(f.fldDate) fldDate from acc.tblDocumentRecorde_File as f where f.fldDocumentHeaderId=header.fldId
			union all
			select max(b.fldDate) fldDate from acc.tblDocumentRecorde_File as f 
			inner join acc.tblDocumentBookMark as b on b.fldDocumentRecordeId=f.fldId
			where f.fldDocumentHeaderId=header.fldId)t)md
outer apply(select top 1  h.fldDocumentNum as fldDocumentNum_Pid from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldPId and h.fldId<h1.fldId order by h.fldId desc )Doc_Pid
outer apply(select top 1  h.fldTypeSanadId as fldTypeSanadId_Pid from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldId  order by h.fldId desc )Typesanad
outer apply(select (select top(1)  N'مرجوع شده (مرتبه ' +cast( ROW_NUMBER() over (order by h.fldid) as varchar(10))+')' from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldId and h.fldTypeSanadId=3 order by h.fldid desc) as fldTypeSanadId_Pid) sanadName
outer APPLY(select top(1) 1 as fldFlag
			FROM   [ACC].[tblDocumentRecord_Details] as d
			inner join acc.tblDocumentRecord_Header as h on h.fldId=d.fldDocument_HedearId
			inner join acc.[tblArtiklMap] as a on a.fldDocumentRecord_DetailsId=d.fldId
			WHERE   fldDocument_HedearId=header.fldId  
			and (fldDocument_HedearId1=h1.fldId
			 or (not exists(select * from Acc.tblDocumentRecord_Details as d2 where d2.fldDocument_HedearId1=h1.fldId ) and fldDocument_HedearId1 is null )) ) flag
WHERE atf like  @Value AND header.fldOrganId=@fldOrganId  and f.fldYear=@fldYear and h1.fldModuleSaveId=@fldMadule
	--order by fldTarikhDocument,case when fldDocumentNum=0 then 1 else 0 end ,fldDocumentNum
	order by md.maxDate desc,fldDocumentNum desc

	
	

	if (@fieldname=N'fldArchiveNum')
		SELECT top(@h) h1.[fldId], [fldDocumentNum],cast(atf as int ) [fldAtfNum], [fldArchiveNum], [fldDescriptionDocu],header.[fldOrganId] ,[fldTarikhDocument],header.[fldDesc], header.[fldDate], header.[fldIP], header.[fldUserId],[fldAccept] 
	,fldType,case when fldType=1 and fldaccept=1 then N'قطعی' when fldType=1 and fldaccept=0 then N'موقت' when fldType=2 then N'یادداشت' end as fldTypeName
	,cast(ShomareRoozane as int)ShomareRoozane,fldShomareFaree,f.fldYear,fldFiscalYearId
	,fldTypeSanadId as fldTypeSanad ,d.fldName    as fldTypeSanadName,m.fldTitle as fldNameModule,fldModuleErsalId,isnull(fldExistsFile,cast(0 as bit))fldIsArchive
	,case when h1.fldPId is null or fldTypeSanadId<>3 then 0 else Doc_Pid.fldDocumentNum_Pid end fldDocumentNum_Pid,isnull(h1.fldPId,0)fldPId,case when Typesanad.fldTypeSanadId_Pid is null then N'ارسال نشده' when Typesanad.fldTypeSanadId_Pid<>3 then N'ارسال شده' else sanadName.fldTypeSanadId_Pid end fldTypeSanadName_Pid
	,case when fldModuleErsalId in (5,12,13) then ACC.fn_GetSourceId(fldModuleErsalId,header.fldId) when fldPId is null  or fldModuleErsalId=fldModuleSaveId then fldDocumentNum  else (select h.fldDocumentNum from acc.tblDocumentRecord_Header1 as h where h1.fldPId=h.fldid) end fldMainDocNum,isnull(flag.fldFlag,0) as fldFlag, ACC.fn_GetArtiklMap( header.fldId, h1.fldId,h1.fldModuleErsalId) as fldIsMap,fldEdit,case when fldModuleErsalId in(12,13) then ACC.[fn_GetCaseTypeId](fldModuleErsalId,header.fldId) else 0 end as fldCaseTypeId
	FROM   [ACC].[tblDocumentRecord_Header] header inner join acc.tblFiscalYear f on header.fldFiscalYearId=f.fldid
	inner join acc.tblDocumentRecord_Header1 as h1 on h1.fldDocument_HedearId=header.fldid
	inner join[ACC].[tblDocumentType] d on d.fldid=fldTypeSanadId
	left join com.tblModule m on m.fldid=fldModuleErsalId
	outer Apply(
				select atf from (select row_number()over (order by h2.fldId) atf,h2.fldid   
				from acc.tblDocumentRecord_Header h
				inner join acc.tblFiscalYear f1 on h.fldFiscalYearId=f1.fldid
				inner join acc.tblDocumentRecord_Header1 as h2 on h2.fldDocument_HedearId=h.fldid
				where h.fldOrganId=header.fldOrganId and f1.fldYear=f.fldYear 
					and h2.fldModuleSaveId=h1.fldModuleSaveId and fldDocumentNum <>0
					)t where t.fldid=h1.fldid)atfNum

		outer apply (select ShomareRoozane from (select row_number()over (order by h2.fldDate) ShomareRoozane,h2.fldid  
				from acc.tblDocumentRecord_Header h
				inner join acc.tblFiscalYear f1 on h.fldFiscalYearId=f1.fldid
				inner join acc.tblDocumentRecord_Header1 as h2 on h2.fldDocument_HedearId=h.fldid
				where h.fldOrganId=header.fldOrganId and f1.fldYear=f.fldYear 
					and h2.fldModuleSaveId=h1.fldModuleSaveId and cast(h2.fldDate as date)=cast(h1.fldDate as date) 	
					and fldDocumentNum <>0)t where t.fldid=h1.fldid)Roozane

	outer apply(select  top(1) cast(1 as bit)fldExistsFile from acc.tblDocumentRecorde_File where fldDocumentHeaderId=header.fldid)Doc_File
	cross apply(select max(fldDate) as maxDate from
			(select max(h.fldDate) fldDate from acc.tblDocumentRecord_Header1 as h where h.fldId=h1.fldId
			union all
			select max(l.fldDate) fldDate from acc.tblDocument_HeaderLog as L where l.fldHeaderId =h1.fldId
			union all
			select max(f.fldDate) fldDate from acc.tblDocumentRecorde_File as f where f.fldDocumentHeaderId=header.fldId
			union all
			select max(b.fldDate) fldDate from acc.tblDocumentRecorde_File as f 
			inner join acc.tblDocumentBookMark as b on b.fldDocumentRecordeId=f.fldId
			where f.fldDocumentHeaderId=header.fldId)t)md
outer apply(select top 1  h.fldDocumentNum as fldDocumentNum_Pid from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldPId and h.fldId<h1.fldId order by h.fldId desc )Doc_Pid
outer apply(select top 1  h.fldTypeSanadId as fldTypeSanadId_Pid from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldId  order by h.fldId desc )Typesanad
outer apply(select (select top(1)  N'مرجوع شده (مرتبه ' +cast( ROW_NUMBER() over (order by h.fldid) as varchar(10))+')' from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldId and h.fldTypeSanadId=3 order by h.fldid desc) as fldTypeSanadId_Pid) sanadName
outer APPLY(select top(1) 1 as fldFlag
			FROM   [ACC].[tblDocumentRecord_Details] as d
			inner join acc.tblDocumentRecord_Header as h on h.fldId=d.fldDocument_HedearId
			inner join acc.[tblArtiklMap] as a on a.fldDocumentRecord_DetailsId=d.fldId
			WHERE   fldDocument_HedearId=header.fldId  
			and (fldDocument_HedearId1=h1.fldId
			 or (not exists(select * from Acc.tblDocumentRecord_Details as d2 where d2.fldDocument_HedearId1=h1.fldId ) and fldDocument_HedearId1 is null )) ) flag
WHERE fldArchiveNum like  @Value AND header.fldOrganId=@fldOrganId  and f.fldYear=@fldYear and h1.fldModuleSaveId=@fldMadule
	--order by fldTarikhDocument,case when fldDocumentNum=0 then 1 else 0 end ,fldDocumentNum
	order by md.maxDate desc,fldDocumentNum desc

	
	
	if (@fieldname=N'fldDescriptionDocu')
		SELECT top(@h) h1.[fldId], [fldDocumentNum],cast(atf as int ) [fldAtfNum], [fldArchiveNum], [fldDescriptionDocu],header.[fldOrganId] ,[fldTarikhDocument],header.[fldDesc], header.[fldDate], header.[fldIP], header.[fldUserId],[fldAccept] 
	,fldType,case when fldType=1 and fldaccept=1 then N'قطعی' when fldType=1 and fldaccept=0 then N'موقت' when fldType=2 then N'یادداشت' end as fldTypeName
	,cast(ShomareRoozane as int)ShomareRoozane,fldShomareFaree,f.fldYear,fldFiscalYearId
	,fldTypeSanadId as fldTypeSanad ,d.fldName    as fldTypeSanadName,m.fldTitle as fldNameModule,fldModuleErsalId,isnull(fldExistsFile,cast(0 as bit))fldIsArchive
	,case when h1.fldPId is null or fldTypeSanadId<>3 then 0 else Doc_Pid.fldDocumentNum_Pid end fldDocumentNum_Pid,isnull(h1.fldPId,0)fldPId,case when Typesanad.fldTypeSanadId_Pid is null then N'ارسال نشده' when Typesanad.fldTypeSanadId_Pid<>3 then N'ارسال شده' else sanadName.fldTypeSanadId_Pid end fldTypeSanadName_Pid
	,case when fldModuleErsalId in (5,12,13) then ACC.fn_GetSourceId(fldModuleErsalId,header.fldId) when fldPId is null  or fldModuleErsalId=fldModuleSaveId then fldDocumentNum  else (select h.fldDocumentNum from acc.tblDocumentRecord_Header1 as h where h1.fldPId=h.fldid) end fldMainDocNum,isnull(flag.fldFlag,0) as fldFlag, ACC.fn_GetArtiklMap( header.fldId, h1.fldId,h1.fldModuleErsalId) as fldIsMap,fldEdit,case when fldModuleErsalId in(12,13) then ACC.[fn_GetCaseTypeId](fldModuleErsalId,header.fldId) else 0 end as fldCaseTypeId
	FROM   [ACC].[tblDocumentRecord_Header] header inner join acc.tblFiscalYear f on header.fldFiscalYearId=f.fldid
	inner join acc.tblDocumentRecord_Header1 as h1 on h1.fldDocument_HedearId=header.fldid
	inner join[ACC].[tblDocumentType] d on d.fldid=fldTypeSanadId
	left join com.tblModule m on m.fldid=fldModuleErsalId
	outer Apply(
				select atf from (select row_number()over (order by h2.fldId) atf,h2.fldid   
				from acc.tblDocumentRecord_Header h
				inner join acc.tblFiscalYear f1 on h.fldFiscalYearId=f1.fldid
				inner join acc.tblDocumentRecord_Header1 as h2 on h2.fldDocument_HedearId=h.fldid
				where h.fldOrganId=header.fldOrganId and f1.fldYear=f.fldYear 
					and h2.fldModuleSaveId=h1.fldModuleSaveId and fldDocumentNum <>0
					)t where t.fldid=h1.fldid)atfNum

	outer apply (select ShomareRoozane from (select row_number()over (order by h2.fldDate) ShomareRoozane,h2.fldid  
				from acc.tblDocumentRecord_Header h
				inner join acc.tblFiscalYear f1 on h.fldFiscalYearId=f1.fldid
				inner join acc.tblDocumentRecord_Header1 as h2 on h2.fldDocument_HedearId=h.fldid
				where h.fldOrganId=header.fldOrganId and f1.fldYear=f.fldYear 
					and h2.fldModuleSaveId=h1.fldModuleSaveId and cast(h2.fldDate as date)=cast(h1.fldDate as date) 	
					and fldDocumentNum <>0)t where t.fldid=h1.fldid)Roozane

	outer apply(select  top(1) cast(1 as bit)fldExistsFile from acc.tblDocumentRecorde_File where fldDocumentHeaderId=header.fldid)Doc_File
	cross apply(select max(fldDate) as maxDate from
			(select max(h.fldDate) fldDate from acc.tblDocumentRecord_Header1 as h where h.fldId=h1.fldId
			union all
			select max(l.fldDate) fldDate from acc.tblDocument_HeaderLog as L where l.fldHeaderId =h1.fldId
			union all
			select max(f.fldDate) fldDate from acc.tblDocumentRecorde_File as f where f.fldDocumentHeaderId=header.fldId
			union all
			select max(b.fldDate) fldDate from acc.tblDocumentRecorde_File as f 
			inner join acc.tblDocumentBookMark as b on b.fldDocumentRecordeId=f.fldId
			where f.fldDocumentHeaderId=header.fldId)t)md
outer apply(select top 1  h.fldDocumentNum as fldDocumentNum_Pid from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldPId and h.fldId<h1.fldId order by h.fldId desc )Doc_Pid
outer apply(select top 1  h.fldTypeSanadId as fldTypeSanadId_Pid from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldId  order by h.fldId desc )Typesanad
outer apply(select (select top(1)  N'مرجوع شده (مرتبه ' +cast( ROW_NUMBER() over (order by h.fldid) as varchar(10))+')' from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldId and h.fldTypeSanadId=3 order by h.fldid desc) as fldTypeSanadId_Pid) sanadName
outer APPLY(select top(1) 1 as fldFlag
			FROM   [ACC].[tblDocumentRecord_Details] as d
			inner join acc.tblDocumentRecord_Header as h on h.fldId=d.fldDocument_HedearId
			inner join acc.[tblArtiklMap] as a on a.fldDocumentRecord_DetailsId=d.fldId
			WHERE   fldDocument_HedearId=header.fldId  
			and (fldDocument_HedearId1=h1.fldId
			 or (not exists(select * from Acc.tblDocumentRecord_Details as d2 where d2.fldDocument_HedearId1=h1.fldId ) and fldDocument_HedearId1 is null )) ) flag
WHERE fldDescriptionDocu like  @Value AND header.fldOrganId=@fldOrganId  and f.fldYear=@fldYear and h1.fldModuleSaveId=@fldMadule
	--order by fldTarikhDocument,case when fldDocumentNum=0 then 1 else 0 end ,fldDocumentNum
	order by md.maxDate desc,fldDocumentNum desc

	
	if (@fieldname=N'fldOrganId')
	SELECT top(@h) h1.[fldId], [fldDocumentNum],cast(atf as int ) [fldAtfNum], [fldArchiveNum], [fldDescriptionDocu],header.[fldOrganId] ,[fldTarikhDocument],header.[fldDesc], header.[fldDate], header.[fldIP], header.[fldUserId],[fldAccept] 
	,fldType,case when fldType=1 and fldaccept=1 then N'قطعی' when fldType=1 and fldaccept=0 then N'موقت' when fldType=2 then N'یادداشت' end as fldTypeName
	,cast(ShomareRoozane as int)ShomareRoozane,fldShomareFaree,f.fldYear,fldFiscalYearId
	,fldTypeSanadId as fldTypeSanad ,d.fldName    as fldTypeSanadName,m.fldTitle as fldNameModule,fldModuleErsalId,isnull(fldExistsFile,cast(0 as bit))fldIsArchive
	,case when h1.fldPId is null or fldTypeSanadId<>3 then 0 else Doc_Pid.fldDocumentNum_Pid end fldDocumentNum_Pid,isnull(h1.fldPId,0)fldPId,case when Typesanad.fldTypeSanadId_Pid is null then N'ارسال نشده' when Typesanad.fldTypeSanadId_Pid<>3 then N'ارسال شده' else sanadName.fldTypeSanadId_Pid end fldTypeSanadName_Pid
	,case when fldModuleErsalId in (5,12,13) then ACC.fn_GetSourceId(fldModuleErsalId,header.fldId) when fldPId is null  or fldModuleErsalId=fldModuleSaveId then fldDocumentNum  else (select h.fldDocumentNum from acc.tblDocumentRecord_Header1 as h where h1.fldPId=h.fldid) end fldMainDocNum,isnull(flag.fldFlag,0) as fldFlag, ACC.fn_GetArtiklMap( header.fldId, h1.fldId,h1.fldModuleErsalId) as fldIsMap,fldEdit,case when fldModuleErsalId in(12,13) then ACC.[fn_GetCaseTypeId](fldModuleErsalId,header.fldId) else 0 end as fldCaseTypeId
	FROM   [ACC].[tblDocumentRecord_Header] header inner join acc.tblFiscalYear f on header.fldFiscalYearId=f.fldid
	inner join acc.tblDocumentRecord_Header1 as h1 on h1.fldDocument_HedearId=header.fldid
	inner join[ACC].[tblDocumentType] d on d.fldid=fldTypeSanadId
	left join com.tblModule m on m.fldid=fldModuleErsalId
	outer Apply(
				select atf from (select row_number()over (order by h2.fldId) atf,h2.fldid   
				from acc.tblDocumentRecord_Header h
				inner join acc.tblFiscalYear f1 on h.fldFiscalYearId=f1.fldid
				inner join acc.tblDocumentRecord_Header1 as h2 on h2.fldDocument_HedearId=h.fldid
				where h.fldOrganId=header.fldOrganId and f1.fldYear=f.fldYear 
					and h2.fldModuleSaveId=h1.fldModuleSaveId and fldDocumentNum <>0
					)t where t.fldid=h1.fldid)atfNum

		outer apply (select ShomareRoozane from (select row_number()over (order by h2.fldDate) ShomareRoozane,h2.fldid  
				from acc.tblDocumentRecord_Header h
				inner join acc.tblFiscalYear f1 on h.fldFiscalYearId=f1.fldid
				inner join acc.tblDocumentRecord_Header1 as h2 on h2.fldDocument_HedearId=h.fldid
				where h.fldOrganId=header.fldOrganId and f1.fldYear=f.fldYear 
					and h2.fldModuleSaveId=h1.fldModuleSaveId and cast(h2.fldDate as date)=cast(h1.fldDate as date) 	
					and fldDocumentNum <>0)t where t.fldid=h1.fldid)Roozane

 outer apply(select  top(1) cast(1 as bit)fldExistsFile from acc.tblDocumentRecorde_File where fldDocumentHeaderId=header.fldid)Doc_File
 cross apply(select max(fldDate) as maxDate from
			(select max(h.fldDate) fldDate from acc.tblDocumentRecord_Header1 as h where h.fldId=h1.fldId
			union all
			select max(l.fldDate) fldDate from acc.tblDocument_HeaderLog as L where l.fldHeaderId =h1.fldId
			union all
			select max(f.fldDate) fldDate from acc.tblDocumentRecorde_File as f where f.fldDocumentHeaderId=header.fldId
			union all
			select max(b.fldDate) fldDate from acc.tblDocumentRecorde_File as f 
			inner join acc.tblDocumentBookMark as b on b.fldDocumentRecordeId=f.fldId
			where f.fldDocumentHeaderId=header.fldId)t)md
outer apply(select top 1  h.fldDocumentNum as fldDocumentNum_Pid from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldPId and h.fldId<h1.fldId order by h.fldId desc )Doc_Pid
outer apply(select top 1  h.fldTypeSanadId as fldTypeSanadId_Pid from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldId  order by h.fldId desc )Typesanad
outer apply(select (select top(1)  N'مرجوع شده (مرتبه ' +cast( ROW_NUMBER() over (order by h.fldid) as varchar(10))+')' from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldId and h.fldTypeSanadId=3 order by h.fldid desc) as fldTypeSanadId_Pid) sanadName
outer APPLY(select top(1) 1 as fldFlag
			FROM   [ACC].[tblDocumentRecord_Details] as d
			inner join acc.tblDocumentRecord_Header as h on h.fldId=d.fldDocument_HedearId
			inner join acc.[tblArtiklMap] as a on a.fldDocumentRecord_DetailsId=d.fldId
			WHERE   fldDocument_HedearId=header.fldId  
			and (fldDocument_HedearId1=h1.fldId
			 or (not exists(select * from Acc.tblDocumentRecord_Details as d2 where d2.fldDocument_HedearId1=h1.fldId ) and fldDocument_HedearId1 is null )) ) flag
WHERE  header.fldOrganId=@fldOrganId  and f.fldYear=@fldYear and h1.fldModuleSaveId=@fldMadule
	--order by fldTarikhDocument,case when fldDocumentNum=0 then 1 else 0 end ,fldDocumentNum
	order by md.maxDate desc,fldDocumentNum desc

	
	
	if (@fieldname=N'fldTarikhDocument')
		SELECT top(@h) h1.[fldId], [fldDocumentNum],cast(atf as int ) [fldAtfNum], [fldArchiveNum], [fldDescriptionDocu],header.[fldOrganId] ,[fldTarikhDocument],header.[fldDesc], header.[fldDate], header.[fldIP], header.[fldUserId],[fldAccept] 
	,fldType,case when fldType=1 and fldaccept=1 then N'قطعی' when fldType=1 and fldaccept=0 then N'موقت' when fldType=2 then N'یادداشت' end as fldTypeName
	,cast(ShomareRoozane as int)ShomareRoozane,fldShomareFaree,f.fldYear,fldFiscalYearId
	,fldTypeSanadId as fldTypeSanad ,d.fldName    as fldTypeSanadName,m.fldTitle as fldNameModule,fldModuleErsalId,isnull(fldExistsFile,cast(0 as bit))fldIsArchive
	,case when h1.fldPId is null or fldTypeSanadId<>3 then 0 else Doc_Pid.fldDocumentNum_Pid end fldDocumentNum_Pid,isnull(h1.fldPId,0)fldPId,case when Typesanad.fldTypeSanadId_Pid is null then N'ارسال نشده' when Typesanad.fldTypeSanadId_Pid<>3 then N'ارسال شده' else sanadName.fldTypeSanadId_Pid end fldTypeSanadName_Pid
	,case when fldModuleErsalId in (5,12,13) then ACC.fn_GetSourceId(fldModuleErsalId,header.fldId) when fldPId is null  or fldModuleErsalId=fldModuleSaveId then fldDocumentNum  else (select h.fldDocumentNum from acc.tblDocumentRecord_Header1 as h where h1.fldPId=h.fldid) end fldMainDocNum,isnull(flag.fldFlag,0) as fldFlag, ACC.fn_GetArtiklMap( header.fldId, h1.fldId,h1.fldModuleErsalId) as fldIsMap,fldEdit,case when fldModuleErsalId in(12,13) then ACC.[fn_GetCaseTypeId](fldModuleErsalId,header.fldId) else 0 end as fldCaseTypeId
	FROM   [ACC].[tblDocumentRecord_Header] header inner join acc.tblFiscalYear f on header.fldFiscalYearId=f.fldid
	inner join acc.tblDocumentRecord_Header1 as h1 on h1.fldDocument_HedearId=header.fldid
	inner join[ACC].[tblDocumentType] d on d.fldid=fldTypeSanadId
	left join com.tblModule m on m.fldid=fldModuleErsalId
	outer Apply(
				select atf from (select row_number()over (order by h2.fldId) atf,h2.fldid   
				from acc.tblDocumentRecord_Header h
				inner join acc.tblFiscalYear f1 on h.fldFiscalYearId=f1.fldid
				inner join acc.tblDocumentRecord_Header1 as h2 on h2.fldDocument_HedearId=h.fldid
				where h.fldOrganId=header.fldOrganId and f1.fldYear=f.fldYear 
					and h2.fldModuleSaveId=h1.fldModuleSaveId and fldDocumentNum <>0
					)t where t.fldid=h1.fldid)atfNum

	outer apply (select ShomareRoozane from (select row_number()over (order by h2.fldDate) ShomareRoozane,h2.fldid  
				from acc.tblDocumentRecord_Header h
				inner join acc.tblFiscalYear f1 on h.fldFiscalYearId=f1.fldid
				inner join acc.tblDocumentRecord_Header1 as h2 on h2.fldDocument_HedearId=h.fldid
				where h.fldOrganId=header.fldOrganId and f1.fldYear=f.fldYear 
					and h2.fldModuleSaveId=h1.fldModuleSaveId and cast(h2.fldDate as date)=cast(h1.fldDate as date) 	
					and fldDocumentNum <>0)t where t.fldid=h1.fldid)Roozane

	outer apply(select  top(1) cast(1 as bit)fldExistsFile from acc.tblDocumentRecorde_File where fldDocumentHeaderId=header.fldid)Doc_File
	cross apply(select max(fldDate) as maxDate from
			(select max(h.fldDate) fldDate from acc.tblDocumentRecord_Header1 as h where h.fldId=h1.fldId
			union all
			select max(l.fldDate) fldDate from acc.tblDocument_HeaderLog as L where l.fldHeaderId =h1.fldId
			union all
			select max(f.fldDate) fldDate from acc.tblDocumentRecorde_File as f where f.fldDocumentHeaderId=header.fldId
			union all
			select max(b.fldDate) fldDate from acc.tblDocumentRecorde_File as f 
			inner join acc.tblDocumentBookMark as b on b.fldDocumentRecordeId=f.fldId
			where f.fldDocumentHeaderId=header.fldId)t)md
outer apply(select top 1  h.fldDocumentNum as fldDocumentNum_Pid from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldPId and h.fldId<h1.fldId order by h.fldId desc )Doc_Pid
outer apply(select top 1  h.fldTypeSanadId as fldTypeSanadId_Pid from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldId  order by h.fldId desc )Typesanad
outer apply(select (select top(1)  N'مرجوع شده (مرتبه ' +cast( ROW_NUMBER() over (order by h.fldid) as varchar(10))+')' from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldId and h.fldTypeSanadId=3 order by h.fldid desc) as fldTypeSanadId_Pid) sanadName
outer APPLY(select top(1) 1 as fldFlag
			FROM   [ACC].[tblDocumentRecord_Details] as d
			inner join acc.tblDocumentRecord_Header as h on h.fldId=d.fldDocument_HedearId
			inner join acc.[tblArtiklMap] as a on a.fldDocumentRecord_DetailsId=d.fldId
			WHERE   fldDocument_HedearId=header.fldId  
			and (fldDocument_HedearId1=h1.fldId
			 or (not exists(select * from Acc.tblDocumentRecord_Details as d2 where d2.fldDocument_HedearId1=h1.fldId ) and fldDocument_HedearId1 is null )) ) flag
WHERE fldTarikhDocument like  @Value AND header.fldOrganId=@fldOrganId  and f.fldYear=@fldYear and h1.fldModuleSaveId=@fldMadule
	--order by fldTarikhDocument,case when fldDocumentNum=0 then 1 else 0 end ,fldDocumentNum
	order by md.maxDate desc,fldDocumentNum desc

	if (@fieldname=N'fldAccept')
	SELECT top(@h) h1.[fldId], [fldDocumentNum],cast(atf as int ) [fldAtfNum], [fldArchiveNum], [fldDescriptionDocu],header.[fldOrganId] ,[fldTarikhDocument],header.[fldDesc], header.[fldDate], header.[fldIP], header.[fldUserId],[fldAccept] 
	,fldType,case when fldType=1 and fldaccept=1 then N'قطعی' when fldType=1 and fldaccept=0 then N'موقت' when fldType=2 then N'یادداشت' end as fldTypeName
	,cast(ShomareRoozane as int)ShomareRoozane,fldShomareFaree,f.fldYear,fldFiscalYearId
	,fldTypeSanadId as fldTypeSanad ,d.fldName    as fldTypeSanadName,m.fldTitle as fldNameModule,fldModuleErsalId,isnull(fldExistsFile,cast(0 as bit))fldIsArchive
	,case when h1.fldPId is null or fldTypeSanadId<>3 then 0 else Doc_Pid.fldDocumentNum_Pid end fldDocumentNum_Pid,isnull(h1.fldPId,0)fldPId,case when Typesanad.fldTypeSanadId_Pid is null then N'ارسال نشده' when Typesanad.fldTypeSanadId_Pid<>3 then N'ارسال شده' else sanadName.fldTypeSanadId_Pid end fldTypeSanadName_Pid
	,case when fldModuleErsalId in (5,12,13) then ACC.fn_GetSourceId(fldModuleErsalId,header.fldId) when fldPId is null  or fldModuleErsalId=fldModuleSaveId then fldDocumentNum  else (select h.fldDocumentNum from acc.tblDocumentRecord_Header1 as h where h1.fldPId=h.fldid) end fldMainDocNum,isnull(flag.fldFlag,0) as fldFlag, ACC.fn_GetArtiklMap( header.fldId, h1.fldId,h1.fldModuleErsalId) as fldIsMap,fldEdit,case when fldModuleErsalId in(12,13) then ACC.[fn_GetCaseTypeId](fldModuleErsalId,header.fldId) else 0 end as fldCaseTypeId
	FROM   [ACC].[tblDocumentRecord_Header] header inner join acc.tblFiscalYear f on header.fldFiscalYearId=f.fldid
	inner join acc.tblDocumentRecord_Header1 as h1 on h1.fldDocument_HedearId=header.fldid
	inner join[ACC].[tblDocumentType] d on d.fldid=fldTypeSanadId
	left join com.tblModule m on m.fldid=fldModuleErsalId
	outer Apply(
				select atf from (select row_number()over (order by h2.fldId) atf,h2.fldid   
				from acc.tblDocumentRecord_Header h
				inner join acc.tblFiscalYear f1 on h.fldFiscalYearId=f1.fldid
				inner join acc.tblDocumentRecord_Header1 as h2 on h2.fldDocument_HedearId=h.fldid
				where h.fldOrganId=header.fldOrganId and f1.fldYear=f.fldYear 
					and h2.fldModuleSaveId=h1.fldModuleSaveId and fldDocumentNum <>0
					)t where t.fldid=h1.fldid)atfNum

		outer apply (select ShomareRoozane from (select row_number()over (order by h2.fldDate) ShomareRoozane,h2.fldid  
				from acc.tblDocumentRecord_Header h
				inner join acc.tblFiscalYear f1 on h.fldFiscalYearId=f1.fldid
				inner join acc.tblDocumentRecord_Header1 as h2 on h2.fldDocument_HedearId=h.fldid
				where h.fldOrganId=header.fldOrganId and f1.fldYear=f.fldYear 
					and h2.fldModuleSaveId=h1.fldModuleSaveId and cast(h2.fldDate as date)=cast(h1.fldDate as date) 	
					and fldDocumentNum <>0)t where t.fldid=h1.fldid)Roozane

	outer apply(select  top(1) cast(1 as bit)fldExistsFile from acc.tblDocumentRecorde_File where fldDocumentHeaderId=header.fldid)Doc_File
	cross apply(select max(fldDate) as maxDate from
			(select max(h.fldDate) fldDate from acc.tblDocumentRecord_Header1 as h where h.fldId=h1.fldId
			union all
			select max(l.fldDate) fldDate from acc.tblDocument_HeaderLog as L where l.fldHeaderId =h1.fldId
			union all
			select max(f.fldDate) fldDate from acc.tblDocumentRecorde_File as f where f.fldDocumentHeaderId=header.fldId
			union all
			select max(b.fldDate) fldDate from acc.tblDocumentRecorde_File as f 
			inner join acc.tblDocumentBookMark as b on b.fldDocumentRecordeId=f.fldId
			where f.fldDocumentHeaderId=header.fldId)t)md
outer apply(select top 1  h.fldDocumentNum as fldDocumentNum_Pid from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldPId and h.fldId<h1.fldId order by h.fldId desc )Doc_Pid
outer apply(select top 1  h.fldTypeSanadId as fldTypeSanadId_Pid from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldId  order by h.fldId desc )Typesanad
outer apply(select (select top(1)  N'مرجوع شده (مرتبه ' +cast( ROW_NUMBER() over (order by h.fldid) as varchar(10))+')' from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldId and h.fldTypeSanadId=3 order by h.fldid desc) as fldTypeSanadId_Pid) sanadName
outer APPLY(select top(1) 1 as fldFlag
			FROM   [ACC].[tblDocumentRecord_Details] as d
			inner join acc.tblDocumentRecord_Header as h on h.fldId=d.fldDocument_HedearId
			inner join acc.[tblArtiklMap] as a on a.fldDocumentRecord_DetailsId=d.fldId
			WHERE   fldDocument_HedearId=header.fldId  
			and (fldDocument_HedearId1=h1.fldId
			 or (not exists(select * from Acc.tblDocumentRecord_Details as d2 where d2.fldDocument_HedearId1=h1.fldId ) and fldDocument_HedearId1 is null )) ) flag
WHERE fldAccept like  @Value AND header.fldOrganId=@fldOrganId  and f.fldYear=@fldYear and h1.fldModuleSaveId=@fldMadule
	--order by fldTarikhDocument,case when fldDocumentNum=0 then 1 else 0 end ,fldDocumentNum
	order by md.maxDate desc,fldDocumentNum desc

		if (@fieldname=N'ShomareRoozane')
		SELECT top(@h) h1.[fldId], [fldDocumentNum],cast(atf as int ) [fldAtfNum], [fldArchiveNum], [fldDescriptionDocu],header.[fldOrganId] ,[fldTarikhDocument],header.[fldDesc], header.[fldDate], header.[fldIP], header.[fldUserId],[fldAccept] 
	,fldType,case when fldType=1 and fldaccept=1 then N'قطعی' when fldType=1 and fldaccept=0 then N'موقت' when fldType=2 then N'یادداشت' end as fldTypeName
	,cast(ShomareRoozane as int)ShomareRoozane,fldShomareFaree,f.fldYear,fldFiscalYearId
	,fldTypeSanadId as fldTypeSanad ,d.fldName    as fldTypeSanadName,m.fldTitle as fldNameModule,fldModuleErsalId,isnull(fldExistsFile,cast(0 as bit))fldIsArchive
	,case when h1.fldPId is null or fldTypeSanadId<>3 then 0 else Doc_Pid.fldDocumentNum_Pid end fldDocumentNum_Pid,isnull(h1.fldPId,0)fldPId,case when Typesanad.fldTypeSanadId_Pid is null then N'ارسال نشده' when Typesanad.fldTypeSanadId_Pid<>3 then N'ارسال شده' else sanadName.fldTypeSanadId_Pid end fldTypeSanadName_Pid
	,case when fldModuleErsalId in (5,12,13) then ACC.fn_GetSourceId(fldModuleErsalId,header.fldId) when fldPId is null  or fldModuleErsalId=fldModuleSaveId then fldDocumentNum  else (select h.fldDocumentNum from acc.tblDocumentRecord_Header1 as h where h1.fldPId=h.fldid) end fldMainDocNum,isnull(flag.fldFlag,0) as fldFlag, ACC.fn_GetArtiklMap( header.fldId, h1.fldId,h1.fldModuleErsalId) as fldIsMap,fldEdit,case when fldModuleErsalId in(12,13) then ACC.[fn_GetCaseTypeId](fldModuleErsalId,header.fldId) else 0 end as fldCaseTypeId
	FROM   [ACC].[tblDocumentRecord_Header] header inner join acc.tblFiscalYear f on header.fldFiscalYearId=f.fldid
	inner join acc.tblDocumentRecord_Header1 as h1 on h1.fldDocument_HedearId=header.fldid
	inner join[ACC].[tblDocumentType] d on d.fldid=fldTypeSanadId
	left join com.tblModule m on m.fldid=fldModuleErsalId
	outer Apply(
				select atf from (select row_number()over (order by h2.fldId) atf,h2.fldid   
				from acc.tblDocumentRecord_Header h
				inner join acc.tblFiscalYear f1 on h.fldFiscalYearId=f1.fldid
				inner join acc.tblDocumentRecord_Header1 as h2 on h2.fldDocument_HedearId=h.fldid
				where h.fldOrganId=header.fldOrganId and f1.fldYear=f.fldYear 
					and h2.fldModuleSaveId=h1.fldModuleSaveId and fldDocumentNum <>0
					)t where t.fldid=h1.fldid)atfNum
	outer apply (select ShomareRoozane from (select row_number()over (order by h2.fldDate) ShomareRoozane,h2.fldid  
				from acc.tblDocumentRecord_Header h
				inner join acc.tblFiscalYear f1 on h.fldFiscalYearId=f1.fldid
				inner join acc.tblDocumentRecord_Header1 as h2 on h2.fldDocument_HedearId=h.fldid
				where h.fldOrganId=header.fldOrganId and f1.fldYear=f.fldYear 
					and h2.fldModuleSaveId=h1.fldModuleSaveId and cast(h2.fldDate as date)=cast(h1.fldDate as date) 	
					and fldDocumentNum <>0)t where t.fldid=h1.fldid)Roozane

	outer apply(select  top(1) cast(1 as bit)fldExistsFile from acc.tblDocumentRecorde_File where fldDocumentHeaderId=header.fldid)Doc_File
	cross apply(select max(fldDate) as maxDate from
			(select max(h.fldDate) fldDate from acc.tblDocumentRecord_Header1 as h where h.fldId=h1.fldId
			union all
			select max(l.fldDate) fldDate from acc.tblDocument_HeaderLog as L where l.fldHeaderId =h1.fldId
			union all
			select max(f.fldDate) fldDate from acc.tblDocumentRecorde_File as f where f.fldDocumentHeaderId=header.fldId
			union all
			select max(b.fldDate) fldDate from acc.tblDocumentRecorde_File as f 
			inner join acc.tblDocumentBookMark as b on b.fldDocumentRecordeId=f.fldId
			where f.fldDocumentHeaderId=header.fldId)t)md
outer apply(select top 1  h.fldDocumentNum as fldDocumentNum_Pid from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldPId and h.fldId<h1.fldId order by h.fldId desc )Doc_Pid
outer apply(select top 1  h.fldTypeSanadId as fldTypeSanadId_Pid from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldId  order by h.fldId desc )Typesanad
outer apply(select (select top(1)  N'مرجوع شده (مرتبه ' +cast( ROW_NUMBER() over (order by h.fldid) as varchar(10))+')' from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldId and h.fldTypeSanadId=3 order by h.fldid desc) as fldTypeSanadId_Pid) sanadName
outer APPLY(select top(1) 1 as fldFlag
			FROM   [ACC].[tblDocumentRecord_Details] as d
			inner join acc.tblDocumentRecord_Header as h on h.fldId=d.fldDocument_HedearId
			inner join acc.[tblArtiklMap] as a on a.fldDocumentRecord_DetailsId=d.fldId
			WHERE   fldDocument_HedearId=header.fldId  
			and (fldDocument_HedearId1=h1.fldId
			 or (not exists(select * from Acc.tblDocumentRecord_Details as d2 where d2.fldDocument_HedearId1=h1.fldId ) and fldDocument_HedearId1 is null )) ) flag
WHERE ShomareRoozane like  @Value AND header.fldOrganId=@fldOrganId  and f.fldYear=@fldYear and h1.fldModuleSaveId=@fldMadule
	--order by fldTarikhDocument,case when fldDocumentNum=0 then 1 else 0 end ,fldDocumentNum
	order by md.maxDate desc,fldDocumentNum desc


	if (@fieldname=N'fldShomareFaree')
		SELECT top(@h) h1.[fldId], [fldDocumentNum],cast(atf as int ) [fldAtfNum], [fldArchiveNum], [fldDescriptionDocu],header.[fldOrganId] ,[fldTarikhDocument],header.[fldDesc], header.[fldDate], header.[fldIP], header.[fldUserId],[fldAccept] 
	,fldType,case when fldType=1 and fldaccept=1 then N'قطعی' when fldType=1 and fldaccept=0 then N'موقت' when fldType=2 then N'یادداشت' end as fldTypeName
	,cast(ShomareRoozane as int)ShomareRoozane,fldShomareFaree,f.fldYear,fldFiscalYearId
	,fldTypeSanadId as fldTypeSanad ,d.fldName    as fldTypeSanadName,m.fldTitle as fldNameModule,fldModuleErsalId,isnull(fldExistsFile,cast(0 as bit))fldIsArchive
	,case when h1.fldPId is null or fldTypeSanadId<>3 then 0 else Doc_Pid.fldDocumentNum_Pid end fldDocumentNum_Pid,isnull(h1.fldPId,0)fldPId,case when Typesanad.fldTypeSanadId_Pid is null then N'ارسال نشده' when Typesanad.fldTypeSanadId_Pid<>3 then N'ارسال شده' else sanadName.fldTypeSanadId_Pid end fldTypeSanadName_Pid
	,case when fldModuleErsalId in (5,12,13) then ACC.fn_GetSourceId(fldModuleErsalId,header.fldId) when fldPId is null  or fldModuleErsalId=fldModuleSaveId then fldDocumentNum  else (select h.fldDocumentNum from acc.tblDocumentRecord_Header1 as h where h1.fldPId=h.fldid) end fldMainDocNum,isnull(flag.fldFlag,0) as fldFlag, ACC.fn_GetArtiklMap( header.fldId, h1.fldId,h1.fldModuleErsalId) as fldIsMap,fldEdit,case when fldModuleErsalId in(12,13) then ACC.[fn_GetCaseTypeId](fldModuleErsalId,header.fldId) else 0 end as fldCaseTypeId
	FROM   [ACC].[tblDocumentRecord_Header] header inner join acc.tblFiscalYear f on header.fldFiscalYearId=f.fldid
	inner join acc.tblDocumentRecord_Header1 as h1 on h1.fldDocument_HedearId=header.fldid
	inner join[ACC].[tblDocumentType] d on d.fldid=fldTypeSanadId
	left join com.tblModule m on m.fldid=fldModuleErsalId
	outer Apply(
				select atf from (select row_number()over (order by h2.fldId) atf,h2.fldid   
				from acc.tblDocumentRecord_Header h
				inner join acc.tblFiscalYear f1 on h.fldFiscalYearId=f1.fldid
				inner join acc.tblDocumentRecord_Header1 as h2 on h2.fldDocument_HedearId=h.fldid
				where h.fldOrganId=header.fldOrganId and f1.fldYear=f.fldYear 
					and h2.fldModuleSaveId=h1.fldModuleSaveId and fldDocumentNum <>0
					)t where t.fldid=h1.fldid)atfNum

		outer apply (select ShomareRoozane from (select row_number()over (order by h2.fldDate) ShomareRoozane,h2.fldid  
				from acc.tblDocumentRecord_Header h
				inner join acc.tblFiscalYear f1 on h.fldFiscalYearId=f1.fldid
				inner join acc.tblDocumentRecord_Header1 as h2 on h2.fldDocument_HedearId=h.fldid
				where h.fldOrganId=header.fldOrganId and f1.fldYear=f.fldYear 
					and h2.fldModuleSaveId=h1.fldModuleSaveId and cast(h2.fldDate as date)=cast(h1.fldDate as date) 	
					and fldDocumentNum <>0)t where t.fldid=h1.fldid)Roozane

	outer apply(select   top(1) cast(1 as bit)fldExistsFile from acc.tblDocumentRecorde_File where fldDocumentHeaderId=header.fldid)Doc_File
	cross apply(select max(fldDate) as maxDate from
			(select max(h.fldDate) fldDate from acc.tblDocumentRecord_Header1 as h where h.fldId=h1.fldId
			union all
			select max(l.fldDate) fldDate from acc.tblDocument_HeaderLog as L where l.fldHeaderId =h1.fldId
			union all
			select max(f.fldDate) fldDate from acc.tblDocumentRecorde_File as f where f.fldDocumentHeaderId=header.fldId
			union all
			select max(b.fldDate) fldDate from acc.tblDocumentRecorde_File as f 
			inner join acc.tblDocumentBookMark as b on b.fldDocumentRecordeId=f.fldId
			where f.fldDocumentHeaderId=header.fldId)t)md
outer apply(select top 1  h.fldDocumentNum as fldDocumentNum_Pid from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldPId and h.fldId<h1.fldId order by h.fldId desc )Doc_Pid
outer apply(select top 1  h.fldTypeSanadId as fldTypeSanadId_Pid from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldId  order by h.fldId desc )Typesanad
outer apply(select (select top(1)  N'مرجوع شده (مرتبه ' +cast( ROW_NUMBER() over (order by h.fldid) as varchar(10))+')' from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldId and h.fldTypeSanadId=3 order by h.fldid desc) as fldTypeSanadId_Pid) sanadName
outer APPLY(select top(1) 1 as fldFlag
			FROM   [ACC].[tblDocumentRecord_Details] as d
			inner join acc.tblDocumentRecord_Header as h on h.fldId=d.fldDocument_HedearId
			inner join acc.[tblArtiklMap] as a on a.fldDocumentRecord_DetailsId=d.fldId
			WHERE   fldDocument_HedearId=header.fldId  
			and (fldDocument_HedearId1=h1.fldId
			 or (not exists(select * from Acc.tblDocumentRecord_Details as d2 where d2.fldDocument_HedearId1=h1.fldId ) and fldDocument_HedearId1 is null )) ) flag
WHERE fldShomareFaree like  @Value AND header.fldOrganId=@fldOrganId  and f.fldYear=@fldYear and h1.fldModuleSaveId=@fldMadule
	--order by fldTarikhDocument,case when fldDocumentNum=0 then 1 else 0 end ,fldDocumentNum
	order by md.maxDate desc,fldDocumentNum desc

	if (@fieldname=N'fldType')
		SELECT top(@h) h1.[fldId], [fldDocumentNum],cast(atf as int ) [fldAtfNum], [fldArchiveNum], [fldDescriptionDocu],header.[fldOrganId] ,[fldTarikhDocument],header.[fldDesc], header.[fldDate], header.[fldIP], header.[fldUserId],[fldAccept] 
	,fldType,case when fldType=1 and fldaccept=1 then N'قطعی' when fldType=1 and fldaccept=0 then N'موقت' when fldType=2 then N'یادداشت' end as fldTypeName
	,cast(ShomareRoozane as int)ShomareRoozane,fldShomareFaree,f.fldYear,fldFiscalYearId
	,fldTypeSanadId as fldTypeSanad ,d.fldName    as fldTypeSanadName,m.fldTitle as fldNameModule,fldModuleErsalId,isnull(fldExistsFile,cast(0 as bit))fldIsArchive
	,case when h1.fldPId is null or fldTypeSanadId<>3 then 0 else Doc_Pid.fldDocumentNum_Pid end fldDocumentNum_Pid,isnull(h1.fldPId,0)fldPId,case when Typesanad.fldTypeSanadId_Pid is null then N'ارسال نشده' when Typesanad.fldTypeSanadId_Pid<>3 then N'ارسال شده' else sanadName.fldTypeSanadId_Pid end fldTypeSanadName_Pid
	,case when fldModuleErsalId in (5,12,13) then ACC.fn_GetSourceId(fldModuleErsalId,header.fldId) when fldPId is null  or fldModuleErsalId=fldModuleSaveId then fldDocumentNum  else (select h.fldDocumentNum from acc.tblDocumentRecord_Header1 as h where h1.fldPId=h.fldid) end fldMainDocNum,isnull(flag.fldFlag,0) as fldFlag, ACC.fn_GetArtiklMap( header.fldId, h1.fldId,h1.fldModuleErsalId) as fldIsMap,fldEdit,case when fldModuleErsalId in(12,13) then ACC.[fn_GetCaseTypeId](fldModuleErsalId,header.fldId) else 0 end as fldCaseTypeId
	FROM   [ACC].[tblDocumentRecord_Header] header inner join acc.tblFiscalYear f on header.fldFiscalYearId=f.fldid
	inner join acc.tblDocumentRecord_Header1 as h1 on h1.fldDocument_HedearId=header.fldid
	inner join[ACC].[tblDocumentType] d on d.fldid=fldTypeSanadId
	left join com.tblModule m on m.fldid=fldModuleErsalId
	outer Apply(
				select atf from (select row_number()over (order by h2.fldId) atf,h2.fldid   
				from acc.tblDocumentRecord_Header h
				inner join acc.tblFiscalYear f1 on h.fldFiscalYearId=f1.fldid
				inner join acc.tblDocumentRecord_Header1 as h2 on h2.fldDocument_HedearId=h.fldid
				where h.fldOrganId=header.fldOrganId and f1.fldYear=f.fldYear 
					and h2.fldModuleSaveId=h1.fldModuleSaveId and fldDocumentNum <>0
					)t where t.fldid=h1.fldid)atfNum

		outer apply (select ShomareRoozane from (select row_number()over (order by h2.fldDate) ShomareRoozane,h2.fldid  
				from acc.tblDocumentRecord_Header h
				inner join acc.tblFiscalYear f1 on h.fldFiscalYearId=f1.fldid
				inner join acc.tblDocumentRecord_Header1 as h2 on h2.fldDocument_HedearId=h.fldid
				where h.fldOrganId=header.fldOrganId and f1.fldYear=f.fldYear 
					and h2.fldModuleSaveId=h1.fldModuleSaveId and cast(h2.fldDate as date)=cast(h1.fldDate as date) 	
					and fldDocumentNum <>0)t where t.fldid=h1.fldid)Roozane

	outer apply(select  top(1) cast(1 as bit)fldExistsFile from acc.tblDocumentRecorde_File where fldDocumentHeaderId=header.fldid)Doc_File
	cross apply(select max(fldDate) as maxDate from
			(select max(h.fldDate) fldDate from acc.tblDocumentRecord_Header1 as h where h.fldId=h1.fldId
			union all
			select max(l.fldDate) fldDate from acc.tblDocument_HeaderLog as L where l.fldHeaderId =h1.fldId
			union all
			select max(f.fldDate) fldDate from acc.tblDocumentRecorde_File as f where f.fldDocumentHeaderId=header.fldId
			union all
			select max(b.fldDate) fldDate from acc.tblDocumentRecorde_File as f 
			inner join acc.tblDocumentBookMark as b on b.fldDocumentRecordeId=f.fldId
			where f.fldDocumentHeaderId=header.fldId)t)md
outer apply(select top 1  h.fldDocumentNum as fldDocumentNum_Pid from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldPId and h.fldId<h1.fldId order by h.fldId desc )Doc_Pid
outer apply(select top 1  h.fldTypeSanadId as fldTypeSanadId_Pid from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldId  order by h.fldId desc )Typesanad
outer apply(select (select top(1)  N'مرجوع شده (مرتبه ' +cast( ROW_NUMBER() over (order by h.fldid) as varchar(10))+')' from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldId and h.fldTypeSanadId=3 order by h.fldid desc) as fldTypeSanadId_Pid) sanadName
outer APPLY(select top(1) 1 as fldFlag
			FROM   [ACC].[tblDocumentRecord_Details] as d
			inner join acc.tblDocumentRecord_Header as h on h.fldId=d.fldDocument_HedearId
			inner join acc.[tblArtiklMap] as a on a.fldDocumentRecord_DetailsId=d.fldId
			WHERE   fldDocument_HedearId=header.fldId  
			and (fldDocument_HedearId1=h1.fldId
			 or (not exists(select * from Acc.tblDocumentRecord_Details as d2 where d2.fldDocument_HedearId1=h1.fldId ) and fldDocument_HedearId1 is null )) ) flag
WHERE fldType like  @Value AND header.fldOrganId=@fldOrganId  and f.fldYear=@fldYear and h1.fldModuleSaveId=@fldMadule
	--order by fldTarikhDocument,case when fldDocumentNum=0 then 1 else 0 end ,fldDocumentNum
	order by md.maxDate desc,fldDocumentNum desc

	if (@fieldname=N'fldTypeSanadId')
		SELECT top(@h) h1.[fldId], [fldDocumentNum],cast(atf as int ) [fldAtfNum], [fldArchiveNum], [fldDescriptionDocu],header.[fldOrganId] ,[fldTarikhDocument],header.[fldDesc], header.[fldDate], header.[fldIP], header.[fldUserId],[fldAccept] 
	,fldType,case when fldType=1 and fldaccept=1 then N'قطعی' when fldType=1 and fldaccept=0 then N'موقت' when fldType=2 then N'یادداشت' end as fldTypeName
	,cast(ShomareRoozane as int)ShomareRoozane,fldShomareFaree,f.fldYear,fldFiscalYearId
	,fldTypeSanadId as fldTypeSanad ,d.fldName    as fldTypeSanadName,m.fldTitle as fldNameModule,fldModuleErsalId,isnull(fldExistsFile,cast(0 as bit))fldIsArchive
	,case when h1.fldPId is null or fldTypeSanadId<>3 then 0 else Doc_Pid.fldDocumentNum_Pid end fldDocumentNum_Pid,isnull(h1.fldPId,0)fldPId,case when Typesanad.fldTypeSanadId_Pid is null then N'ارسال نشده' when Typesanad.fldTypeSanadId_Pid<>3 then N'ارسال شده' else sanadName.fldTypeSanadId_Pid end fldTypeSanadName_Pid
	,case when fldModuleErsalId in (5,12,13) then ACC.fn_GetSourceId(fldModuleErsalId,header.fldId) when fldPId is null  or fldModuleErsalId=fldModuleSaveId then fldDocumentNum  else (select h.fldDocumentNum from acc.tblDocumentRecord_Header1 as h where h1.fldPId=h.fldid) end fldMainDocNum,isnull(flag.fldFlag,0) as fldFlag, ACC.fn_GetArtiklMap( header.fldId, h1.fldId,h1.fldModuleErsalId) as fldIsMap,fldEdit,case when fldModuleErsalId in(12,13) then ACC.[fn_GetCaseTypeId](fldModuleErsalId,header.fldId) else 0 end as fldCaseTypeId
	FROM   [ACC].[tblDocumentRecord_Header] header inner join acc.tblFiscalYear f on header.fldFiscalYearId=f.fldid
	inner join acc.tblDocumentRecord_Header1 as h1 on h1.fldDocument_HedearId=header.fldid
	inner join[ACC].[tblDocumentType] d on d.fldid=fldTypeSanadId
	left join com.tblModule m on m.fldid=fldModuleErsalId
	outer Apply(
				select atf from (select row_number()over (order by h2.fldId) atf,h2.fldid   
				from acc.tblDocumentRecord_Header h
				inner join acc.tblFiscalYear f1 on h.fldFiscalYearId=f1.fldid
				inner join acc.tblDocumentRecord_Header1 as h2 on h2.fldDocument_HedearId=h.fldid
				where h.fldOrganId=header.fldOrganId and f1.fldYear=f.fldYear 
					and h2.fldModuleSaveId=h1.fldModuleSaveId and fldDocumentNum <>0
					)t where t.fldid=h1.fldid)atfNum

		outer apply (select ShomareRoozane from (select row_number()over (order by h2.fldDate) ShomareRoozane,h2.fldid  
				from acc.tblDocumentRecord_Header h
				inner join acc.tblFiscalYear f1 on h.fldFiscalYearId=f1.fldid
				inner join acc.tblDocumentRecord_Header1 as h2 on h2.fldDocument_HedearId=h.fldid
				where h.fldOrganId=header.fldOrganId and f1.fldYear=f.fldYear 
					and h2.fldModuleSaveId=h1.fldModuleSaveId and cast(h2.fldDate as date)=cast(h1.fldDate as date) 	
					and fldDocumentNum <>0)t where t.fldid=h1.fldid)Roozane

	outer apply(select  top(1) cast(1 as bit)fldExistsFile from acc.tblDocumentRecorde_File where fldDocumentHeaderId=header.fldid)Doc_File
	cross apply(select max(fldDate) as maxDate from
			(select max(h.fldDate) fldDate from acc.tblDocumentRecord_Header1 as h where h.fldId=h1.fldId
			union all
			select max(l.fldDate) fldDate from acc.tblDocument_HeaderLog as L where l.fldHeaderId =h1.fldId
			union all
			select max(f.fldDate) fldDate from acc.tblDocumentRecorde_File as f where f.fldDocumentHeaderId=header.fldId
			union all
			select max(b.fldDate) fldDate from acc.tblDocumentRecorde_File as f 
			inner join acc.tblDocumentBookMark as b on b.fldDocumentRecordeId=f.fldId
			where f.fldDocumentHeaderId=header.fldId)t)md
outer apply(select top 1  h.fldDocumentNum as fldDocumentNum_Pid from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldPId and h.fldId<h1.fldId order by h.fldId desc )Doc_Pid
outer apply(select top 1  h.fldTypeSanadId as fldTypeSanadId_Pid from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldId  order by h.fldId desc )Typesanad
outer apply(select (select top(1)  N'مرجوع شده (مرتبه ' +cast( ROW_NUMBER() over (order by h.fldid) as varchar(10))+')' from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldId and h.fldTypeSanadId=3 order by h.fldid desc) as fldTypeSanadId_Pid) sanadName
outer APPLY(select top(1) 1 as fldFlag
			FROM   [ACC].[tblDocumentRecord_Details] as d
			inner join acc.tblDocumentRecord_Header as h on h.fldId=d.fldDocument_HedearId
			inner join acc.[tblArtiklMap] as a on a.fldDocumentRecord_DetailsId=d.fldId
			WHERE   fldDocument_HedearId=header.fldId  
			and (fldDocument_HedearId1=h1.fldId
			 or (not exists(select * from Acc.tblDocumentRecord_Details as d2 where d2.fldDocument_HedearId1=h1.fldId ) and fldDocument_HedearId1 is null )) ) flag
WHERE fldTypeSanadId like  @Value AND header.fldOrganId=@fldOrganId  and f.fldYear=@fldYear and h1.fldModuleSaveId=@fldMadule
	--order by fldTarikhDocument,case when fldDocumentNum=0 then 1 else 0 end ,fldDocumentNum
	order by md.maxDate desc,fldDocumentNum desc

		if (@fieldname=N'fldTypeSanadName')
		SELECT top(@h) h1.[fldId], [fldDocumentNum],cast(atf as int ) [fldAtfNum], [fldArchiveNum], [fldDescriptionDocu],header.[fldOrganId] ,[fldTarikhDocument],header.[fldDesc], header.[fldDate], header.[fldIP], header.[fldUserId],[fldAccept] 
	,fldType,case when fldType=1 and fldaccept=1 then N'قطعی' when fldType=1 and fldaccept=0 then N'موقت' when fldType=2 then N'یادداشت' end as fldTypeName
	,cast(ShomareRoozane as int)ShomareRoozane,fldShomareFaree,f.fldYear,fldFiscalYearId
	,fldTypeSanadId as fldTypeSanad ,d.fldName    as fldTypeSanadName,m.fldTitle as fldNameModule,fldModuleErsalId,isnull(fldExistsFile,cast(0 as bit))fldIsArchive
	,case when h1.fldPId is null or fldTypeSanadId<>3 then 0 else Doc_Pid.fldDocumentNum_Pid end fldDocumentNum_Pid,isnull(h1.fldPId,0)fldPId,case when Typesanad.fldTypeSanadId_Pid is null then N'ارسال نشده' when Typesanad.fldTypeSanadId_Pid<>3 then N'ارسال شده' else sanadName.fldTypeSanadId_Pid end fldTypeSanadName_Pid
	,case when fldModuleErsalId in (5,12,13) then ACC.fn_GetSourceId(fldModuleErsalId,header.fldId) when fldPId is null  or fldModuleErsalId=fldModuleSaveId then fldDocumentNum  else (select h.fldDocumentNum from acc.tblDocumentRecord_Header1 as h where h1.fldPId=h.fldid) end fldMainDocNum,isnull(flag.fldFlag,0) as fldFlag, ACC.fn_GetArtiklMap( header.fldId, h1.fldId,h1.fldModuleErsalId) as fldIsMap,fldEdit,case when fldModuleErsalId in(12,13) then ACC.[fn_GetCaseTypeId](fldModuleErsalId,header.fldId) else 0 end as fldCaseTypeId
	FROM   [ACC].[tblDocumentRecord_Header] header inner join acc.tblFiscalYear f on header.fldFiscalYearId=f.fldid
	inner join acc.tblDocumentRecord_Header1 as h1 on h1.fldDocument_HedearId=header.fldid
	inner join[ACC].[tblDocumentType] d on d.fldid=fldTypeSanadId
	left join com.tblModule m on m.fldid=fldModuleErsalId
	outer Apply(
				select atf from (select row_number()over (order by h2.fldId) atf,h2.fldid   
				from acc.tblDocumentRecord_Header h
				inner join acc.tblFiscalYear f1 on h.fldFiscalYearId=f1.fldid
				inner join acc.tblDocumentRecord_Header1 as h2 on h2.fldDocument_HedearId=h.fldid
				where h.fldOrganId=header.fldOrganId and f1.fldYear=f.fldYear 
					and h2.fldModuleSaveId=h1.fldModuleSaveId and fldDocumentNum <>0
					)t where t.fldid=h1.fldid)atfNum

	outer apply (select ShomareRoozane from (select row_number()over (order by h2.fldDate) ShomareRoozane,h2.fldid  
				from acc.tblDocumentRecord_Header h
				inner join acc.tblFiscalYear f1 on h.fldFiscalYearId=f1.fldid
				inner join acc.tblDocumentRecord_Header1 as h2 on h2.fldDocument_HedearId=h.fldid
				where h.fldOrganId=header.fldOrganId and f1.fldYear=f.fldYear 
					and h2.fldModuleSaveId=h1.fldModuleSaveId and cast(h2.fldDate as date)=cast(h1.fldDate as date) 	
					and fldDocumentNum <>0)t where t.fldid=h1.fldid)Roozane

	outer apply(select top(1) cast(1 as bit)fldExistsFile from acc.tblDocumentRecorde_File where fldDocumentHeaderId=header.fldid)Doc_File
	cross apply(select max(fldDate) as maxDate from
			(select max(h.fldDate) fldDate from acc.tblDocumentRecord_Header1 as h where h.fldId=h1.fldId
			union all
			select max(l.fldDate) fldDate from acc.tblDocument_HeaderLog as L where l.fldHeaderId =h1.fldId
			union all
			select max(f.fldDate) fldDate from acc.tblDocumentRecorde_File as f where f.fldDocumentHeaderId=header.fldId
			union all
			select max(b.fldDate) fldDate from acc.tblDocumentRecorde_File as f 
			inner join acc.tblDocumentBookMark as b on b.fldDocumentRecordeId=f.fldId
			where f.fldDocumentHeaderId=header.fldId)t)md
outer apply(select top 1  h.fldDocumentNum as fldDocumentNum_Pid from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldPId and h.fldId<h1.fldId order by h.fldId desc )Doc_Pid
outer apply(select top 1  h.fldTypeSanadId as fldTypeSanadId_Pid from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldId  order by h.fldId desc )Typesanad
outer apply(select (select top(1)  N'مرجوع شده (مرتبه ' +cast( ROW_NUMBER() over (order by h.fldid) as varchar(10))+')' from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldId and h.fldTypeSanadId=3 order by h.fldid desc) as fldTypeSanadId_Pid) sanadName
outer APPLY(select top(1) 1 as fldFlag
			FROM   [ACC].[tblDocumentRecord_Details] as d
			inner join acc.tblDocumentRecord_Header as h on h.fldId=d.fldDocument_HedearId
			inner join acc.[tblArtiklMap] as a on a.fldDocumentRecord_DetailsId=d.fldId
			WHERE   fldDocument_HedearId=header.fldId  
			and (fldDocument_HedearId1=h1.fldId
			 or (not exists(select * from Acc.tblDocumentRecord_Details as d2 where d2.fldDocument_HedearId1=h1.fldId ) and fldDocument_HedearId1 is null )) ) flag
WHERE d.fldName like  @Value AND header.fldOrganId=@fldOrganId  and f.fldYear=@fldYear and h1.fldModuleSaveId=@fldMadule
	--order by fldTarikhDocument,case when fldDocumentNum=0 then 1 else 0 end ,fldDocumentNum
	order by md.maxDate desc,fldDocumentNum desc
	
	if (@fieldname=N'fldNameModule')
		SELECT top(@h) h1.[fldId], [fldDocumentNum],cast(atf as int ) [fldAtfNum], [fldArchiveNum], [fldDescriptionDocu],header.[fldOrganId] ,[fldTarikhDocument],header.[fldDesc], header.[fldDate], header.[fldIP], header.[fldUserId],[fldAccept] 
	,fldType,case when fldType=1 and fldaccept=1 then N'قطعی' when fldType=1 and fldaccept=0 then N'موقت' when fldType=2 then N'یادداشت' end as fldTypeName
	,cast(ShomareRoozane as int)ShomareRoozane,fldShomareFaree,f.fldYear,fldFiscalYearId
	,fldTypeSanadId as fldTypeSanad ,d.fldName    as fldTypeSanadName,m.fldTitle as fldNameModule,fldModuleErsalId,isnull(fldExistsFile,cast(0 as bit))fldIsArchive
	,case when h1.fldPId is null or fldTypeSanadId<>3 then 0 else Doc_Pid.fldDocumentNum_Pid end fldDocumentNum_Pid,isnull(h1.fldPId,0)fldPId,case when Typesanad.fldTypeSanadId_Pid is null then N'ارسال نشده' when Typesanad.fldTypeSanadId_Pid<>3 then N'ارسال شده' else sanadName.fldTypeSanadId_Pid end fldTypeSanadName_Pid
	,case when fldModuleErsalId in (5,12,13) then ACC.fn_GetSourceId(fldModuleErsalId,header.fldId) when fldPId is null  or fldModuleErsalId=fldModuleSaveId then fldDocumentNum  else (select h.fldDocumentNum from acc.tblDocumentRecord_Header1 as h where h1.fldPId=h.fldid) end fldMainDocNum,isnull(flag.fldFlag,0) as fldFlag, ACC.fn_GetArtiklMap( header.fldId, h1.fldId,h1.fldModuleErsalId) as fldIsMap,fldEdit,case when fldModuleErsalId in(12,13) then ACC.[fn_GetCaseTypeId](fldModuleErsalId,header.fldId) else 0 end as fldCaseTypeId
	FROM   [ACC].[tblDocumentRecord_Header] header inner join acc.tblFiscalYear f on header.fldFiscalYearId=f.fldid
	inner join acc.tblDocumentRecord_Header1 as h1 on h1.fldDocument_HedearId=header.fldid
	inner join[ACC].[tblDocumentType] d on d.fldid=fldTypeSanadId
	left join com.tblModule m on m.fldid=fldModuleErsalId
	outer Apply(
				select atf from (select row_number()over (order by h2.fldId) atf,h2.fldid   
				from acc.tblDocumentRecord_Header h
				inner join acc.tblFiscalYear f1 on h.fldFiscalYearId=f1.fldid
				inner join acc.tblDocumentRecord_Header1 as h2 on h2.fldDocument_HedearId=h.fldid
				where h.fldOrganId=header.fldOrganId and f1.fldYear=f.fldYear 
					and h2.fldModuleSaveId=h1.fldModuleSaveId and fldDocumentNum <>0
					)t where t.fldid=h1.fldid)atfNum

	outer apply (select ShomareRoozane from (select row_number()over (order by h2.fldDate) ShomareRoozane,h2.fldid  
				from acc.tblDocumentRecord_Header h
				inner join acc.tblFiscalYear f1 on h.fldFiscalYearId=f1.fldid
				inner join acc.tblDocumentRecord_Header1 as h2 on h2.fldDocument_HedearId=h.fldid
				where h.fldOrganId=header.fldOrganId and f1.fldYear=f.fldYear 
					and h2.fldModuleSaveId=h1.fldModuleSaveId and cast(h2.fldDate as date)=cast(h1.fldDate as date) 	
					and fldDocumentNum <>0)t where t.fldid=h1.fldid)Roozane

	outer apply(select top(1) cast(1 as bit)fldExistsFile from acc.tblDocumentRecorde_File where fldDocumentHeaderId=header.fldid)Doc_File
	cross apply(select max(fldDate) as maxDate from
			(select max(h.fldDate) fldDate from acc.tblDocumentRecord_Header1 as h where h.fldId=h1.fldId
			union all
			select max(l.fldDate) fldDate from acc.tblDocument_HeaderLog as L where l.fldHeaderId =h1.fldId
			union all
			select max(f.fldDate) fldDate from acc.tblDocumentRecorde_File as f where f.fldDocumentHeaderId=header.fldId
			union all
			select max(b.fldDate) fldDate from acc.tblDocumentRecorde_File as f 
			inner join acc.tblDocumentBookMark as b on b.fldDocumentRecordeId=f.fldId
			where f.fldDocumentHeaderId=header.fldId)t)md
outer apply(select top 1  h.fldDocumentNum as fldDocumentNum_Pid from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldPId and h.fldId<h1.fldId order by h.fldId desc )Doc_Pid
outer apply(select top 1  h.fldTypeSanadId as fldTypeSanadId_Pid from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldId  order by h.fldId desc )Typesanad
outer apply(select (select top(1)  N'مرجوع شده (مرتبه ' +cast( ROW_NUMBER() over (order by h.fldid) as varchar(10))+')' from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldId and h.fldTypeSanadId=3 order by h.fldid desc) as fldTypeSanadId_Pid) sanadName
outer APPLY(select top(1) 1 as fldFlag
			FROM   [ACC].[tblDocumentRecord_Details] as d
			inner join acc.tblDocumentRecord_Header as h on h.fldId=d.fldDocument_HedearId
			inner join acc.[tblArtiklMap] as a on a.fldDocumentRecord_DetailsId=d.fldId
			WHERE   fldDocument_HedearId=header.fldId  
			and (fldDocument_HedearId1=h1.fldId
			 or (not exists(select * from Acc.tblDocumentRecord_Details as d2 where d2.fldDocument_HedearId1=h1.fldId ) and fldDocument_HedearId1 is null )) ) flag
WHERE m.fldTitle like  @Value AND header.fldOrganId=@fldOrganId  and f.fldYear=@fldYear and h1.fldModuleSaveId=@fldMadule
	--order by fldTarikhDocument,case when fldDocumentNum=0 then 1 else 0 end ,fldDocumentNum
	order by md.maxDate desc,fldDocumentNum desc
	
	if (@fieldname=N'lastYear')/*farghdare*/
	SELECT top(1) h1.[fldId], [fldDocumentNum],0 [fldAtfNum], [fldArchiveNum], [fldDescriptionDocu],header.[fldOrganId] ,[fldTarikhDocument],header.[fldDesc], header.[fldDate], header.[fldIP], header.[fldUserId],[fldAccept] 
	,fldType,case when fldType=1 and fldaccept=1 then N'قطعی' when fldType=1 and fldaccept=0 then N'موقت' when fldType=2 then N'یادداشت' end as fldTypeName
	,0 ShomareRoozane,fldShomareFaree,f.fldYear,fldFiscalYearId
	,fldTypeSanadId as fldTypeSanad ,d.fldName    as fldTypeSanadName,m.fldTitle as fldNameModule,fldModuleErsalId,cast(0 as bit)fldIsArchive
	,case when h1.fldPId is null or fldTypeSanadId<>3 then 0 else Doc_Pid.fldDocumentNum_Pid end fldDocumentNum_Pid,isnull(h1.fldPId,0)fldPId,case when Typesanad.fldTypeSanadId_Pid is null then N'ارسال نشده' when Typesanad.fldTypeSanadId_Pid<>3 then N'ارسال شده' else sanadName.fldTypeSanadId_Pid end fldTypeSanadName_Pid
	,case when fldModuleErsalId in (5,12,13) then ACC.fn_GetSourceId(fldModuleErsalId,header.fldId) when fldPId is null  or fldModuleErsalId=fldModuleSaveId then fldDocumentNum  else (select h.fldDocumentNum from acc.tblDocumentRecord_Header1 as h where h1.fldPId=h.fldid) end fldMainDocNum,isnull(flag.fldFlag,0) as fldFlag, ACC.fn_GetArtiklMap( header.fldId, h1.fldId,h1.fldModuleErsalId) as fldIsMap,fldEdit,case when fldModuleErsalId in(12,13) then ACC.[fn_GetCaseTypeId](fldModuleErsalId,header.fldId) else 0 end as fldCaseTypeId
	FROM   [ACC].[tblDocumentRecord_Header] header inner join acc.tblFiscalYear f on header.fldFiscalYearId=f.fldid
	inner join acc.tblDocumentRecord_Header1 as h1 on h1.fldDocument_HedearId=header.fldid
	inner join[ACC].[tblDocumentType] d on d.fldid=fldTypeSanadId
	left join com.tblModule m on m.fldid=fldModuleErsalId
outer apply(select top 1  h.fldDocumentNum as fldDocumentNum_Pid from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldPId and h.fldId<h1.fldId order by h.fldId desc )Doc_Pid
outer apply(select top 1  h.fldTypeSanadId as fldTypeSanadId_Pid from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldId  order by h.fldId desc )Typesanad
outer apply(select (select top(1)  N'مرجوع شده (مرتبه ' +cast( ROW_NUMBER() over (order by h.fldid) as varchar(10))+')' from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldId and h.fldTypeSanadId=3 order by h.fldid desc) as fldTypeSanadId_Pid) sanadName
outer APPLY(select top(1) 1 as fldFlag
			FROM   [ACC].[tblDocumentRecord_Details] as d
			inner join acc.tblDocumentRecord_Header as h on h.fldId=d.fldDocument_HedearId
			inner join acc.[tblArtiklMap] as a on a.fldDocumentRecord_DetailsId=d.fldId
			WHERE   fldDocument_HedearId=header.fldId  
			and (fldDocument_HedearId1=h1.fldId
			 or (not exists(select * from Acc.tblDocumentRecord_Details as d2 where d2.fldDocument_HedearId1=h1.fldId ) and fldDocument_HedearId1 is null )) ) flag
where header.fldOrganId=@fldOrganId and fldModuleSaveId=@fldMadule
	order by fldYear desc


	if (@fieldname=N'lastDateDoc')/*farghdare*/
	SELECT top(1) h1.[fldId], [fldDocumentNum],0 [fldAtfNum], [fldArchiveNum], [fldDescriptionDocu],header.[fldOrganId] ,[fldTarikhDocument],header.[fldDesc], header.[fldDate], header.[fldIP], header.[fldUserId],[fldAccept] 
	,fldType,case when fldType=1 and fldaccept=1 then N'قطعی' when fldType=1 and fldaccept=0 then N'موقت' when fldType=2 then N'یادداشت' end as fldTypeName
	,0 ShomareRoozane,fldShomareFaree,f.fldYear,fldFiscalYearId
	,fldTypeSanadId as fldTypeSanad ,d.fldName    as fldTypeSanadName,m.fldTitle as fldNameModule,fldModuleErsalId,cast(0 as bit)fldIsArchive
	,case when h1.fldPId is null or fldTypeSanadId<>3 then 0 else Doc_Pid.fldDocumentNum_Pid end fldDocumentNum_Pid,isnull(h1.fldPId,0)fldPId,case when Typesanad.fldTypeSanadId_Pid is null then N'ارسال نشده' when Typesanad.fldTypeSanadId_Pid<>3 then N'ارسال شده' else sanadName.fldTypeSanadId_Pid end fldTypeSanadName_Pid
	,case when fldModuleErsalId in (5,12,13) then ACC.fn_GetSourceId(fldModuleErsalId,header.fldId) when fldPId is null  or fldModuleErsalId=fldModuleSaveId then fldDocumentNum  else (select h.fldDocumentNum from acc.tblDocumentRecord_Header1 as h where h1.fldPId=h.fldid) end fldMainDocNum,isnull(flag.fldFlag,0) as fldFlag, ACC.fn_GetArtiklMap( header.fldId, h1.fldId,h1.fldModuleErsalId) as fldIsMap,fldEdit,case when fldModuleErsalId in(12,13) then ACC.[fn_GetCaseTypeId](fldModuleErsalId,header.fldId) else 0 end as fldCaseTypeId
	FROM   [ACC].[tblDocumentRecord_Header] header inner join acc.tblFiscalYear f on header.fldFiscalYearId=f.fldid
	inner join acc.tblDocumentRecord_Header1 as h1 on h1.fldDocument_HedearId=header.fldid
	inner join[ACC].[tblDocumentType] d on d.fldid=fldTypeSanadId
outer apply(select top 1  h.fldDocumentNum as fldDocumentNum_Pid from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldPId and h.fldId<h1.fldId order by h.fldId desc )Doc_Pid
outer apply(select top 1  h.fldTypeSanadId as fldTypeSanadId_Pid from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldId  order by h.fldId desc )Typesanad
outer apply(select (select top(1)  N'مرجوع شده (مرتبه ' +cast( ROW_NUMBER() over (order by h.fldid) as varchar(10))+')' from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldId and h.fldTypeSanadId=3 order by h.fldid desc) as fldTypeSanadId_Pid) sanadName
outer APPLY(select top(1) 1 as fldFlag
			FROM   [ACC].[tblDocumentRecord_Details] as d
			inner join acc.tblDocumentRecord_Header as h on h.fldId=d.fldDocument_HedearId
			inner join acc.[tblArtiklMap] as a on a.fldDocumentRecord_DetailsId=d.fldId
			WHERE   fldDocument_HedearId=header.fldId  
			and (fldDocument_HedearId1=h1.fldId
			 or (not exists(select * from Acc.tblDocumentRecord_Details as d2 where d2.fldDocument_HedearId1=h1.fldId ) and fldDocument_HedearId1 is null )) ) flag
left join com.tblModule m on m.fldid=fldModuleErsalId
	where header.fldOrganId=@fldOrganId and fldModuleSaveId=@fldMadule and f.fldYear=@fldYear and header.fldId<>@Value
	order by fldTarikhDocument DESC
    


	if (@fieldname=N'fldAzTarikh_TaTarikhDoc')
	BEGIN
    IF (@Value='')
		SELECT top(@h) h1.[fldId], [fldDocumentNum],cast(atf as int ) [fldAtfNum], [fldArchiveNum], [fldDescriptionDocu],header.[fldOrganId] ,[fldTarikhDocument],header.[fldDesc], header.[fldDate], header.[fldIP], header.[fldUserId],[fldAccept] 
	,fldType,case when fldType=1 and fldaccept=1 then N'قطعی' when fldType=1 and fldaccept=0 then N'موقت' when fldType=2 then N'یادداشت' end as fldTypeName
	,cast(ShomareRoozane as int)ShomareRoozane,fldShomareFaree,f.fldYear,fldFiscalYearId
	,fldTypeSanadId as fldTypeSanad ,d.fldName    as fldTypeSanadName,m.fldTitle as fldNameModule,fldModuleErsalId,isnull(fldExistsFile,cast(0 as bit))fldIsArchive
	,case when h1.fldPId is null or fldTypeSanadId<>3 then 0 else Doc_Pid.fldDocumentNum_Pid end fldDocumentNum_Pid,isnull(h1.fldPId,0)fldPId,case when Typesanad.fldTypeSanadId_Pid is null then N'ارسال نشده' when Typesanad.fldTypeSanadId_Pid<>3 then N'ارسال شده' else sanadName.fldTypeSanadId_Pid end fldTypeSanadName_Pid
	,case when fldModuleErsalId in (5,12,13) then ACC.fn_GetSourceId(fldModuleErsalId,header.fldId) when fldPId is null  or fldModuleErsalId=fldModuleSaveId then fldDocumentNum  else (select h.fldDocumentNum from acc.tblDocumentRecord_Header1 as h where h1.fldPId=h.fldid) end fldMainDocNum,isnull(flag.fldFlag,0) as fldFlag, ACC.fn_GetArtiklMap( header.fldId, h1.fldId,h1.fldModuleErsalId) as fldIsMap,fldEdit,case when fldModuleErsalId in(12,13) then ACC.[fn_GetCaseTypeId](fldModuleErsalId,header.fldId) else 0 end as fldCaseTypeId
	FROM   [ACC].[tblDocumentRecord_Header] header inner join acc.tblFiscalYear f on header.fldFiscalYearId=f.fldid
	inner join acc.tblDocumentRecord_Header1 as h1 on h1.fldDocument_HedearId=header.fldid
	inner join[ACC].[tblDocumentType] d on d.fldid=fldTypeSanadId
	left join com.tblModule m on m.fldid=fldModuleErsalId
	outer Apply(
				select atf from (select row_number()over (order by h2.fldId) atf,h2.fldid   
				from acc.tblDocumentRecord_Header h
				inner join acc.tblFiscalYear f1 on h.fldFiscalYearId=f1.fldid
				inner join acc.tblDocumentRecord_Header1 as h2 on h2.fldDocument_HedearId=h.fldid
				where h.fldOrganId=header.fldOrganId and f1.fldYear=f.fldYear 
					and h2.fldModuleSaveId=h1.fldModuleSaveId and fldDocumentNum <>0
					)t where t.fldid=h1.fldid)atfNum

	outer apply (select ShomareRoozane from (select row_number()over (order by h2.fldDate) ShomareRoozane,h2.fldid  
				from acc.tblDocumentRecord_Header h
				inner join acc.tblFiscalYear f1 on h.fldFiscalYearId=f1.fldid
				inner join acc.tblDocumentRecord_Header1 as h2 on h2.fldDocument_HedearId=h.fldid
				where h.fldOrganId=header.fldOrganId and f1.fldYear=f.fldYear 
					and h2.fldModuleSaveId=h1.fldModuleSaveId and cast(h2.fldDate as date)=cast(h1.fldDate as date) 	
					and fldDocumentNum <>0)t where t.fldid=h1.fldid)Roozane

	outer apply(select top(1) cast(1 as bit)fldExistsFile from acc.tblDocumentRecorde_File where fldDocumentHeaderId=header.fldid)Doc_File
	cross apply(select max(fldDate) as maxDate from
			(select max(h.fldDate) fldDate from acc.tblDocumentRecord_Header1 as h where h.fldId=h1.fldId
			union all
			select max(l.fldDate) fldDate from acc.tblDocument_HeaderLog as L where l.fldHeaderId =h1.fldId
			union all
			select max(f.fldDate) fldDate from acc.tblDocumentRecorde_File as f where f.fldDocumentHeaderId=header.fldId
			union all
			select max(b.fldDate) fldDate from acc.tblDocumentRecorde_File as f 
			inner join acc.tblDocumentBookMark as b on b.fldDocumentRecordeId=f.fldId
			where f.fldDocumentHeaderId=header.fldId)t)md
outer apply(select top 1  h.fldDocumentNum as fldDocumentNum_Pid from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldPId and h.fldId<h1.fldId order by h.fldId desc )Doc_Pid
outer apply(select top 1  h.fldTypeSanadId as fldTypeSanadId_Pid from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldId  order by h.fldId desc )Typesanad
outer apply(select (select top(1)  N'مرجوع شده (مرتبه ' +cast( ROW_NUMBER() over (order by h.fldid) as varchar(10))+')' from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldId and h.fldTypeSanadId=3 order by h.fldid desc) as fldTypeSanadId_Pid) sanadName
outer APPLY(select top(1) 1 as fldFlag
			FROM   [ACC].[tblDocumentRecord_Details] as d
			inner join acc.tblDocumentRecord_Header as h on h.fldId=d.fldDocument_HedearId
			inner join acc.[tblArtiklMap] as a on a.fldDocumentRecord_DetailsId=d.fldId
			WHERE   fldDocument_HedearId=header.fldId  
			and (fldDocument_HedearId1=h1.fldId
			 or (not exists(select * from Acc.tblDocumentRecord_Details as d2 where d2.fldDocument_HedearId1=h1.fldId ) and fldDocument_HedearId1 is null )) ) flag
WHERE header.fldOrganId=@fldOrganId  /*and f.fldYear=@fldYear */and h1.fldModuleSaveId=@fldMadule
AND h1.fldTarikhDocument BETWEEN @value1 AND @value2 AND h1.fldDocumentNum<>0
	--order by fldTarikhDocument,case when fldDocumentNum=0 then 1 else 0 end ,fldDocumentNum
	order by md.maxDate desc,fldDocumentNum desc
    
 else
		SELECT top(@h) h1.[fldId], [fldDocumentNum],cast(atf as int ) [fldAtfNum], [fldArchiveNum], [fldDescriptionDocu],header.[fldOrganId] ,[fldTarikhDocument],header.[fldDesc], header.[fldDate], header.[fldIP], header.[fldUserId],[fldAccept] 
	,fldType,case when fldType=1 and fldaccept=1 then N'قطعی' when fldType=1 and fldaccept=0 then N'موقت' when fldType=2 then N'یادداشت' end as fldTypeName
	,cast(ShomareRoozane as int)ShomareRoozane,fldShomareFaree,f.fldYear,fldFiscalYearId
	,fldTypeSanadId as fldTypeSanad ,d.fldName    as fldTypeSanadName,m.fldTitle as fldNameModule,fldModuleErsalId,isnull(fldExistsFile,cast(0 as bit))fldIsArchive
	,case when h1.fldPId is null or fldTypeSanadId<>3 then 0 else Doc_Pid.fldDocumentNum_Pid end fldDocumentNum_Pid,isnull(h1.fldPId,0)fldPId,case when Typesanad.fldTypeSanadId_Pid is null then N'ارسال نشده' when Typesanad.fldTypeSanadId_Pid<>3 then N'ارسال شده' else sanadName.fldTypeSanadId_Pid end fldTypeSanadName_Pid
	,case when fldModuleErsalId in (5,12,13) then ACC.fn_GetSourceId(fldModuleErsalId,header.fldId) when fldPId is null  or fldModuleErsalId=fldModuleSaveId then fldDocumentNum  else (select h.fldDocumentNum from acc.tblDocumentRecord_Header1 as h where h1.fldPId=h.fldid) end fldMainDocNum,isnull(flag.fldFlag,0) as fldFlag, ACC.fn_GetArtiklMap( header.fldId, h1.fldId,h1.fldModuleErsalId) as fldIsMap,fldEdit,case when fldModuleErsalId in(12,13) then ACC.[fn_GetCaseTypeId](fldModuleErsalId,header.fldId) else 0 end as fldCaseTypeId
	FROM   [ACC].[tblDocumentRecord_Header] header inner join acc.tblFiscalYear f on header.fldFiscalYearId=f.fldid
	inner join acc.tblDocumentRecord_Header1 as h1 on h1.fldDocument_HedearId=header.fldid
	inner join[ACC].[tblDocumentType] d on d.fldid=fldTypeSanadId
	left join com.tblModule m on m.fldid=fldModuleErsalId
	outer Apply(
				select atf from (select row_number()over (order by h2.fldId) atf,h2.fldid   
				from acc.tblDocumentRecord_Header h
				inner join acc.tblFiscalYear f1 on h.fldFiscalYearId=f1.fldid
				inner join acc.tblDocumentRecord_Header1 as h2 on h2.fldDocument_HedearId=h.fldid
				where h.fldOrganId=header.fldOrganId and f1.fldYear=f.fldYear 
					and h2.fldModuleSaveId=h1.fldModuleSaveId and fldDocumentNum <>0
					)t where t.fldid=h1.fldid)atfNum

	outer apply (select ShomareRoozane from (select row_number()over (order by h2.fldDate) ShomareRoozane,h2.fldid  
				from acc.tblDocumentRecord_Header h
				inner join acc.tblFiscalYear f1 on h.fldFiscalYearId=f1.fldid
				inner join acc.tblDocumentRecord_Header1 as h2 on h2.fldDocument_HedearId=h.fldid
				where h.fldOrganId=header.fldOrganId and f1.fldYear=f.fldYear 
					and h2.fldModuleSaveId=h1.fldModuleSaveId and cast(h2.fldDate as date)=cast(h1.fldDate as date) 	
					and fldDocumentNum <>0)t where t.fldid=h1.fldid)Roozane

	outer apply(select top(1) cast(1 as bit)fldExistsFile from acc.tblDocumentRecorde_File where fldDocumentHeaderId=header.fldid)Doc_File
	cross apply(select max(fldDate) as maxDate from
			(select max(h.fldDate) fldDate from acc.tblDocumentRecord_Header1 as h where h.fldId=h1.fldId
			union all
			select max(l.fldDate) fldDate from acc.tblDocument_HeaderLog as L where l.fldHeaderId =h1.fldId
			union all
			select max(f.fldDate) fldDate from acc.tblDocumentRecorde_File as f where f.fldDocumentHeaderId=header.fldId
			union all
			select max(b.fldDate) fldDate from acc.tblDocumentRecorde_File as f 
			inner join acc.tblDocumentBookMark as b on b.fldDocumentRecordeId=f.fldId
			where f.fldDocumentHeaderId=header.fldId)t)md
outer apply(select top 1  h.fldDocumentNum as fldDocumentNum_Pid from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldPId and h.fldId<h1.fldId order by h.fldId desc )Doc_Pid
outer apply(select top 1  h.fldTypeSanadId as fldTypeSanadId_Pid from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldId  order by h.fldId desc )Typesanad
outer apply(select (select top(1)  N'مرجوع شده (مرتبه ' +cast( ROW_NUMBER() over (order by h.fldid) as varchar(10))+')' from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldId and h.fldTypeSanadId=3 order by h.fldid desc) as fldTypeSanadId_Pid) sanadName
CROSS APPLY(SELECT hh.fldDocumentNum t_Doc FROM acc.tblDocumentRecord_Header1 hh WHERE hh.fldId=@Value)TarikhSanad
outer APPLY(select top(1) 1 as fldFlag
			FROM   [ACC].[tblDocumentRecord_Details] as d
			inner join acc.tblDocumentRecord_Header as h on h.fldId=d.fldDocument_HedearId
			inner join acc.[tblArtiklMap] as a on a.fldDocumentRecord_DetailsId=d.fldId
			WHERE   fldDocument_HedearId=header.fldId  
			and (fldDocument_HedearId1=h1.fldId
			 or (not exists(select * from Acc.tblDocumentRecord_Details as d2 where d2.fldDocument_HedearId1=h1.fldId ) and fldDocument_HedearId1 is null )) ) flag
WHERE header.fldOrganId=@fldOrganId  /*and f.fldYear=@fldYear*/ and h1.fldModuleSaveId=@fldMadule
AND h1.fldTarikhDocument BETWEEN @value1 AND @value2 AND h1.fldDocumentNum  >=TarikhSanad.t_Doc
AND h1.fldDocumentNum<>0
	--order by fldTarikhDocument,case when fldDocumentNum=0 then 1 else 0 end ,fldDocumentNum
	order by md.maxDate desc,fldDocumentNum desc


END

if (@fieldname=N'fldAzMah_TaMahDoc')
	BEGIN
    IF (@Value='')
		SELECT top(@h) h1.[fldId], [fldDocumentNum],cast(atf as int ) [fldAtfNum], [fldArchiveNum], [fldDescriptionDocu],header.[fldOrganId] ,[fldTarikhDocument],header.[fldDesc], header.[fldDate], header.[fldIP], header.[fldUserId],[fldAccept] 
	,fldType,case when fldType=1 and fldaccept=1 then N'قطعی' when fldType=1 and fldaccept=0 then N'موقت' when fldType=2 then N'یادداشت' end as fldTypeName
	,cast(ShomareRoozane as int)ShomareRoozane,fldShomareFaree,f.fldYear,fldFiscalYearId
	,fldTypeSanadId as fldTypeSanad ,d.fldName    as fldTypeSanadName,m.fldTitle as fldNameModule,fldModuleErsalId,isnull(fldExistsFile,cast(0 as bit))fldIsArchive
	,case when h1.fldPId is null or fldTypeSanadId<>3 then 0 else Doc_Pid.fldDocumentNum_Pid end fldDocumentNum_Pid,isnull(h1.fldPId,0)fldPId,case when Typesanad.fldTypeSanadId_Pid is null then N'ارسال نشده' when Typesanad.fldTypeSanadId_Pid<>3 then N'ارسال شده' else sanadName.fldTypeSanadId_Pid end fldTypeSanadName_Pid
	,case when fldModuleErsalId in (5,12,13) then ACC.fn_GetSourceId(fldModuleErsalId,header.fldId) when fldPId is null  or fldModuleErsalId=fldModuleSaveId then fldDocumentNum  else (select h.fldDocumentNum from acc.tblDocumentRecord_Header1 as h where h1.fldPId=h.fldid) end fldMainDocNum,isnull(flag.fldFlag,0) as fldFlag, ACC.fn_GetArtiklMap( header.fldId, h1.fldId,h1.fldModuleErsalId) as fldIsMap,fldEdit,case when fldModuleErsalId in(12,13) then ACC.[fn_GetCaseTypeId](fldModuleErsalId,header.fldId) else 0 end as fldCaseTypeId
	FROM   [ACC].[tblDocumentRecord_Header] header inner join acc.tblFiscalYear f on header.fldFiscalYearId=f.fldid
	inner join acc.tblDocumentRecord_Header1 as h1 on h1.fldDocument_HedearId=header.fldid
	inner join[ACC].[tblDocumentType] d on d.fldid=fldTypeSanadId
	left join com.tblModule m on m.fldid=fldModuleErsalId
	outer Apply(
				select atf from (select row_number()over (order by h2.fldId) atf,h2.fldid   
				from acc.tblDocumentRecord_Header h
				inner join acc.tblFiscalYear f1 on h.fldFiscalYearId=f1.fldid
				inner join acc.tblDocumentRecord_Header1 as h2 on h2.fldDocument_HedearId=h.fldid
				where h.fldOrganId=header.fldOrganId and f1.fldYear=f.fldYear 
					and h2.fldModuleSaveId=h1.fldModuleSaveId and fldDocumentNum <>0
					)t where t.fldid=h1.fldid)atfNum

	outer apply (select ShomareRoozane from (select row_number()over (order by h2.fldDate) ShomareRoozane,h2.fldid  
				from acc.tblDocumentRecord_Header h
				inner join acc.tblFiscalYear f1 on h.fldFiscalYearId=f1.fldid
				inner join acc.tblDocumentRecord_Header1 as h2 on h2.fldDocument_HedearId=h.fldid
				where h.fldOrganId=header.fldOrganId and f1.fldYear=f.fldYear 
					and h2.fldModuleSaveId=h1.fldModuleSaveId and cast(h2.fldDate as date)=cast(h1.fldDate as date) 	
					and fldDocumentNum <>0)t where t.fldid=h1.fldid)Roozane

	outer apply(select top(1) cast(1 as bit)fldExistsFile from acc.tblDocumentRecorde_File where fldDocumentHeaderId=header.fldid)Doc_File
	cross apply(select max(fldDate) as maxDate from
			(select max(h.fldDate) fldDate from acc.tblDocumentRecord_Header1 as h where h.fldId=h1.fldId
			union all
			select max(l.fldDate) fldDate from acc.tblDocument_HeaderLog as L where l.fldHeaderId =h1.fldId
			union all
			select max(f.fldDate) fldDate from acc.tblDocumentRecorde_File as f where f.fldDocumentHeaderId=header.fldId
			union all
			select max(b.fldDate) fldDate from acc.tblDocumentRecorde_File as f 
			inner join acc.tblDocumentBookMark as b on b.fldDocumentRecordeId=f.fldId
			where f.fldDocumentHeaderId=header.fldId)t)md
outer apply(select top 1  h.fldDocumentNum as fldDocumentNum_Pid from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldPId and h.fldId<h1.fldId order by h.fldId desc )Doc_Pid
outer apply(select top 1  h.fldTypeSanadId as fldTypeSanadId_Pid from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldId  order by h.fldId desc )Typesanad
outer apply(select (select top(1)  N'مرجوع شده (مرتبه ' +cast( ROW_NUMBER() over (order by h.fldid) as varchar(10))+')' from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldId and h.fldTypeSanadId=3 order by h.fldid desc) as fldTypeSanadId_Pid) sanadName
outer APPLY(select top(1) 1 as fldFlag
			FROM   [ACC].[tblDocumentRecord_Details] as d
			inner join acc.tblDocumentRecord_Header as h on h.fldId=d.fldDocument_HedearId
			inner join acc.[tblArtiklMap] as a on a.fldDocumentRecord_DetailsId=d.fldId
			WHERE   fldDocument_HedearId=header.fldId  
			and (fldDocument_HedearId1=h1.fldId
			 or (not exists(select * from Acc.tblDocumentRecord_Details as d2 where d2.fldDocument_HedearId1=h1.fldId ) and fldDocument_HedearId1 is null )) ) flag
WHERE header.fldOrganId=@fldOrganId  and f.fldYear=@fldYear and h1.fldModuleSaveId=@fldMadule
AND SUBSTRING(h1.fldTarikhDocument,6,2) BETWEEN @value1 AND @value2 AND h1.fldDocumentNum<>0
	--order by fldTarikhDocument,case when fldDocumentNum=0 then 1 else 0 end ,fldDocumentNum
	order by md.maxDate desc,fldDocumentNum desc
    
 else
		SELECT top(@h) h1.[fldId], [fldDocumentNum],cast(atf as int ) [fldAtfNum], [fldArchiveNum], [fldDescriptionDocu],header.[fldOrganId] ,[fldTarikhDocument],header.[fldDesc], header.[fldDate], header.[fldIP], header.[fldUserId],[fldAccept] 
	,fldType,case when fldType=1 and fldaccept=1 then N'قطعی' when fldType=1 and fldaccept=0 then N'موقت' when fldType=2 then N'یادداشت' end as fldTypeName
	,cast(ShomareRoozane as int)ShomareRoozane,fldShomareFaree,f.fldYear,fldFiscalYearId
	,fldTypeSanadId as fldTypeSanad ,d.fldName    as fldTypeSanadName,m.fldTitle as fldNameModule,fldModuleErsalId,isnull(fldExistsFile,cast(0 as bit))fldIsArchive
	,case when h1.fldPId is null or fldTypeSanadId<>3 then 0 else Doc_Pid.fldDocumentNum_Pid end fldDocumentNum_Pid,isnull(h1.fldPId,0)fldPId,case when Typesanad.fldTypeSanadId_Pid is null then N'ارسال نشده' when Typesanad.fldTypeSanadId_Pid<>3 then N'ارسال شده' else sanadName.fldTypeSanadId_Pid end fldTypeSanadName_Pid
	,case when fldModuleErsalId in (5,12,13) then ACC.fn_GetSourceId(fldModuleErsalId,header.fldId) when fldPId is null  or fldModuleErsalId=fldModuleSaveId then fldDocumentNum  else (select h.fldDocumentNum from acc.tblDocumentRecord_Header1 as h where h1.fldPId=h.fldid) end fldMainDocNum,isnull(flag.fldFlag,0) as fldFlag, ACC.fn_GetArtiklMap( header.fldId, h1.fldId,h1.fldModuleErsalId) as fldIsMap,fldEdit,case when fldModuleErsalId in(12,13) then ACC.[fn_GetCaseTypeId](fldModuleErsalId,header.fldId) else 0 end as fldCaseTypeId
	FROM   [ACC].[tblDocumentRecord_Header] header inner join acc.tblFiscalYear f on header.fldFiscalYearId=f.fldid
	inner join acc.tblDocumentRecord_Header1 as h1 on h1.fldDocument_HedearId=header.fldid
	inner join[ACC].[tblDocumentType] d on d.fldid=fldTypeSanadId
	left join com.tblModule m on m.fldid=fldModuleErsalId
	outer Apply(
				select atf from (select row_number()over (order by h2.fldId) atf,h2.fldid   
				from acc.tblDocumentRecord_Header h
				inner join acc.tblFiscalYear f1 on h.fldFiscalYearId=f1.fldid
				inner join acc.tblDocumentRecord_Header1 as h2 on h2.fldDocument_HedearId=h.fldid
				where h.fldOrganId=header.fldOrganId and f1.fldYear=f.fldYear 
					and h2.fldModuleSaveId=h1.fldModuleSaveId and fldDocumentNum <>0
					)t where t.fldid=h1.fldid)atfNum

	outer apply (select ShomareRoozane from (select row_number()over (order by h2.fldDate) ShomareRoozane,h2.fldid  
				from acc.tblDocumentRecord_Header h
				inner join acc.tblFiscalYear f1 on h.fldFiscalYearId=f1.fldid
				inner join acc.tblDocumentRecord_Header1 as h2 on h2.fldDocument_HedearId=h.fldid
				where h.fldOrganId=header.fldOrganId and f1.fldYear=f.fldYear 
					and h2.fldModuleSaveId=h1.fldModuleSaveId and cast(h2.fldDate as date)=cast(h1.fldDate as date) 	
					and fldDocumentNum <>0)t where t.fldid=h1.fldid)Roozane

	outer apply(select top(1) cast(1 as bit)fldExistsFile from acc.tblDocumentRecorde_File where fldDocumentHeaderId=header.fldid)Doc_File
	cross apply(select max(fldDate) as maxDate from
			(select max(h.fldDate) fldDate from acc.tblDocumentRecord_Header1 as h where h.fldId=h1.fldId
			union all
			select max(l.fldDate) fldDate from acc.tblDocument_HeaderLog as L where l.fldHeaderId =h1.fldId
			union all
			select max(f.fldDate) fldDate from acc.tblDocumentRecorde_File as f where f.fldDocumentHeaderId=header.fldId
			union all
			select max(b.fldDate) fldDate from acc.tblDocumentRecorde_File as f 
			inner join acc.tblDocumentBookMark as b on b.fldDocumentRecordeId=f.fldId
			where f.fldDocumentHeaderId=header.fldId)t)md
outer apply(select top 1  h.fldDocumentNum as fldDocumentNum_Pid from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldPId and h.fldId<h1.fldId order by h.fldId desc )Doc_Pid
outer apply(select top 1  h.fldTypeSanadId as fldTypeSanadId_Pid from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldId  order by h.fldId desc )Typesanad
outer apply(select (select top(1)  N'مرجوع شده (مرتبه ' +cast( ROW_NUMBER() over (order by h.fldid) as varchar(10))+')' from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldId and h.fldTypeSanadId=3 order by h.fldid desc) as fldTypeSanadId_Pid) sanadName
CROSS APPLY(SELECT hh.fldDocumentNum T_doc FROM acc.tblDocumentRecord_Header1 hh WHERE hh.fldid=@Value)TarikhSanad
outer APPLY(select top(1) 1 as fldFlag
			FROM   [ACC].[tblDocumentRecord_Details] as d
			inner join acc.tblDocumentRecord_Header as h on h.fldId=d.fldDocument_HedearId
			inner join acc.[tblArtiklMap] as a on a.fldDocumentRecord_DetailsId=d.fldId
			WHERE   fldDocument_HedearId=header.fldId  
			and (fldDocument_HedearId1=h1.fldId
			 or (not exists(select * from Acc.tblDocumentRecord_Details as d2 where d2.fldDocument_HedearId1=h1.fldId ) and fldDocument_HedearId1 is null )) ) flag
WHERE header.fldOrganId=@fldOrganId  and f.fldYear=@fldYear and h1.fldModuleSaveId=@fldMadule
AND  SUBSTRING(h1.fldTarikhDocument,6,2) BETWEEN @value1 AND @value2 AND h1.fldDocumentNum  >=TarikhSanad.T_doc
AND h1.fldDocumentNum<>0
	--order by fldTarikhDocument,case when fldDocumentNum=0 then 1 else 0 end ,fldDocumentNum
	order by md.maxDate desc,fldDocumentNum desc


end

end

if (@typeorder=2)
begin 
if (@fieldname=N'fldId')
	SELECT  h1.[fldId], [fldDocumentNum],cast(atf as int ) [fldAtfNum], [fldArchiveNum], [fldDescriptionDocu],header.[fldOrganId] ,[fldTarikhDocument],header.[fldDesc], header.[fldDate], header.[fldIP], header.[fldUserId],[fldAccept] 
	,fldType,case when fldType=1 and fldaccept=1 then N'قطعی' when fldType=1 and fldaccept=0 then N'موقت' when fldType=2 then N'یادداشت' end as fldTypeName
	,cast(ShomareRoozane as int)ShomareRoozane,fldShomareFaree,f.fldYear,fldFiscalYearId
	,fldTypeSanadId as fldTypeSanad ,d.fldName    as fldTypeSanadName,m.fldTitle as fldNameModule,fldModuleErsalId,isnull(fldExistsFile,cast(0 as bit))fldIsArchive
	,case when h1.fldPId is null or fldTypeSanadId<>3 then 0 else Doc_Pid.fldDocumentNum_Pid end fldDocumentNum_Pid,isnull(h1.fldPId,0)fldPId,case when Typesanad.fldTypeSanadId_Pid is null then N'ارسال نشده' when Typesanad.fldTypeSanadId_Pid<>3 then N'ارسال شده' else sanadName.fldTypeSanadId_Pid end fldTypeSanadName_Pid
	,case when fldModuleErsalId in (5,12,13) then ACC.fn_GetSourceId(fldModuleErsalId,header.fldId)	
	when fldPId is null  or fldModuleErsalId=fldModuleSaveId  then fldDocumentNum  
	else (select h.fldDocumentNum from acc.tblDocumentRecord_Header1 as h where h1.fldPId=h.fldid) end fldMainDocNum,isnull(flag.fldFlag,0) as fldFlag, ACC.fn_GetArtiklMap( header.fldId, h1.fldId,h1.fldModuleErsalId) as fldIsMap
	,fldEdit,case when fldModuleErsalId in(12,13) then ACC.[fn_GetCaseTypeId](fldModuleErsalId,header.fldId) else 0 end as fldCaseTypeId

	FROM   [ACC].[tblDocumentRecord_Header] header 
	inner join acc.tblFiscalYear f on header.fldFiscalYearId=f.fldid 
	inner join acc.tblDocumentRecord_Header1 as h1 on h1.fldDocument_HedearId=header.fldid
	inner join[ACC].[tblDocumentType] d on d.fldid=h1.fldTypeSanadId
	left join com.tblModule m on m.fldid=h1.fldModuleErsalId
	outer Apply(
				select atf from (select row_number()over (order by h2.fldId) atf,h2.fldid   
				from acc.tblDocumentRecord_Header h
				inner join acc.tblFiscalYear f1 on h.fldFiscalYearId=f1.fldid
				inner join acc.tblDocumentRecord_Header1 as h2 on h2.fldDocument_HedearId=h.fldid
				where h.fldOrganId=header.fldOrganId and f1.fldYear=f.fldYear 
					and h2.fldModuleSaveId=h1.fldModuleSaveId and fldDocumentNum <>0
					)t where t.fldid=h1.fldid)atfNum

		outer apply (select ShomareRoozane from (select row_number()over (order by h2.fldDate) ShomareRoozane,h2.fldid  
				from acc.tblDocumentRecord_Header h
				inner join acc.tblFiscalYear f1 on h.fldFiscalYearId=f1.fldid
				inner join acc.tblDocumentRecord_Header1 as h2 on h2.fldDocument_HedearId=h.fldid
				where h.fldOrganId=header.fldOrganId and f1.fldYear=f.fldYear 
					and h2.fldModuleSaveId=h1.fldModuleSaveId and cast(h2.fldDate as date)=cast(h1.fldDate as date) 	
					and fldDocumentNum <>0)t where t.fldid=h1.fldid)Roozane

	outer apply(select top(1) cast(1 as bit)fldExistsFile from acc.tblDocumentRecorde_File where fldDocumentHeaderId=header.fldid)Doc_File
	cross apply(select max(fldDate) as maxDate from
			(select max(h.fldDate) fldDate from acc.tblDocumentRecord_Header1 as h where h.fldId=h1.fldId
			union all
			select max(l.fldDate) fldDate from acc.tblDocument_HeaderLog as L where l.fldHeaderId =h1.fldId
			union all
			select max(f.fldDate) fldDate from acc.tblDocumentRecorde_File as f where f.fldDocumentHeaderId=header.fldId
			union all
			select max(b.fldDate) fldDate from acc.tblDocumentRecorde_File as f 
			inner join acc.tblDocumentBookMark as b on b.fldDocumentRecordeId=f.fldId
			where f.fldDocumentHeaderId=header.fldId)t)md
outer apply(select top 1  h.fldDocumentNum as fldDocumentNum_Pid from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldPId and h.fldId<h1.fldId order by h.fldId desc )Doc_Pid
outer apply(select top 1  h.fldTypeSanadId as fldTypeSanadId_Pid from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldId  order by h.fldId desc )Typesanad
outer APPLY(select (select top(1)  N'مرجوع شده (مرتبه ' +cast( ROW_NUMBER() over (order by h.fldid) as varchar(10))+')' from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldId and h.fldTypeSanadId=3 order by h.fldid desc) as fldTypeSanadId_Pid) sanadName
outer APPLY(select top(1) 1 as fldFlag
			FROM   [ACC].[tblDocumentRecord_Details] as d
			inner join acc.tblDocumentRecord_Header as h on h.fldId=d.fldDocument_HedearId
			inner join acc.[tblArtiklMap] as a on a.fldDocumentRecord_DetailsId=d.fldId
			WHERE   fldDocument_HedearId=header.fldId  
			and (fldDocument_HedearId1=h1.fldId
			 or (not exists(select * from Acc.tblDocumentRecord_Details as d2 where d2.fldDocument_HedearId1=h1.fldId ) and fldDocument_HedearId1 is null )) ) flag
	WHERE  h1.fldId = @Value AND header.fldOrganId=@fldOrganId and header.fldYear=@fldYear and fldModuleSaveId=@fldMadule
	--order by fldTarikhDocument,case when fldDocumentNum=0 then 1 else 0 end ,fldDocumentNum
	order by  fldDocumentNum desc

	if (@fieldname=N'Mortabet')/*فرق داره*/
	SELECT  h1.[fldId], [fldDocumentNum],cast(atf as int ) [fldAtfNum], [fldArchiveNum], [fldDescriptionDocu],header.[fldOrganId] ,[fldTarikhDocument],header.[fldDesc], header.[fldDate], header.[fldIP], header.[fldUserId],[fldAccept] 
	,fldType,case when fldType=1 and fldaccept=1 then N'قطعی' when fldType=1 and fldaccept=0 then N'موقت' when fldType=2 then N'یادداشت' end as fldTypeName
	,cast(ShomareRoozane as int)ShomareRoozane,fldShomareFaree,f.fldYear,fldFiscalYearId
	,fldTypeSanadId as fldTypeSanad ,d.fldName    as fldTypeSanadName,m.fldTitle as fldNameModule,fldModuleErsalId,isnull(fldExistsFile,cast(0 as bit))fldIsArchive
	,case when h1.fldPId is null or fldTypeSanadId<>3 then 0 else Doc_Pid.fldDocumentNum_Pid end fldDocumentNum_Pid,isnull(h1.fldPId,0)fldPId
	,case when Typesanad.fldTypeSanadId_Pid is null then N'ارسال نشده' when Typesanad.fldTypeSanadId_Pid<>3 then N'ارسال شده' else sanadName.fldTypeSanadId_Pid end fldTypeSanadName_Pid
	,case when fldModuleErsalId in (5,12,13) then ACC.fn_GetSourceId(fldModuleErsalId,header.fldId)	when fldPId is null  or fldModuleErsalId=fldModuleSaveId  then fldDocumentNum  
	else (select h.fldDocumentNum from acc.tblDocumentRecord_Header1 as h where h1.fldPId=h.fldid) end fldMainDocNum,isnull(flag.fldFlag,0) as fldFlag
	, ACC.fn_GetArtiklMap( header.fldId, h1.fldId,h1.fldModuleErsalId) as fldIsMap,fldEdit,case when fldModuleErsalId in(12,13) then ACC.[fn_GetCaseTypeId](fldModuleErsalId,header.fldId) else 0 end as fldCaseTypeId

	FROM   [ACC].[tblDocumentRecord_Header] header 
	inner join acc.tblFiscalYear f on header.fldFiscalYearId=f.fldid 
	inner join acc.tblDocumentRecord_Header1 as h1 on h1.fldDocument_HedearId=header.fldid
	inner join[ACC].[tblDocumentType] d on d.fldid=h1.fldTypeSanadId
	left join com.tblModule m on m.fldid=h1.fldModuleErsalId
	outer Apply(
				select atf from (select row_number()over (order by h2.fldId) atf,h2.fldid   
				from acc.tblDocumentRecord_Header h
				inner join acc.tblFiscalYear f1 on h.fldFiscalYearId=f1.fldid
				inner join acc.tblDocumentRecord_Header1 as h2 on h2.fldDocument_HedearId=h.fldid
				where h.fldOrganId=header.fldOrganId and f1.fldYear=f.fldYear 
					and h2.fldModuleSaveId=h1.fldModuleSaveId and fldDocumentNum <>0
					)t where t.fldid=h1.fldid)atfNum

		outer apply (select ShomareRoozane from (select row_number()over (order by h2.fldDate) ShomareRoozane,h2.fldid  
				from acc.tblDocumentRecord_Header h
				inner join acc.tblFiscalYear f1 on h.fldFiscalYearId=f1.fldid
				inner join acc.tblDocumentRecord_Header1 as h2 on h2.fldDocument_HedearId=h.fldid
				where h.fldOrganId=header.fldOrganId and f1.fldYear=f.fldYear 
					and h2.fldModuleSaveId=h1.fldModuleSaveId and cast(h2.fldDate as date)=cast(h1.fldDate as date) 	
					and fldDocumentNum <>0)t where t.fldid=h1.fldid)Roozane

	outer apply(select top(1) cast(1 as bit)fldExistsFile from acc.tblDocumentRecorde_File where fldDocumentHeaderId=header.fldid)Doc_File
	cross apply(select max(fldDate) as maxDate from
			(select max(h.fldDate) fldDate from acc.tblDocumentRecord_Header1 as h where h.fldId=h1.fldId
			union all
			select max(l.fldDate) fldDate from acc.tblDocument_HeaderLog as L where l.fldHeaderId =h1.fldId
			union all
			select max(f.fldDate) fldDate from acc.tblDocumentRecorde_File as f where f.fldDocumentHeaderId=header.fldId
			union all
			select max(b.fldDate) fldDate from acc.tblDocumentRecorde_File as f 
			inner join acc.tblDocumentBookMark as b on b.fldDocumentRecordeId=f.fldId
			where f.fldDocumentHeaderId=header.fldId)t)md
outer apply(select top 1  h.fldDocumentNum as fldDocumentNum_Pid from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldPId and h.fldId<h1.fldId order by h.fldId desc )Doc_Pid
outer apply(select top 1  h.fldTypeSanadId as fldTypeSanadId_Pid from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldId  order by h.fldId desc )Typesanad
outer APPLY(select (select top(1)  N'مرجوع شده (مرتبه ' +cast( ROW_NUMBER() over (order by h.fldid) as varchar(10))+')' from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldId and h.fldTypeSanadId=3 order by h.fldid desc) as fldTypeSanadId_Pid) sanadName
outer APPLY(select top(1) 1 as fldFlag
			FROM   [ACC].[tblDocumentRecord_Details] as d
			inner join acc.tblDocumentRecord_Header as h on h.fldId=d.fldDocument_HedearId
			inner join acc.[tblArtiklMap] as a on a.fldDocumentRecord_DetailsId=d.fldId
			WHERE   fldDocument_HedearId=header.fldId  
			and (fldDocument_HedearId1=h1.fldId
			 or (not exists(select * from Acc.tblDocumentRecord_Details as d2 where d2.fldDocument_HedearId1=h1.fldId ) and fldDocument_HedearId1 is null )) ) flag
cross apply (
select distinct h1.fldid from (
select c.fldId
			FROM   [ACC].[tblDocumentRecord_Details] as d
			inner join acc.tblCase as c on c.fldId=d.fldCaseId			
			inner join acc.tblCoding_Details as cd on cd.fldId=d.fldCodingId
			inner join acc.tblTemplateCoding as t on t.fldId=cd.fldTempCodingId
			inner join acc.[tblArtiklMap] as a on a.fldType=c.fldCaseTypeId
			inner join acc.tblDocumentRecord_Header as h2 on h2.fldId=d.fldDocument_HedearId			
			inner join acc.tblDocumentRecord_Header1 as h21 on h2.fldId=h21.fldDocument_HedearId
			cross apply(select * from com.Split(a.fldSourceId,','))s 
			WHERE  h21.fldId = @Value 
			and     c.fldSourceId=s.Item and s.Item<>''  and fldItemId=14 and fldCaseTypeId=6 and fldModuleSaveId=@fldMadule
			and (fldDocument_HedearId1=h21.fldId
			 or (not exists(select * from Acc.tblDocumentRecord_Details as d2 where d2.fldDocument_HedearId1=h21.fldId ) and fldDocument_HedearId1 is null ))
			)c
			inner join [ACC].[tblDocumentRecord_Details] as d on c.fldId=d.fldCaseId
			inner join acc.tblCoding_Details as cd on cd.fldId=d.fldCodingId
			inner join acc.tblTemplateCoding as t on t.fldId=cd.fldTempCodingId
			inner join acc.tblDocumentRecord_Header as h on h.fldId=d.fldDocument_HedearId			
			inner join acc.tblDocumentRecord_Header1 as h1 on h.fldId=h1.fldDocument_HedearId
			where fldItemId=14 and fldModuleSaveId=@fldMadule
			and (fldDocument_HedearId1=h1.fldId
			 or (not exists(select * from Acc.tblDocumentRecord_Details as d2 where d2.fldDocument_HedearId1=h1.fldId ) and fldDocument_HedearId1 is null ))
)map
where h1.fldId=map.fldId and Typesanad.fldTypeSanadId_Pid is null
	--order by fldTarikhDocument,case when fldDocumentNum=0 then 1 else 0 end ,fldDocumentNum
	order by fldDocumentNum desc


	if (@fieldname=N'SanadNumbers')
	SELECT top(100) h1.[fldId], [fldDocumentNum],cast(atf as int ) [fldAtfNum], [fldArchiveNum], [fldDescriptionDocu],header.[fldOrganId] ,[fldTarikhDocument],header.[fldDesc], header.[fldDate], header.[fldIP], header.[fldUserId],[fldAccept] 
	,fldType,case when fldType=1 and fldaccept=1 then N'قطعی' when fldType=1 and fldaccept=0 then N'موقت' when fldType=2 then N'یادداشت' end as fldTypeName
	,cast(ShomareRoozane as int)ShomareRoozane,fldShomareFaree,f.fldYear,fldFiscalYearId
	,fldTypeSanadId as fldTypeSanad ,d.fldName    as fldTypeSanadName,m.fldTitle as fldNameModule,fldModuleErsalId,isnull(fldExistsFile,cast(0 as bit))fldIsArchive
	,case when h1.fldPId is null or fldTypeSanadId<>3 then 0 else Doc_Pid.fldDocumentNum_Pid end fldDocumentNum_Pid,isnull(h1.fldPId,0)fldPId,case when Typesanad.fldTypeSanadId_Pid is null then N'ارسال نشده' when Typesanad.fldTypeSanadId_Pid<>3 then N'ارسال شده' else sanadName.fldTypeSanadId_Pid end fldTypeSanadName_Pid
	,case when fldModuleErsalId in (5,12,13) then ACC.fn_GetSourceId(fldModuleErsalId,header.fldId) when fldPId is null  or fldModuleErsalId=fldModuleSaveId then fldDocumentNum  else (select h.fldDocumentNum from acc.tblDocumentRecord_Header1 as h where h1.fldPId=h.fldid) end fldMainDocNum,isnull(flag.fldFlag,0) as fldFlag, ACC.fn_GetArtiklMap( header.fldId, h1.fldId,h1.fldModuleErsalId) as fldIsMap,fldEdit,case when fldModuleErsalId in(12,13) then ACC.[fn_GetCaseTypeId](fldModuleErsalId,header.fldId) else 0 end as fldCaseTypeId
	FROM   [ACC].[tblDocumentRecord_Header] header 
	inner join acc.tblFiscalYear f on header.fldFiscalYearId=f.fldid 
	inner join acc.tblDocumentRecord_Header1 as h1 on h1.fldDocument_HedearId=header.fldid
	inner join[ACC].[tblDocumentType] d on d.fldid=h1.fldTypeSanadId
	left join com.tblModule m on m.fldid=h1.fldModuleErsalId
	outer Apply(
				select atf from (select row_number()over (order by h2.fldId) atf,h2.fldid   
				from acc.tblDocumentRecord_Header h
				inner join acc.tblFiscalYear f1 on h.fldFiscalYearId=f1.fldid
				inner join acc.tblDocumentRecord_Header1 as h2 on h2.fldDocument_HedearId=h.fldid
				where h.fldOrganId=header.fldOrganId and f1.fldYear=f.fldYear 
					and h2.fldModuleSaveId=h1.fldModuleSaveId and fldDocumentNum <>0
					)t where t.fldid=h1.fldid)atfNum

		outer apply (select ShomareRoozane from (select row_number()over (order by h2.fldDate) ShomareRoozane,h2.fldid  
				from acc.tblDocumentRecord_Header h
				inner join acc.tblFiscalYear f1 on h.fldFiscalYearId=f1.fldid
				inner join acc.tblDocumentRecord_Header1 as h2 on h2.fldDocument_HedearId=h.fldid
				where h.fldOrganId=header.fldOrganId and f1.fldYear=f.fldYear 
					and h2.fldModuleSaveId=h1.fldModuleSaveId and cast(h2.fldDate as date)=cast(h1.fldDate as date) 	
					and fldDocumentNum <>0)t where t.fldid=h1.fldid)Roozane

	outer apply(select top(1) cast(1 as bit)fldExistsFile from acc.tblDocumentRecorde_File where fldDocumentHeaderId=header.fldid)Doc_File
	cross apply(select max(fldDate) as maxDate from
			(select max(h.fldDate) fldDate from acc.tblDocumentRecord_Header1 as h where h.fldId=h1.fldId
			union all
			select max(l.fldDate) fldDate from acc.tblDocument_HeaderLog as L where l.fldHeaderId =h1.fldId
			union all
			select max(f.fldDate) fldDate from acc.tblDocumentRecorde_File as f where f.fldDocumentHeaderId=header.fldId
			union all
			select max(b.fldDate) fldDate from acc.tblDocumentRecorde_File as f 
			inner join acc.tblDocumentBookMark as b on b.fldDocumentRecordeId=f.fldId
			where f.fldDocumentHeaderId=header.fldId)t)md
outer apply(select top 1  h.fldDocumentNum as fldDocumentNum_Pid from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldPId and h.fldId<h1.fldId order by h.fldId desc )Doc_Pid
outer apply(select top 1  h.fldTypeSanadId as fldTypeSanadId_Pid from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldId  order by h.fldId desc )Typesanad
outer APPLY(select (select top(1)  N'مرجوع شده (مرتبه ' +cast( ROW_NUMBER() over (order by h.fldid) as varchar(10))+')' from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldId and h.fldTypeSanadId=3 order by h.fldid desc) as fldTypeSanadId_Pid) sanadName
outer APPLY(select top(1) 1 as fldFlag
			FROM   [ACC].[tblDocumentRecord_Details] as d
			inner join acc.tblDocumentRecord_Header as h on h.fldId=d.fldDocument_HedearId
			inner join acc.[tblArtiklMap] as a on a.fldDocumentRecord_DetailsId=d.fldId
			WHERE   fldDocument_HedearId=header.fldId  
			and (fldDocument_HedearId1=h1.fldId
			 or (not exists(select * from Acc.tblDocumentRecord_Details as d2 where d2.fldDocument_HedearId1=h1.fldId ) and fldDocument_HedearId1 is null )) ) flag
	WHERE   cast(h1.fldid  as varchar(10)) in (select top(1 )* from com.Split(@value,';')
	where item=h1.fldid)  /*AND header.fldOrganId=@fldOrganIdand header.fldYear=@fldYear and fldModuleSaveId=@fldMadule
	--order by fldTarikhDocument,case when fldDocumentNum=0 then 1 else 0 end ,fldDocumentNum*/
	order by fldDocumentNum desc



	if (@fieldname=N'fldPId')
	SELECT  h1.[fldId], [fldDocumentNum],cast(atf as int ) [fldAtfNum], [fldArchiveNum], [fldDescriptionDocu],header.[fldOrganId] ,[fldTarikhDocument],header.[fldDesc], header.[fldDate], header.[fldIP], header.[fldUserId],[fldAccept] 
	,fldType,case when fldType=1 and fldaccept=1 then N'قطعی' when fldType=1 and fldaccept=0 then N'موقت' when fldType=2 then N'یادداشت' end as fldTypeName
	,cast(ShomareRoozane as int)ShomareRoozane,fldShomareFaree,f.fldYear,fldFiscalYearId
	,fldTypeSanadId as fldTypeSanad ,d.fldName    as fldTypeSanadName,m.fldTitle as fldNameModule,fldModuleErsalId,isnull(fldExistsFile,cast(0 as bit))fldIsArchive
	,case when h1.fldPId is null or fldTypeSanadId<>3 then 0 else Doc_Pid.fldDocumentNum_Pid end fldDocumentNum_Pid,isnull(h1.fldPId,0)fldPId,case when Typesanad.fldTypeSanadId_Pid is null then N'ارسال نشده' when Typesanad.fldTypeSanadId_Pid<>3 then N'ارسال شده' else sanadName.fldTypeSanadId_Pid end fldTypeSanadName_Pid
	,case when fldModuleErsalId in (5,12,13) then ACC.fn_GetSourceId(fldModuleErsalId,header.fldId) when fldPId is null  or fldModuleErsalId=fldModuleSaveId then fldDocumentNum  else (select h.fldDocumentNum from acc.tblDocumentRecord_Header1 as h where h1.fldPId=h.fldid) end fldMainDocNum,isnull(flag.fldFlag,0) as fldFlag, ACC.fn_GetArtiklMap( header.fldId, h1.fldId,h1.fldModuleErsalId) as fldIsMap,fldEdit,case when fldModuleErsalId in(12,13) then ACC.[fn_GetCaseTypeId](fldModuleErsalId,header.fldId) else 0 end as fldCaseTypeId
	FROM   [ACC].[tblDocumentRecord_Header] header 
	inner join acc.tblFiscalYear f on header.fldFiscalYearId=f.fldid
	inner join acc.tblDocumentRecord_Header1 as h1 on h1.fldDocument_HedearId=header.fldid
	inner join[ACC].[tblDocumentType] d on d.fldid=fldTypeSanadId
	left join com.tblModule m on m.fldid=fldModuleErsalId
	outer Apply(
				select atf from (select row_number()over (order by h2.fldId) atf,h2.fldid   
				from acc.tblDocumentRecord_Header h
				inner join acc.tblFiscalYear f1 on h.fldFiscalYearId=f1.fldid
				inner join acc.tblDocumentRecord_Header1 as h2 on h2.fldDocument_HedearId=h.fldid
				where h.fldOrganId=header.fldOrganId and f1.fldYear=f.fldYear 
					and h2.fldModuleSaveId=h1.fldModuleSaveId and fldDocumentNum <>0
					)t where t.fldid=h1.fldid)atfNum

		outer apply (select ShomareRoozane from (select row_number()over (order by h2.fldDate) ShomareRoozane,h2.fldid  
				from acc.tblDocumentRecord_Header h
				inner join acc.tblFiscalYear f1 on h.fldFiscalYearId=f1.fldid
				inner join acc.tblDocumentRecord_Header1 as h2 on h2.fldDocument_HedearId=h.fldid
				where h.fldOrganId=header.fldOrganId and f1.fldYear=f.fldYear 
					and h2.fldModuleSaveId=h1.fldModuleSaveId and cast(h2.fldDate as date)=cast(h1.fldDate as date) 	
					and fldDocumentNum <>0)t where t.fldid=h1.fldid)Roozane

	outer apply(select top(1) cast(1 as bit)fldExistsFile from acc.tblDocumentRecorde_File where fldDocumentHeaderId=header.fldid)Doc_File
	cross apply(select max(fldDate) as maxDate from
			(select max(h.fldDate) fldDate from acc.tblDocumentRecord_Header1 as h where h.fldId=h1.fldId
			union all
			select max(l.fldDate) fldDate from acc.tblDocument_HeaderLog as L where l.fldHeaderId =h1.fldId
			union all
			select max(f.fldDate) fldDate from acc.tblDocumentRecorde_File as f where f.fldDocumentHeaderId=header.fldId
			union all
			select max(b.fldDate) fldDate from acc.tblDocumentRecorde_File as f 
			inner join acc.tblDocumentBookMark as b on b.fldDocumentRecordeId=f.fldId
			where f.fldDocumentHeaderId=header.fldId)t)md
outer apply(select top 1  h.fldDocumentNum as fldDocumentNum_Pid from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldPId and h.fldId<h1.fldId order by h.fldId desc )Doc_Pid
outer apply(select top 1  h.fldTypeSanadId as fldTypeSanadId_Pid from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldId  order by h.fldId desc )Typesanad
outer apply(select (select top(1)  N'مرجوع شده (مرتبه ' +cast( ROW_NUMBER() over (order by h.fldid) as varchar(10))+')' from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldId and h.fldTypeSanadId=3 order by h.fldid desc) as fldTypeSanadId_Pid) sanadName
outer APPLY(select top(1) 1 as fldFlag
			FROM   [ACC].[tblDocumentRecord_Details] as d
			inner join acc.tblDocumentRecord_Header as h on h.fldId=d.fldDocument_HedearId
			inner join acc.[tblArtiklMap] as a on a.fldDocumentRecord_DetailsId=d.fldId
			WHERE   fldDocument_HedearId=header.fldId  
			and (fldDocument_HedearId1=h1.fldId
			 or (not exists(select * from Acc.tblDocumentRecord_Details as d2 where d2.fldDocument_HedearId1=h1.fldId ) and fldDocument_HedearId1 is null )) ) flag
	WHERE  h1.fldPId = @Value /*چک کردن ارسال سند به حسابداری*/
	--order by fldTarikhDocument,case when fldDocumentNum=0 then 1 else 0 end ,fldDocumentNum
	order by fldDocumentNum desc



	if (@fieldname=N'fldDesc')
		SELECT top(@h) h1.[fldId], [fldDocumentNum],cast(atf as int ) [fldAtfNum], [fldArchiveNum], [fldDescriptionDocu],header.[fldOrganId] ,[fldTarikhDocument],header.[fldDesc], header.[fldDate], header.[fldIP], header.[fldUserId],[fldAccept] 
	,fldType,case when fldType=1 and fldaccept=1 then N'قطعی' when fldType=1 and fldaccept=0 then N'موقت' when fldType=2 then N'یادداشت' end as fldTypeName
	,cast(ShomareRoozane as int)ShomareRoozane,fldShomareFaree,f.fldYear,fldFiscalYearId
	,fldTypeSanadId as fldTypeSanad ,d.fldName    as fldTypeSanadName,m.fldTitle as fldNameModule,fldModuleErsalId,isnull(fldExistsFile,cast(0 as bit))fldIsArchive
	,case when h1.fldPId is null or fldTypeSanadId<>3 then 0 else Doc_Pid.fldDocumentNum_Pid end fldDocumentNum_Pid,isnull(h1.fldPId,0)fldPId,case when Typesanad.fldTypeSanadId_Pid is null then N'ارسال نشده' when Typesanad.fldTypeSanadId_Pid<>3 then N'ارسال شده' else sanadName.fldTypeSanadId_Pid end fldTypeSanadName_Pid
	,case when fldModuleErsalId in (5,12,13) then ACC.fn_GetSourceId(fldModuleErsalId,header.fldId) when fldPId is null  or fldModuleErsalId=fldModuleSaveId then fldDocumentNum  else (select h.fldDocumentNum from acc.tblDocumentRecord_Header1 as h where h1.fldPId=h.fldid) end fldMainDocNum,isnull(flag.fldFlag,0) as fldFlag, ACC.fn_GetArtiklMap( header.fldId, h1.fldId,h1.fldModuleErsalId) as fldIsMap,fldEdit,case when fldModuleErsalId in(12,13) then ACC.[fn_GetCaseTypeId](fldModuleErsalId,header.fldId) else 0 end as fldCaseTypeId
	FROM   [ACC].[tblDocumentRecord_Header] header 
	inner join acc.tblFiscalYear f on header.fldFiscalYearId=f.fldid
	inner join acc.tblDocumentRecord_Header1 as h1 on h1.fldDocument_HedearId=header.fldid
	inner join[ACC].[tblDocumentType] d on d.fldid=fldTypeSanadId
	left join com.tblModule m on m.fldid=fldModuleErsalId
	outer Apply(
				select atf from (select row_number()over (order by h2.fldId) atf,h2.fldid   
				from acc.tblDocumentRecord_Header h
				inner join acc.tblFiscalYear f1 on h.fldFiscalYearId=f1.fldid
				inner join acc.tblDocumentRecord_Header1 as h2 on h2.fldDocument_HedearId=h.fldid
				where h.fldOrganId=header.fldOrganId and f1.fldYear=f.fldYear 
					and h2.fldModuleSaveId=h1.fldModuleSaveId and fldDocumentNum <>0
					)t where t.fldid=h1.fldid)atfNum

		outer apply (select ShomareRoozane from (select row_number()over (order by h2.fldDate) ShomareRoozane,h2.fldid  
				from acc.tblDocumentRecord_Header h
				inner join acc.tblFiscalYear f1 on h.fldFiscalYearId=f1.fldid
				inner join acc.tblDocumentRecord_Header1 as h2 on h2.fldDocument_HedearId=h.fldid
				where h.fldOrganId=header.fldOrganId and f1.fldYear=f.fldYear 
					and h2.fldModuleSaveId=h1.fldModuleSaveId and cast(h2.fldDate as date)=cast(h1.fldDate as date) 	
					and fldDocumentNum <>0)t where t.fldid=h1.fldid)Roozane

	outer apply(select top(1) cast(1 as bit)fldExistsFile from acc.tblDocumentRecorde_File where fldDocumentHeaderId=header.fldid)Doc_File
	cross apply(select max(fldDate) as maxDate from
			(select max(h.fldDate) fldDate from acc.tblDocumentRecord_Header1 as h where h.fldId=h1.fldId
			union all
			select max(l.fldDate) fldDate from acc.tblDocument_HeaderLog as L where l.fldHeaderId =h1.fldId
			union all
			select max(f.fldDate) fldDate from acc.tblDocumentRecorde_File as f where f.fldDocumentHeaderId=header.fldId
			union all
			select max(b.fldDate) fldDate from acc.tblDocumentRecorde_File as f 
			inner join acc.tblDocumentBookMark as b on b.fldDocumentRecordeId=f.fldId
			where f.fldDocumentHeaderId=header.fldId)t)md
outer apply(select top 1  h.fldDocumentNum as fldDocumentNum_Pid from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldPId and h.fldId<h1.fldId order by h.fldId desc )Doc_Pid
outer apply(select top 1  h.fldTypeSanadId as fldTypeSanadId_Pid from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldId  order by h.fldId desc )Typesanad
outer apply(select (select top(1)  N'مرجوع شده (مرتبه ' +cast( ROW_NUMBER() over (order by h.fldid) as varchar(10))+')' from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldId and h.fldTypeSanadId=3 order by h.fldid desc) as fldTypeSanadId_Pid) sanadName	--order by fldTarikhDocument,case when fldDocumentNum=0 then 1 else 0 end ,fldDocumentNum
outer APPLY(select top(1) 1 as fldFlag
			FROM   [ACC].[tblDocumentRecord_Details] as d
			inner join acc.tblDocumentRecord_Header as h on h.fldId=d.fldDocument_HedearId
			inner join acc.[tblArtiklMap] as a on a.fldDocumentRecord_DetailsId=d.fldId
			WHERE   fldDocument_HedearId=header.fldId  
			and (fldDocument_HedearId1=h1.fldId
			 or (not exists(select * from Acc.tblDocumentRecord_Details as d2 where d2.fldDocument_HedearId1=h1.fldId ) and fldDocument_HedearId1 is null )) ) flag
	order by fldDocumentNum desc

	if (@fieldname=N'CheckYear')
		SELECT top(@h) h1.[fldId], [fldDocumentNum],cast(atf as int ) [fldAtfNum], [fldArchiveNum], [fldDescriptionDocu],header.[fldOrganId] ,[fldTarikhDocument],header.[fldDesc], header.[fldDate], header.[fldIP], header.[fldUserId],[fldAccept] 
	,fldType,case when fldType=1 and fldaccept=1 then N'قطعی' when fldType=1 and fldaccept=0 then N'موقت' when fldType=2 then N'یادداشت' end as fldTypeName
	,cast(ShomareRoozane as int)ShomareRoozane,fldShomareFaree,f.fldYear,fldFiscalYearId
	,fldTypeSanadId as fldTypeSanad ,d.fldName    as fldTypeSanadName,m.fldTitle as fldNameModule,fldModuleErsalId,isnull(fldExistsFile,cast(0 as bit))fldIsArchive
	,case when h1.fldPId is null or fldTypeSanadId<>3 then 0 else Doc_Pid.fldDocumentNum_Pid end fldDocumentNum_Pid,isnull(h1.fldPId,0)fldPId,case when Typesanad.fldTypeSanadId_Pid is null then N'ارسال نشده' when Typesanad.fldTypeSanadId_Pid<>3 then N'ارسال شده' else sanadName.fldTypeSanadId_Pid end fldTypeSanadName_Pid
	,case when fldModuleErsalId in (5,12,13) then ACC.fn_GetSourceId(fldModuleErsalId,header.fldId) when fldPId is null  or fldModuleErsalId=fldModuleSaveId then fldDocumentNum  else (select h.fldDocumentNum from acc.tblDocumentRecord_Header1 as h where h1.fldPId=h.fldid) end fldMainDocNum,isnull(flag.fldFlag,0) as fldFlag, ACC.fn_GetArtiklMap( header.fldId, h1.fldId,h1.fldModuleErsalId) as fldIsMap,fldEdit,case when fldModuleErsalId in(12,13) then ACC.[fn_GetCaseTypeId](fldModuleErsalId,header.fldId) else 0 end as fldCaseTypeId
	FROM   [ACC].[tblDocumentRecord_Header] header 
	inner join acc.tblFiscalYear f on header.fldFiscalYearId=f.fldid
	inner join acc.tblDocumentRecord_Header1 as h1 on h1.fldDocument_HedearId=header.fldid
	inner join[ACC].[tblDocumentType] d on d.fldid=fldTypeSanadId
	left join com.tblModule m on m.fldid=fldModuleErsalId
	outer Apply(
				select atf from (select row_number()over (order by h2.fldId) atf,h2.fldid   
				from acc.tblDocumentRecord_Header h
				inner join acc.tblFiscalYear f1 on h.fldFiscalYearId=f1.fldid
				inner join acc.tblDocumentRecord_Header1 as h2 on h2.fldDocument_HedearId=h.fldid
				where h.fldOrganId=header.fldOrganId and f1.fldYear=f.fldYear 
					and h2.fldModuleSaveId=h1.fldModuleSaveId and fldDocumentNum <>0
					)t where t.fldid=h1.fldid)atfNum

		outer apply (select ShomareRoozane from (select row_number()over (order by h2.fldDate) ShomareRoozane,h2.fldid  
				from acc.tblDocumentRecord_Header h
				inner join acc.tblFiscalYear f1 on h.fldFiscalYearId=f1.fldid
				inner join acc.tblDocumentRecord_Header1 as h2 on h2.fldDocument_HedearId=h.fldid
				where h.fldOrganId=header.fldOrganId and f1.fldYear=f.fldYear 
					and h2.fldModuleSaveId=h1.fldModuleSaveId and cast(h2.fldDate as date)=cast(h1.fldDate as date) 	
					and fldDocumentNum <>0)t where t.fldid=h1.fldid)Roozane

	outer apply(select  top(1) cast(1 as bit)fldExistsFile from acc.tblDocumentRecorde_File where fldDocumentHeaderId=header.fldid)Doc_File
	cross apply(select max(fldDate) as maxDate from
			(select max(h.fldDate) fldDate from acc.tblDocumentRecord_Header1 as h where h.fldId=h1.fldId
			union all
			select max(l.fldDate) fldDate from acc.tblDocument_HeaderLog as L where l.fldHeaderId =h1.fldId
			union all
			select max(f.fldDate) fldDate from acc.tblDocumentRecorde_File as f where f.fldDocumentHeaderId=header.fldId
			union all
			select max(b.fldDate) fldDate from acc.tblDocumentRecorde_File as f 
			inner join acc.tblDocumentBookMark as b on b.fldDocumentRecordeId=f.fldId
			where f.fldDocumentHeaderId=header.fldId)t)md
	outer apply(select top 1  h.fldDocumentNum as fldDocumentNum_Pid from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldPId and h.fldId<h1.fldId order by h.fldId desc )Doc_Pid
outer apply(select top 1  h.fldTypeSanadId as fldTypeSanadId_Pid from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldId  order by h.fldId desc )Typesanad
outer apply(select (select top(1)  N'مرجوع شده (مرتبه ' +cast( ROW_NUMBER() over (order by h.fldid) as varchar(10))+')' from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldId and h.fldTypeSanadId=3 order by h.fldid desc) as fldTypeSanadId_Pid) sanadName
outer APPLY(select top(1) 1 as fldFlag
			FROM   [ACC].[tblDocumentRecord_Details] as d
			inner join acc.tblDocumentRecord_Header as h on h.fldId=d.fldDocument_HedearId
			inner join acc.[tblArtiklMap] as a on a.fldDocumentRecord_DetailsId=d.fldId
			WHERE   fldDocument_HedearId=header.fldId  
			and (fldDocument_HedearId1=h1.fldId
			 or (not exists(select * from Acc.tblDocumentRecord_Details as d2 where d2.fldDocument_HedearId1=h1.fldId ) and fldDocument_HedearId1 is null )) ) flag
WHERE fldFiscalYearId like  @Value --AND fldOrganId=@fldOrganId  and fldYear=@fldYear and fldModuleSaveId=@fldMadule
	--order by fldTarikhDocument,case when fldDocumentNum=0 then 1 else 0 end ,fldDocumentNum
	order by fldDocumentNum desc

	if (@fieldname=N'fldCaseId')
		SELECT top(@h) h1.[fldId], [fldDocumentNum],cast(atf as int ) [fldAtfNum], [fldArchiveNum], [fldDescriptionDocu],header.[fldOrganId] ,[fldTarikhDocument],header.[fldDesc], header.[fldDate], header.[fldIP], header.[fldUserId],[fldAccept] 
	,fldType,case when fldType=1 and fldaccept=1 then N'قطعی' when fldType=1 and fldaccept=0 then N'موقت' when fldType=2 then N'یادداشت' end as fldTypeName
	,cast(ShomareRoozane as int)ShomareRoozane,fldShomareFaree,f.fldYear,fldFiscalYearId
	,fldTypeSanadId as fldTypeSanad ,d.fldName    as fldTypeSanadName,m.fldTitle as fldNameModule,fldModuleErsalId,isnull(fldExistsFile,cast(0 as bit))fldIsArchive
	,case when h1.fldPId is null or fldTypeSanadId<>3 then 0 else Doc_Pid.fldDocumentNum_Pid end fldDocumentNum_Pid,isnull(h1.fldPId,0)fldPId,case when Typesanad.fldTypeSanadId_Pid is null then N'ارسال نشده' when Typesanad.fldTypeSanadId_Pid<>3 then N'ارسال شده' else sanadName.fldTypeSanadId_Pid end fldTypeSanadName_Pid
	,case when fldModuleErsalId in (5,12,13) then ACC.fn_GetSourceId(fldModuleErsalId,header.fldId) when fldPId is null  or fldModuleErsalId=fldModuleSaveId then fldDocumentNum  else (select h.fldDocumentNum from acc.tblDocumentRecord_Header1 as h where h1.fldPId=h.fldid) end fldMainDocNum,isnull(flag.fldFlag,0) as fldFlag, ACC.fn_GetArtiklMap( header.fldId, h1.fldId,h1.fldModuleErsalId) as fldIsMap,fldEdit,case when fldModuleErsalId in(12,13) then ACC.[fn_GetCaseTypeId](fldModuleErsalId,header.fldId) else 0 end as fldCaseTypeId
	FROM   [ACC].[tblDocumentRecord_Header] header 
	inner join acc.tblFiscalYear f on header.fldFiscalYearId=f.fldid
	inner join acc.tblDocumentRecord_Header1 as h1 on h1.fldDocument_HedearId=header.fldid
	inner join[ACC].[tblDocumentType] d on d.fldid=fldTypeSanadId
	inner join acc.tblDocumentRecord_Details as dd on dd.fldDocument_HedearId=header.fldId
	inner join acc.tblCoding_Details as cd on cd.fldId=dd.fldCodingId
	inner join acc.tblTemplateCoding as t on t.fldId=cd.fldTempCodingId
	left join com.tblModule m on m.fldid=fldModuleErsalId
	outer Apply(
				select atf from (select row_number()over (order by h2.fldId) atf,h2.fldid   
				from acc.tblDocumentRecord_Header h
				inner join acc.tblFiscalYear f1 on h.fldFiscalYearId=f1.fldid
				inner join acc.tblDocumentRecord_Header1 as h2 on h2.fldDocument_HedearId=h.fldid
				where h.fldOrganId=header.fldOrganId and f1.fldYear=f.fldYear 
					and h2.fldModuleSaveId=h1.fldModuleSaveId and fldDocumentNum <>0
					)t where t.fldid=h1.fldid)atfNum

		outer apply (select ShomareRoozane from (select row_number()over (order by h2.fldDate) ShomareRoozane,h2.fldid  
				from acc.tblDocumentRecord_Header h
				inner join acc.tblFiscalYear f1 on h.fldFiscalYearId=f1.fldid
				inner join acc.tblDocumentRecord_Header1 as h2 on h2.fldDocument_HedearId=h.fldid
				where h.fldOrganId=header.fldOrganId and f1.fldYear=f.fldYear 
					and h2.fldModuleSaveId=h1.fldModuleSaveId and cast(h2.fldDate as date)=cast(h1.fldDate as date) 	
					and fldDocumentNum <>0)t where t.fldid=h1.fldid)Roozane

	outer apply(select  top(1) cast(1 as bit)fldExistsFile from acc.tblDocumentRecorde_File where fldDocumentHeaderId=header.fldid)Doc_File
	cross apply(select max(fldDate) as maxDate from
			(select max(h.fldDate) fldDate from acc.tblDocumentRecord_Header1 as h where h.fldId=h1.fldId
			union all
			select max(l.fldDate) fldDate from acc.tblDocument_HeaderLog as L where l.fldHeaderId =h1.fldId
			union all
			select max(f.fldDate) fldDate from acc.tblDocumentRecorde_File as f where f.fldDocumentHeaderId=header.fldId
			union all
			select max(b.fldDate) fldDate from acc.tblDocumentRecorde_File as f 
			inner join acc.tblDocumentBookMark as b on b.fldDocumentRecordeId=f.fldId
			where f.fldDocumentHeaderId=header.fldId)t)md
	outer apply(select top 1  h.fldDocumentNum as fldDocumentNum_Pid from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldPId and h.fldId<h1.fldId order by h.fldId desc )Doc_Pid
outer apply(select top 1  h.fldTypeSanadId as fldTypeSanadId_Pid from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldId  order by h.fldId desc )Typesanad
outer apply(select (select top(1)  N'مرجوع شده (مرتبه ' +cast( ROW_NUMBER() over (order by h.fldid) as varchar(10))+')' from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldId and h.fldTypeSanadId=3 order by h.fldid desc) as fldTypeSanadId_Pid) sanadName
outer APPLY(select top(1) 1 as fldFlag
			FROM   [ACC].[tblDocumentRecord_Details] as d
			inner join acc.tblDocumentRecord_Header as h on h.fldId=d.fldDocument_HedearId
			inner join acc.[tblArtiklMap] as a on a.fldDocumentRecord_DetailsId=d.fldId
			WHERE   fldDocument_HedearId=header.fldId  
			and (fldDocument_HedearId1=h1.fldId
			 or (not exists(select * from Acc.tblDocumentRecord_Details as d2 where d2.fldDocument_HedearId1=h1.fldId ) and fldDocument_HedearId1 is null )) ) flag
WHERE fldFiscalYearId =  @Value AND dd.fldCaseId=@value1 and t.fldItemId=@value2 and fldModuleSaveId=@fldMadule
and (fldDocument_HedearId1=h1.fldId
			 or (not exists(select * from Acc.tblDocumentRecord_Details as d2 where d2.fldDocument_HedearId1=h1.fldId ) and fldDocument_HedearId1 is null )) 

	order by fldDocumentNum desc

	if (@fieldname=N'')
	SELECT top(@h) h1.[fldId], [fldDocumentNum],cast(atf as int ) [fldAtfNum], [fldArchiveNum], [fldDescriptionDocu],header.[fldOrganId] ,[fldTarikhDocument],header.[fldDesc], header.[fldDate], header.[fldIP], header.[fldUserId],[fldAccept] 
	,fldType,case when fldType=1 and fldaccept=1 then N'قطعی' when fldType=1 and fldaccept=0 then N'موقت' when fldType=2 then N'یادداشت' end as fldTypeName
	,cast(ShomareRoozane as int)ShomareRoozane,fldShomareFaree,f.fldYear,fldFiscalYearId
,fldTypeSanadId as fldTypeSanad ,d.fldName    as fldTypeSanadName,m.fldTitle as fldNameModule,fldModuleErsalId,isnull(fldExistsFile,cast(0 as bit))fldIsArchive
	,case when h1.fldPId is null or fldTypeSanadId<>3 then 0 else Doc_Pid.fldDocumentNum_Pid end fldDocumentNum_Pid,isnull(h1.fldPId,0)fldPId,case when Typesanad.fldTypeSanadId_Pid is null then N'ارسال نشده' when Typesanad.fldTypeSanadId_Pid<>3 then N'ارسال شده' else sanadName.fldTypeSanadId_Pid end fldTypeSanadName_Pid
	,case when fldModuleErsalId in (5,12,13) then ACC.fn_GetSourceId(fldModuleErsalId,header.fldId) when fldPId is null  or fldModuleErsalId=fldModuleSaveId then fldDocumentNum  else (select h.fldDocumentNum from acc.tblDocumentRecord_Header1 as h where h1.fldPId=h.fldid) end fldMainDocNum,isnull(flag.fldFlag,0) as fldFlag, ACC.fn_GetArtiklMap( header.fldId, h1.fldId,h1.fldModuleErsalId) as fldIsMap,fldEdit,case when fldModuleErsalId in(12,13) then ACC.[fn_GetCaseTypeId](fldModuleErsalId,header.fldId) else 0 end as fldCaseTypeId
	FROM   [ACC].[tblDocumentRecord_Header] header 
	inner join acc.tblFiscalYear f on header.fldFiscalYearId=f.fldid
	inner join acc.tblDocumentRecord_Header1 as h1 on h1.fldDocument_HedearId=header.fldid
	inner join[ACC].[tblDocumentType] d on d.fldid=fldTypeSanadId
	left join com.tblModule m on m.fldid=fldModuleErsalId
	outer Apply(
				select atf from (select row_number()over (order by h2.fldId) atf,h2.fldid   
				from acc.tblDocumentRecord_Header h
				inner join acc.tblFiscalYear f1 on h.fldFiscalYearId=f1.fldid
				inner join acc.tblDocumentRecord_Header1 as h2 on h2.fldDocument_HedearId=h.fldid
				where h.fldOrganId=header.fldOrganId and f1.fldYear=f.fldYear 
					and h2.fldModuleSaveId=h1.fldModuleSaveId and fldDocumentNum <>0
					)t where t.fldid=h1.fldid)atfNum

	outer apply (select ShomareRoozane from (select row_number()over (order by h2.fldDate) ShomareRoozane,h2.fldid  
				from acc.tblDocumentRecord_Header h
				inner join acc.tblFiscalYear f1 on h.fldFiscalYearId=f1.fldid
				inner join acc.tblDocumentRecord_Header1 as h2 on h2.fldDocument_HedearId=h.fldid
				where h.fldOrganId=header.fldOrganId and f1.fldYear=f.fldYear 
					and h2.fldModuleSaveId=h1.fldModuleSaveId and cast(h2.fldDate as date)=cast(h1.fldDate as date) 	
					and fldDocumentNum <>0)t where t.fldid=h1.fldid)Roozane

	outer apply(select  top(1) cast(1 as bit)fldExistsFile from acc.tblDocumentRecorde_File where fldDocumentHeaderId=header.fldid)Doc_File
	cross apply(select max(fldDate) as maxDate from
			(select max(h.fldDate) fldDate from acc.tblDocumentRecord_Header1 as h where h.fldId=h1.fldId
			union all
			select max(l.fldDate) fldDate from acc.tblDocument_HeaderLog as L where l.fldHeaderId =h1.fldId
			union all
			select max(f.fldDate) fldDate from acc.tblDocumentRecorde_File as f where f.fldDocumentHeaderId=header.fldId
			union all
			select max(b.fldDate) fldDate from acc.tblDocumentRecorde_File as f 
			inner join acc.tblDocumentBookMark as b on b.fldDocumentRecordeId=f.fldId
			where f.fldDocumentHeaderId=header.fldId)t)md
outer apply(select top 1  h.fldDocumentNum as fldDocumentNum_Pid from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldPId and h.fldId<h1.fldId order by h.fldId desc )Doc_Pid
outer apply(select top 1  h.fldTypeSanadId as fldTypeSanadId_Pid from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldId  order by h.fldId desc )Typesanad
outer apply(select (select top(1)  N'مرجوع شده (مرتبه ' +cast( ROW_NUMBER() over (order by h.fldid) as varchar(10))+')' from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldId and h.fldTypeSanadId=3 order by h.fldid desc) as fldTypeSanadId_Pid) sanadName
outer APPLY(select top(1) 1 as fldFlag
			FROM   [ACC].[tblDocumentRecord_Details] as d
			inner join acc.tblDocumentRecord_Header as h on h.fldId=d.fldDocument_HedearId
			inner join acc.[tblArtiklMap] as a on a.fldDocumentRecord_DetailsId=d.fldId
			WHERE   fldDocument_HedearId=header.fldId  
			and (fldDocument_HedearId1=h1.fldId
			 or (not exists(select * from Acc.tblDocumentRecord_Details as d2 where d2.fldDocument_HedearId1=h1.fldId ) and fldDocument_HedearId1 is null )) ) flag
					where header.fldOrganId=@fldOrganId  and f.fldYear=@fldYear and h1.fldModuleSaveId=@fldMadule
					--order by fldTarikhDocument,case when fldDocumentNum=0 then 1 else 0 end ,fldDocumentNum
			order by fldDocumentNum desc


	
	if (@fieldname=N'fldTypeName')
	SELECT top(@h) [fldId], [fldDocumentNum], [fldAtfNum], [fldArchiveNum], [fldDescriptionDocu],[fldOrganId] ,[fldTarikhDocument],[fldDesc],[fldDate], [fldIP], [fldUserId],[fldAccept] 
	,fldType,fldTypeName
	,ShomareRoozane,fldShomareFaree,fldYear,fldFiscalYearId
	, fldTypeSanad , fldTypeSanadName, fldNameModule,fldModuleErsalId,fldIsArchive
	,fldDocumentNum_Pid
	, fldMainDocNum, fldFlag
	,fldPId, fldTypeSanadName_Pid from(	SELECT  h1.[fldId], [fldDocumentNum],cast(atf as int ) [fldAtfNum], [fldArchiveNum], [fldDescriptionDocu],header.[fldOrganId] ,[fldTarikhDocument],header.[fldDesc], header.[fldDate], header.[fldIP], header.[fldUserId],[fldAccept] 
	,fldType,case when fldType=1 and fldaccept=1 then N'قطعی' when fldType=1 and fldaccept=0 then N'موقت' when fldType=2 then N'یادداشت' end as fldTypeName
	,cast(ShomareRoozane as int)ShomareRoozane,fldShomareFaree,f.fldYear,fldFiscalYearId
	,fldTypeSanadId as fldTypeSanad ,d.fldName    as fldTypeSanadName,m.fldTitle as fldNameModule,fldModuleErsalId,isnull(fldExistsFile,cast(0 as bit))fldIsArchive
	,case when h1.fldPId is null or fldTypeSanadId<>3 then 0 else Doc_Pid.fldDocumentNum_Pid end fldDocumentNum_Pid
	,case when fldModuleErsalId in (5,12,13) then ACC.fn_GetSourceId(fldModuleErsalId,header.fldId) when fldPId is null  or fldModuleErsalId=fldModuleSaveId then fldDocumentNum  else (select h.fldDocumentNum from acc.tblDocumentRecord_Header1 as h where h1.fldPId=h.fldid) end fldMainDocNum,isnull(flag.fldFlag,0) as fldFlag, ACC.fn_GetArtiklMap( header.fldId, h1.fldId,h1.fldModuleErsalId) as fldIsMap,fldEdit,case when fldModuleErsalId in(12,13) then ACC.[fn_GetCaseTypeId](fldModuleErsalId,header.fldId) else 0 end as fldCaseTypeId
	,isnull(h1.fldPId,0)fldPId,case when Typesanad.fldTypeSanadId_Pid is null then N'ارسال نشده' when Typesanad.fldTypeSanadId_Pid<>3 then N'ارسال شده' else sanadName.fldTypeSanadId_Pid end fldTypeSanadName_Pid
	,h1.fldDocument_HedearId
	FROM   [ACC].[tblDocumentRecord_Header] header 
	inner join acc.tblFiscalYear f on header.fldFiscalYearId=f.fldid
	inner join acc.tblDocumentRecord_Header1 as h1 on h1.fldDocument_HedearId=header.fldid
	inner join[ACC].[tblDocumentType] d on d.fldid=fldTypeSanadId
	left join com.tblModule m on m.fldid=fldModuleErsalId
	outer Apply(
				select atf from (select row_number()over (order by h2.fldId) atf,h2.fldid   
				from acc.tblDocumentRecord_Header h
				inner join acc.tblFiscalYear f1 on h.fldFiscalYearId=f1.fldid
				inner join acc.tblDocumentRecord_Header1 as h2 on h2.fldDocument_HedearId=h.fldid
				where h.fldOrganId=header.fldOrganId and f1.fldYear=f.fldYear 
					and h2.fldModuleSaveId=h1.fldModuleSaveId and fldDocumentNum <>0
					)t where t.fldid=h1.fldid)atfNum
	outer apply (select ShomareRoozane from (select row_number()over (order by h2.fldDate) ShomareRoozane,h2.fldid  
				from acc.tblDocumentRecord_Header h
				inner join acc.tblFiscalYear f1 on h.fldFiscalYearId=f1.fldid
				inner join acc.tblDocumentRecord_Header1 as h2 on h2.fldDocument_HedearId=h.fldid
				where h.fldOrganId=header.fldOrganId and f1.fldYear=f.fldYear 
					and h2.fldModuleSaveId=h1.fldModuleSaveId and cast(h2.fldDate as date)=cast(h1.fldDate as date) 	
					and fldDocumentNum <>0)t where t.fldid=h1.fldid)Roozane

	outer apply(select  top(1) cast(1 as bit)fldExistsFile from acc.tblDocumentRecorde_File where fldDocumentHeaderId=header.fldid)Doc_File
	outer apply(select top 1  h.fldDocumentNum as fldDocumentNum_Pid from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldPId and h.fldId<h1.fldId order by h.fldId desc )Doc_Pid
outer apply(select top 1  h.fldTypeSanadId as fldTypeSanadId_Pid from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldId  order by h.fldId desc )Typesanad
outer apply(select (select top(1)  N'مرجوع شده (مرتبه ' +cast( ROW_NUMBER() over (order by h.fldid) as varchar(10))+')' from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldId and h.fldTypeSanadId=3 order by h.fldid desc) as fldTypeSanadId_Pid) sanadName
outer APPLY(select top(1) 1 as fldFlag
			FROM   [ACC].[tblDocumentRecord_Details] as d
			inner join acc.tblDocumentRecord_Header as h on h.fldId=d.fldDocument_HedearId
			inner join acc.[tblArtiklMap] as a on a.fldDocumentRecord_DetailsId=d.fldId
			WHERE   fldDocument_HedearId=header.fldId  
			and (fldDocument_HedearId1=h1.fldId
			 or (not exists(select * from Acc.tblDocumentRecord_Details as d2 where d2.fldDocument_HedearId1=h1.fldId ) and fldDocument_HedearId1 is null )) ) flag

					where header.fldOrganId=@fldOrganId  and f.fldYear=@fldYear and h1.fldModuleSaveId=@fldMadule
					)t
	cross apply(select max(fldDate) as maxDate from
			(select max(h.fldDate) fldDate from acc.tblDocumentRecord_Header1 as h where h.fldId=t.fldId
			union all
			select max(l.fldDate) fldDate from acc.tblDocument_HeaderLog as L where l.fldHeaderId =t.fldId
			union all
			select max(f.fldDate) fldDate from acc.tblDocumentRecorde_File as f where f.fldDocumentHeaderId=t.fldDocument_HedearId
			union all
			select max(b.fldDate) fldDate from acc.tblDocumentRecorde_File as f 
			inner join acc.tblDocumentBookMark as b on b.fldDocumentRecordeId=f.fldId
			where f.fldDocumentHeaderId=t.fldDocument_HedearId)t)md
	WHERE fldTypeName like  @Value 
	--order by fldTarikhDocument,case when fldDocumentNum=0 then 1 else 0 end ,fldDocumentNum
	order by fldDocumentNum desc

	
	if (@fieldname=N'fldTypeSanadName_Pid')
	SELECT top(@h) [fldId], [fldDocumentNum], [fldAtfNum], [fldArchiveNum], [fldDescriptionDocu],[fldOrganId] ,[fldTarikhDocument],[fldDesc],[fldDate], [fldIP], [fldUserId],[fldAccept] 
	,fldType,fldTypeName
	,ShomareRoozane,fldShomareFaree,fldYear,fldFiscalYearId
	, fldTypeSanad , fldTypeSanadName, fldNameModule,fldModuleErsalId,fldIsArchive
	,fldDocumentNum_Pid
	, fldMainDocNum, fldFlag
	,fldPId, fldTypeSanadName_Pid
 from(	SELECT  h1.[fldId], [fldDocumentNum],cast(atf as int ) [fldAtfNum], [fldArchiveNum], [fldDescriptionDocu],header.[fldOrganId] ,[fldTarikhDocument],header.[fldDesc], header.[fldDate], header.[fldIP], header.[fldUserId],[fldAccept] 
	,fldType,case when fldType=1 and fldaccept=1 then N'قطعی' when fldType=1 and fldaccept=0 then N'موقت' when fldType=2 then N'یادداشت' end as fldTypeName
	,cast(ShomareRoozane as int)ShomareRoozane,fldShomareFaree,f.fldYear,fldFiscalYearId
	,fldTypeSanadId as fldTypeSanad ,d.fldName    as fldTypeSanadName,m.fldTitle as fldNameModule,fldModuleErsalId,isnull(fldExistsFile,cast(0 as bit))fldIsArchive
	,case when h1.fldPId is null or fldTypeSanadId<>3 then 0 else Doc_Pid.fldDocumentNum_Pid end fldDocumentNum_Pid
	,case when fldModuleErsalId in (5,12,13) then ACC.fn_GetSourceId(fldModuleErsalId,header.fldId) when fldPId is null  or fldModuleErsalId=fldModuleSaveId then fldDocumentNum  else (select h.fldDocumentNum from acc.tblDocumentRecord_Header1 as h where h1.fldPId=h.fldid) end fldMainDocNum,isnull(flag.fldFlag,0) as fldFlag, ACC.fn_GetArtiklMap( header.fldId, h1.fldId,h1.fldModuleErsalId) as fldIsMap,fldEdit,case when fldModuleErsalId in(12,13) then ACC.[fn_GetCaseTypeId](fldModuleErsalId,header.fldId) else 0 end as fldCaseTypeId
	,isnull(h1.fldPId,0)fldPId,case when Typesanad.fldTypeSanadId_Pid is null then N'ارسال نشده' when Typesanad.fldTypeSanadId_Pid<>3 then N'ارسال شده' else sanadName.fldTypeSanadId_Pid end fldTypeSanadName_Pid
	,h1.fldDocument_HedearId
	FROM   [ACC].[tblDocumentRecord_Header] header 
	inner join acc.tblFiscalYear f on header.fldFiscalYearId=f.fldid
	inner join acc.tblDocumentRecord_Header1 as h1 on h1.fldDocument_HedearId=header.fldid
	inner join[ACC].[tblDocumentType] d on d.fldid=fldTypeSanadId
	left join com.tblModule m on m.fldid=fldModuleErsalId
	outer Apply(
				select atf from (select row_number()over (order by h2.fldId) atf,h2.fldid   
				from acc.tblDocumentRecord_Header h
				inner join acc.tblFiscalYear f1 on h.fldFiscalYearId=f1.fldid
				inner join acc.tblDocumentRecord_Header1 as h2 on h2.fldDocument_HedearId=h.fldid
				where h.fldOrganId=header.fldOrganId and f1.fldYear=f.fldYear 
					and h2.fldModuleSaveId=h1.fldModuleSaveId and fldDocumentNum <>0
					)t where t.fldid=h1.fldid)atfNum
	outer apply (select ShomareRoozane from (select row_number()over (order by h2.fldDate) ShomareRoozane,h2.fldid  
				from acc.tblDocumentRecord_Header h
				inner join acc.tblFiscalYear f1 on h.fldFiscalYearId=f1.fldid
				inner join acc.tblDocumentRecord_Header1 as h2 on h2.fldDocument_HedearId=h.fldid
				where h.fldOrganId=header.fldOrganId and f1.fldYear=f.fldYear 
					and h2.fldModuleSaveId=h1.fldModuleSaveId and cast(h2.fldDate as date)=cast(h1.fldDate as date) 	
					and fldDocumentNum <>0)t where t.fldid=h1.fldid)Roozane

	outer apply(select  top(1) cast(1 as bit)fldExistsFile from acc.tblDocumentRecorde_File where fldDocumentHeaderId=header.fldid)Doc_File
	outer apply(select top 1  h.fldDocumentNum as fldDocumentNum_Pid from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldPId and h.fldId<h1.fldId order by h.fldId desc )Doc_Pid
outer apply(select top 1  h.fldTypeSanadId as fldTypeSanadId_Pid from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldId  order by h.fldId desc )Typesanad
outer apply(select (select top(1)  N'مرجوع شده (مرتبه ' +cast( ROW_NUMBER() over (order by h.fldid) as varchar(10))+')' from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldId and h.fldTypeSanadId=3 order by h.fldid desc) as fldTypeSanadId_Pid) sanadName
outer APPLY(select top(1) 1 as fldFlag
			FROM   [ACC].[tblDocumentRecord_Details] as d
			inner join acc.tblDocumentRecord_Header as h on h.fldId=d.fldDocument_HedearId
			inner join acc.[tblArtiklMap] as a on a.fldDocumentRecord_DetailsId=d.fldId
			WHERE   fldDocument_HedearId=header.fldId  
			and (fldDocument_HedearId1=h1.fldId
			 or (not exists(select * from Acc.tblDocumentRecord_Details as d2 where d2.fldDocument_HedearId1=h1.fldId ) and fldDocument_HedearId1 is null )) ) flag
					where header.fldOrganId=@fldOrganId  and f.fldYear=@fldYear and h1.fldModuleSaveId=@fldMadule
					)t
	cross apply(select max(fldDate) as maxDate from
			(select max(h.fldDate) fldDate from acc.tblDocumentRecord_Header1 as h where h.fldId=t.fldId
			union all
			select max(l.fldDate) fldDate from acc.tblDocument_HeaderLog as L where l.fldHeaderId =t.fldId
			union all
			select max(f.fldDate) fldDate from acc.tblDocumentRecorde_File as f where f.fldDocumentHeaderId=t.fldDocument_HedearId
			union all
			select max(b.fldDate) fldDate from acc.tblDocumentRecorde_File as f 
			inner join acc.tblDocumentBookMark as b on b.fldDocumentRecordeId=f.fldId
			where f.fldDocumentHeaderId=t.fldDocument_HedearId)t)md
	WHERE fldTypeSanadName_Pid like  @Value 
	--order by fldTarikhDocument,case when fldDocumentNum=0 then 1 else 0 end ,fldDocumentNum
	order by fldDocumentNum desc

	if (@fieldname=N'fldMainDocNum')
	SELECT top(@h)  [fldId], [fldDocumentNum], [fldAtfNum], [fldArchiveNum], [fldDescriptionDocu],[fldOrganId] ,[fldTarikhDocument],[fldDesc],[fldDate], [fldIP], [fldUserId],[fldAccept] 
	,fldType,fldTypeName
	,ShomareRoozane,fldShomareFaree,fldYear,fldFiscalYearId
	, fldTypeSanad , fldTypeSanadName, fldNameModule,fldModuleErsalId,fldIsArchive
	,fldDocumentNum_Pid
	, fldMainDocNum, fldFlag
	,fldPId, fldTypeSanadName_Pid from(	SELECT  h1.[fldId], [fldDocumentNum],cast(atf as int ) [fldAtfNum], [fldArchiveNum], [fldDescriptionDocu],header.[fldOrganId] ,[fldTarikhDocument],header.[fldDesc], header.[fldDate], header.[fldIP], header.[fldUserId],[fldAccept] 
	,fldType,case when fldType=1 and fldaccept=1 then N'قطعی' when fldType=1 and fldaccept=0 then N'موقت' when fldType=2 then N'یادداشت' end as fldTypeName
	,cast(ShomareRoozane as int)ShomareRoozane,fldShomareFaree,f.fldYear,fldFiscalYearId
	,fldTypeSanadId as fldTypeSanad ,d.fldName    as fldTypeSanadName,m.fldTitle as fldNameModule,fldModuleErsalId,isnull(fldExistsFile,cast(0 as bit))fldIsArchive
	,case when h1.fldPId is null or fldTypeSanadId<>3 then 0 else Doc_Pid.fldDocumentNum_Pid end fldDocumentNum_Pid
	,case when fldModuleErsalId in (5,12,13) then ACC.fn_GetSourceId(fldModuleErsalId,header.fldId) when fldPId is null  or fldModuleErsalId=fldModuleSaveId then fldDocumentNum  
	else (select h.fldDocumentNum from acc.tblDocumentRecord_Header1 as h where h1.fldPId=h.fldid) end fldMainDocNum,isnull(flag.fldFlag,0) as fldFlag, ACC.fn_GetArtiklMap( header.fldId, h1.fldId,h1.fldModuleErsalId) as fldIsMap,fldEdit,case when fldModuleErsalId in(12,13) then ACC.[fn_GetCaseTypeId](fldModuleErsalId,header.fldId) else 0 end as fldCaseTypeId
	,isnull(h1.fldPId,0)fldPId,case when Typesanad.fldTypeSanadId_Pid is null then N'ارسال نشده' when Typesanad.fldTypeSanadId_Pid<>3 then N'ارسال شده' else sanadName.fldTypeSanadId_Pid end fldTypeSanadName_Pid
	,h1.fldDocument_HedearId
	FROM   [ACC].[tblDocumentRecord_Header] header inner join acc.tblFiscalYear f on header.fldFiscalYearId=f.fldid
	inner join acc.tblDocumentRecord_Header1 as h1 on h1.fldDocument_HedearId=header.fldid
	inner join[ACC].[tblDocumentType] d on d.fldid=fldTypeSanadId
	left join com.tblModule m on m.fldid=fldModuleErsalId
	outer Apply(
				select atf from (select row_number()over (order by h2.fldId) atf,h2.fldid   
				from acc.tblDocumentRecord_Header h
				inner join acc.tblFiscalYear f1 on h.fldFiscalYearId=f1.fldid
				inner join acc.tblDocumentRecord_Header1 as h2 on h2.fldDocument_HedearId=h.fldid
				where h.fldOrganId=header.fldOrganId and f1.fldYear=f.fldYear 
					and h2.fldModuleSaveId=h1.fldModuleSaveId and fldDocumentNum <>0
					)t where t.fldid=h1.fldid)atfNum
		outer apply (select ShomareRoozane from (select row_number()over (order by h2.fldDate) ShomareRoozane,h2.fldid  
				from acc.tblDocumentRecord_Header h
				inner join acc.tblFiscalYear f1 on h.fldFiscalYearId=f1.fldid
				inner join acc.tblDocumentRecord_Header1 as h2 on h2.fldDocument_HedearId=h.fldid
				where h.fldOrganId=header.fldOrganId and f1.fldYear=f.fldYear 
					and h2.fldModuleSaveId=h1.fldModuleSaveId and cast(h2.fldDate as date)=cast(h1.fldDate as date) 	
					and fldDocumentNum <>0)t where t.fldid=h1.fldid)Roozane

	outer apply(select  top(1) cast(1 as bit)fldExistsFile from acc.tblDocumentRecorde_File where fldDocumentHeaderId=header.fldid)Doc_File
	outer apply(select top 1  h.fldDocumentNum as fldDocumentNum_Pid from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldPId and h.fldId<h1.fldId order by h.fldId desc )Doc_Pid
outer apply(select top 1  h.fldTypeSanadId as fldTypeSanadId_Pid from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldId  order by h.fldId desc )Typesanad
outer apply(select (select top(1)  N'مرجوع شده (مرتبه ' +cast( ROW_NUMBER() over (order by h.fldid) as varchar(10))+')' from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldId and h.fldTypeSanadId=3 order by h.fldid desc) as fldTypeSanadId_Pid) sanadName
outer APPLY(select top(1) 1 as fldFlag
			FROM   [ACC].[tblDocumentRecord_Details] as d
			inner join acc.tblDocumentRecord_Header as h on h.fldId=d.fldDocument_HedearId
			inner join acc.[tblArtiklMap] as a on a.fldDocumentRecord_DetailsId=d.fldId
			WHERE   fldDocument_HedearId=header.fldId  
			and (fldDocument_HedearId1=h1.fldId
			 or (not exists(select * from Acc.tblDocumentRecord_Details as d2 where d2.fldDocument_HedearId1=h1.fldId ) and fldDocument_HedearId1 is null )) ) flag

					where header.fldOrganId=@fldOrganId  and f.fldYear=@fldYear and h1.fldModuleSaveId=@fldMadule
					)t
	cross apply(select max(fldDate) as maxDate from
			(select max(h.fldDate) fldDate from acc.tblDocumentRecord_Header1 as h where h.fldId=t.fldId
			union all
			select max(l.fldDate) fldDate from acc.tblDocument_HeaderLog as L where l.fldHeaderId =t.fldId
			union all
			select max(f.fldDate) fldDate from acc.tblDocumentRecorde_File as f where f.fldDocumentHeaderId=t.fldDocument_HedearId
			union all
			select max(b.fldDate) fldDate from acc.tblDocumentRecorde_File as f 
			inner join acc.tblDocumentBookMark as b on b.fldDocumentRecordeId=f.fldId
			where f.fldDocumentHeaderId=t.fldDocument_HedearId)t)md
	WHERE fldMainDocNum like  @Value 
	--order by fldTarikhDocument,case when fldDocumentNum=0 then 1 else 0 end ,fldDocumentNum
	order by fldDocumentNum desc
	
	if (@fieldname=N'fldDocumentNum')
		SELECT top(@h) h1.[fldId], [fldDocumentNum],cast(atf as int ) [fldAtfNum], [fldArchiveNum], [fldDescriptionDocu],header.[fldOrganId] ,[fldTarikhDocument],header.[fldDesc], header.[fldDate], header.[fldIP], header.[fldUserId],[fldAccept] 
	,fldType,case when fldType=1 and fldaccept=1 then N'قطعی' when fldType=1 and fldaccept=0 then N'موقت' when fldType=2 then N'یادداشت' end as fldTypeName
	,cast(ShomareRoozane as int)ShomareRoozane,fldShomareFaree,f.fldYear,fldFiscalYearId
	,fldTypeSanadId as fldTypeSanad ,d.fldName    as fldTypeSanadName,m.fldTitle as fldNameModule,fldModuleErsalId,isnull(fldExistsFile,cast(0 as bit))fldIsArchive
	,case when h1.fldPId is null or fldTypeSanadId<>3 then 0 else Doc_Pid.fldDocumentNum_Pid end fldDocumentNum_Pid,isnull(h1.fldPId,0)fldPId,case when Typesanad.fldTypeSanadId_Pid is null then N'ارسال نشده' when Typesanad.fldTypeSanadId_Pid<>3 then N'ارسال شده' else sanadName.fldTypeSanadId_Pid end fldTypeSanadName_Pid
	,case when fldModuleErsalId in (5,12,13) then ACC.fn_GetSourceId(fldModuleErsalId,header.fldId) when fldPId is null  or fldModuleErsalId=fldModuleSaveId then fldDocumentNum  else (select h.fldDocumentNum from acc.tblDocumentRecord_Header1 as h where h1.fldPId=h.fldid) end fldMainDocNum,isnull(flag.fldFlag,0) as fldFlag, ACC.fn_GetArtiklMap( header.fldId, h1.fldId,h1.fldModuleErsalId) as fldIsMap,fldEdit,case when fldModuleErsalId in(12,13) then ACC.[fn_GetCaseTypeId](fldModuleErsalId,header.fldId) else 0 end as fldCaseTypeId
	FROM   [ACC].[tblDocumentRecord_Header] header inner join acc.tblFiscalYear f on header.fldFiscalYearId=f.fldid
	inner join acc.tblDocumentRecord_Header1 as h1 on h1.fldDocument_HedearId=header.fldid
	inner join[ACC].[tblDocumentType] d on d.fldid=fldTypeSanadId
	left join com.tblModule m on m.fldid=fldModuleErsalId
	outer Apply(
				select atf from (select row_number()over (order by h2.fldId) atf,h2.fldid   
				from acc.tblDocumentRecord_Header h
				inner join acc.tblFiscalYear f1 on h.fldFiscalYearId=f1.fldid
				inner join acc.tblDocumentRecord_Header1 as h2 on h2.fldDocument_HedearId=h.fldid
				where h.fldOrganId=header.fldOrganId and f1.fldYear=f.fldYear 
					and h2.fldModuleSaveId=h1.fldModuleSaveId and fldDocumentNum <>0
					)t where t.fldid=h1.fldid)atfNum

		outer apply (select ShomareRoozane from (select row_number()over (order by h2.fldDate) ShomareRoozane,h2.fldid  
				from acc.tblDocumentRecord_Header h
				inner join acc.tblFiscalYear f1 on h.fldFiscalYearId=f1.fldid
				inner join acc.tblDocumentRecord_Header1 as h2 on h2.fldDocument_HedearId=h.fldid
				where h.fldOrganId=header.fldOrganId and f1.fldYear=f.fldYear 
					and h2.fldModuleSaveId=h1.fldModuleSaveId and cast(h2.fldDate as date)=cast(h1.fldDate as date) 	
					and fldDocumentNum <>0)t where t.fldid=h1.fldid)Roozane

	outer apply(select  top(1) cast(1 as bit)fldExistsFile from acc.tblDocumentRecorde_File where fldDocumentHeaderId=header.fldid)Doc_File
	cross apply(select max(fldDate) as maxDate from
			(select max(h.fldDate) fldDate from acc.tblDocumentRecord_Header1 as h where h.fldId=h1.fldId
			union all
			select max(l.fldDate) fldDate from acc.tblDocument_HeaderLog as L where l.fldHeaderId =h1.fldId
			union all
			select max(f.fldDate) fldDate from acc.tblDocumentRecorde_File as f where f.fldDocumentHeaderId=header.fldId
			union all
			select max(b.fldDate) fldDate from acc.tblDocumentRecorde_File as f 
			inner join acc.tblDocumentBookMark as b on b.fldDocumentRecordeId=f.fldId
			where f.fldDocumentHeaderId=header.fldId)t)md
outer apply(select top 1  h.fldDocumentNum as fldDocumentNum_Pid from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldPId and h.fldId<h1.fldId order by h.fldId desc )Doc_Pid
outer apply(select top 1  h.fldTypeSanadId as fldTypeSanadId_Pid from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldId  order by h.fldId desc )Typesanad
outer apply(select (select top(1)  N'مرجوع شده (مرتبه ' +cast( ROW_NUMBER() over (order by h.fldid) as varchar(10))+')' from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldId and h.fldTypeSanadId=3 order by h.fldid desc) as fldTypeSanadId_Pid) sanadName
outer APPLY(select top(1) 1 as fldFlag
			FROM   [ACC].[tblDocumentRecord_Details] as d
			inner join acc.tblDocumentRecord_Header as h on h.fldId=d.fldDocument_HedearId
			inner join acc.[tblArtiklMap] as a on a.fldDocumentRecord_DetailsId=d.fldId
			WHERE   fldDocument_HedearId=header.fldId  
			and (fldDocument_HedearId1=h1.fldId
			 or (not exists(select * from Acc.tblDocumentRecord_Details as d2 where d2.fldDocument_HedearId1=h1.fldId ) and fldDocument_HedearId1 is null )) ) flag
WHERE fldDocumentNum like  @Value AND header.fldOrganId=@fldOrganId  and f.fldYear=@fldYear and h1.fldModuleSaveId=@fldMadule
	--order by fldTarikhDocument,case when fldDocumentNum=0 then 1 else 0 end ,fldDocumentNum
	order by fldDocumentNum desc

	
	
	
	if (@fieldname=N'fldAtfNum')
		SELECT top(@h) h1.[fldId], [fldDocumentNum],cast(atf as int ) [fldAtfNum], [fldArchiveNum], [fldDescriptionDocu],header.[fldOrganId] ,[fldTarikhDocument],header.[fldDesc], header.[fldDate], header.[fldIP], header.[fldUserId],[fldAccept] 
	,fldType,case when fldType=1 and fldaccept=1 then N'قطعی' when fldType=1 and fldaccept=0 then N'موقت' when fldType=2 then N'یادداشت' end as fldTypeName
	,cast(ShomareRoozane as int)ShomareRoozane,fldShomareFaree,f.fldYear,fldFiscalYearId
	,fldTypeSanadId as fldTypeSanad ,d.fldName    as fldTypeSanadName,m.fldTitle as fldNameModule,fldModuleErsalId,isnull(fldExistsFile,cast(0 as bit))fldIsArchive
	,case when h1.fldPId is null or fldTypeSanadId<>3 then 0 else Doc_Pid.fldDocumentNum_Pid end fldDocumentNum_Pid,isnull(h1.fldPId,0)fldPId,case when Typesanad.fldTypeSanadId_Pid is null then N'ارسال نشده' when Typesanad.fldTypeSanadId_Pid<>3 then N'ارسال شده' else sanadName.fldTypeSanadId_Pid end fldTypeSanadName_Pid
	,case when fldModuleErsalId in (5,12,13) then ACC.fn_GetSourceId(fldModuleErsalId,header.fldId) when fldPId is null  or fldModuleErsalId=fldModuleSaveId then fldDocumentNum  else (select h.fldDocumentNum from acc.tblDocumentRecord_Header1 as h where h1.fldPId=h.fldid) end fldMainDocNum,isnull(flag.fldFlag,0) as fldFlag, ACC.fn_GetArtiklMap( header.fldId, h1.fldId,h1.fldModuleErsalId) as fldIsMap,fldEdit,case when fldModuleErsalId in(12,13) then ACC.[fn_GetCaseTypeId](fldModuleErsalId,header.fldId) else 0 end as fldCaseTypeId
	FROM   [ACC].[tblDocumentRecord_Header] header inner join acc.tblFiscalYear f on header.fldFiscalYearId=f.fldid
	inner join acc.tblDocumentRecord_Header1 as h1 on h1.fldDocument_HedearId=header.fldid
	inner join[ACC].[tblDocumentType] d on d.fldid=fldTypeSanadId
	left join com.tblModule m on m.fldid=fldModuleErsalId
	outer Apply(
				select atf from (select row_number()over (order by h2.fldId) atf,h2.fldid   
				from acc.tblDocumentRecord_Header h
				inner join acc.tblFiscalYear f1 on h.fldFiscalYearId=f1.fldid
				inner join acc.tblDocumentRecord_Header1 as h2 on h2.fldDocument_HedearId=h.fldid
				where h.fldOrganId=header.fldOrganId and f1.fldYear=f.fldYear 
					and h2.fldModuleSaveId=h1.fldModuleSaveId and fldDocumentNum <>0
					)t where t.fldid=h1.fldid)atfNum

	outer apply (select ShomareRoozane from (select row_number()over (order by h2.fldDate) ShomareRoozane,h2.fldid  
				from acc.tblDocumentRecord_Header h
				inner join acc.tblFiscalYear f1 on h.fldFiscalYearId=f1.fldid
				inner join acc.tblDocumentRecord_Header1 as h2 on h2.fldDocument_HedearId=h.fldid
				where h.fldOrganId=header.fldOrganId and f1.fldYear=f.fldYear 
					and h2.fldModuleSaveId=h1.fldModuleSaveId and cast(h2.fldDate as date)=cast(h1.fldDate as date) 	
					and fldDocumentNum <>0)t where t.fldid=h1.fldid)Roozane

	outer apply(select  top(1) cast(1 as bit)fldExistsFile from acc.tblDocumentRecorde_File where fldDocumentHeaderId=header.fldid)Doc_File
	cross apply(select max(fldDate) as maxDate from
			(select max(h.fldDate) fldDate from acc.tblDocumentRecord_Header1 as h where h.fldId=h1.fldId
			union all
			select max(l.fldDate) fldDate from acc.tblDocument_HeaderLog as L where l.fldHeaderId =h1.fldId
			union all
			select max(f.fldDate) fldDate from acc.tblDocumentRecorde_File as f where f.fldDocumentHeaderId=header.fldId
			union all
			select max(b.fldDate) fldDate from acc.tblDocumentRecorde_File as f 
			inner join acc.tblDocumentBookMark as b on b.fldDocumentRecordeId=f.fldId
			where f.fldDocumentHeaderId=header.fldId)t)md
outer apply(select top 1  h.fldDocumentNum as fldDocumentNum_Pid from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldPId and h.fldId<h1.fldId order by h.fldId desc )Doc_Pid
outer apply(select top 1  h.fldTypeSanadId as fldTypeSanadId_Pid from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldId  order by h.fldId desc )Typesanad
outer apply(select (select top(1)  N'مرجوع شده (مرتبه ' +cast( ROW_NUMBER() over (order by h.fldid) as varchar(10))+')' from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldId and h.fldTypeSanadId=3 order by h.fldid desc) as fldTypeSanadId_Pid) sanadName
outer APPLY(select top(1) 1 as fldFlag
			FROM   [ACC].[tblDocumentRecord_Details] as d
			inner join acc.tblDocumentRecord_Header as h on h.fldId=d.fldDocument_HedearId
			inner join acc.[tblArtiklMap] as a on a.fldDocumentRecord_DetailsId=d.fldId
			WHERE   fldDocument_HedearId=header.fldId  
			and (fldDocument_HedearId1=h1.fldId
			 or (not exists(select * from Acc.tblDocumentRecord_Details as d2 where d2.fldDocument_HedearId1=h1.fldId ) and fldDocument_HedearId1 is null )) ) flag
WHERE atf like  @Value AND header.fldOrganId=@fldOrganId  and f.fldYear=@fldYear and h1.fldModuleSaveId=@fldMadule
	--order by fldTarikhDocument,case when fldDocumentNum=0 then 1 else 0 end ,fldDocumentNum
	order by fldDocumentNum desc

	
	

	if (@fieldname=N'fldArchiveNum')
		SELECT top(@h) h1.[fldId], [fldDocumentNum],cast(atf as int ) [fldAtfNum], [fldArchiveNum], [fldDescriptionDocu],header.[fldOrganId] ,[fldTarikhDocument],header.[fldDesc], header.[fldDate], header.[fldIP], header.[fldUserId],[fldAccept] 
	,fldType,case when fldType=1 and fldaccept=1 then N'قطعی' when fldType=1 and fldaccept=0 then N'موقت' when fldType=2 then N'یادداشت' end as fldTypeName
	,cast(ShomareRoozane as int)ShomareRoozane,fldShomareFaree,f.fldYear,fldFiscalYearId
	,fldTypeSanadId as fldTypeSanad ,d.fldName    as fldTypeSanadName,m.fldTitle as fldNameModule,fldModuleErsalId,isnull(fldExistsFile,cast(0 as bit))fldIsArchive
	,case when h1.fldPId is null or fldTypeSanadId<>3 then 0 else Doc_Pid.fldDocumentNum_Pid end fldDocumentNum_Pid,isnull(h1.fldPId,0)fldPId,case when Typesanad.fldTypeSanadId_Pid is null then N'ارسال نشده' when Typesanad.fldTypeSanadId_Pid<>3 then N'ارسال شده' else sanadName.fldTypeSanadId_Pid end fldTypeSanadName_Pid
	,case when fldModuleErsalId in (5,12,13) then ACC.fn_GetSourceId(fldModuleErsalId,header.fldId) when fldPId is null  or fldModuleErsalId=fldModuleSaveId then fldDocumentNum  else (select h.fldDocumentNum from acc.tblDocumentRecord_Header1 as h where h1.fldPId=h.fldid) end fldMainDocNum,isnull(flag.fldFlag,0) as fldFlag, ACC.fn_GetArtiklMap( header.fldId, h1.fldId,h1.fldModuleErsalId) as fldIsMap,fldEdit,case when fldModuleErsalId in(12,13) then ACC.[fn_GetCaseTypeId](fldModuleErsalId,header.fldId) else 0 end as fldCaseTypeId
	FROM   [ACC].[tblDocumentRecord_Header] header inner join acc.tblFiscalYear f on header.fldFiscalYearId=f.fldid
	inner join acc.tblDocumentRecord_Header1 as h1 on h1.fldDocument_HedearId=header.fldid
	inner join[ACC].[tblDocumentType] d on d.fldid=fldTypeSanadId
	left join com.tblModule m on m.fldid=fldModuleErsalId
	outer Apply(
				select atf from (select row_number()over (order by h2.fldId) atf,h2.fldid   
				from acc.tblDocumentRecord_Header h
				inner join acc.tblFiscalYear f1 on h.fldFiscalYearId=f1.fldid
				inner join acc.tblDocumentRecord_Header1 as h2 on h2.fldDocument_HedearId=h.fldid
				where h.fldOrganId=header.fldOrganId and f1.fldYear=f.fldYear 
					and h2.fldModuleSaveId=h1.fldModuleSaveId and fldDocumentNum <>0
					)t where t.fldid=h1.fldid)atfNum

		outer apply (select ShomareRoozane from (select row_number()over (order by h2.fldDate) ShomareRoozane,h2.fldid  
				from acc.tblDocumentRecord_Header h
				inner join acc.tblFiscalYear f1 on h.fldFiscalYearId=f1.fldid
				inner join acc.tblDocumentRecord_Header1 as h2 on h2.fldDocument_HedearId=h.fldid
				where h.fldOrganId=header.fldOrganId and f1.fldYear=f.fldYear 
					and h2.fldModuleSaveId=h1.fldModuleSaveId and cast(h2.fldDate as date)=cast(h1.fldDate as date) 	
					and fldDocumentNum <>0)t where t.fldid=h1.fldid)Roozane

	outer apply(select  top(1) cast(1 as bit)fldExistsFile from acc.tblDocumentRecorde_File where fldDocumentHeaderId=header.fldid)Doc_File
	cross apply(select max(fldDate) as maxDate from
			(select max(h.fldDate) fldDate from acc.tblDocumentRecord_Header1 as h where h.fldId=h1.fldId
			union all
			select max(l.fldDate) fldDate from acc.tblDocument_HeaderLog as L where l.fldHeaderId =h1.fldId
			union all
			select max(f.fldDate) fldDate from acc.tblDocumentRecorde_File as f where f.fldDocumentHeaderId=header.fldId
			union all
			select max(b.fldDate) fldDate from acc.tblDocumentRecorde_File as f 
			inner join acc.tblDocumentBookMark as b on b.fldDocumentRecordeId=f.fldId
			where f.fldDocumentHeaderId=header.fldId)t)md
outer apply(select top 1  h.fldDocumentNum as fldDocumentNum_Pid from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldPId and h.fldId<h1.fldId order by h.fldId desc )Doc_Pid
outer apply(select top 1  h.fldTypeSanadId as fldTypeSanadId_Pid from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldId  order by h.fldId desc )Typesanad
outer apply(select (select top(1)  N'مرجوع شده (مرتبه ' +cast( ROW_NUMBER() over (order by h.fldid) as varchar(10))+')' from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldId and h.fldTypeSanadId=3 order by h.fldid desc) as fldTypeSanadId_Pid) sanadName
outer APPLY(select top(1) 1 as fldFlag
			FROM   [ACC].[tblDocumentRecord_Details] as d
			inner join acc.tblDocumentRecord_Header as h on h.fldId=d.fldDocument_HedearId
			inner join acc.[tblArtiklMap] as a on a.fldDocumentRecord_DetailsId=d.fldId
			WHERE   fldDocument_HedearId=header.fldId  
			and (fldDocument_HedearId1=h1.fldId
			 or (not exists(select * from Acc.tblDocumentRecord_Details as d2 where d2.fldDocument_HedearId1=h1.fldId ) and fldDocument_HedearId1 is null )) ) flag
WHERE fldArchiveNum like  @Value AND header.fldOrganId=@fldOrganId  and f.fldYear=@fldYear and h1.fldModuleSaveId=@fldMadule
	--order by fldTarikhDocument,case when fldDocumentNum=0 then 1 else 0 end ,fldDocumentNum
	order by fldDocumentNum desc

	
	
	if (@fieldname=N'fldDescriptionDocu')
		SELECT top(@h) h1.[fldId], [fldDocumentNum],cast(atf as int ) [fldAtfNum], [fldArchiveNum], [fldDescriptionDocu],header.[fldOrganId] ,[fldTarikhDocument],header.[fldDesc], header.[fldDate], header.[fldIP], header.[fldUserId],[fldAccept] 
	,fldType,case when fldType=1 and fldaccept=1 then N'قطعی' when fldType=1 and fldaccept=0 then N'موقت' when fldType=2 then N'یادداشت' end as fldTypeName
	,cast(ShomareRoozane as int)ShomareRoozane,fldShomareFaree,f.fldYear,fldFiscalYearId
	,fldTypeSanadId as fldTypeSanad ,d.fldName    as fldTypeSanadName,m.fldTitle as fldNameModule,fldModuleErsalId,isnull(fldExistsFile,cast(0 as bit))fldIsArchive
	,case when h1.fldPId is null or fldTypeSanadId<>3 then 0 else Doc_Pid.fldDocumentNum_Pid end fldDocumentNum_Pid,isnull(h1.fldPId,0)fldPId,case when Typesanad.fldTypeSanadId_Pid is null then N'ارسال نشده' when Typesanad.fldTypeSanadId_Pid<>3 then N'ارسال شده' else sanadName.fldTypeSanadId_Pid end fldTypeSanadName_Pid
	,case when fldModuleErsalId in (5,12,13) then ACC.fn_GetSourceId(fldModuleErsalId,header.fldId) when fldPId is null  or fldModuleErsalId=fldModuleSaveId then fldDocumentNum  else (select h.fldDocumentNum from acc.tblDocumentRecord_Header1 as h where h1.fldPId=h.fldid) end fldMainDocNum,isnull(flag.fldFlag,0) as fldFlag, ACC.fn_GetArtiklMap( header.fldId, h1.fldId,h1.fldModuleErsalId) as fldIsMap,fldEdit,case when fldModuleErsalId in(12,13) then ACC.[fn_GetCaseTypeId](fldModuleErsalId,header.fldId) else 0 end as fldCaseTypeId
	FROM   [ACC].[tblDocumentRecord_Header] header inner join acc.tblFiscalYear f on header.fldFiscalYearId=f.fldid
	inner join acc.tblDocumentRecord_Header1 as h1 on h1.fldDocument_HedearId=header.fldid
	inner join[ACC].[tblDocumentType] d on d.fldid=fldTypeSanadId
	left join com.tblModule m on m.fldid=fldModuleErsalId
	outer Apply(
				select atf from (select row_number()over (order by h2.fldId) atf,h2.fldid   
				from acc.tblDocumentRecord_Header h
				inner join acc.tblFiscalYear f1 on h.fldFiscalYearId=f1.fldid
				inner join acc.tblDocumentRecord_Header1 as h2 on h2.fldDocument_HedearId=h.fldid
				where h.fldOrganId=header.fldOrganId and f1.fldYear=f.fldYear 
					and h2.fldModuleSaveId=h1.fldModuleSaveId and fldDocumentNum <>0
					)t where t.fldid=h1.fldid)atfNum

	outer apply (select ShomareRoozane from (select row_number()over (order by h2.fldDate) ShomareRoozane,h2.fldid  
				from acc.tblDocumentRecord_Header h
				inner join acc.tblFiscalYear f1 on h.fldFiscalYearId=f1.fldid
				inner join acc.tblDocumentRecord_Header1 as h2 on h2.fldDocument_HedearId=h.fldid
				where h.fldOrganId=header.fldOrganId and f1.fldYear=f.fldYear 
					and h2.fldModuleSaveId=h1.fldModuleSaveId and cast(h2.fldDate as date)=cast(h1.fldDate as date) 	
					and fldDocumentNum <>0)t where t.fldid=h1.fldid)Roozane

	outer apply(select  top(1) cast(1 as bit)fldExistsFile from acc.tblDocumentRecorde_File where fldDocumentHeaderId=header.fldid)Doc_File
	cross apply(select max(fldDate) as maxDate from
			(select max(h.fldDate) fldDate from acc.tblDocumentRecord_Header1 as h where h.fldId=h1.fldId
			union all
			select max(l.fldDate) fldDate from acc.tblDocument_HeaderLog as L where l.fldHeaderId =h1.fldId
			union all
			select max(f.fldDate) fldDate from acc.tblDocumentRecorde_File as f where f.fldDocumentHeaderId=header.fldId
			union all
			select max(b.fldDate) fldDate from acc.tblDocumentRecorde_File as f 
			inner join acc.tblDocumentBookMark as b on b.fldDocumentRecordeId=f.fldId
			where f.fldDocumentHeaderId=header.fldId)t)md
outer apply(select top 1  h.fldDocumentNum as fldDocumentNum_Pid from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldPId and h.fldId<h1.fldId order by h.fldId desc )Doc_Pid
outer apply(select top 1  h.fldTypeSanadId as fldTypeSanadId_Pid from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldId  order by h.fldId desc )Typesanad
outer apply(select (select top(1)  N'مرجوع شده (مرتبه ' +cast( ROW_NUMBER() over (order by h.fldid) as varchar(10))+')' from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldId and h.fldTypeSanadId=3 order by h.fldid desc) as fldTypeSanadId_Pid) sanadName
outer APPLY(select top(1) 1 as fldFlag
			FROM   [ACC].[tblDocumentRecord_Details] as d
			inner join acc.tblDocumentRecord_Header as h on h.fldId=d.fldDocument_HedearId
			inner join acc.[tblArtiklMap] as a on a.fldDocumentRecord_DetailsId=d.fldId
			WHERE   fldDocument_HedearId=header.fldId  
			and (fldDocument_HedearId1=h1.fldId
			 or (not exists(select * from Acc.tblDocumentRecord_Details as d2 where d2.fldDocument_HedearId1=h1.fldId ) and fldDocument_HedearId1 is null )) ) flag
WHERE fldDescriptionDocu like  @Value AND header.fldOrganId=@fldOrganId  and f.fldYear=@fldYear and h1.fldModuleSaveId=@fldMadule
	--order by fldTarikhDocument,case when fldDocumentNum=0 then 1 else 0 end ,fldDocumentNum
	order by fldDocumentNum desc

	
	if (@fieldname=N'fldOrganId')
	SELECT top(@h) h1.[fldId], [fldDocumentNum],cast(atf as int ) [fldAtfNum], [fldArchiveNum], [fldDescriptionDocu],header.[fldOrganId] ,[fldTarikhDocument],header.[fldDesc], header.[fldDate], header.[fldIP], header.[fldUserId],[fldAccept] 
	,fldType,case when fldType=1 and fldaccept=1 then N'قطعی' when fldType=1 and fldaccept=0 then N'موقت' when fldType=2 then N'یادداشت' end as fldTypeName
	,cast(ShomareRoozane as int)ShomareRoozane,fldShomareFaree,f.fldYear,fldFiscalYearId
	,fldTypeSanadId as fldTypeSanad ,d.fldName    as fldTypeSanadName,m.fldTitle as fldNameModule,fldModuleErsalId,isnull(fldExistsFile,cast(0 as bit))fldIsArchive
	,case when h1.fldPId is null or fldTypeSanadId<>3 then 0 else Doc_Pid.fldDocumentNum_Pid end fldDocumentNum_Pid,isnull(h1.fldPId,0)fldPId,case when Typesanad.fldTypeSanadId_Pid is null then N'ارسال نشده' when Typesanad.fldTypeSanadId_Pid<>3 then N'ارسال شده' else sanadName.fldTypeSanadId_Pid end fldTypeSanadName_Pid
	,case when fldModuleErsalId in (5,12,13) then ACC.fn_GetSourceId(fldModuleErsalId,header.fldId) when fldPId is null  or fldModuleErsalId=fldModuleSaveId then fldDocumentNum  else (select h.fldDocumentNum from acc.tblDocumentRecord_Header1 as h where h1.fldPId=h.fldid) end fldMainDocNum,isnull(flag.fldFlag,0) as fldFlag, ACC.fn_GetArtiklMap( header.fldId, h1.fldId,h1.fldModuleErsalId) as fldIsMap,fldEdit,case when fldModuleErsalId in(12,13) then ACC.[fn_GetCaseTypeId](fldModuleErsalId,header.fldId) else 0 end as fldCaseTypeId
	FROM   [ACC].[tblDocumentRecord_Header] header inner join acc.tblFiscalYear f on header.fldFiscalYearId=f.fldid
	inner join acc.tblDocumentRecord_Header1 as h1 on h1.fldDocument_HedearId=header.fldid
	inner join[ACC].[tblDocumentType] d on d.fldid=fldTypeSanadId
	left join com.tblModule m on m.fldid=fldModuleErsalId
	outer Apply(
				select atf from (select row_number()over (order by h2.fldId) atf,h2.fldid   
				from acc.tblDocumentRecord_Header h
				inner join acc.tblFiscalYear f1 on h.fldFiscalYearId=f1.fldid
				inner join acc.tblDocumentRecord_Header1 as h2 on h2.fldDocument_HedearId=h.fldid
				where h.fldOrganId=header.fldOrganId and f1.fldYear=f.fldYear 
					and h2.fldModuleSaveId=h1.fldModuleSaveId and fldDocumentNum <>0
					)t where t.fldid=h1.fldid)atfNum

		outer apply (select ShomareRoozane from (select row_number()over (order by h2.fldDate) ShomareRoozane,h2.fldid  
				from acc.tblDocumentRecord_Header h
				inner join acc.tblFiscalYear f1 on h.fldFiscalYearId=f1.fldid
				inner join acc.tblDocumentRecord_Header1 as h2 on h2.fldDocument_HedearId=h.fldid
				where h.fldOrganId=header.fldOrganId and f1.fldYear=f.fldYear 
					and h2.fldModuleSaveId=h1.fldModuleSaveId and cast(h2.fldDate as date)=cast(h1.fldDate as date) 	
					and fldDocumentNum <>0)t where t.fldid=h1.fldid)Roozane

 outer apply(select  top(1) cast(1 as bit)fldExistsFile from acc.tblDocumentRecorde_File where fldDocumentHeaderId=header.fldid)Doc_File
 cross apply(select max(fldDate) as maxDate from
			(select max(h.fldDate) fldDate from acc.tblDocumentRecord_Header1 as h where h.fldId=h1.fldId
			union all
			select max(l.fldDate) fldDate from acc.tblDocument_HeaderLog as L where l.fldHeaderId =h1.fldId
			union all
			select max(f.fldDate) fldDate from acc.tblDocumentRecorde_File as f where f.fldDocumentHeaderId=header.fldId
			union all
			select max(b.fldDate) fldDate from acc.tblDocumentRecorde_File as f 
			inner join acc.tblDocumentBookMark as b on b.fldDocumentRecordeId=f.fldId
			where f.fldDocumentHeaderId=header.fldId)t)md
outer apply(select top 1  h.fldDocumentNum as fldDocumentNum_Pid from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldPId and h.fldId<h1.fldId order by h.fldId desc )Doc_Pid
outer apply(select top 1  h.fldTypeSanadId as fldTypeSanadId_Pid from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldId  order by h.fldId desc )Typesanad
outer apply(select (select top(1)  N'مرجوع شده (مرتبه ' +cast( ROW_NUMBER() over (order by h.fldid) as varchar(10))+')' from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldId and h.fldTypeSanadId=3 order by h.fldid desc) as fldTypeSanadId_Pid) sanadName
outer APPLY(select top(1) 1 as fldFlag
			FROM   [ACC].[tblDocumentRecord_Details] as d
			inner join acc.tblDocumentRecord_Header as h on h.fldId=d.fldDocument_HedearId
			inner join acc.[tblArtiklMap] as a on a.fldDocumentRecord_DetailsId=d.fldId
			WHERE   fldDocument_HedearId=header.fldId  
			and (fldDocument_HedearId1=h1.fldId
			 or (not exists(select * from Acc.tblDocumentRecord_Details as d2 where d2.fldDocument_HedearId1=h1.fldId ) and fldDocument_HedearId1 is null )) ) flag
WHERE  header.fldOrganId=@fldOrganId  and f.fldYear=@fldYear and h1.fldModuleSaveId=@fldMadule
	--order by fldTarikhDocument,case when fldDocumentNum=0 then 1 else 0 end ,fldDocumentNum
	order by fldDocumentNum desc

	
	
	if (@fieldname=N'fldTarikhDocument')
		SELECT top(@h) h1.[fldId], [fldDocumentNum],cast(atf as int ) [fldAtfNum], [fldArchiveNum], [fldDescriptionDocu],header.[fldOrganId] ,[fldTarikhDocument],header.[fldDesc], header.[fldDate], header.[fldIP], header.[fldUserId],[fldAccept] 
	,fldType,case when fldType=1 and fldaccept=1 then N'قطعی' when fldType=1 and fldaccept=0 then N'موقت' when fldType=2 then N'یادداشت' end as fldTypeName
	,cast(ShomareRoozane as int)ShomareRoozane,fldShomareFaree,f.fldYear,fldFiscalYearId
	,fldTypeSanadId as fldTypeSanad ,d.fldName    as fldTypeSanadName,m.fldTitle as fldNameModule,fldModuleErsalId,isnull(fldExistsFile,cast(0 as bit))fldIsArchive
	,case when h1.fldPId is null or fldTypeSanadId<>3 then 0 else Doc_Pid.fldDocumentNum_Pid end fldDocumentNum_Pid,isnull(h1.fldPId,0)fldPId,case when Typesanad.fldTypeSanadId_Pid is null then N'ارسال نشده' when Typesanad.fldTypeSanadId_Pid<>3 then N'ارسال شده' else sanadName.fldTypeSanadId_Pid end fldTypeSanadName_Pid
	,case when fldModuleErsalId in (5,12,13) then ACC.fn_GetSourceId(fldModuleErsalId,header.fldId) when fldPId is null  or fldModuleErsalId=fldModuleSaveId then fldDocumentNum  else (select h.fldDocumentNum from acc.tblDocumentRecord_Header1 as h where h1.fldPId=h.fldid) end fldMainDocNum,isnull(flag.fldFlag,0) as fldFlag, ACC.fn_GetArtiklMap( header.fldId, h1.fldId,h1.fldModuleErsalId) as fldIsMap,fldEdit,case when fldModuleErsalId in(12,13) then ACC.[fn_GetCaseTypeId](fldModuleErsalId,header.fldId) else 0 end as fldCaseTypeId
	FROM   [ACC].[tblDocumentRecord_Header] header inner join acc.tblFiscalYear f on header.fldFiscalYearId=f.fldid
	inner join acc.tblDocumentRecord_Header1 as h1 on h1.fldDocument_HedearId=header.fldid
	inner join[ACC].[tblDocumentType] d on d.fldid=fldTypeSanadId
	left join com.tblModule m on m.fldid=fldModuleErsalId
	outer Apply(
				select atf from (select row_number()over (order by h2.fldId) atf,h2.fldid   
				from acc.tblDocumentRecord_Header h
				inner join acc.tblFiscalYear f1 on h.fldFiscalYearId=f1.fldid
				inner join acc.tblDocumentRecord_Header1 as h2 on h2.fldDocument_HedearId=h.fldid
				where h.fldOrganId=header.fldOrganId and f1.fldYear=f.fldYear 
					and h2.fldModuleSaveId=h1.fldModuleSaveId and fldDocumentNum <>0
					)t where t.fldid=h1.fldid)atfNum

	outer apply (select ShomareRoozane from (select row_number()over (order by h2.fldDate) ShomareRoozane,h2.fldid  
				from acc.tblDocumentRecord_Header h
				inner join acc.tblFiscalYear f1 on h.fldFiscalYearId=f1.fldid
				inner join acc.tblDocumentRecord_Header1 as h2 on h2.fldDocument_HedearId=h.fldid
				where h.fldOrganId=header.fldOrganId and f1.fldYear=f.fldYear 
					and h2.fldModuleSaveId=h1.fldModuleSaveId and cast(h2.fldDate as date)=cast(h1.fldDate as date) 	
					and fldDocumentNum <>0)t where t.fldid=h1.fldid)Roozane

	outer apply(select  top(1) cast(1 as bit)fldExistsFile from acc.tblDocumentRecorde_File where fldDocumentHeaderId=header.fldid)Doc_File
	cross apply(select max(fldDate) as maxDate from
			(select max(h.fldDate) fldDate from acc.tblDocumentRecord_Header1 as h where h.fldId=h1.fldId
			union all
			select max(l.fldDate) fldDate from acc.tblDocument_HeaderLog as L where l.fldHeaderId =h1.fldId
			union all
			select max(f.fldDate) fldDate from acc.tblDocumentRecorde_File as f where f.fldDocumentHeaderId=header.fldId
			union all
			select max(b.fldDate) fldDate from acc.tblDocumentRecorde_File as f 
			inner join acc.tblDocumentBookMark as b on b.fldDocumentRecordeId=f.fldId
			where f.fldDocumentHeaderId=header.fldId)t)md
outer apply(select top 1  h.fldDocumentNum as fldDocumentNum_Pid from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldPId and h.fldId<h1.fldId order by h.fldId desc )Doc_Pid
outer apply(select top 1  h.fldTypeSanadId as fldTypeSanadId_Pid from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldId  order by h.fldId desc )Typesanad
outer apply(select (select top(1)  N'مرجوع شده (مرتبه ' +cast( ROW_NUMBER() over (order by h.fldid) as varchar(10))+')' from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldId and h.fldTypeSanadId=3 order by h.fldid desc) as fldTypeSanadId_Pid) sanadName
outer APPLY(select top(1) 1 as fldFlag
			FROM   [ACC].[tblDocumentRecord_Details] as d
			inner join acc.tblDocumentRecord_Header as h on h.fldId=d.fldDocument_HedearId
			inner join acc.[tblArtiklMap] as a on a.fldDocumentRecord_DetailsId=d.fldId
			WHERE   fldDocument_HedearId=header.fldId  
			and (fldDocument_HedearId1=h1.fldId
			 or (not exists(select * from Acc.tblDocumentRecord_Details as d2 where d2.fldDocument_HedearId1=h1.fldId ) and fldDocument_HedearId1 is null )) ) flag
WHERE fldTarikhDocument like  @Value AND header.fldOrganId=@fldOrganId  and f.fldYear=@fldYear and h1.fldModuleSaveId=@fldMadule
	--order by fldTarikhDocument,case when fldDocumentNum=0 then 1 else 0 end ,fldDocumentNum
	order by fldDocumentNum desc

	if (@fieldname=N'fldAccept')
	SELECT top(@h) h1.[fldId], [fldDocumentNum],cast(atf as int ) [fldAtfNum], [fldArchiveNum], [fldDescriptionDocu],header.[fldOrganId] ,[fldTarikhDocument],header.[fldDesc], header.[fldDate], header.[fldIP], header.[fldUserId],[fldAccept] 
	,fldType,case when fldType=1 and fldaccept=1 then N'قطعی' when fldType=1 and fldaccept=0 then N'موقت' when fldType=2 then N'یادداشت' end as fldTypeName
	,cast(ShomareRoozane as int)ShomareRoozane,fldShomareFaree,f.fldYear,fldFiscalYearId
	,fldTypeSanadId as fldTypeSanad ,d.fldName    as fldTypeSanadName,m.fldTitle as fldNameModule,fldModuleErsalId,isnull(fldExistsFile,cast(0 as bit))fldIsArchive
	,case when h1.fldPId is null or fldTypeSanadId<>3 then 0 else Doc_Pid.fldDocumentNum_Pid end fldDocumentNum_Pid,isnull(h1.fldPId,0)fldPId,case when Typesanad.fldTypeSanadId_Pid is null then N'ارسال نشده' when Typesanad.fldTypeSanadId_Pid<>3 then N'ارسال شده' else sanadName.fldTypeSanadId_Pid end fldTypeSanadName_Pid
	,case when fldModuleErsalId in (5,12,13) then ACC.fn_GetSourceId(fldModuleErsalId,header.fldId) when fldPId is null  or fldModuleErsalId=fldModuleSaveId then fldDocumentNum  else (select h.fldDocumentNum from acc.tblDocumentRecord_Header1 as h where h1.fldPId=h.fldid) end fldMainDocNum,isnull(flag.fldFlag,0) as fldFlag, ACC.fn_GetArtiklMap( header.fldId, h1.fldId,h1.fldModuleErsalId) as fldIsMap,fldEdit,case when fldModuleErsalId in(12,13) then ACC.[fn_GetCaseTypeId](fldModuleErsalId,header.fldId) else 0 end as fldCaseTypeId
	FROM   [ACC].[tblDocumentRecord_Header] header inner join acc.tblFiscalYear f on header.fldFiscalYearId=f.fldid
	inner join acc.tblDocumentRecord_Header1 as h1 on h1.fldDocument_HedearId=header.fldid
	inner join[ACC].[tblDocumentType] d on d.fldid=fldTypeSanadId
	left join com.tblModule m on m.fldid=fldModuleErsalId
	outer Apply(
				select atf from (select row_number()over (order by h2.fldId) atf,h2.fldid   
				from acc.tblDocumentRecord_Header h
				inner join acc.tblFiscalYear f1 on h.fldFiscalYearId=f1.fldid
				inner join acc.tblDocumentRecord_Header1 as h2 on h2.fldDocument_HedearId=h.fldid
				where h.fldOrganId=header.fldOrganId and f1.fldYear=f.fldYear 
					and h2.fldModuleSaveId=h1.fldModuleSaveId and fldDocumentNum <>0
					)t where t.fldid=h1.fldid)atfNum

		outer apply (select ShomareRoozane from (select row_number()over (order by h2.fldDate) ShomareRoozane,h2.fldid  
				from acc.tblDocumentRecord_Header h
				inner join acc.tblFiscalYear f1 on h.fldFiscalYearId=f1.fldid
				inner join acc.tblDocumentRecord_Header1 as h2 on h2.fldDocument_HedearId=h.fldid
				where h.fldOrganId=header.fldOrganId and f1.fldYear=f.fldYear 
					and h2.fldModuleSaveId=h1.fldModuleSaveId and cast(h2.fldDate as date)=cast(h1.fldDate as date) 	
					and fldDocumentNum <>0)t where t.fldid=h1.fldid)Roozane

	outer apply(select  top(1) cast(1 as bit)fldExistsFile from acc.tblDocumentRecorde_File where fldDocumentHeaderId=header.fldid)Doc_File
	cross apply(select max(fldDate) as maxDate from
			(select max(h.fldDate) fldDate from acc.tblDocumentRecord_Header1 as h where h.fldId=h1.fldId
			union all
			select max(l.fldDate) fldDate from acc.tblDocument_HeaderLog as L where l.fldHeaderId =h1.fldId
			union all
			select max(f.fldDate) fldDate from acc.tblDocumentRecorde_File as f where f.fldDocumentHeaderId=header.fldId
			union all
			select max(b.fldDate) fldDate from acc.tblDocumentRecorde_File as f 
			inner join acc.tblDocumentBookMark as b on b.fldDocumentRecordeId=f.fldId
			where f.fldDocumentHeaderId=header.fldId)t)md
outer apply(select top 1  h.fldDocumentNum as fldDocumentNum_Pid from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldPId and h.fldId<h1.fldId order by h.fldId desc )Doc_Pid
outer apply(select top 1  h.fldTypeSanadId as fldTypeSanadId_Pid from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldId  order by h.fldId desc )Typesanad
outer apply(select (select top(1)  N'مرجوع شده (مرتبه ' +cast( ROW_NUMBER() over (order by h.fldid) as varchar(10))+')' from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldId and h.fldTypeSanadId=3 order by h.fldid desc) as fldTypeSanadId_Pid) sanadName
outer APPLY(select top(1) 1 as fldFlag
			FROM   [ACC].[tblDocumentRecord_Details] as d
			inner join acc.tblDocumentRecord_Header as h on h.fldId=d.fldDocument_HedearId
			inner join acc.[tblArtiklMap] as a on a.fldDocumentRecord_DetailsId=d.fldId
			WHERE   fldDocument_HedearId=header.fldId  
			and (fldDocument_HedearId1=h1.fldId
			 or (not exists(select * from Acc.tblDocumentRecord_Details as d2 where d2.fldDocument_HedearId1=h1.fldId ) and fldDocument_HedearId1 is null )) ) flag
WHERE fldAccept like  @Value AND header.fldOrganId=@fldOrganId  and f.fldYear=@fldYear and h1.fldModuleSaveId=@fldMadule
	--order by fldTarikhDocument,case when fldDocumentNum=0 then 1 else 0 end ,fldDocumentNum
	order by fldDocumentNum desc

		if (@fieldname=N'ShomareRoozane')
		SELECT top(@h) h1.[fldId], [fldDocumentNum],cast(atf as int ) [fldAtfNum], [fldArchiveNum], [fldDescriptionDocu],header.[fldOrganId] ,[fldTarikhDocument],header.[fldDesc], header.[fldDate], header.[fldIP], header.[fldUserId],[fldAccept] 
	,fldType,case when fldType=1 and fldaccept=1 then N'قطعی' when fldType=1 and fldaccept=0 then N'موقت' when fldType=2 then N'یادداشت' end as fldTypeName
	,cast(ShomareRoozane as int)ShomareRoozane,fldShomareFaree,f.fldYear,fldFiscalYearId
	,fldTypeSanadId as fldTypeSanad ,d.fldName    as fldTypeSanadName,m.fldTitle as fldNameModule,fldModuleErsalId,isnull(fldExistsFile,cast(0 as bit))fldIsArchive
	,case when h1.fldPId is null or fldTypeSanadId<>3 then 0 else Doc_Pid.fldDocumentNum_Pid end fldDocumentNum_Pid,isnull(h1.fldPId,0)fldPId,case when Typesanad.fldTypeSanadId_Pid is null then N'ارسال نشده' when Typesanad.fldTypeSanadId_Pid<>3 then N'ارسال شده' else sanadName.fldTypeSanadId_Pid end fldTypeSanadName_Pid
	,case when fldModuleErsalId in (5,12,13) then ACC.fn_GetSourceId(fldModuleErsalId,header.fldId) when fldPId is null  or fldModuleErsalId=fldModuleSaveId then fldDocumentNum  else (select h.fldDocumentNum from acc.tblDocumentRecord_Header1 as h where h1.fldPId=h.fldid) end fldMainDocNum,isnull(flag.fldFlag,0) as fldFlag, ACC.fn_GetArtiklMap( header.fldId, h1.fldId,h1.fldModuleErsalId) as fldIsMap,fldEdit,case when fldModuleErsalId in(12,13) then ACC.[fn_GetCaseTypeId](fldModuleErsalId,header.fldId) else 0 end as fldCaseTypeId
	FROM   [ACC].[tblDocumentRecord_Header] header inner join acc.tblFiscalYear f on header.fldFiscalYearId=f.fldid
	inner join acc.tblDocumentRecord_Header1 as h1 on h1.fldDocument_HedearId=header.fldid
	inner join[ACC].[tblDocumentType] d on d.fldid=fldTypeSanadId
	left join com.tblModule m on m.fldid=fldModuleErsalId
	outer Apply(
				select atf from (select row_number()over (order by h2.fldId) atf,h2.fldid   
				from acc.tblDocumentRecord_Header h
				inner join acc.tblFiscalYear f1 on h.fldFiscalYearId=f1.fldid
				inner join acc.tblDocumentRecord_Header1 as h2 on h2.fldDocument_HedearId=h.fldid
				where h.fldOrganId=header.fldOrganId and f1.fldYear=f.fldYear 
					and h2.fldModuleSaveId=h1.fldModuleSaveId and fldDocumentNum <>0
					)t where t.fldid=h1.fldid)atfNum
	outer apply (select ShomareRoozane from (select row_number()over (order by h2.fldDate) ShomareRoozane,h2.fldid  
				from acc.tblDocumentRecord_Header h
				inner join acc.tblFiscalYear f1 on h.fldFiscalYearId=f1.fldid
				inner join acc.tblDocumentRecord_Header1 as h2 on h2.fldDocument_HedearId=h.fldid
				where h.fldOrganId=header.fldOrganId and f1.fldYear=f.fldYear 
					and h2.fldModuleSaveId=h1.fldModuleSaveId and cast(h2.fldDate as date)=cast(h1.fldDate as date) 	
					and fldDocumentNum <>0)t where t.fldid=h1.fldid)Roozane

	outer apply(select  top(1) cast(1 as bit)fldExistsFile from acc.tblDocumentRecorde_File where fldDocumentHeaderId=header.fldid)Doc_File
	cross apply(select max(fldDate) as maxDate from
			(select max(h.fldDate) fldDate from acc.tblDocumentRecord_Header1 as h where h.fldId=h1.fldId
			union all
			select max(l.fldDate) fldDate from acc.tblDocument_HeaderLog as L where l.fldHeaderId =h1.fldId
			union all
			select max(f.fldDate) fldDate from acc.tblDocumentRecorde_File as f where f.fldDocumentHeaderId=header.fldId
			union all
			select max(b.fldDate) fldDate from acc.tblDocumentRecorde_File as f 
			inner join acc.tblDocumentBookMark as b on b.fldDocumentRecordeId=f.fldId
			where f.fldDocumentHeaderId=header.fldId)t)md
outer apply(select top 1  h.fldDocumentNum as fldDocumentNum_Pid from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldPId and h.fldId<h1.fldId order by h.fldId desc )Doc_Pid
outer apply(select top 1  h.fldTypeSanadId as fldTypeSanadId_Pid from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldId  order by h.fldId desc )Typesanad
outer apply(select (select top(1)  N'مرجوع شده (مرتبه ' +cast( ROW_NUMBER() over (order by h.fldid) as varchar(10))+')' from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldId and h.fldTypeSanadId=3 order by h.fldid desc) as fldTypeSanadId_Pid) sanadName
outer APPLY(select top(1) 1 as fldFlag
			FROM   [ACC].[tblDocumentRecord_Details] as d
			inner join acc.tblDocumentRecord_Header as h on h.fldId=d.fldDocument_HedearId
			inner join acc.[tblArtiklMap] as a on a.fldDocumentRecord_DetailsId=d.fldId
			WHERE   fldDocument_HedearId=header.fldId  
			and (fldDocument_HedearId1=h1.fldId
			 or (not exists(select * from Acc.tblDocumentRecord_Details as d2 where d2.fldDocument_HedearId1=h1.fldId ) and fldDocument_HedearId1 is null )) ) flag
WHERE ShomareRoozane like  @Value AND header.fldOrganId=@fldOrganId  and f.fldYear=@fldYear and h1.fldModuleSaveId=@fldMadule
	--order by fldTarikhDocument,case when fldDocumentNum=0 then 1 else 0 end ,fldDocumentNum
	order by fldDocumentNum desc


	if (@fieldname=N'fldShomareFaree')
		SELECT top(@h) h1.[fldId], [fldDocumentNum],cast(atf as int ) [fldAtfNum], [fldArchiveNum], [fldDescriptionDocu],header.[fldOrganId] ,[fldTarikhDocument],header.[fldDesc], header.[fldDate], header.[fldIP], header.[fldUserId],[fldAccept] 
	,fldType,case when fldType=1 and fldaccept=1 then N'قطعی' when fldType=1 and fldaccept=0 then N'موقت' when fldType=2 then N'یادداشت' end as fldTypeName
	,cast(ShomareRoozane as int)ShomareRoozane,fldShomareFaree,f.fldYear,fldFiscalYearId
	,fldTypeSanadId as fldTypeSanad ,d.fldName    as fldTypeSanadName,m.fldTitle as fldNameModule,fldModuleErsalId,isnull(fldExistsFile,cast(0 as bit))fldIsArchive
	,case when h1.fldPId is null or fldTypeSanadId<>3 then 0 else Doc_Pid.fldDocumentNum_Pid end fldDocumentNum_Pid,isnull(h1.fldPId,0)fldPId,case when Typesanad.fldTypeSanadId_Pid is null then N'ارسال نشده' when Typesanad.fldTypeSanadId_Pid<>3 then N'ارسال شده' else sanadName.fldTypeSanadId_Pid end fldTypeSanadName_Pid
	,case when fldModuleErsalId in (5,12,13) then ACC.fn_GetSourceId(fldModuleErsalId,header.fldId) when fldPId is null  or fldModuleErsalId=fldModuleSaveId then fldDocumentNum  else (select h.fldDocumentNum from acc.tblDocumentRecord_Header1 as h where h1.fldPId=h.fldid) end fldMainDocNum,isnull(flag.fldFlag,0) as fldFlag, ACC.fn_GetArtiklMap( header.fldId, h1.fldId,h1.fldModuleErsalId) as fldIsMap,fldEdit,case when fldModuleErsalId in(12,13) then ACC.[fn_GetCaseTypeId](fldModuleErsalId,header.fldId) else 0 end as fldCaseTypeId
	FROM   [ACC].[tblDocumentRecord_Header] header inner join acc.tblFiscalYear f on header.fldFiscalYearId=f.fldid
	inner join acc.tblDocumentRecord_Header1 as h1 on h1.fldDocument_HedearId=header.fldid
	inner join[ACC].[tblDocumentType] d on d.fldid=fldTypeSanadId
	left join com.tblModule m on m.fldid=fldModuleErsalId
	outer Apply(
				select atf from (select row_number()over (order by h2.fldId) atf,h2.fldid   
				from acc.tblDocumentRecord_Header h
				inner join acc.tblFiscalYear f1 on h.fldFiscalYearId=f1.fldid
				inner join acc.tblDocumentRecord_Header1 as h2 on h2.fldDocument_HedearId=h.fldid
				where h.fldOrganId=header.fldOrganId and f1.fldYear=f.fldYear 
					and h2.fldModuleSaveId=h1.fldModuleSaveId and fldDocumentNum <>0
					)t where t.fldid=h1.fldid)atfNum

		outer apply (select ShomareRoozane from (select row_number()over (order by h2.fldDate) ShomareRoozane,h2.fldid  
				from acc.tblDocumentRecord_Header h
				inner join acc.tblFiscalYear f1 on h.fldFiscalYearId=f1.fldid
				inner join acc.tblDocumentRecord_Header1 as h2 on h2.fldDocument_HedearId=h.fldid
				where h.fldOrganId=header.fldOrganId and f1.fldYear=f.fldYear 
					and h2.fldModuleSaveId=h1.fldModuleSaveId and cast(h2.fldDate as date)=cast(h1.fldDate as date) 	
					and fldDocumentNum <>0)t where t.fldid=h1.fldid)Roozane

	outer apply(select   top(1) cast(1 as bit)fldExistsFile from acc.tblDocumentRecorde_File where fldDocumentHeaderId=header.fldid)Doc_File
	cross apply(select max(fldDate) as maxDate from
			(select max(h.fldDate) fldDate from acc.tblDocumentRecord_Header1 as h where h.fldId=h1.fldId
			union all
			select max(l.fldDate) fldDate from acc.tblDocument_HeaderLog as L where l.fldHeaderId =h1.fldId
			union all
			select max(f.fldDate) fldDate from acc.tblDocumentRecorde_File as f where f.fldDocumentHeaderId=header.fldId
			union all
			select max(b.fldDate) fldDate from acc.tblDocumentRecorde_File as f 
			inner join acc.tblDocumentBookMark as b on b.fldDocumentRecordeId=f.fldId
			where f.fldDocumentHeaderId=header.fldId)t)md
outer apply(select top 1  h.fldDocumentNum as fldDocumentNum_Pid from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldPId and h.fldId<h1.fldId order by h.fldId desc )Doc_Pid
outer apply(select top 1  h.fldTypeSanadId as fldTypeSanadId_Pid from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldId  order by h.fldId desc )Typesanad
outer apply(select (select top(1)  N'مرجوع شده (مرتبه ' +cast( ROW_NUMBER() over (order by h.fldid) as varchar(10))+')' from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldId and h.fldTypeSanadId=3 order by h.fldid desc) as fldTypeSanadId_Pid) sanadName
outer APPLY(select top(1) 1 as fldFlag
			FROM   [ACC].[tblDocumentRecord_Details] as d
			inner join acc.tblDocumentRecord_Header as h on h.fldId=d.fldDocument_HedearId
			inner join acc.[tblArtiklMap] as a on a.fldDocumentRecord_DetailsId=d.fldId
			WHERE   fldDocument_HedearId=header.fldId  
			and (fldDocument_HedearId1=h1.fldId
			 or (not exists(select * from Acc.tblDocumentRecord_Details as d2 where d2.fldDocument_HedearId1=h1.fldId ) and fldDocument_HedearId1 is null )) ) flag
WHERE fldShomareFaree like  @Value AND header.fldOrganId=@fldOrganId  and f.fldYear=@fldYear and h1.fldModuleSaveId=@fldMadule
	--order by fldTarikhDocument,case when fldDocumentNum=0 then 1 else 0 end ,fldDocumentNum
	order by fldDocumentNum desc

	if (@fieldname=N'fldType')
		SELECT top(@h) h1.[fldId], [fldDocumentNum],cast(atf as int ) [fldAtfNum], [fldArchiveNum], [fldDescriptionDocu],header.[fldOrganId] ,[fldTarikhDocument],header.[fldDesc], header.[fldDate], header.[fldIP], header.[fldUserId],[fldAccept] 
	,fldType,case when fldType=1 and fldaccept=1 then N'قطعی' when fldType=1 and fldaccept=0 then N'موقت' when fldType=2 then N'یادداشت' end as fldTypeName
	,cast(ShomareRoozane as int)ShomareRoozane,fldShomareFaree,f.fldYear,fldFiscalYearId
	,fldTypeSanadId as fldTypeSanad ,d.fldName    as fldTypeSanadName,m.fldTitle as fldNameModule,fldModuleErsalId,isnull(fldExistsFile,cast(0 as bit))fldIsArchive
	,case when h1.fldPId is null or fldTypeSanadId<>3 then 0 else Doc_Pid.fldDocumentNum_Pid end fldDocumentNum_Pid,isnull(h1.fldPId,0)fldPId,case when Typesanad.fldTypeSanadId_Pid is null then N'ارسال نشده' when Typesanad.fldTypeSanadId_Pid<>3 then N'ارسال شده' else sanadName.fldTypeSanadId_Pid end fldTypeSanadName_Pid
	,case when fldModuleErsalId in (5,12,13) then ACC.fn_GetSourceId(fldModuleErsalId,header.fldId) when fldPId is null  or fldModuleErsalId=fldModuleSaveId then fldDocumentNum  else (select h.fldDocumentNum from acc.tblDocumentRecord_Header1 as h where h1.fldPId=h.fldid) end fldMainDocNum,isnull(flag.fldFlag,0) as fldFlag, ACC.fn_GetArtiklMap( header.fldId, h1.fldId,h1.fldModuleErsalId) as fldIsMap,fldEdit,case when fldModuleErsalId in(12,13) then ACC.[fn_GetCaseTypeId](fldModuleErsalId,header.fldId) else 0 end as fldCaseTypeId
	FROM   [ACC].[tblDocumentRecord_Header] header inner join acc.tblFiscalYear f on header.fldFiscalYearId=f.fldid
	inner join acc.tblDocumentRecord_Header1 as h1 on h1.fldDocument_HedearId=header.fldid
	inner join[ACC].[tblDocumentType] d on d.fldid=fldTypeSanadId
	left join com.tblModule m on m.fldid=fldModuleErsalId
	outer Apply(
				select atf from (select row_number()over (order by h2.fldId) atf,h2.fldid   
				from acc.tblDocumentRecord_Header h
				inner join acc.tblFiscalYear f1 on h.fldFiscalYearId=f1.fldid
				inner join acc.tblDocumentRecord_Header1 as h2 on h2.fldDocument_HedearId=h.fldid
				where h.fldOrganId=header.fldOrganId and f1.fldYear=f.fldYear 
					and h2.fldModuleSaveId=h1.fldModuleSaveId and fldDocumentNum <>0
					)t where t.fldid=h1.fldid)atfNum

		outer apply (select ShomareRoozane from (select row_number()over (order by h2.fldDate) ShomareRoozane,h2.fldid  
				from acc.tblDocumentRecord_Header h
				inner join acc.tblFiscalYear f1 on h.fldFiscalYearId=f1.fldid
				inner join acc.tblDocumentRecord_Header1 as h2 on h2.fldDocument_HedearId=h.fldid
				where h.fldOrganId=header.fldOrganId and f1.fldYear=f.fldYear 
					and h2.fldModuleSaveId=h1.fldModuleSaveId and cast(h2.fldDate as date)=cast(h1.fldDate as date) 	
					and fldDocumentNum <>0)t where t.fldid=h1.fldid)Roozane

	outer apply(select  top(1) cast(1 as bit)fldExistsFile from acc.tblDocumentRecorde_File where fldDocumentHeaderId=header.fldid)Doc_File
	cross apply(select max(fldDate) as maxDate from
			(select max(h.fldDate) fldDate from acc.tblDocumentRecord_Header1 as h where h.fldId=h1.fldId
			union all
			select max(l.fldDate) fldDate from acc.tblDocument_HeaderLog as L where l.fldHeaderId =h1.fldId
			union all
			select max(f.fldDate) fldDate from acc.tblDocumentRecorde_File as f where f.fldDocumentHeaderId=header.fldId
			union all
			select max(b.fldDate) fldDate from acc.tblDocumentRecorde_File as f 
			inner join acc.tblDocumentBookMark as b on b.fldDocumentRecordeId=f.fldId
			where f.fldDocumentHeaderId=header.fldId)t)md
outer apply(select top 1  h.fldDocumentNum as fldDocumentNum_Pid from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldPId and h.fldId<h1.fldId order by h.fldId desc )Doc_Pid
outer apply(select top 1  h.fldTypeSanadId as fldTypeSanadId_Pid from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldId  order by h.fldId desc )Typesanad
outer apply(select (select top(1)  N'مرجوع شده (مرتبه ' +cast( ROW_NUMBER() over (order by h.fldid) as varchar(10))+')' from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldId and h.fldTypeSanadId=3 order by h.fldid desc) as fldTypeSanadId_Pid) sanadName
outer APPLY(select top(1) 1 as fldFlag
			FROM   [ACC].[tblDocumentRecord_Details] as d
			inner join acc.tblDocumentRecord_Header as h on h.fldId=d.fldDocument_HedearId
			inner join acc.[tblArtiklMap] as a on a.fldDocumentRecord_DetailsId=d.fldId
			WHERE   fldDocument_HedearId=header.fldId  
			and (fldDocument_HedearId1=h1.fldId
			 or (not exists(select * from Acc.tblDocumentRecord_Details as d2 where d2.fldDocument_HedearId1=h1.fldId ) and fldDocument_HedearId1 is null )) ) flag
WHERE fldType like  @Value AND header.fldOrganId=@fldOrganId  and f.fldYear=@fldYear and h1.fldModuleSaveId=@fldMadule
	--order by fldTarikhDocument,case when fldDocumentNum=0 then 1 else 0 end ,fldDocumentNum
	order by fldDocumentNum desc

	if (@fieldname=N'fldTypeSanadId')
		SELECT top(@h) h1.[fldId], [fldDocumentNum],cast(atf as int ) [fldAtfNum], [fldArchiveNum], [fldDescriptionDocu],header.[fldOrganId] ,[fldTarikhDocument],header.[fldDesc], header.[fldDate], header.[fldIP], header.[fldUserId],[fldAccept] 
	,fldType,case when fldType=1 and fldaccept=1 then N'قطعی' when fldType=1 and fldaccept=0 then N'موقت' when fldType=2 then N'یادداشت' end as fldTypeName
	,cast(ShomareRoozane as int)ShomareRoozane,fldShomareFaree,f.fldYear,fldFiscalYearId
	,fldTypeSanadId as fldTypeSanad ,d.fldName    as fldTypeSanadName,m.fldTitle as fldNameModule,fldModuleErsalId,isnull(fldExistsFile,cast(0 as bit))fldIsArchive
	,case when h1.fldPId is null or fldTypeSanadId<>3 then 0 else Doc_Pid.fldDocumentNum_Pid end fldDocumentNum_Pid,isnull(h1.fldPId,0)fldPId,case when Typesanad.fldTypeSanadId_Pid is null then N'ارسال نشده' when Typesanad.fldTypeSanadId_Pid<>3 then N'ارسال شده' else sanadName.fldTypeSanadId_Pid end fldTypeSanadName_Pid
	,case when fldModuleErsalId in (5,12,13) then ACC.fn_GetSourceId(fldModuleErsalId,header.fldId) when fldPId is null  or fldModuleErsalId=fldModuleSaveId then fldDocumentNum  else (select h.fldDocumentNum from acc.tblDocumentRecord_Header1 as h where h1.fldPId=h.fldid) end fldMainDocNum,isnull(flag.fldFlag,0) as fldFlag, ACC.fn_GetArtiklMap( header.fldId, h1.fldId,h1.fldModuleErsalId) as fldIsMap,fldEdit,case when fldModuleErsalId in(12,13) then ACC.[fn_GetCaseTypeId](fldModuleErsalId,header.fldId) else 0 end as fldCaseTypeId
	FROM   [ACC].[tblDocumentRecord_Header] header inner join acc.tblFiscalYear f on header.fldFiscalYearId=f.fldid
	inner join acc.tblDocumentRecord_Header1 as h1 on h1.fldDocument_HedearId=header.fldid
	inner join[ACC].[tblDocumentType] d on d.fldid=fldTypeSanadId
	left join com.tblModule m on m.fldid=fldModuleErsalId
	outer Apply(
				select atf from (select row_number()over (order by h2.fldId) atf,h2.fldid   
				from acc.tblDocumentRecord_Header h
				inner join acc.tblFiscalYear f1 on h.fldFiscalYearId=f1.fldid
				inner join acc.tblDocumentRecord_Header1 as h2 on h2.fldDocument_HedearId=h.fldid
				where h.fldOrganId=header.fldOrganId and f1.fldYear=f.fldYear 
					and h2.fldModuleSaveId=h1.fldModuleSaveId and fldDocumentNum <>0
					)t where t.fldid=h1.fldid)atfNum

		outer apply (select ShomareRoozane from (select row_number()over (order by h2.fldDate) ShomareRoozane,h2.fldid  
				from acc.tblDocumentRecord_Header h
				inner join acc.tblFiscalYear f1 on h.fldFiscalYearId=f1.fldid
				inner join acc.tblDocumentRecord_Header1 as h2 on h2.fldDocument_HedearId=h.fldid
				where h.fldOrganId=header.fldOrganId and f1.fldYear=f.fldYear 
					and h2.fldModuleSaveId=h1.fldModuleSaveId and cast(h2.fldDate as date)=cast(h1.fldDate as date) 	
					and fldDocumentNum <>0)t where t.fldid=h1.fldid)Roozane

	outer apply(select  top(1) cast(1 as bit)fldExistsFile from acc.tblDocumentRecorde_File where fldDocumentHeaderId=header.fldid)Doc_File
	cross apply(select max(fldDate) as maxDate from
			(select max(h.fldDate) fldDate from acc.tblDocumentRecord_Header1 as h where h.fldId=h1.fldId
			union all
			select max(l.fldDate) fldDate from acc.tblDocument_HeaderLog as L where l.fldHeaderId =h1.fldId
			union all
			select max(f.fldDate) fldDate from acc.tblDocumentRecorde_File as f where f.fldDocumentHeaderId=header.fldId
			union all
			select max(b.fldDate) fldDate from acc.tblDocumentRecorde_File as f 
			inner join acc.tblDocumentBookMark as b on b.fldDocumentRecordeId=f.fldId
			where f.fldDocumentHeaderId=header.fldId)t)md
outer apply(select top 1  h.fldDocumentNum as fldDocumentNum_Pid from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldPId and h.fldId<h1.fldId order by h.fldId desc )Doc_Pid
outer apply(select top 1  h.fldTypeSanadId as fldTypeSanadId_Pid from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldId  order by h.fldId desc )Typesanad
outer apply(select (select top(1)  N'مرجوع شده (مرتبه ' +cast( ROW_NUMBER() over (order by h.fldid) as varchar(10))+')' from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldId and h.fldTypeSanadId=3 order by h.fldid desc) as fldTypeSanadId_Pid) sanadName
outer APPLY(select top(1) 1 as fldFlag
			FROM   [ACC].[tblDocumentRecord_Details] as d
			inner join acc.tblDocumentRecord_Header as h on h.fldId=d.fldDocument_HedearId
			inner join acc.[tblArtiklMap] as a on a.fldDocumentRecord_DetailsId=d.fldId
			WHERE   fldDocument_HedearId=header.fldId  
			and (fldDocument_HedearId1=h1.fldId
			 or (not exists(select * from Acc.tblDocumentRecord_Details as d2 where d2.fldDocument_HedearId1=h1.fldId ) and fldDocument_HedearId1 is null )) ) flag
WHERE fldTypeSanadId like  @Value AND header.fldOrganId=@fldOrganId  and f.fldYear=@fldYear and h1.fldModuleSaveId=@fldMadule
	--order by fldTarikhDocument,case when fldDocumentNum=0 then 1 else 0 end ,fldDocumentNum
	order by fldDocumentNum desc

		if (@fieldname=N'fldTypeSanadName')
		SELECT top(@h) h1.[fldId], [fldDocumentNum],cast(atf as int ) [fldAtfNum], [fldArchiveNum], [fldDescriptionDocu],header.[fldOrganId] ,[fldTarikhDocument],header.[fldDesc], header.[fldDate], header.[fldIP], header.[fldUserId],[fldAccept] 
	,fldType,case when fldType=1 and fldaccept=1 then N'قطعی' when fldType=1 and fldaccept=0 then N'موقت' when fldType=2 then N'یادداشت' end as fldTypeName
	,cast(ShomareRoozane as int)ShomareRoozane,fldShomareFaree,f.fldYear,fldFiscalYearId
	,fldTypeSanadId as fldTypeSanad ,d.fldName    as fldTypeSanadName,m.fldTitle as fldNameModule,fldModuleErsalId,isnull(fldExistsFile,cast(0 as bit))fldIsArchive
	,case when h1.fldPId is null or fldTypeSanadId<>3 then 0 else Doc_Pid.fldDocumentNum_Pid end fldDocumentNum_Pid,isnull(h1.fldPId,0)fldPId,case when Typesanad.fldTypeSanadId_Pid is null then N'ارسال نشده' when Typesanad.fldTypeSanadId_Pid<>3 then N'ارسال شده' else sanadName.fldTypeSanadId_Pid end fldTypeSanadName_Pid
	,case when fldModuleErsalId in (5,12,13) then ACC.fn_GetSourceId(fldModuleErsalId,header.fldId) when fldPId is null  or fldModuleErsalId=fldModuleSaveId then fldDocumentNum  else (select h.fldDocumentNum from acc.tblDocumentRecord_Header1 as h where h1.fldPId=h.fldid) end fldMainDocNum,isnull(flag.fldFlag,0) as fldFlag, ACC.fn_GetArtiklMap( header.fldId, h1.fldId,h1.fldModuleErsalId) as fldIsMap,fldEdit,case when fldModuleErsalId in(12,13) then ACC.[fn_GetCaseTypeId](fldModuleErsalId,header.fldId) else 0 end as fldCaseTypeId
	FROM   [ACC].[tblDocumentRecord_Header] header inner join acc.tblFiscalYear f on header.fldFiscalYearId=f.fldid
	inner join acc.tblDocumentRecord_Header1 as h1 on h1.fldDocument_HedearId=header.fldid
	inner join[ACC].[tblDocumentType] d on d.fldid=fldTypeSanadId
	left join com.tblModule m on m.fldid=fldModuleErsalId
	outer Apply(
				select atf from (select row_number()over (order by h2.fldId) atf,h2.fldid   
				from acc.tblDocumentRecord_Header h
				inner join acc.tblFiscalYear f1 on h.fldFiscalYearId=f1.fldid
				inner join acc.tblDocumentRecord_Header1 as h2 on h2.fldDocument_HedearId=h.fldid
				where h.fldOrganId=header.fldOrganId and f1.fldYear=f.fldYear 
					and h2.fldModuleSaveId=h1.fldModuleSaveId and fldDocumentNum <>0
					)t where t.fldid=h1.fldid)atfNum

	outer apply (select ShomareRoozane from (select row_number()over (order by h2.fldDate) ShomareRoozane,h2.fldid  
				from acc.tblDocumentRecord_Header h
				inner join acc.tblFiscalYear f1 on h.fldFiscalYearId=f1.fldid
				inner join acc.tblDocumentRecord_Header1 as h2 on h2.fldDocument_HedearId=h.fldid
				where h.fldOrganId=header.fldOrganId and f1.fldYear=f.fldYear 
					and h2.fldModuleSaveId=h1.fldModuleSaveId and cast(h2.fldDate as date)=cast(h1.fldDate as date) 	
					and fldDocumentNum <>0)t where t.fldid=h1.fldid)Roozane

	outer apply(select top(1) cast(1 as bit)fldExistsFile from acc.tblDocumentRecorde_File where fldDocumentHeaderId=header.fldid)Doc_File
	cross apply(select max(fldDate) as maxDate from
			(select max(h.fldDate) fldDate from acc.tblDocumentRecord_Header1 as h where h.fldId=h1.fldId
			union all
			select max(l.fldDate) fldDate from acc.tblDocument_HeaderLog as L where l.fldHeaderId =h1.fldId
			union all
			select max(f.fldDate) fldDate from acc.tblDocumentRecorde_File as f where f.fldDocumentHeaderId=header.fldId
			union all
			select max(b.fldDate) fldDate from acc.tblDocumentRecorde_File as f 
			inner join acc.tblDocumentBookMark as b on b.fldDocumentRecordeId=f.fldId
			where f.fldDocumentHeaderId=header.fldId)t)md
outer apply(select top 1  h.fldDocumentNum as fldDocumentNum_Pid from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldPId and h.fldId<h1.fldId order by h.fldId desc )Doc_Pid
outer apply(select top 1  h.fldTypeSanadId as fldTypeSanadId_Pid from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldId  order by h.fldId desc )Typesanad
outer apply(select (select top(1)  N'مرجوع شده (مرتبه ' +cast( ROW_NUMBER() over (order by h.fldid) as varchar(10))+')' from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldId and h.fldTypeSanadId=3 order by h.fldid desc) as fldTypeSanadId_Pid) sanadName
outer APPLY(select top(1) 1 as fldFlag
			FROM   [ACC].[tblDocumentRecord_Details] as d
			inner join acc.tblDocumentRecord_Header as h on h.fldId=d.fldDocument_HedearId
			inner join acc.[tblArtiklMap] as a on a.fldDocumentRecord_DetailsId=d.fldId
			WHERE   fldDocument_HedearId=header.fldId  
			and (fldDocument_HedearId1=h1.fldId
			 or (not exists(select * from Acc.tblDocumentRecord_Details as d2 where d2.fldDocument_HedearId1=h1.fldId ) and fldDocument_HedearId1 is null )) ) flag
WHERE d.fldName like  @Value AND header.fldOrganId=@fldOrganId  and f.fldYear=@fldYear and h1.fldModuleSaveId=@fldMadule
	--order by fldTarikhDocument,case when fldDocumentNum=0 then 1 else 0 end ,fldDocumentNum
	order by fldDocumentNum desc
	
	if (@fieldname=N'fldNameModule')
		SELECT top(@h) h1.[fldId], [fldDocumentNum],cast(atf as int ) [fldAtfNum], [fldArchiveNum], [fldDescriptionDocu],header.[fldOrganId] ,[fldTarikhDocument],header.[fldDesc], header.[fldDate], header.[fldIP], header.[fldUserId],[fldAccept] 
	,fldType,case when fldType=1 and fldaccept=1 then N'قطعی' when fldType=1 and fldaccept=0 then N'موقت' when fldType=2 then N'یادداشت' end as fldTypeName
	,cast(ShomareRoozane as int)ShomareRoozane,fldShomareFaree,f.fldYear,fldFiscalYearId
	,fldTypeSanadId as fldTypeSanad ,d.fldName    as fldTypeSanadName,m.fldTitle as fldNameModule,fldModuleErsalId,isnull(fldExistsFile,cast(0 as bit))fldIsArchive
	,case when h1.fldPId is null or fldTypeSanadId<>3 then 0 else Doc_Pid.fldDocumentNum_Pid end fldDocumentNum_Pid,isnull(h1.fldPId,0)fldPId,case when Typesanad.fldTypeSanadId_Pid is null then N'ارسال نشده' when Typesanad.fldTypeSanadId_Pid<>3 then N'ارسال شده' else sanadName.fldTypeSanadId_Pid end fldTypeSanadName_Pid
	,case when fldModuleErsalId in (5,12,13) then ACC.fn_GetSourceId(fldModuleErsalId,header.fldId) when fldPId is null  or fldModuleErsalId=fldModuleSaveId then fldDocumentNum  else (select h.fldDocumentNum from acc.tblDocumentRecord_Header1 as h where h1.fldPId=h.fldid) end fldMainDocNum,isnull(flag.fldFlag,0) as fldFlag, ACC.fn_GetArtiklMap( header.fldId, h1.fldId,h1.fldModuleErsalId) as fldIsMap,fldEdit,case when fldModuleErsalId in(12,13) then ACC.[fn_GetCaseTypeId](fldModuleErsalId,header.fldId) else 0 end as fldCaseTypeId
	FROM   [ACC].[tblDocumentRecord_Header] header inner join acc.tblFiscalYear f on header.fldFiscalYearId=f.fldid
	inner join acc.tblDocumentRecord_Header1 as h1 on h1.fldDocument_HedearId=header.fldid
	inner join[ACC].[tblDocumentType] d on d.fldid=fldTypeSanadId
	left join com.tblModule m on m.fldid=fldModuleErsalId
	outer Apply(
				select atf from (select row_number()over (order by h2.fldId) atf,h2.fldid   
				from acc.tblDocumentRecord_Header h
				inner join acc.tblFiscalYear f1 on h.fldFiscalYearId=f1.fldid
				inner join acc.tblDocumentRecord_Header1 as h2 on h2.fldDocument_HedearId=h.fldid
				where h.fldOrganId=header.fldOrganId and f1.fldYear=f.fldYear 
					and h2.fldModuleSaveId=h1.fldModuleSaveId and fldDocumentNum <>0
					)t where t.fldid=h1.fldid)atfNum

	outer apply (select ShomareRoozane from (select row_number()over (order by h2.fldDate) ShomareRoozane,h2.fldid  
				from acc.tblDocumentRecord_Header h
				inner join acc.tblFiscalYear f1 on h.fldFiscalYearId=f1.fldid
				inner join acc.tblDocumentRecord_Header1 as h2 on h2.fldDocument_HedearId=h.fldid
				where h.fldOrganId=header.fldOrganId and f1.fldYear=f.fldYear 
					and h2.fldModuleSaveId=h1.fldModuleSaveId and cast(h2.fldDate as date)=cast(h1.fldDate as date) 	
					and fldDocumentNum <>0)t where t.fldid=h1.fldid)Roozane

	outer apply(select top(1) cast(1 as bit)fldExistsFile from acc.tblDocumentRecorde_File where fldDocumentHeaderId=header.fldid)Doc_File
	cross apply(select max(fldDate) as maxDate from
			(select max(h.fldDate) fldDate from acc.tblDocumentRecord_Header1 as h where h.fldId=h1.fldId
			union all
			select max(l.fldDate) fldDate from acc.tblDocument_HeaderLog as L where l.fldHeaderId =h1.fldId
			union all
			select max(f.fldDate) fldDate from acc.tblDocumentRecorde_File as f where f.fldDocumentHeaderId=header.fldId
			union all
			select max(b.fldDate) fldDate from acc.tblDocumentRecorde_File as f 
			inner join acc.tblDocumentBookMark as b on b.fldDocumentRecordeId=f.fldId
			where f.fldDocumentHeaderId=header.fldId)t)md
outer apply(select top 1  h.fldDocumentNum as fldDocumentNum_Pid from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldPId and h.fldId<h1.fldId order by h.fldId desc )Doc_Pid
outer apply(select top 1  h.fldTypeSanadId as fldTypeSanadId_Pid from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldId  order by h.fldId desc )Typesanad
outer apply(select (select top(1)  N'مرجوع شده (مرتبه ' +cast( ROW_NUMBER() over (order by h.fldid) as varchar(10))+')' from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldId and h.fldTypeSanadId=3 order by h.fldid desc) as fldTypeSanadId_Pid) sanadName
outer APPLY(select top(1) 1 as fldFlag
			FROM   [ACC].[tblDocumentRecord_Details] as d
			inner join acc.tblDocumentRecord_Header as h on h.fldId=d.fldDocument_HedearId
			inner join acc.[tblArtiklMap] as a on a.fldDocumentRecord_DetailsId=d.fldId
			WHERE   fldDocument_HedearId=header.fldId  
			and (fldDocument_HedearId1=h1.fldId
			 or (not exists(select * from Acc.tblDocumentRecord_Details as d2 where d2.fldDocument_HedearId1=h1.fldId ) and fldDocument_HedearId1 is null )) ) flag
WHERE m.fldTitle like  @Value AND header.fldOrganId=@fldOrganId  and f.fldYear=@fldYear and h1.fldModuleSaveId=@fldMadule
	--order by fldTarikhDocument,case when fldDocumentNum=0 then 1 else 0 end ,fldDocumentNum
	order by fldDocumentNum desc
	
	if (@fieldname=N'lastYear')/*farghdare*/
	SELECT top(1) h1.[fldId], [fldDocumentNum],0 [fldAtfNum], [fldArchiveNum], [fldDescriptionDocu],header.[fldOrganId] ,[fldTarikhDocument],header.[fldDesc], header.[fldDate], header.[fldIP], header.[fldUserId],[fldAccept] 
	,fldType,case when fldType=1 and fldaccept=1 then N'قطعی' when fldType=1 and fldaccept=0 then N'موقت' when fldType=2 then N'یادداشت' end as fldTypeName
	,0 ShomareRoozane,fldShomareFaree,f.fldYear,fldFiscalYearId
	,fldTypeSanadId as fldTypeSanad ,d.fldName    as fldTypeSanadName,m.fldTitle as fldNameModule,fldModuleErsalId,cast(0 as bit)fldIsArchive
	,case when h1.fldPId is null or fldTypeSanadId<>3 then 0 else Doc_Pid.fldDocumentNum_Pid end fldDocumentNum_Pid,isnull(h1.fldPId,0)fldPId,case when Typesanad.fldTypeSanadId_Pid is null then N'ارسال نشده' when Typesanad.fldTypeSanadId_Pid<>3 then N'ارسال شده' else sanadName.fldTypeSanadId_Pid end fldTypeSanadName_Pid
	,case when fldModuleErsalId in (5,12,13) then ACC.fn_GetSourceId(fldModuleErsalId,header.fldId) when fldPId is null  or fldModuleErsalId=fldModuleSaveId then fldDocumentNum  else (select h.fldDocumentNum from acc.tblDocumentRecord_Header1 as h where h1.fldPId=h.fldid) end fldMainDocNum,isnull(flag.fldFlag,0) as fldFlag, ACC.fn_GetArtiklMap( header.fldId, h1.fldId,h1.fldModuleErsalId) as fldIsMap,fldEdit,case when fldModuleErsalId in(12,13) then ACC.[fn_GetCaseTypeId](fldModuleErsalId,header.fldId) else 0 end as fldCaseTypeId
	FROM   [ACC].[tblDocumentRecord_Header] header inner join acc.tblFiscalYear f on header.fldFiscalYearId=f.fldid
	inner join acc.tblDocumentRecord_Header1 as h1 on h1.fldDocument_HedearId=header.fldid
	inner join[ACC].[tblDocumentType] d on d.fldid=fldTypeSanadId
	left join com.tblModule m on m.fldid=fldModuleErsalId
outer apply(select top 1  h.fldDocumentNum as fldDocumentNum_Pid from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldPId and h.fldId<h1.fldId order by h.fldId desc )Doc_Pid
outer apply(select top 1  h.fldTypeSanadId as fldTypeSanadId_Pid from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldId  order by h.fldId desc )Typesanad
outer apply(select (select top(1)  N'مرجوع شده (مرتبه ' +cast( ROW_NUMBER() over (order by h.fldid) as varchar(10))+')' from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldId and h.fldTypeSanadId=3 order by h.fldid desc) as fldTypeSanadId_Pid) sanadName
outer APPLY(select top(1) 1 as fldFlag
			FROM   [ACC].[tblDocumentRecord_Details] as d
			inner join acc.tblDocumentRecord_Header as h on h.fldId=d.fldDocument_HedearId
			inner join acc.[tblArtiklMap] as a on a.fldDocumentRecord_DetailsId=d.fldId
			WHERE   fldDocument_HedearId=header.fldId  
			and (fldDocument_HedearId1=h1.fldId
			 or (not exists(select * from Acc.tblDocumentRecord_Details as d2 where d2.fldDocument_HedearId1=h1.fldId ) and fldDocument_HedearId1 is null )) ) flag
where header.fldOrganId=@fldOrganId and fldModuleSaveId=@fldMadule
	order by fldYear desc


	if (@fieldname=N'lastDateDoc')/*farghdare*/
	SELECT top(1) h1.[fldId], [fldDocumentNum],0 [fldAtfNum], [fldArchiveNum], [fldDescriptionDocu],header.[fldOrganId] ,[fldTarikhDocument],header.[fldDesc], header.[fldDate], header.[fldIP], header.[fldUserId],[fldAccept] 
	,fldType,case when fldType=1 and fldaccept=1 then N'قطعی' when fldType=1 and fldaccept=0 then N'موقت' when fldType=2 then N'یادداشت' end as fldTypeName
	,0 ShomareRoozane,fldShomareFaree,f.fldYear,fldFiscalYearId
	,fldTypeSanadId as fldTypeSanad ,d.fldName    as fldTypeSanadName,m.fldTitle as fldNameModule,fldModuleErsalId,cast(0 as bit)fldIsArchive
	,case when h1.fldPId is null or fldTypeSanadId<>3 then 0 else Doc_Pid.fldDocumentNum_Pid end fldDocumentNum_Pid,isnull(h1.fldPId,0)fldPId,case when Typesanad.fldTypeSanadId_Pid is null then N'ارسال نشده' when Typesanad.fldTypeSanadId_Pid<>3 then N'ارسال شده' else sanadName.fldTypeSanadId_Pid end fldTypeSanadName_Pid
	,case when fldModuleErsalId in (5,12,13) then ACC.fn_GetSourceId(fldModuleErsalId,header.fldId) when fldPId is null  or fldModuleErsalId=fldModuleSaveId then fldDocumentNum  else (select h.fldDocumentNum from acc.tblDocumentRecord_Header1 as h where h1.fldPId=h.fldid) end fldMainDocNum,isnull(flag.fldFlag,0) as fldFlag, ACC.fn_GetArtiklMap( header.fldId, h1.fldId,h1.fldModuleErsalId) as fldIsMap,fldEdit,case when fldModuleErsalId in(12,13) then ACC.[fn_GetCaseTypeId](fldModuleErsalId,header.fldId) else 0 end as fldCaseTypeId
	FROM   [ACC].[tblDocumentRecord_Header] header inner join acc.tblFiscalYear f on header.fldFiscalYearId=f.fldid
	inner join acc.tblDocumentRecord_Header1 as h1 on h1.fldDocument_HedearId=header.fldid
	inner join[ACC].[tblDocumentType] d on d.fldid=fldTypeSanadId
outer apply(select top 1  h.fldDocumentNum as fldDocumentNum_Pid from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldPId and h.fldId<h1.fldId order by h.fldId desc )Doc_Pid
outer apply(select top 1  h.fldTypeSanadId as fldTypeSanadId_Pid from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldId  order by h.fldId desc )Typesanad
outer apply(select (select top(1)  N'مرجوع شده (مرتبه ' +cast( ROW_NUMBER() over (order by h.fldid) as varchar(10))+')' from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldId and h.fldTypeSanadId=3 order by h.fldid desc) as fldTypeSanadId_Pid) sanadName
outer APPLY(select top(1) 1 as fldFlag
			FROM   [ACC].[tblDocumentRecord_Details] as d
			inner join acc.tblDocumentRecord_Header as h on h.fldId=d.fldDocument_HedearId
			inner join acc.[tblArtiklMap] as a on a.fldDocumentRecord_DetailsId=d.fldId
			WHERE   fldDocument_HedearId=header.fldId  
			and (fldDocument_HedearId1=h1.fldId
			 or (not exists(select * from Acc.tblDocumentRecord_Details as d2 where d2.fldDocument_HedearId1=h1.fldId ) and fldDocument_HedearId1 is null )) ) flag
left join com.tblModule m on m.fldid=fldModuleErsalId
	where header.fldOrganId=@fldOrganId and fldModuleSaveId=@fldMadule and f.fldYear=@fldYear and header.fldId<>@Value
	order by fldTarikhDocument DESC
    


	if (@fieldname=N'fldAzTarikh_TaTarikhDoc')
	BEGIN
    IF (@Value='')
		SELECT top(@h) h1.[fldId], [fldDocumentNum],cast(atf as int ) [fldAtfNum], [fldArchiveNum], [fldDescriptionDocu],header.[fldOrganId] ,[fldTarikhDocument],header.[fldDesc], header.[fldDate], header.[fldIP], header.[fldUserId],[fldAccept] 
	,fldType,case when fldType=1 and fldaccept=1 then N'قطعی' when fldType=1 and fldaccept=0 then N'موقت' when fldType=2 then N'یادداشت' end as fldTypeName
	,cast(ShomareRoozane as int)ShomareRoozane,fldShomareFaree,f.fldYear,fldFiscalYearId
	,fldTypeSanadId as fldTypeSanad ,d.fldName    as fldTypeSanadName,m.fldTitle as fldNameModule,fldModuleErsalId,isnull(fldExistsFile,cast(0 as bit))fldIsArchive
	,case when h1.fldPId is null or fldTypeSanadId<>3 then 0 else Doc_Pid.fldDocumentNum_Pid end fldDocumentNum_Pid,isnull(h1.fldPId,0)fldPId,case when Typesanad.fldTypeSanadId_Pid is null then N'ارسال نشده' when Typesanad.fldTypeSanadId_Pid<>3 then N'ارسال شده' else sanadName.fldTypeSanadId_Pid end fldTypeSanadName_Pid
	,case when fldModuleErsalId in (5,12,13) then ACC.fn_GetSourceId(fldModuleErsalId,header.fldId) when fldPId is null  or fldModuleErsalId=fldModuleSaveId then fldDocumentNum  else (select h.fldDocumentNum from acc.tblDocumentRecord_Header1 as h where h1.fldPId=h.fldid) end fldMainDocNum,isnull(flag.fldFlag,0) as fldFlag, ACC.fn_GetArtiklMap( header.fldId, h1.fldId,h1.fldModuleErsalId) as fldIsMap,fldEdit,case when fldModuleErsalId in(12,13) then ACC.[fn_GetCaseTypeId](fldModuleErsalId,header.fldId) else 0 end as fldCaseTypeId
	FROM   [ACC].[tblDocumentRecord_Header] header inner join acc.tblFiscalYear f on header.fldFiscalYearId=f.fldid
	inner join acc.tblDocumentRecord_Header1 as h1 on h1.fldDocument_HedearId=header.fldid
	inner join[ACC].[tblDocumentType] d on d.fldid=fldTypeSanadId
	left join com.tblModule m on m.fldid=fldModuleErsalId
	outer Apply(
				select atf from (select row_number()over (order by h2.fldId) atf,h2.fldid   
				from acc.tblDocumentRecord_Header h
				inner join acc.tblFiscalYear f1 on h.fldFiscalYearId=f1.fldid
				inner join acc.tblDocumentRecord_Header1 as h2 on h2.fldDocument_HedearId=h.fldid
				where h.fldOrganId=header.fldOrganId and f1.fldYear=f.fldYear 
					and h2.fldModuleSaveId=h1.fldModuleSaveId and fldDocumentNum <>0
					)t where t.fldid=h1.fldid)atfNum

	outer apply (select ShomareRoozane from (select row_number()over (order by h2.fldDate) ShomareRoozane,h2.fldid  
				from acc.tblDocumentRecord_Header h
				inner join acc.tblFiscalYear f1 on h.fldFiscalYearId=f1.fldid
				inner join acc.tblDocumentRecord_Header1 as h2 on h2.fldDocument_HedearId=h.fldid
				where h.fldOrganId=header.fldOrganId and f1.fldYear=f.fldYear 
					and h2.fldModuleSaveId=h1.fldModuleSaveId and cast(h2.fldDate as date)=cast(h1.fldDate as date) 	
					and fldDocumentNum <>0)t where t.fldid=h1.fldid)Roozane

	outer apply(select top(1) cast(1 as bit)fldExistsFile from acc.tblDocumentRecorde_File where fldDocumentHeaderId=header.fldid)Doc_File
	cross apply(select max(fldDate) as maxDate from
			(select max(h.fldDate) fldDate from acc.tblDocumentRecord_Header1 as h where h.fldId=h1.fldId
			union all
			select max(l.fldDate) fldDate from acc.tblDocument_HeaderLog as L where l.fldHeaderId =h1.fldId
			union all
			select max(f.fldDate) fldDate from acc.tblDocumentRecorde_File as f where f.fldDocumentHeaderId=header.fldId
			union all
			select max(b.fldDate) fldDate from acc.tblDocumentRecorde_File as f 
			inner join acc.tblDocumentBookMark as b on b.fldDocumentRecordeId=f.fldId
			where f.fldDocumentHeaderId=header.fldId)t)md
outer apply(select top 1  h.fldDocumentNum as fldDocumentNum_Pid from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldPId and h.fldId<h1.fldId order by h.fldId desc )Doc_Pid
outer apply(select top 1  h.fldTypeSanadId as fldTypeSanadId_Pid from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldId  order by h.fldId desc )Typesanad
outer apply(select (select top(1)  N'مرجوع شده (مرتبه ' +cast( ROW_NUMBER() over (order by h.fldid) as varchar(10))+')' from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldId and h.fldTypeSanadId=3 order by h.fldid desc) as fldTypeSanadId_Pid) sanadName
outer APPLY(select top(1) 1 as fldFlag
			FROM   [ACC].[tblDocumentRecord_Details] as d
			inner join acc.tblDocumentRecord_Header as h on h.fldId=d.fldDocument_HedearId
			inner join acc.[tblArtiklMap] as a on a.fldDocumentRecord_DetailsId=d.fldId
			WHERE   fldDocument_HedearId=header.fldId  
			and (fldDocument_HedearId1=h1.fldId
			 or (not exists(select * from Acc.tblDocumentRecord_Details as d2 where d2.fldDocument_HedearId1=h1.fldId ) and fldDocument_HedearId1 is null )) ) flag
WHERE header.fldOrganId=@fldOrganId  /*and f.fldYear=@fldYear */and h1.fldModuleSaveId=@fldMadule
AND h1.fldTarikhDocument BETWEEN @value1 AND @value2 AND h1.fldDocumentNum<>0
	--order by fldTarikhDocument,case when fldDocumentNum=0 then 1 else 0 end ,fldDocumentNum
	order by fldDocumentNum desc
    
 else
		SELECT top(@h) h1.[fldId], [fldDocumentNum],cast(atf as int ) [fldAtfNum], [fldArchiveNum], [fldDescriptionDocu],header.[fldOrganId] ,[fldTarikhDocument],header.[fldDesc], header.[fldDate], header.[fldIP], header.[fldUserId],[fldAccept] 
	,fldType,case when fldType=1 and fldaccept=1 then N'قطعی' when fldType=1 and fldaccept=0 then N'موقت' when fldType=2 then N'یادداشت' end as fldTypeName
	,cast(ShomareRoozane as int)ShomareRoozane,fldShomareFaree,f.fldYear,fldFiscalYearId
	,fldTypeSanadId as fldTypeSanad ,d.fldName    as fldTypeSanadName,m.fldTitle as fldNameModule,fldModuleErsalId,isnull(fldExistsFile,cast(0 as bit))fldIsArchive
	,case when h1.fldPId is null or fldTypeSanadId<>3 then 0 else Doc_Pid.fldDocumentNum_Pid end fldDocumentNum_Pid,isnull(h1.fldPId,0)fldPId,case when Typesanad.fldTypeSanadId_Pid is null then N'ارسال نشده' when Typesanad.fldTypeSanadId_Pid<>3 then N'ارسال شده' else sanadName.fldTypeSanadId_Pid end fldTypeSanadName_Pid
	,case when fldModuleErsalId in (5,12,13) then ACC.fn_GetSourceId(fldModuleErsalId,header.fldId) when fldPId is null  or fldModuleErsalId=fldModuleSaveId then fldDocumentNum  else (select h.fldDocumentNum from acc.tblDocumentRecord_Header1 as h where h1.fldPId=h.fldid) end fldMainDocNum,isnull(flag.fldFlag,0) as fldFlag, ACC.fn_GetArtiklMap( header.fldId, h1.fldId,h1.fldModuleErsalId) as fldIsMap,fldEdit,case when fldModuleErsalId in(12,13) then ACC.[fn_GetCaseTypeId](fldModuleErsalId,header.fldId) else 0 end as fldCaseTypeId
	FROM   [ACC].[tblDocumentRecord_Header] header inner join acc.tblFiscalYear f on header.fldFiscalYearId=f.fldid
	inner join acc.tblDocumentRecord_Header1 as h1 on h1.fldDocument_HedearId=header.fldid
	inner join[ACC].[tblDocumentType] d on d.fldid=fldTypeSanadId
	left join com.tblModule m on m.fldid=fldModuleErsalId
	outer Apply(
				select atf from (select row_number()over (order by h2.fldId) atf,h2.fldid   
				from acc.tblDocumentRecord_Header h
				inner join acc.tblFiscalYear f1 on h.fldFiscalYearId=f1.fldid
				inner join acc.tblDocumentRecord_Header1 as h2 on h2.fldDocument_HedearId=h.fldid
				where h.fldOrganId=header.fldOrganId and f1.fldYear=f.fldYear 
					and h2.fldModuleSaveId=h1.fldModuleSaveId and fldDocumentNum <>0
					)t where t.fldid=h1.fldid)atfNum

	outer apply (select ShomareRoozane from (select row_number()over (order by h2.fldDate) ShomareRoozane,h2.fldid  
				from acc.tblDocumentRecord_Header h
				inner join acc.tblFiscalYear f1 on h.fldFiscalYearId=f1.fldid
				inner join acc.tblDocumentRecord_Header1 as h2 on h2.fldDocument_HedearId=h.fldid
				where h.fldOrganId=header.fldOrganId and f1.fldYear=f.fldYear 
					and h2.fldModuleSaveId=h1.fldModuleSaveId and cast(h2.fldDate as date)=cast(h1.fldDate as date) 	
					and fldDocumentNum <>0)t where t.fldid=h1.fldid)Roozane

	outer apply(select top(1) cast(1 as bit)fldExistsFile from acc.tblDocumentRecorde_File where fldDocumentHeaderId=header.fldid)Doc_File
	cross apply(select max(fldDate) as maxDate from
			(select max(h.fldDate) fldDate from acc.tblDocumentRecord_Header1 as h where h.fldId=h1.fldId
			union all
			select max(l.fldDate) fldDate from acc.tblDocument_HeaderLog as L where l.fldHeaderId =h1.fldId
			union all
			select max(f.fldDate) fldDate from acc.tblDocumentRecorde_File as f where f.fldDocumentHeaderId=header.fldId
			union all
			select max(b.fldDate) fldDate from acc.tblDocumentRecorde_File as f 
			inner join acc.tblDocumentBookMark as b on b.fldDocumentRecordeId=f.fldId
			where f.fldDocumentHeaderId=header.fldId)t)md
outer apply(select top 1  h.fldDocumentNum as fldDocumentNum_Pid from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldPId and h.fldId<h1.fldId order by h.fldId desc )Doc_Pid
outer apply(select top 1  h.fldTypeSanadId as fldTypeSanadId_Pid from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldId  order by h.fldId desc )Typesanad
outer apply(select (select top(1)  N'مرجوع شده (مرتبه ' +cast( ROW_NUMBER() over (order by h.fldid) as varchar(10))+')' from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldId and h.fldTypeSanadId=3 order by h.fldid desc) as fldTypeSanadId_Pid) sanadName
CROSS APPLY(SELECT hh.fldDocumentNum t_Doc FROM acc.tblDocumentRecord_Header1 hh WHERE hh.fldId=@Value)TarikhSanad
outer APPLY(select top(1) 1 as fldFlag
			FROM   [ACC].[tblDocumentRecord_Details] as d
			inner join acc.tblDocumentRecord_Header as h on h.fldId=d.fldDocument_HedearId
			inner join acc.[tblArtiklMap] as a on a.fldDocumentRecord_DetailsId=d.fldId
			WHERE   fldDocument_HedearId=header.fldId  
			and (fldDocument_HedearId1=h1.fldId
			 or (not exists(select * from Acc.tblDocumentRecord_Details as d2 where d2.fldDocument_HedearId1=h1.fldId ) and fldDocument_HedearId1 is null )) ) flag
WHERE header.fldOrganId=@fldOrganId  /*and f.fldYear=@fldYear*/ and h1.fldModuleSaveId=@fldMadule
AND h1.fldTarikhDocument BETWEEN @value1 AND @value2 AND h1.fldDocumentNum  >=TarikhSanad.t_Doc
AND h1.fldDocumentNum<>0
	--order by fldTarikhDocument,case when fldDocumentNum=0 then 1 else 0 end ,fldDocumentNum
	order by fldDocumentNum desc


END

if (@fieldname=N'fldAzMah_TaMahDoc')
	BEGIN
    IF (@Value='')
		SELECT top(@h) h1.[fldId], [fldDocumentNum],cast(atf as int ) [fldAtfNum], [fldArchiveNum], [fldDescriptionDocu],header.[fldOrganId] ,[fldTarikhDocument],header.[fldDesc], header.[fldDate], header.[fldIP], header.[fldUserId],[fldAccept] 
	,fldType,case when fldType=1 and fldaccept=1 then N'قطعی' when fldType=1 and fldaccept=0 then N'موقت' when fldType=2 then N'یادداشت' end as fldTypeName
	,cast(ShomareRoozane as int)ShomareRoozane,fldShomareFaree,f.fldYear,fldFiscalYearId
	,fldTypeSanadId as fldTypeSanad ,d.fldName    as fldTypeSanadName,m.fldTitle as fldNameModule,fldModuleErsalId,isnull(fldExistsFile,cast(0 as bit))fldIsArchive
	,case when h1.fldPId is null or fldTypeSanadId<>3 then 0 else Doc_Pid.fldDocumentNum_Pid end fldDocumentNum_Pid,isnull(h1.fldPId,0)fldPId,case when Typesanad.fldTypeSanadId_Pid is null then N'ارسال نشده' when Typesanad.fldTypeSanadId_Pid<>3 then N'ارسال شده' else sanadName.fldTypeSanadId_Pid end fldTypeSanadName_Pid
	,case when fldModuleErsalId in (5,12,13) then ACC.fn_GetSourceId(fldModuleErsalId,header.fldId) when fldPId is null  or fldModuleErsalId=fldModuleSaveId then fldDocumentNum  else (select h.fldDocumentNum from acc.tblDocumentRecord_Header1 as h where h1.fldPId=h.fldid) end fldMainDocNum,isnull(flag.fldFlag,0) as fldFlag, ACC.fn_GetArtiklMap( header.fldId, h1.fldId,h1.fldModuleErsalId) as fldIsMap,fldEdit,case when fldModuleErsalId in(12,13) then ACC.[fn_GetCaseTypeId](fldModuleErsalId,header.fldId) else 0 end as fldCaseTypeId
	FROM   [ACC].[tblDocumentRecord_Header] header inner join acc.tblFiscalYear f on header.fldFiscalYearId=f.fldid
	inner join acc.tblDocumentRecord_Header1 as h1 on h1.fldDocument_HedearId=header.fldid
	inner join[ACC].[tblDocumentType] d on d.fldid=fldTypeSanadId
	left join com.tblModule m on m.fldid=fldModuleErsalId
	outer Apply(
				select atf from (select row_number()over (order by h2.fldId) atf,h2.fldid   
				from acc.tblDocumentRecord_Header h
				inner join acc.tblFiscalYear f1 on h.fldFiscalYearId=f1.fldid
				inner join acc.tblDocumentRecord_Header1 as h2 on h2.fldDocument_HedearId=h.fldid
				where h.fldOrganId=header.fldOrganId and f1.fldYear=f.fldYear 
					and h2.fldModuleSaveId=h1.fldModuleSaveId and fldDocumentNum <>0
					)t where t.fldid=h1.fldid)atfNum

	outer apply (select ShomareRoozane from (select row_number()over (order by h2.fldDate) ShomareRoozane,h2.fldid  
				from acc.tblDocumentRecord_Header h
				inner join acc.tblFiscalYear f1 on h.fldFiscalYearId=f1.fldid
				inner join acc.tblDocumentRecord_Header1 as h2 on h2.fldDocument_HedearId=h.fldid
				where h.fldOrganId=header.fldOrganId and f1.fldYear=f.fldYear 
					and h2.fldModuleSaveId=h1.fldModuleSaveId and cast(h2.fldDate as date)=cast(h1.fldDate as date) 	
					and fldDocumentNum <>0)t where t.fldid=h1.fldid)Roozane

	outer apply(select top(1) cast(1 as bit)fldExistsFile from acc.tblDocumentRecorde_File where fldDocumentHeaderId=header.fldid)Doc_File
	cross apply(select max(fldDate) as maxDate from
			(select max(h.fldDate) fldDate from acc.tblDocumentRecord_Header1 as h where h.fldId=h1.fldId
			union all
			select max(l.fldDate) fldDate from acc.tblDocument_HeaderLog as L where l.fldHeaderId =h1.fldId
			union all
			select max(f.fldDate) fldDate from acc.tblDocumentRecorde_File as f where f.fldDocumentHeaderId=header.fldId
			union all
			select max(b.fldDate) fldDate from acc.tblDocumentRecorde_File as f 
			inner join acc.tblDocumentBookMark as b on b.fldDocumentRecordeId=f.fldId
			where f.fldDocumentHeaderId=header.fldId)t)md
outer apply(select top 1  h.fldDocumentNum as fldDocumentNum_Pid from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldPId and h.fldId<h1.fldId order by h.fldId desc )Doc_Pid
outer apply(select top 1  h.fldTypeSanadId as fldTypeSanadId_Pid from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldId  order by h.fldId desc )Typesanad
outer apply(select (select top(1)  N'مرجوع شده (مرتبه ' +cast( ROW_NUMBER() over (order by h.fldid) as varchar(10))+')' from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldId and h.fldTypeSanadId=3 order by h.fldid desc) as fldTypeSanadId_Pid) sanadName
outer APPLY(select top(1) 1 as fldFlag
			FROM   [ACC].[tblDocumentRecord_Details] as d
			inner join acc.tblDocumentRecord_Header as h on h.fldId=d.fldDocument_HedearId
			inner join acc.[tblArtiklMap] as a on a.fldDocumentRecord_DetailsId=d.fldId
			WHERE   fldDocument_HedearId=header.fldId  
			and (fldDocument_HedearId1=h1.fldId
			 or (not exists(select * from Acc.tblDocumentRecord_Details as d2 where d2.fldDocument_HedearId1=h1.fldId ) and fldDocument_HedearId1 is null )) ) flag
WHERE header.fldOrganId=@fldOrganId  and f.fldYear=@fldYear and h1.fldModuleSaveId=@fldMadule
AND SUBSTRING(h1.fldTarikhDocument,6,2) BETWEEN @value1 AND @value2 AND h1.fldDocumentNum<>0
	--order by fldTarikhDocument,case when fldDocumentNum=0 then 1 else 0 end ,fldDocumentNum
	order by fldDocumentNum desc
    
 else
		SELECT top(@h) h1.[fldId], [fldDocumentNum],cast(atf as int ) [fldAtfNum], [fldArchiveNum], [fldDescriptionDocu],header.[fldOrganId] ,[fldTarikhDocument],header.[fldDesc], header.[fldDate], header.[fldIP], header.[fldUserId],[fldAccept] 
	,fldType,case when fldType=1 and fldaccept=1 then N'قطعی' when fldType=1 and fldaccept=0 then N'موقت' when fldType=2 then N'یادداشت' end as fldTypeName
	,cast(ShomareRoozane as int)ShomareRoozane,fldShomareFaree,f.fldYear,fldFiscalYearId
	,fldTypeSanadId as fldTypeSanad ,d.fldName    as fldTypeSanadName,m.fldTitle as fldNameModule,fldModuleErsalId,isnull(fldExistsFile,cast(0 as bit))fldIsArchive
	,case when h1.fldPId is null or fldTypeSanadId<>3 then 0 else Doc_Pid.fldDocumentNum_Pid end fldDocumentNum_Pid,isnull(h1.fldPId,0)fldPId,case when Typesanad.fldTypeSanadId_Pid is null then N'ارسال نشده' when Typesanad.fldTypeSanadId_Pid<>3 then N'ارسال شده' else sanadName.fldTypeSanadId_Pid end fldTypeSanadName_Pid
	,case when fldModuleErsalId in (5,12,13) then ACC.fn_GetSourceId(fldModuleErsalId,header.fldId) when fldPId is null  or fldModuleErsalId=fldModuleSaveId then fldDocumentNum  else (select h.fldDocumentNum from acc.tblDocumentRecord_Header1 as h where h1.fldPId=h.fldid) end fldMainDocNum,isnull(flag.fldFlag,0) as fldFlag, ACC.fn_GetArtiklMap( header.fldId, h1.fldId,h1.fldModuleErsalId) as fldIsMap,fldEdit,case when fldModuleErsalId in(12,13) then ACC.[fn_GetCaseTypeId](fldModuleErsalId,header.fldId) else 0 end as fldCaseTypeId
	FROM   [ACC].[tblDocumentRecord_Header] header inner join acc.tblFiscalYear f on header.fldFiscalYearId=f.fldid
	inner join acc.tblDocumentRecord_Header1 as h1 on h1.fldDocument_HedearId=header.fldid
	inner join[ACC].[tblDocumentType] d on d.fldid=fldTypeSanadId
	left join com.tblModule m on m.fldid=fldModuleErsalId
	outer Apply(
				select atf from (select row_number()over (order by h2.fldId) atf,h2.fldid   
				from acc.tblDocumentRecord_Header h
				inner join acc.tblFiscalYear f1 on h.fldFiscalYearId=f1.fldid
				inner join acc.tblDocumentRecord_Header1 as h2 on h2.fldDocument_HedearId=h.fldid
				where h.fldOrganId=header.fldOrganId and f1.fldYear=f.fldYear 
					and h2.fldModuleSaveId=h1.fldModuleSaveId and fldDocumentNum <>0
					)t where t.fldid=h1.fldid)atfNum

	outer apply (select ShomareRoozane from (select row_number()over (order by h2.fldDate) ShomareRoozane,h2.fldid  
				from acc.tblDocumentRecord_Header h
				inner join acc.tblFiscalYear f1 on h.fldFiscalYearId=f1.fldid
				inner join acc.tblDocumentRecord_Header1 as h2 on h2.fldDocument_HedearId=h.fldid
				where h.fldOrganId=header.fldOrganId and f1.fldYear=f.fldYear 
					and h2.fldModuleSaveId=h1.fldModuleSaveId and cast(h2.fldDate as date)=cast(h1.fldDate as date) 	
					and fldDocumentNum <>0)t where t.fldid=h1.fldid)Roozane

	outer apply(select top(1) cast(1 as bit)fldExistsFile from acc.tblDocumentRecorde_File where fldDocumentHeaderId=header.fldid)Doc_File
	cross apply(select max(fldDate) as maxDate from
			(select max(h.fldDate) fldDate from acc.tblDocumentRecord_Header1 as h where h.fldId=h1.fldId
			union all
			select max(l.fldDate) fldDate from acc.tblDocument_HeaderLog as L where l.fldHeaderId =h1.fldId
			union all
			select max(f.fldDate) fldDate from acc.tblDocumentRecorde_File as f where f.fldDocumentHeaderId=header.fldId
			union all
			select max(b.fldDate) fldDate from acc.tblDocumentRecorde_File as f 
			inner join acc.tblDocumentBookMark as b on b.fldDocumentRecordeId=f.fldId
			where f.fldDocumentHeaderId=header.fldId)t)md
outer apply(select top 1  h.fldDocumentNum as fldDocumentNum_Pid from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldPId and h.fldId<h1.fldId order by h.fldId desc )Doc_Pid
outer apply(select top 1  h.fldTypeSanadId as fldTypeSanadId_Pid from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldId  order by h.fldId desc )Typesanad
outer apply(select (select top(1)  N'مرجوع شده (مرتبه ' +cast( ROW_NUMBER() over (order by h.fldid) as varchar(10))+')' from acc.tblDocumentRecord_Header1 as h where h.fldPId=h1.fldId and h.fldTypeSanadId=3 order by h.fldid desc) as fldTypeSanadId_Pid) sanadName
CROSS APPLY(SELECT hh.fldDocumentNum T_doc FROM acc.tblDocumentRecord_Header1 hh WHERE hh.fldid=@Value)TarikhSanad
outer APPLY(select top(1) 1 as fldFlag
			FROM   [ACC].[tblDocumentRecord_Details] as d
			inner join acc.tblDocumentRecord_Header as h on h.fldId=d.fldDocument_HedearId
			inner join acc.[tblArtiklMap] as a on a.fldDocumentRecord_DetailsId=d.fldId
			WHERE   fldDocument_HedearId=header.fldId  
			and (fldDocument_HedearId1=h1.fldId
			 or (not exists(select * from Acc.tblDocumentRecord_Details as d2 where d2.fldDocument_HedearId1=h1.fldId ) and fldDocument_HedearId1 is null )) ) flag
WHERE header.fldOrganId=@fldOrganId  and f.fldYear=@fldYear and h1.fldModuleSaveId=@fldMadule
AND  SUBSTRING(h1.fldTarikhDocument,6,2) BETWEEN @value1 AND @value2 AND h1.fldDocumentNum  >=TarikhSanad.T_doc
AND h1.fldDocumentNum<>0
	--order by fldTarikhDocument,case when fldDocumentNum=0 then 1 else 0 end ,fldDocumentNum
	order by fldDocumentNum desc


end


end 
	COMMIT
GO
