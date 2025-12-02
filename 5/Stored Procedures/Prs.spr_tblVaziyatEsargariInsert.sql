SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Prs].[spr_tblVaziyatEsargariInsert] 

    @fldTitle nvarchar(100),
    @fldMoafAsBime	bit	,
	@fldMoafAsMaliyat	bit	,
	@fldMoafAsBimeOmr bit,
	@fldMoafAsBimeTakmili bit,
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	
	BEGIN TRAN
	declare @fldID int 
	SET @fldTitle=Com.fn_TextNormalize(@fldTitle)
	SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
	select @fldID =ISNULL(max(fldId),0)+1 from [Prs].[tblVaziyatEsargari] 
	INSERT INTO [Prs].[tblVaziyatEsargari] ([fldId], [fldTitle],fldMoafAsBime,fldMoafAsMaliyat, [fldUserId], [fldDesc], [fldDate],fldMoafAsBimeOmr,fldMoafAsBimeTakmili)
	SELECT @fldId, @fldTitle, @fldMoafAsBime,@fldMoafAsMaliyat, @fldUserId, @fldDesc, GETDATE(),@fldMoafAsBimeOmr,@fldMoafAsBimeTakmili
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
