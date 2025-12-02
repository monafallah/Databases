SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [BUD].[spr_tblTahodatSanavatiUpdate] 
    @fldId int,
    @fldD1 bigint = NULL,
    @fldD2 bigint = NULL,
    @fldD3 bigint = NULL,
    @fldH1 bigint = NULL,
    @fldH2 bigint = NULL,
    @fldH3 bigint = NULL,
    @fldH4 bigint = NULL,
    @fldUserId int,
    @fldIp varchar(15)
AS 
	BEGIN TRAN
	UPDATE [BUD].[tblTahodatSanavati]
	SET    [fldD1] = @fldD1, [fldD2] = @fldD2, [fldD3] = @fldD3, [fldH1] = @fldH1, [fldH2] = @fldH2, [fldH3] = @fldH3, [fldH4] = @fldH4, [fldUserId] = @fldUserId, [fldIp] = @fldIp, [fldDate] = getdate()
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
