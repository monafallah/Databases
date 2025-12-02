SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_Pay_CopyMoteghayerhayHoghoghi]
@fldTarikhEjra NVARCHAR(10),
@fldTarikhSodur NVARCHAR(10),
@HeaderId INT,
@UserId INT,
@Desc NVARCHAR(max)
as
DECLARE @Id INT,@IdDetail INT,@flag BIT=0
select @Id =ISNULL(max(fldId),0)+1 from Pay.tblMoteghayerhayeHoghoghi
INSERT INTO Pay.tblMoteghayerhayeHoghoghi
        ( fldId ,fldTarikhEjra ,fldTarikhSodur ,fldAnvaeEstekhdamId ,fldTypeBimeId ,fldZaribEzafeKar ,fldSaatKari , fldDarsadBimePersonal ,fldDarsadbimeKarfarma ,
          fldDarsadBimeBikari ,fldDarsadBimeJanbazan ,fldHaghDarmanKarmand ,fldHaghDarmanKarfarma ,fldHaghDarmanDolat ,fldHaghDarmanMazad ,fldHaghDarmanTahteTakaffol ,
          fldDarsadBimeMashagheleZiyanAvar ,fldMaxHaghDarman ,fldZaribHoghoghiSal ,fldHoghogh ,fldFoghShoghl ,fldTafavotTatbigh ,fldFoghVizhe ,fldHaghJazb ,fldTadil ,
          fldBarJastegi ,fldSanavat,fldFoghTalash ,fldUserId ,fldDate ,fldDesc)
SELECT     @Id AS Expr1, @fldTarikhEjra AS Expr2, @fldTarikhSodur AS Expr3, fldAnvaeEstekhdamId, fldTypeBimeId, fldZaribEzafeKar, fldSaatKari, fldDarsadBimePersonal, 
                      fldDarsadbimeKarfarma, fldDarsadBimeBikari, fldDarsadBimeJanbazan, fldHaghDarmanKarmand, fldHaghDarmanKarfarma, fldHaghDarmanDolat, 
                      fldHaghDarmanMazad, fldHaghDarmanTahteTakaffol, fldDarsadBimeMashagheleZiyanAvar, fldMaxHaghDarman, fldZaribHoghoghiSal, fldHoghogh, fldFoghShoghl, 
                      fldTafavotTatbigh, fldFoghVizhe, fldHaghJazb, fldTadil, fldBarJastegi, fldSanavat, fldFoghTalash, @UserId AS Expr4, GETDATE() AS Expr5, @Desc AS Expr6
FROM         Pay.tblMoteghayerhayeHoghoghi 
          WHERE fldid=@HeaderId
 IF(@@ERROR<>0)
 BEGIN
 	ROLLBACK
 	SET @flag=1
 END
 IF(@flag=0)
 BEGIN
select @IdDetail =ISNULL(max(fldId),0)+1 from Pay.tblMoteghayerhayeHoghoghi_Detail 
INSERT INTO Pay.tblMoteghayerhayeHoghoghi_Detail
        (fldId ,fldMoteghayerhayeHoghoghiId ,fldItemEstekhdamId ,fldUserId , fldDate ,fldDesc,fldMazayaMashmool)
SELECT @IdDetail+ ROW_NUMBER() OVER (ORDER BY Pay.tblMoteghayerhayeHoghoghi_Detail.fldId),@Id,fldItemEstekhdamId,@UserId , GETDATE() ,@Desc,fldMazayaMashmool 
FROM  Pay.tblMoteghayerhayeHoghoghi_Detail WHERE fldMoteghayerhayeHoghoghiId=@HeaderId
 IF(@@ERROR<>0)
 BEGIN
 	ROLLBACK
 	SET @flag=1
 END
END
GO
