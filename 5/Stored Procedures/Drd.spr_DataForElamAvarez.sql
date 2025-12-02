SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_DataForElamAvarez]

@value  nvarchar(50),
@fieldname nvarchar(50),
@AzTarikh NVARCHAR(10),
@TaTarikh NVARCHAR(10),
--@FiscalYearId int,
@h INT,
@Organid INT,
@type TINYINT

AS
begin tran
if (@h=0) set @h=2147483647
--declare  @Year varchar(4)

--select @Year=fldYear from acc.tblFiscalYear where fldId=@FiscalYearId

DECLARE @temp TABLE (fldId INT ,fldTarikhSarResid NVARCHAR(10),fldReplyTaghsitId INT,fldShomareSanad NVARCHAR(50),fldMablaghSanad bigINT,fldStatus TINYINT,fldShomareHesabId INT,fldBaratDarId INT,fldTypeSanad TINYINT,fldMakanPardakht NVARCHAR(max),
fldUserId int,fldDesc NVARCHAR(max),fldDate DATETIME,fldTypeSanadName NVARCHAR(200),fldStatusName NVARCHAR(200),fldShomareHesab NVARCHAR(150),fldBankName NVARCHAR(100),fldBankId INT,fldNameShobe NVARCHAR(150),fldShobeId INT,fldNameBaratDar NVARCHAR(200),
fldStatusFish NVARCHAR(100),fldStatusFishId NVARCHAR(50),fldFishId INT,fldShomareHesabIdOrgan INT,fldShomareHesabOrgan NVARCHAR(100),fldName NVARCHAR(200),fldShenaseMeli NVARCHAR(200),fldFather_Sabt NVARCHAR(150),fldElamAvarezId INT,fldTarikhAkhz NVARCHAR(10),fldDateStatus  NVARCHAR(10))

if (@fieldname=N'Ejra')
BEGIN
IF(@AzTarikh <>'' AND @TaTarikh<>'')
BEGIN
INSERT INTO @temp
SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ), CAST(0 AS BIGINT)) AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
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
					,tblCheck.fldTarikhAkhz,fldDateStatus
FROM         Drd.tblCheck INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId
WHERE fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND fldTarikhSarResid BETWEEN @AzTarikh AND @TaTarikh
union all
--INSERT INTO @temp
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL( cast(fldMablaghSanad as bigint),CAST(0 AS bigint)) AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0,0,CAST(3 AS TINYINT),'',fldUserId, fldDesc, fldDate
,N'سفته' AS fldTypeSanadName
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,'','',0,'',0 ,'' fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
FROM         Drd.tblSafte
WHERE fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND fldTarikhSarResid BETWEEN @AzTarikh AND @TaTarikh
union all
--INSERT INTO @temp
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL( cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT), ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
,N'برات' AS fldTypeSanadName
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,'','',0,'',0,com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId)fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
FROM         Drd.tblBarat
WHERE fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND fldTarikhSarResid BETWEEN @AzTarikh AND @TaTarikh

SELECT * FROM @temp
--WHERE fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
--AND fldTarikhSarResid BETWEEN @AzTarikh AND @TaTarikh
order by fldTarikhSarResid
end
IF(@AzTarikh <>'' AND @TaTarikh='')
BEGIN
INSERT INTO @temp
SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ), cast(0 as bigint)) AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
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
,tblCheck.fldTarikhAkhz,fldDateStatus
FROM         Drd.tblCheck INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId
					  where fldReplyTaghsitId is not null and  fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND fldTarikhSarResid >= @AzTarikh 
--INSERT INTO @temp
union all
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL( cast(fldMablaghSanad as bigint),CAST(0 AS bigint)) AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0,0,CAST(3 AS TINYINT),'',fldUserId, fldDesc, fldDate
,N'سفته' AS fldTypeSanadName
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,'','',0,'',0 ,'' fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
FROM         Drd.tblSafte
WHERE fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND fldTarikhSarResid >= @AzTarikh 
--INSERT INTO @temp
union all
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL( cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT), ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
,N'برات' AS fldTypeSanadName
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,'','',0,'',0,com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId)fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
FROM         Drd.tblBarat
WHERE fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND fldTarikhSarResid >= @AzTarikh 
SELECT * FROM @temp
--WHERE fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
--AND fldTarikhSarResid >= @AzTarikh 
order by fldTarikhSarResid
END 
IF(@AzTarikh ='' AND @TaTarikh<>'')
BEGIN
INSERT INTO @temp
SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ), cast(0 as bigint)) AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
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
,tblCheck.fldTarikhAkhz,fldDateStatus
FROM         Drd.tblCheck INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId
					  where fldReplyTaghsitId is not null and  fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND fldTarikhSarResid <= @TaTarikh
--INSERT INTO @temp
union all
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL( cast(fldMablaghSanad as bigint),CAST(0 AS bigint)) AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0,0,CAST(3 AS TINYINT),'',fldUserId, fldDesc, fldDate
,N'سفته' AS fldTypeSanadName
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,'','',0,'',0 ,'' fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
FROM         Drd.tblSafte
WHERE fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND fldTarikhSarResid <= @TaTarikh
--INSERT INTO @temp
union all
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL( cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT), ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
,N'برات' AS fldTypeSanadName
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,'','',0,'',0,com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId)fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
FROM         Drd.tblBarat
WHERE fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND fldTarikhSarResid <= @TaTarikh
SELECT *FROM @temp
--WHERE fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
--AND fldTarikhSarResid <= @TaTarikh

END
IF(@AzTarikh ='' AND @TaTarikh='')
BEGIN
INSERT INTO @temp
SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ), cast(0 as bigint)) AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
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
,tblCheck.fldTarikhAkhz,fldDateStatus
FROM         Drd.tblCheck INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId
					  where fldReplyTaghsitId is not null and   fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
					   --and fldTarikhSarResid like @Year+'%'
--INSERT INTO @temp
union all
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL( cast(fldMablaghSanad as bigint),CAST(0 AS bigint)) AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0,0,CAST(3 AS TINYINT),'',fldUserId, fldDesc, fldDate
,N'سفته' AS fldTypeSanadName
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,'','',0,'',0 ,'' fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus

FROM         Drd.tblSafte
WHERE  fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
  --and fldTarikhSarResid like @Year+'%'

--INSERT INTO @temp
union all
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL( cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT), ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
,N'برات' AS fldTypeSanadName
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,'','',0,'',0,com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId)fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
FROM         Drd.tblBarat
WHERE  fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
 --and fldTarikhSarResid like @Year+'%'
SELECT * FROM @temp
--WHERE  fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
order by fldTarikhSarResid
END


END


--IF (@fieldname=N'Ejra_fldId')
--BEGIN
--IF(@AzTarikh <>'' AND @TaTarikh<>'')
--BEGIN
--INSERT INTO @temp
--SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
--                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ), cast(0 as bigint)) AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
--                      CAST(0 AS TINYINT)) AS fldStatus, ISNULL(Drd.tblCheck.fldShomareHesabId, 0) AS fldShomareHesabId, 0 AS fldBaratDarId, 
--                      CASE WHEN fldTypeSanad = 0 THEN CAST(2 AS TINYINT) ELSE CAST(6 AS TINYINT) END AS fldTypeSanad, '' AS fldMakanPardakht, Drd.tblCheck.fldUserId, 
--                      Drd.tblCheck.fldDesc, Drd.tblCheck.fldDate, CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, 
--                      ISNULL((CASE WHEN fldStatus = 1 THEN N'در انتظار وصول' WHEN fldStatus = 2 THEN N'وصول شده' WHEN fldStatus = 3 THEN N'برگشت خورده' WHEN fldStatus = 4 THEN
--                       N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END), '') AS fldStatusName, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblBank.fldBankName, 
--                      Com.tblSHobe.fldBankId, Com.tblSHobe.fldName AS fldNameShobe, Com.tblShomareHesabeOmoomi.fldShobeId, '' AS fldNameBaratDar, '' AS fldStatusFish, 
--                      '' AS fldStatusFishId, NULL AS fldFishId, Drd.tblCheck.fldShomareHesabIdOrgan, tblShomareHesabeOmoomi_1.fldShomareHesab AS fldShomareHesabOrgan
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,tblCheck.fldTarikhAkhz,fldDateStatus
--FROM         Drd.tblCheck INNER JOIN
--                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
--                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
--                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
--                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId

--INSERT INTO @temp
--SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL( cast(fldMablaghSanad as bigint),CAST(0 AS bigint)) AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0,0,CAST(3 AS TINYINT),'',fldUserId, fldDesc, fldDate
--,N'سفته' AS fldTypeSanadName
--,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
--,'','',0,'',0 ,'' fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,com.MiladiTOShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus

--FROM         Drd.tblSafte

--INSERT INTO @temp
--SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL( cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT), ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
--,N'برات' AS fldTypeSanadName
--,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
--,'','',0,'',0,com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId)fldNameBaratDar
--,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,com.MiladiTOShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus

--FROM         Drd.tblBarat

--SELECT * FROM @temp
--WHERE fldid like @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
--AND fldTarikhSarResid BETWEEN @AzTarikh AND @TaTarikh
--END
--IF(@AzTarikh <>'' AND @TaTarikh='')
--BEGIN
--INSERT INTO @temp
--SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
--                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ), cast(0 as bigint)) AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
--                      CAST(0 AS TINYINT)) AS fldStatus, ISNULL(Drd.tblCheck.fldShomareHesabId, 0) AS fldShomareHesabId, 0 AS fldBaratDarId, 
--                      CASE WHEN fldTypeSanad = 0 THEN CAST(2 AS TINYINT) ELSE CAST(6 AS TINYINT) END AS fldTypeSanad, '' AS fldMakanPardakht, Drd.tblCheck.fldUserId, 
--                      Drd.tblCheck.fldDesc, Drd.tblCheck.fldDate, CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, 
--                      ISNULL((CASE WHEN fldStatus = 1 THEN N'در انتظار وصول' WHEN fldStatus = 2 THEN N'وصول شده' WHEN fldStatus = 3 THEN N'برگشت خورده' WHEN fldStatus = 4 THEN
--                       N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END), '') AS fldStatusName, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblBank.fldBankName, 
--                      Com.tblSHobe.fldBankId, Com.tblSHobe.fldName AS fldNameShobe, Com.tblShomareHesabeOmoomi.fldShobeId, '' AS fldNameBaratDar, '' AS fldStatusFish, 
--                      '' AS fldStatusFishId, NULL AS fldFishId, Drd.tblCheck.fldShomareHesabIdOrgan, tblShomareHesabeOmoomi_1.fldShomareHesab AS fldShomareHesabOrgan
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,tblCheck.fldTarikhAkhz,fldDateStatus
--FROM         Drd.tblCheck INNER JOIN
--                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
--                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
--                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
--                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId

--INSERT INTO @temp
--SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL( cast(fldMablaghSanad as bigint),CAST(0 AS bigint)) AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0,0,CAST(3 AS TINYINT),'',fldUserId, fldDesc, fldDate
--,N'سفته' AS fldTypeSanadName
--,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
--,'','',0,'',0 ,'' fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,com.MiladiTOShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus

--FROM         Drd.tblSafte

--INSERT INTO @temp
--SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL( cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT), ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
--,N'برات' AS fldTypeSanadName
--,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
--,'','',0,'',0,com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId)fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,com.MiladiTOShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus

--FROM         Drd.tblBarat

--SELECT * FROM @temp
--WHERE fldid like @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
--AND fldTarikhSarResid >= @AzTarikh 
--end
--IF(@AzTarikh ='' AND @TaTarikh<>'')
--BEGIN
--INSERT INTO @temp
--SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
--                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ), cast(0 as bigint)) AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
--                      CAST(0 AS TINYINT)) AS fldStatus, ISNULL(Drd.tblCheck.fldShomareHesabId, 0) AS fldShomareHesabId, 0 AS fldBaratDarId, 
--                      CASE WHEN fldTypeSanad = 0 THEN CAST(2 AS TINYINT) ELSE CAST(6 AS TINYINT) END AS fldTypeSanad, '' AS fldMakanPardakht, Drd.tblCheck.fldUserId, 
--                      Drd.tblCheck.fldDesc, Drd.tblCheck.fldDate, CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, 
--                      ISNULL((CASE WHEN fldStatus = 1 THEN N'در انتظار وصول' WHEN fldStatus = 2 THEN N'وصول شده' WHEN fldStatus = 3 THEN N'برگشت خورده' WHEN fldStatus = 4 THEN
--                       N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END), '') AS fldStatusName, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblBank.fldBankName, 
--                      Com.tblSHobe.fldBankId, Com.tblSHobe.fldName AS fldNameShobe, Com.tblShomareHesabeOmoomi.fldShobeId, '' AS fldNameBaratDar, '' AS fldStatusFish, 
--                      '' AS fldStatusFishId, NULL AS fldFishId, Drd.tblCheck.fldShomareHesabIdOrgan, tblShomareHesabeOmoomi_1.fldShomareHesab AS fldShomareHesabOrgan
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,tblCheck.fldTarikhAkhz,fldDateStatus
--FROM         Drd.tblCheck INNER JOIN
--                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
--                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
--                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
--                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId

--INSERT INTO @temp
--SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL( cast(fldMablaghSanad as bigint),CAST(0 AS bigint)) AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0,0,CAST(3 AS TINYINT),'',fldUserId, fldDesc, fldDate
--,N'سفته' AS fldTypeSanadName
--,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
--,'','',0,'',0 ,'' fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,com.MiladiTOShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus

--FROM         Drd.tblSafte

--INSERT INTO @temp
--SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL( cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT), ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
--,N'برات' AS fldTypeSanadName
--,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
--,'','',0,'',0,com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId)fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,com.MiladiTOShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus

--FROM         Drd.tblBarat

--SELECT * FROM @temp
--WHERE fldid like @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
--AND fldTarikhSarResid <= @TaTarikh
--END
--IF(@AzTarikh ='' AND @TaTarikh='')
--BEGIN
--INSERT INTO @temp
--SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
--                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ), cast(0 as bigint)) AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
--                      CAST(0 AS TINYINT)) AS fldStatus, ISNULL(Drd.tblCheck.fldShomareHesabId, 0) AS fldShomareHesabId, 0 AS fldBaratDarId, 
--                      CASE WHEN fldTypeSanad = 0 THEN CAST(2 AS TINYINT) ELSE CAST(6 AS TINYINT) END AS fldTypeSanad, '' AS fldMakanPardakht, Drd.tblCheck.fldUserId, 
--                      Drd.tblCheck.fldDesc, Drd.tblCheck.fldDate, CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, 
--                      ISNULL((CASE WHEN fldStatus = 1 THEN N'در انتظار وصول' WHEN fldStatus = 2 THEN N'وصول شده' WHEN fldStatus = 3 THEN N'برگشت خورده' WHEN fldStatus = 4 THEN
--                       N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END), '') AS fldStatusName, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblBank.fldBankName, 
--                      Com.tblSHobe.fldBankId, Com.tblSHobe.fldName AS fldNameShobe, Com.tblShomareHesabeOmoomi.fldShobeId, '' AS fldNameBaratDar, '' AS fldStatusFish, 
--                      '' AS fldStatusFishId, NULL AS fldFishId, Drd.tblCheck.fldShomareHesabIdOrgan, tblShomareHesabeOmoomi_1.fldShomareHesab AS fldShomareHesabOrgan
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,tblCheck.fldTarikhAkhz,fldDateStatus
--FROM         Drd.tblCheck INNER JOIN
--                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
--                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
--                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
--                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId

--INSERT INTO @temp
--SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL( cast(fldMablaghSanad as bigint),CAST(0 AS bigint)) AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0,0,CAST(3 AS TINYINT),'',fldUserId, fldDesc, fldDate
--,N'سفته' AS fldTypeSanadName
--,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
--,'','',0,'',0 ,'' fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,com.MiladiTOShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus

--FROM         Drd.tblSafte

--INSERT INTO @temp
--SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL( cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT), ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
--,N'برات' AS fldTypeSanadName
--,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
--,'','',0,'',0,com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId)fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,com.MiladiTOShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus

--FROM         Drd.tblBarat

--SELECT * FROM @temp
--WHERE fldId LIKE @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
--END 
--END

--IF (@fieldname=N'Ejra_fldElamAvarezId')
--BEGIN
--IF(@AzTarikh <>'' AND @TaTarikh<>'')
--BEGIN
--INSERT INTO @temp
--SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
--                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ), cast(0 as bigint)) AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
--                      CAST(0 AS TINYINT)) AS fldStatus, ISNULL(Drd.tblCheck.fldShomareHesabId, 0) AS fldShomareHesabId, 0 AS fldBaratDarId, 
--                      CASE WHEN fldTypeSanad = 0 THEN CAST(2 AS TINYINT) ELSE CAST(6 AS TINYINT) END AS fldTypeSanad, '' AS fldMakanPardakht, Drd.tblCheck.fldUserId, 
--                      Drd.tblCheck.fldDesc, Drd.tblCheck.fldDate, CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, 
--                      ISNULL((CASE WHEN fldStatus = 1 THEN N'در انتظار وصول' WHEN fldStatus = 2 THEN N'وصول شده' WHEN fldStatus = 3 THEN N'برگشت خورده' WHEN fldStatus = 4 THEN
--                       N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END), '') AS fldStatusName, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblBank.fldBankName, 
--                      Com.tblSHobe.fldBankId, Com.tblSHobe.fldName AS fldNameShobe, Com.tblShomareHesabeOmoomi.fldShobeId, '' AS fldNameBaratDar, '' AS fldStatusFish, 
--                      '' AS fldStatusFishId, NULL AS fldFishId, Drd.tblCheck.fldShomareHesabIdOrgan, tblShomareHesabeOmoomi_1.fldShomareHesab AS fldShomareHesabOrgan
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,tblCheck.fldTarikhAkhz,fldDateStatus
--FROM         Drd.tblCheck INNER JOIN
--                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
--                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
--                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
--                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId

--INSERT INTO @temp
--SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL( cast(fldMablaghSanad as bigint),CAST(0 AS bigint)) AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0,0,CAST(3 AS TINYINT),'',fldUserId, fldDesc, fldDate
--,N'سفته' AS fldTypeSanadName
--,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
--,'','',0,'',0 ,'' fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,com.MiladiTOShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus

--FROM         Drd.tblSafte

--INSERT INTO @temp
--SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL( cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT), ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
--,N'برات' AS fldTypeSanadName
--,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
--,'','',0,'',0,com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId)fldNameBaratDar
--,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,com.MiladiTOShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus

--FROM         Drd.tblBarat

--SELECT * FROM @temp
--WHERE fldElamAvarezId like @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
--AND fldTarikhSarResid BETWEEN @AzTarikh AND @TaTarikh
--END
--IF(@AzTarikh <>'' AND @TaTarikh='')
--BEGIN
--INSERT INTO @temp
--SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
--                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ), cast(0 as bigint)) AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
--                      CAST(0 AS TINYINT)) AS fldStatus, ISNULL(Drd.tblCheck.fldShomareHesabId, 0) AS fldShomareHesabId, 0 AS fldBaratDarId, 
--                      CASE WHEN fldTypeSanad = 0 THEN CAST(2 AS TINYINT) ELSE CAST(6 AS TINYINT) END AS fldTypeSanad, '' AS fldMakanPardakht, Drd.tblCheck.fldUserId, 
--                      Drd.tblCheck.fldDesc, Drd.tblCheck.fldDate, CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, 
--                      ISNULL((CASE WHEN fldStatus = 1 THEN N'در انتظار وصول' WHEN fldStatus = 2 THEN N'وصول شده' WHEN fldStatus = 3 THEN N'برگشت خورده' WHEN fldStatus = 4 THEN
--                       N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END), '') AS fldStatusName, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblBank.fldBankName, 
--                      Com.tblSHobe.fldBankId, Com.tblSHobe.fldName AS fldNameShobe, Com.tblShomareHesabeOmoomi.fldShobeId, '' AS fldNameBaratDar, '' AS fldStatusFish, 
--                      '' AS fldStatusFishId, NULL AS fldFishId, Drd.tblCheck.fldShomareHesabIdOrgan, tblShomareHesabeOmoomi_1.fldShomareHesab AS fldShomareHesabOrgan
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,tblCheck.fldTarikhAkhz,fldDateStatus

