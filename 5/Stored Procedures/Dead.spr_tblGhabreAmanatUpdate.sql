SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Dead].[spr_tblGhabreAmanatUpdate] 
    @fldId int,
    @fldShomareId int,
   -- @fldShomareTabaghe tinyint,
    @fldEmployeeId int,
    @fldOrganId int,
    @fldTarikhRezerv int = NULL,
    @fldUserId int,
    @fldDesc nvarchar(100),
    @fldIP nvarchar(15)
AS 

	BEGIN TRAN
	set @fldDesc=com.fn_TextNormalize(@fldDesc)
	UPDATE [Dead].[tblGhabreAmanat]
	SET    [fldShomareId] = @fldShomareId/*, [fldShomareTabaghe] = @fldShomareTabaghe*/, [fldEmployeeId] = @fldEmployeeId, [fldOrganId] = @fldOrganId, [fldTarikhRezerv] = @fldTarikhRezerv, [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = GETDATE(), [fldIP] = @fldIP
	WHERE  fldId=@fldId
	if(@@Error<>0)
        rollback   

	COMMIT
GO
