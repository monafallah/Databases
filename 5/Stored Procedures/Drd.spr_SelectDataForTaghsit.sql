SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_SelectDataForTaghsit]
@value  nvarchar(50),
@fieldname nvarchar(50),
@AzTarikh NVARCHAR(10),
@TaTarikh NVARCHAR(10),
@h INT,
@Organid int
AS
	--DECLARE @organ TABLE (id int)
	--;WITH organ as	(
	--SELECT    fldId    
	--FROM            Com.tblOrganization
	--WHERE fldId=@OrganId
	--UNION ALL
	--SELECT t.fldId FROM Com.tblOrganization AS t
	--INNER JOIN organ ON t.fldPId=organ.fldId
	-- )
	-- INSERT INTO @organ 
	--		 ( id )
	-- SELECT organ.fldId FROM organ
if (@h=0) set @h=2147483647
if (@fieldname=N'ReplyTaghsitId')
SELECT     TOP (@h) Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ),cast(0 as bigint))AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
                      CAST(0 AS TINYINT)) AS fldStatus, ISNULL(Drd.tblCheck.fldShomareHesabId, 0) AS fldShomareHesabId, 0 AS fldBaratDarId, 
                      CASE WHEN fldTypeSanad = 0 THEN CAST(2 AS TINYINT) ELSE CAST(6 AS TINYINT) END AS fldTypeSanad, '' AS fldMakanPardakht, Drd.tblCheck.fldUserId, 
                      Drd.tblCheck.fldDesc, Drd.tblCheck.fldDate, CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, fldDateStatus,
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
					,tblCheck.fldTarikhAkhz AS fldTarikhSabt
					,(SELECT CASE WHEN fldHaghighiId IS NOT NULL THEN (SELECT fldName+'_'+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) 
					WHEN fldHoghoghiId is NOT NULL  THEN (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldid=fldHoghoghiId)END 
					FROM Com.tblAshkhas WHERE fldid=tblShomareHesabeOmoomi.fldAshkhasId)AS fldNameSaderKonandeCheck
					,'' AS TarikhPardakht,isnull(fldFlag,0) as fldIsSanad
FROM         Drd.tblCheck INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId
					outer apply (select top(1) 1 fldFlag from acc.tblDocumentRecord_Details d inner join acc.tblCase c on c.fldid=fldCaseId where fldCaseTypeId=3 and fldSourceId=tblCheck.fldid)document
WHERE fldReplyTaghsitId=@value   AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid))
UNION ALL
SELECT TOP(@h)      fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0,0,CAST(3 AS TINYINT),'',fldUserId, fldDesc, fldDate
,N'سفته' AS fldTypeSanadName, fldDateStatus
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,'','',0,'',0 ,'' fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
					,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhSabt,'','' AS TarikhPardakht,0 as fldIsSanad
					
FROM         Drd.tblSafte
WHERE fldReplyTaghsitId=@value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid))

UNION ALL
SELECT TOP(@h)     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT), ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
,N'برات' AS fldTypeSanadName, fldDateStatus
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,'','',0,'',0,com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId)fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
				,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhSabt,'','' AS TarikhPardakht,0 as fldIsSanad
FROM         Drd.tblBarat
WHERE fldReplyTaghsitId=@value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid))

UNION ALL
SELECT TOP(@h)      fldId,'',  ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId,isnull(CASE WHEN fldFishId NOT IN(SELECT tblEbtal.fldFishId FROM Drd.tblEbtal WHERE tblNaghdi_Talab.fldFishId=tblEbtal.fldFishId) then cast(fldFishId as nvarchar(max))
ELSE NULL END,'') as fldShomareSanad,ISNULL(cast(fldMablagh as bigint),cast(0 as bigint))AS fldMablagh, CAST(0 AS TINYINT),0,0,CASE WHEN fldType=1 THEN CAST(1 AS TINYINT) WHEN fldType=2 THEN CAST(5 AS TINYINT)  WHEN fldType=3 THEN CAST(7 AS TINYINT) end,'', fldUserId, fldDesc, fldDate
,CASE WHEN fldType=1 THEN N'نقدی' WHEN fldType=2 THEN N'بدهکاری' when fldType=3 then N'بستانکاری' end AS fldTypeSanadName, (SELECT fldTarikh FROM Drd.tblPardakhtFish WHERE tblPardakhtFish.fldFishId=tblNaghdi_Talab.fldFishId) AS fldDateStatus
,case when (SELECT fldTarikh FROM Drd.tblPardakhtFish WHERE tblPardakhtFish.fldFishId=tblNaghdi_Talab.fldFishId)<>'' then N'وصول شده' else N'درانتظار وصول' end AS fldStatusName,'','',0,'',0,'' fldNameBaratDar,CASE WHEN fldfishid IS NULL THEN N'فیش صادر نشده' WHEN fldfishId IN (SELECT fldfishId FROM Drd.tblEbtal where fldfishid=tblNaghdi_Talab.fldFishId ) THEN N'فیش ابطال شده' ELSE N'فیش صادر شده'END AS fldStatusFish,
CASE WHEN fldfishid IS NULL THEN N'1' WHEN fldfishId IN (SELECT fldfishId FROM Drd.tblEbtal where fldfishid=tblNaghdi_Talab.fldFishId ) THEN N'3' ELSE N'2'END AS fldStatusFishId
,CASE WHEN fldFishId NOT IN(SELECT tblEbtal.fldFishId FROM Drd.tblEbtal WHERE tblNaghdi_Talab.fldFishId=tblEbtal.fldFishId) then fldFishId
ELSE NULL END AS fldFishId
,ISNULL(fldShomareHesabId,0) ,ISNULL((SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldId=fldShomareHesabId),'') AS fldShomareHesab
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldid IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldid IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldid IN (SELECT fldId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldid FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT fldId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
					,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhSabt,''
					,(SELECT fldTarikh FROM Drd.tblPardakhtFish WHERE tblPardakhtFish.fldFishId=tblNaghdi_Talab.fldFishId) AS TarikhPardakht
					,0 as fldIsSanad
FROM         Drd.tblNaghdi_Talab
WHERE fldReplyTaghsitId=@value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid))


if (@fieldname=N'fldTarikhSarResid')
SELECT TOP(@h)  * FROM (SELECT     TOP (@h) Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ),cast(0 as bigint))AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
                      CAST(0 AS TINYINT)) AS fldStatus, ISNULL(Drd.tblCheck.fldShomareHesabId, 0) AS fldShomareHesabId, 0 AS fldBaratDarId, 
                      CASE WHEN fldTypeSanad = 0 THEN CAST(2 AS TINYINT) ELSE CAST(6 AS TINYINT) END AS fldTypeSanad, '' AS fldMakanPardakht, Drd.tblCheck.fldUserId, 
                      Drd.tblCheck.fldDesc, Drd.tblCheck.fldDate, CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, fldDateStatus, 
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
					,tblCheck.fldTarikhAkhz AS fldTarikhSabt
			,(SELECT CASE WHEN fldHaghighiId IS NOT NULL THEN (SELECT fldName+'_'+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) 
					WHEN fldHoghoghiId is NOT NULL  THEN (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldid=fldHoghoghiId)END 
					FROM Com.tblAshkhas WHERE fldid=tblShomareHesabeOmoomi.fldAshkhasId)AS fldNameSaderKonandeCheck
					,'' AS TarikhPardakht,isnull(fldFlag,0) as fldIsSanad

FROM         Drd.tblCheck INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId
					outer apply (select  top(1) 1 fldFlag from acc.tblDocumentRecord_Details d inner join acc.tblCase c on c.fldid=fldCaseId where fldCaseTypeId=3 and fldSourceId=tblCheck.fldid)document

					  where fldReplyTaghsitId is not null

UNION ALL
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0,0,CAST(3 AS TINYINT),'',fldUserId, fldDesc, fldDate
,N'سفته' AS fldTypeSanadName, fldDateStatus,0 ,''
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,'','',0,'',0 ,'' fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
			,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhSabt,'','' AS TarikhPardakht,0 as fldIsSanad
FROM         Drd.tblSafte

UNION ALL
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT), ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
,N'برات' AS fldTypeSanadName, fldDateStatus,0 ,''
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,'','',0,'',0,com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId)fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
			,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhSabt,'','' AS TarikhPardakht,0 as fldIsSanad
FROM         Drd.tblBarat

UNION ALL
SELECT     fldId,'' AS fldTarikhSarResid,  ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId,'',ISNULL(cast(fldMablagh as bigint),cast(0 as bigint))AS fldMablagh, CAST(0 AS TINYINT),0,0,CASE WHEN fldType=1 THEN CAST(1 AS TINYINT) WHEN fldType=2 THEN CAST(5 AS TINYINT)  WHEN fldType=3 THEN CAST(7 AS TINYINT) end,'', fldUserId, fldDesc, fldDate
,CASE WHEN fldType=1 THEN N'نقدی' WHEN fldType=2 THEN N'بدهکاری' when fldType=3 then N'بستانکاری' end AS fldTypeSanadName, '' AS fldDateStatus
,'' AS fldStatusName,'','',0,'',0,'' fldNameBaratDar,CASE WHEN fldfishid IS NULL THEN N'فیش صادر نشده' WHEN fldfishId IN (SELECT fldfishId FROM Drd.tblEbtal where fldfishid=tblNaghdi_Talab.fldFishId ) THEN N'فیش ابطال شده' ELSE N'فیش صادر شده'END AS fldStatusFish,
CASE WHEN fldfishid IS NULL THEN N'1' WHEN fldfishId IN (SELECT fldfishId FROM Drd.tblEbtal where fldfishid=tblNaghdi_Talab.fldFishId ) THEN N'3' ELSE N'2'END AS fldStatusFishId
,CASE WHEN fldFishId NOT IN(SELECT tblEbtal.fldFishId FROM Drd.tblEbtal WHERE tblNaghdi_Talab.fldFishId=tblEbtal.fldFishId) then fldFishId
ELSE NULL END AS fldFishId,ISNULL(fldShomareHesabId,0) ,ISNULL((SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldId=fldShomareHesabId),'') AS fldShomareHesab
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
				,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhSabt,''
				,(SELECT fldTarikh FROM Drd.tblPardakhtFish WHERE tblPardakhtFish.fldFishId=tblNaghdi_Talab.fldFishId) AS TarikhPardakht,0 as fldIsSanad
FROM         Drd.tblNaghdi_Talab)t
WHERE fldTarikhSarResid like @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid))


if (@fieldname=N'fldShomareSanad')
SELECT TOP(@h)    * FROM (SELECT   Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ),cast(0 as bigint))AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
                      CAST(0 AS TINYINT)) AS fldStatus, ISNULL(Drd.tblCheck.fldShomareHesabId, 0) AS fldShomareHesabId, 0 AS fldBaratDarId, 
                      CASE WHEN fldTypeSanad = 0 THEN CAST(2 AS TINYINT) ELSE CAST(6 AS TINYINT) END AS fldTypeSanad, '' AS fldMakanPardakht, Drd.tblCheck.fldUserId, 
                      Drd.tblCheck.fldDesc, Drd.tblCheck.fldDate, CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, fldDateStatus, 
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
					,tblCheck.fldTarikhAkhz AS fldTarikhSabt	,(SELECT CASE WHEN fldHaghighiId IS NOT NULL THEN (SELECT fldName+'_'+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) 
					WHEN fldHoghoghiId is NOT NULL  THEN (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldid=fldHoghoghiId)END 
					FROM Com.tblAshkhas WHERE fldid=tblShomareHesabeOmoomi.fldAshkhasId)AS fldNameSaderKonandeCheck,'' AS TarikhPardakht
					,isnull(fldFlag,0) as fldIsSanad
FROM         Drd.tblCheck INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId
										outer apply (select   top(1) 1 fldFlag from acc.tblDocumentRecord_Details d inner join acc.tblCase c on c.fldid=fldCaseId where fldCaseTypeId=3 and fldSourceId=tblCheck.fldid)document

					  where fldReplyTaghsitId is not null

