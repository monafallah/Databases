SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_DataForElamAvarez_Check]
@value  nvarchar(50),
@fieldname nvarchar(50),
@AzTarikh NVARCHAR(10),
@TaTarikh NVARCHAR(10),
--@FiscalYearId int,
@h INT,
@Organid INT
AS
BEGIN TRAN
if (@h=0) set @h=2147483647
--declare  @Year varchar(4)

--select @Year=fldYear from acc.tblFiscalYear where fldId=@FiscalYearId
IF (@fieldname=N'Ejra')
BEGIN
IF(@AzTarikh <>'' AND @TaTarikh<>'')
SELECT TOP(@h) Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ), 0) AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
                      CAST(0 AS TINYINT)) AS fldStatus, ISNULL(Drd.tblCheck.fldShomareHesabId, 0) AS fldShomareHesabId, 0 AS fldBaratDarId, 
                      CASE WHEN fldTypeSanad = 0 THEN CAST(2 AS TINYINT) ELSE CAST(6 AS TINYINT) END AS fldTypeSanad, '' AS fldMakanPardakht, Drd.tblCheck.fldUserId, 
                      Drd.tblCheck.fldDesc, Drd.tblCheck.fldDate, CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, 
                      ISNULL((CASE WHEN fldStatus = 1 THEN N'در انتظار وصول' WHEN fldStatus = 2 THEN N'وصول شده' WHEN fldStatus = 3 THEN N'برگشت خورده' WHEN fldStatus = 4 THEN
                       N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END), '') AS fldStatusName, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblBank.fldBankName, 
                      Com.tblSHobe.fldBankId, Com.tblSHobe.fldName AS fldNameShobe, Com.tblShomareHesabeOmoomi.fldShobeId, '' AS fldNameBaratDar, '' AS fldStatusFish, 
                      '' AS fldStatusFishId, NULL AS fldFishId, Drd.tblCheck.fldShomareHesabIdOrgan, tblShomareHesabeOmoomi_1.fldShomareHesab AS fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,tblCheck.fldTarikhAkhz,fldDateStatus,com.fn_NameAshkhasHaghighi_Hoghoghi(Drd.tblCheck.fldAshkhasId) as fldNameSaderkonandeCheck
FROM         Drd.tblCheck INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId

WHERE fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND fldTarikhSarResid BETWEEN @AzTarikh AND @TaTarikh
order by fldTarikhSarResid

ELSE IF(@AzTarikh <>'' AND @TaTarikh='')
SELECT  TOP(@h) Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ), 0) AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
                      CAST(0 AS TINYINT)) AS fldStatus, ISNULL(Drd.tblCheck.fldShomareHesabId, 0) AS fldShomareHesabId, 0 AS fldBaratDarId, 
                      CASE WHEN fldTypeSanad = 0 THEN CAST(2 AS TINYINT) ELSE CAST(6 AS TINYINT) END AS fldTypeSanad, '' AS fldMakanPardakht, Drd.tblCheck.fldUserId, 
                      Drd.tblCheck.fldDesc, Drd.tblCheck.fldDate, CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, 
                      ISNULL((CASE WHEN fldStatus = 1 THEN N'در انتظار وصول' WHEN fldStatus = 2 THEN N'وصول شده' WHEN fldStatus = 3 THEN N'برگشت خورده' WHEN fldStatus = 4 THEN
                       N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END), '') AS fldStatusName, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblBank.fldBankName, 
                      Com.tblSHobe.fldBankId, Com.tblSHobe.fldName AS fldNameShobe, Com.tblShomareHesabeOmoomi.fldShobeId, '' AS fldNameBaratDar, '' AS fldStatusFish, 
                      '' AS fldStatusFishId, NULL AS fldFishId, Drd.tblCheck.fldShomareHesabIdOrgan, tblShomareHesabeOmoomi_1.fldShomareHesab AS fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,tblCheck.fldTarikhAkhz,fldDateStatus ,com.fn_NameAshkhasHaghighi_Hoghoghi(Drd.tblCheck.fldAshkhasId) as fldNameSaderkonandeCheck
FROM         Drd.tblCheck INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId

WHERE fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND fldTarikhSarResid >= @AzTarikh 
order by fldTarikhSarResid

ELSE IF(@AzTarikh ='' AND @TaTarikh<>'')
SELECT  TOP(@h) Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ), 0) AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
                      CAST(0 AS TINYINT)) AS fldStatus, ISNULL(Drd.tblCheck.fldShomareHesabId, 0) AS fldShomareHesabId, 0 AS fldBaratDarId, 
                      CASE WHEN fldTypeSanad = 0 THEN CAST(2 AS TINYINT) ELSE CAST(6 AS TINYINT) END AS fldTypeSanad, '' AS fldMakanPardakht, Drd.tblCheck.fldUserId, 
                      Drd.tblCheck.fldDesc, Drd.tblCheck.fldDate, CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, 
                      ISNULL((CASE WHEN fldStatus = 1 THEN N'در انتظار وصول' WHEN fldStatus = 2 THEN N'وصول شده' WHEN fldStatus = 3 THEN N'برگشت خورده' WHEN fldStatus = 4 THEN
                       N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END), '') AS fldStatusName, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblBank.fldBankName, 
                      Com.tblSHobe.fldBankId, Com.tblSHobe.fldName AS fldNameShobe, Com.tblShomareHesabeOmoomi.fldShobeId, '' AS fldNameBaratDar, '' AS fldStatusFish, 
                      '' AS fldStatusFishId, NULL AS fldFishId, Drd.tblCheck.fldShomareHesabIdOrgan, tblShomareHesabeOmoomi_1.fldShomareHesab AS fldShomareHesabOrgan

,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,tblCheck.fldTarikhAkhz,fldDateStatus,com.fn_NameAshkhasHaghighi_Hoghoghi(Drd.tblCheck.fldAshkhasId) as fldNameSaderkonandeCheck
FROM         Drd.tblCheck INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId


WHERE fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND fldTarikhSarResid <= @TaTarikh
order by fldTarikhSarResid

ELSE 

SELECT  TOP(@h) Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ), 0) AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
                      CAST(0 AS TINYINT)) AS fldStatus, ISNULL(Drd.tblCheck.fldShomareHesabId, 0) AS fldShomareHesabId, 0 AS fldBaratDarId, 
                      CASE WHEN fldTypeSanad = 0 THEN CAST(2 AS TINYINT) ELSE CAST(6 AS TINYINT) END AS fldTypeSanad, '' AS fldMakanPardakht, Drd.tblCheck.fldUserId, 
                      Drd.tblCheck.fldDesc, Drd.tblCheck.fldDate, CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, 
                      ISNULL((CASE WHEN fldStatus = 1 THEN N'در انتظار وصول' WHEN fldStatus = 2 THEN N'وصول شده' WHEN fldStatus = 3 THEN N'برگشت خورده' WHEN fldStatus = 4 THEN
                       N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END), '') AS fldStatusName, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblBank.fldBankName, 
                      Com.tblSHobe.fldBankId, Com.tblSHobe.fldName AS fldNameShobe, Com.tblShomareHesabeOmoomi.fldShobeId, '' AS fldNameBaratDar, '' AS fldStatusFish, 
                      '' AS fldStatusFishId, NULL AS fldFishId, Drd.tblCheck.fldShomareHesabIdOrgan, tblShomareHesabeOmoomi_1.fldShomareHesab AS fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,tblCheck.fldTarikhAkhz,fldDateStatus,com.fn_NameAshkhasHaghighi_Hoghoghi(Drd.tblCheck.fldAshkhasId) as fldNameSaderkonandeCheck
FROM         Drd.tblCheck INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId
WHERE fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
 --and fldTarikhSarResid like @Year+'%'
order by fldTarikhSarResid

END

IF (@fieldname=N'Ejra_fldShomareSanad')
BEGIN
IF(@AzTarikh <>'' AND @TaTarikh<>'')
SELECT TOP(@h)  * FROM (SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ), 0) AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
                      CAST(0 AS TINYINT)) AS fldStatus, ISNULL(Drd.tblCheck.fldShomareHesabId, 0) AS fldShomareHesabId, 0 AS fldBaratDarId, 
                      CASE WHEN fldTypeSanad = 0 THEN CAST(2 AS TINYINT) ELSE CAST(6 AS TINYINT) END AS fldTypeSanad, '' AS fldMakanPardakht, Drd.tblCheck.fldUserId, 
                      Drd.tblCheck.fldDesc, Drd.tblCheck.fldDate, CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, 
                      ISNULL((CASE WHEN fldStatus = 1 THEN N'در انتظار وصول' WHEN fldStatus = 2 THEN N'وصول شده' WHEN fldStatus = 3 THEN N'برگشت خورده' WHEN fldStatus = 4 THEN
                       N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END), '') AS fldStatusName, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblBank.fldBankName, 
                      Com.tblSHobe.fldBankId, Com.tblSHobe.fldName AS fldNameShobe, Com.tblShomareHesabeOmoomi.fldShobeId, '' AS fldNameBaratDar, '' AS fldStatusFish, 
                      '' AS fldStatusFishId, NULL AS fldFishId, Drd.tblCheck.fldShomareHesabIdOrgan, tblShomareHesabeOmoomi_1.fldShomareHesab AS fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,tblCheck.fldTarikhAkhz,fldDateStatus,com.fn_NameAshkhasHaghighi_Hoghoghi(Drd.tblCheck.fldAshkhasId) as fldNameSaderkonandeCheck
FROM         Drd.tblCheck INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId
)t
WHERE fldShomareSanad LIKE @value and fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND t.fldTarikhSarResid BETWEEN @AzTarikh AND @TaTarikh
order by fldTarikhSarResid

IF(@AzTarikh <>'' AND @TaTarikh='')
SELECT TOP(@h)  * FROM (SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ), 0) AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
                      CAST(0 AS TINYINT)) AS fldStatus, ISNULL(Drd.tblCheck.fldShomareHesabId, 0) AS fldShomareHesabId, 0 AS fldBaratDarId, 
                      CASE WHEN fldTypeSanad = 0 THEN CAST(2 AS TINYINT) ELSE CAST(6 AS TINYINT) END AS fldTypeSanad, '' AS fldMakanPardakht, Drd.tblCheck.fldUserId, 
                      Drd.tblCheck.fldDesc, Drd.tblCheck.fldDate, CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, 
                      ISNULL((CASE WHEN fldStatus = 1 THEN N'در انتظار وصول' WHEN fldStatus = 2 THEN N'وصول شده' WHEN fldStatus = 3 THEN N'برگشت خورده' WHEN fldStatus = 4 THEN
                       N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END), '') AS fldStatusName, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblBank.fldBankName, 
                      Com.tblSHobe.fldBankId, Com.tblSHobe.fldName AS fldNameShobe, Com.tblShomareHesabeOmoomi.fldShobeId, '' AS fldNameBaratDar, '' AS fldStatusFish, 
                      '' AS fldStatusFishId, NULL AS fldFishId, Drd.tblCheck.fldShomareHesabIdOrgan, tblShomareHesabeOmoomi_1.fldShomareHesab AS fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,tblCheck.fldTarikhAkhz,fldDateStatus,com.fn_NameAshkhasHaghighi_Hoghoghi(Drd.tblCheck.fldAshkhasId) as fldNameSaderkonandeCheck
FROM         Drd.tblCheck INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId
)t
WHERE fldShomareSanad LIKE @value and  fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND t.fldTarikhSarResid >= @AzTarikh 
order by fldTarikhSarResid

IF(@AzTarikh ='' AND @TaTarikh<>'')
SELECT TOP(@h)  * FROM (SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ), 0) AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
                      CAST(0 AS TINYINT)) AS fldStatus, ISNULL(Drd.tblCheck.fldShomareHesabId, 0) AS fldShomareHesabId, 0 AS fldBaratDarId, 
                      CASE WHEN fldTypeSanad = 0 THEN CAST(2 AS TINYINT) ELSE CAST(6 AS TINYINT) END AS fldTypeSanad, '' AS fldMakanPardakht, Drd.tblCheck.fldUserId, 
                      Drd.tblCheck.fldDesc, Drd.tblCheck.fldDate, CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, 
                      ISNULL((CASE WHEN fldStatus = 1 THEN N'در انتظار وصول' WHEN fldStatus = 2 THEN N'وصول شده' WHEN fldStatus = 3 THEN N'برگشت خورده' WHEN fldStatus = 4 THEN
                       N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END), '') AS fldStatusName, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblBank.fldBankName, 
                      Com.tblSHobe.fldBankId, Com.tblSHobe.fldName AS fldNameShobe, Com.tblShomareHesabeOmoomi.fldShobeId, '' AS fldNameBaratDar, '' AS fldStatusFish, 
                      '' AS fldStatusFishId, NULL AS fldFishId, Drd.tblCheck.fldShomareHesabIdOrgan, tblShomareHesabeOmoomi_1.fldShomareHesab AS fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,tblCheck.fldTarikhAkhz,fldDateStatus,com.fn_NameAshkhasHaghighi_Hoghoghi(Drd.tblCheck.fldAshkhasId) as fldNameSaderkonandeCheck
FROM         Drd.tblCheck INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId

)t
WHERE fldShomareSanad LIKE @value and  fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND t.fldTarikhSarResid <= @TaTarikh
order by fldTarikhSarResid

IF(@AzTarikh ='' AND @TaTarikh='')
SELECT TOP(@h)  * FROM (SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ), 0) AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
                      CAST(0 AS TINYINT)) AS fldStatus, ISNULL(Drd.tblCheck.fldShomareHesabId, 0) AS fldShomareHesabId, 0 AS fldBaratDarId, 
                      CASE WHEN fldTypeSanad = 0 THEN CAST(2 AS TINYINT) ELSE CAST(6 AS TINYINT) END AS fldTypeSanad, '' AS fldMakanPardakht, Drd.tblCheck.fldUserId, 
                      Drd.tblCheck.fldDesc, Drd.tblCheck.fldDate, CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, 
                      ISNULL((CASE WHEN fldStatus = 1 THEN N'در انتظار وصول' WHEN fldStatus = 2 THEN N'وصول شده' WHEN fldStatus = 3 THEN N'برگشت خورده' WHEN fldStatus = 4 THEN
                       N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END), '') AS fldStatusName, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblBank.fldBankName, 
                      Com.tblSHobe.fldBankId, Com.tblSHobe.fldName AS fldNameShobe, Com.tblShomareHesabeOmoomi.fldShobeId, '' AS fldNameBaratDar, '' AS fldStatusFish, 
                      '' AS fldStatusFishId, NULL AS fldFishId, Drd.tblCheck.fldShomareHesabIdOrgan, tblShomareHesabeOmoomi_1.fldShomareHesab AS fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,tblCheck.fldTarikhAkhz,fldDateStatus,com.fn_NameAshkhasHaghighi_Hoghoghi(Drd.tblCheck.fldAshkhasId) as fldNameSaderkonandeCheck
FROM         Drd.tblCheck INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId

)t
WHERE fldShomareSanad LIKE @value and  fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
 --and fldTarikhSarResid like @Year+'%'
order by fldTarikhSarResid

END




