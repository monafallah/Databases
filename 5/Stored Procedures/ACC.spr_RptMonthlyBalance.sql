SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE proc [ACC].[spr_RptMonthlyBalance]
 @Level smallint,@Flag bit,@OrganId int,@ModuleSaveId int,@Type tinyint
 ,@AzTarikh varchar(10),@TaTarikh varchar(10),@AzDocumentNum int ,@TaDocumentNum int,@CodingDetailsId int,@SourceId int,@CaseTypeId int
as
begin tran
/*تراز ماهیانه*/

--declare @Level smallint=3,@Flag bit=1,@Org5 SanId int=2,@ModuleSaveId int=4,@Type tinyint=2
--,@AzTarikh varchar(10)='1402/04/01',@TaTarikh varchar(10)='1402/04/31',@AzDocumentNum int=0 ,@TaDocumentNum int=0,@CodingDetailsId int=1090
--,@SourceId int=0,@CaseTypeId int=0
declare  @Month tinyint,@Month_Pre tinyint,@Year smallint,@Year_Pre smallint,@Tarikh_Pre varchar(10)=''
--declare @Parvande table (SourceId int,CaseTypeId int,CodingId int)
declare @Coding table (CodingId int,fldTitle nvarchar(500))
set @Month=SUBSTRING(@TaTarikh,6,2)
set @Month_Pre=@Month-1
set @Year=SUBSTRING(@TaTarikh,1,4)
set @Year_Pre=@Year
if(@Month_Pre=0)
begin
	set @Month_Pre=12
	set @Year_Pre=@Year-1
end
select @Tarikh_Pre=max(fldTarikh) from com.tblDateDim
where fldSal=@Year_Pre and fldMah=@Month_Pre
--select @Tarikh_Pre,@Year_Pre,@Month_Pre
/*insert @Parvande
select distinct fldSourceId,fldCaseTypeId,p.fldId 
from acc.tblCoding_Details  as p
	inner join acc.tblCoding_Header as h on h.fldId=p.fldHeaderCodId
	cross apply(select distinct ca.fldSourceId,ca.fldCaseTypeId,d2.fldId as id,c.fldId as id2
							from acc.tblCoding_Details  as c
							inner join acc.tblDocumentRecord_Details as d2 on d2.fldCodingId=c.fldId
							inner join ACC.tblDocumentRecord_Header as h2 on h2.fldId=d2.fldDocument_HedearId
							inner join acc.tblDocumentRecord_Header1 as h1 on h1.fldDocument_HedearId=h2.fldid
							inner join Acc.tblCase as ca on ca.fldId=d2.fldCaseId
							where c.fldCodeId.IsDescendantOf(p.fldCodeId)=1 and h2.fldYear  in (@Year,@Year_Pre)
							and h2.fldOrganId=@OrganId and h1.fldModuleSaveId=@ModuleSaveId 
							and h1.fldTarikhDocument <= @TaTarikh
							and  (d2.fldDocument_HedearId1=h1.fldid	or (not exists(select * from Acc.tblDocumentRecord_Details as d3 where d3.fldDocument_HedearId1=h1.fldid ) and d2.fldDocument_HedearId1 is null )) 
							and((h1.fldDocumentNum<>0 and @AzDocumentNum=0) or (h1.fldDocumentNum between @AzDocumentNum and @TaDocumentNum))
							--and(@CodingDetailsId=0 or c.fldId=@CodingDetailsId)
							--and h1.fldDocumentNum<>0 
							and (@Type=2 or (@Type<>2 and h1.fldAccept=@Type)) )sum_Date
				where h.fldYear in (@Year,@Year_Pre) and(@CodingDetailsId=0 or p.fldId=@CodingDetailsId)
				and h.fldOrganId=@OrganId /*and h.fldModuleSaveId=@ModuleSaveId and h.fldDocumentNum<>0  and*/
				and p.fldLevelId<=@Level and p.fldLevelId<>0
				--and ((@Flag=0 and p.fldLevelId=@Level ) or (@Flag=1 and p.fldLevelId<=@Level and p.fldLevelId<>0)) 
				*/
