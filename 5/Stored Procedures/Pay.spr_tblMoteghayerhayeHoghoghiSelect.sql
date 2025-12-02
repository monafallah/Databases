SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblMoteghayerhayeHoghoghiSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@h int
AS 
	BEGIN TRAN
	if (@h=0) set @h=2147483647
	SET @Value=Com.fn_TextNormalize(@Value)
	if (@fieldname=N'fldId')
	SELECT     TOP (@h) Pay.tblMoteghayerhayeHoghoghi.fldId, fldTarikhEjra, 
                       fldTarikhSodur, Pay.tblMoteghayerhayeHoghoghi.fldZaribEzafeKar, 
                      Pay.tblMoteghayerhayeHoghoghi.fldSaatKari, Pay.tblMoteghayerhayeHoghoghi.fldDarsadBimePersonal, Pay.tblMoteghayerhayeHoghoghi.fldDarsadbimeKarfarma, 
                      Pay.tblMoteghayerhayeHoghoghi.fldDarsadBimeBikari, Pay.tblMoteghayerhayeHoghoghi.fldDarsadBimeJanbazan, 
                      Pay.tblMoteghayerhayeHoghoghi.fldHaghDarmanKarmand, Pay.tblMoteghayerhayeHoghoghi.fldHaghDarmanKarFarma, 
                      Pay.tblMoteghayerhayeHoghoghi.fldHaghDarmanDolat, Pay.tblMoteghayerhayeHoghoghi.fldHaghDarmanMazad, 
                      Pay.tblMoteghayerhayeHoghoghi.fldHaghDarmanTahteTakaffol,Pay.tblMoteghayerhayeHoghoghi.fldDarsadBimeMashagheleZiyanAvar,fldMaxHaghDarman,fldZaribHoghoghiSal,fldHoghogh,fldFoghShoghl,fldTafavotTatbigh,fldFoghVizhe,fldHaghJazb,fldTadil,fldBarJastegi,fldSanavat, 
                      Pay.tblMoteghayerhayeHoghoghi.fldUserId, Pay.tblMoteghayerhayeHoghoghi.fldDate, 
                      Pay.tblMoteghayerhayeHoghoghi.fldDesc, Com.tblTypeBime.fldTitle AS fldTypeBimeName, Pay.tblMoteghayerhayeHoghoghi.fldTypeBimeId, 
                      Pay.tblMoteghayerhayeHoghoghi.fldAnvaeEstekhdamId, 
                      Com.tblAnvaEstekhdam.fldTitle AS fldAnvaeEstekhdamTitle,fldFoghTalash
                    FROM         Pay.tblMoteghayerhayeHoghoghi INNER JOIN
                      Com.tblTypeBime ON Pay.tblMoteghayerhayeHoghoghi.fldTypeBimeId = Com.tblTypeBime.fldId INNER JOIN
                      Com.tblAnvaEstekhdam ON Pay.tblMoteghayerhayeHoghoghi.fldAnvaeEstekhdamId = Com.tblAnvaEstekhdam.fldId
	WHERE     (Pay.tblMoteghayerhayeHoghoghi.fldId = @Value)
	
	if (@fieldname=N'fldAnvaeEstekhdamId')
	SELECT     TOP (@h) Pay.tblMoteghayerhayeHoghoghi.fldId, fldTarikhEjra, 
                       fldTarikhSodur, Pay.tblMoteghayerhayeHoghoghi.fldZaribEzafeKar, 
                      Pay.tblMoteghayerhayeHoghoghi.fldSaatKari, Pay.tblMoteghayerhayeHoghoghi.fldDarsadBimePersonal, Pay.tblMoteghayerhayeHoghoghi.fldDarsadbimeKarfarma, 
                      Pay.tblMoteghayerhayeHoghoghi.fldDarsadBimeBikari, Pay.tblMoteghayerhayeHoghoghi.fldDarsadBimeJanbazan, 
                      Pay.tblMoteghayerhayeHoghoghi.fldHaghDarmanKarmand, Pay.tblMoteghayerhayeHoghoghi.fldHaghDarmanKarFarma, 
                      Pay.tblMoteghayerhayeHoghoghi.fldHaghDarmanDolat, Pay.tblMoteghayerhayeHoghoghi.fldHaghDarmanMazad, 
                      Pay.tblMoteghayerhayeHoghoghi.fldHaghDarmanTahteTakaffol,Pay.tblMoteghayerhayeHoghoghi.fldDarsadBimeMashagheleZiyanAvar,fldMaxHaghDarman,fldZaribHoghoghiSal,fldHoghogh,fldFoghShoghl,fldTafavotTatbigh,fldFoghVizhe,fldHaghJazb,fldTadil,fldBarJastegi,fldSanavat, 
                      Pay.tblMoteghayerhayeHoghoghi.fldUserId, Pay.tblMoteghayerhayeHoghoghi.fldDate, 
                      Pay.tblMoteghayerhayeHoghoghi.fldDesc, Com.tblTypeBime.fldTitle AS fldTypeBimeName, Pay.tblMoteghayerhayeHoghoghi.fldTypeBimeId, 
                      Pay.tblMoteghayerhayeHoghoghi.fldAnvaeEstekhdamId, 
                      Com.tblAnvaEstekhdam.fldTitle AS fldAnvaeEstekhdamTitle,fldFoghTalash
                    FROM         Pay.tblMoteghayerhayeHoghoghi INNER JOIN
                      Com.tblTypeBime ON Pay.tblMoteghayerhayeHoghoghi.fldTypeBimeId = Com.tblTypeBime.fldId INNER JOIN
                      Com.tblAnvaEstekhdam ON Pay.tblMoteghayerhayeHoghoghi.fldAnvaeEstekhdamId = Com.tblAnvaEstekhdam.fldId
	WHERE     (Pay.tblMoteghayerhayeHoghoghi.fldAnvaeEstekhdamId = @Value)
	
	if (@fieldname=N'fldTarikhEjra')
	SELECT     TOP (@h) Pay.tblMoteghayerhayeHoghoghi.fldId, fldTarikhEjra, 
                       fldTarikhSodur, Pay.tblMoteghayerhayeHoghoghi.fldZaribEzafeKar, 
                      Pay.tblMoteghayerhayeHoghoghi.fldSaatKari, Pay.tblMoteghayerhayeHoghoghi.fldDarsadBimePersonal, Pay.tblMoteghayerhayeHoghoghi.fldDarsadbimeKarfarma, 
                      Pay.tblMoteghayerhayeHoghoghi.fldDarsadBimeBikari, Pay.tblMoteghayerhayeHoghoghi.fldDarsadBimeJanbazan, 
                      Pay.tblMoteghayerhayeHoghoghi.fldHaghDarmanKarmand, Pay.tblMoteghayerhayeHoghoghi.fldHaghDarmanKarFarma, 
                      Pay.tblMoteghayerhayeHoghoghi.fldHaghDarmanDolat, Pay.tblMoteghayerhayeHoghoghi.fldHaghDarmanMazad, 
                      Pay.tblMoteghayerhayeHoghoghi.fldHaghDarmanTahteTakaffol,Pay.tblMoteghayerhayeHoghoghi.fldDarsadBimeMashagheleZiyanAvar,fldMaxHaghDarman,fldZaribHoghoghiSal,fldHoghogh,fldFoghShoghl,fldTafavotTatbigh,fldFoghVizhe,fldHaghJazb,fldTadil,fldBarJastegi,fldSanavat, 
                      Pay.tblMoteghayerhayeHoghoghi.fldUserId, Pay.tblMoteghayerhayeHoghoghi.fldDate, 
                      Pay.tblMoteghayerhayeHoghoghi.fldDesc, Com.tblTypeBime.fldTitle AS fldTypeBimeName, Pay.tblMoteghayerhayeHoghoghi.fldTypeBimeId, 
                      Pay.tblMoteghayerhayeHoghoghi.fldAnvaeEstekhdamId, 
                      Com.tblAnvaEstekhdam.fldTitle AS fldAnvaeEstekhdamTitle,fldFoghTalash
                    FROM         Pay.tblMoteghayerhayeHoghoghi INNER JOIN
                      Com.tblTypeBime ON Pay.tblMoteghayerhayeHoghoghi.fldTypeBimeId = Com.tblTypeBime.fldId INNER JOIN
                      Com.tblAnvaEstekhdam ON Pay.tblMoteghayerhayeHoghoghi.fldAnvaeEstekhdamId = Com.tblAnvaEstekhdam.fldId
                      	WHERE (fldTarikhEjra) LIKE @Value 
                        order by Pay.tblMoteghayerhayeHoghoghi.fldId desc
	
	if (@fieldname=N'fldTarikhSodur')
	SELECT     TOP (@h) Pay.tblMoteghayerhayeHoghoghi.fldId, fldTarikhEjra, 
                       fldTarikhSodur, Pay.tblMoteghayerhayeHoghoghi.fldZaribEzafeKar, 
                      Pay.tblMoteghayerhayeHoghoghi.fldSaatKari, Pay.tblMoteghayerhayeHoghoghi.fldDarsadBimePersonal, Pay.tblMoteghayerhayeHoghoghi.fldDarsadbimeKarfarma, 
                      Pay.tblMoteghayerhayeHoghoghi.fldDarsadBimeBikari, Pay.tblMoteghayerhayeHoghoghi.fldDarsadBimeJanbazan, 
                      Pay.tblMoteghayerhayeHoghoghi.fldHaghDarmanKarmand, Pay.tblMoteghayerhayeHoghoghi.fldHaghDarmanKarFarma, 
                      Pay.tblMoteghayerhayeHoghoghi.fldHaghDarmanDolat, Pay.tblMoteghayerhayeHoghoghi.fldHaghDarmanMazad, 
                      Pay.tblMoteghayerhayeHoghoghi.fldHaghDarmanTahteTakaffol,Pay.tblMoteghayerhayeHoghoghi.fldDarsadBimeMashagheleZiyanAvar,fldMaxHaghDarman,fldZaribHoghoghiSal,fldHoghogh,fldFoghShoghl,fldTafavotTatbigh,fldFoghVizhe,fldHaghJazb,fldTadil,fldBarJastegi,fldSanavat, 
                      Pay.tblMoteghayerhayeHoghoghi.fldUserId, Pay.tblMoteghayerhayeHoghoghi.fldDate, 
                      Pay.tblMoteghayerhayeHoghoghi.fldDesc, Com.tblTypeBime.fldTitle AS fldTypeBimeName, Pay.tblMoteghayerhayeHoghoghi.fldTypeBimeId, 
                      Pay.tblMoteghayerhayeHoghoghi.fldAnvaeEstekhdamId, 
                      Com.tblAnvaEstekhdam.fldTitle AS fldAnvaeEstekhdamTitle,fldFoghTalash
                    FROM         Pay.tblMoteghayerhayeHoghoghi INNER JOIN
                      Com.tblTypeBime ON Pay.tblMoteghayerhayeHoghoghi.fldTypeBimeId = Com.tblTypeBime.fldId INNER JOIN
                      Com.tblAnvaEstekhdam ON Pay.tblMoteghayerhayeHoghoghi.fldAnvaeEstekhdamId = Com.tblAnvaEstekhdam.fldId
	WHERE  (fldTarikhSodur) like @Value
                        order by Pay.tblMoteghayerhayeHoghoghi.fldId desc
	
	if (@fieldname=N'fldAnvaeEstekhdamTitle')
