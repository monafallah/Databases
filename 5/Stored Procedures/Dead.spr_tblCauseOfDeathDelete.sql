SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Dead].[spr_tblCauseOfDeathDelete] 
@fldID int,
@fldUserID int
AS 
	
	BEGIN TRAN
	update [Dead].[tblCauseOfDeath] set fldUserID=@fldUserID,fldDate=GETDATE()
	where  fldId =@fldId
	DELETE
	FROM   [Dead].[tblCauseOfDeath]
	where  fldId =@fldId
	if(@@Error<>0)
        rollback   
	COMMIT
GO
