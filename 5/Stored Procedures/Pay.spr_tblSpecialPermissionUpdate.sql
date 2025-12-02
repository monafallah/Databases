SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblSpecialPermissionUpdate] 
    @fldId int,
    @fldUserSelectId int,
    @fldChartOrganId int,
    @fldOpertionId int,
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	BEGIN TRAN
	UPDATE [Pay].[tblSpecialPermission]
	SET    [fldUserSelectId] = @fldUserSelectId, [fldChartOrganId] = @fldChartOrganId, [fldOpertionId] = @fldOpertionId, [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = GETDATE()
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
