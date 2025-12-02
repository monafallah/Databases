SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE proc [ACC].[spr_RptCodingTurnover_Tarikh] (@Coding_DetailsId int ,@CaseTypeId int,@SourceId INT,@Year smallint,@OrganId int,@ModuleSaveId int
,@aztarikh varchar(10),@tatarikh  varchar(10))
 as
 begin tran
--declare @Coding_DetailsId int =1096,@CaseTypeId int=0,@SourceId INT=-1,@Year smallint=1402,@OrganId int=2,@ModuleSaveId int=4
--,@aztarikh varchar(10)='1402/03/03',@tatarikh  varchar(10)='1402/03/04'
declare @Start varchar(10),@end varchar(10),@Date datetime,@DateShow varchar(10)=''
set @DateShow=dbo.Fn_AssembelyMiladiToShamsi(DATEADD(day,-1, com.ShamsiToMiladi(@aztarikh)))
set @Start=cast(@Year as varchar(4))+'/01/01'
select @end=fldTarikh,@Date=d from com.tblDateDim d
cross apply (
			select dateadd( DAY,-1,fldDate) fldDate,fldDate as d from com.tblDateDim 
			where fldTarikh=@aztarikh
			)d1
	where d.fldDate=d1.fldDate
	
	declare @t table( id int)
	insert @t
	select @Coding_DetailsId
	union 
	select c.fldId from acc.tblCoding_Details as p
	inner join acc.tblCoding_Details as c on p.fldId=@Coding_DetailsId
	where  c.fldCodeId.IsDescendantOf(p.fldCodeId)=1 

	select fldId, fldTitle,fldTarikhDocument, fldParentTitle, isnull(fldMande_t,0)fldMande_t
		, isnull(fldBedehkar,0)fldBedehkar, isnull(fldBestankar,0)fldBestankar
		, isnull(fldBedehkar_t,0)fldBedehkar_t	,  isnull(fldBestankar_t,0)fldBestankar_t
		, fldTypeName_t
		, fldType
		, fldDocumentNum, fldDescriptionDocu, fldDocument_HedearId, isnull(fldParvande,'')fldParvande from(

	select  fldId, fldTitle, fldParentTitle,
	abs(fldBedehkar_t-fldBestankar_t) as fldMande_t
		, fldBedehkar, fldBestankar
		, fldBedehkar_t	,  fldBestankar_t
		,case when fldBedehkar_t<fldBestankar_t then N'بستانکار' when fldBedehkar_t>fldBestankar_t then N'بدهکار' else N'خنثی' end as fldTypeName_t
			,case when fldBedehkar_t<fldBestankar_t then 1 when fldBedehkar_t>fldBestankar_t then 2 else 3 end as fldType
			, fldDocumentNum, fldDescriptionDocu, fldDocument_HedearId, fldParvande,fldTarikhDocument,fldDate,fldDetailId from (
		select  0 fldId,N'' fldTitle,N'' fldParentTitle
		,sum(fldBedehkar) as fldBedehkar,sum(fldBestankar) as fldBestankar
		,max( fldBedehkar_t	)as fldBedehkar_t	, max(fldBestankar_t) as fldBestankar_t
			,0 fldDocumentNum,N'مانده از قبل' fldDescriptionDocu,0 fldDocument_HedearId,N'' fldParvande,@DateShow as fldTarikhDocument
			,@Date as fldDate,1 as fldDetailId
			from (
			select p.fldId,p.fldTitle,(fldBedehkar) as fldBedehkar,(fldBestankar) as fldBestankar ,t.fldParentTitle
			,sum(fldBedehkar) over (order by h1.fldTarikhDocument ,d.fldDate,d.fldid,isnull(d.fldDocument_HedearId1,h1.fldId)) as fldBedehkar_t
			,sum(fldBestankar) over (order by h1.fldTarikhDocument ,d.fldDate,d.fldid,isnull(d.fldDocument_HedearId1,h1.fldId)) as fldBestankar_t
			,h1.fldDocumentNum,d.fldDescription as fldDescriptionDocu,d.fldorder,h1.fldTarikhDocument ,d.fldDate,d.fldId as fldDetailId
			,isnull(d.fldDocument_HedearId1,h1.fldId) as fldDocument_HedearId
			,isnull([ACC].[fn_GetParvandeName](fldCaseTypeId,fldSourceId,h.fldOrganId),'') as fldParvande
			from acc.tblCoding_Details  as p
			inner join acc.tblDocumentRecord_Details as d on d.fldCodingId=p.fldId
			inner join acc.tblDocumentRecord_Header as h on h.fldId=d.fldDocument_HedearId
			inner join acc.tblDocumentRecord_Header1 as h1 on h1.fldDocument_HedearId=h.fldid
			left join acc.tblCase as ca on ca.fldId=d.fldCaseId
			outer apply (select (select p2.fldTitle+'/' from acc.tblCoding_Details as p2 where p.fldCodeId.IsDescendantOf(p2.fldCodeId)=1 and p.fldHeaderCodId=p2.fldHeaderCodId for xml path('')) as fldParentTitle )t
			where  (d.fldDocument_HedearId1=h1.fldId or 
			(not exists(select * from Acc.tblDocumentRecord_Details as d2 where d2.fldDocument_HedearId1=h1.fldId )   and d.fldDocument_HedearId1 is null)) 
			and fldTarikhDocument  between @Start and @end 
			and h.fldYear=@Year and h.fldOrganId=@OrganId and h1.fldModuleSaveId=@ModuleSaveId and		 
			exists (select id from @t as t where t.id=p.fldId) and
			h1.fldDocumentNum<>0 
			and (ca.fldCaseTypeId=@CaseTypeId or @CaseTypeId=0)
			and ((ca.fldSourceId=@SourceId or @SourceId=0)or (@SourceId=-1 and d.fldCaseId is null))
			
			)t
			)t2
			union all

		select  fldId,fldTitle,fldParentTitle,
		abs(fldBedehkar_t-fldBestankar_t) as fldMande_t
		,fldBedehkar,fldBestankar
		, fldBedehkar_t		, fldBestankar_t
		,case when fldBedehkar_t<fldBestankar_t then N'بستانکار' when fldBedehkar_t>fldBestankar_t then N'بدهکار' else N'خنثی' end as fldTypeName_t
			,case when fldBedehkar_t<fldBestankar_t then 1 when fldBedehkar_t>fldBestankar_t then 2 else 3 end as fldType
			,fldDocumentNum,fldDescriptionDocu,fldDocument_HedearId,fldParvande,fldTarikhDocument,fldDate,fldDetailId
			from (
			select p.fldId,p.fldTitle,(fldBedehkar) as fldBedehkar,(fldBestankar) as fldBestankar ,t.fldParentTitle
			,sum(fldBedehkar) over (order by h1.fldTarikhDocument ,d.fldDate,d.fldid,isnull(d.fldDocument_HedearId1,h1.fldId)) as fldBedehkar_t
			,sum(fldBestankar) over (order by h1.fldTarikhDocument ,d.fldDate,d.fldid,isnull(d.fldDocument_HedearId1,h1.fldId)) as fldBestankar_t
			,h1.fldDocumentNum,d.fldDescription as fldDescriptionDocu,d.fldorder,h1.fldTarikhDocument ,d.fldDate,d.fldId as fldDetailId,isnull(d.fldDocument_HedearId1,h1.fldId) as fldDocument_HedearId
			,isnull([ACC].[fn_GetParvandeName](fldCaseTypeId,fldSourceId,h.fldOrganId),'') as fldParvande
			from acc.tblCoding_Details  as p
			inner join acc.tblDocumentRecord_Details as d on d.fldCodingId=p.fldId
			inner join acc.tblDocumentRecord_Header as h on h.fldId=d.fldDocument_HedearId
			inner join acc.tblDocumentRecord_Header1 as h1 on h1.fldDocument_HedearId=h.fldid
			left join acc.tblCase as ca on ca.fldId=d.fldCaseId
			outer apply (select (select p2.fldTitle+'/' from acc.tblCoding_Details as p2 where p.fldCodeId.IsDescendantOf(p2.fldCodeId)=1 and p.fldHeaderCodId=p2.fldHeaderCodId for xml path('')) as fldParentTitle )t
			
			where   (d.fldDocument_HedearId1=h1.fldId or 
			(not exists(select * from Acc.tblDocumentRecord_Details as d2 where d2.fldDocument_HedearId1=h1.fldId )   and d.fldDocument_HedearId1 is null)) 
			and h1.fldTarikhDocument between @aztarikh and @tatarikh and h.fldYear=@Year and h.fldOrganId=@OrganId and h1.fldModuleSaveId=@ModuleSaveId and		 
			 exists (select id from @t as t where t.id=p.fldId)  and
			h1.fldDocumentNum<>0 
			and (ca.fldCaseTypeId=@CaseTypeId or @CaseTypeId=0)
			and ((ca.fldSourceId=@SourceId or @SourceId=0)or (@SourceId=-1 and d.fldCaseId is null))
			
			)t
			)t2
			order by fldTarikhDocument,fldDate,fldDetailId,fldDocument_HedearId

		






		--else if(@flag=0)
