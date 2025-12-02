SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_SelectFishSaderShode1]
 @fieldName NVARCHAR(50),
@Value NVARCHAR(50),
@AzTarikh NVARCHAR(10),
@TaTarikh NVARCHAR(10),
@UserId INT,
@OrganId int,
@h int
AS
begin tran
--declare @fieldName NVARCHAR(50)='',
--@Value NVARCHAR(50)='',
--@AzTarikh NVARCHAR(10)='',
--@TaTarikh NVARCHAR(10)='',
--@UserId INT=1,
--@OrganId int=1,
--@h int=100
declare @Az date,@ta date
set @az=com.ShamsiToMiladi(@azTarikh)
set @ta=com.ShamsiToMiladi(@TaTarikh)
if (@h=0) set @h=2147483647	 
IF(@fieldName='')
BEGIN
		 IF(@AzTarikh ='' AND @TaTarikh='')
		SELECT   top(@h)    Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
							  Drd.tblSodoorFish.fldShenasePardakht, Drd.tblSodoorFish.fldMablaghAvarezGerdShode, Drd.tblSodoorFish.fldShorooShenaseGhabz, Drd.tblSodoorFish.fldUserId, 
							  Drd.tblSodoorFish.fldDesc, Drd.tblSodoorFish.fldTarikh,Drd.tblSodoorFish.fldJamKol, Drd.tblSodoorFish.fldBarcode,
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
					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
					,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
		FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

		FROM         Drd.tblSodoorFish INNER JOIN
							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId
		WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId) AND fldOrganId=@OrganId
		order by  Drd.tblSodoorFish.fldId desc

		ELSE IF(@AzTarikh <>'' AND @TaTarikh='')
		SELECT  top(@h)   Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
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
					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
					,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
		FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

		FROM         Drd.tblSodoorFish INNER JOIN
							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId
		WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId) AND fldOrganId=@OrganId
		AND cast(tblSodoorFish.fldDate as date)>=@Az
		order by  Drd.tblSodoorFish.fldId desc

		else IF(@AzTarikh ='' AND @TaTarikh<>'')
		SELECT   top(@h)    Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
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
					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
					,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
		FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

		FROM         Drd.tblSodoorFish INNER JOIN
							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId
		WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId) AND fldOrganId=@OrganId
		AND cast(tblSodoorFish.fldDate as date)<=@Ta
		order by  Drd.tblSodoorFish.fldId desc

		else IF(@AzTarikh <>'' AND @TaTarikh<>'')
		SELECT   top(@h)    Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
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
					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
					,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
		FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

		FROM         Drd.tblSodoorFish INNER JOIN
							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId
		WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId) AND fldOrganId=@OrganId
		AND cast(tblSodoorFish.fldDate as date) BETWEEN @Az AND @Ta
		order by  Drd.tblSodoorFish.fldId desc

		
END

else IF(@fieldName=N'fldShenaseGhabz')
BEGIN
		 IF(@AzTarikh <>'' AND @TaTarikh='')
		SELECT    top(@h)   Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
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
					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
					,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
		FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

		FROM         Drd.tblSodoorFish INNER JOIN
							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId
		WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId) AND fldOrganId=@OrganId
		AND cast(tblSodoorFish.fldDate as date)>=@Az and Drd.tblSodoorFish.fldShenaseGhabz like @Value
		order by  Drd.tblSodoorFish.fldId desc

		else IF(@AzTarikh ='' AND @TaTarikh<>'')
		SELECT   top(@h)    Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
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
					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
					,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
		FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

		FROM         Drd.tblSodoorFish INNER JOIN
							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId
		WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId) AND fldOrganId=@OrganId
		AND cast(tblSodoorFish.fldDate as date)<=@Ta and Drd.tblSodoorFish.fldShenaseGhabz like @Value
		order by  Drd.tblSodoorFish.fldId desc

		else IF(@AzTarikh <>'' AND @TaTarikh<>'')
		SELECT    top(@h)   Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
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
					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
					,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
		FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

		FROM         Drd.tblSodoorFish INNER JOIN
							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId
		WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId) AND fldOrganId=@OrganId
		AND cast(tblSodoorFish.fldDate as date) BETWEEN @Az AND @Ta and Drd.tblSodoorFish.fldShenaseGhabz like @Value
		order by  Drd.tblSodoorFish.fldId desc

		else IF(@AzTarikh ='' AND @TaTarikh='')
		SELECT    top(@h)   Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
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
					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
					,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
		FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

		FROM         Drd.tblSodoorFish INNER JOIN
							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId
		WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId) AND fldOrganId=@OrganId and Drd.tblSodoorFish.fldShenaseGhabz like @Value
		order by  Drd.tblSodoorFish.fldId desc
END

else IF(@fieldName=N'fldId')
BEGIN
		 IF(@AzTarikh <>'' AND @TaTarikh='')
		SELECT  top(@h)     Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
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
					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
					,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
		FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

		FROM         Drd.tblSodoorFish INNER JOIN
							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId
		WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId) AND fldOrganId=@OrganId
		AND cast(tblSodoorFish.fldDate as date)>=@Az and Drd.tblSodoorFish.fldId like @Value
		order by  Drd.tblSodoorFish.fldId desc

		else IF(@AzTarikh ='' AND @TaTarikh<>'')
		SELECT    top(@h)   Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
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
					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
					,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
		FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

		FROM         Drd.tblSodoorFish INNER JOIN
							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId
		WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId) AND fldOrganId=@OrganId
		AND cast(tblSodoorFish.fldDate as date)<=@Ta and Drd.tblSodoorFish.fldId like @Value
		order by  Drd.tblSodoorFish.fldId desc

		else IF(@AzTarikh <>'' AND @TaTarikh<>'')
		SELECT   top(@h)    Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
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
					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
					,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
		FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

		FROM         Drd.tblSodoorFish INNER JOIN
							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId
		WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId) AND fldOrganId=@OrganId
		AND cast(tblSodoorFish.fldDate as date) BETWEEN @Az AND @Ta and Drd.tblSodoorFish.fldId like @Value
		order by  Drd.tblSodoorFish.fldId desc

		else IF(@AzTarikh ='' AND @TaTarikh='')
		SELECT   top(@h)    Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
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
					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
				,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
		FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

		FROM         Drd.tblSodoorFish INNER JOIN
							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId
		WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId) AND fldOrganId=@OrganId and Drd.tblSodoorFish.fldId like @Value
		order by  Drd.tblSodoorFish.fldId desc
END

else IF(@fieldName=N'fldShenaseGhabz')
BEGIN
		IF(@AzTarikh <>'' AND @TaTarikh='')
		SELECT   top(@h)    Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
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
					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
					,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
		FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

		FROM         Drd.tblSodoorFish INNER JOIN
							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId
		WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId) AND fldOrganId=@OrganId
		AND cast(tblSodoorFish.fldDate as date)>=@Az and Drd.tblSodoorFish.fldShenaseGhabz like @Value
		order by  Drd.tblSodoorFish.fldId desc

		else IF(@AzTarikh ='' AND @TaTarikh<>'')
		SELECT   top(@h)    Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
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
					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
						,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
		FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

		FROM         Drd.tblSodoorFish INNER JOIN
							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId
		WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId) AND fldOrganId=@OrganId
		AND cast(tblSodoorFish.fldDate as date)<=@Ta and Drd.tblSodoorFish.fldShenaseGhabz like @Value
		order by  Drd.tblSodoorFish.fldId desc

		else IF(@AzTarikh <>'' AND @TaTarikh<>'')
		SELECT    top(@h)   Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
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
					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
						,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
		FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

		FROM         Drd.tblSodoorFish INNER JOIN
							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId
		WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId) AND fldOrganId=@OrganId
		AND cast(tblSodoorFish.fldDate as date) BETWEEN @Az AND @Ta and Drd.tblSodoorFish.fldShenaseGhabz like @Value
		order by  Drd.tblSodoorFish.fldId desc

		else IF(@AzTarikh ='' AND @TaTarikh='')
		SELECT    top(@h)   Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
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
					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
					,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
		FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

		FROM         Drd.tblSodoorFish INNER JOIN
							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId
		WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId) AND fldOrganId=@OrganId and Drd.tblSodoorFish.fldShenaseGhabz like @Value
		order by  Drd.tblSodoorFish.fldId desc
END

