SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [ACC].[spr_LastNum_AtfDocumentRecord] 

@fldYear SMALLINT,
@fldOrganId INT ,
@ModuleDocId int

AS 
BEGIN 
--declare @fldYear SMALLINT=1404,
--@fldOrganId INT =1,
--@ModuleDocId int=4
--SELECT TOP(1) fldAtfNum,fldDocumentNum FROM ACC.tblDocumentRecord_Header
--ORDER BY fldId DESC


--SELECT ISNULL(MAX(atf),0) +1 AS AtfNum,ISNULL(MAX(cast(fldDocumentNum as int)),0)+1 AS fldDocumentNum,isnull(max(cast(ShomareRoozane as int)),0)+1 ShomareRoozane

--FROM ACC.tblDocumentRecord_Header INNER JOIN 
--ACC.tblDocumentRecord_Details ON tblDocumentRecord_Details.fldDocument_HedearId = tblDocumentRecord_Header.fldId INNER JOIN 
--ACC.tblCoding_Details ON tblCoding_Details.fldId = tblDocumentRecord_Details.fldCodingId INNER JOIN 
--ACC.tblCoding_Header ON tblCoding_Header.fldId = tblCoding_Details.fldHeaderCodId 
--cross apply (select cast(row_number()over (order by fldId) as int) atf from acc.tblDocumentRecord_Header h
--			WHERE ACC.tblCoding_Header.fldYear=@fldYear AND tblCoding_Header.fldOrganId=@fldOrganId
-- and fldModuleSaveId=@ModuleDocId)atfName

-- cross apply (select ShomareRoozane from (select row_number()over (order by h.fldDate) ShomareRoozane,fldid  from acc.tblDocumentRecord_Header h
--				where h.fldOrganId=[tblDocumentRecord_Header].fldOrganId and h.fldYear=[tblDocumentRecord_Header].fldYear 
--					and h.fldModuleSaveId=[tblDocumentRecord_Header].fldModuleSaveId and h.fldTarikhDocument=[tblDocumentRecord_Header].fldTarikhDocument	
--					)t where t.fldid=[tblDocumentRecord_Header].fldid)Roozane
-- WHERE ACC.tblCoding_Header.fldYear=@fldYear AND tblCoding_Header.fldOrganId=@fldOrganId
-- and fldModuleSaveId=@ModuleDocId

  declare @FromDate datetime=cast( (cast( cast(getdate()  as date) as varchar(10)) +' 00:00:00')as datetime)
  ,@ToDate datetime=cast( (cast( cast(getdate()  as date) as varchar(10)) +' 23:59:59')as datetime)
  , @fldDocumentNum int=1, @AtfNum as int=1,@ShomareRoozane int=1
   

   select @AtfNum=max(AtfNum)  from(
   select cast(row_number()over (order by h.fldId) as int) as AtfNum
			from  acc.tblDocumentRecord_Header h 
			inner join acc.tblFiscalYear f on fldFiscalYearId=f.fldid
			 inner join acc.tblDocumentRecord_Header1 as h2 on h2.fldDocument_HedearId=h.fldid
				where h.fldYear=@fldYear and  h.fldOrganId=@fldOrganId 
				and h2.fldModuleSaveId=@ModuleDocId  
				and h2.fldDocumentNum <>0
	)t

select @ShomareRoozane=max(ShomareRoozane)  from(
select row_number()over (order by h.fldid) as ShomareRoozane
			from  acc.tblDocumentRecord_Header h 
			inner join acc.tblFiscalYear f on fldFiscalYearId=f.fldid
			inner join acc.tblDocumentRecord_Header1 as h2 on h2.fldDocument_HedearId=h.fldid
			where h.fldYear=@fldYear and h.fldOrganId=@fldOrganId  
			and cast(h.fldDate as date) between @FromDate and @ToDate
			and h2.fldModuleSaveId=@ModuleDocId and h2.fldDocumentNum <>0 			 
)t


select @fldDocumentNum=ISNULL(MAX(cast(fldDocumentNum as int)),0)+1 
			from  acc.tblDocumentRecord_Header h 
			inner join acc.tblFiscalYear f on fldFiscalYearId=f.fldid
			inner join acc.tblDocumentRecord_Header1 as h2 on h2.fldDocument_HedearId=h.fldid
		where  h.fldYear=@fldYear and h.fldOrganId=@fldOrganId 
and h2.fldModuleSaveId=@ModuleDocId		 

select @fldDocumentNum as fldDocumentNum,isnull(@AtfNum+1,1) as AtfNum  ,isnull(@ShomareRoozane+1,1) as ShomareRoozane

--select ISNULL(MAX(cast(fldDocumentNum as int)),0)+1 AS fldDocumentNum
--,ISNULL(MAX(atf),0) +1 AS AtfNum 
--,isnull(max(cast(ShomareRoozane as int)),0)+1 ShomareRoozane

-- from acc.tblDocumentRecord_Header as Header
-- inner join acc.tblFiscalYear on fldFiscalYearId=tblFiscalYear.fldid
-- inner join acc.tblDocumentRecord_Header1 as h1 on h1.fldDocument_HedearId=Header.fldid
--outer apply (select  cast(row_number()over (order by h.fldId) as int) atf 
--			from  acc.tblDocumentRecord_Header h 
--			inner join acc.tblFiscalYear f on fldFiscalYearId=f.fldid
--			 inner join acc.tblDocumentRecord_Header1 as h2 on h2.fldDocument_HedearId=h.fldid
--				where h.fldYear=@fldYear and  h.fldOrganId=@fldOrganId 
--				and h2.fldModuleSaveId=@ModuleDocId  
--				and h2.fldDocumentNum <>0)a
--outer apply (select row_number()over (order by h.fldid)ShomareRoozane from  acc.tblDocumentRecord_Header h 
--			inner join acc.tblFiscalYear f on fldFiscalYearId=f.fldid
--			inner join acc.tblDocumentRecord_Header1 as h2 on h2.fldDocument_HedearId=h.fldid
--			where h.fldYear=@fldYear and h.fldOrganId=@fldOrganId  
--			and cast(h.fldDate as date) between @FromDate and @ToDate
--			and h2.fldModuleSaveId=@ModuleDocId and h2.fldDocumentNum <>0 			 
--			--and cast(h.fldDate as date)=cast(getdate()  as date)
--			)sh
--where  Header.fldYear=@fldYear and Header.fldOrganId=@fldOrganId 
--and h1.fldModuleSaveId=@ModuleDocId
   
end
GO
