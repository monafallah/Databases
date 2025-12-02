SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
create proc [Dead].[spr_RefreshGhabrInfo]

as 
begin try
begin tran


--exec  dead.spr_InsertGhabrInfoFromAramBD


--exec  dead.spr_DeleteGhabrInfoNotAramBD


commit
end try 

begin catch 

rollback

end  catch 
GO
