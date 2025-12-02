SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblShomareHesabCodeDaramadDelete] 
	@fldID int,
	@fldUserID int
AS 
	BEGIN TRAN
	delete from drd.tblShomareHesab_Formula
	where fldShomareHesab_CodeId=@fldID
	if (@@ERROR<>0)
		rollback
	else
	begin
	UPDATE      [Drd].[tblShomareHesabCodeDaramad]
	SET fldUserId=@fldUserId , flddate=GETDATE()
	WHERE  fldId = @fldId
		if (@@ERROR<>0)
		rollback
	DELETE
	FROM   [Drd].[tblShomareHesabCodeDaramad]
	WHERE  fldId = @fldId
	if (@@ERROR<>0)
		rollback

	end
	COMMIT
GO
