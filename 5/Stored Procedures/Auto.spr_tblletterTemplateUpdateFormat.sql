SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE proc [Auto].[spr_tblletterTemplateUpdateFormat](@id int,@fldformat nvarchar(max),@userId int)
as 
begin tran 
update 
auto.tblletterTemplate
set fldformat=@fldformat,fldUserId=@userId
where fldid=@id
if (@@error<>0)
rollback
commit
GO
