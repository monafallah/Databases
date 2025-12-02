SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_SelectFishSaderShode]
@fieldName NVARCHAR(50),
@Value NVARCHAR(50),
@AzTarikh NVARCHAR(10),
@TaTarikh NVARCHAR(10),
@UserId INT,
@OrganId int,
--@FiscalYearId int,
@h int=100
AS
begin tran
declare @fieldName1 NVARCHAR(50),
@Value1 NVARCHAR(50),
@AzTarikh1 NVARCHAR(10),
@TaTarikh1 NVARCHAR(10),
@UserId1 INT,
@OrganId1 int,
@h1 int=100,@date date,@fromdate date,@toDate date--, @Year varchar(4)

--select @Year=fldYear from acc.tblFiscalYear where fldId=@FiscalYearId

set @fieldName1=@fieldName
set @Value1=@Value
set @AzTarikh1=@AzTarikh
set @TaTarikh1=@TaTarikh
set @UserId1=@UserId
set @OrganId1=@OrganId
set @h1=@h

--declare @fieldName1 NVARCHAR(50)='',
--@Value1 NVARCHAR(50)='',
--@AzTarikh1 NVARCHAR(10)='',
--@TaTarikh1 NVARCHAR(10)='',
--@UserId1 INT=1,
--@OrganId1 int=1,
--@h1 int=100
	--DECLARE @organ TABLE (id int)
	--;WITH organ as	(
	--SELECT    fldId    
	--FROM            Com.tblOrganization
	--WHERE fldId=@OrganId1
	--UNION ALL
	--SELECT t.fldId FROM Com.tblOrganization AS t
	--INNER JOIN organ ON t.fldPId=organ.fldId
	-- )
	-- INSERT INTO @organ 
	--		 ( id )
	-- SELECT organ.fldId FROM organ
if (@h1=0) set @h1=2147483647	 
IF(@fieldName1='')
BEGIN

		 IF(@AzTarikh1 ='' AND @TaTarikh1='')
		SELECT   top(@h1)    Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
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
					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId1 ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
					,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
		FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

		FROM         Drd.tblSodoorFish INNER JOIN
							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId
		WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId) AND fldOrganId=@OrganId1
		--and tblSodoorFish.fldTarikh like @Year+'%'
		order by  Drd.tblSodoorFish.fldId desc

		ELSE IF(@AzTarikh1 <>'' AND @TaTarikh1='')
		begin
		set @fromdate=com.ShamsiToMiladi(@AzTarikh1)
		SELECT  top(@h1)   Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
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
					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId1 ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
					,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
		FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

		FROM         Drd.tblSodoorFish INNER JOIN
							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId
		WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId) AND fldOrganId=@OrganId1
		AND cast(tblSodoorFish.flddate as date)>=@fromdate
		order by  Drd.tblSodoorFish.fldId desc
		end
		else IF(@AzTarikh1 ='' AND @TaTarikh1<>'')
		begin
		set @toDate=com.ShamsiToMiladi(@TaTarikh1)
		SELECT   top(@h1)    Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
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
					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId1 ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
					,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
		FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

		FROM         Drd.tblSodoorFish INNER JOIN
							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId
		WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId) AND fldOrganId=@OrganId1
		AND cast(tblSodoorFish.flddate as date)<=@toDate
		order by  Drd.tblSodoorFish.fldId desc
		end
		else IF(@AzTarikh1 <>'' AND @TaTarikh1<>'')
		begin
		set @fromdate=com.ShamsiToMiladi(@AzTarikh1)
		set @toDate=com.ShamsiToMiladi(@TaTarikh1)
		SELECT   top(@h1)    Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
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
					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId1 ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
					,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
		FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

		FROM         Drd.tblSodoorFish INNER JOIN
							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId
		WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId) AND fldOrganId=@OrganId1
		AND cast(tblSodoorFish.fldDate as date)>=@fromdate AND cast(tblSodoorFish.fldDate as date)<=@toDate
		order by  Drd.tblSodoorFish.fldId desc
		end 
		
END

else IF(@fieldName1=N'fldShenaseGhabz')
BEGIN
		 IF(@AzTarikh1 <>'' AND @TaTarikh1='')
		 begin
		 set @fromdate=com.ShamsiToMiladi(@AzTarikh1)
		SELECT    top(@h1)   Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
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
					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId1 ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
					,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
		FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

		FROM         Drd.tblSodoorFish INNER JOIN
							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId
		WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId) AND fldOrganId=@OrganId1
		AND cast(tblSodoorFish.flddate as date)>=@fromdate and Drd.tblSodoorFish.fldShenaseGhabz like @Value1
		order by  Drd.tblSodoorFish.fldId desc
		end
		else IF(@AzTarikh1 ='' AND @TaTarikh1<>'')
		begin
		set @toDate=com.ShamsiToMiladi(@TaTarikh1)
		SELECT   top(@h1)    Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
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
					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId1 ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
					,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
		FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

		FROM         Drd.tblSodoorFish INNER JOIN
							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId
		WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId) AND fldOrganId=@OrganId1
		AND cast(tblSodoorFish.flddate as date)<=@toDate and Drd.tblSodoorFish.fldShenaseGhabz like @Value1
		order by  Drd.tblSodoorFish.fldId desc
		end
		else IF(@AzTarikh1 <>'' AND @TaTarikh1<>'')
		begin
		set @fromdate=com.ShamsiToMiladi(@AzTarikh1)
		set @toDate=com.ShamsiToMiladi(@TaTarikh1)
		SELECT    top(@h1)   Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
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
					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId1 ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
					,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
		FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

		FROM         Drd.tblSodoorFish INNER JOIN
							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId
		WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId) AND fldOrganId=@OrganId1
		AND cast(tblSodoorFish.flddate as date) >= @fromdate AND cast(tblSodoorFish.flddate as date) <=@toDate and Drd.tblSodoorFish.fldShenaseGhabz like @Value1
		order by  Drd.tblSodoorFish.fldId desc
		end
		else IF(@AzTarikh1 ='' AND @TaTarikh1='')
		SELECT    top(@h1)   Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
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
					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId1 ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
					,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
		FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

		FROM         Drd.tblSodoorFish INNER JOIN
							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId
		WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId) AND fldOrganId=@OrganId1 
		and Drd.tblSodoorFish.fldShenaseGhabz like @Value1 --and tblSodoorFish.fldTarikh like @Year+'%'
		order by  Drd.tblSodoorFish.fldId desc
