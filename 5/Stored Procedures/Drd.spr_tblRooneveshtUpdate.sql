SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROC [Drd].[spr_tblRooneveshtUpdate] 
    @fldId int,
    @fldShomareHesabCodeDaramadId int,
    @fldTitle nvarchar(400),
    @fldUserId int,
    @fldDesc nvarchar(MAX) 
AS 
	BEGIN TRAN
	set @fldTitle=com.fn_TextNormalize(@fldTitle)
	set @fldDesc=com.fn_TextNormalize(@fldDesc)
	UPDATE [Drd].[tblRoonevesht]
	SET    [fldShomareHesabCodeDaramadId] = @fldShomareHesabCodeDaramadId, [fldTitle] = @fldTitle, [fldUserId] = @fldUserId, [fldDate] = getDate(), [fldDesc] = @fldDesc
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
