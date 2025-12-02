SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblSpecialPermissionInsert] 
  
    @fldUserSelectId int,
    @fldChartOrganId int,
    @fldOpertionId int,
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	
	BEGIN TRAN
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [Pay].[tblSpecialPermission] 
	INSERT INTO [Pay].[tblSpecialPermission] ([fldId], [fldUserSelectId], [fldChartOrganId], [fldOpertionId], [fldUserId], [fldDesc], [fldDate])
	SELECT @fldId, @fldUserSelectId, @fldChartOrganId, @fldOpertionId, @fldUserId, @fldDesc, GETDATE()
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