END

else IF(@fieldName1=N'fldId')
BEGIN
		 IF(@AzTarikh1 <>'' AND @TaTarikh1='')
		 begin
		 set @fromdate=com.ShamsiToMiladi(@AzTarikh1)
		SELECT  top(@h1)     Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
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
					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId1 ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
					,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
		FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

		FROM         Drd.tblSodoorFish INNER JOIN
							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId
		WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId) AND fldOrganId=@OrganId1
		AND cast(tblSodoorFish.flddate as date)>=@fromdate and Drd.tblSodoorFish.fldId like @Value1
		order by  Drd.tblSodoorFish.fldId desc
		end
		else IF(@AzTarikh1 ='' AND @TaTarikh1<>'')
		begin
		set @toDate=com.ShamsiToMiladi(@TaTarikh1)
		SELECT    top(@h1)   Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
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
					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId1 ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
					,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
		FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

		FROM         Drd.tblSodoorFish INNER JOIN
							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId
		WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId) AND fldOrganId=@OrganId1
		AND cast(tblSodoorFish.flddate as date)<=@toDate and Drd.tblSodoorFish.fldId like @Value1
		order by  Drd.tblSodoorFish.fldId desc
		end
		else IF(@AzTarikh1 <>'' AND @TaTarikh1<>'')
		begin
		set @fromdate=com.ShamsiToMiladi(@AzTarikh1)
		set @toDate=com.ShamsiToMiladi(@TaTarikh1)
		SELECT   top(@h1)    Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
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
					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId1 ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
					,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
		FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

		FROM         Drd.tblSodoorFish INNER JOIN
							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId
		WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId) AND fldOrganId=@OrganId1
		AND cast(tblSodoorFish.flddate as date) >= @fromdate AND cast(tblSodoorFish.flddate as date)<= @todate and Drd.tblSodoorFish.fldId like @Value1
		order by  Drd.tblSodoorFish.fldId desc
		end
		else IF(@AzTarikh1 ='' AND @TaTarikh1='')
		SELECT   top(@h1)    Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
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
					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId1 ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
				,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
		FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

		FROM         Drd.tblSodoorFish INNER JOIN
							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId
		WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId) 
		AND fldOrganId=@OrganId1 and Drd.tblSodoorFish.fldId like @Value1 --and tblSodoorFish.fldTarikh like @Year+'%' 
		order by  Drd.tblSodoorFish.fldId desc
END

else IF(@fieldName1=N'fldShenaseGhabz')
BEGIN
		IF(@AzTarikh1 <>'' AND @TaTarikh1='')
		begin
		set @fromdate=com.ShamsiToMiladi(@AzTarikh1)
		SELECT   top(@h1)    Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
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
					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId1 ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
					,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
		FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

		FROM         Drd.tblSodoorFish INNER JOIN
							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId
		WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId) AND fldOrganId=@OrganId1
		AND cast(tblSodoorFish.flddate as date)>=@fromdate and Drd.tblSodoorFish.fldShenaseGhabz like @Value1
		order by  Drd.tblSodoorFish.fldId desc
		end
		else IF(@AzTarikh1 ='' AND @TaTarikh1<>'')
		begin
		set @toDate=com.ShamsiToMiladi(@TaTarikh1)
		SELECT   top(@h1)    Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
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
					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId1 ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
						,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
		FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

		FROM         Drd.tblSodoorFish INNER JOIN
							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId
		WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId) AND fldOrganId=@OrganId1
		AND cast(tblSodoorFish.flddate as date)<=@toDate and Drd.tblSodoorFish.fldShenaseGhabz like @Value1
		order by  Drd.tblSodoorFish.fldId desc
		end
		else IF(@AzTarikh1 <>'' AND @TaTarikh1<>'')
		begin
		set @fromdate=com.ShamsiToMiladi(@AzTarikh1)
		set @toDate=com.ShamsiToMiladi(@TaTarikh1)
		SELECT    top(@h1)   Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
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
					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId1 ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
						,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
		FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

		FROM         Drd.tblSodoorFish INNER JOIN
							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId
		WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId) AND fldOrganId=@OrganId1
		AND cast(tblSodoorFish.flddate as date) >= @fromdate AND cast(tblSodoorFish.flddate as date)<=@toDate and Drd.tblSodoorFish.fldShenaseGhabz like @Value1
		order by  Drd.tblSodoorFish.fldId desc
		end
		else IF(@AzTarikh1 ='' AND @TaTarikh1='')
		SELECT    top(@h1)   Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
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
					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId1 ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
					,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
		FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

		FROM         Drd.tblSodoorFish INNER JOIN
							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId
		WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId) AND fldOrganId=@OrganId1 
		and Drd.tblSodoorFish.fldShenaseGhabz like @Value1 --and tblSodoorFish.fldTarikh like @Year+'%'
		order by  Drd.tblSodoorFish.fldId desc
END

