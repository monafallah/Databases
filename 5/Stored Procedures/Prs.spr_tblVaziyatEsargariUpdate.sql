SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Prs].[spr_tblVaziyatEsargariUpdate] 
    @fldId int,
    @fldTitle nvarchar(100),
    @fldMoafAsBime	bit	,
	@fldMoafAsMaliyat	bit	,
	@fldMoafAsBimeOmr bit,
	@fldMoafAsBimeTakmili bit,
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	BEGIN TRAN
	SET @fldTitle=Com.fn_TextNormalize(@fldTitle)
	SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
	UPDATE [Prs].[tblVaziyatEsargari]
	SET    [fldId] = @fldId, [fldTitle] = @fldTitle,  [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = GETDATE(),
	fldMoafAsBime=@fldMoafAsBime,fldMoafAsMaliyat=@fldMoafAsMaliyat,fldMoafAsBimeOmr=@fldMoafAsBimeOmr,fldMoafAsBimeTakmili=@fldMoafAsBimeTakmili
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
