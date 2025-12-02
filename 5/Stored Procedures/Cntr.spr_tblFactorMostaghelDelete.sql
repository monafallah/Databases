SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Cntr].[spr_tblFactorMostaghelDelete] 
    @fldId int,
	@fldUserId int
AS 
	
	
	BEGIN TRAN
	UPDATE [Cntr].[tblFactorMostaghel]
	SET    fldUserId=@fldUserId,fldDate=getdate()
	WHERE  [fldId] = @fldId
	if (@@error<>0)
		rollback
	
	DELETE
	FROM   [Cntr].[tblFactorMostaghel]
	WHERE  [fldId] = @fldId
	if (@@error<>0)
		rollback
	COMMIT
GO
