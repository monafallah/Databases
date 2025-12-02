SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblTakhfifUpdate] 
    @fldId int,
    @fldShomareMojavez nvarchar(50),
    @fldTarikhMojavez nvarchar(10),
    @fldAzTarikh nvarchar(10),
    @fldTaTarikh nvarchar(10),
    @fldTakhfifKoli decimal(5, 2),
    @fldTakhfifNaghdi decimal(5, 2),
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	BEGIN TRAN
	UPDATE [Drd].[tblTakhfif]
	SET    [fldId] = @fldId, [fldShomareMojavez] = @fldShomareMojavez, [fldTarikhMojavez] = @fldTarikhMojavez, [fldAzTarikh] = @fldAzTarikh, [fldTaTarikh] = @fldTaTarikh, [fldTakhfifKoli] = @fldTakhfifKoli, [fldTakhfifNaghdi] = @fldTakhfifNaghdi, [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = GETDATE()
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