SELECT     TOP (@h) Pay.tblMoteghayerhayeHoghoghi.fldId, fldTarikhEjra, 
                       fldTarikhSodur, Pay.tblMoteghayerhayeHoghoghi.fldZaribEzafeKar, 
                      Pay.tblMoteghayerhayeHoghoghi.fldSaatKari, Pay.tblMoteghayerhayeHoghoghi.fldDarsadBimePersonal, Pay.tblMoteghayerhayeHoghoghi.fldDarsadbimeKarfarma, 
                      Pay.tblMoteghayerhayeHoghoghi.fldDarsadBimeBikari, Pay.tblMoteghayerhayeHoghoghi.fldDarsadBimeJanbazan, 
                      Pay.tblMoteghayerhayeHoghoghi.fldHaghDarmanKarmand, Pay.tblMoteghayerhayeHoghoghi.fldHaghDarmanKarFarma, 
                      Pay.tblMoteghayerhayeHoghoghi.fldHaghDarmanDolat, Pay.tblMoteghayerhayeHoghoghi.fldHaghDarmanMazad, 
                      Pay.tblMoteghayerhayeHoghoghi.fldHaghDarmanTahteTakaffol,Pay.tblMoteghayerhayeHoghoghi.fldDarsadBimeMashagheleZiyanAvar,fldMaxHaghDarman,fldZaribHoghoghiSal,fldHoghogh,fldFoghShoghl,fldTafavotTatbigh,fldFoghVizhe,fldHaghJazb,fldTadil,fldBarJastegi,fldSanavat, 
                      Pay.tblMoteghayerhayeHoghoghi.fldUserId, Pay.tblMoteghayerhayeHoghoghi.fldDate, 
                      Pay.tblMoteghayerhayeHoghoghi.fldDesc, Com.tblTypeBime.fldTitle AS fldTypeBimeName, Pay.tblMoteghayerhayeHoghoghi.fldTypeBimeId, 
                      Pay.tblMoteghayerhayeHoghoghi.fldAnvaeEstekhdamId, 
                      Com.tblAnvaEstekhdam.fldTitle AS fldAnvaeEstekhdamTitle,fldFoghTalash
                    FROM         Pay.tblMoteghayerhayeHoghoghi INNER JOIN
                      Com.tblTypeBime ON Pay.tblMoteghayerhayeHoghoghi.fldTypeBimeId = Com.tblTypeBime.fldId INNER JOIN
                      Com.tblAnvaEstekhdam ON Pay.tblMoteghayerhayeHoghoghi.fldAnvaeEstekhdamId = Com.tblAnvaEstekhdam.fldId
	WHERE   Com.tblAnvaEstekhdam.fldTitle like @Value
                        order by Pay.tblMoteghayerhayeHoghoghi.fldId desc
	
	if (@fieldname=N'fldTypeBimeName')
