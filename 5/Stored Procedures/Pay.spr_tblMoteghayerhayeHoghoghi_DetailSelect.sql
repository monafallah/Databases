SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblMoteghayerhayeHoghoghi_DetailSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@h int
AS 
	BEGIN TRAN
	if (@h=0) set @h=2147483647
	SET @Value=Com.fn_TextNormalize(@Value)
	if (@fieldname=N'fldId')
	SELECT     TOP (@h) Pay.tblMoteghayerhayeHoghoghi_Detail.fldId, Pay.tblMoteghayerhayeHoghoghi_Detail.fldMoteghayerhayeHoghoghiId, 
                      Pay.tblMoteghayerhayeHoghoghi_Detail.fldItemEstekhdamId, 
                      Pay.tblMoteghayerhayeHoghoghi_Detail.fldUserId, Pay.tblMoteghayerhayeHoghoghi_Detail.fldDate, 
                      Pay.tblMoteghayerhayeHoghoghi_Detail.fldDesc, Com.tblItems_Estekhdam.fldTitle, Pay.tblMoteghayerhayeHoghoghi.fldTarikhEjra, 
                      Pay.tblMoteghayerhayeHoghoghi.fldTarikhSodur, Pay.tblMoteghayerhayeHoghoghi.fldZaribEzafeKar, Pay.tblMoteghayerhayeHoghoghi.fldSaatKari, 
                      Pay.tblMoteghayerhayeHoghoghi.fldDarsadBimePersonal, Pay.tblMoteghayerhayeHoghoghi.fldDarsadbimeKarfarma, 
                      Pay.tblMoteghayerhayeHoghoghi.fldDarsadBimeBikari, Pay.tblMoteghayerhayeHoghoghi.fldDarsadBimeJanbazan, 
                      Pay.tblMoteghayerhayeHoghoghi.fldHaghDarmanKarmand, Pay.tblMoteghayerhayeHoghoghi.fldHaghDarmanKarfarma, 
                      Pay.tblMoteghayerhayeHoghoghi.fldHaghDarmanDolat, Pay.tblMoteghayerhayeHoghoghi.fldHaghDarmanMazad, 
                      Pay.tblMoteghayerhayeHoghoghi.fldHaghDarmanTahteTakaffol,fldMazayaMashmool
FROM         Pay.tblMoteghayerhayeHoghoghi_Detail INNER JOIN
                      Com.tblItems_Estekhdam ON Pay.tblMoteghayerhayeHoghoghi_Detail.fldItemEstekhdamId = Com.tblItems_Estekhdam.fldId INNER JOIN
                      Pay.tblMoteghayerhayeHoghoghi ON Pay.tblMoteghayerhayeHoghoghi_Detail.fldMoteghayerhayeHoghoghiId = Pay.tblMoteghayerhayeHoghoghi.fldId
                      WHERE     (Pay.tblMoteghayerhayeHoghoghi_Detail.fldId = @Value)

if (@fieldname=N'fldMoteghayerhayeHoghoghiId')
	SELECT     TOP (@h) Pay.tblMoteghayerhayeHoghoghi_Detail.fldId, Pay.tblMoteghayerhayeHoghoghi_Detail.fldMoteghayerhayeHoghoghiId, 
                      Pay.tblMoteghayerhayeHoghoghi_Detail.fldItemEstekhdamId, Pay.tblMoteghayerhayeHoghoghi_Detail.fldUserId, Pay.tblMoteghayerhayeHoghoghi_Detail.fldDate, 
                      Pay.tblMoteghayerhayeHoghoghi_Detail.fldDesc, Com.tblItems_Estekhdam.fldTitle, Pay.tblMoteghayerhayeHoghoghi.fldTarikhEjra, 
                      Pay.tblMoteghayerhayeHoghoghi.fldTarikhSodur, Pay.tblMoteghayerhayeHoghoghi.fldZaribEzafeKar, Pay.tblMoteghayerhayeHoghoghi.fldSaatKari, 
                      Pay.tblMoteghayerhayeHoghoghi.fldDarsadBimePersonal, Pay.tblMoteghayerhayeHoghoghi.fldDarsadbimeKarfarma, 
                      Pay.tblMoteghayerhayeHoghoghi.fldDarsadBimeBikari, Pay.tblMoteghayerhayeHoghoghi.fldDarsadBimeJanbazan, 
                      Pay.tblMoteghayerhayeHoghoghi.fldHaghDarmanKarmand, Pay.tblMoteghayerhayeHoghoghi.fldHaghDarmanKarfarma, 
                      Pay.tblMoteghayerhayeHoghoghi.fldHaghDarmanDolat, Pay.tblMoteghayerhayeHoghoghi.fldHaghDarmanMazad, 
                      Pay.tblMoteghayerhayeHoghoghi.fldHaghDarmanTahteTakaffol,fldMazayaMashmool
