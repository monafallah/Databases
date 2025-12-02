SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Cntr].[spr_tblFactorMostaghelUpdate] 
    @fldId int,
    @fldFactorId int,
    @fldAshkhasId int,
    @fldBudjeCodingId int,
    @fldTankhahId int = NULL,
    @fldUserId int,
    @fldOrganID int,
    @fldIP varchar(16),
    @fldDesc nvarchar(200)
AS 
	 
	
	BEGIN TRAN

	UPDATE [Cntr].[tblFactorMostaghel]
	SET    [fldFactorId] = @fldFactorId, [fldAshkhasId] = @fldAshkhasId, [fldBudjeCodingId] = @fldBudjeCodingId, [fldTankhahGroupId] = @fldTankhahId, [fldUserId] = @fldUserId, [fldOrganID] = @fldOrganID, [fldIP] = @fldIP, [fldDesc] = @fldDesc, [fldDate] = getdate()
	WHERE  [fldId] = @fldId
	
	if (@@error<>0)
		rollback

	COMMIT
GO