if(@CodingDetailsId=0  and @SourceId=0)
begin
select fldLevelId,fldName,fldCode,fldTitle,fldBedehkar_Pre,fldBestankar_Pre,fldBedehkar_Mah,fldBestankar_Mah,fldBedehkar_Date,fldBestankar_Date
		, fldBedehkar
	, fldBestankar from (
	select fldLevelId,fldName,fldCode,fldTitle,fldBedehkar_Pre,fldBestankar_Pre,fldBedehkar_Mah,fldBestankar_Mah,fldBedehkar_Date,fldBestankar_Date
		,case when fldBedehkar_Date-fldBestankar_Date<=0 then 0 else fldBedehkar_Date-fldBestankar_Date end as fldBedehkar
	,case when fldBestankar_Date-fldBedehkar_Date<=0 then 0 else fldBestankar_Date-fldBedehkar_Date end as fldBestankar,fldtype,fldCode as code2
	from(
	select  p.fldLevelId ,
	case when p.fldLevelId=1 then N'گروه' when p.fldLevelId=2 then N'کل' when p.fldLevelId=3 then N'معین' 
	when p.fldLevelId>3 then  N'تفصیلی ' + cast(p.fldLevelId-3 as varchar(5)) else N'' end as fldName
	,p.fldCode,p.fldTitle
	,isnull(sum_pre.fldBedehkar_Pre,0) as fldBedehkar_Pre,isnull(sum_pre.fldBestankar_Pre,0) as fldBestankar_Pre
	,isnull(sum_Mah.fldBedehkar_mah,0) as fldBedehkar_Mah,isnull(sum_Mah.fldBestankar_mah,0) as fldBestankar_Mah
	,isnull(sum_Date.fldBedehkar_Date,0) as fldBedehkar_Date,isnull(sum_Date.fldBestankar_Date,0) as fldBestankar_Date,1 as fldtype
	from acc.tblCoding_Details  as p
	inner join acc.tblCoding_Header as h on h.fldId=p.fldHeaderCodId
				outer apply(select SUM(d2.fldBedehkar) as fldBedehkar_Pre,sum(d2.fldBestankar) as fldBestankar_Pre  
							from acc.tblCoding_Details  as c
							inner join acc.tblDocumentRecord_Details as d2 on d2.fldCodingId=c.fldId
							inner join ACC.tblDocumentRecord_Header as h2 on h2.fldId=d2.fldDocument_HedearId
							inner join acc.tblDocumentRecord_Header1 as h1 on h1.fldDocument_HedearId=h2.fldid
							where /*d2.fldCodingId=d.fldCodingId*/ c.fldCodeId.IsDescendantOf(p.fldCodeId)=1 
							and h2.fldYear=@Year_Pre
							and h2.fldOrganId=@OrganId and h1.fldModuleSaveId=@ModuleSaveId 
							and h1.fldTarikhDocument<=@Tarikh_Pre
							and  (d2.fldDocument_HedearId1=h1.fldid	or (not exists(select * from Acc.tblDocumentRecord_Details as d3 where d3.fldDocument_HedearId1=h1.fldid ) and d2.fldDocument_HedearId1 is null )) 
							and((h1.fldDocumentNum<>0 and @AzDocumentNum=0) or (@AzDocumentNum<>0 and h1.fldDocumentNum between @AzDocumentNum and @TaDocumentNum))
							--and(@CodingDetailsId=0 or c.fldId=@CodingDetailsId)
							--and h1.fldDocumentNum<>0  
							and (@Type=2 or (@Type<>2 and h1.fldAccept=@Type)))sum_pre
				outer apply(select SUM(d2.fldBedehkar) as fldBedehkar_mah,sum(d2.fldBestankar) as fldBestankar_mah  
							from acc.tblCoding_Details  as c
							inner join acc.tblDocumentRecord_Details as d2 on d2.fldCodingId=c.fldId
							inner join ACC.tblDocumentRecord_Header as h2 on h2.fldId=d2.fldDocument_HedearId
							inner join acc.tblDocumentRecord_Header1 as h1 on h1.fldDocument_HedearId=h2.fldid
							where c.fldCodeId.IsDescendantOf(p.fldCodeId)=1 
							--and h2.fldYear=@Year 
							and h2.fldOrganId=@OrganId and h1.fldModuleSaveId=@ModuleSaveId 
							and h1.fldTarikhDocument between @AzTarikh and @TaTarikh
							and  (d2.fldDocument_HedearId1=h1.fldid	or (not exists(select * from Acc.tblDocumentRecord_Details as d3 where d3.fldDocument_HedearId1=h1.fldid ) and d2.fldDocument_HedearId1 is null )) 
							and((h1.fldDocumentNum<>0 and @AzDocumentNum=0) or (@AzDocumentNum<>0 and h1.fldDocumentNum between @AzDocumentNum and @TaDocumentNum))
							--and(@CodingDetailsId=0 or c.fldId=@CodingDetailsId)
							--and h1.fldDocumentNum<>0  
							and (@Type=2 or (@Type<>2 and h1.fldAccept=@Type)))sum_Mah
				outer apply(select SUM(d2.fldBedehkar) as fldBedehkar_Date,sum(d2.fldBestankar) as fldBestankar_Date  
							from acc.tblCoding_Details  as c
							inner join acc.tblDocumentRecord_Details as d2 on d2.fldCodingId=c.fldId
							inner join ACC.tblDocumentRecord_Header as h2 on h2.fldId=d2.fldDocument_HedearId
							inner join acc.tblDocumentRecord_Header1 as h1 on h1.fldDocument_HedearId=h2.fldid
							where c.fldCodeId.IsDescendantOf(p.fldCodeId)=1 and h2.fldYear=@Year 
							and h2.fldOrganId=@OrganId and h1.fldModuleSaveId=@ModuleSaveId 
							and h1.fldTarikhDocument <= @TaTarikh
							and  (d2.fldDocument_HedearId1=h1.fldid	or (not exists(select * from Acc.tblDocumentRecord_Details as d3 where d3.fldDocument_HedearId1=h1.fldid ) and d2.fldDocument_HedearId1 is null )) 
							and((h1.fldDocumentNum<>0 and @AzDocumentNum=0) or (@AzDocumentNum<>0 and h1.fldDocumentNum between @AzDocumentNum and @TaDocumentNum))
							--and(@CodingDetailsId=0 or c.fldId=@CodingDetailsId)
							--and h1.fldDocumentNum<>0 
							and (@Type=2 or (@Type<>2 and h1.fldAccept=@Type)) )sum_Date
				where h.fldYear in (@Year,@Year_Pre) and(@CodingDetailsId=0 or p.fldId=@CodingDetailsId)
				and h.fldOrganId=@OrganId /*and h.fldModuleSaveId=@ModuleSaveId and h.fldDocumentNum<>0  and*/
				and ((@Flag=0 and p.fldLevelId=@Level ) or (@Flag=1 and p.fldLevelId<=@Level and p.fldLevelId<>0)) 
	
				 --and (@Type=2 or (@Type<>2 and h.fldAccept=@Type))
			and (fldBestankar_Pre<>0 or fldBedehkar_Pre<>0 or fldBestankar_mah<>0 or fldBedehkar_mah<>0 or fldBestankar_date<>0 or fldBedehkar_date<>0 )
				)t

		/*union 
		select fldLevelId, 
	case when fldLevelId=1 then N'گروه' when fldLevelId=2 then N'کل' when fldLevelId=3 then N'معین' 
	when fldLevelId>3 then  N'تفصیلی ' + cast(fldLevelId-3 as varchar(5)) else N'' end as fldName,''fldCode,fldTitle,fldBedehkar_Pre,fldBestankar_Pre,fldBedehkar_Mah,fldBestankar_Mah,fldBedehkar_Date,fldBestankar_Date
		,case when fldBedehkar_Date-fldBestankar_Date<=0 then 0 else fldBedehkar_Date-fldBestankar_Date end as fldBedehkar
	,case when fldBestankar_Date-fldBedehkar_Date<=0 then 0 else fldBestankar_Date-fldBedehkar_Date end as fldBestankar,fldtype,fldCode as code2
	
	from(
	select  p.fldLevelId+1 as fldLevelId
	,p.fldCode,Acc.fn_GetParvandeName (pa.CaseTypeId,pa.SourceId ,@OrganId ) as fldTitle 
	,isnull(sum_pre.fldBedehkar_Pre,0) as fldBedehkar_Pre,isnull(sum_pre.fldBestankar_Pre,0) as fldBestankar_Pre
	,isnull(sum_Mah.fldBedehkar_mah,0) as fldBedehkar_Mah,isnull(sum_Mah.fldBestankar_mah,0) as fldBestankar_Mah
	,isnull(sum_Date.fldBedehkar_Date,0) as fldBedehkar_Date,isnull(sum_Date.fldBestankar_Date,0) as fldBestankar_Date,2 as fldtype
	
	from acc.tblCoding_Details  as p
	inner join acc.tblCoding_Header as h on h.fldId=p.fldHeaderCodId
	inner join @Parvande as pa on p.fldId=pa.CodingId
				outer apply(select SUM(d2.fldBedehkar) as fldBedehkar_Pre,sum(d2.fldBestankar) as fldBestankar_Pre 
											from acc.tblCoding_Details  as c
							inner join acc.tblDocumentRecord_Details as d2 on d2.fldCodingId=c.fldId
							inner join ACC.tblDocumentRecord_Header as h2 on h2.fldId=d2.fldDocument_HedearId
							inner join acc.tblDocumentRecord_Header1 as h1 on h1.fldDocument_HedearId=h2.fldid
							inner join acc.tblCase as ca on ca.fldId=d2.fldCaseId
							where /*d2.fldCodingId=d.fldCodingId*/ c.fldCodeId.IsDescendantOf(p.fldCodeId)=1 
							and h2.fldYear=@Year_Pre and ca.fldCaseTypeId=pa.CaseTypeId and ca.fldSourceId=pa.SourceId
							and h2.fldOrganId=@OrganId and h1.fldModuleSaveId=@ModuleSaveId 
							and h1.fldTarikhDocument<=@Tarikh_Pre
							and  (d2.fldDocument_HedearId1=h1.fldid	or (not exists(select * from Acc.tblDocumentRecord_Details as d3 where d3.fldDocument_HedearId1=h1.fldid ) and d2.fldDocument_HedearId1 is null )) 
							and((h1.fldDocumentNum<>0 and @AzDocumentNum=0) or (h1.fldDocumentNum between @AzDocumentNum and @TaDocumentNum))
							--and(@CodingDetailsId=0 or c.fldId=@CodingDetailsId)
							--and h1.fldDocumentNum<>0  
							and (@Type=2 or (@Type<>2 and h1.fldAccept=@Type))
							group by fldSourceId,fldCaseTypeId)sum_pre
				outer apply(select SUM(d2.fldBedehkar) as fldBedehkar_mah,sum(d2.fldBestankar) as fldBestankar_mah  
				
							from acc.tblCoding_Details  as c
							inner join acc.tblDocumentRecord_Details as d2 on d2.fldCodingId=c.fldId
							inner join ACC.tblDocumentRecord_Header as h2 on h2.fldId=d2.fldDocument_HedearId
							inner join acc.tblDocumentRecord_Header1 as h1 on h1.fldDocument_HedearId=h2.fldid
							inner join acc.tblCase as ca on ca.fldId=d2.fldCaseId
							where c.fldCodeId.IsDescendantOf(p.fldCodeId)=1  and ca.fldCaseTypeId=pa.CaseTypeId and ca.fldSourceId=pa.SourceId
							--and h2.fldYear=@Year 
							and h2.fldOrganId=@OrganId and h1.fldModuleSaveId=@ModuleSaveId 
							and h1.fldTarikhDocument between @AzTarikh and @TaTarikh
							and  (d2.fldDocument_HedearId1=h1.fldid	or (not exists(select * from Acc.tblDocumentRecord_Details as d3 where d3.fldDocument_HedearId1=h1.fldid ) and d2.fldDocument_HedearId1 is null )) 
							and((h1.fldDocumentNum<>0 and @AzDocumentNum=0) or (h1.fldDocumentNum between @AzDocumentNum and @TaDocumentNum))
							--and(@CodingDetailsId=0 or c.fldId=@CodingDetailsId)
							--and h1.fldDocumentNum<>0  
							and (@Type=2 or (@Type<>2 and h1.fldAccept=@Type))
							group by fldSourceId,fldCaseTypeId)sum_Mah
				outer apply(select SUM(d2.fldBedehkar) as fldBedehkar_Date,sum(d2.fldBestankar) as fldBestankar_Date 
							from acc.tblCoding_Details  as c
							inner join acc.tblDocumentRecord_Details as d2 on d2.fldCodingId=c.fldId
							inner join ACC.tblDocumentRecord_Header as h2 on h2.fldId=d2.fldDocument_HedearId
							inner join acc.tblDocumentRecord_Header1 as h1 on h1.fldDocument_HedearId=h2.fldid
							inner join acc.tblCase as ca on ca.fldId=d2.fldCaseId
							where c.fldCodeId.IsDescendantOf(p.fldCodeId)=1 and h2.fldYear=@Year  and ca.fldCaseTypeId=pa.CaseTypeId and ca.fldSourceId=pa.SourceId
							and h2.fldOrganId=@OrganId and h1.fldModuleSaveId=@ModuleSaveId 
							and h1.fldTarikhDocument <= @TaTarikh
							and  (d2.fldDocument_HedearId1=h1.fldid	or (not exists(select * from Acc.tblDocumentRecord_Details as d3 where d3.fldDocument_HedearId1=h1.fldid ) and d2.fldDocument_HedearId1 is null )) 
							and((h1.fldDocumentNum<>0 and @AzDocumentNum=0) or (h1.fldDocumentNum between @AzDocumentNum and @TaDocumentNum))
							--and(@CodingDetailsId=0 or c.fldId=@CodingDetailsId)
							--and h1.fldDocumentNum<>0 
							and (@Type=2 or (@Type<>2 and h1.fldAccept=@Type)) 
							group by fldSourceId,fldCaseTypeId)sum_Date

				where h.fldYear in (@Year,@Year_Pre) and(@CodingDetailsId=0 or p.fldId=@CodingDetailsId)
				and h.fldOrganId=@OrganId /*and h.fldModuleSaveId=@ModuleSaveId and h.fldDocumentNum<>0  and*/
				--and ((@Flag=0 and p.fldLevelId=@Level ) or (@Flag=1 and p.fldLevelId<=@Level and p.fldLevelId<>0)) 
				and p.fldLevelId<=@Level and p.fldLevelId<>0
				and exists(select * from acc.tblDocumentRecord_Details where fldCodingId= p.fldId)
				 --and (@Type=2 or (@Type<>2 and h.fldAccept=@Type))
			and (fldBestankar_Pre<>0 or fldBedehkar_Pre<>0 or fldBestankar_mah<>0 or fldBedehkar_mah<>0 or fldBestankar_date<>0 or fldBedehkar_date<>0 )
				)t*/
				
				)t2
	order by code2,fldtype
