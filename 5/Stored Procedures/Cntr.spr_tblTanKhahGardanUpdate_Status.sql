SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
create PROC [Cntr].[spr_tblTanKhahGardanUpdate_Status] 
    @fldId int,
   
    @fldStatus bit,
    @fldOrganId int,
    @fldUserId int,
 
 
    @fldIP varchar(15)
AS 
	 
	
	BEGIN TRAN

	UPDATE [Cntr].[tblTanKhahGardan]
	SET   [fldStatus] = @fldStatus, [fldOrganId] = @fldOrganId, [fldUserId] = @fldUserId, [fldDate] = getdate(), [fldIP] = @fldIP
	WHERE  [fldId] = @fldId
	
	if (@@error<>0)
		rollback

	COMMIT
GO