IF (@fieldname=N'Ejra_fldDateStatus')
BEGIN
IF(@AzTarikh <>'' AND @TaTarikh<>'')
SELECT TOP(@h)  * FROM (SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ), 0) AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
                      CAST(0 AS TINYINT)) AS fldStatus, ISNULL(Drd.tblCheck.fldShomareHesabId, 0) AS fldShomareHesabId, 0 AS fldBaratDarId, 
                      CASE WHEN fldTypeSanad = 0 THEN CAST(2 AS TINYINT) ELSE CAST(6 AS TINYINT) END AS fldTypeSanad, '' AS fldMakanPardakht, Drd.tblCheck.fldUserId, 
                      Drd.tblCheck.fldDesc, Drd.tblCheck.fldDate, CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, 
                      ISNULL((CASE WHEN fldStatus = 1 THEN N'در انتظار وصول' WHEN fldStatus = 2 THEN N'وصول شده' WHEN fldStatus = 3 THEN N'برگشت خورده' WHEN fldStatus = 4 THEN
                       N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END), '') AS fldStatusName, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblBank.fldBankName, 
                      Com.tblSHobe.fldBankId, Com.tblSHobe.fldName AS fldNameShobe, Com.tblShomareHesabeOmoomi.fldShobeId, '' AS fldNameBaratDar, '' AS fldStatusFish, 
                      '' AS fldStatusFishId, NULL AS fldFishId, Drd.tblCheck.fldShomareHesabIdOrgan, tblShomareHesabeOmoomi_1.fldShomareHesab AS fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,tblCheck.fldTarikhAkhz,fldDateStatus,com.fn_NameAshkhasHaghighi_Hoghoghi(Drd.tblCheck.fldAshkhasId) as fldNameSaderkonandeCheck
FROM         Drd.tblCheck INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId
)t
WHERE fldDateStatus LIKE @value and fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND t.fldTarikhSarResid BETWEEN @AzTarikh AND @TaTarikh
order by fldTarikhSarResid

IF(@AzTarikh <>'' AND @TaTarikh='')
SELECT TOP(@h)  * FROM (SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ), 0) AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
                      CAST(0 AS TINYINT)) AS fldStatus, ISNULL(Drd.tblCheck.fldShomareHesabId, 0) AS fldShomareHesabId, 0 AS fldBaratDarId, 
                      CASE WHEN fldTypeSanad = 0 THEN CAST(2 AS TINYINT) ELSE CAST(6 AS TINYINT) END AS fldTypeSanad, '' AS fldMakanPardakht, Drd.tblCheck.fldUserId, 
                      Drd.tblCheck.fldDesc, Drd.tblCheck.fldDate, CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, 
                      ISNULL((CASE WHEN fldStatus = 1 THEN N'در انتظار وصول' WHEN fldStatus = 2 THEN N'وصول شده' WHEN fldStatus = 3 THEN N'برگشت خورده' WHEN fldStatus = 4 THEN
                       N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END), '') AS fldStatusName, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblBank.fldBankName, 
                      Com.tblSHobe.fldBankId, Com.tblSHobe.fldName AS fldNameShobe, Com.tblShomareHesabeOmoomi.fldShobeId, '' AS fldNameBaratDar, '' AS fldStatusFish, 
                      '' AS fldStatusFishId, NULL AS fldFishId, Drd.tblCheck.fldShomareHesabIdOrgan, tblShomareHesabeOmoomi_1.fldShomareHesab AS fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,tblCheck.fldTarikhAkhz,fldDateStatus,com.fn_NameAshkhasHaghighi_Hoghoghi(Drd.tblCheck.fldAshkhasId) as fldNameSaderkonandeCheck
FROM         Drd.tblCheck INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId
)t
WHERE fldDateStatus LIKE @value and  fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND t.fldTarikhSarResid >= @AzTarikh 
order by fldTarikhSarResid

IF(@AzTarikh ='' AND @TaTarikh<>'')
SELECT TOP(@h)  * FROM (SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ), 0) AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
                      CAST(0 AS TINYINT)) AS fldStatus, ISNULL(Drd.tblCheck.fldShomareHesabId, 0) AS fldShomareHesabId, 0 AS fldBaratDarId, 
                      CASE WHEN fldTypeSanad = 0 THEN CAST(2 AS TINYINT) ELSE CAST(6 AS TINYINT) END AS fldTypeSanad, '' AS fldMakanPardakht, Drd.tblCheck.fldUserId, 
                      Drd.tblCheck.fldDesc, Drd.tblCheck.fldDate, CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, 
                      ISNULL((CASE WHEN fldStatus = 1 THEN N'در انتظار وصول' WHEN fldStatus = 2 THEN N'وصول شده' WHEN fldStatus = 3 THEN N'برگشت خورده' WHEN fldStatus = 4 THEN
                       N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END), '') AS fldStatusName, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblBank.fldBankName, 
                      Com.tblSHobe.fldBankId, Com.tblSHobe.fldName AS fldNameShobe, Com.tblShomareHesabeOmoomi.fldShobeId, '' AS fldNameBaratDar, '' AS fldStatusFish, 
                      '' AS fldStatusFishId, NULL AS fldFishId, Drd.tblCheck.fldShomareHesabIdOrgan, tblShomareHesabeOmoomi_1.fldShomareHesab AS fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,tblCheck.fldTarikhAkhz,fldDateStatus,com.fn_NameAshkhasHaghighi_Hoghoghi(Drd.tblCheck.fldAshkhasId) as fldNameSaderkonandeCheck
FROM         Drd.tblCheck INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId

)t
WHERE fldDateStatus LIKE @value and  fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND t.fldTarikhSarResid <= @TaTarikh
order by fldTarikhSarResid

IF(@AzTarikh ='' AND @TaTarikh='')
SELECT TOP(@h)  * FROM (SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ), 0) AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
                      CAST(0 AS TINYINT)) AS fldStatus, ISNULL(Drd.tblCheck.fldShomareHesabId, 0) AS fldShomareHesabId, 0 AS fldBaratDarId, 
                      CASE WHEN fldTypeSanad = 0 THEN CAST(2 AS TINYINT) ELSE CAST(6 AS TINYINT) END AS fldTypeSanad, '' AS fldMakanPardakht, Drd.tblCheck.fldUserId, 
                      Drd.tblCheck.fldDesc, Drd.tblCheck.fldDate, CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, 
                      ISNULL((CASE WHEN fldStatus = 1 THEN N'در انتظار وصول' WHEN fldStatus = 2 THEN N'وصول شده' WHEN fldStatus = 3 THEN N'برگشت خورده' WHEN fldStatus = 4 THEN
                       N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END), '') AS fldStatusName, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblBank.fldBankName, 
                      Com.tblSHobe.fldBankId, Com.tblSHobe.fldName AS fldNameShobe, Com.tblShomareHesabeOmoomi.fldShobeId, '' AS fldNameBaratDar, '' AS fldStatusFish, 
                      '' AS fldStatusFishId, NULL AS fldFishId, Drd.tblCheck.fldShomareHesabIdOrgan, tblShomareHesabeOmoomi_1.fldShomareHesab AS fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,tblCheck.fldTarikhAkhz,fldDateStatus,com.fn_NameAshkhasHaghighi_Hoghoghi(Drd.tblCheck.fldAshkhasId) as fldNameSaderkonandeCheck
FROM         Drd.tblCheck INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId

)t
WHERE fldDateStatus LIKE @value and  fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
 --and fldTarikhSarResid like @Year+'%'
order by fldTarikhSarResid
END



IF (@fieldname=N'Ejra_fldElamAvarezId')
BEGIN
IF(@AzTarikh <>'' AND @TaTarikh<>'')
SELECT TOP(@h)  * FROM (SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ), 0) AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
                      CAST(0 AS TINYINT)) AS fldStatus, ISNULL(Drd.tblCheck.fldShomareHesabId, 0) AS fldShomareHesabId, 0 AS fldBaratDarId, 
                      CASE WHEN fldTypeSanad = 0 THEN CAST(2 AS TINYINT) ELSE CAST(6 AS TINYINT) END AS fldTypeSanad, '' AS fldMakanPardakht, Drd.tblCheck.fldUserId, 
                      Drd.tblCheck.fldDesc, Drd.tblCheck.fldDate, CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, 
                      ISNULL((CASE WHEN fldStatus = 1 THEN N'در انتظار وصول' WHEN fldStatus = 2 THEN N'وصول شده' WHEN fldStatus = 3 THEN N'برگشت خورده' WHEN fldStatus = 4 THEN
                       N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END), '') AS fldStatusName, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblBank.fldBankName, 
                      Com.tblSHobe.fldBankId, Com.tblSHobe.fldName AS fldNameShobe, Com.tblShomareHesabeOmoomi.fldShobeId, '' AS fldNameBaratDar, '' AS fldStatusFish, 
                      '' AS fldStatusFishId, NULL AS fldFishId, Drd.tblCheck.fldShomareHesabIdOrgan, tblShomareHesabeOmoomi_1.fldShomareHesab AS fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,tblCheck.fldTarikhAkhz,fldDateStatus,com.fn_NameAshkhasHaghighi_Hoghoghi(Drd.tblCheck.fldAshkhasId) as fldNameSaderkonandeCheck
FROM         Drd.tblCheck INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId
)t
WHERE fldElamAvarezId LIKE @value and fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND t.fldTarikhSarResid BETWEEN @AzTarikh AND @TaTarikh
order by fldTarikhSarResid

IF(@AzTarikh <>'' AND @TaTarikh='')
SELECT TOP(@h)  * FROM (SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ), 0) AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
                      CAST(0 AS TINYINT)) AS fldStatus, ISNULL(Drd.tblCheck.fldShomareHesabId, 0) AS fldShomareHesabId, 0 AS fldBaratDarId, 
                      CASE WHEN fldTypeSanad = 0 THEN CAST(2 AS TINYINT) ELSE CAST(6 AS TINYINT) END AS fldTypeSanad, '' AS fldMakanPardakht, Drd.tblCheck.fldUserId, 
                      Drd.tblCheck.fldDesc, Drd.tblCheck.fldDate, CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, 
                      ISNULL((CASE WHEN fldStatus = 1 THEN N'در انتظار وصول' WHEN fldStatus = 2 THEN N'وصول شده' WHEN fldStatus = 3 THEN N'برگشت خورده' WHEN fldStatus = 4 THEN
                       N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END), '') AS fldStatusName, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblBank.fldBankName, 
                      Com.tblSHobe.fldBankId, Com.tblSHobe.fldName AS fldNameShobe, Com.tblShomareHesabeOmoomi.fldShobeId, '' AS fldNameBaratDar, '' AS fldStatusFish, 
                      '' AS fldStatusFishId, NULL AS fldFishId, Drd.tblCheck.fldShomareHesabIdOrgan, tblShomareHesabeOmoomi_1.fldShomareHesab AS fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,tblCheck.fldTarikhAkhz,fldDateStatus,com.fn_NameAshkhasHaghighi_Hoghoghi(Drd.tblCheck.fldAshkhasId) as fldNameSaderkonandeCheck
FROM         Drd.tblCheck INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId
)t
WHERE fldElamAvarezId LIKE @value and  fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND t.fldTarikhSarResid >= @AzTarikh 
order by fldTarikhSarResid

IF(@AzTarikh ='' AND @TaTarikh<>'')
SELECT TOP(@h)  * FROM (SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ), 0) AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
                      CAST(0 AS TINYINT)) AS fldStatus, ISNULL(Drd.tblCheck.fldShomareHesabId, 0) AS fldShomareHesabId, 0 AS fldBaratDarId, 
                      CASE WHEN fldTypeSanad = 0 THEN CAST(2 AS TINYINT) ELSE CAST(6 AS TINYINT) END AS fldTypeSanad, '' AS fldMakanPardakht, Drd.tblCheck.fldUserId, 
                      Drd.tblCheck.fldDesc, Drd.tblCheck.fldDate, CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, 
                      ISNULL((CASE WHEN fldStatus = 1 THEN N'در انتظار وصول' WHEN fldStatus = 2 THEN N'وصول شده' WHEN fldStatus = 3 THEN N'برگشت خورده' WHEN fldStatus = 4 THEN
                       N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END), '') AS fldStatusName, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblBank.fldBankName, 
                      Com.tblSHobe.fldBankId, Com.tblSHobe.fldName AS fldNameShobe, Com.tblShomareHesabeOmoomi.fldShobeId, '' AS fldNameBaratDar, '' AS fldStatusFish, 
                      '' AS fldStatusFishId, NULL AS fldFishId, Drd.tblCheck.fldShomareHesabIdOrgan, tblShomareHesabeOmoomi_1.fldShomareHesab AS fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,tblCheck.fldTarikhAkhz,fldDateStatus,com.fn_NameAshkhasHaghighi_Hoghoghi(Drd.tblCheck.fldAshkhasId) as fldNameSaderkonandeCheck
FROM         Drd.tblCheck INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId

)t
WHERE fldElamAvarezId LIKE @value and  fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND t.fldTarikhSarResid <= @TaTarikh
order by fldTarikhSarResid

IF(@AzTarikh ='' AND @TaTarikh='')
SELECT TOP(@h)  * FROM (SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ), 0) AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
                      CAST(0 AS TINYINT)) AS fldStatus, ISNULL(Drd.tblCheck.fldShomareHesabId, 0) AS fldShomareHesabId, 0 AS fldBaratDarId, 
                      CASE WHEN fldTypeSanad = 0 THEN CAST(2 AS TINYINT) ELSE CAST(6 AS TINYINT) END AS fldTypeSanad, '' AS fldMakanPardakht, Drd.tblCheck.fldUserId, 
                      Drd.tblCheck.fldDesc, Drd.tblCheck.fldDate, CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, 
                      ISNULL((CASE WHEN fldStatus = 1 THEN N'در انتظار وصول' WHEN fldStatus = 2 THEN N'وصول شده' WHEN fldStatus = 3 THEN N'برگشت خورده' WHEN fldStatus = 4 THEN
                       N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END), '') AS fldStatusName, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblBank.fldBankName, 
                      Com.tblSHobe.fldBankId, Com.tblSHobe.fldName AS fldNameShobe, Com.tblShomareHesabeOmoomi.fldShobeId, '' AS fldNameBaratDar, '' AS fldStatusFish, 
                      '' AS fldStatusFishId, NULL AS fldFishId, Drd.tblCheck.fldShomareHesabIdOrgan, tblShomareHesabeOmoomi_1.fldShomareHesab AS fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,tblCheck.fldTarikhAkhz,fldDateStatus,com.fn_NameAshkhasHaghighi_Hoghoghi(Drd.tblCheck.fldAshkhasId) as fldNameSaderkonandeCheck
FROM         Drd.tblCheck INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId

)t
WHERE fldElamAvarezId LIKE @value and  fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
 --and fldTarikhSarResid like @Year+'%'
order by fldTarikhSarResid

END


IF (@fieldname=N'Ejra_fldTarikhSarResid')
BEGIN
IF(@AzTarikh <>'' AND @TaTarikh<>'')
SELECT TOP(@h)  * FROM (SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ), 0) AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
                      CAST(0 AS TINYINT)) AS fldStatus, ISNULL(Drd.tblCheck.fldShomareHesabId, 0) AS fldShomareHesabId, 0 AS fldBaratDarId, 
                      CASE WHEN fldTypeSanad = 0 THEN CAST(2 AS TINYINT) ELSE CAST(6 AS TINYINT) END AS fldTypeSanad, '' AS fldMakanPardakht, Drd.tblCheck.fldUserId, 
                      Drd.tblCheck.fldDesc, Drd.tblCheck.fldDate, CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, 
                      ISNULL((CASE WHEN fldStatus = 1 THEN N'در انتظار وصول' WHEN fldStatus = 2 THEN N'وصول شده' WHEN fldStatus = 3 THEN N'برگشت خورده' WHEN fldStatus = 4 THEN
                       N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END), '') AS fldStatusName, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblBank.fldBankName, 
                      Com.tblSHobe.fldBankId, Com.tblSHobe.fldName AS fldNameShobe, Com.tblShomareHesabeOmoomi.fldShobeId, '' AS fldNameBaratDar, '' AS fldStatusFish, 
                      '' AS fldStatusFishId, NULL AS fldFishId, Drd.tblCheck.fldShomareHesabIdOrgan, tblShomareHesabeOmoomi_1.fldShomareHesab AS fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,tblCheck.fldTarikhAkhz,fldDateStatus,com.fn_NameAshkhasHaghighi_Hoghoghi(Drd.tblCheck.fldAshkhasId) as fldNameSaderkonandeCheck
