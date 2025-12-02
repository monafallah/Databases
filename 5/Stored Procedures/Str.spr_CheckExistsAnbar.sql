SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE proc [Str].[spr_CheckExistsAnbar]
	@fldId int,
	@fldAnbarTreeId nvarchar(max)
as
begin
	declare @temp table(id int,groupId int)
	insert @temp
	select item,0 from Com.Split(@fldAnbarTreeId,',')
		where Item<>''
	update t set groupId=fldGroupId
	from @temp t inner join tblAnbarTree on t.id=fldId
	if exists( select * from str.tblAnbar inner join Str.tblAnbar_Tree  on tblAnbar.fldId=tblAnbar_Tree.fldAnbarId  
	inner join tblAnbarTree on tblAnbarTree.fldId=tblAnbar_Tree.fldAnbarTreeId  inner join @temp as  t
	on t.groupId=tblAnbarTree.fldGroupId
	where tblAnbar.fldId=@fldId)
		select 0 as fldCheck
	else
		select 1 as fldCheck
end

GO
