SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


CREATE PROC [Drd].[spr_tblRequestTaghsit_TakhfifSelect(Tahlil2)] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@h int
AS 
	BEGIN TRAN
	if (@h=0) set @h=2147483647
	set @Value=com.fn_TextNormalize(@Value)
	
	if (@fieldname=N'Reply')/*تمامی فیلد های این select متفاوت است*/
SELECT     TOP (@h) Drd.tblRequestTaghsit_Takhfif.fldId, Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId, Drd.tblRequestTaghsit_Takhfif.fldRequestType, 
                      Drd.tblRequestTaghsit_Takhfif.fldEmployeeId, ISNULL(Drd.tblRequestTaghsit_Takhfif.fldAddress,'')fldAddress, ISNULL(Drd.tblRequestTaghsit_Takhfif.fldEmail,'')fldEmail, 
                      ISNULL(Drd.tblRequestTaghsit_Takhfif.fldCodePosti,'')fldCodePosti, Drd.tblRequestTaghsit_Takhfif.fldMobile, Drd.tblRequestTaghsit_Takhfif.fldUserId, Drd.tblRequestTaghsit_Takhfif.fldDesc, 
                      Drd.tblRequestTaghsit_Takhfif.fldDate, CASE WHEN fldRequestType = 1 THEN N'تقسیط' WHEN fldRequestType = 2 THEN N'تخفیف' END AS fldRequestTypeName, 
                      CASE WHEN tblRequestTaghsit_Takhfif.fldid in(SELECT fldRequestTaghsit_TakhfifId FROM drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=tblRequestTaghsit_Takhfif.fldid) THEN N'ابطال' ELSE N'صدور' END AS fldStatusName, 
                      CASE WHEN tblRequestTaghsit_Takhfif.fldid in(SELECT fldRequestTaghsit_TakhfifId FROM  drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=tblRequestTaghsit_Takhfif.fldid) THEN N'2' ELSE N'1' END AS fldStatusId,
                    CASE WHEN fldEmployeeId<> (SELECT CASE  WHEN fldHaghighiId IS NOT NULL THEN fldHaghighiId ELSE fldHoghoghiId end FROM Com.tblAshkhas WHERE fldid IN(SELECT fldAshakhasID FROM Drd.tblElamAvarez WHERE fldId=@Value)) THEN Com.tblEmployee.fldName + ' ' + Com.tblEmployee.fldFamily+'('+N'نماینده'+')' ELSE Com.tblEmployee.fldName + ' ' + Com.tblEmployee.fldFamily end AS fldName_Family
					,fldCodemeli,ISNULL((SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=tblRequestTaghsit_Takhfif.fldEmployeeId),'') AS fldFatherName
						,ISNULL(CAST((drd.Fn_MablaghTakhfif('MablaghKol',fldElamAvarezId))AS bigint),0) AS fldMablaghKoli
						,ISNULL(CASE WHEN fldElamAvarezId IN (SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldTypeRequest=1 AND fldTypeMojavez=1) AND fldElamAvarezId=@Value) AND fldElamAvarezId IN (SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldTypeRequest=2 AND fldTypeMojavez=1) AND fldElamAvarezId=@Value) AND tblRequestTaghsit_Takhfif.fldId NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId) THEN N'4'
						WHEN fldElamAvarezId IN (SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldTypeRequest=1 AND fldTypeMojavez=1) AND fldElamAvarezId=@Value) AND tblRequestTaghsit_Takhfif.fldId NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId)THEN N'3'
						WHEN fldElamAvarezId IN (SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldTypeRequest=2 AND fldTypeMojavez=1) AND fldElamAvarezId=@Value) AND tblRequestTaghsit_Takhfif.fldId NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId)THEN N'2'
						WHEN fldElamAvarezId NOT IN (SELECT fldElamAvarezId FROM Drd.tblRequestTaghsit_Takhfif WHERE fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif))AND tblRequestTaghsit_Takhfif.fldId NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId)THEN N'1' ELSE N'0' END
					    ,'0')AS fldCheckTakhfif_Taghsit
						,CASE WHEN EXISTS (SELECT * FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId AND fldTypeMojavez=1) THEN N'1'
						WHEN EXISTS(SELECT * FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId AND fldTypeMojavez=2) THEN N'2'
						WHEN NOT EXISTS (SELECT * FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId) THEN N'3' END AS fldReplyRequest
					,CASE WHEN EXISTS (SELECT * FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId AND fldTypeMojavez=1) THEN N'توافق'
						WHEN EXISTS(SELECT * FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId AND fldTypeMojavez=2) THEN N'عدم توافق'
						WHEN NOT EXISTS (SELECT * FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId) THEN N'بی پاسخ' END AS fldReplyRequestName
					,ISNULL(CAST(drd.Fn_MablaghTakhfif('MablaghMashmool',fldElamAvarezId) AS BIGINT),0) AS fldMablaghMashmoolKarmozd
				,CAST((SELECT SUM(cast(fldMaliyatValue+fldAvarezValue+(CAST(fldAsliValue AS BIGINT)*fldTedad)as bigint)) FROM Drd.tblCodhayeDaramadiElamAvarez WHERE fldElamAvarezId=Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId AND fldShomareHesabCodeDaramadId IN(SELECT fldid FROM Drd.tblShomareHesabCodeDaramad WHERE fldCodeDaramadId in (SELECT fldId FROM Drd.tblCodhayeDaramd)))AS BIGINT) AS fldMablagh
			/*for hidden*/,CAST((SELECT SUM(cast(fldMaliyatValue+fldAvarezValue+(CAST(fldAsliValue AS BIGINT)*fldTedad)as bigint)) FROM Drd.tblCodhayeDaramadiElamAvarez WHERE fldElamAvarezId=Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId AND fldShomareHesabCodeDaramadId IN(SELECT fldid FROM Drd.tblShomareHesabCodeDaramad WHERE fldCodeDaramadId in (SELECT fldId FROM Drd.tblCodhayeDaramd)))AS BIGINT)-ISNULL((SELECT SUM(CAST(fldTakhfifAsli+fldTakhfifMaliyat+fldTakhfifAvarez AS BIGINT)) FROM Drd.tblMablaghTakhfif WHERE fldType=1 AND tblMablaghTakhfif.fldElamAvarezId=Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId),0) AS fldMablaghWithTakhfifKoli
			,(SELECT SUM(a) FROM ((SELECT (CAST((ISNULL((SELECT fldTakhfifAsli FROM Drd.tblMablaghTakhfif WHERE fldCodeDaramadElamAvarezId=tblCodhayeDaramadiElamAvarez.fldId AND fldtype=1),fldAsliValue)*fldTedad)AS BIGINT))AS a FROM Drd.tblCodhayeDaramadiElamAvarez WHERE tblCodhayeDaramadiElamAvarez.fldElamAvarezId=tblRequestTaghsit_Takhfif.fldElamAvarezId))t) AS MablaghAsli
			,(SELECT SUM(fldTedad) FROM Drd.tblCodhayeDaramadiElamAvarez WHERE tblCodhayeDaramadiElamAvarez.fldElamAvarezId=tblRequestTaghsit_Takhfif.fldElamAvarezId AND fldSharheCodeDaramad <> N'کارمزد تقسیط')AS SumTedad
