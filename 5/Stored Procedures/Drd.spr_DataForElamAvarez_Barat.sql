SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_DataForElamAvarez_Barat]
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

IF (@fieldname=N'Ejra_fldId')
BEGIN
IF(@AzTarikh <>'' AND @TaTarikh<>'')
SELECT TOP(@h)  * FROM (
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 AS fldShomareHesabId ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT) fldTypeSanad, ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
,N'برات' AS fldTypeSanadName
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,'' AS fldShomareHesab,'' fldBankName,0 fldBankId,'' fldNameShobe,0 fldShobeId,ISNULL(com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId),'')fldNameBaratDar,'' fldStatusFish,''AS fldStatusFishId,NULL AS fldFishId,0 fldShomareHesabIdOrgan,'' AS fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
FROM         Drd.tblBarat
)t
WHERE fldid like @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND t.fldTarikhSarResid BETWEEN @AzTarikh AND @TaTarikh

IF(@AzTarikh <>'' AND @TaTarikh='')
SELECT TOP(@h)  * FROM (
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 AS fldShomareHesabId ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT) fldTypeSanad, ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
,N'برات' AS fldTypeSanadName
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,'' AS fldShomareHesab,'' fldBankName,0 fldBankId,'' fldNameShobe,0 fldShobeId,ISNULL(com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId),'')fldNameBaratDar,'' fldStatusFish,''AS fldStatusFishId,NULL AS fldFishId,0 fldShomareHesabIdOrgan,'' AS fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
FROM         Drd.tblBarat
)t
WHERE fldid like @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND t.fldTarikhSarResid >= @AzTarikh 

IF(@AzTarikh ='' AND @TaTarikh<>'')
SELECT TOP(@h)  * FROM (
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 AS fldShomareHesabId ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT) fldTypeSanad, ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
,N'برات' AS fldTypeSanadName
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,'' AS fldShomareHesab,'' fldBankName,0 fldBankId,'' fldNameShobe,0 fldShobeId,ISNULL(com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId),'')fldNameBaratDar,'' fldStatusFish,''AS fldStatusFishId,NULL AS fldFishId,0 fldShomareHesabIdOrgan,'' AS fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
FROM         Drd.tblBarat
)t
WHERE fldid like @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND t.fldTarikhSarResid <= @TaTarikh

IF(@AzTarikh ='' AND @TaTarikh='')
SELECT TOP(@h)  * FROM (
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 AS fldShomareHesabId ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT) fldTypeSanad, ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
,N'برات' AS fldTypeSanadName
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,'' AS fldShomareHesab,'' fldBankName,0 fldBankId,'' fldNameShobe,0 fldShobeId,ISNULL(com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId),'')fldNameBaratDar,'' fldStatusFish,''AS fldStatusFishId,NULL AS fldFishId,0 fldShomareHesabIdOrgan,'' AS fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL THEN (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) END
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldid IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL THEN (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) END
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldid IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL THEN (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) END
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldid IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
FROM         Drd.tblBarat
--where  fldTarikhSarResid like @Year+'%'
)t
WHERE fldId LIKE @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))

END

IF (@fieldname=N'Ejra_fldElamAvarezId')
BEGIN
IF(@AzTarikh <>'' AND @TaTarikh<>'')
SELECT TOP(@h)  * FROM (
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 AS fldShomareHesabId ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT) fldTypeSanad, ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
,N'برات' AS fldTypeSanadName
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,'' AS fldShomareHesab,'' fldBankName,0 fldBankId,'' fldNameShobe,0 fldShobeId,ISNULL(com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId),'')fldNameBaratDar,'' fldStatusFish,''AS fldStatusFishId,NULL AS fldFishId,0 fldShomareHesabIdOrgan,'' AS fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
FROM         Drd.tblBarat
)t
WHERE fldElamAvarezId like @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND t.fldTarikhSarResid BETWEEN @AzTarikh AND @TaTarikh

IF(@AzTarikh <>'' AND @TaTarikh='')
SELECT TOP(@h)  * FROM (
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 AS fldShomareHesabId ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT) fldTypeSanad, ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
,N'برات' AS fldTypeSanadName
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,'' AS fldShomareHesab,'' fldBankName,0 fldBankId,'' fldNameShobe,0 fldShobeId,ISNULL(com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId),'')fldNameBaratDar,'' fldStatusFish,''AS fldStatusFishId,NULL AS fldFishId,0 fldShomareHesabIdOrgan,'' AS fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
FROM         Drd.tblBarat
)t
WHERE fldElamAvarezId like @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND t.fldTarikhSarResid >= @AzTarikh 

IF(@AzTarikh ='' AND @TaTarikh<>'')
SELECT TOP(@h)  * FROM (
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 AS fldShomareHesabId ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT) fldTypeSanad, ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
,N'برات' AS fldTypeSanadName
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,'' AS fldShomareHesab,'' fldBankName,0 fldBankId,'' fldNameShobe,0 fldShobeId,ISNULL(com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId),'')fldNameBaratDar,'' fldStatusFish,''AS fldStatusFishId,NULL AS fldFishId,0 fldShomareHesabIdOrgan,'' AS fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
FROM         Drd.tblBarat
)t
WHERE fldElamAvarezId like @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND t.fldTarikhSarResid <= @TaTarikh

IF(@AzTarikh ='' AND @TaTarikh='')
SELECT TOP(@h)  * FROM (
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 AS fldShomareHesabId ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT) fldTypeSanad, ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
,N'برات' AS fldTypeSanadName
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,'' AS fldShomareHesab,'' fldBankName,0 fldBankId,'' fldNameShobe,0 fldShobeId,ISNULL(com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId),'')fldNameBaratDar,'' fldStatusFish,''AS fldStatusFishId,NULL AS fldFishId,0 fldShomareHesabIdOrgan,'' AS fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL THEN (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) END
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldid IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL THEN (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) END
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldid IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL THEN (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) END
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldid IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
FROM         Drd.tblBarat
--where  fldTarikhSarResid like @Year+'%'
)t
WHERE fldElamAvarezId LIKE @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))

END



IF (@fieldname=N'Ejra_fldDateStatus')
BEGIN
IF(@AzTarikh <>'' AND @TaTarikh<>'')
SELECT TOP(@h)  * FROM (
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 AS fldShomareHesabId ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT) fldTypeSanad, ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
,N'برات' AS fldTypeSanadName
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,'' AS fldShomareHesab,'' fldBankName,0 fldBankId,'' fldNameShobe,0 fldShobeId,ISNULL(com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId),'')fldNameBaratDar,'' fldStatusFish,''AS fldStatusFishId,NULL AS fldFishId,0 fldShomareHesabIdOrgan,'' AS fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
FROM         Drd.tblBarat
)t
WHERE fldDateStatus like @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND t.fldTarikhSarResid BETWEEN @AzTarikh AND @TaTarikh

