SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Cntr].[spr_tblTanKhahGardanDelete] 
    @fldId int,
	@fldUserId int
AS 
	
	
	BEGIN TRAN
	UPDATE [Cntr].[tblTanKhahGardan]
	SET    fldUserId=@fldUserId,fldDate=getdate()
	WHERE  [fldId] = @fldId
	if (@@error<>0)
		rollback
	
	DELETE
	FROM   [Cntr].[tblTanKhahGardan]
	WHERE  [fldId] = @fldId
	if (@@error<>0)
		rollback
	COMMIT
GO