else IF(@fieldName1=N'fldElamAvarezId')
BEGIN
	    IF(@AzTarikh1 <>'' AND @TaTarikh1='')
		begin
		set @fromdate=com.ShamsiToMiladi(@AzTarikh1)
		SELECT    top(@h1)   Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
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
					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId1 ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
						,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
		FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

		FROM         Drd.tblSodoorFish INNER JOIN
							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId
		WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId) AND fldOrganId=@OrganId1
		AND cast(tblSodoorFish.flddate as date)>=@fromdate and Drd.tblSodoorFish.fldElamAvarezId like @Value1
		order by  Drd.tblSodoorFish.fldId desc
		end
		else IF(@AzTarikh1 ='' AND @TaTarikh1<>'')
		begin
		set @toDate=com.ShamsiToMiladi(@TaTarikh1)
		SELECT    top(@h1)   Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
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
					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId1 ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
						,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
		FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

		FROM         Drd.tblSodoorFish INNER JOIN
							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId
		WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId) AND fldOrganId=@OrganId1
		AND cast(tblSodoorFish.flddate as date)<=@toDate and Drd.tblSodoorFish.fldElamAvarezId like @Value1
		order by  Drd.tblSodoorFish.fldId desc
		end
		else IF(@AzTarikh1 <>'' AND @TaTarikh1<>'')
		begin
		set @fromdate=com.ShamsiToMiladi(@AzTarikh1)
		set @toDate=com.ShamsiToMiladi(@TaTarikh1)
		SELECT   top(@h1)    Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
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
					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId1 ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
						,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
		FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

		FROM         Drd.tblSodoorFish INNER JOIN
							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId
		WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId) AND fldOrganId=@OrganId1
		AND cast(tblSodoorFish.flddate as date) >= @fromdate AND cast(tblSodoorFish.flddate as date)<=@toDate and Drd.tblSodoorFish.fldElamAvarezId like @Value1
		order by  Drd.tblSodoorFish.fldId desc
		end
		else IF(@AzTarikh1 ='' AND @TaTarikh1='')
		SELECT    top(@h1)   Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
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
						,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId1 ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
						,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
		FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

		FROM         Drd.tblSodoorFish INNER JOIN
							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId
		WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId) AND fldOrganId=@OrganId1 
		and Drd.tblSodoorFish.fldElamAvarezId like @Value1 --and tblSodoorFish.fldTarikh like @Year+'%'
		order by  Drd.tblSodoorFish.fldId desc
END



else IF(@fieldName1=N'fldTarikh')
BEGIN
		IF(@AzTarikh1 <>'' AND @TaTarikh1='')
		begin
		set @fromdate=com.ShamsiToMiladi(@AzTarikh1)
		set @date=com.ShamsiToMiladi(replace(@Value1,'%',''))
		SELECT   top(@h1)    Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
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
					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId1 ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
					,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
		FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

		FROM         Drd.tblSodoorFish INNER JOIN
							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId
		WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId) AND fldOrganId=@OrganId1
		AND cast(tblSodoorFish.flddate as date)>=@fromdate and cast(Drd.tblSodoorFish.flddate as date) = @date
		order by  Drd.tblSodoorFish.fldId desc
		end
		else IF(@AzTarikh1 ='' AND @TaTarikh1<>'')
		begin
		set @toDate=com.ShamsiToMiladi(@TaTarikh1)
		set @date=com.ShamsiToMiladi(replace(@Value1,'%',''))
		SELECT    top(@h1)   Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
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
					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId1 ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
						,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
		FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

		FROM         Drd.tblSodoorFish INNER JOIN
							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId
		WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId) AND fldOrganId=@OrganId1
		AND cast(tblSodoorFish.flddate as date)<=@toDate and cast(Drd.tblSodoorFish.flddate as date) = @date
		order by  Drd.tblSodoorFish.fldId desc
		end
		else IF(@AzTarikh1 <>'' AND @TaTarikh1<>'')
		begin
		set @fromdate=com.ShamsiToMiladi(@AzTarikh1)
		set @toDate=com.ShamsiToMiladi(@TaTarikh1)
		set @date=com.ShamsiToMiladi(replace(@Value1,'%',''))
		SELECT   top(@h1)    Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
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
					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId1 ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
						,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
		FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

		FROM         Drd.tblSodoorFish INNER JOIN
							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId
		WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId) AND fldOrganId=@OrganId1
		AND cast(tblSodoorFish.flddate as date) >= @fromdate AND  cast(tblSodoorFish.flddate as date)<=@toDate and cast(Drd.tblSodoorFish.flddate as  date) = @date
		order by  Drd.tblSodoorFish.fldId desc
		end
		else IF(@AzTarikh1 ='' AND @TaTarikh1='')
		begin
		set @date=com.ShamsiToMiladi(replace(@Value1,'%',''))
		SELECT   top(@h1)    Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
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
					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId1 ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
						,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
		FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

		FROM         Drd.tblSodoorFish INNER JOIN
							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId
		WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId) 
		AND fldOrganId=@OrganId1 and cast(Drd.tblSodoorFish.flddate as date) =@date
		order by  Drd.tblSodoorFish.fldId desc
		end
END




else IF(@fieldName1=N'fldShenasePardakht')
BEGIN
		IF(@AzTarikh1 <>'' AND @TaTarikh1='')
		begin
		set @fromdate=com.ShamsiToMiladi(@AzTarikh1)
		SELECT    top(@h1)   Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
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
					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId1 ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
						,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
		FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

		FROM         Drd.tblSodoorFish INNER JOIN
							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId
		WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId) AND fldOrganId=@OrganId1
		AND cast(tblSodoorFish.flddate as date)>=@fromdate and Drd.tblSodoorFish.fldShenasePardakht like @Value1
		order by  Drd.tblSodoorFish.fldId desc
		end
		else IF(@AzTarikh1 ='' AND @TaTarikh1<>'')
		begin
		set @toDate=com.ShamsiToMiladi(@TaTarikh1)
		SELECT    top(@h1)   Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
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
					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId1 ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
					,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
		FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

		FROM         Drd.tblSodoorFish INNER JOIN
							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId
		WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId) AND fldOrganId=@OrganId1
		AND cast(tblSodoorFish.flddate as date)<=@toDate and Drd.tblSodoorFish.fldShenasePardakht like @Value1
		order by  Drd.tblSodoorFish.fldId desc
		end
		else IF(@AzTarikh1 <>'' AND @TaTarikh1<>'')
		begin
		set @fromdate=com.ShamsiToMiladi(@AzTarikh1)
		set @toDate=com.ShamsiToMiladi(@TaTarikh1)
		SELECT    top(@h1)   Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
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
					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId1 ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
						,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
		FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

		FROM         Drd.tblSodoorFish INNER JOIN
							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId
		WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId) AND fldOrganId=@OrganId1
		AND cast(tblSodoorFish.flddate as date) >= @fromdate AND cast(tblSodoorFish.flddate as date)<=@toDate and Drd.tblSodoorFish.fldShenasePardakht like @Value1
		order by  Drd.tblSodoorFish.fldId desc
		end
		else IF(@AzTarikh1 ='' AND @TaTarikh1='')
		SELECT    top(@h1)   Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
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
					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId1 ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
						,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
		FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

		FROM         Drd.tblSodoorFish INNER JOIN
							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId
		WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId) AND fldOrganId=@OrganId1 
		and Drd.tblSodoorFish.fldShenasePardakht like @Value1  --and tblSodoorFish.fldTarikh like @Year+'%'
		order by  Drd.tblSodoorFish.fldId desc
