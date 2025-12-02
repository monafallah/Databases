SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE proc [Com].[spr_UpdateActiveUser](@id int,@Active_Deactive bit)
as
begin tran
update tbluser
set fldActive_Deactive =@Active_Deactive ,fldDate =getdate(),fldDesc=fldDesc+N'_رمز اشتباه'
where fldid=@id
if (@@error<>0)
rollback

commit
GO
