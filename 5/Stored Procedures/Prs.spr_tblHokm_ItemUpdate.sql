SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Prs].[spr_tblHokm_ItemUpdate] 
    @fldId int,
    @fldPersonalHokmId int,
    @fldItems_EstekhdamId int,
    @fldMablagh int,
    @fldZarib decimal(6, 3),
    @fldUserId int,
   
    @fldDesc nvarchar(MAX)
AS 
	BEGIN TRAN
	SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
	UPDATE [Prs].[tblHokm_Item]
	SET    [fldId] = @fldId, [fldPersonalHokmId] = @fldPersonalHokmId, [fldItems_EstekhdamId] = @fldItems_EstekhdamId, [fldMablagh] = @fldMablagh, [fldZarib] = @fldZarib, [fldUserId] = @fldUserId, [fldDate] = GETDATE(), [fldDesc] = @fldDesc
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