FROM         Drd.tblRequestTaghsit_Takhfif INNER JOIN
                      Com.tblEmployee ON Drd.tblRequestTaghsit_Takhfif.fldEmployeeId = Com.tblEmployee.fldId
                      WHERE    fldElamAvarezId=@value AND  tblRequestTaghsit_Takhfif.fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId) 
                     -- AND tblRequestTaghsit_Takhfif.fldid NOT IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif  WHERE fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId) 

	
	if (@fieldname=N'fldId')
SELECT     TOP (@h) Drd.tblRequestTaghsit_Takhfif.fldId, Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId, Drd.tblRequestTaghsit_Takhfif.fldRequestType, 
                      Drd.tblRequestTaghsit_Takhfif.fldEmployeeId,ISNULL(Drd.tblRequestTaghsit_Takhfif.fldAddress,'')fldAddress, ISNULL(Drd.tblRequestTaghsit_Takhfif.fldEmail,'')fldEmail, 
                      ISNULL(Drd.tblRequestTaghsit_Takhfif.fldCodePosti,'')fldCodePosti, Drd.tblRequestTaghsit_Takhfif.fldMobile, Drd.tblRequestTaghsit_Takhfif.fldUserId, Drd.tblRequestTaghsit_Takhfif.fldDesc, 
                      Drd.tblRequestTaghsit_Takhfif.fldDate, CASE WHEN fldRequestType = 1 THEN N'تقسیط' WHEN fldRequestType = 2 THEN N'تخفیف' END AS fldRequestTypeName, 
                      CASE WHEN tblRequestTaghsit_Takhfif.fldid in(SELECT fldRequestTaghsit_TakhfifId FROM drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=tblRequestTaghsit_Takhfif.fldid) THEN N'ابطال' ELSE N'صدور' END AS fldStatusName, 
                      CASE WHEN tblRequestTaghsit_Takhfif.fldid in(SELECT fldRequestTaghsit_TakhfifId FROM  drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=tblRequestTaghsit_Takhfif.fldid) THEN N'2' ELSE N'1' END AS fldStatusId,
                       Com.tblEmployee.fldName + ' ' + Com.tblEmployee.fldFamily AS fldName_Family,fldCodemeli,ISNULL((SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=tblRequestTaghsit_Takhfif.fldEmployeeId),'') AS fldFatherName
						,CAST(0 AS bigint) AS fldMablaghKoli,CASE WHEN tblRequestTaghsit_Takhfif.fldid NOT IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId =tblRequestTaghsit_Takhfif.fldId ) THEN N'1'
						WHEN tblRequestTaghsit_Takhfif.fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldTypeRequest=2  AND fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId) AND tblRequestTaghsit_Takhfif.fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId) AND Drd.tblRequestTaghsit_Takhfif.fldid NOT IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldTypeRequest=1 AND fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId)THEN N'2'
						WHEN tblRequestTaghsit_Takhfif.fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldTypeRequest=1  AND fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId) AND tblRequestTaghsit_Takhfif.fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId) AND Drd.tblRequestTaghsit_Takhfif.fldid NOT IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldTypeRequest=2AND fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId)THEN N'3'
						WHEN tblRequestTaghsit_Takhfif.fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldTypeRequest=1  AND fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId) AND tblRequestTaghsit_Takhfif.fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId) AND Drd.tblRequestTaghsit_Takhfif.fldid  IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldTypeRequest=2  AND fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId)THEN N'4'
						ELSE N'0' END  AS fldCheckTakhfif_Taghsit
						,CASE WHEN EXISTS (SELECT * FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId AND fldTypeMojavez=1) THEN N'1'
						WHEN EXISTS(SELECT * FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId AND fldTypeMojavez=2) THEN N'2'
						WHEN NOT EXISTS (SELECT * FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId) THEN N'3' END AS fldReplyRequest
					,CASE WHEN EXISTS (SELECT * FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId AND fldTypeMojavez=1) THEN N'توافق'
						WHEN EXISTS(SELECT * FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId AND fldTypeMojavez=2) THEN N'عدم توافق'
						WHEN NOT EXISTS (SELECT * FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId) THEN N'بی پاسخ' END AS fldReplyRequestName
					,CAST(0 AS bigint)  AS fldMablaghMashmoolKarmozd,CAST(0 AS bigint)  AS fldMablagh
					,CAST(0 AS BIGINT) AS fldMablaghWithTakhfifKoli,CAST(0 AS BIGINT) AS MablaghAsli
					,(SELECT SUM(fldTedad) FROM Drd.tblCodhayeDaramadiElamAvarez WHERE tblCodhayeDaramadiElamAvarez.fldElamAvarezId=tblRequestTaghsit_Takhfif.fldElamAvarezId AND fldSharheCodeDaramad <> N'کارمزد تقسیط')AS SumTedad
