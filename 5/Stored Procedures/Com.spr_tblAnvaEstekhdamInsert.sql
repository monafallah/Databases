SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblAnvaEstekhdamInsert] 

    @fldTitle nvarchar(300),
    @fldNoeEstekhdamId int,
	@fldPatternNoeEstekhdamId int,
    @fldUserId int,
    @fldDesc nvarchar(MAX),
	@fldTypeEstekhdamFormul tinyint
AS 
	
	BEGIN TRAN
	declare @fldID int 
	SET @fldTitle=Com.fn_TextNormalize(@fldTitle)
	SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
	select @fldID =ISNULL(max(fldId),0)+1 from  [Com].[tblAnvaEstekhdam] 
	INSERT INTO  [Com].[tblAnvaEstekhdam] ([fldId], [fldTitle], [fldNoeEstekhdamId], [fldUserId], [fldDesc], [fldDate],fldPatternNoeEstekhdamId,fldTypeEstekhdamFormul)
	SELECT @fldId, @fldTitle, @fldNoeEstekhdamId, @fldUserId, @fldDesc, GETDATE(),@fldPatternNoeEstekhdamId,@fldTypeEstekhdamFormul
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