UNION ALL
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0,0,CAST(3 AS TINYINT),'',fldUserId, fldDesc, fldDate
,N'سفته' AS fldTypeSanadName, fldDateStatus
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,'','',0,'',0 ,'' fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
				,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhSabt,'','' AS TarikhPardakht,0 as fldIsSanad
FROM         Drd.tblSafte

UNION ALL
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT), ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
,N'برات' AS fldTypeSanadName, fldDateStatus
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,'','',0,'',0,com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId)fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
				,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhSabt,'','' AS TarikhPardakht ,0 as fldIsSanad
FROM         Drd.tblBarat

UNION ALL
SELECT     fldId,'' AS fldTarikhSarResid,  ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId,'',ISNULL(cast(fldMablagh as bigint),cast(0 as bigint))AS fldMablagh, CAST(0 AS TINYINT),0,0,CASE WHEN fldType=1 THEN CAST(1 AS TINYINT) WHEN fldType=2 THEN CAST(5 AS TINYINT)  WHEN fldType=3 THEN CAST(7 AS TINYINT) end,'', fldUserId, fldDesc, fldDate
,CASE WHEN fldType=1 THEN N'نقدی' WHEN fldType=2 THEN N'بدهکاری' when fldType=3 then N'بستانکاری' end AS fldTypeSanadName, '' AS fldDateStatus
,'' AS fldStatusName,'','',0,'',0,'' fldNameBaratDar,CASE WHEN fldfishid IS NULL THEN N'فیش صادر نشده' WHEN fldfishId IN (SELECT fldfishId FROM Drd.tblEbtal where fldfishid=tblNaghdi_Talab.fldFishId ) THEN N'فیش ابطال شده' ELSE N'فیش صادر شده'END AS fldStatusFish,
CASE WHEN fldfishid IS NULL THEN N'1' WHEN fldfishId IN (SELECT fldfishId FROM Drd.tblEbtal where fldfishid=tblNaghdi_Talab.fldFishId ) THEN N'3' ELSE N'2'END AS fldStatusFishId
,CASE WHEN fldFishId NOT IN(SELECT tblEbtal.fldFishId FROM Drd.tblEbtal WHERE tblNaghdi_Talab.fldFishId=tblEbtal.fldFishId) then fldFishId
ELSE NULL END AS fldFishId,ISNULL(fldShomareHesabId,0) ,ISNULL((SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldId=fldShomareHesabId),'') AS fldShomareHesab
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
			,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhSabt,''
			,(SELECT fldTarikh FROM Drd.tblPardakhtFish WHERE tblPardakhtFish.fldFishId=tblNaghdi_Talab.fldFishId) AS TarikhPardakht,0 as fldIsSanad
FROM Drd.tblNaghdi_Talab)t
WHERE fldShomareSanad like @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid))


if (@fieldname=N'fldMablaghSanad')
SELECT TOP(@h)  * FROM (SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ),cast(0 as bigint))AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
                      CAST(0 AS TINYINT)) AS fldStatus, ISNULL(Drd.tblCheck.fldShomareHesabId, 0) AS fldShomareHesabId, 0 AS fldBaratDarId, 
                      CASE WHEN fldTypeSanad = 0 THEN CAST(2 AS TINYINT) ELSE CAST(6 AS TINYINT) END AS fldTypeSanad, '' AS fldMakanPardakht, Drd.tblCheck.fldUserId, 
                      Drd.tblCheck.fldDesc, Drd.tblCheck.fldDate, CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, fldDateStatus, 
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
			,tblCheck.fldTarikhAkhz AS fldTarikhSabt
	,(SELECT CASE WHEN fldHaghighiId IS NOT NULL THEN (SELECT fldName+'_'+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) 
					WHEN fldHoghoghiId is NOT NULL  THEN (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldid=fldHoghoghiId)END 
					FROM Com.tblAshkhas WHERE fldid=tblShomareHesabeOmoomi.fldAshkhasId)AS fldNameSaderKonandeCheck,'' AS TarikhPardakht
					,isnull(fldFlag,0) as fldIsSanad
FROM         Drd.tblCheck INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId
					 					outer apply (select  top(1) 1 fldFlag from acc.tblDocumentRecord_Details d inner join acc.tblCase c on c.fldid=fldCaseId where fldCaseTypeId=3 and fldSourceId=tblCheck.fldid)document

					   where fldReplyTaghsitId is not null

UNION ALL
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0,0,CAST(3 AS TINYINT),'',fldUserId, fldDesc, fldDate
,N'سفته' AS fldTypeSanadName, fldDateStatus
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,'','',0,'',0 ,'' fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhSabt,'','' AS TarikhPardakht,0 as fldIsSanad
FROM         Drd.tblSafte

UNION ALL
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT), ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
,N'برات' AS fldTypeSanadName, fldDateStatus
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,'','',0,'',0,com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId)fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhSabt,'','' AS TarikhPardakht,0 as fldIsSanad
FROM         Drd.tblBarat

UNION ALL
SELECT     fldId,'',  ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId,'',ISNULL(cast(fldMablagh as bigint),cast(0 as bigint))AS fldMablagh, CAST(0 AS TINYINT),0,0,CASE WHEN fldType=1 THEN CAST(1 AS TINYINT) WHEN fldType=2 THEN CAST(5 AS TINYINT)  WHEN fldType=3 THEN CAST(7 AS TINYINT) end,'', fldUserId, fldDesc, fldDate
,CASE WHEN fldType=1 THEN N'نقدی' WHEN fldType=2 THEN N'بدهکاری' when fldType=3 then N'بستانکاری' end AS fldTypeSanadName, '' AS fldDateStatus
,'' AS fldStatusName,'','',0,'',0,'' fldNameBaratDar,CASE WHEN fldfishid IS NULL THEN N'فیش صادر نشده' WHEN fldfishId IN (SELECT fldfishId FROM Drd.tblEbtal where fldfishid=tblNaghdi_Talab.fldFishId ) THEN N'فیش ابطال شده' ELSE N'فیش صادر شده'END AS fldStatusFish,
CASE WHEN fldfishid IS NULL THEN N'1' WHEN fldfishId IN (SELECT fldfishId FROM Drd.tblEbtal where fldfishid=tblNaghdi_Talab.fldFishId ) THEN N'3' ELSE N'2'END AS fldStatusFishId
,CASE WHEN fldFishId NOT IN(SELECT tblEbtal.fldFishId FROM Drd.tblEbtal WHERE tblNaghdi_Talab.fldFishId=tblEbtal.fldFishId) then fldFishId
ELSE NULL END AS fldFishId,ISNULL(fldShomareHesabId,0) ,ISNULL((SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldId=fldShomareHesabId),'') AS fldShomareHesab
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhSabt,''
,(SELECT fldTarikh FROM Drd.tblPardakhtFish WHERE tblPardakhtFish.fldFishId=tblNaghdi_Talab.fldFishId) AS TarikhPardakht,0 as fldIsSanad
FROM         Drd.tblNaghdi_Talab)t
WHERE fldMablaghSanad LIKE @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid))


if (@fieldname=N'fldStatus')
SELECT TOP(@h)  * FROM (SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ),cast(0 as bigint))AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
                      CAST(0 AS TINYINT)) AS fldStatus, ISNULL(Drd.tblCheck.fldShomareHesabId, 0) AS fldShomareHesabId, 0 AS fldBaratDarId, 
                      CASE WHEN fldTypeSanad = 0 THEN CAST(2 AS TINYINT) ELSE CAST(6 AS TINYINT) END AS fldTypeSanad, '' AS fldMakanPardakht, Drd.tblCheck.fldUserId, 
                      Drd.tblCheck.fldDesc, Drd.tblCheck.fldDate, CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, fldDateStatus, 
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
				,tblCheck.fldTarikhAkhz AS fldTarikhSabt,(SELECT CASE WHEN fldHaghighiId IS NOT NULL THEN (SELECT fldName+'_'+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) 
					WHEN fldHoghoghiId is NOT NULL  THEN (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldid=fldHoghoghiId)END 
					FROM Com.tblAshkhas WHERE fldid=tblShomareHesabeOmoomi.fldAshkhasId)AS fldNameSaderKonandeCheck,'' AS TarikhPardakht
					,isnull(fldFlag,0) as fldIsSanad
FROM         Drd.tblCheck INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId
				outer apply (select  top(1) 1 fldFlag from acc.tblDocumentRecord_Details d inner join acc.tblCase c on c.fldid=fldCaseId where fldCaseTypeId=3 and fldSourceId=tblCheck.fldid)document
					   where fldReplyTaghsitId is not null
UNION ALL
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0,0,CAST(3 AS TINYINT),'',fldUserId, fldDesc, fldDate
,N'سفته' AS fldTypeSanadName, fldDateStatus
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,'','',0,'',0 ,'' fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhSabt,'','' AS TarikhPardakht,0 as fldIsSanad
FROM         Drd.tblSafte

UNION ALL
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT), ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
,N'برات' AS fldTypeSanadName, fldDateStatus
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,'','',0,'',0,com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId)fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhSabt,'','' AS TarikhPardakht,0 as fldIsSanad
FROM         Drd.tblBarat

UNION ALL
SELECT     fldId,'',  ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId,'',ISNULL(cast(fldMablagh as bigint),cast(0 as bigint))AS fldMablagh, CAST(0 AS TINYINT),0,0,CASE WHEN fldType=1 THEN CAST(1 AS TINYINT) WHEN fldType=2 THEN CAST(5 AS TINYINT)  WHEN fldType=3 THEN CAST(7 AS TINYINT) end,'', fldUserId, fldDesc, fldDate
,CASE WHEN fldType=1 THEN N'نقدی' WHEN fldType=2 THEN N'بدهکاری' when fldType=3 then N'بستانکاری' end AS fldTypeSanadName, '' AS fldDateStatus
,'' AS fldStatusName,'','',0,'',0,'' fldNameBaratDar,CASE WHEN fldfishid IS NULL THEN N'فیش صادر نشده' WHEN fldfishId IN (SELECT fldfishId FROM Drd.tblEbtal where fldfishid=tblNaghdi_Talab.fldFishId ) THEN N'فیش ابطال شده' ELSE N'فیش صادر شده'END AS fldStatusFish,
CASE WHEN fldfishid IS NULL THEN N'1' WHEN fldfishId IN (SELECT fldfishId FROM Drd.tblEbtal where fldfishid=tblNaghdi_Talab.fldFishId ) THEN N'3' ELSE N'2'END AS fldStatusFishId
,CASE WHEN fldFishId NOT IN(SELECT tblEbtal.fldFishId FROM Drd.tblEbtal WHERE tblNaghdi_Talab.fldFishId=tblEbtal.fldFishId) then fldFishId
ELSE NULL END AS fldFishId,ISNULL(fldShomareHesabId,0) ,ISNULL((SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldId=fldShomareHesabId),'') AS fldShomareHesab
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhSabt,''
,(SELECT fldTarikh FROM Drd.tblPardakhtFish WHERE tblPardakhtFish.fldFishId=tblNaghdi_Talab.fldFishId) AS TarikhPardakht,0 as fldIsSanad
FROM         Drd.tblNaghdi_Talab)t
WHERE fldStatus LIKE @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid))


if (@fieldname=N'fldShomareHesabId')
SELECT  * FROM (SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ),cast(0 as bigint))AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
                      CAST(0 AS TINYINT)) AS fldStatus, ISNULL(Drd.tblCheck.fldShomareHesabId, 0) AS fldShomareHesabId, 0 AS fldBaratDarId, 
                      CASE WHEN fldTypeSanad = 0 THEN CAST(2 AS TINYINT) ELSE CAST(6 AS TINYINT) END AS fldTypeSanad, '' AS fldMakanPardakht, Drd.tblCheck.fldUserId, 
                      Drd.tblCheck.fldDesc, Drd.tblCheck.fldDate, CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, fldDateStatus, 
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
				,tblCheck.fldTarikhAkhz AS fldTarikhSabt
					,(SELECT CASE WHEN fldHaghighiId IS NOT NULL THEN (SELECT fldName+'_'+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) 
					WHEN fldHoghoghiId is NOT NULL  THEN (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldid=fldHoghoghiId)END 
					FROM Com.tblAshkhas WHERE fldid=tblShomareHesabeOmoomi.fldAshkhasId)AS fldNameSaderKonandeCheck,'' AS TarikhPardakht
					,isnull(fldFlag,0) as fldIsSanad
