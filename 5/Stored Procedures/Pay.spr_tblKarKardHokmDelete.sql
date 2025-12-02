SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblKarKardHokmDelete] 
	@fldID int,
	@fldUserID int
AS 
	BEGIN TRAN
	DELETE
	FROM   [Pay].[tblKarKardHokm]
	WHERE  fldKarkardId = @fldId

	COMMIT
GO
