SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblCodhayeDaramdDelete] 
	@fldID int,
	@fldUserID int
AS 
	BEGIN TRAN
	delete from drd.tblShomareHedabCodeDaramd_Detail
	where fldCodeDaramdId=@fldID
	if (@@ERROR<>0)
	rollback
	else
	begin
	UPDATE   [Drd].[tblCodhayeDaramd]
		SET fldUserId=@fldUserId , flddate=GETDATE()
		WHERE  fldId = @fldId
		if (@@ERROR<>0)
		rollback
	else
		begin
	DELETE
	FROM   [Drd].[tblCodhayeDaramd]
	WHERE  fldId = @fldId
	if (@@ERROR<>0)
		rollback
		end
	end
	COMMIT
GO