FROM         Drd.tblRequestTaghsit_Takhfif INNER JOIN
                      Com.tblEmployee ON Drd.tblRequestTaghsit_Takhfif.fldEmployeeId = Com.tblEmployee.fldId
	WHERE  tblRequestTaghsit_Takhfif.fldId = @Value



	if (@fieldname=N'fldElamAvarezId')
	SELECT     TOP (@h) Drd.tblRequestTaghsit_Takhfif.fldId, Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId, Drd.tblRequestTaghsit_Takhfif.fldRequestType, 
                      Drd.tblRequestTaghsit_Takhfif.fldEmployeeId, ISNULL(Drd.tblRequestTaghsit_Takhfif.fldAddress,'')fldAddress, ISNULL(Drd.tblRequestTaghsit_Takhfif.fldEmail,'')fldEmail, 
                      ISNULL(Drd.tblRequestTaghsit_Takhfif.fldCodePosti,'')fldCodePosti, Drd.tblRequestTaghsit_Takhfif.fldMobile, Drd.tblRequestTaghsit_Takhfif.fldUserId, Drd.tblRequestTaghsit_Takhfif.fldDesc, 
                      Drd.tblRequestTaghsit_Takhfif.fldDate, CASE WHEN fldRequestType = 1 THEN N'تقسیط' WHEN fldRequestType = 2 THEN N'تخفیف' END AS fldRequestTypeName, 
                      CASE WHEN tblRequestTaghsit_Takhfif.fldid in(SELECT fldRequestTaghsit_TakhfifId FROM drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=tblRequestTaghsit_Takhfif.fldid) THEN N'ابطال' ELSE N'صدور' END AS fldStatusName, 
                      CASE WHEN tblRequestTaghsit_Takhfif.fldid in(SELECT fldRequestTaghsit_TakhfifId FROM  drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=tblRequestTaghsit_Takhfif.fldid) THEN N'2' ELSE N'1' END AS fldStatusId,
                       Com.tblEmployee.fldName + ' ' + Com.tblEmployee.fldFamily AS fldName_Family,fldCodemeli,ISNULL((SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=tblRequestTaghsit_Takhfif.fldEmployeeId),'') AS fldFatherName
						,CAST(0 AS bigint)  AS fldMablaghKoli,CASE WHEN tblRequestTaghsit_Takhfif.fldid NOT IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId =tblRequestTaghsit_Takhfif.fldId ) THEN N'1'
						WHEN tblRequestTaghsit_Takhfif.fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldTypeRequest=2  AND fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId) AND tblRequestTaghsit_Takhfif.fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId) AND Drd.tblRequestTaghsit_Takhfif.fldid NOT IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldTypeRequest=1 AND fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId)THEN N'2'
						WHEN tblRequestTaghsit_Takhfif.fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldTypeRequest=1  AND fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId) AND tblRequestTaghsit_Takhfif.fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId) AND Drd.tblRequestTaghsit_Takhfif.fldid NOT IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldTypeRequest=2AND fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId)THEN N'3'
						WHEN tblRequestTaghsit_Takhfif.fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldTypeRequest=1  AND fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId) AND tblRequestTaghsit_Takhfif.fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId) AND Drd.tblRequestTaghsit_Takhfif.fldid  IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldTypeRequest=2  AND fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId)THEN N'4'
						ELSE N'0' END  AS fldCheckTakhfif_Taghsit
						,CASE WHEN EXISTS (SELECT * FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId AND fldTypeMojavez=1) THEN N'1'
						WHEN EXISTS(SELECT * FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId AND fldTypeMojavez=2) THEN N'2'
						WHEN NOT EXISTS (SELECT * FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId) THEN N'3' END AS fldReplyRequest
					,CASE WHEN EXISTS (SELECT * FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId AND fldTypeMojavez=1) THEN N'توافق'
						WHEN EXISTS(SELECT * FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId AND fldTypeMojavez=2) THEN N'عدم توافق'
						WHEN NOT EXISTS (SELECT * FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId) THEN N'بی پاسخ' END AS fldReplyRequestName
					,CAST(0 AS bigint)  AS fldMablaghMashmoolKarmozd,CAST(0 AS bigint)  AS fldMablagh
					,CAST(0 AS BIGINT) AS fldMablaghWithTakhfifKoli,CAST(0 AS BIGINT) AS MablaghAsli
					,(SELECT SUM(fldTedad) FROM Drd.tblCodhayeDaramadiElamAvarez WHERE tblCodhayeDaramadiElamAvarez.fldElamAvarezId=tblRequestTaghsit_Takhfif.fldElamAvarezId AND fldSharheCodeDaramad <> N'کارمزد تقسیط')AS SumTedad
