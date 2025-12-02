SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblTakhfifDetailUpdate] 
    @fldId int,
    @fldTakhfifId int,
    @fldShCodeDaramad int,
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	BEGIN TRAN
	UPDATE [Drd].[tblTakhfifDetail]
	SET    [fldId] = @fldId, [fldTakhfifId] = @fldTakhfifId, [fldShCodeDaramad] = @fldShCodeDaramad, [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = GETDATE()
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
