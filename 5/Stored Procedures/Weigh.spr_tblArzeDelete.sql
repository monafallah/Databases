SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Weigh].[spr_tblArzeDelete] 
@fldID int,
@fldUserID int
AS 
	
	BEGIN TRAN
	delete Weigh.tblArze_Detail
	where fldHeaderId=@fldID
	if (@@error<>0)
		rollback
else
begin
	UPDATE [Weigh].[tblArze]
	SET    fldUserId=@fldUserId,flddate=getdate()
	WHERE  fldId=@fldId
	if(@@Error<>0)
        rollback 
	else
	begin  
	  DELETE
	  FROM   [Weigh].[tblArze]
	  where  fldId =@fldId
	  if(@@Error<>0)
          rollback  
	end 
end
	COMMIT
GO
