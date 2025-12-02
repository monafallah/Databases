SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
create proc [Com].[spr_CheckExistsKala]
	@fldId int,
	@fldKalaTreeId nvarchar(max)
as
begin
	declare @temp table(id int,groupId int)
	insert @temp
	select item,0 from Com.Split(@fldKalaTreeId,',')
		where Item<>''
	update t set groupId=fldGroupId
	from @temp t inner join tblKalaTree on t.id=fldId
	if exists( select * from com.tblKala inner join com.tblKala_Tree  on tblKala.fldId=tblKala_Tree.fldKalaId  
	inner join tblKalaTree on tblKalaTree.fldId=tblKala_Tree.fldKalaTreeId  inner join @temp as  t
	on t.groupId=tblKalaTree.fldGroupId
	where tblKala.fldId=@fldId)
		select 0 as fldCheck
	else
		select 1 as fldCheck
end

GO
