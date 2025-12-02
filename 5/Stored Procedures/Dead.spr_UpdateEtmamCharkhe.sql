SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE proc [Dead].[spr_UpdateEtmamCharkhe]
@fldId int,
@UserId int,
@IP nvarchar(15)
as
begin tran
update dead.tblKartabl_Request
set fldEtmamcharkhe=1,fldUserId=@UserId,fldDate=getdate(),fldIP=@IP
where fldid=@fldid
if (@@error<>0)
rollback
commit
GO
