SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblMonasebatHeaderDelete] 
	@fldID int,
	@fldUserID int
AS 
	BEGIN TRAN
	DELETE
	FROM   [Pay].[tblMonasebatMablagh]
	WHERE  fldHeaderId = @fldId
	if (@@error<>0)
		rollback
		else
		begin
			update   [Pay].[tblMonasebatHeader] set [fldUserId] = @fldUserId, [fldDate] =  getdate()
			WHERE  fldId = @fldId
			DELETE
			FROM   [Pay].[tblMonasebatHeader]
			WHERE  fldId = @fldId
		end

	COMMIT
GO
