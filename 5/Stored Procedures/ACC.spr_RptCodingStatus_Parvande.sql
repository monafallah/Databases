SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE proc [ACC].[spr_RptCodingStatus_Parvande]
 @Coding_DetailsId int ,@Flag tinyint,@CaseTypeId int,@SourceId INT,@Year smallint,@OrganId int,@ModuleSaveId int,@Type tinyint
 as
 begin tran
 --declare @Coding_DetailsId int =1096,@Flag tinyint=0,@CaseTypeId int=0,@SourceId INT=0,@Year smallint=1402,@OrganId int=1,@ModuleSaveId int=4
 --,@Type tinyint=2
--declare @Title nvarchar(500)='',@ParentTitle nvarchar(1000)=''
--select * from acc.tblDocumentRecord_Details as d where d.fldCodingId=1
if(@Coding_DetailsId=0 or @Coding_DetailsId is null)
begin
	
	select *,	case when/* (fldNoe_Mande =1 and fldMahiyatId=2 ) or (fldNoe_Mande=2 and fldMahiyatId=1)*/fldNoe_Mande<>fldMahiyatId  then 1 else 0 end fldNoe_Mahiyat
	 from (
	select isnull(fldId,0) as fldId,isnull(fldTitle,N'') as fldTitle ,isnull(fldParentTitle,N'') as fldParentTitle
	,isnull(( abs(fldBedehkar-fldBestankar)),0) as fldMande
		,case when fldBedehkar<fldBestankar then N'بستانکار' when fldBedehkar>fldBestankar then N'بدهکار' else N'خنثی' end as fldTypeName
			,case when fldBedehkar<fldBestankar then 1 when fldBedehkar>fldBestankar then 2 else 3 end as fldType
					,case when fldBedehkar>fldBestankar then 1 when fldBedehkar<fldBestankar then 2 else 3 end as fldNoe_Mande,fldMahiyatId
			,isnull(fldParvande,N'') as fldParvande,isnull(fldCaseTypeId,0) as fldCaseTypeId,isnull(fldSourceId,0)fldSourceId
			from (
			select c.fldId,c.fldTitle,sum(fldBedehkar) as fldBedehkar,sum(fldBestankar) as fldBestankar ,t.fldParentTitle
			,isnull([ACC].[fn_GetParvandeName](fldCaseTypeId,fldSourceId,h.fldOrganId),'') as fldParvande,fldCaseTypeId,ca.fldSourceId,fldMahiyatId

			from 
			--acc.tblCoding_Details  as p
			--inner join 
			acc.tblCoding_Details  as c 
			--on c.fldCodeId.IsDescendantOf(p.fldCodeId)=1 --on p.fldId=@Coding_DetailsId
			inner join acc.tblDocumentRecord_Details as d on d.fldCodingId=c.fldId
			inner join ACC.tblDocumentRecord_Header as h on h.fldId=d.fldDocument_HedearId
			inner join acc.tblDocumentRecord_Header1 as h1 on h1.fldDocument_HedearId=h.fldid
			left join acc.tblCase as ca on ca.fldId=d.fldCaseId
			outer apply (select(select  p2.fldTitle+'/' from acc.tblCoding_Details as p2 
						where c.fldCodeId.IsDescendantOf(p2.fldCodeId)=1   and c.fldHeaderCodId=p2.fldHeaderCodId  for xml path('')) as fldParentTitle )t
			
			where 
			(d.fldDocument_HedearId1=h1.fldId or 
			(not exists(select * from Acc.tblDocumentRecord_Details as d2 where d2.fldDocument_HedearId1=h1.fldId )   and d.fldDocument_HedearId1 is null)) 
			and h.fldYear=@Year and h.fldOrganId=@OrganId and h1.fldModuleSaveId=@ModuleSaveId and 
			--(p.fldId=@Coding_DetailsId or @Coding_DetailsId=0)
			--c.fldCodeId.IsDescendantOf(p.fldCodeId)=1 
			--and 
			h1.fldDocumentNum<>0   and (@Type=2 or (@Type<>2 and h1.fldAccept=@Type))
			and (ca.fldCaseTypeId=@CaseTypeId or @CaseTypeId=0)
			and (ca.fldSourceId=@SourceId or @SourceId=0)
			group by c.fldId,c.fldStrhid,c.fldTitle,t.fldParentTitle,fldCaseTypeId,h.fldOrganId,ca.fldSourceId,fldMahiyatId
			)t
		)s


