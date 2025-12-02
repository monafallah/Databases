SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_DataForElamAvarez_Safte]
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
SELECT TOP(@h)  * FROM (
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0 AS fldShomareHesabId,0 AS fldBaratDarId,CAST(3 AS TINYINT)AS fldTypeSanad,'' fldMakanPardakht,fldUserId, fldDesc, fldDate
,N'سفته' AS fldTypeSanadName
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,''fldShomareHesab,''fldBankName,0 fldBankId,'' fldNameShobe,0 fldShobeId,'' fldNameBaratDar,''fldStatusFish,''AS fldStatusFishId,NULL AS fldFishId,0 fldShomareHesabIdOrgan,'' fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
FROM         Drd.tblSafte


)t
WHERE fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND t.fldTarikhSarResid BETWEEN @AzTarikh AND @TaTarikh

IF(@AzTarikh <>'' AND @TaTarikh='')
SELECT TOP(@h)  * FROM (
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0 AS fldShomareHesabId,0 AS fldBaratDarId,CAST(3 AS TINYINT)AS fldTypeSanad,'' fldMakanPardakht,fldUserId, fldDesc, fldDate
,N'سفته' AS fldTypeSanadName
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,''fldShomareHesab,''fldBankName,0 fldBankId,'' fldNameShobe,0 fldShobeId,'' fldNameBaratDar,''fldStatusFish,''AS fldStatusFishId,NULL AS fldFishId,0 fldShomareHesabIdOrgan,'' fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
FROM         Drd.tblSafte

)t
WHERE fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND t.fldTarikhSarResid >= @AzTarikh 

IF(@AzTarikh ='' AND @TaTarikh<>'')
SELECT TOP(@h)  * FROM (
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0 AS fldShomareHesabId,0 AS fldBaratDarId,CAST(3 AS TINYINT)AS fldTypeSanad,'' fldMakanPardakht,fldUserId, fldDesc, fldDate
,N'سفته' AS fldTypeSanadName
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,''fldShomareHesab,''fldBankName,0 fldBankId,'' fldNameShobe,0 fldShobeId,'' fldNameBaratDar,''fldStatusFish,''AS fldStatusFishId,NULL AS fldFishId,0 fldShomareHesabIdOrgan,'' fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus

FROM         Drd.tblSafte


)t
WHERE  fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND t.fldTarikhSarResid <= @TaTarikh

IF(@AzTarikh ='' AND @TaTarikh='')
SELECT TOP(@h)  * FROM (
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0 AS fldShomareHesabId,0 AS fldBaratDarId,CAST(3 AS TINYINT)AS fldTypeSanad,'' fldMakanPardakht,fldUserId, fldDesc, fldDate
,N'سفته' AS fldTypeSanadName
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,''fldShomareHesab,''fldBankName,0 fldBankId,'' fldNameShobe,0 fldShobeId,'' fldNameBaratDar,''fldStatusFish,''AS fldStatusFishId,NULL AS fldFishId,0 fldShomareHesabIdOrgan,'' fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus

FROM         Drd.tblSafte
--where  fldTarikhSarResid like @Year+'%'

)t
WHERE  fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))

END



IF (@fieldname=N'Ejra_fldTarikhSarResid')
BEGIN
IF(@AzTarikh <>'' AND @TaTarikh<>'')
SELECT TOP(@h)  * FROM (
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0 AS fldShomareHesabId,0 AS fldBaratDarId,CAST(3 AS TINYINT)AS fldTypeSanad,'' fldMakanPardakht,fldUserId, fldDesc, fldDate
,N'سفته' AS fldTypeSanadName
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,''fldShomareHesab,''fldBankName,0 fldBankId,'' fldNameShobe,0 fldShobeId,'' fldNameBaratDar,''fldStatusFish,''AS fldStatusFishId,NULL AS fldFishId,0 fldShomareHesabIdOrgan,'' fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL THEN (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) END
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL THEN (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) END
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL THEN (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) END
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus

FROM         Drd.tblSafte


)t
WHERE fldTarikhSarResid LIKE @value AND  fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND t.fldTarikhSarResid BETWEEN @AzTarikh AND @TaTarikh

IF(@AzTarikh <>'' AND @TaTarikh='')
SELECT TOP(@h)  * FROM (
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0 AS fldShomareHesabId,0 AS fldBaratDarId,CAST(3 AS TINYINT)AS fldTypeSanad,'' fldMakanPardakht,fldUserId, fldDesc, fldDate
,N'سفته' AS fldTypeSanadName
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,''fldShomareHesab,''fldBankName,0 fldBankId,'' fldNameShobe,0 fldShobeId,'' fldNameBaratDar,''fldStatusFish,''AS fldStatusFishId,NULL AS fldFishId,0 fldShomareHesabIdOrgan,'' fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus

FROM         Drd.tblSafte

)t
WHERE fldTarikhSarResid LIKE @value AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND t.fldTarikhSarResid >= @AzTarikh 

IF(@AzTarikh ='' AND @TaTarikh<>'')
SELECT TOP(@h)  * FROM (
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0 AS fldShomareHesabId,0 AS fldBaratDarId,CAST(3 AS TINYINT)AS fldTypeSanad,'' fldMakanPardakht,fldUserId, fldDesc, fldDate
,N'سفته' AS fldTypeSanadName
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,''fldShomareHesab,''fldBankName,0 fldBankId,'' fldNameShobe,0 fldShobeId,'' fldNameBaratDar,''fldStatusFish,''AS fldStatusFishId,NULL AS fldFishId,0 fldShomareHesabIdOrgan,'' fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
FROM         Drd.tblSafte


)t
WHERE fldTarikhSarResid LIKE @value AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND t.fldTarikhSarResid <= @TaTarikh

IF(@AzTarikh ='' AND @TaTarikh='')
SELECT TOP(@h)  * FROM (
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0 AS fldShomareHesabId,0 AS fldBaratDarId,CAST(3 AS TINYINT)AS fldTypeSanad,'' fldMakanPardakht,fldUserId, fldDesc, fldDate
,N'سفته' AS fldTypeSanadName
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,''fldShomareHesab,''fldBankName,0 fldBankId,'' fldNameShobe,0 fldShobeId,'' fldNameBaratDar,''fldStatusFish,''AS fldStatusFishId,NULL AS fldFishId,0 fldShomareHesabIdOrgan,'' fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
FROM         Drd.tblSafte
--where  fldTarikhSarResid like @Year+'%'

)t
WHERE fldTarikhSarResid LIKE @value AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))

END



IF (@fieldname=N'Ejra_fldDateStatus')
BEGIN
IF(@AzTarikh <>'' AND @TaTarikh<>'')
SELECT TOP(@h)  * FROM (
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0 AS fldShomareHesabId,0 AS fldBaratDarId,CAST(3 AS TINYINT)AS fldTypeSanad,'' fldMakanPardakht,fldUserId, fldDesc, fldDate
,N'سفته' AS fldTypeSanadName
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,''fldShomareHesab,''fldBankName,0 fldBankId,'' fldNameShobe,0 fldShobeId,'' fldNameBaratDar,''fldStatusFish,''AS fldStatusFishId,NULL AS fldFishId,0 fldShomareHesabIdOrgan,'' fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL THEN (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) END
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL THEN (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) END
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL THEN (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) END
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus

FROM         Drd.tblSafte


)t
WHERE fldDateStatus LIKE @value AND  fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND t.fldTarikhSarResid BETWEEN @AzTarikh AND @TaTarikh