SELECT     TOP (@h) Pay.tblMoteghayerhayeHoghoghi.fldId, fldTarikhEjra, 
                       fldTarikhSodur, Pay.tblMoteghayerhayeHoghoghi.fldZaribEzafeKar, 
                      Pay.tblMoteghayerhayeHoghoghi.fldSaatKari, Pay.tblMoteghayerhayeHoghoghi.fldDarsadBimePersonal, Pay.tblMoteghayerhayeHoghoghi.fldDarsadbimeKarfarma, 
                      Pay.tblMoteghayerhayeHoghoghi.fldDarsadBimeBikari, Pay.tblMoteghayerhayeHoghoghi.fldDarsadBimeJanbazan, 
                      Pay.tblMoteghayerhayeHoghoghi.fldHaghDarmanKarmand, Pay.tblMoteghayerhayeHoghoghi.fldHaghDarmanKarFarma, 
                      Pay.tblMoteghayerhayeHoghoghi.fldHaghDarmanDolat, Pay.tblMoteghayerhayeHoghoghi.fldHaghDarmanMazad, 
                      Pay.tblMoteghayerhayeHoghoghi.fldHaghDarmanTahteTakaffol,Pay.tblMoteghayerhayeHoghoghi.fldDarsadBimeMashagheleZiyanAvar,fldMaxHaghDarman,fldZaribHoghoghiSal,fldHoghogh,fldFoghShoghl,fldTafavotTatbigh,fldFoghVizhe,fldHaghJazb,fldTadil,fldBarJastegi,fldSanavat, 
                      Pay.tblMoteghayerhayeHoghoghi.fldUserId, Pay.tblMoteghayerhayeHoghoghi.fldDate, 
                      Pay.tblMoteghayerhayeHoghoghi.fldDesc, Com.tblTypeBime.fldTitle AS fldTypeBimeName, Pay.tblMoteghayerhayeHoghoghi.fldTypeBimeId, 
                      Pay.tblMoteghayerhayeHoghoghi.fldAnvaeEstekhdamId, 
                      Com.tblAnvaEstekhdam.fldTitle AS fldAnvaeEstekhdamTitle,fldFoghTalash
                    FROM         Pay.tblMoteghayerhayeHoghoghi INNER JOIN
                      Com.tblTypeBime ON Pay.tblMoteghayerhayeHoghoghi.fldTypeBimeId = Com.tblTypeBime.fldId INNER JOIN
                      Com.tblAnvaEstekhdam ON Pay.tblMoteghayerhayeHoghoghi.fldAnvaeEstekhdamId = Com.tblAnvaEstekhdam.fldId
				WHERE   Com.tblTypeBime.fldTitle like @Value
                        order by Pay.tblMoteghayerhayeHoghoghi.fldId desc

		if (@fieldname=N'fldTypeBimeName')
