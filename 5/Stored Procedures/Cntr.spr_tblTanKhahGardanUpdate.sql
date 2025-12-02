SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Cntr].[spr_tblTanKhahGardanUpdate] 
    @fldId int,
    @fldEmployeeId int,
   
    @fldOrganId int,
    @fldUserId int,
    @fldDesc nvarchar(150),
 
    @fldIP varchar(15)
AS 
	 
	
	BEGIN TRAN
	SET @fldDesc=com.fn_TextNormalize(@fldDesc)
	UPDATE [Cntr].[tblTanKhahGardan]
	SET    [fldEmployeeId] = @fldEmployeeId,  [fldOrganId] = @fldOrganId, [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = getdate(), [fldIP] = @fldIP
	WHERE  [fldId] = @fldId
	
	if (@@error<>0)
		rollback

	COMMIT
GO
