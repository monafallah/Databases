SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblEzafeKari_TatilKariInsert] 

    @fldPersonalId int,
    @fldYear smallint,
    @fldMonth tinyint,
    @fldNobatePardakht tinyint,
    @fldCount DECIMAL(6,3),
    @fldType tinyint,
    @fldHasBime	bit	,
	@fldHasMaliyat	bit,

    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	
	BEGIN TRAN
	declare @fldID INT
	SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
	select @fldID =ISNULL(max(fldId),0)+1 from [Pay].[tblEzafeKari_TatilKari] 
	INSERT INTO [Pay].[tblEzafeKari_TatilKari] ([fldId], [fldPersonalId], [fldYear], [fldMonth], [fldNobatePardakht], [fldCount], [fldType], [fldUserId], [fldDate], [fldDesc],fldHasBime,fldHasMaliyat)
	SELECT @fldId, @fldPersonalId, @fldYear, @fldMonth, @fldNobatePardakht, @fldCount, @fldType, @fldUserId, GETDATE(), @fldDesc,@fldHasBime,@fldHasMaliyat

	
	IF (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