FROM         Drd.tblRequestTaghsit_Takhfif INNER JOIN
                      Com.tblEmployee ON Drd.tblRequestTaghsit_Takhfif.fldEmployeeId = Com.tblEmployee.fldId	
                      WHERE  fldElamAvarezId = @Value
                      

		if (@fieldname=N'fldElamAvarezId_NotEbtal')
	SELECT     TOP (@h) Drd.tblRequestTaghsit_Takhfif.fldId, Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId, Drd.tblRequestTaghsit_Takhfif.fldRequestType, 
                      Drd.tblRequestTaghsit_Takhfif.fldEmployeeId,ISNULL(Drd.tblRequestTaghsit_Takhfif.fldAddress,'')fldAddress, ISNULL(Drd.tblRequestTaghsit_Takhfif.fldEmail,'')fldEmail, 
                      ISNULL(Drd.tblRequestTaghsit_Takhfif.fldCodePosti,'')fldCodePosti, Drd.tblRequestTaghsit_Takhfif.fldMobile, Drd.tblRequestTaghsit_Takhfif.fldUserId, Drd.tblRequestTaghsit_Takhfif.fldDesc, 
                      Drd.tblRequestTaghsit_Takhfif.fldDate, CASE WHEN fldRequestType = 1 THEN N'تقسیط' WHEN fldRequestType = 2 THEN N'تخفیف' END AS fldRequestTypeName, 
                      CASE WHEN tblRequestTaghsit_Takhfif.fldid in(SELECT fldRequestTaghsit_TakhfifId FROM drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=tblRequestTaghsit_Takhfif.fldid) THEN N'ابطال' ELSE N'صدور' END AS fldStatusName, 
                      CASE WHEN tblRequestTaghsit_Takhfif.fldid in(SELECT fldRequestTaghsit_TakhfifId FROM  drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=tblRequestTaghsit_Takhfif.fldid) THEN N'2' ELSE N'1' END AS fldStatusId,
                       Com.tblEmployee.fldName + ' ' + Com.tblEmployee.fldFamily AS fldName_Family,fldCodemeli,ISNULL((SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=tblRequestTaghsit_Takhfif.fldEmployeeId),'') AS fldFatherName
						,CAST(0 AS bigint)  AS fldMablaghKoli,CASE WHEN tblRequestTaghsit_Takhfif.fldid NOT IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId =tblRequestTaghsit_Takhfif.fldId ) THEN N'1'
						WHEN tblRequestTaghsit_Takhfif.fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldTypeRequest=2  AND fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId) AND tblRequestTaghsit_Takhfif.fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId) AND Drd.tblRequestTaghsit_Takhfif.fldid NOT IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldTypeRequest=1 AND fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId)THEN N'2'
						WHEN tblRequestTaghsit_Takhfif.fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldTypeRequest=1  AND fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId) AND tblRequestTaghsit_Takhfif.fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId) AND Drd.tblRequestTaghsit_Takhfif.fldid NOT IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldTypeRequest=2AND fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId)THEN N'3'
						WHEN tblRequestTaghsit_Takhfif.fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldTypeRequest=1  AND fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId) AND tblRequestTaghsit_Takhfif.fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId) AND Drd.tblRequestTaghsit_Takhfif.fldid  IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldTypeRequest=2  AND fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId)THEN N'4'
						ELSE N'0' END  AS fldCheckTakhfif_Taghsit
						,CASE WHEN EXISTS (SELECT * FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId AND fldTypeMojavez=1) THEN N'1'
						WHEN EXISTS(SELECT * FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId AND fldTypeMojavez=2) THEN N'2'
						WHEN NOT EXISTS (SELECT * FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId) THEN N'3' END AS fldReplyRequest
					,CASE WHEN EXISTS (SELECT * FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId AND fldTypeMojavez=1) THEN N'توافق'
						WHEN EXISTS(SELECT * FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId AND fldTypeMojavez=2) THEN N'عدم توافق'
						WHEN NOT EXISTS (SELECT * FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId) THEN N'بی پاسخ' END AS fldReplyRequestName
					,CAST(0 AS bigint)  AS fldMablaghMashmoolKarmozd,CAST(0 AS bigint)  AS fldMablagh
					,CAST(0 AS BIGINT) AS fldMablaghWithTakhfifKoli,CAST(0 AS BIGINT) AS MablaghAsli
					,(SELECT SUM(fldTedad) FROM Drd.tblCodhayeDaramadiElamAvarez WHERE tblCodhayeDaramadiElamAvarez.fldElamAvarezId=tblRequestTaghsit_Takhfif.fldElamAvarezId AND fldSharheCodeDaramad <> N'کارمزد تقسیط')AS SumTedad
FROM         Drd.tblRequestTaghsit_Takhfif INNER JOIN
                      Com.tblEmployee ON Drd.tblRequestTaghsit_Takhfif.fldEmployeeId = Com.tblEmployee.fldId
                     	WHERE  fldElamAvarezId = @value and tblRequestTaghsit_Takhfif.fldid not in(SELECT fldRequestTaghsit_TakhfifId FROM drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=tblRequestTaghsit_Takhfif.fldid )
					--	AND tblRequestTaghsit_Takhfif.fldid NOT IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldTypeMojavez=2 AND fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId)
		
		if (@fieldname=N'fldElamAvarezId_Report')
	SELECT     TOP (@h) Drd.tblRequestTaghsit_Takhfif.fldId, Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId, Drd.tblRequestTaghsit_Takhfif.fldRequestType, 
                      Drd.tblRequestTaghsit_Takhfif.fldEmployeeId,ISNULL(Drd.tblRequestTaghsit_Takhfif.fldAddress,'')fldAddress, ISNULL(Drd.tblRequestTaghsit_Takhfif.fldEmail,'')fldEmail, 
                      ISNULL(Drd.tblRequestTaghsit_Takhfif.fldCodePosti,'')fldCodePosti, Drd.tblRequestTaghsit_Takhfif.fldMobile, Drd.tblRequestTaghsit_Takhfif.fldUserId, Drd.tblRequestTaghsit_Takhfif.fldDesc, 
                      Drd.tblRequestTaghsit_Takhfif.fldDate, CASE WHEN fldRequestType = 1 THEN N'تقسیط' WHEN fldRequestType = 2 THEN N'تخفیف' END AS fldRequestTypeName, 
                      CASE WHEN tblRequestTaghsit_Takhfif.fldid in(SELECT fldRequestTaghsit_TakhfifId FROM drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=tblRequestTaghsit_Takhfif.fldid) THEN N'ابطال' ELSE N'صدور' END AS fldStatusName, 
                      CASE WHEN tblRequestTaghsit_Takhfif.fldid in(SELECT fldRequestTaghsit_TakhfifId FROM  drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=tblRequestTaghsit_Takhfif.fldid) THEN N'2' ELSE N'1' END AS fldStatusId,
                       Com.tblEmployee.fldName + ' ' + Com.tblEmployee.fldFamily AS fldName_Family,fldCodemeli,ISNULL((SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=tblRequestTaghsit_Takhfif.fldEmployeeId),'') AS fldFatherName
						,CAST(0 AS bigint)  AS fldMablaghKoli,CASE WHEN tblRequestTaghsit_Takhfif.fldid NOT IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId =tblRequestTaghsit_Takhfif.fldId ) THEN N'1'
						WHEN tblRequestTaghsit_Takhfif.fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldTypeRequest=2  AND fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId) AND tblRequestTaghsit_Takhfif.fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId) AND Drd.tblRequestTaghsit_Takhfif.fldid NOT IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldTypeRequest=1 AND fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId)THEN N'2'
						WHEN tblRequestTaghsit_Takhfif.fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldTypeRequest=1  AND fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId) AND tblRequestTaghsit_Takhfif.fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId) AND Drd.tblRequestTaghsit_Takhfif.fldid NOT IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldTypeRequest=2AND fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId)THEN N'3'
						WHEN tblRequestTaghsit_Takhfif.fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldTypeRequest=1  AND fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId) AND tblRequestTaghsit_Takhfif.fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId) AND Drd.tblRequestTaghsit_Takhfif.fldid  IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldTypeRequest=2  AND fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId)THEN N'4'
						ELSE N'0' END  AS fldCheckTakhfif_Taghsit
						,CASE WHEN EXISTS (SELECT * FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId AND fldTypeMojavez=1) THEN N'1'
						WHEN EXISTS(SELECT * FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId AND fldTypeMojavez=2) THEN N'2'
						WHEN NOT EXISTS (SELECT * FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId) THEN N'3' END AS fldReplyRequest
					,CASE WHEN EXISTS (SELECT * FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId AND fldTypeMojavez=1) THEN N'توافق'
						WHEN EXISTS(SELECT * FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId AND fldTypeMojavez=2) THEN N'عدم توافق'
						WHEN NOT EXISTS (SELECT * FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId) THEN N'بی پاسخ' END AS fldReplyRequestName
					,CAST(0 AS bigint)  AS fldMablaghMashmoolKarmozd,CAST(0 AS bigint)  AS fldMablagh
					,CAST(0 AS BIGINT) AS fldMablaghWithTakhfifKoli,CAST(0 AS BIGINT) AS MablaghAsli
					,(SELECT SUM(fldTedad) FROM Drd.tblCodhayeDaramadiElamAvarez WHERE tblCodhayeDaramadiElamAvarez.fldElamAvarezId=tblRequestTaghsit_Takhfif.fldElamAvarezId AND fldSharheCodeDaramad <> N'کارمزد تقسیط')AS SumTedad
