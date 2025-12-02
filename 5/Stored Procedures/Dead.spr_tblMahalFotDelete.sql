SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Dead].[spr_tblMahalFotDelete] 
@fldID int,
@fldUserID int
AS 
	
	BEGIN TRAN
	update [Dead].[tblMahalFot]
	set fldUserId=@fldUserID,fldDate=getdate()
	where fldid=@fldid
	if (@@error<>0)
	rollback
	else
	begin
	DELETE
	FROM   [Dead].[tblMahalFot]
	where  fldId =@fldId
	if(@@Error<>0)
        rollback 
	end  
	COMMIT
GO