else IF(@fieldName=N'fldElamAvarezId')
BEGIN
	    IF(@AzTarikh <>'' AND @TaTarikh='')
		SELECT    top(@h)   Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
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
					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
						,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
		FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

		FROM         Drd.tblSodoorFish INNER JOIN
							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId
		WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId) AND fldOrganId=@OrganId
		AND cast(tblSodoorFish.fldDate as date)>=@Az and Drd.tblSodoorFish.fldElamAvarezId like @Value
		order by  Drd.tblSodoorFish.fldId desc

		else IF(@AzTarikh ='' AND @TaTarikh<>'')
		SELECT    top(@h)   Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
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
					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
						,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
		FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

		FROM         Drd.tblSodoorFish INNER JOIN
							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId
		WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId) AND fldOrganId=@OrganId
		AND cast(tblSodoorFish.fldDate as date)<=@Ta and Drd.tblSodoorFish.fldElamAvarezId like @Value
		order by  Drd.tblSodoorFish.fldId desc

		else IF(@AzTarikh <>'' AND @TaTarikh<>'')
		SELECT   top(@h)    Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
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
					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
						,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
		FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

		FROM         Drd.tblSodoorFish INNER JOIN
							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId
		WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId) AND fldOrganId=@OrganId
		AND cast(tblSodoorFish.fldDate as date) BETWEEN @Az AND @Ta and Drd.tblSodoorFish.fldElamAvarezId like @Value
		order by  Drd.tblSodoorFish.fldId desc

		else IF(@AzTarikh ='' AND @TaTarikh='')
		SELECT    top(@h)   Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
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
						,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
						,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
		FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

		FROM         Drd.tblSodoorFish INNER JOIN
							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId
		WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId) AND fldOrganId=@OrganId and Drd.tblSodoorFish.fldElamAvarezId like @Value
		order by  Drd.tblSodoorFish.fldId desc
END



else IF(@fieldName=N'fldTarikh')
BEGIN
		IF(@AzTarikh <>'' AND @TaTarikh='')
		SELECT   top(@h)    Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
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
					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
					,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
		FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

		FROM         Drd.tblSodoorFish INNER JOIN
							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId
		WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId) AND fldOrganId=@OrganId
		AND tblSodoorFish.fldTarikh>=@AzTarikh and Drd.tblSodoorFish.fldTarikh like @Value
		order by  Drd.tblSodoorFish.fldId desc

		else IF(@AzTarikh ='' AND @TaTarikh<>'')
		SELECT    top(@h)   Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
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
					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
						,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
		FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

		FROM         Drd.tblSodoorFish INNER JOIN
							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId
		WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId) AND fldOrganId=@OrganId
		AND tblSodoorFish.fldTarikh<=@TaTarikh and Drd.tblSodoorFish.fldTarikh like @Value
		order by  Drd.tblSodoorFish.fldId desc

		else IF(@AzTarikh <>'' AND @TaTarikh<>'')
		SELECT   top(@h)    Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
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
					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
						,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
		FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

		FROM         Drd.tblSodoorFish INNER JOIN
							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId
		WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId) AND fldOrganId=@OrganId
		AND tblSodoorFish.fldTarikh BETWEEN @AzTarikh AND @TaTarikh and Drd.tblSodoorFish.fldTarikh like @Value
		order by  Drd.tblSodoorFish.fldId desc

		else IF(@AzTarikh ='' AND @TaTarikh='')
		SELECT   top(@h)    Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
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
					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
						,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
		FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

		FROM         Drd.tblSodoorFish INNER JOIN
							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId
		WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId) AND fldOrganId=@OrganId and Drd.tblSodoorFish.fldTarikh like @Value
		order by  Drd.tblSodoorFish.fldId desc
END




else IF(@fieldName=N'fldShenasePardakht')
BEGIN
		IF(@AzTarikh <>'' AND @TaTarikh='')
		SELECT    top(@h)   Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
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
					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
						,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
		FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

		FROM         Drd.tblSodoorFish INNER JOIN
							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId
		WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId) AND fldOrganId=@OrganId
		AND cast(tblSodoorFish.fldDate as date)>=@Az and Drd.tblSodoorFish.fldShenasePardakht like @Value
		order by  Drd.tblSodoorFish.fldId desc

		else IF(@AzTarikh ='' AND @TaTarikh<>'')
		SELECT    top(@h)   Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
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
					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
					,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
		FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

		FROM         Drd.tblSodoorFish INNER JOIN
							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId
		WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId) AND fldOrganId=@OrganId
		AND cast(tblSodoorFish.fldDate as date)<=@Ta and Drd.tblSodoorFish.fldShenasePardakht like @Value
		order by  Drd.tblSodoorFish.fldId desc

		else IF(@AzTarikh <>'' AND @TaTarikh<>'')
		SELECT    top(@h)   Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
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
					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
						,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
		FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

		FROM         Drd.tblSodoorFish INNER JOIN
							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId
		WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId) AND fldOrganId=@OrganId
		AND cast(tblSodoorFish.fldDate as date) BETWEEN @Az AND @Ta and Drd.tblSodoorFish.fldShenasePardakht like @Value
		order by  Drd.tblSodoorFish.fldId desc

		else IF(@AzTarikh ='' AND @TaTarikh='')
		SELECT    top(@h)   Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
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
					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
						,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
		FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

		FROM         Drd.tblSodoorFish INNER JOIN
							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId
		WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId) AND fldOrganId=@OrganId and Drd.tblSodoorFish.fldShenasePardakht like @Value
		order by  Drd.tblSodoorFish.fldId desc
END





else IF(@fieldName=N'fldMablaghAvarezGerdShode')
BEGIN
		IF(@AzTarikh <>'' AND @TaTarikh='')
		SELECT    top(@h)   Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
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
					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
						,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
		FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

		FROM         Drd.tblSodoorFish INNER JOIN
							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId
		WHERE tblSodoorFish.fldId NOT IN (SELECT tblEbtal.fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId) AND fldOrganId=@OrganId
		AND cast(tblSodoorFish.fldDate as date)>=@Az and Drd.tblSodoorFish.fldMablaghAvarezGerdShode like @Value
		order by  Drd.tblSodoorFish.fldId desc

		else IF(@AzTarikh ='' AND @TaTarikh<>'')
		SELECT   top(@h)    Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
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
					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
				,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
		FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

			FROM         Drd.tblSodoorFish INNER JOIN
							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId
		WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId) AND fldOrganId=@OrganId
		AND cast(tblSodoorFish.fldDate as date)<=@Ta and Drd.tblSodoorFish.fldMablaghAvarezGerdShode like @Value
		order by  Drd.tblSodoorFish.fldId desc

		else IF(@AzTarikh <>'' AND @TaTarikh<>'')
		SELECT    top(@h)   Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
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
					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
						,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
		FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

		FROM         Drd.tblSodoorFish INNER JOIN
							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId
		WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId) AND fldOrganId=@OrganId
		AND cast(tblSodoorFish.fldDate as date) BETWEEN @Az AND @Ta and Drd.tblSodoorFish.fldMablaghAvarezGerdShode like @Value
		order by  Drd.tblSodoorFish.fldId desc

		else IF(@AzTarikh ='' AND @TaTarikh='')
		SELECT   top(@h)    Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
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
					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
						,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
		FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

		FROM         Drd.tblSodoorFish INNER JOIN
							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId
		WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId) AND fldOrganId=@OrganId and Drd.tblSodoorFish.fldMablaghAvarezGerdShode like @Value
		order by  Drd.tblSodoorFish.fldId desc
END





else IF(@fieldName=N'fldShorooShenaseGhabz')
BEGIN
		IF(@AzTarikh <>'' AND @TaTarikh='')
		SELECT    top(@h)   Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
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
					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
			,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
		FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

		FROM         Drd.tblSodoorFish INNER JOIN
							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId
		WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId) AND fldOrganId=@OrganId
		AND cast(tblSodoorFish.fldDate as date)>=@Az and Drd.tblSodoorFish.fldShorooShenaseGhabz like @Value
		order by  Drd.tblSodoorFish.fldId desc

		else IF(@AzTarikh ='' AND @TaTarikh<>'')
		SELECT   top(@h)    Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
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
					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
						,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
		FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

		FROM         Drd.tblSodoorFish INNER JOIN
							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId
		WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId) AND fldOrganId=@OrganId
		AND cast(tblSodoorFish.fldDate as date)<=@Ta and Drd.tblSodoorFish.fldShorooShenaseGhabz like @Value
		order by  Drd.tblSodoorFish.fldId desc

		else IF(@AzTarikh <>'' AND @TaTarikh<>'')
		SELECT   top(@h)    Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
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
					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
					,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
		FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

			FROM         Drd.tblSodoorFish INNER JOIN
							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId
		WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId) AND fldOrganId=@OrganId
		AND cast(tblSodoorFish.fldDate as date) BETWEEN @Az AND @Ta and Drd.tblSodoorFish.fldShorooShenaseGhabz like @Value
		order by  Drd.tblSodoorFish.fldId desc

		else IF(@AzTarikh ='' AND @TaTarikh='')
		SELECT   top(@h)    Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
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
					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
					,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
		FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

		FROM         Drd.tblSodoorFish INNER JOIN
							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId
                      
		WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId) AND fldOrganId=@OrganId and Drd.tblSodoorFish.fldShorooShenaseGhabz like @Value
		order by  Drd.tblSodoorFish.fldId desc