IF(@AzTarikh <>'' AND @TaTarikh='')
SELECT TOP(@h)  * FROM (
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 AS fldShomareHesabId ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT) fldTypeSanad, ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
,N'برات' AS fldTypeSanadName
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,'' AS fldShomareHesab,'' fldBankName,0 fldBankId,'' fldNameShobe,0 fldShobeId,ISNULL(com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId),'')fldNameBaratDar,'' fldStatusFish,''AS fldStatusFishId,NULL AS fldFishId,0 fldShomareHesabIdOrgan,'' AS fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL THEN (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) END
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL THEN (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) END
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL THEN (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) END
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
FROM         Drd.tblBarat
)t
WHERE fldDateStatus LIKE @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND t.fldTarikhSarResid >= @AzTarikh 

IF(@AzTarikh ='' AND @TaTarikh<>'')
SELECT TOP(@h)  * FROM (
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 AS fldShomareHesabId ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT) fldTypeSanad, ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
,N'برات' AS fldTypeSanadName
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,'' AS fldShomareHesab,'' fldBankName,0 fldBankId,'' fldNameShobe,0 fldShobeId,ISNULL(com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId),'')fldNameBaratDar,'' fldStatusFish,''AS fldStatusFishId,NULL AS fldFishId,0 fldShomareHesabIdOrgan,'' AS fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL THEN (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) END
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL THEN (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) END
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL THEN (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) END
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
FROM         Drd.tblBarat
)t
WHERE fldDateStatus LIKE @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND t.fldTarikhSarResid <= @TaTarikh

IF(@AzTarikh ='' AND @TaTarikh='')
SELECT TOP(@h)  * FROM (
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 AS fldShomareHesabId ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT) fldTypeSanad, ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
,N'برات' AS fldTypeSanadName
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,'' AS fldShomareHesab,'' fldBankName,0 fldBankId,'' fldNameShobe,0 fldShobeId,ISNULL(com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId),'')fldNameBaratDar,'' fldStatusFish,''AS fldStatusFishId,NULL AS fldFishId,0 fldShomareHesabIdOrgan,'' AS fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL THEN (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) END
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldid IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL THEN (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) END
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldid IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL THEN (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) END
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldid IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
FROM         Drd.tblBarat
--where  fldTarikhSarResid like @Year+'%'
)t
WHERE fldDateStatus LIKE @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))

END



IF (@fieldname=N'Ejra_fldTarikhSarResid')
BEGIN
IF(@AzTarikh <>'' AND @TaTarikh<>'')
SELECT TOP(@h)  * FROM (
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 AS fldShomareHesabId ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT) fldTypeSanad, ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
,N'برات' AS fldTypeSanadName
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,'' AS fldShomareHesab,'' fldBankName,0 fldBankId,'' fldNameShobe,0 fldShobeId,ISNULL(com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId),'')fldNameBaratDar,'' fldStatusFish,''AS fldStatusFishId,NULL AS fldFishId,0 fldShomareHesabIdOrgan,'' AS fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
FROM         Drd.tblBarat
)t
WHERE fldTarikhSarResid like @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND t.fldTarikhSarResid BETWEEN @AzTarikh AND @TaTarikh

IF(@AzTarikh <>'' AND @TaTarikh='')
SELECT TOP(@h)  * FROM (
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 AS fldShomareHesabId ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT) fldTypeSanad, ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
,N'برات' AS fldTypeSanadName
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,'' AS fldShomareHesab,'' fldBankName,0 fldBankId,'' fldNameShobe,0 fldShobeId,ISNULL(com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId),'')fldNameBaratDar,'' fldStatusFish,''AS fldStatusFishId,NULL AS fldFishId,0 fldShomareHesabIdOrgan,'' AS fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
FROM         Drd.tblBarat
)t
WHERE fldTarikhSarResid like @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND t.fldTarikhSarResid >= @AzTarikh 

IF(@AzTarikh ='' AND @TaTarikh<>'')
SELECT TOP(@h)  * FROM (
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 AS fldShomareHesabId ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT) fldTypeSanad, ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
,N'برات' AS fldTypeSanadName
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,'' AS fldShomareHesab,'' fldBankName,0 fldBankId,'' fldNameShobe,0 fldShobeId,ISNULL(com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId),'')fldNameBaratDar,'' fldStatusFish,''AS fldStatusFishId,NULL AS fldFishId,0 fldShomareHesabIdOrgan,'' AS fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
FROM         Drd.tblBarat
)t
WHERE fldTarikhSarResid like @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND t.fldTarikhSarResid <= @TaTarikh

IF(@AzTarikh ='' AND @TaTarikh='')
SELECT TOP(@h)  * FROM (
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 AS fldShomareHesabId ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT) fldTypeSanad, ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
,N'برات' AS fldTypeSanadName
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,'' AS fldShomareHesab,'' fldBankName,0 fldBankId,'' fldNameShobe,0 fldShobeId,ISNULL(com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId),'')fldNameBaratDar,'' fldStatusFish,''AS fldStatusFishId,NULL AS fldFishId,0 fldShomareHesabIdOrgan,'' AS fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL THEN (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) END
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldid IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL THEN (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) END
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldid IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL THEN (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) END
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldid IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
FROM         Drd.tblBarat
--where  fldTarikhSarResid like @Year+'%'
)t
WHERE fldTarikhSarResid LIKE @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))

END

IF (@fieldname=N'Ejra_fldShomareSanad')
BEGIN
IF(@AzTarikh <>'' AND @TaTarikh<>'')
SELECT TOP(@h)  * FROM (
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 AS fldShomareHesabId ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT) fldTypeSanad, ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
,N'برات' AS fldTypeSanadName
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,'' AS fldShomareHesab,'' fldBankName,0 fldBankId,'' fldNameShobe,0 fldShobeId,ISNULL(com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId),'')fldNameBaratDar,'' fldStatusFish,''AS fldStatusFishId,NULL AS fldFishId,0 fldShomareHesabIdOrgan,'' AS fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
FROM         Drd.tblBarat
)t
WHERE fldShomareSanad like @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND t.fldTarikhSarResid BETWEEN @AzTarikh AND @TaTarikh

IF(@AzTarikh <>'' AND @TaTarikh='')
SELECT TOP(@h)  * FROM (
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 AS fldShomareHesabId ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT) fldTypeSanad, ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
,N'برات' AS fldTypeSanadName
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,'' AS fldShomareHesab,'' fldBankName,0 fldBankId,'' fldNameShobe,0 fldShobeId,ISNULL(com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId),'')fldNameBaratDar,'' fldStatusFish,''AS fldStatusFishId,NULL AS fldFishId,0 fldShomareHesabIdOrgan,'' AS fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
FROM         Drd.tblBarat
)t
WHERE fldShomareSanad like @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND t.fldTarikhSarResid >= @AzTarikh 