FROM         Drd.tblCheck INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId
)t
WHERE fldTarikhSarResid LIKE @value AND  fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND t.fldTarikhSarResid BETWEEN @AzTarikh AND @TaTarikh
order by fldTarikhSarResid

IF(@AzTarikh <>'' AND @TaTarikh='')
SELECT TOP(@h)  * FROM (SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ), 0) AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
                      CAST(0 AS TINYINT)) AS fldStatus, ISNULL(Drd.tblCheck.fldShomareHesabId, 0) AS fldShomareHesabId, 0 AS fldBaratDarId, 
                      CASE WHEN fldTypeSanad = 0 THEN CAST(2 AS TINYINT) ELSE CAST(6 AS TINYINT) END AS fldTypeSanad, '' AS fldMakanPardakht, Drd.tblCheck.fldUserId, 
                      Drd.tblCheck.fldDesc, Drd.tblCheck.fldDate, CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, 
                      ISNULL((CASE WHEN fldStatus = 1 THEN N'در انتظار وصول' WHEN fldStatus = 2 THEN N'وصول شده' WHEN fldStatus = 3 THEN N'برگشت خورده' WHEN fldStatus = 4 THEN
                       N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END), '') AS fldStatusName, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblBank.fldBankName, 
                      Com.tblSHobe.fldBankId, Com.tblSHobe.fldName AS fldNameShobe, Com.tblShomareHesabeOmoomi.fldShobeId, '' AS fldNameBaratDar, '' AS fldStatusFish, 
                      '' AS fldStatusFishId, NULL AS fldFishId, Drd.tblCheck.fldShomareHesabIdOrgan, tblShomareHesabeOmoomi_1.fldShomareHesab AS fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,tblCheck.fldTarikhAkhz,fldDateStatus,com.fn_NameAshkhasHaghighi_Hoghoghi(Drd.tblCheck.fldAshkhasId) as fldNameSaderkonandeCheck
FROM         Drd.tblCheck INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId
)t
WHERE fldTarikhSarResid LIKE @value AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND t.fldTarikhSarResid >= @AzTarikh 
order by fldTarikhSarResid

IF(@AzTarikh ='' AND @TaTarikh<>'')
SELECT TOP(@h)  * FROM (SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ), 0) AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
                      CAST(0 AS TINYINT)) AS fldStatus, ISNULL(Drd.tblCheck.fldShomareHesabId, 0) AS fldShomareHesabId, 0 AS fldBaratDarId, 
                      CASE WHEN fldTypeSanad = 0 THEN CAST(2 AS TINYINT) ELSE CAST(6 AS TINYINT) END AS fldTypeSanad, '' AS fldMakanPardakht, Drd.tblCheck.fldUserId, 
                      Drd.tblCheck.fldDesc, Drd.tblCheck.fldDate, CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, 
                      ISNULL((CASE WHEN fldStatus = 1 THEN N'در انتظار وصول' WHEN fldStatus = 2 THEN N'وصول شده' WHEN fldStatus = 3 THEN N'برگشت خورده' WHEN fldStatus = 4 THEN
                       N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END), '') AS fldStatusName, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblBank.fldBankName, 
                      Com.tblSHobe.fldBankId, Com.tblSHobe.fldName AS fldNameShobe, Com.tblShomareHesabeOmoomi.fldShobeId, '' AS fldNameBaratDar, '' AS fldStatusFish, 
                      '' AS fldStatusFishId, NULL AS fldFishId, Drd.tblCheck.fldShomareHesabIdOrgan, tblShomareHesabeOmoomi_1.fldShomareHesab AS fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,tblCheck.fldTarikhAkhz,fldDateStatus,com.fn_NameAshkhasHaghighi_Hoghoghi(Drd.tblCheck.fldAshkhasId) as fldNameSaderkonandeCheck
FROM         Drd.tblCheck INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId

)t
WHERE fldTarikhSarResid LIKE @value AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND t.fldTarikhSarResid <= @TaTarikh
order by fldTarikhSarResid

IF(@AzTarikh ='' AND @TaTarikh='')
SELECT TOP(@h)  * FROM (SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ), 0) AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
                      CAST(0 AS TINYINT)) AS fldStatus, ISNULL(Drd.tblCheck.fldShomareHesabId, 0) AS fldShomareHesabId, 0 AS fldBaratDarId, 
                      CASE WHEN fldTypeSanad = 0 THEN CAST(2 AS TINYINT) ELSE CAST(6 AS TINYINT) END AS fldTypeSanad, '' AS fldMakanPardakht, Drd.tblCheck.fldUserId, 
                      Drd.tblCheck.fldDesc, Drd.tblCheck.fldDate, CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, 
                      ISNULL((CASE WHEN fldStatus = 1 THEN N'در انتظار وصول' WHEN fldStatus = 2 THEN N'وصول شده' WHEN fldStatus = 3 THEN N'برگشت خورده' WHEN fldStatus = 4 THEN
                       N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END), '') AS fldStatusName, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblBank.fldBankName, 
                      Com.tblSHobe.fldBankId, Com.tblSHobe.fldName AS fldNameShobe, Com.tblShomareHesabeOmoomi.fldShobeId, '' AS fldNameBaratDar, '' AS fldStatusFish, 
                      '' AS fldStatusFishId, NULL AS fldFishId, Drd.tblCheck.fldShomareHesabIdOrgan, tblShomareHesabeOmoomi_1.fldShomareHesab AS fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,tblCheck.fldTarikhAkhz,fldDateStatus,com.fn_NameAshkhasHaghighi_Hoghoghi(Drd.tblCheck.fldAshkhasId) as fldNameSaderkonandeCheck
FROM         Drd.tblCheck INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId

)t
WHERE fldTarikhSarResid LIKE @value AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
 --and fldTarikhSarResid like @Year+'%'
order by fldTarikhSarResid

END


IF (@fieldname=N'Ejra_fldStatusName')
BEGIN
IF(@AzTarikh <>'' AND @TaTarikh<>'')
SELECT TOP(@h)  * FROM (SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ), 0) AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
                      CAST(0 AS TINYINT)) AS fldStatus, ISNULL(Drd.tblCheck.fldShomareHesabId, 0) AS fldShomareHesabId, 0 AS fldBaratDarId, 
                      CASE WHEN fldTypeSanad = 0 THEN CAST(2 AS TINYINT) ELSE CAST(6 AS TINYINT) END AS fldTypeSanad, '' AS fldMakanPardakht, Drd.tblCheck.fldUserId, 
                      Drd.tblCheck.fldDesc, Drd.tblCheck.fldDate, CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, 
                      ISNULL((CASE WHEN fldStatus = 1 THEN N'در انتظار وصول' WHEN fldStatus = 2 THEN N'وصول شده' WHEN fldStatus = 3 THEN N'برگشت خورده' WHEN fldStatus = 4 THEN
                       N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END), '') AS fldStatusName, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblBank.fldBankName, 
                      Com.tblSHobe.fldBankId, Com.tblSHobe.fldName AS fldNameShobe, Com.tblShomareHesabeOmoomi.fldShobeId, '' AS fldNameBaratDar, '' AS fldStatusFish, 
                      '' AS fldStatusFishId, NULL AS fldFishId, Drd.tblCheck.fldShomareHesabIdOrgan, tblShomareHesabeOmoomi_1.fldShomareHesab AS fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,tblCheck.fldTarikhAkhz,fldDateStatus,com.fn_NameAshkhasHaghighi_Hoghoghi(Drd.tblCheck.fldAshkhasId) as fldNameSaderkonandeCheck
FROM         Drd.tblCheck INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId
)t
WHERE fldStatusName LIKE @value and  fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND t.fldTarikhSarResid BETWEEN @AzTarikh AND @TaTarikh
order by fldTarikhSarResid

IF(@AzTarikh <>'' AND @TaTarikh='')
SELECT TOP(@h)  * FROM (SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ), 0) AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
                      CAST(0 AS TINYINT)) AS fldStatus, ISNULL(Drd.tblCheck.fldShomareHesabId, 0) AS fldShomareHesabId, 0 AS fldBaratDarId, 
                      CASE WHEN fldTypeSanad = 0 THEN CAST(2 AS TINYINT) ELSE CAST(6 AS TINYINT) END AS fldTypeSanad, '' AS fldMakanPardakht, Drd.tblCheck.fldUserId, 
                      Drd.tblCheck.fldDesc, Drd.tblCheck.fldDate, CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, 
                      ISNULL((CASE WHEN fldStatus = 1 THEN N'در انتظار وصول' WHEN fldStatus = 2 THEN N'وصول شده' WHEN fldStatus = 3 THEN N'برگشت خورده' WHEN fldStatus = 4 THEN
                       N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END), '') AS fldStatusName, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblBank.fldBankName, 
                      Com.tblSHobe.fldBankId, Com.tblSHobe.fldName AS fldNameShobe, Com.tblShomareHesabeOmoomi.fldShobeId, '' AS fldNameBaratDar, '' AS fldStatusFish, 
                      '' AS fldStatusFishId, NULL AS fldFishId, Drd.tblCheck.fldShomareHesabIdOrgan, tblShomareHesabeOmoomi_1.fldShomareHesab AS fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,tblCheck.fldTarikhAkhz,fldDateStatus,com.fn_NameAshkhasHaghighi_Hoghoghi(Drd.tblCheck.fldAshkhasId) as fldNameSaderkonandeCheck
FROM         Drd.tblCheck INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId
)t
WHERE fldStatusName LIKE @value AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND t.fldTarikhSarResid >= @AzTarikh 
order by fldTarikhSarResid

IF(@AzTarikh ='' AND @TaTarikh<>'')
SELECT TOP(@h)  * FROM (SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ), 0) AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
                      CAST(0 AS TINYINT)) AS fldStatus, ISNULL(Drd.tblCheck.fldShomareHesabId, 0) AS fldShomareHesabId, 0 AS fldBaratDarId, 
                      CASE WHEN fldTypeSanad = 0 THEN CAST(2 AS TINYINT) ELSE CAST(6 AS TINYINT) END AS fldTypeSanad, '' AS fldMakanPardakht, Drd.tblCheck.fldUserId, 
                      Drd.tblCheck.fldDesc, Drd.tblCheck.fldDate, CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, 
                      ISNULL((CASE WHEN fldStatus = 1 THEN N'در انتظار وصول' WHEN fldStatus = 2 THEN N'وصول شده' WHEN fldStatus = 3 THEN N'برگشت خورده' WHEN fldStatus = 4 THEN
                       N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END), '') AS fldStatusName, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblBank.fldBankName, 
                      Com.tblSHobe.fldBankId, Com.tblSHobe.fldName AS fldNameShobe, Com.tblShomareHesabeOmoomi.fldShobeId, '' AS fldNameBaratDar, '' AS fldStatusFish, 
                      '' AS fldStatusFishId, NULL AS fldFishId, Drd.tblCheck.fldShomareHesabIdOrgan, tblShomareHesabeOmoomi_1.fldShomareHesab AS fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,tblCheck.fldTarikhAkhz,fldDateStatus,com.fn_NameAshkhasHaghighi_Hoghoghi(Drd.tblCheck.fldAshkhasId) as fldNameSaderkonandeCheck
FROM         Drd.tblCheck INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId

)t
WHERE fldStatusName LIKE @value AND  fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND t.fldTarikhSarResid <= @TaTarikh
order by fldTarikhSarResid

IF(@AzTarikh ='' AND @TaTarikh='')
SELECT TOP(@h)  * FROM (SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ), 0) AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
                      CAST(0 AS TINYINT)) AS fldStatus, ISNULL(Drd.tblCheck.fldShomareHesabId, 0) AS fldShomareHesabId, 0 AS fldBaratDarId, 
                      CASE WHEN fldTypeSanad = 0 THEN CAST(2 AS TINYINT) ELSE CAST(6 AS TINYINT) END AS fldTypeSanad, '' AS fldMakanPardakht, Drd.tblCheck.fldUserId, 
                      Drd.tblCheck.fldDesc, Drd.tblCheck.fldDate, CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, 
                      ISNULL((CASE WHEN fldStatus = 1 THEN N'در انتظار وصول' WHEN fldStatus = 2 THEN N'وصول شده' WHEN fldStatus = 3 THEN N'برگشت خورده' WHEN fldStatus = 4 THEN
                       N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END), '') AS fldStatusName, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblBank.fldBankName, 
                      Com.tblSHobe.fldBankId, Com.tblSHobe.fldName AS fldNameShobe, Com.tblShomareHesabeOmoomi.fldShobeId, '' AS fldNameBaratDar, '' AS fldStatusFish, 
                      '' AS fldStatusFishId, NULL AS fldFishId, Drd.tblCheck.fldShomareHesabIdOrgan, tblShomareHesabeOmoomi_1.fldShomareHesab AS fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL THEN (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) END
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL THEN (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) END
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL THEN (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) END
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,tblCheck.fldTarikhAkhz,fldDateStatus,com.fn_NameAshkhasHaghighi_Hoghoghi(Drd.tblCheck.fldAshkhasId) as fldNameSaderkonandeCheck
FROM         Drd.tblCheck INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId

)t
WHERE fldStatusName LIKE @value and fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
 --and fldTarikhSarResid like @Year+'%'
order by fldTarikhSarResid
END


IF (@fieldname=N'Ejra_fldTypeSanadName')
BEGIN
IF(@AzTarikh <>'' AND @TaTarikh<>'')
SELECT TOP(@h)  * FROM (SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ), 0) AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
                      CAST(0 AS TINYINT)) AS fldStatus, ISNULL(Drd.tblCheck.fldShomareHesabId, 0) AS fldShomareHesabId, 0 AS fldBaratDarId, 
                      CASE WHEN fldTypeSanad = 0 THEN CAST(2 AS TINYINT) ELSE CAST(6 AS TINYINT) END AS fldTypeSanad, '' AS fldMakanPardakht, Drd.tblCheck.fldUserId, 
                      Drd.tblCheck.fldDesc, Drd.tblCheck.fldDate, CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, 
                      ISNULL((CASE WHEN fldStatus = 1 THEN N'در انتظار وصول' WHEN fldStatus = 2 THEN N'وصول شده' WHEN fldStatus = 3 THEN N'برگشت خورده' WHEN fldStatus = 4 THEN
                       N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END), '') AS fldStatusName, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblBank.fldBankName, 
                      Com.tblSHobe.fldBankId, Com.tblSHobe.fldName AS fldNameShobe, Com.tblShomareHesabeOmoomi.fldShobeId, '' AS fldNameBaratDar, '' AS fldStatusFish, 
                      '' AS fldStatusFishId, NULL AS fldFishId, Drd.tblCheck.fldShomareHesabIdOrgan, tblShomareHesabeOmoomi_1.fldShomareHesab AS fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,tblCheck.fldTarikhAkhz,fldDateStatus,com.fn_NameAshkhasHaghighi_Hoghoghi(Drd.tblCheck.fldAshkhasId) as fldNameSaderkonandeCheck
FROM         Drd.tblCheck INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId
)t
WHERE fldTypeSanadName LIKE @value AND  fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND t.fldTarikhSarResid BETWEEN @AzTarikh AND @TaTarikh
order by fldTarikhSarResid

