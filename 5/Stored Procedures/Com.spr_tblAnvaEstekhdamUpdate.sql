SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblAnvaEstekhdamUpdate] 
    @fldId int,
    @fldTitle nvarchar(300),
    @fldNoeEstekhdamId int,
	@fldPatternNoeEstekhdamId int,
    @fldUserId int,
    @fldDesc nvarchar(MAX),
	@fldTypeEstekhdamFormul tinyint 
AS 
	BEGIN TRAN
	SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
	SET @fldTitle=Com.fn_TextNormalize(@fldTitle)
	UPDATE  [Com].[tblAnvaEstekhdam]
	SET    [fldId] = @fldId, [fldTitle] = @fldTitle, [fldNoeEstekhdamId] = @fldNoeEstekhdamId, [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = GETDATE()
	,fldPatternNoeEstekhdamId=@fldPatternNoeEstekhdamId,fldTypeEstekhdamFormul=@fldTypeEstekhdamFormul
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
