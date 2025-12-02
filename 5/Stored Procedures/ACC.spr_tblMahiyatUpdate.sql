SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [ACC].[spr_tblMahiyatUpdate] 
    @fldId int,
    @fldTitle nvarchar(100),
    @fldDesc nvarchar(MAX),
    
    @fldIp varchar(16),
    @fldUserId int
AS 
	BEGIN TRAN
	UPDATE [ACC].[tblMahiyat]
	SET    [fldId] = @fldId, [fldTitle] = @fldTitle, [fldDesc] = @fldDesc, [fldDate] = GETDATE(), [fldIp] = @fldIp, [fldUserId] = @fldUserId
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
