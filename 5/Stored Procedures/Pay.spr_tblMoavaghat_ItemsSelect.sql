SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblMoavaghat_ItemsSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@h int
AS 
	BEGIN TRAN
	if (@h=0) set @h=2147483647
	SET @Value=Com.fn_TextNormalize(@Value)
	if (@fieldname=N'fldId')
	SELECT top(@h) i.[fldId], i.[fldMoavaghatId], i.[fldItemEstekhdamId], i.[fldMablagh], i.[fldUserId], i.[fldDesc], i.[fldDate] ,m.fldYear,m.fldMonth,h.fldTitle
	,(m.fldHaghDarmanKarfFarma+m.fldHaghDarmanDolat) as fldHaghDarmanKarfFarmaMoavagh, (m.fldPasAndaz/2) as fldPasAndazKarfFarmaMoavagh
	, (m.fldPasAndaz) as fldPasAndazPersonelMoavagh,(m.fldMaliyat) as fldMaliyatMoavagh, (m.fldBimePersonal) as fldBimePersonalMoavagh
	,(fldHaghDarman) as fldHaghDarmanPersonelMoavagh, (fldMashmolBime) as fldMashmolBimeMoavagh,(fldBimeKarFarma + fldBimeBikari) as fldBimeKarFarmaMoavagh
	, (fldMashmolMaliyat) As fldMashmolMaliyatMoavagh
	FROM   [Pay].[tblMoavaghat_Items] as i
	inner join pay.tblMoavaghat as m on m.fldId=i.fldMoavaghatId
	inner join com.tblItems_Estekhdam as e on e.fldId=i.fldItemEstekhdamId
	inner join com.tblItemsHoghughi as h on h.fldId=e.fldItemsHoghughiId
	WHERE  i.fldId = @Value

		if (@fieldname=N'fldDesc')
	SELECT top(@h) i.[fldId], i.[fldMoavaghatId], i.[fldItemEstekhdamId], i.[fldMablagh], i.[fldUserId], i.[fldDesc], i.[fldDate] ,m.fldYear,m.fldMonth,h.fldTitle
	,(m.fldHaghDarmanKarfFarma+m.fldHaghDarmanDolat) as fldHaghDarmanKarfFarmaMoavagh, (m.fldPasAndaz/2) as fldPasAndazKarfFarmaMoavagh
	, (m.fldPasAndaz) as fldPasAndazPersonelMoavagh,(m.fldMaliyat) as fldMaliyatMoavagh, (m.fldBimePersonal) as fldBimePersonalMoavagh
	,(fldHaghDarman) as fldHaghDarmanPersonelMoavagh, (fldMashmolBime) as fldMashmolBimeMoavagh,(fldBimeKarFarma + fldBimeBikari) as fldBimeKarFarmaMoavagh
	, (fldMashmolMaliyat) As fldMashmolMaliyatMoavagh
	FROM   [Pay].[tblMoavaghat_Items] as i
	inner join pay.tblMoavaghat as m on m.fldId=i.fldMoavaghatId
	inner join com.tblItems_Estekhdam as e on e.fldId=i.fldItemEstekhdamId
	inner join com.tblItemsHoghughi as h on h.fldId=e.fldItemsHoghughiId
	WHERE  i.fldDesc LIKE @Value

