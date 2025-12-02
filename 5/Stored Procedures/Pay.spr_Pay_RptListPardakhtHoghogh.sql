SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_Pay_RptListPardakhtHoghogh](@costCenter INT,@typeBime INT,@Sal SMALLINT,@mah TINYINT ,@nobat TINYINT,@type TINYINT,@organId INT,
@CalcType TINYINT=1
 )
AS
declare @YearP SMALLINT=@Sal,@MonthP TINYINT=@Mah-1

if(@Mah=1)
begin
	set @YearP=@Sal-1
	set @MonthP=12
end

DECLARE @costCenter1 INT,@typeBime1 INT,@Sal1 SMALLINT,@mah1 TINYINT ,@nobat1 TINYINT,@type1 TINYINT,@organId1 INT
set @costCenter1=@costCenter
set @typeBime1=@typeBime
set @Sal1=@Sal
set @mah1=@mah
set @nobat1=@nobat
set @type1=@type
set @organId1=@organId

IF(@type1=0)/*معوقه بصورت جدا اضافه میشود*/
SELECT [fldid], [fldKarkard],[fldGheybat]
,[fldTedadEzafeKar],[fldTedadTatilKar],[fldBaBeytute],[fldBedunBeytute],[fldBimeOmrKarFarma],[fldBimeOmr],[fldBimeTakmilyKarFarma],[fldBimeTakmily],[fldPersonalId]
,[fldHaghDarmanKarfFarma],[fldBimeKarFarma],
[fldHaghDarmanDolat],[fldBimePersonal],[fldHaghDarman],[fldMosaede],[fldGhestVam],[fldPasAndaz],[fldMogharari],[fldMaliyat],[fldkhalesPardakhti],
[fldShomareHesab],[fldName_Family],[fldFatherName],[KosoratBank],[JamMotalebat],[JamKosurat],[fldMoavaghe],[fldMashmolBime],[fldMashmolMaliyat],[fldKolMotalebat],[fldKolKosurat]
, ISNULL([h-paye],'')[h-paye],ISNULL([sanavat],'')[sanavat],ISNULL([paye],'')[paye],ISNULL([sanavat-basiji],'')[sanavat-basiji]
,ISNULL([sanavat-isar],'')[sanavat-isar],ISNULL([foghshoghl],'')[foghshoghl],ISNULL([takhasosi],'')[takhasosi],ISNULL([made26],'')[made26],
ISNULL([modiryati],'')[modiryati],ISNULL([barjastegi],'')[barjastegi],ISNULL([tatbigh],'')[tatbigh],ISNULL([fogh-isar],'')[fogh-isar],
ISNULL([abohava],'')[abohava],ISNULL([tashilat],'')[tashilat],ISNULL([sakhtikar],'')[sakhtikar],ISNULL([tadil],'')[tadil],
ISNULL([riali],'')[riali],[jazb9]=ISNULL([jazb9],0),ISNULL([jazb],'')+ISNULL([jazb2],0)+ISNULL([jazb3],0)+ISNULL([jazbTarmim],0)[jazb],
[makhsos]=ISNULL([makhsos],0)+ISNULL([makhsos2],0)+ISNULL([makhsos3],0),
[vije]=ISNULL([vije],0)+ISNULL([vije2],0)+ISNULL([vije3],0)+ISNULL([VizheTarmim],0),
ISNULL([olad],'')[olad],ISNULL([ayelemandi],'')[ayelemandi],ISNULL([kharobar],'')[kharobar],ISNULL([maskan],'')[maskan],ISNULL([nobatkari],'')[nobatkari],ISNULL([bon],'')[bon]
,ISNULL([jazb-tabsare],'')[jazb-tabsare],ISNULL([talash],'')[talash],ISNULL([jebhe],'')[jebhe],ISNULL([janbazi],'')[janbazi],ISNULL([sayer],'')[sayer]
,ISNULL([ezafekar],'')+ISNULL([p].[ezafekariSayer],'') as [ezafekar] ,ISNULL([mamoriat],'')+ISNULL([mamooriyatSayer],'') as [mamoriat]
,ISNULL([tatilkari],'')+ISNULL([tatilkariSayer],'') as [tatilkari] ,ISNULL([s_payankhedmat],'')[s_payankhedmat]
,ISNULL([ghazai],'') ghazai,ISNULL([ashoora],'')ashoora,ISNULL([zaribtadil],'')zaribtadil,ISNULL(jazbTakhasosi,'')jazbTakhasosi,ISNULL(jazbtadil,'') jazbtadil,ISNULL(hadaghaltadil,0)+ISNULL(tatbigh1,0)+ISNULL(khas,0)+ISNULL([karane],0)+ISNULL([refahi],0)+isnull([tarmim],0)+isnull([KhasTarmim],0) as hadaghaltadil,ISNULL(shift,'')shift
,ISNULL([band_y],0)[band_y] ,ISNULL([joz1],0)[joz1],ISNULL([band6],0)[band6]
 from(
SELECT   Pay.tblMohasebat.fldId,  Pay.tblMohasebat.fldKarkard, Pay.tblMohasebat.fldGheybat, Pay.tblMohasebat.fldTedadEzafeKar, Pay.tblMohasebat.fldTedadTatilKar, 
                      Pay.tblMohasebat.fldBaBeytute, Pay.tblMohasebat.fldBedunBeytute, Pay.tblMohasebat.fldBimeOmrKarFarma, Pay.tblMohasebat.fldBimeOmr, 
                      Pay.tblMohasebat.fldBimeTakmilyKarFarma, Pay.tblMohasebat.fldBimeTakmily,Pay.tblMohasebat.fldPersonalId
                      , Pay.tblMohasebat.fldHaghDarmanKarfFarma ,(fldBimeKarFarma+fldbimebikari)+ISNULL((SELECT SUM(Pay.tblMoavaghat.fldBimeKarFarma+Pay.tblMoavaghat.fldbimebikari) FROM Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldid),0)fldBimeKarFarma,
                      Pay.tblMohasebat.fldHaghDarmanDolat,
                       Pay.tblMohasebat.fldBimePersonal+ISNULL((SELECT SUM(Pay.tblMoavaghat.fldBimePersonal) FROM Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldid),0) AS fldBimePersonal
                      , Pay.tblMohasebat.fldHaghDarman+ISNULL((SELECT sum (Pay.tblMoavaghat.fldHaghDarman) FROM Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldId),0) AS fldHaghDarman, 
                    fldMashmolBime+ISNULL((SELECT SUM(Pay.tblMoavaghat.fldMashmolBime) FROM Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldId ),0) AS fldMashmolBime,
                 cast( fldMashmolMaliyat as bigint)+ISNULL((SELECT SUM(cast (Pay.tblMoavaghat.fldMashmolMaliyat as bigint)) FROM Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldId ),0) AS fldMashmolMaliyat,
                  
                  Pay.tblMohasebat.fldMosaede, Pay.tblMohasebat.fldGhestVam, 
                     Pay.tblMohasebat.fldPasAndaz+ISNULL((SELECT  sum (Pay.tblMoavaghat.fldPasAndaz) FROM Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldId),0) AS fldPasAndaz,
                      Pay.tblMohasebat.fldMogharari 
                      ,(ISNULL(Pay.tblMohasebat.fldMaliyat,0)+ISNULL( (SELECT fldMablagh FROM Pay.tblP_MaliyatManfi WHERE fldMohasebeId=Pay.tblMohasebat.fldId),ISNULL((SELECT SUM(fldMaliyat) FROM Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldid),0))) AS fldMaliyat
                      ,  /* ( (SELECT SUM(ISNULL(fldMablagh,0)) FROM Pay.tblMohasebat_Items 
WHERE fldMohasebatId=Pay.tblMohasebat.fldId)+
(SELECT SUM(fldMablagh) FROM [pay].[tblMohasebat_kosorat/MotalebatParam]
WHERE  fldMohasebatId=Pay.tblMohasebat.fldId AND fldKosoratId IS NULL)+
+[fldHaghDarmanKarfFarma]
+[fldHaghDarmanDolat]+([Pay].[tblMohasebat].fldPasAndaz/(2))+[fldBimeTakmilyKarFarma]+[fldBimeOmrKarFarma])
-((SELECT SUM(fldMablagh) FROM [pay].[tblMohasebat_kosorat/MotalebatParam]
WHERE  fldMohasebatId=Pay.tblMohasebat.fldId AND fldMotalebatId IS NULL)+[fldHaghDarman]+[tblMohasebat].fldPasAndaz+(SELECT SUM(fldMablagh) FROM Pay.tblMohasebat_KosoratBank
WHERE fldMohasebatId=Pay.tblMohasebat.fldId)
+[fldMosaede]+[fldBimePersonal]+[fldMaliyat]+[fldBimeTakmily]+tblMohasebat.[fldBimeOmr]+[fldMogharari]+[fldGhestVam])
                     +ISNULL((select((SELECT SUM(Pay.tblMoavaghat_Items.fldMablagh)
               from       Pay.tblMoavaghat_Items 
                      WHERE fldMoavaghatId=tblMoavaghat.fldId)
+[fldHaghDarmanKarfFarma]+[fldHaghDarmanDolat]+([fldPasAndaz]/(2)))
-Com.fn_IsMaliyatManfiForMoavaghe(fldMohasebatId,fldid)+[fldBimePersonal]+[fldHaghDarman]+[fldPasAndaz] FROM Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldId),0)*/0 AS fldkhalesPardakhti,

                       Com.tblShomareHesabeOmoomi.fldShomareHesab, 
                   fldFamily+'_'+fldName+' ('+ fldFatherName+')' AS fldName_Family
                      , Com.tblEmployee_Detail.fldFatherName,fldNameEN,fldMablagh
                      ,(SELECT SUM(fldMablagh) FROM Pay.tblMohasebat_KosoratBank WHERE fldMohasebatId=Pay.tblMohasebat.fldId) AS KosoratBank,
                      ISNULL((SELECT    SUM( fldMablagh) FROM   [Pay].[tblMohasebat_kosorat/MotalebatParam] WHERE fldMohasebatId=Pay.tblMohasebat.fldId AND fldMotalebatId IS NOT null and fldHesabTypeParamId>1 ),0)AS JamMotalebat,
					  ISNULL((SELECT    SUM( fldMablagh) FROM   [Pay].[tblMohasebat_kosorat/MotalebatParam] WHERE fldMohasebatId=Pay.tblMohasebat.fldId AND fldKosoratId IS NOT null and fldHesabTypeParamId>1  ),0) AS JamKosurat
					  ,ISNULL((SELECT   SUM(  Pay.tblMoavaghat_Items.fldMablagh)
						FROM         Pay.tblMoavaghat INNER JOIN
						Pay.tblMoavaghat_Items ON Pay.tblMoavaghat.fldId = Pay.tblMoavaghat_Items.fldMoavaghatId WHERE fldMohasebatId=Pay.tblMohasebat.fldId  AND fldHesabTypeItemId<>1),0)+ isnull(fldMablaghMotamam,0) AS fldMoavaghe
						,ISNULL((SELECT SUM(ISNULL(fldMablagh,0)) FROM Pay.tblMohasebat_Items as i inner join com.tblItems_Estekhdam as e on e.fldId=i.fldItemEstekhdamId  WHERE fldMohasebatId=Pay.tblMohasebat.fldId  AND fldHesabTypeItemId<>1 and fldItemsHoghughiId<>76),0)+isnull((SELECT SUM(fldMablagh) FROM [pay].[tblMohasebat_kosorat/MotalebatParam]WHERE  fldMohasebatId=Pay.tblMohasebat.fldId AND fldKosoratId IS NULL and fldHesabTypeParamId>1 ),0)+fldHaghDarmanKarfFarma+fldHaghDarmanDolat+(Pay.tblMohasebat.fldPasAndaz/2)+fldBimeTakmilyKarFarma+fldBimeOmrKarFarma+
					    ISNULL((SELECT   DISTINCT SUM(fldMablagh)   OVER (PARTITION BY fldMohasebatId) 
FROM            Pay.tblMoavaghat INNER JOIN
                         Pay.tblMoavaghat_Items ON Pay.tblMoavaghat.fldId = Pay.tblMoavaghat_Items.fldMoavaghatId
						 WHERE fldMohasebatId=Pay.tblMohasebat.fldId AND fldHesabTypeItemId<>1) ,0)+ ISNULL((SELECT SUM(Pay.tblMoavaghat.fldHaghDarmanKarfFarma+Pay.tblMoavaghat.fldHaghDarmanDolat+(Pay.tblMoavaghat.fldPasAndaz/2)/*+Pay.tblMoavaghat.fldBimeBikari+Pay.tblMoavaghat.fldBimeKarFarma*/ ) FROM Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldid GROUP BY fldMohasebatId),0) 
						 +isnull((select fldMablagh from [Pay].[fn_KomakGheyerNaghdiPardakht]( fldPersonalId,@sal1 ,@Mah1 ,fldHesabTypeId )),0)
						 +isnull((select fldAmount from [Pay].[fn_KhalesPardakhtiSayerPardakhtsPardkhati]( fldPersonalId,@sal1 ,@Mah1,@Nobat1 ,fldHesabTypeId )),0)
                         +ISNULL(fldMablaghMotamam,0)
fldKolMotalebat,
						ISNULL((SELECT (ISNULL(abs(fldMablagh),0)) FROM Pay.tblMohasebat_Items as i inner join com.tblItems_Estekhdam as e on e.fldId=i.fldItemEstekhdamId  WHERE fldMohasebatId=Pay.tblMohasebat.fldId  AND fldHesabTypeItemId<>1 and fldItemsHoghughiId=76),0)+
						ISNULL((select SUM(fldMablagh) FROM [pay].[tblMohasebat_kosorat/MotalebatParam] WHERE  fldMohasebatId=Pay.tblMohasebat.fldId AND fldMotalebatId IS NULL and fldHesabTypeParamId>1 ),0)+ISNULL((select SUM(fldMablagh) FROM Pay.tblMohasebat_KosoratBank WHERE fldMohasebatId=Pay.tblMohasebat.fldid),0)+fldMosaede+fldBimePersonal+fldMaliyat+fldHaghDarman+Pay.tblMohasebat.fldGhestVam+Pay.tblMohasebat.fldPasAndaz+fldBimeTakmily+fldMogharari+Pay.tblMohasebat.fldBimeOmr+
					    ISNULL(Com.fn_IsMaliyatforMohasebe(Pay.tblMohasebat.fldId),0)+ISNULL((SELECT sum(fldBimePersonal+fldPasAndaz+fldHaghDarman ) FROM Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldId GROUP BY fldMohasebatId),0) 
						+isnull((select fldkhalesPardakhti from [Pay].[fn_KhalesPardakhtiEydi]( fldPersonalId,@sal1 ,@Mah1 ,fldHesabTypeId )),0)
						+isnull((select fldkhalesPardakhti from [Pay].[fn_KomakGheyerNaghdi]( fldPersonalId,@sal1 ,@Mah1 ,fldHesabTypeId )),0)
						+isnull((select fldkhalesPardakhti from [Pay].[fn_KhalesPardakhtiSayerPardakhts]( fldPersonalId,@sal1 ,@Mah1,@nobat1 ,fldHesabTypeId )),0)
						+isnull((select fldkhalesPardakhti from [Pay].[fn_OnAccount]( fldPersonalId,@sal1 ,@Mah1,@Nobat1 ,fldHesabTypeId,fldBankId )),0)
						fldKolKosurat, isnull(motamam.fldMablaghMotamam,0)fldMablaghMotamamm
						 FROM            Pay.tblMohasebat INNER JOIN
                         Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebat.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatId INNER JOIN
                         Prs.Prs_tblPersonalInfo INNER JOIN
                         Pay.Pay_tblPersonalInfo ON Prs.Prs_tblPersonalInfo.fldId = Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId ON Pay.tblMohasebat.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                         Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId left JOIN
                         Pay.tblMohasebat_Items ON Pay.tblMohasebat.fldId = Pay.tblMohasebat_Items.fldMohasebatId left JOIN
                         Com.tblItems_Estekhdam ON Pay.tblMohasebat_Items.fldItemEstekhdamId = Com.tblItems_Estekhdam.fldId left JOIN
                         Com.tblItemsHoghughi ON Com.tblItems_Estekhdam.fldItemsHoghughiId = Com.tblItemsHoghughi.fldId left JOIN
                         Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
                         Com.tblShomareHesabeOmoomi ON Pay.tblMohasebat_PersonalInfo.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId
                      outer apply(select sum(o.fldMablagh) as fldMablaghMotamam from pay.tblMohasebat as m2 
								inner join Pay.tblMohasebat_PersonalInfo as p ON m2.fldId = p.fldMohasebatId
								inner join pay.tblMohasebat_ItemMotamam as o on o.fldMohasebatId=m2.fldId 
								where tblMohasebat.fldPersonalId=m2.fldPersonalId and m2.fldYear= @YearP and m2.fldMonth=@MonthP and o.fldHesabTypeItemId<>1
                                AND p.fldTypeBimeId=@typeBime1
								and p.fldCostCenterId=tblMohasebat_PersonalInfo.fldCostCenterId
                                group by m2.fldPersonalId )motamam
                       WHERE   tblMohasebat_Items.fldHesabTypeItemId<>1 and Pay.tblMohasebat_PersonalInfo.fldCostCenterId=@costCenter1 AND Pay.tblMohasebat_PersonalInfo.fldTypeBimeId=@typeBime1 AND 
                       fldYear=@Sal1 AND fldMonth=@mah1 AND fldNobatPardakht=@nobat1 AND Pay.tblMohasebat_PersonalInfo.fldOrganId =@organId1
                    and fldCalcType=@CalcType
                      )t
 PIVOT
 (MAX(fldMablagh)
FOR fldNameEN IN([h-paye],[sanavat],[paye],[sanavat-basiji],[sanavat-isar],[foghshoghl],[takhasosi],[made26],[modiryati],[barjastegi],[tatbigh],[fogh-isar],
[abohava],[tashilat],[sakhtikar],[tadil],[riali],[jazb9],[jazb],[makhsos],[vije],[olad],[ayelemandi],[kharobar],[maskan],[nobatkari],[bon],[jazb-tabsare],[talash],[jebhe]
,[janbazi],[sayer],[ezafekar],[ezafekariSayer],[mamoriat],[mamooriyatSayer],[tatilkari],[tatilkariSayer],[s_payankhedmat],[ghazai],[ashoora],[zaribtadil],[jazbTakhasosi],[jazbtadil],[hadaghaltadil],[shift],
[band_y],[joz1],[band6],[jazb2],[jazb3],[vije2],[vije3],[makhsos2],[makhsos3],[tatbigh1],[khas],[karane],[refahi],[tarmim],[jazbTarmim],[VizheTarmim],[KhasTarmim]))p      

