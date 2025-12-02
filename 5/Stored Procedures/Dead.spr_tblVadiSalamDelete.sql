SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Dead].[spr_tblVadiSalamDelete] 
@fldID int,
@fldUserID int

AS 
	
	BEGIN TRAN
	
	update [Dead].[tblVadiSalam] set fldUserID=@fldUserID,fldDate=GETDATE()
	where  fldId =@fldId 
	if (@@error<>0)
	rollback
	else
	begin
	DELETE FROM   [Dead].[tblVadiSalam]
	where  fldId =@fldId
	if(@@Error<>0)
        rollback  
	end 
	COMMIT
GO