END





else IF(@fieldName1=N'fldMablaghAvarezGerdShode')
BEGIN
		IF(@AzTarikh1 <>'' AND @TaTarikh1='')
		begin
		set @fromdate=com.ShamsiToMiladi(@AzTarikh1)
		SELECT    top(@h1)   Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
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
					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId1 ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
						,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
		FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

		FROM         Drd.tblSodoorFish INNER JOIN
							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId
		WHERE tblSodoorFish.fldId NOT IN (SELECT tblEbtal.fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId) AND fldOrganId=@OrganId1
		AND cast(tblSodoorFish.flddate as date)>=@fromdate and Drd.tblSodoorFish.fldMablaghAvarezGerdShode like @Value1
		order by  Drd.tblSodoorFish.fldId desc
		end
		else IF(@AzTarikh1 ='' AND @TaTarikh1<>'')
		begin
		set @toDate=com.ShamsiToMiladi(@TaTarikh1)
		SELECT   top(@h1)    Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
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
					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId1 ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
				,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
		FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

			FROM         Drd.tblSodoorFish INNER JOIN
							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId
		WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId) AND fldOrganId=@OrganId1
		AND cast(tblSodoorFish.flddate as date)<=@toDate and Drd.tblSodoorFish.fldMablaghAvarezGerdShode like @Value1
		order by  Drd.tblSodoorFish.fldId desc
		end
		else IF(@AzTarikh1 <>'' AND @TaTarikh1<>'')
		begin
		set @fromdate=com.ShamsiToMiladi(@AzTarikh1)
		set @toDate=com.ShamsiToMiladi(@TaTarikh1)
		SELECT    top(@h1)   Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
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
					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId1 ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
						,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
		FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

		FROM         Drd.tblSodoorFish INNER JOIN
							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId
		WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId) AND fldOrganId=@OrganId1
		AND cast(tblSodoorFish.flddate as date) >= @fromdate AND cast(tblSodoorFish.flddate as date)<=@toDate and Drd.tblSodoorFish.fldMablaghAvarezGerdShode like @Value1
		order by  Drd.tblSodoorFish.fldId desc
		end
		else IF(@AzTarikh1 ='' AND @TaTarikh1='')
		SELECT   top(@h1)    Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
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
					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId1 ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
						,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
		FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

		FROM         Drd.tblSodoorFish INNER JOIN
							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId
		WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId) AND fldOrganId=@OrganId1 
		and Drd.tblSodoorFish.fldMablaghAvarezGerdShode like @Value1 --and tblSodoorFish.fldTarikh like @Year+'%'
		order by  Drd.tblSodoorFish.fldId desc
END

else IF(@fieldName1=N'fldShorooShenaseGhabz')
BEGIN
		IF(@AzTarikh1 <>'' AND @TaTarikh1='')
		SELECT    top(@h1)   Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
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
					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId1 ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
			,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
		FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

		FROM         Drd.tblSodoorFish INNER JOIN
							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId
		WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId) AND fldOrganId=@OrganId1
		AND tblSodoorFish.fldTarikh>=@AzTarikh1 and Drd.tblSodoorFish.fldShorooShenaseGhabz like @Value1
		order by  Drd.tblSodoorFish.fldId desc

		else IF(@AzTarikh1 ='' AND @TaTarikh1<>'')
		SELECT   top(@h1)    Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
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
					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId1 ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
						,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
		FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

		FROM         Drd.tblSodoorFish INNER JOIN
							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId
		WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId) AND fldOrganId=@OrganId1
		AND tblSodoorFish.fldTarikh<=@TaTarikh1 and Drd.tblSodoorFish.fldShorooShenaseGhabz like @Value1
		order by  Drd.tblSodoorFish.fldId desc

		else IF(@AzTarikh1 <>'' AND @TaTarikh1<>'')
		SELECT   top(@h1)    Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
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
					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId1 ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
					,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
		FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

			FROM         Drd.tblSodoorFish INNER JOIN
							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId
		WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId) AND fldOrganId=@OrganId1
		AND tblSodoorFish.fldTarikh BETWEEN @AzTarikh1 AND @TaTarikh1 and Drd.tblSodoorFish.fldShorooShenaseGhabz like @Value1
		order by  Drd.tblSodoorFish.fldId desc

		else IF(@AzTarikh1 ='' AND @TaTarikh1='')
		SELECT   top(@h1)    Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
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
					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId1 ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
					,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
		FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

		FROM         Drd.tblSodoorFish INNER JOIN
							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId
                      
		WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId) AND fldOrganId=@OrganId1 
		and Drd.tblSodoorFish.fldShorooShenaseGhabz like @Value1 --and tblSodoorFish.fldTarikh like @Year+'%'
		order by  Drd.tblSodoorFish.fldId desc
END