IF(@AzTarikh <>'' AND @TaTarikh='')
SELECT TOP(@h)  * FROM (SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ), 0) AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
                      CAST(0 AS TINYINT)) AS fldStatus, ISNULL(Drd.tblCheck.fldShomareHesabId, 0) AS fldShomareHesabId, 0 AS fldBaratDarId, 
                      CASE WHEN fldTypeSanad = 0 THEN CAST(2 AS TINYINT) ELSE CAST(6 AS TINYINT) END AS fldTypeSanad, '' AS fldMakanPardakht, Drd.tblCheck.fldUserId, 
                      Drd.tblCheck.fldDesc, Drd.tblCheck.fldDate, CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, 
                      ISNULL((CASE WHEN fldStatus = 1 THEN N'در انتظار وصول' WHEN fldStatus = 2 THEN N'وصول شده' WHEN fldStatus = 3 THEN N'برگشت خورده' WHEN fldStatus = 4 THEN
                       N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END), '') AS fldStatusName, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblBank.fldBankName, 
                      Com.tblSHobe.fldBankId, Com.tblSHobe.fldName AS fldNameShobe, Com.tblShomareHesabeOmoomi.fldShobeId, '' AS fldNameBaratDar, '' AS fldStatusFish, 
                      '' AS fldStatusFishId, NULL AS fldFishId, Drd.tblCheck.fldShomareHesabIdOrgan, tblShomareHesabeOmoomi_1.fldShomareHesab AS fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,tblCheck.fldTarikhAkhz,fldDateStatus,com.fn_NameAshkhasHaghighi_Hoghoghi(Drd.tblCheck.fldAshkhasId) as fldNameSaderkonandeCheck
FROM         Drd.tblCheck INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId
)t
WHERE fldTypeSanadName LIKE @value AND  fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND t.fldTarikhSarResid >= @AzTarikh 
order by fldTarikhSarResid

IF(@AzTarikh ='' AND @TaTarikh<>'')
SELECT TOP(@h)  * FROM (SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ), 0) AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
                      CAST(0 AS TINYINT)) AS fldStatus, ISNULL(Drd.tblCheck.fldShomareHesabId, 0) AS fldShomareHesabId, 0 AS fldBaratDarId, 
                      CASE WHEN fldTypeSanad = 0 THEN CAST(2 AS TINYINT) ELSE CAST(6 AS TINYINT) END AS fldTypeSanad, '' AS fldMakanPardakht, Drd.tblCheck.fldUserId, 
                      Drd.tblCheck.fldDesc, Drd.tblCheck.fldDate, CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, 
                      ISNULL((CASE WHEN fldStatus = 1 THEN N'در انتظار وصول' WHEN fldStatus = 2 THEN N'وصول شده' WHEN fldStatus = 3 THEN N'برگشت خورده' WHEN fldStatus = 4 THEN
                       N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END), '') AS fldStatusName, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblBank.fldBankName, 
                      Com.tblSHobe.fldBankId, Com.tblSHobe.fldName AS fldNameShobe, Com.tblShomareHesabeOmoomi.fldShobeId, '' AS fldNameBaratDar, '' AS fldStatusFish, 
                      '' AS fldStatusFishId, NULL AS fldFishId, Drd.tblCheck.fldShomareHesabIdOrgan, tblShomareHesabeOmoomi_1.fldShomareHesab AS fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,tblCheck.fldTarikhAkhz,fldDateStatus,com.fn_NameAshkhasHaghighi_Hoghoghi(Drd.tblCheck.fldAshkhasId) as fldNameSaderkonandeCheck
FROM         Drd.tblCheck INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId

)t
WHERE fldTypeSanadName LIKE @value AND  fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND t.fldTarikhSarResid <= @TaTarikh
order by fldTarikhSarResid

IF(@AzTarikh ='' AND @TaTarikh='')
SELECT TOP(@h)  * FROM (SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ), 0) AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
                      CAST(0 AS TINYINT)) AS fldStatus, ISNULL(Drd.tblCheck.fldShomareHesabId, 0) AS fldShomareHesabId, 0 AS fldBaratDarId, 
                      CASE WHEN fldTypeSanad = 0 THEN CAST(2 AS TINYINT) ELSE CAST(6 AS TINYINT) END AS fldTypeSanad, '' AS fldMakanPardakht, Drd.tblCheck.fldUserId, 
                      Drd.tblCheck.fldDesc, Drd.tblCheck.fldDate, CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, 
                      ISNULL((CASE WHEN fldStatus = 1 THEN N'در انتظار وصول' WHEN fldStatus = 2 THEN N'وصول شده' WHEN fldStatus = 3 THEN N'برگشت خورده' WHEN fldStatus = 4 THEN
                       N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END), '') AS fldStatusName, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblBank.fldBankName, 
                      Com.tblSHobe.fldBankId, Com.tblSHobe.fldName AS fldNameShobe, Com.tblShomareHesabeOmoomi.fldShobeId, '' AS fldNameBaratDar, '' AS fldStatusFish, 
                      '' AS fldStatusFishId, NULL AS fldFishId, Drd.tblCheck.fldShomareHesabIdOrgan, tblShomareHesabeOmoomi_1.fldShomareHesab AS fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL THEN (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) END
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL THEN (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) END
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL THEN (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) END
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,tblCheck.fldTarikhAkhz,fldDateStatus,com.fn_NameAshkhasHaghighi_Hoghoghi(Drd.tblCheck.fldAshkhasId) as fldNameSaderkonandeCheck
FROM         Drd.tblCheck INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId

)t
WHERE fldTypeSanadName LIKE @value AND  fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
 --and fldTarikhSarResid like @Year+'%'
order by fldTarikhSarResid
END


IF (@fieldname=N'Ejra_fldBankName')
BEGIN
IF(@AzTarikh <>'' AND @TaTarikh<>'')
SELECT TOP(@h)  * FROM (SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ), 0) AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
                      CAST(0 AS TINYINT)) AS fldStatus, ISNULL(Drd.tblCheck.fldShomareHesabId, 0) AS fldShomareHesabId, 0 AS fldBaratDarId, 
                      CASE WHEN fldTypeSanad = 0 THEN CAST(2 AS TINYINT) ELSE CAST(6 AS TINYINT) END AS fldTypeSanad, '' AS fldMakanPardakht, Drd.tblCheck.fldUserId, 
                      Drd.tblCheck.fldDesc, Drd.tblCheck.fldDate, CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, 
                      ISNULL((CASE WHEN fldStatus = 1 THEN N'در انتظار وصول' WHEN fldStatus = 2 THEN N'وصول شده' WHEN fldStatus = 3 THEN N'برگشت خورده' WHEN fldStatus = 4 THEN
                       N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END), '') AS fldStatusName, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblBank.fldBankName, 
                      Com.tblSHobe.fldBankId, Com.tblSHobe.fldName AS fldNameShobe, Com.tblShomareHesabeOmoomi.fldShobeId, '' AS fldNameBaratDar, '' AS fldStatusFish, 
                      '' AS fldStatusFishId, NULL AS fldFishId, Drd.tblCheck.fldShomareHesabIdOrgan, tblShomareHesabeOmoomi_1.fldShomareHesab AS fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,tblCheck.fldTarikhAkhz,fldDateStatus,com.fn_NameAshkhasHaghighi_Hoghoghi(Drd.tblCheck.fldAshkhasId) as fldNameSaderkonandeCheck
FROM         Drd.tblCheck INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId
)t
WHERE fldBankName LIKE @value AND  fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND t.fldTarikhSarResid BETWEEN @AzTarikh AND @TaTarikh
order by fldTarikhSarResid

IF(@AzTarikh <>'' AND @TaTarikh='')
SELECT TOP(@h)  * FROM (SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ), 0) AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
                      CAST(0 AS TINYINT)) AS fldStatus, ISNULL(Drd.tblCheck.fldShomareHesabId, 0) AS fldShomareHesabId, 0 AS fldBaratDarId, 
                      CASE WHEN fldTypeSanad = 0 THEN CAST(2 AS TINYINT) ELSE CAST(6 AS TINYINT) END AS fldTypeSanad, '' AS fldMakanPardakht, Drd.tblCheck.fldUserId, 
                      Drd.tblCheck.fldDesc, Drd.tblCheck.fldDate, CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, 
                      ISNULL((CASE WHEN fldStatus = 1 THEN N'در انتظار وصول' WHEN fldStatus = 2 THEN N'وصول شده' WHEN fldStatus = 3 THEN N'برگشت خورده' WHEN fldStatus = 4 THEN
                       N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END), '') AS fldStatusName, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblBank.fldBankName, 
                      Com.tblSHobe.fldBankId, Com.tblSHobe.fldName AS fldNameShobe, Com.tblShomareHesabeOmoomi.fldShobeId, '' AS fldNameBaratDar, '' AS fldStatusFish, 
                      '' AS fldStatusFishId, NULL AS fldFishId, Drd.tblCheck.fldShomareHesabIdOrgan, tblShomareHesabeOmoomi_1.fldShomareHesab AS fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,tblCheck.fldTarikhAkhz,fldDateStatus,com.fn_NameAshkhasHaghighi_Hoghoghi(Drd.tblCheck.fldAshkhasId) as fldNameSaderkonandeCheck

FROM         Drd.tblCheck INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId
)t
WHERE fldBankName LIKE @value and fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND t.fldTarikhSarResid >= @AzTarikh 
order by fldTarikhSarResid

IF(@AzTarikh ='' AND @TaTarikh<>'')
SELECT TOP(@h)  * FROM (SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ), 0) AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
                      CAST(0 AS TINYINT)) AS fldStatus, ISNULL(Drd.tblCheck.fldShomareHesabId, 0) AS fldShomareHesabId, 0 AS fldBaratDarId, 
                      CASE WHEN fldTypeSanad = 0 THEN CAST(2 AS TINYINT) ELSE CAST(6 AS TINYINT) END AS fldTypeSanad, '' AS fldMakanPardakht, Drd.tblCheck.fldUserId, 
                      Drd.tblCheck.fldDesc, Drd.tblCheck.fldDate, CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, 
                      ISNULL((CASE WHEN fldStatus = 1 THEN N'در انتظار وصول' WHEN fldStatus = 2 THEN N'وصول شده' WHEN fldStatus = 3 THEN N'برگشت خورده' WHEN fldStatus = 4 THEN
                       N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END), '') AS fldStatusName, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblBank.fldBankName, 
                      Com.tblSHobe.fldBankId, Com.tblSHobe.fldName AS fldNameShobe, Com.tblShomareHesabeOmoomi.fldShobeId, '' AS fldNameBaratDar, '' AS fldStatusFish, 
                      '' AS fldStatusFishId, NULL AS fldFishId, Drd.tblCheck.fldShomareHesabIdOrgan, tblShomareHesabeOmoomi_1.fldShomareHesab AS fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,tblCheck.fldTarikhAkhz,fldDateStatus,com.fn_NameAshkhasHaghighi_Hoghoghi(Drd.tblCheck.fldAshkhasId) as fldNameSaderkonandeCheck
FROM         Drd.tblCheck INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId

)t
WHERE fldBankName LIKE @value AND  fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND t.fldTarikhSarResid <= @TaTarikh
order by fldTarikhSarResid

IF(@AzTarikh ='' AND @TaTarikh='')
SELECT TOP(@h)  * FROM (SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ), 0) AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
                      CAST(0 AS TINYINT)) AS fldStatus, ISNULL(Drd.tblCheck.fldShomareHesabId, 0) AS fldShomareHesabId, 0 AS fldBaratDarId, 
                      CASE WHEN fldTypeSanad = 0 THEN CAST(2 AS TINYINT) ELSE CAST(6 AS TINYINT) END AS fldTypeSanad, '' AS fldMakanPardakht, Drd.tblCheck.fldUserId, 
                      Drd.tblCheck.fldDesc, Drd.tblCheck.fldDate, CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, 
                      ISNULL((CASE WHEN fldStatus = 1 THEN N'در انتظار وصول' WHEN fldStatus = 2 THEN N'وصول شده' WHEN fldStatus = 3 THEN N'برگشت خورده' WHEN fldStatus = 4 THEN
                       N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END), '') AS fldStatusName, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblBank.fldBankName, 
                      Com.tblSHobe.fldBankId, Com.tblSHobe.fldName AS fldNameShobe, Com.tblShomareHesabeOmoomi.fldShobeId, '' AS fldNameBaratDar, '' AS fldStatusFish, 
                      '' AS fldStatusFishId, NULL AS fldFishId, Drd.tblCheck.fldShomareHesabIdOrgan, tblShomareHesabeOmoomi_1.fldShomareHesab AS fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL THEN (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) END
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL THEN (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) END
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL THEN (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) END
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,tblCheck.fldTarikhAkhz,fldDateStatus,com.fn_NameAshkhasHaghighi_Hoghoghi(Drd.tblCheck.fldAshkhasId) as fldNameSaderkonandeCheck
FROM         Drd.tblCheck INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId

)t
WHERE fldBankName LIKE @value AND  fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
 --and fldTarikhSarResid like @Year+'%'
order by fldTarikhSarResid
END


IF (@fieldname=N'Ejra_fldMablaghSanad')
BEGIN
IF(@AzTarikh <>'' AND @TaTarikh<>'')
SELECT TOP(@h)  * FROM (SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ), 0) AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
                      CAST(0 AS TINYINT)) AS fldStatus, ISNULL(Drd.tblCheck.fldShomareHesabId, 0) AS fldShomareHesabId, 0 AS fldBaratDarId, 
                      CASE WHEN fldTypeSanad = 0 THEN CAST(2 AS TINYINT) ELSE CAST(6 AS TINYINT) END AS fldTypeSanad, '' AS fldMakanPardakht, Drd.tblCheck.fldUserId, 
                      Drd.tblCheck.fldDesc, Drd.tblCheck.fldDate, CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, 
                      ISNULL((CASE WHEN fldStatus = 1 THEN N'در انتظار وصول' WHEN fldStatus = 2 THEN N'وصول شده' WHEN fldStatus = 3 THEN N'برگشت خورده' WHEN fldStatus = 4 THEN
                       N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END), '') AS fldStatusName, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblBank.fldBankName, 
                      Com.tblSHobe.fldBankId, Com.tblSHobe.fldName AS fldNameShobe, Com.tblShomareHesabeOmoomi.fldShobeId, '' AS fldNameBaratDar, '' AS fldStatusFish, 
                      '' AS fldStatusFishId, NULL AS fldFishId, Drd.tblCheck.fldShomareHesabIdOrgan, tblShomareHesabeOmoomi_1.fldShomareHesab AS fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,tblCheck.fldTarikhAkhz,fldDateStatus,com.fn_NameAshkhasHaghighi_Hoghoghi(Drd.tblCheck.fldAshkhasId) as fldNameSaderkonandeCheck
FROM         Drd.tblCheck INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId
)t
WHERE fldMablaghSanad LIKE @value AND  fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND t.fldTarikhSarResid BETWEEN @AzTarikh AND @TaTarikh
order by fldTarikhSarResid

IF(@AzTarikh <>'' AND @TaTarikh='')
SELECT TOP(@h)  * FROM (SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ), 0) AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
                      CAST(0 AS TINYINT)) AS fldStatus, ISNULL(Drd.tblCheck.fldShomareHesabId, 0) AS fldShomareHesabId, 0 AS fldBaratDarId, 
                      CASE WHEN fldTypeSanad = 0 THEN CAST(2 AS TINYINT) ELSE CAST(6 AS TINYINT) END AS fldTypeSanad, '' AS fldMakanPardakht, Drd.tblCheck.fldUserId, 
                      Drd.tblCheck.fldDesc, Drd.tblCheck.fldDate, CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, 
                      ISNULL((CASE WHEN fldStatus = 1 THEN N'در انتظار وصول' WHEN fldStatus = 2 THEN N'وصول شده' WHEN fldStatus = 3 THEN N'برگشت خورده' WHEN fldStatus = 4 THEN
                       N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END), '') AS fldStatusName, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblBank.fldBankName, 
                      Com.tblSHobe.fldBankId, Com.tblSHobe.fldName AS fldNameShobe, Com.tblShomareHesabeOmoomi.fldShobeId, '' AS fldNameBaratDar, '' AS fldStatusFish, 
                      '' AS fldStatusFishId, NULL AS fldFishId, Drd.tblCheck.fldShomareHesabIdOrgan, tblShomareHesabeOmoomi_1.fldShomareHesab AS fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,tblCheck.fldTarikhAkhz,fldDateStatus,com.fn_NameAshkhasHaghighi_Hoghoghi(Drd.tblCheck.fldAshkhasId) as fldNameSaderkonandeCheck