--FROM         Drd.tblCheck INNER JOIN
--                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
--                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
--                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
--                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId

--INSERT INTO @temp
--SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL( cast(fldMablaghSanad as bigint),CAST(0 AS bigint)) AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0,0,CAST(3 AS TINYINT),'',fldUserId, fldDesc, fldDate
--,N'سفته' AS fldTypeSanadName
--,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
--,'','',0,'',0 ,'' fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,com.MiladiTOShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus

--FROM         Drd.tblSafte

--INSERT INTO @temp
--SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL( cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT), ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
--,N'برات' AS fldTypeSanadName
--,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
--,'','',0,'',0,com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId)fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,com.MiladiTOShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus

--FROM         Drd.tblBarat

--SELECT * FROM @temp
--WHERE fldElamAvarezId like @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
--AND fldTarikhSarResid >= @AzTarikh 
--end
--IF(@AzTarikh ='' AND @TaTarikh<>'')
--BEGIN
--INSERT INTO @temp
--SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
--                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ), cast(0 as bigint)) AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
--                      CAST(0 AS TINYINT)) AS fldStatus, ISNULL(Drd.tblCheck.fldShomareHesabId, 0) AS fldShomareHesabId, 0 AS fldBaratDarId, 
--                      CASE WHEN fldTypeSanad = 0 THEN CAST(2 AS TINYINT) ELSE CAST(6 AS TINYINT) END AS fldTypeSanad, '' AS fldMakanPardakht, Drd.tblCheck.fldUserId, 
--                      Drd.tblCheck.fldDesc, Drd.tblCheck.fldDate, CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, 
--                      ISNULL((CASE WHEN fldStatus = 1 THEN N'در انتظار وصول' WHEN fldStatus = 2 THEN N'وصول شده' WHEN fldStatus = 3 THEN N'برگشت خورده' WHEN fldStatus = 4 THEN
--                       N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END), '') AS fldStatusName, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblBank.fldBankName, 
--                      Com.tblSHobe.fldBankId, Com.tblSHobe.fldName AS fldNameShobe, Com.tblShomareHesabeOmoomi.fldShobeId, '' AS fldNameBaratDar, '' AS fldStatusFish, 
--                      '' AS fldStatusFishId, NULL AS fldFishId, Drd.tblCheck.fldShomareHesabIdOrgan, tblShomareHesabeOmoomi_1.fldShomareHesab AS fldShomareHesabOrgan
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,tblCheck.fldTarikhAkhz,fldDateStatus
--FROM         Drd.tblCheck INNER JOIN
--                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
--                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
--                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
--                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId

--INSERT INTO @temp
--SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL( cast(fldMablaghSanad as bigint),CAST(0 AS bigint)) AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0,0,CAST(3 AS TINYINT),'',fldUserId, fldDesc, fldDate
--,N'سفته' AS fldTypeSanadName
--,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
--,'','',0,'',0 ,'' fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,com.MiladiTOShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus

--FROM         Drd.tblSafte

--INSERT INTO @temp
--SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL( cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT), ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
--,N'برات' AS fldTypeSanadName
--,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
--,'','',0,'',0,com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId)fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,com.MiladiTOShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus

--FROM         Drd.tblBarat


--SELECT * FROM @temp
--WHERE fldElamAvarezId like @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
--AND fldTarikhSarResid <= @TaTarikh
--END
--IF(@AzTarikh ='' AND @TaTarikh='')
--BEGIN
--INSERT INTO @temp
--SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
--                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ), cast(0 as bigint)) AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
--                      CAST(0 AS TINYINT)) AS fldStatus, ISNULL(Drd.tblCheck.fldShomareHesabId, 0) AS fldShomareHesabId, 0 AS fldBaratDarId, 
--                      CASE WHEN fldTypeSanad = 0 THEN CAST(2 AS TINYINT) ELSE CAST(6 AS TINYINT) END AS fldTypeSanad, '' AS fldMakanPardakht, Drd.tblCheck.fldUserId, 
--                      Drd.tblCheck.fldDesc, Drd.tblCheck.fldDate, CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, 
--                      ISNULL((CASE WHEN fldStatus = 1 THEN N'در انتظار وصول' WHEN fldStatus = 2 THEN N'وصول شده' WHEN fldStatus = 3 THEN N'برگشت خورده' WHEN fldStatus = 4 THEN
--                       N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END), '') AS fldStatusName, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblBank.fldBankName, 
--                      Com.tblSHobe.fldBankId, Com.tblSHobe.fldName AS fldNameShobe, Com.tblShomareHesabeOmoomi.fldShobeId, '' AS fldNameBaratDar, '' AS fldStatusFish, 
--                      '' AS fldStatusFishId, NULL AS fldFishId, Drd.tblCheck.fldShomareHesabIdOrgan, tblShomareHesabeOmoomi_1.fldShomareHesab AS fldShomareHesabOrgan
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,tblCheck.fldTarikhAkhz,fldDateStatus
--FROM         Drd.tblCheck INNER JOIN
--                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
--                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
--                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
--                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId

--INSERT INTO @temp
--SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL( cast(fldMablaghSanad as bigint),CAST(0 AS bigint)) AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0,0,CAST(3 AS TINYINT),'',fldUserId, fldDesc, fldDate
--,N'سفته' AS fldTypeSanadName
--,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
--,'','',0,'',0 ,'' fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,com.MiladiTOShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus

--FROM         Drd.tblSafte

--INSERT INTO @temp
--SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL( cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT), ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
--,N'برات' AS fldTypeSanadName
--,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
--,'','',0,'',0,com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId)fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,com.MiladiTOShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus

--FROM         Drd.tblBarat

--SELECT * FROM @temp
--WHERE fldElamAvarezId LIKE @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
--END 
--END



--IF (@fieldname=N'Ejra_fldDateStatus')
--BEGIN
--IF(@AzTarikh <>'' AND @TaTarikh<>'')
--BEGIN
--INSERT INTO @temp
--SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
--                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ), cast(0 as bigint)) AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
--                      CAST(0 AS TINYINT)) AS fldStatus, ISNULL(Drd.tblCheck.fldShomareHesabId, 0) AS fldShomareHesabId, 0 AS fldBaratDarId, 
--                      CASE WHEN fldTypeSanad = 0 THEN CAST(2 AS TINYINT) ELSE CAST(6 AS TINYINT) END AS fldTypeSanad, '' AS fldMakanPardakht, Drd.tblCheck.fldUserId, 
--                      Drd.tblCheck.fldDesc, Drd.tblCheck.fldDate, CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, 
--                      ISNULL((CASE WHEN fldStatus = 1 THEN N'در انتظار وصول' WHEN fldStatus = 2 THEN N'وصول شده' WHEN fldStatus = 3 THEN N'برگشت خورده' WHEN fldStatus = 4 THEN
--                       N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END), '') AS fldStatusName, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblBank.fldBankName, 
--                      Com.tblSHobe.fldBankId, Com.tblSHobe.fldName AS fldNameShobe, Com.tblShomareHesabeOmoomi.fldShobeId, '' AS fldNameBaratDar, '' AS fldStatusFish, 
--                      '' AS fldStatusFishId, NULL AS fldFishId, Drd.tblCheck.fldShomareHesabIdOrgan, tblShomareHesabeOmoomi_1.fldShomareHesab AS fldShomareHesabOrgan
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,tblCheck.fldTarikhAkhz,fldDateStatus
--FROM         Drd.tblCheck INNER JOIN
--                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
--                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
--                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
--                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId

--INSERT INTO @temp
--SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL( cast(fldMablaghSanad as bigint),CAST(0 AS bigint)) AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0,0,CAST(3 AS TINYINT),'',fldUserId, fldDesc, fldDate
--,N'سفته' AS fldTypeSanadName
--,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
--,'','',0,'',0 ,'' fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,com.MiladiTOShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus

--FROM         Drd.tblSafte

--INSERT INTO @temp
--SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL( cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT), ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
--,N'برات' AS fldTypeSanadName
--,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
--,'','',0,'',0,com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId)fldNameBaratDar
--,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,com.MiladiTOShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus

--FROM         Drd.tblBarat

--SELECT * FROM @temp
--WHERE fldDateStatus like @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
--AND fldTarikhSarResid BETWEEN @AzTarikh AND @TaTarikh
--END
--IF(@AzTarikh <>'' AND @TaTarikh='')
--BEGIN
--INSERT INTO @temp
--SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
--                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ), cast(0 as bigint)) AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
--                      CAST(0 AS TINYINT)) AS fldStatus, ISNULL(Drd.tblCheck.fldShomareHesabId, 0) AS fldShomareHesabId, 0 AS fldBaratDarId, 
--                      CASE WHEN fldTypeSanad = 0 THEN CAST(2 AS TINYINT) ELSE CAST(6 AS TINYINT) END AS fldTypeSanad, '' AS fldMakanPardakht, Drd.tblCheck.fldUserId, 
--                      Drd.tblCheck.fldDesc, Drd.tblCheck.fldDate, CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, 
--                      ISNULL((CASE WHEN fldStatus = 1 THEN N'در انتظار وصول' WHEN fldStatus = 2 THEN N'وصول شده' WHEN fldStatus = 3 THEN N'برگشت خورده' WHEN fldStatus = 4 THEN
--                       N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END), '') AS fldStatusName, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblBank.fldBankName, 
--                      Com.tblSHobe.fldBankId, Com.tblSHobe.fldName AS fldNameShobe, Com.tblShomareHesabeOmoomi.fldShobeId, '' AS fldNameBaratDar, '' AS fldStatusFish, 
--                      '' AS fldStatusFishId, NULL AS fldFishId, Drd.tblCheck.fldShomareHesabIdOrgan, tblShomareHesabeOmoomi_1.fldShomareHesab AS fldShomareHesabOrgan
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,tblCheck.fldTarikhAkhz,fldDateStatus

--FROM         Drd.tblCheck INNER JOIN
--                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
--                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
--                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
--                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId

--INSERT INTO @temp
--SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL( cast(fldMablaghSanad as bigint),CAST(0 AS bigint)) AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0,0,CAST(3 AS TINYINT),'',fldUserId, fldDesc, fldDate
--,N'سفته' AS fldTypeSanadName
--,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
--,'','',0,'',0 ,'' fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,com.MiladiTOShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus

--FROM         Drd.tblSafte

--INSERT INTO @temp
--SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL( cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT), ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
--,N'برات' AS fldTypeSanadName
--,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
--,'','',0,'',0,com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId)fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,com.MiladiTOShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus

--FROM         Drd.tblBarat

--SELECT * FROM @temp
--WHERE fldDateStatus like @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
--AND fldTarikhSarResid >= @AzTarikh 
--end
--IF(@AzTarikh ='' AND @TaTarikh<>'')
--BEGIN
--INSERT INTO @temp
--SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
--                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ), cast(0 as bigint)) AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
--                      CAST(0 AS TINYINT)) AS fldStatus, ISNULL(Drd.tblCheck.fldShomareHesabId, 0) AS fldShomareHesabId, 0 AS fldBaratDarId, 
--                      CASE WHEN fldTypeSanad = 0 THEN CAST(2 AS TINYINT) ELSE CAST(6 AS TINYINT) END AS fldTypeSanad, '' AS fldMakanPardakht, Drd.tblCheck.fldUserId, 
--                      Drd.tblCheck.fldDesc, Drd.tblCheck.fldDate, CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, 
--                      ISNULL((CASE WHEN fldStatus = 1 THEN N'در انتظار وصول' WHEN fldStatus = 2 THEN N'وصول شده' WHEN fldStatus = 3 THEN N'برگشت خورده' WHEN fldStatus = 4 THEN
--                       N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END), '') AS fldStatusName, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblBank.fldBankName, 
--                      Com.tblSHobe.fldBankId, Com.tblSHobe.fldName AS fldNameShobe, Com.tblShomareHesabeOmoomi.fldShobeId, '' AS fldNameBaratDar, '' AS fldStatusFish, 
--                      '' AS fldStatusFishId, NULL AS fldFishId, Drd.tblCheck.fldShomareHesabIdOrgan, tblShomareHesabeOmoomi_1.fldShomareHesab AS fldShomareHesabOrgan
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,tblCheck.fldTarikhAkhz,fldDateStatus
--FROM         Drd.tblCheck INNER JOIN
--                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
--                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
--                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
--                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId

--INSERT INTO @temp
--SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL( cast(fldMablaghSanad as bigint),CAST(0 AS bigint)) AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0,0,CAST(3 AS TINYINT),'',fldUserId, fldDesc, fldDate
--,N'سفته' AS fldTypeSanadName
--,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
--,'','',0,'',0 ,'' fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,com.MiladiTOShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus

--FROM         Drd.tblSafte

--INSERT INTO @temp
--SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL( cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT), ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
--,N'برات' AS fldTypeSanadName
--,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
--,'','',0,'',0,com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId)fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,com.MiladiTOShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus

--FROM         Drd.tblBarat


--SELECT * FROM @temp
--WHERE fldDateStatus like @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
--AND fldTarikhSarResid <= @TaTarikh
--END
--IF(@AzTarikh ='' AND @TaTarikh='')
--BEGIN
--INSERT INTO @temp
--SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
--                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ), cast(0 as bigint)) AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
--                      CAST(0 AS TINYINT)) AS fldStatus, ISNULL(Drd.tblCheck.fldShomareHesabId, 0) AS fldShomareHesabId, 0 AS fldBaratDarId, 
--                      CASE WHEN fldTypeSanad = 0 THEN CAST(2 AS TINYINT) ELSE CAST(6 AS TINYINT) END AS fldTypeSanad, '' AS fldMakanPardakht, Drd.tblCheck.fldUserId, 
--                      Drd.tblCheck.fldDesc, Drd.tblCheck.fldDate, CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, 
--                      ISNULL((CASE WHEN fldStatus = 1 THEN N'در انتظار وصول' WHEN fldStatus = 2 THEN N'وصول شده' WHEN fldStatus = 3 THEN N'برگشت خورده' WHEN fldStatus = 4 THEN
--                       N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END), '') AS fldStatusName, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblBank.fldBankName, 
--                      Com.tblSHobe.fldBankId, Com.tblSHobe.fldName AS fldNameShobe, Com.tblShomareHesabeOmoomi.fldShobeId, '' AS fldNameBaratDar, '' AS fldStatusFish, 
--                      '' AS fldStatusFishId, NULL AS fldFishId, Drd.tblCheck.fldShomareHesabIdOrgan, tblShomareHesabeOmoomi_1.fldShomareHesab AS fldShomareHesabOrgan
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,tblCheck.fldTarikhAkhz,fldDateStatus
--FROM         Drd.tblCheck INNER JOIN
--                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
--                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
--                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
--                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId

--INSERT INTO @temp
--SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL( cast(fldMablaghSanad as bigint),CAST(0 AS bigint)) AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0,0,CAST(3 AS TINYINT),'',fldUserId, fldDesc, fldDate
--,N'سفته' AS fldTypeSanadName
--,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
--,'','',0,'',0 ,'' fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,com.MiladiTOShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus

--FROM         Drd.tblSafte

--INSERT INTO @temp
--SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL( cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT), ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
--,N'برات' AS fldTypeSanadName
--,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
--,'','',0,'',0,com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId)fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,com.MiladiTOShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus

--FROM         Drd.tblBarat

--SELECT * FROM @temp
--WHERE fldDateStatus LIKE @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
--END 
--END



--IF (@fieldname=N'Ejra_fldName')
--BEGIN
--IF(@AzTarikh <>'' AND @TaTarikh<>'')
--BEGIN
--INSERT INTO @temp
--SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
--                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ), cast(0 as bigint)) AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
--                      CAST(0 AS TINYINT)) AS fldStatus, ISNULL(Drd.tblCheck.fldShomareHesabId, 0) AS fldShomareHesabId, 0 AS fldBaratDarId, 
--                      CASE WHEN fldTypeSanad = 0 THEN CAST(2 AS TINYINT) ELSE CAST(6 AS TINYINT) END AS fldTypeSanad, '' AS fldMakanPardakht, Drd.tblCheck.fldUserId, 
--                      Drd.tblCheck.fldDesc, Drd.tblCheck.fldDate, CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, 
--                      ISNULL((CASE WHEN fldStatus = 1 THEN N'در انتظار وصول' WHEN fldStatus = 2 THEN N'وصول شده' WHEN fldStatus = 3 THEN N'برگشت خورده' WHEN fldStatus = 4 THEN
--                       N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END), '') AS fldStatusName, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblBank.fldBankName, 
--                      Com.tblSHobe.fldBankId, Com.tblSHobe.fldName AS fldNameShobe, Com.tblShomareHesabeOmoomi.fldShobeId, '' AS fldNameBaratDar, '' AS fldStatusFish, 
--                      '' AS fldStatusFishId, NULL AS fldFishId, Drd.tblCheck.fldShomareHesabIdOrgan, tblShomareHesabeOmoomi_1.fldShomareHesab AS fldShomareHesabOrgan
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,tblCheck.fldTarikhAkhz,fldDateStatus
--FROM         Drd.tblCheck INNER JOIN
--                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
--                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
--                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
--                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId

--INSERT INTO @temp
--SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL( cast(fldMablaghSanad as bigint),CAST(0 AS bigint)) AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0,0,CAST(3 AS TINYINT),'',fldUserId, fldDesc, fldDate
--,N'سفته' AS fldTypeSanadName
--,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
--,'','',0,'',0 ,'' fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,com.MiladiTOShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus

--FROM         Drd.tblSafte

--INSERT INTO @temp
--SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL( cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT), ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
--,N'برات' AS fldTypeSanadName
--,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
--,'','',0,'',0,com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId)fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,com.MiladiTOShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
--FROM         Drd.tblBarat

--select * FROM @temp
--WHERE fldname like @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
--AND fldTarikhSarResid BETWEEN @AzTarikh AND @TaTarikh
--END
--IF(@AzTarikh <>'' AND @TaTarikh='')
--BEGIN
--INSERT INTO @temp
--SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
--                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ), cast(0 as bigint)) AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
--                      CAST(0 AS TINYINT)) AS fldStatus, ISNULL(Drd.tblCheck.fldShomareHesabId, 0) AS fldShomareHesabId, 0 AS fldBaratDarId, 
--                      CASE WHEN fldTypeSanad = 0 THEN CAST(2 AS TINYINT) ELSE CAST(6 AS TINYINT) END AS fldTypeSanad, '' AS fldMakanPardakht, Drd.tblCheck.fldUserId, 
--                      Drd.tblCheck.fldDesc, Drd.tblCheck.fldDate, CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, 
--                      ISNULL((CASE WHEN fldStatus = 1 THEN N'در انتظار وصول' WHEN fldStatus = 2 THEN N'وصول شده' WHEN fldStatus = 3 THEN N'برگشت خورده' WHEN fldStatus = 4 THEN
--                       N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END), '') AS fldStatusName, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblBank.fldBankName, 
--                      Com.tblSHobe.fldBankId, Com.tblSHobe.fldName AS fldNameShobe, Com.tblShomareHesabeOmoomi.fldShobeId, '' AS fldNameBaratDar, '' AS fldStatusFish, 
--                      '' AS fldStatusFishId, NULL AS fldFishId, Drd.tblCheck.fldShomareHesabIdOrgan, tblShomareHesabeOmoomi_1.fldShomareHesab AS fldShomareHesabOrgan
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,tblCheck.fldTarikhAkhz,fldDateStatus
--FROM         Drd.tblCheck INNER JOIN
--                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
--                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
--                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
--                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId

--INSERT INTO @temp
--SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL( cast(fldMablaghSanad as bigint),CAST(0 AS bigint)) AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0,0,CAST(3 AS TINYINT),'',fldUserId, fldDesc, fldDate
--,N'سفته' AS fldTypeSanadName
--,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
--,'','',0,'',0 ,'' fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,com.MiladiTOShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
--FROM         Drd.tblSafte

--INSERT INTO @temp
--SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL( cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT), ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
--,N'برات' AS fldTypeSanadName
--,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
--,'','',0,'',0,com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId)fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,com.MiladiTOShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus

--FROM         Drd.tblBarat