else IF(@fieldName1=N'fldJamKol')
BEGIN
		IF(@AzTarikh1 <>'' AND @TaTarikh1='')
		SELECT    top(@h1)   Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
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
					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId1 ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
							,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
		FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

		FROM         Drd.tblSodoorFish INNER JOIN
							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId
		WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId) AND fldOrganId=@OrganId1
		AND tblSodoorFish.fldTarikh>=@AzTarikh1 and Drd.tblSodoorFish.fldJamKol like @Value1
		order by  Drd.tblSodoorFish.fldId desc

		else IF(@AzTarikh1 ='' AND @TaTarikh1<>'')
		SELECT   top(@h1)    Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
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
					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId1 ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
			,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
		FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

		FROM         Drd.tblSodoorFish INNER JOIN
							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId
		WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId) AND fldOrganId=@OrganId1
		AND tblSodoorFish.fldTarikh<=@TaTarikh1 and Drd.tblSodoorFish.fldJamKol like @Value1
		order by  Drd.tblSodoorFish.fldId desc

		else IF(@AzTarikh1 <>'' AND @TaTarikh1<>'')
		SELECT   top(@h1)    Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
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
					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId1 ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
			,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
					FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

		FROM         Drd.tblSodoorFish INNER JOIN
							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId
		WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId) AND fldOrganId=@OrganId1
		AND tblSodoorFish.fldTarikh BETWEEN @AzTarikh1 AND @TaTarikh1 and Drd.tblSodoorFish.fldJamKol like @Value1
		order by  Drd.tblSodoorFish.fldId desc

		else IF(@AzTarikh1 ='' AND @TaTarikh1='')
		SELECT    top(@h1)   Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
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
					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId1 ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
			,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
					FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

		FROM         Drd.tblSodoorFish INNER JOIN
							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId
		WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId) AND fldOrganId=@OrganId1 
		and Drd.tblSodoorFish.fldJamKol like @Value1 --and tblSodoorFish.fldTarikh like @Year+'%'
		order by  Drd.tblSodoorFish.fldId desc
END


else IF(@fieldName1=N'fldBarcode')
BEGIN
		IF(@AzTarikh1 <>'' AND @TaTarikh1='')
		SELECT   top(@h1)    Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
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
					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId1 ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
			,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
					FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

		FROM         Drd.tblSodoorFish INNER JOIN
							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId
		WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId) AND fldOrganId=@OrganId1
		AND tblSodoorFish.fldTarikh>=@AzTarikh1 and Drd.tblSodoorFish.fldBarcode like @Value1
		order by  Drd.tblSodoorFish.fldId desc

		else IF(@AzTarikh1 ='' AND @TaTarikh1<>'')
		SELECT    top(@h1)   Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
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
					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId1 ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
			,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
					FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

		FROM         Drd.tblSodoorFish INNER JOIN
							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId
		WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId) AND fldOrganId=@OrganId1
		AND tblSodoorFish.fldTarikh<=@TaTarikh1 and Drd.tblSodoorFish.fldBarcode like @Value1
		order by  Drd.tblSodoorFish.fldId desc

		else IF(@AzTarikh1 <>'' AND @TaTarikh1<>'')
		SELECT  top(@h1)     Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
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
					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId1 ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
			,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
					FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

		FROM         Drd.tblSodoorFish INNER JOIN
							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId
		WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId) AND fldOrganId=@OrganId1
		AND tblSodoorFish.fldTarikh BETWEEN @AzTarikh1 AND @TaTarikh1 and Drd.tblSodoorFish.fldBarcode like @Value1
		order by  Drd.tblSodoorFish.fldId desc

		else IF(@AzTarikh1 ='' AND @TaTarikh1='')
		SELECT    top(@h1)   Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
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
					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId1 ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
			,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
					FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

		FROM         Drd.tblSodoorFish INNER JOIN
							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId
		WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId) AND fldOrganId=@OrganId1 
		and Drd.tblSodoorFish.fldBarcode like @Value1 --and tblSodoorFish.fldTarikh like @Year+'%'
		order by  Drd.tblSodoorFish.fldId desc
END

else IF(@fieldName1=N'fldAshakhasID')
BEGIN
		IF(@AzTarikh1 <>'' AND @TaTarikh1='')
		SELECT    top(@h1)   Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
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
					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId1 ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
			,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
					FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

		FROM         Drd.tblSodoorFish INNER JOIN
							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId
		WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId) AND fldOrganId=@OrganId1
		AND tblSodoorFish.fldTarikh>=@AzTarikh1 and fldAshakhasID like @Value1
		order by  Drd.tblSodoorFish.fldId desc

		else IF(@AzTarikh1 ='' AND @TaTarikh1<>'')
		SELECT   top(@h1)    Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
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
					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId1 ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
			,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
					FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

		FROM         Drd.tblSodoorFish INNER JOIN
							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId
		WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId) AND fldOrganId=@OrganId1
		AND tblSodoorFish.fldTarikh<=@TaTarikh1 and fldAshakhasID like @Value1
		order by  Drd.tblSodoorFish.fldId desc

		else IF(@AzTarikh1 <>'' AND @TaTarikh1<>'')
		SELECT    top(@h1)   Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
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
					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId1 ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
			,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
					FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

		FROM         Drd.tblSodoorFish INNER JOIN
							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId
		WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId) AND fldOrganId=@OrganId1
		AND tblSodoorFish.fldTarikh BETWEEN @AzTarikh1 AND @TaTarikh1 and fldAshakhasID like @Value1
		order by  Drd.tblSodoorFish.fldId desc

		else IF(@AzTarikh1 ='' AND @TaTarikh1='')
		SELECT    top(@h1)   Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
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
					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId1 ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
			,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
					FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

		FROM         Drd.tblSodoorFish INNER JOIN
							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId
		WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId) AND fldOrganId=@OrganId1 
		and fldAshakhasID like @Value1 --and tblSodoorFish.fldTarikh like @Year+'%'
		order by  Drd.tblSodoorFish.fldId desc
END


