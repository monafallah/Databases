SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE proc [Pay].[spr_Pay_Rpt12Mahe]
 @Sal SMALLINT,@nobat TINYINT,@organId INT,
@CalcType TINYINT=1
as
begin tran
--declare  @Sal SMALLINT=1401,@Mah int=1,@nobat TINYINT=1,@organId INT=1


SELECT  fldid,fldPersonalId as [آیدی پرسنل],fldMonth as [ماه],[fldMaliyat] as [مالیات],fldMaliyatMoavagh as [مالیات معوقه],
[fldName_Family] as [نام خانوادگی_نام],[fldFatherName] as [نام پدر],fldCodemeli as [کدملی],[fldMoavaghe] as [معوقه]
,[fldMashmolMaliyat] as [مشمول مالیات],fldMashmolMaliyatmoavaghe as [مشمول مالیات معوقه],
ISNULL([JamMotalebat],0) as [مطالبات],
ISNULL([fldKolMotalebat],0) as [کل مطالبات],
ISNULL([olad],'') as [حق اولاد],ISNULL([ayelemandi],'') as [عائله مندی],ISNULL([maskan],'')[حق مسکن],
ISNULL([ezafekar],'')+ISNULL([tatilkari],'')+ISNULL([ezafekariSayer],'')+ISNULL([tatilkariSayer],'') [تعطیل کاری+اضافه کاری]
 ,ISNULL([mamoriat],'')+ISNULL([mamooriyatSayer],'') [ماموریت] ,ISNULL([s_payankhedmat],'')[سنوات پایان خدمت]
 ,ISNULL(refahi,0)[تسهیلات رفاهی]
 ,ISNULL([h-paye],0)+ISNULL([sanavat],0)+ISNULL([paye],0)+ISNULL([sanavat-basiji],0)+ISNULL([sanavat-isar],0)+ISNULL([jebhe],0)+ISNULL([janbazi],0)+ISNULL([ashoora],0) as [حقوق]
 ,ISNULL([foghshoghl],0) as [فوق العاده شغل],ISNULL([takhasosi],0) as [تحقیقی و تخصصی],ISNULL([made26],0) as [فوق العاده ماده26]
 ,ISNULL([modiryati],0) as [مدیریتی و سرپرستی]
 ,ISNULL([barjastegi],0) as [برجستگی]
 ,ISNULL([tatbigh],0) as [تفاوت تطبیق],ISNULL([fogh-isar],0) as [فوق العاده ایثارگری],ISNULL([abohava],0) as [بدی آب و هوا]
 ,ISNULL([tashilat],0) as [تسهیلات زندگی]
 ,ISNULL([sakhtikar],0) as [سختی کار]
 ,ISNULL([tadil],0) as [فوق العاده تعدیل],ISNULL([riali],0) as [مزایای ریالی گروه تشویقی]
 ,ISNULL([jazb9],0) as [حق جذب بند9],ISNULL([kharobar],0) as [خوار و بار]
 ,ISNULL([nobatkari],0) as [نوبت کاری],ISNULL([bon],0) as [بن ماهیانه]
 ,ISNULL([jazb-tabsare],0) as [حق جذب تبصره 7 ماده یک],ISNULL([talash],0) as [فوق العاده تلاش]
