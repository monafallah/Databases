SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
create proc [Dead].[spr_UpdateRequestForEbtal]
@fldId int,
@fldUserId int,
@fldIP nvarchar(15)
as
begin tran

update dead.tblRequestAmanat
set fldIsEbtal=1,fldUserId=@fldUserId,fldDate=getdate(),fldIP=@fldIP
where fldid=@fldid
if (@@error<>0)
rollback
commit
GO