else IF(@fieldName1=N'fldNameShakhs')
BEGIN
		IF(@AzTarikh1 <>'' AND @TaTarikh1='')
		begin
		set @fromdate=com.ShamsiToMiladi(@AzTarikh1)
		SELECT   TOP (@h1) * FROM(SELECT  Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
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
					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId1 ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
			,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
					FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

		FROM         Drd.tblSodoorFish INNER JOIN
							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId
		WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId) AND fldOrganId=@OrganId1
		AND cast(tblSodoorFish.flddate as date)>=@fromdate)AS t where fldNameShakhs like @Value1
		order by  fldId desc
		end
		else IF(@AzTarikh1 ='' AND @TaTarikh1<>'')
		begin
		set @toDate=com.ShamsiToMiladi(@TaTarikh1)
		SELECT   TOP (@h1) * FROM(SELECT  Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
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
					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId1 ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
			,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
					FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

		FROM         Drd.tblSodoorFish INNER JOIN
							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId
		WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId) AND fldOrganId=@OrganId1
		AND cast(tblSodoorFish.flddate as date)<=@toDate )as t where fldNameShakhs like @Value1
		order by  fldId desc
		end
		else IF(@AzTarikh1 <>'' AND @TaTarikh1<>'')
		begin
		SELECT    TOP (@h1) * FROM(SELECT Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
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
					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId1 ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
			,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
					FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

		FROM         Drd.tblSodoorFish INNER JOIN
							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId
		WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId) AND fldOrganId=@OrganId1
		AND cast(tblSodoorFish.flddate as date) >= @fromdate AND cast(tblSodoorFish.flddate as date)<=@toDate)as t where fldNameShakhs like @Value1
		order by  fldId desc
		end
		else IF(@AzTarikh1 ='' AND @TaTarikh1='')
		SELECT   TOP (@h1) * FROM(SELECT  Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
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
					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId1 ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
			,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
					FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

		FROM         Drd.tblSodoorFish INNER JOIN
							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId where fldOrganId=@OrganId1
							   /*and tblSodoorFish.fldTarikh like @Year+'%'*/)as t
		WHERE t.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=t.fldId)  and fldNameShakhs like @Value1

		order by  fldId desc
END




else IF(@fieldName1=N'fldNoeShakhs')
BEGIN
		IF(@AzTarikh1 <>'' AND @TaTarikh1='')
		SELECT   TOP (@h1) * FROM(SELECT  Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
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
					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId1 ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
			,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
					FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

		FROM         Drd.tblSodoorFish INNER JOIN
							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId
		WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId) AND fldOrganId=@OrganId1
		AND tblSodoorFish.fldTarikh>=@AzTarikh1)AS t where fldNoeShakhs like @Value1
		order by  fldId desc

		else IF(@AzTarikh1 ='' AND @TaTarikh1<>'')
		SELECT   TOP (@h1) * FROM(SELECT  Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
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
					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId1 ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
			,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
					FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

		FROM         Drd.tblSodoorFish INNER JOIN
							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId
		WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId) AND fldOrganId=@OrganId1
		AND tblSodoorFish.fldTarikh<=@TaTarikh1 )as t where fldNoeShakhs like @Value1
		order by  fldId desc

		else IF(@AzTarikh1 <>'' AND @TaTarikh1<>'')
		SELECT    TOP (@h1) * FROM(SELECT Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
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
					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId1 ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
			,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
					FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

		FROM         Drd.tblSodoorFish INNER JOIN
							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId
		WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId) AND fldOrganId=@OrganId1
		AND tblSodoorFish.fldTarikh BETWEEN @AzTarikh1 AND @TaTarikh1)as t where fldNoeShakhs like @Value1
		order by  fldId desc

		else IF(@AzTarikh1 ='' AND @TaTarikh1='')
		SELECT   TOP (@h1) * FROM(SELECT  Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
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
					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId1 ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
			,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
					FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

		FROM         Drd.tblSodoorFish INNER JOIN
							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId  where fldOrganId=@OrganId1
							   /*and tblSodoorFish.fldTarikh like @Year+'%'*/)as t
		WHERE t.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=t.fldId)  and fldNoeShakhs like @Value1 
		order by  fldId desc
END




else IF(@fieldName1=N'fldFather_ShomareSabt')
BEGIN
		IF(@AzTarikh1 <>'' AND @TaTarikh1='')
		SELECT   TOP (@h1) * FROM(SELECT  Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
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
					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId1 ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
			,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
					FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

		FROM         Drd.tblSodoorFish INNER JOIN
							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId
		WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId) AND fldOrganId=@OrganId1
		AND tblSodoorFish.fldTarikh>=@AzTarikh1 )AS t where fldFather_ShomareSabt like @Value1
		order by  fldId desc 

		else IF(@AzTarikh1 ='' AND @TaTarikh1<>'')
		SELECT   TOP (@h1) * FROM(SELECT  Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
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
					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId1 ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
						,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
					FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

		FROM         Drd.tblSodoorFish INNER JOIN
							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId
		WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId) AND fldOrganId=@OrganId1
		AND tblSodoorFish.fldTarikh<=@TaTarikh1)as t where  fldFather_ShomareSabt like @Value1
		order by  fldId desc

		else IF(@AzTarikh1 <>'' AND @TaTarikh1<>'')
		SELECT    TOP (@h1) * FROM(SELECT Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
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
					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId1 ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
						,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
					FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

		FROM         Drd.tblSodoorFish INNER JOIN
							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId
		WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId) AND fldOrganId=@OrganId1
		AND tblSodoorFish.fldTarikh BETWEEN @AzTarikh1 AND @TaTarikh1 )as t where fldFather_ShomareSabt like @Value1
		order by fldId desc

		else IF(@AzTarikh1 ='' AND @TaTarikh1='')
		SELECT   TOP (@h1) * FROM(SELECT  Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
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
					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId1 ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
				,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
					FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

		FROM         Drd.tblSodoorFish INNER JOIN
							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId where fldOrganId=@OrganId1 
							  /*and tblSodoorFish.fldTarikh like @Year+'%'*/)as t
		WHERE t.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=t.fldId)  and fldFather_ShomareSabt like @Value1
		order by  fldId desc
