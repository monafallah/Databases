SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_Pay_RptKosurBazneshastegi](@sal SMALLINT,@mah TINYINT,@Nobat TINYINT,@organId INT)
as
--DECLARE @sal SMALLINT,@mah TINYINT,@Nobat TINYINT
with t as (
select max(fldCalcType) as fldCalcType,fldPersonalId
from Pay.tblMohasebat 
INNER JOIN Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebat.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatId
WHERE fldYear=@sal AND fldMonth=@mah AND fldNobatPardakht=@nobat and Pay.tblMohasebat_PersonalInfo.fldOrganId=@organId  --AND Pay.tblMohasebat_PersonalInfo.fldInsuranceWorkShopId=@KargahBime 
                      AND Pay.tblMohasebat_PersonalInfo.fldTypeBimeId=2 --AND Com.fn_MaxPersonalStatus(Pay.Pay_tblPersonalInfo.fldId,'hoghoghi')=1
group by fldPersonalId
)
SELECT ISNULL(SUM(fldHoghogh),0) AS fldHoghogh,ISNULL(SUM(fldfoghjazb),0)fldfoghjazb,ISNULL(SUM(fldNobatKari),0)fldNobatKari,ISNULL(SUM(fldSakhtikar),0)fldSakhtikar,ISNULL(SUM(fldfoghshoghl),0)fldfoghshoghl
,ISNULL(SUM(fldKosur),0)fldKosur,ISNULL(SUM(fldHoghoghMoavaghe),0)fldHoghoghMoavaghe,ISNULL(SUM(fldfoghjazbMoavaghe),0)fldfoghjazbMoavaghe,ISNULL(SUM(fldNobatKariMoavaghe),0)fldNobatKariMoavaghe
,ISNULL(SUM(fldSakhtikarMoavaghe),0)fldSakhtikarMoavaghe,ISNULL(SUM(fldfoghshoghlMoavaghe),0)fldfoghshoghlMoavaghe,ISNULL(SUM(KosurMoavaghe),0)KosurMoavaghe,ISNULL(sum(fldMazad30sal),0)fldMazad30sal
,ISNULL(SUM(fldMazad30salMoavaghe),0)fldMazad30salMoavaghe,ISNULL(SUM(MogharariMahAval),0)MogharariMahAval,ISNULL(SUM(Mogharari),0)Mogharari,ISNULL(count (fldpersonalId),0)fldpersonalId,ISNULL(SUM(SahamKarmand),0) AS SahamKarmand,
ISNULL(SUM(SahmKarfarma),0)SahmKarfarma,ISNULL(sum (SahamKarmandMoavaghe),0)SahamKarmandMoavaghe,ISNULL(SUM(SahmKarfarmaMoavaghe),0)SahmKarfarmaMoavaghe
FROM (SELECT *
,(CAST(((fldKosur-fldMazad30sal-Mogharari)*(SELECT fldDarsadBimePersonal FROM Pay.tblMoteghayerhayeHoghoghi WHERE fldid=fldMoteghayerHoghoghiId)/100)AS int)) AS SahamKarmand
,(CAST(((fldKosur-MogharariMahAval-Mogharari)*(SELECT fldDarsadbimeKarfarma FROM Pay.tblMoteghayerhayeHoghoghi WHERE fldid=fldMoteghayerHoghoghiId)/100)AS INT)) AS SahmKarfarma
,(CAST(((KosurMoavaghe-fldMazad30salMoavaghe)*(SELECT fldDarsadBimePersonal FROM Pay.tblMoteghayerhayeHoghoghi WHERE fldid=fldMoteghayerHoghoghiId)/100)AS INT)) AS SahamKarmandMoavaghe
,(CAST(((KosurMoavaghe)*(SELECT fldDarsadbimeKarfarma FROM Pay.tblMoteghayerhayeHoghoghi WHERE fldid=fldMoteghayerHoghoghiId)/100)AS int)) AS SahmKarfarmaMoavaghe
 FROM ( 
SELECT    ISNULL((SELECT     SUM(Pay.tblMohasebat_Items.fldMablagh)
FROM         Pay.tblMohasebat_Items INNER JOIN
                      Com.tblItems_Estekhdam ON Pay.tblMohasebat_Items.fldItemEstekhdamId = Com.tblItems_Estekhdam.fldId WHERE fldMohasebatId =Pay.tblMohasebat.fldId AND fldItemsHoghughiId IN (1,2,4,5,11,17) ),0) AS fldHoghogh,
ISNULL((SELECT     SUM(Pay.tblMohasebat_Items.fldMablagh) 
FROM         Pay.tblMohasebat_Items INNER JOIN
                      Com.tblItems_Estekhdam ON Pay.tblMohasebat_Items.fldItemEstekhdamId = Com.tblItems_Estekhdam.fldId WHERE fldMohasebatId =Pay.tblMohasebat.fldId AND fldItemsHoghughiId IN (19,37,40,41) ),0) AS fldfoghjazb,
ISNULL((SELECT     SUM(Pay.tblMohasebat_Items.fldMablagh) 
FROM         Pay.tblMohasebat_Items INNER JOIN
                      Com.tblItems_Estekhdam ON Pay.tblMohasebat_Items.fldItemEstekhdamId = Com.tblItems_Estekhdam.fldId WHERE fldMohasebatId =Pay.tblMohasebat.fldId AND fldItemsHoghughiId =26 ),0) AS fldNobatKari,
ISNULL((SELECT     SUM(Pay.tblMohasebat_Items.fldMablagh) 
FROM         Pay.tblMohasebat_Items INNER JOIN
                      Com.tblItems_Estekhdam ON Pay.tblMohasebat_Items.fldItemEstekhdamId = Com.tblItems_Estekhdam.fldId WHERE fldMohasebatId =Pay.tblMohasebat.fldId AND fldItemsHoghughiId =15 ),0) AS fldSakhtikar,
ISNULL((SELECT     SUM(Pay.tblMohasebat_Items.fldMablagh) 
FROM         Pay.tblMohasebat_Items INNER JOIN
                      Com.tblItems_Estekhdam ON Pay.tblMohasebat_Items.fldItemEstekhdamId = Com.tblItems_Estekhdam.fldId WHERE fldMohasebatId =Pay.tblMohasebat.fldId AND fldItemsHoghughiId =6 ) ,0)AS fldfoghshoghl,
fldMashmolBime  AS fldKosur,
ISNULL((SELECT    SUM(fldMablagh) 
FROM         Pay.tblMoavaghat INNER JOIN
                      Pay.tblMoavaghat_Items ON Pay.tblMoavaghat.fldId = Pay.tblMoavaghat_Items.fldMoavaghatId INNER JOIN
                      Com.tblItems_Estekhdam ON Pay.tblMoavaghat_Items.fldItemEstekhdamId = Com.tblItems_Estekhdam.fldId WHERE fldMohasebatId =Pay.tblMohasebat.fldId AND fldItemsHoghughiId IN (1,2,4,5,11,17)),0) AS fldHoghoghMoavaghe
,ISNULL((SELECT    SUM(fldMablagh) 
FROM         Pay.tblMoavaghat INNER JOIN
                      Pay.tblMoavaghat_Items ON Pay.tblMoavaghat.fldId = Pay.tblMoavaghat_Items.fldMoavaghatId INNER JOIN
                      Com.tblItems_Estekhdam ON Pay.tblMoavaghat_Items.fldItemEstekhdamId = Com.tblItems_Estekhdam.fldId WHERE fldMohasebatId =Pay.tblMohasebat.fldId AND fldItemsHoghughiId IN (19,37,40,41)),0) AS fldfoghjazbMoavaghe
,ISNULL((SELECT    SUM(fldMablagh) 
FROM         Pay.tblMoavaghat INNER JOIN
                      Pay.tblMoavaghat_Items ON Pay.tblMoavaghat.fldId = Pay.tblMoavaghat_Items.fldMoavaghatId INNER JOIN
                      Com.tblItems_Estekhdam ON Pay.tblMoavaghat_Items.fldItemEstekhdamId = Com.tblItems_Estekhdam.fldId WHERE fldMohasebatId =Pay.tblMohasebat.fldId AND fldItemsHoghughiId =26),0) AS fldNobatKariMoavaghe
,ISNULL((SELECT    SUM(fldMablagh) 
FROM         Pay.tblMoavaghat INNER JOIN
                      Pay.tblMoavaghat_Items ON Pay.tblMoavaghat.fldId = Pay.tblMoavaghat_Items.fldMoavaghatId INNER JOIN
                      Com.tblItems_Estekhdam ON Pay.tblMoavaghat_Items.fldItemEstekhdamId = Com.tblItems_Estekhdam.fldId WHERE fldMohasebatId =Pay.tblMohasebat.fldId AND fldItemsHoghughiId =15),0) AS fldSakhtikarMoavaghe
,ISNULL((SELECT    SUM(fldMablagh) 
FROM         Pay.tblMoavaghat INNER JOIN
                      Pay.tblMoavaghat_Items ON Pay.tblMoavaghat.fldId = Pay.tblMoavaghat_Items.fldMoavaghatId INNER JOIN
                      Com.tblItems_Estekhdam ON Pay.tblMoavaghat_Items.fldItemEstekhdamId = Com.tblItems_Estekhdam.fldId WHERE fldMohasebatId =Pay.tblMohasebat.fldId AND fldItemsHoghughiId =6),0) AS fldfoghshoghlMoavaghe
,ISNULL((SELECT   SUM(fldMashmolBime)  
FROM         Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldId),0) AS KosurMoavaghe,
CASE WHEN fldMazad30Sal=1 THEN fldMashmolBime ELSE 0 END AS fldMazad30sal,
ISNULL((SELECT SUM(Pay.tblMoavaghat.fldMashmolBime) FROM Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldId AND fldMazad30Sal=1),0)fldMazad30salMoavaghe
,CASE WHEN fldMazad30Sal=1 THEN fldMogharari ELSE 0 END AS MogharariMahAval
,CASE WHEN fldMazad30Sal=0 THEN fldMogharari ELSE 0 END AS Mogharari,fldMoteghayerHoghoghiId,tblMohasebat.fldPersonalId

FROM         Pay.tblMohasebat_PersonalInfo INNER JOIN
                      Pay.tblMohasebat ON Pay.tblMohasebat_PersonalInfo.fldMohasebatId = Pay.tblMohasebat.fldId  inner join
                      t on t.fldPersonalId= Pay.tblMohasebat.fldPersonalId and t.fldCalcType= Pay.tblMohasebat.fldCalcType
                   
					 WHERE fldYear=@sal AND fldMonth=@mah AND fldNobatPardakht=@Nobat AND Pay.tblMohasebat_PersonalInfo.fldOrganId=@organId
                     AND fldTypeBimeId=2
                      )t)s
GO