IF(@AzTarikh <>'' AND @TaTarikh='')
SELECT TOP(@h)  * FROM (
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0 AS fldShomareHesabId,0 AS fldBaratDarId,CAST(3 AS TINYINT)AS fldTypeSanad,'' fldMakanPardakht,fldUserId, fldDesc, fldDate
,N'سفته' AS fldTypeSanadName
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,''fldShomareHesab,''fldBankName,0 fldBankId,'' fldNameShobe,0 fldShobeId,'' fldNameBaratDar,''fldStatusFish,''AS fldStatusFishId,NULL AS fldFishId,0 fldShomareHesabIdOrgan,'' fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus

FROM         Drd.tblSafte

)t
WHERE fldDateStatus LIKE @value AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND t.fldTarikhSarResid >= @AzTarikh 

IF(@AzTarikh ='' AND @TaTarikh<>'')
SELECT TOP(@h)  * FROM (
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0 AS fldShomareHesabId,0 AS fldBaratDarId,CAST(3 AS TINYINT)AS fldTypeSanad,'' fldMakanPardakht,fldUserId, fldDesc, fldDate
,N'سفته' AS fldTypeSanadName
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,''fldShomareHesab,''fldBankName,0 fldBankId,'' fldNameShobe,0 fldShobeId,'' fldNameBaratDar,''fldStatusFish,''AS fldStatusFishId,NULL AS fldFishId,0 fldShomareHesabIdOrgan,'' fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
FROM         Drd.tblSafte


)t
WHERE fldDateStatus LIKE @value AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND t.fldTarikhSarResid <= @TaTarikh

IF(@AzTarikh ='' AND @TaTarikh='')
SELECT TOP(@h)  * FROM (
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0 AS fldShomareHesabId,0 AS fldBaratDarId,CAST(3 AS TINYINT)AS fldTypeSanad,'' fldMakanPardakht,fldUserId, fldDesc, fldDate
,N'سفته' AS fldTypeSanadName
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,''fldShomareHesab,''fldBankName,0 fldBankId,'' fldNameShobe,0 fldShobeId,'' fldNameBaratDar,''fldStatusFish,''AS fldStatusFishId,NULL AS fldFishId,0 fldShomareHesabIdOrgan,'' fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
FROM         Drd.tblSafte
--where  fldTarikhSarResid like @Year+'%'

)t
WHERE fldDateStatus LIKE @value AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))

END




IF (@fieldname=N'Ejra_fldMablaghSanad')
BEGIN
IF(@AzTarikh <>'' AND @TaTarikh<>'')
SELECT TOP(@h)  * FROM (
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0 AS fldShomareHesabId,0 AS fldBaratDarId,CAST(3 AS TINYINT)AS fldTypeSanad,'' fldMakanPardakht,fldUserId, fldDesc, fldDate
,N'سفته' AS fldTypeSanadName
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,''fldShomareHesab,''fldBankName,0 fldBankId,'' fldNameShobe,0 fldShobeId,'' fldNameBaratDar,''fldStatusFish,''AS fldStatusFishId,NULL AS fldFishId,0 fldShomareHesabIdOrgan,'' fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL THEN (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) END
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL THEN (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) END
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL THEN (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) END
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus

FROM         Drd.tblSafte


)t
WHERE fldMablaghSanad LIKE @value AND  fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND t.fldTarikhSarResid BETWEEN @AzTarikh AND @TaTarikh

IF(@AzTarikh <>'' AND @TaTarikh='')
SELECT TOP(@h)  * FROM (
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0 AS fldShomareHesabId,0 AS fldBaratDarId,CAST(3 AS TINYINT)AS fldTypeSanad,'' fldMakanPardakht,fldUserId, fldDesc, fldDate
,N'سفته' AS fldTypeSanadName
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,''fldShomareHesab,''fldBankName,0 fldBankId,'' fldNameShobe,0 fldShobeId,'' fldNameBaratDar,''fldStatusFish,''AS fldStatusFishId,NULL AS fldFishId,0 fldShomareHesabIdOrgan,'' fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus

FROM         Drd.tblSafte

)t
WHERE fldMablaghSanad LIKE @value AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND t.fldTarikhSarResid >= @AzTarikh 

IF(@AzTarikh ='' AND @TaTarikh<>'')
SELECT TOP(@h)  * FROM (
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0 AS fldShomareHesabId,0 AS fldBaratDarId,CAST(3 AS TINYINT)AS fldTypeSanad,'' fldMakanPardakht,fldUserId, fldDesc, fldDate
,N'سفته' AS fldTypeSanadName
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,''fldShomareHesab,''fldBankName,0 fldBankId,'' fldNameShobe,0 fldShobeId,'' fldNameBaratDar,''fldStatusFish,''AS fldStatusFishId,NULL AS fldFishId,0 fldShomareHesabIdOrgan,'' fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
FROM         Drd.tblSafte


)t
WHERE fldMablaghSanad LIKE @value AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND t.fldTarikhSarResid <= @TaTarikh

IF(@AzTarikh ='' AND @TaTarikh='')
SELECT TOP(@h)  * FROM (
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0 AS fldShomareHesabId,0 AS fldBaratDarId,CAST(3 AS TINYINT)AS fldTypeSanad,'' fldMakanPardakht,fldUserId, fldDesc, fldDate
,N'سفته' AS fldTypeSanadName
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,''fldShomareHesab,''fldBankName,0 fldBankId,'' fldNameShobe,0 fldShobeId,'' fldNameBaratDar,''fldStatusFish,''AS fldStatusFishId,NULL AS fldFishId,0 fldShomareHesabIdOrgan,'' fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
FROM         Drd.tblSafte
--where  fldTarikhSarResid like @Year+'%'

)t
WHERE fldMablaghSanad LIKE @value AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))

END




IF (@fieldname=N'Ejra_fldElamAvarezId')
BEGIN
IF(@AzTarikh <>'' AND @TaTarikh<>'')
SELECT TOP(@h)  * FROM (
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0 AS fldShomareHesabId,0 AS fldBaratDarId,CAST(3 AS TINYINT)AS fldTypeSanad,'' fldMakanPardakht,fldUserId, fldDesc, fldDate
,N'سفته' AS fldTypeSanadName
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,''fldShomareHesab,''fldBankName,0 fldBankId,'' fldNameShobe,0 fldShobeId,'' fldNameBaratDar,''fldStatusFish,''AS fldStatusFishId,NULL AS fldFishId,0 fldShomareHesabIdOrgan,'' fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL THEN (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) END
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL THEN (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) END
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL THEN (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) END
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
FROM         Drd.tblSafte


)t
WHERE fldElamAvarezId LIKE @value AND  fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND t.fldTarikhSarResid BETWEEN @AzTarikh AND @TaTarikh

