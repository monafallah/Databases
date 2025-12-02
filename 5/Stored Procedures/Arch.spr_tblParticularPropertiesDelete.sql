SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Arch].[spr_tblParticularPropertiesDelete] 
	@fldID int,
	@fldUserID int
AS 
	BEGIN TRAN
	DELETE
	FROM   [Arch].[tblParticularProperties]
	WHERE  fldId = @fldId

	COMMIT
GO