FROM         Drd.tblCheck INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId
outer apply (select  top(1) 1 fldFlag from acc.tblDocumentRecord_Details d inner join acc.tblCase c on c.fldid=fldCaseId where fldCaseTypeId=3 and fldSourceId=tblCheck.fldid)document

					   where fldReplyTaghsitId is not null
UNION ALL
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0,0,CAST(3 AS TINYINT),'',fldUserId, fldDesc, fldDate
,N'سفته' AS fldTypeSanadName, fldDateStatus
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,'','',0,'',0 ,'' fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhSabt,'','' AS TarikhPardakht,0 as fldIsSanad
FROM         Drd.tblSafte

UNION ALL
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT), ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
,N'برات' AS fldTypeSanadName, fldDateStatus
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,'','',0,'',0,com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId)fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhSabt,'','' AS TarikhPardakht,0 as fldIsSanad
FROM         Drd.tblBarat

UNION ALL
SELECT     fldId,'',  ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId,'',ISNULL(cast(fldMablagh as bigint),cast(0 as bigint))AS fldMablagh, CAST(0 AS TINYINT),0,0,CASE WHEN fldType=1 THEN CAST(1 AS TINYINT) WHEN fldType=2 THEN CAST(5 AS TINYINT)  WHEN fldType=3 THEN CAST(7 AS TINYINT) end,'', fldUserId, fldDesc, fldDate
,CASE WHEN fldType=1 THEN N'نقدی' WHEN fldType=2 THEN N'بدهکاری' when fldType=3 then N'بستانکاری' end AS fldTypeSanadName, '' AS fldDateStatus
,'' AS fldStatusName,'','',0,'',0,'' fldNameBaratDar,CASE WHEN fldfishid IS NULL THEN N'فیش صادر نشده' WHEN fldfishId IN (SELECT fldfishId FROM Drd.tblEbtal where fldfishid=tblNaghdi_Talab.fldFishId ) THEN N'فیش ابطال شده' ELSE N'فیش صادر شده'END AS fldStatusFish,
CASE WHEN fldfishid IS NULL THEN N'1' WHEN fldfishId IN (SELECT fldfishId FROM Drd.tblEbtal where fldfishid=tblNaghdi_Talab.fldFishId ) THEN N'3' ELSE N'2'END AS fldStatusFishId
,fldFishId,ISNULL(fldShomareHesabId,0) ,ISNULL((SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldId=fldShomareHesabId),'') AS fldShomareHesab
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhSabt,''
,(SELECT fldTarikh FROM Drd.tblPardakhtFish WHERE tblPardakhtFish.fldFishId=tblNaghdi_Talab.fldFishId) AS TarikhPardakht,0 as fldIsSanad
FROM         Drd.tblNaghdi_Talab)t
WHERE fldShomareHesabId LIKE @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid))


if (@fieldname=N'fldBaratDarId')
SELECT TOP(@h)  * FROM (SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ),cast(0 as bigint))AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
                      CAST(0 AS TINYINT)) AS fldStatus, ISNULL(Drd.tblCheck.fldShomareHesabId, 0) AS fldShomareHesabId, 0 AS fldBaratDarId, 
                      CASE WHEN fldTypeSanad = 0 THEN CAST(2 AS TINYINT) ELSE CAST(6 AS TINYINT) END AS fldTypeSanad, '' AS fldMakanPardakht, Drd.tblCheck.fldUserId, 
                      Drd.tblCheck.fldDesc, Drd.tblCheck.fldDate, CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, fldDateStatus, 
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
					,tblCheck.fldTarikhAkhz AS fldTarikhSabt
						,(SELECT CASE WHEN fldHaghighiId IS NOT NULL THEN (SELECT fldName+'_'+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) 
					WHEN fldHoghoghiId is NOT NULL  THEN (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldid=fldHoghoghiId)END 
					FROM Com.tblAshkhas WHERE fldid=tblShomareHesabeOmoomi.fldAshkhasId)AS fldNameSaderKonandeCheck,'' AS TarikhPardakht
					,isnull(fldFlag,0) as fldIsSanad
FROM         Drd.tblCheck INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId
							outer apply (select  top(1) 1 fldFlag from acc.tblDocumentRecord_Details d inner join acc.tblCase c on c.fldid=fldCaseId where fldCaseTypeId=3 and fldSourceId=tblCheck.fldid)document
			
					   where fldReplyTaghsitId is not null
UNION ALL
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0,0,CAST(3 AS TINYINT),'',fldUserId, fldDesc, fldDate
,N'سفته' AS fldTypeSanadName, fldDateStatus
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,'','',0,'',0 ,'' fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhSabt,'','' AS TarikhPardakht,0 as fldIsSanad
FROM         Drd.tblSafte

UNION ALL
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT), ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
,N'برات' AS fldTypeSanadName, fldDateStatus
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,'','',0,'',0,com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId)fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhSabt,'','' AS TarikhPardakht,0 as fldIsSanad
FROM         Drd.tblBarat

UNION ALL
SELECT     fldId,'',  ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId,'',ISNULL(cast(fldMablagh as bigint),cast(0 as bigint))AS fldMablagh, CAST(0 AS TINYINT),0,0,CASE WHEN fldType=1 THEN CAST(1 AS TINYINT) WHEN fldType=2 THEN CAST(5 AS TINYINT)  WHEN fldType=3 THEN CAST(7 AS TINYINT) end,'', fldUserId, fldDesc, fldDate
,CASE WHEN fldType=1 THEN N'نقدی' WHEN fldType=2 THEN N'بدهکاری' when fldType=3 then N'بستانکاری' end AS fldTypeSanadName, '' AS fldDateStatus
,'' AS fldStatusName,'','',0,'',0,'' fldNameBaratDar,CASE WHEN fldfishid IS NULL THEN N'فیش صادر نشده' WHEN fldfishId IN (SELECT fldfishId FROM Drd.tblEbtal where fldfishid=tblNaghdi_Talab.fldFishId ) THEN N'فیش ابطال شده' ELSE N'فیش صادر شده'END AS fldStatusFish,
CASE WHEN fldfishid IS NULL THEN N'1' WHEN fldfishId IN (SELECT fldfishId FROM Drd.tblEbtal where fldfishid=tblNaghdi_Talab.fldFishId ) THEN N'3' ELSE N'2'END AS fldStatusFishId
,CASE WHEN fldFishId NOT IN(SELECT tblEbtal.fldFishId FROM Drd.tblEbtal WHERE tblNaghdi_Talab.fldFishId=tblEbtal.fldFishId) then fldFishId
ELSE NULL END AS fldFishId,ISNULL(fldShomareHesabId,0) ,ISNULL((SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldId=fldShomareHesabId),'') AS fldShomareHesab
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhSabt,''
,(SELECT fldTarikh FROM Drd.tblPardakhtFish WHERE tblPardakhtFish.fldFishId=tblNaghdi_Talab.fldFishId) AS TarikhPardakht,0 as fldIsSanad
FROM         Drd.tblNaghdi_Talab)t
WHERE fldBaratDarId LIKE @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid))


if (@fieldname=N'fldTypeSanad')
SELECT TOP(@h)   * FROM (SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ),cast(0 as bigint))AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
                      CAST(0 AS TINYINT)) AS fldStatus, ISNULL(Drd.tblCheck.fldShomareHesabId, 0) AS fldShomareHesabId, 0 AS fldBaratDarId, 
                      CASE WHEN fldTypeSanad = 0 THEN CAST(2 AS TINYINT) ELSE CAST(6 AS TINYINT) END AS fldTypeSanad, '' AS fldMakanPardakht, Drd.tblCheck.fldUserId, 
                      Drd.tblCheck.fldDesc, Drd.tblCheck.fldDate, CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, fldDateStatus, 
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
				,tblCheck.fldTarikhAkhz AS fldTarikhSabt,(SELECT CASE WHEN fldHaghighiId IS NOT NULL THEN (SELECT fldName+'_'+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) 
					WHEN fldHoghoghiId is NOT NULL  THEN (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldid=fldHoghoghiId)END 
					FROM Com.tblAshkhas WHERE fldid=tblShomareHesabeOmoomi.fldAshkhasId)AS fldNameSaderKonandeCheck,'' AS TarikhPardakht
					,isnull(fldFlag,0) as fldIsSanad
FROM         Drd.tblCheck INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId
	outer apply (select  top(1) 1 fldFlag from acc.tblDocumentRecord_Details d inner join acc.tblCase c on c.fldid=fldCaseId where fldCaseTypeId=3 and fldSourceId=tblCheck.fldid)document
					   where fldReplyTaghsitId is not null
UNION ALL
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0,0,CAST(3 AS TINYINT),'',fldUserId, fldDesc, fldDate
,N'سفته' AS fldTypeSanadName, fldDateStatus
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,'','',0,'',0 ,'' fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhSabt,'','' AS TarikhPardakht,0 as fldIsSanad
FROM         Drd.tblSafte

UNION ALL
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT), ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
,N'برات' AS fldTypeSanadName, fldDateStatus
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,'','',0,'',0,com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId)fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhSabt,'','' AS TarikhPardakht,0 as fldIsSanad
FROM         Drd.tblBarat

UNION ALL
SELECT     fldId,'',  ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId,'',ISNULL(cast(fldMablagh as bigint),cast(0 as bigint))AS fldMablagh, CAST(0 AS TINYINT),0,0,CASE WHEN fldType=1 THEN CAST(1 AS TINYINT) WHEN fldType=2 THEN CAST(5 AS TINYINT)  WHEN fldType=3 THEN CAST(7 AS TINYINT) end,'', fldUserId, fldDesc, fldDate
,CASE WHEN fldType=1 THEN N'نقدی' WHEN fldType=2 THEN N'بدهکاری' when fldType=3 then N'بستانکاری' end AS fldTypeSanadName, '' AS fldDateStatus
,'' AS fldStatusName,'','',0,'',0,'' fldNameBaratDar,CASE WHEN fldfishid IS NULL THEN N'فیش صادر نشده' WHEN fldfishId IN (SELECT fldfishId FROM Drd.tblEbtal where fldfishid=tblNaghdi_Talab.fldFishId ) THEN N'فیش ابطال شده' ELSE N'فیش صادر شده'END AS fldStatusFish,
CASE WHEN fldfishid IS NULL THEN N'1' WHEN fldfishId IN (SELECT fldfishId FROM Drd.tblEbtal where fldfishid=tblNaghdi_Talab.fldFishId ) THEN N'3' ELSE N'2'END AS fldStatusFishId
,CASE WHEN fldFishId NOT IN(SELECT tblEbtal.fldFishId FROM Drd.tblEbtal WHERE tblNaghdi_Talab.fldFishId=tblEbtal.fldFishId) then fldFishId
ELSE NULL END AS fldFishId,ISNULL(fldShomareHesabId,0) ,ISNULL((SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldId=fldShomareHesabId),'') AS fldShomareHesab
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhSabt,''
,(SELECT fldTarikh FROM Drd.tblPardakhtFish WHERE tblPardakhtFish.fldFishId=tblNaghdi_Talab.fldFishId) AS TarikhPardakht,0 as fldIsSanad
FROM         Drd.tblNaghdi_Talab)t
WHERE fldReplyTaghsitId=@value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid))