end
else if (@Flag=0 and @SourceId=0)
begin
select fldLevelId,fldName,fldCode,fldTitle,fldBedehkar_Pre,fldBestankar_Pre,fldBedehkar_Mah,fldBestankar_Mah,fldBedehkar_Date,fldBestankar_Date
		, fldBedehkar
	, fldBestankar from (
	select fldLevelId,fldName,fldCode,fldTitle,fldBedehkar_Pre,fldBestankar_Pre,fldBedehkar_Mah,fldBestankar_Mah,fldBedehkar_Date,fldBestankar_Date
		,case when fldBedehkar_Date-fldBestankar_Date<=0 then 0 else fldBedehkar_Date-fldBestankar_Date end as fldBedehkar
	,case when fldBestankar_Date-fldBedehkar_Date<=0 then 0 else fldBestankar_Date-fldBedehkar_Date end as fldBestankar,fldtype,fldCode as code2
	from(
	select  p.fldLevelId ,
	case when p.fldLevelId=1 then N'گروه' when p.fldLevelId=2 then N'کل' when p.fldLevelId=3 then N'معین' 
	when p.fldLevelId>3 then  N'تفصیلی ' + cast(p.fldLevelId-3 as varchar(5)) else N'' end as fldName
	,p.fldCode,p.fldTitle
	,isnull(sum_pre.fldBedehkar_Pre,0) as fldBedehkar_Pre,isnull(sum_pre.fldBestankar_Pre,0) as fldBestankar_Pre
	,isnull(sum_Mah.fldBedehkar_mah,0) as fldBedehkar_Mah,isnull(sum_Mah.fldBestankar_mah,0) as fldBestankar_Mah
	,isnull(sum_Date.fldBedehkar_Date,0) as fldBedehkar_Date,isnull(sum_Date.fldBestankar_Date,0) as fldBestankar_Date,1 as fldtype
	from acc.tblCoding_Details  as p
	inner join acc.tblCoding_Header as h on h.fldId=p.fldHeaderCodId
				outer apply(select SUM(d2.fldBedehkar) as fldBedehkar_Pre,sum(d2.fldBestankar) as fldBestankar_Pre  
							from acc.tblCoding_Details  as c
							inner join acc.tblDocumentRecord_Details as d2 on d2.fldCodingId=c.fldId
							inner join ACC.tblDocumentRecord_Header as h2 on h2.fldId=d2.fldDocument_HedearId
							inner join acc.tblDocumentRecord_Header1 as h1 on h1.fldDocument_HedearId=h2.fldid
							where  c.fldCodeId.IsDescendantOf(p.fldCodeId)=1 
							and h2.fldYear=@Year_Pre
							and h2.fldOrganId=@OrganId and h1.fldModuleSaveId=@ModuleSaveId 
							and h1.fldTarikhDocument<=@Tarikh_Pre
							and  (d2.fldDocument_HedearId1=h1.fldid	or (not exists(select * from Acc.tblDocumentRecord_Details as d3 where d3.fldDocument_HedearId1=h1.fldid ) and d2.fldDocument_HedearId1 is null )) 
							and((h1.fldDocumentNum<>0 and @AzDocumentNum=0) or (@AzDocumentNum<>0 and h1.fldDocumentNum between @AzDocumentNum and @TaDocumentNum))
							and (@Type=2 or (@Type<>2 and h1.fldAccept=@Type)))sum_pre
				outer apply(select SUM(d2.fldBedehkar) as fldBedehkar_mah,sum(d2.fldBestankar) as fldBestankar_mah  
							from acc.tblCoding_Details  as c
							inner join acc.tblDocumentRecord_Details as d2 on d2.fldCodingId=c.fldId
							inner join ACC.tblDocumentRecord_Header as h2 on h2.fldId=d2.fldDocument_HedearId
							inner join acc.tblDocumentRecord_Header1 as h1 on h1.fldDocument_HedearId=h2.fldid
							where c.fldCodeId.IsDescendantOf(p.fldCodeId)=1 
							and h2.fldOrganId=@OrganId and h1.fldModuleSaveId=@ModuleSaveId 
							and h1.fldTarikhDocument between @AzTarikh and @TaTarikh
							and  (d2.fldDocument_HedearId1=h1.fldid	or (not exists(select * from Acc.tblDocumentRecord_Details as d3 where d3.fldDocument_HedearId1=h1.fldid ) and d2.fldDocument_HedearId1 is null )) 
							and((h1.fldDocumentNum<>0 and @AzDocumentNum=0) or (@AzDocumentNum<>0 and h1.fldDocumentNum between @AzDocumentNum and @TaDocumentNum))
 
							and (@Type=2 or (@Type<>2 and h1.fldAccept=@Type)))sum_Mah
				outer apply(select SUM(d2.fldBedehkar) as fldBedehkar_Date,sum(d2.fldBestankar) as fldBestankar_Date  
							from acc.tblCoding_Details  as c
							inner join acc.tblDocumentRecord_Details as d2 on d2.fldCodingId=c.fldId
							inner join ACC.tblDocumentRecord_Header as h2 on h2.fldId=d2.fldDocument_HedearId
							inner join acc.tblDocumentRecord_Header1 as h1 on h1.fldDocument_HedearId=h2.fldid
							where c.fldCodeId.IsDescendantOf(p.fldCodeId)=1 and h2.fldYear=@Year 
							and h2.fldOrganId=@OrganId and h1.fldModuleSaveId=@ModuleSaveId 
							and h1.fldTarikhDocument <= @TaTarikh
							and  (d2.fldDocument_HedearId1=h1.fldid	or (not exists(select * from Acc.tblDocumentRecord_Details as d3 where d3.fldDocument_HedearId1=h1.fldid ) and d2.fldDocument_HedearId1 is null )) 
							and((h1.fldDocumentNum<>0 and @AzDocumentNum=0) or (@AzDocumentNum<>0 and h1.fldDocumentNum between @AzDocumentNum and @TaDocumentNum))
							
							and (@Type=2 or (@Type<>2 and h1.fldAccept=@Type)) )sum_Date
				where (p.fldId=@CodingDetailsId)and  h.fldYear in (@Year,@Year_Pre) 
				and h.fldOrganId=@OrganId 
			and (fldBestankar_Pre<>0 or fldBedehkar_Pre<>0 or fldBestankar_mah<>0 or fldBedehkar_mah<>0 or fldBestankar_date<>0 or fldBedehkar_date<>0 )
				)t

				)t2
	order by code2,fldtype
