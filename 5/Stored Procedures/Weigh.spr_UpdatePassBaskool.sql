SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
create proc [Weigh].[spr_UpdatePassBaskool] (@fldid int ,@Pass nvarchar(100),@userId int)
as
begin tran

update Weigh.tblWeighbridge
set fldPassword=@Pass ,fldUserId=@userId,fldDate=getdate()
where fldid=@fldid
if (@@error<>0)
rollback

commit
GO