,ISNULL([sayer],0) as [سایر مزایا],ISNULL([ezafekar],0) as [اضافه کاری]
,ISNULL([tatilkari],0) as [تعطیل کاری]
,ISNULL([ghazai],0) as [حق جذب قضایی],ISNULL([zaribtadil],0) as [ضریب تعدیل]
,ISNULL([jazbTakhasosi],0) as [جذب مشاغل تخصصی],ISNULL([jazbtadil],0) as [جذب تعدیل]
,ISNULL([hadaghaltadil],0) as [تفاوت ناشی از ضریب تعدیل],ISNULL([shift],0) as [حق شیفت],ISNULL([band_y],0) as [تفاوت بند(ی)]
,ISNULL([joz1],0) as [تفاوت جزء(1)],ISNULL([band6],0) as [تفاوت ناشی از بند6]
,ISNULL([jazb],0)+ISNULL([jazb2],0)+ISNULL([jazb3],0)+ISNULL([jazbTarmim],0) as [فوق العاده جذب]
,ISNULL([vije],0)+ISNULL([vije2],0)+ISNULL([vije3],0)+ISNULL([VizheTarmim],0) as [فوق العاده ویژه]
,ISNULL([makhsos],0)+ISNULL([makhsos2],0)+ISNULL([makhsos3],0) as [فوق العاده مخصوص]
,ISNULL([tatbigh1],0) as [تفاوت تطبیق موضوع جزء1],ISNULL([khas],0)+isnull([KhasTarmim],0) as [فوق العاده خاص],ISNULL([karane],0) as [کارانه]
,ISNULL([tarmim],0) as [ترمیم حقوق]
,([fldBimeOmr]-[fldBimeOmrKarFarma])+([fldBimeTakmily]-[fldBimeTakmilyKarFarma])+
[fldBimePersonal]+[fldHaghDarman]  as [بیمه معاف]
,ISNULL(fldPasAndaz,0) as [پس انداز+پس انداز معوق]
 ,ISNULL([fldBimeTakmilyKarFarma],'')  as [بیمه تکمیلی کارفرما]
 ,ISNULL([fldKolMotalebat],0)+ISNULL(fldHaghDarmanKarfFarma,0)+ISNULL(fldHaghDarmanDolat,0)+ISNULL((fldPasAndazKoli/2),0)+ISNULL(fldBimeTakmilyKarFarma,0)
 +ISNULL(fldBimeOmrKarFarma,0)+ISNULL(fldBimeKarFarmaAsli,0)+ISNULL(fldBimeBikari,0)+
 +ISNULL(fldHaghDarmanKarfFarma_m,0)+ISNULL(fldHaghDarmanDolat_m,0)+ISNULL(fldPasAndaz_m,0)+ISNULL(fldBimeBikari_m,0)+ISNULL(fldBimeKarFarma_m2,0) as [جمع مطالبات]
 ,ISNULL(fldHaghDarmanKarfFarma,0) as [حق درمان سهم کارفرما],ISNULL(fldHaghDarmanDolat,0)as [حق درمان سهم دولت],ISNULL((fldPasAndazKoli/2),0)as [پس انداز]
 ,ISNULL(fldBimeTakmilyKarFarma,0)as [بیمه تکمیلی سهم کارفرما],ISNULL(fldBimeOmrKarFarma,0)as [بیمه عمر سهم کارفرما]
 ,ISNULL(fldBimeKarFarmaAsli,0)as [بیمه سهم کارفرما],ISNULL(fldBimeBikari,0)as [بیمه بیکاری],
 ISNULL(fldHaghDarmanKarfFarma_m,0)as [حق درمان سهم کارفرما معوق],ISNULL(fldHaghDarmanDolat_m,0)as [حق درمان سهم دولت معوق],ISNULL(fldPasAndaz_m,0)as [پس انداز معوق]
 ,ISNULL(fldBimeBikari_m,0)as [بیمه بیکاری معوق],ISNULL(fldBimeKarFarma_m2,0)as [بیمه سهم کارفرما معوق]
  ,ISNULL(mazayaRefahi,0)as [مزایای جانبی رفاهی]
  ,ISNULL(mahdeKodak,0)as [هزینه مهد کودک]
  ,ISNULL(khoraki,0)as [اقلام خوراکی]
  ,ISNULL(kalaBehdashti,0)as [کالاهای بهداشتی]
  ,ISNULL(Monasebat,0)as [مناسبت]	 
  ,ISNULL(javani,0)as [مزایای جوانی جمعیت]
  ,ISNULL(madares,0)as [بازگشایی مدارس]	 
  ,ISNULL(eydi,0)as [عیدی]
 FROM(
SELECT   Pay.tblMohasebat.fldId,fldMonth,  Pay.tblMohasebat.fldKarkard, Pay.tblMohasebat.fldGheybat, Pay.tblMohasebat.fldTedadEzafeKar, Pay.tblMohasebat.fldTedadTatilKar, 
                     Pay.tblMohasebat.fldBaBeytute, Pay.tblMohasebat.fldBedunBeytute, Pay.tblMohasebat.fldBimeOmrKarFarma, Pay.tblMohasebat.fldBimeOmr, 
                      Pay.tblMohasebat.fldBimeTakmilyKarFarma, Pay.tblMohasebat.fldBimeTakmily,Pay.tblMohasebat.fldPersonalId
                      , Pay.tblMohasebat.fldHaghDarmanKarfFarma 
					  ,(ISNULL(fldBimeKarFarma,0)+ISNULL(fldbimebikari,0)+isnull(m.fldBimeKarFarma_m,0))/*ISNULL((SELECT SUM(Pay.tblMoavaghat.fldBimeKarFarma+Pay.tblMoavaghat.fldbimebikari) FROM Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldid),0)*/
					  fldBimeKarFarma,fldBimeKarFarma as fldBimeKarFarmaAsli,
                      Pay.tblMohasebat.fldHaghDarmanDolat,
                       Pay.tblMohasebat.fldBimePersonal+isnull(m.fldBimePersonal_m,0)/*ISNULL((SELECT SUM(Pay.tblMoavaghat.fldBimePersonal) FROM Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldid),0)*/ AS fldBimePersonal
                      , Pay.tblMohasebat.fldHaghDarman+isnull(m.fldHaghDarman_m,0)/*ISNULL((SELECT sum (Pay.tblMoavaghat.fldHaghDarman) FROM Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldId),0)*/ AS fldHaghDarman, 
                      fldMashmolBime+isnull(m.fldMashmolBime_m,0)/*ISNULL((SELECT SUM(Pay.tblMoavaghat.fldMashmolBime) FROM Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldId ),0)*/ AS fldMashmolBime,
                  fldMashmolMaliyat,isnull(m.fldMashmolMaliyat_m,0)/*ISNULL((SELECT SUM(Pay.tblMoavaghat.fldMashmolMaliyat) FROM Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldId ),0)*/ AS fldMashmolMaliyatmoavaghe,
                             Pay.tblMohasebat.fldMosaede, Pay.tblMohasebat.fldGhestVam, 
                     Pay.tblMohasebat.fldPasAndaz/2+isnull(m.fldPasAndaz_m,0)/*ISNULL((SELECT  sum (Pay.tblMoavaghat.fldPasAndaz/2) FROM Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldId),0)*/ AS fldPasAndaz,
                      Pay.tblMohasebat.fldMogharari 
                      ,ISNULL(Pay.tblMohasebat.fldMaliyat,0)as fldMaliyat,ISNULL( (SELECT fldMablagh FROM Pay.tblP_MaliyatManfi WHERE fldMohasebeId=Pay.tblMohasebat.fldId)
					  ,(isnull(m.fldMaliyat_m,0))/*ISNULL((SELECT SUM(fldMaliyat) FROM Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldid),0)*/) AS fldMaliyatMoavagh
                      ,/* از قبل( (SELECT SUM(ISNULL(fldMablagh,0)) FROM Pay.tblMohasebat_Items 
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
-Com.fn_IsMaliyatManfiForMoavaghe(fldMohasebatId,fldid)+[fldBimePersonal]+[fldHaghDarman]+[fldPasAndaz] FROM Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldId),0) تا اینجا*/0 AS fldkhalesPardakhti
                    ,fldBimeBikari, Pay.tblMohasebat.fldPasAndaz as fldPasAndazKoli
                      ,Com.tblShomareHesabeOmoomi.fldShomareHesab, 
                     fldFamily+'_'+fldName+' ('+ fldFatherName+')' AS fldName_Family,fldCodemeli
                     , Com.tblEmployee_Detail.fldFatherName,fldNameEN
					 ,fldMablagh+
					 ISNULL((SELECT   SUM(  Pay.tblMoavaghat_Items.fldMablagh)
						FROM         Pay.tblMoavaghat INNER JOIN
						Pay.tblMoavaghat_Items ON Pay.tblMoavaghat.fldId = Pay.tblMoavaghat_Items.fldMoavaghatId WHERE fldMohasebatId=Pay.tblMohasebat.fldId
						AND Pay.tblMoavaghat_Items.fldItemEstekhdamId=Pay.tblMohasebat_Items.fldItemEstekhdamId),0)
						+isnull((select sum(o.fldMablagh) as fldMablaghMotamam from pay.tblMohasebat as m2 
								inner join pay.tblMohasebat_ItemMotamam as o on o.fldMohasebatId=m2.fldId 
								AND o.fldItemEstekhdamId=Pay.tblMohasebat_Items.fldItemEstekhdamId
								where m2.fldPersonalId=tblMohasebat.fldPersonalId and m2.fldYear=case when tblMohasebat.fldMonth=1 then @Sal-1 else @sal end
								and m2.fldMonth=case when tblMohasebat.fldMonth=1 then 12 else tblMohasebat.fldMonth-1 end ),0)
						AS fldMablagh
						--+ISNULL(mi.fldMablagh_item,0)
                      ,/*(SELECT SUM(fldMablagh) FROM Pay.tblMohasebat_KosoratBank WHERE fldMohasebatId=Pay.tblMohasebat.fldId)*/
					  b.fldMablagh_b AS KosoratBank,
                      /*ISNULL((SELECT    SUM( fldMablagh) FROM   [Pay].[tblMohasebat_kosorat/MotalebatParam] WHERE fldMohasebatId=Pay.tblMohasebat.fldId AND fldMotalebatId IS NOT null ),0)*/
					  mo.fldMablagh_mo as JamMotalebat,
					  /*ISNULL((SELECT    SUM( fldMablagh) FROM   [Pay].[tblMohasebat_kosorat/MotalebatParam] WHERE fldMohasebatId=Pay.tblMohasebat.fldId AND fldKosoratId IS NOT null ),0)*/
					  k.fldMablagh_k AS JamKosurat
					  ,0 AS fldMoavaghe
					 ,ISNULL(mi.fldMablagh_Item,0)--ISNULL((SELECT SUM(ISNULL(fldMablagh,0)) FROM Pay.tblMohasebat_Items WHERE fldMohasebatId=Pay.tblMohasebat.fldid),0)
					 +ISNULL(mo.fldMablagh_mo,0)/*isnull((SELECT SUM(fldMablagh) FROM [pay].[tblMohasebat_kosorat/MotalebatParam]WHERE  fldMohasebatId=Pay.tblMohasebat.fldid AND fldKosoratId IS NULL),0)*/
					 + ISNULL((SELECT  SUM(fldMablagh)  
					 				  
FROM            Pay.tblMoavaghat INNER JOIN
                         Pay.tblMoavaghat_Items ON Pay.tblMoavaghat.fldId = Pay.tblMoavaghat_Items.fldMoavaghatId
						 WHERE fldMohasebatId =Pay.tblMohasebat.fldId),0) 
						 fldKolMotalebat
						,m.fldHaghDarmanKarfFarma_m,m.fldHaghDarmanDolat_m,m.fldPasAndaz_m,m.fldBimeBikari_m,m.fldBimeKarFarma_m2
						,(/*ISNULL ((SELECT SUM(fldMablagh) FROM [pay].[tblMohasebat_kosorat/MotalebatParam]
WHERE  fldMohasebatId=Pay.tblMohasebat.fldId AND fldMotalebatId IS NULL),0)*/
isnull( k.fldMablagh_k,0)+isnull(b.fldMablagh_b,0)
--ISNULL((select SUM(fldMablagh) FROM Pay.tblMohasebat_KosoratBank WHERE fldMohasebatId=Pay.tblMohasebat.fldId),0)
+fldMosaede+fldBimePersonal+fldMaliyat+fldHaghDarman+Pay.tblMohasebat.fldPasAndaz+Pay.tblMohasebat.fldGhestVam+fldMogharari+fldBimeTakmily+Pay.tblMohasebat.fldBimeOmr)
--+ISNULL(Com.fn_IsMaliyatforMohasebe(Pay.tblMohasebat.fldId),0)
+coalesce(mm.fldMablagh_Manfi,m.fldMaliyat_m,0)
--+ISNULL((SELECT sum(fldBimePersonal+fldPasAndaz+fldHaghDarman ) FROM Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldId GROUP BY fldMohasebatId),0) 
+ISNULL(fldKosurat_m,0)
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
						 outer apply(SELECT SUM(Pay.tblMoavaghat.fldHaghDarmanKarfFarma) as fldHaghDarmanKarfFarma_m,sum(Pay.tblMoavaghat.fldHaghDarmanDolat) as fldHaghDarmanDolat_m
						 				 ,SUM(Pay.tblMoavaghat.fldBimeBikari) as fldBimeBikari_m,SUM(Pay.tblMoavaghat.fldBimeKarFarma ) as fldBimeKarFarma_m2,
									 SUM(Pay.tblMoavaghat.fldBimeKarFarma+Pay.tblMoavaghat.fldbimebikari) as fldBimeKarFarma_m
									,SUM(Pay.tblMoavaghat.fldBimePersonal) as fldBimePersonal_m,sum (Pay.tblMoavaghat.fldHaghDarman)  as fldHaghDarman_m
									,SUM(Pay.tblMoavaghat.fldMashmolBime) as fldMashmolBime_m,SUM(Pay.tblMoavaghat.fldMashmolMaliyat) as fldMashmolMaliyat_m
									,sum (Pay.tblMoavaghat.fldPasAndaz/2) as fldPasAndaz_m,SUM(fldMaliyat) as fldMaliyat_m
									,sum(fldBimePersonal+fldPasAndaz+fldHaghDarman ) as fldKosurat_m
									FROM Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldid)m
						outer apply(SELECT    SUM( fldMablagh) as fldMablagh_mo FROM   [Pay].[tblMohasebat_kosorat/MotalebatParam]
									WHERE fldMohasebatId=Pay.tblMohasebat.fldId AND fldMotalebatId IS NOT null)mo
						outer apply(SELECT    SUM( fldMablagh) as fldMablagh_k FROM   [Pay].[tblMohasebat_kosorat/MotalebatParam]
									WHERE fldMohasebatId=Pay.tblMohasebat.fldId AND fldKosoratId IS NOT null)k
						outer apply(SELECT SUM(fldMablagh) as fldMablagh_b FROM Pay.tblMohasebat_KosoratBank WHERE fldMohasebatId=Pay.tblMohasebat.fldId)b
                      outer apply( SELECT     fldMablagh as fldMablagh_Manfi   FROM   Pay.tblP_MaliyatManfi WHERE fldMohasebeId=Pay.tblMohasebat.fldId)mm
					outer apply(SELECT SUM(ISNULL(fldMablagh,0)) as fldMablagh_Item  FROM Pay.tblMohasebat_Items WHERE fldMohasebatId=Pay.tblMohasebat.fldid)mi
					--outer apply(SELECT  SUM(fldMablagh)   fldMablagh_Moavaghe
					--			FROM            Pay.tblMoavaghat INNER JOIN
					--			 Pay.tblMoavaghat_Items ON Pay.tblMoavaghat.fldId = Pay.tblMoavaghat_Items.fldMoavaghatId
					--			 WHERE fldMohasebatId =Pay.tblMohasebat.fldId)m_item
					-- outer apply(SELECT   SUM(  Pay.tblMoavaghat_Items.fldMablagh) as fldMablagh_item
						--FROM         Pay.tblMoavaghat INNER JOIN
						--Pay.tblMoavaghat_Items ON Pay.tblMoavaghat.fldId = Pay.tblMoavaghat_Items.fldMoavaghatId WHERE fldMohasebatId=Pay.tblMohasebat.fldId
						--AND Pay.tblMoavaghat_Items.fldItemEstekhdamId=Pay.tblMohasebat_Items.fldItemEstekhdamId)mi
					   WHERE fldYear=@Sal and fldNobatPardakht=@nobat AND Pay.tblMohasebat_PersonalInfo.fldOrganId=@organId
					   and fldCalcType=@CalcType
        )t 
 PIVOT
 (sum(fldMablagh)
FOR fldNameEN IN([h-paye],[sanavat],[paye],[sanavat-basiji],[sanavat-isar],[foghshoghl],[takhasosi],[made26],[modiryati],[barjastegi],[tatbigh],[fogh-isar],
[abohava],[tashilat],[sakhtikar],[tadil],[riali],[jazb9],[jazb],[makhsos],[vije],[olad],[ayelemandi],[kharobar],[maskan],[nobatkari],[bon],[jazb-tabsare],[talash],[jebhe]
,[janbazi],[sayer],[ezafekar],[mamoriat],[tatilkari],[s_payankhedmat],[ghazai],[ashoora],[zaribtadil],[jazbTakhasosi],[jazbtadil],[hadaghaltadil],[shift]
,[band_y],[joz1],[band6],[jazb2],[jazb3],[vije2],[vije3],[makhsos2],[makhsos3],[tatbigh1],[khas],[karane],[refahi],[tarmim],[jazbTarmim],[VizheTarmim],[KhasTarmim]
,[mazayaRefahi],[mahdeKodak],[khoraki],[kalaBehdashti],[Monasebat],[javani],[madares],[eydi],[mamooriyatSayer],[tatilkariSayer],[ezafekariSayer]))p
--where fldPersonalId=747

order by fldid  
commit tran
GO