END


else IF(@fieldName=N'fldJamKol')
BEGIN
		IF(@AzTarikh <>'' AND @TaTarikh='')
		SELECT    top(@h)   Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
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
					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
							,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
		FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

		FROM         Drd.tblSodoorFish INNER JOIN
							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId
		WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId) AND fldOrganId=@OrganId
		AND cast(tblSodoorFish.fldDate as date)>=@Az and Drd.tblSodoorFish.fldJamKol like @Value
		order by  Drd.tblSodoorFish.fldId desc

		else IF(@AzTarikh ='' AND @TaTarikh<>'')
		SELECT   top(@h)    Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
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
					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
			,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
		FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

		FROM         Drd.tblSodoorFish INNER JOIN
							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId
		WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId) AND fldOrganId=@OrganId
		AND cast(tblSodoorFish.fldDate as date)<=@Ta and Drd.tblSodoorFish.fldJamKol like @Value
		order by  Drd.tblSodoorFish.fldId desc

		else IF(@AzTarikh <>'' AND @TaTarikh<>'')
		SELECT   top(@h)    Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
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
					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
			,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
					FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

		FROM         Drd.tblSodoorFish INNER JOIN
							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId
		WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId) AND fldOrganId=@OrganId
		AND cast(tblSodoorFish.fldDate as date) BETWEEN @Az AND @Ta and Drd.tblSodoorFish.fldJamKol like @Value
		order by  Drd.tblSodoorFish.fldId desc

		else IF(@AzTarikh ='' AND @TaTarikh='')
		SELECT    top(@h)   Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
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
					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
			,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
					FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

		FROM         Drd.tblSodoorFish INNER JOIN
							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId
		WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId) AND fldOrganId=@OrganId and Drd.tblSodoorFish.fldJamKol like @Value
		order by  Drd.tblSodoorFish.fldId desc
END


else IF(@fieldName=N'fldBarcode')
BEGIN
		IF(@AzTarikh <>'' AND @TaTarikh='')
		SELECT   top(@h)    Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
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
					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
			,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
					FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

		FROM         Drd.tblSodoorFish INNER JOIN
							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId
		WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId) AND fldOrganId=@OrganId
		AND cast(tblSodoorFish.fldDate as date)>=@Az and Drd.tblSodoorFish.fldBarcode like @Value
		order by  Drd.tblSodoorFish.fldId desc

		else IF(@AzTarikh ='' AND @TaTarikh<>'')
		SELECT    top(@h)   Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
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
					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
			,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
					FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

		FROM         Drd.tblSodoorFish INNER JOIN
							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId
		WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId) AND fldOrganId=@OrganId
		AND cast(tblSodoorFish.fldDate as date)<=@Ta and Drd.tblSodoorFish.fldBarcode like @Value
		order by  Drd.tblSodoorFish.fldId desc

		else IF(@AzTarikh <>'' AND @TaTarikh<>'')
		SELECT  top(@h)     Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
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
					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
			,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
					FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

		FROM         Drd.tblSodoorFish INNER JOIN
							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId
		WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId) AND fldOrganId=@OrganId
		AND cast(tblSodoorFish.fldDate as date) BETWEEN @Az AND @Ta and Drd.tblSodoorFish.fldBarcode like @Value
		order by  Drd.tblSodoorFish.fldId desc

		else IF(@AzTarikh ='' AND @TaTarikh='')
		SELECT    top(@h)   Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
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
					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
			,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
					FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

		FROM         Drd.tblSodoorFish INNER JOIN
							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId
		WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId) AND fldOrganId=@OrganId and Drd.tblSodoorFish.fldBarcode like @Value
		order by  Drd.tblSodoorFish.fldId desc
END

else IF(@fieldName=N'fldAshakhasID')
BEGIN
		IF(@AzTarikh <>'' AND @TaTarikh='')
		SELECT    top(@h)   Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
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
					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
			,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
					FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

		FROM         Drd.tblSodoorFish INNER JOIN
							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId
		WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId) AND fldOrganId=@OrganId
		AND cast(tblSodoorFish.fldDate as date)>=@Az and fldAshakhasID like @Value
		order by  Drd.tblSodoorFish.fldId desc

		else IF(@AzTarikh ='' AND @TaTarikh<>'')
		SELECT   top(@h)    Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
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
					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
			,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
					FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

		FROM         Drd.tblSodoorFish INNER JOIN
							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId
		WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId) AND fldOrganId=@OrganId
		AND cast(tblSodoorFish.fldDate as date)<=@Ta and fldAshakhasID like @Value
		order by  Drd.tblSodoorFish.fldId desc

		else IF(@AzTarikh <>'' AND @TaTarikh<>'')
		SELECT    top(@h)   Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
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
					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
			,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
					FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

		FROM         Drd.tblSodoorFish INNER JOIN
							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId
		WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId) AND fldOrganId=@OrganId
		AND cast(tblSodoorFish.fldDate as date) BETWEEN @Az AND @Ta and fldAshakhasID like @Value
		order by  Drd.tblSodoorFish.fldId desc

		else IF(@AzTarikh ='' AND @TaTarikh='')
		SELECT    top(@h)   Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
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
					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
			,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
					FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

		FROM         Drd.tblSodoorFish INNER JOIN
							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId
		WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId) AND fldOrganId=@OrganId and fldAshakhasID like @Value
		order by  Drd.tblSodoorFish.fldId desc
END


else IF(@fieldName=N'fldNameShakhs')
BEGIN
		IF(@AzTarikh <>'' AND @TaTarikh='')
		--SELECT   TOP (@h) * FROM(
		SELECT  Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
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
					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
			,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
					FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

		FROM         Drd.tblSodoorFish INNER JOIN
							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId
		WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId) AND fldOrganId=@OrganId
		and  (SELECT CASE WHEN fldHaghighiId IS not NULL THEN (SELECT  fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId)
							 WHEN fldHoghoghiId IS not NULL THEN (SELECT tblAshkhaseHoghoghi.fldName FROM Com.tblAshkhaseHoghoghi WHERE fldid=fldHoghoghiId)end FROM Com.tblAshkhas WHERE fldId=fldAshakhasID) like @value 
		AND tblSodoorFish.fldTarikh>=@AzTarikh
		--)AS t where fldNameShakhs like @Value
		order by  tblSodoorFish.fldId desc

		else IF(@AzTarikh ='' AND @TaTarikh<>'')
		--SELECT   TOP (@h) * FROM(
		SELECT  Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
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
					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
			,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
					FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

		FROM         Drd.tblSodoorFish INNER JOIN
							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId
		WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId) AND fldOrganId=@OrganId
		AND tblSodoorFish.fldTarikh<=@TaTarikh 
		and  (SELECT CASE WHEN fldHaghighiId IS not NULL THEN (SELECT  fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId)
							 WHEN fldHoghoghiId IS not NULL THEN (SELECT tblAshkhaseHoghoghi.fldName FROM Com.tblAshkhaseHoghoghi WHERE fldid=fldHoghoghiId)end FROM Com.tblAshkhas WHERE fldId=fldAshakhasID) like @value 
		AND tblSodoorFish.fldTarikh>=@AzTarikh

		--)as t where fldNameShakhs like @Value
		order by  tblSodoorFish.fldId desc

		else IF(@AzTarikh <>'' AND @TaTarikh<>'')
		--SELECT    TOP (@h) * FROM(
		SELECT Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
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
					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
			,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
					FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

		FROM         Drd.tblSodoorFish INNER JOIN
							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId
		WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId) AND fldOrganId=@OrganId
		AND tblSodoorFish.fldTarikh BETWEEN @AzTarikh AND @TaTarikh
		and  (SELECT CASE WHEN fldHaghighiId IS not NULL THEN (SELECT  fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId)
							 WHEN fldHoghoghiId IS not NULL THEN (SELECT tblAshkhaseHoghoghi.fldName FROM Com.tblAshkhaseHoghoghi WHERE fldid=fldHoghoghiId)end FROM Com.tblAshkhas WHERE fldId=fldAshakhasID) like @value 
		AND tblSodoorFish.fldTarikh>=@AzTarikh

		--)as t where fldNameShakhs like @Value
		order by tblSodoorFish.fldId desc

		else IF(@AzTarikh ='' AND @TaTarikh='')
		--SELECT   TOP (@h) * FROM(
		SELECT  Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
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
					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
			,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
					FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

		FROM         Drd.tblSodoorFish INNER JOIN
							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId
							   where tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=fldId) and  fldOrganId=@OrganId
		and  (SELECT CASE WHEN fldHaghighiId IS not NULL THEN (SELECT  fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId)
							 WHEN fldHoghoghiId IS not NULL THEN (SELECT tblAshkhaseHoghoghi.fldName FROM Com.tblAshkhaseHoghoghi WHERE fldid=fldHoghoghiId)end FROM Com.tblAshkhas WHERE fldId=fldAshakhasID) like @value 
		AND tblSodoorFish.fldTarikh>=@AzTarikh

		--					   )as t
		--WHERE   fldNameShakhs like @Value
		order by  tblSodoorFish.fldId desc