SELECT     TOP (@h) Pay.tblMoteghayerhayeHoghoghi.fldId, fldTarikhEjra, 
                       fldTarikhSodur, Pay.tblMoteghayerhayeHoghoghi.fldZaribEzafeKar, 
                      Pay.tblMoteghayerhayeHoghoghi.fldSaatKari, Pay.tblMoteghayerhayeHoghoghi.fldDarsadBimePersonal, Pay.tblMoteghayerhayeHoghoghi.fldDarsadbimeKarfarma, 
                      Pay.tblMoteghayerhayeHoghoghi.fldDarsadBimeBikari, Pay.tblMoteghayerhayeHoghoghi.fldDarsadBimeJanbazan, 
                      Pay.tblMoteghayerhayeHoghoghi.fldHaghDarmanKarmand, Pay.tblMoteghayerhayeHoghoghi.fldHaghDarmanKarFarma, 
                      Pay.tblMoteghayerhayeHoghoghi.fldHaghDarmanDolat, Pay.tblMoteghayerhayeHoghoghi.fldHaghDarmanMazad, 
                      Pay.tblMoteghayerhayeHoghoghi.fldHaghDarmanTahteTakaffol,Pay.tblMoteghayerhayeHoghoghi.fldDarsadBimeMashagheleZiyanAvar,fldMaxHaghDarman,fldZaribHoghoghiSal,fldHoghogh,fldFoghShoghl,fldTafavotTatbigh,fldFoghVizhe,fldHaghJazb,fldTadil,fldBarJastegi,fldSanavat, 
                      Pay.tblMoteghayerhayeHoghoghi.fldUserId, Pay.tblMoteghayerhayeHoghoghi.fldDate, 
                      Pay.tblMoteghayerhayeHoghoghi.fldDesc, Com.tblTypeBime.fldTitle AS fldTypeBimeName, Pay.tblMoteghayerhayeHoghoghi.fldTypeBimeId, 
                      Pay.tblMoteghayerhayeHoghoghi.fldAnvaeEstekhdamId, 
                      Com.tblAnvaEstekhdam.fldTitle AS fldAnvaeEstekhdamTitle,fldFoghTalash
                    FROM         Pay.tblMoteghayerhayeHoghoghi INNER JOIN
                      Com.tblTypeBime ON Pay.tblMoteghayerhayeHoghoghi.fldTypeBimeId = Com.tblTypeBime.fldId INNER JOIN
                      Com.tblAnvaEstekhdam ON Pay.tblMoteghayerhayeHoghoghi.fldAnvaeEstekhdamId = Com.tblAnvaEstekhdam.fldId
				WHERE   Com.tblTypeBime.fldTitle like @Value
                        order by Pay.tblMoteghayerhayeHoghoghi.fldId desc

