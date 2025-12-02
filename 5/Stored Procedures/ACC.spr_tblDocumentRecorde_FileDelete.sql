SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [ACC].[spr_tblDocumentRecorde_FileDelete] 
@fldID int,
@fldUserID int
AS 
	
	BEGIN TRAN
	declare @fielid int
	select @fielid=fldfileid from acc.tblDocumentRecorde_File
	where fldId=@fldId

	UPDATE [ACC].[tblDocumentRecorde_File]
	SET    fldUserId=@fldUserId,flddate=getdate()
	WHERE  fldId=@fldId
	if(@@Error<>0)
        rollback 
	else
	begin  
	  DELETE
	  FROM   [ACC].[tblDocumentRecorde_File]
	  where  fldId =@fldId
	  if(@@Error<>0)
          rollback  
	  else
	  begin
		  delete from com.tblFile
		  where fldid=@fielid
		   if(@@Error<>0)
			  rollback
	  end

	end 
	COMMIT
GO
