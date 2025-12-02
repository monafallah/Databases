SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblMotalebateParametri_PersonalUpdate] 
    @fldId int,
    @fldPersonalId int,
    @fldParametrId int,
    @fldNoePardakht bit,
    @fldMablagh int,
    @fldTedad int,
    @fldTarikhPardakht nvarchar(10),
    @fldMashmoleBime bit,
	@fldMazayaMashmool bit,
    @fldMashmoleMaliyat bit,
    @fldStatus bit,
    @fldDateDeactive int,
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	BEGIN TRAN
	SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
	UPDATE [Pay].[tblMotalebateParametri_Personal]
	SET    [fldId] = @fldId, [fldPersonalId] = @fldPersonalId, [fldParametrId] = @fldParametrId, [fldNoePardakht] = @fldNoePardakht, [fldMablagh] = @fldMablagh, [fldTedad] = @fldTedad, [fldTarikhPardakht] = @fldTarikhPardakht, [fldMashmoleBime] = @fldMashmoleBime, [fldMashmoleMaliyat] = @fldMashmoleMaliyat, [fldStatus] = @fldStatus, [fldDateDeactive] = @fldDateDeactive, [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = GETDATE()
	,fldMazayaMashmool=@fldMazayaMashmool
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