END





else IF(@fieldName1=N'fldTypeAvarez')
BEGIN
		IF(@AzTarikh1 <>'' AND @TaTarikh1='')
		SELECT   TOP (@h1) * FROM(SELECT  Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
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
					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId1 ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
							,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
					FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

		FROM         Drd.tblSodoorFish INNER JOIN
							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId
		WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId) AND fldOrganId=@OrganId1
		AND tblSodoorFish.fldTarikh>=@AzTarikh1)AS t where fldTypeAvarez like @Value1
		order by  fldId desc

		else IF(@AzTarikh1 ='' AND @TaTarikh1<>'')
		SELECT   TOP (@h1) * FROM(SELECT  Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
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
					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId1 ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
						,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
					FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

		FROM         Drd.tblSodoorFish INNER JOIN
							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId
		WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId) AND fldOrganId=@OrganId1
		AND tblSodoorFish.fldTarikh<=@TaTarikh1)as t where fldTypeAvarez like @Value1
		order by  fldId desc

		else IF(@AzTarikh1 <>'' AND @TaTarikh1<>'')
		SELECT    TOP (@h1) * FROM(SELECT Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
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
					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId1 ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
						,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
					FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

		FROM         Drd.tblSodoorFish INNER JOIN
							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId
		WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId) AND fldOrganId=@OrganId1
		AND tblSodoorFish.fldTarikh BETWEEN @AzTarikh1 AND @TaTarikh1 )as t where fldTypeAvarez like @Value1
		order by  fldId desc

		else IF(@AzTarikh1 ='' AND @TaTarikh1='')
		SELECT   TOP (@h1) * FROM(SELECT  Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
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
					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId1 ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
						,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
					FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

		FROM         Drd.tblSodoorFish INNER JOIN
							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId where fldOrganId=@OrganId1
							   /*and tblSodoorFish.fldTarikh like @Year+'%'*/)as t
		WHERE t.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=t.fldId) AND  fldTypeAvarez like @Value1
		order by  fldId desc
END





else IF(@fieldName1=N'fldNationalCode')
BEGIN
		IF(@AzTarikh1 <>'' AND @TaTarikh1='')
		begin
		set @fromdate=com.ShamsiToMiladi(@AzTarikh1)
		SELECT   TOP (@h1) * FROM(SELECT  Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
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
					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId1 ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
						,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
					FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

		FROM         Drd.tblSodoorFish INNER JOIN
							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId
		WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId) AND fldOrganId=@OrganId1
		AND cast(tblSodoorFish.flddate as date)>=@fromdate)AS t where fldNationalCode like @Value1
		order by  fldId desc
		end
		else IF(@AzTarikh1 ='' AND @TaTarikh1<>'')
		begin
		set @toDate=com.ShamsiToMiladi(@TaTarikh1)
		SELECT   TOP (@h1) * FROM(SELECT  Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
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
					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId1 ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
						,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
					FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

		FROM         Drd.tblSodoorFish INNER JOIN
							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId
		WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId) AND fldOrganId=@OrganId1
		AND cast(tblSodoorFish.flddate as date)<=@toDate)as t where fldNationalCode like @Value1
		order by  fldId desc
		end
		else IF(@AzTarikh1 <>'' AND @TaTarikh1<>'')
		begin
		set @fromdate=com.ShamsiToMiladi(@AzTarikh1)
		set @toDate=com.ShamsiToMiladi(@TaTarikh1)
		SELECT    TOP (@h1) * FROM(SELECT Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
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
					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId1 ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
						,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
					FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

		FROM         Drd.tblSodoorFish INNER JOIN
							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId
		WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId) AND fldOrganId=@OrganId1
		AND cast(tblSodoorFish.flddate as date)>= @fromdate AND cast(tblSodoorFish.flddate as date)<=@toDate )as t where fldNationalCode like @Value1
		order by  fldId desc
		end
		else IF(@AzTarikh1 ='' AND @TaTarikh1='')
		SELECT   TOP (@h1) * FROM(SELECT  Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
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
					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId1 ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
						,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
					FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

		FROM         Drd.tblSodoorFish INNER JOIN
							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId where fldOrganId=@OrganId1
							   /*and tblSodoorFish.fldTarikh like @Year+'%'*/)as t
		WHERE t.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=t.fldId) AND  fldNationalCode like @Value1
		order by  fldId desc
END



else IF(@fieldName1=N'fldMashmool')
BEGIN
		IF(@AzTarikh1 <>'' AND @TaTarikh1='')
		SELECT   TOP (@h1) * FROM(SELECT  Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
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
					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId1 ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
						,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
					FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

		FROM         Drd.tblSodoorFish INNER JOIN
							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId
		WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId) AND fldOrganId=@OrganId1
		AND tblSodoorFish.fldTarikh>=@AzTarikh1 )AS t where fldMashmool like @Value1
		order by  fldId desc

		else IF(@AzTarikh1 ='' AND @TaTarikh1<>'')
		SELECT   TOP (@h1) * FROM(SELECT  Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
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
					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId1 ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
						,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
					FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

		FROM         Drd.tblSodoorFish INNER JOIN
							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId
		WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId) AND fldOrganId=@OrganId1
		AND tblSodoorFish.fldTarikh<=@TaTarikh1 )as t where fldMashmool like @Value1
		order by fldId desc

		else IF(@AzTarikh1 <>'' AND @TaTarikh1<>'')
		SELECT    TOP (@h1) * FROM(SELECT Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
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
					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId1 ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
						,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
					FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

		FROM         Drd.tblSodoorFish INNER JOIN
							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId
		WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId) AND fldOrganId=@OrganId1
		AND tblSodoorFish.fldTarikh BETWEEN @AzTarikh1 AND @TaTarikh1 )as t where fldMashmool like @Value1
		order by  fldId desc

		else IF(@AzTarikh1 ='' AND @TaTarikh1='')
		SELECT   TOP (@h1) * FROM(SELECT  Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
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
					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId1 ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
						,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
					FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

		FROM         Drd.tblSodoorFish INNER JOIN
							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId where fldOrganId=@OrganId1
							   /*and tblSodoorFish.fldTarikh like @Year+'%'*/)as t
		WHERE t.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=t.fldId) AND  fldMashmool like @Value1
		order by  fldId desc