END




else IF(@fieldName=N'fldNoeShakhs')
BEGIN
		IF(@AzTarikh <>'' AND @TaTarikh='')
		SELECT   TOP (@h) * FROM(SELECT  Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
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
					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
			,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
					FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

		FROM         Drd.tblSodoorFish INNER JOIN
							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId
		WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId) AND fldOrganId=@OrganId
		AND tblSodoorFish.fldTarikh>=@AzTarikh)AS t where fldNoeShakhs like @Value
		order by  fldId desc

		else IF(@AzTarikh ='' AND @TaTarikh<>'')
		SELECT   TOP (@h) * FROM(SELECT  Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
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
					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
			,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
					FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

		FROM         Drd.tblSodoorFish INNER JOIN
							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId
		WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId) AND fldOrganId=@OrganId
		AND tblSodoorFish.fldTarikh<=@TaTarikh )as t where fldNoeShakhs like @Value
		order by  fldId desc

		else IF(@AzTarikh <>'' AND @TaTarikh<>'')
		SELECT    TOP (@h) * FROM(SELECT Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
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
					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
			,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
					FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

		FROM         Drd.tblSodoorFish INNER JOIN
							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId
		WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId) AND fldOrganId=@OrganId
		AND tblSodoorFish.fldTarikh BETWEEN @AzTarikh AND @TaTarikh)as t where fldNoeShakhs like @Value
		order by  fldId desc

		else IF(@AzTarikh ='' AND @TaTarikh='')
		SELECT   TOP (@h) * FROM(SELECT  Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
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
					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
			,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
					FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

		FROM         Drd.tblSodoorFish INNER JOIN
							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId  where fldOrganId=@OrganId)as t
		WHERE t.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=t.fldId)  and fldNoeShakhs like @Value 
		order by  fldId desc
END




else IF(@fieldName=N'fldFather_ShomareSabt')
BEGIN
		IF(@AzTarikh <>'' AND @TaTarikh='')
		SELECT   TOP (@h) * FROM(SELECT  Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
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
					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
			,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
					FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

		FROM         Drd.tblSodoorFish INNER JOIN
							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId
		WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId) AND fldOrganId=@OrganId
		AND tblSodoorFish.fldTarikh>=@AzTarikh )AS t where fldFather_ShomareSabt like @Value
		order by  fldId desc 

		else IF(@AzTarikh ='' AND @TaTarikh<>'')
		SELECT   TOP (@h) * FROM(SELECT  Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
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
					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
						,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
					FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

		FROM         Drd.tblSodoorFish INNER JOIN
							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId
		WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId) AND fldOrganId=@OrganId
		AND tblSodoorFish.fldTarikh<=@TaTarikh)as t where  fldFather_ShomareSabt like @Value
		order by  fldId desc

		else IF(@AzTarikh <>'' AND @TaTarikh<>'')
		SELECT    TOP (@h) * FROM(SELECT Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
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
					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
						,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
					FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

		FROM         Drd.tblSodoorFish INNER JOIN
							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId
		WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId) AND fldOrganId=@OrganId
		AND tblSodoorFish.fldTarikh BETWEEN @AzTarikh AND @TaTarikh )as t where fldFather_ShomareSabt like @Value
		order by fldId desc

		else IF(@AzTarikh ='' AND @TaTarikh='')
		SELECT   TOP (@h) * FROM(SELECT  Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
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
					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
				,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
					FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

		FROM         Drd.tblSodoorFish INNER JOIN
							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId where fldOrganId=@OrganId)as t
		WHERE t.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=t.fldId)  and fldFather_ShomareSabt like @Value
		order by  fldId desc
END





else IF(@fieldName=N'fldTypeAvarez')
BEGIN
		IF(@AzTarikh <>'' AND @TaTarikh='')
		SELECT   TOP (@h) * FROM(SELECT  Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
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
					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
							,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
					FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

		FROM         Drd.tblSodoorFish INNER JOIN
							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId
		WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId) AND fldOrganId=@OrganId
		AND tblSodoorFish.fldTarikh>=@AzTarikh)AS t where fldTypeAvarez like @Value
		order by  fldId desc

		else IF(@AzTarikh ='' AND @TaTarikh<>'')
		SELECT   TOP (@h) * FROM(SELECT  Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
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
					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
						,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
					FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

		FROM         Drd.tblSodoorFish INNER JOIN
							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId
		WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId) AND fldOrganId=@OrganId
		AND tblSodoorFish.fldTarikh<=@TaTarikh)as t where fldTypeAvarez like @Value
		order by  fldId desc

		else IF(@AzTarikh <>'' AND @TaTarikh<>'')
		SELECT    TOP (@h) * FROM(SELECT Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
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
					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
						,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
					FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

		FROM         Drd.tblSodoorFish INNER JOIN
							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId
		WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId) AND fldOrganId=@OrganId
		AND tblSodoorFish.fldTarikh BETWEEN @AzTarikh AND @TaTarikh )as t where fldTypeAvarez like @Value
		order by  fldId desc

		else IF(@AzTarikh ='' AND @TaTarikh='')
		SELECT   TOP (@h) * FROM(SELECT  Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
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
					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
						,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
					FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

		FROM         Drd.tblSodoorFish INNER JOIN
							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId where fldOrganId=@OrganId)as t
		WHERE t.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=t.fldId) AND  fldTypeAvarez like @Value
		order by  fldId desc
END





else IF(@fieldName=N'fldNationalCode')
BEGIN
		IF(@AzTarikh <>'' AND @TaTarikh='')
		SELECT   TOP (@h) * FROM(SELECT  Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
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
					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
						,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
					FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

		FROM         Drd.tblSodoorFish INNER JOIN
							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId
		WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId) AND fldOrganId=@OrganId
		AND tblSodoorFish.fldTarikh>=@AzTarikh)AS t where fldNationalCode like @Value
		order by  fldId desc

		else IF(@AzTarikh ='' AND @TaTarikh<>'')
		SELECT   TOP (@h) * FROM(SELECT  Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
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
					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
						,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
					FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

		FROM         Drd.tblSodoorFish INNER JOIN
							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId
		WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId) AND fldOrganId=@OrganId
		AND tblSodoorFish.fldTarikh<=@TaTarikh)as t where fldNationalCode like @Value
		order by  fldId desc

		else IF(@AzTarikh <>'' AND @TaTarikh<>'')
		SELECT    TOP (@h) * FROM(SELECT Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
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
					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
						,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
					FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

		FROM         Drd.tblSodoorFish INNER JOIN
							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId
		WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId) AND fldOrganId=@OrganId
		AND tblSodoorFish.fldTarikh BETWEEN @AzTarikh AND @TaTarikh )as t where fldNationalCode like @Value
		order by  fldId desc

		else IF(@AzTarikh ='' AND @TaTarikh='')
		SELECT   TOP (@h) * FROM(SELECT  Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
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
					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
						,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
					FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

		FROM         Drd.tblSodoorFish INNER JOIN
							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId where fldOrganId=@OrganId)as t
		WHERE t.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=t.fldId) AND  fldNationalCode like @Value
		order by  fldId desc
END



else IF(@fieldName=N'fldMashmool')
BEGIN
		IF(@AzTarikh <>'' AND @TaTarikh='')
		SELECT   TOP (@h) * FROM(SELECT  Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
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
					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
						,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
					FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

		FROM         Drd.tblSodoorFish INNER JOIN
							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId
		WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId) AND fldOrganId=@OrganId
		AND tblSodoorFish.fldTarikh>=@AzTarikh )AS t where fldMashmool like @Value
		order by  fldId desc

