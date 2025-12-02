SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblPropertiesValuesUpdate] 
    @fldId int,
    @fldPropertiesId int,
    @fldElamAvarezId int,
    @fldValue nvarchar(300),
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	BEGIN TRAN
	UPDATE [Drd].[tblPropertiesValues]
	SET    [fldPropertiesId] = @fldPropertiesId, [fldElamAvarezId] = @fldElamAvarezId, [fldValue] = @fldValue, [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = GETDATE()
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
