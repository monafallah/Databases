SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
create PROC [chk].[spr_AghsatCheckAmaniDelete_CheckHayeVaredeId] 
	@CheckHayeVaredeId int,
	@fldUserID int
AS 
	BEGIN TRAN
	DELETE
	FROM   [chk].[tblAghsatCheckAmani]
	WHERE  fldIdCheckHayeVarede = @CheckHayeVaredeId

	COMMIT
GO