--		else IF(@AzTarikh ='' AND @TaTarikh<>'')
--		SELECT   TOP (@h) * FROM(SELECT  Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
--							  Drd.tblSodoorFish.fldShenasePardakht, Drd.tblSodoorFish.fldMablaghAvarezGerdShode, Drd.tblSodoorFish.fldShorooShenaseGhabz, Drd.tblSodoorFish.fldUserId, 
--							  Drd.tblSodoorFish.fldDesc, Drd.tblSodoorFish.fldTarikh, Drd.tblSodoorFish.fldJamKol, Drd.tblSodoorFish.fldBarcode, 
--							  fldAshakhasID,
--							 (SELECT CASE WHEN fldHaghighiId IS not NULL THEN (SELECT  fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId)
--							 WHEN fldHoghoghiId IS not NULL THEN (SELECT tblAshkhaseHoghoghi.fldName FROM Com.tblAshkhaseHoghoghi WHERE fldid=fldHoghoghiId)end FROM Com.tblAshkhas WHERE fldId=fldAshakhasID) AS fldNameShakhs,
--							(SELECT CASE WHEN fldHaghighiId IS not NULL THEN N'حقیقی'
--							 WHEN fldHoghoghiId IS not NULL THEN N'حقوقی' END FROM Com.tblAshkhas WHERE fldId=fldAshakhasID) AS fldNoeShakhs,
--							(SELECT CASE WHEN fldHaghighiId IS not NULL THEN (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId)
--							 WHEN fldHoghoghiId IS not NULL THEN (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldid=fldHoghoghiId)end FROM Com.tblAshkhas WHERE fldId=fldAshakhasID) AS fldFather_ShomareSabt
--						 ,CASE WHEN fldType = 0 THEN N'داخلی' WHEN fldType = 1 THEN N'خارجی' END AS fldTypeAvarez,
--						 (SELECT CASE WHEN fldHaghighiId IS not NULL THEN (SELECT  fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId)
--							 WHEN fldHoghoghiId IS not NULL THEN (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldid=fldHoghoghiId)end FROM Com.tblAshkhas WHERE fldId=fldAshakhasID) AS fldNationalCode
--						, CASE WHEN EXISTS (SELECT * FROM  Drd.tblCodhayeDaramd WHERE fldMashmooleArzesheAfzoode=1 and fldId IN (SELECT fldCodeDaramadId FROM Drd.tblShomareHesabCodeDaramad WHERE fldid IN (SELECT fldShomareHesabCodeDaramadId FROM Drd.tblCodhayeDaramadiElamAvarez WHERE fldid IN (SELECT fldCodeElamAvarezId FROM Drd.tblSodoorFish_Detail WHERE fldFishId=Drd.tblSodoorFish.fldId) ))) THEN N'1' ELSE N'0' END  AS fldMashmool
--					   ,ISNULL((SELECT    N'پرداخت شده با'+Drd.tblNahvePardakht.fldTitle
			
--		FROM         Drd.tblPardakhtFish INNER JOIN
--							  Drd.tblNahvePardakht ON Drd.tblPardakhtFish.fldNahvePardakhtId = Drd.tblNahvePardakht.fldId WHERE fldFishId=Drd.tblSodoorFish.fldId),N'پرداخت نشده')AS fldPardakhFish
--					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
--						,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
--					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
--					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
--					FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

--		FROM         Drd.tblSodoorFish INNER JOIN
--							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId
--		WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId) AND fldOrganId=@OrganId
--		AND tblSodoorFish.fldTarikh<=@TaTarikh )as t where fldMashmool like @Value
--		order by fldId desc

--		else IF(@AzTarikh <>'' AND @TaTarikh<>'')
--		SELECT    TOP (@h) * FROM(SELECT Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
--							  Drd.tblSodoorFish.fldShenasePardakht, Drd.tblSodoorFish.fldMablaghAvarezGerdShode, Drd.tblSodoorFish.fldShorooShenaseGhabz, Drd.tblSodoorFish.fldUserId, 
--							  Drd.tblSodoorFish.fldDesc, Drd.tblSodoorFish.fldTarikh, Drd.tblSodoorFish.fldJamKol, Drd.tblSodoorFish.fldBarcode, 
--							  fldAshakhasID,
--							 (SELECT CASE WHEN fldHaghighiId IS not NULL THEN (SELECT  fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId)
--							 WHEN fldHoghoghiId IS not NULL THEN (SELECT tblAshkhaseHoghoghi.fldName FROM Com.tblAshkhaseHoghoghi WHERE fldid=fldHoghoghiId)end FROM Com.tblAshkhas WHERE fldId=fldAshakhasID) AS fldNameShakhs,
--							(SELECT CASE WHEN fldHaghighiId IS not NULL THEN N'حقیقی'
--							 WHEN fldHoghoghiId IS not NULL THEN N'حقوقی' END FROM Com.tblAshkhas WHERE fldId=fldAshakhasID) AS fldNoeShakhs,
--							(SELECT CASE WHEN fldHaghighiId IS not NULL THEN (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId)
--							 WHEN fldHoghoghiId IS not NULL THEN (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldid=fldHoghoghiId)end FROM Com.tblAshkhas WHERE fldId=fldAshakhasID) AS fldFather_ShomareSabt
--						 ,CASE WHEN fldType = 0 THEN N'داخلی' WHEN fldType = 1 THEN N'خارجی' END AS fldTypeAvarez,
--						 (SELECT CASE WHEN fldHaghighiId IS not NULL THEN (SELECT  fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId)
--							 WHEN fldHoghoghiId IS not NULL THEN (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldid=fldHoghoghiId)end FROM Com.tblAshkhas WHERE fldId=fldAshakhasID) AS fldNationalCode
--						, CASE WHEN EXISTS (SELECT * FROM  Drd.tblCodhayeDaramd WHERE fldMashmooleArzesheAfzoode=1 and fldId IN (SELECT fldCodeDaramadId FROM Drd.tblShomareHesabCodeDaramad WHERE fldid IN (SELECT fldShomareHesabCodeDaramadId FROM Drd.tblCodhayeDaramadiElamAvarez WHERE fldid IN (SELECT fldCodeElamAvarezId FROM Drd.tblSodoorFish_Detail WHERE fldFishId=Drd.tblSodoorFish.fldId) ))) THEN N'1' ELSE N'0' END  AS fldMashmool
--					   ,ISNULL((SELECT    N'پرداخت شده با'+Drd.tblNahvePardakht.fldTitle
--		FROM         Drd.tblPardakhtFish INNER JOIN
--							  Drd.tblNahvePardakht ON Drd.tblPardakhtFish.fldNahvePardakhtId = Drd.tblNahvePardakht.fldId WHERE fldFishId=Drd.tblSodoorFish.fldId),N'پرداخت نشده')AS fldPardakhFish
--					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
--						,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
--					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
--					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
--					FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

--		FROM         Drd.tblSodoorFish INNER JOIN
--							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId
--		WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId) AND fldOrganId=@OrganId
--		AND tblSodoorFish.fldTarikh BETWEEN @AzTarikh AND @TaTarikh )as t where fldMashmool like @Value
--		order by  fldId desc

--		else IF(@AzTarikh ='' AND @TaTarikh='')
--		SELECT   TOP (@h) * FROM(SELECT  Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
--							  Drd.tblSodoorFish.fldShenasePardakht, Drd.tblSodoorFish.fldMablaghAvarezGerdShode, Drd.tblSodoorFish.fldShorooShenaseGhabz, Drd.tblSodoorFish.fldUserId, 
--							  Drd.tblSodoorFish.fldDesc, Drd.tblSodoorFish.fldTarikh, Drd.tblSodoorFish.fldJamKol, Drd.tblSodoorFish.fldBarcode, 
--							  fldAshakhasID,
--							 (SELECT CASE WHEN fldHaghighiId IS not NULL THEN (SELECT  fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId)
--							 WHEN fldHoghoghiId IS not NULL THEN (SELECT tblAshkhaseHoghoghi.fldName FROM Com.tblAshkhaseHoghoghi WHERE fldid=fldHoghoghiId)end FROM Com.tblAshkhas WHERE fldId=fldAshakhasID) AS fldNameShakhs,
--							(SELECT CASE WHEN fldHaghighiId IS not NULL THEN N'حقیقی'
--							 WHEN fldHoghoghiId IS not NULL THEN N'حقوقی' END FROM Com.tblAshkhas WHERE fldId=fldAshakhasID) AS fldNoeShakhs,
--							(SELECT CASE WHEN fldHaghighiId IS not NULL THEN (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId)
--							 WHEN fldHoghoghiId IS not NULL THEN (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldid=fldHoghoghiId)end FROM Com.tblAshkhas WHERE fldId=fldAshakhasID) AS fldFather_ShomareSabt
--						 ,CASE WHEN fldType = 0 THEN N'داخلی' WHEN fldType = 1 THEN N'خارجی' END AS fldTypeAvarez,
--						 (SELECT CASE WHEN fldHaghighiId IS not NULL THEN (SELECT  fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId)
--							 WHEN fldHoghoghiId IS not NULL THEN (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldid=fldHoghoghiId)end FROM Com.tblAshkhas WHERE fldId=fldAshakhasID) AS fldNationalCode
--						, CASE WHEN EXISTS (SELECT * FROM  Drd.tblCodhayeDaramd WHERE fldMashmooleArzesheAfzoode=1 and fldId IN (SELECT fldCodeDaramadId FROM Drd.tblShomareHesabCodeDaramad WHERE fldid IN (SELECT fldShomareHesabCodeDaramadId FROM Drd.tblCodhayeDaramadiElamAvarez WHERE fldid IN (SELECT fldCodeElamAvarezId FROM Drd.tblSodoorFish_Detail WHERE fldFishId=Drd.tblSodoorFish.fldId) ))) THEN N'1' ELSE N'0' END  AS fldMashmool
--					   ,ISNULL((SELECT    N'پرداخت شده با'+Drd.tblNahvePardakht.fldTitle
--		FROM         Drd.tblPardakhtFish INNER JOIN
--							  Drd.tblNahvePardakht ON Drd.tblPardakhtFish.fldNahvePardakhtId = Drd.tblNahvePardakht.fldId WHERE fldFishId=Drd.tblSodoorFish.fldId),N'پرداخت نشده')AS fldPardakhFish
--					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
--						,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
--					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
--					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
--					FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

--		FROM         Drd.tblSodoorFish INNER JOIN
--							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId where fldOrganId=@OrganId)as t
--		WHERE t.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=t.fldId) AND  fldMashmool like @Value
--		order by  fldId desc
END