FROM         Drd.tblRequestTaghsit_Takhfif INNER JOIN
                      Com.tblEmployee ON Drd.tblRequestTaghsit_Takhfif.fldEmployeeId = Com.tblEmployee.fldId
                     	WHERE  fldElamAvarezId = @value and tblRequestTaghsit_Takhfif.fldid not in(SELECT fldRequestTaghsit_TakhfifId FROM drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=tblRequestTaghsit_Takhfif.fldid )
						AND fldRequestType=1
		
						
	if (@fieldname=N'fldEmployeeId')
SELECT     TOP (@h) Drd.tblRequestTaghsit_Takhfif.fldId, Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId, Drd.tblRequestTaghsit_Takhfif.fldRequestType, 
                      Drd.tblRequestTaghsit_Takhfif.fldEmployeeId,ISNULL(Drd.tblRequestTaghsit_Takhfif.fldAddress,'')fldAddress, ISNULL(Drd.tblRequestTaghsit_Takhfif.fldEmail,'')fldEmail, 
                      ISNULL(Drd.tblRequestTaghsit_Takhfif.fldCodePosti,'')fldCodePosti, Drd.tblRequestTaghsit_Takhfif.fldMobile, Drd.tblRequestTaghsit_Takhfif.fldUserId, Drd.tblRequestTaghsit_Takhfif.fldDesc, 
                      Drd.tblRequestTaghsit_Takhfif.fldDate, CASE WHEN fldRequestType = 1 THEN N'تقسیط' WHEN fldRequestType = 2 THEN N'تخفیف' END AS fldRequestTypeName, 
                      CASE WHEN tblRequestTaghsit_Takhfif.fldid in(SELECT fldRequestTaghsit_TakhfifId FROM drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=tblRequestTaghsit_Takhfif.fldid) THEN N'ابطال' ELSE N'صدور' END AS fldStatusName, 
                      CASE WHEN tblRequestTaghsit_Takhfif.fldid in(SELECT fldRequestTaghsit_TakhfifId FROM  drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=tblRequestTaghsit_Takhfif.fldid) THEN N'2' ELSE N'1' END AS fldStatusId,
                       Com.tblEmployee.fldName + ' ' + Com.tblEmployee.fldFamily AS fldName_Family,fldCodemeli,ISNULL((SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=tblRequestTaghsit_Takhfif.fldEmployeeId),'') AS fldFatherName
						,CAST(0 AS bigint)  AS fldMablaghKoli,CASE WHEN tblRequestTaghsit_Takhfif.fldid NOT IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId =tblRequestTaghsit_Takhfif.fldId ) THEN N'1'
						WHEN tblRequestTaghsit_Takhfif.fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldTypeRequest=2  AND fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId) AND tblRequestTaghsit_Takhfif.fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId) AND Drd.tblRequestTaghsit_Takhfif.fldid NOT IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldTypeRequest=1 AND fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId)THEN N'2'
						WHEN tblRequestTaghsit_Takhfif.fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldTypeRequest=1  AND fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId) AND tblRequestTaghsit_Takhfif.fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId) AND Drd.tblRequestTaghsit_Takhfif.fldid NOT IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldTypeRequest=2AND fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId)THEN N'3'
						WHEN tblRequestTaghsit_Takhfif.fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldTypeRequest=1  AND fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId) AND tblRequestTaghsit_Takhfif.fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId) AND Drd.tblRequestTaghsit_Takhfif.fldid  IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldTypeRequest=2  AND fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId)THEN N'4'
						ELSE N'0' END  AS fldCheckTakhfif_Taghsit
						,CASE WHEN EXISTS (SELECT * FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId AND fldTypeMojavez=1) THEN N'1'
						WHEN EXISTS(SELECT * FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId AND fldTypeMojavez=2) THEN N'2'
						WHEN NOT EXISTS (SELECT * FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId) THEN N'3' END AS fldReplyRequest
					,CASE WHEN EXISTS (SELECT * FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId AND fldTypeMojavez=1) THEN N'توافق'
						WHEN EXISTS(SELECT * FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId AND fldTypeMojavez=2) THEN N'عدم توافق'
						WHEN NOT EXISTS (SELECT * FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId) THEN N'بی پاسخ' END AS fldReplyRequestName
					,CAST(0 AS bigint)  AS fldMablaghMashmoolKarmozd,CAST(0 AS bigint)  AS fldMablagh
					,CAST(0 AS BIGINT)AS fldMablaghWithTakhfifKoli,CAST(0 AS BIGINT) AS MablaghAsli
					,(SELECT SUM(fldTedad) FROM Drd.tblCodhayeDaramadiElamAvarez WHERE tblCodhayeDaramadiElamAvarez.fldElamAvarezId=tblRequestTaghsit_Takhfif.fldElamAvarezId AND fldSharheCodeDaramad <> N'کارمزد تقسیط')AS SumTedad
FROM         Drd.tblRequestTaghsit_Takhfif INNER JOIN
                      Com.tblEmployee ON Drd.tblRequestTaghsit_Takhfif.fldEmployeeId = Com.tblEmployee.fldId
	WHERE  fldEmployeeId = @Value

	
	if (@fieldname=N'fldDesc')