if (@fieldname=N'fldDesc')
SELECT     TOP (@h) Pay.tblMoteghayerhayeHoghoghi.fldId, fldTarikhEjra, 
                       fldTarikhSodur, Pay.tblMoteghayerhayeHoghoghi.fldZaribEzafeKar, 
                      Pay.tblMoteghayerhayeHoghoghi.fldSaatKari, Pay.tblMoteghayerhayeHoghoghi.fldDarsadBimePersonal, Pay.tblMoteghayerhayeHoghoghi.fldDarsadbimeKarfarma, 
                      Pay.tblMoteghayerhayeHoghoghi.fldDarsadBimeBikari, Pay.tblMoteghayerhayeHoghoghi.fldDarsadBimeJanbazan, 
                      Pay.tblMoteghayerhayeHoghoghi.fldHaghDarmanKarmand, Pay.tblMoteghayerhayeHoghoghi.fldHaghDarmanKarFarma, 
                      Pay.tblMoteghayerhayeHoghoghi.fldHaghDarmanDolat, Pay.tblMoteghayerhayeHoghoghi.fldHaghDarmanMazad, 
                      Pay.tblMoteghayerhayeHoghoghi.fldHaghDarmanTahteTakaffol,Pay.tblMoteghayerhayeHoghoghi.fldDarsadBimeMashagheleZiyanAvar,fldMaxHaghDarman,fldZaribHoghoghiSal,fldHoghogh,fldFoghShoghl,fldTafavotTatbigh,fldFoghVizhe,fldHaghJazb,fldTadil,fldBarJastegi,fldSanavat, 
                      Pay.tblMoteghayerhayeHoghoghi.fldUserId, Pay.tblMoteghayerhayeHoghoghi.fldDate, 
                      Pay.tblMoteghayerhayeHoghoghi.fldDesc, Com.tblTypeBime.fldTitle AS fldTypeBimeName, Pay.tblMoteghayerhayeHoghoghi.fldTypeBimeId, 
                      Pay.tblMoteghayerhayeHoghoghi.fldAnvaeEstekhdamId, 
                      Com.tblAnvaEstekhdam.fldTitle AS fldAnvaeEstekhdamTitle,fldFoghTalash
                    FROM         Pay.tblMoteghayerhayeHoghoghi INNER JOIN
                      Com.tblTypeBime ON Pay.tblMoteghayerhayeHoghoghi.fldTypeBimeId = Com.tblTypeBime.fldId INNER JOIN
                      Com.tblAnvaEstekhdam ON Pay.tblMoteghayerhayeHoghoghi.fldAnvaeEstekhdamId = Com.tblAnvaEstekhdam.fldId
				WHERE   pay.tblMoteghayerhayeHoghoghi.fldDesc like @Value
                        order by Pay.tblMoteghayerhayeHoghoghi.fldId desc
	if (@fieldname=N'')
