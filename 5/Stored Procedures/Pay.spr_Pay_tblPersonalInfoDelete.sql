SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_Pay_tblPersonalInfoDelete] 
	@fldID int,
	@fldUserID int
AS 
	BEGIN TRAN
	delete from  com.tblPersonalStatus
	where fldPayPersonalInfoId=@fldid
	if (@@error<>0)
	rollback 
	else 
	begin

	DELETE
	FROM   [Pay].[Pay_tblPersonalInfo]
	WHERE  fldId = @fldId
	if (@@error<>0)
	rollback 
	end 
	COMMIT
GO