SELECT     TOP (@h) Drd.tblRequestTaghsit_Takhfif.fldId, Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId, Drd.tblRequestTaghsit_Takhfif.fldRequestType, 
                      Drd.tblRequestTaghsit_Takhfif.fldEmployeeId, ISNULL(Drd.tblRequestTaghsit_Takhfif.fldAddress,'')fldAddress, ISNULL(Drd.tblRequestTaghsit_Takhfif.fldEmail,'')fldEmail, 
                      ISNULL(Drd.tblRequestTaghsit_Takhfif.fldCodePosti,'')fldCodePosti, Drd.tblRequestTaghsit_Takhfif.fldMobile, Drd.tblRequestTaghsit_Takhfif.fldUserId, Drd.tblRequestTaghsit_Takhfif.fldDesc, 
                      Drd.tblRequestTaghsit_Takhfif.fldDate, CASE WHEN fldRequestType = 1 THEN N'تقسیط' WHEN fldRequestType = 2 THEN N'تخفیف' END AS fldRequestTypeName, 
                      CASE WHEN tblRequestTaghsit_Takhfif.fldid in(SELECT fldRequestTaghsit_TakhfifId FROM drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=tblRequestTaghsit_Takhfif.fldid) THEN N'ابطال' ELSE N'صدور' END AS fldStatusName, 
                      CASE WHEN tblRequestTaghsit_Takhfif.fldid in(SELECT fldRequestTaghsit_TakhfifId FROM  drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=tblRequestTaghsit_Takhfif.fldid) THEN N'2' ELSE N'1' END AS fldStatusId,
                       Com.tblEmployee.fldName + ' ' + Com.tblEmployee.fldFamily AS fldName_Family,fldCodemeli,ISNULL((SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=tblRequestTaghsit_Takhfif.fldEmployeeId),'') AS fldFatherName
						,CAST(0 AS bigint)  AS fldMablaghKoli,CASE WHEN tblRequestTaghsit_Takhfif.fldid NOT IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId =tblRequestTaghsit_Takhfif.fldId ) THEN N'1'
						WHEN tblRequestTaghsit_Takhfif.fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldTypeRequest=2  AND fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId) AND tblRequestTaghsit_Takhfif.fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId) AND Drd.tblRequestTaghsit_Takhfif.fldid NOT IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldTypeRequest=1 AND fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId)THEN N'2'
						WHEN tblRequestTaghsit_Takhfif.fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldTypeRequest=1  AND fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId) AND tblRequestTaghsit_Takhfif.fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId) AND Drd.tblRequestTaghsit_Takhfif.fldid NOT IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldTypeRequest=2AND fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId)THEN N'3'
						WHEN tblRequestTaghsit_Takhfif.fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldTypeRequest=1  AND fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId) AND tblRequestTaghsit_Takhfif.fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId) AND Drd.tblRequestTaghsit_Takhfif.fldid  IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldTypeRequest=2  AND fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId)THEN N'4'
						ELSE N'0' END  AS fldCheckTakhfif_Taghsit
						,CASE WHEN EXISTS (SELECT * FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId AND fldTypeMojavez=1) THEN N'1'
						WHEN EXISTS(SELECT * FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId AND fldTypeMojavez=2) THEN N'2'
						WHEN NOT EXISTS (SELECT * FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId) THEN N'3' END AS fldReplyRequest
					,CASE WHEN EXISTS (SELECT * FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId AND fldTypeMojavez=1) THEN N'توافق'
						WHEN EXISTS(SELECT * FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId AND fldTypeMojavez=2) THEN N'عدم توافق'
						WHEN NOT EXISTS (SELECT * FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId) THEN N'بی پاسخ' END AS fldReplyRequestName
					,CAST(0 AS bigint)  AS fldMablaghMashmoolKarmozd,CAST(0 AS bigint)  AS fldMablagh
					,CAST(0 AS BIGINT) AS fldMablaghWithTakhfifKoli,CAST(0 AS BIGINT) AS MablaghAsli
					,(SELECT SUM(fldTedad) FROM Drd.tblCodhayeDaramadiElamAvarez WHERE tblCodhayeDaramadiElamAvarez.fldElamAvarezId=tblRequestTaghsit_Takhfif.fldElamAvarezId AND fldSharheCodeDaramad <> N'کارمزد تقسیط')AS SumTedad
FROM         Drd.tblRequestTaghsit_Takhfif INNER JOIN
                      Com.tblEmployee ON Drd.tblRequestTaghsit_Takhfif.fldEmployeeId = Com.tblEmployee.fldId
	WHERE  Drd.tblRequestTaghsit_Takhfif.fldDesc like @Value
	
	
	
	IF (@fieldname=N'Takhfif')