SELECT     TOP (@h) Pay.tblMoteghayerhayeHoghoghi.fldId, fldTarikhEjra, 
                       fldTarikhSodur, Pay.tblMoteghayerhayeHoghoghi.fldZaribEzafeKar, 
                      Pay.tblMoteghayerhayeHoghoghi.fldSaatKari, Pay.tblMoteghayerhayeHoghoghi.fldDarsadBimePersonal, Pay.tblMoteghayerhayeHoghoghi.fldDarsadbimeKarfarma, 
                      Pay.tblMoteghayerhayeHoghoghi.fldDarsadBimeBikari, Pay.tblMoteghayerhayeHoghoghi.fldDarsadBimeJanbazan, 
                      Pay.tblMoteghayerhayeHoghoghi.fldHaghDarmanKarmand, Pay.tblMoteghayerhayeHoghoghi.fldHaghDarmanKarFarma, 
                      Pay.tblMoteghayerhayeHoghoghi.fldHaghDarmanDolat, Pay.tblMoteghayerhayeHoghoghi.fldHaghDarmanMazad, 
                      Pay.tblMoteghayerhayeHoghoghi.fldHaghDarmanTahteTakaffol,Pay.tblMoteghayerhayeHoghoghi.fldDarsadBimeMashagheleZiyanAvar,fldMaxHaghDarman,fldZaribHoghoghiSal,fldHoghogh,fldFoghShoghl,fldTafavotTatbigh,fldFoghVizhe,fldHaghJazb,fldTadil,fldBarJastegi,fldSanavat, 
                      Pay.tblMoteghayerhayeHoghoghi.fldUserId, Pay.tblMoteghayerhayeHoghoghi.fldDate, 
                      Pay.tblMoteghayerhayeHoghoghi.fldDesc, Com.tblTypeBime.fldTitle AS fldTypeBimeName, Pay.tblMoteghayerhayeHoghoghi.fldTypeBimeId, 
                      Pay.tblMoteghayerhayeHoghoghi.fldAnvaeEstekhdamId, 
                      Com.tblAnvaEstekhdam.fldTitle AS fldAnvaeEstekhdamTitle,fldFoghTalash
                    FROM         Pay.tblMoteghayerhayeHoghoghi INNER JOIN
                      Com.tblTypeBime ON Pay.tblMoteghayerhayeHoghoghi.fldTypeBimeId = Com.tblTypeBime.fldId INNER JOIN
                      Com.tblAnvaEstekhdam ON Pay.tblMoteghayerhayeHoghoghi.fldAnvaeEstekhdamId = Com.tblAnvaEstekhdam.fldId
                        order by Pay.tblMoteghayerhayeHoghoghi.fldId desc


					  /*"SELECT    TOP(1)    fldId, fldTarikhEjra, fldTarikhSodur, fldAnvaeEstekhdamId, fldTypeBimeId, fldZaribEzafeKar, fldSaatKari, fldDarsadBimePersonal, fldDarsadbimeKarfarma, fldDarsadBimeBikari, fldDarsadBimeJanbazan, " +
                  "fldHaghDarmanKarmand, fldHaghDarmanKarfarma, fldHaghDarmanDolat, fldHaghDarmanMazad, fldHaghDarmanTahteTakaffol, fldDarsadBimeMashagheleZiyanAvar, fldMaxHaghDarman, fldZaribHoghoghiSal,  " +
                  "fldHoghogh, fldFoghShoghl, fldTafavotTatbigh, fldFoghVizhe, fldHaghJazb, fldTadil, fldBarJastegi, fldSanavat,fldFoghTalash, fldUserId, fldDate, fldDesc " +
                  "FROM            Pay.tblMoteghayerhayeHoghoghi " +
                  "WHERE fldAnvaeEstekhdamId=" + AnvaEstekhdam + "AND fldTypeBimeId=" + TypeBime + "AND SUBSTRING(fldTarikhEjra,1,4)<= TarikhEjra 
                  "ORDER BY fldTarikhSodur DESC,fldTarikhEjra DESC";*/
	
	COMMIT
GO