IF(@AzTarikh ='' AND @TaTarikh<>'')
SELECT TOP(@h)  * FROM (
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 AS fldShomareHesabId ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT) fldTypeSanad, ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
,N'برات' AS fldTypeSanadName
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,'' AS fldShomareHesab,'' fldBankName,0 fldBankId,'' fldNameShobe,0 fldShobeId,ISNULL(com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId),'')fldNameBaratDar,'' fldStatusFish,''AS fldStatusFishId,NULL AS fldFishId,0 fldShomareHesabIdOrgan,'' AS fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
FROM         Drd.tblBarat
)t
WHERE fldShomareSanad like @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND t.fldTarikhSarResid <= @TaTarikh

IF(@AzTarikh ='' AND @TaTarikh='')
SELECT TOP(@h)  * FROM (
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 AS fldShomareHesabId ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT) fldTypeSanad, ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
,N'برات' AS fldTypeSanadName
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,'' AS fldShomareHesab,'' fldBankName,0 fldBankId,'' fldNameShobe,0 fldShobeId,ISNULL(com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId),'')fldNameBaratDar,'' fldStatusFish,''AS fldStatusFishId,NULL AS fldFishId,0 fldShomareHesabIdOrgan,'' AS fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL THEN (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) END
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldid IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL THEN (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) END
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldid IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL THEN (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) END
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldid IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
FROM         Drd.tblBarat
--where  fldTarikhSarResid like @Year+'%'
)t
WHERE fldShomareSanad LIKE @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))

END



IF (@fieldname=N'Ejra_fldTarikhSarResid')
BEGIN
IF(@AzTarikh <>'' AND @TaTarikh<>'')
SELECT TOP(@h)  * FROM (
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 AS fldShomareHesabId ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT) fldTypeSanad, ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
,N'برات' AS fldTypeSanadName
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,'' AS fldShomareHesab,'' fldBankName,0 fldBankId,'' fldNameShobe,0 fldShobeId,ISNULL(com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId),'')fldNameBaratDar,'' fldStatusFish,''AS fldStatusFishId,NULL AS fldFishId,0 fldShomareHesabIdOrgan,'' AS fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
FROM         Drd.tblBarat
)t
WHERE fldTarikhSarResid like @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND t.fldTarikhSarResid BETWEEN @AzTarikh AND @TaTarikh

IF(@AzTarikh <>'' AND @TaTarikh='')
SELECT TOP(@h)  * FROM (
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 AS fldShomareHesabId ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT) fldTypeSanad, ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
,N'برات' AS fldTypeSanadName
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,'' AS fldShomareHesab,'' fldBankName,0 fldBankId,'' fldNameShobe,0 fldShobeId,ISNULL(com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId),'')fldNameBaratDar,'' fldStatusFish,''AS fldStatusFishId,NULL AS fldFishId,0 fldShomareHesabIdOrgan,'' AS fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
FROM         Drd.tblBarat
)t
WHERE fldTarikhSarResid like @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND t.fldTarikhSarResid >= @AzTarikh 

IF(@AzTarikh ='' AND @TaTarikh<>'')
SELECT TOP(@h)  * FROM (
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 AS fldShomareHesabId ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT) fldTypeSanad, ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
,N'برات' AS fldTypeSanadName
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,'' AS fldShomareHesab,'' fldBankName,0 fldBankId,'' fldNameShobe,0 fldShobeId,ISNULL(com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId),'')fldNameBaratDar,'' fldStatusFish,''AS fldStatusFishId,NULL AS fldFishId,0 fldShomareHesabIdOrgan,'' AS fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
FROM         Drd.tblBarat
)t
WHERE fldTarikhSarResid like @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND t.fldTarikhSarResid <= @TaTarikh

IF(@AzTarikh ='' AND @TaTarikh='')
SELECT TOP(@h)  * FROM (
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 AS fldShomareHesabId ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT) fldTypeSanad, ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
,N'برات' AS fldTypeSanadName
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,'' AS fldShomareHesab,'' fldBankName,0 fldBankId,'' fldNameShobe,0 fldShobeId,ISNULL(com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId),'')fldNameBaratDar,'' fldStatusFish,''AS fldStatusFishId,NULL AS fldFishId,0 fldShomareHesabIdOrgan,'' AS fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL THEN (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) END
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldid IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL THEN (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) END
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldid IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL THEN (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) END
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldid IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
FROM         Drd.tblBarat
--where  fldTarikhSarResid like @Year+'%'
)t
WHERE fldTarikhSarResid LIKE @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))

END

IF (@fieldname=N'Ejra_fldMablaghSanad')
BEGIN
IF(@AzTarikh <>'' AND @TaTarikh<>'')
SELECT TOP(@h)  * FROM (
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 AS fldShomareHesabId ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT) fldTypeSanad, ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
,N'برات' AS fldTypeSanadName
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,'' AS fldShomareHesab,'' fldBankName,0 fldBankId,'' fldNameShobe,0 fldShobeId,ISNULL(com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId),'')fldNameBaratDar,'' fldStatusFish,''AS fldStatusFishId,NULL AS fldFishId,0 fldShomareHesabIdOrgan,'' AS fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
FROM         Drd.tblBarat
)t
WHERE fldMablaghSanad like @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND t.fldTarikhSarResid BETWEEN @AzTarikh AND @TaTarikh

IF(@AzTarikh <>'' AND @TaTarikh='')
SELECT TOP(@h)  * FROM (
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 AS fldShomareHesabId ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT) fldTypeSanad, ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
,N'برات' AS fldTypeSanadName
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,'' AS fldShomareHesab,'' fldBankName,0 fldBankId,'' fldNameShobe,0 fldShobeId,ISNULL(com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId),'')fldNameBaratDar,'' fldStatusFish,''AS fldStatusFishId,NULL AS fldFishId,0 fldShomareHesabIdOrgan,'' AS fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
FROM         Drd.tblBarat
)t
WHERE fldMablaghSanad like @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND t.fldTarikhSarResid >= @AzTarikh 

IF(@AzTarikh ='' AND @TaTarikh<>'')
SELECT TOP(@h)  * FROM (
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 AS fldShomareHesabId ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT) fldTypeSanad, ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
,N'برات' AS fldTypeSanadName
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,'' AS fldShomareHesab,'' fldBankName,0 fldBankId,'' fldNameShobe,0 fldShobeId,ISNULL(com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId),'')fldNameBaratDar,'' fldStatusFish,''AS fldStatusFishId,NULL AS fldFishId,0 fldShomareHesabIdOrgan,'' AS fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
FROM         Drd.tblBarat
)t
WHERE fldMablaghSanad like @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND t.fldTarikhSarResid <= @TaTarikh