IF(@AzTarikh <>'' AND @TaTarikh='')
SELECT TOP(@h)  * FROM (
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0 AS fldShomareHesabId,0 AS fldBaratDarId,CAST(3 AS TINYINT)AS fldTypeSanad,'' fldMakanPardakht,fldUserId, fldDesc, fldDate
,N'سفته' AS fldTypeSanadName
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,''fldShomareHesab,''fldBankName,0 fldBankId,'' fldNameShobe,0 fldShobeId,'' fldNameBaratDar,''fldStatusFish,''AS fldStatusFishId,NULL AS fldFishId,0 fldShomareHesabIdOrgan,'' fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
FROM         Drd.tblSafte

)t
WHERE fldElamAvarezId LIKE @value AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND t.fldTarikhSarResid >= @AzTarikh 

IF(@AzTarikh ='' AND @TaTarikh<>'')
SELECT TOP(@h)  * FROM (
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0 AS fldShomareHesabId,0 AS fldBaratDarId,CAST(3 AS TINYINT)AS fldTypeSanad,'' fldMakanPardakht,fldUserId, fldDesc, fldDate
,N'سفته' AS fldTypeSanadName
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,''fldShomareHesab,''fldBankName,0 fldBankId,'' fldNameShobe,0 fldShobeId,'' fldNameBaratDar,''fldStatusFish,''AS fldStatusFishId,NULL AS fldFishId,0 fldShomareHesabIdOrgan,'' fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
FROM         Drd.tblSafte


)t
WHERE fldElamAvarezId LIKE @value AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND t.fldTarikhSarResid <= @TaTarikh

IF(@AzTarikh ='' AND @TaTarikh='')
SELECT TOP(@h)  * FROM (
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0 AS fldShomareHesabId,0 AS fldBaratDarId,CAST(3 AS TINYINT)AS fldTypeSanad,'' fldMakanPardakht,fldUserId, fldDesc, fldDate
,N'سفته' AS fldTypeSanadName
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,''fldShomareHesab,''fldBankName,0 fldBankId,'' fldNameShobe,0 fldShobeId,'' fldNameBaratDar,''fldStatusFish,''AS fldStatusFishId,NULL AS fldFishId,0 fldShomareHesabIdOrgan,'' fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
FROM         Drd.tblSafte
--where  fldTarikhSarResid like @Year+'%'
)t
WHERE fldElamAvarezId LIKE @value AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))

END



IF (@fieldname=N'Ejra_fldShomareSanad')
BEGIN
IF(@AzTarikh <>'' AND @TaTarikh<>'')
SELECT TOP(@h)  * FROM (
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0 AS fldShomareHesabId,0 AS fldBaratDarId,CAST(3 AS TINYINT)AS fldTypeSanad,'' fldMakanPardakht,fldUserId, fldDesc, fldDate
,N'سفته' AS fldTypeSanadName
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,''fldShomareHesab,''fldBankName,0 fldBankId,'' fldNameShobe,0 fldShobeId,'' fldNameBaratDar,''fldStatusFish,''AS fldStatusFishId,NULL AS fldFishId,0 fldShomareHesabIdOrgan,'' fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
FROM         Drd.tblSafte


)t
WHERE fldShomareSanad LIKE @value and fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND t.fldTarikhSarResid BETWEEN @AzTarikh AND @TaTarikh

IF(@AzTarikh <>'' AND @TaTarikh='')
SELECT TOP(@h)  * FROM (
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0 AS fldShomareHesabId,0 AS fldBaratDarId,CAST(3 AS TINYINT)AS fldTypeSanad,'' fldMakanPardakht,fldUserId, fldDesc, fldDate
,N'سفته' AS fldTypeSanadName
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,''fldShomareHesab,''fldBankName,0 fldBankId,'' fldNameShobe,0 fldShobeId,'' fldNameBaratDar,''fldStatusFish,''AS fldStatusFishId,NULL AS fldFishId,0 fldShomareHesabIdOrgan,'' fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
FROM         Drd.tblSafte

)t
WHERE fldShomareSanad LIKE @value and fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND t.fldTarikhSarResid >= @AzTarikh 

IF(@AzTarikh ='' AND @TaTarikh<>'')
SELECT TOP(@h)  * FROM (
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0 AS fldShomareHesabId,0 AS fldBaratDarId,CAST(3 AS TINYINT)AS fldTypeSanad,'' fldMakanPardakht,fldUserId, fldDesc, fldDate
,N'سفته' AS fldTypeSanadName
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,''fldShomareHesab,''fldBankName,0 fldBankId,'' fldNameShobe,0 fldShobeId,'' fldNameBaratDar,''fldStatusFish,''AS fldStatusFishId,NULL AS fldFishId,0 fldShomareHesabIdOrgan,'' fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
FROM         Drd.tblSafte


)t
WHERE fldShomareSanad LIKE @value and fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND t.fldTarikhSarResid <= @TaTarikh

IF(@AzTarikh ='' AND @TaTarikh='')
SELECT TOP(@h)  * FROM (
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0 AS fldShomareHesabId,0 AS fldBaratDarId,CAST(3 AS TINYINT)AS fldTypeSanad,'' fldMakanPardakht,fldUserId, fldDesc, fldDate
,N'سفته' AS fldTypeSanadName
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,''fldShomareHesab,''fldBankName,0 fldBankId,'' fldNameShobe,0 fldShobeId,'' fldNameBaratDar,''fldStatusFish,''AS fldStatusFishId,NULL AS fldFishId,0 fldShomareHesabIdOrgan,'' fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL THEN (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) END
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL THEN (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) END
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL THEN (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) END
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
FROM         Drd.tblSafte
--where  fldTarikhSarResid like @Year+'%'

)t
WHERE fldShomareSanad LIKE @value and fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))

END


IF (@fieldname=N'Ejra_fldStatusName')
BEGIN
IF(@AzTarikh <>'' AND @TaTarikh<>'')
SELECT TOP(@h)  * FROM (
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0 AS fldShomareHesabId,0 AS fldBaratDarId,CAST(3 AS TINYINT)AS fldTypeSanad,'' fldMakanPardakht,fldUserId, fldDesc, fldDate
,N'سفته' AS fldTypeSanadName
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,''fldShomareHesab,''fldBankName,0 fldBankId,'' fldNameShobe,0 fldShobeId,'' fldNameBaratDar,''fldStatusFish,''AS fldStatusFishId,NULL AS fldFishId,0 fldShomareHesabIdOrgan,'' fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
FROM         Drd.tblSafte


)t
WHERE fldStatusName LIKE @value and fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND t.fldTarikhSarResid BETWEEN @AzTarikh AND @TaTarikh