end
else if (@Flag=1 and @SourceId=0)
begin
insert @Coding
select distinct sum_Date.fldId ,sum_Date.fldTitle
from acc.tblCoding_Details  as p
	inner join acc.tblCoding_Header as h on h.fldId=p.fldHeaderCodId
	cross apply(select distinct c.fldId ,c.fldTitle
							from acc.tblCoding_Details  as c
							inner join acc.tblDocumentRecord_Details as d2 on d2.fldCodingId=c.fldId
							inner join ACC.tblDocumentRecord_Header as h2 on h2.fldId=d2.fldDocument_HedearId
							inner join acc.tblDocumentRecord_Header1 as h1 on h1.fldDocument_HedearId=h2.fldid
							left join acc.tblCase as ca on ca.fldId=d2.fldCaseId
							where c.fldCodeId.IsDescendantOf(p.fldCodeId)=1 and h2.fldYear  in (@Year,@Year_Pre)
							and h2.fldOrganId=@OrganId and h1.fldModuleSaveId=@ModuleSaveId 
							and h1.fldTarikhDocument <= @TaTarikh
							and  (d2.fldDocument_HedearId1=h1.fldid	or (not exists(select * from Acc.tblDocumentRecord_Details as d3 where d3.fldDocument_HedearId1=h1.fldid ) and d2.fldDocument_HedearId1 is null )) 
							and((h1.fldDocumentNum<>0 and @AzDocumentNum=0) or (h1.fldDocumentNum between @AzDocumentNum and @TaDocumentNum))
							and (@SourceId=0 or (ca.fldSourceId=@SourceId and ca.fldCaseTypeId=@CaseTypeId))
							and (@Type=2 or (@Type<>2 and h1.fldAccept=@Type)) )sum_Date
				where h.fldYear in (@Year,@Year_Pre) and( p.fldId=@CodingDetailsId)
				and h.fldOrganId=@OrganId

