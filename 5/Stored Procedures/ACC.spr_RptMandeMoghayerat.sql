SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE proc [ACC].[spr_RptMandeMoghayerat]
 @FiscalYearId int,@aztarikh varchar(10),@tatarikh  varchar(10)
 as
 begin tran
 --declare @FiscalYearId int=5,@aztarikh varchar(10)='1402/01/01',@tatarikh  varchar(10)='1402/12/29'


	select * from(
	select fldCode  ,isnull(fldParentTitle,N'')+'/'+isnull(fldParvande,N'') as fldParentTitle
	,fldBedehkar,fldBestankar,isnull(( abs(fldBedehkar-fldBestankar)),0) as fldMande
		,case when fldBedehkar<fldBestankar then N'بس' when fldBedehkar>fldBestankar then N'بد' else N'خنثی' end as fldTypeName
			,fldMahiyatName
			from (
			select c.fldCode,c.fldTitle,sum(fldBedehkar) as fldBedehkar,sum(fldBestankar) as fldBestankar ,t.fldParentTitle
			,isnull([ACC].[fn_GetParvandeName](fldCaseTypeId,fldSourceId,h.fldOrganId),'') as fldParvande
			,fldCaseTypeId,ca.fldSourceId,c.fldMahiyatId,m.fldTitle as fldMahiyatName
			from 
			acc.tblCoding_Details  as c 
			inner join acc.tblDocumentRecord_Details as d on d.fldCodingId=c.fldId
			inner join ACC.tblDocumentRecord_Header as h on h.fldId=d.fldDocument_HedearId
			inner join acc.tblDocumentRecord_Header1 as h1 on h1.fldDocument_HedearId=h.fldid
			inner join acc.tblMahiyat as m on m.fldId=c.fldMahiyatId
			left join acc.tblCase as ca on ca.fldId=d.fldCaseId
			outer apply (select(select  p2.fldTitle+'/' from acc.tblCoding_Details as p2 
						where c.fldCodeId.IsDescendantOf(p2.fldCodeId)=1   and c.fldHeaderCodId=p2.fldHeaderCodId  for xml path('')) as fldParentTitle )t
			where 
			(d.fldDocument_HedearId1=h1.fldId or 
			(not exists(select * from Acc.tblDocumentRecord_Details as d2 where d2.fldDocument_HedearId1=h1.fldId )   and d.fldDocument_HedearId1 is null)) 
			and h.fldFiscalYearId=@FiscalYearId and h1.fldModuleSaveId=4 and 
			h1.fldDocumentNum<>0 
			and (ca.fldCaseTypeId=5)
			and fldTarikhDocument between @aztarikh and @tatarikh 
			group by c.fldCode,c.fldStrhid,c.fldTitle,t.fldParentTitle,fldCaseTypeId,h.fldOrganId,ca.fldSourceId,fldMahiyatId,m.fldTitle
			)t
	)s
	where fldMande>0

commit tran
GO
