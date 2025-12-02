SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE proc [Drd].[sp_selectFishForKhazane](@organId INT,@Fishid int)
as
-- فیلد آموزشو پرورش در این پروسیجر نیس
BEGIN TRAN
 --select cast(0 as bigint) AS Mablagh,''fldDaramadCode,''fldSharheCodeDaramad,''fldTarikh,''[Name],''Codemeli,0fldFishId, ''TarikhSodoor,''fldTitle,''fldShomareHesab,0Idcode 
declare @AzTarikh NVARCHAR(10),@TaTarikh NVARCHAR(10)
--DECLARE @fieldname NVARCHAR(50)='ALL', @AzTarikh NVARCHAR(10)='1397/02/08',@TaTarikh NVARCHAR(10)='1397/02/08',@ShomareHesabId INT=0,@CodeDaramd NVARCHAR(50)='603011/04',@OrganId INT=1
select @AzTarikh=dbo.Fn_AssembelyMiladiToShamsi(fldDatePardakht),@TaTarikh=dbo.Fn_AssembelyMiladiToShamsi(fldDatePardakht) from Drd.tblPardakhtFish where fldFishId=@Fishid

DECLARE @StartDate DATE=com.ShamsiToMiladi(@Aztarikh)
DECLARE @EndDate DATE=com.ShamsiToMiladi(@TaTarikh)

		SELECT SUM(fldmablaghCodeDaramad) AS Mablagh,fldDaramadCode,fldSharheCodeDaramad,fldTarikh,[Name],Codemeli,fldFishId, TarikhSodoor,fldTitle,fldShomareHesab,Idcode 
		FROM
		(SELECT      tblCodhayeDaramd_1.fldDaramadCode, Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad, Com.tblShomareHesabeOmoomi.fldShomareHesab, 
								   cast((fldSumAsli )as bigint)
				AS fldmablaghCodeDaramad, '0' AS Expr1, tblCodhayeDaramd_1.fldDaramadId,tblPardakhtFish.fldTarikh,tblPardakhtFish.fldId,tblSodoorFish.fldShomareHesabId,
				isnull(fldTakhfifMaliyatValue,fldMaliyatValue)fldMaliyatValue,isnull(fldTakhfifAvarezValue,fldAvarezValue)fldAvarezValue,isnull(fldTakhfifAmuzeshParvareshValue,fldAmuzeshParvareshValue)fldAmuzeshParvareshValue,tblCodhayeDaramd_1.fldid as IdCode
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
							 and tblPardakhtFish.fldFishId=@Fishid
			union
			--مالیات
			SELECT     /* (SELECT fldDaramadCode FROM Drd.tblCodhayeDaramd WHERE fldId IN (SELECT fldCodeDaramadId FROM Drd.tblShomareHesabCodeDaramad WHERE fldid IN (SELECT fldMaliyatId FROM Drd.tblTanzimateDaramad WHERE fldOrganId=Drd.tblElamAvarez.fldOrganId ) ))*/
			/*(select c.fldCode from acc.tblCoding_Details c inner join drd.tblTanzimateDaramad t on t.fldMaliyatId=c.fldid where t.fldOrganId=drd.tblElamAvarez.fldOrganId)*//*جدید*/
			'-', N'مالیات', Com.tblShomareHesabeOmoomi.fldShomareHesab, 
								   ISNULL(cast((Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifMaliyatValue)as bigint),
									  cast((Drd.tblCodhayeDaramadiElamAvarez.fldMaliyatValue)as bigint))
				AS fldmablaghCodeDaramad, '0' AS Expr1, tblCodhayeDaramd_1.fldDaramadId,tblPardakhtFish.fldTarikh,tblPardakhtFish.fldId,tblSodoorFish.fldShomareHesabId,
				isnull(fldTakhfifMaliyatValue,fldMaliyatValue)fldMaliyatValue,isnull(fldTakhfifAvarezValue,fldAvarezValue)fldAvarezValue,isnull(fldTakhfifAmuzeshParvareshValue,fldAmuzeshParvareshValue)fldAmuzeshParvareshValue
				,(select top(1) c.fldid from drd.tblCodhayeDaramd c  where fldDaramadTitle like N'مالیات')Idcode
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
							 and tblPardakhtFish.fldFishId=@Fishid
			union
			--عوارض
			SELECT      /*(SELECT fldDaramadCode FROM Drd.tblCodhayeDaramd WHERE fldId IN (SELECT fldCodeDaramadId FROM Drd.tblShomareHesabCodeDaramad WHERE fldid IN (SELECT fldAvarezId FROM Drd.tblTanzimateDaramad WHERE fldOrganId=Drd.tblElamAvarez.fldOrganId ) ))*/
				/*(select c.fldCode from acc.tblCoding_Details c inner join drd.tblTanzimateDaramad t on t.fldAvarezId=c.fldid where t.fldOrganId=drd.tblElamAvarez.fldOrganId)*/
			'-', N'عوارض', Com.tblShomareHesabeOmoomi.fldShomareHesab, 
								   ISNULL(cast((Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifAvarezValue)as bigint),
									  cast((Drd.tblCodhayeDaramadiElamAvarez.fldAvarezValue)as bigint))
				AS fldmablaghCodeDaramad, '0' AS Expr1, tblCodhayeDaramd_1.fldDaramadId,tblPardakhtFish.fldTarikh,tblPardakhtFish.fldId,tblSodoorFish.fldShomareHesabId,
				isnull(fldTakhfifMaliyatValue,fldMaliyatValue)fldMaliyatValue,isnull(fldTakhfifAvarezValue,fldAvarezValue)fldAvarezValue,isnull(fldTakhfifAmuzeshParvareshValue,fldAmuzeshParvareshValue)fldAmuzeshParvareshValue
					,(select  top(1) c.fldid from drd.tblCodhayeDaramd c  where fldDaramadTitle like N'عوارض')Idcode
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
							 and tblPardakhtFish.fldFishId=@Fishid
			union all
			SELECT fldDaramadCode,fldSharheCodeDaramad,fldShomareHesab,cast(cast(fldMablaghNaghdi as numeric(50)) *cast(fldmablaghCodeDaramad as numeric(50))/cast(fldmablaghKoli as numeric(50))as bigint),'1'
			,fldDaramadId,fldTarikh,fldId,fldShomareHesabId,fldMaliyatValue,fldAvarezValue,fldAmuzeshParvareshValue,IdCode,[Name],Codemeli,fldFishId,TarikhSodoor,fldTitle
			 FROM 
			(SELECT   DISTINCT    Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId, tblCodhayeDaramd_1.fldDaramadCode, 
									 Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad
									,Drd.fn_SumMablaghNaghdi('Naghdi_Talab',tblNaghdi_Talab.fldFishId,tblNaghdi_Talab.fldShomareHesabId,@azTarikh ,@Tatarikh) AS fldMablaghNaghdi
									,fldShomareHesab ,fldReplyTaghsitId
				,SUM(fldSumAsli) AS fldmablaghCodeDaramad
				,(SELECT TOP(1) SUM(fldSumAsli) OVER (PARTITION BY tblCodhayeDaramadiElamAvarez.fldElamAvarezId) FROM Drd.tblCodhayeDaramadiElamAvarez AS a 
				WHERE a.fldElamAvarezId =Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId) AS fldmablaghKoli
			,tblCodhayeDaramd_1.fldDaramadId,tblPardakhtFish.fldTarikh,tblPardakhtFish.fldId,Drd.tblNaghdi_Talab.fldShomareHesabId,isnull(fldTakhfifMaliyatValue,fldMaliyatValue)fldMaliyatValue,
			isnull(fldTakhfifAvarezValue,fldAvarezValue)fldAvarezValue,isnull(fldTakhfifAmuzeshParvareshValue,fldAmuzeshParvareshValue)fldAmuzeshParvareshValue,tblCodhayeDaramd_1.fldid as IdCode
			
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
						 AND tblShomareHesabCodeDaramad.fldOrganId=@OrganId
							AND tblShomareHesabCodeDaramad.fldOrganId=@OrganId
							  and tblPardakhtFish.fldFishId=@Fishid
							 GROUP BY tblRequestTaghsit_Takhfif.fldElamAvarezId,tblCodhayeDaramd_1.fldDaramadCode, 
							 Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad,fldMablagh,fldReplyTaghsitId, tblCodhayeDaramadiElamAvarez.fldElamAvarezId
							 ,tblNaghdi_Talab.fldShomareHesabId,fldShomareHesab,fldDaramadId,tblPardakhtFish.fldTarikh,tblPardakhtFish.fldId,tblNaghdi_Talab.fldShomareHesabId
						,fldMaliyatValue,fldAvarezValue,fldTakhfifMaliyatValue,fldTakhfifAvarezValue,fldAshakhasID,tblPardakhtFish.fldFishId
							, Drd.tblSodoorFish.fldTarikh,Drd.tblSodoorFish.fldId,tblNaghdi_Talab.fldFishId ,tblCodhayeDaramd_1.fldid  ,fldTakhfifAmuzeshParvareshValue,fldAmuzeshParvareshValue
							
							)t
							--مالیات
							union all
			SELECT /*(SELECT fldDaramadCode FROM Drd.tblCodhayeDaramd WHERE fldId IN (SELECT fldCodeDaramadId FROM Drd.tblShomareHesabCodeDaramad WHERE fldid IN (SELECT fldAvarezId FROM Drd.tblTanzimateDaramad WHERE fldOrganId=@organId ) ))*/
			/*	(select c.fldCode from acc.tblCoding_Details c inner join drd.tblTanzimateDaramad t on t.fldMaliyatId=c.fldid where t.fldOrganId=@organId)*/'-',N'مالیات',
			fldShomareHesab,cast(cast(fldMablaghNaghdi as numeric(50)) *cast(fldmablaghCodeDaramad as numeric(50))/(case when fldmablaghKoli>0 then cast(fldmablaghKoli as numeric(50))else 1 end) as bigint),'1'
			,fldDaramadId,fldTarikh,fldId,fldShomareHesabId,fldMaliyatValue,fldAvarezValue,fldAmuzeshParvareshValue,IdCode,[Name],Codemeli,fldFishId,TarikhSodoor,fldTitle
			 FROM 
			(SELECT   DISTINCT    Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId, tblCodhayeDaramd_1.fldDaramadCode, 
									 Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad
									,Drd.fn_SumMablaghNaghdi('Naghdi_Talab',tblNaghdi_Talab.fldFishId,tblNaghdi_Talab.fldShomareHesabId,@azTarikh ,@Tatarikh) AS fldMablaghNaghdi
									,fldShomareHesab ,fldReplyTaghsitId
				,ISNULL(SUM(fldTakhfifMaliyatValue),SUM(fldMaliyatValue)) AS fldmablaghCodeDaramad
				,(SELECT TOP(1) ISNULL(SUM(fldTakhfifMaliyatValue) OVER (PARTITION BY tblCodhayeDaramadiElamAvarez.fldElamAvarezId),
				SUM(fldMaliyatValue) OVER (PARTITION BY tblCodhayeDaramadiElamAvarez.fldElamAvarezId)) FROM Drd.tblCodhayeDaramadiElamAvarez AS a 
				WHERE a.fldElamAvarezId =Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId) AS fldmablaghKoli
			,tblCodhayeDaramd_1.fldDaramadId,tblPardakhtFish.fldTarikh,tblPardakhtFish.fldId,Drd.tblNaghdi_Talab.fldShomareHesabId,isnull(fldTakhfifMaliyatValue,fldMaliyatValue)fldMaliyatValue,
			isnull(fldTakhfifAvarezValue,fldAvarezValue)fldAvarezValue,isnull(fldTakhfifAmuzeshParvareshValue,fldAmuzeshParvareshValue)fldAmuzeshParvareshValue
			,(select  top(1) c.fldid from drd.tblCodhayeDaramd c  where fldDaramadTitle like N'مالیات')Idcode
			
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
						 AND tblShomareHesabCodeDaramad.fldOrganId=@OrganId
							AND tblShomareHesabCodeDaramad.fldOrganId=@OrganId
							  and tblPardakhtFish.fldFishId=@Fishid
							 GROUP BY tblRequestTaghsit_Takhfif.fldElamAvarezId,tblCodhayeDaramd_1.fldDaramadCode, 
							 Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad,fldMablagh,fldReplyTaghsitId, tblCodhayeDaramadiElamAvarez.fldElamAvarezId
							 ,tblNaghdi_Talab.fldShomareHesabId,fldShomareHesab,fldDaramadId,tblPardakhtFish.fldTarikh,tblPardakhtFish.fldId,tblNaghdi_Talab.fldShomareHesabId
						,fldMaliyatValue,fldAvarezValue,fldTakhfifMaliyatValue,fldTakhfifAvarezValue,fldAshakhasID,tblPardakhtFish.fldFishId
							, Drd.tblSodoorFish.fldTarikh,Drd.tblSodoorFish.fldId,tblNaghdi_Talab.fldFishId,fldAmuzeshParvareshValue,fldTakhfifAmuzeshParvareshValue
							
							)t
							--عوارض
							union all
			SELECT /*(SELECT fldDaramadCode FROM Drd.tblCodhayeDaramd WHERE fldId IN (SELECT fldCodeDaramadId FROM Drd.tblShomareHesabCodeDaramad WHERE fldid IN (SELECT fldAvarezId FROM Drd.tblTanzimateDaramad WHERE fldOrganId=@organId ) ))*/
			/*(select c.fldCode from acc.tblCoding_Details c inner join drd.tblTanzimateDaramad t on t.fldAvarezId=c.fldid where t.fldOrganId=@organId)*/'-',N'عوارض',
			fldShomareHesab,cast(cast(fldMablaghNaghdi as numeric(50)) *cast(fldmablaghCodeDaramad as numeric(50))/(case when fldmablaghKoli>0 then cast(fldmablaghKoli as numeric(50))else 1 end)as bigint),'1'
			,fldDaramadId,fldTarikh,fldId,fldShomareHesabId,fldMaliyatValue,fldAvarezValue,fldAmuzeshParvareshValue,IdCode,[Name],Codemeli,fldFishId,TarikhSodoor,fldTitle
			 FROM 
			(SELECT   DISTINCT    Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId, tblCodhayeDaramd_1.fldDaramadCode, 
									 Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad
									,Drd.fn_SumMablaghNaghdi('Naghdi_Talab',tblNaghdi_Talab.fldFishId,tblNaghdi_Talab.fldShomareHesabId,@azTarikh ,@Tatarikh) AS fldMablaghNaghdi
									,fldShomareHesab ,fldReplyTaghsitId
				,ISNULL(SUM(fldTakhfifAvarezValue),SUM(fldAvarezValue)) AS fldmablaghCodeDaramad
				,(SELECT TOP(1) ISNULL(SUM(fldTakhfifAvarezValue) OVER (PARTITION BY tblCodhayeDaramadiElamAvarez.fldElamAvarezId),
				SUM(fldAvarezValue) OVER (PARTITION BY tblCodhayeDaramadiElamAvarez.fldElamAvarezId)) FROM Drd.tblCodhayeDaramadiElamAvarez AS a 
				WHERE a.fldElamAvarezId =Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId) AS fldmablaghKoli
			,tblCodhayeDaramd_1.fldDaramadId,tblPardakhtFish.fldTarikh,tblPardakhtFish.fldId,Drd.tblNaghdi_Talab.fldShomareHesabId,isnull(fldTakhfifMaliyatValue,fldMaliyatValue)fldMaliyatValue,
			isnull(fldTakhfifAvarezValue,fldAvarezValue)fldAvarezValue,isnull(fldTakhfifAmuzeshParvareshValue,fldAmuzeshParvareshValue)fldAmuzeshParvareshValue
				,(select  top(1) c.fldid from drd.tblCodhayeDaramd c  where fldDaramadTitle like N'عوارض')Idcode
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
						 AND tblShomareHesabCodeDaramad.fldOrganId=@OrganId
							AND tblShomareHesabCodeDaramad.fldOrganId=@OrganId
							  and tblPardakhtFish.fldFishId=@Fishid
							 GROUP BY tblRequestTaghsit_Takhfif.fldElamAvarezId,tblCodhayeDaramd_1.fldDaramadCode, 
							 Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad,fldMablagh,fldReplyTaghsitId, tblCodhayeDaramadiElamAvarez.fldElamAvarezId
							 ,tblNaghdi_Talab.fldShomareHesabId,fldShomareHesab,fldDaramadId,tblPardakhtFish.fldTarikh,tblPardakhtFish.fldId,tblNaghdi_Talab.fldShomareHesabId
						,fldMaliyatValue,fldAvarezValue,fldTakhfifMaliyatValue,fldTakhfifAvarezValue,fldAshakhasID,tblPardakhtFish.fldFishId
							, Drd.tblSodoorFish.fldTarikh,Drd.tblSodoorFish.fldId,tblNaghdi_Talab.fldFishId  ,fldTakhfifAmuzeshParvareshValue,fldAmuzeshParvareshValue
							
							)t
				)s
				where fldmablaghCodeDaramad<>0
				GROUP BY fldDaramadCode,fldSharheCodeDaramad,fldTarikh,[Name],Codemeli,fldFishId,TarikhSodoor,fldTitle,fldShomareHesab,idcode
				ORDER BY MIN(fldFishId)
				

COMMIT

GO