select fldLevelId,fldName,fldCode,fldTitle,fldBedehkar_Pre,fldBestankar_Pre,fldBedehkar_Mah,fldBestankar_Mah,fldBedehkar_Date,fldBestankar_Date
		, fldBedehkar
	, fldBestankar from (
	select fldLevelId,fldName,fldCode,fldTitle,fldBedehkar_Pre,fldBestankar_Pre,fldBedehkar_Mah,fldBestankar_Mah,fldBedehkar_Date,fldBestankar_Date
		,case when fldBedehkar_Date-fldBestankar_Date<=0 then 0 else fldBedehkar_Date-fldBestankar_Date end as fldBedehkar
	,case when fldBestankar_Date-fldBedehkar_Date<=0 then 0 else fldBestankar_Date-fldBedehkar_Date end as fldBestankar,fldtype,fldCode as code2
	from(
	select  p.fldLevelId ,
	case when p.fldLevelId=1 then N'گروه' when p.fldLevelId=2 then N'کل' when p.fldLevelId=3 then N'معین' 
	when p.fldLevelId>3 then  N'تفصیلی ' + cast(p.fldLevelId-3 as varchar(5)) else N'' end as fldName
	,p.fldCode,p.fldTitle
	,isnull(sum_pre.fldBedehkar_Pre,0) as fldBedehkar_Pre,isnull(sum_pre.fldBestankar_Pre,0) as fldBestankar_Pre
	,isnull(sum_Mah.fldBedehkar_mah,0) as fldBedehkar_Mah,isnull(sum_Mah.fldBestankar_mah,0) as fldBestankar_Mah
	,isnull(sum_Date.fldBedehkar_Date,0) as fldBedehkar_Date,isnull(sum_Date.fldBestankar_Date,0) as fldBestankar_Date,1 as fldtype
	from acc.tblCoding_Details  as p
	inner join acc.tblCoding_Header as h on h.fldId=p.fldHeaderCodId
				outer apply(select SUM(d2.fldBedehkar) as fldBedehkar_Pre,sum(d2.fldBestankar) as fldBestankar_Pre  
							from acc.tblCoding_Details  as c
							inner join acc.tblDocumentRecord_Details as d2 on d2.fldCodingId=c.fldId
							inner join ACC.tblDocumentRecord_Header as h2 on h2.fldId=d2.fldDocument_HedearId
							inner join acc.tblDocumentRecord_Header1 as h1 on h1.fldDocument_HedearId=h2.fldid
							where  c.fldCodeId.IsDescendantOf(p.fldCodeId)=1 
							and h2.fldYear=@Year_Pre
							and h2.fldOrganId=@OrganId and h1.fldModuleSaveId=@ModuleSaveId 
							and h1.fldTarikhDocument<=@Tarikh_Pre
							and  (d2.fldDocument_HedearId1=h1.fldid	or (not exists(select * from Acc.tblDocumentRecord_Details as d3 where d3.fldDocument_HedearId1=h1.fldid ) and d2.fldDocument_HedearId1 is null )) 
							and((h1.fldDocumentNum<>0 and @AzDocumentNum=0) or (@AzDocumentNum<>0 and h1.fldDocumentNum between @AzDocumentNum and @TaDocumentNum))
							and (@Type=2 or (@Type<>2 and h1.fldAccept=@Type)))sum_pre
				outer apply(select SUM(d2.fldBedehkar) as fldBedehkar_mah,sum(d2.fldBestankar) as fldBestankar_mah  
							from acc.tblCoding_Details  as c
							inner join acc.tblDocumentRecord_Details as d2 on d2.fldCodingId=c.fldId
							inner join ACC.tblDocumentRecord_Header as h2 on h2.fldId=d2.fldDocument_HedearId
							inner join acc.tblDocumentRecord_Header1 as h1 on h1.fldDocument_HedearId=h2.fldid
							where c.fldCodeId.IsDescendantOf(p.fldCodeId)=1 
							and h2.fldOrganId=@OrganId and h1.fldModuleSaveId=@ModuleSaveId 
							and h1.fldTarikhDocument between @AzTarikh and @TaTarikh
							and  (d2.fldDocument_HedearId1=h1.fldid	or (not exists(select * from Acc.tblDocumentRecord_Details as d3 where d3.fldDocument_HedearId1=h1.fldid ) and d2.fldDocument_HedearId1 is null )) 
							and((h1.fldDocumentNum<>0 and @AzDocumentNum=0) or (@AzDocumentNum<>0 and h1.fldDocumentNum between @AzDocumentNum and @TaDocumentNum))
 
							and (@Type=2 or (@Type<>2 and h1.fldAccept=@Type)))sum_Mah
				outer apply(select SUM(d2.fldBedehkar) as fldBedehkar_Date,sum(d2.fldBestankar) as fldBestankar_Date  
							from acc.tblCoding_Details  as c
							inner join acc.tblDocumentRecord_Details as d2 on d2.fldCodingId=c.fldId
							inner join ACC.tblDocumentRecord_Header as h2 on h2.fldId=d2.fldDocument_HedearId
							inner join acc.tblDocumentRecord_Header1 as h1 on h1.fldDocument_HedearId=h2.fldid
							where c.fldCodeId.IsDescendantOf(p.fldCodeId)=1 and h2.fldYear=@Year 
							and h2.fldOrganId=@OrganId and h1.fldModuleSaveId=@ModuleSaveId 
							and h1.fldTarikhDocument <= @TaTarikh
							and  (d2.fldDocument_HedearId1=h1.fldid	or (not exists(select * from Acc.tblDocumentRecord_Details as d3 where d3.fldDocument_HedearId1=h1.fldid ) and d2.fldDocument_HedearId1 is null )) 
							and((h1.fldDocumentNum<>0 and @AzDocumentNum=0) or (@AzDocumentNum<>0 and h1.fldDocumentNum between @AzDocumentNum and @TaDocumentNum))
							
							and (@Type=2 or (@Type<>2 and h1.fldAccept=@Type)) )sum_Date
				where (p.fldId=@CodingDetailsId)and  h.fldYear in (@Year,@Year_Pre) 
				and h.fldOrganId=@OrganId 
			and (fldBestankar_Pre<>0 or fldBedehkar_Pre<>0 or fldBestankar_mah<>0 or fldBedehkar_mah<>0 or fldBestankar_date<>0 or fldBedehkar_date<>0 )
				
union all
select  p.fldLevelId ,
	case when p.fldLevelId=1 then N'گروه' when p.fldLevelId=2 then N'کل' when p.fldLevelId=3 then N'معین' 
	when p.fldLevelId>3 then  N'تفصیلی ' + cast(p.fldLevelId-3 as varchar(5)) else N'' end as fldName
	,p.fldCode,p.fldTitle
	,isnull(sum_pre.fldBedehkar_Pre,0) as fldBedehkar_Pre,isnull(sum_pre.fldBestankar_Pre,0) as fldBestankar_Pre
	,isnull(sum_Mah.fldBedehkar_mah,0) as fldBedehkar_Mah,isnull(sum_Mah.fldBestankar_mah,0) as fldBestankar_Mah
	,isnull(sum_Date.fldBedehkar_Date,0) as fldBedehkar_Date,isnull(sum_Date.fldBestankar_Date,0) as fldBestankar_Date,1 as fldtype
	from acc.tblCoding_Details  as p
	inner join @Coding as co on co.CodingId=p.fldId
	inner join acc.tblCoding_Header as h on h.fldId=p.fldHeaderCodId
				outer apply(select SUM(d2.fldBedehkar) as fldBedehkar_Pre,sum(d2.fldBestankar) as fldBestankar_Pre  
							from acc.tblCoding_Details  as c
							inner join acc.tblDocumentRecord_Details as d2 on d2.fldCodingId=c.fldId
							inner join ACC.tblDocumentRecord_Header as h2 on h2.fldId=d2.fldDocument_HedearId
							inner join acc.tblDocumentRecord_Header1 as h1 on h1.fldDocument_HedearId=h2.fldid
							where  c.fldId=co.CodingId
							and h2.fldYear=@Year_Pre
							and h2.fldOrganId=@OrganId and h1.fldModuleSaveId=@ModuleSaveId 
							and h1.fldTarikhDocument<=@Tarikh_Pre
							and  (d2.fldDocument_HedearId1=h1.fldid	or (not exists(select * from Acc.tblDocumentRecord_Details as d3 where d3.fldDocument_HedearId1=h1.fldid ) and d2.fldDocument_HedearId1 is null )) 
							and((h1.fldDocumentNum<>0 and @AzDocumentNum=0) or (@AzDocumentNum<>0 and h1.fldDocumentNum between @AzDocumentNum and @TaDocumentNum))
							and (@Type=2 or (@Type<>2 and h1.fldAccept=@Type))
							)sum_pre
				outer apply(select SUM(d2.fldBedehkar) as fldBedehkar_mah,sum(d2.fldBestankar) as fldBestankar_mah 
							from acc.tblCoding_Details  as c
							inner join acc.tblDocumentRecord_Details as d2 on d2.fldCodingId=c.fldId
							inner join ACC.tblDocumentRecord_Header as h2 on h2.fldId=d2.fldDocument_HedearId
							inner join acc.tblDocumentRecord_Header1 as h1 on h1.fldDocument_HedearId=h2.fldid
							where   c.fldId=co.CodingId
							and h2.fldOrganId=@OrganId and h1.fldModuleSaveId=@ModuleSaveId 
							and h1.fldTarikhDocument between @AzTarikh and @TaTarikh
							and  (d2.fldDocument_HedearId1=h1.fldid	or (not exists(select * from Acc.tblDocumentRecord_Details as d3 where d3.fldDocument_HedearId1=h1.fldid ) and d2.fldDocument_HedearId1 is null )) 
							and((h1.fldDocumentNum<>0 and @AzDocumentNum=0) or (@AzDocumentNum<>0 and h1.fldDocumentNum between @AzDocumentNum and @TaDocumentNum))
 
							and (@Type=2 or (@Type<>2 and h1.fldAccept=@Type)))sum_Mah
				outer apply(select SUM(d2.fldBedehkar) as fldBedehkar_Date,sum(d2.fldBestankar) as fldBestankar_Date 
							from acc.tblCoding_Details  as c
							inner join acc.tblDocumentRecord_Details as d2 on d2.fldCodingId=c.fldId
							inner join ACC.tblDocumentRecord_Header as h2 on h2.fldId=d2.fldDocument_HedearId
							inner join acc.tblDocumentRecord_Header1 as h1 on h1.fldDocument_HedearId=h2.fldid
							where   c.fldId=co.CodingId and h2.fldYear=@Year 
							and h2.fldOrganId=@OrganId and h1.fldModuleSaveId=@ModuleSaveId 
							and h1.fldTarikhDocument <= @TaTarikh
							and  (d2.fldDocument_HedearId1=h1.fldid	or (not exists(select * from Acc.tblDocumentRecord_Details as d3 where d3.fldDocument_HedearId1=h1.fldid ) and d2.fldDocument_HedearId1 is null )) 
							and((h1.fldDocumentNum<>0 and @AzDocumentNum=0) or (@AzDocumentNum<>0 and h1.fldDocumentNum between @AzDocumentNum and @TaDocumentNum))
							
							and (@Type=2 or (@Type<>2 and h1.fldAccept=@Type)) )sum_Date
				where  h.fldYear in (@Year,@Year_Pre) 
				and h.fldOrganId=@OrganId 
			and (fldBestankar_Pre<>0 or fldBedehkar_Pre<>0 or fldBestankar_mah<>0 or fldBedehkar_mah<>0 or fldBestankar_date<>0 or fldBedehkar_date<>0 )
				)t
				)t2
	order by code2,fldtype