--		begin
--			select @Title=fldTitle ,@ParentTitle=fldParentTitle
--			from acc.tblCoding_Details  as c 
--			outer apply (select(select p2.fldTitle+'/' from acc.tblCoding_Details as p2 where c.fldCodeId.IsDescendantOf(p2.fldCodeId)=1 for xml path('')) as fldParentTitle )t
--			where c.fldId=@Coding_DetailsId

--select fldId,fldTitle,fldParentTitle, (fldBedehkar_t-fldBestankar_t) as fldMande_t
--		, fldBedehkar_t
--		, fldBestankar_t
--		,case when fldBedehkar_t<fldBestankar_t then N'بستانکار' when fldBedehkar_t>fldBestankar_t then N'بدهکار' else N'خنثی' end as fldTypeName_t
--			,case when fldBedehkar_t<fldBestankar_t then 1 when fldBedehkar_t>fldBestankar_t then 2 else 3 end as fldType
--			,fldDocumentNum,fldDescriptionDocu
--			from (
--			select @Coding_DetailsId as fldId,@Title as fldTitle,@ParentTitle as fldParentTitle
--			,(fldBedehkar) as fldBedehkar,(fldBestankar) as fldBestankar 
--			,sum(fldBedehkar) over (order by c.fldId) as fldBedehkar_t
--			,sum(fldBestankar) over (order by c.fldId) as fldBestankar_t
--			,h.fldDocumentNum,h.fldDescriptionDocu
--			from acc.tblCoding_Details  as p
--			inner join acc.tblCoding_Details  as c on p.fldId=@Coding_DetailsId
--			inner join acc.tblDocumentRecord_Details as d on d.fldCodingId=c.fldId
--			inner join acc.tblDocumentRecord_Header as h on h.fldId=d.fldDocument_HedearId
--			left join acc.tblCase as ca on ca.fldId=d.fldCaseId
--			where /*h.fldYear=@Year and h.fldOrganId=@OrganId and h.fldModuleSaveId=@ModuleSaveId and */
--			h.fldDocumentNum<>0 
--			and c.fldCodeId.IsDescendantOf(p.fldCodeId)=1 
--			and (ca.fldCaseTypeId=@CaseTypeId or @CaseTypeId=0)
--			and (ca.fldSourceId=@SourceId or @SourceId=0)
--			)t
			
--		end
commit tran
GO
