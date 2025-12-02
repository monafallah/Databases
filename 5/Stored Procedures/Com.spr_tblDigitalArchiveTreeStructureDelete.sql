SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblDigitalArchiveTreeStructureDelete] 
	@fldID int,
	@fldUserID int
AS 
	BEGIN TRAN
	DELETE
	FROM   [Com].[tblDigitalArchiveTreeStructure]
	WHERE  fldId = @fldId

	COMMIT
GO
