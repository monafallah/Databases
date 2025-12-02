SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[spr_Hokm]
as
SELECT ISNULL(fldName,'')fldName,ISNULL(fldFamily,'')fldFamily, ISNULL(fldCodemeli,'')fldFamily, ISNULL(fldStatus,'')fldStatus,ISNULL(fldFatherName,'')fldFatherName, 
ISNULL(fldJensiyat,'')fldJensiyat,ISNULL(fldTarikhTavalod,'')fldTarikhTavalod, ISNULL(fldStatusEsargari,'')fldStatusEsargari, 
ISNULL(fldCodePosti,'')fldCodePosti,ISNULL(fldAddress,'')fldAddress,ISNULL(fldMadrakTahsili,'')fldMadrakTahsili, 
ISNULL(fldReshteTahsili,'')fldReshteTahsili,ISNULL(fldRasteShoghli,'')fldRasteShoghli,ISNULL(fldReshteShoghli,'')fldReshteShoghli, 
ISNULL(fldOrganizationalPosts,'')fldOrganizationalPosts,ISNULL(fldTabaghe,'')fldTabaghe,ISNULL(fldShomareMojavezEstekhdam,'')fldShomareMojavezEstekhdam, 
ISNULL(fldTarikhMojavezEstekhdam,'')fldTarikhMojavezEstekhdam,ISNULL(fldMahleKhedmat,'')fldMahleKhedmat,ISNULL(fldTarikhEjra,'')fldTarikhEjra,
ISNULL(fldTarikhSodoorHokm,'')fldTarikhSodoorHokm,ISNULL(fldTarikhEtmam,'')fldTarikhEtmam,ISNULL(fldTitleEstekhdam,'')fldTitleEstekhdam,
ISNULL(fldGroup,'')fldGroup,ISNULL(fldMoreGroup,'')fldMoreGroup,ISNULL(fldShomarePostSazmani,'')fldShomarePostSazmani,ISNULL(fldTedadFarzand,'')fldTedadFarzand,ISNULL(fldNezamVazifeTitle,'')fldNezamVazifeTitle,
ISNULL(fldMeliyatName,'') fldMeliyatName,ISNULL(fldBimeOmrName,'')fldBimeOmrName,ISNULL(fldBimeTakmiliName,'')fldBimeTakmiliName,
ISNULL(fldMashagheleSakhtVaZianAvarName,'')fldMashagheleSakhtVaZianAvarName,ISNULL(fldMazadCSalName,'')fldMazadCSalName,
ISNULL(fldPasAndazName,'')fldPasAndazName,ISNULL(fldSanavatPayanKhedmatName,'')fldSanavatPayanKhedmatName,ISNULL(fldHamsarKarmandName,'')fldHamsarKarmandName,
ISNULL(fldTedadAfradTahteTakafol,'')fldTedadAfradTahteTakafol,ISNULL(fldTypehokm,'')fldTypehokm,ISNULL(fldShomareHokm,'')fldShomareHokm, 
ISNULL(fldDescriptionHokm,'')fldDescriptionHokm,ISNULL(fldCodeShoghl,'')fldCodeShoghl,ISNULL(StatusTaaholTitle,'')StatusTaaholTitle,
ISNULL(fldCodeShoghliBime,'')fldCodeShoghliBime,ISNULL(fldShomareBime,'')fldShomareBime,ISNULL(fldShPasAndazPersonal,'')fldShPasAndazPersonal, 
ISNULL(fldShPasAndazKarFarma,'')fldShPasAndazKarFarma,ISNULL(fldTedadBime1,'')fldTedadBime1,ISNULL(fldTedadBime2,'')fldTedadBime2, 
ISNULL(fldTedadBime3,'')fldTedadBime3,ISNULL(fldT_Asli,'')fldT_Asli,ISNULL(fldT_70,'')fldT_70,ISNULL(fldT_60,'')fldT_60,
ISNULL(fldHamsareKarmand,'')fldHamsareKarmand,ISNULL(fldMazad30Sal,'')fldMazad30Sal,ISNULL(StatusEsargariTitle,'')StatusEsargariTitle,
ISNULL(fldShomareHesab,'')fldShomareHesab,ISNULL(fldShomareKart,'')fldShomareKart,ISNULL(fldWorkShopNum,'')fldWorkShopNum,ISNULL(fldWorkShopName,'')+'_'+ISNULL(fldWorkShopNum,'')fldWorkShopName,
ISNULL(fldEmployerName,'')fldEmployerName,ISNULL(CostCenterTitle,'')CostCenterTitle,ISNULL(TypeBimeTitle,'')TypeBimeTitle, ISNULL(OrganName,'')OrganName,ISNULL(fldSh_Shenasname,'')fldSh_Shenasname, 
ISNULL(MahaleSodoorName,'')MahaleSodoorName,ISNULL(MahalTavalodName,'')MahalTavalodName,ISNULL(fldMahalTavalodId,'')fldMahalTavalodId,ISNULL(fldMahalSodoorId,'')fldMahalSodoorId, 
ISNULL(fldTarikhSodoor,'')fldTarikhSodoor, ISNULL(fldKarkard,'')fldKarkard,ISNULL(fldGheybat,'')fldGheybat,ISNULL(fldTedadEzafeKar,'')fldTedadEzafeKar, 
ISNULL(fldTedadTatilKar,'')fldTedadTatilKar,ISNULL(CAST(Mamooriyat AS INT),0)Mamooriyat,ISNULL(fldBimeOmrKarFarma,'')fldBimeOmrKarFarma,
ISNULL(fldBimeOmr,'')fldBimeOmr,ISNULL(fldBimeTakmilyKarFarma,'')fldBimeTakmilyKarFarma,ISNULL(fldBimeTakmily,'')fldBimeTakmily,
ISNULL(fldHaghDarmanKarfFarma,'')fldHaghDarmanKarfFarma,ISNULL(fldHaghDarmanDolat,'')fldHaghDarmanDolat,ISNULL(fldHaghDarman,'')fldHaghDarman,
ISNULL(fldBimePersonal,'')fldBimePersonal,ISNULL(fldBimeKarFarma,'')fldBimeKarFarma,ISNULL(fldBimeBikari,'')fldBimeBikari,
ISNULL(fldBimeMashaghel,'')fldBimeMashaghel,ISNULL(fldTedadNobatKari,'')fldTedadNobatKari,ISNULL(fldMosaede,'')fldMosaede,
ISNULL(fldGhestVam,'')fldGhestVam,ISNULL(fldNobatPardakht,'')fldNobatPardakht, ISNULL(fldPasAndaz,'')fldPasAndaz,
ISNULL(fldMashmolBime,'')fldMashmolBime,ISNULL(fldMashmolMaliyat,'')fldMashmolMaliyat,ISNULL(fldMaliyat,'')fldMaliyat,
ISNULL((motalebat-kosurat),'')fldkhalesPardakhti,ISNULL(fldJobeCode,'')fldJobeCode,ISNULL(fldSh_Personali,'')fldSh_Personali,
ISNULL(fldOrganPostName,'')fldOrganPostName,ISNULL(fldYear,'')fldYear, ISNULL(fldMonth,'')fldMonth, ISNULL(fldJobDesc,'')+'_'+ISNULL(fldJobeCode,'')fldJobDesc,ISNULL(fldMogharari,'')fldMogharari,ISNULL(fldSharhEsargari,'')fldSharhEsargari,
ISNULL(fldTarikhEstekhdam,'')fldTarikhEstekhdam,ISNULL(fldSh_MojavezEstekhdam,'')fldSh_MojavezEstekhdam,ISNULL(fldTarikhMajavezEstekhdam,'')fldTarikhMajavezEstekhdam,
ISNULL(fldStatusIsargariId,'')fldStatusIsargariId,ISNULL(fldTypeBimeId,'')fldTypeBimeId,ISNULL(fldInsuranceWorkShopId,'')fldInsuranceWorkShopId,
ISNULL(fldCostCenterId,'')fldCostCenterId,ISNULL(fldAnvaeEstekhdamId,'')fldAnvaeEstekhdamId,ISNULL(fldStatusTaaholId,'')fldStatusTaaholId,ISNULL(statusPay,'')statusPay,
ISNULL(statusPrs,'')statusPrs,
ISNULL(case when statusPay=1  then N'فعال' when statusPay=2  then N'غیرفعال'  when statusPay=3  then N'بازنشسته'  end ,'')statusPayName,
ISNULL(case when statusPrs=1  then N'فعال' when statusPrs=2  then N'غیرفعال'  when statusPrs=3  then N'بازنشسته'  end,'')statusPrsName,
ISNULL(fldJensiyatName,'')fldJensiyatName,ISNULL(fldMadrakId,'')fldMadrakId,ISNULL(fldOrganId,'')fldOrganId,
ISNULL([h-paye],'')[h-paye],ISNULL([sanavat],'')[sanavat],ISNULL([paye],'')[paye],ISNULL([sanavat-basiji],'')[sanavat-basiji],
ISNULL([sanavat-isar],'')[sanavat-isar],ISNULL([foghshoghl],'')[foghshoghl],ISNULL([takhasosi],'')[takhasosi],ISNULL([made26],'')[made26],
ISNULL([modiryati],'')[modiryati],ISNULL([barjastegi],'')[barjastegi],ISNULL([tatbigh],'')[tatbigh],ISNULL([fogh-isar],'')[fogh-isar],
ISNULL([abohava],'')[abohava],ISNULL([tashilat],'')[tashilat],ISNULL([sakhtikar],'')[sakhtikar],ISNULL([tadil],'')[tadil],
ISNULL([riali],'')[riali],ISNULL([jazb9],'')[jazb9],ISNULL([jazb],'')[jazb],ISNULL([makhsos],'')[makhsos],ISNULL([vije],'')[vije],
ISNULL([olad],'')[olad],ISNULL([ayelemandi],'')[ayelemandi],ISNULL([kharobar],'')[kharobar],ISNULL([maskan],'')[maskan],ISNULL([nobatkari],'')[nobatkari],ISNULL([bon],'')[bon],
ISNULL([jazb-tabsare],'')[jazb-tabsare],ISNULL([talash],'')[talash],ISNULL([jebhe],'')[jebhe],ISNULL([janbazi],'')[janbazi],ISNULL([sayer],'')[sayer],ISNULL([ezafekar],'')[ezafekar] ,
ISNULL([mamoriat],'')[mamoriat],ISNULL([tatilkari],'')[tatilkari] ,ISNULL([s_payankhedmat],'')[s_payankhedmat],ISNULL([ghazai],'')ghazai,
ISNULL([ashoora],'')ashoora,ISNULL([zaribtadil],'')zaribtadil,ISNULL([jazbTakhasosi],'') jazbTakhasosi
from(
SELECT     Com.tblEmployee.fldName, Com.tblEmployee.fldFamily, Com.tblEmployee.fldCodemeli, Com.tblEmployee.fldStatus, Com.tblEmployee_Detail.fldFatherName, 
                      Com.tblEmployee_Detail.fldJensiyat, Com.tblEmployee_Detail.fldTarikhTavalod, Prs.tblHokm_InfoPersonal_History.fldStatusEsargari, 
                      Prs.tblHokm_InfoPersonal_History.fldCodePosti, Prs.tblHokm_InfoPersonal_History.fldAddress, Prs.tblHokm_InfoPersonal_History.fldMadrakTahsili, 
                      Prs.tblHokm_InfoPersonal_History.fldReshteTahsili, Prs.tblHokm_InfoPersonal_History.fldRasteShoghli, Prs.tblHokm_InfoPersonal_History.fldReshteShoghli, 
                      Prs.tblHokm_InfoPersonal_History.fldOrganizationalPosts, Prs.tblHokm_InfoPersonal_History.fldTabaghe, 
                      Prs.tblHokm_InfoPersonal_History.fldShomareMojavezEstekhdam, Prs.tblHokm_InfoPersonal_History.fldTarikhMojavezEstekhdam, 
                      Prs.tblHokm_InfoPersonal_History.fldMahleKhedmat, Prs.tblPersonalHokm.fldTarikhEjra, Prs.tblPersonalHokm.fldTarikhSodoor AS fldTarikhSodoorHokm, Prs.tblPersonalHokm.fldTarikhEtmam, 
                      Com.tblAnvaEstekhdam.fldTitle AS fldTitleEstekhdam, Prs.tblPersonalHokm.fldGroup, Prs.tblPersonalHokm.fldMoreGroup, Prs.tblPersonalHokm.fldShomarePostSazmani, 
                      Prs.tblPersonalHokm.fldTedadFarzand, Prs.tblPersonalHokm.fldTedadAfradTahteTakafol, Prs.tblPersonalHokm.fldTypehokm, Prs.tblPersonalHokm.fldShomareHokm, 
                      Prs.tblPersonalHokm.fldDescriptionHokm, Prs.tblPersonalHokm.fldCodeShoghl, Com.tblStatusTaahol.fldTitle AS StatusTaaholTitle, 
                      Pay.tblMohasebat_PersonalInfo.fldCodeShoghliBime, Pay.tblMohasebat_PersonalInfo.fldShomareBime, Pay.tblMohasebat_PersonalInfo.fldShPasAndazPersonal, 
                      Pay.tblMohasebat_PersonalInfo.fldShPasAndazKarFarma, Pay.tblMohasebat_PersonalInfo.fldTedadBime1, Pay.tblMohasebat_PersonalInfo.fldTedadBime2, 
                      Pay.tblMohasebat_PersonalInfo.fldTedadBime3, Pay.tblMohasebat_PersonalInfo.fldT_Asli, Pay.tblMohasebat_PersonalInfo.fldT_70, 
                      Pay.tblMohasebat_PersonalInfo.fldT_60, Pay.tblMohasebat_PersonalInfo.fldHamsareKarmand, Pay.tblMohasebat_PersonalInfo.fldMazad30Sal, 
                      Prs.tblVaziyatEsargari.fldTitle AS StatusEsargariTitle, com.tblShomareHesabeOmoomi.fldShomareHesab,Com.tblShomareHesabOmoomi_Detail.fldShomareKart, 
                      Pay.tblInsuranceWorkshop.fldWorkShopNum, Pay.tblInsuranceWorkshop.fldWorkShopName, Pay.tblInsuranceWorkshop.fldEmployerName, 
                      Pay.tblCostCenter.fldTitle AS CostCenterTitle, Com.tblTypeBime.fldTitle AS TypeBimeTitle,/*com.fn_stringDecode( Com.tblOrganization.fldName)*/'' AS OrganName, Com.tblEmployee_Detail.fldSh_Shenasname, 
                      tblCity_1.fldName AS MahaleSodoorName, Com.tblCity.fldName AS MahalTavalodName, Com.tblEmployee_Detail.fldMahalTavalodId, Com.tblEmployee_Detail.fldMahalSodoorId, 
                      Com.tblEmployee_Detail.fldTarikhSodoor, Pay.tblMohasebat.fldKarkard, Pay.tblMohasebat.fldGheybat, Pay.tblMohasebat.fldTedadEzafeKar, 
                      Pay.tblMohasebat.fldTedadTatilKar, Pay.tblMohasebat.fldBaBeytute+ Pay.tblMohasebat.fldBedunBeytute AS Mamooriyat, Pay.tblMohasebat.fldBimeOmrKarFarma, 
                      Pay.tblMohasebat.fldBimeOmr, Pay.tblMohasebat.fldBimeTakmilyKarFarma, Pay.tblMohasebat.fldBimeTakmily,
                      CASE WHEN fldMeliyat = 0 THEN N'غیر ایرانی' ELSE N'ایرانی' END AS fldMeliyatName,
                       Pay.tblMohasebat.fldHaghDarmanKarfFarma+ ISNULL((SELECT SUM(fldHaghDarmanKarfFarma) FROM Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldId),0) AS fldHaghDarmanKarfFarma, 
                      Pay.tblMohasebat.fldHaghDarmanDolat+ ISNULL((SELECT SUM(fldHaghDarmanDolat) FROM Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldId),0)as fldHaghDarmanDolat
                      ,Pay.tblMohasebat.fldHaghDarman+ISNULL((SELECT SUM(fldHaghDarman) FROM Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldId),0)AS fldHaghDarman
                      ,Pay.tblMohasebat.fldBimePersonal+ISNULL((SELECT SUM(fldBimePersonal) FROM Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldId),0)AS fldBimePersonal
                      ,Pay.tblMohasebat.fldBimeKarFarma+ISNULL((SELECT SUM(fldBimeKarFarma) FROM Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldId),0) AS fldBimeKarFarma 
                      ,Pay.tblMohasebat.fldBimeBikari+ISNULL((SELECT SUM(fldBimeBikari) FROM Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldId),0) AS fldBimeBikari
                      ,Pay.tblMohasebat.fldBimeMashaghel +ISNULL((SELECT SUM(fldBimeMashaghel) FROM Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldId),0) AS fldBimeMashaghel
                      ,Pay.tblMohasebat.fldTedadNobatKari
                      ,Pay.tblMohasebat.fldMosaede, 
                      Pay.tblMohasebat.fldGhestVam, Pay.tblMohasebat.fldNobatPardakht, 
                      Pay.tblMohasebat.fldPasAndaz+ISNULL((SELECT SUM(fldPasAndaz) FROM Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldId),0)AS fldPasAndaz
                      , Pay.tblMohasebat.fldMashmolBime+ ISNULL((SELECT SUM(fldMashmolBime) FROM Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldId),0)AS fldMashmolBime, 
                      Pay.tblMohasebat.fldMashmolMaliyat+ ISNULL((SELECT SUM(fldMashmolMaliyat) FROM Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldId),0)AS fldMashmolMaliyat, 
                      Pay.tblMohasebat.fldMogharari, Pay.tblMohasebat.fldMaliyat+ ISNULL((SELECT SUM(fldMaliyat) FROM Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldId),0)AS fldMaliyat
                       ,--Pay.tblMohasebat.fldkhalesPardakhti+ ISNULL((SELECT SUM(fldkhalesPardakhti) FROM Pay.tblMoavaghat WHERE fldMohasebatId=Pay.tblMohasebat.fldId),0)
                   isnull((select SUM(ISNULL(fldMablagh,0)) FROM Pay.tblMohasebat_Items 
					WHERE fldMohasebatId=tblmohasebat.fldid),0)
					+
					isnull((select SUM(fldMablagh) FROM [pay].[tblMohasebat_kosorat/MotalebatParam]
					WHERE  fldMohasebatId=tblmohasebat.fldid AND fldKosoratId IS NULL),0)
					+[fldHaghDarmanKarfFarma]+[fldHaghDarmanDolat]+(tblmohasebat.[fldPasAndaz]/(2))+[fldBimeTakmilyKarFarma]+[fldBimeOmrKarFarma]
					+isnull((SELECT      sum(fldMablagh)  
					FROM            Pay.tblMoavaghat INNER JOIN
                         Pay.tblMoavaghat_Items ON Pay.tblMoavaghat.fldId = Pay.tblMoavaghat_Items.fldMoavaghatId
						 where fldMohasebatId=tblmohasebat.fldid group by fldMohasebatId),0)+isnull((select sum([fldHaghDarmanKarfFarma]+[fldHaghDarmanDolat]+([fldPasAndaz]/(2))) from Pay.tblMoavaghat where fldMohasebatId=tblmohasebat.fldid ),0)

					    AS motalebat, 
						fldMaliyat+isnull((select fldMablagh from pay.tblP_MaliyatManfi where fldMohasebeId=tblMohasebat.fldid),isnull((select sum(fldMaliyat) from pay.tblMoavaghat where fldMohasebatId=tblMohasebat.fldid),0))
+fldBimePersonal+tblmohasebat.fldBimeOmr+fldMogharari+fldGhestVam+fldBimeTakmily+fldHaghDarman+tblmohasebat.fldPasAndaz+fldMosaede+isnull((select sum(tblMoavaghat.fldHaghDarman+tblMoavaghat.fldPasAndaz+tblMoavaghat.fldBimePersonal) from pay.tblMoavaghat where fldMohasebatId=tblMohasebat.fldid),0)
+isnull((select sum(fldMablagh) from pay.[tblMohasebat_kosorat/MotalebatParam] where fldMohasebatId=tblMohasebat.fldid and fldKosoratId is null),0)+
isnull((select sum(fldMablagh) from pay.tblMohasebat_KosoratBank where fldMohasebatId=tblMohasebat.fldId),0) as kosurat,

                        Pay.Pay_tblPersonalInfo.fldJobeCode, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali, (select fldTitle from com.tblOrganizationalPosts where fldId=Prs.Prs_tblPersonalInfo.fldOrganPostId) AS fldOrganPostName, Pay.tblMohasebat.fldYear, Pay.tblMohasebat.fldMonth, 
                      Com.tblItemsHoghughi.fldNameEN, Prs.Prs_tblPersonalInfo.fldTarikhEstekhdam,
                      Prs.Prs_tblPersonalInfo.fldSh_MojavezEstekhdam, Prs.Prs_tblPersonalInfo.fldTarikhMajavezEstekhdam, Pay.tblMohasebat_PersonalInfo.fldStatusIsargariId, 
                      Pay.tblMohasebat_PersonalInfo.fldTypeBimeId, Pay.tblMohasebat_PersonalInfo.fldInsuranceWorkShopId, Pay.tblMohasebat_PersonalInfo.fldCostCenterId, 
                      Prs.tblPersonalHokm.fldAnvaeEstekhdamId, Prs.tblPersonalHokm.fldStatusTaaholId,com.fn_MaxPersonalStatus(Pay.Pay_tblPersonalInfo.fldId,'hoghoghi') AS statusPay
                      ,com.fn_MaxPersonalStatus(Prs.Prs_tblPersonalInfo.fldId,'kargozini') AS statusPrs
                     ,CASE WHEN fldJensiyat=1 THEN N'مرد' ELSE N'زن' END AS fldJensiyatName,tblHokm_InfoPersonal_History.fldMadrakId
					,(select fldMablagh+(SELECT  sum(fldMablagh) FROM  Pay.tblMoavaghat_Items INNER JOIN
                         Pay.tblMoavaghat ON Pay.tblMoavaghat_Items.fldMoavaghatId = Pay.tblMoavaghat.fldId where fldMohasebatId=tblMohasebat.fldid and fldItemEstekhdamId=tblItems_Estekhdam.fldid) from pay.tblMohasebat_Items where fldMohasebatId=tblMohasebat.fldid and fldItemEstekhdamId=tblItems_Estekhdam.fldId)fldMablagh
					,tblMohasebat_PersonalInfo.fldOrganId,
				
					CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeOmr = 1) THEN N'دارد' ELSE N'ندارد' END AS fldBimeOmrName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldBimeTakmili = 1) THEN N'دارد' ELSE N'ندارد' END AS fldBimeTakmiliName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldMashagheleSakhtVaZianAvar = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMashagheleSakhtVaZianAvarName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldMazad30Sal = 1) THEN N'دارد' ELSE N'ندارد' END AS fldMazadCSalName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldPasAndaz = 1) THEN N'دارد' ELSE N'ندارد' END AS fldPasAndazName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldSanavatPayanKhedmat = 1) THEN N'دارد' ELSE N'ندارد' END AS fldSanavatPayanKhedmatName, 
                      CASE WHEN (Pay.Pay_tblPersonalInfo.fldHamsarKarmand = 1) THEN N'دارد' ELSE N'ندارد' END AS fldHamsarKarmandName,fldSharhEsargari
					,(select fldJobDesc from pay.tblTabJobOfBime where fldJobCode=pay.Pay_tblPersonalInfo.fldJobeCode)fldJobDesc
					,isnull((select fldTitle from com.tblNezamVazife where fldId= Com.tblEmployee_Detail.fldNezamVazifeId),'') AS fldNezamVazifeTitle
					
					
					FROM         Pay.tblMohasebat_PersonalInfo INNER JOIN
                      Prs.tblPersonalHokm ON Pay.tblMohasebat_PersonalInfo.fldHokmId = Prs.tblPersonalHokm.fldId INNER JOIN
                      Pay.tblMohasebat ON Pay.tblMohasebat_PersonalInfo.fldMohasebatId = Pay.tblMohasebat.fldId INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblMohasebat.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Prs.Prs_tblPersonalInfo.fldId = Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId INNER JOIN
                      Com.tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = Com.tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON Com.tblEmployee_Detail.fldEmployeeId = Com.tblEmployee.fldId INNER JOIN
                      Pay.tblMohasebat_Items ON Pay.tblMohasebat.fldId = Pay.tblMohasebat_Items.fldMohasebatId INNER JOIN
                      Com.tblItems_Estekhdam ON Pay.tblMohasebat_Items.fldItemEstekhdamId = Com.tblItems_Estekhdam.fldId INNER JOIN
                      Com.tblItemsHoghughi ON Com.tblItemsHoghughi.fldId = Com.tblItems_Estekhdam.fldItemsHoghughiId INNER JOIN
                      Prs.tblHokm_InfoPersonal_History ON Prs.tblPersonalHokm.fldId = Prs.tblHokm_InfoPersonal_History.fldPersonalHokmId INNER JOIN
                      Com.tblAnvaEstekhdam ON Prs.tblPersonalHokm.fldAnvaeEstekhdamId = Com.tblAnvaEstekhdam.fldId INNER JOIN
                      Com.tblStatusTaahol ON Prs.tblPersonalHokm.fldStatusTaaholId = Com.tblStatusTaahol.fldId INNER JOIN
                      Pay.tblCostCenter ON Pay.tblMohasebat_PersonalInfo.fldCostCenterId = Pay.tblCostCenter.fldId INNER JOIN
                      Pay.tblInsuranceWorkshop ON Pay.tblMohasebat_PersonalInfo.fldInsuranceWorkShopId = Pay.tblInsuranceWorkshop.fldId INNER JOIN
                      Com.tblTypeBime ON Pay.tblMohasebat_PersonalInfo.fldTypeBimeId = Com.tblTypeBime.fldId INNER JOIN
                      com.tblShomareHesabeOmoomi ON Pay.tblMohasebat_PersonalInfo.fldShomareHesabId =com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      com.tblShomareHesabOmoomi_Detail ON com.tblShomareHesabeOmoomi.fldId=com.tblShomareHesabOmoomi_Detail.fldShomareHesabId INNER JOIN
                      Prs.tblVaziyatEsargari ON Pay.tblMohasebat_PersonalInfo.fldStatusIsargariId = Prs.tblVaziyatEsargari.fldId INNER JOIN
                      Com.tblOrganization ON Pay.tblMohasebat_PersonalInfo.fldOrganId = Com.tblOrganization.fldId INNER JOIN
                      Com.tblCity ON Com.tblEmployee_Detail.fldMahalTavalodId = Com.tblCity.fldId INNER JOIN
                      Com.tblCity AS tblCity_1 ON Com.tblEmployee_Detail.fldMahalSodoorId = tblCity_1.fldId
					  WHERE  fldYear=1397 AND fldMonth=5  AND fldNobatPardakht=1 --AND com.fn_MaxPersonalStatus(Pay.Pay_tblPersonalInfo.fldId,'hoghoghi')=1 AND com.fn_MaxPersonalStatus(Prs.Prs_tblPersonalInfo.fldId,'kargozini')=1
                   --AND Com.tblEmployee_Detail.fldJensiyat=1 AND fldStatusIsargariId=1 AND tblEmployee_Detail.fldMadrakId=1 AND com.fn_MaxPersonalTypeEstekhdam(Prs.Prs_tblPersonalInfo.fldId)=1
                   --AND Pay.tblMohasebat_PersonalInfo.fldTypeBimeId=1 AND  Pay.tblMohasebat_PersonalInfo.fldCostCenterId=1 AND  Pay.tblMohasebat_PersonalInfo.fldInsuranceWorkShopId=1
                    )t
 PIVOT(
 MAX(fldMablagh) 
 FOR fldNameEN IN ([h-paye],[sanavat],[paye],[sanavat-basiji],[sanavat-isar],[foghshoghl],[takhasosi],[made26],[modiryati],[barjastegi],[tatbigh],[fogh-isar],
[abohava],[tashilat],[sakhtikar],[tadil],[riali],[jazb9],[jazb],[makhsos],[vije],[olad],[ayelemandi],[kharobar],[maskan],[nobatkari],[bon],[jazb-tabsare],[talash],[jebhe]
,[janbazi],[sayer],[ezafekar],[mamoriat],[tatilkari],[s_payankhedmat],[ghazai],[ashoora],[zaribtadil],[jazbTakhasosi]))  p                 
GO