--SELECT * FROM @temp
--WHERE fldname like @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
--AND fldTarikhSarResid >= @AzTarikh 
--END
--IF(@AzTarikh ='' AND @TaTarikh<>'')
--BEGIN
--INSERT INTO @temp
--SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
--                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ), cast(0 as bigint)) AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
--                      CAST(0 AS TINYINT)) AS fldStatus, ISNULL(Drd.tblCheck.fldShomareHesabId, 0) AS fldShomareHesabId, 0 AS fldBaratDarId, 
--                      CASE WHEN fldTypeSanad = 0 THEN CAST(2 AS TINYINT) ELSE CAST(6 AS TINYINT) END AS fldTypeSanad, '' AS fldMakanPardakht, Drd.tblCheck.fldUserId, 
--                      Drd.tblCheck.fldDesc, Drd.tblCheck.fldDate, CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, 
--                      ISNULL((CASE WHEN fldStatus = 1 THEN N'در انتظار وصول' WHEN fldStatus = 2 THEN N'وصول شده' WHEN fldStatus = 3 THEN N'برگشت خورده' WHEN fldStatus = 4 THEN
--                       N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END), '') AS fldStatusName, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblBank.fldBankName, 
--                      Com.tblSHobe.fldBankId, Com.tblSHobe.fldName AS fldNameShobe, Com.tblShomareHesabeOmoomi.fldShobeId, '' AS fldNameBaratDar, '' AS fldStatusFish, 
--                      '' AS fldStatusFishId, NULL AS fldFishId, Drd.tblCheck.fldShomareHesabIdOrgan, tblShomareHesabeOmoomi_1.fldShomareHesab AS fldShomareHesabOrgan
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,tblCheck.fldTarikhAkhz,fldDateStatus
--FROM         Drd.tblCheck INNER JOIN
--                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
--                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
--                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
--                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId

--INSERT INTO @temp
--SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL( cast(fldMablaghSanad as bigint),CAST(0 AS bigint)) AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0,0,CAST(3 AS TINYINT),'',fldUserId, fldDesc, fldDate
--,N'سفته' AS fldTypeSanadName
--,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
--,'','',0,'',0 ,'' fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,com.MiladiTOShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus

--FROM         Drd.tblSafte

--INSERT INTO @temp
--SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL( cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT), ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
--,N'برات' AS fldTypeSanadName
--,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
--,'','',0,'',0,com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId)fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,com.MiladiTOShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus

--FROM         Drd.tblBarat

--SELECT * FROM @temp
--WHERE fldname like @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
--AND fldTarikhSarResid <= @TaTarikh
--end
--IF(@AzTarikh ='' AND @TaTarikh='')
--BEGIN
--INSERT INTO @temp
--SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
--                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ), cast(0 as bigint)) AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
--                      CAST(0 AS TINYINT)) AS fldStatus, ISNULL(Drd.tblCheck.fldShomareHesabId, 0) AS fldShomareHesabId, 0 AS fldBaratDarId, 
--                      CASE WHEN fldTypeSanad = 0 THEN CAST(2 AS TINYINT) ELSE CAST(6 AS TINYINT) END AS fldTypeSanad, '' AS fldMakanPardakht, Drd.tblCheck.fldUserId, 
--                      Drd.tblCheck.fldDesc, Drd.tblCheck.fldDate, CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, 
--                      ISNULL((CASE WHEN fldStatus = 1 THEN N'در انتظار وصول' WHEN fldStatus = 2 THEN N'وصول شده' WHEN fldStatus = 3 THEN N'برگشت خورده' WHEN fldStatus = 4 THEN
--                       N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END), '') AS fldStatusName, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblBank.fldBankName, 
--                      Com.tblSHobe.fldBankId, Com.tblSHobe.fldName AS fldNameShobe, Com.tblShomareHesabeOmoomi.fldShobeId, '' AS fldNameBaratDar, '' AS fldStatusFish, 
--                      '' AS fldStatusFishId, NULL AS fldFishId, Drd.tblCheck.fldShomareHesabIdOrgan, tblShomareHesabeOmoomi_1.fldShomareHesab AS fldShomareHesabOrgan
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,tblCheck.fldTarikhAkhz,fldDateStatus
--FROM         Drd.tblCheck INNER JOIN
--                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
--                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
--                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
--                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId

--INSERT INTO @temp
--SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL( cast(fldMablaghSanad as bigint),CAST(0 AS bigint)) AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0,0,CAST(3 AS TINYINT),'',fldUserId, fldDesc, fldDate
--,N'سفته' AS fldTypeSanadName
--,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
--,'','',0,'',0 ,'' fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,com.MiladiTOShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus

--FROM         Drd.tblSafte

--INSERT INTO @temp
--SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL( cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT), ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
--,N'برات' AS fldTypeSanadName
--,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
--,'','',0,'',0,com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId)fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,com.MiladiTOShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus

--FROM         Drd.tblBarat
--SELECT * FROM @temp
--WHERE fldName LIKE @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
--end
--END


--/*IF (@fieldname=N'Ejra_fldMablaghSanad')
--BEGIN
--IF(@AzTarikh <>'' AND @TaTarikh<>'')
--BEGIN
--INSERT INTO @temp
--SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
--                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ), cast(0 as bigint)) AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
--                      CAST(0 AS TINYINT)) AS fldStatus, ISNULL(Drd.tblCheck.fldShomareHesabId, 0) AS fldShomareHesabId, 0 AS fldBaratDarId, 
--                      CASE WHEN fldTypeSanad = 0 THEN CAST(2 AS TINYINT) ELSE CAST(6 AS TINYINT) END AS fldTypeSanad, '' AS fldMakanPardakht, Drd.tblCheck.fldUserId, 
--                      Drd.tblCheck.fldDesc, Drd.tblCheck.fldDate, CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, 
--                      ISNULL((CASE WHEN fldStatus = 1 THEN N'در انتظار وصول' WHEN fldStatus = 2 THEN N'وصول شده' WHEN fldStatus = 3 THEN N'برگشت خورده' WHEN fldStatus = 4 THEN
--                       N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END), '') AS fldStatusName, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblBank.fldBankName, 
--                      Com.tblSHobe.fldBankId, Com.tblSHobe.fldName AS fldNameShobe, Com.tblShomareHesabeOmoomi.fldShobeId, '' AS fldNameBaratDar, '' AS fldStatusFish, 
--                      '' AS fldStatusFishId, NULL AS fldFishId, Drd.tblCheck.fldShomareHesabIdOrgan, tblShomareHesabeOmoomi_1.fldShomareHesab AS fldShomareHesabOrgan
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,tblCheck.fldTarikhAkhz,fldDateStatus
--FROM         Drd.tblCheck INNER JOIN
--                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
--                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
--                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
--                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId

--INSERT INTO @temp
--SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL( cast(fldMablaghSanad as bigint),CAST(0 AS bigint)) AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0,0,CAST(3 AS TINYINT),'',fldUserId, fldDesc, fldDate
--,N'سفته' AS fldTypeSanadName
--,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
--,'','',0,'',0 ,'' fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,com.MiladiTOShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus

--FROM         Drd.tblSafte

--INSERT INTO @temp
--SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL( cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT), ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
--,N'برات' AS fldTypeSanadName
--,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
--,'','',0,'',0,com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId)fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,com.MiladiTOShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
--FROM         Drd.tblBarat

--select * FROM @temp
--WHERE fldMablaghSanad like @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
--AND fldTarikhSarResid BETWEEN @AzTarikh AND @TaTarikh
--END
--IF(@AzTarikh <>'' AND @TaTarikh='')
--BEGIN
--INSERT INTO @temp
--SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
--                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ), cast(0 as bigint)) AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
--                      CAST(0 AS TINYINT)) AS fldStatus, ISNULL(Drd.tblCheck.fldShomareHesabId, 0) AS fldShomareHesabId, 0 AS fldBaratDarId, 
--                      CASE WHEN fldTypeSanad = 0 THEN CAST(2 AS TINYINT) ELSE CAST(6 AS TINYINT) END AS fldTypeSanad, '' AS fldMakanPardakht, Drd.tblCheck.fldUserId, 
--                      Drd.tblCheck.fldDesc, Drd.tblCheck.fldDate, CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, 
--                      ISNULL((CASE WHEN fldStatus = 1 THEN N'در انتظار وصول' WHEN fldStatus = 2 THEN N'وصول شده' WHEN fldStatus = 3 THEN N'برگشت خورده' WHEN fldStatus = 4 THEN
--                       N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END), '') AS fldStatusName, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblBank.fldBankName, 
--                      Com.tblSHobe.fldBankId, Com.tblSHobe.fldName AS fldNameShobe, Com.tblShomareHesabeOmoomi.fldShobeId, '' AS fldNameBaratDar, '' AS fldStatusFish, 
--                      '' AS fldStatusFishId, NULL AS fldFishId, Drd.tblCheck.fldShomareHesabIdOrgan, tblShomareHesabeOmoomi_1.fldShomareHesab AS fldShomareHesabOrgan
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,tblCheck.fldTarikhAkhz,fldDateStatus
--FROM         Drd.tblCheck INNER JOIN
--                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
--                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
--                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
--                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId

--INSERT INTO @temp
--SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL( cast(fldMablaghSanad as bigint),CAST(0 AS bigint)) AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0,0,CAST(3 AS TINYINT),'',fldUserId, fldDesc, fldDate
--,N'سفته' AS fldTypeSanadName
--,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
--,'','',0,'',0 ,'' fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,com.MiladiTOShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
--FROM         Drd.tblSafte

--INSERT INTO @temp
--SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL( cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT), ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
--,N'برات' AS fldTypeSanadName
--,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
--,'','',0,'',0,com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId)fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,com.MiladiTOShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus

--FROM         Drd.tblBarat

--SELECT * FROM @temp
--WHERE fldMablaghSanad like @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
--AND fldTarikhSarResid >= @AzTarikh 
--END
--IF(@AzTarikh ='' AND @TaTarikh<>'')
--BEGIN
--INSERT INTO @temp
--SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
--                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ), cast(0 as bigint)) AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
--                      CAST(0 AS TINYINT)) AS fldStatus, ISNULL(Drd.tblCheck.fldShomareHesabId, 0) AS fldShomareHesabId, 0 AS fldBaratDarId, 
--                      CASE WHEN fldTypeSanad = 0 THEN CAST(2 AS TINYINT) ELSE CAST(6 AS TINYINT) END AS fldTypeSanad, '' AS fldMakanPardakht, Drd.tblCheck.fldUserId, 
--                      Drd.tblCheck.fldDesc, Drd.tblCheck.fldDate, CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, 
--                      ISNULL((CASE WHEN fldStatus = 1 THEN N'در انتظار وصول' WHEN fldStatus = 2 THEN N'وصول شده' WHEN fldStatus = 3 THEN N'برگشت خورده' WHEN fldStatus = 4 THEN
--                       N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END), '') AS fldStatusName, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblBank.fldBankName, 
--                      Com.tblSHobe.fldBankId, Com.tblSHobe.fldName AS fldNameShobe, Com.tblShomareHesabeOmoomi.fldShobeId, '' AS fldNameBaratDar, '' AS fldStatusFish, 
--                      '' AS fldStatusFishId, NULL AS fldFishId, Drd.tblCheck.fldShomareHesabIdOrgan, tblShomareHesabeOmoomi_1.fldShomareHesab AS fldShomareHesabOrgan
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,tblCheck.fldTarikhAkhz,fldDateStatus
--FROM         Drd.tblCheck INNER JOIN
--                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
--                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
--                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
--                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId

--INSERT INTO @temp
--SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL( cast(fldMablaghSanad as bigint),CAST(0 AS bigint)) AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0,0,CAST(3 AS TINYINT),'',fldUserId, fldDesc, fldDate
--,N'سفته' AS fldTypeSanadName
--,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
--,'','',0,'',0 ,'' fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,com.MiladiTOShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus

--FROM         Drd.tblSafte

--INSERT INTO @temp
--SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL( cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT), ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
--,N'برات' AS fldTypeSanadName
--,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
--,'','',0,'',0,com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId)fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,com.MiladiTOShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus

--FROM         Drd.tblBarat

--SELECT * FROM @temp
--WHERE fldMablaghSanad like @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
--AND fldTarikhSarResid <= @TaTarikh
--end
--IF(@AzTarikh ='' AND @TaTarikh='')
--BEGIN
--INSERT INTO @temp
--SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
--                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ), cast(0 as bigint)) AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
--                      CAST(0 AS TINYINT)) AS fldStatus, ISNULL(Drd.tblCheck.fldShomareHesabId, 0) AS fldShomareHesabId, 0 AS fldBaratDarId, 
--                      CASE WHEN fldTypeSanad = 0 THEN CAST(2 AS TINYINT) ELSE CAST(6 AS TINYINT) END AS fldTypeSanad, '' AS fldMakanPardakht, Drd.tblCheck.fldUserId, 
--                      Drd.tblCheck.fldDesc, Drd.tblCheck.fldDate, CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, 
--                      ISNULL((CASE WHEN fldStatus = 1 THEN N'در انتظار وصول' WHEN fldStatus = 2 THEN N'وصول شده' WHEN fldStatus = 3 THEN N'برگشت خورده' WHEN fldStatus = 4 THEN
--                       N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END), '') AS fldStatusName, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblBank.fldBankName, 
--                      Com.tblSHobe.fldBankId, Com.tblSHobe.fldName AS fldNameShobe, Com.tblShomareHesabeOmoomi.fldShobeId, '' AS fldNameBaratDar, '' AS fldStatusFish, 
--                      '' AS fldStatusFishId, NULL AS fldFishId, Drd.tblCheck.fldShomareHesabIdOrgan, tblShomareHesabeOmoomi_1.fldShomareHesab AS fldShomareHesabOrgan
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,tblCheck.fldTarikhAkhz,fldDateStatus
--FROM         Drd.tblCheck INNER JOIN
--                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
--                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
--                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
--                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId

--INSERT INTO @temp
--SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL( cast(fldMablaghSanad as bigint),CAST(0 AS bigint)) AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0,0,CAST(3 AS TINYINT),'',fldUserId, fldDesc, fldDate
--,N'سفته' AS fldTypeSanadName
--,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
--,'','',0,'',0 ,'' fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,com.MiladiTOShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus

--FROM         Drd.tblSafte

--INSERT INTO @temp
--SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL( cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT), ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
--,N'برات' AS fldTypeSanadName
--,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
--,'','',0,'',0,com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId)fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,com.MiladiTOShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus

--FROM         Drd.tblBarat
--SELECT * FROM @temp
--WHERE fldMablaghSanad LIKE @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
--end
--END*/



--if (@fieldname=N'Ejra_fldShenaseMeli')
--BEGIN
--IF(@AzTarikh <>'' AND @TaTarikh<>'')
--BEGIN
--INSERT INTO @temp
--SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
--                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ), cast(0 as bigint)) AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
--                      CAST(0 AS TINYINT)) AS fldStatus, ISNULL(Drd.tblCheck.fldShomareHesabId, 0) AS fldShomareHesabId, 0 AS fldBaratDarId, 
--                      CASE WHEN fldTypeSanad = 0 THEN CAST(2 AS TINYINT) ELSE CAST(6 AS TINYINT) END AS fldTypeSanad, '' AS fldMakanPardakht, Drd.tblCheck.fldUserId, 
--                      Drd.tblCheck.fldDesc, Drd.tblCheck.fldDate, CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, 
--                      ISNULL((CASE WHEN fldStatus = 1 THEN N'در انتظار وصول' WHEN fldStatus = 2 THEN N'وصول شده' WHEN fldStatus = 3 THEN N'برگشت خورده' WHEN fldStatus = 4 THEN
--                       N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END), '') AS fldStatusName, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblBank.fldBankName, 
--                      Com.tblSHobe.fldBankId, Com.tblSHobe.fldName AS fldNameShobe, Com.tblShomareHesabeOmoomi.fldShobeId, '' AS fldNameBaratDar, '' AS fldStatusFish, 
--                      '' AS fldStatusFishId, NULL AS fldFishId, Drd.tblCheck.fldShomareHesabIdOrgan, tblShomareHesabeOmoomi_1.fldShomareHesab AS fldShomareHesabOrgan
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,tblCheck.fldTarikhAkhz,fldDateStatus
--FROM         Drd.tblCheck INNER JOIN
--                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
--                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
--                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
--                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId

--INSERT INTO @temp
--SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL( cast(fldMablaghSanad as bigint),CAST(0 AS bigint)) AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0,0,CAST(3 AS TINYINT),'',fldUserId, fldDesc, fldDate
--,N'سفته' AS fldTypeSanadName
--,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
--,'','',0,'',0 ,'' fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,com.MiladiTOShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus

--FROM         Drd.tblSafte

--INSERT INTO @temp
--SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL( cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT), ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
--,N'برات' AS fldTypeSanadName
--,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
--,'','',0,'',0,com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId)fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,com.MiladiTOShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus

--FROM         Drd.tblBarat
--SELECT * FROM @temp
--WHERE fldShenaseMeli like @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
--AND fldTarikhSarResid BETWEEN @AzTarikh AND @TaTarikh
--end
--IF(@AzTarikh <>'' AND @TaTarikh='')
--BEGIN
--INSERT INTO @temp
--SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
--                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ), cast(0 as bigint)) AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
--                      CAST(0 AS TINYINT)) AS fldStatus, ISNULL(Drd.tblCheck.fldShomareHesabId, 0) AS fldShomareHesabId, 0 AS fldBaratDarId, 
--                      CASE WHEN fldTypeSanad = 0 THEN CAST(2 AS TINYINT) ELSE CAST(6 AS TINYINT) END AS fldTypeSanad, '' AS fldMakanPardakht, Drd.tblCheck.fldUserId, 
--                      Drd.tblCheck.fldDesc, Drd.tblCheck.fldDate, CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, 
--                      ISNULL((CASE WHEN fldStatus = 1 THEN N'در انتظار وصول' WHEN fldStatus = 2 THEN N'وصول شده' WHEN fldStatus = 3 THEN N'برگشت خورده' WHEN fldStatus = 4 THEN
--                       N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END), '') AS fldStatusName, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblBank.fldBankName, 
--                      Com.tblSHobe.fldBankId, Com.tblSHobe.fldName AS fldNameShobe, Com.tblShomareHesabeOmoomi.fldShobeId, '' AS fldNameBaratDar, '' AS fldStatusFish, 
--                      '' AS fldStatusFishId, NULL AS fldFishId, Drd.tblCheck.fldShomareHesabIdOrgan, tblShomareHesabeOmoomi_1.fldShomareHesab AS fldShomareHesabOrgan
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,tblCheck.fldTarikhAkhz,fldDateStatus
--FROM         Drd.tblCheck INNER JOIN
--                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
--                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
--                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
--                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId

--INSERT INTO @temp
--SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL( cast(fldMablaghSanad as bigint),CAST(0 AS bigint)) AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0,0,CAST(3 AS TINYINT),'',fldUserId, fldDesc, fldDate
--,N'سفته' AS fldTypeSanadName
--,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
--,'','',0,'',0 ,'' fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,com.MiladiTOShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus

--FROM         Drd.tblSafte

--INSERT INTO @temp
--SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL( cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT), ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
--,N'برات' AS fldTypeSanadName
--,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
--,'','',0,'',0,com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId)fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,com.MiladiTOShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus

--FROM         Drd.tblBarat
--SELECT * FROM @temp
--WHERE fldShenaseMeli like @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
--AND fldTarikhSarResid >= @AzTarikh 
--end
--IF(@AzTarikh ='' AND @TaTarikh<>'')
--BEGIN
--INSERT INTO @temp
--SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
--                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ), cast(0 as bigint)) AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
--                      CAST(0 AS TINYINT)) AS fldStatus, ISNULL(Drd.tblCheck.fldShomareHesabId, 0) AS fldShomareHesabId, 0 AS fldBaratDarId, 
--                      CASE WHEN fldTypeSanad = 0 THEN CAST(2 AS TINYINT) ELSE CAST(6 AS TINYINT) END AS fldTypeSanad, '' AS fldMakanPardakht, Drd.tblCheck.fldUserId, 
--                      Drd.tblCheck.fldDesc, Drd.tblCheck.fldDate, CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, 
--                      ISNULL((CASE WHEN fldStatus = 1 THEN N'در انتظار وصول' WHEN fldStatus = 2 THEN N'وصول شده' WHEN fldStatus = 3 THEN N'برگشت خورده' WHEN fldStatus = 4 THEN
--                       N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END), '') AS fldStatusName, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblBank.fldBankName, 
--                      Com.tblSHobe.fldBankId, Com.tblSHobe.fldName AS fldNameShobe, Com.tblShomareHesabeOmoomi.fldShobeId, '' AS fldNameBaratDar, '' AS fldStatusFish, 
--                      '' AS fldStatusFishId, NULL AS fldFishId, Drd.tblCheck.fldShomareHesabIdOrgan, tblShomareHesabeOmoomi_1.fldShomareHesab AS fldShomareHesabOrgan
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,tblCheck.fldTarikhAkhz,fldDateStatus