end
	else if(@flag=1)
	begin
		select *,	case when /*(fldNoe_Mande =1 and fldMahiyatId=2 ) or (fldNoe_Mande=2 and fldMahiyatId=1)*/fldNoe_Mande<>fldMahiyatId then 1 else 0 end fldNoe_Mahiyat from (
		select isnull(fldId,0) as fldId,isnull(fldTitle,N'') as fldTitle,isnull(fldParentTitle,N'') as fldParentTitle
		,isnull(( abs(fldBedehkar-fldBestankar)),0) as fldMande
		,case when fldBedehkar<fldBestankar then N'بستانکار' when fldBedehkar>fldBestankar then N'بدهکار' else N'خنثی' end as fldTypeName
			,case when fldBedehkar<fldBestankar then 1 when fldBedehkar>fldBestankar then 2 else 3 end as fldType
			,case when fldBedehkar>fldBestankar then 1 when fldBedehkar<fldBestankar then 2 else 3 end as fldNoe_Mande,fldMahiyatId
			,isnull(fldParvande,N'') as fldParvande,isnull(fldCaseTypeId,0) as fldCaseTypeId,isnull(fldSourceId,0)fldSourceId
			from (
			select c.fldId,c.fldTitle,sum(fldBedehkar) as fldBedehkar,sum(fldBestankar) as fldBestankar ,t.fldParentTitle
			,isnull([ACC].[fn_GetParvandeName](fldCaseTypeId,fldSourceId,h.fldOrganId),'') as fldParvande,fldCaseTypeId,ca.fldSourceId,c.fldMahiyatId
			from acc.tblCoding_Details  as p
			inner join acc.tblCoding_Details  as c on p.fldId=@Coding_DetailsId
			inner join acc.tblDocumentRecord_Details as d on d.fldCodingId=c.fldId
			inner join ACC.tblDocumentRecord_Header as h on h.fldId=d.fldDocument_HedearId
			inner join acc.tblDocumentRecord_Header1 as h1 on h1.fldDocument_HedearId=h.fldid
			left join acc.tblCase as ca on ca.fldId=d.fldCaseId
			outer apply (select(select p2.fldTitle+'/' from acc.tblCoding_Details as p2 
						where c.fldCodeId.IsDescendantOf(p2.fldCodeId)=1   and c.fldHeaderCodId=p2.fldHeaderCodId for xml path('')) as fldParentTitle )t
			
			where  
			(d.fldDocument_HedearId1=h1.fldId or 
			(not exists(select * from Acc.tblDocumentRecord_Details as d2 where d2.fldDocument_HedearId1=h1.fldId )   and d.fldDocument_HedearId1 is null)) 
			and h.fldYear=@Year and h.fldOrganId=@OrganId and h1.fldModuleSaveId=@ModuleSaveId and 
			c.fldCodeId.IsDescendantOf(p.fldCodeId)=1 
			and	h1.fldDocumentNum<>0   and (@Type=2 or (@Type<>2 and h1.fldAccept=@Type))
			and (ca.fldCaseTypeId=@CaseTypeId or @CaseTypeId=0)
			and (ca.fldSourceId=@SourceId or @SourceId=0)
			group by c.fldId,c.fldStrhid,c.fldTitle,t.fldParentTitle,fldCaseTypeId,h.fldOrganId,ca.fldSourceId
			,c.fldMahiyatId
			)t
		)s
			order by fldTitle
		end
		else if(@flag=0)
		begin
			declare @Title nvarchar(500)='',@ParentTitle nvarchar(1000)='',@mahiyatid int=0
			select @Title=fldTitle ,@ParentTitle=fldParentTitle,@mahiyatid= fldMahiyatId
			from acc.tblCoding_Details  as c 
			outer apply (select(select p2.fldTitle+'/' from acc.tblCoding_Details as p2 
			where c.fldCodeId.IsDescendantOf(p2.fldCodeId)=1   and c.fldHeaderCodId=p2.fldHeaderCodId for xml path('')) as fldParentTitle )t
			where c.fldId=@Coding_DetailsId

			select *,case when /*(fldNoe_Mande =1 and fldMahiyatId=2 ) or (fldNoe_Mande=2 and fldMahiyatId=1)*/fldNoe_Mande<>fldMahiyatId then 1 else 0 end fldNoe_Mahiyat 
			from 
			(select isnull(fldId,0) as fldId,isnull(fldTitle,N'') as fldTitle,isnull(fldParentTitle,N'') as fldParentTitle
			,isnull(( abs(fldBedehkar-fldBestankar)),0) as fldMande
			,case when fldBedehkar<fldBestankar then N'بستانکار' when fldBedehkar>fldBestankar then N'بدهکار' else N'خنثی' end as fldTypeName
			,case when fldBedehkar<fldBestankar then 1 when fldBedehkar>fldBestankar then 2 else 3 end as fldType
			,case when fldBedehkar>fldBestankar then 1 when fldBedehkar<fldBestankar then 2 else 3 end as fldNoe_Mande,fldMahiyatId
			,isnull(fldParvande,N'') as fldParvande,isnull(fldCaseTypeId,0) as fldCaseTypeId,isnull(fldSourceId,0)fldSourceId
			from (
			select @Coding_DetailsId as fldId,@Title as fldTitle,@ParentTitle as fldParentTitle,sum(fldBedehkar) as fldBedehkar
			,sum(fldBestankar) as fldBestankar ,@mahiyatid as fldMahiyatId
			,isnull([ACC].[fn_GetParvandeName](fldCaseTypeId,fldSourceId,h.fldOrganId),'') as fldParvande,fldCaseTypeId,ca.fldSourceId
			from acc.tblCoding_Details  as p
			inner join acc.tblCoding_Details  as c on p.fldId=@Coding_DetailsId
			inner join acc.tblDocumentRecord_Details as d on d.fldCodingId=c.fldId
			inner join ACC.tblDocumentRecord_Header as h on h.fldId=d.fldDocument_HedearId
			inner join acc.tblDocumentRecord_Header1 as h1 on h1.fldDocument_HedearId=h.fldid
			left join acc.tblCase as ca on ca.fldId=d.fldCaseId
			
			where  
			(d.fldDocument_HedearId1=h1.fldId or 
			(not exists(select * from Acc.tblDocumentRecord_Details as d2 where d2.fldDocument_HedearId1=h1.fldId )   and d.fldDocument_HedearId1 is null)) 
			and h.fldYear=@Year and h.fldOrganId=@OrganId and h1.fldModuleSaveId=@ModuleSaveId and c.fldCodeId.IsDescendantOf(p.fldCodeId)=1 
			and h1.fldDocumentNum<>0   and (@Type=2 or (@Type<>2 and h1.fldAccept=@Type))
			and (ca.fldCaseTypeId=@CaseTypeId or @CaseTypeId=0)
			and (ca.fldSourceId=@SourceId or @SourceId=0)
			group by fldCaseTypeId,h.fldOrganId,ca.fldSourceId
			)t
	)s
		end
		

commit tran
GO
