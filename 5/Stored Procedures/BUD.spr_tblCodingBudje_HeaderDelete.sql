SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [BUD].[spr_tblCodingBudje_HeaderDelete] 
@fldID int,
@fldUserID int
AS 
	
	BEGIN TRAN
	delete from bud.tblCodingBudje_Details
	where fldHeaderId=@fldid
	if(@@Error<>0)
        rollback 
		else

		begin
	UPDATE [BUD].[tblCodingBudje_Header]
	SET    fldUserId=@fldUserId,flddate=getdate()
	WHERE  fldHedaerId=@fldId
	if(@@Error<>0)
        rollback 
	else
	begin  
	  DELETE
	  FROM   [BUD].[tblCodingBudje_Header]
	  where  fldHedaerId =@fldId
	  if(@@Error<>0)
          rollback  
	end 
end
	COMMIT
GO
