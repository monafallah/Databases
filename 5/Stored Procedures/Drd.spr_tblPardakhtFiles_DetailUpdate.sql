SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblPardakhtFiles_DetailUpdate] 
    @fldId int,
    @fldShenaseGhabz nvarchar(100),
    @fldShenasePardakht nvarchar(100),
    @fldTarikhPardakht nvarchar(10),
    @fldCodeRahgiry nvarchar(100),
    @fldNahvePardakhtId int,
    @fldPardakhtFileId int,
    @fldOrganId int,
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	BEGIN TRAN
	set @fldShenaseGhabz=com.fn_TextNormalize(@fldShenaseGhabz)
	set @fldShenasePardakht=com.fn_TextNormalize(@fldShenasePardakht)
	set @fldTarikhPardakht=com.fn_TextNormalize(@fldTarikhPardakht)
	set @fldCodeRahgiry=com.fn_TextNormalize(@fldCodeRahgiry)
	set @fldDesc=com.fn_TextNormalize(@fldDesc)
	UPDATE [Drd].[tblPardakhtFiles_Detail]
	SET    [fldShenaseGhabz] = @fldShenaseGhabz, [fldShenasePardakht] = @fldShenasePardakht, [fldTarikhPardakht] = @fldTarikhPardakht, [fldCodeRahgiry] = @fldCodeRahgiry, [fldNahvePardakhtId] = @fldNahvePardakhtId, [fldPardakhtFileId] = @fldPardakhtFileId, [fldOrganId] = @fldOrganId, [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = GETDATE()
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