if (@fieldname=N'fldMakanPardakht')
SELECT TOP(@h)   * FROM(SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ),cast(0 as bigint))AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
                      CAST(0 AS TINYINT)) AS fldStatus, ISNULL(Drd.tblCheck.fldShomareHesabId, 0) AS fldShomareHesabId, 0 AS fldBaratDarId, 
                      CASE WHEN fldTypeSanad = 0 THEN CAST(2 AS TINYINT) ELSE CAST(6 AS TINYINT) END AS fldTypeSanad, '' AS fldMakanPardakht, Drd.tblCheck.fldUserId, 
                      Drd.tblCheck.fldDesc, Drd.tblCheck.fldDate, CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, fldDateStatus, 
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
					,tblCheck.fldTarikhAkhz AS fldTarikhSabt	,(SELECT CASE WHEN fldHaghighiId IS NOT NULL THEN (SELECT fldName+'_'+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) 
					WHEN fldHoghoghiId is NOT NULL  THEN (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldid=fldHoghoghiId)END 
					FROM Com.tblAshkhas WHERE fldid=tblShomareHesabeOmoomi.fldAshkhasId)AS fldNameSaderKonandeCheck,'' AS TarikhPardakht
					,isnull(fldFlag,0) as fldIsSanad
FROM         Drd.tblCheck INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId
					 					outer apply (select  top(1) 1 fldFlag from acc.tblDocumentRecord_Details d inner join acc.tblCase c on c.fldid=fldCaseId where fldCaseTypeId=3 and fldSourceId=tblCheck.fldid)document

					   where fldReplyTaghsitId is not null
UNION ALL
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0,0,CAST(3 AS TINYINT),'',fldUserId, fldDesc, fldDate
,N'سفته' AS fldTypeSanadName, fldDateStatus
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,'','',0,'',0 ,'' fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhSabt,'','' AS TarikhPardakht,0 as fldIsSanad
FROM         Drd.tblSafte

UNION ALL
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT), ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
,N'برات' AS fldTypeSanadName, fldDateStatus
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,'','',0,'',0,com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId)fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhSabt,'','' AS TarikhPardakht,0 as fldIsSanad
FROM         Drd.tblBarat

UNION ALL
SELECT     fldId,'',  ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId,'',ISNULL(cast(fldMablagh as bigint),cast(0 as bigint))AS fldMablagh, CAST(0 AS TINYINT),0,0,CASE WHEN fldType=1 THEN CAST(1 AS TINYINT) WHEN fldType=2 THEN CAST(5 AS TINYINT)  WHEN fldType=3 THEN CAST(7 AS TINYINT) end,'', fldUserId, fldDesc, fldDate
,CASE WHEN fldType=1 THEN N'نقدی' WHEN fldType=2 THEN N'بدهکاری' when fldType=3 then N'بستانکاری' end AS fldTypeSanadName, '' AS fldDateStatus
,'' AS fldStatusName,'','',0,'',0,'' fldNameBaratDar,CASE WHEN fldfishid IS NULL THEN N'فیش صادر نشده' WHEN fldfishId IN (SELECT fldfishId FROM Drd.tblEbtal where fldfishid=tblNaghdi_Talab.fldFishId ) THEN N'فیش ابطال شده' ELSE N'فیش صادر شده'END AS fldStatusFish,
CASE WHEN fldfishid IS NULL THEN N'1' WHEN fldfishId IN (SELECT fldfishId FROM Drd.tblEbtal where fldfishid=tblNaghdi_Talab.fldFishId ) THEN N'3' ELSE N'2'END AS fldStatusFishId
,CASE WHEN fldFishId NOT IN(SELECT tblEbtal.fldFishId FROM Drd.tblEbtal WHERE tblNaghdi_Talab.fldFishId=tblEbtal.fldFishId) then fldFishId
ELSE NULL END AS fldFishId,ISNULL(fldShomareHesabId,0) ,ISNULL((SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldId=fldShomareHesabId),'') AS fldShomareHesab
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhSabt,''
,(SELECT fldTarikh FROM Drd.tblPardakhtFish WHERE tblPardakhtFish.fldFishId=tblNaghdi_Talab.fldFishId) AS TarikhPardakht,0 as fldIsSanad
FROM         Drd.tblNaghdi_Talab)t
WHERE fldMakanPardakht LIKE @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid))


if (@fieldname=N'fldTypeSanadName')
SELECT TOP(@h)  * FROM (SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ),cast(0 as bigint))AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
                      CAST(0 AS TINYINT)) AS fldStatus, ISNULL(Drd.tblCheck.fldShomareHesabId, 0) AS fldShomareHesabId, 0 AS fldBaratDarId, 
                      CASE WHEN fldTypeSanad = 0 THEN CAST(2 AS TINYINT) ELSE CAST(6 AS TINYINT) END AS fldTypeSanad, '' AS fldMakanPardakht, Drd.tblCheck.fldUserId, 
                      Drd.tblCheck.fldDesc, Drd.tblCheck.fldDate, CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, fldDateStatus, 
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
				,tblCheck.fldTarikhAkhz AS fldTarikhSabt	,(SELECT CASE WHEN fldHaghighiId IS NOT NULL THEN (SELECT fldName+'_'+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) 
					WHEN fldHoghoghiId is NOT NULL  THEN (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldid=fldHoghoghiId)END 
					FROM Com.tblAshkhas WHERE fldid=tblShomareHesabeOmoomi.fldAshkhasId)AS fldNameSaderKonandeCheck,'' AS TarikhPardakht
					,isnull(fldFlag,0) as fldIsSanad
FROM         Drd.tblCheck INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId
					 					outer apply (select  top(1) 1 fldFlag from acc.tblDocumentRecord_Details d inner join acc.tblCase c on c.fldid=fldCaseId where fldCaseTypeId=3 and fldSourceId=tblCheck.fldid)document

					   where fldReplyTaghsitId is not null

UNION ALL
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0,0,CAST(3 AS TINYINT),'',fldUserId, fldDesc, fldDate
,N'سفته' AS fldTypeSanadName, fldDateStatus
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,'','',0,'',0 ,'' fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhSabt,'','' AS TarikhPardakht,0 as fldIsSanad
FROM         Drd.tblSafte

UNION ALL
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT), ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
,N'برات' AS fldTypeSanadName, fldDateStatus
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,'','',0,'',0,com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId)fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhSabt,'','' AS TarikhPardakht,0 as fldIsSanad
FROM         Drd.tblBarat

UNION ALL
SELECT     fldId,'',  ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId,'',ISNULL(cast(fldMablagh as bigint),cast(0 as bigint))AS fldMablagh, CAST(0 AS TINYINT),0,0,CASE WHEN fldType=1 THEN CAST(1 AS TINYINT) WHEN fldType=2 THEN CAST(5 AS TINYINT)  WHEN fldType=3 THEN CAST(7 AS TINYINT) end,'', fldUserId, fldDesc, fldDate
,CASE WHEN fldType=1 THEN N'نقدی' WHEN fldType=2 THEN N'بدهکاری' when fldType=3 then N'بستانکاری' end AS fldTypeSanadName, '' AS fldDateStatus
,'' AS fldStatusName,'','',0,'',0,'' fldNameBaratDar,CASE WHEN fldfishid IS NULL THEN N'فیش صادر نشده' WHEN fldfishId IN (SELECT fldfishId FROM Drd.tblEbtal where fldfishid=tblNaghdi_Talab.fldFishId ) THEN N'فیش ابطال شده' ELSE N'فیش صادر شده'END AS fldStatusFish,
CASE WHEN fldfishid IS NULL THEN N'1' WHEN fldfishId IN (SELECT fldfishId FROM Drd.tblEbtal where fldfishid=tblNaghdi_Talab.fldFishId ) THEN N'3' ELSE N'2'END AS fldStatusFishId
,CASE WHEN fldFishId NOT IN(SELECT tblEbtal.fldFishId FROM Drd.tblEbtal WHERE tblNaghdi_Talab.fldFishId=tblEbtal.fldFishId) then fldFishId
ELSE NULL END AS fldFishId,ISNULL(fldShomareHesabId,0) ,ISNULL((SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldId=fldShomareHesabId),'') AS fldShomareHesab
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhSabt,''
,(SELECT fldTarikh FROM Drd.tblPardakhtFish WHERE tblPardakhtFish.fldFishId=tblNaghdi_Talab.fldFishId) AS TarikhPardakht,0 as fldIsSanad
FROM         Drd.tblNaghdi_Talab)t
WHERE fldTypeSanadName LIKE @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid))


if (@fieldname=N'fldStatusName')
SELECT TOP(@h)  * FROM (SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ),cast(0 as bigint))AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
                      CAST(0 AS TINYINT)) AS fldStatus, ISNULL(Drd.tblCheck.fldShomareHesabId, 0) AS fldShomareHesabId, 0 AS fldBaratDarId, 
                      CASE WHEN fldTypeSanad = 0 THEN CAST(2 AS TINYINT) ELSE CAST(6 AS TINYINT) END AS fldTypeSanad, '' AS fldMakanPardakht, Drd.tblCheck.fldUserId, 
                      Drd.tblCheck.fldDesc, Drd.tblCheck.fldDate, CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, fldDateStatus, 
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
				,tblCheck.fldTarikhAkhz AS fldTarikhSabt	,(SELECT CASE WHEN fldHaghighiId IS NOT NULL THEN (SELECT fldName+'_'+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) 
					WHEN fldHoghoghiId is NOT NULL  THEN (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldid=fldHoghoghiId)END 
					FROM Com.tblAshkhas WHERE fldid=tblShomareHesabeOmoomi.fldAshkhasId)AS fldNameSaderKonandeCheck,'' AS TarikhPardakht
					,isnull(fldFlag,0) as fldIsSanad
FROM         Drd.tblCheck INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId
										outer apply (select  top(1) 1 fldFlag from acc.tblDocumentRecord_Details d inner join acc.tblCase c on c.fldid=fldCaseId where fldCaseTypeId=3 and fldSourceId=tblCheck.fldid)document

					   where fldReplyTaghsitId is not null
UNION ALL
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0,0,CAST(3 AS TINYINT),'',fldUserId, fldDesc, fldDate
,N'سفته' AS fldTypeSanadName, fldDateStatus
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,'','',0,'',0 ,'' fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhSabt,'','' AS TarikhPardakht,0 as fldIsSanad
FROM         Drd.tblSafte

UNION ALL
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT), ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
,N'برات' AS fldTypeSanadName, fldDateStatus
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,'','',0,'',0,com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId)fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhSabt,'','' AS TarikhPardakht,0 as fldIsSanad
FROM         Drd.tblBarat

UNION ALL
SELECT     fldId,'',  ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId,'',ISNULL(cast(fldMablagh as bigint),cast(0 as bigint))AS fldMablagh, CAST(0 AS TINYINT),0,0,CASE WHEN fldType=1 THEN CAST(1 AS TINYINT) WHEN fldType=2 THEN CAST(5 AS TINYINT)  WHEN fldType=3 THEN CAST(7 AS TINYINT) end,'', fldUserId, fldDesc, fldDate
,CASE WHEN fldType=1 THEN N'نقدی' WHEN fldType=2 THEN N'بدهکاری' when fldType=3 then N'بستانکاری' end AS fldTypeSanadName, '' AS fldDateStatus
,'' AS fldStatusName,'','',0,'',0,'' fldNameBaratDar,CASE WHEN fldfishid IS NULL THEN N'فیش صادر نشده' WHEN fldfishId IN (SELECT fldfishId FROM Drd.tblEbtal where fldfishid=tblNaghdi_Talab.fldFishId ) THEN N'فیش ابطال شده' ELSE N'فیش صادر شده'END AS fldStatusFish,
CASE WHEN fldfishid IS NULL THEN N'1' WHEN fldfishId IN (SELECT fldfishId FROM Drd.tblEbtal where fldfishid=tblNaghdi_Talab.fldFishId ) THEN N'3' ELSE N'2'END AS fldStatusFishId
,CASE WHEN fldFishId NOT IN(SELECT tblEbtal.fldFishId FROM Drd.tblEbtal WHERE tblNaghdi_Talab.fldFishId=tblEbtal.fldFishId) then fldFishId
ELSE NULL END AS fldFishId,ISNULL(fldShomareHesabId,0) ,ISNULL((SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldId=fldShomareHesabId),'') AS fldShomareHesab
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhSabt,''
,(SELECT fldTarikh FROM Drd.tblPardakhtFish WHERE tblPardakhtFish.fldFishId=tblNaghdi_Talab.fldFishId) AS TarikhPardakht,0 as fldIsSanad
FROM         Drd.tblNaghdi_Talab)t
WHERE fldStatusName LIKE @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid))