IF(@AzTarikh ='' AND @TaTarikh='')
SELECT TOP(@h)  * FROM (
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 AS fldShomareHesabId ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT) fldTypeSanad, ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
,N'برات' AS fldTypeSanadName
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,'' AS fldShomareHesab,'' fldBankName,0 fldBankId,'' fldNameShobe,0 fldShobeId,ISNULL(com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId),'')fldNameBaratDar,'' fldStatusFish,''AS fldStatusFishId,NULL AS fldFishId,0 fldShomareHesabIdOrgan,'' AS fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL THEN (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) END
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldid IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL THEN (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) END
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldid IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL THEN (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) END
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldid IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
FROM         Drd.tblBarat
--where  fldTarikhSarResid like @Year+'%'
)t
WHERE fldMablaghSanad LIKE @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))

END




IF (@fieldname=N'Ejra_fldTypeSanadName')
BEGIN
IF(@AzTarikh <>'' AND @TaTarikh<>'')
SELECT TOP(@h)  * FROM (
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 AS fldShomareHesabId ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT) fldTypeSanad, ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
,N'برات' AS fldTypeSanadName
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,'' AS fldShomareHesab,'' fldBankName,0 fldBankId,'' fldNameShobe,0 fldShobeId,ISNULL(com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId),'')fldNameBaratDar,'' fldStatusFish,''AS fldStatusFishId,NULL AS fldFishId,0 fldShomareHesabIdOrgan,'' AS fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
FROM         Drd.tblBarat
)t
WHERE fldTypeSanadName like @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND t.fldTarikhSarResid BETWEEN @AzTarikh AND @TaTarikh

IF(@AzTarikh <>'' AND @TaTarikh='')
SELECT TOP(@h)  * FROM (
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 AS fldShomareHesabId ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT) fldTypeSanad, ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
,N'برات' AS fldTypeSanadName
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,'' AS fldShomareHesab,'' fldBankName,0 fldBankId,'' fldNameShobe,0 fldShobeId,ISNULL(com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId),'')fldNameBaratDar,'' fldStatusFish,''AS fldStatusFishId,NULL AS fldFishId,0 fldShomareHesabIdOrgan,'' AS fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
FROM         Drd.tblBarat
)t
WHERE fldTypeSanadName like @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND t.fldTarikhSarResid >= @AzTarikh 

IF(@AzTarikh ='' AND @TaTarikh<>'')
SELECT TOP(@h)  * FROM (
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 AS fldShomareHesabId ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT) fldTypeSanad, ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
,N'برات' AS fldTypeSanadName
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,'' AS fldShomareHesab,'' fldBankName,0 fldBankId,'' fldNameShobe,0 fldShobeId,ISNULL(com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId),'')fldNameBaratDar,'' fldStatusFish,''AS fldStatusFishId,NULL AS fldFishId,0 fldShomareHesabIdOrgan,'' AS fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
FROM         Drd.tblBarat
)t
WHERE fldTypeSanadName like @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND t.fldTarikhSarResid <= @TaTarikh

IF(@AzTarikh ='' AND @TaTarikh='')
SELECT TOP(@h)  * FROM (
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 AS fldShomareHesabId ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT) fldTypeSanad, ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
,N'برات' AS fldTypeSanadName
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,'' AS fldShomareHesab,'' fldBankName,0 fldBankId,'' fldNameShobe,0 fldShobeId,ISNULL(com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId),'')fldNameBaratDar,'' fldStatusFish,''AS fldStatusFishId,NULL AS fldFishId,0 fldShomareHesabIdOrgan,'' AS fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL THEN (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) END
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldid IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL THEN (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) END
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldid IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL THEN (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) END
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldid IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
FROM         Drd.tblBarat
--where  fldTarikhSarResid like @Year+'%'
)t
WHERE fldTypeSanadName LIKE @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))

END

IF (@fieldname=N'Ejra_fldStatusName')
BEGIN
IF(@AzTarikh <>'' AND @TaTarikh<>'')
SELECT TOP(@h)  * FROM (
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 AS fldShomareHesabId ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT) fldTypeSanad, ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
,N'برات' AS fldTypeSanadName
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,'' AS fldShomareHesab,'' fldBankName,0 fldBankId,'' fldNameShobe,0 fldShobeId,ISNULL(com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId),'')fldNameBaratDar,'' fldStatusFish,''AS fldStatusFishId,NULL AS fldFishId,0 fldShomareHesabIdOrgan,'' AS fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
FROM         Drd.tblBarat
)t
WHERE fldStatusName like @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND t.fldTarikhSarResid BETWEEN @AzTarikh AND @TaTarikh

IF(@AzTarikh <>'' AND @TaTarikh='')
SELECT TOP(@h)  * FROM (
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 AS fldShomareHesabId ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT) fldTypeSanad, ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
,N'برات' AS fldTypeSanadName
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,'' AS fldShomareHesab,'' fldBankName,0 fldBankId,'' fldNameShobe,0 fldShobeId,ISNULL(com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId),'')fldNameBaratDar,'' fldStatusFish,''AS fldStatusFishId,NULL AS fldFishId,0 fldShomareHesabIdOrgan,'' AS fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL THEN (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) END
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL THEN (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) END
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL THEN (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) END
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
FROM         Drd.tblBarat
)t
WHERE fldStatusName LIKE @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND t.fldTarikhSarResid >= @AzTarikh 

IF(@AzTarikh ='' AND @TaTarikh<>'')
SELECT TOP(@h)  * FROM (
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 AS fldShomareHesabId ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT) fldTypeSanad, ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
,N'برات' AS fldTypeSanadName
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,'' AS fldShomareHesab,'' fldBankName,0 fldBankId,'' fldNameShobe,0 fldShobeId,ISNULL(com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId),'')fldNameBaratDar,'' fldStatusFish,''AS fldStatusFishId,NULL AS fldFishId,0 fldShomareHesabIdOrgan,'' AS fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL THEN (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) END
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL THEN (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) END
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL THEN (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) END
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
FROM         Drd.tblBarat
)t
WHERE fldStatusName LIKE @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND t.fldTarikhSarResid <= @TaTarikh

