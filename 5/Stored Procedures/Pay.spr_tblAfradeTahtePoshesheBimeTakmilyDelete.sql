SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblAfradeTahtePoshesheBimeTakmilyDelete] 
	@fldID int,
	@fldUserID int
AS 
	BEGIN TRAN
	  DELETE
	  FROM   [Pay].[tblAfradeTahtePoshesheBimeTakmily_Details]
	  where  fldBimeTakmiliId =@fldId
	  if(@@Error<>0)
          rollback  
		  else
		  begin
			UPDATE  [Pay].[tblAfradeTahtePoshesheBimeTakmily]
			SET fldUserId=@fldUserId , flddate=GETDATE()
			WHERE  fldId = @fldId
			DELETE
			FROM   [Pay].[tblAfradeTahtePoshesheBimeTakmily]
			WHERE  fldId = @fldId
			if(@@Error<>0)
				rollback  
		end
	COMMIT
GO