if (@fieldname=N'fldMoavaghatId')
	SELECT top(@h) i.[fldId], i.[fldMoavaghatId], i.[fldItemEstekhdamId], i.[fldMablagh], i.[fldUserId], i.[fldDesc], i.[fldDate] ,m.fldYear,m.fldMonth,h.fldTitle
	,(m.fldHaghDarmanKarfFarma+m.fldHaghDarmanDolat) as fldHaghDarmanKarfFarmaMoavagh, (m.fldPasAndaz/2) as fldPasAndazKarfFarmaMoavagh
	, (m.fldPasAndaz) as fldPasAndazPersonelMoavagh,(m.fldMaliyat) as fldMaliyatMoavagh, (m.fldBimePersonal) as fldBimePersonalMoavagh
	,(fldHaghDarman) as fldHaghDarmanPersonelMoavagh, (fldMashmolBime) as fldMashmolBimeMoavagh,(fldBimeKarFarma + fldBimeBikari) as fldBimeKarFarmaMoavagh
	, (fldMashmolMaliyat) As fldMashmolMaliyatMoavagh
	FROM   [Pay].[tblMoavaghat_Items] as i
	inner join pay.tblMoavaghat as m on m.fldId=i.fldMoavaghatId
	inner join com.tblItems_Estekhdam as e on e.fldId=i.fldItemEstekhdamId
	inner join com.tblItemsHoghughi as h on h.fldId=e.fldItemsHoghughiId
	WHERE  fldMoavaghatId = @Value

	if (@fieldname=N'fldMohasebatId')
	SELECT top(@h) 0 as [fldId], i.[fldMoavaghatId], i.[fldItemEstekhdamId],sum( i.[fldMablagh]) as fldMablagh, i.[fldUserId],'' as [fldDesc],getdate() [fldDate] ,m.fldYear,m.fldMonth
	,sum(m.fldHaghDarmanKarfFarma+m.fldHaghDarmanDolat) as fldHaghDarmanKarfFarmaMoavagh, SUM(m.fldPasAndaz/2) as fldPasAndazKarfFarmaMoavagh
								, SUM(m.fldPasAndaz) as fldPasAndazPersonelMoavagh,sum(m.fldMaliyat) as fldMaliyatMoavagh, SUM(m.fldBimePersonal) as fldBimePersonalMoavagh
								,SUM(fldHaghDarman) as fldHaghDarmanPersonelMoavagh, SUM(fldMashmolBime) as fldMashmolBimeMoavagh,SUM(fldBimeKarFarma + fldBimeBikari) as fldBimeKarFarmaMoavagh
								, SUM(fldMashmolMaliyat) As fldMashmolMaliyatMoavagh
	FROM   [Pay].[tblMoavaghat_Items] as i
	inner join pay.tblMoavaghat as m on m.fldId=i.fldMoavaghatId
	WHERE  fldMohasebatId = @Value
	group by i.fldMoavaghatId,i.fldId,i.[fldUserId] ,m.fldYear,m.fldMonth,i.fldItemEstekhdamId

	if (@fieldname=N'')
	SELECT top(@h) i.[fldId], i.[fldMoavaghatId], i.[fldItemEstekhdamId], i.[fldMablagh], i.[fldUserId], i.[fldDesc], i.[fldDate] ,m.fldYear,m.fldMonth,h.fldTitle
	,(m.fldHaghDarmanKarfFarma+m.fldHaghDarmanDolat) as fldHaghDarmanKarfFarmaMoavagh, (m.fldPasAndaz/2) as fldPasAndazKarfFarmaMoavagh
	, (m.fldPasAndaz) as fldPasAndazPersonelMoavagh,(m.fldMaliyat) as fldMaliyatMoavagh, (m.fldBimePersonal) as fldBimePersonalMoavagh
	,(fldHaghDarman) as fldHaghDarmanPersonelMoavagh, (fldMashmolBime) as fldMashmolBimeMoavagh,(fldBimeKarFarma + fldBimeBikari) as fldBimeKarFarmaMoavagh
	, (fldMashmolMaliyat) As fldMashmolMaliyatMoavagh
	FROM   [Pay].[tblMoavaghat_Items] as i
	inner join pay.tblMoavaghat as m on m.fldId=i.fldMoavaghatId
	inner join com.tblItems_Estekhdam as e on e.fldId=i.fldItemEstekhdamId
	inner join com.tblItemsHoghughi as h on h.fldId=e.fldItemsHoghughiId

	COMMIT
GO