else IF(@fieldName=N'fldPardakhFish')
BEGIN
--		IF(@AzTarikh <>'' AND @TaTarikh='')
		SELECT   TOP (@h) * FROM(SELECT  Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
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
					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
						,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
					FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

		FROM         Drd.tblSodoorFish INNER JOIN
							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId
		WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId) AND fldOrganId=@OrganId
		AND tblSodoorFish.fldTarikh>=@AzTarikh )AS t where fldPardakhFish like @Value
		order by  fldId desc

--		else IF(@AzTarikh ='' AND @TaTarikh<>'')
--		SELECT   TOP (@h) * FROM(SELECT  Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
--							  Drd.tblSodoorFish.fldShenasePardakht, Drd.tblSodoorFish.fldMablaghAvarezGerdShode, Drd.tblSodoorFish.fldShorooShenaseGhabz, Drd.tblSodoorFish.fldUserId, 
--							  Drd.tblSodoorFish.fldDesc, Drd.tblSodoorFish.fldTarikh, Drd.tblSodoorFish.fldJamKol, Drd.tblSodoorFish.fldBarcode, 
--							  fldAshakhasID,
--							 (SELECT CASE WHEN fldHaghighiId IS not NULL THEN (SELECT  fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId)
--							 WHEN fldHoghoghiId IS not NULL THEN (SELECT tblAshkhaseHoghoghi.fldName FROM Com.tblAshkhaseHoghoghi WHERE fldid=fldHoghoghiId)end FROM Com.tblAshkhas WHERE fldId=fldAshakhasID) AS fldNameShakhs,
--							(SELECT CASE WHEN fldHaghighiId IS not NULL THEN N'حقیقی'
--							 WHEN fldHoghoghiId IS not NULL THEN N'حقوقی' END FROM Com.tblAshkhas WHERE fldId=fldAshakhasID) AS fldNoeShakhs,
--							(SELECT CASE WHEN fldHaghighiId IS not NULL THEN (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId)
--							 WHEN fldHoghoghiId IS not NULL THEN (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldid=fldHoghoghiId)end FROM Com.tblAshkhas WHERE fldId=fldAshakhasID) AS fldFather_ShomareSabt
--						 ,CASE WHEN fldType = 0 THEN N'داخلی' WHEN fldType = 1 THEN N'خارجی' END AS fldTypeAvarez,
--						 (SELECT CASE WHEN fldHaghighiId IS not NULL THEN (SELECT  fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId)
--							 WHEN fldHoghoghiId IS not NULL THEN (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldid=fldHoghoghiId)end FROM Com.tblAshkhas WHERE fldId=fldAshakhasID) AS fldNationalCode
--						, CASE WHEN EXISTS (SELECT * FROM  Drd.tblCodhayeDaramd WHERE fldMashmooleArzesheAfzoode=1 and fldId IN (SELECT fldCodeDaramadId FROM Drd.tblShomareHesabCodeDaramad WHERE fldid IN (SELECT fldShomareHesabCodeDaramadId FROM Drd.tblCodhayeDaramadiElamAvarez WHERE fldid IN (SELECT fldCodeElamAvarezId FROM Drd.tblSodoorFish_Detail WHERE fldFishId=Drd.tblSodoorFish.fldId) ))) THEN N'1' ELSE N'0' END  AS fldMashmool
--					   ,ISNULL((SELECT    N'پرداخت شده با'+Drd.tblNahvePardakht.fldTitle
--		FROM         Drd.tblPardakhtFish INNER JOIN
--							  Drd.tblNahvePardakht ON Drd.tblPardakhtFish.fldNahvePardakhtId = Drd.tblNahvePardakht.fldId WHERE fldFishId=Drd.tblSodoorFish.fldId),N'پرداخت نشده')AS fldPardakhFish
--					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
--						,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
--					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
--					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
--					FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

--		FROM         Drd.tblSodoorFish INNER JOIN
--							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId
--		WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId) AND fldOrganId=@OrganId
--		AND tblSodoorFish.fldTarikh<=@TaTarikh )as t where fldPardakhFish like @Value
--		order by  fldId desc

--		else IF(@AzTarikh <>'' AND @TaTarikh<>'')
--		SELECT    TOP (@h) * FROM(SELECT Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
--							  Drd.tblSodoorFish.fldShenasePardakht, Drd.tblSodoorFish.fldMablaghAvarezGerdShode, Drd.tblSodoorFish.fldShorooShenaseGhabz, Drd.tblSodoorFish.fldUserId, 
--							  Drd.tblSodoorFish.fldDesc, Drd.tblSodoorFish.fldTarikh, Drd.tblSodoorFish.fldJamKol, Drd.tblSodoorFish.fldBarcode, 
--							  fldAshakhasID,
--							 (SELECT CASE WHEN fldHaghighiId IS not NULL THEN (SELECT  fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId)
--							 WHEN fldHoghoghiId IS not NULL THEN (SELECT tblAshkhaseHoghoghi.fldName FROM Com.tblAshkhaseHoghoghi WHERE fldid=fldHoghoghiId)end FROM Com.tblAshkhas WHERE fldId=fldAshakhasID) AS fldNameShakhs,
--							(SELECT CASE WHEN fldHaghighiId IS not NULL THEN N'حقیقی'
--							 WHEN fldHoghoghiId IS not NULL THEN N'حقوقی' END FROM Com.tblAshkhas WHERE fldId=fldAshakhasID) AS fldNoeShakhs,
--							(SELECT CASE WHEN fldHaghighiId IS not NULL THEN (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId)
--							 WHEN fldHoghoghiId IS not NULL THEN (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldid=fldHoghoghiId)end FROM Com.tblAshkhas WHERE fldId=fldAshakhasID) AS fldFather_ShomareSabt
--						 ,CASE WHEN fldType = 0 THEN N'داخلی' WHEN fldType = 1 THEN N'خارجی' END AS fldTypeAvarez,
--						 (SELECT CASE WHEN fldHaghighiId IS not NULL THEN (SELECT  fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId)
--							 WHEN fldHoghoghiId IS not NULL THEN (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldid=fldHoghoghiId)end FROM Com.tblAshkhas WHERE fldId=fldAshakhasID) AS fldNationalCode
--						, CASE WHEN EXISTS (SELECT * FROM  Drd.tblCodhayeDaramd WHERE fldMashmooleArzesheAfzoode=1 and fldId IN (SELECT fldCodeDaramadId FROM Drd.tblShomareHesabCodeDaramad WHERE fldid IN (SELECT fldShomareHesabCodeDaramadId FROM Drd.tblCodhayeDaramadiElamAvarez WHERE fldid IN (SELECT fldCodeElamAvarezId FROM Drd.tblSodoorFish_Detail WHERE fldFishId=Drd.tblSodoorFish.fldId) ))) THEN N'1' ELSE N'0' END  AS fldMashmool
--					   ,ISNULL((SELECT    N'پرداخت شده با'+Drd.tblNahvePardakht.fldTitle
--		FROM         Drd.tblPardakhtFish INNER JOIN
--							  Drd.tblNahvePardakht ON Drd.tblPardakhtFish.fldNahvePardakhtId = Drd.tblNahvePardakht.fldId WHERE fldFishId=Drd.tblSodoorFish.fldId),N'پرداخت نشده')AS fldPardakhFish
--					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
--						,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
--					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
--					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
--					FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

--		FROM         Drd.tblSodoorFish INNER JOIN
--							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId
--		WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId) AND fldOrganId=@OrganId
--		AND tblSodoorFish.fldTarikh BETWEEN @AzTarikh AND @TaTarikh )as t where fldPardakhFish like @Value
--		order by  fldId desc

