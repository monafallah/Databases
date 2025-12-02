SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [chk].[spr_tblCheckHayeVaredeDelete] 
	@fldID int,
	@fldUserID int
AS 
	BEGIN TRAN
	DELETE
	FROM   [drd].[tblCheck]
	WHERE  fldId = @fldId
	if (@@ERROR<>0)
	rollback
	COMMIT
GO
