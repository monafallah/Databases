SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROC [Drd].[spr_tblParametreSabetUpdate] 
    @fldId int,
    @fldShomareHesabCodeDaramadId int,
    @fldNameParametreFa nvarchar(100),
    @fldNameParametreEn varchar(100),
    @fldNoe bit,
    @fldNoeField tinyint,
    @fldVaziyat bit,
    @fldComboBaxId int,
    @fldUserId int,
    @fldDesc nvarchar(MAX),
	@fldTypeParametr bit
  
AS 
	BEGIN TRAN
    set @fldNameParametreFa=com.fn_TextNormalize(@fldNameParametreFa)
	set @fldNameParametreEn=com.fn_TextNormalize(@fldNameParametreEn)
	set @fldDesc=com.fn_TextNormalize(@fldDesc)
	UPDATE [Drd].[tblParametreSabet]
	SET    [fldShomareHesabCodeDaramadId] = @fldShomareHesabCodeDaramadId, [fldNameParametreFa] = @fldNameParametreFa, [fldNameParametreEn] = @fldNameParametreEn, [fldNoe] = @fldNoe, [fldNoeField] = @fldNoeField, [fldVaziyat] = @fldVaziyat, [fldComboBaxId] = @fldComboBaxId, [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = getdate(),fldTypeParametr=@fldTypeParametr
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
