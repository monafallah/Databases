SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblPermissionUpdate] 
    @fldId int,
    @fldUserGroup_ModuleOrganID int,
    @fldApplicationPartID int,
    @fldUserID int,
    @fldDesc nvarchar(MAX)
AS 
	BEGIN TRAN
	UPDATE [Com].[tblPermission]
	SET    [fldId] = @fldId, [fldUserGroup_ModuleOrganID] = @fldUserGroup_ModuleOrganID, [fldApplicationPartID] = @fldApplicationPartID, [fldUserID] = @fldUserID, [fldDesc] = @fldDesc, [fldDate] = GETDATE()
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
