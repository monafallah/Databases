SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROC [Drd].[spr_tblParametreSabet_ValueUpdate] 
    @fldID int,
    @fldElamAvarezId int,
    @fldValue nvarchar(300),
    @fldParametreSabetId int,
    @fldUserId int,
    @fldDesc nvarchar(MAX),
    @fldCodeDaramadElamAvarezId int
AS 
	BEGIN TRAN
	set @fldValue=com.fn_TextNormalize(@fldValue)
	set @fldDesc=com.fn_TextNormalize(@fldDesc)
	UPDATE [Drd].[tblParametreSabet_Value]
	SET    [fldElamAvarezId] = @fldElamAvarezId, [fldValue] = @fldValue, [fldParametreSabetId] = @fldParametreSabetId, [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = getdate(),fldCodeDaramadElamAvarezId=@fldCodeDaramadElamAvarezId
	WHERE  [fldID] = @fldID
	COMMIT TRAN
GO
