SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE proc [Drd].[sp_RptAshkhasFishStatus] @AshkhasId int
as
SELECT       Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId,drd.fn_SharheCode_ElamAvarez(tblElamAvarez.fldid) AS SharhDesc, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
							  Drd.tblSodoorFish.fldShenasePardakht, Drd.tblSodoorFish.fldMablaghAvarezGerdShode, Drd.tblSodoorFish.fldShorooShenaseGhabz, Drd.tblSodoorFish.fldUserId, 
							  Drd.tblSodoorFish.fldDesc, Drd.tblSodoorFish.fldTarikh, Drd.tblSodoorFish.fldJamKol, Drd.tblSodoorFish.fldBarcode, 
							  fldAshakhasID,
							 (SELECT CASE WHEN fldHaghighiId IS not NULL THEN (SELECT  fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId)
							 WHEN fldHoghoghiId IS not NULL THEN (SELECT tblAshkhaseHoghoghi.fldName FROM Com.tblAshkhaseHoghoghi WHERE fldid=fldHoghoghiId)end FROM Com.tblAshkhas WHERE fldId=fldAshakhasID) AS fldNameShakhs,
							(SELECT CASE WHEN fldHaghighiId IS not NULL THEN N'حقیقی'
							 WHEN fldHoghoghiId IS not NULL THEN N'حقوقی' END FROM Com.tblAshkhas WHERE fldId=fldAshakhasID) AS fldNoeShakhs,
							(SELECT CASE WHEN fldHaghighiId IS not NULL THEN (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId)
							 WHEN fldHoghoghiId IS not NULL THEN (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldid=fldHoghoghiId)end FROM Com.tblAshkhas WHERE fldId=fldAshakhasID) AS fldFather_ShomareSabt
						 ,CASE WHEN fldType = 0 THEN N'داخلی' WHEN fldType = 1 THEN N'خارجی' END AS fldTypeAvarez,
						 (SELECT CASE WHEN fldHaghighiId IS not NULL THEN (SELECT  fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId)
							 WHEN fldHoghoghiId IS not NULL THEN (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldid=fldHoghoghiId)end FROM Com.tblAshkhas WHERE fldId=fldAshakhasID) AS fldNationalCode
						, CASE WHEN EXISTS (SELECT * FROM  Drd.tblCodhayeDaramd WHERE fldMashmooleArzesheAfzoode=1 and fldId IN (SELECT fldCodeDaramadId FROM Drd.tblShomareHesabCodeDaramad WHERE fldid IN (SELECT fldShomareHesabCodeDaramadId FROM Drd.tblCodhayeDaramadiElamAvarez WHERE fldid IN (SELECT fldCodeElamAvarezId FROM Drd.tblSodoorFish_Detail WHERE fldFishId=Drd.tblSodoorFish.fldId) ))) THEN N'1' ELSE N'0' END  AS fldMashmool
					   ,ISNULL((SELECT    N'پرداخت شده با'+Drd.tblNahvePardakht.fldTitle
		FROM         Drd.tblPardakhtFish INNER JOIN
							  Drd.tblNahvePardakht ON Drd.tblPardakhtFish.fldNahvePardakhtId = Drd.tblNahvePardakht.fldId WHERE fldFishId=Drd.tblSodoorFish.fldId),N'پرداخت نشده')AS fldPardakhFish
					,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
		FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

		FROM         Drd.tblSodoorFish INNER JOIN
							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId
		WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId) and fldAshakhasID=@AshkhasId
		order by  Drd.tblSodoorFish.fldId desc
GO