FROM         Drd.tblCheck INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId
)t
WHERE fldMablaghSanad LIKE @value and fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND t.fldTarikhSarResid >= @AzTarikh 
order by fldTarikhSarResid

IF(@AzTarikh ='' AND @TaTarikh<>'')
SELECT TOP(@h)  * FROM (SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ), 0) AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
                      CAST(0 AS TINYINT)) AS fldStatus, ISNULL(Drd.tblCheck.fldShomareHesabId, 0) AS fldShomareHesabId, 0 AS fldBaratDarId, 
                      CASE WHEN fldTypeSanad = 0 THEN CAST(2 AS TINYINT) ELSE CAST(6 AS TINYINT) END AS fldTypeSanad, '' AS fldMakanPardakht, Drd.tblCheck.fldUserId, 
                      Drd.tblCheck.fldDesc, Drd.tblCheck.fldDate, CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, 
                      ISNULL((CASE WHEN fldStatus = 1 THEN N'در انتظار وصول' WHEN fldStatus = 2 THEN N'وصول شده' WHEN fldStatus = 3 THEN N'برگشت خورده' WHEN fldStatus = 4 THEN
                       N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END), '') AS fldStatusName, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblBank.fldBankName, 
                      Com.tblSHobe.fldBankId, Com.tblSHobe.fldName AS fldNameShobe, Com.tblShomareHesabeOmoomi.fldShobeId, '' AS fldNameBaratDar, '' AS fldStatusFish, 
                      '' AS fldStatusFishId, NULL AS fldFishId, Drd.tblCheck.fldShomareHesabIdOrgan, tblShomareHesabeOmoomi_1.fldShomareHesab AS fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,tblCheck.fldTarikhAkhz,fldDateStatus,com.fn_NameAshkhasHaghighi_Hoghoghi(Drd.tblCheck.fldAshkhasId) as fldNameSaderkonandeCheck
FROM         Drd.tblCheck INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId

)t
WHERE fldMablaghSanad LIKE @value AND  fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND t.fldTarikhSarResid <= @TaTarikh
order by fldTarikhSarResid

IF(@AzTarikh ='' AND @TaTarikh='')
SELECT TOP(@h)  * FROM (SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ), 0) AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
                      CAST(0 AS TINYINT)) AS fldStatus, ISNULL(Drd.tblCheck.fldShomareHesabId, 0) AS fldShomareHesabId, 0 AS fldBaratDarId, 
                      CASE WHEN fldTypeSanad = 0 THEN CAST(2 AS TINYINT) ELSE CAST(6 AS TINYINT) END AS fldTypeSanad, '' AS fldMakanPardakht, Drd.tblCheck.fldUserId, 
                      Drd.tblCheck.fldDesc, Drd.tblCheck.fldDate, CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, 
                      ISNULL((CASE WHEN fldStatus = 1 THEN N'در انتظار وصول' WHEN fldStatus = 2 THEN N'وصول شده' WHEN fldStatus = 3 THEN N'برگشت خورده' WHEN fldStatus = 4 THEN
                       N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END), '') AS fldStatusName, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblBank.fldBankName, 
                      Com.tblSHobe.fldBankId, Com.tblSHobe.fldName AS fldNameShobe, Com.tblShomareHesabeOmoomi.fldShobeId, '' AS fldNameBaratDar, '' AS fldStatusFish, 
                      '' AS fldStatusFishId, NULL AS fldFishId, Drd.tblCheck.fldShomareHesabIdOrgan, tblShomareHesabeOmoomi_1.fldShomareHesab AS fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL THEN (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) END
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL THEN (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) END
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL THEN (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) END
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,tblCheck.fldTarikhAkhz,fldDateStatus,com.fn_NameAshkhasHaghighi_Hoghoghi(Drd.tblCheck.fldAshkhasId) as fldNameSaderkonandeCheck
FROM         Drd.tblCheck INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId

)t
WHERE fldMablaghSanad LIKE @value AND  fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
 --and fldTarikhSarResid like @Year+'%'
order by fldTarikhSarResid
END




IF (@fieldname=N'Ejra_fldNameShobe')
BEGIN
IF(@AzTarikh <>'' AND @TaTarikh<>'')
SELECT TOP(@h)  * FROM (SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ), 0) AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
                      CAST(0 AS TINYINT)) AS fldStatus, ISNULL(Drd.tblCheck.fldShomareHesabId, 0) AS fldShomareHesabId, 0 AS fldBaratDarId, 
                      CASE WHEN fldTypeSanad = 0 THEN CAST(2 AS TINYINT) ELSE CAST(6 AS TINYINT) END AS fldTypeSanad, '' AS fldMakanPardakht, Drd.tblCheck.fldUserId, 
                      Drd.tblCheck.fldDesc, Drd.tblCheck.fldDate, CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, 
                      ISNULL((CASE WHEN fldStatus = 1 THEN N'در انتظار وصول' WHEN fldStatus = 2 THEN N'وصول شده' WHEN fldStatus = 3 THEN N'برگشت خورده' WHEN fldStatus = 4 THEN
                       N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END), '') AS fldStatusName, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblBank.fldBankName, 
                      Com.tblSHobe.fldBankId, Com.tblSHobe.fldName AS fldNameShobe, Com.tblShomareHesabeOmoomi.fldShobeId, '' AS fldNameBaratDar, '' AS fldStatusFish, 
                      '' AS fldStatusFishId, NULL AS fldFishId, Drd.tblCheck.fldShomareHesabIdOrgan, tblShomareHesabeOmoomi_1.fldShomareHesab AS fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,tblCheck.fldTarikhAkhz,fldDateStatus,com.fn_NameAshkhasHaghighi_Hoghoghi(Drd.tblCheck.fldAshkhasId) as fldNameSaderkonandeCheck
FROM         Drd.tblCheck INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId
)t
WHERE fldNameShobe LIKE @value and fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND t.fldTarikhSarResid BETWEEN @AzTarikh AND @TaTarikh
order by fldTarikhSarResid

IF(@AzTarikh <>'' AND @TaTarikh='')
SELECT TOP(@h)  * FROM (SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ), 0) AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
                      CAST(0 AS TINYINT)) AS fldStatus, ISNULL(Drd.tblCheck.fldShomareHesabId, 0) AS fldShomareHesabId, 0 AS fldBaratDarId, 
                      CASE WHEN fldTypeSanad = 0 THEN CAST(2 AS TINYINT) ELSE CAST(6 AS TINYINT) END AS fldTypeSanad, '' AS fldMakanPardakht, Drd.tblCheck.fldUserId, 
                      Drd.tblCheck.fldDesc, Drd.tblCheck.fldDate, CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, 
                      ISNULL((CASE WHEN fldStatus = 1 THEN N'در انتظار وصول' WHEN fldStatus = 2 THEN N'وصول شده' WHEN fldStatus = 3 THEN N'برگشت خورده' WHEN fldStatus = 4 THEN
                       N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END), '') AS fldStatusName, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblBank.fldBankName, 
                      Com.tblSHobe.fldBankId, Com.tblSHobe.fldName AS fldNameShobe, Com.tblShomareHesabeOmoomi.fldShobeId, '' AS fldNameBaratDar, '' AS fldStatusFish, 
                      '' AS fldStatusFishId, NULL AS fldFishId, Drd.tblCheck.fldShomareHesabIdOrgan, tblShomareHesabeOmoomi_1.fldShomareHesab AS fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,tblCheck.fldTarikhAkhz,fldDateStatus,com.fn_NameAshkhasHaghighi_Hoghoghi(Drd.tblCheck.fldAshkhasId) as fldNameSaderkonandeCheck
FROM         Drd.tblCheck INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId
)t
WHERE fldNameShobe LIKE @value and fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND t.fldTarikhSarResid >= @AzTarikh 
order by fldTarikhSarResid

IF(@AzTarikh ='' AND @TaTarikh<>'')
SELECT TOP(@h)  * FROM (SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ), 0) AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
                      CAST(0 AS TINYINT)) AS fldStatus, ISNULL(Drd.tblCheck.fldShomareHesabId, 0) AS fldShomareHesabId, 0 AS fldBaratDarId, 
                      CASE WHEN fldTypeSanad = 0 THEN CAST(2 AS TINYINT) ELSE CAST(6 AS TINYINT) END AS fldTypeSanad, '' AS fldMakanPardakht, Drd.tblCheck.fldUserId, 
                      Drd.tblCheck.fldDesc, Drd.tblCheck.fldDate, CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, 
                      ISNULL((CASE WHEN fldStatus = 1 THEN N'در انتظار وصول' WHEN fldStatus = 2 THEN N'وصول شده' WHEN fldStatus = 3 THEN N'برگشت خورده' WHEN fldStatus = 4 THEN
                       N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END), '') AS fldStatusName, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblBank.fldBankName, 
                      Com.tblSHobe.fldBankId, Com.tblSHobe.fldName AS fldNameShobe, Com.tblShomareHesabeOmoomi.fldShobeId, '' AS fldNameBaratDar, '' AS fldStatusFish, 
                      '' AS fldStatusFishId, NULL AS fldFishId, Drd.tblCheck.fldShomareHesabIdOrgan, tblShomareHesabeOmoomi_1.fldShomareHesab AS fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,tblCheck.fldTarikhAkhz,fldDateStatus,com.fn_NameAshkhasHaghighi_Hoghoghi(Drd.tblCheck.fldAshkhasId) as fldNameSaderkonandeCheck
FROM         Drd.tblCheck INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId

)t
WHERE fldNameShobe LIKE @value and fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND t.fldTarikhSarResid <= @TaTarikh
order by fldTarikhSarResid

IF(@AzTarikh ='' AND @TaTarikh='')
SELECT TOP(@h)  * FROM (SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ), 0) AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
                      CAST(0 AS TINYINT)) AS fldStatus, ISNULL(Drd.tblCheck.fldShomareHesabId, 0) AS fldShomareHesabId, 0 AS fldBaratDarId, 
                      CASE WHEN fldTypeSanad = 0 THEN CAST(2 AS TINYINT) ELSE CAST(6 AS TINYINT) END AS fldTypeSanad, '' AS fldMakanPardakht, Drd.tblCheck.fldUserId, 
                      Drd.tblCheck.fldDesc, Drd.tblCheck.fldDate, CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, 
                      ISNULL((CASE WHEN fldStatus = 1 THEN N'در انتظار وصول' WHEN fldStatus = 2 THEN N'وصول شده' WHEN fldStatus = 3 THEN N'برگشت خورده' WHEN fldStatus = 4 THEN
                       N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END), '') AS fldStatusName, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblBank.fldBankName, 
                      Com.tblSHobe.fldBankId, Com.tblSHobe.fldName AS fldNameShobe, Com.tblShomareHesabeOmoomi.fldShobeId, '' AS fldNameBaratDar, '' AS fldStatusFish, 
                      '' AS fldStatusFishId, NULL AS fldFishId, Drd.tblCheck.fldShomareHesabIdOrgan, tblShomareHesabeOmoomi_1.fldShomareHesab AS fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL THEN (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) END
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL THEN (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) END
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL THEN (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) END
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,tblCheck.fldTarikhAkhz,fldDateStatus,com.fn_NameAshkhasHaghighi_Hoghoghi(Drd.tblCheck.fldAshkhasId) as fldNameSaderkonandeCheck
FROM         Drd.tblCheck INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId

)t
WHERE fldNameShobe LIKE @value and fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
 --and fldTarikhSarResid like @Year+'%'
order by fldTarikhSarResid
END


IF (@fieldname=N'Ejra_fldShomareHesab')
BEGIN
IF(@AzTarikh <>'' AND @TaTarikh<>'')
SELECT TOP(@h)  * FROM (SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ), 0) AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
                      CAST(0 AS TINYINT)) AS fldStatus, ISNULL(Drd.tblCheck.fldShomareHesabId, 0) AS fldShomareHesabId, 0 AS fldBaratDarId, 
                      CASE WHEN fldTypeSanad = 0 THEN CAST(2 AS TINYINT) ELSE CAST(6 AS TINYINT) END AS fldTypeSanad, '' AS fldMakanPardakht, Drd.tblCheck.fldUserId, 
                      Drd.tblCheck.fldDesc, Drd.tblCheck.fldDate, CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, 
                      ISNULL((CASE WHEN fldStatus = 1 THEN N'در انتظار وصول' WHEN fldStatus = 2 THEN N'وصول شده' WHEN fldStatus = 3 THEN N'برگشت خورده' WHEN fldStatus = 4 THEN
                       N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END), '') AS fldStatusName, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblBank.fldBankName, 
                      Com.tblSHobe.fldBankId, Com.tblSHobe.fldName AS fldNameShobe, Com.tblShomareHesabeOmoomi.fldShobeId, '' AS fldNameBaratDar, '' AS fldStatusFish, 
                      '' AS fldStatusFishId, NULL AS fldFishId, Drd.tblCheck.fldShomareHesabIdOrgan, tblShomareHesabeOmoomi_1.fldShomareHesab AS fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,tblCheck.fldTarikhAkhz,fldDateStatus,com.fn_NameAshkhasHaghighi_Hoghoghi(Drd.tblCheck.fldAshkhasId) as fldNameSaderkonandeCheck
FROM         Drd.tblCheck INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId
)t
WHERE fldShomareHesab LIKE @value and fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND t.fldTarikhSarResid BETWEEN @AzTarikh AND @TaTarikh
order by fldTarikhSarResid

IF(@AzTarikh <>'' AND @TaTarikh='')
SELECT TOP(@h)  * FROM (SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ), 0) AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
                      CAST(0 AS TINYINT)) AS fldStatus, ISNULL(Drd.tblCheck.fldShomareHesabId, 0) AS fldShomareHesabId, 0 AS fldBaratDarId, 
                      CASE WHEN fldTypeSanad = 0 THEN CAST(2 AS TINYINT) ELSE CAST(6 AS TINYINT) END AS fldTypeSanad, '' AS fldMakanPardakht, Drd.tblCheck.fldUserId, 
                      Drd.tblCheck.fldDesc, Drd.tblCheck.fldDate, CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, 
                      ISNULL((CASE WHEN fldStatus = 1 THEN N'در انتظار وصول' WHEN fldStatus = 2 THEN N'وصول شده' WHEN fldStatus = 3 THEN N'برگشت خورده' WHEN fldStatus = 4 THEN
                       N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END), '') AS fldStatusName, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblBank.fldBankName, 
                      Com.tblSHobe.fldBankId, Com.tblSHobe.fldName AS fldNameShobe, Com.tblShomareHesabeOmoomi.fldShobeId, '' AS fldNameBaratDar, '' AS fldStatusFish, 
                      '' AS fldStatusFishId, NULL AS fldFishId, Drd.tblCheck.fldShomareHesabIdOrgan, tblShomareHesabeOmoomi_1.fldShomareHesab AS fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,tblCheck.fldTarikhAkhz,fldDateStatus,com.fn_NameAshkhasHaghighi_Hoghoghi(Drd.tblCheck.fldAshkhasId) as fldNameSaderkonandeCheck
FROM         Drd.tblCheck INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId
)t
WHERE fldShomareHesab LIKE @value and fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND t.fldTarikhSarResid >= @AzTarikh 
order by fldTarikhSarResid

