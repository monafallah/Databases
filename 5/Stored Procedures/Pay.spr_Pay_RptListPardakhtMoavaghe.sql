SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_Pay_RptListPardakhtMoavaghe](@sal SMALLINT,@mah TINYINT,@PersonalId INT,@organId INT,@CalcType TINYINT=1)
as
IF(@PersonalId<>0)
BEGIN
SELECT [fldBimeKarfarma],[fldBimePersonal],[fldMaliyat],[fldMashmolBime],isnull([fldShomareHesab],0)[fldShomareHesab],[fldTedadEzafeKar],[fldTedadTatilKar],[fldKhalesPardakhti],[NameMah],[Sal],[fldHaghDarmanKarfFarma],[fldHaghDarmanDolat],[fldPasAndaz]
,[fldName_Family],[fldPersonalId],ISNULL([h-paye],0)[h-paye],ISNULL([sanavat],0)[sanavat],ISNULL([paye],0)[paye],ISNULL([sanavat-basiji],0)[sanavat-basiji]
,ISNULL([sanavat-isar],0)[sanavat-isar],ISNULL([foghshoghl],0)[foghshoghl],ISNULL([takhasosi],0)[takhasosi],ISNULL([made26],0)[made26],
ISNULL([modiryati],0)[modiryati],ISNULL([barjastegi],0)[barjastegi],ISNULL([tatbigh],0)[tatbigh],ISNULL([fogh-isar],0)[fogh-isar],
ISNULL([abohava],0)[abohava],ISNULL([tashilat],0)[tashilat],ISNULL([sakhtikar],0)[sakhtikar],ISNULL([tadil],0)[tadil],
ISNULL([riali],0)[riali],
[jazb9]=ISNULL([jazb9],0),
ISNULL([jazb],0)+ISNULL([jazb2],0)+ISNULL([jazb3],0)+ISNULL([jazbTarmim],0)[jazb],
[makhsos]=ISNULL([makhsos],0)+ISNULL([makhsos2],0)+ISNULL([makhsos3],0),
[vije]=ISNULL([vije],0)+ISNULL([vije2],0)+ISNULL([vije3],0)+ISNULL([VizheTarmim],0),
ISNULL([olad],0)[olad],ISNULL([ayelemandi],0)[ayelemandi],ISNULL([kharobar],0)[kharobar],ISNULL([maskan],0)+ISNULL([karane],0)+ISNULL([refahi],0)[maskan],ISNULL([nobatkari],0)[nobatkari],ISNULL([bon],0)[bon]
,ISNULL([jazb-tabsare],0)[jazb-tabsare],ISNULL([talash],0)[talash],ISNULL([jebhe],0)[jebhe],ISNULL([janbazi],0)[janbazi],ISNULL([sayer],0)[sayer],(ISNULL([ezafekar],0))[ezafekar] ,ISNULL([mamoriat],0)[mamoriat]
,ISNULL([tatilkari],0)[tatilkari] ,ISNULL([s_payankhedmat],0)[s_payankhedmat],ISNULL([ghazai],'') ghazai,ISNULL([ashoora],'')ashoora,ISNULL([zaribtadil],'')zaribtadil,ISNULL([jazbTakhasosi],'') jazbTakhasosi,
ISNULL(jazbtadil,'')jazbtadil,ISNULL(hadaghaltadil,0)+isnull(tatbigh1,0)+isnull(khas,0)+isnull([tarmim],0)+isnull([KhasTarmim],0) as hadaghaltadil
,ISNULL([band_y],0)[band_y] ,ISNULL([joz1],0)[joz1],ISNULL([band6],0)[band6]
FROM (SELECT DISTINCT       ISNULL((tblMoavaghat.fldPasAndaz),0) AS fldPasAndaz,
                             ISNULL((tblMoavaghat.fldBimeKarFarma + tblMoavaghat.fldBimeBikari), 0) AS fldBimeKarfarma,
                              ISNULL((tblMoavaghat.fldBimePersonal), 0) AS fldBimePersonal,
                                   /*ISNULL((select fldmablagh from pay.tblP_MaliyatManfi where tblP_MaliyatManfi.fldMohasebeId=tblMohasebat.fldid),*/isnull(tblMoavaghat.fldMaliyat, 0)/*)*/AS fldMaliyat,
                                     ISNULL(tblMoavaghat.fldMashmolBime, 0) AS fldMashmolBime, (select fldShomareHesab from com.tblShomareHesabeOmoomi where fldid=tblMohasebat_PersonalInfo.fldShomareHesabId) fldShomareHesab, (select isnull(fldTedadEzafeKar,0.00) from pay.tblMohasebat as a where a.fldYear=tblMoavaghat.fldYear and a.fldmonth=tblMoavaghat.fldMonth and a.fldPersonalId=tblMohasebat.fldPersonalId) fldTedadEzafeKar, 
                         ISNULL(Com.tblItemsHoghughi.fldNameEN, '') AS fldNameEN,(select isnull(fldTedadTatilKar,0.00) from pay.tblMohasebat as a where a.fldYear=tblMoavaghat.fldYear and a.fldmonth=tblMoavaghat.fldMonth and a.fldPersonalId=tblMohasebat.fldPersonalId) fldTedadTatilKar,(SELECT        Com.tblEmployee.fldFamily + '_' + Com.tblEmployee.fldName + '(' +fldFatherName+')'
FROM            Com.tblEmployee LEFT OUTER JOIN
                         Com.tblEmployee_Detail ON Com.tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId where tblEmployee.fldId=Prs_tblPersonalInfo.fldEmployeeId) AS fldName_Family, Pay.tblMohasebat.fldPersonalId,
                            /* (SELECT        SUM(Pay.tblMoavaghat_Items.fldMablagh) AS Expr1
                               FROM            Pay.tblMoavaghat_Items INNER JOIN
                                                         Pay.tblMoavaghat AS tblMoavaghat_6 ON Pay.tblMoavaghat_Items.fldMoavaghatId = tblMoavaghat_6.fldId
                               WHERE        (Pay.tblMoavaghat_Items.fldItemEstekhdamId = Com.tblItems_Estekhdam.fldId) AND (tblMoavaghat_6.fldMohasebatId = Pay.tblMohasebat.fldId))*/
							    tblMoavaghat_Items. fldmablagh AS fldmablagh, Com.fn_month(Pay.tblMoavaghat.fldMonth) AS NameMah,
                         tblMoavaghat. fldYear AS Sal,tblMoavaghat.fldMonth, tblMoavaghat.fldHaghDarmanKarfFarma+ tblMoavaghat.fldHaghDarmanDolat as fldHaghDarmanKarfFarma, tblMoavaghat.fldHaghDarman as fldHaghDarmanDolat, tblMoavaghat.fldkhalesPardakhti
FROM         Pay.tblMohasebat INNER JOIN
                      Pay.tblMoavaghat ON Pay.tblMohasebat.fldId = Pay.tblMoavaghat.fldMohasebatId left JOIN
                      Pay.tblMoavaghat_Items ON Pay.tblMoavaghat.fldId = Pay.tblMoavaghat_Items.fldMoavaghatId INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebat.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatId INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblMohasebat.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId left JOIN
                      Com.tblItems_Estekhdam ON Pay.tblMoavaghat_Items.fldItemEstekhdamId = Com.tblItems_Estekhdam.fldId left JOIN
                      Com.tblItemsHoghughi ON Com.tblItems_Estekhdam.fldItemsHoghughiId = Com.tblItemsHoghughi.fldId                      
					  WHERE Pay.tblMohasebat.fldYear=@sal AND Pay.tblMohasebat.fldMonth=@mah AND Pay.tblMohasebat.fldPersonalId=@PersonalId
                      AND Pay.tblMohasebat_PersonalInfo.fldOrganId=@organId and fldCalcType=@CalcType)t2
                      