IF(@AzTarikh ='' AND @TaTarikh='')
SELECT TOP(@h)  * FROM (
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 AS fldShomareHesabId ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT) fldTypeSanad, ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
,N'برات' AS fldTypeSanadName
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,'' AS fldShomareHesab,'' fldBankName,0 fldBankId,'' fldNameShobe,0 fldShobeId,ISNULL(com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId),'')fldNameBaratDar,'' fldStatusFish,''AS fldStatusFishId,NULL AS fldFishId,0 fldShomareHesabIdOrgan,'' AS fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL THEN (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) END
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldid IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL THEN (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) END
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldid IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL THEN (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) END
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldid IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
FROM         Drd.tblBarat
--where  fldTarikhSarResid like @Year+'%'
)t
WHERE fldStatusName LIKE @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))

END

IF (@fieldname=N'Ejra_fldBankName')
BEGIN
IF(@AzTarikh <>'' AND @TaTarikh<>'')
SELECT TOP(@h)  * FROM (
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 AS fldShomareHesabId ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT) fldTypeSanad, ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
,N'برات' AS fldTypeSanadName
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,'' AS fldShomareHesab,'' fldBankName,0 fldBankId,'' fldNameShobe,0 fldShobeId,ISNULL(com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId),'')fldNameBaratDar,'' fldStatusFish,''AS fldStatusFishId,NULL AS fldFishId,0 fldShomareHesabIdOrgan,'' AS fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
FROM         Drd.tblBarat
)t
WHERE fldBankName like @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND t.fldTarikhSarResid BETWEEN @AzTarikh AND @TaTarikh

IF(@AzTarikh <>'' AND @TaTarikh='')
SELECT TOP(@h)  * FROM (
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 AS fldShomareHesabId ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT) fldTypeSanad, ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
,N'برات' AS fldTypeSanadName
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,'' AS fldShomareHesab,'' fldBankName,0 fldBankId,'' fldNameShobe,0 fldShobeId,ISNULL(com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId),'')fldNameBaratDar,'' fldStatusFish,''AS fldStatusFishId,NULL AS fldFishId,0 fldShomareHesabIdOrgan,'' AS fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
FROM         Drd.tblBarat
)t
WHERE fldBankName like @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND t.fldTarikhSarResid >= @AzTarikh 

IF(@AzTarikh ='' AND @TaTarikh<>'')
SELECT TOP(@h)  * FROM (
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 AS fldShomareHesabId ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT) fldTypeSanad, ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
,N'برات' AS fldTypeSanadName
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,'' AS fldShomareHesab,'' fldBankName,0 fldBankId,'' fldNameShobe,0 fldShobeId,ISNULL(com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId),'')fldNameBaratDar,'' fldStatusFish,''AS fldStatusFishId,NULL AS fldFishId,0 fldShomareHesabIdOrgan,'' AS fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
FROM         Drd.tblBarat
)t
WHERE fldBankName like @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND t.fldTarikhSarResid <= @TaTarikh

IF(@AzTarikh ='' AND @TaTarikh='')
SELECT TOP(@h)  * FROM (
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 AS fldShomareHesabId ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT) fldTypeSanad, ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
,N'برات' AS fldTypeSanadName
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,'' AS fldShomareHesab,'' fldBankName,0 fldBankId,'' fldNameShobe,0 fldShobeId,ISNULL(com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId),'')fldNameBaratDar,'' fldStatusFish,''AS fldStatusFishId,NULL AS fldFishId,0 fldShomareHesabIdOrgan,'' AS fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL THEN (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) END
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldid IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL THEN (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) END
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldid IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL THEN (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) END
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldid IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
FROM         Drd.tblBarat
--where  fldTarikhSarResid like @Year+'%'
)t
WHERE fldBankName LIKE @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))

END

IF (@fieldname=N'Ejra_fldNameShobe')
BEGIN
IF(@AzTarikh <>'' AND @TaTarikh<>'')
SELECT TOP(@h)  * FROM (
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 AS fldShomareHesabId ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT) fldTypeSanad, ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
,N'برات' AS fldTypeSanadName
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,'' AS fldShomareHesab,'' fldBankName,0 fldBankId,'' fldNameShobe,0 fldShobeId,ISNULL(com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId),'')fldNameBaratDar,'' fldStatusFish,''AS fldStatusFishId,NULL AS fldFishId,0 fldShomareHesabIdOrgan,'' AS fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
FROM         Drd.tblBarat
)t
WHERE fldNameShobe like @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND t.fldTarikhSarResid BETWEEN @AzTarikh AND @TaTarikh

IF(@AzTarikh <>'' AND @TaTarikh='')
SELECT TOP(@h)  * FROM (
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 AS fldShomareHesabId ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT) fldTypeSanad, ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
,N'برات' AS fldTypeSanadName
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,'' AS fldShomareHesab,'' fldBankName,0 fldBankId,'' fldNameShobe,0 fldShobeId,ISNULL(com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId),'')fldNameBaratDar,'' fldStatusFish,''AS fldStatusFishId,NULL AS fldFishId,0 fldShomareHesabIdOrgan,'' AS fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
FROM         Drd.tblBarat
)t
WHERE fldNameShobe like @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND t.fldTarikhSarResid >= @AzTarikh 

IF(@AzTarikh ='' AND @TaTarikh<>'')
SELECT TOP(@h)  * FROM (
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 AS fldShomareHesabId ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT) fldTypeSanad, ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
,N'برات' AS fldTypeSanadName
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,'' AS fldShomareHesab,'' fldBankName,0 fldBankId,'' fldNameShobe,0 fldShobeId,ISNULL(com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId),'')fldNameBaratDar,'' fldStatusFish,''AS fldStatusFishId,NULL AS fldFishId,0 fldShomareHesabIdOrgan,'' AS fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
FROM         Drd.tblBarat
)t
WHERE fldNameShobe like @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND t.fldTarikhSarResid <= @TaTarikh

IF(@AzTarikh ='' AND @TaTarikh='')
SELECT TOP(@h)  * FROM (
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 AS fldShomareHesabId ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT) fldTypeSanad, ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
,N'برات' AS fldTypeSanadName
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,'' AS fldShomareHesab,'' fldBankName,0 fldBankId,'' fldNameShobe,0 fldShobeId,ISNULL(com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId),'')fldNameBaratDar,'' fldStatusFish,''AS fldStatusFishId,NULL AS fldFishId,0 fldShomareHesabIdOrgan,'' AS fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL THEN (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) END
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldid IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL THEN (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) END
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldid IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL THEN (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) END
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldid IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
FROM         Drd.tblBarat
--where  fldTarikhSarResid like @Year+'%'
)t
WHERE fldNameShobe LIKE @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))

END