IF(@AzTarikh ='' AND @TaTarikh<>'')
SELECT TOP(@h)  * FROM (SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ), 0) AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
                      CAST(0 AS TINYINT)) AS fldStatus, ISNULL(Drd.tblCheck.fldShomareHesabId, 0) AS fldShomareHesabId, 0 AS fldBaratDarId, 
                      CASE WHEN fldTypeSanad = 0 THEN CAST(2 AS TINYINT) ELSE CAST(6 AS TINYINT) END AS fldTypeSanad, '' AS fldMakanPardakht, Drd.tblCheck.fldUserId, 
                      Drd.tblCheck.fldDesc, Drd.tblCheck.fldDate, CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, 
                      ISNULL((CASE WHEN fldStatus = 1 THEN N'در انتظار وصول' WHEN fldStatus = 2 THEN N'وصول شده' WHEN fldStatus = 3 THEN N'برگشت خورده' WHEN fldStatus = 4 THEN
                       N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END), '') AS fldStatusName, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblBank.fldBankName, 
                      Com.tblSHobe.fldBankId, Com.tblSHobe.fldName AS fldNameShobe, Com.tblShomareHesabeOmoomi.fldShobeId, '' AS fldNameBaratDar, '' AS fldStatusFish, 
                      '' AS fldStatusFishId, NULL AS fldFishId, Drd.tblCheck.fldShomareHesabIdOrgan, tblShomareHesabeOmoomi_1.fldShomareHesab AS fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL THEN (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) END
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL THEN (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) END
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL THEN (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) END
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,tblCheck.fldTarikhAkhz,fldDateStatus,com.fn_NameAshkhasHaghighi_Hoghoghi(Drd.tblCheck.fldAshkhasId) as fldNameSaderkonandeCheck
FROM         Drd.tblCheck INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId

)t
WHERE fldShomareHesab LIKE @value and fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND t.fldTarikhSarResid <= @TaTarikh
order by fldTarikhSarResid

IF(@AzTarikh ='' AND @TaTarikh='')
SELECT TOP(@h)  * FROM (SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ), 0) AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
                      CAST(0 AS TINYINT)) AS fldStatus, ISNULL(Drd.tblCheck.fldShomareHesabId, 0) AS fldShomareHesabId, 0 AS fldBaratDarId, 
                      CASE WHEN fldTypeSanad = 0 THEN CAST(2 AS TINYINT) ELSE CAST(6 AS TINYINT) END AS fldTypeSanad, '' AS fldMakanPardakht, Drd.tblCheck.fldUserId, 
                      Drd.tblCheck.fldDesc, Drd.tblCheck.fldDate, CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, 
                      ISNULL((CASE WHEN fldStatus = 1 THEN N'در انتظار وصول' WHEN fldStatus = 2 THEN N'وصول شده' WHEN fldStatus = 3 THEN N'برگشت خورده' WHEN fldStatus = 4 THEN
                       N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END), '') AS fldStatusName, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblBank.fldBankName, 
                      Com.tblSHobe.fldBankId, Com.tblSHobe.fldName AS fldNameShobe, Com.tblShomareHesabeOmoomi.fldShobeId, '' AS fldNameBaratDar, '' AS fldStatusFish, 
                      '' AS fldStatusFishId, NULL AS fldFishId, Drd.tblCheck.fldShomareHesabIdOrgan, tblShomareHesabeOmoomi_1.fldShomareHesab AS fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL THEN (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) END
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL THEN (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) END
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL THEN (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) END
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,tblCheck.fldTarikhAkhz,fldDateStatus,com.fn_NameAshkhasHaghighi_Hoghoghi(Drd.tblCheck.fldAshkhasId) as fldNameSaderkonandeCheck
FROM         Drd.tblCheck INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId

)t
WHERE fldShomareHesab LIKE @value and fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
 --and fldTarikhSarResid like @Year+'%'
order by fldTarikhSarResid
END


IF (@fieldname=N'Ejra_fldId')
BEGIN
IF(@AzTarikh <>'' AND @TaTarikh<>'')
SELECT TOP(@h)  * FROM (SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ), 0) AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
                      CAST(0 AS TINYINT)) AS fldStatus, ISNULL(Drd.tblCheck.fldShomareHesabId, 0) AS fldShomareHesabId, 0 AS fldBaratDarId, 
                      CASE WHEN fldTypeSanad = 0 THEN CAST(2 AS TINYINT) ELSE CAST(6 AS TINYINT) END AS fldTypeSanad, '' AS fldMakanPardakht, Drd.tblCheck.fldUserId, 
                      Drd.tblCheck.fldDesc, Drd.tblCheck.fldDate, CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, 
                      ISNULL((CASE WHEN fldStatus = 1 THEN N'در انتظار وصول' WHEN fldStatus = 2 THEN N'وصول شده' WHEN fldStatus = 3 THEN N'برگشت خورده' WHEN fldStatus = 4 THEN
                       N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END), '') AS fldStatusName, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblBank.fldBankName, 
                      Com.tblSHobe.fldBankId, Com.tblSHobe.fldName AS fldNameShobe, Com.tblShomareHesabeOmoomi.fldShobeId, '' AS fldNameBaratDar, '' AS fldStatusFish, 
                      '' AS fldStatusFishId, NULL AS fldFishId, Drd.tblCheck.fldShomareHesabIdOrgan, tblShomareHesabeOmoomi_1.fldShomareHesab AS fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,tblCheck.fldTarikhAkhz,fldDateStatus,com.fn_NameAshkhasHaghighi_Hoghoghi(Drd.tblCheck.fldAshkhasId) as fldNameSaderkonandeCheck
FROM         Drd.tblCheck INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId
)t
WHERE fldid like @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND t.fldTarikhSarResid BETWEEN @AzTarikh AND @TaTarikh
order by fldTarikhSarResid

IF(@AzTarikh <>'' AND @TaTarikh='')
SELECT TOP(@h)  * FROM (SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ), 0) AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
                      CAST(0 AS TINYINT)) AS fldStatus, ISNULL(Drd.tblCheck.fldShomareHesabId, 0) AS fldShomareHesabId, 0 AS fldBaratDarId, 
                      CASE WHEN fldTypeSanad = 0 THEN CAST(2 AS TINYINT) ELSE CAST(6 AS TINYINT) END AS fldTypeSanad, '' AS fldMakanPardakht, Drd.tblCheck.fldUserId, 
                      Drd.tblCheck.fldDesc, Drd.tblCheck.fldDate, CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, 
                      ISNULL((CASE WHEN fldStatus = 1 THEN N'در انتظار وصول' WHEN fldStatus = 2 THEN N'وصول شده' WHEN fldStatus = 3 THEN N'برگشت خورده' WHEN fldStatus = 4 THEN
                       N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END), '') AS fldStatusName, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblBank.fldBankName, 
                      Com.tblSHobe.fldBankId, Com.tblSHobe.fldName AS fldNameShobe, Com.tblShomareHesabeOmoomi.fldShobeId, '' AS fldNameBaratDar, '' AS fldStatusFish, 
                      '' AS fldStatusFishId, NULL AS fldFishId, Drd.tblCheck.fldShomareHesabIdOrgan, tblShomareHesabeOmoomi_1.fldShomareHesab AS fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,tblCheck.fldTarikhAkhz,fldDateStatus,com.fn_NameAshkhasHaghighi_Hoghoghi(Drd.tblCheck.fldAshkhasId) as fldNameSaderkonandeCheck
FROM         Drd.tblCheck INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId
)t
WHERE fldid like @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND t.fldTarikhSarResid >= @AzTarikh 
order by fldTarikhSarResid

IF(@AzTarikh ='' AND @TaTarikh<>'')
SELECT TOP(@h)  * FROM (SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ), 0) AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
                      CAST(0 AS TINYINT)) AS fldStatus, ISNULL(Drd.tblCheck.fldShomareHesabId, 0) AS fldShomareHesabId, 0 AS fldBaratDarId, 
                      CASE WHEN fldTypeSanad = 0 THEN CAST(2 AS TINYINT) ELSE CAST(6 AS TINYINT) END AS fldTypeSanad, '' AS fldMakanPardakht, Drd.tblCheck.fldUserId, 
                      Drd.tblCheck.fldDesc, Drd.tblCheck.fldDate, CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, 
                      ISNULL((CASE WHEN fldStatus = 1 THEN N'در انتظار وصول' WHEN fldStatus = 2 THEN N'وصول شده' WHEN fldStatus = 3 THEN N'برگشت خورده' WHEN fldStatus = 4 THEN
                       N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END), '') AS fldStatusName, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblBank.fldBankName, 
                      Com.tblSHobe.fldBankId, Com.tblSHobe.fldName AS fldNameShobe, Com.tblShomareHesabeOmoomi.fldShobeId, '' AS fldNameBaratDar, '' AS fldStatusFish, 
                      '' AS fldStatusFishId, NULL AS fldFishId, Drd.tblCheck.fldShomareHesabIdOrgan, tblShomareHesabeOmoomi_1.fldShomareHesab AS fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,tblCheck.fldTarikhAkhz,fldDateStatus,com.fn_NameAshkhasHaghighi_Hoghoghi(Drd.tblCheck.fldAshkhasId) as fldNameSaderkonandeCheck
FROM         Drd.tblCheck INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId

)t
WHERE fldid like @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND t.fldTarikhSarResid <= @TaTarikh
order by fldTarikhSarResid

IF(@AzTarikh ='' AND @TaTarikh='')
SELECT TOP(@h)  * FROM (SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ), 0) AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
                      CAST(0 AS TINYINT)) AS fldStatus, ISNULL(Drd.tblCheck.fldShomareHesabId, 0) AS fldShomareHesabId, 0 AS fldBaratDarId, 
                      CASE WHEN fldTypeSanad = 0 THEN CAST(2 AS TINYINT) ELSE CAST(6 AS TINYINT) END AS fldTypeSanad, '' AS fldMakanPardakht, Drd.tblCheck.fldUserId, 
                      Drd.tblCheck.fldDesc, Drd.tblCheck.fldDate, CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, 
                      ISNULL((CASE WHEN fldStatus = 1 THEN N'در انتظار وصول' WHEN fldStatus = 2 THEN N'وصول شده' WHEN fldStatus = 3 THEN N'برگشت خورده' WHEN fldStatus = 4 THEN
                       N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END), '') AS fldStatusName, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblBank.fldBankName, 
                      Com.tblSHobe.fldBankId, Com.tblSHobe.fldName AS fldNameShobe, Com.tblShomareHesabeOmoomi.fldShobeId, '' AS fldNameBaratDar, '' AS fldStatusFish, 
                      '' AS fldStatusFishId, NULL AS fldFishId, Drd.tblCheck.fldShomareHesabIdOrgan, tblShomareHesabeOmoomi_1.fldShomareHesab AS fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,tblCheck.fldTarikhAkhz,fldDateStatus,com.fn_NameAshkhasHaghighi_Hoghoghi(Drd.tblCheck.fldAshkhasId) as fldNameSaderkonandeCheck
FROM         Drd.tblCheck INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId

)t
WHERE fldId LIKE @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
 --and fldTarikhSarResid like @Year+'%'
order by fldTarikhSarResid
END

IF (@fieldname=N'Ejra_fldName')
BEGIN
IF(@AzTarikh <>'' AND @TaTarikh<>'')
SELECT TOP(@h)  * FROM (SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ), 0) AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
                      CAST(0 AS TINYINT)) AS fldStatus, ISNULL(Drd.tblCheck.fldShomareHesabId, 0) AS fldShomareHesabId, 0 AS fldBaratDarId, 
                      CASE WHEN fldTypeSanad = 0 THEN CAST(2 AS TINYINT) ELSE CAST(6 AS TINYINT) END AS fldTypeSanad, '' AS fldMakanPardakht, Drd.tblCheck.fldUserId, 
                      Drd.tblCheck.fldDesc, Drd.tblCheck.fldDate, CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, 
                      ISNULL((CASE WHEN fldStatus = 1 THEN N'در انتظار وصول' WHEN fldStatus = 2 THEN N'وصول شده' WHEN fldStatus = 3 THEN N'برگشت خورده' WHEN fldStatus = 4 THEN
                       N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END), '') AS fldStatusName, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblBank.fldBankName, 
                      Com.tblSHobe.fldBankId, Com.tblSHobe.fldName AS fldNameShobe, Com.tblShomareHesabeOmoomi.fldShobeId, '' AS fldNameBaratDar, '' AS fldStatusFish, 
                      '' AS fldStatusFishId, NULL AS fldFishId, Drd.tblCheck.fldShomareHesabIdOrgan, tblShomareHesabeOmoomi_1.fldShomareHesab AS fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,tblCheck.fldTarikhAkhz,fldDateStatus,com.fn_NameAshkhasHaghighi_Hoghoghi(Drd.tblCheck.fldAshkhasId) as fldNameSaderkonandeCheck
FROM         Drd.tblCheck INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                     Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId

)t
WHERE fldname like @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND t.fldTarikhSarResid BETWEEN @AzTarikh AND @TaTarikh
order by fldTarikhSarResid

IF(@AzTarikh <>'' AND @TaTarikh='')
SELECT TOP(@h)  * FROM (SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ), 0) AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
                      CAST(0 AS TINYINT)) AS fldStatus, ISNULL(Drd.tblCheck.fldShomareHesabId, 0) AS fldShomareHesabId, 0 AS fldBaratDarId, 
                      CASE WHEN fldTypeSanad = 0 THEN CAST(2 AS TINYINT) ELSE CAST(6 AS TINYINT) END AS fldTypeSanad, '' AS fldMakanPardakht, Drd.tblCheck.fldUserId, 
                      Drd.tblCheck.fldDesc, Drd.tblCheck.fldDate, CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, 
                      ISNULL((CASE WHEN fldStatus = 1 THEN N'در انتظار وصول' WHEN fldStatus = 2 THEN N'وصول شده' WHEN fldStatus = 3 THEN N'برگشت خورده' WHEN fldStatus = 4 THEN
                       N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END), '') AS fldStatusName, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblBank.fldBankName, 
                      Com.tblSHobe.fldBankId, Com.tblSHobe.fldName AS fldNameShobe, Com.tblShomareHesabeOmoomi.fldShobeId, '' AS fldNameBaratDar, '' AS fldStatusFish, 
                      '' AS fldStatusFishId, NULL AS fldFishId, Drd.tblCheck.fldShomareHesabIdOrgan, tblShomareHesabeOmoomi_1.fldShomareHesab AS fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,tblCheck.fldTarikhAkhz,fldDateStatus,com.fn_NameAshkhasHaghighi_Hoghoghi(Drd.tblCheck.fldAshkhasId) as fldNameSaderkonandeCheck
FROM         Drd.tblCheck INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId

)t
WHERE fldname like @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND t.fldTarikhSarResid >= @AzTarikh 
order by fldTarikhSarResid

IF(@AzTarikh ='' AND @TaTarikh<>'')
SELECT TOP(@h)  * FROM (SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ), 0) AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
                      CAST(0 AS TINYINT)) AS fldStatus, ISNULL(Drd.tblCheck.fldShomareHesabId, 0) AS fldShomareHesabId, 0 AS fldBaratDarId, 
                      CASE WHEN fldTypeSanad = 0 THEN CAST(2 AS TINYINT) ELSE CAST(6 AS TINYINT) END AS fldTypeSanad, '' AS fldMakanPardakht, Drd.tblCheck.fldUserId, 
                      Drd.tblCheck.fldDesc, Drd.tblCheck.fldDate, CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, 
                      ISNULL((CASE WHEN fldStatus = 1 THEN N'در انتظار وصول' WHEN fldStatus = 2 THEN N'وصول شده' WHEN fldStatus = 3 THEN N'برگشت خورده' WHEN fldStatus = 4 THEN
                       N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END), '') AS fldStatusName, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblBank.fldBankName, 
                      Com.tblSHobe.fldBankId, Com.tblSHobe.fldName AS fldNameShobe, Com.tblShomareHesabeOmoomi.fldShobeId, '' AS fldNameBaratDar, '' AS fldStatusFish, 
                      '' AS fldStatusFishId, NULL AS fldFishId, Drd.tblCheck.fldShomareHesabIdOrgan, tblShomareHesabeOmoomi_1.fldShomareHesab AS fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,tblCheck.fldTarikhAkhz,fldDateStatus,com.fn_NameAshkhasHaghighi_Hoghoghi(Drd.tblCheck.fldAshkhasId) as fldNameSaderkonandeCheck