FROM         Pay.tblMoteghayerhayeHoghoghi_Detail INNER JOIN
                      Com.tblItems_Estekhdam ON Pay.tblMoteghayerhayeHoghoghi_Detail.fldItemEstekhdamId = Com.tblItems_Estekhdam.fldId INNER JOIN
                      Pay.tblMoteghayerhayeHoghoghi ON Pay.tblMoteghayerhayeHoghoghi_Detail.fldMoteghayerhayeHoghoghiId = Pay.tblMoteghayerhayeHoghoghi.fldId
                      WHERE     (Pay.tblMoteghayerhayeHoghoghi.fldId = @Value)


if (@fieldname=N'fldAnvaeEstekhdamId')
	SELECT     TOP (@h) Pay.tblMoteghayerhayeHoghoghi_Detail.fldId, Pay.tblMoteghayerhayeHoghoghi_Detail.fldMoteghayerhayeHoghoghiId, 
                      Pay.tblMoteghayerhayeHoghoghi_Detail.fldItemEstekhdamId,  Pay.tblMoteghayerhayeHoghoghi_Detail.fldUserId, Pay.tblMoteghayerhayeHoghoghi_Detail.fldDate, 
                      Pay.tblMoteghayerhayeHoghoghi_Detail.fldDesc, Com.tblItems_Estekhdam.fldTitle, Pay.tblMoteghayerhayeHoghoghi.fldTarikhEjra, 
                      Pay.tblMoteghayerhayeHoghoghi.fldTarikhSodur, Pay.tblMoteghayerhayeHoghoghi.fldZaribEzafeKar, Pay.tblMoteghayerhayeHoghoghi.fldSaatKari, 
                      Pay.tblMoteghayerhayeHoghoghi.fldDarsadBimePersonal, Pay.tblMoteghayerhayeHoghoghi.fldDarsadbimeKarfarma, 
                      Pay.tblMoteghayerhayeHoghoghi.fldDarsadBimeBikari, Pay.tblMoteghayerhayeHoghoghi.fldDarsadBimeJanbazan, 
                      Pay.tblMoteghayerhayeHoghoghi.fldHaghDarmanKarmand, Pay.tblMoteghayerhayeHoghoghi.fldHaghDarmanKarfarma, 
                      Pay.tblMoteghayerhayeHoghoghi.fldHaghDarmanDolat, Pay.tblMoteghayerhayeHoghoghi.fldHaghDarmanMazad, 
                      Pay.tblMoteghayerhayeHoghoghi.fldHaghDarmanTahteTakaffol,fldMazayaMashmool
FROM         Pay.tblMoteghayerhayeHoghoghi_Detail INNER JOIN
                      Com.tblItems_Estekhdam ON Pay.tblMoteghayerhayeHoghoghi_Detail.fldItemEstekhdamId = Com.tblItems_Estekhdam.fldId INNER JOIN
                      Pay.tblMoteghayerhayeHoghoghi ON Pay.tblMoteghayerhayeHoghoghi_Detail.fldMoteghayerhayeHoghoghiId = Pay.tblMoteghayerhayeHoghoghi.fldId
                      WHERE     (fldAnvaeEstekhdamId = @Value)
