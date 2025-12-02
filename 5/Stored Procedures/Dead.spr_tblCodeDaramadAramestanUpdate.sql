SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Dead].[spr_tblCodeDaramadAramestanUpdate] 
    @fldId int,
    @fldCodeDaramadId int,
	@fldOrganId int,
    @fldUserId int,
    @fldIP nvarchar(15),
    @fldDesc nvarchar(100)
AS 

	BEGIN TRAN

	UPDATE [Dead].[tblCodeDaramadAramestan]
	SET    [fldCodeDaramadId] = @fldCodeDaramadId, [fldUserId] = @fldUserId, [fldIP] = @fldIP, [fldDesc] = @fldDesc, [fldDate] = getdate(),fldorganId=@fldOrganId
	WHERE  fldId=@fldId
	if(@@Error<>0)
        rollback   

	COMMIT
GO