--FROM         Drd.tblCheck INNER JOIN
--                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
--                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
--                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
--                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId

--INSERT INTO @temp
--SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL( cast(fldMablaghSanad as bigint),CAST(0 AS bigint)) AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0,0,CAST(3 AS TINYINT),'',fldUserId, fldDesc, fldDate
--,N'سفته' AS fldTypeSanadName
--,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
--,'','',0,'',0 ,'' fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,com.MiladiTOShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus

--FROM         Drd.tblSafte

--INSERT INTO @temp
--SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL( cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT), ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
--,N'برات' AS fldTypeSanadName
--,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
--,'','',0,'',0,com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId)fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,com.MiladiTOShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus

--FROM         Drd.tblBarat
--SELECT * FROM @temp
--WHERE fldShenaseMeli like @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
--AND fldTarikhSarResid <= @TaTarikh
--END 

--IF(@AzTarikh ='' AND @TaTarikh='')
--BEGIN
--INSERT INTO @temp
--SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
--                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ), cast(0 as bigint)) AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
--                      CAST(0 AS TINYINT)) AS fldStatus, ISNULL(Drd.tblCheck.fldShomareHesabId, 0) AS fldShomareHesabId, 0 AS fldBaratDarId, 
--                      CASE WHEN fldTypeSanad = 0 THEN CAST(2 AS TINYINT) ELSE CAST(6 AS TINYINT) END AS fldTypeSanad, '' AS fldMakanPardakht, Drd.tblCheck.fldUserId, 
--                      Drd.tblCheck.fldDesc, Drd.tblCheck.fldDate, CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, 
--                      ISNULL((CASE WHEN fldStatus = 1 THEN N'در انتظار وصول' WHEN fldStatus = 2 THEN N'وصول شده' WHEN fldStatus = 3 THEN N'برگشت خورده' WHEN fldStatus = 4 THEN
--                       N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END), '') AS fldStatusName, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblBank.fldBankName, 
--                      Com.tblSHobe.fldBankId, Com.tblSHobe.fldName AS fldNameShobe, Com.tblShomareHesabeOmoomi.fldShobeId, '' AS fldNameBaratDar, '' AS fldStatusFish, 
--                      '' AS fldStatusFishId, NULL AS fldFishId, Drd.tblCheck.fldShomareHesabIdOrgan, tblShomareHesabeOmoomi_1.fldShomareHesab AS fldShomareHesabOrgan
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,tblCheck.fldTarikhAkhz,fldDateStatus
--FROM         Drd.tblCheck INNER JOIN
--                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
--                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
--                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
--                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId

--INSERT INTO @temp
--SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL( cast(fldMablaghSanad as bigint),CAST(0 AS bigint)) AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0,0,CAST(3 AS TINYINT),'',fldUserId, fldDesc, fldDate
--,N'سفته' AS fldTypeSanadName
--,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
--,'','',0,'',0 ,'' fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,com.MiladiTOShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus

--FROM         Drd.tblSafte

--INSERT INTO @temp
--SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL( cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT), ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
--,N'برات' AS fldTypeSanadName
--,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
--,'','',0,'',0,com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId)fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,com.MiladiTOShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus

--FROM         Drd.tblBarat
--SELECT * FROM @temp
--WHERE fldShenaseMeli LIKE @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
--END 
--END
--if (@fieldname=N'Ejra_fldFather_Sabt')
--BEGIN
--IF(@AzTarikh <>'' AND @TaTarikh<>'')
--BEGIN
--INSERT INTO @temp
--SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
--                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ), cast(0 as bigint)) AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
--                      CAST(0 AS TINYINT)) AS fldStatus, ISNULL(Drd.tblCheck.fldShomareHesabId, 0) AS fldShomareHesabId, 0 AS fldBaratDarId, 
--                      CASE WHEN fldTypeSanad = 0 THEN CAST(2 AS TINYINT) ELSE CAST(6 AS TINYINT) END AS fldTypeSanad, '' AS fldMakanPardakht, Drd.tblCheck.fldUserId, 
--                      Drd.tblCheck.fldDesc, Drd.tblCheck.fldDate, CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, 
--                      ISNULL((CASE WHEN fldStatus = 1 THEN N'در انتظار وصول' WHEN fldStatus = 2 THEN N'وصول شده' WHEN fldStatus = 3 THEN N'برگشت خورده' WHEN fldStatus = 4 THEN
--                       N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END), '') AS fldStatusName, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblBank.fldBankName, 
--                      Com.tblSHobe.fldBankId, Com.tblSHobe.fldName AS fldNameShobe, Com.tblShomareHesabeOmoomi.fldShobeId, '' AS fldNameBaratDar, '' AS fldStatusFish, 
--                      '' AS fldStatusFishId, NULL AS fldFishId, Drd.tblCheck.fldShomareHesabIdOrgan, tblShomareHesabeOmoomi_1.fldShomareHesab AS fldShomareHesabOrgan
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,tblCheck.fldTarikhAkhz,fldDateStatus
--FROM         Drd.tblCheck INNER JOIN
--                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
--                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
--                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
--                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId

--INSERT INTO @temp
--SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL( cast(fldMablaghSanad as bigint),CAST(0 AS bigint)) AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0,0,CAST(3 AS TINYINT),'',fldUserId, fldDesc, fldDate
--,N'سفته' AS fldTypeSanadName
--,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
--,'','',0,'',0 ,'' fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,com.MiladiTOShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus

--FROM         Drd.tblSafte

--INSERT INTO @temp
--SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL( cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT), ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
--,N'برات' AS fldTypeSanadName
--,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
--,'','',0,'',0,com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId)fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,com.MiladiTOShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus

--FROM         Drd.tblBarat
--SELECT * FROM @temp
--WHERE fldFather_Sabt like @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
--AND fldTarikhSarResid BETWEEN @AzTarikh AND @TaTarikh
--end
--IF(@AzTarikh <>'' AND @TaTarikh='')
--BEGIN
--INSERT INTO @temp
--SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
--                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ), cast(0 as bigint)) AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
--                      CAST(0 AS TINYINT)) AS fldStatus, ISNULL(Drd.tblCheck.fldShomareHesabId, 0) AS fldShomareHesabId, 0 AS fldBaratDarId, 
--                      CASE WHEN fldTypeSanad = 0 THEN CAST(2 AS TINYINT) ELSE CAST(6 AS TINYINT) END AS fldTypeSanad, '' AS fldMakanPardakht, Drd.tblCheck.fldUserId, 
--                      Drd.tblCheck.fldDesc, Drd.tblCheck.fldDate, CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, 
--                      ISNULL((CASE WHEN fldStatus = 1 THEN N'در انتظار وصول' WHEN fldStatus = 2 THEN N'وصول شده' WHEN fldStatus = 3 THEN N'برگشت خورده' WHEN fldStatus = 4 THEN
--                       N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END), '') AS fldStatusName, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblBank.fldBankName, 
--                      Com.tblSHobe.fldBankId, Com.tblSHobe.fldName AS fldNameShobe, Com.tblShomareHesabeOmoomi.fldShobeId, '' AS fldNameBaratDar, '' AS fldStatusFish, 
--                      '' AS fldStatusFishId, NULL AS fldFishId, Drd.tblCheck.fldShomareHesabIdOrgan, tblShomareHesabeOmoomi_1.fldShomareHesab AS fldShomareHesabOrgan
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,tblCheck.fldTarikhAkhz,fldDateStatus
--FROM         Drd.tblCheck INNER JOIN
--                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
--                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
--                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
--                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId

--INSERT INTO @temp
--SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL( cast(fldMablaghSanad as bigint),CAST(0 AS bigint)) AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0,0,CAST(3 AS TINYINT),'',fldUserId, fldDesc, fldDate
--,N'سفته' AS fldTypeSanadName
--,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
--,'','',0,'',0 ,'' fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,com.MiladiTOShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus

--FROM         Drd.tblSafte

--INSERT INTO @temp
--SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL( cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT), ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
--,N'برات' AS fldTypeSanadName
--,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
--,'','',0,'',0,com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId)fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,com.MiladiTOShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus

--FROM         Drd.tblBarat
--SELECT * FROM @temp
--WHERE fldFather_Sabt like @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
--AND fldTarikhSarResid >= @AzTarikh 
--end
--IF(@AzTarikh ='' AND @TaTarikh<>'')
--BEGIN
--INSERT INTO @temp
--SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
--                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ), cast(0 as bigint)) AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
--                      CAST(0 AS TINYINT)) AS fldStatus, ISNULL(Drd.tblCheck.fldShomareHesabId, 0) AS fldShomareHesabId, 0 AS fldBaratDarId, 
--                      CASE WHEN fldTypeSanad = 0 THEN CAST(2 AS TINYINT) ELSE CAST(6 AS TINYINT) END AS fldTypeSanad, '' AS fldMakanPardakht, Drd.tblCheck.fldUserId, 
--                      Drd.tblCheck.fldDesc, Drd.tblCheck.fldDate, CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, 
--                      ISNULL((CASE WHEN fldStatus = 1 THEN N'در انتظار وصول' WHEN fldStatus = 2 THEN N'وصول شده' WHEN fldStatus = 3 THEN N'برگشت خورده' WHEN fldStatus = 4 THEN
--                       N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END), '') AS fldStatusName, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblBank.fldBankName, 
--                      Com.tblSHobe.fldBankId, Com.tblSHobe.fldName AS fldNameShobe, Com.tblShomareHesabeOmoomi.fldShobeId, '' AS fldNameBaratDar, '' AS fldStatusFish, 
--                      '' AS fldStatusFishId, NULL AS fldFishId, Drd.tblCheck.fldShomareHesabIdOrgan, tblShomareHesabeOmoomi_1.fldShomareHesab AS fldShomareHesabOrgan
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,tblCheck.fldTarikhAkhz,fldDateStatus
--FROM         Drd.tblCheck INNER JOIN
--                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
--                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
--                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
--                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId

--INSERT INTO @temp
--SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL( cast(fldMablaghSanad as bigint),CAST(0 AS bigint)) AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0,0,CAST(3 AS TINYINT),'',fldUserId, fldDesc, fldDate
--,N'سفته' AS fldTypeSanadName
--,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
--,'','',0,'',0 ,'' fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,'',
--ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,com.MiladiTOShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus

--FROM         Drd.tblSafte

--INSERT INTO @temp
--SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL( cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT), ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
--,N'برات' AS fldTypeSanadName
--,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
--,'','',0,'',0,com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId)fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,com.MiladiTOShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus

--FROM         Drd.tblBarat
--SELECT * FROM @temp
--WHERE fldFather_Sabt like @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
--AND fldTarikhSarResid <= @TaTarikh
--END 
--IF(@AzTarikh ='' AND @TaTarikh='')
--BEGIN
--INSERT INTO @temp
--SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
--                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ), cast(0 as bigint)) AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
--                      CAST(0 AS TINYINT)) AS fldStatus, ISNULL(Drd.tblCheck.fldShomareHesabId, 0) AS fldShomareHesabId, 0 AS fldBaratDarId, 
--                      CASE WHEN fldTypeSanad = 0 THEN CAST(2 AS TINYINT) ELSE CAST(6 AS TINYINT) END AS fldTypeSanad, '' AS fldMakanPardakht, Drd.tblCheck.fldUserId, 
--                      Drd.tblCheck.fldDesc, Drd.tblCheck.fldDate, CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, 
--                      ISNULL((CASE WHEN fldStatus = 1 THEN N'در انتظار وصول' WHEN fldStatus = 2 THEN N'وصول شده' WHEN fldStatus = 3 THEN N'برگشت خورده' WHEN fldStatus = 4 THEN
--                       N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END), '') AS fldStatusName, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblBank.fldBankName, 
--                      Com.tblSHobe.fldBankId, Com.tblSHobe.fldName AS fldNameShobe, Com.tblShomareHesabeOmoomi.fldShobeId, '' AS fldNameBaratDar, '' AS fldStatusFish, 
--                      '' AS fldStatusFishId, NULL AS fldFishId, Drd.tblCheck.fldShomareHesabIdOrgan, tblShomareHesabeOmoomi_1.fldShomareHesab AS fldShomareHesabOrgan
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,tblCheck.fldTarikhAkhz,fldDateStatus
--FROM         Drd.tblCheck INNER JOIN
--                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
--                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
--                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
--                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId

--INSERT INTO @temp
--SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL( cast(fldMablaghSanad as bigint),CAST(0 AS bigint)) AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0,0,CAST(3 AS TINYINT),'',fldUserId, fldDesc, fldDate
--,N'سفته' AS fldTypeSanadName
--,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
--,'','',0,'',0 ,'' fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,com.MiladiTOShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus

--FROM         Drd.tblSafte

--INSERT INTO @temp
--SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL( cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT), ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
--,N'برات' AS fldTypeSanadName
--,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
--,'','',0,'',0,com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId)fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,com.MiladiTOShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus

--FROM         Drd.tblBarat
--SELECT * FROM @temp
--WHERE fldFather_Sabt LIKE @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
--end
--END

--if (@fieldname=N'Ejra_fldNameBaratDar')
--BEGIN
--IF(@AzTarikh <>'' AND @TaTarikh<>'')
--BEGIN
--INSERT INTO @temp
--SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
--                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ), cast(0 as bigint)) AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
--                      CAST(0 AS TINYINT)) AS fldStatus, ISNULL(Drd.tblCheck.fldShomareHesabId, 0) AS fldShomareHesabId, 0 AS fldBaratDarId, 
--                      CASE WHEN fldTypeSanad = 0 THEN CAST(2 AS TINYINT) ELSE CAST(6 AS TINYINT) END AS fldTypeSanad, '' AS fldMakanPardakht, Drd.tblCheck.fldUserId, 
--                      Drd.tblCheck.fldDesc, Drd.tblCheck.fldDate, CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, 
--                      ISNULL((CASE WHEN fldStatus = 1 THEN N'در انتظار وصول' WHEN fldStatus = 2 THEN N'وصول شده' WHEN fldStatus = 3 THEN N'برگشت خورده' WHEN fldStatus = 4 THEN
--                       N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END), '') AS fldStatusName, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblBank.fldBankName, 
--                      Com.tblSHobe.fldBankId, Com.tblSHobe.fldName AS fldNameShobe, Com.tblShomareHesabeOmoomi.fldShobeId, '' AS fldNameBaratDar, '' AS fldStatusFish, 
--                      '' AS fldStatusFishId, NULL AS fldFishId, Drd.tblCheck.fldShomareHesabIdOrgan, tblShomareHesabeOmoomi_1.fldShomareHesab AS fldShomareHesabOrgan
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,tblCheck.fldTarikhAkhz,fldDateStatus
--FROM         Drd.tblCheck INNER JOIN
--                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
--                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
--                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
--                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId

--INSERT INTO @temp
--SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL( cast(fldMablaghSanad as bigint),CAST(0 AS bigint)) AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0,0,CAST(3 AS TINYINT),'',fldUserId, fldDesc, fldDate
--,N'سفته' AS fldTypeSanadName
--,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
--,'','',0,'',0 ,'' fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,com.MiladiTOShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus

--FROM         Drd.tblSafte

--INSERT INTO @temp
--SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL( cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT), ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
--,N'برات' AS fldTypeSanadName
--,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
--,'','',0,'',0,com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId)fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,com.MiladiTOShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus

--FROM         Drd.tblBarat
--SELECT * FROM @temp
--WHERE fldNameBaratDar like @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
--AND fldTarikhSarResid BETWEEN @AzTarikh AND @TaTarikh
--END 
--IF(@AzTarikh <>'' AND @TaTarikh='')
--BEGIN
--INSERT INTO @temp
--SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
--                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ), cast(0 as bigint)) AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
--                      CAST(0 AS TINYINT)) AS fldStatus, ISNULL(Drd.tblCheck.fldShomareHesabId, 0) AS fldShomareHesabId, 0 AS fldBaratDarId, 
--                      CASE WHEN fldTypeSanad = 0 THEN CAST(2 AS TINYINT) ELSE CAST(6 AS TINYINT) END AS fldTypeSanad, '' AS fldMakanPardakht, Drd.tblCheck.fldUserId, 
--                      Drd.tblCheck.fldDesc, Drd.tblCheck.fldDate, CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, 
--                      ISNULL((CASE WHEN fldStatus = 1 THEN N'در انتظار وصول' WHEN fldStatus = 2 THEN N'وصول شده' WHEN fldStatus = 3 THEN N'برگشت خورده' WHEN fldStatus = 4 THEN
--                       N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END), '') AS fldStatusName, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblBank.fldBankName, 
--                      Com.tblSHobe.fldBankId, Com.tblSHobe.fldName AS fldNameShobe, Com.tblShomareHesabeOmoomi.fldShobeId, '' AS fldNameBaratDar, '' AS fldStatusFish, 
--                      '' AS fldStatusFishId, NULL AS fldFishId, Drd.tblCheck.fldShomareHesabIdOrgan, tblShomareHesabeOmoomi_1.fldShomareHesab AS fldShomareHesabOrgan
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,tblCheck.fldTarikhAkhz,fldDateStatus
--FROM         Drd.tblCheck INNER JOIN
--                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
--                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
--                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
--                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId

--INSERT INTO @temp
--SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL( cast(fldMablaghSanad as bigint),CAST(0 AS bigint)) AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0,0,CAST(3 AS TINYINT),'',fldUserId, fldDesc, fldDate
--,N'سفته' AS fldTypeSanadName
--,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
--,'','',0,'',0 ,'' fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,com.MiladiTOShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus

--FROM         Drd.tblSafte

--INSERT INTO @temp
--SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL( cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT), ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
--,N'برات' AS fldTypeSanadName
--,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
--,'','',0,'',0,com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId)fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,com.MiladiTOShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus

--FROM         Drd.tblBarat
--SELECT * FROM @temp
--WHERE fldNameBaratDar like @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
--AND fldTarikhSarResid >= @AzTarikh 
--END 
--IF(@AzTarikh ='' AND @TaTarikh<>'')
--BEGIN
--INSERT INTO @temp
--SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
--                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ), cast(0 as bigint)) AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
--                      CAST(0 AS TINYINT)) AS fldStatus, ISNULL(Drd.tblCheck.fldShomareHesabId, 0) AS fldShomareHesabId, 0 AS fldBaratDarId, 
--                      CASE WHEN fldTypeSanad = 0 THEN CAST(2 AS TINYINT) ELSE CAST(6 AS TINYINT) END AS fldTypeSanad, '' AS fldMakanPardakht, Drd.tblCheck.fldUserId, 
--                      Drd.tblCheck.fldDesc, Drd.tblCheck.fldDate, CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, 
--                      ISNULL((CASE WHEN fldStatus = 1 THEN N'در انتظار وصول' WHEN fldStatus = 2 THEN N'وصول شده' WHEN fldStatus = 3 THEN N'برگشت خورده' WHEN fldStatus = 4 THEN
--                       N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END), '') AS fldStatusName, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblBank.fldBankName, 
--                      Com.tblSHobe.fldBankId, Com.tblSHobe.fldName AS fldNameShobe, Com.tblShomareHesabeOmoomi.fldShobeId, '' AS fldNameBaratDar, '' AS fldStatusFish, 
--                      '' AS fldStatusFishId, NULL AS fldFishId, Drd.tblCheck.fldShomareHesabIdOrgan, tblShomareHesabeOmoomi_1.fldShomareHesab AS fldShomareHesabOrgan
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,tblCheck.fldTarikhAkhz,fldDateStatus
--FROM         Drd.tblCheck INNER JOIN
--                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
--                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
--                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
--                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId

--INSERT INTO @temp
--SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL( cast(fldMablaghSanad as bigint),CAST(0 AS bigint)) AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0,0,CAST(3 AS TINYINT),'',fldUserId, fldDesc, fldDate
--,N'سفته' AS fldTypeSanadName
--,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
--,'','',0,'',0 ,'' fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,com.MiladiTOShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus

--FROM         Drd.tblSafte

--INSERT INTO @temp
--SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL( cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT), ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
--,N'برات' AS fldTypeSanadName
--,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
--,'','',0,'',0,com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId)fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,com.MiladiTOShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus

--FROM         Drd.tblBarat
--SELECT * FROM  @temp
--WHERE fldNameBaratDar like @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
--AND fldTarikhSarResid <= @TaTarikh
--end
--IF(@AzTarikh ='' AND @TaTarikh='')
--BEGIN
--INSERT INTO @temp
--SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
--                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ), cast(0 as bigint)) AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
--                      CAST(0 AS TINYINT)) AS fldStatus, ISNULL(Drd.tblCheck.fldShomareHesabId, 0) AS fldShomareHesabId, 0 AS fldBaratDarId, 
--                      CASE WHEN fldTypeSanad = 0 THEN CAST(2 AS TINYINT) ELSE CAST(6 AS TINYINT) END AS fldTypeSanad, '' AS fldMakanPardakht, Drd.tblCheck.fldUserId, 
--                      Drd.tblCheck.fldDesc, Drd.tblCheck.fldDate, CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, 
--                      ISNULL((CASE WHEN fldStatus = 1 THEN N'در انتظار وصول' WHEN fldStatus = 2 THEN N'وصول شده' WHEN fldStatus = 3 THEN N'برگشت خورده' WHEN fldStatus = 4 THEN
--                       N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END), '') AS fldStatusName, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblBank.fldBankName, 
--                      Com.tblSHobe.fldBankId, Com.tblSHobe.fldName AS fldNameShobe, Com.tblShomareHesabeOmoomi.fldShobeId, '' AS fldNameBaratDar, '' AS fldStatusFish, 
--                      '' AS fldStatusFishId, NULL AS fldFishId, Drd.tblCheck.fldShomareHesabIdOrgan, tblShomareHesabeOmoomi_1.fldShomareHesab AS fldShomareHesabOrgan
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,tblCheck.fldTarikhAkhz,fldDateStatus
--FROM         Drd.tblCheck INNER JOIN
--                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
--                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
--                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
--                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId

--INSERT INTO @temp
--SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL( cast(fldMablaghSanad as bigint),CAST(0 AS bigint)) AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0,0,CAST(3 AS TINYINT),'',fldUserId, fldDesc, fldDate
--,N'سفته' AS fldTypeSanadName
--,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
--,'','',0,'',0 ,'' fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,com.MiladiTOShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus

--FROM         Drd.tblSafte

--INSERT INTO @temp
--SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL( cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT), ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
--,N'برات' AS fldTypeSanadName
--,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
--,'','',0,'',0,com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId)fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,com.MiladiTOShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus

--FROM         Drd.tblBarat
--SELECT * FROM @temp
--WHERE fldNameBaratDar LIKE @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
--END
--end
--if (@fieldname=N'Ejra_fldTypeSanadName')
--BEGIN
--IF(@AzTarikh<>'' AND @TaTarikh<>'')
--BEGIN 
--INSERT INTO @temp
--SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
--                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ), cast(0 as bigint)) AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
--                      CAST(0 AS TINYINT)) AS fldStatus, ISNULL(Drd.tblCheck.fldShomareHesabId, 0) AS fldShomareHesabId, 0 AS fldBaratDarId, 
--                      CASE WHEN fldTypeSanad = 0 THEN CAST(2 AS TINYINT) ELSE CAST(6 AS TINYINT) END AS fldTypeSanad, '' AS fldMakanPardakht, Drd.tblCheck.fldUserId, 
--                      Drd.tblCheck.fldDesc, Drd.tblCheck.fldDate, CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, 
--                      ISNULL((CASE WHEN fldStatus = 1 THEN N'در انتظار وصول' WHEN fldStatus = 2 THEN N'وصول شده' WHEN fldStatus = 3 THEN N'برگشت خورده' WHEN fldStatus = 4 THEN
--                       N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END), '') AS fldStatusName, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblBank.fldBankName, 
--                      Com.tblSHobe.fldBankId, Com.tblSHobe.fldName AS fldNameShobe, Com.tblShomareHesabeOmoomi.fldShobeId, '' AS fldNameBaratDar, '' AS fldStatusFish, 
--                      '' AS fldStatusFishId, NULL AS fldFishId, Drd.tblCheck.fldShomareHesabIdOrgan, tblShomareHesabeOmoomi_1.fldShomareHesab AS fldShomareHesabOrgan
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,tblCheck.fldTarikhAkhz,fldDateStatus
--FROM         Drd.tblCheck INNER JOIN
--                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
--                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
--                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
--                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId

--INSERT INTO @temp
--SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL( cast(fldMablaghSanad as bigint),CAST(0 AS bigint)) AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0,0,CAST(3 AS TINYINT),'',fldUserId, fldDesc, fldDate
--,N'سفته' AS fldTypeSanadName
--,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
--,'','',0,'',0 ,'' fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,com.MiladiTOShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus

--FROM         Drd.tblSafte

--INSERT INTO @temp
--SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL( cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT), ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
--,N'برات' AS fldTypeSanadName
--,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
--,'','',0,'',0,com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId)fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,com.MiladiTOShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus

--FROM         Drd.tblBarat
--SELECT * FROM @temp
--WHERE fldTypeSanadName LIKE @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
--AND fldTarikhSarResid BETWEEN @AzTarikh AND @TaTarikh
--END 
--IF(@AzTarikh<>'' AND @TaTarikh='')
--BEGIN
--INSERT INTO @temp
--SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
--                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ), cast(0 as bigint)) AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
--                      CAST(0 AS TINYINT)) AS fldStatus, ISNULL(Drd.tblCheck.fldShomareHesabId, 0) AS fldShomareHesabId, 0 AS fldBaratDarId, 
--                      CASE WHEN fldTypeSanad = 0 THEN CAST(2 AS TINYINT) ELSE CAST(6 AS TINYINT) END AS fldTypeSanad, '' AS fldMakanPardakht, Drd.tblCheck.fldUserId, 
--                      Drd.tblCheck.fldDesc, Drd.tblCheck.fldDate, CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, 
--                      ISNULL((CASE WHEN fldStatus = 1 THEN N'در انتظار وصول' WHEN fldStatus = 2 THEN N'وصول شده' WHEN fldStatus = 3 THEN N'برگشت خورده' WHEN fldStatus = 4 THEN
--                       N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END), '') AS fldStatusName, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblBank.fldBankName, 
--                      Com.tblSHobe.fldBankId, Com.tblSHobe.fldName AS fldNameShobe, Com.tblShomareHesabeOmoomi.fldShobeId, '' AS fldNameBaratDar, '' AS fldStatusFish, 
--                      '' AS fldStatusFishId, NULL AS fldFishId, Drd.tblCheck.fldShomareHesabIdOrgan, tblShomareHesabeOmoomi_1.fldShomareHesab AS fldShomareHesabOrgan
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,tblCheck.fldTarikhAkhz,fldDateStatus
--FROM         Drd.tblCheck INNER JOIN
--                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
--                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
--                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
--                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId

--INSERT INTO @temp
--SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL( cast(fldMablaghSanad as bigint),CAST(0 AS bigint)) AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0,0,CAST(3 AS TINYINT),'',fldUserId, fldDesc, fldDate
--,N'سفته' AS fldTypeSanadName
--,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
--,'','',0,'',0 ,'' fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,com.MiladiTOShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus

--FROM         Drd.tblSafte

--INSERT INTO @temp
--SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL( cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT), ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
--,N'برات' AS fldTypeSanadName
--,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
--,'','',0,'',0,com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId)fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,com.MiladiTOShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus

--FROM         Drd.tblBarat
--SELECT * FROM @temp
--WHERE fldTypeSanadName LIKE @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
--AND  fldTarikhSarResid >= @AzTarikh 
--end

--IF(@AzTarikh='' AND @TaTarikh<>'')
--BEGIN
--INSERT INTO @temp
--SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
--                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ), cast(0 as bigint)) AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
--                      CAST(0 AS TINYINT)) AS fldStatus, ISNULL(Drd.tblCheck.fldShomareHesabId, 0) AS fldShomareHesabId, 0 AS fldBaratDarId, 
--                      CASE WHEN fldTypeSanad = 0 THEN CAST(2 AS TINYINT) ELSE CAST(6 AS TINYINT) END AS fldTypeSanad, '' AS fldMakanPardakht, Drd.tblCheck.fldUserId, 
--                      Drd.tblCheck.fldDesc, Drd.tblCheck.fldDate, CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, 
--                      ISNULL((CASE WHEN fldStatus = 1 THEN N'در انتظار وصول' WHEN fldStatus = 2 THEN N'وصول شده' WHEN fldStatus = 3 THEN N'برگشت خورده' WHEN fldStatus = 4 THEN
--                       N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END), '') AS fldStatusName, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblBank.fldBankName, 
--                      Com.tblSHobe.fldBankId, Com.tblSHobe.fldName AS fldNameShobe, Com.tblShomareHesabeOmoomi.fldShobeId, '' AS fldNameBaratDar, '' AS fldStatusFish, 
--                      '' AS fldStatusFishId, NULL AS fldFishId, Drd.tblCheck.fldShomareHesabIdOrgan, tblShomareHesabeOmoomi_1.fldShomareHesab AS fldShomareHesabOrgan
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,tblCheck.fldTarikhAkhz,fldDateStatus
--FROM         Drd.tblCheck INNER JOIN
--                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
--                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
--                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
--                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId

--INSERT INTO @temp
--SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL( cast(fldMablaghSanad as bigint),CAST(0 AS bigint)) AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0,0,CAST(3 AS TINYINT),'',fldUserId, fldDesc, fldDate
--,N'سفته' AS fldTypeSanadName
--,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
--,'','',0,'',0 ,'' fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,com.MiladiTOShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus

--FROM         Drd.tblSafte

--INSERT INTO @temp
--SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL( cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT), ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
--,N'برات' AS fldTypeSanadName
--,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
--,'','',0,'',0,com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId)fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,com.MiladiTOShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus

--FROM         Drd.tblBarat
--SELECT * FROM @temp
--WHERE fldTypeSanadName LIKE @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
--AND fldTarikhSarResid <= @TaTarikh
--end

--IF(@AzTarikh='' AND @TaTarikh='')
--BEGIN
--INSERT INTO @temp
--SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
--                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ), cast(0 as bigint)) AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
--                      CAST(0 AS TINYINT)) AS fldStatus, ISNULL(Drd.tblCheck.fldShomareHesabId, 0) AS fldShomareHesabId, 0 AS fldBaratDarId, 
--                      CASE WHEN fldTypeSanad = 0 THEN CAST(2 AS TINYINT) ELSE CAST(6 AS TINYINT) END AS fldTypeSanad, '' AS fldMakanPardakht, Drd.tblCheck.fldUserId, 
--                      Drd.tblCheck.fldDesc, Drd.tblCheck.fldDate, CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, 
--                      ISNULL((CASE WHEN fldStatus = 1 THEN N'در انتظار وصول' WHEN fldStatus = 2 THEN N'وصول شده' WHEN fldStatus = 3 THEN N'برگشت خورده' WHEN fldStatus = 4 THEN
--                       N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END), '') AS fldStatusName, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblBank.fldBankName, 
--                      Com.tblSHobe.fldBankId, Com.tblSHobe.fldName AS fldNameShobe, Com.tblShomareHesabeOmoomi.fldShobeId, '' AS fldNameBaratDar, '' AS fldStatusFish, 
--                      '' AS fldStatusFishId, NULL AS fldFishId, Drd.tblCheck.fldShomareHesabIdOrgan, tblShomareHesabeOmoomi_1.fldShomareHesab AS fldShomareHesabOrgan
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,tblCheck.fldTarikhAkhz,fldDateStatus
--FROM         Drd.tblCheck INNER JOIN
--                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
--                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
--                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
--                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId

--INSERT INTO @temp
--SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL( cast(fldMablaghSanad as bigint),CAST(0 AS bigint)) AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0,0,CAST(3 AS TINYINT),'',fldUserId, fldDesc, fldDate
--,N'سفته' AS fldTypeSanadName
--,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
--,'','',0,'',0 ,'' fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,com.MiladiTOShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus

--FROM         Drd.tblSafte

--INSERT INTO @temp
--SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL( cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT), ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
--,N'برات' AS fldTypeSanadName
--,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
--,'','',0,'',0,com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId)fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,com.MiladiTOShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus

--FROM         Drd.tblBarat
--SELECT * FROM @temp
--WHERE fldTypeSanadName LIKE @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
--END

--END
--IF (@fieldname=N'Ejra_fldStatusName')
--BEGIN
--IF(@AzTarikh<>'' AND @TaTarikh<>'')
--BEGIN
--INSERT INTO @temp
--SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
--                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ), cast(0 as bigint)) AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
--                      CAST(0 AS TINYINT)) AS fldStatus, ISNULL(Drd.tblCheck.fldShomareHesabId, 0) AS fldShomareHesabId, 0 AS fldBaratDarId, 
--                      CASE WHEN fldTypeSanad = 0 THEN CAST(2 AS TINYINT) ELSE CAST(6 AS TINYINT) END AS fldTypeSanad, '' AS fldMakanPardakht, Drd.tblCheck.fldUserId, 
--                      Drd.tblCheck.fldDesc, Drd.tblCheck.fldDate, CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, 
--                      ISNULL((CASE WHEN fldStatus = 1 THEN N'در انتظار وصول' WHEN fldStatus = 2 THEN N'وصول شده' WHEN fldStatus = 3 THEN N'برگشت خورده' WHEN fldStatus = 4 THEN
--                       N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END), '') AS fldStatusName, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblBank.fldBankName, 
--                      Com.tblSHobe.fldBankId, Com.tblSHobe.fldName AS fldNameShobe, Com.tblShomareHesabeOmoomi.fldShobeId, '' AS fldNameBaratDar, '' AS fldStatusFish, 
--                      '' AS fldStatusFishId, NULL AS fldFishId, Drd.tblCheck.fldShomareHesabIdOrgan, tblShomareHesabeOmoomi_1.fldShomareHesab AS fldShomareHesabOrgan
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,tblCheck.fldTarikhAkhz,fldDateStatus
--FROM         Drd.tblCheck INNER JOIN
--                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
--                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
--                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
--                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId

--INSERT INTO @temp
--SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL( cast(fldMablaghSanad as bigint),CAST(0 AS bigint)) AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0,0,CAST(3 AS TINYINT),'',fldUserId, fldDesc, fldDate
--,N'سفته' AS fldTypeSanadName
--,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
--,'','',0,'',0 ,'' fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,com.MiladiTOShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus

--FROM         Drd.tblSafte

--INSERT INTO @temp
--SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL( cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT), ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
--,N'برات' AS fldTypeSanadName
--,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
--,'','',0,'',0,com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId)fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,com.MiladiTOShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus

--FROM         Drd.tblBarat
--SELECT * FROM @temp
--WHERE fldStatusName LIKE @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
--AND fldTarikhSarResid BETWEEN @AzTarikh AND @TaTarikh
--end
--IF(@AzTarikh<>'' AND @TaTarikh='')
--BEGIN
--INSERT INTO @temp
--SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
--                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ), cast(0 as bigint)) AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
--                      CAST(0 AS TINYINT)) AS fldStatus, ISNULL(Drd.tblCheck.fldShomareHesabId, 0) AS fldShomareHesabId, 0 AS fldBaratDarId, 
--                      CASE WHEN fldTypeSanad = 0 THEN CAST(2 AS TINYINT) ELSE CAST(6 AS TINYINT) END AS fldTypeSanad, '' AS fldMakanPardakht, Drd.tblCheck.fldUserId, 
--                      Drd.tblCheck.fldDesc, Drd.tblCheck.fldDate, CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, 
--                      ISNULL((CASE WHEN fldStatus = 1 THEN N'در انتظار وصول' WHEN fldStatus = 2 THEN N'وصول شده' WHEN fldStatus = 3 THEN N'برگشت خورده' WHEN fldStatus = 4 THEN
--                       N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END), '') AS fldStatusName, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblBank.fldBankName, 
--                      Com.tblSHobe.fldBankId, Com.tblSHobe.fldName AS fldNameShobe, Com.tblShomareHesabeOmoomi.fldShobeId, '' AS fldNameBaratDar, '' AS fldStatusFish, 
--                      '' AS fldStatusFishId, NULL AS fldFishId, Drd.tblCheck.fldShomareHesabIdOrgan, tblShomareHesabeOmoomi_1.fldShomareHesab AS fldShomareHesabOrgan
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,tblCheck.fldTarikhAkhz,fldDateStatus
--FROM         Drd.tblCheck INNER JOIN
--                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
--                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
--                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
--                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId

--INSERT INTO @temp
--SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL( cast(fldMablaghSanad as bigint),CAST(0 AS bigint)) AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0,0,CAST(3 AS TINYINT),'',fldUserId, fldDesc, fldDate
--,N'سفته' AS fldTypeSanadName
--,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
--,'','',0,'',0 ,'' fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,com.MiladiTOShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus

--FROM         Drd.tblSafte

--INSERT INTO @temp
--SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL( cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT), ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
--,N'برات' AS fldTypeSanadName
--,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
--,'','',0,'',0,com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId)fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,com.MiladiTOShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus

--FROM         Drd.tblBarat
--SELECT * FROM @temp
--WHERE fldStatusName LIKE @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
--AND fldTarikhSarResid >= @AzTarikh 
--end

--IF(@AzTarikh='' AND @TaTarikh<>'')
--BEGIN
--INSERT INTO @temp
--SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
--                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ), cast(0 as bigint)) AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
--                      CAST(0 AS TINYINT)) AS fldStatus, ISNULL(Drd.tblCheck.fldShomareHesabId, 0) AS fldShomareHesabId, 0 AS fldBaratDarId, 
--                      CASE WHEN fldTypeSanad = 0 THEN CAST(2 AS TINYINT) ELSE CAST(6 AS TINYINT) END AS fldTypeSanad, '' AS fldMakanPardakht, Drd.tblCheck.fldUserId, 
--                      Drd.tblCheck.fldDesc, Drd.tblCheck.fldDate, CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, 
--                      ISNULL((CASE WHEN fldStatus = 1 THEN N'در انتظار وصول' WHEN fldStatus = 2 THEN N'وصول شده' WHEN fldStatus = 3 THEN N'برگشت خورده' WHEN fldStatus = 4 THEN
--                       N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END), '') AS fldStatusName, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblBank.fldBankName, 
--                      Com.tblSHobe.fldBankId, Com.tblSHobe.fldName AS fldNameShobe, Com.tblShomareHesabeOmoomi.fldShobeId, '' AS fldNameBaratDar, '' AS fldStatusFish, 
--                      '' AS fldStatusFishId, NULL AS fldFishId, Drd.tblCheck.fldShomareHesabIdOrgan, tblShomareHesabeOmoomi_1.fldShomareHesab AS fldShomareHesabOrgan
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,tblCheck.fldTarikhAkhz,fldDateStatus
--FROM         Drd.tblCheck INNER JOIN
--                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
--                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
--                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
--                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId

--INSERT INTO @temp
--SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL( cast(fldMablaghSanad as bigint),CAST(0 AS bigint)) AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0,0,CAST(3 AS TINYINT),'',fldUserId, fldDesc, fldDate
--,N'سفته' AS fldTypeSanadName
--,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
--,'','',0,'',0 ,'' fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,com.MiladiTOShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus

--FROM         Drd.tblSafte

--INSERT INTO @temp
--SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL( cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT), ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
--,N'برات' AS fldTypeSanadName
--,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
--,'','',0,'',0,com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId)fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,com.MiladiTOShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus

--FROM         Drd.tblBarat
--SELECT * FROM @temp
--WHERE fldStatusName LIKE @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
--AND fldTarikhSarResid <= @TaTarikh
--END 