FROM         Drd.tblCheck INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId


)t
WHERE fldname like @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND t.fldTarikhSarResid <= @TaTarikh
order by fldTarikhSarResid

IF(@AzTarikh ='' AND @TaTarikh='')
SELECT TOP(@h)  * FROM (SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ), 0) AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
                      CAST(0 AS TINYINT)) AS fldStatus, ISNULL(Drd.tblCheck.fldShomareHesabId, 0) AS fldShomareHesabId, 0 AS fldBaratDarId, 
                      CASE WHEN fldTypeSanad = 0 THEN CAST(2 AS TINYINT) ELSE CAST(6 AS TINYINT) END AS fldTypeSanad, '' AS fldMakanPardakht, Drd.tblCheck.fldUserId, 
                      Drd.tblCheck.fldDesc, Drd.tblCheck.fldDate, CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, 
                      ISNULL((CASE WHEN fldStatus = 1 THEN N'در انتظار وصول' WHEN fldStatus = 2 THEN N'وصول شده' WHEN fldStatus = 3 THEN N'برگشت خورده' WHEN fldStatus = 4 THEN
                       N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END), '') AS fldStatusName, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblBank.fldBankName, 
                      Com.tblSHobe.fldBankId, Com.tblSHobe.fldName AS fldNameShobe, Com.tblShomareHesabeOmoomi.fldShobeId, '' AS fldNameBaratDar, '' AS fldStatusFish, 
                      '' AS fldStatusFishId, NULL AS fldFishId, Drd.tblCheck.fldShomareHesabIdOrgan, tblShomareHesabeOmoomi_1.fldShomareHesab AS fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,tblCheck.fldTarikhAkhz,fldDateStatus,com.fn_NameAshkhasHaghighi_Hoghoghi(Drd.tblCheck.fldAshkhasId) as fldNameSaderkonandeCheck
FROM         Drd.tblCheck INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId

)t
WHERE fldName LIKE @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
 --and fldTarikhSarResid like @Year+'%'
order by fldTarikhSarResid
END

if (@fieldname=N'Ejra_fldShenaseMeli')
BEGIN
IF(@AzTarikh <>'' AND @TaTarikh<>'')
SELECT TOP(@h)  * FROM (SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ), 0) AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
                      CAST(0 AS TINYINT)) AS fldStatus, ISNULL(Drd.tblCheck.fldShomareHesabId, 0) AS fldShomareHesabId, 0 AS fldBaratDarId, 
                      CASE WHEN fldTypeSanad = 0 THEN CAST(2 AS TINYINT) ELSE CAST(6 AS TINYINT) END AS fldTypeSanad, '' AS fldMakanPardakht, Drd.tblCheck.fldUserId, 
                      Drd.tblCheck.fldDesc, Drd.tblCheck.fldDate, CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, 
                      ISNULL((CASE WHEN fldStatus = 1 THEN N'در انتظار وصول' WHEN fldStatus = 2 THEN N'وصول شده' WHEN fldStatus = 3 THEN N'برگشت خورده' WHEN fldStatus = 4 THEN
                       N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END), '') AS fldStatusName, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblBank.fldBankName, 
                      Com.tblSHobe.fldBankId, Com.tblSHobe.fldName AS fldNameShobe, Com.tblShomareHesabeOmoomi.fldShobeId, '' AS fldNameBaratDar, '' AS fldStatusFish, 
                      '' AS fldStatusFishId, NULL AS fldFishId, Drd.tblCheck.fldShomareHesabIdOrgan, tblShomareHesabeOmoomi_1.fldShomareHesab AS fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,tblCheck.fldTarikhAkhz,fldDateStatus,com.fn_NameAshkhasHaghighi_Hoghoghi(Drd.tblCheck.fldAshkhasId) as fldNameSaderkonandeCheck
FROM         Drd.tblCheck INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId

)t
WHERE t.fldShenaseMeli like @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND t.fldTarikhSarResid BETWEEN @AzTarikh AND @TaTarikh
order by fldTarikhSarResid

IF(@AzTarikh <>'' AND @TaTarikh='')
SELECT TOP(@h)  * FROM (SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ), 0) AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
                      CAST(0 AS TINYINT)) AS fldStatus, ISNULL(Drd.tblCheck.fldShomareHesabId, 0) AS fldShomareHesabId, 0 AS fldBaratDarId, 
                      CASE WHEN fldTypeSanad = 0 THEN CAST(2 AS TINYINT) ELSE CAST(6 AS TINYINT) END AS fldTypeSanad, '' AS fldMakanPardakht, Drd.tblCheck.fldUserId, 
                      Drd.tblCheck.fldDesc, Drd.tblCheck.fldDate, CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, 
                      ISNULL((CASE WHEN fldStatus = 1 THEN N'در انتظار وصول' WHEN fldStatus = 2 THEN N'وصول شده' WHEN fldStatus = 3 THEN N'برگشت خورده' WHEN fldStatus = 4 THEN
                       N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END), '') AS fldStatusName, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblBank.fldBankName, 
                      Com.tblSHobe.fldBankId, Com.tblSHobe.fldName AS fldNameShobe, Com.tblShomareHesabeOmoomi.fldShobeId, '' AS fldNameBaratDar, '' AS fldStatusFish, 
                      '' AS fldStatusFishId, NULL AS fldFishId, Drd.tblCheck.fldShomareHesabIdOrgan, tblShomareHesabeOmoomi_1.fldShomareHesab AS fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,tblCheck.fldTarikhAkhz,fldDateStatus,com.fn_NameAshkhasHaghighi_Hoghoghi(Drd.tblCheck.fldAshkhasId) as fldNameSaderkonandeCheck
FROM         Drd.tblCheck INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId

)t
WHERE t.fldShenaseMeli like @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND t.fldTarikhSarResid >= @AzTarikh 
order by fldTarikhSarResid

IF(@AzTarikh ='' AND @TaTarikh<>'')
SELECT TOP(@h)  * FROM (SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ), 0) AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
                      CAST(0 AS TINYINT)) AS fldStatus, ISNULL(Drd.tblCheck.fldShomareHesabId, 0) AS fldShomareHesabId, 0 AS fldBaratDarId, 
                      CASE WHEN fldTypeSanad = 0 THEN CAST(2 AS TINYINT) ELSE CAST(6 AS TINYINT) END AS fldTypeSanad, '' AS fldMakanPardakht, Drd.tblCheck.fldUserId, 
                      Drd.tblCheck.fldDesc, Drd.tblCheck.fldDate, CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, 
                      ISNULL((CASE WHEN fldStatus = 1 THEN N'در انتظار وصول' WHEN fldStatus = 2 THEN N'وصول شده' WHEN fldStatus = 3 THEN N'برگشت خورده' WHEN fldStatus = 4 THEN
                       N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END), '') AS fldStatusName, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblBank.fldBankName, 
                      Com.tblSHobe.fldBankId, Com.tblSHobe.fldName AS fldNameShobe, Com.tblShomareHesabeOmoomi.fldShobeId, '' AS fldNameBaratDar, '' AS fldStatusFish, 
                      '' AS fldStatusFishId, NULL AS fldFishId, Drd.tblCheck.fldShomareHesabIdOrgan, tblShomareHesabeOmoomi_1.fldShomareHesab AS fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,tblCheck.fldTarikhAkhz,fldDateStatus,com.fn_NameAshkhasHaghighi_Hoghoghi(Drd.tblCheck.fldAshkhasId) as fldNameSaderkonandeCheck
FROM         Drd.tblCheck INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId


)t
WHERE t.fldShenaseMeli like @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND t.fldTarikhSarResid <= @TaTarikh
order by fldTarikhSarResid

IF(@AzTarikh ='' AND @TaTarikh='')
SELECT TOP(@h)  * FROM (SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ), 0) AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
                      CAST(0 AS TINYINT)) AS fldStatus, ISNULL(Drd.tblCheck.fldShomareHesabId, 0) AS fldShomareHesabId, 0 AS fldBaratDarId, 
                      CASE WHEN fldTypeSanad = 0 THEN CAST(2 AS TINYINT) ELSE CAST(6 AS TINYINT) END AS fldTypeSanad, '' AS fldMakanPardakht, Drd.tblCheck.fldUserId, 
                      Drd.tblCheck.fldDesc, Drd.tblCheck.fldDate, CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, 
                      ISNULL((CASE WHEN fldStatus = 1 THEN N'در انتظار وصول' WHEN fldStatus = 2 THEN N'وصول شده' WHEN fldStatus = 3 THEN N'برگشت خورده' WHEN fldStatus = 4 THEN
                       N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END), '') AS fldStatusName, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblBank.fldBankName, 
                      Com.tblSHobe.fldBankId, Com.tblSHobe.fldName AS fldNameShobe, Com.tblShomareHesabeOmoomi.fldShobeId, '' AS fldNameBaratDar, '' AS fldStatusFish, 
                      '' AS fldStatusFishId, NULL AS fldFishId, Drd.tblCheck.fldShomareHesabIdOrgan, tblShomareHesabeOmoomi_1.fldShomareHesab AS fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,tblCheck.fldTarikhAkhz,fldDateStatus,com.fn_NameAshkhasHaghighi_Hoghoghi(Drd.tblCheck.fldAshkhasId) as fldNameSaderkonandeCheck
FROM         Drd.tblCheck INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId

)t
WHERE t.fldShenaseMeli LIKE @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
 --and fldTarikhSarResid like @Year+'%'
order by fldTarikhSarResid

END
if (@fieldname=N'Ejra_fldFather_Sabt')
BEGIN
IF(@AzTarikh <>'' AND @TaTarikh<>'')
SELECT TOP(@h)  * FROM (SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ), 0) AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
                      CAST(0 AS TINYINT)) AS fldStatus, ISNULL(Drd.tblCheck.fldShomareHesabId, 0) AS fldShomareHesabId, 0 AS fldBaratDarId, 
                      CASE WHEN fldTypeSanad = 0 THEN CAST(2 AS TINYINT) ELSE CAST(6 AS TINYINT) END AS fldTypeSanad, '' AS fldMakanPardakht, Drd.tblCheck.fldUserId, 
                      Drd.tblCheck.fldDesc, Drd.tblCheck.fldDate, CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, 
                      ISNULL((CASE WHEN fldStatus = 1 THEN N'در انتظار وصول' WHEN fldStatus = 2 THEN N'وصول شده' WHEN fldStatus = 3 THEN N'برگشت خورده' WHEN fldStatus = 4 THEN
                       N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END), '') AS fldStatusName, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblBank.fldBankName, 
                      Com.tblSHobe.fldBankId, Com.tblSHobe.fldName AS fldNameShobe, Com.tblShomareHesabeOmoomi.fldShobeId, '' AS fldNameBaratDar, '' AS fldStatusFish, 
                      '' AS fldStatusFishId, NULL AS fldFishId, Drd.tblCheck.fldShomareHesabIdOrgan, tblShomareHesabeOmoomi_1.fldShomareHesab AS fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,tblCheck.fldTarikhAkhz,fldDateStatus,com.fn_NameAshkhasHaghighi_Hoghoghi(Drd.tblCheck.fldAshkhasId) as fldNameSaderkonandeCheck
FROM         Drd.tblCheck INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId


)t
WHERE fldFather_Sabt like @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND t.fldTarikhSarResid BETWEEN @AzTarikh AND @TaTarikh
order by fldTarikhSarResid

IF(@AzTarikh <>'' AND @TaTarikh='')
SELECT TOP(@h)  * FROM (SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ), 0) AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
                      CAST(0 AS TINYINT)) AS fldStatus, ISNULL(Drd.tblCheck.fldShomareHesabId, 0) AS fldShomareHesabId, 0 AS fldBaratDarId, 
                      CASE WHEN fldTypeSanad = 0 THEN CAST(2 AS TINYINT) ELSE CAST(6 AS TINYINT) END AS fldTypeSanad, '' AS fldMakanPardakht, Drd.tblCheck.fldUserId, 
                      Drd.tblCheck.fldDesc, Drd.tblCheck.fldDate, CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, 
                      ISNULL((CASE WHEN fldStatus = 1 THEN N'در انتظار وصول' WHEN fldStatus = 2 THEN N'وصول شده' WHEN fldStatus = 3 THEN N'برگشت خورده' WHEN fldStatus = 4 THEN
                       N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END), '') AS fldStatusName, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblBank.fldBankName, 
                      Com.tblSHobe.fldBankId, Com.tblSHobe.fldName AS fldNameShobe, Com.tblShomareHesabeOmoomi.fldShobeId, '' AS fldNameBaratDar, '' AS fldStatusFish, 
                      '' AS fldStatusFishId, NULL AS fldFishId, Drd.tblCheck.fldShomareHesabIdOrgan, tblShomareHesabeOmoomi_1.fldShomareHesab AS fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,tblCheck.fldTarikhAkhz,fldDateStatus,com.fn_NameAshkhasHaghighi_Hoghoghi(Drd.tblCheck.fldAshkhasId) as fldNameSaderkonandeCheck
FROM         Drd.tblCheck INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId

)t
WHERE fldFather_Sabt like @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND t.fldTarikhSarResid >= @AzTarikh 
order by fldTarikhSarResid

IF(@AzTarikh ='' AND @TaTarikh<>'')
SELECT TOP(@h)  * FROM (SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ), 0) AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
                      CAST(0 AS TINYINT)) AS fldStatus, ISNULL(Drd.tblCheck.fldShomareHesabId, 0) AS fldShomareHesabId, 0 AS fldBaratDarId, 
                      CASE WHEN fldTypeSanad = 0 THEN CAST(2 AS TINYINT) ELSE CAST(6 AS TINYINT) END AS fldTypeSanad, '' AS fldMakanPardakht, Drd.tblCheck.fldUserId, 
                      Drd.tblCheck.fldDesc, Drd.tblCheck.fldDate, CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, 
                      ISNULL((CASE WHEN fldStatus = 1 THEN N'در انتظار وصول' WHEN fldStatus = 2 THEN N'وصول شده' WHEN fldStatus = 3 THEN N'برگشت خورده' WHEN fldStatus = 4 THEN
                       N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END), '') AS fldStatusName, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblBank.fldBankName, 
                      Com.tblSHobe.fldBankId, Com.tblSHobe.fldName AS fldNameShobe, Com.tblShomareHesabeOmoomi.fldShobeId, '' AS fldNameBaratDar, '' AS fldStatusFish, 
                      '' AS fldStatusFishId, NULL AS fldFishId, Drd.tblCheck.fldShomareHesabIdOrgan, tblShomareHesabeOmoomi_1.fldShomareHesab AS fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,tblCheck.fldTarikhAkhz,fldDateStatus,com.fn_NameAshkhasHaghighi_Hoghoghi(Drd.tblCheck.fldAshkhasId) as fldNameSaderkonandeCheck
FROM         Drd.tblCheck INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId

)t
WHERE fldFather_Sabt like @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND t.fldTarikhSarResid <= @TaTarikh
order by fldTarikhSarResid