SELECT     TOP (1) Drd.tblRequestTaghsit_Takhfif.fldId, Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId, Drd.tblRequestTaghsit_Takhfif.fldRequestType, 
                      Drd.tblRequestTaghsit_Takhfif.fldEmployeeId,ISNULL(Drd.tblRequestTaghsit_Takhfif.fldAddress,'')fldAddress, ISNULL(Drd.tblRequestTaghsit_Takhfif.fldEmail,'')fldEmail, 
                      ISNULL(Drd.tblRequestTaghsit_Takhfif.fldCodePosti,'')fldCodePosti, Drd.tblRequestTaghsit_Takhfif.fldMobile, Drd.tblRequestTaghsit_Takhfif.fldUserId, Drd.tblRequestTaghsit_Takhfif.fldDesc, 
                      Drd.tblRequestTaghsit_Takhfif.fldDate, CASE WHEN fldRequestType = 1 THEN N'تقسیط' WHEN fldRequestType = 2 THEN N'تخفیف' END AS fldRequestTypeName, 
                      CASE WHEN tblRequestTaghsit_Takhfif.fldid in(SELECT fldRequestTaghsit_TakhfifId FROM drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=tblRequestTaghsit_Takhfif.fldid) THEN N'ابطال' ELSE N'صدور' END AS fldStatusName, 
                      CASE WHEN tblRequestTaghsit_Takhfif.fldid in(SELECT fldRequestTaghsit_TakhfifId FROM  drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=tblRequestTaghsit_Takhfif.fldid) THEN N'2' ELSE N'1' END AS fldStatusId,
                       Com.tblEmployee.fldName + ' ' + Com.tblEmployee.fldFamily AS fldName_Family,fldCodemeli,ISNULL((SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=tblRequestTaghsit_Takhfif.fldEmployeeId),'') AS fldFatherName
						,CAST(0 AS bigint)  AS fldMablaghKoli,CASE WHEN tblRequestTaghsit_Takhfif.fldid NOT IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId =tblRequestTaghsit_Takhfif.fldId ) THEN N'1'
						WHEN tblRequestTaghsit_Takhfif.fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldTypeRequest=2  AND fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId) AND tblRequestTaghsit_Takhfif.fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId) AND Drd.tblRequestTaghsit_Takhfif.fldid NOT IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldTypeRequest=1 AND fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId)THEN N'2'
						WHEN tblRequestTaghsit_Takhfif.fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldTypeRequest=1  AND fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId) AND tblRequestTaghsit_Takhfif.fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId) AND Drd.tblRequestTaghsit_Takhfif.fldid NOT IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldTypeRequest=2AND fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId)THEN N'3'
						WHEN tblRequestTaghsit_Takhfif.fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldTypeRequest=1  AND fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId) AND tblRequestTaghsit_Takhfif.fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId) AND Drd.tblRequestTaghsit_Takhfif.fldid  IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldTypeRequest=2  AND fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId)THEN N'4'
						END  AS fldCheckTakhfif_Taghsit
						,CASE WHEN EXISTS (SELECT * FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId AND fldTypeMojavez=1) THEN N'1'
						WHEN EXISTS(SELECT * FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId AND fldTypeMojavez=2) THEN N'2'
						WHEN NOT EXISTS (SELECT * FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId) THEN N'3' END AS fldReplyRequest
					,CASE WHEN EXISTS (SELECT * FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId AND fldTypeMojavez=1) THEN N'توافق'
						WHEN EXISTS(SELECT * FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId AND fldTypeMojavez=2) THEN N'عدم توافق'
						WHEN NOT EXISTS (SELECT * FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId) THEN N'بی پاسخ' END AS fldReplyRequestName
						,CAST(0 AS bigint)  AS fldMablaghMashmoolKarmozd,CAST(0 AS bigint)  AS fldMablagh
						,CAST(0 AS BIGINT) AS fldMablaghWithTakhfifKoli,CAST(0 AS BIGINT) AS MablaghAsli
						,(SELECT SUM(fldTedad) FROM Drd.tblCodhayeDaramadiElamAvarez WHERE tblCodhayeDaramadiElamAvarez.fldElamAvarezId=tblRequestTaghsit_Takhfif.fldElamAvarezId AND fldSharheCodeDaramad <> N'کارمزد تقسیط')AS SumTedad
FROM         Drd.tblRequestTaghsit_Takhfif INNER JOIN
                      Com.tblEmployee ON Drd.tblRequestTaghsit_Takhfif.fldEmployeeId = Com.tblEmployee.fldId
                      WHERE fldElamAvarezId=@Value AND fldRequestType=2 AND tblRequestTaghsit_Takhfif.fldId NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=tblRequestTaghsit_Takhfif.fldId)
                      ORDER BY tblRequestTaghsit_Takhfif.fldId desc
	
	IF (@fieldname=N'Taghsit')
SELECT     TOP (1) Drd.tblRequestTaghsit_Takhfif.fldId, Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId, Drd.tblRequestTaghsit_Takhfif.fldRequestType, 
                      Drd.tblRequestTaghsit_Takhfif.fldEmployeeId,ISNULL(Drd.tblRequestTaghsit_Takhfif.fldAddress,'')fldAddress, ISNULL(Drd.tblRequestTaghsit_Takhfif.fldEmail,'')fldEmail, 
                      ISNULL(Drd.tblRequestTaghsit_Takhfif.fldCodePosti,'')fldCodePosti, Drd.tblRequestTaghsit_Takhfif.fldMobile, Drd.tblRequestTaghsit_Takhfif.fldUserId, Drd.tblRequestTaghsit_Takhfif.fldDesc, 
                      Drd.tblRequestTaghsit_Takhfif.fldDate, CASE WHEN fldRequestType = 1 THEN N'تقسیط' WHEN fldRequestType = 2 THEN N'تخفیف' END AS fldRequestTypeName, 
                      CASE WHEN tblRequestTaghsit_Takhfif.fldid in(SELECT fldRequestTaghsit_TakhfifId FROM drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=tblRequestTaghsit_Takhfif.fldid) THEN N'ابطال' ELSE N'صدور' END AS fldStatusName, 
                      CASE WHEN tblRequestTaghsit_Takhfif.fldid in(SELECT fldRequestTaghsit_TakhfifId FROM  drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=tblRequestTaghsit_Takhfif.fldid) THEN N'2' ELSE N'1' END AS fldStatusId,
                       Com.tblEmployee.fldName + ' ' + Com.tblEmployee.fldFamily AS fldName_Family,fldCodemeli,ISNULL((SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=tblRequestTaghsit_Takhfif.fldEmployeeId),'') AS fldFatherName
						,CAST(0 AS bigint)  AS fldMablaghKoli,CASE WHEN tblRequestTaghsit_Takhfif.fldid NOT IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId =tblRequestTaghsit_Takhfif.fldId ) THEN N'1'
						WHEN tblRequestTaghsit_Takhfif.fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldTypeRequest=2  AND fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId) AND tblRequestTaghsit_Takhfif.fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId) AND Drd.tblRequestTaghsit_Takhfif.fldid NOT IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldTypeRequest=1 AND fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId)THEN N'2'
						WHEN tblRequestTaghsit_Takhfif.fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldTypeRequest=1  AND fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId) AND tblRequestTaghsit_Takhfif.fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId) AND Drd.tblRequestTaghsit_Takhfif.fldid NOT IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldTypeRequest=2AND fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId)THEN N'3'
						WHEN tblRequestTaghsit_Takhfif.fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldTypeRequest=1  AND fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId) AND tblRequestTaghsit_Takhfif.fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId) AND Drd.tblRequestTaghsit_Takhfif.fldid  IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldTypeRequest=2  AND fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId)THEN N'4'
						END  AS fldCheckTakhfif_Taghsit
						,CASE WHEN EXISTS (SELECT * FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId AND fldTypeMojavez=1) THEN N'1'
						WHEN EXISTS(SELECT * FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId AND fldTypeMojavez=2) THEN N'2'
						WHEN NOT EXISTS (SELECT * FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId) THEN N'3' END AS fldReplyRequest
					,CASE WHEN EXISTS (SELECT * FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId AND fldTypeMojavez=1) THEN N'توافق'
						WHEN EXISTS(SELECT * FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId AND fldTypeMojavez=2) THEN N'عدم توافق'
						WHEN NOT EXISTS (SELECT * FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId) THEN N'بی پاسخ' END AS fldReplyRequestName
						,CAST(0 AS bigint)  AS fldMablaghMashmoolKarmozd,CAST(0 AS bigint)  AS fldMablagh
						,CAST(0 AS BIGINT) AS fldMablaghWithTakhfifKoli,CAST(0 AS BIGINT) AS MablaghAsli
						,(SELECT SUM(fldTedad) FROM Drd.tblCodhayeDaramadiElamAvarez WHERE tblCodhayeDaramadiElamAvarez.fldElamAvarezId=tblRequestTaghsit_Takhfif.fldElamAvarezId AND fldSharheCodeDaramad <> N'کارمزد تقسیط')AS SumTedad
