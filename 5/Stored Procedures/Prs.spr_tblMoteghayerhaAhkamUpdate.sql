SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Prs].[spr_tblMoteghayerhaAhkamUpdate] 
    @fldId int,
    @fldYear smallint,
    @fldType bit,
    @fldHagheOlad int,
    @fldHagheAeleMandi int,
    @fldKharoBar int,
    @fldMaskan int,
    @fldKharoBarMojarad int,
    @fldHadaghalDaryafti int,
    @fldHaghBon int,
    @fldUserId int,
    @fldDesc nvarchar(MAX),
	@fldHadaghalTadil int
AS 
	BEGIN TRAN
	SET @fldDesc=com.fn_TextNormalize(@fldDesc)
	UPDATE [Prs].[tblMoteghayerhaAhkam]
	SET    [fldId] = @fldId, [fldYear] = @fldYear, [fldType] = @fldType, [fldHagheOlad] = @fldHagheOlad, [fldHagheAeleMandi] = @fldHagheAeleMandi, [fldKharoBar] = @fldKharoBar, [fldMaskan] = @fldMaskan, [fldKharoBarMojarad] = @fldKharoBarMojarad, [fldHadaghalDaryafti] = @fldHadaghalDaryafti, [fldHaghBon] = @fldHaghBon, [fldUserId] = @fldUserId, [fldDate] = GETDATE(), [fldDesc] = @fldDesc,[fldHadaghalTadil]=@fldHadaghalTadil
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
