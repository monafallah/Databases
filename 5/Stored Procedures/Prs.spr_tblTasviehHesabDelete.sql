SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Prs].[spr_tblTasviehHesabDelete] 
@fldID int,
@fldUserID int
AS 
	
	BEGIN TRAN
	UPDATE [Prs].[tblTasviehHesab]
	SET    fldUserId=@fldUserId,flddate=getdate()
	WHERE  fldId=@fldId
	if(@@Error<>0)
        rollback 
	else
	begin  
	  DELETE
	  FROM   [Prs].[tblTasviehHesab]
	  where  fldId =@fldId
	  if(@@Error<>0)
          rollback  
	end 
	COMMIT
GO
