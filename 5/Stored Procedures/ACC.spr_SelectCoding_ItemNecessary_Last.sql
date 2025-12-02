SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
create proc  [ACC].[spr_SelectCoding_ItemNecessary_Last]
 @Year smallint,@OrganId int
 as
 begin

 ;with coding
 as
 (
	select d.fldCode,d.fldLevelId,d.fldCodeId,d.fldTitle,d.fldId fldcodingDetailId,i.fldNameItem,i.fldId fldnecid from ACC.tblCoding_Details d inner join acc.tblCoding_Header h
	on d.fldHeaderCodId=h.fldId left join ACC.tblTemplateCoding t
    on t.fldId=d.fldTempCodingId left join ACC.tblItemNecessary i on t.fldItemId=i.fldId  where h.fldYear=@Year and h.fldOrganId=@OrganId
 )--select COUNT(*) from coding
 ,codingitem
 as
 (
	select * from coding where  fldnecid is not null
	union all
	select c1.fldCode,c1.fldLevelId,c1.fldCodeId,c1.fldTitle,c1.fldcodingDetailId,c2.fldNameItem,c2.fldnecid from coding c1 inner join codingitem c2 on c1.fldCodeId.GetAncestor(1)=c2.fldCodeId and c1.fldnecid is null and c1.fldLevelId=c2.fldLevelId+1
 )select * from codingitem order by fldcode

end
GO