FROM         Drd.tblRequestTaghsit_Takhfif INNER JOIN
                      Com.tblEmployee ON Drd.tblRequestTaghsit_Takhfif.fldEmployeeId = Com.tblEmployee.fldId
                      WHERE fldElamAvarezId=@Value AND fldRequestType=1 AND tblRequestTaghsit_Takhfif.fldId NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=tblRequestTaghsit_Takhfif.fldId)
                      ORDER BY tblRequestTaghsit_Takhfif.fldId desc


	IF (@fieldname=N'')
SELECT     TOP (@h) Drd.tblRequestTaghsit_Takhfif.fldId, Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId, Drd.tblRequestTaghsit_Takhfif.fldRequestType, 
                      Drd.tblRequestTaghsit_Takhfif.fldEmployeeId,ISNULL(Drd.tblRequestTaghsit_Takhfif.fldAddress,'')fldAddress, ISNULL(Drd.tblRequestTaghsit_Takhfif.fldEmail,'')fldEmail, 
                      ISNULL(Drd.tblRequestTaghsit_Takhfif.fldCodePosti,'')fldCodePosti, Drd.tblRequestTaghsit_Takhfif.fldMobile, Drd.tblRequestTaghsit_Takhfif.fldUserId, Drd.tblRequestTaghsit_Takhfif.fldDesc, 
                      Drd.tblRequestTaghsit_Takhfif.fldDate, CASE WHEN fldRequestType = 1 THEN N'تقسیط' WHEN fldRequestType = 2 THEN N'تخفیف' END AS fldRequestTypeName, 
                      CASE WHEN tblRequestTaghsit_Takhfif.fldid in(SELECT fldRequestTaghsit_TakhfifId FROM drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=tblRequestTaghsit_Takhfif.fldid) THEN N'ابطال' ELSE N'صدور' END AS fldStatusName, 
                      CASE WHEN tblRequestTaghsit_Takhfif.fldid in(SELECT fldRequestTaghsit_TakhfifId FROM  drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=tblRequestTaghsit_Takhfif.fldid) THEN N'2' ELSE N'1' END AS fldStatusId,
                       Com.tblEmployee.fldName + ' ' + Com.tblEmployee.fldFamily AS fldName_Family,fldCodemeli,ISNULL((SELECT fldFatherName FROM Com.tblEmployee_Detail WHERE fldEmployeeId=tblRequestTaghsit_Takhfif.fldEmployeeId),'') AS fldFatherName
						,CAST(0 AS bigint)  AS fldMablaghKoli,CASE WHEN tblRequestTaghsit_Takhfif.fldid NOT IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId =tblRequestTaghsit_Takhfif.fldId ) THEN N'1'
						WHEN tblRequestTaghsit_Takhfif.fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldTypeRequest=2  AND fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId) AND tblRequestTaghsit_Takhfif.fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId) AND Drd.tblRequestTaghsit_Takhfif.fldid NOT IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldTypeRequest=1 AND fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId)THEN N'2'
						WHEN tblRequestTaghsit_Takhfif.fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldTypeRequest=1  AND fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId) AND tblRequestTaghsit_Takhfif.fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId) AND Drd.tblRequestTaghsit_Takhfif.fldid NOT IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldTypeRequest=2AND fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId)THEN N'3'
						WHEN tblRequestTaghsit_Takhfif.fldid IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldTypeRequest=1  AND fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId) AND tblRequestTaghsit_Takhfif.fldid NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId) AND Drd.tblRequestTaghsit_Takhfif.fldid  IN (SELECT fldRequestId FROM Drd.tblStatusTaghsit_Takhfif WHERE fldTypeRequest=2  AND fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId)THEN N'4'
						END  AS fldCheckTakhfif_Taghsit
						,CASE WHEN EXISTS (SELECT * FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId AND fldTypeMojavez=1) THEN N'1'
						WHEN EXISTS(SELECT * FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId AND fldTypeMojavez=2) THEN N'2'
						WHEN NOT EXISTS (SELECT * FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId) THEN N'3' END AS fldReplyRequest
					,CASE WHEN EXISTS (SELECT * FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId AND fldTypeMojavez=1) THEN N'توافق'
						WHEN EXISTS(SELECT * FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId AND fldTypeMojavez=2) THEN N'عدم توافق'
						WHEN NOT EXISTS (SELECT * FROM Drd.tblStatusTaghsit_Takhfif WHERE fldRequestId=Drd.tblRequestTaghsit_Takhfif.fldId) THEN N'بی پاسخ' END AS fldReplyRequestName
						,CAST(0 AS bigint)  AS fldMablaghMashmoolKarmozd,CAST(0 AS bigint)  AS fldMablagh
						,CAST(0 AS BIGINT) AS fldMablaghWithTakhfifKoli,CAST(0 AS BIGINT) AS MablaghAsli
						,(SELECT SUM(fldTedad) FROM Drd.tblCodhayeDaramadiElamAvarez WHERE tblCodhayeDaramadiElamAvarez.fldElamAvarezId=tblRequestTaghsit_Takhfif.fldElamAvarezId AND fldSharheCodeDaramad <> N'کارمزد تقسیط')AS SumTedad
FROM         Drd.tblRequestTaghsit_Takhfif INNER JOIN
                      Com.tblEmployee ON Drd.tblRequestTaghsit_Takhfif.fldEmployeeId = Com.tblEmployee.fldId

	COMMIT
GO