end	
else 
begin
declare @ParvaneName nvarchar(200)=Acc.fn_GetParvandeName (@CaseTypeId,@SourceId ,@OrganId )


select fldLevelId,fldName,fldCode,fldTitle,fldBedehkar_Pre,fldBestankar_Pre,fldBedehkar_Mah,fldBestankar_Mah,fldBedehkar_Date,fldBestankar_Date
		, fldBedehkar
	, fldBestankar from (
	select fldLevelId,fldName,fldCode,fldTitle,fldBedehkar_Pre,fldBestankar_Pre,fldBedehkar_Mah,fldBestankar_Mah,fldBedehkar_Date,fldBestankar_Date
		,case when fldBedehkar_Date-fldBestankar_Date<=0 then 0 else fldBedehkar_Date-fldBestankar_Date end as fldBedehkar
	,case when fldBestankar_Date-fldBedehkar_Date<=0 then 0 else fldBestankar_Date-fldBedehkar_Date end as fldBestankar,fldtype,fldCode as code2
	from(
	select  p.fldLevelId ,
	case when p.fldLevelId=1 then N'گروه' when p.fldLevelId=2 then N'کل' when p.fldLevelId=3 then N'معین' 
	when p.fldLevelId>3 then  N'تفصیلی ' + cast(p.fldLevelId-3 as varchar(5)) else N'' end as fldName
	,p.fldCode,@ParvaneName as fldTitle
	,isnull(sum_pre.fldBedehkar_Pre,0) as fldBedehkar_Pre,isnull(sum_pre.fldBestankar_Pre,0) as fldBestankar_Pre
	,isnull(sum_Mah.fldBedehkar_mah,0) as fldBedehkar_Mah,isnull(sum_Mah.fldBestankar_mah,0) as fldBestankar_Mah
	,isnull(sum_Date.fldBedehkar_Date,0) as fldBedehkar_Date,isnull(sum_Date.fldBestankar_Date,0) as fldBestankar_Date,1 as fldtype
	from acc.tblCoding_Details  as p
	inner join acc.tblCoding_Header as h on h.fldId=p.fldHeaderCodId
				outer apply(select SUM(d2.fldBedehkar) as fldBedehkar_Pre,sum(d2.fldBestankar) as fldBestankar_Pre  
							from acc.tblCoding_Details  as c
							inner join acc.tblDocumentRecord_Details as d2 on d2.fldCodingId=c.fldId
							inner join ACC.tblDocumentRecord_Header as h2 on h2.fldId=d2.fldDocument_HedearId
							inner join acc.tblDocumentRecord_Header1 as h1 on h1.fldDocument_HedearId=h2.fldid
							inner join acc.tblCase as ca on ca.fldId=d2.fldCaseId
							where  ca.fldSourceId=@SourceId and ca.fldCaseTypeId=@CaseTypeId 
							and c.fldCodeId.IsDescendantOf(p.fldCodeId)=1 
							and h2.fldYear=@Year_Pre							
							and h2.fldOrganId=@OrganId and h1.fldModuleSaveId=@ModuleSaveId 
							and h1.fldTarikhDocument<=@Tarikh_Pre
							and  (d2.fldDocument_HedearId1=h1.fldid	or (not exists(select * from Acc.tblDocumentRecord_Details as d3 where d3.fldDocument_HedearId1=h1.fldid ) and d2.fldDocument_HedearId1 is null )) 
							and((h1.fldDocumentNum<>0 and @AzDocumentNum=0) or (@AzDocumentNum<>0 and h1.fldDocumentNum between @AzDocumentNum and @TaDocumentNum))
							and (@Type=2 or (@Type<>2 and h1.fldAccept=@Type)))sum_pre
				outer apply(select SUM(d2.fldBedehkar) as fldBedehkar_mah,sum(d2.fldBestankar) as fldBestankar_mah  
							from acc.tblCoding_Details  as c
							inner join acc.tblDocumentRecord_Details as d2 on d2.fldCodingId=c.fldId
							inner join ACC.tblDocumentRecord_Header as h2 on h2.fldId=d2.fldDocument_HedearId
							inner join acc.tblDocumentRecord_Header1 as h1 on h1.fldDocument_HedearId=h2.fldid
							inner join acc.tblCase as ca on ca.fldId=d2.fldCaseId
							where  ca.fldSourceId=@SourceId and ca.fldCaseTypeId=@CaseTypeId 
							and c.fldCodeId.IsDescendantOf(p.fldCodeId)=1 
							and h2.fldOrganId=@OrganId and h1.fldModuleSaveId=@ModuleSaveId 
							and h1.fldTarikhDocument between @AzTarikh and @TaTarikh
							and  (d2.fldDocument_HedearId1=h1.fldid	or (not exists(select * from Acc.tblDocumentRecord_Details as d3 where d3.fldDocument_HedearId1=h1.fldid ) and d2.fldDocument_HedearId1 is null )) 
							and((h1.fldDocumentNum<>0 and @AzDocumentNum=0) or (@AzDocumentNum<>0 and h1.fldDocumentNum between @AzDocumentNum and @TaDocumentNum))
 
							and (@Type=2 or (@Type<>2 and h1.fldAccept=@Type)))sum_Mah
				outer apply(select SUM(d2.fldBedehkar) as fldBedehkar_Date,sum(d2.fldBestankar) as fldBestankar_Date  
							from acc.tblCoding_Details  as c
							inner join acc.tblDocumentRecord_Details as d2 on d2.fldCodingId=c.fldId
							inner join ACC.tblDocumentRecord_Header as h2 on h2.fldId=d2.fldDocument_HedearId
							inner join acc.tblDocumentRecord_Header1 as h1 on h1.fldDocument_HedearId=h2.fldid
							inner join acc.tblCase as ca on ca.fldId=d2.fldCaseId
							where  ca.fldSourceId=@SourceId and ca.fldCaseTypeId=@CaseTypeId 
							and  c.fldCodeId.IsDescendantOf(p.fldCodeId)=1 and h2.fldYear=@Year 
							and h2.fldOrganId=@OrganId and h1.fldModuleSaveId=@ModuleSaveId 
							and h1.fldTarikhDocument <= @TaTarikh
							and  (d2.fldDocument_HedearId1=h1.fldid	or (not exists(select * from Acc.tblDocumentRecord_Details as d3 where d3.fldDocument_HedearId1=h1.fldid ) and d2.fldDocument_HedearId1 is null )) 
							and((h1.fldDocumentNum<>0 and @AzDocumentNum=0) or (@AzDocumentNum<>0 and h1.fldDocumentNum between @AzDocumentNum and @TaDocumentNum))
							
							and (@Type=2 or (@Type<>2 and h1.fldAccept=@Type)) )sum_Date
				where (p.fldId=@CodingDetailsId)and  h.fldYear in (@Year,@Year_Pre) 
				and h.fldOrganId=@OrganId 
			and (fldBestankar_Pre<>0 or fldBedehkar_Pre<>0 or fldBestankar_mah<>0 or fldBedehkar_mah<>0 or fldBestankar_date<>0 or fldBedehkar_date<>0 )
				
)t
				)t2
	order by code2,fldtype
end	
commit tran
GO
