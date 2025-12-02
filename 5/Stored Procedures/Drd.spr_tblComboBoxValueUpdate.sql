SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblComboBoxValueUpdate] 
    @fldId int,
    @fldComboBoxId int,
    @fldTitle nvarchar(100),
    @fldValue nvarchar(100),
    @fldUserId int,
    @fldDesc nvarchar(MAX)

AS 
	BEGIN TRAN
	set @fldTitle=com.fn_TextNormalize(@fldTitle)
	set @fldValue=com.fn_TextNormalize(@fldValue)
	set @fldDesc=com.fn_TextNormalize(@fldDesc)
	UPDATE [Drd].[tblComboBoxValue]
	SET    [fldComboBoxId] = @fldComboBoxId, [fldTitle] = @fldTitle, [fldValue] = @fldValue, [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = getdate()
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
