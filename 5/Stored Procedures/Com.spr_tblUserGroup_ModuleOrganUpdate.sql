SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblUserGroup_ModuleOrganUpdate] 
    @fldId int,
    @fldUserGroupId int,
    @fldModuleOrganId int,
    @fldUserID int,
    @fldDesc nvarchar(MAX)
AS 
	BEGIN TRAN
	UPDATE [Com].[tblUserGroup_ModuleOrgan]
	SET    [fldUserGroupId] = @fldUserGroupId, [fldModuleOrganId] = @fldModuleOrganId, [fldUserID] = @fldUserID, [fldDesc] = @fldDesc, [fldDate] = GETDATE()
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
