SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblUserGroup_ModuleOrganInsert] 

    @fldUserGroupId int,
    @fldModuleOrganId int,
    @fldUserID int,
    @fldDesc nvarchar(MAX)
AS 
	
	BEGIN TRAN
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [Com].[tblUserGroup_ModuleOrgan] 
	INSERT INTO [Com].[tblUserGroup_ModuleOrgan] ([fldId], [fldUserGroupId], [fldModuleOrganId], [fldUserID], [fldDesc], [fldDate])
	SELECT @fldId, @fldUserGroupId, @fldModuleOrganId, @fldUserID, @fldDesc, GETDATE()
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
