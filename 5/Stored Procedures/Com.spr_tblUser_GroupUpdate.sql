SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblUser_GroupUpdate] 
    @fldId int,
    @fldUserGroupId int,
    @fldUserSelectId int,
    @fldUserId int,
	@fldGrant bit,
	@fldWithGrant bit,
    @fldDesc nvarchar(MAX)
AS 
	BEGIN TRAN
	SET @fldDesc=Com.fn_TextNormalize(@flddesc)
	UPDATE [Com].[tblUser_Group]
	SET    [fldId] = @fldId, [fldUserGroupId] = @fldUserGroupId, [fldUserSelectId] = @fldUserSelectId, [fldUserId] = @fldUserId,[fldGrant]=@fldGrant,[fldWithGrant]=@fldWithGrant, [fldDesc] = @fldDesc, [fldDate] = GETDATE()
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
