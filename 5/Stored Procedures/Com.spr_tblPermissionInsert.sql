SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblPermissionInsert] 

    @fldUserGroup_ModuleOrganID int,
    @fldApplicationPartID int,
    @fldUserID int,
    @fldDesc nvarchar(MAX)
AS 
	
	BEGIN TRAN
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [Com].[tblPermission] 
	INSERT INTO [Com].[tblPermission] ([fldId], [fldUserGroup_ModuleOrganID], [fldApplicationPartID], [fldUserID], [fldDesc], [fldDate])
	SELECT @fldId, @fldUserGroup_ModuleOrganID, @fldApplicationPartID, @fldUserID, @fldDesc, GETDATE()
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