IF(@AzTarikh <>'' AND @TaTarikh='')
SELECT TOP(@h)  * FROM (
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0 AS fldShomareHesabId,0 AS fldBaratDarId,CAST(3 AS TINYINT)AS fldTypeSanad,'' fldMakanPardakht,fldUserId, fldDesc, fldDate
,N'سفته' AS fldTypeSanadName
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,''fldShomareHesab,''fldBankName,0 fldBankId,'' fldNameShobe,0 fldShobeId,'' fldNameBaratDar,''fldStatusFish,''AS fldStatusFishId,NULL AS fldFishId,0 fldShomareHesabIdOrgan,'' fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL THEN (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) END
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL THEN (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) END
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL THEN (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) END
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
FROM         Drd.tblSafte

)t
WHERE fldStatusName LIKE @value and fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND t.fldTarikhSarResid >= @AzTarikh 

IF(@AzTarikh ='' AND @TaTarikh<>'')
SELECT TOP(@h)  * FROM (
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0 AS fldShomareHesabId,0 AS fldBaratDarId,CAST(3 AS TINYINT)AS fldTypeSanad,'' fldMakanPardakht,fldUserId, fldDesc, fldDate
,N'سفته' AS fldTypeSanadName
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,''fldShomareHesab,''fldBankName,0 fldBankId,'' fldNameShobe,0 fldShobeId,'' fldNameBaratDar,''fldStatusFish,''AS fldStatusFishId,NULL AS fldFishId,0 fldShomareHesabIdOrgan,'' fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL THEN (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) END
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL THEN (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) END
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL THEN (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) END
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
FROM         Drd.tblSafte


)t
WHERE fldStatusName LIKE @value and fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND t.fldTarikhSarResid <= @TaTarikh

IF(@AzTarikh ='' AND @TaTarikh='')
SELECT TOP(@h)  * FROM (
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0 AS fldShomareHesabId,0 AS fldBaratDarId,CAST(3 AS TINYINT)AS fldTypeSanad,'' fldMakanPardakht,fldUserId, fldDesc, fldDate
,N'سفته' AS fldTypeSanadName
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,''fldShomareHesab,''fldBankName,0 fldBankId,'' fldNameShobe,0 fldShobeId,'' fldNameBaratDar,''fldStatusFish,''AS fldStatusFishId,NULL AS fldFishId,0 fldShomareHesabIdOrgan,'' fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL THEN (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) END
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL THEN (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) END
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL THEN (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) END
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
FROM         Drd.tblSafte
--where  fldTarikhSarResid like @Year+'%'

)t
WHERE fldStatusName LIKE @value and fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))

END


IF (@fieldname=N'Ejra_fldTypeSanadName')
BEGIN
IF(@AzTarikh <>'' AND @TaTarikh<>'')
SELECT TOP(@h)  * FROM (
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0 AS fldShomareHesabId,0 AS fldBaratDarId,CAST(3 AS TINYINT)AS fldTypeSanad,'' fldMakanPardakht,fldUserId, fldDesc, fldDate
,N'سفته' AS fldTypeSanadName
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,''fldShomareHesab,''fldBankName,0 fldBankId,'' fldNameShobe,0 fldShobeId,'' fldNameBaratDar,''fldStatusFish,''AS fldStatusFishId,NULL AS fldFishId,0 fldShomareHesabIdOrgan,'' fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
FROM         Drd.tblSafte


)t
WHERE fldTypeSanadName LIKE @value AND  fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND t.fldTarikhSarResid BETWEEN @AzTarikh AND @TaTarikh

IF(@AzTarikh <>'' AND @TaTarikh='')
SELECT TOP(@h)  * FROM (
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0 AS fldShomareHesabId,0 AS fldBaratDarId,CAST(3 AS TINYINT)AS fldTypeSanad,'' fldMakanPardakht,fldUserId, fldDesc, fldDate
,N'سفته' AS fldTypeSanadName
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,''fldShomareHesab,''fldBankName,0 fldBankId,'' fldNameShobe,0 fldShobeId,'' fldNameBaratDar,''fldStatusFish,''AS fldStatusFishId,NULL AS fldFishId,0 fldShomareHesabIdOrgan,'' fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
FROM         Drd.tblSafte

)t
WHERE fldTypeSanadName LIKE @value AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND t.fldTarikhSarResid >= @AzTarikh 

IF(@AzTarikh ='' AND @TaTarikh<>'')
SELECT TOP(@h)  * FROM (
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0 AS fldShomareHesabId,0 AS fldBaratDarId,CAST(3 AS TINYINT)AS fldTypeSanad,'' fldMakanPardakht,fldUserId, fldDesc, fldDate
,N'سفته' AS fldTypeSanadName
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,''fldShomareHesab,''fldBankName,0 fldBankId,'' fldNameShobe,0 fldShobeId,'' fldNameBaratDar,''fldStatusFish,''AS fldStatusFishId,NULL AS fldFishId,0 fldShomareHesabIdOrgan,'' fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
FROM         Drd.tblSafte


)t
WHERE fldTypeSanadName LIKE @value AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND t.fldTarikhSarResid <= @TaTarikh

IF(@AzTarikh ='' AND @TaTarikh='')
SELECT TOP(@h)  * FROM (
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0 AS fldShomareHesabId,0 AS fldBaratDarId,CAST(3 AS TINYINT)AS fldTypeSanad,'' fldMakanPardakht,fldUserId, fldDesc, fldDate
,N'سفته' AS fldTypeSanadName
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,''fldShomareHesab,''fldBankName,0 fldBankId,'' fldNameShobe,0 fldShobeId,'' fldNameBaratDar,''fldStatusFish,''AS fldStatusFishId,NULL AS fldFishId,0 fldShomareHesabIdOrgan,'' fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
FROM         Drd.tblSafte
--where  fldTarikhSarResid like @Year+'%'

)t
WHERE fldTypeSanadName LIKE @value AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))

END


IF (@fieldname=N'Ejra_fldBankName')
BEGIN
IF(@AzTarikh <>'' AND @TaTarikh<>'')
SELECT TOP(@h)  * FROM (
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0 AS fldShomareHesabId,0 AS fldBaratDarId,CAST(3 AS TINYINT)AS fldTypeSanad,'' fldMakanPardakht,fldUserId, fldDesc, fldDate
,N'سفته' AS fldTypeSanadName
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,''fldShomareHesab,''fldBankName,0 fldBankId,'' fldNameShobe,0 fldShobeId,'' fldNameBaratDar,''fldStatusFish,''AS fldStatusFishId,NULL AS fldFishId,0 fldShomareHesabIdOrgan,'' fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
FROM         Drd.tblSafte


)t
WHERE fldBankName LIKE @value AND  fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND t.fldTarikhSarResid BETWEEN @AzTarikh AND @TaTarikh

