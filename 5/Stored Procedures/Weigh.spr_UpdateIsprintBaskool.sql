SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
create proc [Weigh].[spr_UpdateIsprintBaskool]
@id int

as
begin tran
	
	update [Weigh].tblVazn_Baskool
	set fldisPrint=1
	where fldid=@id
	if (@@error<>0)
		rollback

commit
GO
