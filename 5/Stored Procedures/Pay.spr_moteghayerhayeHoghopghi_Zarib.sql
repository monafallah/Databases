SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
create procedure [Pay].[spr_moteghayerhayeHoghopghi_Zarib]
@fldAnvaeEstekhdamId int,
@fldTypeBimeId int,
@fldTarikhEjra nvarchar(10)

as

SELECT    TOP(1)   fldId, fldTarikhEjra, fldTarikhSodur, fldAnvaeEstekhdamId, fldTypeBimeId, fldZaribEzafeKar, fldSaatKari, fldDarsadBimePersonal, fldDarsadbimeKarfarma, fldDarsadBimeBikari, fldDarsadBimeJanbazan,
fldHaghDarmanKarmand, fldHaghDarmanKarfarma, fldHaghDarmanDolat, fldHaghDarmanMazad, fldHaghDarmanTahteTakaffol, fldDarsadBimeMashagheleZiyanAvar, fldMaxHaghDarman, fldZaribHoghoghiSal,  
                  fldHoghogh, fldFoghShoghl, fldTafavotTatbigh, fldFoghVizhe, fldHaghJazb, fldTadil, fldBarJastegi, fldSanavat,fldFoghTalash, fldUserId, fldDate, fldDesc  
                  FROM            Pay.tblMoteghayerhayeHoghoghi  
                  WHERE fldAnvaeEstekhdamId= @fldAnvaeEstekhdamId  AND fldTypeBimeId= @fldTypeBimeId AND SUBSTRING(fldTarikhEjra,1,4)<= @fldTarikhEjra
                  ORDER BY fldTarikhSodur DESC,fldTarikhEjra DESC
	
	
GO
