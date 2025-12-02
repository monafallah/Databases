SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_RptFishPardakhtShode_CodeDaramd1](@AzTarikh NVARCHAR(10),@TaTarikh NVARCHAR(10),@organId INT,@ShomareHesabId INT,@CodeDaramd NVARCHAR(50),@DateType tinyint)
AS
BEGIN TRAN
--DECLARE @fieldname NVARCHAR(50)='ALL', @AzTarikh NVARCHAR(10)='1397/02/08',@TaTarikh NVARCHAR(10)='1397/02/08',@ShomareHesabId INT=0,@CodeDaramd NVARCHAR(50)='603011/04',@OrganId INT=1
DECLARE @StartDate DATE=com.ShamsiToMiladi(@Aztarikh)
DECLARE @EndDate DATE=com.ShamsiToMiladi(@TaTarikh)
IF(@CodeDaramd<>'0' AND @ShomareHesabId<>0)
BEGIN
	if(@DateType=1)/*براساس تاریخ پرداخت*/
	begin
	SELECT SUM(fldmablaghCodeDaramad) AS Mablagh,fldDaramadCode,fldSharheCodeDaramad,fldTarikh,[Name],Codemeli,fldFishId, TarikhSodoor,fldTitle,fldShomareHesab FROM
	(SELECT      tblCodhayeDaramd_1.fldDaramadCode, Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad, Com.tblShomareHesabeOmoomi.fldShomareHesab, 
								   ISNULL(cast((Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifAsliValue * Drd.tblCodhayeDaramadiElamAvarez.fldTedad + Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifAvarezValue + Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifMaliyatValue)as bigint),
									  cast((Drd.tblCodhayeDaramadiElamAvarez.fldAsliValue * Drd.tblCodhayeDaramadiElamAvarez.fldTedad + 
									  Drd.tblCodhayeDaramadiElamAvarez.fldAvarezValue + Drd.tblCodhayeDaramadiElamAvarez.fldMaliyatValue)as bigint))
				AS fldmablaghCodeDaramad, '0' AS Expr1, tblCodhayeDaramd_1.fldDaramadId,tblPardakhtFish.fldTarikh,tblPardakhtFish.fldId
				,tblSodoorFish.fldShomareHesabId,isnull(fldTakhfifMaliyatValue,fldMaliyatValue)fldMaliyatValue,isnull(fldTakhfifAvarezValue,fldAvarezValue)fldAvarezValue
		,	 (SELECT        CASE WHEN fldHaghighiId IS NOT NULL THEN
                                                             (SELECT        fldName + ' ' + fldFamily
                                                                FROM            Com.tblEmployee
                                                                WHERE        fldId = fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN
                                                             (SELECT        fldName
                                                                FROM            Com.tblAshkhaseHoghoghi
                                                                WHERE        fldId = fldHoghoghiId) END AS Expr1
                                FROM            Com.tblAshkhas
                                WHERE        (fldId = Drd.tblElamAvarez.fldAshakhasID)) AS [Name],
                             (SELECT        CASE WHEN fldHaghighiId IS NOT NULL THEN
                                                             (SELECT        fldCodemeli
                                                                FROM            Com.tblEmployee
                                                                WHERE        fldId = fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN
                                                             (SELECT        fldShomareSabt
                                                                FROM            Com.tblAshkhaseHoghoghi
                                                                WHERE        fldId = fldHoghoghiId) END AS Expr1
                                FROM            Com.tblAshkhas
                                WHERE        (fldId = Drd.tblElamAvarez.fldAshakhasID)) AS Codemeli
                                ,tblPardakhtFish.fldFishId,Drd.tblSodoorFish.fldTarikh AS TarikhSodoor,
                                ISNULL((SELECT fldTitle FROM Drd.tblPardakhtFish INNER JOIN
						 Drd.tblNahvePardakht ON tblNahvePardakht.fldId = tblPardakhtFish.fldNahvePardakhtId WHERE tblPardakhtFish.fldFishId=tblSodoorFish.fldId),N'') AS fldTitle
                                			FROM            Drd.tblSodoorFish INNER JOIN
							 Drd.tblSodoorFish_Detail ON Drd.tblSodoorFish.fldId = Drd.tblSodoorFish_Detail.fldFishId INNER JOIN
							 Drd.tblCodhayeDaramadiElamAvarez ON Drd.tblSodoorFish_Detail.fldCodeElamAvarezId = Drd.tblCodhayeDaramadiElamAvarez.fldID INNER JOIN
							 Drd.tblShomareHesabCodeDaramad ON Drd.tblCodhayeDaramadiElamAvarez.fldShomareHesabCodeDaramadId = Drd.tblShomareHesabCodeDaramad.fldId AND 
							 Drd.tblCodhayeDaramadiElamAvarez.fldShomareHesabCodeDaramadId = Drd.tblShomareHesabCodeDaramad.fldId INNER JOIN
							 Drd.tblCodhayeDaramd AS tblCodhayeDaramd_1 ON Drd.tblShomareHesabCodeDaramad.fldCodeDaramadId = tblCodhayeDaramd_1.fldId INNER JOIN
							 Drd.tblPardakhtFish ON Drd.tblSodoorFish.fldId = Drd.tblPardakhtFish.fldFishId AND Drd.tblSodoorFish.fldId = Drd.tblPardakhtFish.fldFishId INNER JOIN
							 Com.tblShomareHesabeOmoomi ON Drd.tblSodoorFish.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId
							 INNER JOIN Drd.tblElamAvarez ON tblElamAvarez.fldId = tblCodhayeDaramadiElamAvarez.fldElamAvarezId
			WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId)
							 AND CAST( tblPardakhtFish.fldDatePardakht AS DATE) BETWEEN @StartDate AND @EndDate
							 AND Drd.tblShomareHesabCodeDaramad.fldOrganId=@OrganId
							 
			
			union all
			SELECT fldDaramadCode,fldSharheCodeDaramad,fldShomareHesab, cast(cast(fldMablaghNaghdi as numeric(50)) *cast(fldmablaghCodeDaramad as numeric(50))/cast(fldmablaghKoli as numeric(50))as bigint),'1'
			,fldDaramadId,fldTarikh,fldId,fldShomareHesabId,fldMaliyatValue,fldAvarezValue,[Name],Codemeli,fldFishId,TarikhSodoor,fldTitle
			 FROM 
			(SELECT   DISTINCT    Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId, tblCodhayeDaramd_1.fldDaramadCode, 
									 Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad
									,Drd.fn_SumMablaghNaghdi('Naghdi_Talab',tblNaghdi_Talab.fldFishId,tblNaghdi_Talab.fldShomareHesabId,@azTarikh ,@Tatarikh) AS fldMablaghNaghdi
									,fldShomareHesab ,fldReplyTaghsitId
				,ISNULL(SUM(fldTakhfifAsliValue*fldTedad+fldTakhfifAvarezValue+fldTakhfifMaliyatValue),SUM(fldAsliValue*fldTedad+fldAvarezValue+fldMaliyatValue)) AS fldmablaghCodeDaramad
				,(SELECT TOP(1) ISNULL(SUM(fldTakhfifAsliValue*fldTedad+fldTakhfifAvarezValue+fldTakhfifMaliyatValue) OVER (PARTITION BY tblCodhayeDaramadiElamAvarez.fldElamAvarezId),SUM(fldAsliValue*fldTedad+fldAvarezValue+fldMaliyatValue) OVER (PARTITION BY tblCodhayeDaramadiElamAvarez.fldElamAvarezId)) FROM Drd.tblCodhayeDaramadiElamAvarez AS a WHERE a.fldElamAvarezId =Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId) AS fldmablaghKoli
			,tblCodhayeDaramd_1.fldDaramadId,tblPardakhtFish.fldTarikh,tblPardakhtFish.fldId,Drd.tblNaghdi_Talab.fldShomareHesabId,isnull(fldTakhfifMaliyatValue,fldMaliyatValue)fldMaliyatValue,isnull(fldTakhfifAvarezValue,fldAvarezValue)fldAvarezValue
			
			 ,(SELECT        CASE WHEN fldHaghighiId IS NOT NULL THEN
                                                             (SELECT        fldName + ' ' + fldFamily
                                                                FROM            Com.tblEmployee
                                                                WHERE        fldId = fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN
                                                             (SELECT        fldName
                                                                FROM            Com.tblAshkhaseHoghoghi
                                                                WHERE        fldId = fldHoghoghiId) END AS Expr1
                                FROM            Com.tblAshkhas
                                WHERE        (fldId = Drd.tblElamAvarez.fldAshakhasID)) AS [Name],
                             (SELECT        CASE WHEN fldHaghighiId IS NOT NULL THEN
                                                             (SELECT        fldCodemeli
                                                                FROM            Com.tblEmployee
                                                                WHERE        fldId = fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN
                                                             (SELECT        fldShomareSabt
                                                                FROM            Com.tblAshkhaseHoghoghi
                                                                WHERE        fldId = fldHoghoghiId) END AS Expr1
                                FROM            Com.tblAshkhas
                                WHERE        (fldId = Drd.tblElamAvarez.fldAshakhasID)) AS Codemeli
                                        ,tblPardakhtFish.fldFishId,
                                       Drd.tblSodoorFish.fldTarikh  AS TarikhSodoor,tblNaghdi_Talab.fldFishId AS Naghfish,
                                ISNULL((SELECT fldTitle FROM Drd.tblPardakhtFish INNER JOIN
						 Drd.tblNahvePardakht ON tblNahvePardakht.fldId = tblPardakhtFish.fldNahvePardakhtId WHERE tblPardakhtFish.fldFishId=tblSodoorFish.fldId),N'') AS fldTitle 
			FROM            Drd.tblRequestTaghsit_Takhfif INNER JOIN
							Drd.tblStatusTaghsit_Takhfif ON Drd.tblRequestTaghsit_Takhfif.fldId = Drd.tblStatusTaghsit_Takhfif.fldRequestId INNER JOIN
							 Drd.tblReplyTaghsit ON Drd.tblStatusTaghsit_Takhfif.fldId = Drd.tblReplyTaghsit.fldStatusId INNER JOIN
							 Drd.tblElamAvarez ON Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId = Drd.tblElamAvarez.fldId INNER JOIN
							 Drd.tblCodhayeDaramadiElamAvarez ON Drd.tblElamAvarez.fldId = Drd.tblCodhayeDaramadiElamAvarez.fldElamAvarezId INNER JOIN
							 Drd.tblShomareHesabCodeDaramad ON Drd.tblCodhayeDaramadiElamAvarez.fldShomareHesabCodeDaramadId = Drd.tblShomareHesabCodeDaramad.fldId INNER JOIN
							 Drd.tblCodhayeDaramd AS tblCodhayeDaramd_1 ON Drd.tblShomareHesabCodeDaramad.fldCodeDaramadId = tblCodhayeDaramd_1.fldId INNER JOIN
							 Drd.tblNaghdi_Talab ON Drd.tblReplyTaghsit.fldId = Drd.tblNaghdi_Talab.fldReplyTaghsitId INNER JOIN
							 Com.tblShomareHesabeOmoomi ON Com.tblShomareHesabeOmoomi.fldId = Drd.tblNaghdi_Talab.fldShomareHesabId INNER JOIN
							 Drd.tblSodoorFish ON Drd.tblNaghdi_Talab.fldFishId = Drd.tblSodoorFish.fldId INNER JOIN
							 Drd.tblPardakhtFish ON Drd.tblSodoorFish.fldId = Drd.tblPardakhtFish.fldFishId 
							 WHERE fldRequestId NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=fldRequestId)
							AND tblNaghdi_Talab.fldType=1 
							AND CAST(tblPardakhtFish.fldDatePardakht AS  DATE) BETWEEN @StartDate AND @EndDate AND tblShomareHesabCodeDaramad.fldOrganId=@OrganId
							AND tblShomareHesabCodeDaramad.fldOrganId=@OrganId
							 
							 GROUP BY tblRequestTaghsit_Takhfif.fldElamAvarezId,tblCodhayeDaramd_1.fldDaramadCode, 
							 Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad,fldMablagh,fldReplyTaghsitId, tblCodhayeDaramadiElamAvarez.fldElamAvarezId
							 ,tblNaghdi_Talab.fldShomareHesabId,fldShomareHesab,fldDaramadId,tblPardakhtFish.fldTarikh,tblPardakhtFish.fldId,tblNaghdi_Talab.fldShomareHesabId
						,fldMaliyatValue,fldAvarezValue,fldTakhfifMaliyatValue,fldTakhfifAvarezValue,fldAshakhasID,tblPardakhtFish.fldFishId
							, Drd.tblSodoorFish.fldTarikh,Drd.tblSodoorFish.fldId,tblNaghdi_Talab.fldFishId )t)s
								 WHERE s.fldDaramadCode=@CodeDaramd AND s.fldShomareHesabId=@ShomareHesabId
			GROUP BY fldDaramadCode,fldSharheCodeDaramad,fldTarikh,[Name],Codemeli,fldFishId,TarikhSodoor,fldTitle,fldShomareHesab
			ORDER BY MIN(fldFishId)
		end
		else if(@DateType=0)/*براساس تاریخ واریز*/
	begin
	SELECT SUM(fldmablaghCodeDaramad) AS Mablagh,fldDaramadCode,fldSharheCodeDaramad,fldTarikh,[Name],Codemeli,fldFishId, TarikhSodoor,fldTitle,fldShomareHesab FROM
	(SELECT      tblCodhayeDaramd_1.fldDaramadCode, Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad, Com.tblShomareHesabeOmoomi.fldShomareHesab, 
								   ISNULL(cast((Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifAsliValue * Drd.tblCodhayeDaramadiElamAvarez.fldTedad + Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifAvarezValue + Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifMaliyatValue)as bigint),
									  cast((Drd.tblCodhayeDaramadiElamAvarez.fldAsliValue * Drd.tblCodhayeDaramadiElamAvarez.fldTedad + 
									  Drd.tblCodhayeDaramadiElamAvarez.fldAvarezValue + Drd.tblCodhayeDaramadiElamAvarez.fldMaliyatValue)as bigint))
				AS fldmablaghCodeDaramad, '0' AS Expr1, tblCodhayeDaramd_1.fldDaramadId,tblPardakhtFish.fldTarikhVariz fldTarikh,tblPardakhtFish.fldId
				,tblSodoorFish.fldShomareHesabId,isnull(fldTakhfifMaliyatValue,fldMaliyatValue)fldMaliyatValue,isnull(fldTakhfifAvarezValue,fldAvarezValue)fldAvarezValue
		,	 (SELECT        CASE WHEN fldHaghighiId IS NOT NULL THEN
                                                             (SELECT        fldName + ' ' + fldFamily
                                                                FROM            Com.tblEmployee
                                                                WHERE        fldId = fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN
                                                             (SELECT        fldName
                                                                FROM            Com.tblAshkhaseHoghoghi
                                                                WHERE        fldId = fldHoghoghiId) END AS Expr1
                                FROM            Com.tblAshkhas
                                WHERE        (fldId = Drd.tblElamAvarez.fldAshakhasID)) AS [Name],
                             (SELECT        CASE WHEN fldHaghighiId IS NOT NULL THEN
                                                             (SELECT        fldCodemeli
                                                                FROM            Com.tblEmployee
                                                                WHERE        fldId = fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN
                                                             (SELECT        fldShomareSabt
                                                                FROM            Com.tblAshkhaseHoghoghi
                                                                WHERE        fldId = fldHoghoghiId) END AS Expr1
                                FROM            Com.tblAshkhas
                                WHERE        (fldId = Drd.tblElamAvarez.fldAshakhasID)) AS Codemeli
                                ,tblPardakhtFish.fldFishId,Drd.tblSodoorFish.fldTarikh AS TarikhSodoor,
                                ISNULL((SELECT fldTitle FROM Drd.tblPardakhtFish INNER JOIN
						 Drd.tblNahvePardakht ON tblNahvePardakht.fldId = tblPardakhtFish.fldNahvePardakhtId WHERE tblPardakhtFish.fldFishId=tblSodoorFish.fldId),N'') AS fldTitle
                                			FROM            Drd.tblSodoorFish INNER JOIN
							 Drd.tblSodoorFish_Detail ON Drd.tblSodoorFish.fldId = Drd.tblSodoorFish_Detail.fldFishId INNER JOIN
							 Drd.tblCodhayeDaramadiElamAvarez ON Drd.tblSodoorFish_Detail.fldCodeElamAvarezId = Drd.tblCodhayeDaramadiElamAvarez.fldID INNER JOIN
							 Drd.tblShomareHesabCodeDaramad ON Drd.tblCodhayeDaramadiElamAvarez.fldShomareHesabCodeDaramadId = Drd.tblShomareHesabCodeDaramad.fldId AND 
							 Drd.tblCodhayeDaramadiElamAvarez.fldShomareHesabCodeDaramadId = Drd.tblShomareHesabCodeDaramad.fldId INNER JOIN
							 Drd.tblCodhayeDaramd AS tblCodhayeDaramd_1 ON Drd.tblShomareHesabCodeDaramad.fldCodeDaramadId = tblCodhayeDaramd_1.fldId INNER JOIN
							 Drd.tblPardakhtFish ON Drd.tblSodoorFish.fldId = Drd.tblPardakhtFish.fldFishId AND Drd.tblSodoorFish.fldId = Drd.tblPardakhtFish.fldFishId INNER JOIN
							 Com.tblShomareHesabeOmoomi ON Drd.tblSodoorFish.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId
							 INNER JOIN Drd.tblElamAvarez ON tblElamAvarez.fldId = tblCodhayeDaramadiElamAvarez.fldElamAvarezId
			WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId)
							 AND CAST( tblPardakhtFish.fldDateVariz AS DATE) BETWEEN @StartDate AND @EndDate
							 AND Drd.tblShomareHesabCodeDaramad.fldOrganId=@OrganId
							 
			
			union all
			SELECT fldDaramadCode,fldSharheCodeDaramad,fldShomareHesab, cast(cast(fldMablaghNaghdi as numeric(50)) *cast(fldmablaghCodeDaramad as numeric(50))/cast(fldmablaghKoli as numeric(50))as bigint),'1'
			,fldDaramadId,fldTarikh,fldId,fldShomareHesabId,fldMaliyatValue,fldAvarezValue,[Name],Codemeli,fldFishId,TarikhSodoor,fldTitle
			 FROM 
			(SELECT   DISTINCT    Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId, tblCodhayeDaramd_1.fldDaramadCode, 
									 Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad
									,Drd.fn_SumMablaghNaghdi('Naghdi_Talab',tblNaghdi_Talab.fldFishId,tblNaghdi_Talab.fldShomareHesabId,@azTarikh ,@Tatarikh) AS fldMablaghNaghdi
									,fldShomareHesab ,fldReplyTaghsitId
				,ISNULL(SUM(fldTakhfifAsliValue*fldTedad+fldTakhfifAvarezValue+fldTakhfifMaliyatValue),SUM(fldAsliValue*fldTedad+fldAvarezValue+fldMaliyatValue)) AS fldmablaghCodeDaramad
				,(SELECT TOP(1) ISNULL(SUM(fldTakhfifAsliValue*fldTedad+fldTakhfifAvarezValue+fldTakhfifMaliyatValue) OVER (PARTITION BY tblCodhayeDaramadiElamAvarez.fldElamAvarezId),SUM(fldAsliValue*fldTedad+fldAvarezValue+fldMaliyatValue) OVER (PARTITION BY tblCodhayeDaramadiElamAvarez.fldElamAvarezId)) FROM Drd.tblCodhayeDaramadiElamAvarez AS a WHERE a.fldElamAvarezId =Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId) AS fldmablaghKoli
			,tblCodhayeDaramd_1.fldDaramadId,tblPardakhtFish.fldTarikhVariz fldTarikh,tblPardakhtFish.fldId,Drd.tblNaghdi_Talab.fldShomareHesabId,isnull(fldTakhfifMaliyatValue,fldMaliyatValue)fldMaliyatValue,isnull(fldTakhfifAvarezValue,fldAvarezValue)fldAvarezValue
			
			 ,(SELECT        CASE WHEN fldHaghighiId IS NOT NULL THEN
                                                             (SELECT        fldName + ' ' + fldFamily
                                                                FROM            Com.tblEmployee
                                                                WHERE        fldId = fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN
                                                             (SELECT        fldName
                                                                FROM            Com.tblAshkhaseHoghoghi
                                                                WHERE        fldId = fldHoghoghiId) END AS Expr1
                                FROM            Com.tblAshkhas
                                WHERE        (fldId = Drd.tblElamAvarez.fldAshakhasID)) AS [Name],
                             (SELECT        CASE WHEN fldHaghighiId IS NOT NULL THEN
                                                             (SELECT        fldCodemeli
                                                                FROM            Com.tblEmployee
                                                                WHERE        fldId = fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN
                                                             (SELECT        fldShomareSabt
                                                                FROM            Com.tblAshkhaseHoghoghi
                                                                WHERE        fldId = fldHoghoghiId) END AS Expr1
                                FROM            Com.tblAshkhas
                                WHERE        (fldId = Drd.tblElamAvarez.fldAshakhasID)) AS Codemeli
                                        ,tblPardakhtFish.fldFishId,
                                       Drd.tblSodoorFish.fldTarikh  AS TarikhSodoor,tblNaghdi_Talab.fldFishId AS Naghfish,
                                ISNULL((SELECT fldTitle FROM Drd.tblPardakhtFish INNER JOIN
						 Drd.tblNahvePardakht ON tblNahvePardakht.fldId = tblPardakhtFish.fldNahvePardakhtId WHERE tblPardakhtFish.fldFishId=tblSodoorFish.fldId),N'') AS fldTitle 
			FROM            Drd.tblRequestTaghsit_Takhfif INNER JOIN
							Drd.tblStatusTaghsit_Takhfif ON Drd.tblRequestTaghsit_Takhfif.fldId = Drd.tblStatusTaghsit_Takhfif.fldRequestId INNER JOIN
							 Drd.tblReplyTaghsit ON Drd.tblStatusTaghsit_Takhfif.fldId = Drd.tblReplyTaghsit.fldStatusId INNER JOIN
							 Drd.tblElamAvarez ON Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId = Drd.tblElamAvarez.fldId INNER JOIN
							 Drd.tblCodhayeDaramadiElamAvarez ON Drd.tblElamAvarez.fldId = Drd.tblCodhayeDaramadiElamAvarez.fldElamAvarezId INNER JOIN
							 Drd.tblShomareHesabCodeDaramad ON Drd.tblCodhayeDaramadiElamAvarez.fldShomareHesabCodeDaramadId = Drd.tblShomareHesabCodeDaramad.fldId INNER JOIN
							 Drd.tblCodhayeDaramd AS tblCodhayeDaramd_1 ON Drd.tblShomareHesabCodeDaramad.fldCodeDaramadId = tblCodhayeDaramd_1.fldId INNER JOIN
							 Drd.tblNaghdi_Talab ON Drd.tblReplyTaghsit.fldId = Drd.tblNaghdi_Talab.fldReplyTaghsitId INNER JOIN
							 Com.tblShomareHesabeOmoomi ON Com.tblShomareHesabeOmoomi.fldId = Drd.tblNaghdi_Talab.fldShomareHesabId INNER JOIN
							 Drd.tblSodoorFish ON Drd.tblNaghdi_Talab.fldFishId = Drd.tblSodoorFish.fldId INNER JOIN
							 Drd.tblPardakhtFish ON Drd.tblSodoorFish.fldId = Drd.tblPardakhtFish.fldFishId 
							 WHERE fldRequestId NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=fldRequestId)
							AND tblNaghdi_Talab.fldType=1 
							AND CAST(tblPardakhtFish.fldDateVariz AS  DATE) BETWEEN @StartDate AND @EndDate AND tblShomareHesabCodeDaramad.fldOrganId=@OrganId
							AND tblShomareHesabCodeDaramad.fldOrganId=@OrganId
							 
							 GROUP BY tblRequestTaghsit_Takhfif.fldElamAvarezId,tblCodhayeDaramd_1.fldDaramadCode, 
							 Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad,fldMablagh,fldReplyTaghsitId, tblCodhayeDaramadiElamAvarez.fldElamAvarezId
							 ,tblNaghdi_Talab.fldShomareHesabId,fldShomareHesab,fldDaramadId,tblPardakhtFish.fldTarikhVariz,tblPardakhtFish.fldId,tblNaghdi_Talab.fldShomareHesabId
						,fldMaliyatValue,fldAvarezValue,fldTakhfifMaliyatValue,fldTakhfifAvarezValue,fldAshakhasID,tblPardakhtFish.fldFishId
							, Drd.tblSodoorFish.fldTarikh,Drd.tblSodoorFish.fldId,tblNaghdi_Talab.fldFishId )t)s
								 WHERE s.fldDaramadCode=@CodeDaramd AND s.fldShomareHesabId=@ShomareHesabId
		GROUP BY fldDaramadCode,fldSharheCodeDaramad,fldTarikh,[Name],Codemeli,fldFishId,TarikhSodoor,fldTitle,fldShomareHesab
		ORDER BY MIN(fldFishId)
	end
END

IF(@CodeDaramd='0' AND @ShomareHesabId<>0)
BEGIN
	if(@DateType=1)/*براساس تاریخ پرداخت*/
	begin
		SELECT SUM(fldmablaghCodeDaramad) AS Mablagh,fldDaramadCode,fldSharheCodeDaramad,fldTarikh,[Name],Codemeli,fldFishId, TarikhSodoor,fldTitle,fldShomareHesab FROM
		(SELECT      tblCodhayeDaramd_1.fldDaramadCode, Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad, Com.tblShomareHesabeOmoomi.fldShomareHesab, 
								   ISNULL(cast((Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifAsliValue * Drd.tblCodhayeDaramadiElamAvarez.fldTedad + 
								   Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifAvarezValue + Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifMaliyatValue)as bigint),
									  cast((Drd.tblCodhayeDaramadiElamAvarez.fldAsliValue * Drd.tblCodhayeDaramadiElamAvarez.fldTedad + Drd.tblCodhayeDaramadiElamAvarez.fldAvarezValue 
									  + Drd.tblCodhayeDaramadiElamAvarez.fldMaliyatValue)as bigint))
				AS fldmablaghCodeDaramad, '0' AS Expr1, tblCodhayeDaramd_1.fldDaramadId,tblPardakhtFish.fldTarikh,tblPardakhtFish.fldId,
				tblSodoorFish.fldShomareHesabId,isnull(fldTakhfifMaliyatValue,fldMaliyatValue)fldMaliyatValue,
				isnull(fldTakhfifAvarezValue,fldAvarezValue)fldAvarezValue
		,	 (SELECT        CASE WHEN fldHaghighiId IS NOT NULL THEN
                                                             (SELECT        fldName + ' ' + fldFamily
                                                                FROM            Com.tblEmployee
                                                                WHERE        fldId = fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN
                                                             (SELECT        fldName
                                                                FROM            Com.tblAshkhaseHoghoghi
                                                                WHERE        fldId = fldHoghoghiId) END AS Expr1
                                FROM            Com.tblAshkhas
                                WHERE        (fldId = Drd.tblElamAvarez.fldAshakhasID)) AS [Name],
                             (SELECT        CASE WHEN fldHaghighiId IS NOT NULL THEN
                                                             (SELECT        fldCodemeli
                                                                FROM            Com.tblEmployee
                                                                WHERE        fldId = fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN
                                                             (SELECT        fldShomareSabt
                                                                FROM            Com.tblAshkhaseHoghoghi
                                                                WHERE        fldId = fldHoghoghiId) END AS Expr1
                                FROM            Com.tblAshkhas
                                WHERE        (fldId = Drd.tblElamAvarez.fldAshakhasID)) AS Codemeli
                                ,tblPardakhtFish.fldFishId,Drd.tblSodoorFish.fldTarikh AS TarikhSodoor,
                                ISNULL((SELECT fldTitle FROM Drd.tblPardakhtFish INNER JOIN
						 Drd.tblNahvePardakht ON tblNahvePardakht.fldId = tblPardakhtFish.fldNahvePardakhtId WHERE tblPardakhtFish.fldFishId=tblSodoorFish.fldId),N'') AS fldTitle
                                			FROM            Drd.tblSodoorFish INNER JOIN
							 Drd.tblSodoorFish_Detail ON Drd.tblSodoorFish.fldId = Drd.tblSodoorFish_Detail.fldFishId INNER JOIN
							 Drd.tblCodhayeDaramadiElamAvarez ON Drd.tblSodoorFish_Detail.fldCodeElamAvarezId = Drd.tblCodhayeDaramadiElamAvarez.fldID INNER JOIN
							 Drd.tblShomareHesabCodeDaramad ON Drd.tblCodhayeDaramadiElamAvarez.fldShomareHesabCodeDaramadId = Drd.tblShomareHesabCodeDaramad.fldId AND 
							 Drd.tblCodhayeDaramadiElamAvarez.fldShomareHesabCodeDaramadId = Drd.tblShomareHesabCodeDaramad.fldId INNER JOIN
							 Drd.tblCodhayeDaramd AS tblCodhayeDaramd_1 ON Drd.tblShomareHesabCodeDaramad.fldCodeDaramadId = tblCodhayeDaramd_1.fldId INNER JOIN
							 Drd.tblPardakhtFish ON Drd.tblSodoorFish.fldId = Drd.tblPardakhtFish.fldFishId AND Drd.tblSodoorFish.fldId = Drd.tblPardakhtFish.fldFishId INNER JOIN
							 Com.tblShomareHesabeOmoomi ON Drd.tblSodoorFish.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId
							 INNER JOIN Drd.tblElamAvarez ON tblElamAvarez.fldId = tblCodhayeDaramadiElamAvarez.fldElamAvarezId
			WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId)
							 AND CAST( tblPardakhtFish.fldDatePardakht AS DATE) BETWEEN @StartDate AND @EndDate
							 AND Drd.tblShomareHesabCodeDaramad.fldOrganId=@OrganId
							 
			
			union all
			SELECT fldDaramadCode,fldSharheCodeDaramad,fldShomareHesab, cast(cast(fldMablaghNaghdi as numeric(50)) *cast(fldmablaghCodeDaramad as numeric(50))/cast(fldmablaghKoli as numeric(50))as bigint),'1'
			,fldDaramadId,fldTarikh,fldId,fldShomareHesabId,fldMaliyatValue,fldAvarezValue,[Name],Codemeli,fldFishId,TarikhSodoor,fldTitle
			 FROM 
			(SELECT   DISTINCT    Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId, tblCodhayeDaramd_1.fldDaramadCode, 
									 Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad
									,Drd.fn_SumMablaghNaghdi('Naghdi_Talab',tblNaghdi_Talab.fldFishId,tblNaghdi_Talab.fldShomareHesabId,@azTarikh ,@Tatarikh) AS fldMablaghNaghdi
									,fldShomareHesab ,fldReplyTaghsitId
				,ISNULL(SUM(fldTakhfifAsliValue*fldTedad+fldTakhfifAvarezValue+fldTakhfifMaliyatValue),SUM(fldAsliValue*fldTedad+fldAvarezValue+fldMaliyatValue)) AS fldmablaghCodeDaramad
				,(SELECT TOP(1) ISNULL(SUM(fldTakhfifAsliValue*fldTedad+fldTakhfifAvarezValue+fldTakhfifMaliyatValue) OVER (PARTITION BY tblCodhayeDaramadiElamAvarez.fldElamAvarezId),SUM(fldAsliValue*fldTedad+fldAvarezValue+fldMaliyatValue) OVER (PARTITION BY tblCodhayeDaramadiElamAvarez.fldElamAvarezId)) FROM Drd.tblCodhayeDaramadiElamAvarez AS a WHERE a.fldElamAvarezId =Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId) AS fldmablaghKoli
			,tblCodhayeDaramd_1.fldDaramadId,tblPardakhtFish.fldTarikh,tblPardakhtFish.fldId,Drd.tblNaghdi_Talab.fldShomareHesabId,isnull(fldTakhfifMaliyatValue,fldMaliyatValue)fldMaliyatValue,isnull(fldTakhfifAvarezValue,fldAvarezValue)fldAvarezValue
			
			 ,(SELECT        CASE WHEN fldHaghighiId IS NOT NULL THEN
                                                             (SELECT        fldName + ' ' + fldFamily
                                                                FROM            Com.tblEmployee
                                                                WHERE        fldId = fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN
                                                             (SELECT        fldName
                                                                FROM            Com.tblAshkhaseHoghoghi
                                                                WHERE        fldId = fldHoghoghiId) END AS Expr1
                                FROM            Com.tblAshkhas
                                WHERE        (fldId = Drd.tblElamAvarez.fldAshakhasID)) AS [Name],
                             (SELECT        CASE WHEN fldHaghighiId IS NOT NULL THEN
                                                             (SELECT        fldCodemeli
                                                                FROM            Com.tblEmployee
                                                                WHERE        fldId = fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN
                                                             (SELECT        fldShomareSabt
                                                                FROM            Com.tblAshkhaseHoghoghi
                                                                WHERE        fldId = fldHoghoghiId) END AS Expr1
                                FROM            Com.tblAshkhas
                                WHERE        (fldId = Drd.tblElamAvarez.fldAshakhasID)) AS Codemeli
                                        ,tblPardakhtFish.fldFishId,
                                       Drd.tblSodoorFish.fldTarikh  AS TarikhSodoor,tblNaghdi_Talab.fldFishId AS Naghfish,
                                ISNULL((SELECT fldTitle FROM Drd.tblPardakhtFish INNER JOIN
						 Drd.tblNahvePardakht ON tblNahvePardakht.fldId = tblPardakhtFish.fldNahvePardakhtId WHERE tblPardakhtFish.fldFishId=tblSodoorFish.fldId),N'') AS fldTitle 
			FROM            Drd.tblRequestTaghsit_Takhfif INNER JOIN
							Drd.tblStatusTaghsit_Takhfif ON Drd.tblRequestTaghsit_Takhfif.fldId = Drd.tblStatusTaghsit_Takhfif.fldRequestId INNER JOIN
							 Drd.tblReplyTaghsit ON Drd.tblStatusTaghsit_Takhfif.fldId = Drd.tblReplyTaghsit.fldStatusId INNER JOIN
							 Drd.tblElamAvarez ON Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId = Drd.tblElamAvarez.fldId INNER JOIN
							 Drd.tblCodhayeDaramadiElamAvarez ON Drd.tblElamAvarez.fldId = Drd.tblCodhayeDaramadiElamAvarez.fldElamAvarezId INNER JOIN
							 Drd.tblShomareHesabCodeDaramad ON Drd.tblCodhayeDaramadiElamAvarez.fldShomareHesabCodeDaramadId = Drd.tblShomareHesabCodeDaramad.fldId INNER JOIN
							 Drd.tblCodhayeDaramd AS tblCodhayeDaramd_1 ON Drd.tblShomareHesabCodeDaramad.fldCodeDaramadId = tblCodhayeDaramd_1.fldId INNER JOIN
							 Drd.tblNaghdi_Talab ON Drd.tblReplyTaghsit.fldId = Drd.tblNaghdi_Talab.fldReplyTaghsitId INNER JOIN
							 Com.tblShomareHesabeOmoomi ON Com.tblShomareHesabeOmoomi.fldId = Drd.tblNaghdi_Talab.fldShomareHesabId INNER JOIN
							 Drd.tblSodoorFish ON Drd.tblNaghdi_Talab.fldFishId = Drd.tblSodoorFish.fldId INNER JOIN
							 Drd.tblPardakhtFish ON Drd.tblSodoorFish.fldId = Drd.tblPardakhtFish.fldFishId 
							 WHERE fldRequestId NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=fldRequestId)
							AND tblNaghdi_Talab.fldType=1 
							AND CAST(tblPardakhtFish.fldDatePardakht AS  DATE) BETWEEN @StartDate AND @EndDate AND tblShomareHesabCodeDaramad.fldOrganId=@OrganId
							AND tblShomareHesabCodeDaramad.fldOrganId=@OrganId
							 
							 GROUP BY tblRequestTaghsit_Takhfif.fldElamAvarezId,tblCodhayeDaramd_1.fldDaramadCode, 
							 Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad,fldMablagh,fldReplyTaghsitId, tblCodhayeDaramadiElamAvarez.fldElamAvarezId
							 ,tblNaghdi_Talab.fldShomareHesabId,fldShomareHesab,fldDaramadId,tblPardakhtFish.fldTarikh,tblPardakhtFish.fldId,tblNaghdi_Talab.fldShomareHesabId
						,fldMaliyatValue,fldAvarezValue,fldTakhfifMaliyatValue,fldTakhfifAvarezValue,fldAshakhasID,tblPardakhtFish.fldFishId
							, Drd.tblSodoorFish.fldTarikh,Drd.tblSodoorFish.fldId,tblNaghdi_Talab.fldFishId  )t)s
							  WHERE  s.fldShomareHesabId=@ShomareHesabId
					GROUP BY fldDaramadCode,fldSharheCodeDaramad,fldTarikh,[Name],Codemeli,fldFishId,TarikhSodoor,fldTitle,fldShomareHesab
					ORDER BY MIN(fldFishId)
				end
	if(@DateType=0)/*براساس تاریخ واریز*/
	begin
		SELECT SUM(fldmablaghCodeDaramad) AS Mablagh,fldDaramadCode,fldSharheCodeDaramad,fldTarikh,[Name],Codemeli,fldFishId, TarikhSodoor,fldTitle,fldShomareHesab FROM
		(SELECT      tblCodhayeDaramd_1.fldDaramadCode, Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad, Com.tblShomareHesabeOmoomi.fldShomareHesab, 
								   ISNULL(cast((Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifAsliValue * Drd.tblCodhayeDaramadiElamAvarez.fldTedad + 
								   Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifAvarezValue + Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifMaliyatValue)as bigint),
									  cast((Drd.tblCodhayeDaramadiElamAvarez.fldAsliValue * Drd.tblCodhayeDaramadiElamAvarez.fldTedad + Drd.tblCodhayeDaramadiElamAvarez.fldAvarezValue 
									  + Drd.tblCodhayeDaramadiElamAvarez.fldMaliyatValue)as bigint))
				AS fldmablaghCodeDaramad, '0' AS Expr1, tblCodhayeDaramd_1.fldDaramadId,tblPardakhtFish.fldTarikhVariz fldTarikh,tblPardakhtFish.fldId,
				tblSodoorFish.fldShomareHesabId,isnull(fldTakhfifMaliyatValue,fldMaliyatValue)fldMaliyatValue,
				isnull(fldTakhfifAvarezValue,fldAvarezValue)fldAvarezValue
		,	 (SELECT        CASE WHEN fldHaghighiId IS NOT NULL THEN
                                                             (SELECT        fldName + ' ' + fldFamily
                                                                FROM            Com.tblEmployee
                                                                WHERE        fldId = fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN
                                                             (SELECT        fldName
                                                                FROM            Com.tblAshkhaseHoghoghi
                                                                WHERE        fldId = fldHoghoghiId) END AS Expr1
                                FROM            Com.tblAshkhas
                                WHERE        (fldId = Drd.tblElamAvarez.fldAshakhasID)) AS [Name],
                             (SELECT        CASE WHEN fldHaghighiId IS NOT NULL THEN
                                                             (SELECT        fldCodemeli
                                                                FROM            Com.tblEmployee
                                                                WHERE        fldId = fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN
                                                             (SELECT        fldShomareSabt
                                                                FROM            Com.tblAshkhaseHoghoghi
                                                                WHERE        fldId = fldHoghoghiId) END AS Expr1
                                FROM            Com.tblAshkhas
                                WHERE        (fldId = Drd.tblElamAvarez.fldAshakhasID)) AS Codemeli
                                ,tblPardakhtFish.fldFishId,Drd.tblSodoorFish.fldTarikh AS TarikhSodoor,
                                ISNULL((SELECT fldTitle FROM Drd.tblPardakhtFish INNER JOIN
						 Drd.tblNahvePardakht ON tblNahvePardakht.fldId = tblPardakhtFish.fldNahvePardakhtId WHERE tblPardakhtFish.fldFishId=tblSodoorFish.fldId),N'') AS fldTitle
                                			FROM            Drd.tblSodoorFish INNER JOIN
							 Drd.tblSodoorFish_Detail ON Drd.tblSodoorFish.fldId = Drd.tblSodoorFish_Detail.fldFishId INNER JOIN
							 Drd.tblCodhayeDaramadiElamAvarez ON Drd.tblSodoorFish_Detail.fldCodeElamAvarezId = Drd.tblCodhayeDaramadiElamAvarez.fldID INNER JOIN
							 Drd.tblShomareHesabCodeDaramad ON Drd.tblCodhayeDaramadiElamAvarez.fldShomareHesabCodeDaramadId = Drd.tblShomareHesabCodeDaramad.fldId AND 
							 Drd.tblCodhayeDaramadiElamAvarez.fldShomareHesabCodeDaramadId = Drd.tblShomareHesabCodeDaramad.fldId INNER JOIN
							 Drd.tblCodhayeDaramd AS tblCodhayeDaramd_1 ON Drd.tblShomareHesabCodeDaramad.fldCodeDaramadId = tblCodhayeDaramd_1.fldId INNER JOIN
							 Drd.tblPardakhtFish ON Drd.tblSodoorFish.fldId = Drd.tblPardakhtFish.fldFishId AND Drd.tblSodoorFish.fldId = Drd.tblPardakhtFish.fldFishId INNER JOIN
							 Com.tblShomareHesabeOmoomi ON Drd.tblSodoorFish.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId
							 INNER JOIN Drd.tblElamAvarez ON tblElamAvarez.fldId = tblCodhayeDaramadiElamAvarez.fldElamAvarezId
			WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId)
							 AND CAST( tblPardakhtFish.fldDateVariz AS DATE) BETWEEN @StartDate AND @EndDate
							 AND Drd.tblShomareHesabCodeDaramad.fldOrganId=@OrganId
							 
			
			union all
			SELECT fldDaramadCode,fldSharheCodeDaramad,fldShomareHesab, cast(cast(fldMablaghNaghdi as numeric(50)) *cast(fldmablaghCodeDaramad as numeric(50))/cast(fldmablaghKoli as numeric(50))as bigint),'1'
			,fldDaramadId,fldTarikh,fldId,fldShomareHesabId,fldMaliyatValue,fldAvarezValue,[Name],Codemeli,fldFishId,TarikhSodoor,fldTitle
			 FROM 
			(SELECT   DISTINCT    Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId, tblCodhayeDaramd_1.fldDaramadCode, 
									 Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad
									,Drd.fn_SumMablaghNaghdi('Naghdi_Talab',tblNaghdi_Talab.fldFishId,tblNaghdi_Talab.fldShomareHesabId,@azTarikh ,@Tatarikh) AS fldMablaghNaghdi
									,fldShomareHesab ,fldReplyTaghsitId
				,ISNULL(SUM(fldTakhfifAsliValue*fldTedad+fldTakhfifAvarezValue+fldTakhfifMaliyatValue),SUM(fldAsliValue*fldTedad+fldAvarezValue+fldMaliyatValue)) AS fldmablaghCodeDaramad
				,(SELECT TOP(1) ISNULL(SUM(fldTakhfifAsliValue*fldTedad+fldTakhfifAvarezValue+fldTakhfifMaliyatValue) OVER (PARTITION BY tblCodhayeDaramadiElamAvarez.fldElamAvarezId),SUM(fldAsliValue*fldTedad+fldAvarezValue+fldMaliyatValue) OVER (PARTITION BY tblCodhayeDaramadiElamAvarez.fldElamAvarezId)) FROM Drd.tblCodhayeDaramadiElamAvarez AS a WHERE a.fldElamAvarezId =Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId) AS fldmablaghKoli
			,tblCodhayeDaramd_1.fldDaramadId,tblPardakhtFish.fldTarikhVariz fldTarikh,tblPardakhtFish.fldId,Drd.tblNaghdi_Talab.fldShomareHesabId,isnull(fldTakhfifMaliyatValue,fldMaliyatValue)fldMaliyatValue,isnull(fldTakhfifAvarezValue,fldAvarezValue)fldAvarezValue
			
			 ,(SELECT        CASE WHEN fldHaghighiId IS NOT NULL THEN
                                                             (SELECT        fldName + ' ' + fldFamily
                                                                FROM            Com.tblEmployee
                                                                WHERE        fldId = fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN
                                                             (SELECT        fldName
                                                                FROM            Com.tblAshkhaseHoghoghi
                                                                WHERE        fldId = fldHoghoghiId) END AS Expr1
                                FROM            Com.tblAshkhas
                                WHERE        (fldId = Drd.tblElamAvarez.fldAshakhasID)) AS [Name],
                             (SELECT        CASE WHEN fldHaghighiId IS NOT NULL THEN
                                                             (SELECT        fldCodemeli
                                                                FROM            Com.tblEmployee
                                                                WHERE        fldId = fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN
                                                             (SELECT        fldShomareSabt
                                                                FROM            Com.tblAshkhaseHoghoghi
                                                                WHERE        fldId = fldHoghoghiId) END AS Expr1
                                FROM            Com.tblAshkhas
                                WHERE        (fldId = Drd.tblElamAvarez.fldAshakhasID)) AS Codemeli
                                        ,tblPardakhtFish.fldFishId,
                                       Drd.tblSodoorFish.fldTarikh  AS TarikhSodoor,tblNaghdi_Talab.fldFishId AS Naghfish,
                                ISNULL((SELECT fldTitle FROM Drd.tblPardakhtFish INNER JOIN
						 Drd.tblNahvePardakht ON tblNahvePardakht.fldId = tblPardakhtFish.fldNahvePardakhtId WHERE tblPardakhtFish.fldFishId=tblSodoorFish.fldId),N'') AS fldTitle 
			FROM            Drd.tblRequestTaghsit_Takhfif INNER JOIN
							Drd.tblStatusTaghsit_Takhfif ON Drd.tblRequestTaghsit_Takhfif.fldId = Drd.tblStatusTaghsit_Takhfif.fldRequestId INNER JOIN
							 Drd.tblReplyTaghsit ON Drd.tblStatusTaghsit_Takhfif.fldId = Drd.tblReplyTaghsit.fldStatusId INNER JOIN
							 Drd.tblElamAvarez ON Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId = Drd.tblElamAvarez.fldId INNER JOIN
							 Drd.tblCodhayeDaramadiElamAvarez ON Drd.tblElamAvarez.fldId = Drd.tblCodhayeDaramadiElamAvarez.fldElamAvarezId INNER JOIN
							 Drd.tblShomareHesabCodeDaramad ON Drd.tblCodhayeDaramadiElamAvarez.fldShomareHesabCodeDaramadId = Drd.tblShomareHesabCodeDaramad.fldId INNER JOIN
							 Drd.tblCodhayeDaramd AS tblCodhayeDaramd_1 ON Drd.tblShomareHesabCodeDaramad.fldCodeDaramadId = tblCodhayeDaramd_1.fldId INNER JOIN
							 Drd.tblNaghdi_Talab ON Drd.tblReplyTaghsit.fldId = Drd.tblNaghdi_Talab.fldReplyTaghsitId INNER JOIN
							 Com.tblShomareHesabeOmoomi ON Com.tblShomareHesabeOmoomi.fldId = Drd.tblNaghdi_Talab.fldShomareHesabId INNER JOIN
							 Drd.tblSodoorFish ON Drd.tblNaghdi_Talab.fldFishId = Drd.tblSodoorFish.fldId INNER JOIN
							 Drd.tblPardakhtFish ON Drd.tblSodoorFish.fldId = Drd.tblPardakhtFish.fldFishId 
							 WHERE fldRequestId NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=fldRequestId)
							AND tblNaghdi_Talab.fldType=1 
							AND CAST(tblPardakhtFish.fldDateVariz AS  DATE) BETWEEN @StartDate AND @EndDate AND tblShomareHesabCodeDaramad.fldOrganId=@OrganId
							AND tblShomareHesabCodeDaramad.fldOrganId=@OrganId
							 
							 GROUP BY tblRequestTaghsit_Takhfif.fldElamAvarezId,tblCodhayeDaramd_1.fldDaramadCode, 
							 Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad,fldMablagh,fldReplyTaghsitId, tblCodhayeDaramadiElamAvarez.fldElamAvarezId
							 ,tblNaghdi_Talab.fldShomareHesabId,fldShomareHesab,fldDaramadId,tblPardakhtFish.fldTarikhVariz ,tblPardakhtFish.fldId,tblNaghdi_Talab.fldShomareHesabId
						,fldMaliyatValue,fldAvarezValue,fldTakhfifMaliyatValue,fldTakhfifAvarezValue,fldAshakhasID,tblPardakhtFish.fldFishId
							, Drd.tblSodoorFish.fldTarikh,Drd.tblSodoorFish.fldId,tblNaghdi_Talab.fldFishId  )t)s
							  WHERE  s.fldShomareHesabId=@ShomareHesabId
					GROUP BY fldDaramadCode,fldSharheCodeDaramad,fldTarikh,[Name],Codemeli,fldFishId,TarikhSodoor,fldTitle,fldShomareHesab
					ORDER BY MIN(fldFishId)
					end
END

IF(@CodeDaramd<>'0' AND @ShomareHesabId=0)
BEGIN
	if(@DateType=1)/*براساس تاریخ پرداخت*/
	begin
		SELECT SUM(fldmablaghCodeDaramad) AS Mablagh,fldDaramadCode,fldSharheCodeDaramad,fldTarikh,[Name],Codemeli,fldFishId, TarikhSodoor,fldTitle,fldShomareHesab FROM
		(SELECT      tblCodhayeDaramd_1.fldDaramadCode, Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad, Com.tblShomareHesabeOmoomi.fldShomareHesab, 
								   ISNULL(cast((Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifAsliValue * Drd.tblCodhayeDaramadiElamAvarez.fldTedad +
								    Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifAvarezValue + Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifMaliyatValue)as bigint),
									  cast((Drd.tblCodhayeDaramadiElamAvarez.fldAsliValue * Drd.tblCodhayeDaramadiElamAvarez.fldTedad + Drd.tblCodhayeDaramadiElamAvarez.fldAvarezValue + 
									  Drd.tblCodhayeDaramadiElamAvarez.fldMaliyatValue)as bigint))
				AS fldmablaghCodeDaramad, '0' AS Expr1, tblCodhayeDaramd_1.fldDaramadId,tblPardakhtFish.fldTarikh,tblPardakhtFish.fldId,tblSodoorFish.fldShomareHesabId,
				isnull(fldTakhfifMaliyatValue,fldMaliyatValue)fldMaliyatValue,isnull(fldTakhfifAvarezValue,fldAvarezValue)fldAvarezValue
		,	 (SELECT        CASE WHEN fldHaghighiId IS NOT NULL THEN
                                                             (SELECT        fldName + ' ' + fldFamily
                                                                FROM            Com.tblEmployee
                                                                WHERE        fldId = fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN
                                                             (SELECT        fldName
                                                                FROM            Com.tblAshkhaseHoghoghi
                                                                WHERE        fldId = fldHoghoghiId) END AS Expr1
                                FROM            Com.tblAshkhas
                                WHERE        (fldId = Drd.tblElamAvarez.fldAshakhasID)) AS [Name],
                             (SELECT        CASE WHEN fldHaghighiId IS NOT NULL THEN
                                                             (SELECT        fldCodemeli
                                                                FROM            Com.tblEmployee
                                                                WHERE        fldId = fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN
                                                             (SELECT        fldShomareSabt
                                                                FROM            Com.tblAshkhaseHoghoghi
                                                                WHERE        fldId = fldHoghoghiId) END AS Expr1
                                FROM            Com.tblAshkhas
                                WHERE        (fldId = Drd.tblElamAvarez.fldAshakhasID)) AS Codemeli
                                ,tblPardakhtFish.fldFishId,Drd.tblSodoorFish.fldTarikh AS TarikhSodoor,
                                ISNULL((SELECT fldTitle FROM Drd.tblPardakhtFish INNER JOIN
						 Drd.tblNahvePardakht ON tblNahvePardakht.fldId = tblPardakhtFish.fldNahvePardakhtId WHERE tblPardakhtFish.fldFishId=tblSodoorFish.fldId),N'') AS fldTitle
                                			FROM            Drd.tblSodoorFish INNER JOIN
							 Drd.tblSodoorFish_Detail ON Drd.tblSodoorFish.fldId = Drd.tblSodoorFish_Detail.fldFishId INNER JOIN
							 Drd.tblCodhayeDaramadiElamAvarez ON Drd.tblSodoorFish_Detail.fldCodeElamAvarezId = Drd.tblCodhayeDaramadiElamAvarez.fldID INNER JOIN
							 Drd.tblShomareHesabCodeDaramad ON Drd.tblCodhayeDaramadiElamAvarez.fldShomareHesabCodeDaramadId = Drd.tblShomareHesabCodeDaramad.fldId AND 
							 Drd.tblCodhayeDaramadiElamAvarez.fldShomareHesabCodeDaramadId = Drd.tblShomareHesabCodeDaramad.fldId INNER JOIN
							 Drd.tblCodhayeDaramd AS tblCodhayeDaramd_1 ON Drd.tblShomareHesabCodeDaramad.fldCodeDaramadId = tblCodhayeDaramd_1.fldId INNER JOIN
							 Drd.tblPardakhtFish ON Drd.tblSodoorFish.fldId = Drd.tblPardakhtFish.fldFishId AND Drd.tblSodoorFish.fldId = Drd.tblPardakhtFish.fldFishId INNER JOIN
							 Com.tblShomareHesabeOmoomi ON Drd.tblSodoorFish.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId
							 INNER JOIN Drd.tblElamAvarez ON tblElamAvarez.fldId = tblCodhayeDaramadiElamAvarez.fldElamAvarezId
			WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId)
							 AND CAST( tblPardakhtFish.fldDatePardakht AS DATE) BETWEEN @StartDate AND @EndDate
							 AND Drd.tblShomareHesabCodeDaramad.fldOrganId=@OrganId
							 
			
			union all
			SELECT fldDaramadCode,fldSharheCodeDaramad,fldShomareHesab, cast(cast(fldMablaghNaghdi as numeric(50)) *cast(fldmablaghCodeDaramad as numeric(50))/cast(fldmablaghKoli as numeric(50))as bigint),'1'
			,fldDaramadId,fldTarikh,fldId,fldShomareHesabId,fldMaliyatValue,fldAvarezValue,[Name],Codemeli,fldFishId,TarikhSodoor,fldTitle
			 FROM 
			(SELECT   DISTINCT    Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId, tblCodhayeDaramd_1.fldDaramadCode, 
									 Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad
									,Drd.fn_SumMablaghNaghdi('Naghdi_Talab',tblNaghdi_Talab.fldFishId,tblNaghdi_Talab.fldShomareHesabId,@azTarikh ,@Tatarikh) AS fldMablaghNaghdi
									,fldShomareHesab ,fldReplyTaghsitId
				,ISNULL(SUM(fldTakhfifAsliValue*fldTedad+fldTakhfifAvarezValue+fldTakhfifMaliyatValue),SUM(fldAsliValue*fldTedad+fldAvarezValue+fldMaliyatValue)) AS fldmablaghCodeDaramad
				,(SELECT TOP(1) ISNULL(SUM(fldTakhfifAsliValue*fldTedad+fldTakhfifAvarezValue+fldTakhfifMaliyatValue) OVER (PARTITION BY tblCodhayeDaramadiElamAvarez.fldElamAvarezId),
				SUM(fldAsliValue*fldTedad+fldAvarezValue+fldMaliyatValue) OVER (PARTITION BY tblCodhayeDaramadiElamAvarez.fldElamAvarezId)) FROM Drd.tblCodhayeDaramadiElamAvarez AS a WHERE
				 a.fldElamAvarezId =Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId) AS fldmablaghKoli
			,tblCodhayeDaramd_1.fldDaramadId,tblPardakhtFish.fldTarikh,tblPardakhtFish.fldId,Drd.tblNaghdi_Talab.fldShomareHesabId,isnull(fldTakhfifMaliyatValue,fldMaliyatValue)fldMaliyatValue,
			isnull(fldTakhfifAvarezValue,fldAvarezValue)fldAvarezValue
			
			 ,(SELECT        CASE WHEN fldHaghighiId IS NOT NULL THEN
                                                             (SELECT        fldName + ' ' + fldFamily
                                                                FROM            Com.tblEmployee
                                                                WHERE        fldId = fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN
                                                             (SELECT        fldName
                                                                FROM            Com.tblAshkhaseHoghoghi
                                                                WHERE        fldId = fldHoghoghiId) END AS Expr1
                                FROM            Com.tblAshkhas
                                WHERE        (fldId = Drd.tblElamAvarez.fldAshakhasID)) AS [Name],
                             (SELECT        CASE WHEN fldHaghighiId IS NOT NULL THEN
                                                             (SELECT        fldCodemeli
                                                                FROM            Com.tblEmployee
                                                                WHERE        fldId = fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN
                                                             (SELECT        fldShomareSabt
                                                                FROM            Com.tblAshkhaseHoghoghi
                                                                WHERE        fldId = fldHoghoghiId) END AS Expr1
                                FROM            Com.tblAshkhas
                                WHERE        (fldId = Drd.tblElamAvarez.fldAshakhasID)) AS Codemeli
                                        ,tblPardakhtFish.fldFishId,
                                       Drd.tblSodoorFish.fldTarikh  AS TarikhSodoor,tblNaghdi_Talab.fldFishId AS Naghfish,
                                ISNULL((SELECT fldTitle FROM Drd.tblPardakhtFish INNER JOIN
						 Drd.tblNahvePardakht ON tblNahvePardakht.fldId = tblPardakhtFish.fldNahvePardakhtId WHERE tblPardakhtFish.fldFishId=tblSodoorFish.fldId),N'') AS fldTitle 
			FROM            Drd.tblRequestTaghsit_Takhfif INNER JOIN
							Drd.tblStatusTaghsit_Takhfif ON Drd.tblRequestTaghsit_Takhfif.fldId = Drd.tblStatusTaghsit_Takhfif.fldRequestId INNER JOIN
							 Drd.tblReplyTaghsit ON Drd.tblStatusTaghsit_Takhfif.fldId = Drd.tblReplyTaghsit.fldStatusId INNER JOIN
							 Drd.tblElamAvarez ON Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId = Drd.tblElamAvarez.fldId INNER JOIN
							 Drd.tblCodhayeDaramadiElamAvarez ON Drd.tblElamAvarez.fldId = Drd.tblCodhayeDaramadiElamAvarez.fldElamAvarezId INNER JOIN
							 Drd.tblShomareHesabCodeDaramad ON Drd.tblCodhayeDaramadiElamAvarez.fldShomareHesabCodeDaramadId = Drd.tblShomareHesabCodeDaramad.fldId INNER JOIN
							 Drd.tblCodhayeDaramd AS tblCodhayeDaramd_1 ON Drd.tblShomareHesabCodeDaramad.fldCodeDaramadId = tblCodhayeDaramd_1.fldId INNER JOIN
							 Drd.tblNaghdi_Talab ON Drd.tblReplyTaghsit.fldId = Drd.tblNaghdi_Talab.fldReplyTaghsitId INNER JOIN
							 Com.tblShomareHesabeOmoomi ON Com.tblShomareHesabeOmoomi.fldId = Drd.tblNaghdi_Talab.fldShomareHesabId INNER JOIN
							 Drd.tblSodoorFish ON Drd.tblNaghdi_Talab.fldFishId = Drd.tblSodoorFish.fldId INNER JOIN
							 Drd.tblPardakhtFish ON Drd.tblSodoorFish.fldId = Drd.tblPardakhtFish.fldFishId 
							 WHERE fldRequestId NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=fldRequestId)
							AND tblNaghdi_Talab.fldType=1 
							AND CAST(tblPardakhtFish.fldDatePardakht AS  DATE) BETWEEN @StartDate AND @EndDate AND tblShomareHesabCodeDaramad.fldOrganId=@OrganId
							AND tblShomareHesabCodeDaramad.fldOrganId=@OrganId
							 
							 GROUP BY tblRequestTaghsit_Takhfif.fldElamAvarezId,tblCodhayeDaramd_1.fldDaramadCode, 
							 Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad,fldMablagh,fldReplyTaghsitId, tblCodhayeDaramadiElamAvarez.fldElamAvarezId
							 ,tblNaghdi_Talab.fldShomareHesabId,fldShomareHesab,fldDaramadId,tblPardakhtFish.fldTarikh,tblPardakhtFish.fldId,tblNaghdi_Talab.fldShomareHesabId
						,fldMaliyatValue,fldAvarezValue,fldTakhfifMaliyatValue,fldTakhfifAvarezValue,fldAshakhasID,tblPardakhtFish.fldFishId
							, Drd.tblSodoorFish.fldTarikh,Drd.tblSodoorFish.fldId,tblNaghdi_Talab.fldFishId  )t)s
							  WHERE  s.fldDaramadCode=@CodeDaramd
GROUP BY fldDaramadCode,fldSharheCodeDaramad,fldTarikh,[Name],Codemeli,fldFishId,TarikhSodoor,fldTitle,fldShomareHesab
ORDER BY MIN(fldFishId)
END
if(@DateType=0)/*براساس تاریخ پرداخت*/
	begin
		SELECT SUM(fldmablaghCodeDaramad) AS Mablagh,fldDaramadCode,fldSharheCodeDaramad,fldTarikh,[Name],Codemeli,fldFishId, TarikhSodoor,fldTitle,fldShomareHesab FROM
		(SELECT      tblCodhayeDaramd_1.fldDaramadCode, Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad, Com.tblShomareHesabeOmoomi.fldShomareHesab, 
								   ISNULL(cast((Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifAsliValue * Drd.tblCodhayeDaramadiElamAvarez.fldTedad +
								    Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifAvarezValue + Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifMaliyatValue)as bigint),
									  cast((Drd.tblCodhayeDaramadiElamAvarez.fldAsliValue * Drd.tblCodhayeDaramadiElamAvarez.fldTedad + Drd.tblCodhayeDaramadiElamAvarez.fldAvarezValue + 
									  Drd.tblCodhayeDaramadiElamAvarez.fldMaliyatValue)as bigint))
				AS fldmablaghCodeDaramad, '0' AS Expr1, tblCodhayeDaramd_1.fldDaramadId,tblPardakhtFish.fldTarikhVariz fldTarikh,tblPardakhtFish.fldId,tblSodoorFish.fldShomareHesabId,
				isnull(fldTakhfifMaliyatValue,fldMaliyatValue)fldMaliyatValue,isnull(fldTakhfifAvarezValue,fldAvarezValue)fldAvarezValue
		,	 (SELECT        CASE WHEN fldHaghighiId IS NOT NULL THEN
                                                             (SELECT        fldName + ' ' + fldFamily
                                                                FROM            Com.tblEmployee
                                                                WHERE        fldId = fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN
                                                             (SELECT        fldName
                                                                FROM            Com.tblAshkhaseHoghoghi
                                                                WHERE        fldId = fldHoghoghiId) END AS Expr1
                                FROM            Com.tblAshkhas
                                WHERE        (fldId = Drd.tblElamAvarez.fldAshakhasID)) AS [Name],
                             (SELECT        CASE WHEN fldHaghighiId IS NOT NULL THEN
                                                             (SELECT        fldCodemeli
                                                                FROM            Com.tblEmployee
                                                                WHERE        fldId = fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN
                                                             (SELECT        fldShomareSabt
                                                                FROM            Com.tblAshkhaseHoghoghi
                                                                WHERE        fldId = fldHoghoghiId) END AS Expr1
                                FROM            Com.tblAshkhas
                                WHERE        (fldId = Drd.tblElamAvarez.fldAshakhasID)) AS Codemeli
                                ,tblPardakhtFish.fldFishId,Drd.tblSodoorFish.fldTarikh AS TarikhSodoor,
                                ISNULL((SELECT fldTitle FROM Drd.tblPardakhtFish INNER JOIN
						 Drd.tblNahvePardakht ON tblNahvePardakht.fldId = tblPardakhtFish.fldNahvePardakhtId WHERE tblPardakhtFish.fldFishId=tblSodoorFish.fldId),N'') AS fldTitle
                                			FROM            Drd.tblSodoorFish INNER JOIN
							 Drd.tblSodoorFish_Detail ON Drd.tblSodoorFish.fldId = Drd.tblSodoorFish_Detail.fldFishId INNER JOIN
							 Drd.tblCodhayeDaramadiElamAvarez ON Drd.tblSodoorFish_Detail.fldCodeElamAvarezId = Drd.tblCodhayeDaramadiElamAvarez.fldID INNER JOIN
							 Drd.tblShomareHesabCodeDaramad ON Drd.tblCodhayeDaramadiElamAvarez.fldShomareHesabCodeDaramadId = Drd.tblShomareHesabCodeDaramad.fldId AND 
							 Drd.tblCodhayeDaramadiElamAvarez.fldShomareHesabCodeDaramadId = Drd.tblShomareHesabCodeDaramad.fldId INNER JOIN
							 Drd.tblCodhayeDaramd AS tblCodhayeDaramd_1 ON Drd.tblShomareHesabCodeDaramad.fldCodeDaramadId = tblCodhayeDaramd_1.fldId INNER JOIN
							 Drd.tblPardakhtFish ON Drd.tblSodoorFish.fldId = Drd.tblPardakhtFish.fldFishId AND Drd.tblSodoorFish.fldId = Drd.tblPardakhtFish.fldFishId INNER JOIN
							 Com.tblShomareHesabeOmoomi ON Drd.tblSodoorFish.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId
							 INNER JOIN Drd.tblElamAvarez ON tblElamAvarez.fldId = tblCodhayeDaramadiElamAvarez.fldElamAvarezId
			WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId)
							 AND CAST( tblPardakhtFish.fldDateVariz AS DATE) BETWEEN @StartDate AND @EndDate
							 AND Drd.tblShomareHesabCodeDaramad.fldOrganId=@OrganId
							 
			
			union all
			SELECT fldDaramadCode,fldSharheCodeDaramad,fldShomareHesab, cast(cast(fldMablaghNaghdi as numeric(50)) *cast(fldmablaghCodeDaramad as numeric(50))/cast(fldmablaghKoli as numeric(50))as bigint),'1'
			,fldDaramadId,fldTarikh,fldId,fldShomareHesabId,fldMaliyatValue,fldAvarezValue,[Name],Codemeli,fldFishId,TarikhSodoor,fldTitle
			 FROM 
			(SELECT   DISTINCT    Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId, tblCodhayeDaramd_1.fldDaramadCode, 
									 Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad
									,Drd.fn_SumMablaghNaghdi('Naghdi_Talab',tblNaghdi_Talab.fldFishId,tblNaghdi_Talab.fldShomareHesabId,@azTarikh ,@Tatarikh) AS fldMablaghNaghdi
									,fldShomareHesab ,fldReplyTaghsitId
				,ISNULL(SUM(fldTakhfifAsliValue*fldTedad+fldTakhfifAvarezValue+fldTakhfifMaliyatValue),SUM(fldAsliValue*fldTedad+fldAvarezValue+fldMaliyatValue)) AS fldmablaghCodeDaramad
				,(SELECT TOP(1) ISNULL(SUM(fldTakhfifAsliValue*fldTedad+fldTakhfifAvarezValue+fldTakhfifMaliyatValue) OVER (PARTITION BY tblCodhayeDaramadiElamAvarez.fldElamAvarezId),
				SUM(fldAsliValue*fldTedad+fldAvarezValue+fldMaliyatValue) OVER (PARTITION BY tblCodhayeDaramadiElamAvarez.fldElamAvarezId)) FROM Drd.tblCodhayeDaramadiElamAvarez AS a WHERE
				 a.fldElamAvarezId =Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId) AS fldmablaghKoli
			,tblCodhayeDaramd_1.fldDaramadId,tblPardakhtFish.fldTarikhVariz fldTarikh,tblPardakhtFish.fldId,Drd.tblNaghdi_Talab.fldShomareHesabId,isnull(fldTakhfifMaliyatValue,fldMaliyatValue)fldMaliyatValue,
			isnull(fldTakhfifAvarezValue,fldAvarezValue)fldAvarezValue
			
			 ,(SELECT        CASE WHEN fldHaghighiId IS NOT NULL THEN
                                                             (SELECT        fldName + ' ' + fldFamily
                                                                FROM            Com.tblEmployee
                                                                WHERE        fldId = fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN
                                                             (SELECT        fldName
                                                                FROM            Com.tblAshkhaseHoghoghi
                                                                WHERE        fldId = fldHoghoghiId) END AS Expr1
                                FROM            Com.tblAshkhas
                                WHERE        (fldId = Drd.tblElamAvarez.fldAshakhasID)) AS [Name],
                             (SELECT        CASE WHEN fldHaghighiId IS NOT NULL THEN
                                                             (SELECT        fldCodemeli
                                                                FROM            Com.tblEmployee
                                                                WHERE        fldId = fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN
                                                             (SELECT        fldShomareSabt
                                                                FROM            Com.tblAshkhaseHoghoghi
                                                                WHERE        fldId = fldHoghoghiId) END AS Expr1
                                FROM            Com.tblAshkhas
                                WHERE        (fldId = Drd.tblElamAvarez.fldAshakhasID)) AS Codemeli
                                        ,tblPardakhtFish.fldFishId,
                                       Drd.tblSodoorFish.fldTarikh  AS TarikhSodoor,tblNaghdi_Talab.fldFishId AS Naghfish,
                                ISNULL((SELECT fldTitle FROM Drd.tblPardakhtFish INNER JOIN
						 Drd.tblNahvePardakht ON tblNahvePardakht.fldId = tblPardakhtFish.fldNahvePardakhtId WHERE tblPardakhtFish.fldFishId=tblSodoorFish.fldId),N'') AS fldTitle 
			FROM            Drd.tblRequestTaghsit_Takhfif INNER JOIN
							Drd.tblStatusTaghsit_Takhfif ON Drd.tblRequestTaghsit_Takhfif.fldId = Drd.tblStatusTaghsit_Takhfif.fldRequestId INNER JOIN
							 Drd.tblReplyTaghsit ON Drd.tblStatusTaghsit_Takhfif.fldId = Drd.tblReplyTaghsit.fldStatusId INNER JOIN
							 Drd.tblElamAvarez ON Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId = Drd.tblElamAvarez.fldId INNER JOIN
							 Drd.tblCodhayeDaramadiElamAvarez ON Drd.tblElamAvarez.fldId = Drd.tblCodhayeDaramadiElamAvarez.fldElamAvarezId INNER JOIN
							 Drd.tblShomareHesabCodeDaramad ON Drd.tblCodhayeDaramadiElamAvarez.fldShomareHesabCodeDaramadId = Drd.tblShomareHesabCodeDaramad.fldId INNER JOIN
							 Drd.tblCodhayeDaramd AS tblCodhayeDaramd_1 ON Drd.tblShomareHesabCodeDaramad.fldCodeDaramadId = tblCodhayeDaramd_1.fldId INNER JOIN
							 Drd.tblNaghdi_Talab ON Drd.tblReplyTaghsit.fldId = Drd.tblNaghdi_Talab.fldReplyTaghsitId INNER JOIN
							 Com.tblShomareHesabeOmoomi ON Com.tblShomareHesabeOmoomi.fldId = Drd.tblNaghdi_Talab.fldShomareHesabId INNER JOIN
							 Drd.tblSodoorFish ON Drd.tblNaghdi_Talab.fldFishId = Drd.tblSodoorFish.fldId INNER JOIN
							 Drd.tblPardakhtFish ON Drd.tblSodoorFish.fldId = Drd.tblPardakhtFish.fldFishId 
							 WHERE fldRequestId NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=fldRequestId)
							AND tblNaghdi_Talab.fldType=1 
							AND CAST(tblPardakhtFish.fldDateVariz AS  DATE) BETWEEN @StartDate AND @EndDate AND tblShomareHesabCodeDaramad.fldOrganId=@OrganId
							AND tblShomareHesabCodeDaramad.fldOrganId=@OrganId
							 
							 GROUP BY tblRequestTaghsit_Takhfif.fldElamAvarezId,tblCodhayeDaramd_1.fldDaramadCode, 
							 Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad,fldMablagh,fldReplyTaghsitId, tblCodhayeDaramadiElamAvarez.fldElamAvarezId
							 ,tblNaghdi_Talab.fldShomareHesabId,fldShomareHesab,fldDaramadId,tblPardakhtFish.fldTarikhVariz,tblPardakhtFish.fldId,tblNaghdi_Talab.fldShomareHesabId
						,fldMaliyatValue,fldAvarezValue,fldTakhfifMaliyatValue,fldTakhfifAvarezValue,fldAshakhasID,tblPardakhtFish.fldFishId
							, Drd.tblSodoorFish.fldTarikh,Drd.tblSodoorFish.fldId,tblNaghdi_Talab.fldFishId  )t)s
							  WHERE  s.fldDaramadCode=@CodeDaramd
		GROUP BY fldDaramadCode,fldSharheCodeDaramad,fldTarikh,[Name],Codemeli,fldFishId,TarikhSodoor,fldTitle,fldShomareHesab
		ORDER BY MIN(fldFishId)
		END
END

IF(@CodeDaramd='0' AND @ShomareHesabId=0)
BEGIN
	if(@DateType=1)/*براساس تاریخ پرداخت*/
	begin
		SELECT SUM(fldmablaghCodeDaramad) AS Mablagh,fldDaramadCode,fldSharheCodeDaramad,fldTarikh,[Name],Codemeli,fldFishId, TarikhSodoor,fldTitle,fldShomareHesab FROM
		(SELECT      tblCodhayeDaramd_1.fldDaramadCode, Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad, Com.tblShomareHesabeOmoomi.fldShomareHesab, 
								   ISNULL(cast((Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifAsliValue * Drd.tblCodhayeDaramadiElamAvarez.fldTedad + 
								   Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifAvarezValue + Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifMaliyatValue)as bigint),
									  cast((Drd.tblCodhayeDaramadiElamAvarez.fldAsliValue * Drd.tblCodhayeDaramadiElamAvarez.fldTedad + Drd.tblCodhayeDaramadiElamAvarez.fldAvarezValue
									   + Drd.tblCodhayeDaramadiElamAvarez.fldMaliyatValue)as bigint))
				AS fldmablaghCodeDaramad, '0' AS Expr1, tblCodhayeDaramd_1.fldDaramadId,tblPardakhtFish.fldTarikh,tblPardakhtFish.fldId,tblSodoorFish.fldShomareHesabId,
				isnull(fldTakhfifMaliyatValue,fldMaliyatValue)fldMaliyatValue,isnull(fldTakhfifAvarezValue,fldAvarezValue)fldAvarezValue
		,	 (SELECT        CASE WHEN fldHaghighiId IS NOT NULL THEN
                                                             (SELECT        fldName + ' ' + fldFamily
                                                                FROM            Com.tblEmployee
                                                                WHERE        fldId = fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN
                                                             (SELECT        fldName
                                                                FROM            Com.tblAshkhaseHoghoghi
                                                                WHERE        fldId = fldHoghoghiId) END AS Expr1
                                FROM            Com.tblAshkhas
                                WHERE        (fldId = Drd.tblElamAvarez.fldAshakhasID)) AS [Name],
                             (SELECT        CASE WHEN fldHaghighiId IS NOT NULL THEN
                                                             (SELECT        fldCodemeli
                                                                FROM            Com.tblEmployee
                                                                WHERE        fldId = fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN
                                                             (SELECT        fldShomareSabt
                                                                FROM            Com.tblAshkhaseHoghoghi
                                                                WHERE        fldId = fldHoghoghiId) END AS Expr1
                                FROM            Com.tblAshkhas
                                WHERE        (fldId = Drd.tblElamAvarez.fldAshakhasID)) AS Codemeli
                                ,tblPardakhtFish.fldFishId,Drd.tblSodoorFish.fldTarikh AS TarikhSodoor,
                                ISNULL((SELECT fldTitle FROM Drd.tblPardakhtFish INNER JOIN
						 Drd.tblNahvePardakht ON tblNahvePardakht.fldId = tblPardakhtFish.fldNahvePardakhtId WHERE tblPardakhtFish.fldFishId=tblSodoorFish.fldId),N'') AS fldTitle
                                			FROM            Drd.tblSodoorFish INNER JOIN
							 Drd.tblSodoorFish_Detail ON Drd.tblSodoorFish.fldId = Drd.tblSodoorFish_Detail.fldFishId INNER JOIN
							 Drd.tblCodhayeDaramadiElamAvarez ON Drd.tblSodoorFish_Detail.fldCodeElamAvarezId = Drd.tblCodhayeDaramadiElamAvarez.fldID INNER JOIN
							 Drd.tblShomareHesabCodeDaramad ON Drd.tblCodhayeDaramadiElamAvarez.fldShomareHesabCodeDaramadId = Drd.tblShomareHesabCodeDaramad.fldId AND 
							 Drd.tblCodhayeDaramadiElamAvarez.fldShomareHesabCodeDaramadId = Drd.tblShomareHesabCodeDaramad.fldId INNER JOIN
							 Drd.tblCodhayeDaramd AS tblCodhayeDaramd_1 ON Drd.tblShomareHesabCodeDaramad.fldCodeDaramadId = tblCodhayeDaramd_1.fldId INNER JOIN
							 Drd.tblPardakhtFish ON Drd.tblSodoorFish.fldId = Drd.tblPardakhtFish.fldFishId AND Drd.tblSodoorFish.fldId = Drd.tblPardakhtFish.fldFishId INNER JOIN
							 Com.tblShomareHesabeOmoomi ON Drd.tblSodoorFish.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId
							 INNER JOIN Drd.tblElamAvarez ON tblElamAvarez.fldId = tblCodhayeDaramadiElamAvarez.fldElamAvarezId
			WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId)
							 AND CAST( tblPardakhtFish.fldDatePardakht AS DATE) BETWEEN @StartDate AND @EndDate
							 AND Drd.tblShomareHesabCodeDaramad.fldOrganId=@OrganId
							 
			
			union all
			SELECT fldDaramadCode,fldSharheCodeDaramad,fldShomareHesab,cast(cast(fldMablaghNaghdi as numeric(50)) *cast(fldmablaghCodeDaramad as numeric(50))/cast(fldmablaghKoli as numeric(50))as bigint),'1'
			,fldDaramadId,fldTarikh,fldId,fldShomareHesabId,fldMaliyatValue,fldAvarezValue,[Name],Codemeli,fldFishId,TarikhSodoor,fldTitle
			 FROM 
			(SELECT   DISTINCT    Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId, tblCodhayeDaramd_1.fldDaramadCode, 
									 Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad
									,Drd.fn_SumMablaghNaghdi('Naghdi_Talab',tblNaghdi_Talab.fldFishId,tblNaghdi_Talab.fldShomareHesabId,@azTarikh ,@Tatarikh) AS fldMablaghNaghdi
									,fldShomareHesab ,fldReplyTaghsitId
				,ISNULL(SUM(fldTakhfifAsliValue*fldTedad+fldTakhfifAvarezValue+fldTakhfifMaliyatValue),SUM(fldAsliValue*fldTedad+fldAvarezValue+fldMaliyatValue)) AS fldmablaghCodeDaramad
				,(SELECT TOP(1) ISNULL(SUM(fldTakhfifAsliValue*fldTedad+fldTakhfifAvarezValue+fldTakhfifMaliyatValue) OVER (PARTITION BY tblCodhayeDaramadiElamAvarez.fldElamAvarezId),
				SUM(fldAsliValue*fldTedad+fldAvarezValue+fldMaliyatValue) OVER (PARTITION BY tblCodhayeDaramadiElamAvarez.fldElamAvarezId)) FROM Drd.tblCodhayeDaramadiElamAvarez AS a 
				WHERE a.fldElamAvarezId =Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId) AS fldmablaghKoli
			,tblCodhayeDaramd_1.fldDaramadId,tblPardakhtFish.fldTarikh,tblPardakhtFish.fldId,Drd.tblNaghdi_Talab.fldShomareHesabId,isnull(fldTakhfifMaliyatValue,fldMaliyatValue)fldMaliyatValue,
			isnull(fldTakhfifAvarezValue,fldAvarezValue)fldAvarezValue
			
			 ,(SELECT        CASE WHEN fldHaghighiId IS NOT NULL THEN
                                                             (SELECT        fldName + ' ' + fldFamily
                                                                FROM            Com.tblEmployee
                                                                WHERE        fldId = fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN
                                                             (SELECT        fldName
                                                                FROM            Com.tblAshkhaseHoghoghi
                                                                WHERE        fldId = fldHoghoghiId) END AS Expr1
                                FROM            Com.tblAshkhas
                                WHERE        (fldId = Drd.tblElamAvarez.fldAshakhasID)) AS [Name],
                             (SELECT        CASE WHEN fldHaghighiId IS NOT NULL THEN
                                                             (SELECT        fldCodemeli
                                                                FROM            Com.tblEmployee
                                                                WHERE        fldId = fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN
                                                             (SELECT        fldShomareSabt
                                                                FROM            Com.tblAshkhaseHoghoghi
                                                                WHERE        fldId = fldHoghoghiId) END AS Expr1
                                FROM            Com.tblAshkhas
                                WHERE        (fldId = Drd.tblElamAvarez.fldAshakhasID)) AS Codemeli
                                        ,tblPardakhtFish.fldFishId,
                                       Drd.tblSodoorFish.fldTarikh  AS TarikhSodoor,tblNaghdi_Talab.fldFishId AS Naghfish,
                                ISNULL((SELECT fldTitle FROM Drd.tblPardakhtFish INNER JOIN
						 Drd.tblNahvePardakht ON tblNahvePardakht.fldId = tblPardakhtFish.fldNahvePardakhtId WHERE tblPardakhtFish.fldFishId=tblSodoorFish.fldId),N'') AS fldTitle 
			FROM            Drd.tblRequestTaghsit_Takhfif INNER JOIN
							Drd.tblStatusTaghsit_Takhfif ON Drd.tblRequestTaghsit_Takhfif.fldId = Drd.tblStatusTaghsit_Takhfif.fldRequestId INNER JOIN
							 Drd.tblReplyTaghsit ON Drd.tblStatusTaghsit_Takhfif.fldId = Drd.tblReplyTaghsit.fldStatusId INNER JOIN
							 Drd.tblElamAvarez ON Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId = Drd.tblElamAvarez.fldId INNER JOIN
							 Drd.tblCodhayeDaramadiElamAvarez ON Drd.tblElamAvarez.fldId = Drd.tblCodhayeDaramadiElamAvarez.fldElamAvarezId INNER JOIN
							 Drd.tblShomareHesabCodeDaramad ON Drd.tblCodhayeDaramadiElamAvarez.fldShomareHesabCodeDaramadId = Drd.tblShomareHesabCodeDaramad.fldId INNER JOIN
							 Drd.tblCodhayeDaramd AS tblCodhayeDaramd_1 ON Drd.tblShomareHesabCodeDaramad.fldCodeDaramadId = tblCodhayeDaramd_1.fldId INNER JOIN
							 Drd.tblNaghdi_Talab ON Drd.tblReplyTaghsit.fldId = Drd.tblNaghdi_Talab.fldReplyTaghsitId INNER JOIN
							 Com.tblShomareHesabeOmoomi ON Com.tblShomareHesabeOmoomi.fldId = Drd.tblNaghdi_Talab.fldShomareHesabId INNER JOIN
							 Drd.tblSodoorFish ON Drd.tblNaghdi_Talab.fldFishId = Drd.tblSodoorFish.fldId INNER JOIN
							 Drd.tblPardakhtFish ON Drd.tblSodoorFish.fldId = Drd.tblPardakhtFish.fldFishId 
							 WHERE fldRequestId NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=fldRequestId)
							AND tblNaghdi_Talab.fldType=1 
							AND CAST(tblPardakhtFish.fldDatePardakht AS  DATE) BETWEEN @StartDate AND @EndDate AND tblShomareHesabCodeDaramad.fldOrganId=@OrganId
							AND tblShomareHesabCodeDaramad.fldOrganId=@OrganId
							 
							 GROUP BY tblRequestTaghsit_Takhfif.fldElamAvarezId,tblCodhayeDaramd_1.fldDaramadCode, 
							 Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad,fldMablagh,fldReplyTaghsitId, tblCodhayeDaramadiElamAvarez.fldElamAvarezId
							 ,tblNaghdi_Talab.fldShomareHesabId,fldShomareHesab,fldDaramadId,tblPardakhtFish.fldTarikh,tblPardakhtFish.fldId,tblNaghdi_Talab.fldShomareHesabId
						,fldMaliyatValue,fldAvarezValue,fldTakhfifMaliyatValue,fldTakhfifAvarezValue,fldAshakhasID,tblPardakhtFish.fldFishId
							, Drd.tblSodoorFish.fldTarikh,Drd.tblSodoorFish.fldId,tblNaghdi_Talab.fldFishId  )t)s
				GROUP BY fldDaramadCode,fldSharheCodeDaramad,fldTarikh,[Name],Codemeli,fldFishId,TarikhSodoor,fldTitle,fldShomareHesab
				ORDER BY MIN(fldFishId)
				end
	else if(@DateType=0)/*براساس تاریخ واریز*/
	begin
		SELECT SUM(fldmablaghCodeDaramad) AS Mablagh,fldDaramadCode,fldSharheCodeDaramad,fldTarikh,[Name],Codemeli,fldFishId, TarikhSodoor,fldTitle,fldShomareHesab FROM
		(SELECT      tblCodhayeDaramd_1.fldDaramadCode, Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad, Com.tblShomareHesabeOmoomi.fldShomareHesab, 
								   ISNULL(cast((Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifAsliValue * Drd.tblCodhayeDaramadiElamAvarez.fldTedad + 
								   Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifAvarezValue + Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifMaliyatValue)as bigint),
									  cast((Drd.tblCodhayeDaramadiElamAvarez.fldAsliValue * Drd.tblCodhayeDaramadiElamAvarez.fldTedad + Drd.tblCodhayeDaramadiElamAvarez.fldAvarezValue
									   + Drd.tblCodhayeDaramadiElamAvarez.fldMaliyatValue)as bigint))
				AS fldmablaghCodeDaramad, '0' AS Expr1, tblCodhayeDaramd_1.fldDaramadId,tblPardakhtFish.fldTarikhVariz fldTarikh,tblPardakhtFish.fldId,tblSodoorFish.fldShomareHesabId,
				isnull(fldTakhfifMaliyatValue,fldMaliyatValue)fldMaliyatValue,isnull(fldTakhfifAvarezValue,fldAvarezValue)fldAvarezValue
		,	 (SELECT        CASE WHEN fldHaghighiId IS NOT NULL THEN
                                                             (SELECT        fldName + ' ' + fldFamily
                                                                FROM            Com.tblEmployee
                                                                WHERE        fldId = fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN
                                                             (SELECT        fldName
                                                                FROM            Com.tblAshkhaseHoghoghi
                                                                WHERE        fldId = fldHoghoghiId) END AS Expr1
                                FROM            Com.tblAshkhas
                                WHERE        (fldId = Drd.tblElamAvarez.fldAshakhasID)) AS [Name],
                             (SELECT        CASE WHEN fldHaghighiId IS NOT NULL THEN
                                                             (SELECT        fldCodemeli
                                                                FROM            Com.tblEmployee
                                                                WHERE        fldId = fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN
                                                             (SELECT        fldShomareSabt
                                                                FROM            Com.tblAshkhaseHoghoghi
                                                                WHERE        fldId = fldHoghoghiId) END AS Expr1
                                FROM            Com.tblAshkhas
                                WHERE        (fldId = Drd.tblElamAvarez.fldAshakhasID)) AS Codemeli
                                ,tblPardakhtFish.fldFishId,Drd.tblSodoorFish.fldTarikh AS TarikhSodoor,
                                ISNULL((SELECT fldTitle FROM Drd.tblPardakhtFish INNER JOIN
						 Drd.tblNahvePardakht ON tblNahvePardakht.fldId = tblPardakhtFish.fldNahvePardakhtId WHERE tblPardakhtFish.fldFishId=tblSodoorFish.fldId),N'') AS fldTitle
                                			FROM            Drd.tblSodoorFish INNER JOIN
							 Drd.tblSodoorFish_Detail ON Drd.tblSodoorFish.fldId = Drd.tblSodoorFish_Detail.fldFishId INNER JOIN
							 Drd.tblCodhayeDaramadiElamAvarez ON Drd.tblSodoorFish_Detail.fldCodeElamAvarezId = Drd.tblCodhayeDaramadiElamAvarez.fldID INNER JOIN
							 Drd.tblShomareHesabCodeDaramad ON Drd.tblCodhayeDaramadiElamAvarez.fldShomareHesabCodeDaramadId = Drd.tblShomareHesabCodeDaramad.fldId AND 
							 Drd.tblCodhayeDaramadiElamAvarez.fldShomareHesabCodeDaramadId = Drd.tblShomareHesabCodeDaramad.fldId INNER JOIN
							 Drd.tblCodhayeDaramd AS tblCodhayeDaramd_1 ON Drd.tblShomareHesabCodeDaramad.fldCodeDaramadId = tblCodhayeDaramd_1.fldId INNER JOIN
							 Drd.tblPardakhtFish ON Drd.tblSodoorFish.fldId = Drd.tblPardakhtFish.fldFishId AND Drd.tblSodoorFish.fldId = Drd.tblPardakhtFish.fldFishId INNER JOIN
							 Com.tblShomareHesabeOmoomi ON Drd.tblSodoorFish.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId
							 INNER JOIN Drd.tblElamAvarez ON tblElamAvarez.fldId = tblCodhayeDaramadiElamAvarez.fldElamAvarezId
			WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId)
							 AND CAST( tblPardakhtFish.fldDateVariz AS DATE) BETWEEN @StartDate AND @EndDate
							 AND Drd.tblShomareHesabCodeDaramad.fldOrganId=@OrganId
							 
			
			union all
			SELECT fldDaramadCode,fldSharheCodeDaramad,fldShomareHesab,cast(cast(fldMablaghNaghdi as numeric(50)) *cast(fldmablaghCodeDaramad as numeric(50))/cast(fldmablaghKoli as numeric(50))as bigint),'1'
			,fldDaramadId,fldTarikh,fldId,fldShomareHesabId,fldMaliyatValue,fldAvarezValue,[Name],Codemeli,fldFishId,TarikhSodoor,fldTitle
			 FROM 
			(SELECT   DISTINCT    Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId, tblCodhayeDaramd_1.fldDaramadCode, 
									 Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad
									,Drd.fn_SumMablaghNaghdi('Naghdi_Talab',tblNaghdi_Talab.fldFishId,tblNaghdi_Talab.fldShomareHesabId,@azTarikh ,@Tatarikh) AS fldMablaghNaghdi
									,fldShomareHesab ,fldReplyTaghsitId
				,ISNULL(SUM(fldTakhfifAsliValue*fldTedad+fldTakhfifAvarezValue+fldTakhfifMaliyatValue),SUM(fldAsliValue*fldTedad+fldAvarezValue+fldMaliyatValue)) AS fldmablaghCodeDaramad
				,(SELECT TOP(1) ISNULL(SUM(fldTakhfifAsliValue*fldTedad+fldTakhfifAvarezValue+fldTakhfifMaliyatValue) OVER (PARTITION BY tblCodhayeDaramadiElamAvarez.fldElamAvarezId),
				SUM(fldAsliValue*fldTedad+fldAvarezValue+fldMaliyatValue) OVER (PARTITION BY tblCodhayeDaramadiElamAvarez.fldElamAvarezId)) FROM Drd.tblCodhayeDaramadiElamAvarez AS a 
				WHERE a.fldElamAvarezId =Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId) AS fldmablaghKoli
			,tblCodhayeDaramd_1.fldDaramadId,tblPardakhtFish.fldTarikhVariz fldTarikh,tblPardakhtFish.fldId,Drd.tblNaghdi_Talab.fldShomareHesabId,isnull(fldTakhfifMaliyatValue,fldMaliyatValue)fldMaliyatValue,
			isnull(fldTakhfifAvarezValue,fldAvarezValue)fldAvarezValue
			
			 ,(SELECT        CASE WHEN fldHaghighiId IS NOT NULL THEN
                                                             (SELECT        fldName + ' ' + fldFamily
                                                                FROM            Com.tblEmployee
                                                                WHERE        fldId = fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN
                                                             (SELECT        fldName
                                                                FROM            Com.tblAshkhaseHoghoghi
                                                                WHERE        fldId = fldHoghoghiId) END AS Expr1
                                FROM            Com.tblAshkhas
                                WHERE        (fldId = Drd.tblElamAvarez.fldAshakhasID)) AS [Name],
                             (SELECT        CASE WHEN fldHaghighiId IS NOT NULL THEN
                                                             (SELECT        fldCodemeli
                                                                FROM            Com.tblEmployee
                                                                WHERE        fldId = fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN
                                                             (SELECT        fldShomareSabt
                                                                FROM            Com.tblAshkhaseHoghoghi
                                                                WHERE        fldId = fldHoghoghiId) END AS Expr1
                                FROM            Com.tblAshkhas
                                WHERE        (fldId = Drd.tblElamAvarez.fldAshakhasID)) AS Codemeli
                                        ,tblPardakhtFish.fldFishId,
                                       Drd.tblSodoorFish.fldTarikh  AS TarikhSodoor,tblNaghdi_Talab.fldFishId AS Naghfish,
                                ISNULL((SELECT fldTitle FROM Drd.tblPardakhtFish INNER JOIN
						 Drd.tblNahvePardakht ON tblNahvePardakht.fldId = tblPardakhtFish.fldNahvePardakhtId WHERE tblPardakhtFish.fldFishId=tblSodoorFish.fldId),N'') AS fldTitle 
			FROM            Drd.tblRequestTaghsit_Takhfif INNER JOIN
							Drd.tblStatusTaghsit_Takhfif ON Drd.tblRequestTaghsit_Takhfif.fldId = Drd.tblStatusTaghsit_Takhfif.fldRequestId INNER JOIN
							 Drd.tblReplyTaghsit ON Drd.tblStatusTaghsit_Takhfif.fldId = Drd.tblReplyTaghsit.fldStatusId INNER JOIN
							 Drd.tblElamAvarez ON Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId = Drd.tblElamAvarez.fldId INNER JOIN
							 Drd.tblCodhayeDaramadiElamAvarez ON Drd.tblElamAvarez.fldId = Drd.tblCodhayeDaramadiElamAvarez.fldElamAvarezId INNER JOIN
							 Drd.tblShomareHesabCodeDaramad ON Drd.tblCodhayeDaramadiElamAvarez.fldShomareHesabCodeDaramadId = Drd.tblShomareHesabCodeDaramad.fldId INNER JOIN
							 Drd.tblCodhayeDaramd AS tblCodhayeDaramd_1 ON Drd.tblShomareHesabCodeDaramad.fldCodeDaramadId = tblCodhayeDaramd_1.fldId INNER JOIN
							 Drd.tblNaghdi_Talab ON Drd.tblReplyTaghsit.fldId = Drd.tblNaghdi_Talab.fldReplyTaghsitId INNER JOIN
							 Com.tblShomareHesabeOmoomi ON Com.tblShomareHesabeOmoomi.fldId = Drd.tblNaghdi_Talab.fldShomareHesabId INNER JOIN
							 Drd.tblSodoorFish ON Drd.tblNaghdi_Talab.fldFishId = Drd.tblSodoorFish.fldId INNER JOIN
							 Drd.tblPardakhtFish ON Drd.tblSodoorFish.fldId = Drd.tblPardakhtFish.fldFishId 
							 WHERE fldRequestId NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=fldRequestId)
							AND tblNaghdi_Talab.fldType=1 
							AND CAST(tblPardakhtFish.fldDateVariz AS  DATE) BETWEEN @StartDate AND @EndDate AND tblShomareHesabCodeDaramad.fldOrganId=@OrganId
							AND tblShomareHesabCodeDaramad.fldOrganId=@OrganId
							 
							 GROUP BY tblRequestTaghsit_Takhfif.fldElamAvarezId,tblCodhayeDaramd_1.fldDaramadCode, 
							 Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad,fldMablagh,fldReplyTaghsitId, tblCodhayeDaramadiElamAvarez.fldElamAvarezId
							 ,tblNaghdi_Talab.fldShomareHesabId,fldShomareHesab,fldDaramadId,tblPardakhtFish.fldTarikhVariz ,tblPardakhtFish.fldId,tblNaghdi_Talab.fldShomareHesabId
						,fldMaliyatValue,fldAvarezValue,fldTakhfifMaliyatValue,fldTakhfifAvarezValue,fldAshakhasID,tblPardakhtFish.fldFishId
							, Drd.tblSodoorFish.fldTarikh,Drd.tblSodoorFish.fldId,tblNaghdi_Talab.fldFishId  )t)s
			GROUP BY fldDaramadCode,fldSharheCodeDaramad,fldTarikh,[Name],Codemeli,fldFishId,TarikhSodoor,fldTitle,fldShomareHesab
			ORDER BY MIN(fldFishId)
		end
	end
COMMIT

GO