if (@fieldname=N'fldDesc')
	SELECT     TOP (@h) Pay.tblMoteghayerhayeHoghoghi_Detail.fldId, Pay.tblMoteghayerhayeHoghoghi_Detail.fldMoteghayerhayeHoghoghiId, 
                      Pay.tblMoteghayerhayeHoghoghi_Detail.fldItemEstekhdamId,  Pay.tblMoteghayerhayeHoghoghi_Detail.fldUserId, Pay.tblMoteghayerhayeHoghoghi_Detail.fldDate, 
                      Pay.tblMoteghayerhayeHoghoghi_Detail.fldDesc, Com.tblItems_Estekhdam.fldTitle, Pay.tblMoteghayerhayeHoghoghi.fldTarikhEjra, 
                      Pay.tblMoteghayerhayeHoghoghi.fldTarikhSodur, Pay.tblMoteghayerhayeHoghoghi.fldZaribEzafeKar, Pay.tblMoteghayerhayeHoghoghi.fldSaatKari, 
                      Pay.tblMoteghayerhayeHoghoghi.fldDarsadBimePersonal, Pay.tblMoteghayerhayeHoghoghi.fldDarsadbimeKarfarma, 
                      Pay.tblMoteghayerhayeHoghoghi.fldDarsadBimeBikari, Pay.tblMoteghayerhayeHoghoghi.fldDarsadBimeJanbazan, 
                      Pay.tblMoteghayerhayeHoghoghi.fldHaghDarmanKarmand, Pay.tblMoteghayerhayeHoghoghi.fldHaghDarmanKarfarma, 
                      Pay.tblMoteghayerhayeHoghoghi.fldHaghDarmanDolat, Pay.tblMoteghayerhayeHoghoghi.fldHaghDarmanMazad, 
                      Pay.tblMoteghayerhayeHoghoghi.fldHaghDarmanTahteTakaffol,fldMazayaMashmool
FROM         Pay.tblMoteghayerhayeHoghoghi_Detail INNER JOIN
                      Com.tblItems_Estekhdam ON Pay.tblMoteghayerhayeHoghoghi_Detail.fldItemEstekhdamId = Com.tblItems_Estekhdam.fldId INNER JOIN
                      Pay.tblMoteghayerhayeHoghoghi ON Pay.tblMoteghayerhayeHoghoghi_Detail.fldMoteghayerhayeHoghoghiId = Pay.tblMoteghayerhayeHoghoghi.fldId
                      WHERE     (tblMoteghayerhayeHoghoghi.fldDesc = @Value)
	if (@fieldname=N'')
SELECT     TOP (@h) Pay.tblMoteghayerhayeHoghoghi_Detail.fldId, Pay.tblMoteghayerhayeHoghoghi_Detail.fldMoteghayerhayeHoghoghiId, 
                      Pay.tblMoteghayerhayeHoghoghi_Detail.fldItemEstekhdamId,  Pay.tblMoteghayerhayeHoghoghi_Detail.fldUserId, Pay.tblMoteghayerhayeHoghoghi_Detail.fldDate, 
                      Pay.tblMoteghayerhayeHoghoghi_Detail.fldDesc, Com.tblItems_Estekhdam.fldTitle, Pay.tblMoteghayerhayeHoghoghi.fldTarikhEjra, 
                      Pay.tblMoteghayerhayeHoghoghi.fldTarikhSodur, Pay.tblMoteghayerhayeHoghoghi.fldZaribEzafeKar, Pay.tblMoteghayerhayeHoghoghi.fldSaatKari, 
                      Pay.tblMoteghayerhayeHoghoghi.fldDarsadBimePersonal, Pay.tblMoteghayerhayeHoghoghi.fldDarsadbimeKarfarma, 
                      Pay.tblMoteghayerhayeHoghoghi.fldDarsadBimeBikari, Pay.tblMoteghayerhayeHoghoghi.fldDarsadBimeJanbazan, 
                      Pay.tblMoteghayerhayeHoghoghi.fldHaghDarmanKarmand, Pay.tblMoteghayerhayeHoghoghi.fldHaghDarmanKarfarma, 
                      Pay.tblMoteghayerhayeHoghoghi.fldHaghDarmanDolat, Pay.tblMoteghayerhayeHoghoghi.fldHaghDarmanMazad, 
                      Pay.tblMoteghayerhayeHoghoghi.fldHaghDarmanTahteTakaffol,fldMazayaMashmool
FROM         Pay.tblMoteghayerhayeHoghoghi_Detail INNER JOIN
                      Com.tblItems_Estekhdam ON Pay.tblMoteghayerhayeHoghoghi_Detail.fldItemEstekhdamId = Com.tblItems_Estekhdam.fldId INNER JOIN
                      Pay.tblMoteghayerhayeHoghoghi ON Pay.tblMoteghayerhayeHoghoghi_Detail.fldMoteghayerhayeHoghoghiId = Pay.tblMoteghayerhayeHoghoghi.fldId

	COMMIT
GO
