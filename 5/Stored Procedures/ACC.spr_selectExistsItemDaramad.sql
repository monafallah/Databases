SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
	create proc [ACC].[spr_selectExistsItemDaramad](@id int ,@headerId int)
	as 
	declare @tempid int
	select @tempid=parent.fldTempCodingId from  acc.tblCoding_Details child inner join
				 acc.tblCoding_Details parent on child.fldId=@id and child.fldCodeId.IsDescendantOf(parent.fldCodeId)=1
				 and parent.fldLevelId=1 and parent.fldHeaderCodId=@headerId


	select  parent.fldid as fldItemId from ACC.tblItemNecessary child inner join
	ACC.tblItemNecessary parent on  child.fldItemId.IsDescendantOf(parent.fldItemId)=1
	inner join acc.tblTemplateCoding t on t.fldItemId=child.fldId
	where t.fldid=@tempid  and parent.fldLevelId=1


GO