if (@fieldname=N'fldShomareHesab')
SELECT TOP(@h)   * FROM (SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ),cast(0 as bigint))AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
                      CAST(0 AS TINYINT)) AS fldStatus, ISNULL(Drd.tblCheck.fldShomareHesabId, 0) AS fldShomareHesabId, 0 AS fldBaratDarId, 
                      CASE WHEN fldTypeSanad = 0 THEN CAST(2 AS TINYINT) ELSE CAST(6 AS TINYINT) END AS fldTypeSanad, '' AS fldMakanPardakht, Drd.tblCheck.fldUserId, 
                      Drd.tblCheck.fldDesc, Drd.tblCheck.fldDate, CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, fldDateStatus, 
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
				,tblCheck.fldTarikhAkhz AS fldTarikhSabt	,(SELECT CASE WHEN fldHaghighiId IS NOT NULL THEN (SELECT fldName+'_'+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) 
					WHEN fldHoghoghiId is NOT NULL  THEN (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldid=fldHoghoghiId)END 
					FROM Com.tblAshkhas WHERE fldid=tblShomareHesabeOmoomi.fldAshkhasId)AS fldNameSaderKonandeCheck,'' AS TarikhPardakht

					,isnull(fldFlag,0) as fldIsSanad
FROM         Drd.tblCheck INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId
					outer apply (select top(1) 1 fldFlag from acc.tblDocumentRecord_Details d inner join acc.tblCase c on c.fldid=fldCaseId where fldCaseTypeId=3 and fldSourceId=tblCheck.fldid)document

					   where fldReplyTaghsitId is not null

UNION ALL
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0,0,CAST(3 AS TINYINT),'',fldUserId, fldDesc, fldDate
,N'سفته' AS fldTypeSanadName, fldDateStatus
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,'','',0,'',0 ,'' fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhSabt,'','' AS TarikhPardakht,0 as fldIsSanad
FROM         Drd.tblSafte

UNION ALL
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT), ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
,N'برات' AS fldTypeSanadName, fldDateStatus
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,'','',0,'',0,com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId)fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhSabt,'','' AS TarikhPardakht,0 as fldIsSanad
FROM         Drd.tblBarat

UNION ALL
SELECT     fldId,'',  ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId,'',ISNULL(cast(fldMablagh as bigint),cast(0 as bigint))AS fldMablagh, CAST(0 AS TINYINT),0,0,CASE WHEN fldType=1 THEN CAST(1 AS TINYINT) WHEN fldType=2 THEN CAST(5 AS TINYINT)  WHEN fldType=3 THEN CAST(7 AS TINYINT) end,'', fldUserId, fldDesc, fldDate
,CASE WHEN fldType=1 THEN N'نقدی' WHEN fldType=2 THEN N'بدهکاری' when fldType=3 then N'بستانکاری' end AS fldTypeSanadName, '' AS fldDateStatus
,'' AS fldStatusName,'','',0,'',0,'' fldNameBaratDar,CASE WHEN fldfishid IS NULL THEN N'فیش صادر نشده' WHEN fldfishId IN (SELECT fldfishId FROM Drd.tblEbtal where fldfishid=tblNaghdi_Talab.fldFishId ) THEN N'فیش ابطال شده' ELSE N'فیش صادر شده'END AS fldStatusFish,
CASE WHEN fldfishid IS NULL THEN N'1' WHEN fldfishId IN (SELECT fldfishId FROM Drd.tblEbtal where fldfishid=tblNaghdi_Talab.fldFishId ) THEN N'3' ELSE N'2'END AS fldStatusFishId
,CASE WHEN fldFishId NOT IN(SELECT tblEbtal.fldFishId FROM Drd.tblEbtal WHERE tblNaghdi_Talab.fldFishId=tblEbtal.fldFishId) then fldFishId
ELSE NULL END AS fldFishId,ISNULL(fldShomareHesabId,0) ,ISNULL((SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldId=fldShomareHesabId),'') AS fldShomareHesab
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhSabt,''
,(SELECT fldTarikh FROM Drd.tblPardakhtFish WHERE tblPardakhtFish.fldFishId=tblNaghdi_Talab.fldFishId) AS TarikhPardakht,0 as fldIsSanad
FROM         Drd.tblNaghdi_Talab)t
WHERE fldShomareHesab LIKE @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid))


if (@fieldname=N'fldBankName')
SELECT TOP(@h)   * FROM(SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ),cast(0 as bigint))AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
                      CAST(0 AS TINYINT)) AS fldStatus, ISNULL(Drd.tblCheck.fldShomareHesabId, 0) AS fldShomareHesabId, 0 AS fldBaratDarId, 
                      CASE WHEN fldTypeSanad = 0 THEN CAST(2 AS TINYINT) ELSE CAST(6 AS TINYINT) END AS fldTypeSanad, '' AS fldMakanPardakht, Drd.tblCheck.fldUserId, 
                      Drd.tblCheck.fldDesc, Drd.tblCheck.fldDate, CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, fldDateStatus, 
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
					,tblCheck.fldTarikhAkhz AS fldTarikhSabt	,(SELECT CASE WHEN fldHaghighiId IS NOT NULL THEN (SELECT fldName+'_'+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) 
					WHEN fldHoghoghiId is NOT NULL  THEN (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldid=fldHoghoghiId)END 
					FROM Com.tblAshkhas WHERE fldid=tblShomareHesabeOmoomi.fldAshkhasId)AS fldNameSaderKonandeCheck,'' AS TarikhPardakht
					,isnull(fldFlag,0) as fldIsSanad
FROM         Drd.tblCheck INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId
									outer apply (select  top(1) 1 fldFlag from acc.tblDocumentRecord_Details d inner join acc.tblCase c on c.fldid=fldCaseId where fldCaseTypeId=3 and fldSourceId=tblCheck.fldid)document
	
					   where fldReplyTaghsitId is not null
UNION ALL
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0,0,CAST(3 AS TINYINT),'',fldUserId, fldDesc, fldDate
,N'سفته' AS fldTypeSanadName, fldDateStatus
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,'','',0,'',0 ,'' fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhSabt,'','' AS TarikhPardakht,0 as fldIsSanad
FROM         Drd.tblSafte

UNION ALL
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT), ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
,N'برات' AS fldTypeSanadName, fldDateStatus
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,'','',0,'',0,com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId)fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhSabt,'','' AS TarikhPardakht,0 as fldIsSanad
FROM         Drd.tblBarat

UNION ALL
SELECT     fldId,'',  ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId,'',ISNULL(cast(fldMablagh as bigint),cast(0 as bigint))AS fldMablagh, CAST(0 AS TINYINT),0,0,CASE WHEN fldType=1 THEN CAST(1 AS TINYINT) WHEN fldType=2 THEN CAST(5 AS TINYINT)  WHEN fldType=3 THEN CAST(7 AS TINYINT) end,'', fldUserId, fldDesc, fldDate
,CASE WHEN fldType=1 THEN N'نقدی' WHEN fldType=2 THEN N'بدهکاری' when fldType=3 then N'بستانکاری' end AS fldTypeSanadName, '' AS fldDateStatus
,'' AS fldStatusName,'','',0,'',0,'' fldNameBaratDar,CASE WHEN fldfishid IS NULL THEN N'فیش صادر نشده' WHEN fldfishId IN (SELECT fldfishId FROM Drd.tblEbtal where fldfishid=tblNaghdi_Talab.fldFishId ) THEN N'فیش ابطال شده' ELSE N'فیش صادر شده'END AS fldStatusFish,
CASE WHEN fldfishid IS NULL THEN N'1' WHEN fldfishId IN (SELECT fldfishId FROM Drd.tblEbtal where fldfishid=tblNaghdi_Talab.fldFishId ) THEN N'3' ELSE N'2'END AS fldStatusFishId
,CASE WHEN fldFishId NOT IN(SELECT tblEbtal.fldFishId FROM Drd.tblEbtal WHERE tblNaghdi_Talab.fldFishId=tblEbtal.fldFishId) then fldFishId
ELSE NULL END AS fldFishId,ISNULL(fldShomareHesabId,0) ,ISNULL((SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldId=fldShomareHesabId),'') AS fldShomareHesab
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhSabt,''
,(SELECT fldTarikh FROM Drd.tblPardakhtFish WHERE tblPardakhtFish.fldFishId=tblNaghdi_Talab.fldFishId) AS TarikhPardakht,0 as fldIsSanad
FROM         Drd.tblNaghdi_Talab)t
WHERE fldBankName  LIKE @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid))


if (@fieldname=N'fldNameShobe')
SELECT TOP(@h)   * FROM (SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ),cast(0 as bigint))AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
                      CAST(0 AS TINYINT)) AS fldStatus, ISNULL(Drd.tblCheck.fldShomareHesabId, 0) AS fldShomareHesabId, 0 AS fldBaratDarId, 
                      CASE WHEN fldTypeSanad = 0 THEN CAST(2 AS TINYINT) ELSE CAST(6 AS TINYINT) END AS fldTypeSanad, '' AS fldMakanPardakht, Drd.tblCheck.fldUserId, 
                      Drd.tblCheck.fldDesc, Drd.tblCheck.fldDate, CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, fldDateStatus, 
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
					,tblCheck.fldTarikhAkhz AS fldTarikhSabt	,(SELECT CASE WHEN fldHaghighiId IS NOT NULL THEN (SELECT fldName+'_'+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) 
					WHEN fldHoghoghiId is NOT NULL  THEN (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldid=fldHoghoghiId)END 
					FROM Com.tblAshkhas WHERE fldid=tblShomareHesabeOmoomi.fldAshkhasId)AS fldNameSaderKonandeCheck,'' AS TarikhPardakht
					,isnull(fldFlag,0) as fldIsSanad
FROM         Drd.tblCheck INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId
					 outer apply (select  top(1) 1 fldFlag from acc.tblDocumentRecord_Details d inner join acc.tblCase c on c.fldid=fldCaseId where fldCaseTypeId=3 and fldSourceId=tblCheck.fldid)document
					   where fldReplyTaghsitId is not null
UNION ALL
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0,0,CAST(3 AS TINYINT),'',fldUserId, fldDesc, fldDate
,N'سفته' AS fldTypeSanadName, fldDateStatus
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,'','',0,'',0 ,'' fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhSabt,'','' AS TarikhPardakht,0 as fldIsSanad
FROM         Drd.tblSafte

UNION ALL
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT), ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
,N'برات' AS fldTypeSanadName, fldDateStatus
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,'','',0,'',0,com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId)fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhSabt,'','' AS TarikhPardakht,0 as fldIsSanad
FROM         Drd.tblBarat

UNION ALL
SELECT     fldId,'',  ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId,'',ISNULL(cast(fldMablagh as bigint),cast(0 as bigint))AS fldMablagh, CAST(0 AS TINYINT),0,0,CASE WHEN fldType=1 THEN CAST(1 AS TINYINT) WHEN fldType=2 THEN CAST(5 AS TINYINT)  WHEN fldType=3 THEN CAST(7 AS TINYINT) end,'', fldUserId, fldDesc, fldDate
,CASE WHEN fldType=1 THEN N'نقدی' WHEN fldType=2 THEN N'بدهکاری' when fldType=3 then N'بستانکاری' end AS fldTypeSanadName, '' AS fldDateStatus
,'' AS fldStatusName,'','',0,'',0,'' fldNameBaratDar,CASE WHEN fldfishid IS NULL THEN N'فیش صادر نشده' WHEN fldfishId IN (SELECT fldfishId FROM Drd.tblEbtal where fldfishid=tblNaghdi_Talab.fldFishId ) THEN N'فیش ابطال شده' ELSE N'فیش صادر شده'END AS fldStatusFish,
CASE WHEN fldfishid IS NULL THEN N'1' WHEN fldfishId IN (SELECT fldfishId FROM Drd.tblEbtal where fldfishid=tblNaghdi_Talab.fldFishId ) THEN N'3' ELSE N'2'END AS fldStatusFishId
,CASE WHEN fldFishId NOT IN(SELECT tblEbtal.fldFishId FROM Drd.tblEbtal WHERE tblNaghdi_Talab.fldFishId=tblEbtal.fldFishId) then fldFishId
ELSE NULL END AS fldFishId,ISNULL(fldShomareHesabId,0) ,ISNULL((SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldId=fldShomareHesabId),'') AS fldShomareHesab
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhSabt,''
,(SELECT fldTarikh FROM Drd.tblPardakhtFish WHERE tblPardakhtFish.fldFishId=tblNaghdi_Talab.fldFishId) AS TarikhPardakht,0 as fldIsSanad
FROM         Drd.tblNaghdi_Talab)t
WHERE fldNameShobe LIKE @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid))


