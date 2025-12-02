SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Dead].[spr_tblRadifDelete] 
@fldID int,
@fldUserID int
AS 
	
	BEGIN TRAN
	update [Dead].[tblRadif]
	set flduserId=@fldUserID,fldDate=getdate()
	where fldid=@fldid
	if (@@error<>0)
	rollback
	else
	begin
	DELETE
	FROM   [Dead].[tblRadif]
	where  fldId =@fldId
	if(@@Error<>0)
        rollback  
	end	 
	COMMIT
GO
