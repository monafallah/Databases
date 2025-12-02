SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblTypeEstekhdam_UserGroupDelete] 
@fldUseGroupId int,
@fldUserID int,
@organId int
AS 

	BEGIN TRAN
	UPDATE [Pay].[tblTypeEstekhdam_UserGroup]
	SET    fldUserId=@fldUserId,flddate=getdate()
	WHERE  fldUseGroupId=@fldUseGroupId and fldOrganId=@organId
	if(@@Error<>0)
        rollback 
	else
	begin  
	  DELETE
	  FROM   [Pay].[tblTypeEstekhdam_UserGroup]
	  where  fldUseGroupId =@fldUseGroupId  and fldOrganId=@organId
	  if(@@Error<>0)
          rollback  
	end 
	COMMIT
GO