IF(@AzTarikh <>'' AND @TaTarikh='')
SELECT TOP(@h)  * FROM (
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0 AS fldShomareHesabId,0 AS fldBaratDarId,CAST(3 AS TINYINT)AS fldTypeSanad,'' fldMakanPardakht,fldUserId, fldDesc, fldDate
,N'سفته' AS fldTypeSanadName
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,''fldShomareHesab,''fldBankName,0 fldBankId,'' fldNameShobe,0 fldShobeId,'' fldNameBaratDar,''fldStatusFish,''AS fldStatusFishId,NULL AS fldFishId,0 fldShomareHesabIdOrgan,'' fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
FROM         Drd.tblSafte

)t
WHERE fldBankName LIKE @value AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND t.fldTarikhSarResid >= @AzTarikh 

IF(@AzTarikh ='' AND @TaTarikh<>'')
SELECT TOP(@h)  * FROM (
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0 AS fldShomareHesabId,0 AS fldBaratDarId,CAST(3 AS TINYINT)AS fldTypeSanad,'' fldMakanPardakht,fldUserId, fldDesc, fldDate
,N'سفته' AS fldTypeSanadName
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,''fldShomareHesab,''fldBankName,0 fldBankId,'' fldNameShobe,0 fldShobeId,'' fldNameBaratDar,''fldStatusFish,''AS fldStatusFishId,NULL AS fldFishId,0 fldShomareHesabIdOrgan,'' fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
FROM         Drd.tblSafte


)t
WHERE fldBankName LIKE @value AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND t.fldTarikhSarResid <= @TaTarikh

IF(@AzTarikh ='' AND @TaTarikh='')
SELECT TOP(@h)  * FROM (
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0 AS fldShomareHesabId,0 AS fldBaratDarId,CAST(3 AS TINYINT)AS fldTypeSanad,'' fldMakanPardakht,fldUserId, fldDesc, fldDate
,N'سفته' AS fldTypeSanadName
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,''fldShomareHesab,''fldBankName,0 fldBankId,'' fldNameShobe,0 fldShobeId,'' fldNameBaratDar,''fldStatusFish,''AS fldStatusFishId,NULL AS fldFishId,0 fldShomareHesabIdOrgan,'' fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL THEN (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) END
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL THEN (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) END
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL THEN (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) END
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
FROM         Drd.tblSafte
--where  fldTarikhSarResid like @Year+'%'

)t
WHERE fldBankName LIKE @value AND  fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))

END


IF (@fieldname=N'Ejra_fldNameShobe')
BEGIN
IF(@AzTarikh <>'' AND @TaTarikh<>'')
SELECT TOP(@h)  * FROM (
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0 AS fldShomareHesabId,0 AS fldBaratDarId,CAST(3 AS TINYINT)AS fldTypeSanad,'' fldMakanPardakht,fldUserId, fldDesc, fldDate
,N'سفته' AS fldTypeSanadName
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,''fldShomareHesab,''fldBankName,0 fldBankId,'' fldNameShobe,0 fldShobeId,'' fldNameBaratDar,''fldStatusFish,''AS fldStatusFishId,NULL AS fldFishId,0 fldShomareHesabIdOrgan,'' fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
FROM         Drd.tblSafte


)t
WHERE fldNameShobe LIKE @value and fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND t.fldTarikhSarResid BETWEEN @AzTarikh AND @TaTarikh

IF(@AzTarikh <>'' AND @TaTarikh='')
SELECT TOP(@h)  * FROM (
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0 AS fldShomareHesabId,0 AS fldBaratDarId,CAST(3 AS TINYINT)AS fldTypeSanad,'' fldMakanPardakht,fldUserId, fldDesc, fldDate
,N'سفته' AS fldTypeSanadName
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,''fldShomareHesab,''fldBankName,0 fldBankId,'' fldNameShobe,0 fldShobeId,'' fldNameBaratDar,''fldStatusFish,''AS fldStatusFishId,NULL AS fldFishId,0 fldShomareHesabIdOrgan,'' fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
FROM         Drd.tblSafte

)t
WHERE fldNameShobe LIKE @value and fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND t.fldTarikhSarResid >= @AzTarikh 

IF(@AzTarikh ='' AND @TaTarikh<>'')
SELECT TOP(@h)  * FROM (
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0 AS fldShomareHesabId,0 AS fldBaratDarId,CAST(3 AS TINYINT)AS fldTypeSanad,'' fldMakanPardakht,fldUserId, fldDesc, fldDate
,N'سفته' AS fldTypeSanadName
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,''fldShomareHesab,''fldBankName,0 fldBankId,'' fldNameShobe,0 fldShobeId,'' fldNameBaratDar,''fldStatusFish,''AS fldStatusFishId,NULL AS fldFishId,0 fldShomareHesabIdOrgan,'' fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
FROM         Drd.tblSafte


)t
WHERE fldNameShobe LIKE @value and fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND t.fldTarikhSarResid <= @TaTarikh

IF(@AzTarikh ='' AND @TaTarikh='')
SELECT TOP(@h)  * FROM (
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0 AS fldShomareHesabId,0 AS fldBaratDarId,CAST(3 AS TINYINT)AS fldTypeSanad,'' fldMakanPardakht,fldUserId, fldDesc, fldDate
,N'سفته' AS fldTypeSanadName
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,''fldShomareHesab,''fldBankName,0 fldBankId,'' fldNameShobe,0 fldShobeId,'' fldNameBaratDar,''fldStatusFish,''AS fldStatusFishId,NULL AS fldFishId,0 fldShomareHesabIdOrgan,'' fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL THEN (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) END
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL THEN (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) END
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL THEN (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) END
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
FROM         Drd.tblSafte
--where  fldTarikhSarResid like @Year+'%'

)t
WHERE fldNameShobe LIKE @value and fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))

END


IF (@fieldname=N'Ejra_fldShomareSanad')
BEGIN
IF(@AzTarikh <>'' AND @TaTarikh<>'')
SELECT TOP(@h)  * FROM (
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0 AS fldShomareHesabId,0 AS fldBaratDarId,CAST(3 AS TINYINT)AS fldTypeSanad,'' fldMakanPardakht,fldUserId, fldDesc, fldDate
,N'سفته' AS fldTypeSanadName
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,''fldShomareHesab,''fldBankName,0 fldBankId,'' fldNameShobe,0 fldShobeId,'' fldNameBaratDar,''fldStatusFish,''AS fldStatusFishId,NULL AS fldFishId,0 fldShomareHesabIdOrgan,'' fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
FROM         Drd.tblSafte


)t
WHERE fldShomareSanad LIKE @value AND  fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND t.fldTarikhSarResid BETWEEN @AzTarikh AND @TaTarikh

IF(@AzTarikh <>'' AND @TaTarikh='')
SELECT TOP(@h)  * FROM (
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0 AS fldShomareHesabId,0 AS fldBaratDarId,CAST(3 AS TINYINT)AS fldTypeSanad,'' fldMakanPardakht,fldUserId, fldDesc, fldDate
,N'سفته' AS fldTypeSanadName
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,''fldShomareHesab,''fldBankName,0 fldBankId,'' fldNameShobe,0 fldShobeId,'' fldNameBaratDar,''fldStatusFish,''AS fldStatusFishId,NULL AS fldFishId,0 fldShomareHesabIdOrgan,'' fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
FROM         Drd.tblSafte

)t
WHERE fldShomareSanad LIKE @value AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND t.fldTarikhSarResid >= @AzTarikh 