IF (@fieldname=N'Ejra_fldShomareHesab')
BEGIN
IF(@AzTarikh <>'' AND @TaTarikh<>'')
SELECT TOP(@h)  * FROM (
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 AS fldShomareHesabId ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT) fldTypeSanad, ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
,N'برات' AS fldTypeSanadName
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,'' AS fldShomareHesab,'' fldBankName,0 fldBankId,'' fldNameShobe,0 fldShobeId,ISNULL(com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId),'')fldNameBaratDar,'' fldStatusFish,''AS fldStatusFishId,NULL AS fldFishId,0 fldShomareHesabIdOrgan,'' AS fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
FROM         Drd.tblBarat
)t
WHERE fldShomareHesab like @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND t.fldTarikhSarResid BETWEEN @AzTarikh AND @TaTarikh

IF(@AzTarikh <>'' AND @TaTarikh='')
SELECT TOP(@h)  * FROM (
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 AS fldShomareHesabId ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT) fldTypeSanad, ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
,N'برات' AS fldTypeSanadName
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,'' AS fldShomareHesab,'' fldBankName,0 fldBankId,'' fldNameShobe,0 fldShobeId,ISNULL(com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId),'')fldNameBaratDar,'' fldStatusFish,''AS fldStatusFishId,NULL AS fldFishId,0 fldShomareHesabIdOrgan,'' AS fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
FROM         Drd.tblBarat
)t
WHERE fldShomareHesab like @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND t.fldTarikhSarResid >= @AzTarikh 

IF(@AzTarikh ='' AND @TaTarikh<>'')
SELECT TOP(@h)  * FROM (
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 AS fldShomareHesabId ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT) fldTypeSanad, ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
,N'برات' AS fldTypeSanadName
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,'' AS fldShomareHesab,'' fldBankName,0 fldBankId,'' fldNameShobe,0 fldShobeId,ISNULL(com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId),'')fldNameBaratDar,'' fldStatusFish,''AS fldStatusFishId,NULL AS fldFishId,0 fldShomareHesabIdOrgan,'' AS fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
FROM         Drd.tblBarat
)t
WHERE fldShomareHesab like @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND t.fldTarikhSarResid <= @TaTarikh

IF(@AzTarikh ='' AND @TaTarikh='')
SELECT TOP(@h)  * FROM (
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 AS fldShomareHesabId ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT) fldTypeSanad, ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
,N'برات' AS fldTypeSanadName
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,'' AS fldShomareHesab,'' fldBankName,0 fldBankId,'' fldNameShobe,0 fldShobeId,ISNULL(com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId),'')fldNameBaratDar,'' fldStatusFish,''AS fldStatusFishId,NULL AS fldFishId,0 fldShomareHesabIdOrgan,'' AS fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL THEN (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) END
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldid IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL THEN (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) END
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldid IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL THEN (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) END
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldid IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
FROM         Drd.tblBarat
--where  fldTarikhSarResid like @Year+'%'
)t
WHERE fldShomareHesab LIKE @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))

END


IF (@fieldname=N'Ejra_fldName')
BEGIN
IF(@AzTarikh <>'' AND @TaTarikh<>'')
SELECT TOP(@h)  * FROM (
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 AS fldShomareHesabId ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT) fldTypeSanad, ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
,N'برات' AS fldTypeSanadName
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,'' AS fldShomareHesab,'' fldBankName,0 fldBankId,'' fldNameShobe,0 fldShobeId,ISNULL(com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId),'')fldNameBaratDar,'' fldStatusFish,''AS fldStatusFishId,NULL AS fldFishId,0 fldShomareHesabIdOrgan,'' AS fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
FROM         Drd.tblBarat
)t
WHERE fldname like @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND t.fldTarikhSarResid BETWEEN @AzTarikh AND @TaTarikh

IF(@AzTarikh <>'' AND @TaTarikh='')
SELECT TOP(@h)  * FROM (
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 AS fldShomareHesabId ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT) fldTypeSanad, ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
,N'برات' AS fldTypeSanadName
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,'' AS fldShomareHesab,'' fldBankName,0 fldBankId,'' fldNameShobe,0 fldShobeId,ISNULL(com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId),'')fldNameBaratDar,'' fldStatusFish,''AS fldStatusFishId,NULL AS fldFishId,0 fldShomareHesabIdOrgan,'' AS fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
FROM         Drd.tblBarat
)t
WHERE fldname like @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND t.fldTarikhSarResid >= @AzTarikh 

IF(@AzTarikh ='' AND @TaTarikh<>'')
SELECT TOP(@h)  * FROM (
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 AS fldShomareHesabId ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT) fldTypeSanad, ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
,N'برات' AS fldTypeSanadName
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,'' AS fldShomareHesab,'' fldBankName,0 fldBankId,'' fldNameShobe,0 fldShobeId,ISNULL(com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId),'')fldNameBaratDar,'' fldStatusFish,''AS fldStatusFishId,NULL AS fldFishId,0 fldShomareHesabIdOrgan,'' AS fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
FROM         Drd.tblBarat
)t
WHERE fldname like @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND t.fldTarikhSarResid <= @TaTarikh

IF(@AzTarikh ='' AND @TaTarikh='')
SELECT TOP(@h)  * FROM (
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 AS fldShomareHesabId ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT) fldTypeSanad, ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
,N'برات' AS fldTypeSanadName
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,'' AS fldShomareHesab,'' fldBankName,0 fldBankId,'' fldNameShobe,0 fldShobeId,ISNULL(com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId),'')fldNameBaratDar,'' fldStatusFish,''AS fldStatusFishId,NULL AS fldFishId,0 fldShomareHesabIdOrgan,'' AS fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
FROM         Drd.tblBarat
--where  fldTarikhSarResid like @Year+'%'
)t
WHERE fldName LIKE @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))

END

if (@fieldname=N'Ejra_fldShenaseMeli')
BEGIN
IF(@AzTarikh <>'' AND @TaTarikh<>'')
SELECT TOP(@h)  * FROM (
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 AS fldShomareHesabId ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT) fldTypeSanad, ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
,N'برات' AS fldTypeSanadName
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,'' AS fldShomareHesab,'' fldBankName,0 fldBankId,'' fldNameShobe,0 fldShobeId,ISNULL(com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId),'')fldNameBaratDar,'' fldStatusFish,''AS fldStatusFishId,NULL AS fldFishId,0 fldShomareHesabIdOrgan,'' AS fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
FROM         Drd.tblBarat
)t
WHERE t.fldShenaseMeli like @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND t.fldTarikhSarResid BETWEEN @AzTarikh AND @TaTarikh