IF(@type1=1)/*معوقه بصورت جدا اضافه نمیشود*/
SELECT [fldid], [fldKarkard],[fldGheybat],[fldTedadEzafeKar],[fldTedadTatilKar],[fldBaBeytute],[fldBedunBeytute],[fldBimeOmrKarFarma],[fldBimeOmr],[fldBimeTakmilyKarFarma],[fldBimeTakmily],[fldPersonalId],
[fldHaghDarmanKarfFarma],[fldBimeKarFarma],
[fldHaghDarmanDolat],[fldBimePersonal],[fldHaghDarman],[fldMosaede],[fldGhestVam],[fldPasAndaz],[fldMogharari],[fldMaliyat],[fldkhalesPardakhti],
[fldShomareHesab],[fldName_Family],[fldFatherName],[KosoratBank],[JamMotalebat],[JamKosurat],[fldMoavaghe],[fldMashmolBime],[fldMashmolMaliyat],[fldKolMotalebat],[fldKolKosurat]
, ISNULL([h-paye],'')[h-paye],ISNULL([sanavat],'')[sanavat],ISNULL([paye],'')[paye],ISNULL([sanavat-basiji],'')[sanavat-basiji]
,ISNULL([sanavat-isar],'')[sanavat-isar],ISNULL([foghshoghl],'')[foghshoghl],ISNULL([takhasosi],'')[takhasosi],ISNULL([made26],'')[made26],
ISNULL([modiryati],'')[modiryati],ISNULL([barjastegi],'')[barjastegi],ISNULL([tatbigh],'')[tatbigh],ISNULL([fogh-isar],'')[fogh-isar],
ISNULL([abohava],'')[abohava],ISNULL([tashilat],'')[tashilat],ISNULL([sakhtikar],'')[sakhtikar],ISNULL([tadil],'')[tadil],
ISNULL([riali],'')[riali],ISNULL([jazb9],'')[jazb9],[jazb9]=ISNULL([jazb9],0)+ISNULL([jazb2],0)+ISNULL([jazb3],0)+ISNULL([jazbTarmim],0),
[makhsos]=ISNULL([makhsos],0)+ISNULL([makhsos2],0)+ISNULL([makhsos3],0),
[vije]=ISNULL([vije],0)+ISNULL([vije2],0)+ISNULL([vije3],0)+ISNULL([VizheTarmim],0),
ISNULL([olad],'')[olad],ISNULL([ayelemandi],'')[ayelemandi],ISNULL([kharobar],'')[kharobar],ISNULL([maskan],'')[maskan],ISNULL([nobatkari],'')[nobatkari],ISNULL([bon],'')[bon]
,ISNULL([jazb-tabsare],'')[jazb-tabsare],ISNULL([talash],'')[talash],ISNULL([jebhe],'')[jebhe],ISNULL([janbazi],'')[janbazi],ISNULL([sayer],'')[sayer]
,ISNULL([ezafekar],'')+ISNULL([p].[ezafekariSayer],'') as [ezafekar] ,ISNULL([mamoriat],'')+ISNULL([mamooriyatSayer],'') as [mamoriat]
,ISNULL([tatilkari],'')+ISNULL([tatilkariSayer],'') as [tatilkari],ISNULL([s_payankhedmat],'')[s_payankhedmat],ISNULL([ghazai],'') ghazai,ISNULL([ashoora],'')ashoora,ISNULL([zaribtadil],'')zaribtadil,
 ISNULL(jazbTakhasosi,'')jazbTakhasosi,ISNULL(jazbtadil,'') jazbtadil,ISNULL(hadaghaltadil,0)+ISNULL(tatbigh1,0)+ISNULL(khas,0)+ISNULL([karane],0)+ISNULL([refahi],0)+isnull([tarmim],0)+isnull([KhasTarmim],0) as hadaghaltadil,ISNULL(shift,'')shift
 ,ISNULL([band_y],0),ISNULL([joz1],0),ISNULL([band6],0)
 FROM(
SELECT   Pay.tblMohasebat.fldId,  Pay.tblMohasebat.fldKarkard, Pay.tblMohasebat.fldGheybat, Pay.tblMohasebat.fldTedadEzafeKar, Pay.tblMohasebat.fldTedadTatilKar, 
                      Pay.tblMohasebat.fldBaBeytute, Pay.tblMohasebat.fldBedunBeytute, Pay.tblMohasebat.fldBimeOmrKarFarma, Pay.tblMohasebat.fldBimeOmr, 
                      Pay.tblMohasebat.fldBimeTakmilyKarFarma, Pay.tblMohasebat.fldBimeTakmily,Pay.tblMohasebat.fldPersonalId
                      , Pay.tblMohasebat.fldHaghDarmanKarfFarma ,(fldBimeKarFarma+fldbimebikari)+ISNULL((SELECT SUM(Pay.tblMoavaghat.fldBimeKarFarma+Pay.tblMoavaghat.fldbimebikari) FROM Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldid),0)fldBimeKarFarma,
                      Pay.tblMohasebat.fldHaghDarmanDolat,
                       Pay.tblMohasebat.fldBimePersonal+ISNULL((SELECT SUM(Pay.tblMoavaghat.fldBimePersonal) FROM Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldid),0) AS fldBimePersonal
                      , Pay.tblMohasebat.fldHaghDarman+ISNULL((SELECT sum (Pay.tblMoavaghat.fldHaghDarman) FROM Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldId),0) AS fldHaghDarman, 
                      fldMashmolBime+ISNULL((SELECT SUM(Pay.tblMoavaghat.fldMashmolBime) FROM Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldId ),0) AS fldMashmolBime,
                  cast( fldMashmolMaliyat as bigint)+ISNULL((SELECT SUM(cast (Pay.tblMoavaghat.fldMashmolMaliyat as bigint)) FROM Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldId ),0) AS fldMashmolMaliyat,
                             Pay.tblMohasebat.fldMosaede, Pay.tblMohasebat.fldGhestVam, 
                     Pay.tblMohasebat.fldPasAndaz+ISNULL((SELECT  sum (Pay.tblMoavaghat.fldPasAndaz) FROM Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldId),0) AS fldPasAndaz,
                      Pay.tblMohasebat.fldMogharari 
                      ,(ISNULL(Pay.tblMohasebat.fldMaliyat,0)+ISNULL( (SELECT fldMablagh FROM Pay.tblP_MaliyatManfi WHERE fldMohasebeId=Pay.tblMohasebat.fldId),ISNULL((SELECT SUM(fldMaliyat) FROM Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldid),0))) AS fldMaliyat
                     , /* ( (SELECT SUM(ISNULL(fldMablagh,0)) FROM Pay.tblMohasebat_Items 
WHERE fldMohasebatId=Pay.tblMohasebat.fldId)+
(SELECT SUM(fldMablagh) FROM [pay].[tblMohasebat_kosorat/MotalebatParam]
WHERE  fldMohasebatId=Pay.tblMohasebat.fldId AND fldKosoratId IS NULL)+
+[fldHaghDarmanKarfFarma]
+[fldHaghDarmanDolat]+([Pay].[tblMohasebat].fldPasAndaz/(2))+[fldBimeTakmilyKarFarma]+[fldBimeOmrKarFarma])
-((SELECT SUM(fldMablagh) FROM [pay].[tblMohasebat_kosorat/MotalebatParam]
WHERE  fldMohasebatId=Pay.tblMohasebat.fldId AND fldMotalebatId IS NULL)+[fldHaghDarman]+[tblMohasebat].fldPasAndaz+(SELECT SUM(fldMablagh) FROM Pay.tblMohasebat_KosoratBank
WHERE fldMohasebatId=Pay.tblMohasebat.fldId)
+[fldMosaede]+[fldBimePersonal]+[fldMaliyat]+[fldBimeTakmily]+tblMohasebat.[fldBimeOmr]+[fldMogharari]+[fldGhestVam])
                     +ISNULL((select((SELECT SUM(Pay.tblMoavaghat_Items.fldMablagh)
               from       Pay.tblMoavaghat_Items 
                      WHERE fldMoavaghatId=tblMoavaghat.fldId)
+[fldHaghDarmanKarfFarma]+[fldHaghDarmanDolat]+([fldPasAndaz]/(2)))
-Com.fn_IsMaliyatManfiForMoavaghe(fldMohasebatId,fldid)+[fldBimePersonal]+[fldHaghDarman]+[fldPasAndaz] FROM Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldId),0)*/0 AS fldkhalesPardakhti,
                     
                      Com.tblShomareHesabeOmoomi.fldShomareHesab, 
                     fldFamily+'_'+fldName+' ('+ fldFatherName+')' AS fldName_Family
                      , Com.tblEmployee_Detail.fldFatherName,fldNameEN,fldMablagh+ISNULL((SELECT   SUM(  Pay.tblMoavaghat_Items.fldMablagh)
						FROM         Pay.tblMoavaghat INNER JOIN
						Pay.tblMoavaghat_Items ON Pay.tblMoavaghat.fldId = Pay.tblMoavaghat_Items.fldMoavaghatId WHERE fldMohasebatId=Pay.tblMohasebat.fldId AND Pay.tblMoavaghat_Items.fldItemEstekhdamId=Pay.tblMohasebat_Items.fldItemEstekhdamId AND fldHesabTypeItemId<>1),0) AS fldMablagh
                      ,(SELECT SUM(fldMablagh) FROM Pay.tblMohasebat_KosoratBank WHERE fldMohasebatId=Pay.tblMohasebat.fldId) AS KosoratBank,
                      ISNULL((SELECT    SUM( fldMablagh) FROM   [Pay].[tblMohasebat_kosorat/MotalebatParam] WHERE fldMohasebatId=Pay.tblMohasebat.fldId AND fldMotalebatId IS NOT null and fldHesabTypeParamId>1  ),0)AS JamMotalebat,
					  ISNULL((SELECT    SUM( fldMablagh) FROM   [Pay].[tblMohasebat_kosorat/MotalebatParam] WHERE fldMohasebatId=Pay.tblMohasebat.fldId AND fldKosoratId IS NOT null  and fldHesabTypeParamId>1 ),0) AS JamKosurat
					  ,0 AS fldMoavaghe
					 ,ISNULL((SELECT SUM(ISNULL(fldMablagh,0)) FROM Pay.tblMohasebat_Items as i inner join com.tblItems_Estekhdam as e on e.fldId=i.fldItemEstekhdamId  WHERE fldMohasebatId=Pay.tblMohasebat.fldId  AND fldHesabTypeItemId<>1 and fldItemsHoghughiId<>76),0)+isnull((SELECT SUM(fldMablagh) FROM [pay].[tblMohasebat_kosorat/MotalebatParam]WHERE  fldMohasebatId=Pay.tblMohasebat.fldid AND fldKosoratId IS NULL and fldHesabTypeParamId>1 ),0)+fldHaghDarmanKarfFarma+fldHaghDarmanDolat+(Pay.tblMohasebat.fldPasAndaz/2)+fldBimeTakmilyKarFarma+fldBimeOmrKarFarma +
						ISNULL((SELECT DISTINCT SUM(fldMablagh) OVER (PARTITION BY fldMohasebatId)     
FROM            Pay.tblMoavaghat INNER JOIN
                         Pay.tblMoavaghat_Items ON Pay.tblMoavaghat.fldId = Pay.tblMoavaghat_Items.fldMoavaghatId
						 WHERE fldMohasebatId =Pay.tblMohasebat.fldId AND fldHesabTypeItemId<>1),0)+ISNULL((SELECT
 +SUM(Pay.tblMoavaghat.fldHaghDarmanKarfFarma+Pay.tblMoavaghat.fldHaghDarmanDolat+(Pay.tblMoavaghat.fldPasAndaz/2))  FROM Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldid GROUP BY fldMohasebatId),0)
  +isnull((select fldMablagh from [Pay].[fn_KomakGheyerNaghdiPardakht]( fldPersonalId,@sal1 ,@Mah1 ,fldHesabTypeId )),0)
						 +isnull((select fldAmount from [Pay].[fn_KhalesPardakhtiSayerPardakhtsPardkhati]( fldPersonalId,@sal1 ,@Mah1,@Nobat1 ,fldHesabTypeId )),0)

 fldKolMotalebat
						
						,ISNULL((SELECT (ISNULL(abs(fldMablagh),0)) FROM Pay.tblMohasebat_Items as i inner join com.tblItems_Estekhdam as e on e.fldId=i.fldItemEstekhdamId  WHERE fldMohasebatId=Pay.tblMohasebat.fldId  AND fldHesabTypeItemId<>1 and fldItemsHoghughiId=76),0)+
						(ISNULL ((SELECT SUM(fldMablagh) FROM [pay].[tblMohasebat_kosorat/MotalebatParam]
WHERE  fldMohasebatId=Pay.tblMohasebat.fldId AND fldMotalebatId IS NULL  and fldHesabTypeParamId>1 ),0)+ISNULL((select SUM(fldMablagh) FROM Pay.tblMohasebat_KosoratBank WHERE fldMohasebatId=Pay.tblMohasebat.fldId),0)
+fldMosaede+fldBimePersonal+fldMaliyat+fldHaghDarman+Pay.tblMohasebat.fldPasAndaz+Pay.tblMohasebat.fldGhestVam+fldMogharari+fldBimeTakmily+Pay.tblMohasebat.fldBimeOmr)+
					    ISNULL(Com.fn_IsMaliyatforMohasebe(Pay.tblMohasebat.fldId),0)+ISNULL((SELECT sum(fldBimePersonal+fldPasAndaz+fldHaghDarman ) FROM Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldId GROUP BY fldMohasebatId),0) 
						+isnull((select fldkhalesPardakhti from [Pay].[fn_KhalesPardakhtiEydi]( fldPersonalId,@sal1 ,@Mah1 ,fldHesabTypeId )),0)
						+isnull((select fldkhalesPardakhti from [Pay].[fn_KomakGheyerNaghdi]( fldPersonalId,@sal1 ,@Mah1 ,fldHesabTypeId )),0)
						+isnull((select fldkhalesPardakhti from [Pay].[fn_KhalesPardakhtiSayerPardakhts]( fldPersonalId,@sal1 ,@Mah1,@Nobat1 ,fldHesabTypeId )),0)
						+isnull((select fldkhalesPardakhti from [Pay].[fn_OnAccount]( fldPersonalId,@sal1 ,@Mah1,@Nobat1 ,fldHesabTypeId,fldBankId )),0)

						fldKolKosurat
					 FROM            Pay.tblMohasebat INNER JOIN
                         Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebat.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatId INNER JOIN
                         Prs.Prs_tblPersonalInfo INNER JOIN
                         Pay.Pay_tblPersonalInfo ON Prs.Prs_tblPersonalInfo.fldId = Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId ON Pay.tblMohasebat.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                         Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId left JOIN
                         Pay.tblMohasebat_Items ON Pay.tblMohasebat.fldId = Pay.tblMohasebat_Items.fldMohasebatId left JOIN
                         Com.tblItems_Estekhdam ON Pay.tblMohasebat_Items.fldItemEstekhdamId = Com.tblItems_Estekhdam.fldId left JOIN
                         Com.tblItemsHoghughi ON Com.tblItems_Estekhdam.fldItemsHoghughiId = Com.tblItemsHoghughi.fldId left JOIN
                         Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
                         Com.tblShomareHesabeOmoomi ON Pay.tblMohasebat_PersonalInfo.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId
                       WHERE   fldHesabTypeItemId<>1 AND Pay.tblMohasebat_PersonalInfo.fldCostCenterId=@costCenter1 AND Pay.tblMohasebat_PersonalInfo.fldTypeBimeId=@typeBime1 AND 
                       fldYear=@Sal1 AND fldMonth=@mah1 AND fldNobatPardakht=@nobat1 AND Pay.tblMohasebat_PersonalInfo.fldOrganId=@organId1
                      and fldCalcType=@CalcType)t 
 PIVOT
 (MAX(fldMablagh)
FOR fldNameEN IN([h-paye],[sanavat],[paye],[sanavat-basiji],[sanavat-isar],[foghshoghl],[takhasosi],[made26],[modiryati],[barjastegi],[tatbigh],[fogh-isar],
[abohava],[tashilat],[sakhtikar],[tadil],[riali],[jazb9],[jazb],[makhsos],[vije],[olad],[ayelemandi],[kharobar],[maskan],[nobatkari],[bon],[jazb-tabsare],[talash],[jebhe]
,[janbazi],[sayer],[ezafekar],[ezafekariSayer],[mamoriat],[mamooriyatSayer],[tatilkari],[tatilkariSayer],[s_payankhedmat],[ghazai],[ashoora],[zaribtadil],[jazbTakhasosi],[jazbtadil],[hadaghaltadil],[shift]
,[band_y],[joz1],[band6],[jazb2],[jazb3],[vije2],[vije3],[makhsos2],[makhsos3],[tatbigh1],[khas],[karane],[refahi],[tarmim],[jazbTarmim],[VizheTarmim],[KhasTarmim]))p


