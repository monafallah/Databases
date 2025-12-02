SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
create proc [Arch].[spr_SelectArchiveTree_Module](@OrganId int,@ModuleId int,@value varchar(10))
as
begin tran
--declare @OrganId int,@ModuleId int,@value varchar(10)


if (@value='0')

	select top(1) * from Arch.tblArchiveTree
	where fldOrganId=@OrganId and fldModuleId=@ModuleId and fldPID is null

else
	select top(1) * from Arch.tblArchiveTree
	where fldOrganId=@OrganId and fldModuleId=@ModuleId and fldPID=@value

commit
GO
