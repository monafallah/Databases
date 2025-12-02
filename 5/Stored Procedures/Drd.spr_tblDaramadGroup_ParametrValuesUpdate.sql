SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblDaramadGroup_ParametrValuesUpdate] 
    @fldId int,
    @fldElamAvarezId int,
    @fldParametrGroupDaramadId int,
    @fldValue nvarchar(MAX),
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	BEGIN TRAN
	
	SET @fldDesc=com.fn_TextNormalize(@fldDesc)
	UPDATE [Drd].[tblDaramadGroup_ParametrValues]
	SET    [fldId] = @fldId, [fldElamAvarezId] = @fldElamAvarezId, [fldParametrGroupDaramadId] = @fldParametrGroupDaramadId, [fldValue] = @fldValue, [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = GETDATE()
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