IF(@type1=2)/*بدون معوقه */
SELECT [fldid], [fldKarkard],[fldGheybat],[fldTedadEzafeKar],[fldTedadTatilKar],[fldBaBeytute],[fldBedunBeytute],[fldBimeOmrKarFarma],[fldBimeOmr],[fldBimeTakmilyKarFarma],[fldBimeTakmily],[fldPersonalId]
,[fldHaghDarmanKarfFarma],[fldBimeKarFarma],
[fldHaghDarmanDolat],[fldBimePersonal],[fldHaghDarman],[fldMosaede],[fldGhestVam],[fldPasAndaz],[fldMogharari],[fldMaliyat],[fldkhalesPardakhti],
[fldShomareHesab],[fldName_Family],[fldFatherName],[KosoratBank],[JamMotalebat],[JamKosurat], [fldMoavaghe],[fldMashmolBime],[fldMashmolMaliyat],[fldKolMotalebat],[fldKolKosurat]
, ISNULL([h-paye],'')[h-paye],ISNULL([sanavat],'')[sanavat],ISNULL([paye],'')[paye],ISNULL([sanavat-basiji],'')[sanavat-basiji]
,ISNULL([sanavat-isar],'')[sanavat-isar],ISNULL([foghshoghl],'')[foghshoghl],ISNULL([takhasosi],'')[takhasosi],ISNULL([made26],'')[made26],
ISNULL([modiryati],'')[modiryati],ISNULL([barjastegi],'')[barjastegi],ISNULL([tatbigh],'')[tatbigh],ISNULL([fogh-isar],'')[fogh-isar],
ISNULL([abohava],'')[abohava],ISNULL([tashilat],'')[tashilat],ISNULL([sakhtikar],'')[sakhtikar],ISNULL([tadil],'')[tadil],
ISNULL([riali],'')[riali],[jazb9]=ISNULL([jazb9],0),ISNULL([jazb],'')+ISNULL([jazb2],0)+ISNULL([jazb3],0)+ISNULL([jazbTarmim],0)[jazb],
[makhsos]=ISNULL([makhsos],0)+ISNULL([makhsos2],0)+ISNULL([makhsos3],0),
[vije]=ISNULL([vije],0)+ISNULL([vije2],0)+ISNULL([vije3],0)+ISNULL([VizheTarmim],0),
ISNULL([olad],'')[olad],ISNULL([ayelemandi],'')[ayelemandi],ISNULL([kharobar],'')[kharobar],ISNULL([maskan],'')[maskan],ISNULL([nobatkari],'')[nobatkari],ISNULL([bon],'')[bon]
,ISNULL([jazb-tabsare],'')[jazb-tabsare],ISNULL([talash],'')[talash],ISNULL([jebhe],'')[jebhe],ISNULL([janbazi],'')[janbazi],ISNULL([sayer],'')[sayer]
,ISNULL([ezafekar],'')+ISNULL([p].[ezafekariSayer],'') as [ezafekar] ,ISNULL([mamoriat],'')+ISNULL([mamooriyatSayer],'') as [mamoriat]
,ISNULL([tatilkari],'')+ISNULL([tatilkariSayer],'') as [tatilkari] ,ISNULL([s_payankhedmat],'')[s_payankhedmat]
,ISNULL([ghazai],'') ghazai,ISNULL([ashoora],'')ashoora,ISNULL([zaribtadil],'')zaribtadil,ISNULL(jazbTakhasosi,'')jazbTakhasosi,ISNULL(jazbtadil,'') jazbtadil,ISNULL(hadaghaltadil,0)+ISNULL(tatbigh1,0)+ISNULL(khas,0)+ISNULL([karane],0)+ISNULL([refahi],0)+isnull([tarmim],0)+isnull([KhasTarmim],0) as hadaghaltadil,ISNULL(shift,'')shift
,ISNULL([band_y],0)[band_y] ,ISNULL([joz1],0)[joz1],ISNULL([band6],0)[band6]
 from(
SELECT   Pay.tblMohasebat.fldId,  Pay.tblMohasebat.fldKarkard, Pay.tblMohasebat.fldGheybat, Pay.tblMohasebat.fldTedadEzafeKar, Pay.tblMohasebat.fldTedadTatilKar, 
                      Pay.tblMohasebat.fldBaBeytute, Pay.tblMohasebat.fldBedunBeytute, Pay.tblMohasebat.fldBimeOmrKarFarma, Pay.tblMohasebat.fldBimeOmr, 
                      Pay.tblMohasebat.fldBimeTakmilyKarFarma, Pay.tblMohasebat.fldBimeTakmily,Pay.tblMohasebat.fldPersonalId
                      , Pay.tblMohasebat.fldHaghDarmanKarfFarma ,(fldBimeKarFarma+fldbimebikari) fldBimeKarFarma,
                      Pay.tblMohasebat.fldHaghDarmanDolat,
                       Pay.tblMohasebat.fldBimePersonal AS fldBimePersonal
                      , Pay.tblMohasebat.fldHaghDarman AS fldHaghDarman, 
                    fldMashmolBime AS fldMashmolBime,
                  fldMashmolMaliyat AS fldMashmolMaliyat,
                  
                  Pay.tblMohasebat.fldMosaede, Pay.tblMohasebat.fldGhestVam, 
                     Pay.tblMohasebat.fldPasAndaz AS fldPasAndaz,
                      Pay.tblMohasebat.fldMogharari 
                      ,(ISNULL(Pay.tblMohasebat.fldMaliyat,0)+ISNULL( (SELECT fldMablagh FROM Pay.tblP_MaliyatManfi WHERE fldMohasebeId=Pay.tblMohasebat.fldId),ISNULL((SELECT SUM(fldMaliyat) FROM Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldid),0))) AS fldMaliyat
                      ,  /* ( (SELECT SUM(ISNULL(fldMablagh,0)) FROM Pay.tblMohasebat_Items 
WHERE fldMohasebatId=Pay.tblMohasebat.fldId)+
(SELECT SUM(fldMablagh) FROM [pay].[tblMohasebat_kosorat/MotalebatParam]
WHERE  fldMohasebatId=Pay.tblMohasebat.fldId AND fldKosoratId IS NULL)+
+[fldHaghDarmanKarfFarma]
+[fldHaghDarmanDolat]+([Pay].[tblMohasebat].fldPasAndaz/(2))+[fldBimeTakmilyKarFarma]+[fldBimeOmrKarFarma])
-((SELECT SUM(fldMablagh) FROM [pay].[tblMohasebat_kosorat/MotalebatParam]
WHERE  fldMohasebatId=Pay.tblMohasebat.fldId AND fldMotalebatId IS NULL)+[fldHaghDarman]+[tblMohasebat].fldPasAndaz+(SELECT SUM(fldMablagh) FROM Pay.tblMohasebat_KosoratBank
WHERE fldMohasebatId=Pay.tblMohasebat.fldId)
+[fldMosaede]+[fldBimePersonal]+[fldMaliyat]+[fldBimeTakmily]+tblMohasebat.[fldBimeOmr]+[fldMogharari]+[fldGhestVam])
                     +ISNULL((select((SELECT SUM(Pay.tblMoavaghat_Items.fldMablagh)
               from       Pay.tblMoavaghat_Items 
                      WHERE fldMoavaghatId=tblMoavaghat.fldId)
+[fldHaghDarmanKarfFarma]+[fldHaghDarmanDolat]+([fldPasAndaz]/(2)))
-Com.fn_IsMaliyatManfiForMoavaghe(fldMohasebatId,fldid)+[fldBimePersonal]+[fldHaghDarman]+[fldPasAndaz] FROM Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldId),0)*/0 AS fldkhalesPardakhti,

                       Com.tblShomareHesabeOmoomi.fldShomareHesab, 
                   fldFamily+'_'+fldName+' ('+ fldFatherName+')' AS fldName_Family
                      , Com.tblEmployee_Detail.fldFatherName,fldNameEN,fldMablagh
                      ,(SELECT SUM(fldMablagh) FROM Pay.tblMohasebat_KosoratBank WHERE fldMohasebatId=Pay.tblMohasebat.fldId) AS KosoratBank,
                      ISNULL((SELECT    SUM( fldMablagh) FROM   [Pay].[tblMohasebat_kosorat/MotalebatParam] WHERE fldMohasebatId=Pay.tblMohasebat.fldId AND fldMotalebatId IS NOT null  and fldHesabTypeParamId>1 ),0)AS JamMotalebat,
					  ISNULL((SELECT    SUM( fldMablagh) FROM   [Pay].[tblMohasebat_kosorat/MotalebatParam] WHERE fldMohasebatId=Pay.tblMohasebat.fldId AND fldKosoratId IS NOT null  and fldHesabTypeParamId>1 ),0) AS JamKosurat
					  ,ISNULL((SELECT   SUM(  Pay.tblMoavaghat_Items.fldMablagh)
						FROM         Pay.tblMoavaghat INNER JOIN
						Pay.tblMoavaghat_Items ON Pay.tblMoavaghat.fldId = Pay.tblMoavaghat_Items.fldMoavaghatId WHERE fldMohasebatId=Pay.tblMohasebat.fldId AND fldHesabTypeItemId<>1),0) + isnull(fldMablaghMotamam,0) AS fldMoavaghe
						,ISNULL((SELECT SUM(ISNULL(fldMablagh,0)) FROM Pay.tblMohasebat_Items as i inner join com.tblItems_Estekhdam as e on e.fldId=i.fldItemEstekhdamId  WHERE fldMohasebatId=Pay.tblMohasebat.fldId  AND fldHesabTypeItemId<>1 and fldItemsHoghughiId<>76),0)
						+isnull((SELECT SUM(fldMablagh) FROM [pay].[tblMohasebat_kosorat/MotalebatParam]WHERE  fldMohasebatId=Pay.tblMohasebat.fldId AND fldKosoratId IS NULL and fldHesabTypeParamId>1 ),0)
						+fldHaghDarmanKarfFarma+fldHaghDarmanDolat+(Pay.tblMohasebat.fldPasAndaz/2)+fldBimeTakmilyKarFarma+fldBimeOmrKarFarma 
						 +isnull((select fldMablagh from [Pay].[fn_KomakGheyerNaghdiPardakht]( fldPersonalId,@sal1 ,@Mah1 ,fldHesabTypeId )),0)
						 +isnull((select fldAmount from [Pay].[fn_KhalesPardakhtiSayerPardakhtsPardkhati]( fldPersonalId,@sal1 ,@Mah1,@Nobat1 ,fldHesabTypeId )),0)

						as   fldKolMotalebat,
						ISNULL((SELECT (ISNULL(abs(fldMablagh),0)) FROM Pay.tblMohasebat_Items as i inner join com.tblItems_Estekhdam as e on e.fldId=i.fldItemEstekhdamId  WHERE fldMohasebatId=Pay.tblMohasebat.fldId  AND fldHesabTypeItemId<>1 and fldItemsHoghughiId=76),0)+
						ISNULL((select SUM(fldMablagh) FROM [pay].[tblMohasebat_kosorat/MotalebatParam] WHERE  fldMohasebatId=Pay.tblMohasebat.fldId AND fldMotalebatId IS NULL and fldHesabTypeParamId>1 ),0)+ISNULL((select SUM(fldMablagh) FROM Pay.tblMohasebat_KosoratBank WHERE fldMohasebatId=Pay.tblMohasebat.fldid),0)+fldMosaede+fldBimePersonal+fldMaliyat+fldHaghDarman+Pay.tblMohasebat.fldGhestVam+Pay.tblMohasebat.fldPasAndaz+fldBimeTakmily+fldMogharari+Pay.tblMohasebat.fldBimeOmr
						+isnull((select fldkhalesPardakhti from [Pay].[fn_KhalesPardakhtiEydi]( fldPersonalId,@sal1 ,@Mah1 ,fldHesabTypeId )),0)
						+isnull((select fldkhalesPardakhti from [Pay].[fn_KomakGheyerNaghdi]( fldPersonalId,@sal1 ,@Mah1 ,fldHesabTypeId )),0)
						+isnull((select fldkhalesPardakhti from [Pay].[fn_KhalesPardakhtiSayerPardakhts]( fldPersonalId,@sal1 ,@Mah1,@Nobat1 ,fldHesabTypeId )),0)
						+isnull((select fldkhalesPardakhti from [Pay].[fn_OnAccount]( fldPersonalId,@sal1 ,@Mah1,@Nobat1 ,fldHesabTypeId,fldBankId )),0)

						as fldKolKosurat
						 FROM            Pay.tblMohasebat INNER JOIN
                         Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebat.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatId INNER JOIN
                         Prs.Prs_tblPersonalInfo INNER JOIN
                         Pay.Pay_tblPersonalInfo ON Prs.Prs_tblPersonalInfo.fldId = Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId ON Pay.tblMohasebat.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                         Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId left JOIN
                         Pay.tblMohasebat_Items ON Pay.tblMohasebat.fldId = Pay.tblMohasebat_Items.fldMohasebatId left JOIN
                         Com.tblItems_Estekhdam ON Pay.tblMohasebat_Items.fldItemEstekhdamId = Com.tblItems_Estekhdam.fldId left JOIN
                         Com.tblItemsHoghughi ON Com.tblItems_Estekhdam.fldItemsHoghughiId = Com.tblItemsHoghughi.fldId left JOIN
                         Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
                         Com.tblShomareHesabeOmoomi ON Pay.tblMohasebat_PersonalInfo.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId
                      outer apply(select sum(o.fldMablagh) as fldMablaghMotamam from pay.tblMohasebat as m2 
								inner join Pay.tblMohasebat_PersonalInfo as p ON m2.fldId = p.fldMohasebatId
								inner join pay.tblMohasebat_ItemMotamam as o on o.fldMohasebatId=m2.fldId 
								where tblMohasebat.fldPersonalId=m2.fldPersonalId and m2.fldYear= @YearP and m2.fldMonth=@MonthP and o.fldHesabTypeItemId<>1
                                AND p.fldTypeBimeId=@typeBime1
								and p.fldCostCenterId=tblMohasebat_PersonalInfo.fldCostCenterId
                                group by m2.fldPersonalId )motamam
                       WHERE   fldHesabTypeItemId<>1 and Pay.tblMohasebat_PersonalInfo.fldCostCenterId=@costCenter1 AND Pay.tblMohasebat_PersonalInfo.fldTypeBimeId=@typeBime1 AND 
                       fldYear=@Sal1 AND fldMonth=@mah1 AND fldNobatPardakht=@nobat1 AND Pay.tblMohasebat_PersonalInfo.fldOrganId =@organId1
                    and fldCalcType=@CalcType
                      )t
                      
 PIVOT
 (MAX(fldMablagh)
FOR fldNameEN IN([h-paye],[sanavat],[paye],[sanavat-basiji],[sanavat-isar],[foghshoghl],[takhasosi],[made26],[modiryati],[barjastegi],[tatbigh],[fogh-isar],
[abohava],[tashilat],[sakhtikar],[tadil],[riali],[jazb9],[jazb],[makhsos],[vije],[olad],[ayelemandi],[kharobar],[maskan],[nobatkari],[bon],[jazb-tabsare],[talash],[jebhe]
,[janbazi],[sayer],[ezafekar],[ezafekariSayer],[mamoriat],[mamooriyatSayer],[tatilkari],[tatilkariSayer],[s_payankhedmat],[ghazai],[ashoora],[zaribtadil],[jazbTakhasosi],[jazbtadil],[hadaghaltadil],[shift],
[band_y],[joz1],[band6],[jazb2],[jazb3],[vije2],[vije3],[makhsos2],[makhsos3],[tatbigh1],[khas],[karane],[refahi],[tarmim],[jazbTarmim],[VizheTarmim],[KhasTarmim]))p      
GO