IF(@AzTarikh ='' AND @TaTarikh<>'')
SELECT TOP(@h)  * FROM (
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0 AS fldShomareHesabId,0 AS fldBaratDarId,CAST(3 AS TINYINT)AS fldTypeSanad,'' fldMakanPardakht,fldUserId, fldDesc, fldDate
,N'سفته' AS fldTypeSanadName
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,''fldShomareHesab,''fldBankName,0 fldBankId,'' fldNameShobe,0 fldShobeId,'' fldNameBaratDar,''fldStatusFish,''AS fldStatusFishId,NULL AS fldFishId,0 fldShomareHesabIdOrgan,'' fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
FROM         Drd.tblSafte


)t
WHERE  fldShomareSanad LIKE @value AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND t.fldTarikhSarResid <= @TaTarikh

IF(@AzTarikh ='' AND @TaTarikh='')
SELECT TOP(@h)  * FROM (
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0 AS fldShomareHesabId,0 AS fldBaratDarId,CAST(3 AS TINYINT)AS fldTypeSanad,'' fldMakanPardakht,fldUserId, fldDesc, fldDate
,N'سفته' AS fldTypeSanadName
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,''fldShomareHesab,''fldBankName,0 fldBankId,'' fldNameShobe,0 fldShobeId,'' fldNameBaratDar,''fldStatusFish,''AS fldStatusFishId,NULL AS fldFishId,0 fldShomareHesabIdOrgan,'' fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
FROM         Drd.tblSafte
--where  fldTarikhSarResid like @Year+'%'

)t
WHERE fldShomareSanad LIKE @value AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))

END



IF (@fieldname=N'Ejra_fldId')
BEGIN
IF(@AzTarikh <>'' AND @TaTarikh<>'')
SELECT TOP(@h)  * FROM (
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0 AS fldShomareHesabId,0 AS fldBaratDarId,CAST(3 AS TINYINT)AS fldTypeSanad,'' fldMakanPardakht,fldUserId, fldDesc, fldDate
,N'سفته' AS fldTypeSanadName
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,''fldShomareHesab,''fldBankName,0 fldBankId,'' fldNameShobe,0 fldShobeId,'' fldNameBaratDar,''fldStatusFish,''AS fldStatusFishId,NULL AS fldFishId,0 fldShomareHesabIdOrgan,'' fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
FROM         Drd.tblSafte


)t
WHERE fldid like @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND t.fldTarikhSarResid BETWEEN @AzTarikh AND @TaTarikh

IF(@AzTarikh <>'' AND @TaTarikh='')
SELECT TOP(@h)  * FROM (
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0 AS fldShomareHesabId,0 AS fldBaratDarId,CAST(3 AS TINYINT)AS fldTypeSanad,'' fldMakanPardakht,fldUserId, fldDesc, fldDate
,N'سفته' AS fldTypeSanadName
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,''fldShomareHesab,''fldBankName,0 fldBankId,'' fldNameShobe,0 fldShobeId,'' fldNameBaratDar,''fldStatusFish,''AS fldStatusFishId,NULL AS fldFishId,0 fldShomareHesabIdOrgan,'' fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
FROM         Drd.tblSafte

)t
WHERE fldid like @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND t.fldTarikhSarResid >= @AzTarikh 

IF(@AzTarikh ='' AND @TaTarikh<>'')
SELECT TOP(@h)  * FROM (
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0 AS fldShomareHesabId,0 AS fldBaratDarId,CAST(3 AS TINYINT)AS fldTypeSanad,'' fldMakanPardakht,fldUserId, fldDesc, fldDate
,N'سفته' AS fldTypeSanadName
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,''fldShomareHesab,''fldBankName,0 fldBankId,'' fldNameShobe,0 fldShobeId,'' fldNameBaratDar,''fldStatusFish,''AS fldStatusFishId,NULL AS fldFishId,0 fldShomareHesabIdOrgan,'' fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
FROM         Drd.tblSafte


)t
WHERE fldid like @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND t.fldTarikhSarResid <= @TaTarikh

IF(@AzTarikh ='' AND @TaTarikh='')
SELECT TOP(@h)  * FROM (
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0 AS fldShomareHesabId,0 AS fldBaratDarId,CAST(3 AS TINYINT)AS fldTypeSanad,'' fldMakanPardakht,fldUserId, fldDesc, fldDate
,N'سفته' AS fldTypeSanadName
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,''fldShomareHesab,''fldBankName,0 fldBankId,'' fldNameShobe,0 fldShobeId,'' fldNameBaratDar,''fldStatusFish,''AS fldStatusFishId,NULL AS fldFishId,0 fldShomareHesabIdOrgan,'' fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
FROM         Drd.tblSafte
--where  fldTarikhSarResid like @Year+'%'

)t
WHERE fldId LIKE @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))

END

IF (@fieldname=N'Ejra_fldName')
BEGIN
IF(@AzTarikh <>'' AND @TaTarikh<>'')
SELECT TOP(@h)  * FROM (
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0 AS fldShomareHesabId,0 AS fldBaratDarId,CAST(3 AS TINYINT)AS fldTypeSanad,'' fldMakanPardakht,fldUserId, fldDesc, fldDate
,N'سفته' AS fldTypeSanadName
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,''fldShomareHesab,''fldBankName,0 fldBankId,'' fldNameShobe,0 fldShobeId,'' fldNameBaratDar,''fldStatusFish,''AS fldStatusFishId,NULL AS fldFishId,0 fldShomareHesabIdOrgan,'' fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
FROM         Drd.tblSafte


)t
WHERE fldname like @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND t.fldTarikhSarResid BETWEEN @AzTarikh AND @TaTarikh

IF(@AzTarikh <>'' AND @TaTarikh='')
SELECT TOP(@h)  * FROM (
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0 AS fldShomareHesabId,0 AS fldBaratDarId,CAST(3 AS TINYINT)AS fldTypeSanad,'' fldMakanPardakht,fldUserId, fldDesc, fldDate
,N'سفته' AS fldTypeSanadName
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,''fldShomareHesab,''fldBankName,0 fldBankId,'' fldNameShobe,0 fldShobeId,'' fldNameBaratDar,''fldStatusFish,''AS fldStatusFishId,NULL AS fldFishId,0 fldShomareHesabIdOrgan,'' fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
FROM         Drd.tblSafte

)t
WHERE fldname like @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND t.fldTarikhSarResid >= @AzTarikh 

IF(@AzTarikh ='' AND @TaTarikh<>'')
SELECT TOP(@h)  * FROM (
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0 AS fldShomareHesabId,0 AS fldBaratDarId,CAST(3 AS TINYINT)AS fldTypeSanad,'' fldMakanPardakht,fldUserId, fldDesc, fldDate
,N'سفته' AS fldTypeSanadName
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,''fldShomareHesab,''fldBankName,0 fldBankId,'' fldNameShobe,0 fldShobeId,'' fldNameBaratDar,''fldStatusFish,''AS fldStatusFishId,NULL AS fldFishId,0 fldShomareHesabIdOrgan,'' fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
FROM         Drd.tblSafte

)t
WHERE fldname like @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND t.fldTarikhSarResid <= @TaTarikh