--		else IF(@AzTarikh ='' AND @TaTarikh='')
--		SELECT   TOP (@h) * FROM(SELECT  Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
--							  Drd.tblSodoorFish.fldShenasePardakht, Drd.tblSodoorFish.fldMablaghAvarezGerdShode, Drd.tblSodoorFish.fldShorooShenaseGhabz, Drd.tblSodoorFish.fldUserId, 
--							  Drd.tblSodoorFish.fldDesc, Drd.tblSodoorFish.fldTarikh, Drd.tblSodoorFish.fldJamKol, Drd.tblSodoorFish.fldBarcode, 
--							  fldAshakhasID,
--							 (SELECT CASE WHEN fldHaghighiId IS not NULL THEN (SELECT  fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId)
--							 WHEN fldHoghoghiId IS not NULL THEN (SELECT tblAshkhaseHoghoghi.fldName FROM Com.tblAshkhaseHoghoghi WHERE fldid=fldHoghoghiId)end FROM Com.tblAshkhas WHERE fldId=fldAshakhasID) AS fldNameShakhs,
--							(SELECT CASE WHEN fldHaghighiId IS not NULL THEN N'حقیقی'
--							 WHEN fldHoghoghiId IS not NULL THEN N'حقوقی' END FROM Com.tblAshkhas WHERE fldId=fldAshakhasID) AS fldNoeShakhs,
--							(SELECT CASE WHEN fldHaghighiId IS not NULL THEN (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId)
--							 WHEN fldHoghoghiId IS not NULL THEN (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldid=fldHoghoghiId)end FROM Com.tblAshkhas WHERE fldId=fldAshakhasID) AS fldFather_ShomareSabt
--						 ,CASE WHEN fldType = 0 THEN N'داخلی' WHEN fldType = 1 THEN N'خارجی' END AS fldTypeAvarez,
--						 (SELECT CASE WHEN fldHaghighiId IS not NULL THEN (SELECT  fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId)
--							 WHEN fldHoghoghiId IS not NULL THEN (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldid=fldHoghoghiId)end FROM Com.tblAshkhas WHERE fldId=fldAshakhasID) AS fldNationalCode
--						, CASE WHEN EXISTS (SELECT * FROM  Drd.tblCodhayeDaramd WHERE fldMashmooleArzesheAfzoode=1 and fldId IN (SELECT fldCodeDaramadId FROM Drd.tblShomareHesabCodeDaramad WHERE fldid IN (SELECT fldShomareHesabCodeDaramadId FROM Drd.tblCodhayeDaramadiElamAvarez WHERE fldid IN (SELECT fldCodeElamAvarezId FROM Drd.tblSodoorFish_Detail WHERE fldFishId=Drd.tblSodoorFish.fldId) ))) THEN N'1' ELSE N'0' END  AS fldMashmool
--					   ,ISNULL((SELECT    N'پرداخت شده با'+Drd.tblNahvePardakht.fldTitle
--		FROM         Drd.tblPardakhtFish INNER JOIN
--							  Drd.tblNahvePardakht ON Drd.tblPardakhtFish.fldNahvePardakhtId = Drd.tblNahvePardakht.fldId WHERE fldFishId=Drd.tblSodoorFish.fldId),N'پرداخت نشده')AS fldPardakhFish
--					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
--						,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
--					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
--					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
--					FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

--		FROM         Drd.tblSodoorFish INNER JOIN
--							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId where  fldOrganId=@OrganId)as t
--		WHERE t.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=t.fldId) AND  fldPardakhFish like @Value
--		order by  fldId desc
END




else IF(@fieldName=N'fldPcposUser')
BEGIN
		--IF(@AzTarikh <>'' AND @TaTarikh='')
		SELECT   TOP (@h) * FROM(SELECT  Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
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
					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
						,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
					FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

		FROM         Drd.tblSodoorFish INNER JOIN
							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId
		WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId) AND fldOrganId=@OrganId
		AND tblSodoorFish.fldTarikh>=@AzTarikh )AS t where fldPcposUser like @Value
		order by  fldId desc

--		else IF(@AzTarikh ='' AND @TaTarikh<>'')
--		SELECT   TOP (@h) * FROM(SELECT  Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
--							  Drd.tblSodoorFish.fldShenasePardakht, Drd.tblSodoorFish.fldMablaghAvarezGerdShode, Drd.tblSodoorFish.fldShorooShenaseGhabz, Drd.tblSodoorFish.fldUserId, 
--							  Drd.tblSodoorFish.fldDesc, Drd.tblSodoorFish.fldTarikh, Drd.tblSodoorFish.fldJamKol, Drd.tblSodoorFish.fldBarcode, 
--							  fldAshakhasID,
--							 (SELECT CASE WHEN fldHaghighiId IS not NULL THEN (SELECT  fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId)
--							 WHEN fldHoghoghiId IS not NULL THEN (SELECT tblAshkhaseHoghoghi.fldName FROM Com.tblAshkhaseHoghoghi WHERE fldid=fldHoghoghiId)end FROM Com.tblAshkhas WHERE fldId=fldAshakhasID) AS fldNameShakhs,
--							(SELECT CASE WHEN fldHaghighiId IS not NULL THEN N'حقیقی'
--							 WHEN fldHoghoghiId IS not NULL THEN N'حقوقی' END FROM Com.tblAshkhas WHERE fldId=fldAshakhasID) AS fldNoeShakhs,
--							(SELECT CASE WHEN fldHaghighiId IS not NULL THEN (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId)
--							 WHEN fldHoghoghiId IS not NULL THEN (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldid=fldHoghoghiId)end FROM Com.tblAshkhas WHERE fldId=fldAshakhasID) AS fldFather_ShomareSabt
--						 ,CASE WHEN fldType = 0 THEN N'داخلی' WHEN fldType = 1 THEN N'خارجی' END AS fldTypeAvarez,
--						 (SELECT CASE WHEN fldHaghighiId IS not NULL THEN (SELECT  fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId)
--							 WHEN fldHoghoghiId IS not NULL THEN (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldid=fldHoghoghiId)end FROM Com.tblAshkhas WHERE fldId=fldAshakhasID) AS fldNationalCode
--						, CASE WHEN EXISTS (SELECT * FROM  Drd.tblCodhayeDaramd WHERE fldMashmooleArzesheAfzoode=1 and fldId IN (SELECT fldCodeDaramadId FROM Drd.tblShomareHesabCodeDaramad WHERE fldid IN (SELECT fldShomareHesabCodeDaramadId FROM Drd.tblCodhayeDaramadiElamAvarez WHERE fldid IN (SELECT fldCodeElamAvarezId FROM Drd.tblSodoorFish_Detail WHERE fldFishId=Drd.tblSodoorFish.fldId) ))) THEN N'1' ELSE N'0' END  AS fldMashmool
--					   ,ISNULL((SELECT    N'پرداخت شده با'+Drd.tblNahvePardakht.fldTitle
--		FROM         Drd.tblPardakhtFish INNER JOIN
--							  Drd.tblNahvePardakht ON Drd.tblPardakhtFish.fldNahvePardakhtId = Drd.tblNahvePardakht.fldId WHERE fldFishId=Drd.tblSodoorFish.fldId),N'پرداخت نشده')AS fldPardakhFish
--					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
--					,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
--					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
--					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
--					FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

--		FROM         Drd.tblSodoorFish INNER JOIN
--							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId
--		WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId) AND fldOrganId=@OrganId
--		AND tblSodoorFish.fldTarikh<=@TaTarikh )as t where fldPcposUser like @Value
--		order by  fldId desc

