SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Prs].[spr_RptFiscal](@Year SMALLINT,@month TINYINT,@CostCenterId INT,@NobatPardakht TINYINT,@organId INT,@CalcType TINYINT=1)  
AS
IF(@NobatPardakht=0)    
BEGIN  
SELECT [fldId],[fldKarkard],ISNULL([fldMaliyat],0)[fldMaliyat],ISNULL([fldMashmolMaliyat],0)[fldMashmolMaliyat],[Name_Family],[fldSh_Personali],[fldName],[fldFamily],[fldYear],[fldMonth],[fldCostCenterId]
 , ISNULL([h-paye],'')[h-paye],ISNULL([sanavat],'')[sanavat],ISNULL([paye],'')[paye],ISNULL([sanavat-basiji],'')[sanavat-basiji]
,ISNULL([sanavat-isar],'')[sanavat-isar],ISNULL([foghshoghl],'')[foghshoghl],ISNULL([takhasosi],'')[takhasosi],ISNULL([made26],'')[made26],
ISNULL([modiryati],'')[modiryati],ISNULL([barjastegi],'')[barjastegi],ISNULL([tatbigh],'')[tatbigh],ISNULL([fogh-isar],'')[fogh-isar],
ISNULL([abohava],'')[abohava],ISNULL([tashilat],'')[tashilat],ISNULL([sakhtikar],'')[sakhtikar],ISNULL([tadil],'')[tadil],
ISNULL([riali],'')[riali],
[jazb9]=ISNULL([jazb9],0)+ISNULL([jazb2],0)+ISNULL([jazb3],0),
ISNULL([jazb],0)[jazb],
[makhsos]=ISNULL([makhsos],0)+ISNULL([makhsos2],0)+ISNULL([makhsos3],0),
[vije]=ISNULL([vije],0)+ISNULL([vije2],0)+ISNULL([vije3],0),
ISNULL([olad],'')[olad],ISNULL([ayelemandi],'')[ayelemandi],ISNULL([kharobar],'')[kharobar],ISNULL([maskan],'')[maskan],ISNULL([nobatkari],'')[nobatkari],ISNULL([bon],'')[bon]
,ISNULL([jazb-tabsare],'')[jazb-tabsare],ISNULL([talash],'')[talash],ISNULL([jebhe],'')[jebhe],ISNULL([janbazi],'')[janbazi],ISNULL([sayer],'')[sayer],(ISNULL([ezafekar],''))[ezafekar] 
,ISNULL([mamoriat],'')[mamoriat],ISNULL([tatilkari],'')[tatilkari],ISNULL([s_payankhedmat],'')[s_payankhedmat]
,ISNULL([ghazai],'') [ghazai],ISNULL([ashoora],'')[ashoora],ISNULL([zaribtadil],'')[zaribtadil],ISNULL(jazbTakhasosi,'') jazbTakhasosi,ISNULL([jazbtadil],'')[jazbtadil],ISNULL(hadaghaltadil,'')hadaghaltadil,ISNULL(shift,'')shift
,ISNULL([band_y],0)[band_y] ,ISNULL([joz1],0)[joz1],ISNULL([band6],0)[band6]
 FROM
