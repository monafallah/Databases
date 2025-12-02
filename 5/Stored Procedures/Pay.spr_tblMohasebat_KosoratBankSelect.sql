SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblMohasebat_KosoratBankSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@h int
AS 
	BEGIN TRAN
	if (@h=0) set @h=2147483647
	SET @Value=Com.fn_TextNormalize(@Value)
	if (@fieldname=N'fldId')
SELECT top(@h) m.[fldId], m.[fldMohasebatId], m.[fldKosoratBankId], m.[fldMablagh], m.[fldUserId], m.[fldDate], m.[fldDesc] 
	,tblBank.fldBankName + N' شعبه ' + tblSHobe.fldName AS fldBankName
	FROM   [Pay].[tblMohasebat_KosoratBank] as m
	INNER JOIN Pay.tblKosuratBank ON m.fldKosoratBankId = Pay.tblKosuratBank.fldId 
	INNER JOIN Com.tblSHobe AS tblSHobe ON Pay.tblKosuratBank.fldShobeId = tblSHobe.fldId 
	INNER JOIN Com.tblBank AS tblBank ON tblSHobe.fldBankId = tblBank.fldId 
	WHERE  m.fldId = @Value

		if (@fieldname=N'fldDesc')
	SELECT top(@h) m.[fldId], m.[fldMohasebatId], m.[fldKosoratBankId], m.[fldMablagh], m.[fldUserId], m.[fldDate], m.[fldDesc] 
	,tblBank.fldBankName + N' شعبه ' + tblSHobe.fldName AS fldBankName
	FROM   [Pay].[tblMohasebat_KosoratBank] as m
	INNER JOIN Pay.tblKosuratBank ON m.fldKosoratBankId = Pay.tblKosuratBank.fldId 
	INNER JOIN Com.tblSHobe AS tblSHobe ON Pay.tblKosuratBank.fldShobeId = tblSHobe.fldId 
	INNER JOIN Com.tblBank AS tblBank ON tblSHobe.fldBankId = tblBank.fldId
	WHERE  m.fldDesc LIKE @Value
	
	if (@fieldname=N'fldMohasebatId')
	SELECT top(@h) m.[fldId], m.[fldMohasebatId], m.[fldKosoratBankId], m.[fldMablagh], m.[fldUserId], m.[fldDate], m.[fldDesc] 
	,tblBank.fldBankName + N' شعبه ' + tblSHobe.fldName AS fldBankName
	FROM   [Pay].[tblMohasebat_KosoratBank] as m
	INNER JOIN Pay.tblKosuratBank ON m.fldKosoratBankId = Pay.tblKosuratBank.fldId 
	INNER JOIN Com.tblSHobe AS tblSHobe ON Pay.tblKosuratBank.fldShobeId = tblSHobe.fldId 
	INNER JOIN Com.tblBank AS tblBank ON tblSHobe.fldBankId = tblBank.fldId
	WHERE  m.fldMohasebatId = @Value
	
	if (@fieldname=N'fldKosoratBankId')
	SELECT top(@h) m.[fldId], m.[fldMohasebatId], m.[fldKosoratBankId], m.[fldMablagh], m.[fldUserId], m.[fldDate], m.[fldDesc] 
	,tblBank.fldBankName + N' شعبه ' + tblSHobe.fldName AS fldBankName
	FROM   [Pay].[tblMohasebat_KosoratBank] as m
	INNER JOIN Pay.tblKosuratBank ON m.fldKosoratBankId = Pay.tblKosuratBank.fldId 
	INNER JOIN Com.tblSHobe AS tblSHobe ON Pay.tblKosuratBank.fldShobeId = tblSHobe.fldId 
	INNER JOIN Com.tblBank AS tblBank ON tblSHobe.fldBankId = tblBank.fldId
	WHERE  m.fldKosoratBankId = @Value


	if (@fieldname=N'')
	SELECT top(@h) m.[fldId], m.[fldMohasebatId], m.[fldKosoratBankId], m.[fldMablagh], m.[fldUserId], m.[fldDate], m.[fldDesc] 
	,tblBank.fldBankName + N' شعبه ' + tblSHobe.fldName AS fldBankName
	FROM   [Pay].[tblMohasebat_KosoratBank] as m
	INNER JOIN Pay.tblKosuratBank ON m.fldKosoratBankId = Pay.tblKosuratBank.fldId 
	INNER JOIN Com.tblSHobe AS tblSHobe ON Pay.tblKosuratBank.fldShobeId = tblSHobe.fldId 
	INNER JOIN Com.tblBank AS tblBank ON tblSHobe.fldBankId = tblBank.fldId

	COMMIT
GO
