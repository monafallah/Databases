SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE proc [Drd].[spr_UpdateTarikhFishMotefareghe](@Idfish int,@date datetime,@flduserId int)
as 
begin tran
declare @elamId int
select @elamId=fldElamAvarezId from drd.tblSodoorFish
where fldid=@Idfish 
update
 drd.tblSodoorFish
 set fldDate=@date,fldUserId=@flduserId
where fldid=@Idfish
if (@@ERROR<>0)
	rollback
else
begin
update drd.tblElamAvarez
set fldDate=@date,fldUserId=@flduserId
where fldid=@elamId
if (@@ERROR<>0)
	rollback
end
commit
GO
