SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblUserGroup_ModuleOrganDelete] 
	@fldID int,
	@fldUserID int
AS 
	BEGIN TRAN
	DELETE
	FROM   [Com].[tblUserGroup_ModuleOrgan]
	WHERE  fldId = @fldId

	COMMIT
GO