(SELECT     Pay.tblMohasebat.fldId, Pay.tblMohasebat.fldKarkard, Pay.tblMohasebat.fldMashmolMaliyat+
                          (SELECT     ISNULL(SUM(fldMashmolMaliyat),0) AS Expr1
                            FROM          Pay.tblMoavaghat
                            WHERE      (fldMohasebatId = Pay.tblMohasebat.fldId)) AS fldMashmolMaliyat, /*Pay.tblMohasebat.fldMaliyat +
                          (SELECT     ISNULL(SUM(fldMaliyat),0) AS Expr1
                            FROM          Pay.tblMoavaghat AS tblMoavaghat_4
                            WHERE      (fldMohasebatId = Pay.tblMohasebat.fldId))*/
                      (ISNULL(Pay.tblMohasebat.fldMaliyat,0)+ISNULL( (SELECT fldMablagh FROM Pay.tblP_MaliyatManfi WHERE fldMohasebeId=Pay.tblMohasebat.fldId),ISNULL((SELECT SUM(fldMaliyat) FROM Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldid),0))) AS fldMaliyat, 
                      com.fn_FamilyEmployee(tblEmployee.fldId)  AS Name_Family, ISNULL(Com.tblItemsHoghughi.fldNameEN, '') 
                      AS fldNameEN, /*Com.fn_SumMablaghMoavaghat_Mohasebat_Items(Com.tblItems_Estekhdam.fldId, Pay.tblMohasebat.fldId) AS*/ fldMablagh, 
                      Prs_tblPersonalInfo.fldSh_Personali, tblEmployee.fldName, tblEmployee.fldFamily, Pay.tblMohasebat.fldYear, Pay.tblMohasebat.fldMonth, 
                      Pay.tblMohasebat_PersonalInfo.fldCostCenterId
FROM         Pay.tblMohasebat INNER JOIN
                      Pay.tblMohasebat_Items ON Pay.tblMohasebat.fldId = Pay.tblMohasebat_Items.fldMohasebatId INNER JOIN
                      Com.tblItems_Estekhdam ON Pay.tblMohasebat_Items.fldItemEstekhdamId = Com.tblItems_Estekhdam.fldId INNER JOIN
                      Com.tblItemsHoghughi ON Com.tblItems_Estekhdam.fldItemsHoghughiId = Com.tblItemsHoghughi.fldId INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblMohasebat.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs_tblPersonalInfo.fldId LEFT OUTER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebat.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatId INNER JOIN 
                      Com.tblEmployee  AS tblEmployee ON Prs_tblPersonalInfo.fldEmployeeId=tblEmployee.fldid INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldid=Com.tblEmployee_Detail.fldEmployeeId
                      WHERE     (Pay.tblMohasebat.fldYear = @Year) AND (Pay.tblMohasebat.fldMonth = @month) AND (Pay.tblMohasebat_PersonalInfo.fldCostCenterId = @CostCenterId ) AND Pay.tblMohasebat_PersonalInfo.fldMohasebatId IS NOT NULL
                      AND Com.fn_OrganId(Prs_tblPersonalInfo.fldId)=@organId  and fldCalcType=@CalcType
GROUP BY Pay.tblMohasebat.fldId,fldKarkard,fldMashmolMaliyat,fldMaliyat,tblEmployee.fldName,tblEmployee.fldFamily,fldNameEN,fldMablagh,Com.tblItems_Estekhdam.fldId,fldSh_Personali,fldFatherName
,fldYear,fldMonth,Pay.tblMohasebat_PersonalInfo.fldCostCenterId,tblEmployee.fldId)t2

 PIVOT (MAX( fldMablagh)
FOR fldNameEN IN([h-paye],[sanavat],[paye],[sanavat-basiji],[sanavat-isar],[foghshoghl],[takhasosi],[made26],[modiryati],[barjastegi],[tatbigh],[fogh-isar],
[abohava],[tashilat],[sakhtikar],[tadil],[riali],[jazb9],[jazb],[makhsos],[vije],[olad],[ayelemandi],[kharobar],[maskan],[nobatkari],[bon],[jazb-tabsare],[talash],[jebhe]
,[janbazi],[sayer],[ezafekar],[mamoriat],[tatilkari],[s_payankhedmat],[ghazai],[ashoora],[zaribtadil],[jazbTakhasosi],[jazbtadil],[hadaghaltadil],[shift]
,[band_y],[joz1],[band6],[jazb2],[jazb3],[vije2],[vije3],[makhsos2],[makhsos3]))p
END
ELSE 
BEGIN
SELECT [fldId],[fldKarkard],ISNULL([fldMaliyat],0)[fldMaliyat],ISNULL([fldMashmolMaliyat],0)[fldMashmolMaliyat],[Name_Family], [fldSh_Personali],[fldName],[fldFamily],[fldYear],[fldMonth] ,[fldCostCenterId]
, ISNULL([h-paye],'')[h-paye],ISNULL([sanavat],'')[sanavat],ISNULL([paye],'')[paye],ISNULL([sanavat-basiji],'')[sanavat-basiji]
,ISNULL([sanavat-isar],'')[sanavat-isar],ISNULL([foghshoghl],'')[foghshoghl],ISNULL([takhasosi],'')[takhasosi],ISNULL([made26],'')[made26],
ISNULL([modiryati],'')[modiryati],ISNULL([barjastegi],'')[barjastegi],ISNULL([tatbigh],'')[tatbigh],ISNULL([fogh-isar],'')[fogh-isar],
ISNULL([abohava],'')[abohava],ISNULL([tashilat],'')[tashilat],ISNULL([sakhtikar],'')[sakhtikar],ISNULL([tadil],'')[tadil],
ISNULL([riali],'')[riali],
[jazb9]=ISNULL([jazb9],0)+ISNULL([jazb2],0)+ISNULL([jazb3],0),
ISNULL([jazb],0)[jazb],
[makhsos]=ISNULL([makhsos],0)+ISNULL([makhsos2],0)+ISNULL([makhsos3],0),
[vije]=ISNULL([vije],0)+ISNULL([vije2],0)+ISNULL([vije3],0),
ISNULL([olad],'')[olad],ISNULL([ayelemandi],'')[ayelemandi],ISNULL([kharobar],'')[kharobar],ISNULL([maskan],'')[maskan],ISNULL([nobatkari],'')[nobatkari],ISNULL([bon],'')[bon]
,ISNULL([jazb-tabsare],'')[jazb-tabsare],ISNULL([talash],'')[talash],ISNULL([jebhe],'')[jebhe],ISNULL([janbazi],'')[janbazi],ISNULL([sayer],'')[sayer],ISNULL([ezafekar],'')[ezafekar] 
,ISNULL([mamoriat],'')[mamoriat],ISNULL([tatilkari],'')[tatilkari],ISNULL([s_payankhedmat],'')[s_payankhedmat]
,ISNULL([ghazai],'') [ghazai],ISNULL([ashoora],'')[ashoora],ISNULL([zaribtadil],'')[zaribtadil],ISNULL([jazbTakhasosi],'') jazbTakhasosi,ISNULL(hadaghaltadil,'')hadaghaltadil,ISNULL(shift,'')shift
 ,ISNULL([band_y],0),ISNULL([joz1],0),ISNULL([band6],0)
