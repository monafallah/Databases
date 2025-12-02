SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Prs].[spr_tblMoteghayerhaAhkamInsert] 
  
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
	declare @fldID int 
	SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
	select @fldID =ISNULL(max(fldId),0)+1 from [Prs].[tblMoteghayerhaAhkam] 
	INSERT INTO [Prs].[tblMoteghayerhaAhkam] ([fldId], [fldYear], [fldType], [fldHagheOlad], [fldHagheAeleMandi], [fldKharoBar], [fldMaskan], [fldKharoBarMojarad], [fldHadaghalDaryafti], [fldHaghBon], [fldUserId], [fldDate], [fldDesc],[fldHadaghalTadil])
	SELECT @fldId, @fldYear, @fldType, @fldHagheOlad, @fldHagheAeleMandi, @fldKharoBar, @fldMaskan, @fldKharoBarMojarad, @fldHadaghalDaryafti, @fldHaghBon, @fldUserId, GETDATE(), @fldDesc,@fldHadaghalTadil
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