IF(@AzTarikh ='' AND @TaTarikh='')
SELECT TOP(@h)  * FROM (SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ), 0) AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
                      CAST(0 AS TINYINT)) AS fldStatus, ISNULL(Drd.tblCheck.fldShomareHesabId, 0) AS fldShomareHesabId, 0 AS fldBaratDarId, 
                      CASE WHEN fldTypeSanad = 0 THEN CAST(2 AS TINYINT) ELSE CAST(6 AS TINYINT) END AS fldTypeSanad, '' AS fldMakanPardakht, Drd.tblCheck.fldUserId, 
                      Drd.tblCheck.fldDesc, Drd.tblCheck.fldDate, CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, 
                      ISNULL((CASE WHEN fldStatus = 1 THEN N'در انتظار وصول' WHEN fldStatus = 2 THEN N'وصول شده' WHEN fldStatus = 3 THEN N'برگشت خورده' WHEN fldStatus = 4 THEN
                       N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END), '') AS fldStatusName, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblBank.fldBankName, 
                      Com.tblSHobe.fldBankId, Com.tblSHobe.fldName AS fldNameShobe, Com.tblShomareHesabeOmoomi.fldShobeId, '' AS fldNameBaratDar, '' AS fldStatusFish, 
                      '' AS fldStatusFishId, NULL AS fldFishId, Drd.tblCheck.fldShomareHesabIdOrgan, tblShomareHesabeOmoomi_1.fldShomareHesab AS fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,tblCheck.fldTarikhAkhz,fldDateStatus,com.fn_NameAshkhasHaghighi_Hoghoghi(Drd.tblCheck.fldAshkhasId) as fldNameSaderkonandeCheck
FROM         Drd.tblCheck INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId

)t
WHERE t.fldFather_Sabt LIKE @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
 --and fldTarikhSarResid like @Year+'%'
order by fldTarikhSarResid
END

if (@fieldname=N'Ejra_fldNameBaratDar')
BEGIN
IF(@AzTarikh <>'' AND @TaTarikh<>'')
SELECT TOP(@h)  * FROM (SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ), 0) AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
                      CAST(0 AS TINYINT)) AS fldStatus, ISNULL(Drd.tblCheck.fldShomareHesabId, 0) AS fldShomareHesabId, 0 AS fldBaratDarId, 
                      CASE WHEN fldTypeSanad = 0 THEN CAST(2 AS TINYINT) ELSE CAST(6 AS TINYINT) END AS fldTypeSanad, '' AS fldMakanPardakht, Drd.tblCheck.fldUserId, 
                      Drd.tblCheck.fldDesc, Drd.tblCheck.fldDate, CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, 
                      ISNULL((CASE WHEN fldStatus = 1 THEN N'در انتظار وصول' WHEN fldStatus = 2 THEN N'وصول شده' WHEN fldStatus = 3 THEN N'برگشت خورده' WHEN fldStatus = 4 THEN
                       N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END), '') AS fldStatusName, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblBank.fldBankName, 
                      Com.tblSHobe.fldBankId, Com.tblSHobe.fldName AS fldNameShobe, Com.tblShomareHesabeOmoomi.fldShobeId, '' AS fldNameBaratDar, '' AS fldStatusFish, 
                      '' AS fldStatusFishId, NULL AS fldFishId, Drd.tblCheck.fldShomareHesabIdOrgan, tblShomareHesabeOmoomi_1.fldShomareHesab AS fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,tblCheck.fldTarikhAkhz,fldDateStatus,com.fn_NameAshkhasHaghighi_Hoghoghi(Drd.tblCheck.fldAshkhasId) as fldNameSaderkonandeCheck
FROM         Drd.tblCheck INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId

)t
WHERE fldNameBaratDar like @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND t.fldTarikhSarResid BETWEEN @AzTarikh AND @TaTarikh
order by fldTarikhSarResid

IF(@AzTarikh <>'' AND @TaTarikh='')
SELECT TOP(@h)  * FROM (SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ), 0) AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
                      CAST(0 AS TINYINT)) AS fldStatus, ISNULL(Drd.tblCheck.fldShomareHesabId, 0) AS fldShomareHesabId, 0 AS fldBaratDarId, 
                      CASE WHEN fldTypeSanad = 0 THEN CAST(2 AS TINYINT) ELSE CAST(6 AS TINYINT) END AS fldTypeSanad, '' AS fldMakanPardakht, Drd.tblCheck.fldUserId, 
                      Drd.tblCheck.fldDesc, Drd.tblCheck.fldDate, CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, 
                      ISNULL((CASE WHEN fldStatus = 1 THEN N'در انتظار وصول' WHEN fldStatus = 2 THEN N'وصول شده' WHEN fldStatus = 3 THEN N'برگشت خورده' WHEN fldStatus = 4 THEN
                       N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END), '') AS fldStatusName, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblBank.fldBankName, 
                      Com.tblSHobe.fldBankId, Com.tblSHobe.fldName AS fldNameShobe, Com.tblShomareHesabeOmoomi.fldShobeId, '' AS fldNameBaratDar, '' AS fldStatusFish, 
                      '' AS fldStatusFishId, NULL AS fldFishId, Drd.tblCheck.fldShomareHesabIdOrgan, tblShomareHesabeOmoomi_1.fldShomareHesab AS fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,tblCheck.fldTarikhAkhz,fldDateStatus,com.fn_NameAshkhasHaghighi_Hoghoghi(Drd.tblCheck.fldAshkhasId) as fldNameSaderkonandeCheck
FROM         Drd.tblCheck INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId


)t
WHERE fldNameBaratDar like @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND t.fldTarikhSarResid >= @AzTarikh 
order by fldTarikhSarResid

IF(@AzTarikh ='' AND @TaTarikh<>'')
SELECT TOP(@h)  * FROM (SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ), 0) AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
                      CAST(0 AS TINYINT)) AS fldStatus, ISNULL(Drd.tblCheck.fldShomareHesabId, 0) AS fldShomareHesabId, 0 AS fldBaratDarId, 
                      CASE WHEN fldTypeSanad = 0 THEN CAST(2 AS TINYINT) ELSE CAST(6 AS TINYINT) END AS fldTypeSanad, '' AS fldMakanPardakht, Drd.tblCheck.fldUserId, 
                      Drd.tblCheck.fldDesc, Drd.tblCheck.fldDate, CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, 
                      ISNULL((CASE WHEN fldStatus = 1 THEN N'در انتظار وصول' WHEN fldStatus = 2 THEN N'وصول شده' WHEN fldStatus = 3 THEN N'برگشت خورده' WHEN fldStatus = 4 THEN
                       N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END), '') AS fldStatusName, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblBank.fldBankName, 
                      Com.tblSHobe.fldBankId, Com.tblSHobe.fldName AS fldNameShobe, Com.tblShomareHesabeOmoomi.fldShobeId, '' AS fldNameBaratDar, '' AS fldStatusFish, 
                      '' AS fldStatusFishId, NULL AS fldFishId, Drd.tblCheck.fldShomareHesabIdOrgan, tblShomareHesabeOmoomi_1.fldShomareHesab AS fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,tblCheck.fldTarikhAkhz,fldDateStatus,com.fn_NameAshkhasHaghighi_Hoghoghi(Drd.tblCheck.fldAshkhasId) as fldNameSaderkonandeCheck
FROM         Drd.tblCheck INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId


)t
WHERE fldNameBaratDar like @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND t.fldTarikhSarResid <= @TaTarikh
order by fldTarikhSarResid

IF(@AzTarikh ='' AND @TaTarikh='')
SELECT TOP(@h)  * FROM (SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ), 0) AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
                      CAST(0 AS TINYINT)) AS fldStatus, ISNULL(Drd.tblCheck.fldShomareHesabId, 0) AS fldShomareHesabId, 0 AS fldBaratDarId, 
                      CASE WHEN fldTypeSanad = 0 THEN CAST(2 AS TINYINT) ELSE CAST(6 AS TINYINT) END AS fldTypeSanad, '' AS fldMakanPardakht, Drd.tblCheck.fldUserId, 
                      Drd.tblCheck.fldDesc, Drd.tblCheck.fldDate, CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, 
                      ISNULL((CASE WHEN fldStatus = 1 THEN N'در انتظار وصول' WHEN fldStatus = 2 THEN N'وصول شده' WHEN fldStatus = 3 THEN N'برگشت خورده' WHEN fldStatus = 4 THEN
                       N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END), '') AS fldStatusName, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblBank.fldBankName, 
                      Com.tblSHobe.fldBankId, Com.tblSHobe.fldName AS fldNameShobe, Com.tblShomareHesabeOmoomi.fldShobeId, '' AS fldNameBaratDar, '' AS fldStatusFish, 
                      '' AS fldStatusFishId, NULL AS fldFishId, Drd.tblCheck.fldShomareHesabIdOrgan, tblShomareHesabeOmoomi_1.fldShomareHesab AS fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,tblCheck.fldTarikhAkhz,fldDateStatus,com.fn_NameAshkhasHaghighi_Hoghoghi(Drd.tblCheck.fldAshkhasId) as fldNameSaderkonandeCheck
FROM         Drd.tblCheck INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId
)t
WHERE t.fldNameBaratDar LIKE @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
 --and fldTarikhSarResid like @Year+'%'
order by fldTarikhSarResid
end


if (@fieldname=N'Ejra_fldTarikhAkhz')
BEGIN
IF(@AzTarikh <>'' AND @TaTarikh<>'')
SELECT TOP(@h)  * FROM (SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ), 0) AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
                      CAST(0 AS TINYINT)) AS fldStatus, ISNULL(Drd.tblCheck.fldShomareHesabId, 0) AS fldShomareHesabId, 0 AS fldBaratDarId, 
                      CASE WHEN fldTypeSanad = 0 THEN CAST(2 AS TINYINT) ELSE CAST(6 AS TINYINT) END AS fldTypeSanad, '' AS fldMakanPardakht, Drd.tblCheck.fldUserId, 
                      Drd.tblCheck.fldDesc, Drd.tblCheck.fldDate, CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, 
                      ISNULL((CASE WHEN fldStatus = 1 THEN N'در انتظار وصول' WHEN fldStatus = 2 THEN N'وصول شده' WHEN fldStatus = 3 THEN N'برگشت خورده' WHEN fldStatus = 4 THEN
                       N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END), '') AS fldStatusName, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblBank.fldBankName, 
                      Com.tblSHobe.fldBankId, Com.tblSHobe.fldName AS fldNameShobe, Com.tblShomareHesabeOmoomi.fldShobeId, '' AS fldNameBaratDar, '' AS fldStatusFish, 
                      '' AS fldStatusFishId, NULL AS fldFishId, Drd.tblCheck.fldShomareHesabIdOrgan, tblShomareHesabeOmoomi_1.fldShomareHesab AS fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,tblCheck.fldTarikhAkhz,fldDateStatus,com.fn_NameAshkhasHaghighi_Hoghoghi(Drd.tblCheck.fldAshkhasId) as fldNameSaderkonandeCheck
FROM         Drd.tblCheck INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId

)t
WHERE fldTarikhAkhz like @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND t.fldTarikhSarResid BETWEEN @AzTarikh AND @TaTarikh
order by fldTarikhSarResid

IF(@AzTarikh <>'' AND @TaTarikh='')
SELECT TOP(@h)  * FROM (SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ), 0) AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
                      CAST(0 AS TINYINT)) AS fldStatus, ISNULL(Drd.tblCheck.fldShomareHesabId, 0) AS fldShomareHesabId, 0 AS fldBaratDarId, 
                      CASE WHEN fldTypeSanad = 0 THEN CAST(2 AS TINYINT) ELSE CAST(6 AS TINYINT) END AS fldTypeSanad, '' AS fldMakanPardakht, Drd.tblCheck.fldUserId, 
                      Drd.tblCheck.fldDesc, Drd.tblCheck.fldDate, CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, 
                      ISNULL((CASE WHEN fldStatus = 1 THEN N'در انتظار وصول' WHEN fldStatus = 2 THEN N'وصول شده' WHEN fldStatus = 3 THEN N'برگشت خورده' WHEN fldStatus = 4 THEN
                       N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END), '') AS fldStatusName, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblBank.fldBankName, 
                      Com.tblSHobe.fldBankId, Com.tblSHobe.fldName AS fldNameShobe, Com.tblShomareHesabeOmoomi.fldShobeId, '' AS fldNameBaratDar, '' AS fldStatusFish, 
                      '' AS fldStatusFishId, NULL AS fldFishId, Drd.tblCheck.fldShomareHesabIdOrgan, tblShomareHesabeOmoomi_1.fldShomareHesab AS fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,tblCheck.fldTarikhAkhz,fldDateStatus,com.fn_NameAshkhasHaghighi_Hoghoghi(Drd.tblCheck.fldAshkhasId) as fldNameSaderkonandeCheck
FROM         Drd.tblCheck INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId


)t
WHERE fldTarikhAkhz like @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND t.fldTarikhSarResid >= @AzTarikh 
order by fldTarikhSarResid

IF(@AzTarikh ='' AND @TaTarikh<>'')
SELECT TOP(@h)  * FROM (SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ), 0) AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
                      CAST(0 AS TINYINT)) AS fldStatus, ISNULL(Drd.tblCheck.fldShomareHesabId, 0) AS fldShomareHesabId, 0 AS fldBaratDarId, 
                      CASE WHEN fldTypeSanad = 0 THEN CAST(2 AS TINYINT) ELSE CAST(6 AS TINYINT) END AS fldTypeSanad, '' AS fldMakanPardakht, Drd.tblCheck.fldUserId, 
                      Drd.tblCheck.fldDesc, Drd.tblCheck.fldDate, CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, 
                      ISNULL((CASE WHEN fldStatus = 1 THEN N'در انتظار وصول' WHEN fldStatus = 2 THEN N'وصول شده' WHEN fldStatus = 3 THEN N'برگشت خورده' WHEN fldStatus = 4 THEN
                       N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END), '') AS fldStatusName, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblBank.fldBankName, 
                      Com.tblSHobe.fldBankId, Com.tblSHobe.fldName AS fldNameShobe, Com.tblShomareHesabeOmoomi.fldShobeId, '' AS fldNameBaratDar, '' AS fldStatusFish, 
                      '' AS fldStatusFishId, NULL AS fldFishId, Drd.tblCheck.fldShomareHesabIdOrgan, tblShomareHesabeOmoomi_1.fldShomareHesab AS fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,tblCheck.fldTarikhAkhz,fldDateStatus,com.fn_NameAshkhasHaghighi_Hoghoghi(Drd.tblCheck.fldAshkhasId) as fldNameSaderkonandeCheck
FROM         Drd.tblCheck INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId


)t
WHERE fldTarikhAkhz like @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND t.fldTarikhSarResid <= @TaTarikh
order by fldTarikhSarResid

IF(@AzTarikh ='' AND @TaTarikh='')
SELECT TOP(@h)  * FROM (SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ), 0) AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
                      CAST(0 AS TINYINT)) AS fldStatus, ISNULL(Drd.tblCheck.fldShomareHesabId, 0) AS fldShomareHesabId, 0 AS fldBaratDarId, 
                      CASE WHEN fldTypeSanad = 0 THEN CAST(2 AS TINYINT) ELSE CAST(6 AS TINYINT) END AS fldTypeSanad, '' AS fldMakanPardakht, Drd.tblCheck.fldUserId, 
                      Drd.tblCheck.fldDesc, Drd.tblCheck.fldDate, CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, 
                      ISNULL((CASE WHEN fldStatus = 1 THEN N'در انتظار وصول' WHEN fldStatus = 2 THEN N'وصول شده' WHEN fldStatus = 3 THEN N'برگشت خورده' WHEN fldStatus = 4 THEN
                       N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END), '') AS fldStatusName, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblBank.fldBankName, 
                      Com.tblSHobe.fldBankId, Com.tblSHobe.fldName AS fldNameShobe, Com.tblShomareHesabeOmoomi.fldShobeId, '' AS fldNameBaratDar, '' AS fldStatusFish, 
                      '' AS fldStatusFishId, NULL AS fldFishId, Drd.tblCheck.fldShomareHesabIdOrgan, tblShomareHesabeOmoomi_1.fldShomareHesab AS fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,tblCheck.fldTarikhAkhz,fldDateStatus,com.fn_NameAshkhasHaghighi_Hoghoghi(Drd.tblCheck.fldAshkhasId) as fldNameSaderkonandeCheck
FROM         Drd.tblCheck INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId
)t
WHERE t.fldTarikhAkhz LIKE @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
order by fldTarikhSarResid
end
COMMIT
GO