PIVOT
(MAX(fldmablagh)
FOR fldNameEN IN([h-paye],[sanavat],[paye],[sanavat-basiji],[sanavat-isar],[foghshoghl],[takhasosi],[made26],[modiryati],[barjastegi],[tatbigh],[fogh-isar],
[abohava],[tashilat],[sakhtikar],[tadil],[riali],[jazb9],[jazb],[makhsos],[vije],[olad],[ayelemandi],[kharobar],[maskan],[nobatkari],[bon],[jazb-tabsare],[talash],[jebhe]
,[janbazi],[sayer],[ezafekar],[mamoriat],[tatilkari],[s_payankhedmat],[ghazai],[ashoora],[zaribtadil],[jazbTakhasosi],[jazbtadil],[hadaghaltadil]
,[band_y],[joz1],[band6],[jazb2],[jazb3],[vije2],[vije3],[makhsos2],[makhsos3],[tatbigh1],[khas],[karane],[refahi],[tarmim],[jazbTarmim],[VizheTarmim],[KhasTarmim]))p
END
ELSE
BEGIN
SELECT [fldBimeKarfarma],[fldBimePersonal],[fldMaliyat],[fldMashmolBime],isnull([fldShomareHesab],0)[fldShomareHesab],[fldTedadEzafeKar],[fldTedadTatilKar],[fldKhalesPardakhti],[NameMah],[Sal],[fldHaghDarmanKarfFarma],[fldHaghDarmanDolat],[fldPasAndaz]
,[fldName_Family],[fldPersonalId],ISNULL([h-paye],0)[h-paye],ISNULL([sanavat],0)[sanavat],ISNULL([paye],0)[paye],ISNULL([sanavat-basiji],0)[sanavat-basiji]
,ISNULL([sanavat-isar],0)[sanavat-isar],ISNULL([foghshoghl],0)[foghshoghl],ISNULL([takhasosi],0)[takhasosi],ISNULL([made26],0)[made26],
ISNULL([modiryati],0)[modiryati],ISNULL([barjastegi],0)[barjastegi],ISNULL([tatbigh],0)[tatbigh],ISNULL([fogh-isar],0)[fogh-isar],
ISNULL([abohava],0)[abohava],ISNULL([tashilat],0)[tashilat],ISNULL([sakhtikar],0)[sakhtikar],ISNULL([tadil],0)[tadil],
ISNULL([riali],0)[riali],[jazb9]=ISNULL([jazb9],0),
ISNULL([jazb],0)+ISNULL([jazb2],0)+ISNULL([jazb3],0)+ISNULL([jazbTarmim],0)[jazb],
[makhsos]=ISNULL([makhsos],0)+ISNULL([makhsos2],0)+ISNULL([makhsos3],0),
[vije]=ISNULL([vije],0)+ISNULL([vije2],0)+ISNULL([vije3],0)+ISNULL([VizheTarmim],0),
ISNULL([olad],0)[olad],ISNULL([ayelemandi],0)[ayelemandi],ISNULL([kharobar],0)[kharobar],ISNULL([maskan],0)+ISNULL([karane],0)+ISNULL([refahi],0)[maskan],ISNULL([nobatkari],0)[nobatkari],ISNULL([bon],0)[bon]
,ISNULL([jazb-tabsare],0)[jazb-tabsare],ISNULL([talash],0)[talash],ISNULL([jebhe],0)[jebhe],ISNULL([janbazi],0)[janbazi],ISNULL([sayer],0)[sayer],(ISNULL([ezafekar],0))[ezafekar]
,ISNULL([mamoriat],0)[mamoriat],ISNULL([tatilkari],0)[tatilkari] ,ISNULL([s_payankhedmat],0)[s_payankhedmat],ISNULL([ghazai],'') ghazai,ISNULL([ashoora],'')ashoora,ISNULL([zaribtadil],'')zaribtadil
,ISNULL([jazbTakhasosi],'') jazbTakhasosi,ISNULL(jazbtadil,'')jazbtadil,ISNULL(hadaghaltadil,0)+isnull(tatbigh1,0)+isnull(khas,0)+isnull([tarmim],0)+isnull([KhasTarmim],0) as hadaghaltadil
FROM (SELECT DISTINCT       ISNULL((tblMoavaghat.fldPasAndaz),0) AS fldPasAndaz,
                             ISNULL((tblMoavaghat.fldBimeKarFarma + tblMoavaghat.fldBimeBikari), 0) AS fldBimeKarfarma,
                              ISNULL((tblMoavaghat.fldBimePersonal), 0) AS fldBimePersonal,
                                   /*ISNULL((select fldmablagh from pay.tblP_MaliyatManfi where tblP_MaliyatManfi.fldMohasebeId=tblMohasebat.fldid),*/isnull(tblMoavaghat.fldMaliyat, 0)/*)*/AS fldMaliyat,
                                     ISNULL(tblMoavaghat.fldMashmolBime, 0) AS fldMashmolBime, (select fldShomareHesab from com.tblShomareHesabeOmoomi where fldid=tblMohasebat_PersonalInfo.fldShomareHesabId) fldShomareHesab, (select isnull(fldTedadEzafeKar,0.00) from pay.tblMohasebat as a where a.fldYear=tblMoavaghat.fldYear and a.fldmonth=tblMoavaghat.fldMonth and a.fldPersonalId=tblMohasebat.fldPersonalId) fldTedadEzafeKar,  
                         ISNULL(Com.tblItemsHoghughi.fldNameEN, '') AS fldNameEN,(select isnull(fldTedadTatilKar,0.00) from pay.tblMohasebat as a where a.fldYear=tblMoavaghat.fldYear and a.fldmonth=tblMoavaghat.fldMonth and a.fldPersonalId=tblMohasebat.fldPersonalId) fldTedadTatilKar,(SELECT        Com.tblEmployee.fldFamily + '_' + Com.tblEmployee.fldName + '(' +fldFatherName+')'
FROM            Com.tblEmployee LEFT OUTER JOIN
                         Com.tblEmployee_Detail ON Com.tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId where tblEmployee.fldId=Prs_tblPersonalInfo.fldEmployeeId) AS fldName_Family, Pay.tblMohasebat.fldPersonalId,
                             /*(SELECT        SUM(Pay.tblMoavaghat_Items.fldMablagh) AS Expr1
                               FROM            Pay.tblMoavaghat_Items INNER JOIN
                                                         Pay.tblMoavaghat AS tblMoavaghat_6 ON Pay.tblMoavaghat_Items.fldMoavaghatId = tblMoavaghat_6.fldId
                               WHERE        (Pay.tblMoavaghat_Items.fldItemEstekhdamId = Com.tblItems_Estekhdam.fldId) AND (tblMoavaghat_6.fldMohasebatId = Pay.tblMohasebat.fldId))*/
							     tblMoavaghat_Items. fldmablagh AS fldmablagh, Com.fn_month(Pay.tblMoavaghat.fldMonth) AS NameMah,
                         tblMoavaghat. fldYear AS Sal,tblMoavaghat.fldMonth, tblMoavaghat.fldHaghDarmanKarfFarma+tblMoavaghat.fldHaghDarmanDolat as fldHaghDarmanKarfFarma,tblMoavaghat.fldHaghDarman as fldHaghDarmanDolat, tblMoavaghat.fldkhalesPardakhti
FROM         Pay.tblMohasebat INNER JOIN
                      Pay.tblMoavaghat ON Pay.tblMohasebat.fldId = Pay.tblMoavaghat.fldMohasebatId left JOIN
                      Pay.tblMoavaghat_Items ON Pay.tblMoavaghat.fldId = Pay.tblMoavaghat_Items.fldMoavaghatId INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebat.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatId INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblMohasebat.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId left JOIN
                      Com.tblItems_Estekhdam ON Pay.tblMoavaghat_Items.fldItemEstekhdamId = Com.tblItems_Estekhdam.fldId left JOIN
                      Com.tblItemsHoghughi ON Com.tblItems_Estekhdam.fldItemsHoghughiId = Com.tblItemsHoghughi.fldId
                      WHERE tblMohasebat.fldYear=@sal AND tblMohasebat.fldMonth=@mah AND Pay.tblMohasebat_PersonalInfo.fldOrganId=@organId  and fldCalcType=@CalcType
					  group by tblMoavaghat.fldPasAndaz,tblMoavaghat.fldBimeKarFarma,tblMoavaghat.fldBimeBikari,tblMoavaghat.fldBimePersonal,fldTedadTatilKar
					  ,fldTedadEzafeKar,fldNameEN,fldEmployeeId,Pay.tblMohasebat.fldPersonalId,Com.tblItems_Estekhdam.fldId,Pay.tblMohasebat.fldId,Pay.tblMoavaghat.fldYear
					  ,Pay.tblMoavaghat.fldMonth,Pay.tblMoavaghat.fldHaghDarmanKarfFarma,Pay.tblMoavaghat.fldHaghDarmanDolat,Pay.tblMoavaghat.fldHaghDarman,Pay.tblMoavaghat.fldkhalesPardakhti,
					  tblMoavaghat.fldMaliyat,tblMoavaghat.fldMashmolBime,tblMohasebat_PersonalInfo.fldShomareHesabId,fldmablagh)t2
                      
PIVOT
(MAX(fldmablagh)
FOR fldNameEN IN([h-paye],[sanavat],[paye],[sanavat-basiji],[sanavat-isar],[foghshoghl],[takhasosi],[made26],[modiryati],[barjastegi],[tatbigh],[fogh-isar],
[abohava],[tashilat],[sakhtikar],[tadil],[riali],[jazb9],[jazb],[makhsos],[vije],[olad],[ayelemandi],[kharobar],[maskan],[nobatkari],[bon],[jazb-tabsare],[talash],[jebhe]
,[janbazi],[sayer],[ezafekar],[mamoriat],[tatilkari],[s_payankhedmat],[ghazai],[ashoora],[zaribtadil],[jazbTakhasosi],[jazbtadil],[hadaghaltadil]
,[band_y],[joz1],[band6],[jazb2],[jazb3],[vije2],[vije3],[makhsos2],[makhsos3],[tatbigh1],[khas],[karane],[refahi],[tarmim],[jazbTarmim],[VizheTarmim],[KhasTarmim]))p
END
GO