if (@fieldname=N'fldBankId')
SELECT TOP(@h) * FROM (SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ),cast(0 as bigint))AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
                      CAST(0 AS TINYINT)) AS fldStatus, ISNULL(Drd.tblCheck.fldShomareHesabId, 0) AS fldShomareHesabId, 0 AS fldBaratDarId, 
                      CASE WHEN fldTypeSanad = 0 THEN CAST(2 AS TINYINT) ELSE CAST(6 AS TINYINT) END AS fldTypeSanad, '' AS fldMakanPardakht, Drd.tblCheck.fldUserId, 
                      Drd.tblCheck.fldDesc, Drd.tblCheck.fldDate, CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, fldDateStatus, 
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
,tblCheck.fldTarikhAkhz AS fldTarikhSabt	,(SELECT CASE WHEN fldHaghighiId IS NOT NULL THEN (SELECT fldName+'_'+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) 
					WHEN fldHoghoghiId is NOT NULL  THEN (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldid=fldHoghoghiId)END 
					FROM Com.tblAshkhas WHERE fldid=tblShomareHesabeOmoomi.fldAshkhasId)AS fldNameSaderKonandeCheck,'' AS TarikhPardakht
					,isnull(fldFlag,0) as fldIsSanad
FROM         Drd.tblCheck INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId
					outer apply (select  top(1) 1 fldFlag from acc.tblDocumentRecord_Details d inner join acc.tblCase c on c.fldid=fldCaseId where fldCaseTypeId=3 and fldSourceId=tblCheck.fldid)document
					   where fldReplyTaghsitId is not null

UNION ALL
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0,0,CAST(3 AS TINYINT),'',fldUserId, fldDesc, fldDate
,N'سفته' AS fldTypeSanadName, fldDateStatus
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,'','',0,'',0 ,'' fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhSabt,'','' AS TarikhPardakht,0 as fldIsSanad
FROM         Drd.tblSafte

UNION ALL
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT), ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
,N'برات' AS fldTypeSanadName, fldDateStatus
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,'','',0,'',0,com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId)fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhSabt,'','' AS TarikhPardakht,0 as fldIsSanad
FROM         Drd.tblBarat

UNION ALL
SELECT     fldId,'',  ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId,'',ISNULL(cast(fldMablagh as bigint),cast(0 as bigint))AS fldMablagh, CAST(0 AS TINYINT),0,0,CASE WHEN fldType=1 THEN CAST(1 AS TINYINT) WHEN fldType=2 THEN CAST(5 AS TINYINT)  WHEN fldType=3 THEN CAST(7 AS TINYINT) end,'', fldUserId, fldDesc, fldDate
,CASE WHEN fldType=1 THEN N'نقدی' WHEN fldType=2 THEN N'بدهکاری' when fldType=3 then N'بستانکاری' end AS fldTypeSanadName, '' AS fldDateStatus
,'' AS fldStatusName,'','',0,'',0,'' fldNameBaratDar,CASE WHEN fldfishid IS NULL THEN N'فیش صادر نشده' WHEN fldfishId IN (SELECT fldfishId FROM Drd.tblEbtal where fldfishid=tblNaghdi_Talab.fldFishId ) THEN N'فیش ابطال شده' ELSE N'فیش صادر شده'END AS fldStatusFish,
CASE WHEN fldfishid IS NULL THEN N'1' WHEN fldfishId IN (SELECT fldfishId FROM Drd.tblEbtal where fldfishid=tblNaghdi_Talab.fldFishId ) THEN N'3' ELSE N'2'END AS fldStatusFishId
,CASE WHEN fldFishId NOT IN(SELECT tblEbtal.fldFishId FROM Drd.tblEbtal WHERE tblNaghdi_Talab.fldFishId=tblEbtal.fldFishId) then fldFishId
ELSE NULL END AS fldFishId,ISNULL(fldShomareHesabId,0) ,ISNULL((SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldId=fldShomareHesabId),'') AS fldShomareHesab
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhSabt,''
,(SELECT fldTarikh FROM Drd.tblPardakhtFish WHERE tblPardakhtFish.fldFishId=tblNaghdi_Talab.fldFishId) AS TarikhPardakht,0 as fldIsSanad
FROM         Drd.tblNaghdi_Talab)t
WHERE fldBankId LIKE @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid))


if (@fieldname=N'fldShobeId')
SELECT TOP(@h)  * FROM (SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ),cast(0 as bigint))AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
                      CAST(0 AS TINYINT)) AS fldStatus, ISNULL(Drd.tblCheck.fldShomareHesabId, 0) AS fldShomareHesabId, 0 AS fldBaratDarId, 
                      CASE WHEN fldTypeSanad = 0 THEN CAST(2 AS TINYINT) ELSE CAST(6 AS TINYINT) END AS fldTypeSanad, '' AS fldMakanPardakht, Drd.tblCheck.fldUserId, 
                      Drd.tblCheck.fldDesc, Drd.tblCheck.fldDate, CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, fldDateStatus, 
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
,tblCheck.fldTarikhAkhz AS fldTarikhSabt	,(SELECT CASE WHEN fldHaghighiId IS NOT NULL THEN (SELECT fldName+'_'+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) 
					WHEN fldHoghoghiId is NOT NULL  THEN (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldid=fldHoghoghiId)END 
					FROM Com.tblAshkhas WHERE fldid=tblShomareHesabeOmoomi.fldAshkhasId)AS fldNameSaderKonandeCheck,'' AS TarikhPardakht
					,isnull(fldFlag,0) as fldIsSanad
FROM         Drd.tblCheck INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId
		outer apply (select  top(1) 1 fldFlag from acc.tblDocumentRecord_Details d inner join acc.tblCase c on c.fldid=fldCaseId where fldCaseTypeId=3 and fldSourceId=tblCheck.fldid)document
					   where fldReplyTaghsitId is not null

UNION ALL
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0,0,CAST(3 AS TINYINT),'',fldUserId, fldDesc, fldDate
,N'سفته' AS fldTypeSanadName, fldDateStatus
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,'','',0,'',0 ,'' fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhSabt,'','' AS TarikhPardakht,0 as fldIsSanad
FROM         Drd.tblSafte

UNION ALL
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT), ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
,N'برات' AS fldTypeSanadName, fldDateStatus
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,'','',0,'',0,com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId)fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhSabt,'','' AS TarikhPardakht,0 as fldIsSanad
FROM         Drd.tblBarat

UNION ALL
SELECT     fldId,'',  ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId,'',ISNULL(cast(fldMablagh as bigint),cast(0 as bigint))AS fldMablagh, CAST(0 AS TINYINT),0,0,CASE WHEN fldType=1 THEN CAST(1 AS TINYINT) WHEN fldType=2 THEN CAST(5 AS TINYINT)  WHEN fldType=3 THEN CAST(7 AS TINYINT) end,'', fldUserId, fldDesc, fldDate
,CASE WHEN fldType=1 THEN N'نقدی' WHEN fldType=2 THEN N'بدهکاری' when fldType=3 then N'بستانکاری' end AS fldTypeSanadName, '' AS fldDateStatus
,'' AS fldStatusName,'','',0,'',0,'' fldNameBaratDar,CASE WHEN fldfishid IS NULL THEN N'فیش صادر نشده' WHEN fldfishId IN (SELECT fldfishId FROM Drd.tblEbtal where fldfishid=tblNaghdi_Talab.fldFishId ) THEN N'فیش ابطال شده' ELSE N'فیش صادر شده'END AS fldStatusFish,
CASE WHEN fldfishid IS NULL THEN N'1' WHEN fldfishId IN (SELECT fldfishId FROM Drd.tblEbtal where fldfishid=tblNaghdi_Talab.fldFishId ) THEN N'3' ELSE N'2'END AS fldStatusFishId
,CASE WHEN fldFishId NOT IN(SELECT tblEbtal.fldFishId FROM Drd.tblEbtal WHERE tblNaghdi_Talab.fldFishId=tblEbtal.fldFishId) then fldFishId
ELSE NULL END AS fldFishId,ISNULL(fldShomareHesabId,0) ,ISNULL((SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldId=fldShomareHesabId),'') AS fldShomareHesab
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhSabt,''
,(SELECT fldTarikh FROM Drd.tblPardakhtFish WHERE tblPardakhtFish.fldFishId=tblNaghdi_Talab.fldFishId) AS TarikhPardakht,0 as fldIsSanad
FROM         Drd.tblNaghdi_Talab)t
WHERE fldShobeId like @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid))


if (@fieldname=N'fldNameBaratDar')
SELECT TOP(@h)  * FROM (SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ),cast(0 as bigint))AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
                      CAST(0 AS TINYINT)) AS fldStatus, ISNULL(Drd.tblCheck.fldShomareHesabId, 0) AS fldShomareHesabId, 0 AS fldBaratDarId, 
                      CASE WHEN fldTypeSanad = 0 THEN CAST(2 AS TINYINT) ELSE CAST(6 AS TINYINT) END AS fldTypeSanad, '' AS fldMakanPardakht, Drd.tblCheck.fldUserId, 
                      Drd.tblCheck.fldDesc, Drd.tblCheck.fldDate, CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, fldDateStatus, 
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
,tblCheck.fldTarikhAkhz AS fldTarikhSabt	,(SELECT CASE WHEN fldHaghighiId IS NOT NULL THEN (SELECT fldName+'_'+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) 
					WHEN fldHoghoghiId is NOT NULL  THEN (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldid=fldHoghoghiId)END 
					FROM Com.tblAshkhas WHERE fldid=tblShomareHesabeOmoomi.fldAshkhasId)AS fldNameSaderKonandeCheck,'' AS TarikhPardakht
					,isnull(fldFlag,0) as fldIsSanad
FROM         Drd.tblCheck INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId
					outer apply (select  top(1) 1 fldFlag from acc.tblDocumentRecord_Details d inner join acc.tblCase c on c.fldid=fldCaseId where fldCaseTypeId=3 and fldSourceId=tblCheck.fldid)document

					   where fldReplyTaghsitId is not null

UNION ALL
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0,0,CAST(3 AS TINYINT),'',fldUserId, fldDesc, fldDate
,N'سفته' AS fldTypeSanadName, fldDateStatus
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,'','',0,'',0 ,'' fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhSabt,'','' AS TarikhPardakht,0 as fldIsSanad
FROM         Drd.tblSafte

UNION ALL
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT), ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
,N'برات' AS fldTypeSanadName, fldDateStatus
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,'','',0,'',0,com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId)fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhSabt,'','' AS TarikhPardakht,0 as fldIsSanad
FROM         Drd.tblBarat

