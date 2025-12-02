SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE proc [ACC].[spr_AdvancedSearchDoc]
@condition  nvarchar(max)
as
begin tran
--declare @condition  nvarchar(max)=N''

	declare @Setting varchar(10)='false',@Ghatei nvarchar(10)=N'قطعی',@Movaghat nvarchar(10)=N'موقت',@line nvarchar(10)='_'
	select @Setting=case when fldValue=1 then 'true' else 'false' end from com.tblGeneralSetting_Value  
	where fldGeneralSettingId=3

	declare @q nvarchar(max)='',@q1 nvarchar(max)='',@q2 nvarchar(max)='',@q3 nvarchar(max)=''
	
	set @q1='
	select fldDocumentNum,fldAtfNum,fldArchiveNum,fldShomareFaree,fldTarikhDocument,fldTypeName,fldDescriptionDocu,fldTypeSanadName,fldCode,
   fldDescriptionCoding,fldMablaghJoz,fldBedehkar,fldBestankar,fldNameParvande,fldDescription,fldModuleErsalName,fldBestankarInt,fldOrder,fldOrders
   ,fldDate,fldId,bed_sum,bes_sum,fldCenterCoId,fldNameCenter,case when  bed_sum-bes_sum=0 then 1 else 0 end fldType from(
	select * 
	,sum(fldBedehkar) over(order by fldOrders,fldDate,fldId) as bed_sum,sum(fldBestankarInt)  over(order by fldOrders,fldDate,fldId) as bes_sum
	from(
	select fldDocumentNum,fldAtfNum,fldArchiveNum,fldShomareFaree,fldTarikhDocument,fldTypeName,fldDescriptionDocu,fldTypeSanadName,fldCode,fldDescriptionCoding,fldMablaghJoz
	,fldBedehkar,CHAR(9) +replace(convert(varchar,cast(fldBestankar as money),1), ''.00'','''') as fldBestankar
	,fldNameParvande,case when t.fldBestankar>0 then  CHAR(9) +t.fldDescription else t.fldDescription end  as fldDescription,isnull(m.fldTitle,'''') as fldModuleErsalName
	,fldBestankar as fldBestankarInt,t.fldorder,fldOrders,t.fldDate,t.fldId,isnull(fldCenterCoId,0) as fldCenterCoId,fldNameCenter
	from 
	(
	select h.fldDocumentNum,a.atf as fldAtfNum,isnull(h.fldArchiveNum,'''') as fldArchiveNum,isnull((cast(h.fldShomareFaree as varchar(100))),'''') as fldShomareFaree
	,h.fldModuleErsalId
	,h.fldTarikhDocument,case when fldType=1 and fldaccept=1 then N'''+@Ghatei+''' when fldType=1 and fldaccept=0 then  N'''+@Movaghat+''' end as fldTypeName,
	h.fldDescriptionDocu,dt.fldName as fldTypeSanadName, cd.fldCode,
	case when '''+ @Setting+''' =''true'' then cp.fldTileParent else cd.fldTitle end as fldDescriptionCoding,0 as fldMablaghJoz,d.fldBedehkar
	,d.fldBestankar  as fldBestankar
	,e.fldName+''_''+e.fldFamily+''(''+ed.fldFatherName+'')'' as fldNameParvande
	,d.fldDescription,d.fldorder,case when d.fldBedehkar<>0 then 1 else 2 end as fldOrders,d.fldDate,d.fldId,d.fldCenterCoId,isnull(co.fldNameCenter,N'''') as fldNameCenter
	from acc.tblDocumentRecord_Header as h
	inner join acc.tblDocumentType dt on dt.fldid=fldTypeSanadId
	inner join acc.tblDocumentRecord_Details as d on d.fldDocument_HedearId=h.fldId
	inner join acc.tblCoding_Details as cd on cd.fldId=d.fldCodingId
	inner join acc.tblCase as c on c.fldId=d.fldCaseId
	inner join Com.tblEmployee as e on e.fldId=c.fldSourceId
	inner join com.tblEmployee_Detail as ed on ed.fldEmployeeId=e.fldId
	left join acc.tblCenterCost as co on co.fldId=d.fldCenterCoId
	cross apply(select stuff((select N'''+@line+''' +p.fldTitle  from ACC.tblCoding_Details as p
						inner join ACC.tblCoding_Details as child on child.fldId=cd.fldId 
						where child.fldCodeId.IsDescendantOf(p.fldCodeId)=1  and child.fldHeaderCodId=p.fldHeaderCodId for xml path('''')),1,2,'''') as fldTileParent ) cp
	outer apply (select  cast(row_number()over (order by h2.fldId) as int) atf from  acc.tblDocumentRecord_Header h2 inner join acc.tblFiscalYear f
				on h2.fldFiscalYearId=f.fldid
				where   f.fldYear=h2.fldYear 
				)a
	where  c.fldCaseTypeId=1 
	union all
	select h.fldDocumentNum,aa.atf as fldAtfNum,isnull(h.fldArchiveNum,'''') as fldArchiveNum,isnull((cast(h.fldShomareFaree as varchar(100))),'''') as fldShomareFaree,h.fldModuleErsalId
	,h.fldTarikhDocument,case when fldType=1 and fldaccept=1 then  N'''+@Ghatei+''' when fldType=1 and fldaccept=0 then  N'''+@Movaghat+''' end as fldTypeName,
	h.fldDescriptionDocu,dt.fldName as fldTypeSanadName,cd.fldCode,
	case when '''+ @Setting+'''=''true'' then cp.fldTileParent else cd.fldTitle end as fldDescriptionCoding,0 as fldMablaghJoz,d.fldBedehkar,d.fldBestankar 
	,a.fldName as fldNameParvande,d.fldDescription,d.fldorder,case when d.fldBedehkar<>0 then 1 else 2 end as fldOrders,d.fldDate,d.fldId,d.fldCenterCoId,isnull(co.fldNameCenter,N'''') as fldNameCenter'
	set @q2=' from acc.tblDocumentRecord_Header as h
	inner join acc.tblDocumentType dt on dt.fldid=fldTypeSanadId
	inner join acc.tblDocumentRecord_Details as d on d.fldDocument_HedearId=h.fldId
	inner join acc.tblCoding_Details as cd on cd.fldId=d.fldCodingId
	inner join acc.tblCase as c on c.fldId=d.fldCaseId
	inner join Com.tblAshkhaseHoghoghi as a on a.fldId=c.fldSourceId
	left join acc.tblCenterCost as co on co.fldId=d.fldCenterCoId
	cross apply(select stuff((select N'''+@line+''' +p.fldTitle  from ACC.tblCoding_Details as p
						inner join ACC.tblCoding_Details as child on child.fldId=cd.fldId 
						where child.fldCodeId.IsDescendantOf(p.fldCodeId)=1  and child.fldHeaderCodId=p.fldHeaderCodId for xml path('''')),1,2,'''') as fldTileParent ) cp
	outer apply (select  cast(row_number()over (order by h2.fldId) as int) atf from  acc.tblDocumentRecord_Header h2 inner join acc.tblFiscalYear f 

				on h2.fldFiscalYearId=f.fldid
				where   f.fldYear=h2.fldYear 
				)aa
	where   c.fldCaseTypeId=2 
	union all
	select h.fldDocumentNum,a.atf as fldAtfNum,isnull(h.fldArchiveNum,'''') as fldArchiveNum,isnull((cast(h.fldShomareFaree as varchar(100))),'''') as fldShomareFaree,h.fldModuleErsalId
	,h.fldTarikhDocument,case when fldType=1 and fldaccept=1 then  N'''+@Ghatei+''' when fldType=1 and fldaccept=0 then  N'''+@Movaghat+''' end as fldTypeName,
	h.fldDescriptionDocu,dt.fldName as fldTypeSanadName,cd.fldCode,	case when '''+ @Setting+'''=''true'' then cp.fldTileParent else cd.fldTitle end as fldDescriptionCoding,0 as fldMablaghJoz,d.fldBedehkar,d.fldBestankar 
	,r.fldSubject as fldNameParvande,d.fldDescription,d.fldorder,case when d.fldBedehkar<>0 then 1 else 2 end as fldOrders,d.fldDate,d.fldId,d.fldCenterCoId,isnull(co.fldNameCenter,N'''') as fldNameCenter'
set @q3='	from acc.tblDocumentRecord_Header as h
	inner join acc.tblDocumentType dt on dt.fldid=fldTypeSanadId
	inner join acc.tblDocumentRecord_Details as d on d.fldDocument_HedearId=h.fldId
	inner join acc.tblCoding_Details as cd on cd.fldId=d.fldCodingId
	inner join acc.tblCase as c on c.fldId=d.fldCaseId
	inner join Cntr.tblContracts as r on r.fldId=c.fldSourceId
	left join acc.tblCenterCost as co on co.fldId=d.fldCenterCoId
	cross apply(select stuff((select N'''+@line+''' +p.fldTitle  from ACC.tblCoding_Details as p
						inner join ACC.tblCoding_Details as child on child.fldId=cd.fldId 
						where child.fldCodeId.IsDescendantOf(p.fldCodeId)=1  and child.fldHeaderCodId=p.fldHeaderCodId for xml path('''')),1,2,'''') as fldTileParent ) cp
	outer apply (select  cast(row_number()over (order by h2.fldId) as int) atf from  acc.tblDocumentRecord_Header h2 inner join acc.tblFiscalYear f
				on h2.fldFiscalYearId=f.fldid
				where   f.fldYear=h2.fldYear 
				)a
	where   c.fldCaseTypeId=3
	) t
	left join com.tblModule as m on m.fldId=t.fldModuleErsalId
	union all
	select h.fldDocumentNum,a.atf as fldAtfNum,isnull(h.fldArchiveNum,'''') as fldArchiveNum,isnull((cast(h.fldShomareFaree as varchar(100))),'''') as fldShomareFaree
	,h.fldTarikhDocument,case when fldType=1 and fldaccept=1 then  N'''+@Ghatei+''' when fldType=1 and fldaccept=0 then  N'''+@Movaghat+''' end as fldTypeName,
	h.fldDescriptionDocu,dt.fldName as fldTypeSanadName,cd.fldCode,	case when '''+ @Setting+'''=''true'' then cp.fldTileParent else cd.fldTitle end as fldDescriptionCoding,0 as fldMablaghJoz,d.fldBedehkar
	,CHAR(9) +replace(convert(varchar,cast(fldBestankar as money),1), ''.00'','''')as fldBestankar
	,N'''' as fldNameParvande
	,case when d.fldBestankar>0 then  CHAR(9) +d.fldDescription else d.fldDescription end  as fldDescription,isnull(m.fldTitle,'''') as fldModuleErsalName
	,fldBestankar,d.fldorder,case when d.fldBedehkar<>0 then 1 else 2 end as fldOrders,d.fldDate,d.fldId,d.fldCenterCoId,isnull(co.fldNameCenter,N'''') as fldNameCenter
	from acc.tblDocumentRecord_Header as h
	inner join acc.tblDocumentType dt on dt.fldid=fldTypeSanadId
	inner join acc.tblDocumentRecord_Details as d on d.fldDocument_HedearId=h.fldId 
	inner join acc.tblCoding_Details as cd on cd.fldId=d.fldCodingId
	left join acc.tblCenterCost as co on co.fldId=d.fldCenterCoId
	cross apply(select stuff((select N'''+@line+''' +p.fldTitle  from ACC.tblCoding_Details as p
						inner join ACC.tblCoding_Details as child on child.fldId=cd.fldId 
						where child.fldCodeId.IsDescendantOf(p.fldCodeId)=1  and child.fldHeaderCodId=p.fldHeaderCodId for xml path('''')),1,2,'''') as fldTileParent ) cp
	outer apply (select  cast(row_number()over (order by h2.fldId) as int) atf from  acc.tblDocumentRecord_Header h2 inner join acc.tblFiscalYear f
				on h2.fldFiscalYearId=f.fldid
				where   f.fldYear=h2.fldYear 
				)a
	left join com.tblModule as m on m.fldId=h.fldModuleErsalId
	where   d.fldCaseId is null
	)t2
	)t3
	where 1=1 '+@condition+
	' order by fldorders,flddate,fldId'

	set @q=@q1+@q2+@q3
	--select @q
	  
	execute(@q)

commit tran

   
GO
