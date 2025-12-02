SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Dead].[spr_tblGheteDelete] 
@fldID int,
@fldUserID int
AS 
	
	BEGIN TRAN
	update  [Dead].[tblGhete]
	set flduserid=@fldUserID ,fldDate=getdate()
	where fldid=@fldid
	if (@@ERROR<>0)
	rollback
	else
	begin
		DELETE
		FROM   [Dead].[tblGhete]
		where  fldId =@fldId
		if(@@Error<>0)
			rollback   
	end
	COMMIT
GO