UNION ALL
SELECT     fldId,'',  ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId,'',ISNULL(cast(fldMablagh as bigint),cast(0 as bigint))AS fldMablagh, CAST(0 AS TINYINT),0,0,CASE WHEN fldType=1 THEN CAST(1 AS TINYINT) WHEN fldType=2 THEN CAST(5 AS TINYINT)  WHEN fldType=3 THEN CAST(7 AS TINYINT) end,'', fldUserId, fldDesc, fldDate
,CASE WHEN fldType=1 THEN N'نقدی' WHEN fldType=2 THEN N'بدهکاری' when fldType=3 then N'بستانکاری' end AS fldTypeSanadName, '' AS fldDateStatus
,'' AS fldStatusName,'','',0,'',0,'' fldNameBaratDar,CASE WHEN fldfishid IS NULL THEN N'فیش صادر نشده' WHEN fldfishId IN (SELECT fldfishId FROM Drd.tblEbtal where fldfishid=tblNaghdi_Talab.fldFishId ) THEN N'فیش ابطال شده' ELSE N'فیش صادر شده'END AS fldStatusFish,
CASE WHEN fldfishid IS NULL THEN N'1' WHEN fldfishId IN (SELECT fldfishId FROM Drd.tblEbtal where fldfishid=tblNaghdi_Talab.fldFishId ) THEN N'3' ELSE N'2'END AS fldStatusFishId
,CASE WHEN fldFishId NOT IN(SELECT tblEbtal.fldFishId FROM Drd.tblEbtal WHERE tblNaghdi_Talab.fldFishId=tblEbtal.fldFishId) then fldFishId
ELSE NULL END AS fldFishId,ISNULL(fldShomareHesabId,0) ,ISNULL((SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldId=fldShomareHesabId),'') AS fldShomareHesab
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhSabt,''
,(SELECT fldTarikh FROM Drd.tblPardakhtFish WHERE tblPardakhtFish.fldFishId=tblNaghdi_Talab.fldFishId) AS TarikhPardakht,0 as fldIsSanad
FROM         Drd.tblNaghdi_Talab)t
WHERE fldNameBaratDar like @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid))


if (@fieldname=N'fldStatusFish')
SELECT TOP(@h)   * FROM (SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ),cast(0 as bigint))AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
                      CAST(0 AS TINYINT)) AS fldStatus, ISNULL(Drd.tblCheck.fldShomareHesabId, 0) AS fldShomareHesabId, 0 AS fldBaratDarId, 
                      CASE WHEN fldTypeSanad = 0 THEN CAST(2 AS TINYINT) ELSE CAST(6 AS TINYINT) END AS fldTypeSanad, '' AS fldMakanPardakht, Drd.tblCheck.fldUserId, 
                      Drd.tblCheck.fldDesc, Drd.tblCheck.fldDate, CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, fldDateStatus, 
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
,tblCheck.fldTarikhAkhz AS fldTarikhSabt	,(SELECT CASE WHEN fldHaghighiId IS NOT NULL THEN (SELECT fldName+'_'+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) 
					WHEN fldHoghoghiId is NOT NULL  THEN (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldid=fldHoghoghiId)END 
					FROM Com.tblAshkhas WHERE fldid=tblShomareHesabeOmoomi.fldAshkhasId)AS fldNameSaderKonandeCheck,'' AS TarikhPardakht
					,isnull(fldFlag,0) as fldIsSanad
FROM         Drd.tblCheck INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId
					 outer apply (select  top(1) 1 fldFlag from acc.tblDocumentRecord_Details d inner join acc.tblCase c on c.fldid=fldCaseId where fldCaseTypeId=3 and fldSourceId=tblCheck.fldid)document

					   where fldReplyTaghsitId is not null

UNION ALL
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0,0,CAST(3 AS TINYINT),'',fldUserId, fldDesc, fldDate
,N'سفته' AS fldTypeSanadName, fldDateStatus
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,'','',0,'',0 ,'' fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhSabt,'','' AS TarikhPardakht,0 as fldIsSanad
FROM         Drd.tblSafte

UNION ALL
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT), ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
,N'برات' AS fldTypeSanadName, fldDateStatus
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,'','',0,'',0,com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId)fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhSabt,'','' AS TarikhPardakht,0 as fldIsSanad
FROM         Drd.tblBarat

UNION ALL
SELECT     fldId,'',  ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId,'',ISNULL(cast(fldMablagh as bigint),cast(0 as bigint))AS fldMablagh, CAST(0 AS TINYINT),0,0,CASE WHEN fldType=1 THEN CAST(1 AS TINYINT) WHEN fldType=2 THEN CAST(5 AS TINYINT)  WHEN fldType=3 THEN CAST(7 AS TINYINT) end,'', fldUserId, fldDesc, fldDate
,CASE WHEN fldType=1 THEN N'نقدی' WHEN fldType=2 THEN N'بدهکاری' when fldType=3 then N'بستانکاری' end AS fldTypeSanadName, '' AS fldDateStatus
,'' AS fldStatusName,'','',0,'',0,'' fldNameBaratDar,CASE WHEN fldfishid IS NULL THEN N'فیش صادر نشده' WHEN fldfishId IN (SELECT fldfishId FROM Drd.tblEbtal where fldfishid=tblNaghdi_Talab.fldFishId ) THEN N'فیش ابطال شده' ELSE N'فیش صادر شده'END AS fldStatusFish,
CASE WHEN fldfishid IS NULL THEN N'1' WHEN fldfishId IN (SELECT fldfishId FROM Drd.tblEbtal where fldfishid=tblNaghdi_Talab.fldFishId ) THEN N'3' ELSE N'2'END AS fldStatusFishId
,CASE WHEN fldFishId NOT IN(SELECT tblEbtal.fldFishId FROM Drd.tblEbtal WHERE tblNaghdi_Talab.fldFishId=tblEbtal.fldFishId) then fldFishId
ELSE NULL END AS fldFishId,ISNULL(fldShomareHesabId,0) ,ISNULL((SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldId=fldShomareHesabId),'') AS fldShomareHesab
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhSabt,''
,(SELECT fldTarikh FROM Drd.tblPardakhtFish WHERE tblPardakhtFish.fldFishId=tblNaghdi_Talab.fldFishId) AS TarikhPardakht,0 as fldIsSanad
FROM         Drd.tblNaghdi_Talab)t
WHERE fldStatusFish like @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid))


if (@fieldname=N'fldStatusFishId')
SELECT TOP(@h)  * FROM(SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ),cast(0 as bigint))AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
                      CAST(0 AS TINYINT)) AS fldStatus, ISNULL(Drd.tblCheck.fldShomareHesabId, 0) AS fldShomareHesabId, 0 AS fldBaratDarId, 
                      CASE WHEN fldTypeSanad = 0 THEN CAST(2 AS TINYINT) ELSE CAST(6 AS TINYINT) END AS fldTypeSanad, '' AS fldMakanPardakht, Drd.tblCheck.fldUserId, 
                      Drd.tblCheck.fldDesc, Drd.tblCheck.fldDate, CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, fldDateStatus, 
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
,tblCheck.fldTarikhAkhz AS fldTarikhSabt	,(SELECT CASE WHEN fldHaghighiId IS NOT NULL THEN (SELECT fldName+'_'+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) 
					WHEN fldHoghoghiId is NOT NULL  THEN (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldid=fldHoghoghiId)END 
					FROM Com.tblAshkhas WHERE fldid=tblShomareHesabeOmoomi.fldAshkhasId)AS fldNameSaderKonandeCheck,'' AS TarikhPardakht
					,isnull(fldFlag,0) as fldIsSanad
FROM         Drd.tblCheck INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId
					outer apply (select  top(1) 1 fldFlag from acc.tblDocumentRecord_Details d inner join acc.tblCase c on c.fldid=fldCaseId where fldCaseTypeId=3 and fldSourceId=tblCheck.fldid)document

					   where fldReplyTaghsitId is not null

UNION ALL
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0,0,CAST(3 AS TINYINT),'',fldUserId, fldDesc, fldDate
,N'سفته' AS fldTypeSanadName, fldDateStatus
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,'','',0,'',0 ,'' fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhSabt,'','' AS TarikhPardakht,0 as fldIsSanad
FROM         Drd.tblSafte

UNION ALL
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT), ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
,N'برات' AS fldTypeSanadName, fldDateStatus
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,'','',0,'',0,com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId)fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhSabt,'','' AS TarikhPardakht ,0 as fldIsSanad
FROM         Drd.tblBarat

UNION ALL
SELECT     fldId,'',  ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId,'',ISNULL(cast(fldMablagh as bigint),cast(0 as bigint))AS fldMablagh, CAST(0 AS TINYINT),0,0,CASE WHEN fldType=1 THEN CAST(1 AS TINYINT) WHEN fldType=2 THEN CAST(5 AS TINYINT)  WHEN fldType=3 THEN CAST(7 AS TINYINT) end,'', fldUserId, fldDesc, fldDate
,CASE WHEN fldType=1 THEN N'نقدی' WHEN fldType=2 THEN N'بدهکاری' when fldType=3 then N'بستانکاری' end AS fldTypeSanadName, '' AS fldDateStatus
,'' AS fldStatusName,'','',0,'',0,'' fldNameBaratDar,CASE WHEN fldfishid IS NULL THEN N'فیش صادر نشده' WHEN fldfishId IN (SELECT fldfishId FROM Drd.tblEbtal where fldfishid=tblNaghdi_Talab.fldFishId ) THEN N'فیش ابطال شده' ELSE N'فیش صادر شده'END AS fldStatusFish,
CASE WHEN fldfishid IS NULL THEN N'1' WHEN fldfishId IN (SELECT fldfishId FROM Drd.tblEbtal where fldfishid=tblNaghdi_Talab.fldFishId ) THEN N'3' ELSE N'2'END AS fldStatusFishId
,CASE WHEN fldFishId NOT IN(SELECT tblEbtal.fldFishId FROM Drd.tblEbtal WHERE tblNaghdi_Talab.fldFishId=tblEbtal.fldFishId) then fldFishId
ELSE NULL END AS fldFishId,ISNULL(fldShomareHesabId,0) ,ISNULL((SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldId=fldShomareHesabId),'') AS fldShomareHesab
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhSabt,''
,(SELECT fldTarikh FROM Drd.tblPardakhtFish WHERE tblPardakhtFish.fldFishId=tblNaghdi_Talab.fldFishId) AS TarikhPardakht,0 as fldIsSanad
FROM         Drd.tblNaghdi_Talab)t
WHERE fldStatusFishId like @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid))


if (@fieldname=N'fldFishId')
SELECT TOP(@h)  * FROM (SELECT Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ),cast(0 as bigint))AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
                      CAST(0 AS TINYINT)) AS fldStatus, ISNULL(Drd.tblCheck.fldShomareHesabId, 0) AS fldShomareHesabId, 0 AS fldBaratDarId, 
                      CASE WHEN fldTypeSanad = 0 THEN CAST(2 AS TINYINT) ELSE CAST(6 AS TINYINT) END AS fldTypeSanad, '' AS fldMakanPardakht, Drd.tblCheck.fldUserId, 
                      Drd.tblCheck.fldDesc, Drd.tblCheck.fldDate, CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, fldDateStatus, 
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
,tblCheck.fldTarikhAkhz AS fldTarikhSabt	,(SELECT CASE WHEN fldHaghighiId IS NOT NULL THEN (SELECT fldName+'_'+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) 
					WHEN fldHoghoghiId is NOT NULL  THEN (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldid=fldHoghoghiId)END 
					FROM Com.tblAshkhas WHERE fldid=tblShomareHesabeOmoomi.fldAshkhasId)AS fldNameSaderKonandeCheck,'' AS TarikhPardakht
					,isnull(fldFlag,0) as fldIsSanad
FROM         Drd.tblCheck INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId
					outer apply (select  top(1) 1 fldFlag from acc.tblDocumentRecord_Details d inner join acc.tblCase c on c.fldid=fldCaseId where fldCaseTypeId=3 and fldSourceId=tblCheck.fldid)document

					   where fldReplyTaghsitId is not null

UNION ALL
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0,0,CAST(3 AS TINYINT),'',fldUserId, fldDesc, fldDate
,N'سفته' AS fldTypeSanadName, fldDateStatus
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,'','',0,'',0 ,'' fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhSabt,'','' AS TarikhPardakht,0 as fldIsSanad
FROM         Drd.tblSafte

UNION ALL
SELECT     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT), ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
,N'برات' AS fldTypeSanadName, fldDateStatus
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,'','',0,'',0,com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId)fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhSabt,'','' AS TarikhPardakht,0 as fldIsSanad
FROM         Drd.tblBarat