IF(@AzTarikh ='' AND @TaTarikh='')
SELECT TOP(@h)  * FROM (
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0 AS fldShomareHesabId,0 AS fldBaratDarId,CAST(3 AS TINYINT)AS fldTypeSanad,'' fldMakanPardakht,fldUserId, fldDesc, fldDate
,N'سفته' AS fldTypeSanadName
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,''fldShomareHesab,''fldBankName,0 fldBankId,'' fldNameShobe,0 fldShobeId,'' fldNameBaratDar,''fldStatusFish,''AS fldStatusFishId,NULL AS fldFishId,0 fldShomareHesabIdOrgan,'' fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
FROM         Drd.tblSafte
--where  fldTarikhSarResid like @Year+'%'
)t
WHERE fldName LIKE @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))

END

if (@fieldname=N'Ejra_fldShenaseMeli')
BEGIN
IF(@AzTarikh <>'' AND @TaTarikh<>'')
SELECT TOP(@h)  * FROM (
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0 AS fldShomareHesabId,0 AS fldBaratDarId,CAST(3 AS TINYINT)AS fldTypeSanad,'' fldMakanPardakht,fldUserId, fldDesc, fldDate
,N'سفته' AS fldTypeSanadName
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,''fldShomareHesab,''fldBankName,0 fldBankId,'' fldNameShobe,0 fldShobeId,'' fldNameBaratDar,''fldStatusFish,''AS fldStatusFishId,NULL AS fldFishId,0 fldShomareHesabIdOrgan,'' fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
FROM         Drd.tblSafte

)t
WHERE t.fldShenaseMeli like @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND t.fldTarikhSarResid BETWEEN @AzTarikh AND @TaTarikh

IF(@AzTarikh <>'' AND @TaTarikh='')
SELECT TOP(@h)  * FROM (
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0 AS fldShomareHesabId,0 AS fldBaratDarId,CAST(3 AS TINYINT)AS fldTypeSanad,'' fldMakanPardakht,fldUserId, fldDesc, fldDate
,N'سفته' AS fldTypeSanadName
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,''fldShomareHesab,''fldBankName,0 fldBankId,'' fldNameShobe,0 fldShobeId,'' fldNameBaratDar,''fldStatusFish,''AS fldStatusFishId,NULL AS fldFishId,0 fldShomareHesabIdOrgan,'' fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
FROM         Drd.tblSafte

)t
WHERE t.fldShenaseMeli like @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND t.fldTarikhSarResid >= @AzTarikh 

IF(@AzTarikh ='' AND @TaTarikh<>'')
SELECT TOP(@h)  * FROM (
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0 AS fldShomareHesabId,0 AS fldBaratDarId,CAST(3 AS TINYINT)AS fldTypeSanad,'' fldMakanPardakht,fldUserId, fldDesc, fldDate
,N'سفته' AS fldTypeSanadName
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,''fldShomareHesab,''fldBankName,0 fldBankId,'' fldNameShobe,0 fldShobeId,'' fldNameBaratDar,''fldStatusFish,''AS fldStatusFishId,NULL AS fldFishId,0 fldShomareHesabIdOrgan,'' fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
FROM         Drd.tblSafte

)t
WHERE t.fldShenaseMeli like @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND t.fldTarikhSarResid <= @TaTarikh

IF(@AzTarikh ='' AND @TaTarikh='')
SELECT TOP(@h)  * FROM (
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0 AS fldShomareHesabId,0 AS fldBaratDarId,CAST(3 AS TINYINT)AS fldTypeSanad,'' fldMakanPardakht,fldUserId, fldDesc, fldDate
,N'سفته' AS fldTypeSanadName
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,''fldShomareHesab,''fldBankName,0 fldBankId,'' fldNameShobe,0 fldShobeId,'' fldNameBaratDar,''fldStatusFish,''AS fldStatusFishId,NULL AS fldFishId,0 fldShomareHesabIdOrgan,'' fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
FROM         Drd.tblSafte
--where  fldTarikhSarResid like @Year+'%'
)t
WHERE t.fldShenaseMeli LIKE @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))

END
if (@fieldname=N'Ejra_fldFather_Sabt')
BEGIN
IF(@AzTarikh <>'' AND @TaTarikh<>'')
SELECT TOP(@h)  * FROM (
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0 AS fldShomareHesabId,0 AS fldBaratDarId,CAST(3 AS TINYINT)AS fldTypeSanad,'' fldMakanPardakht,fldUserId, fldDesc, fldDate
,N'سفته' AS fldTypeSanadName
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,''fldShomareHesab,''fldBankName,0 fldBankId,'' fldNameShobe,0 fldShobeId,'' fldNameBaratDar,''fldStatusFish,''AS fldStatusFishId,NULL AS fldFishId,0 fldShomareHesabIdOrgan,'' fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
FROM         Drd.tblSafte

)t
WHERE fldFather_Sabt like @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND t.fldTarikhSarResid BETWEEN @AzTarikh AND @TaTarikh

IF(@AzTarikh <>'' AND @TaTarikh='')
SELECT TOP(@h)  * FROM (
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0 AS fldShomareHesabId,0 AS fldBaratDarId,CAST(3 AS TINYINT)AS fldTypeSanad,'' fldMakanPardakht,fldUserId, fldDesc, fldDate
,N'سفته' AS fldTypeSanadName
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,''fldShomareHesab,''fldBankName,0 fldBankId,'' fldNameShobe,0 fldShobeId,'' fldNameBaratDar,''fldStatusFish,''AS fldStatusFishId,NULL AS fldFishId,0 fldShomareHesabIdOrgan,'' fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
FROM         Drd.tblSafte


)t
WHERE fldFather_Sabt like @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND t.fldTarikhSarResid >= @AzTarikh 

IF(@AzTarikh ='' AND @TaTarikh<>'')
SELECT TOP(@h)  * FROM (
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0 AS fldShomareHesabId,0 AS fldBaratDarId,CAST(3 AS TINYINT)AS fldTypeSanad,'' fldMakanPardakht,fldUserId, fldDesc, fldDate
,N'سفته' AS fldTypeSanadName
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,''fldShomareHesab,''fldBankName,0 fldBankId,'' fldNameShobe,0 fldShobeId,'' fldNameBaratDar,''fldStatusFish,''AS fldStatusFishId,NULL AS fldFishId,0 fldShomareHesabIdOrgan,'' fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
FROM         Drd.tblSafte


)t
WHERE fldFather_Sabt like @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND t.fldTarikhSarResid <= @TaTarikh

