SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [chk].[spr_tblSodorCheckDelete] 
	@fldID int,
	@fldUserID int
AS 
	BEGIN TRAN
	update  [chk].[tblSodorCheck]
	set fldUserId=@fldUserID ,fldDate=getdate()
	where 	  fldId = @fldId
	if (@@ERROR<>0)
		rollback 
	else
	begin 
		delete from [chk].[tblCheck_Factor]
		WHERE    [fldCheckSadereId] =@fldId
		if (@@ERROR<>0)
			rollback
		else
		begin 
			DELETE
			FROM   [chk].[tblSodorCheck]
			WHERE  fldId = @fldId
			if (@@ERROR<>0)
			rollback
		end 
	end 
	COMMIT
GO