UNION ALL
SELECT     fldId,'',  ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId,'',ISNULL(cast(fldMablagh as bigint),cast(0 as bigint))AS fldMablagh, CAST(0 AS TINYINT),0,0,CASE WHEN fldType=1 THEN CAST(1 AS TINYINT) WHEN fldType=2 THEN CAST(5 AS TINYINT)  WHEN fldType=3 THEN CAST(7 AS TINYINT) end,'', fldUserId, fldDesc, fldDate
,CASE WHEN fldType=1 THEN N'نقدی' WHEN fldType=2 THEN N'بدهکاری' when fldType=3 then N'بستانکاری' end AS fldTypeSanadName, '' AS fldDateStatus
,'' AS fldStatusName,'','',0,'',0,'' fldNameBaratDar,CASE WHEN fldfishid IS NULL THEN N'فیش صادر نشده' WHEN fldfishId IN (SELECT fldfishId FROM Drd.tblEbtal where fldfishid=tblNaghdi_Talab.fldFishId ) THEN N'فیش ابطال شده' ELSE N'فیش صادر شده'END AS fldStatusFish,
CASE WHEN fldfishid IS NULL THEN N'1' WHEN fldfishId IN (SELECT fldfishId FROM Drd.tblEbtal where fldfishid=tblNaghdi_Talab.fldFishId ) THEN N'3' ELSE N'2'END AS fldStatusFishId
,CASE WHEN fldFishId NOT IN(SELECT tblEbtal.fldFishId FROM Drd.tblEbtal WHERE tblNaghdi_Talab.fldFishId=tblEbtal.fldFishId) then fldFishId
ELSE NULL END AS fldFishId,ISNULL(fldShomareHesabId,0) ,ISNULL((SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldId=fldShomareHesabId),'') AS fldShomareHesab
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhSabt,''
,(SELECT fldTarikh FROM Drd.tblPardakhtFish WHERE tblPardakhtFish.fldFishId=tblNaghdi_Talab.fldFishId) AS TarikhPardakht,0 as fldIsSanad
FROM         Drd.tblNaghdi_Talab)t
WHERE fldFishId like @value  AND fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid))


IF (@fieldname=N'')
SELECT TOP(@h) Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ),cast(0 as bigint))AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
                      CAST(0 AS TINYINT)) AS fldStatus, ISNULL(Drd.tblCheck.fldShomareHesabId, 0) AS fldShomareHesabId, 0 AS fldBaratDarId, 
                      CASE WHEN fldTypeSanad = 0 THEN CAST(2 AS TINYINT) ELSE CAST(6 AS TINYINT) END AS fldTypeSanad, '' AS fldMakanPardakht, Drd.tblCheck.fldUserId, 
                      Drd.tblCheck.fldDesc, Drd.tblCheck.fldDate, CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, fldDateStatus, 
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
,tblCheck.fldTarikhAkhz AS fldTarikhSabt,(SELECT CASE WHEN fldHaghighiId IS NOT NULL THEN (SELECT fldName+'_'+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) 
					WHEN fldHoghoghiId is NOT NULL  THEN (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldid=fldHoghoghiId)END 
					FROM Com.tblAshkhas WHERE fldid=tblShomareHesabeOmoomi.fldAshkhasId)AS fldNameSaderKonandeCheck,'' AS TarikhPardakht
					,isnull(fldFlag,0) as fldIsSanad
FROM         Drd.tblCheck INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId
										outer apply (select  top(1) 1 fldFlag from acc.tblDocumentRecord_Details d inner join acc.tblCase c on c.fldid=fldCaseId where fldCaseTypeId=3 and fldSourceId=tblCheck.fldid)document
 
					   where fldReplyTaghsitId is not null

UNION ALL
SELECT TOP (@h)     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0,0,CAST(3 AS TINYINT),'',fldUserId, fldDesc, fldDate
,N'سفته' AS fldTypeSanadName, fldDateStatus
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,'','',0,'',0 ,'' fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhSabt,'','' AS TarikhPardakht,0 as fldIsSanad
FROM         Drd.tblSafte

UNION ALL

SELECT TOP (@h)     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT), ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
,N'برات' AS fldTypeSanadName, fldDateStatus
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,'','',0,'',0,com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId)fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhSabt,'','' AS TarikhPardakht,0 as fldIsSanad
FROM         Drd.tblBarat

UNION ALL

SELECT TOP (@h)    fldId,'',  ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId,'',ISNULL(cast(fldMablagh as bigint),cast(0 as bigint))AS fldMablagh, CAST(0 AS TINYINT),0,0,CASE WHEN fldType=1 THEN CAST(1 AS TINYINT) WHEN fldType=2 THEN CAST(5 AS TINYINT)  WHEN fldType=3 THEN CAST(7 AS TINYINT) end,'', fldUserId, fldDesc, fldDate
,CASE WHEN fldType=1 THEN N'نقدی' WHEN fldType=2 THEN N'بدهکاری' when fldType=3 then N'بستانکاری' end AS fldTypeSanadName, '' AS fldDateStatus
,'' AS fldStatusName,'','',0,'',0,'' fldNameBaratDar,CASE WHEN fldfishid IS NULL THEN N'فیش صادر نشده' WHEN fldfishId IN (SELECT fldfishId FROM Drd.tblEbtal where fldfishid=tblNaghdi_Talab.fldFishId ) THEN N'فیش ابطال شده' ELSE N'فیش صادر شده'END AS fldStatusFish,
CASE WHEN fldfishid IS NULL THEN N'1' WHEN fldfishId IN (SELECT fldfishId FROM Drd.tblEbtal where fldfishid=tblNaghdi_Talab.fldFishId ) THEN N'3' ELSE N'2'END AS fldStatusFishId
,CASE WHEN fldFishId NOT IN(SELECT tblEbtal.fldFishId FROM Drd.tblEbtal WHERE tblNaghdi_Talab.fldFishId=tblEbtal.fldFishId) then fldFishId
ELSE NULL END AS fldFishId,ISNULL(fldShomareHesabId,0) ,ISNULL((SELECT fldShomareHesab FROM Com.tblShomareHesabeOmoomi WHERE fldId=fldShomareHesabId),'') AS fldShomareHesab
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhSabt,''
,(SELECT fldTarikh FROM Drd.tblPardakhtFish WHERE tblPardakhtFish.fldFishId=tblNaghdi_Talab.fldFishId) AS TarikhPardakht,0 as fldIsSanad
FROM         Drd.tblNaghdi_Talab 
WHERE   fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid))


IF (@fieldname=N'Ejra')
SELECT TOP(@h)* FROM (select Drd.tblCheck.fldId, ISNULL(Drd.tblCheck.fldTarikhSarResid, '') AS fldTarikhSarResid, ISNULL(Drd.tblCheck.fldReplyTaghsitId, 0) AS fldReplyTaghsitId, 
                      ISNULL(Drd.tblCheck.fldShomareSanad, '') AS fldShomareSanad, ISNULL(cast(Drd.tblCheck.fldMablaghSanad as bigint ),cast(0 as bigint))AS fldMablaghSanad, ISNULL(Drd.tblCheck.fldStatus, 
                      CAST(0 AS TINYINT)) AS fldStatus, ISNULL(Drd.tblCheck.fldShomareHesabId, 0) AS fldShomareHesabId, 0 AS fldBaratDarId, 
                      CASE WHEN fldTypeSanad = 0 THEN CAST(2 AS TINYINT) ELSE CAST(6 AS TINYINT) END AS fldTypeSanad, '' AS fldMakanPardakht, Drd.tblCheck.fldUserId, 
                      Drd.tblCheck.fldDesc, Drd.tblCheck.fldDate, CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N'چک ضمانتی' END AS fldTypeSanadName, fldDateStatus, 
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
,tblCheck.fldTarikhAkhz AS fldTarikhSabt	,(SELECT CASE WHEN fldHaghighiId IS NOT NULL THEN (SELECT fldName+'_'+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) 
					WHEN fldHoghoghiId is NOT NULL  THEN (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldid=fldHoghoghiId)END 
					FROM Com.tblAshkhas WHERE fldid=tblShomareHesabeOmoomi.fldAshkhasId)AS fldNameSaderKonandeCheck,'' AS TarikhPardakht
					,isnull(fldFlag,0) as fldIsSanad
FROM         Drd.tblCheck INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblCheck.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId INNER JOIN
                      Com.tblBank ON Com.tblSHobe.fldBankId = Com.tblBank.fldId INNER JOIN
                      Com.tblShomareHesabeOmoomi AS tblShomareHesabeOmoomi_1 ON Drd.tblCheck.fldShomareHesabIdOrgan = tblShomareHesabeOmoomi_1.fldId
					 					outer apply (select  top(1) 1 fldFlag from acc.tblDocumentRecord_Details d inner join acc.tblCase c on c.fldid=fldCaseId where fldCaseTypeId=3 and fldSourceId=tblCheck.fldid)document

					   where fldReplyTaghsitId is not null

UNION ALL
SELECT TOP (@h)     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid,ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'') AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,0)AS fldStatus, 0,0,CAST(3 AS TINYINT),'',fldUserId, fldDesc, fldDate
,N'سفته' AS fldTypeSanadName, fldDateStatus
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,'','',0,'',0 ,'' fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhSabt,'','' AS TarikhPardakht,0 as fldIsSanad
FROM         Drd.tblSafte

UNION ALL

SELECT TOP (@h)     fldId, ISNULL(fldTarikhSarResid,'')AS fldTarikhSarResid, ISNULL(fldReplyTaghsitId,0)AS fldReplyTaghsitId, ISNULL(fldShomareSanad,'')AS fldShomareSanad, ISNULL(cast(fldMablaghSanad as bigint),cast(0 as bigint))AS fldMablaghSanad, ISNULL(fldStatus,CAST(0 AS TINYINT))AS fldStatus,0 ,ISNULL(fldBaratDarId,0)AS fldBaratDarId,CAST(4 AS TINYINT), ISNULL(fldMakanPardakht,'')AS fldMakanPardakht, fldUserId, fldDesc, fldDate
,N'برات' AS fldTypeSanadName, fldDateStatus
,ISNULL((CASE WHEN fldStatus=1 THEN N'در انتظار وصول' WHEN fldStatus=2 THEN N'وصول شده'  WHEN fldStatus=3 THEN N'نکول شده'  WHEN fldStatus=4 THEN N'حقوقی شده' WHEN fldStatus = 5 THEN N'عودت داده شده' END),'') AS fldStatusName
,'','',0,'',0,com.fn_NameAshkhasHaghighi_Hoghoghi(fldBaratDarId)fldNameBaratDar,'',''AS fldStatusFishId,NULL AS fldFishId,0 ,''
,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldName+' '+fldFamily FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldName FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldName
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldCodemeli FROM Com.tblEmployee WHERE fldId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShenaseMelli FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldShenaseMeli
					,ISNULL((SELECT CASE WHEN  fldHaghighiId IS NOT NULL then (SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL then (SELECT fldShomareSabt FROM Com.tblAshkhaseHoghoghi WHERE fldId=fldHoghoghiId) end
					FROM Com.tblAshkhas WHERE fldId IN (SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldid IN (SELECT Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT Drd.tblStatusTaghsit_Takhfif.fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldId IN (SELECT Drd.tblReplyTaghsit.fldStatusId FROM Drd.tblReplyTaghsit WHERE fldid=fldReplyTaghsitId) ) ) )) ,'')AS fldFather_Sabt
,dbo.Fn_AssembelyMiladiToShamsi(fldDate) AS fldTarikhSabt,'','' AS TarikhPardakht,0 as fldIsSanad
FROM         Drd.tblBarat)t
WHERE   fldReplyTaghsitId IN (SELECT fldid FROM Drd.tblReplyTaghsit WHERE fldElamAvarezId IN (SELECT fldid FROM Drd.tblElamAvarez WHERE fldOrganId=@Organid ))
AND fldReplyTaghsitId=@value
GO