IF(@AzTarikh ='' AND @TaTarikh='')
SELECT TOP(@h)  * FROM (
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0 AS fldShomareHesabId,0 AS fldBaratDarId,CAST(3 AS TINYINT)AS fldTypeSanad,'' fldMakanPardakht,fldUserId, fldDesc, fldDate
,N'سفته' AS fldTypeSanadName
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,''fldShomareHesab,''fldBankName,0 fldBankId,'' fldNameShobe,0 fldShobeId,'' fldNameBaratDar,''fldStatusFish,''AS fldStatusFishId,NULL AS fldFishId,0 fldShomareHesabIdOrgan,'' fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
FROM         Drd.tblSafte
--where  fldTarikhSarResid like @Year+'%'
)t
WHERE t.fldFather_Sabt LIKE @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))

END

if (@fieldname=N'Ejra_fldNameBaratDar')
BEGIN
IF(@AzTarikh <>'' AND @TaTarikh<>'')
SELECT TOP(@h)  * FROM (
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0 AS fldShomareHesabId,0 AS fldBaratDarId,CAST(3 AS TINYINT)AS fldTypeSanad,'' fldMakanPardakht,fldUserId, fldDesc, fldDate
,N'سفته' AS fldTypeSanadName
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,''fldShomareHesab,''fldBankName,0 fldBankId,'' fldNameShobe,0 fldShobeId,'' fldNameBaratDar,''fldStatusFish,''AS fldStatusFishId,NULL AS fldFishId,0 fldShomareHesabIdOrgan,'' fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
FROM         Drd.tblSafte

)t
WHERE fldNameBaratDar like @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND t.fldTarikhSarResid BETWEEN @AzTarikh AND @TaTarikh

IF(@AzTarikh <>'' AND @TaTarikh='')
SELECT TOP(@h)  * FROM (
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0 AS fldShomareHesabId,0 AS fldBaratDarId,CAST(3 AS TINYINT)AS fldTypeSanad,'' fldMakanPardakht,fldUserId, fldDesc, fldDate
,N'سفته' AS fldTypeSanadName
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,''fldShomareHesab,''fldBankName,0 fldBankId,'' fldNameShobe,0 fldShobeId,'' fldNameBaratDar,''fldStatusFish,''AS fldStatusFishId,NULL AS fldFishId,0 fldShomareHesabIdOrgan,'' fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
FROM         Drd.tblSafte

)t
WHERE fldNameBaratDar like @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND t.fldTarikhSarResid >= @AzTarikh 

IF(@AzTarikh ='' AND @TaTarikh<>'')
SELECT TOP(@h)  * FROM (
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0 AS fldShomareHesabId,0 AS fldBaratDarId,CAST(3 AS TINYINT)AS fldTypeSanad,'' fldMakanPardakht,fldUserId, fldDesc, fldDate
,N'سفته' AS fldTypeSanadName
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,''fldShomareHesab,''fldBankName,0 fldBankId,'' fldNameShobe,0 fldShobeId,'' fldNameBaratDar,''fldStatusFish,''AS fldStatusFishId,NULL AS fldFishId,0 fldShomareHesabIdOrgan,'' fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
FROM         Drd.tblSafte


)t
WHERE fldNameBaratDar like @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND t.fldTarikhSarResid <= @TaTarikh

IF(@AzTarikh ='' AND @TaTarikh='')
SELECT TOP(@h)  * FROM (
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0 AS fldShomareHesabId,0 AS fldBaratDarId,CAST(3 AS TINYINT)AS fldTypeSanad,'' fldMakanPardakht,fldUserId, fldDesc, fldDate
,N'سفته' AS fldTypeSanadName
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,''fldShomareHesab,''fldBankName,0 fldBankId,'' fldNameShobe,0 fldShobeId,'' fldNameBaratDar,''fldStatusFish,''AS fldStatusFishId,NULL AS fldFishId,0 fldShomareHesabIdOrgan,'' fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
FROM         Drd.tblSafte
--where  fldTarikhSarResid like @Year+'%'
)t
WHERE t.fldNameBaratDar LIKE @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
END

if (@fieldname=N'Ejra_fldTarikhAkhz')
BEGIN
IF(@AzTarikh <>'' AND @TaTarikh<>'')
SELECT TOP(@h)  * FROM (
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0 AS fldShomareHesabId,0 AS fldBaratDarId,CAST(3 AS TINYINT)AS fldTypeSanad,'' fldMakanPardakht,fldUserId, fldDesc, fldDate
,N'سفته' AS fldTypeSanadName
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,''fldShomareHesab,''fldBankName,0 fldBankId,'' fldNameShobe,0 fldShobeId,'' fldNameBaratDar,''fldStatusFish,''AS fldStatusFishId,NULL AS fldFishId,0 fldShomareHesabIdOrgan,'' fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
FROM         Drd.tblSafte

)t
WHERE fldTarikhAkhz like @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND t.fldTarikhSarResid BETWEEN @AzTarikh AND @TaTarikh

IF(@AzTarikh <>'' AND @TaTarikh='')
SELECT TOP(@h)  * FROM (
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0 AS fldShomareHesabId,0 AS fldBaratDarId,CAST(3 AS TINYINT)AS fldTypeSanad,'' fldMakanPardakht,fldUserId, fldDesc, fldDate
,N'سفته' AS fldTypeSanadName
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,''fldShomareHesab,''fldBankName,0 fldBankId,'' fldNameShobe,0 fldShobeId,'' fldNameBaratDar,''fldStatusFish,''AS fldStatusFishId,NULL AS fldFishId,0 fldShomareHesabIdOrgan,'' fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
FROM         Drd.tblSafte

)t
WHERE fldTarikhAkhz like @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND t.fldTarikhSarResid >= @AzTarikh 

IF(@AzTarikh ='' AND @TaTarikh<>'')
SELECT TOP(@h)  * FROM (
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0 AS fldShomareHesabId,0 AS fldBaratDarId,CAST(3 AS TINYINT)AS fldTypeSanad,'' fldMakanPardakht,fldUserId, fldDesc, fldDate
,N'سفته' AS fldTypeSanadName
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,''fldShomareHesab,''fldBankName,0 fldBankId,'' fldNameShobe,0 fldShobeId,'' fldNameBaratDar,''fldStatusFish,''AS fldStatusFishId,NULL AS fldFishId,0 fldShomareHesabIdOrgan,'' fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
FROM         Drd.tblSafte


)t
WHERE fldTarikhAkhz like @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND t.fldTarikhSarResid <= @TaTarikh

IF(@AzTarikh ='' AND @TaTarikh='')
SELECT TOP(@h)  * FROM (
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0 AS fldShomareHesabId,0 AS fldBaratDarId,CAST(3 AS TINYINT)AS fldTypeSanad,'' fldMakanPardakht,fldUserId, fldDesc, fldDate
,N'سفته' AS fldTypeSanadName
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,''fldShomareHesab,''fldBankName,0 fldBankId,'' fldNameShobe,0 fldShobeId,'' fldNameBaratDar,''fldStatusFish,''AS fldStatusFishId,NULL AS fldFishId,0 fldShomareHesabIdOrgan,'' fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
FROM         Drd.tblSafte

)t
WHERE t.fldTarikhAkhz LIKE @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
END

commit
GO