IF(@AzTarikh <>'' AND @TaTarikh='')
SELECT TOP(@h)  * FROM (

SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 AS fldShomareHesabId ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT) fldTypeSanad, ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
,N'برات' AS fldTypeSanadName
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,'' AS fldShomareHesab,'' fldBankName,0 fldBankId,'' fldNameShobe,0 fldShobeId,ISNULL(com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId),'')fldNameBaratDar,'' fldStatusFish,''AS fldStatusFishId,NULL AS fldFishId,0 fldShomareHesabIdOrgan,'' AS fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
FROM         Drd.tblBarat
)t
WHERE t.fldShenaseMeli like @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND t.fldTarikhSarResid >= @AzTarikh 

IF(@AzTarikh ='' AND @TaTarikh<>'')
SELECT TOP(@h)  * FROM (
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 AS fldShomareHesabId ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT) fldTypeSanad, ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
,N'برات' AS fldTypeSanadName
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,'' AS fldShomareHesab,'' fldBankName,0 fldBankId,'' fldNameShobe,0 fldShobeId,ISNULL(com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId),'')fldNameBaratDar,'' fldStatusFish,''AS fldStatusFishId,NULL AS fldFishId,0 fldShomareHesabIdOrgan,'' AS fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
FROM         Drd.tblBarat
)t
WHERE t.fldShenaseMeli like @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND t.fldTarikhSarResid <= @TaTarikh

IF(@AzTarikh ='' AND @TaTarikh='')
SELECT TOP(@h)  * FROM (
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 AS fldShomareHesabId ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT) fldTypeSanad, ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
,N'برات' AS fldTypeSanadName
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,'' AS fldShomareHesab,'' fldBankName,0 fldBankId,'' fldNameShobe,0 fldShobeId,ISNULL(com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId),'')fldNameBaratDar,'' fldStatusFish,''AS fldStatusFishId,NULL AS fldFishId,0 fldShomareHesabIdOrgan,'' AS fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
FROM         Drd.tblBarat
--where  fldTarikhSarResid like @Year+'%'
)t
WHERE t.fldShenaseMeli LIKE @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))

END
if (@fieldname=N'Ejra_fldFather_Sabt')
BEGIN
IF(@AzTarikh <>'' AND @TaTarikh<>'')
SELECT TOP(@h)  * FROM (
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 AS fldShomareHesabId ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT) fldTypeSanad, ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
,N'برات' AS fldTypeSanadName
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,'' AS fldShomareHesab,'' fldBankName,0 fldBankId,'' fldNameShobe,0 fldShobeId,ISNULL(com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId),'')fldNameBaratDar,'' fldStatusFish,''AS fldStatusFishId,NULL AS fldFishId,0 fldShomareHesabIdOrgan,'' AS fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
FROM         Drd.tblBarat
)t
WHERE fldFather_Sabt like @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND t.fldTarikhSarResid BETWEEN @AzTarikh AND @TaTarikh

IF(@AzTarikh <>'' AND @TaTarikh='')
SELECT TOP(@h)  * FROM (
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 AS fldShomareHesabId ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT) fldTypeSanad, ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
,N'برات' AS fldTypeSanadName
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,'' AS fldShomareHesab,'' fldBankName,0 fldBankId,'' fldNameShobe,0 fldShobeId,ISNULL(com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId),'')fldNameBaratDar,'' fldStatusFish,''AS fldStatusFishId,NULL AS fldFishId,0 fldShomareHesabIdOrgan,'' AS fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
FROM         Drd.tblBarat
)t
WHERE fldFather_Sabt like @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND t.fldTarikhSarResid >= @AzTarikh 

IF(@AzTarikh ='' AND @TaTarikh<>'')
SELECT TOP(@h)  * FROM (
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 AS fldShomareHesabId ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT) fldTypeSanad, ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
,N'برات' AS fldTypeSanadName
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,'' AS fldShomareHesab,'' fldBankName,0 fldBankId,'' fldNameShobe,0 fldShobeId,ISNULL(com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId),'')fldNameBaratDar,'' fldStatusFish,''AS fldStatusFishId,NULL AS fldFishId,0 fldShomareHesabIdOrgan,'' AS fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
FROM         Drd.tblBarat
)t
WHERE fldFather_Sabt like @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND t.fldTarikhSarResid <= @TaTarikh

IF(@AzTarikh ='' AND @TaTarikh='')
SELECT TOP(@h)  * FROM (
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 AS fldShomareHesabId ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT) fldTypeSanad, ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
,N'برات' AS fldTypeSanadName
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,'' AS fldShomareHesab,'' fldBankName,0 fldBankId,'' fldNameShobe,0 fldShobeId,ISNULL(com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId),'')fldNameBaratDar,'' fldStatusFish,''AS fldStatusFishId,NULL AS fldFishId,0 fldShomareHesabIdOrgan,'' AS fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
FROM         Drd.tblBarat
--where  fldTarikhSarResid like @Year+'%'
)t
WHERE t.fldFather_Sabt LIKE @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))

END

if (@fieldname=N'Ejra_fldNameBaratDar')
BEGIN
IF(@AzTarikh <>'' AND @TaTarikh<>'')
SELECT TOP(@h)  * FROM (
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 AS fldShomareHesabId ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT) fldTypeSanad, ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
,N'برات' AS fldTypeSanadName
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,'' AS fldShomareHesab,'' fldBankName,0 fldBankId,'' fldNameShobe,0 fldShobeId,ISNULL(com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId),'')fldNameBaratDar,'' fldStatusFish,''AS fldStatusFishId,NULL AS fldFishId,0 fldShomareHesabIdOrgan,'' AS fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
FROM         Drd.tblBarat
)t
WHERE fldNameBaratDar like @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND t.fldTarikhSarResid BETWEEN @AzTarikh AND @TaTarikh

IF(@AzTarikh <>'' AND @TaTarikh='')
SELECT TOP(@h)  * FROM (
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 AS fldShomareHesabId ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT) fldTypeSanad, ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
,N'برات' AS fldTypeSanadName
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,'' AS fldShomareHesab,'' fldBankName,0 fldBankId,'' fldNameShobe,0 fldShobeId,ISNULL(com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId),'')fldNameBaratDar,'' fldStatusFish,''AS fldStatusFishId,NULL AS fldFishId,0 fldShomareHesabIdOrgan,'' AS fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
FROM         Drd.tblBarat
)t
WHERE fldNameBaratDar like @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND t.fldTarikhSarResid >= @AzTarikh 

IF(@AzTarikh ='' AND @TaTarikh<>'')
SELECT TOP(@h)  * FROM (
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 AS fldShomareHesabId ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT) fldTypeSanad, ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
,N'برات' AS fldTypeSanadName
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,'' AS fldShomareHesab,'' fldBankName,0 fldBankId,'' fldNameShobe,0 fldShobeId,ISNULL(com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId),'')fldNameBaratDar,'' fldStatusFish,''AS fldStatusFishId,NULL AS fldFishId,0 fldShomareHesabIdOrgan,'' AS fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
FROM         Drd.tblBarat

)t
WHERE fldNameBaratDar like @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND t.fldTarikhSarResid <= @TaTarikh

