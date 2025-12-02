SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Prs].[spr_tblSavabeghGroupTashvighiUpdate] 
    @fldId int,
    @fldPersonalId int,
    @fldAnvaGroupId tinyint,
    @fldTedadGroup tinyint,
    @fldTarikh char(10),
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	BEGIN TRAN
	SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
	UPDATE [Prs].[tblSavabeghGroupTashvighi]
	SET    [fldId] = @fldId, [fldPersonalId] = @fldPersonalId, [fldAnvaGroupId] = @fldAnvaGroupId, [fldTedadGroup] = @fldTedadGroup, [fldTarikh] = @fldTarikh, [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = GETDATE()
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