--IF(@AzTarikh='' AND @TaTarikh='')
--BEGIN
--INSERT INTO @temp
--SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
--                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ), cast(0 as bigint)) AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
--                      CAST(0 AS TINYINT)) AS fldStatus, ISNULL(Drd.tblCheck.fldShomareHesabId, 0) AS fldShomareHesabId, 0 AS fldBaratDarId, 
--                      CASE WHEN fldTypeSanad = 0 THEN CAST(2 AS TINYINT) ELSE CAST(6 AS TINYINT) END AS fldTypeSanad, '' AS fldMakanPardakht, Drd.tblCheck.fldUserId, 
--                      Drd.tblCheck.fldDesc, Drd.tblCheck.fldDate, CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, 
--                      ISNULL((CASE WHEN fldStatus = 1 THEN N'در انتظار وصول' WHEN fldStatus = 2 THEN N'وصول شده' WHEN fldStatus = 3 THEN N'برگشت خورده' WHEN fldStatus = 4 THEN
--                       N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END), '') AS fldStatusName, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblBank.fldBankName, 
--                      Com.tblSHobe.fldBankId, Com.tblSHobe.fldName AS fldNameShobe, Com.tblShomareHesabeOmoomi.fldShobeId, '' AS fldNameBaratDar, '' AS fldStatusFish, 
--                      '' AS fldStatusFishId, NULL AS fldFishId, Drd.tblCheck.fldShomareHesabIdOrgan, tblShomareHesabeOmoomi_1.fldShomareHesab AS fldShomareHesabOrgan
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,tblCheck.fldTarikhAkhz,fldDateStatus
--FROM         Drd.tblCheck INNER JOIN
--                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
--                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
--                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
--                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId

--INSERT INTO @temp
--SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL( cast(fldMablaghSanad as bigint),CAST(0 AS bigint)) AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0,0,CAST(3 AS TINYINT),'',fldUserId, fldDesc, fldDate
--,N'سفته' AS fldTypeSanadName
--,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
--,'','',0,'',0 ,'' fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,com.MiladiTOShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus

--FROM         Drd.tblSafte

--INSERT INTO @temp
--SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL( cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT), ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
--,N'برات' AS fldTypeSanadName
--,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
--,'','',0,'',0,com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId)fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,com.MiladiTOShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus

--FROM         Drd.tblBarat
--SELECT * FROM @temp
--WHERE fldStatusName LIKE @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid  ))
--end
--end



--if (@fieldname=N'Ejra_fldShomareHesab')
--BEGIN
--IF(@AzTarikh <>'' AND @TaTarikh<>'')
--BEGIN
--INSERT INTO @temp
--SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
--                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ), cast(0 as bigint)) AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
--                      CAST(0 AS TINYINT)) AS fldStatus, ISNULL(Drd.tblCheck.fldShomareHesabId, 0) AS fldShomareHesabId, 0 AS fldBaratDarId, 
--                      CASE WHEN fldTypeSanad = 0 THEN CAST(2 AS TINYINT) ELSE CAST(6 AS TINYINT) END AS fldTypeSanad, '' AS fldMakanPardakht, Drd.tblCheck.fldUserId, 
--                      Drd.tblCheck.fldDesc, Drd.tblCheck.fldDate, CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, 
--                      ISNULL((CASE WHEN fldStatus = 1 THEN N'در انتظار وصول' WHEN fldStatus = 2 THEN N'وصول شده' WHEN fldStatus = 3 THEN N'برگشت خورده' WHEN fldStatus = 4 THEN
--                       N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END), '') AS fldStatusName, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblBank.fldBankName, 
--                      Com.tblSHobe.fldBankId, Com.tblSHobe.fldName AS fldNameShobe, Com.tblShomareHesabeOmoomi.fldShobeId, '' AS fldNameBaratDar, '' AS fldStatusFish, 
--                      '' AS fldStatusFishId, NULL AS fldFishId, Drd.tblCheck.fldShomareHesabIdOrgan, tblShomareHesabeOmoomi_1.fldShomareHesab AS fldShomareHesabOrgan
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,tblCheck.fldTarikhAkhz,fldDateStatus
--FROM         Drd.tblCheck INNER JOIN
--                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
--                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
--                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
--                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId

--INSERT INTO @temp
--SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL( cast(fldMablaghSanad as bigint),CAST(0 AS bigint)) AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0,0,CAST(3 AS TINYINT),'',fldUserId, fldDesc, fldDate
--,N'سفته' AS fldTypeSanadName
--,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
--,'','',0,'',0 ,'' fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,com.MiladiTOShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus

--FROM         Drd.tblSafte

--INSERT INTO @temp
--SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL( cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT), ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
--,N'برات' AS fldTypeSanadName
--,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
--,'','',0,'',0,com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId)fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,com.MiladiTOShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus

--FROM         Drd.tblBarat
--SELECT * FROM @temp
--WHERE  fldShomareHesab LIKE @value and fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
--AND fldTarikhSarResid BETWEEN @AzTarikh AND @TaTarikh
--end
--IF(@AzTarikh <>'' AND @TaTarikh='')
--BEGIN
--INSERT INTO @temp
--SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
--                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ), cast(0 as bigint)) AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
--                      CAST(0 AS TINYINT)) AS fldStatus, ISNULL(Drd.tblCheck.fldShomareHesabId, 0) AS fldShomareHesabId, 0 AS fldBaratDarId, 
--                      CASE WHEN fldTypeSanad = 0 THEN CAST(2 AS TINYINT) ELSE CAST(6 AS TINYINT) END AS fldTypeSanad, '' AS fldMakanPardakht, Drd.tblCheck.fldUserId, 
--                      Drd.tblCheck.fldDesc, Drd.tblCheck.fldDate, CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, 
--                      ISNULL((CASE WHEN fldStatus = 1 THEN N'در انتظار وصول' WHEN fldStatus = 2 THEN N'وصول شده' WHEN fldStatus = 3 THEN N'برگشت خورده' WHEN fldStatus = 4 THEN
--                       N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END), '') AS fldStatusName, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblBank.fldBankName, 
--                      Com.tblSHobe.fldBankId, Com.tblSHobe.fldName AS fldNameShobe, Com.tblShomareHesabeOmoomi.fldShobeId, '' AS fldNameBaratDar, '' AS fldStatusFish, 
--                      '' AS fldStatusFishId, NULL AS fldFishId, Drd.tblCheck.fldShomareHesabIdOrgan, tblShomareHesabeOmoomi_1.fldShomareHesab AS fldShomareHesabOrgan
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,tblCheck.fldTarikhAkhz,fldDateStatus
--FROM         Drd.tblCheck INNER JOIN
--                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
--                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
--                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
--                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId

--INSERT INTO @temp
--SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL( cast(fldMablaghSanad as bigint),CAST(0 AS bigint)) AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0,0,CAST(3 AS TINYINT),'',fldUserId, fldDesc, fldDate
--,N'سفته' AS fldTypeSanadName
--,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
--,'','',0,'',0 ,'' fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,com.MiladiTOShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus

--FROM         Drd.tblSafte

--INSERT INTO @temp
--SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL( cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT), ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
--,N'برات' AS fldTypeSanadName
--,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
--,'','',0,'',0,com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId)fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,com.MiladiTOShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus

--FROM         Drd.tblBarat
--SELECT * FROM @temp
--WHERE  fldShomareHesab LIKE @value AND  fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
--AND fldTarikhSarResid >= @AzTarikh 
--END 
--IF(@AzTarikh ='' AND @TaTarikh<>'')
--BEGIN
--INSERT INTO @temp
--SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
--                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ), cast(0 as bigint)) AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
--                      CAST(0 AS TINYINT)) AS fldStatus, ISNULL(Drd.tblCheck.fldShomareHesabId, 0) AS fldShomareHesabId, 0 AS fldBaratDarId, 
--                      CASE WHEN fldTypeSanad = 0 THEN CAST(2 AS TINYINT) ELSE CAST(6 AS TINYINT) END AS fldTypeSanad, '' AS fldMakanPardakht, Drd.tblCheck.fldUserId, 
--                      Drd.tblCheck.fldDesc, Drd.tblCheck.fldDate, CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, 
--                      ISNULL((CASE WHEN fldStatus = 1 THEN N'در انتظار وصول' WHEN fldStatus = 2 THEN N'وصول شده' WHEN fldStatus = 3 THEN N'برگشت خورده' WHEN fldStatus = 4 THEN
--                       N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END), '') AS fldStatusName, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblBank.fldBankName, 
--                      Com.tblSHobe.fldBankId, Com.tblSHobe.fldName AS fldNameShobe, Com.tblShomareHesabeOmoomi.fldShobeId, '' AS fldNameBaratDar, '' AS fldStatusFish, 
--                      '' AS fldStatusFishId, NULL AS fldFishId, Drd.tblCheck.fldShomareHesabIdOrgan, tblShomareHesabeOmoomi_1.fldShomareHesab AS fldShomareHesabOrgan
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,tblCheck.fldTarikhAkhz,fldDateStatus
--FROM         Drd.tblCheck INNER JOIN
--                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
--                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
--                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
--                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId

--INSERT INTO @temp
--SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL( cast(fldMablaghSanad as bigint),CAST(0 AS bigint)) AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0,0,CAST(3 AS TINYINT),'',fldUserId, fldDesc, fldDate
--,N'سفته' AS fldTypeSanadName
--,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
--,'','',0,'',0 ,'' fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,com.MiladiTOShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus

--FROM         Drd.tblSafte
--INSERT INTO @temp
--SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL( cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT), ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
--,N'برات' AS fldTypeSanadName
--,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
--,'','',0,'',0,com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId)fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,com.MiladiTOShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus

--FROM         Drd.tblBarat
--SELECT *FROM @temp
--WHERE  fldShomareHesab LIKE @value and fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
--AND fldTarikhSarResid <= @TaTarikh
--end
--IF(@AzTarikh ='' AND @TaTarikh='')
--BEGIN
--INSERT INTO @temp
--SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
--                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ), cast(0 as bigint)) AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
--                      CAST(0 AS TINYINT)) AS fldStatus, ISNULL(Drd.tblCheck.fldShomareHesabId, 0) AS fldShomareHesabId, 0 AS fldBaratDarId, 
--                      CASE WHEN fldTypeSanad = 0 THEN CAST(2 AS TINYINT) ELSE CAST(6 AS TINYINT) END AS fldTypeSanad, '' AS fldMakanPardakht, Drd.tblCheck.fldUserId, 
--                      Drd.tblCheck.fldDesc, Drd.tblCheck.fldDate, CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, 
--                      ISNULL((CASE WHEN fldStatus = 1 THEN N'در انتظار وصول' WHEN fldStatus = 2 THEN N'وصول شده' WHEN fldStatus = 3 THEN N'برگشت خورده' WHEN fldStatus = 4 THEN
--                       N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END), '') AS fldStatusName, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblBank.fldBankName, 
--                      Com.tblSHobe.fldBankId, Com.tblSHobe.fldName AS fldNameShobe, Com.tblShomareHesabeOmoomi.fldShobeId, '' AS fldNameBaratDar, '' AS fldStatusFish, 
--                      '' AS fldStatusFishId, NULL AS fldFishId, Drd.tblCheck.fldShomareHesabIdOrgan, tblShomareHesabeOmoomi_1.fldShomareHesab AS fldShomareHesabOrgan
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,tblCheck.fldTarikhAkhz,fldDateStatus
--FROM         Drd.tblCheck INNER JOIN
--                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
--                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
--                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
--                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId

--INSERT INTO @temp
--SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL( cast(fldMablaghSanad as bigint),CAST(0 AS bigint)) AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0,0,CAST(3 AS TINYINT),'',fldUserId, fldDesc, fldDate
--,N'سفته' AS fldTypeSanadName
--,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
--,'','',0,'',0 ,'' fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,com.MiladiTOShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus

--FROM         Drd.tblSafte

--INSERT INTO @temp
--SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL( cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT), ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
--,N'برات' AS fldTypeSanadName
--,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
--,'','',0,'',0,com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId)fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,com.MiladiTOShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus

--FROM         Drd.tblBarat
--SELECT * FROM @temp
--WHERE fldShomareHesab LIKE @value and  fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
--END


--END


--if (@fieldname=N'Ejra_fldNameShobe')
--BEGIN
--IF(@AzTarikh <>'' AND @TaTarikh<>'')
--BEGIN
--INSERT INTO @temp
--SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
--                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ), cast(0 as bigint)) AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
--                      CAST(0 AS TINYINT)) AS fldStatus, ISNULL(Drd.tblCheck.fldShomareHesabId, 0) AS fldShomareHesabId, 0 AS fldBaratDarId, 
--                      CASE WHEN fldTypeSanad = 0 THEN CAST(2 AS TINYINT) ELSE CAST(6 AS TINYINT) END AS fldTypeSanad, '' AS fldMakanPardakht, Drd.tblCheck.fldUserId, 
--                      Drd.tblCheck.fldDesc, Drd.tblCheck.fldDate, CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, 
--                      ISNULL((CASE WHEN fldStatus = 1 THEN N'در انتظار وصول' WHEN fldStatus = 2 THEN N'وصول شده' WHEN fldStatus = 3 THEN N'برگشت خورده' WHEN fldStatus = 4 THEN
--                       N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END), '') AS fldStatusName, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblBank.fldBankName, 
--                      Com.tblSHobe.fldBankId, Com.tblSHobe.fldName AS fldNameShobe, Com.tblShomareHesabeOmoomi.fldShobeId, '' AS fldNameBaratDar, '' AS fldStatusFish, 
--                      '' AS fldStatusFishId, NULL AS fldFishId, Drd.tblCheck.fldShomareHesabIdOrgan, tblShomareHesabeOmoomi_1.fldShomareHesab AS fldShomareHesabOrgan
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,tblCheck.fldTarikhAkhz,fldDateStatus
--FROM         Drd.tblCheck INNER JOIN
--                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
--                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
--                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
--                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId

--INSERT INTO @temp
--SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL( cast(fldMablaghSanad as bigint),CAST(0 AS bigint)) AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0,0,CAST(3 AS TINYINT),'',fldUserId, fldDesc, fldDate
--,N'سفته' AS fldTypeSanadName
--,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
--,'','',0,'',0 ,'' fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,com.MiladiTOShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
--FROM         Drd.tblSafte

--INSERT INTO @temp
--SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL( cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT), ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
--,N'برات' AS fldTypeSanadName
--,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
--,'','',0,'',0,com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId)fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,com.MiladiTOShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus

--FROM         Drd.tblBarat
--SELECT * FROM @temp
--WHERE fldNameShobe LIKE @value AND    fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
--AND fldTarikhSarResid BETWEEN @AzTarikh AND @TaTarikh
--end
--IF(@AzTarikh <>'' AND @TaTarikh='')
--BEGIN
--INSERT INTO @temp
--SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
--                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ), cast(0 as bigint)) AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
--                      CAST(0 AS TINYINT)) AS fldStatus, ISNULL(Drd.tblCheck.fldShomareHesabId, 0) AS fldShomareHesabId, 0 AS fldBaratDarId, 
--                      CASE WHEN fldTypeSanad = 0 THEN CAST(2 AS TINYINT) ELSE CAST(6 AS TINYINT) END AS fldTypeSanad, '' AS fldMakanPardakht, Drd.tblCheck.fldUserId, 
--                      Drd.tblCheck.fldDesc, Drd.tblCheck.fldDate, CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, 
--                      ISNULL((CASE WHEN fldStatus = 1 THEN N'در انتظار وصول' WHEN fldStatus = 2 THEN N'وصول شده' WHEN fldStatus = 3 THEN N'برگشت خورده' WHEN fldStatus = 4 THEN
--                       N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END), '') AS fldStatusName, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblBank.fldBankName, 
--                      Com.tblSHobe.fldBankId, Com.tblSHobe.fldName AS fldNameShobe, Com.tblShomareHesabeOmoomi.fldShobeId, '' AS fldNameBaratDar, '' AS fldStatusFish, 
--                      '' AS fldStatusFishId, NULL AS fldFishId, Drd.tblCheck.fldShomareHesabIdOrgan, tblShomareHesabeOmoomi_1.fldShomareHesab AS fldShomareHesabOrgan
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,tblCheck.fldTarikhAkhz,fldDateStatus
--FROM         Drd.tblCheck INNER JOIN
--                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
--                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
--                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
--                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId

--INSERT INTO @temp
--SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL( cast(fldMablaghSanad as bigint),CAST(0 AS bigint)) AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0,0,CAST(3 AS TINYINT),'',fldUserId, fldDesc, fldDate
--,N'سفته' AS fldTypeSanadName
--,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
--,'','',0,'',0 ,'' fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,com.MiladiTOShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
--FROM         Drd.tblSafte

--INSERT INTO @temp
--SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL( cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT), ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
--,N'برات' AS fldTypeSanadName
--,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
--,'','',0,'',0,com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId)fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,com.MiladiTOShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus

--FROM         Drd.tblBarat
--SELECT * FROM @temp
--WHERE fldNameShobe LIKE @value AND    fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
--AND fldTarikhSarResid >= @AzTarikh 
--END 
--IF(@AzTarikh ='' AND @TaTarikh<>'')
--BEGIN
--INSERT INTO @temp
--SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
--                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ), cast(0 as bigint)) AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
--                      CAST(0 AS TINYINT)) AS fldStatus, ISNULL(Drd.tblCheck.fldShomareHesabId, 0) AS fldShomareHesabId, 0 AS fldBaratDarId, 
--                      CASE WHEN fldTypeSanad = 0 THEN CAST(2 AS TINYINT) ELSE CAST(6 AS TINYINT) END AS fldTypeSanad, '' AS fldMakanPardakht, Drd.tblCheck.fldUserId, 
--                      Drd.tblCheck.fldDesc, Drd.tblCheck.fldDate, CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, 
--                      ISNULL((CASE WHEN fldStatus = 1 THEN N'در انتظار وصول' WHEN fldStatus = 2 THEN N'وصول شده' WHEN fldStatus = 3 THEN N'برگشت خورده' WHEN fldStatus = 4 THEN
--                       N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END), '') AS fldStatusName, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblBank.fldBankName, 
--                      Com.tblSHobe.fldBankId, Com.tblSHobe.fldName AS fldNameShobe, Com.tblShomareHesabeOmoomi.fldShobeId, '' AS fldNameBaratDar, '' AS fldStatusFish, 
--                      '' AS fldStatusFishId, NULL AS fldFishId, Drd.tblCheck.fldShomareHesabIdOrgan, tblShomareHesabeOmoomi_1.fldShomareHesab AS fldShomareHesabOrgan
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,tblCheck.fldTarikhAkhz,fldDateStatus
--FROM         Drd.tblCheck INNER JOIN
--                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
--                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
--                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
--                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId

--INSERT INTO @temp
--SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL( cast(fldMablaghSanad as bigint),CAST(0 AS bigint)) AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0,0,CAST(3 AS TINYINT),'',fldUserId, fldDesc, fldDate
--,N'سفته' AS fldTypeSanadName
--,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
--,'','',0,'',0 ,'' fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,com.MiladiTOShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
--FROM         Drd.tblSafte
--INSERT INTO @temp
--SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL( cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT), ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
--,N'برات' AS fldTypeSanadName
--,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
--,'','',0,'',0,com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId)fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,com.MiladiTOShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus

--FROM         Drd.tblBarat
--SELECT *FROM @temp
--WHERE fldNameShobe LIKE @value AND    fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
--AND fldTarikhSarResid <= @TaTarikh
--end
--IF(@AzTarikh ='' AND @TaTarikh='')
--BEGIN
--INSERT INTO @temp
--SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
--                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ), cast(0 as bigint)) AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
--                      CAST(0 AS TINYINT)) AS fldStatus, ISNULL(Drd.tblCheck.fldShomareHesabId, 0) AS fldShomareHesabId, 0 AS fldBaratDarId, 
--                      CASE WHEN fldTypeSanad = 0 THEN CAST(2 AS TINYINT) ELSE CAST(6 AS TINYINT) END AS fldTypeSanad, '' AS fldMakanPardakht, Drd.tblCheck.fldUserId, 
--                      Drd.tblCheck.fldDesc, Drd.tblCheck.fldDate, CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, 
--                      ISNULL((CASE WHEN fldStatus = 1 THEN N'در انتظار وصول' WHEN fldStatus = 2 THEN N'وصول شده' WHEN fldStatus = 3 THEN N'برگشت خورده' WHEN fldStatus = 4 THEN
--                       N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END), '') AS fldStatusName, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblBank.fldBankName, 
--                      Com.tblSHobe.fldBankId, Com.tblSHobe.fldName AS fldNameShobe, Com.tblShomareHesabeOmoomi.fldShobeId, '' AS fldNameBaratDar, '' AS fldStatusFish, 
--                      '' AS fldStatusFishId, NULL AS fldFishId, Drd.tblCheck.fldShomareHesabIdOrgan, tblShomareHesabeOmoomi_1.fldShomareHesab AS fldShomareHesabOrgan
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,tblCheck.fldTarikhAkhz,fldDateStatus
--FROM         Drd.tblCheck INNER JOIN
--                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
--                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
--                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
--                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId

--INSERT INTO @temp
--SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL( cast(fldMablaghSanad as bigint),CAST(0 AS bigint)) AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0,0,CAST(3 AS TINYINT),'',fldUserId, fldDesc, fldDate
--,N'سفته' AS fldTypeSanadName
--,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
--,'','',0,'',0 ,'' fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,com.MiladiTOShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
--FROM         Drd.tblSafte

--INSERT INTO @temp
--SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL( cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT), ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
--,N'برات' AS fldTypeSanadName
--,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
--,'','',0,'',0,com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId)fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,com.MiladiTOShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus

--FROM         Drd.tblBarat
--SELECT * FROM @temp
--WHERE fldNameShobe LIKE @value AND   fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
--END


--END


--if (@fieldname=N'Ejra_fldBankName')
--BEGIN
--IF(@AzTarikh <>'' AND @TaTarikh<>'')
--BEGIN
--INSERT INTO @temp
--SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
--                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ), cast(0 as bigint)) AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
--                      CAST(0 AS TINYINT)) AS fldStatus, ISNULL(Drd.tblCheck.fldShomareHesabId, 0) AS fldShomareHesabId, 0 AS fldBaratDarId, 
--                      CASE WHEN fldTypeSanad = 0 THEN CAST(2 AS TINYINT) ELSE CAST(6 AS TINYINT) END AS fldTypeSanad, '' AS fldMakanPardakht, Drd.tblCheck.fldUserId, 
--                      Drd.tblCheck.fldDesc, Drd.tblCheck.fldDate, CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, 
--                      ISNULL((CASE WHEN fldStatus = 1 THEN N'در انتظار وصول' WHEN fldStatus = 2 THEN N'وصول شده' WHEN fldStatus = 3 THEN N'برگشت خورده' WHEN fldStatus = 4 THEN
--                       N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END), '') AS fldStatusName, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblBank.fldBankName, 
--                      Com.tblSHobe.fldBankId, Com.tblSHobe.fldName AS fldNameShobe, Com.tblShomareHesabeOmoomi.fldShobeId, '' AS fldNameBaratDar, '' AS fldStatusFish, 
--                      '' AS fldStatusFishId, NULL AS fldFishId, Drd.tblCheck.fldShomareHesabIdOrgan, tblShomareHesabeOmoomi_1.fldShomareHesab AS fldShomareHesabOrgan
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,tblCheck.fldTarikhAkhz,fldDateStatus
--FROM         Drd.tblCheck INNER JOIN
--                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
--                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
--                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
--                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId

--INSERT INTO @temp
--SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL( cast(fldMablaghSanad as bigint),CAST(0 AS bigint)) AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0,0,CAST(3 AS TINYINT),'',fldUserId, fldDesc, fldDate
--,N'سفته' AS fldTypeSanadName
--,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
--,'','',0,'',0 ,'' fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,com.MiladiTOShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
--FROM         Drd.tblSafte

--INSERT INTO @temp
--SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL( cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT), ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
--,N'برات' AS fldTypeSanadName
--,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
--,'','',0,'',0,com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId)fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,com.MiladiTOShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus

--FROM         Drd.tblBarat
--SELECT * FROM @temp
--WHERE fldBankName LIKE @value AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
--AND fldTarikhSarResid BETWEEN @AzTarikh AND @TaTarikh
--end
--IF(@AzTarikh <>'' AND @TaTarikh='')
--BEGIN
--INSERT INTO @temp
--SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
--                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ), cast(0 as bigint)) AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
--                      CAST(0 AS TINYINT)) AS fldStatus, ISNULL(Drd.tblCheck.fldShomareHesabId, 0) AS fldShomareHesabId, 0 AS fldBaratDarId, 
--                      CASE WHEN fldTypeSanad = 0 THEN CAST(2 AS TINYINT) ELSE CAST(6 AS TINYINT) END AS fldTypeSanad, '' AS fldMakanPardakht, Drd.tblCheck.fldUserId, 
--                      Drd.tblCheck.fldDesc, Drd.tblCheck.fldDate, CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, 
--                      ISNULL((CASE WHEN fldStatus = 1 THEN N'در انتظار وصول' WHEN fldStatus = 2 THEN N'وصول شده' WHEN fldStatus = 3 THEN N'برگشت خورده' WHEN fldStatus = 4 THEN
--                       N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END), '') AS fldStatusName, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblBank.fldBankName, 
--                      Com.tblSHobe.fldBankId, Com.tblSHobe.fldName AS fldNameShobe, Com.tblShomareHesabeOmoomi.fldShobeId, '' AS fldNameBaratDar, '' AS fldStatusFish, 
--                      '' AS fldStatusFishId, NULL AS fldFishId, Drd.tblCheck.fldShomareHesabIdOrgan, tblShomareHesabeOmoomi_1.fldShomareHesab AS fldShomareHesabOrgan
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,tblCheck.fldTarikhAkhz,fldDateStatus
--FROM         Drd.tblCheck INNER JOIN
--                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
--                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
--                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
--                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId

--INSERT INTO @temp
--SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL( cast(fldMablaghSanad as bigint),CAST(0 AS bigint)) AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0,0,CAST(3 AS TINYINT),'',fldUserId, fldDesc, fldDate
--,N'سفته' AS fldTypeSanadName
--,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
--,'','',0,'',0 ,'' fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,com.MiladiTOShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus

--FROM         Drd.tblSafte

--INSERT INTO @temp
--SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL( cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT), ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
--,N'برات' AS fldTypeSanadName
--,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
--,'','',0,'',0,com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId)fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,com.MiladiTOShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
--FROM         Drd.tblBarat
--SELECT * FROM @temp
--WHERE fldBankName LIKE @value AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
--AND fldTarikhSarResid >= @AzTarikh 
--END 
--IF(@AzTarikh ='' AND @TaTarikh<>'')
--BEGIN
--INSERT INTO @temp
--SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
--                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ), cast(0 as bigint)) AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
--                      CAST(0 AS TINYINT)) AS fldStatus, ISNULL(Drd.tblCheck.fldShomareHesabId, 0) AS fldShomareHesabId, 0 AS fldBaratDarId, 
--                      CASE WHEN fldTypeSanad = 0 THEN CAST(2 AS TINYINT) ELSE CAST(6 AS TINYINT) END AS fldTypeSanad, '' AS fldMakanPardakht, Drd.tblCheck.fldUserId, 
--                      Drd.tblCheck.fldDesc, Drd.tblCheck.fldDate, CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, 
--                      ISNULL((CASE WHEN fldStatus = 1 THEN N'در انتظار وصول' WHEN fldStatus = 2 THEN N'وصول شده' WHEN fldStatus = 3 THEN N'برگشت خورده' WHEN fldStatus = 4 THEN
--                       N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END), '') AS fldStatusName, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblBank.fldBankName, 
--                      Com.tblSHobe.fldBankId, Com.tblSHobe.fldName AS fldNameShobe, Com.tblShomareHesabeOmoomi.fldShobeId, '' AS fldNameBaratDar, '' AS fldStatusFish, 
--                      '' AS fldStatusFishId, NULL AS fldFishId, Drd.tblCheck.fldShomareHesabIdOrgan, tblShomareHesabeOmoomi_1.fldShomareHesab AS fldShomareHesabOrgan
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,tblCheck.fldTarikhAkhz,fldDateStatus
--FROM         Drd.tblCheck INNER JOIN
--                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
--                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
--                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
--                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId

--INSERT INTO @temp
--SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL( cast(fldMablaghSanad as bigint),CAST(0 AS bigint)) AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0,0,CAST(3 AS TINYINT),'',fldUserId, fldDesc, fldDate
--,N'سفته' AS fldTypeSanadName
--,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
--,'','',0,'',0 ,'' fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,com.MiladiTOShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
--FROM         Drd.tblSafte
--INSERT INTO @temp
--SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL( cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT), ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
--,N'برات' AS fldTypeSanadName
--,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
--,'','',0,'',0,com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId)fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,com.MiladiTOShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus

--FROM         Drd.tblBarat
--SELECT *FROM @temp
--WHERE fldBankName LIKE @value AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
--AND fldTarikhSarResid <= @TaTarikh
--end
--IF(@AzTarikh ='' AND @TaTarikh='')
--BEGIN
--INSERT INTO @temp
--SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
--                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ), cast(0 as bigint)) AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
--                      CAST(0 AS TINYINT)) AS fldStatus, ISNULL(Drd.tblCheck.fldShomareHesabId, 0) AS fldShomareHesabId, 0 AS fldBaratDarId, 
--                      CASE WHEN fldTypeSanad = 0 THEN CAST(2 AS TINYINT) ELSE CAST(6 AS TINYINT) END AS fldTypeSanad, '' AS fldMakanPardakht, Drd.tblCheck.fldUserId, 
--                      Drd.tblCheck.fldDesc, Drd.tblCheck.fldDate, CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, 
--                      ISNULL((CASE WHEN fldStatus = 1 THEN N'در انتظار وصول' WHEN fldStatus = 2 THEN N'وصول شده' WHEN fldStatus = 3 THEN N'برگشت خورده' WHEN fldStatus = 4 THEN
--                       N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END), '') AS fldStatusName, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblBank.fldBankName, 
--                      Com.tblSHobe.fldBankId, Com.tblSHobe.fldName AS fldNameShobe, Com.tblShomareHesabeOmoomi.fldShobeId, '' AS fldNameBaratDar, '' AS fldStatusFish, 
--                      '' AS fldStatusFishId, NULL AS fldFishId, Drd.tblCheck.fldShomareHesabIdOrgan, tblShomareHesabeOmoomi_1.fldShomareHesab AS fldShomareHesabOrgan
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,tblCheck.fldTarikhAkhz,fldDateStatus
--FROM         Drd.tblCheck INNER JOIN
--                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
--                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
--                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
--                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId

--INSERT INTO @temp
--SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL( cast(fldMablaghSanad as bigint),CAST(0 AS bigint)) AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0,0,CAST(3 AS TINYINT),'',fldUserId, fldDesc, fldDate
--,N'سفته' AS fldTypeSanadName
--,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
--,'','',0,'',0 ,'' fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,com.MiladiTOShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
--FROM         Drd.tblSafte

--INSERT INTO @temp
--SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL( cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT), ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
--,N'برات' AS fldTypeSanadName
--,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
--,'','',0,'',0,com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId)fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,com.MiladiTOShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus

--FROM         Drd.tblBarat
--SELECT * FROM @temp
--WHERE fldBankName LIKE @value AND  fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
--END


--END

--if (@fieldname=N'Ejra_fldTarikhSarResid')
--BEGIN
--IF(@AzTarikh <>'' AND @TaTarikh<>'')
--BEGIN
--INSERT INTO @temp
--SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
--                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ), cast(0 as bigint)) AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
--                      CAST(0 AS TINYINT)) AS fldStatus, ISNULL(Drd.tblCheck.fldShomareHesabId, 0) AS fldShomareHesabId, 0 AS fldBaratDarId, 
--                      CASE WHEN fldTypeSanad = 0 THEN CAST(2 AS TINYINT) ELSE CAST(6 AS TINYINT) END AS fldTypeSanad, '' AS fldMakanPardakht, Drd.tblCheck.fldUserId, 
--                      Drd.tblCheck.fldDesc, Drd.tblCheck.fldDate, CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, 
--                      ISNULL((CASE WHEN fldStatus = 1 THEN N'در انتظار وصول' WHEN fldStatus = 2 THEN N'وصول شده' WHEN fldStatus = 3 THEN N'برگشت خورده' WHEN fldStatus = 4 THEN
--                       N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END), '') AS fldStatusName, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblBank.fldBankName, 
--                      Com.tblSHobe.fldBankId, Com.tblSHobe.fldName AS fldNameShobe, Com.tblShomareHesabeOmoomi.fldShobeId, '' AS fldNameBaratDar, '' AS fldStatusFish, 
--                      '' AS fldStatusFishId, NULL AS fldFishId, Drd.tblCheck.fldShomareHesabIdOrgan, tblShomareHesabeOmoomi_1.fldShomareHesab AS fldShomareHesabOrgan
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,tblCheck.fldTarikhAkhz,fldDateStatus
--FROM         Drd.tblCheck INNER JOIN
--                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
--                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
--                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
--                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId

--INSERT INTO @temp
--SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL( cast(fldMablaghSanad as bigint),CAST(0 AS bigint)) AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0,0,CAST(3 AS TINYINT),'',fldUserId, fldDesc, fldDate
--,N'سفته' AS fldTypeSanadName
--,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
--,'','',0,'',0 ,'' fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,com.MiladiTOShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
--FROM         Drd.tblSafte

--INSERT INTO @temp
--SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL( cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT), ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
--,N'برات' AS fldTypeSanadName
--,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
--,'','',0,'',0,com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId)fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,com.MiladiTOShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus

--FROM         Drd.tblBarat
--SELECT * FROM @temp
--WHERE fldTarikhSarResid LIKE @value AND  fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
--AND fldTarikhSarResid BETWEEN @AzTarikh AND @TaTarikh
--end
--IF(@AzTarikh <>'' AND @TaTarikh='')
--BEGIN
--INSERT INTO @temp
--SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
--                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ), cast(0 as bigint)) AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
--                      CAST(0 AS TINYINT)) AS fldStatus, ISNULL(Drd.tblCheck.fldShomareHesabId, 0) AS fldShomareHesabId, 0 AS fldBaratDarId, 
--                      CASE WHEN fldTypeSanad = 0 THEN CAST(2 AS TINYINT) ELSE CAST(6 AS TINYINT) END AS fldTypeSanad, '' AS fldMakanPardakht, Drd.tblCheck.fldUserId, 
--                      Drd.tblCheck.fldDesc, Drd.tblCheck.fldDate, CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, 
--                      ISNULL((CASE WHEN fldStatus = 1 THEN N'در انتظار وصول' WHEN fldStatus = 2 THEN N'وصول شده' WHEN fldStatus = 3 THEN N'برگشت خورده' WHEN fldStatus = 4 THEN
--                       N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END), '') AS fldStatusName, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblBank.fldBankName, 
--                      Com.tblSHobe.fldBankId, Com.tblSHobe.fldName AS fldNameShobe, Com.tblShomareHesabeOmoomi.fldShobeId, '' AS fldNameBaratDar, '' AS fldStatusFish, 
--                      '' AS fldStatusFishId, NULL AS fldFishId, Drd.tblCheck.fldShomareHesabIdOrgan, tblShomareHesabeOmoomi_1.fldShomareHesab AS fldShomareHesabOrgan
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,tblCheck.fldTarikhAkhz,fldDateStatus
--FROM         Drd.tblCheck INNER JOIN
--                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
--                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
--                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
--                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId

--INSERT INTO @temp
--SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL( cast(fldMablaghSanad as bigint),CAST(0 AS bigint)) AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0,0,CAST(3 AS TINYINT),'',fldUserId, fldDesc, fldDate
--,N'سفته' AS fldTypeSanadName
--,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
--,'','',0,'',0 ,'' fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,com.MiladiTOShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
--FROM         Drd.tblSafte

--INSERT INTO @temp
--SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL( cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT), ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
--,N'برات' AS fldTypeSanadName
--,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
--,'','',0,'',0,com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId)fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,com.MiladiTOShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus

--FROM         Drd.tblBarat
--SELECT * FROM @temp
--WHERE fldTarikhSarResid LIKE @value AND  fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
--AND fldTarikhSarResid >= @AzTarikh 
--END 
--IF(@AzTarikh ='' AND @TaTarikh<>'')
--BEGIN
--INSERT INTO @temp
--SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
--                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ), cast(0 as bigint)) AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
--                      CAST(0 AS TINYINT)) AS fldStatus, ISNULL(Drd.tblCheck.fldShomareHesabId, 0) AS fldShomareHesabId, 0 AS fldBaratDarId, 
--                      CASE WHEN fldTypeSanad = 0 THEN CAST(2 AS TINYINT) ELSE CAST(6 AS TINYINT) END AS fldTypeSanad, '' AS fldMakanPardakht, Drd.tblCheck.fldUserId, 
--                      Drd.tblCheck.fldDesc, Drd.tblCheck.fldDate, CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, 
--                      ISNULL((CASE WHEN fldStatus = 1 THEN N'در انتظار وصول' WHEN fldStatus = 2 THEN N'وصول شده' WHEN fldStatus = 3 THEN N'برگشت خورده' WHEN fldStatus = 4 THEN
--                       N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END), '') AS fldStatusName, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblBank.fldBankName, 
--                      Com.tblSHobe.fldBankId, Com.tblSHobe.fldName AS fldNameShobe, Com.tblShomareHesabeOmoomi.fldShobeId, '' AS fldNameBaratDar, '' AS fldStatusFish, 
--                      '' AS fldStatusFishId, NULL AS fldFishId, Drd.tblCheck.fldShomareHesabIdOrgan, tblShomareHesabeOmoomi_1.fldShomareHesab AS fldShomareHesabOrgan
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,tblCheck.fldTarikhAkhz,fldDateStatus
--FROM         Drd.tblCheck INNER JOIN
--                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
--                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
--                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
--                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId

--INSERT INTO @temp
--SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL( cast(fldMablaghSanad as bigint),CAST(0 AS bigint)) AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0,0,CAST(3 AS TINYINT),'',fldUserId, fldDesc, fldDate
--,N'سفته' AS fldTypeSanadName
--,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
--,'','',0,'',0 ,'' fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,com.MiladiTOShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
--FROM         Drd.tblSafte
--INSERT INTO @temp
--SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL( cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT), ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
--,N'برات' AS fldTypeSanadName
--,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
--,'','',0,'',0,com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId)fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,com.MiladiTOShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus

--FROM         Drd.tblBarat
--SELECT *FROM @temp
--WHERE fldTarikhSarResid LIKE @value AND  fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
--AND fldTarikhSarResid <= @TaTarikh
--end
--IF(@AzTarikh ='' AND @TaTarikh='')
--BEGIN
--INSERT INTO @temp
--SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
--                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ), cast(0 as bigint)) AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
--                      CAST(0 AS TINYINT)) AS fldStatus, ISNULL(Drd.tblCheck.fldShomareHesabId, 0) AS fldShomareHesabId, 0 AS fldBaratDarId, 
--                      CASE WHEN fldTypeSanad = 0 THEN CAST(2 AS TINYINT) ELSE CAST(6 AS TINYINT) END AS fldTypeSanad, '' AS fldMakanPardakht, Drd.tblCheck.fldUserId, 
--                      Drd.tblCheck.fldDesc, Drd.tblCheck.fldDate, CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, 
--                      ISNULL((CASE WHEN fldStatus = 1 THEN N'در انتظار وصول' WHEN fldStatus = 2 THEN N'وصول شده' WHEN fldStatus = 3 THEN N'برگشت خورده' WHEN fldStatus = 4 THEN
--                       N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END), '') AS fldStatusName, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblBank.fldBankName, 
--                      Com.tblSHobe.fldBankId, Com.tblSHobe.fldName AS fldNameShobe, Com.tblShomareHesabeOmoomi.fldShobeId, '' AS fldNameBaratDar, '' AS fldStatusFish, 
--                      '' AS fldStatusFishId, NULL AS fldFishId, Drd.tblCheck.fldShomareHesabIdOrgan, tblShomareHesabeOmoomi_1.fldShomareHesab AS fldShomareHesabOrgan
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,tblCheck.fldTarikhAkhz,fldDateStatus
--FROM         Drd.tblCheck INNER JOIN
--                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
--                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
--                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
--                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId

--INSERT INTO @temp
--SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL( cast(fldMablaghSanad as bigint),CAST(0 AS bigint)) AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0,0,CAST(3 AS TINYINT),'',fldUserId, fldDesc, fldDate
--,N'سفته' AS fldTypeSanadName
--,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
--,'','',0,'',0 ,'' fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,com.MiladiTOShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
--FROM         Drd.tblSafte

--INSERT INTO @temp
--SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL( cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT), ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
--,N'برات' AS fldTypeSanadName
--,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
--,'','',0,'',0,com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId)fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,com.MiladiTOShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus

--FROM         Drd.tblBarat
--SELECT * FROM @temp
--WHERE fldTarikhSarResid LIKE @value AND   fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
--END


--END



--if (@fieldname=N'Ejra_fldShomareSanad')
--BEGIN
--IF(@AzTarikh <>'' AND @TaTarikh<>'')
--BEGIN
--INSERT INTO @temp
--SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
--                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ), cast(0 as bigint)) AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
--                      CAST(0 AS TINYINT)) AS fldStatus, ISNULL(Drd.tblCheck.fldShomareHesabId, 0) AS fldShomareHesabId, 0 AS fldBaratDarId, 
--                      CASE WHEN fldTypeSanad = 0 THEN CAST(2 AS TINYINT) ELSE CAST(6 AS TINYINT) END AS fldTypeSanad, '' AS fldMakanPardakht, Drd.tblCheck.fldUserId, 
--                      Drd.tblCheck.fldDesc, Drd.tblCheck.fldDate, CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, 
--                      ISNULL((CASE WHEN fldStatus = 1 THEN N'در انتظار وصول' WHEN fldStatus = 2 THEN N'وصول شده' WHEN fldStatus = 3 THEN N'برگشت خورده' WHEN fldStatus = 4 THEN
--                       N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END), '') AS fldStatusName, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblBank.fldBankName, 
--                      Com.tblSHobe.fldBankId, Com.tblSHobe.fldName AS fldNameShobe, Com.tblShomareHesabeOmoomi.fldShobeId, '' AS fldNameBaratDar, '' AS fldStatusFish, 
--                      '' AS fldStatusFishId, NULL AS fldFishId, Drd.tblCheck.fldShomareHesabIdOrgan, tblShomareHesabeOmoomi_1.fldShomareHesab AS fldShomareHesabOrgan
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,tblCheck.fldTarikhAkhz,fldDateStatus
--FROM         Drd.tblCheck INNER JOIN
--                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
--                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
--                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
--                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId

--INSERT INTO @temp
--SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL( cast(fldMablaghSanad as bigint),CAST(0 AS bigint)) AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0,0,CAST(3 AS TINYINT),'',fldUserId, fldDesc, fldDate
--,N'سفته' AS fldTypeSanadName
--,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
--,'','',0,'',0 ,'' fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,com.MiladiTOShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
--FROM         Drd.tblSafte

--INSERT INTO @temp
--SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL( cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT), ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
--,N'برات' AS fldTypeSanadName
--,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
--,'','',0,'',0,com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId)fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,com.MiladiTOShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus

--FROM         Drd.tblBarat
--SELECT * FROM @temp
--WHERE fldShomareSanad LIKE @value and fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
--AND fldTarikhSarResid BETWEEN @AzTarikh AND @TaTarikh
--end
--IF(@AzTarikh <>'' AND @TaTarikh='')
--BEGIN
--INSERT INTO @temp
--SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
--                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ), cast(0 as bigint)) AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
--                      CAST(0 AS TINYINT)) AS fldStatus, ISNULL(Drd.tblCheck.fldShomareHesabId, 0) AS fldShomareHesabId, 0 AS fldBaratDarId, 
--                      CASE WHEN fldTypeSanad = 0 THEN CAST(2 AS TINYINT) ELSE CAST(6 AS TINYINT) END AS fldTypeSanad, '' AS fldMakanPardakht, Drd.tblCheck.fldUserId, 
--                      Drd.tblCheck.fldDesc, Drd.tblCheck.fldDate, CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, 
--                      ISNULL((CASE WHEN fldStatus = 1 THEN N'در انتظار وصول' WHEN fldStatus = 2 THEN N'وصول شده' WHEN fldStatus = 3 THEN N'برگشت خورده' WHEN fldStatus = 4 THEN
--                       N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END), '') AS fldStatusName, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblBank.fldBankName, 
--                      Com.tblSHobe.fldBankId, Com.tblSHobe.fldName AS fldNameShobe, Com.tblShomareHesabeOmoomi.fldShobeId, '' AS fldNameBaratDar, '' AS fldStatusFish, 
--                      '' AS fldStatusFishId, NULL AS fldFishId, Drd.tblCheck.fldShomareHesabIdOrgan, tblShomareHesabeOmoomi_1.fldShomareHesab AS fldShomareHesabOrgan
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,tblCheck.fldTarikhAkhz,fldDateStatus
--FROM         Drd.tblCheck INNER JOIN
--                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
--                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
--                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
--                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId

--INSERT INTO @temp
--SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL( cast(fldMablaghSanad as bigint),CAST(0 AS bigint)) AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0,0,CAST(3 AS TINYINT),'',fldUserId, fldDesc, fldDate
--,N'سفته' AS fldTypeSanadName
--,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
--,'','',0,'',0 ,'' fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,com.MiladiTOShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
--FROM         Drd.tblSafte

--INSERT INTO @temp
--SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL( cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT), ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
--,N'برات' AS fldTypeSanadName
--,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
--,'','',0,'',0,com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId)fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,com.MiladiTOShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus

--FROM         Drd.tblBarat
--SELECT * FROM @temp
--WHERE fldShomareSanad LIKE @value and fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
--AND fldTarikhSarResid >= @AzTarikh 
--END 
--IF(@AzTarikh ='' AND @TaTarikh<>'')
--BEGIN
--INSERT INTO @temp
--SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
--                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ), cast(0 as bigint)) AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
--                      CAST(0 AS TINYINT)) AS fldStatus, ISNULL(Drd.tblCheck.fldShomareHesabId, 0) AS fldShomareHesabId, 0 AS fldBaratDarId, 
--                      CASE WHEN fldTypeSanad = 0 THEN CAST(2 AS TINYINT) ELSE CAST(6 AS TINYINT) END AS fldTypeSanad, '' AS fldMakanPardakht, Drd.tblCheck.fldUserId, 
--                      Drd.tblCheck.fldDesc, Drd.tblCheck.fldDate, CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, 
--                      ISNULL((CASE WHEN fldStatus = 1 THEN N'در انتظار وصول' WHEN fldStatus = 2 THEN N'وصول شده' WHEN fldStatus = 3 THEN N'برگشت خورده' WHEN fldStatus = 4 THEN
--                       N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END), '') AS fldStatusName, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblBank.fldBankName, 
--                      Com.tblSHobe.fldBankId, Com.tblSHobe.fldName AS fldNameShobe, Com.tblShomareHesabeOmoomi.fldShobeId, '' AS fldNameBaratDar, '' AS fldStatusFish, 
--                      '' AS fldStatusFishId, NULL AS fldFishId, Drd.tblCheck.fldShomareHesabIdOrgan, tblShomareHesabeOmoomi_1.fldShomareHesab AS fldShomareHesabOrgan
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,tblCheck.fldTarikhAkhz,fldDateStatus
--FROM         Drd.tblCheck INNER JOIN
--                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
--                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
--                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
--                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId

--INSERT INTO @temp
--SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL( cast(fldMablaghSanad as bigint),CAST(0 AS bigint)) AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0,0,CAST(3 AS TINYINT),'',fldUserId, fldDesc, fldDate
--,N'سفته' AS fldTypeSanadName
--,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
--,'','',0,'',0 ,'' fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,com.MiladiTOShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
--FROM         Drd.tblSafte
--INSERT INTO @temp
--SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL( cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT), ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
--,N'برات' AS fldTypeSanadName
--,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
--,'','',0,'',0,com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId)fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,com.MiladiTOShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus

--FROM         Drd.tblBarat
--SELECT *FROM @temp
--WHERE fldShomareSanad LIKE @value and fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
--AND fldTarikhSarResid <= @TaTarikh
--end
--IF(@AzTarikh ='' AND @TaTarikh='')
--BEGIN
--INSERT INTO @temp
--SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
--                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ), cast(0 as bigint)) AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
--                      CAST(0 AS TINYINT)) AS fldStatus, ISNULL(Drd.tblCheck.fldShomareHesabId, 0) AS fldShomareHesabId, 0 AS fldBaratDarId, 
--                      CASE WHEN fldTypeSanad = 0 THEN CAST(2 AS TINYINT) ELSE CAST(6 AS TINYINT) END AS fldTypeSanad, '' AS fldMakanPardakht, Drd.tblCheck.fldUserId, 
--                      Drd.tblCheck.fldDesc, Drd.tblCheck.fldDate, CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, 
--                      ISNULL((CASE WHEN fldStatus = 1 THEN N'در انتظار وصول' WHEN fldStatus = 2 THEN N'وصول شده' WHEN fldStatus = 3 THEN N'برگشت خورده' WHEN fldStatus = 4 THEN
--                       N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END), '') AS fldStatusName, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblBank.fldBankName, 
--                      Com.tblSHobe.fldBankId, Com.tblSHobe.fldName AS fldNameShobe, Com.tblShomareHesabeOmoomi.fldShobeId, '' AS fldNameBaratDar, '' AS fldStatusFish, 
--                      '' AS fldStatusFishId, NULL AS fldFishId, Drd.tblCheck.fldShomareHesabIdOrgan, tblShomareHesabeOmoomi_1.fldShomareHesab AS fldShomareHesabOrgan
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,tblCheck.fldTarikhAkhz,fldDateStatus
--FROM         Drd.tblCheck INNER JOIN
--                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
--                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
--                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
--                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId

--INSERT INTO @temp
--SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL( cast(fldMablaghSanad as bigint),CAST(0 AS bigint)) AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0,0,CAST(3 AS TINYINT),'',fldUserId, fldDesc, fldDate
--,N'سفته' AS fldTypeSanadName
--,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
--,'','',0,'',0 ,'' fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,com.MiladiTOShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
--FROM         Drd.tblSafte

--INSERT INTO @temp
--SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL( cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT), ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
--,N'برات' AS fldTypeSanadName
--,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
--,'','',0,'',0,com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId)fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,com.MiladiTOShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus

--FROM         Drd.tblBarat
--SELECT * FROM @temp
--WHERE fldShomareSanad LIKE @value and  fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
--END







--END

--if (@fieldname=N'Ejra_fldTarikhAkhz')
--BEGIN
--IF(@AzTarikh <>'' AND @TaTarikh<>'')
--BEGIN
--INSERT INTO @temp
--SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
--                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ), cast(0 as bigint)) AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
--                      CAST(0 AS TINYINT)) AS fldStatus, ISNULL(Drd.tblCheck.fldShomareHesabId, 0) AS fldShomareHesabId, 0 AS fldBaratDarId, 
--                      CASE WHEN fldTypeSanad = 0 THEN CAST(2 AS TINYINT) ELSE CAST(6 AS TINYINT) END AS fldTypeSanad, '' AS fldMakanPardakht, Drd.tblCheck.fldUserId, 
--                      Drd.tblCheck.fldDesc, Drd.tblCheck.fldDate, CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, 
--                      ISNULL((CASE WHEN fldStatus = 1 THEN N'در انتظار وصول' WHEN fldStatus = 2 THEN N'وصول شده' WHEN fldStatus = 3 THEN N'برگشت خورده' WHEN fldStatus = 4 THEN
--                       N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END), '') AS fldStatusName, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblBank.fldBankName, 
--                      Com.tblSHobe.fldBankId, Com.tblSHobe.fldName AS fldNameShobe, Com.tblShomareHesabeOmoomi.fldShobeId, '' AS fldNameBaratDar, '' AS fldStatusFish, 
--                      '' AS fldStatusFishId, NULL AS fldFishId, Drd.tblCheck.fldShomareHesabIdOrgan, tblShomareHesabeOmoomi_1.fldShomareHesab AS fldShomareHesabOrgan
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,tblCheck.fldTarikhAkhz,fldDateStatus
--FROM         Drd.tblCheck INNER JOIN
--                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
--                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
--                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
--                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId

--INSERT INTO @temp
--SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL( cast(fldMablaghSanad as bigint),CAST(0 AS bigint)) AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0,0,CAST(3 AS TINYINT),'',fldUserId, fldDesc, fldDate
--,N'سفته' AS fldTypeSanadName
--,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
--,'','',0,'',0 ,'' fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,com.MiladiTOShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
--FROM         Drd.tblSafte

--INSERT INTO @temp
--SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL( cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT), ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
--,N'برات' AS fldTypeSanadName
--,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
--,'','',0,'',0,com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId)fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,com.MiladiTOShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus

--FROM         Drd.tblBarat
--SELECT * FROM @temp
--WHERE fldTarikhAkhz LIKE @value and fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
--AND fldTarikhSarResid BETWEEN @AzTarikh AND @TaTarikh
--end
--IF(@AzTarikh <>'' AND @TaTarikh='')
--BEGIN
--INSERT INTO @temp
--SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
--                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ), cast(0 as bigint)) AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
--                      CAST(0 AS TINYINT)) AS fldStatus, ISNULL(Drd.tblCheck.fldShomareHesabId, 0) AS fldShomareHesabId, 0 AS fldBaratDarId, 
--                      CASE WHEN fldTypeSanad = 0 THEN CAST(2 AS TINYINT) ELSE CAST(6 AS TINYINT) END AS fldTypeSanad, '' AS fldMakanPardakht, Drd.tblCheck.fldUserId, 
--                      Drd.tblCheck.fldDesc, Drd.tblCheck.fldDate, CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, 
--                      ISNULL((CASE WHEN fldStatus = 1 THEN N'در انتظار وصول' WHEN fldStatus = 2 THEN N'وصول شده' WHEN fldStatus = 3 THEN N'برگشت خورده' WHEN fldStatus = 4 THEN
--                       N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END), '') AS fldStatusName, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblBank.fldBankName, 
--                      Com.tblSHobe.fldBankId, Com.tblSHobe.fldName AS fldNameShobe, Com.tblShomareHesabeOmoomi.fldShobeId, '' AS fldNameBaratDar, '' AS fldStatusFish, 
--                      '' AS fldStatusFishId, NULL AS fldFishId, Drd.tblCheck.fldShomareHesabIdOrgan, tblShomareHesabeOmoomi_1.fldShomareHesab AS fldShomareHesabOrgan
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,tblCheck.fldTarikhAkhz,fldDateStatus
--FROM         Drd.tblCheck INNER JOIN
--                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
--                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
--                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
--                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId

--INSERT INTO @temp
--SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL( cast(fldMablaghSanad as bigint),CAST(0 AS bigint)) AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0,0,CAST(3 AS TINYINT),'',fldUserId, fldDesc, fldDate
--,N'سفته' AS fldTypeSanadName
--,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
--,'','',0,'',0 ,'' fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,com.MiladiTOShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
--FROM         Drd.tblSafte

--INSERT INTO @temp
--SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL( cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT), ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
--,N'برات' AS fldTypeSanadName
--,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
--,'','',0,'',0,com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId)fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,com.MiladiTOShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus

--FROM         Drd.tblBarat
--SELECT * FROM @temp
--WHERE fldTarikhAkhz LIKE @value and fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
--AND fldTarikhSarResid >= @AzTarikh 
--END 
--IF(@AzTarikh ='' AND @TaTarikh<>'')
--BEGIN
--INSERT INTO @temp
--SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
--                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ), cast(0 as bigint)) AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
--                      CAST(0 AS TINYINT)) AS fldStatus, ISNULL(Drd.tblCheck.fldShomareHesabId, 0) AS fldShomareHesabId, 0 AS fldBaratDarId, 
--                      CASE WHEN fldTypeSanad = 0 THEN CAST(2 AS TINYINT) ELSE CAST(6 AS TINYINT) END AS fldTypeSanad, '' AS fldMakanPardakht, Drd.tblCheck.fldUserId, 
--                      Drd.tblCheck.fldDesc, Drd.tblCheck.fldDate, CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, 
--                      ISNULL((CASE WHEN fldStatus = 1 THEN N'در انتظار وصول' WHEN fldStatus = 2 THEN N'وصول شده' WHEN fldStatus = 3 THEN N'برگشت خورده' WHEN fldStatus = 4 THEN
--                       N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END), '') AS fldStatusName, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblBank.fldBankName, 
--                      Com.tblSHobe.fldBankId, Com.tblSHobe.fldName AS fldNameShobe, Com.tblShomareHesabeOmoomi.fldShobeId, '' AS fldNameBaratDar, '' AS fldStatusFish, 
--                      '' AS fldStatusFishId, NULL AS fldFishId, Drd.tblCheck.fldShomareHesabIdOrgan, tblShomareHesabeOmoomi_1.fldShomareHesab AS fldShomareHesabOrgan
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,tblCheck.fldTarikhAkhz,fldDateStatus
--FROM         Drd.tblCheck INNER JOIN
--                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
--                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
--                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
--                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId

--INSERT INTO @temp
--SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL( cast(fldMablaghSanad as bigint),CAST(0 AS bigint)) AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0,0,CAST(3 AS TINYINT),'',fldUserId, fldDesc, fldDate
--,N'سفته' AS fldTypeSanadName
--,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
--,'','',0,'',0 ,'' fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,com.MiladiTOShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
--FROM         Drd.tblSafte
--INSERT INTO @temp
--SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL( cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT), ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
--,N'برات' AS fldTypeSanadName
--,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
--,'','',0,'',0,com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId)fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,com.MiladiTOShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus

--FROM         Drd.tblBarat
--SELECT *FROM @temp
--WHERE fldTarikhAkhz LIKE @value and fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
--AND fldTarikhSarResid <= @TaTarikh
--end
--IF(@AzTarikh ='' AND @TaTarikh='')
--BEGIN
--INSERT INTO @temp
--SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
--                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ), cast(0 as bigint)) AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
--                      CAST(0 AS TINYINT)) AS fldStatus, ISNULL(Drd.tblCheck.fldShomareHesabId, 0) AS fldShomareHesabId, 0 AS fldBaratDarId, 
--                      CASE WHEN fldTypeSanad = 0 THEN CAST(2 AS TINYINT) ELSE CAST(6 AS TINYINT) END AS fldTypeSanad, '' AS fldMakanPardakht, Drd.tblCheck.fldUserId, 
--                      Drd.tblCheck.fldDesc, Drd.tblCheck.fldDate, CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, 
--                      ISNULL((CASE WHEN fldStatus = 1 THEN N'در انتظار وصول' WHEN fldStatus = 2 THEN N'وصول شده' WHEN fldStatus = 3 THEN N'برگشت خورده' WHEN fldStatus = 4 THEN
--                       N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END), '') AS fldStatusName, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblBank.fldBankName, 
--                      Com.tblSHobe.fldBankId, Com.tblSHobe.fldName AS fldNameShobe, Com.tblShomareHesabeOmoomi.fldShobeId, '' AS fldNameBaratDar, '' AS fldStatusFish, 
--                      '' AS fldStatusFishId, NULL AS fldFishId, Drd.tblCheck.fldShomareHesabIdOrgan, tblShomareHesabeOmoomi_1.fldShomareHesab AS fldShomareHesabOrgan
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,tblCheck.fldTarikhAkhz,fldDateStatus
--FROM         Drd.tblCheck INNER JOIN
--                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
--                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
--                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
--                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId

--INSERT INTO @temp
--SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL( cast(fldMablaghSanad as bigint),CAST(0 AS bigint)) AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0,0,CAST(3 AS TINYINT),'',fldUserId, fldDesc, fldDate
--,N'سفته' AS fldTypeSanadName
--,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
--,'','',0,'',0 ,'' fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,com.MiladiTOShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
--FROM         Drd.tblSafte

--INSERT INTO @temp
--SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL( cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT), ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
--,N'برات' AS fldTypeSanadName
--,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
--,'','',0,'',0,com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId)fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
--,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
--					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
--					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
--,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
--,com.MiladiTOShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus

--FROM         Drd.tblBarat
--SELECT * FROM @temp
--WHERE fldTarikhAkhz LIKE @value and  fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
--END


--END

commit
GO