IF(@AzTarikh ='' AND @TaTarikh='')
SELECT TOP(@h)  * FROM (
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 AS fldShomareHesabId ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT) fldTypeSanad, ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
,N'برات' AS fldTypeSanadName
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,'' AS fldShomareHesab,'' fldBankName,0 fldBankId,'' fldNameShobe,0 fldShobeId,ISNULL(com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId),'')fldNameBaratDar,'' fldStatusFish,''AS fldStatusFishId,NULL AS fldFishId,0 fldShomareHesabIdOrgan,'' AS fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
FROM         Drd.tblBarat
--where  fldTarikhSarResid like @Year+'%'
)t
WHERE t.fldNameBaratDar LIKE @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
END

if (@fieldname=N'Ejra_fldTarikhAkhz')
BEGIN
IF(@AzTarikh <>'' AND @TaTarikh<>'')
SELECT TOP(@h)  * FROM (
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 AS fldShomareHesabId ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT) fldTypeSanad, ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
,N'برات' AS fldTypeSanadName
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,'' AS fldShomareHesab,'' fldBankName,0 fldBankId,'' fldNameShobe,0 fldShobeId,ISNULL(com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId),'')fldNameBaratDar,'' fldStatusFish,''AS fldStatusFishId,NULL AS fldFishId,0 fldShomareHesabIdOrgan,'' AS fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
FROM         Drd.tblBarat
)t
WHERE fldTarikhAkhz like @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND t.fldTarikhSarResid BETWEEN @AzTarikh AND @TaTarikh

IF(@AzTarikh <>'' AND @TaTarikh='')
SELECT TOP(@h)  * FROM (
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 AS fldShomareHesabId ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT) fldTypeSanad, ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
,N'برات' AS fldTypeSanadName
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,'' AS fldShomareHesab,'' fldBankName,0 fldBankId,'' fldNameShobe,0 fldShobeId,ISNULL(com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId),'')fldNameBaratDar,'' fldStatusFish,''AS fldStatusFishId,NULL AS fldFishId,0 fldShomareHesabIdOrgan,'' AS fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
FROM         Drd.tblBarat
)t
WHERE fldTarikhAkhz like @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND t.fldTarikhSarResid >= @AzTarikh 

IF(@AzTarikh ='' AND @TaTarikh<>'')
SELECT TOP(@h)  * FROM (
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 AS fldShomareHesabId ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT) fldTypeSanad, ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
,N'برات' AS fldTypeSanadName
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,'' AS fldShomareHesab,'' fldBankName,0 fldBankId,'' fldNameShobe,0 fldShobeId,ISNULL(com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId),'')fldNameBaratDar,'' fldStatusFish,''AS fldStatusFishId,NULL AS fldFishId,0 fldShomareHesabIdOrgan,'' AS fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
FROM         Drd.tblBarat

)t
WHERE fldTarikhAkhz like @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND t.fldTarikhSarResid <= @TaTarikh

IF(@AzTarikh ='' AND @TaTarikh='')
SELECT TOP(@h)  * FROM (
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 AS fldShomareHesabId ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT) fldTypeSanad, ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
,N'برات' AS fldTypeSanadName
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,'' AS fldShomareHesab,'' fldBankName,0 fldBankId,'' fldNameShobe,0 fldShobeId,ISNULL(com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId),'')fldNameBaratDar,'' fldStatusFish,''AS fldStatusFishId,NULL AS fldFishId,0 fldShomareHesabIdOrgan,'' AS fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
FROM         Drd.tblBarat
--where  fldTarikhSarResid like @Year+'%'
)t
WHERE t.fldTarikhAkhz LIKE @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
END

if (@fieldname=N'Ejra')
BEGIN
IF(@AzTarikh <>'' AND @TaTarikh<>'')
SELECT TOP(@h)  * FROM (
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 AS fldShomareHesabId ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT) fldTypeSanad, ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
,N'برات' AS fldTypeSanadName
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,'' AS fldShomareHesab,'' fldBankName,0 fldBankId,'' fldNameShobe,0 fldShobeId,ISNULL(com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId),'')fldNameBaratDar,'' fldStatusFish,''AS fldStatusFishId,NULL AS fldFishId,0 fldShomareHesabIdOrgan,'' AS fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
FROM         Drd.tblBarat
)t
WHERE  fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND t.fldTarikhSarResid BETWEEN @AzTarikh AND @TaTarikh

IF(@AzTarikh <>'' AND @TaTarikh='')
SELECT TOP(@h)  * FROM (
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 AS fldShomareHesabId ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT) fldTypeSanad, ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
,N'برات' AS fldTypeSanadName
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,'' AS fldShomareHesab,'' fldBankName,0 fldBankId,'' fldNameShobe,0 fldShobeId,ISNULL(com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId),'')fldNameBaratDar,'' fldStatusFish,''AS fldStatusFishId,NULL AS fldFishId,0 fldShomareHesabIdOrgan,'' AS fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
FROM         Drd.tblBarat
)t
WHERE  fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND t.fldTarikhSarResid >= @AzTarikh 

IF(@AzTarikh ='' AND @TaTarikh<>'')
SELECT TOP(@h)  * FROM (
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 AS fldShomareHesabId ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT) fldTypeSanad, ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
,N'برات' AS fldTypeSanadName
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,'' AS fldShomareHesab,'' fldBankName,0 fldBankId,'' fldNameShobe,0 fldShobeId,ISNULL(com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId),'')fldNameBaratDar,'' fldStatusFish,''AS fldStatusFishId,NULL AS fldFishId,0 fldShomareHesabIdOrgan,'' AS fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
FROM         Drd.tblBarat

)t
WHERE fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND t.fldTarikhSarResid <= @TaTarikh

IF(@AzTarikh ='' AND @TaTarikh='')
SELECT TOP(@h)  * FROM (
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 AS fldShomareHesabId ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT) fldTypeSanad, ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
,N'برات' AS fldTypeSanadName
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,'' AS fldShomareHesab,'' fldBankName,0 fldBankId,'' fldNameShobe,0 fldShobeId,ISNULL(com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId),'')fldNameBaratDar,'' fldStatusFish,''AS fldStatusFishId,NULL AS fldFishId,0 fldShomareHesabIdOrgan,'' AS fldShomareHesabOrgan
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,ISNULL((SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldid IN (SELECT fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId)) ),0) AS fldElamAvarezId
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhAkhz,fldDateStatus
FROM         Drd.tblBarat
)t
WHERE  fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
END
COMMIT
GO
