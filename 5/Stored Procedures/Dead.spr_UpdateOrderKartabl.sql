SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
create proc [Dead].[spr_UpdateOrderKartabl]
@kartablid int,
@orderid int,
@userId int

as 
begin tran
update dead.tblKartabl
set fldOrderId=@orderid,fldUserId =@userId,fldDate=getdate()
where fldid=@kartablid
if (@@Error<>0)
rollback
commit
GO
