SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE proc  [ACC].[spr_SelectCoding_ItemNecessary]
 @Year smallint,@OrganId int
 as
 begin tran 
 --declare @Year smallint=1402,@OrganId int=1
	select t2.fldId as fldCoding_DetailsId,i.fldId as  fldItemNecessaryId,i.fldNameItem,t2.fldCodeId/*,fldTempCodingId,t2.fldItemId,temp*/ from(
	select t1.*,isnull(t.fldItemId,c.fldItemId) as fldItemId,temp from(
	select  isnull(p.fldTempCodingId,c.fldTempCodingId) as fldTempCodingId,p.fldId,p.fldCodeId,c.fldStrhid 
	from acc.tblCoding_Details as p
	inner join acc.tblCoding_Header as h on h.fldId=p.fldHeaderCodId
	outer apply(select top(1) c.fldTempCodingId,c.fldStrhid from  acc.tblCoding_Details as c where p.fldCodeId.IsDescendantOf(c.fldCodeId)=1 and p.fldHeaderCodId=c.fldHeaderCodId and c.fldTempCodingId is not null order by c.fldCodeId desc)c
	where h.fldYear=@Year and h.fldOrganId=@OrganId
	)t1
	left join acc.tblTemplateCoding as t on t.fldId=t1.fldTempCodingId
	outer apply(select top(1) c.fldId as temp,c.fldItemId,c.fldStrhid from  acc.tblTemplateCoding as c where t.fldTempCodeId.IsDescendantOf(c.fldTempCodeId)=1 and c.fldTempNameId=t.fldTempNameId and c.fldItemId is not null order by c.fldTempCodeId desc)c
	)t2
	inner join acc.tblItemNecessary as i on i.fldId=t2.fldItemId
	order by t2.fldId

	
commit tran
GO