FROM
(SELECT     Pay.tblMohasebat.fldId, Pay.tblMohasebat.fldKarkard, Pay.tblMohasebat.fldMashmolMaliyat +
                          (SELECT     ISNULL(SUM(fldMashmolMaliyat),0) AS Expr1
                            FROM          Pay.tblMoavaghat
                            WHERE      (fldMohasebatId = Pay.tblMohasebat.fldId)) AS fldMashmolMaliyat,
                              (ISNULL(Pay.tblMohasebat.fldMaliyat,0)+ISNULL( (SELECT fldMablagh FROM Pay.tblP_MaliyatManfi WHERE fldMohasebeId=Pay.tblMohasebat.fldId),ISNULL((SELECT SUM(fldMaliyat) FROM Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldid),0)))  AS fldMaliyat, 
                      com.fn_FamilyEmployee(tblEmployee.fldId) AS Name_Family, ISNULL(Com.tblItemsHoghughi.fldNameEN, '') 
                      AS fldNameEN,/* Com.fn_SumMablaghMoavaghat_Mohasebat_Items(Com.tblItems_Estekhdam.fldId, Pay.tblMohasebat.fldId) AS*/ fldMablagh, 
                      Prs_tblPersonalInfo.fldSh_Personali, tblEmployee.fldName, tblEmployee.fldFamily, Pay.tblMohasebat.fldYear, Pay.tblMohasebat.fldMonth, 
                      Pay.tblMohasebat_PersonalInfo.fldCostCenterId
FROM         Pay.tblMohasebat INNER JOIN
                      Pay.tblMohasebat_Items ON Pay.tblMohasebat.fldId = Pay.tblMohasebat_Items.fldMohasebatId INNER JOIN
                      Com.tblItems_Estekhdam ON Pay.tblMohasebat_Items.fldItemEstekhdamId = Com.tblItems_Estekhdam.fldId INNER JOIN
                      Com.tblItemsHoghughi ON Com.tblItems_Estekhdam.fldItemsHoghughiId = Com.tblItemsHoghughi.fldId INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblMohasebat.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs_tblPersonalInfo.fldId LEFT OUTER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebat.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatId INNER JOIN 
                      Com.tblEmployee  AS tblEmployee ON Prs_tblPersonalInfo.fldEmployeeId=tblEmployee.fldid  INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldid=Com.tblEmployee_Detail.fldEmployeeId
WHERE     (Pay.tblMohasebat.fldYear = @Year) AND (Pay.tblMohasebat.fldMonth = @month) AND (Pay.tblMohasebat_PersonalInfo.fldCostCenterId = @CostCenterId ) AND Pay.tblMohasebat_PersonalInfo.fldMohasebatId IS NOT NULL AND fldNobatPardakht=@NobatPardakht
 AND Com.fn_organIdWithPayPersonal(fldPersonalId)=@OrganId and fldCalcType=@CalcType
GROUP BY Pay.tblMohasebat.fldId,fldKarkard,fldMashmolMaliyat,fldMaliyat,tblEmployee.fldName,tblEmployee.fldFamily,fldNameEN,fldMablagh
,Com.tblItems_Estekhdam.fldId,fldSh_Personali,fldFatherName
,fldYear,fldMonth,Pay.tblMohasebat_PersonalInfo.fldCostCenterId,tblEmployee.fldId)t1


 PIVOT (MAX( fldMablagh)
FOR fldNameEN IN([h-paye],[sanavat],[paye],[sanavat-basiji],[sanavat-isar],[foghshoghl],[takhasosi],[made26],[modiryati],[barjastegi],[tatbigh],[fogh-isar],
[abohava],[tashilat],[sakhtikar],[tadil],[riali],[jazb9],[jazb],[makhsos],[vije],[olad],[ayelemandi],[kharobar],[maskan],[nobatkari],[bon],[jazb-tabsare],[talash],[jebhe]
,[janbazi],[sayer],[ezafekar],[mamoriat],[tatilkari],[s_payankhedmat],[ghazai],[ashoora],[zaribtadil],[jazbTakhasosi],[hadaghaltadil],[shift]
,[band_y],[joz1],[band6],[jazb2],[jazb3],[vije2],[vije3],[makhsos2],[makhsos3]))p
END
GO