END





else IF(@fieldName1=N'fldPardakhFish')
BEGIN
		IF(@AzTarikh1 <>'' AND @TaTarikh1='')
		begin
		set @fromdate=com.ShamsiToMiladi(@AzTarikh1)
		SELECT   TOP (@h1) * FROM(SELECT  Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
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
					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId1 ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
						,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
					FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

		FROM         Drd.tblSodoorFish INNER JOIN
							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId
		WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId) AND fldOrganId=@OrganId1
		AND cast(tblSodoorFish.flddate as date)>=@fromdate )AS t where fldPardakhFish like @Value1
		order by  fldId desc
		end
		else IF(@AzTarikh1 ='' AND @TaTarikh1<>'')
		begin
		set @toDate=com.ShamsiToMiladi(@TaTarikh1)
		SELECT   TOP (@h1) * FROM(SELECT  Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
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
					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId1 ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
						,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
					FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

		FROM         Drd.tblSodoorFish INNER JOIN
							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId
		WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId) AND fldOrganId=@OrganId1
		AND cast(tblSodoorFish.flddate as date)<=@toDate )as t where fldPardakhFish like @Value1
		order by  fldId desc
		end
		else IF(@AzTarikh1 <>'' AND @TaTarikh1<>'')
		begin
		set @fromdate=com.ShamsiToMiladi(@AzTarikh1)
		set @toDate=com.ShamsiToMiladi(@TaTarikh1)
		SELECT    TOP (@h1) * FROM(SELECT Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
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
					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId1 ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
						,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
					FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

		FROM         Drd.tblSodoorFish INNER JOIN
							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId
		WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId) AND fldOrganId=@OrganId1
		AND cast(tblSodoorFish.flddate as date) >= @AzTarikh1 AND cast(tblSodoorFish.flddate as date)<=@toDate )as t where fldPardakhFish like @Value1
		order by  fldId desc
		end
		else IF(@AzTarikh1 ='' AND @TaTarikh1='')
		SELECT   TOP (@h1) * FROM(SELECT  Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
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
					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId1 ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
						,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
					FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

		FROM         Drd.tblSodoorFish INNER JOIN
							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId where  fldOrganId=@OrganId1
							   /*and tblSodoorFish.fldTarikh like @Year+'%'*/)as t
		WHERE t.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=t.fldId) AND  fldPardakhFish like @Value1
		order by  fldId desc
END




else IF(@fieldName1=N'fldPcposUser')
BEGIN
		IF(@AzTarikh1 <>'' AND @TaTarikh1='')
		SELECT   TOP (@h1) * FROM(SELECT  Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
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
					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId1 ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
						,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
					FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

		FROM         Drd.tblSodoorFish INNER JOIN
							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId
		WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId) AND fldOrganId=@OrganId1
		AND tblSodoorFish.fldTarikh>=@AzTarikh1 )AS t where fldPcposUser like @Value1
		order by  fldId desc

		else IF(@AzTarikh1 ='' AND @TaTarikh1<>'')
		SELECT   TOP (@h1) * FROM(SELECT  Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
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
					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId1 ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
					,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
					FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

		FROM         Drd.tblSodoorFish INNER JOIN
							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId
		WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId) AND fldOrganId=@OrganId1
		AND tblSodoorFish.fldTarikh<=@TaTarikh1 )as t where fldPcposUser like @Value1
		order by  fldId desc

		else IF(@AzTarikh1 <>'' AND @TaTarikh1<>'')
		SELECT    TOP (@h1) * FROM(SELECT Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
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
					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId1 ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
		,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
					FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

		FROM         Drd.tblSodoorFish INNER JOIN
							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId
		WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId) AND fldOrganId=@OrganId1
		AND tblSodoorFish.fldTarikh BETWEEN @AzTarikh1 AND @TaTarikh1 )as t where fldPcposUser like @Value1
		order by  fldId desc

		else IF(@AzTarikh1 ='' AND @TaTarikh1='')
		SELECT   TOP (@h1) * FROM(SELECT  Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
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
					,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId1 ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
		,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
					,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
					,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
					FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

		FROM         Drd.tblSodoorFish INNER JOIN
							  Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId where fldOrganId=@OrganId1
							   /*and tblSodoorFish.fldTarikh like @Year+'%'*/)as t
		WHERE t.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=t.fldId) AND  fldPcposUser like @Value1
		order by  fldId desc
END

else IF (@fieldName1='PcPos')
SELECT   top(@h1)    Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldElamAvarezId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
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
			,ISNULL((SELECT COUNT(fldPspId) FROM Drd.tblPcPosInfo WHERE fldId IN (SELECT fldPcPosInfoId FROM Drd.tblPcPosIP WHERE fldId IN (SELECT fldPosIpId FROM Drd.tblPcPosUser WHERE fldIdUser=@UserId1 ) AND fldOrganId=tblElamAvarez.fldOrganId)),0) AS fldPcposUser
			,(SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareHesab
			,(SELECT fldShomareSheba FROM Com.tblShomareHesabeOmoomi WHERE fldid= Drd.tblSodoorFish.fldShomareHesabId)fldShomareSheba
			,ISNULL((SELECT    Drd.tblPardakhtFish.fldTarikh
			FROM         Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId),N'')AS fldTarikhPardakhFish

FROM         Drd.tblSodoorFish INNER JOIN
                      Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId
WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId) AND fldOrganId=@OrganId1
AND fldElamAvarezId=@Value1 AND  Drd.tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldId)
commit
GO
