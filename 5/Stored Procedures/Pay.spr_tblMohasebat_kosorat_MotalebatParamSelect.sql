SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblMohasebat_kosorat/MotalebatParamSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@h int
AS 
	BEGIN TRAN
	if (@h=0) set @h=2147483647
	SET @Value=Com.fn_TextNormalize(@Value)
	if (@fieldname=N'fldId')
	SELECT top(@h) [fldId], [fldMohasebatId], [fldKosoratId], [fldMotalebatId], [fldMablagh], [fldUserId], [fldDate], [fldDesc] ,N'' as fldTitle
	FROM   [Pay].[tblMohasebat_kosorat/MotalebatParam] 
	WHERE  fldId = @Value

		if (@fieldname=N'fldDesc')
	SELECT top(@h) [fldId], [fldMohasebatId], [fldKosoratId], [fldMotalebatId], [fldMablagh], [fldUserId], [fldDate], [fldDesc] ,N'' as fldTitle
	FROM   [Pay].[tblMohasebat_kosorat/MotalebatParam] 
	WHERE  fldDesc LIKE @Value
	
	if (@fieldname=N'fldMohasebatId')
	SELECT top(@h) m.[fldId], m.[fldMohasebatId],m. [fldKosoratId], m.[fldMotalebatId], m.[fldMablagh], m.[fldUserId], m.[fldDate], m.[fldDesc] ,N'' as fldTitle
	FROM   [Pay].[tblMohasebat_kosorat/MotalebatParam] as m
	WHERE  fldMohasebatId = @Value
	
	if (@fieldname=N'fldMohasebatId_Motalebat')
	SELECT  m.[fldId], m.[fldMohasebatId],m. [fldKosoratId], m.[fldMotalebatId], m.[fldMablagh], m.[fldUserId], m.[fldDate], m.[fldDesc] ,p.fldTitle
	FROM   [Pay].[tblMohasebat_kosorat/MotalebatParam] as m
	INNER JOIN Pay.tblMotalebateParametri_Personal as mp ON m.fldMotalebatId =mp.fldId 
	INNER JOIN Pay.tblParametrs as p ON mp.fldParametrId = p.fldId
	WHERE  fldMohasebatId = @Value

	if (@fieldname=N'fldMohasebatId_kosorat')
	SELECT  m.[fldId], m.[fldMohasebatId],m. [fldKosoratId], m.[fldMotalebatId], m.[fldMablagh], m.[fldUserId], m.[fldDate], m.[fldDesc] ,p.fldTitle
	FROM   [Pay].[tblMohasebat_kosorat/MotalebatParam] as m
	INNER JOIN Pay.tblKosorateParametri_Personal as mp ON m.fldKosoratId =mp.fldId 
	INNER JOIN Pay.tblParametrs as p ON mp.fldParametrId = p.fldId
	WHERE  fldMohasebatId = @Value

	if (@fieldname=N'fldKosoratId')
	SELECT top(@h) [fldId], [fldMohasebatId], [fldKosoratId], [fldMotalebatId], [fldMablagh], [fldUserId], [fldDate], [fldDesc] ,N'' as fldTitle
	FROM   [Pay].[tblMohasebat_kosorat/MotalebatParam] 
	WHERE  fldKosoratId = @Value
	
	if (@fieldname=N'fldMotalebatId')
	SELECT top(@h) [fldId], [fldMohasebatId], [fldKosoratId], [fldMotalebatId], [fldMablagh], [fldUserId], [fldDate], [fldDesc] ,N'' as fldTitle
	FROM   [Pay].[tblMohasebat_kosorat/MotalebatParam] 
	WHERE  fldMotalebatId = @Value


	if (@fieldname=N'')
	SELECT top(@h) [fldId], [fldMohasebatId], [fldKosoratId], [fldMotalebatId], [fldMablagh], [fldUserId], [fldDate], [fldDesc] ,N'' as fldTitle
	FROM   [Pay].[tblMohasebat_kosorat/MotalebatParam] 

	COMMIT
GO
