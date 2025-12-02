SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblPermissionDelete] 
	@fldID int,	
	@fldModuleId INT,
	@fldUserID INT

AS 
	BEGIN TRAN
	UPDATE   [Com].[tblPermission]/*قبلن کامنت بود*/
	SET fldUserId=@fldUserId , flddate=GETDATE()
	WHERE  fldUserGroup_ModuleOrganID = @fldId --AND fldApplicationPartID IN (SELECT fldId FROM Com.tblApplicationPart WHERE fldModuleId=@fldModuleId)
	if (@@ERROR<>0)
		rollback
	else
	begin
	DELETE
	FROM   [Com].[tblPermission]
	WHERE  fldUserGroup_ModuleOrganID = @fldId --AND fldApplicationPartID IN (SELECT fldId FROM Com.tblApplicationPart WHERE fldModuleId=4)
	if (@@ERROR<>0)
		rollback
	end
	COMMIT
GO
