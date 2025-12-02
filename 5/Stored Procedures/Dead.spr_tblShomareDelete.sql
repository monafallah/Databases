SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Dead].[spr_tblShomareDelete] 
@fldID int,
@fldUserID int
AS 
	
	BEGIN TRAN
	update  [Dead].[tblShomare]
	set flduserId=@fldUserID,fldDate=getdate()
	where fldid=@fldID
	if (@@error<>0)
	rollback
	else
	begin
	DELETE
	FROM   [Dead].[tblShomare]
	where  fldId =@fldId
	if(@@Error<>0)
        rollback   
	end
	COMMIT
GO