----		else IF(@AzTarikh <>'' AND @TaTarikh<>'')
--		SELECT    TOP (@h) * FROM(SELECT Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
--							  Drd.tblSodoorFish.fldShenasePardakht, Drd.tblSodoorFish.fldMablaghAvarezGerdShode, Drd.tblSodoorFish.fldShorooShenaseGhabz, Drd.tblSodoorFish.fldUserId, 
--							  Drd.tblSodoorFish.fldDesc, Drd.tblSodoorFish.fldTarikh, Drd.tblSodoorFish.fldJamKol, Drd.tblSodoorFish.fldBarcode, 
--							  fldAshakhasID,
--							 (SELECT CASE WHEN fldHaghighiId IS not NULL THEN (SELECT  fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId)
--							 WHEN fldHoghoghiId IS not NULL THEN (SELECT tblAshkhaseHoghoghi.fldName FROM Com.tblAshkhaseHoghoghi WHERE fldid=fldHoghoghiId)end FROM Com.tblAshkhas WHERE fldId=fldAshakhasID) AS fldNameShakhs,
--							(SELECT CASE WHEN fldHaghighiId IS not NULL THEN N'حقیقی'
--							 WHEN fldHoghoghiId IS not NULL THEN N'حقوقی' END FROM Com.tblAshkhas WHERE fldId=fldAshakhasID) AS fldNoeShakhs,
--							(SELECT CASE WHEN fldHaghighiId IS not NULL THEN (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId)
--							 WHEN fldHoghoghiId IS not NULL THEN (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldid=fldHoghoghiId)end FROM Com.tblAshkhas WHERE fldId=fldAshakhasID) AS fldFather_ShomareSabt
--						 ,CASE WHEN fldType = 0 THEN N'داخلی' WHEN fldType = 1 THEN N'خارجی' END AS fldTypeAvarez,
--						 (SELECT CASE WHEN fldHaghighiId IS not NULL THEN (SELECT  fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId)
--							 WHEN fldHoghoghiId IS not NULL THEN (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldid=fldHoghoghiId)end FROM Com.tblAshkhas WHERE fldId=fldAshakhasID) AS fldNationalCode
--						, CASE WHEN EXISTS (SELECT * FROM  Drd.tblCodhayeDaramd WHERE fldMashmooleArzesheAfzoode=1 and fldId IN (SELECT fldCodeDaramadId FROM Drd.tblShomareHesabCodeDaramad WHERE fldid IN (SELECT fldShomareHesabCodeDaramadId FROM Drd.tblCodhayeDaramadiElamAvarez WHERE fldid IN (SELECT fldCodeElamAvarezId FROM Drd.tblSodoorFish_Detail WHERE fldFishId=Drd.tblSodoorFish.fldId) ))) THEN N'1' ELSE N'0' END  AS fldMashmool
--					   ,ISNULL((SELECT    N'پرداخت شده با'+Drd.tblNahvePardakht.fldTitle
--		FROM         Drd.tblPardakhtFish INNER JOIN
--							  Drd.tblNahvePardakht ON Drd.tblPardakhtFish.fldNahvePardakhtId = Drd.tblNahvePardakht.fldId WHERE fldFishId=Drd.tblSodoorFish.fldId),N'پرداخت نشده')AS fldPardakhFish
--					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
--		,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
--					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
--					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
--					FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

--		FROM         Drd.tblSodoorFish INNER JOIN
--							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId
--		WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId) AND fldOrganId=@OrganId
--		AND tblSodoorFish.fldTarikh BETWEEN @AzTarikh AND @TaTarikh )as t where fldPcposUser like @Value
--		order by  fldId desc

--		else IF(@AzTarikh ='' AND @TaTarikh='')
--		SELECT   TOP (@h) * FROM(SELECT  Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
--							  Drd.tblSodoorFish.fldShenasePardakht, Drd.tblSodoorFish.fldMablaghAvarezGerdShode, Drd.tblSodoorFish.fldShorooShenaseGhabz, Drd.tblSodoorFish.fldUserId, 
--							  Drd.tblSodoorFish.fldDesc, Drd.tblSodoorFish.fldTarikh, Drd.tblSodoorFish.fldJamKol, Drd.tblSodoorFish.fldBarcode, 
--							  fldAshakhasID,
--							 (SELECT CASE WHEN fldHaghighiId IS not NULL THEN (SELECT  fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId)
--							 WHEN fldHoghoghiId IS not NULL THEN (SELECT tblAshkhaseHoghoghi.fldName FROM Com.tblAshkhaseHoghoghi WHERE fldid=fldHoghoghiId)end FROM Com.tblAshkhas WHERE fldId=fldAshakhasID) AS fldNameShakhs,
--							(SELECT CASE WHEN fldHaghighiId IS not NULL THEN N'حقیقی'
--							 WHEN fldHoghoghiId IS not NULL THEN N'حقوقی' END FROM Com.tblAshkhas WHERE fldId=fldAshakhasID) AS fldNoeShakhs,
--							(SELECT CASE WHEN fldHaghighiId IS not NULL THEN (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId)
--							 WHEN fldHoghoghiId IS not NULL THEN (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldid=fldHoghoghiId)end FROM Com.tblAshkhas WHERE fldId=fldAshakhasID) AS fldFather_ShomareSabt
--						 ,CASE WHEN fldType = 0 THEN N'داخلی' WHEN fldType = 1 THEN N'خارجی' END AS fldTypeAvarez,
--						 (SELECT CASE WHEN fldHaghighiId IS not NULL THEN (SELECT  fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId)
--							 WHEN fldHoghoghiId IS not NULL THEN (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldid=fldHoghoghiId)end FROM Com.tblAshkhas WHERE fldId=fldAshakhasID) AS fldNationalCode
--						, CASE WHEN EXISTS (SELECT * FROM  Drd.tblCodhayeDaramd WHERE fldMashmooleArzesheAfzoode=1 and fldId IN (SELECT fldCodeDaramadId FROM Drd.tblShomareHesabCodeDaramad WHERE fldid IN (SELECT fldShomareHesabCodeDaramadId FROM Drd.tblCodhayeDaramadiElamAvarez WHERE fldid IN (SELECT fldCodeElamAvarezId FROM Drd.tblSodoorFish_Detail WHERE fldFishId=Drd.tblSodoorFish.fldId) ))) THEN N'1' ELSE N'0' END  AS fldMashmool
--					   ,ISNULL((SELECT    N'پرداخت شده با'+Drd.tblNahvePardakht.fldTitle
--		FROM         Drd.tblPardakhtFish INNER JOIN
--							  Drd.tblNahvePardakht ON Drd.tblPardakhtFish.fldNahvePardakhtId = Drd.tblNahvePardakht.fldId WHERE fldFishId=Drd.tblSodoorFish.fldId),N'پرداخت نشده')AS fldPardakhFish
--					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
--		,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
--					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
--					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
--					FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

--		FROM         Drd.tblSodoorFish INNER JOIN
--							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId where fldOrganId=@OrganId)as t
--		WHERE t.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=t.fldId) AND  fldPcposUser like @Value
--		order by  fldId desc
END

--else IF (@fieldName='PcPos')
--SELECT   top(@h)    Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
--                      Drd.tblSodoorFish.fldShenasePardakht, Drd.tblSodoorFish.fldMablaghAvarezGerdShode, Drd.tblSodoorFish.fldShorooShenaseGhabz, Drd.tblSodoorFish.fldUserId, 
--                      Drd.tblSodoorFish.fldDesc, Drd.tblSodoorFish.fldTarikh, Drd.tblSodoorFish.fldJamKol, Drd.tblSodoorFish.fldBarcode, 
--                      fldAshakhasID,
--                     (SELECT CASE WHEN fldHaghighiId IS not NULL THEN (SELECT  fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId)
--                     WHEN fldHoghoghiId IS not NULL THEN (SELECT tblAshkhaseHoghoghi.fldName FROM Com.tblAshkhaseHoghoghi WHERE fldid=fldHoghoghiId)end FROM Com.tblAshkhas WHERE fldId=fldAshakhasID) AS fldNameShakhs,
--					(SELECT CASE WHEN fldHaghighiId IS not NULL THEN N'حقیقی'
--                     WHEN fldHoghoghiId IS not NULL THEN N'حقوقی' END FROM Com.tblAshkhas WHERE fldId=fldAshakhasID) AS fldNoeShakhs,
--					(SELECT CASE WHEN fldHaghighiId IS not NULL THEN (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId)
--                     WHEN fldHoghoghiId IS not NULL THEN (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldid=fldHoghoghiId)end FROM Com.tblAshkhas WHERE fldId=fldAshakhasID) AS fldFather_ShomareSabt
--				 ,CASE WHEN fldType = 0 THEN N'داخلی' WHEN fldType = 1 THEN N'خارجی' END AS fldTypeAvarez,
--				 (SELECT CASE WHEN fldHaghighiId IS not NULL THEN (SELECT  fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId)
--                     WHEN fldHoghoghiId IS not NULL THEN (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldid=fldHoghoghiId)end FROM Com.tblAshkhas WHERE fldId=fldAshakhasID) AS fldNationalCode
--				, CASE WHEN EXISTS (SELECT * FROM  Drd.tblCodhayeDaramd WHERE fldMashmooleArzesheAfzoode=1 and fldId IN (SELECT fldCodeDaramadId FROM Drd.tblShomareHesabCodeDaramad WHERE fldid IN (SELECT fldShomareHesabCodeDaramadId FROM Drd.tblCodhayeDaramadiElamAvarez WHERE fldid IN (SELECT fldCodeElamAvarezId FROM Drd.tblSodoorFish_Detail WHERE fldFishId=Drd.tblSodoorFish.fldId) ))) THEN N'1' ELSE N'0' END  AS fldMashmool
--			   ,ISNULL((SELECT    N'پرداخت شده با'+Drd.tblNahvePardakht.fldTitle
--FROM         Drd.tblPardakhtFish INNER JOIN
--                      Drd.tblNahvePardakht ON Drd.tblPardakhtFish.fldNahvePardakhtId = Drd.tblNahvePardakht.fldId WHERE fldFishId=Drd.tblSodoorFish.fldId),N'پرداخت نشده')AS fldPardakhFish
--			,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
--			,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
--			,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
--			,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
--			FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

--FROM         Drd.tblSodoorFish INNER JOIN
--                      Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId
--WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId) AND fldOrganId=@OrganId
--AND fldElamAvarezId=@Value AND  Drd.tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId)

COMMIT
GO
