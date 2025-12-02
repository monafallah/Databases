SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblMotalebateParametri_PersonalInsert] 

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
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [Pay].[tblMotalebateParametri_Personal] 
	INSERT INTO [Pay].[tblMotalebateParametri_Personal] ([fldId], [fldPersonalId], [fldParametrId], [fldNoePardakht], [fldMablagh], [fldTedad], [fldTarikhPardakht], [fldMashmoleBime], [fldMashmoleMaliyat], [fldStatus], [fldDateDeactive], [fldUserId], [fldDesc], [fldDate],fldMazayaMashmool)
	SELECT @fldId, @fldPersonalId, @fldParametrId, @fldNoePardakht, @fldMablagh, @fldTedad, @fldTarikhPardakht, @fldMashmoleBime, @fldMashmoleMaliyat, @fldStatus, @fldDateDeactive, @fldUserId, @fldDesc, GETDATE(),@fldMazayaMashmool
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
