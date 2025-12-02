SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblParametreSabetInsert] 
    
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
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [Drd].[tblParametreSabet] 
	INSERT INTO [Drd].[tblParametreSabet] ([fldId], [fldShomareHesabCodeDaramadId], [fldNameParametreFa], [fldNameParametreEn], [fldNoe], [fldNoeField], [fldVaziyat], [fldFormulId], [fldComboBaxId], [fldUserId], [fldDesc], [fldDate],fldTypeParametr)
	SELECT @fldId, @fldShomareHesabCodeDaramadId, @fldNameParametreFa, @fldNameParametreEn, @fldNoe, @fldNoeField, @fldVaziyat,null, @fldComboBaxId, @fldUserId, @fldDesc, getdate(),@fldTypeParametr
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
