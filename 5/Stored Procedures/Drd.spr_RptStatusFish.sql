SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_RptStatusFish](@FieldName NVARCHAR(50),@Aztarikh NVARCHAR(10),@TaTarikh NVARCHAR(10),@ShomareHesabId INT,@organid INT)
as
--DECLARE @FieldName NVARCHAR(50)='PardakhtShode',@Value NVARCHAR(50)='',@Aztarikh NVARCHAR(10)='1397/07/08',@TaTarikh NVARCHAR(10)='1397/07/08'
DECLARE @temp TABLE(FishId INT,[Name] NVARCHAR(50),CodeMeli NVARCHAR(50),MablaghKhales BIGINT,TarikhSodoor NVARCHAR(10),ShomareHesab NVARCHAR(50),Avarez INT,Maliyat INT,MablaghGhabelPardakht BIGINT )
DECLARE @StartDate DATE=com.ShamsiToMiladi(@Aztarikh)
DECLARE @EndDate DATE=com.ShamsiToMiladi(@TaTarikh)
--INSERT INTO @temp
        --( FishId ,          Name ,          CodeMeli ,          TarikhSodoor,ShomareHesab,          MablaghKhales  ,          Avarez ,          Maliyat ,          MablaghGhabelPardakht
        --)
IF(@FieldName='')
BEGIN	
IF(@ShomareHesabId<>0)
 SELECT        tblSodoorFish.fldId as FishId ,
                             (SELECT        CASE WHEN fldHaghighiId IS NOT NULL THEN
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
                                WHERE        (fldId = Drd.tblElamAvarez.fldAshakhasID)) AS Codemeli,
								tblSodoorFish.fldTarikh as TarikhSodoor,Com.tblShomareHesabeOmoomi.fldShomareHesab as ShomareHesab, 
						ISNULL(SUM(cast(Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifAsliValue * Drd.tblCodhayeDaramadiElamAvarez.fldTedad as bigint)),
                          SUM(cast ( Drd.tblCodhayeDaramadiElamAvarez.fldAsliValue * Drd.tblCodhayeDaramadiElamAvarez.fldTedad  as bigint))) AS MablaghKhales,
                         ISNULL(SUM( cast(Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifAvarezValue as bigint)),SUM(cast( Drd.tblCodhayeDaramadiElamAvarez.fldAvarezValue  as bigint) )) AS Avarez,
						 ISNULL(SUM( cast(Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifMaliyatValue as bigint)),SUM(cast( Drd.tblCodhayeDaramadiElamAvarez.fldMaliyatValue as bigint))) AS Maliyat
                         ,ISNULL(SUM( cast(Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifAmuzeshParvareshValue as bigint)),SUM(cast( Drd.tblCodhayeDaramadiElamAvarez.fldAmuzeshParvareshValue as bigint))) AS fldAmuzeshParvareshValue
						  ,fldMablaghAvarezGerdShode as MablaghGhabelPardakht
						  ,ISNULL((SELECT fldTarikh FROM Drd.tblPardakhtFish WHERE tblPardakhtFish.fldFishId=tblSodoorFish.fldId),N'') AS TarikhPardakht,
						  ISNULL((SELECT fldTarikhVariz FROM Drd.tblPardakhtFish WHERE tblPardakhtFish.fldFishId=tblSodoorFish.fldId),N'') AS TarikhVariz
						,ISNULL((SELECT fldTitle FROM Drd.tblPardakhtFish INNER JOIN
						 Drd.tblNahvePardakht ON tblNahvePardakht.fldId = tblPardakhtFish.fldNahvePardakhtId WHERE tblPardakhtFish.fldFishId=tblSodoorFish.fldId),N'') AS fldTitle

FROM            Drd.tblSodoorFish inner JOIN
                         Drd.tblSodoorFish_Detail ON Drd.tblSodoorFish.fldId = Drd.tblSodoorFish_Detail.fldFishId INNER JOIN
                         Drd.tblCodhayeDaramadiElamAvarez ON Drd.tblSodoorFish_Detail.fldCodeElamAvarezId = Drd.tblCodhayeDaramadiElamAvarez.fldID INNER JOIN
                         Drd.tblShomareHesabCodeDaramad ON Drd.tblCodhayeDaramadiElamAvarez.fldShomareHesabCodeDaramadId = Drd.tblShomareHesabCodeDaramad.fldId INNER JOIN
                         Drd.tblCodhayeDaramd AS tblCodhayeDaramd_1 ON Drd.tblShomareHesabCodeDaramad.fldCodeDaramadId = tblCodhayeDaramd_1.fldId INNER JOIN
                         Com.tblShomareHesabeOmoomi ON Drd.tblSodoorFish.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                         Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId
						  WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId)
						 AND CAST( tblSodoorFish.fldDate AS DATE) >= @StartDate AND CAST( tblSodoorFish.fldDate AS DATE) <=@EndDate
						 AND tblSodoorFish.fldShomareHesabId=@ShomareHesabId AND Drd.tblElamAvarez.fldOrganId=@organid
		GROUP BY tblSodoorFish.fldId,fldAshakhasID,Drd.tblSodoorFish.fldTarikh,Com.tblShomareHesabeOmoomi.fldShomareHesab,fldMablaghAvarezGerdShode
union all

SELECT        Drd.tblSodoorFish.fldId AS FishId,
                             (SELECT        CASE WHEN fldHaghighiId IS NOT NULL THEN
                                                             (SELECT        fldName + ' ' + fldFamily
                                                               FROM            Com.tblEmployee
                                                               WHERE        fldId = fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN
                                                             (SELECT        fldName
                                                               FROM            Com.tblAshkhaseHoghoghi
                                                               WHERE        fldId = fldHoghoghiId) END AS Expr1
                               FROM            Com.tblAshkhas
                               WHERE        (fldId = Drd.tblElamAvarez.fldAshakhasID)) AS Name,
                             (SELECT        CASE WHEN fldHaghighiId IS NOT NULL THEN
                                                             (SELECT        fldCodemeli
                                                               FROM            Com.tblEmployee
                                                               WHERE        fldId = fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN
                                                             (SELECT        fldShomareSabt
                                                               FROM            Com.tblAshkhaseHoghoghi
                                                               WHERE        fldId = fldHoghoghiId) END AS Expr1
                               FROM            Com.tblAshkhas AS tblAshkhas_1
                               WHERE        (fldId = Drd.tblElamAvarez.fldAshakhasID)) AS Codemeli, Drd.tblSodoorFish.fldTarikh AS TarikhSodoor, Com.tblShomareHesabeOmoomi.fldShomareHesab, 
                         Drd.tblSodoorFish.fldMablaghAvarezGerdShode AS MablaghKhales, 0 AS Avarez, 0 AS Maliyat,0 as fldAmuzeshParvareshValue, Drd.tblSodoorFish.fldMablaghAvarezGerdShode AS MablaghGhabelPardakht, 
						 ISNULL ((SELECT        fldTarikh FROM Drd.tblPardakhtFish WHERE (fldFishId = Drd.tblSodoorFish.fldId)), N'') AS TarikhPardakht
						 , ISNULL ((SELECT        fldTarikhVariz FROM Drd.tblPardakhtFish WHERE (fldFishId = Drd.tblSodoorFish.fldId)), N'') AS TarikhVariz
						 , ISNULL  ((SELECT        Drd.tblNahvePardakht.fldTitle
                                 FROM            Drd.tblPardakhtFish AS tblPardakhtFish_1 INNER JOIN
                                                          Drd.tblNahvePardakht ON Drd.tblNahvePardakht.fldId = tblPardakhtFish_1.fldNahvePardakhtId
                                 WHERE        (tblPardakhtFish_1.fldFishId = Drd.tblSodoorFish.fldId)), N'') AS fldTitle
FROM            Drd.tblSodoorFish INNER JOIN
                         Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId INNER JOIN
                         Com.tblShomareHesabeOmoomi ON Drd.tblSodoorFish.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId                     
						  WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId)
						 	 AND CAST( tblSodoorFish.fldDate AS DATE) >= @StartDate AND CAST( tblSodoorFish.fldDate AS DATE) <=@EndDate
								 AND tblSodoorFish.fldShomareHesabId=@ShomareHesabId	 AND Drd.tblElamAvarez.fldOrganId=@organid
									GROUP BY tblSodoorFish.fldId,fldAshakhasID,Drd.tblSodoorFish.fldTarikh,Com.tblShomareHesabeOmoomi.fldShomareHesab,fldMablaghAvarezGerdShode
 else
 SELECT        tblSodoorFish.fldId as FishId ,
                             (SELECT        CASE WHEN fldHaghighiId IS NOT NULL THEN
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
                                WHERE        (fldId = Drd.tblElamAvarez.fldAshakhasID)) AS Codemeli,
								tblSodoorFish.fldTarikh as TarikhSodoor,Com.tblShomareHesabeOmoomi.fldShomareHesab as ShomareHesab, 
						ISNULL(SUM(cast(Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifAsliValue * Drd.tblCodhayeDaramadiElamAvarez.fldTedad as bigint)),
                          SUM(cast ( Drd.tblCodhayeDaramadiElamAvarez.fldAsliValue * Drd.tblCodhayeDaramadiElamAvarez.fldTedad  as bigint))) AS MablaghKhales,
                         ISNULL(SUM( cast(Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifAvarezValue as bigint)),SUM(cast( Drd.tblCodhayeDaramadiElamAvarez.fldAvarezValue  as bigint) )) AS Avarez,
						 ISNULL(SUM( cast(Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifMaliyatValue as bigint)),SUM(cast( Drd.tblCodhayeDaramadiElamAvarez.fldMaliyatValue as bigint))) AS Maliyat
                          ,ISNULL(SUM( cast(Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifAmuzeshParvareshValue as bigint)),SUM(cast( Drd.tblCodhayeDaramadiElamAvarez.fldAmuzeshParvareshValue as bigint))) AS fldAmuzeshParvareshValue  
						  ,fldMablaghAvarezGerdShode as MablaghGhabelPardakht
						  ,ISNULL((SELECT fldTarikh FROM Drd.tblPardakhtFish WHERE tblPardakhtFish.fldFishId=tblSodoorFish.fldId),N'') AS TarikhPardakht,
						  ISNULL((SELECT fldTarikhVariz FROM Drd.tblPardakhtFish WHERE tblPardakhtFish.fldFishId=tblSodoorFish.fldId),N'') AS TarikhVariz,
							ISNULL((SELECT fldTitle FROM Drd.tblPardakhtFish INNER JOIN
						 Drd.tblNahvePardakht ON tblNahvePardakht.fldId = tblPardakhtFish.fldNahvePardakhtId WHERE tblPardakhtFish.fldFishId=tblSodoorFish.fldId),N'') AS fldTitle

FROM            Drd.tblSodoorFish inner JOIN
                         Drd.tblSodoorFish_Detail ON Drd.tblSodoorFish.fldId = Drd.tblSodoorFish_Detail.fldFishId INNER JOIN
                         Drd.tblCodhayeDaramadiElamAvarez ON Drd.tblSodoorFish_Detail.fldCodeElamAvarezId = Drd.tblCodhayeDaramadiElamAvarez.fldID INNER JOIN
                         Drd.tblShomareHesabCodeDaramad ON Drd.tblCodhayeDaramadiElamAvarez.fldShomareHesabCodeDaramadId = Drd.tblShomareHesabCodeDaramad.fldId INNER JOIN
                         Drd.tblCodhayeDaramd AS tblCodhayeDaramd_1 ON Drd.tblShomareHesabCodeDaramad.fldCodeDaramadId = tblCodhayeDaramd_1.fldId INNER JOIN
                         Com.tblShomareHesabeOmoomi ON Drd.tblSodoorFish.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                         Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId
						  WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId)
						 AND CAST( tblSodoorFish.fldDate AS DATE) >= @StartDate AND CAST( tblSodoorFish.fldDate AS DATE) <=@EndDate
						AND Drd.tblElamAvarez.fldOrganId=@organid
		GROUP BY tblSodoorFish.fldId,fldAshakhasID,Drd.tblSodoorFish.fldTarikh,Com.tblShomareHesabeOmoomi.fldShomareHesab,fldMablaghAvarezGerdShode
union all

SELECT        Drd.tblSodoorFish.fldId AS FishId,
                             (SELECT        CASE WHEN fldHaghighiId IS NOT NULL THEN
                                                             (SELECT        fldName + ' ' + fldFamily
                                                               FROM            Com.tblEmployee
                                                               WHERE        fldId = fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN
                                                             (SELECT        fldName
                                                               FROM            Com.tblAshkhaseHoghoghi
                                                               WHERE        fldId = fldHoghoghiId) END AS Expr1
                               FROM            Com.tblAshkhas
                               WHERE        (fldId = Drd.tblElamAvarez.fldAshakhasID)) AS Name,
                             (SELECT        CASE WHEN fldHaghighiId IS NOT NULL THEN
                                                             (SELECT        fldCodemeli
                                                               FROM            Com.tblEmployee
                                                               WHERE        fldId = fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN
                                                             (SELECT        fldShomareSabt
                                                               FROM            Com.tblAshkhaseHoghoghi
                                                               WHERE        fldId = fldHoghoghiId) END AS Expr1
                               FROM            Com.tblAshkhas AS tblAshkhas_1
                               WHERE        (fldId = Drd.tblElamAvarez.fldAshakhasID)) AS Codemeli, Drd.tblSodoorFish.fldTarikh AS TarikhSodoor, Com.tblShomareHesabeOmoomi.fldShomareHesab, 
                         Drd.tblSodoorFish.fldMablaghAvarezGerdShode AS MablaghKhales, 0 AS Avarez, 0 AS Maliyat,0 , Drd.tblSodoorFish.fldMablaghAvarezGerdShode AS MablaghGhabelPardakht, 
						 ISNULL ((SELECT        fldTarikh FROM Drd.tblPardakhtFish WHERE (fldFishId = Drd.tblSodoorFish.fldId)), N'') AS TarikhPardakht
						 ,ISNULL ((SELECT        fldTarikhVariz FROM Drd.tblPardakhtFish WHERE (fldFishId = Drd.tblSodoorFish.fldId)), N'') AS TarikhVariz
						 , ISNULL ((SELECT        Drd.tblNahvePardakht.fldTitle
                                 FROM            Drd.tblPardakhtFish AS tblPardakhtFish_1 INNER JOIN
                                                          Drd.tblNahvePardakht ON Drd.tblNahvePardakht.fldId = tblPardakhtFish_1.fldNahvePardakhtId
                                 WHERE        (tblPardakhtFish_1.fldFishId = Drd.tblSodoorFish.fldId)), N'') AS fldTitle
FROM            Drd.tblSodoorFish INNER JOIN
                         Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId INNER JOIN
                         Com.tblShomareHesabeOmoomi ON Drd.tblSodoorFish.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId                     
						  WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId)
						 	 AND CAST( tblSodoorFish.fldDate AS DATE) >= @StartDate AND CAST( tblSodoorFish.fldDate AS DATE) <=@EndDate
							AND Drd.tblElamAvarez.fldOrganId=@organid
									GROUP BY tblSodoorFish.fldId,fldAshakhasID,Drd.tblSodoorFish.fldTarikh,Com.tblShomareHesabeOmoomi.fldShomareHesab,fldMablaghAvarezGerdShode
			 			 


end
IF(@FieldName='PardakhtShode')	
BEGIN
IF(@ShomareHesabId<>0)
 SELECT        tblSodoorFish.fldId as FishId,
                             (SELECT        CASE WHEN fldHaghighiId IS NOT NULL THEN
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
                                WHERE        (fldId = Drd.tblElamAvarez.fldAshakhasID)) AS Codemeli,
								tblSodoorFish.fldTarikh as TarikhSodoor,Com.tblShomareHesabeOmoomi.fldShomareHesab as ShomareHesab, 
						ISNULL(SUM(cast(Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifAsliValue * Drd.tblCodhayeDaramadiElamAvarez.fldTedad  as bigint)),
                          SUM(cast(Drd.tblCodhayeDaramadiElamAvarez.fldAsliValue * Drd.tblCodhayeDaramadiElamAvarez.fldTedad  as bigint))) AS MablaghKhales,
                         ISNULL(SUM(cast( Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifAvarezValue as bigint)),SUM(cast( Drd.tblCodhayeDaramadiElamAvarez.fldAvarezValue  as bigint))) AS Avarez,
						 ISNULL(SUM(cast( Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifMaliyatValue as bigint)),SUM( cast(Drd.tblCodhayeDaramadiElamAvarez.fldMaliyatValue as bigint))) AS Maliyat
						,  ISNULL(SUM(cast( Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifAmuzeshParvareshValue as bigint)),SUM( cast(Drd.tblCodhayeDaramadiElamAvarez.fldAmuzeshParvareshValue as bigint))) AS Maliyat
                          ,fldMablaghAvarezGerdShode as MablaghGhabelPardakht,tblPardakhtFish.fldTarikh AS TarikhPardakht,fldTarikhVariz TarikhVariz,tblNahvePardakht.fldTitle

FROM            Drd.tblSodoorFish inner JOIN
                         Drd.tblSodoorFish_Detail ON Drd.tblSodoorFish.fldId = Drd.tblSodoorFish_Detail.fldFishId INNER JOIN
                         Drd.tblCodhayeDaramadiElamAvarez ON Drd.tblSodoorFish_Detail.fldCodeElamAvarezId = Drd.tblCodhayeDaramadiElamAvarez.fldID INNER JOIN
                         Drd.tblShomareHesabCodeDaramad ON Drd.tblCodhayeDaramadiElamAvarez.fldShomareHesabCodeDaramadId = Drd.tblShomareHesabCodeDaramad.fldId INNER JOIN
                         Drd.tblCodhayeDaramd AS tblCodhayeDaramd_1 ON Drd.tblShomareHesabCodeDaramad.fldCodeDaramadId = tblCodhayeDaramd_1.fldId INNER JOIN
                         Com.tblShomareHesabeOmoomi ON Drd.tblSodoorFish.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                         Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId INNER JOIN
                         Drd.tblPardakhtFish ON  Drd.tblSodoorFish.fldId= Drd.tblPardakhtFish.fldFishId INNER JOIN
						 Drd.tblNahvePardakht ON tblNahvePardakht.fldId = tblPardakhtFish.fldNahvePardakhtId
						 WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId)
						 AND CAST( tblPardakhtFish.fldDatePardakht AS DATE) BETWEEN @StartDate AND @EndDate
							AND tblSodoorFish.fldShomareHesabId=@ShomareHesabId	AND Drd.tblElamAvarez.fldOrganId=@organid		 
		GROUP BY tblSodoorFish.fldId,fldAshakhasID,Drd.tblSodoorFish.fldTarikh,tblCodhayeDaramadiElamAvarez.fldElamAvarezId,Com.tblShomareHesabeOmoomi.fldShomareHesab,fldMablaghAvarezGerdShode,tblPardakhtFish.fldTarikh,tblNahvePardakht.fldTitle,fldTarikhVariz
union all 

SELECT        Drd.tblSodoorFish.fldId AS FishId,
                             (SELECT        CASE WHEN fldHaghighiId IS NOT NULL THEN
                                                             (SELECT        fldName + ' ' + fldFamily
                                                               FROM            Com.tblEmployee
                                                               WHERE        fldId = fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN
                                                             (SELECT        fldName
                                                               FROM            Com.tblAshkhaseHoghoghi
                                                               WHERE        fldId = fldHoghoghiId) END AS Expr1
                               FROM            Com.tblAshkhas
                               WHERE        (fldId = Drd.tblElamAvarez.fldAshakhasID)) AS Name,
                             (SELECT        CASE WHEN fldHaghighiId IS NOT NULL THEN
                                                             (SELECT        fldCodemeli
                                                               FROM            Com.tblEmployee
                                                               WHERE        fldId = fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN
                                                             (SELECT        fldShomareSabt
                                                               FROM            Com.tblAshkhaseHoghoghi
                                                               WHERE        fldId = fldHoghoghiId) END AS Expr1
                               FROM            Com.tblAshkhas AS tblAshkhas_1
                               WHERE        (fldId = Drd.tblElamAvarez.fldAshakhasID)) AS Codemeli, Drd.tblSodoorFish.fldTarikh AS TarikhSodoor, Com.tblShomareHesabeOmoomi.fldShomareHesab AS ShomareHesab, 
                         Drd.tblSodoorFish.fldMablaghAvarezGerdShode AS MablaghKhales, 0 AS Avarez, 0 AS Maliyat,0 as fldAmuzeshParvareshValue , Drd.tblSodoorFish.fldMablaghAvarezGerdShode AS MablaghGhabelPardakht, 
                         Drd.tblPardakhtFish.fldTarikh AS TarikhPardakht,fldTarikhVariz TarikhVariz, Drd.tblNahvePardakht.fldTitle
FROM            Drd.tblPardakhtFish INNER JOIN
                         Drd.tblSodoorFish INNER JOIN
                         Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId INNER JOIN
                         Com.tblShomareHesabeOmoomi ON Drd.tblSodoorFish.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId ON Drd.tblPardakhtFish.fldFishId = Drd.tblSodoorFish.fldId INNER JOIN
                         Drd.tblNahvePardakht ON Drd.tblNahvePardakht.fldId = Drd.tblPardakhtFish.fldNahvePardakhtId           
						  WHERE tblSodoorFish.fldId NOT IN (SELECT tblEbtal.fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId)
						 AND CAST( tblPardakhtFish.fldDatePardakht AS DATE) BETWEEN @StartDate AND @EndDate and tblSodoorFish.fldid not in (select fldFishId from tblSodoorFish_Detail where fldFishId=tblSodoorFish.fldid) 
						AND tblSodoorFish.fldShomareHesabId=@ShomareHesabId		AND Drd.tblElamAvarez.fldOrganId=@organid
						GROUP BY tblSodoorFish.fldId,fldAshakhasID,Drd.tblSodoorFish.fldTarikh,fldElamAvarezId,Com.tblShomareHesabeOmoomi.fldShomareHesab,fldMablaghAvarezGerdShode,tblPardakhtFish.fldTarikh,tblNahvePardakht.fldTitle,fldTarikhVariz
ELSE			 
 SELECT        tblSodoorFish.fldId as FishId,
                             (SELECT        CASE WHEN fldHaghighiId IS NOT NULL THEN
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
                                WHERE        (fldId = Drd.tblElamAvarez.fldAshakhasID)) AS Codemeli,
								tblSodoorFish.fldTarikh as TarikhSodoor,Com.tblShomareHesabeOmoomi.fldShomareHesab as ShomareHesab, 
						ISNULL(SUM(cast(Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifAsliValue * Drd.tblCodhayeDaramadiElamAvarez.fldTedad  as bigint)),
                          SUM(cast(Drd.tblCodhayeDaramadiElamAvarez.fldAsliValue * Drd.tblCodhayeDaramadiElamAvarez.fldTedad  as bigint))) AS MablaghKhales,
                         ISNULL(SUM(cast( Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifAvarezValue as bigint)),SUM(cast( Drd.tblCodhayeDaramadiElamAvarez.fldAvarezValue  as bigint))) AS Avarez,
						 ISNULL(SUM(cast( Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifMaliyatValue as bigint)),SUM( cast(Drd.tblCodhayeDaramadiElamAvarez.fldMaliyatValue as bigint))) AS Maliyat
                          ,ISNULL(SUM( cast(Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifAmuzeshParvareshValue as bigint)),SUM(cast( Drd.tblCodhayeDaramadiElamAvarez.fldAmuzeshParvareshValue as bigint))) AS fldAmuzeshParvareshValue
						  ,fldMablaghAvarezGerdShode as MablaghGhabelPardakht,tblPardakhtFish.fldTarikh AS TarikhPardakht,fldTarikhVariz TarikhVariz,tblNahvePardakht.fldTitle

FROM            Drd.tblSodoorFish inner JOIN
                         Drd.tblSodoorFish_Detail ON Drd.tblSodoorFish.fldId = Drd.tblSodoorFish_Detail.fldFishId INNER JOIN
                         Drd.tblCodhayeDaramadiElamAvarez ON Drd.tblSodoorFish_Detail.fldCodeElamAvarezId = Drd.tblCodhayeDaramadiElamAvarez.fldID INNER JOIN
                         Drd.tblShomareHesabCodeDaramad ON Drd.tblCodhayeDaramadiElamAvarez.fldShomareHesabCodeDaramadId = Drd.tblShomareHesabCodeDaramad.fldId INNER JOIN
                         Drd.tblCodhayeDaramd AS tblCodhayeDaramd_1 ON Drd.tblShomareHesabCodeDaramad.fldCodeDaramadId = tblCodhayeDaramd_1.fldId INNER JOIN
                         Com.tblShomareHesabeOmoomi ON Drd.tblSodoorFish.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                         Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId INNER JOIN
                         Drd.tblPardakhtFish ON  Drd.tblSodoorFish.fldId= Drd.tblPardakhtFish.fldFishId INNER JOIN
						 Drd.tblNahvePardakht ON tblNahvePardakht.fldId = tblPardakhtFish.fldNahvePardakhtId
						 WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId)
						 AND CAST( tblPardakhtFish.fldDatePardakht AS DATE) BETWEEN @StartDate AND @EndDate
								 AND Drd.tblElamAvarez.fldOrganId=@organid
		GROUP BY tblSodoorFish.fldId,fldAshakhasID,Drd.tblSodoorFish.fldTarikh,tblCodhayeDaramadiElamAvarez.fldElamAvarezId,Com.tblShomareHesabeOmoomi.fldShomareHesab,fldMablaghAvarezGerdShode,tblPardakhtFish.fldTarikh,tblNahvePardakht.fldTitle,fldTarikhVariz
union all 

SELECT        Drd.tblSodoorFish.fldId AS FishId,
                             (SELECT        CASE WHEN fldHaghighiId IS NOT NULL THEN
                                                             (SELECT        fldName + ' ' + fldFamily
                                                               FROM            Com.tblEmployee
                                                               WHERE        fldId = fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN
                                                             (SELECT        fldName
                                                               FROM            Com.tblAshkhaseHoghoghi
                                                               WHERE        fldId = fldHoghoghiId) END AS Expr1
                               FROM            Com.tblAshkhas
                               WHERE        (fldId = Drd.tblElamAvarez.fldAshakhasID)) AS Name,
                             (SELECT        CASE WHEN fldHaghighiId IS NOT NULL THEN
                                                             (SELECT        fldCodemeli
                                                               FROM            Com.tblEmployee
                                                               WHERE        fldId = fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN
                                                             (SELECT        fldShomareSabt
                                                               FROM            Com.tblAshkhaseHoghoghi
                                                               WHERE        fldId = fldHoghoghiId) END AS Expr1
                               FROM            Com.tblAshkhas AS tblAshkhas_1
                               WHERE        (fldId = Drd.tblElamAvarez.fldAshakhasID)) AS Codemeli, Drd.tblSodoorFish.fldTarikh AS TarikhSodoor, Com.tblShomareHesabeOmoomi.fldShomareHesab AS ShomareHesab, 
                         Drd.tblSodoorFish.fldMablaghAvarezGerdShode AS MablaghKhales, 0 AS Avarez, 0 AS Maliyat,0, Drd.tblSodoorFish.fldMablaghAvarezGerdShode AS MablaghGhabelPardakht, 
                         Drd.tblPardakhtFish.fldTarikh AS TarikhPardakht,fldTarikhVariz TarikhVariz, Drd.tblNahvePardakht.fldTitle
FROM            Drd.tblPardakhtFish INNER JOIN
                         Drd.tblSodoorFish INNER JOIN
                         Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId INNER JOIN
                         Com.tblShomareHesabeOmoomi ON Drd.tblSodoorFish.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId ON Drd.tblPardakhtFish.fldFishId = Drd.tblSodoorFish.fldId INNER JOIN
                         Drd.tblNahvePardakht ON Drd.tblNahvePardakht.fldId = Drd.tblPardakhtFish.fldNahvePardakhtId           
						  WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId)
						 AND CAST( tblPardakhtFish.fldDatePardakht AS DATE) BETWEEN @StartDate AND @EndDate and tblSodoorFish.fldid not in (select fldFishId from tblSodoorFish_Detail where fldFishId=tblSodoorFish.fldid) 
						AND Drd.tblElamAvarez.fldOrganId=@organid
						GROUP BY tblSodoorFish.fldId,fldAshakhasID,Drd.tblSodoorFish.fldTarikh,fldElamAvarezId,Com.tblShomareHesabeOmoomi.fldShomareHesab,fldMablaghAvarezGerdShode,tblPardakhtFish.fldTarikh,tblNahvePardakht.fldTitle,fldTarikhVariz
			 


end
IF(@FieldName='PardakhtShode_Naghdi')	
BEGIN
IF(@ShomareHesabId<>0)
 SELECT        tblSodoorFish.fldId as FishId,
                             (SELECT        CASE WHEN fldHaghighiId IS NOT NULL THEN
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
                                WHERE        (fldId = Drd.tblElamAvarez.fldAshakhasID)) AS Codemeli,
								tblSodoorFish.fldTarikh as TarikhSodoor,Com.tblShomareHesabeOmoomi.fldShomareHesab as ShomareHesab, 
						ISNULL(SUM(cast(Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifAsliValue * Drd.tblCodhayeDaramadiElamAvarez.fldTedad  as bigint)),
                          SUM(cast(Drd.tblCodhayeDaramadiElamAvarez.fldAsliValue * Drd.tblCodhayeDaramadiElamAvarez.fldTedad  as bigint))) AS MablaghKhales,
                         ISNULL(SUM(cast( Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifAvarezValue as bigint)),SUM(cast( Drd.tblCodhayeDaramadiElamAvarez.fldAvarezValue  as bigint))) AS Avarez,
						 ISNULL(SUM(cast( Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifMaliyatValue as bigint)),SUM( cast(Drd.tblCodhayeDaramadiElamAvarez.fldMaliyatValue as bigint))) AS Maliyat
                          ,ISNULL(SUM( cast(Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifAmuzeshParvareshValue as bigint)),SUM(cast( Drd.tblCodhayeDaramadiElamAvarez.fldAmuzeshParvareshValue as bigint))) AS fldAmuzeshParvareshValue
						  ,fldMablaghAvarezGerdShode as MablaghGhabelPardakht,tblPardakhtFish.fldTarikh AS TarikhPardakht,fldTarikhVariz TarikhVariz,tblNahvePardakht.fldTitle

FROM            Drd.tblSodoorFish inner JOIN
                         Drd.tblSodoorFish_Detail ON Drd.tblSodoorFish.fldId = Drd.tblSodoorFish_Detail.fldFishId INNER JOIN
                         Drd.tblCodhayeDaramadiElamAvarez ON Drd.tblSodoorFish_Detail.fldCodeElamAvarezId = Drd.tblCodhayeDaramadiElamAvarez.fldID INNER JOIN
                         Drd.tblShomareHesabCodeDaramad ON Drd.tblCodhayeDaramadiElamAvarez.fldShomareHesabCodeDaramadId = Drd.tblShomareHesabCodeDaramad.fldId INNER JOIN
                         Drd.tblCodhayeDaramd AS tblCodhayeDaramd_1 ON Drd.tblShomareHesabCodeDaramad.fldCodeDaramadId = tblCodhayeDaramd_1.fldId INNER JOIN
                         Com.tblShomareHesabeOmoomi ON Drd.tblSodoorFish.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                         Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId INNER JOIN
                         Drd.tblPardakhtFish ON  Drd.tblSodoorFish.fldId= Drd.tblPardakhtFish.fldFishId INNER JOIN
						 Drd.tblNahvePardakht ON tblNahvePardakht.fldId = tblPardakhtFish.fldNahvePardakhtId inner join 
						 drd.tblNaghdi_Talab on tblSodoorFish.fldId=tblNaghdi_Talab.fldFishId
						 WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId)
						 AND CAST( tblPardakhtFish.fldDatePardakht AS DATE) BETWEEN @StartDate AND @EndDate
							AND tblSodoorFish.fldShomareHesabId=@ShomareHesabId	AND Drd.tblElamAvarez.fldOrganId=@organid		 
		GROUP BY tblSodoorFish.fldId,fldAshakhasID,Drd.tblSodoorFish.fldTarikh,tblCodhayeDaramadiElamAvarez.fldElamAvarezId,Com.tblShomareHesabeOmoomi.fldShomareHesab,fldMablaghAvarezGerdShode,tblPardakhtFish.fldTarikh,tblNahvePardakht.fldTitle,fldTarikhVariz
union all 

SELECT        Drd.tblSodoorFish.fldId AS FishId,
                             (SELECT        CASE WHEN fldHaghighiId IS NOT NULL THEN
                                                             (SELECT        fldName + ' ' + fldFamily
                                                               FROM            Com.tblEmployee
                                                               WHERE        fldId = fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN
                                                             (SELECT        fldName
                                                               FROM            Com.tblAshkhaseHoghoghi
                                                               WHERE        fldId = fldHoghoghiId) END AS Expr1
                               FROM            Com.tblAshkhas
                               WHERE        (fldId = Drd.tblElamAvarez.fldAshakhasID)) AS Name,
                             (SELECT        CASE WHEN fldHaghighiId IS NOT NULL THEN
                                                             (SELECT        fldCodemeli
                                                               FROM            Com.tblEmployee
                                                               WHERE        fldId = fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN
                                                             (SELECT        fldShomareSabt
                                                               FROM            Com.tblAshkhaseHoghoghi
                                                               WHERE        fldId = fldHoghoghiId) END AS Expr1
                               FROM            Com.tblAshkhas AS tblAshkhas_1
                               WHERE        (fldId = Drd.tblElamAvarez.fldAshakhasID)) AS Codemeli, Drd.tblSodoorFish.fldTarikh AS TarikhSodoor, Com.tblShomareHesabeOmoomi.fldShomareHesab AS ShomareHesab, 
                         Drd.tblSodoorFish.fldMablaghAvarezGerdShode AS MablaghKhales, 0 AS Avarez, 0 AS Maliyat,0 as  fldAmuzeshParvareshValue, Drd.tblSodoorFish.fldMablaghAvarezGerdShode AS MablaghGhabelPardakht, 
                         Drd.tblPardakhtFish.fldTarikh AS TarikhPardakht,fldTarikhVariz TarikhVariz, Drd.tblNahvePardakht.fldTitle
FROM            Drd.tblPardakhtFish INNER JOIN
                         Drd.tblSodoorFish INNER JOIN
                         Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId INNER JOIN
                         Com.tblShomareHesabeOmoomi ON Drd.tblSodoorFish.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId ON Drd.tblPardakhtFish.fldFishId = Drd.tblSodoorFish.fldId INNER JOIN
                         Drd.tblNahvePardakht ON Drd.tblNahvePardakht.fldId = Drd.tblPardakhtFish.fldNahvePardakhtId inner join 
						 drd.tblNaghdi_Talab on tblSodoorFish.fldId=tblNaghdi_Talab.fldFishId         
						  WHERE tblSodoorFish.fldId NOT IN (SELECT tblEbtal.fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId)
						 AND CAST( tblPardakhtFish.fldDatePardakht AS DATE) BETWEEN @StartDate AND @EndDate and tblSodoorFish.fldid not in (select fldFishId from tblSodoorFish_Detail where fldFishId=tblSodoorFish.fldid) 
						AND tblSodoorFish.fldShomareHesabId=@ShomareHesabId		AND Drd.tblElamAvarez.fldOrganId=@organid
						GROUP BY tblSodoorFish.fldId,fldAshakhasID,Drd.tblSodoorFish.fldTarikh,fldElamAvarezId,Com.tblShomareHesabeOmoomi.fldShomareHesab,fldMablaghAvarezGerdShode,tblPardakhtFish.fldTarikh,tblNahvePardakht.fldTitle,fldTarikhVariz
ELSE			 
 SELECT        tblSodoorFish.fldId as FishId,
                             (SELECT        CASE WHEN fldHaghighiId IS NOT NULL THEN
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
                                WHERE        (fldId = Drd.tblElamAvarez.fldAshakhasID)) AS Codemeli,
								tblSodoorFish.fldTarikh as TarikhSodoor,Com.tblShomareHesabeOmoomi.fldShomareHesab as ShomareHesab, 
						ISNULL(SUM(cast(Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifAsliValue * Drd.tblCodhayeDaramadiElamAvarez.fldTedad  as bigint)),
                          SUM(cast(Drd.tblCodhayeDaramadiElamAvarez.fldAsliValue * Drd.tblCodhayeDaramadiElamAvarez.fldTedad  as bigint))) AS MablaghKhales,
                         ISNULL(SUM(cast( Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifAvarezValue as bigint)),SUM(cast( Drd.tblCodhayeDaramadiElamAvarez.fldAvarezValue  as bigint))) AS Avarez,
						 ISNULL(SUM(cast( Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifMaliyatValue as bigint)),SUM( cast(Drd.tblCodhayeDaramadiElamAvarez.fldMaliyatValue as bigint))) AS Maliyat
                           ,ISNULL(SUM( cast(Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifAmuzeshParvareshValue as bigint)),SUM(cast( Drd.tblCodhayeDaramadiElamAvarez.fldAmuzeshParvareshValue as bigint))) AS fldAmuzeshParvareshValue
						  ,fldMablaghAvarezGerdShode as MablaghGhabelPardakht,tblPardakhtFish.fldTarikh AS TarikhPardakht,fldTarikhVariz TarikhVariz,tblNahvePardakht.fldTitle

FROM            Drd.tblSodoorFish inner JOIN
                         Drd.tblSodoorFish_Detail ON Drd.tblSodoorFish.fldId = Drd.tblSodoorFish_Detail.fldFishId INNER JOIN
                         Drd.tblCodhayeDaramadiElamAvarez ON Drd.tblSodoorFish_Detail.fldCodeElamAvarezId = Drd.tblCodhayeDaramadiElamAvarez.fldID INNER JOIN
                         Drd.tblShomareHesabCodeDaramad ON Drd.tblCodhayeDaramadiElamAvarez.fldShomareHesabCodeDaramadId = Drd.tblShomareHesabCodeDaramad.fldId INNER JOIN
                         Drd.tblCodhayeDaramd AS tblCodhayeDaramd_1 ON Drd.tblShomareHesabCodeDaramad.fldCodeDaramadId = tblCodhayeDaramd_1.fldId INNER JOIN
                         Com.tblShomareHesabeOmoomi ON Drd.tblSodoorFish.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                         Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId INNER JOIN
                         Drd.tblPardakhtFish ON  Drd.tblSodoorFish.fldId= Drd.tblPardakhtFish.fldFishId INNER JOIN
						 Drd.tblNahvePardakht ON tblNahvePardakht.fldId = tblPardakhtFish.fldNahvePardakhtId inner join 
						 drd.tblNaghdi_Talab on tblSodoorFish.fldId=tblNaghdi_Talab.fldFishId
						 WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId)
						 AND CAST( tblPardakhtFish.fldDatePardakht AS DATE) BETWEEN @StartDate AND @EndDate
								 AND Drd.tblElamAvarez.fldOrganId=@organid
		GROUP BY tblSodoorFish.fldId,fldAshakhasID,Drd.tblSodoorFish.fldTarikh,tblCodhayeDaramadiElamAvarez.fldElamAvarezId,Com.tblShomareHesabeOmoomi.fldShomareHesab,fldMablaghAvarezGerdShode,tblPardakhtFish.fldTarikh,tblNahvePardakht.fldTitle,fldTarikhVariz
union all 

SELECT        Drd.tblSodoorFish.fldId AS FishId,
                             (SELECT        CASE WHEN fldHaghighiId IS NOT NULL THEN
                                                             (SELECT        fldName + ' ' + fldFamily
                                                               FROM            Com.tblEmployee
                                                               WHERE        fldId = fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN
                                                             (SELECT        fldName
                                                               FROM            Com.tblAshkhaseHoghoghi
                                                               WHERE        fldId = fldHoghoghiId) END AS Expr1
                               FROM            Com.tblAshkhas
                               WHERE        (fldId = Drd.tblElamAvarez.fldAshakhasID)) AS Name,
                             (SELECT        CASE WHEN fldHaghighiId IS NOT NULL THEN
                                                             (SELECT        fldCodemeli
                                                               FROM            Com.tblEmployee
                                                               WHERE        fldId = fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN
                                                             (SELECT        fldShomareSabt
                                                               FROM            Com.tblAshkhaseHoghoghi
                                                               WHERE        fldId = fldHoghoghiId) END AS Expr1
                               FROM            Com.tblAshkhas AS tblAshkhas_1
                               WHERE        (fldId = Drd.tblElamAvarez.fldAshakhasID)) AS Codemeli, Drd.tblSodoorFish.fldTarikh AS TarikhSodoor, Com.tblShomareHesabeOmoomi.fldShomareHesab AS ShomareHesab, 
                         Drd.tblSodoorFish.fldMablaghAvarezGerdShode AS MablaghKhales, 0 AS Avarez, 0 AS Maliyat,0 as fldAmuzeshParvareshValue, Drd.tblSodoorFish.fldMablaghAvarezGerdShode AS MablaghGhabelPardakht, 
                         Drd.tblPardakhtFish.fldTarikh AS TarikhPardakht,fldTarikhVariz TarikhVariz, Drd.tblNahvePardakht.fldTitle
FROM            Drd.tblPardakhtFish INNER JOIN
                         Drd.tblSodoorFish INNER JOIN
                         Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId INNER JOIN
                         Com.tblShomareHesabeOmoomi ON Drd.tblSodoorFish.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId ON Drd.tblPardakhtFish.fldFishId = Drd.tblSodoorFish.fldId INNER JOIN
                         Drd.tblNahvePardakht ON Drd.tblNahvePardakht.fldId = Drd.tblPardakhtFish.fldNahvePardakhtId inner join 
						 drd.tblNaghdi_Talab on tblSodoorFish.fldId=tblNaghdi_Talab.fldFishId        
						  WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId)
						 AND CAST( tblPardakhtFish.fldDatePardakht AS DATE) BETWEEN @StartDate AND @EndDate and tblSodoorFish.fldid not in (select fldFishId from tblSodoorFish_Detail where fldFishId=tblSodoorFish.fldid) 
						AND Drd.tblElamAvarez.fldOrganId=@organid
						GROUP BY tblSodoorFish.fldId,fldAshakhasID,Drd.tblSodoorFish.fldTarikh,fldElamAvarezId,Com.tblShomareHesabeOmoomi.fldShomareHesab,fldMablaghAvarezGerdShode,tblPardakhtFish.fldTarikh,tblNahvePardakht.fldTitle,fldTarikhVariz
			 


end
IF(@FieldName='fldDateVarizPardakhtShode')	
BEGIN
IF(@ShomareHesabId<>0)
 SELECT        tblSodoorFish.fldId as FishId,
                             (SELECT        CASE WHEN fldHaghighiId IS NOT NULL THEN
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
                                WHERE        (fldId = Drd.tblElamAvarez.fldAshakhasID)) AS Codemeli,
								tblSodoorFish.fldTarikh as TarikhSodoor,Com.tblShomareHesabeOmoomi.fldShomareHesab as ShomareHesab, 
						ISNULL(SUM(cast(Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifAsliValue * Drd.tblCodhayeDaramadiElamAvarez.fldTedad  as bigint)),
                          SUM(cast(Drd.tblCodhayeDaramadiElamAvarez.fldAsliValue * Drd.tblCodhayeDaramadiElamAvarez.fldTedad  as bigint))) AS MablaghKhales,
                         ISNULL(SUM(cast( Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifAvarezValue as bigint)),SUM(cast( Drd.tblCodhayeDaramadiElamAvarez.fldAvarezValue  as bigint))) AS Avarez,
						 ISNULL(SUM(cast( Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifMaliyatValue as bigint)),SUM( cast(Drd.tblCodhayeDaramadiElamAvarez.fldMaliyatValue as bigint))) AS Maliyat
                          ,ISNULL(SUM( cast(Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifAmuzeshParvareshValue as bigint)),SUM(cast( Drd.tblCodhayeDaramadiElamAvarez.fldAmuzeshParvareshValue as bigint))) AS fldAmuzeshParvareshValue
						  ,fldMablaghAvarezGerdShode as MablaghGhabelPardakht,tblPardakhtFish.fldTarikh AS TarikhPardakht,fldTarikhVariz TarikhVariz,tblNahvePardakht.fldTitle

FROM            Drd.tblSodoorFish inner JOIN
                         Drd.tblSodoorFish_Detail ON Drd.tblSodoorFish.fldId = Drd.tblSodoorFish_Detail.fldFishId INNER JOIN
                         Drd.tblCodhayeDaramadiElamAvarez ON Drd.tblSodoorFish_Detail.fldCodeElamAvarezId = Drd.tblCodhayeDaramadiElamAvarez.fldID INNER JOIN
                         Drd.tblShomareHesabCodeDaramad ON Drd.tblCodhayeDaramadiElamAvarez.fldShomareHesabCodeDaramadId = Drd.tblShomareHesabCodeDaramad.fldId INNER JOIN
                         Drd.tblCodhayeDaramd AS tblCodhayeDaramd_1 ON Drd.tblShomareHesabCodeDaramad.fldCodeDaramadId = tblCodhayeDaramd_1.fldId INNER JOIN
                         Com.tblShomareHesabeOmoomi ON Drd.tblSodoorFish.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                         Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId INNER JOIN
                         Drd.tblPardakhtFish ON  Drd.tblSodoorFish.fldId= Drd.tblPardakhtFish.fldFishId INNER JOIN
						 Drd.tblNahvePardakht ON tblNahvePardakht.fldId = tblPardakhtFish.fldNahvePardakhtId
						 WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId)
						 AND CAST( tblPardakhtFish.fldDateVariz AS DATE) BETWEEN @StartDate AND @EndDate
							AND tblSodoorFish.fldShomareHesabId=@ShomareHesabId	AND Drd.tblElamAvarez.fldOrganId=@organid		 
		GROUP BY tblSodoorFish.fldId,fldAshakhasID,Drd.tblSodoorFish.fldTarikh,tblCodhayeDaramadiElamAvarez.fldElamAvarezId,Com.tblShomareHesabeOmoomi.fldShomareHesab,fldMablaghAvarezGerdShode,tblPardakhtFish.fldTarikh,tblNahvePardakht.fldTitle,fldTarikhVariz
union all 

SELECT        Drd.tblSodoorFish.fldId AS FishId,
                             (SELECT        CASE WHEN fldHaghighiId IS NOT NULL THEN
                                                             (SELECT        fldName + ' ' + fldFamily
                                                               FROM            Com.tblEmployee
                                                               WHERE        fldId = fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN
                                                             (SELECT        fldName
                                                               FROM            Com.tblAshkhaseHoghoghi
                                                               WHERE        fldId = fldHoghoghiId) END AS Expr1
                               FROM            Com.tblAshkhas
                               WHERE        (fldId = Drd.tblElamAvarez.fldAshakhasID)) AS Name,
                             (SELECT        CASE WHEN fldHaghighiId IS NOT NULL THEN
                                                             (SELECT        fldCodemeli
                                                               FROM            Com.tblEmployee
                                                               WHERE        fldId = fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN
                                                             (SELECT        fldShomareSabt
                                                               FROM            Com.tblAshkhaseHoghoghi
                                                               WHERE        fldId = fldHoghoghiId) END AS Expr1
                               FROM            Com.tblAshkhas AS tblAshkhas_1
                               WHERE        (fldId = Drd.tblElamAvarez.fldAshakhasID)) AS Codemeli, Drd.tblSodoorFish.fldTarikh AS TarikhSodoor, Com.tblShomareHesabeOmoomi.fldShomareHesab AS ShomareHesab, 
                         Drd.tblSodoorFish.fldMablaghAvarezGerdShode AS MablaghKhales, 0 AS Avarez, 0 AS Maliyat,0  as fldAmuzeshParvareshValue , Drd.tblSodoorFish.fldMablaghAvarezGerdShode AS MablaghGhabelPardakht, 
                         Drd.tblPardakhtFish.fldTarikh AS TarikhPardakht,fldTarikhVariz TarikhVariz, Drd.tblNahvePardakht.fldTitle
FROM            Drd.tblPardakhtFish INNER JOIN
                         Drd.tblSodoorFish INNER JOIN
                         Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId INNER JOIN
                         Com.tblShomareHesabeOmoomi ON Drd.tblSodoorFish.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId ON Drd.tblPardakhtFish.fldFishId = Drd.tblSodoorFish.fldId INNER JOIN
                         Drd.tblNahvePardakht ON Drd.tblNahvePardakht.fldId = Drd.tblPardakhtFish.fldNahvePardakhtId           
						  WHERE tblSodoorFish.fldId NOT IN (SELECT tblEbtal.fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId)
						 AND CAST( tblPardakhtFish.fldDateVariz AS DATE) BETWEEN @StartDate AND @EndDate and tblSodoorFish.fldid not in (select fldFishId from tblSodoorFish_Detail where fldFishId=tblSodoorFish.fldid) 
						AND tblSodoorFish.fldShomareHesabId=@ShomareHesabId		AND Drd.tblElamAvarez.fldOrganId=@organid
						GROUP BY tblSodoorFish.fldId,fldAshakhasID,Drd.tblSodoorFish.fldTarikh,fldElamAvarezId,Com.tblShomareHesabeOmoomi.fldShomareHesab,fldMablaghAvarezGerdShode,tblPardakhtFish.fldTarikh,tblNahvePardakht.fldTitle,fldTarikhVariz
ELSE			 
 SELECT        tblSodoorFish.fldId as FishId,
                             (SELECT        CASE WHEN fldHaghighiId IS NOT NULL THEN
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
                                WHERE        (fldId = Drd.tblElamAvarez.fldAshakhasID)) AS Codemeli,
								tblSodoorFish.fldTarikh as TarikhSodoor,Com.tblShomareHesabeOmoomi.fldShomareHesab as ShomareHesab, 
						ISNULL(SUM(cast(Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifAsliValue * Drd.tblCodhayeDaramadiElamAvarez.fldTedad  as bigint)),
                          SUM(cast(Drd.tblCodhayeDaramadiElamAvarez.fldAsliValue * Drd.tblCodhayeDaramadiElamAvarez.fldTedad  as bigint))) AS MablaghKhales,
                         ISNULL(SUM(cast( Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifAvarezValue as bigint)),SUM(cast( Drd.tblCodhayeDaramadiElamAvarez.fldAvarezValue  as bigint))) AS Avarez,
						 ISNULL(SUM(cast( Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifMaliyatValue as bigint)),SUM( cast(Drd.tblCodhayeDaramadiElamAvarez.fldMaliyatValue as bigint))) AS Maliyat
                           ,ISNULL(SUM( cast(Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifAmuzeshParvareshValue as bigint)),SUM(cast( Drd.tblCodhayeDaramadiElamAvarez.fldAmuzeshParvareshValue as bigint))) AS fldAmuzeshParvareshValue
						  ,fldMablaghAvarezGerdShode as MablaghGhabelPardakht,tblPardakhtFish.fldTarikh AS TarikhPardakht,fldTarikhVariz TarikhVariz,tblNahvePardakht.fldTitle

FROM            Drd.tblSodoorFish inner JOIN
                         Drd.tblSodoorFish_Detail ON Drd.tblSodoorFish.fldId = Drd.tblSodoorFish_Detail.fldFishId INNER JOIN
                         Drd.tblCodhayeDaramadiElamAvarez ON Drd.tblSodoorFish_Detail.fldCodeElamAvarezId = Drd.tblCodhayeDaramadiElamAvarez.fldID INNER JOIN
                         Drd.tblShomareHesabCodeDaramad ON Drd.tblCodhayeDaramadiElamAvarez.fldShomareHesabCodeDaramadId = Drd.tblShomareHesabCodeDaramad.fldId INNER JOIN
                         Drd.tblCodhayeDaramd AS tblCodhayeDaramd_1 ON Drd.tblShomareHesabCodeDaramad.fldCodeDaramadId = tblCodhayeDaramd_1.fldId INNER JOIN
                         Com.tblShomareHesabeOmoomi ON Drd.tblSodoorFish.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                         Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId INNER JOIN
                         Drd.tblPardakhtFish ON  Drd.tblSodoorFish.fldId= Drd.tblPardakhtFish.fldFishId INNER JOIN
						 Drd.tblNahvePardakht ON tblNahvePardakht.fldId = tblPardakhtFish.fldNahvePardakhtId
						 WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId)
						 AND CAST( tblPardakhtFish.fldDateVariz AS DATE) BETWEEN @StartDate AND @EndDate
								 AND Drd.tblElamAvarez.fldOrganId=@organid
		GROUP BY tblSodoorFish.fldId,fldAshakhasID,Drd.tblSodoorFish.fldTarikh,tblCodhayeDaramadiElamAvarez.fldElamAvarezId,Com.tblShomareHesabeOmoomi.fldShomareHesab,fldMablaghAvarezGerdShode,tblPardakhtFish.fldTarikh,tblNahvePardakht.fldTitle,fldTarikhVariz
union all 

SELECT        Drd.tblSodoorFish.fldId AS FishId,
                             (SELECT        CASE WHEN fldHaghighiId IS NOT NULL THEN
                                                             (SELECT        fldName + ' ' + fldFamily
                                                               FROM            Com.tblEmployee
                                                               WHERE        fldId = fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN
                                                             (SELECT        fldName
                                                               FROM            Com.tblAshkhaseHoghoghi
                                                               WHERE        fldId = fldHoghoghiId) END AS Expr1
                               FROM            Com.tblAshkhas
                               WHERE        (fldId = Drd.tblElamAvarez.fldAshakhasID)) AS Name,
                             (SELECT        CASE WHEN fldHaghighiId IS NOT NULL THEN
                                                             (SELECT        fldCodemeli
                                                               FROM            Com.tblEmployee
                                                               WHERE        fldId = fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN
                                                             (SELECT        fldShomareSabt
                                                               FROM            Com.tblAshkhaseHoghoghi
                                                               WHERE        fldId = fldHoghoghiId) END AS Expr1
                               FROM            Com.tblAshkhas AS tblAshkhas_1
                               WHERE        (fldId = Drd.tblElamAvarez.fldAshakhasID)) AS Codemeli, Drd.tblSodoorFish.fldTarikh AS TarikhSodoor, Com.tblShomareHesabeOmoomi.fldShomareHesab AS ShomareHesab, 
                         Drd.tblSodoorFish.fldMablaghAvarezGerdShode AS MablaghKhales, 0 AS Avarez, 0 AS Maliyat,0 as fldAmuzeshParvareshValue, Drd.tblSodoorFish.fldMablaghAvarezGerdShode AS MablaghGhabelPardakht, 
                         Drd.tblPardakhtFish.fldTarikh AS TarikhPardakht,fldTarikhVariz TarikhVariz, Drd.tblNahvePardakht.fldTitle
FROM            Drd.tblPardakhtFish INNER JOIN
                         Drd.tblSodoorFish INNER JOIN
                         Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId INNER JOIN
                         Com.tblShomareHesabeOmoomi ON Drd.tblSodoorFish.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId ON Drd.tblPardakhtFish.fldFishId = Drd.tblSodoorFish.fldId INNER JOIN
                         Drd.tblNahvePardakht ON Drd.tblNahvePardakht.fldId = Drd.tblPardakhtFish.fldNahvePardakhtId           
						  WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId)
						 AND CAST( tblPardakhtFish.fldDateVariz AS DATE) BETWEEN @StartDate AND @EndDate and tblSodoorFish.fldid not in (select fldFishId from tblSodoorFish_Detail where fldFishId=tblSodoorFish.fldid) 
						AND Drd.tblElamAvarez.fldOrganId=@organid
						GROUP BY tblSodoorFish.fldId,fldAshakhasID,Drd.tblSodoorFish.fldTarikh,fldElamAvarezId,Com.tblShomareHesabeOmoomi.fldShomareHesab,fldMablaghAvarezGerdShode,tblPardakhtFish.fldTarikh,tblNahvePardakht.fldTitle,fldTarikhVariz
			 


end
IF(@FieldName='fldDateVarizPardakhtShode_Naghdi')	
BEGIN
IF(@ShomareHesabId<>0)
 SELECT        tblSodoorFish.fldId as FishId,
                             (SELECT        CASE WHEN fldHaghighiId IS NOT NULL THEN
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
                                WHERE        (fldId = Drd.tblElamAvarez.fldAshakhasID)) AS Codemeli,
								tblSodoorFish.fldTarikh as TarikhSodoor,Com.tblShomareHesabeOmoomi.fldShomareHesab as ShomareHesab, 
						ISNULL(SUM(cast(Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifAsliValue * Drd.tblCodhayeDaramadiElamAvarez.fldTedad  as bigint)),
                          SUM(cast(Drd.tblCodhayeDaramadiElamAvarez.fldAsliValue * Drd.tblCodhayeDaramadiElamAvarez.fldTedad  as bigint))) AS MablaghKhales,
                         ISNULL(SUM(cast( Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifAvarezValue as bigint)),SUM(cast( Drd.tblCodhayeDaramadiElamAvarez.fldAvarezValue  as bigint))) AS Avarez,
						 ISNULL(SUM(cast( Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifMaliyatValue as bigint)),SUM( cast(Drd.tblCodhayeDaramadiElamAvarez.fldMaliyatValue as bigint))) AS Maliyat
                          ,ISNULL(SUM( cast(Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifAmuzeshParvareshValue as bigint)),SUM(cast( Drd.tblCodhayeDaramadiElamAvarez.fldAmuzeshParvareshValue as bigint))) AS fldAmuzeshParvareshValue
						  ,fldMablaghAvarezGerdShode as MablaghGhabelPardakht,tblPardakhtFish.fldTarikh AS TarikhPardakht,fldTarikhVariz TarikhVariz,tblNahvePardakht.fldTitle

FROM            Drd.tblSodoorFish inner JOIN
                         Drd.tblSodoorFish_Detail ON Drd.tblSodoorFish.fldId = Drd.tblSodoorFish_Detail.fldFishId INNER JOIN
                         Drd.tblCodhayeDaramadiElamAvarez ON Drd.tblSodoorFish_Detail.fldCodeElamAvarezId = Drd.tblCodhayeDaramadiElamAvarez.fldID INNER JOIN
                         Drd.tblShomareHesabCodeDaramad ON Drd.tblCodhayeDaramadiElamAvarez.fldShomareHesabCodeDaramadId = Drd.tblShomareHesabCodeDaramad.fldId INNER JOIN
                         Drd.tblCodhayeDaramd AS tblCodhayeDaramd_1 ON Drd.tblShomareHesabCodeDaramad.fldCodeDaramadId = tblCodhayeDaramd_1.fldId INNER JOIN
                         Com.tblShomareHesabeOmoomi ON Drd.tblSodoorFish.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                         Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId INNER JOIN
                         Drd.tblPardakhtFish ON  Drd.tblSodoorFish.fldId= Drd.tblPardakhtFish.fldFishId INNER JOIN
						 Drd.tblNahvePardakht ON tblNahvePardakht.fldId = tblPardakhtFish.fldNahvePardakhtId inner join 
						 drd.tblNaghdi_Talab on tblSodoorFish.fldId=tblNaghdi_Talab.fldFishId
						 WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId)
						 AND CAST( tblPardakhtFish.fldDateVariz AS DATE) BETWEEN @StartDate AND @EndDate
							AND tblSodoorFish.fldShomareHesabId=@ShomareHesabId	AND Drd.tblElamAvarez.fldOrganId=@organid		 
		GROUP BY tblSodoorFish.fldId,fldAshakhasID,Drd.tblSodoorFish.fldTarikh,tblCodhayeDaramadiElamAvarez.fldElamAvarezId,Com.tblShomareHesabeOmoomi.fldShomareHesab,fldMablaghAvarezGerdShode,tblPardakhtFish.fldTarikh,tblNahvePardakht.fldTitle,fldTarikhVariz
union all 

SELECT        Drd.tblSodoorFish.fldId AS FishId,
                             (SELECT        CASE WHEN fldHaghighiId IS NOT NULL THEN
                                                             (SELECT        fldName + ' ' + fldFamily
                                                               FROM            Com.tblEmployee
                                                               WHERE        fldId = fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN
                                                             (SELECT        fldName
                                                               FROM            Com.tblAshkhaseHoghoghi
                                                               WHERE        fldId = fldHoghoghiId) END AS Expr1
                               FROM            Com.tblAshkhas
                               WHERE        (fldId = Drd.tblElamAvarez.fldAshakhasID)) AS Name,
                             (SELECT        CASE WHEN fldHaghighiId IS NOT NULL THEN
                                                             (SELECT        fldCodemeli
                                                               FROM            Com.tblEmployee
                                                               WHERE        fldId = fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN
                                                             (SELECT        fldShomareSabt
                                                               FROM            Com.tblAshkhaseHoghoghi
                                                               WHERE        fldId = fldHoghoghiId) END AS Expr1
                               FROM            Com.tblAshkhas AS tblAshkhas_1
                               WHERE        (fldId = Drd.tblElamAvarez.fldAshakhasID)) AS Codemeli, Drd.tblSodoorFish.fldTarikh AS TarikhSodoor, Com.tblShomareHesabeOmoomi.fldShomareHesab AS ShomareHesab, 
                         Drd.tblSodoorFish.fldMablaghAvarezGerdShode AS MablaghKhales, 0 AS Avarez, 0 AS Maliyat,0 as fldAmuzeshParvareshValue, Drd.tblSodoorFish.fldMablaghAvarezGerdShode AS MablaghGhabelPardakht, 
                         Drd.tblPardakhtFish.fldTarikh AS TarikhPardakht,fldTarikhVariz TarikhVariz, Drd.tblNahvePardakht.fldTitle
FROM            Drd.tblPardakhtFish INNER JOIN
                         Drd.tblSodoorFish INNER JOIN
                         Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId INNER JOIN
                         Com.tblShomareHesabeOmoomi ON Drd.tblSodoorFish.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId ON Drd.tblPardakhtFish.fldFishId = Drd.tblSodoorFish.fldId INNER JOIN
                         Drd.tblNahvePardakht ON Drd.tblNahvePardakht.fldId = Drd.tblPardakhtFish.fldNahvePardakhtId inner join 
						 drd.tblNaghdi_Talab on tblSodoorFish.fldId=tblNaghdi_Talab.fldFishId
						  WHERE tblSodoorFish.fldId NOT IN (SELECT tblEbtal.fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId)
						 AND CAST( tblPardakhtFish.fldDateVariz AS DATE) BETWEEN @StartDate AND @EndDate and tblSodoorFish.fldid not in (select fldFishId from tblSodoorFish_Detail where fldFishId=tblSodoorFish.fldid) 
						AND tblSodoorFish.fldShomareHesabId=@ShomareHesabId		AND Drd.tblElamAvarez.fldOrganId=@organid
						GROUP BY tblSodoorFish.fldId,fldAshakhasID,Drd.tblSodoorFish.fldTarikh,fldElamAvarezId,Com.tblShomareHesabeOmoomi.fldShomareHesab,fldMablaghAvarezGerdShode,tblPardakhtFish.fldTarikh,tblNahvePardakht.fldTitle,fldTarikhVariz
ELSE			 
 SELECT        tblSodoorFish.fldId as FishId,
                             (SELECT        CASE WHEN fldHaghighiId IS NOT NULL THEN
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
                                WHERE        (fldId = Drd.tblElamAvarez.fldAshakhasID)) AS Codemeli,
								tblSodoorFish.fldTarikh as TarikhSodoor,Com.tblShomareHesabeOmoomi.fldShomareHesab as ShomareHesab, 
						ISNULL(SUM(cast(Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifAsliValue * Drd.tblCodhayeDaramadiElamAvarez.fldTedad  as bigint)),
                          SUM(cast(Drd.tblCodhayeDaramadiElamAvarez.fldAsliValue * Drd.tblCodhayeDaramadiElamAvarez.fldTedad  as bigint))) AS MablaghKhales,
                         ISNULL(SUM(cast( Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifAvarezValue as bigint)),SUM(cast( Drd.tblCodhayeDaramadiElamAvarez.fldAvarezValue  as bigint))) AS Avarez,
						 ISNULL(SUM(cast( Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifMaliyatValue as bigint)),SUM( cast(Drd.tblCodhayeDaramadiElamAvarez.fldMaliyatValue as bigint))) AS Maliyat
                          ,ISNULL(SUM( cast(Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifAmuzeshParvareshValue as bigint)),SUM(cast( Drd.tblCodhayeDaramadiElamAvarez.fldAmuzeshParvareshValue as bigint))) AS fldAmuzeshParvareshValue
						  ,fldMablaghAvarezGerdShode as MablaghGhabelPardakht,tblPardakhtFish.fldTarikh AS TarikhPardakht,fldTarikhVariz TarikhVariz,tblNahvePardakht.fldTitle

FROM            Drd.tblSodoorFish inner JOIN
                         Drd.tblSodoorFish_Detail ON Drd.tblSodoorFish.fldId = Drd.tblSodoorFish_Detail.fldFishId INNER JOIN
                         Drd.tblCodhayeDaramadiElamAvarez ON Drd.tblSodoorFish_Detail.fldCodeElamAvarezId = Drd.tblCodhayeDaramadiElamAvarez.fldID INNER JOIN
                         Drd.tblShomareHesabCodeDaramad ON Drd.tblCodhayeDaramadiElamAvarez.fldShomareHesabCodeDaramadId = Drd.tblShomareHesabCodeDaramad.fldId INNER JOIN
                         Drd.tblCodhayeDaramd AS tblCodhayeDaramd_1 ON Drd.tblShomareHesabCodeDaramad.fldCodeDaramadId = tblCodhayeDaramd_1.fldId INNER JOIN
                         Com.tblShomareHesabeOmoomi ON Drd.tblSodoorFish.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                         Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId INNER JOIN
                         Drd.tblPardakhtFish ON  Drd.tblSodoorFish.fldId= Drd.tblPardakhtFish.fldFishId INNER JOIN
						 Drd.tblNahvePardakht ON tblNahvePardakht.fldId = tblPardakhtFish.fldNahvePardakhtId inner join 
						 drd.tblNaghdi_Talab on tblSodoorFish.fldId=tblNaghdi_Talab.fldFishId
						 WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId)
						 AND CAST( tblPardakhtFish.fldDateVariz AS DATE) BETWEEN @StartDate AND @EndDate
								 AND Drd.tblElamAvarez.fldOrganId=@organid
		GROUP BY tblSodoorFish.fldId,fldAshakhasID,Drd.tblSodoorFish.fldTarikh,tblCodhayeDaramadiElamAvarez.fldElamAvarezId,Com.tblShomareHesabeOmoomi.fldShomareHesab,fldMablaghAvarezGerdShode,tblPardakhtFish.fldTarikh,tblNahvePardakht.fldTitle,fldTarikhVariz
union all 

SELECT        Drd.tblSodoorFish.fldId AS FishId,
                             (SELECT        CASE WHEN fldHaghighiId IS NOT NULL THEN
                                                             (SELECT        fldName + ' ' + fldFamily
                                                               FROM            Com.tblEmployee
                                                               WHERE        fldId = fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN
                                                             (SELECT        fldName
                                                               FROM            Com.tblAshkhaseHoghoghi
                                                               WHERE        fldId = fldHoghoghiId) END AS Expr1
                               FROM            Com.tblAshkhas
                               WHERE        (fldId = Drd.tblElamAvarez.fldAshakhasID)) AS Name,
                             (SELECT        CASE WHEN fldHaghighiId IS NOT NULL THEN
                                                             (SELECT        fldCodemeli
                                                               FROM            Com.tblEmployee
                                                               WHERE        fldId = fldHaghighiId) WHEN fldHoghoghiId IS NOT NULL THEN
                                                             (SELECT        fldShomareSabt
                                                               FROM            Com.tblAshkhaseHoghoghi
                                                               WHERE        fldId = fldHoghoghiId) END AS Expr1
                               FROM            Com.tblAshkhas AS tblAshkhas_1
                               WHERE        (fldId = Drd.tblElamAvarez.fldAshakhasID)) AS Codemeli, Drd.tblSodoorFish.fldTarikh AS TarikhSodoor, Com.tblShomareHesabeOmoomi.fldShomareHesab AS ShomareHesab, 
                         Drd.tblSodoorFish.fldMablaghAvarezGerdShode AS MablaghKhales, 0 AS Avarez, 0 AS Maliyat,0 as fldAmuzeshParvareshValue, Drd.tblSodoorFish.fldMablaghAvarezGerdShode AS MablaghGhabelPardakht, 
                         Drd.tblPardakhtFish.fldTarikh AS TarikhPardakht,fldTarikhVariz TarikhVariz, Drd.tblNahvePardakht.fldTitle
FROM            Drd.tblPardakhtFish INNER JOIN
                         Drd.tblSodoorFish INNER JOIN
                         Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId INNER JOIN
                         Com.tblShomareHesabeOmoomi ON Drd.tblSodoorFish.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId ON Drd.tblPardakhtFish.fldFishId = Drd.tblSodoorFish.fldId INNER JOIN
                         Drd.tblNahvePardakht ON Drd.tblNahvePardakht.fldId = Drd.tblPardakhtFish.fldNahvePardakhtId inner join 
						 drd.tblNaghdi_Talab on tblSodoorFish.fldId=tblNaghdi_Talab.fldFishId        
						  WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId)
						 AND CAST( tblPardakhtFish.fldDateVariz AS DATE) BETWEEN @StartDate AND @EndDate and tblSodoorFish.fldid not in (select fldFishId from tblSodoorFish_Detail where fldFishId=tblSodoorFish.fldid) 
						AND Drd.tblElamAvarez.fldOrganId=@organid
						GROUP BY tblSodoorFish.fldId,fldAshakhasID,Drd.tblSodoorFish.fldTarikh,fldElamAvarezId,Com.tblShomareHesabeOmoomi.fldShomareHesab,fldMablaghAvarezGerdShode,tblPardakhtFish.fldTarikh,tblNahvePardakht.fldTitle,fldTarikhVariz
			 


end
IF(@FieldName='PardakhtNaShode')
BEGIN	
IF(@ShomareHesabId<>0) 
 SELECT        tblSodoorFish.fldId as FishId,
                             (SELECT        CASE WHEN fldHaghighiId IS NOT NULL THEN
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
                                WHERE        (fldId = Drd.tblElamAvarez.fldAshakhasID)) AS Codemeli,
								tblSodoorFish.fldTarikh as TarikhSodoor,Com.tblShomareHesabeOmoomi.fldShomareHesab as ShomareHesab, 
						ISNULL(SUM(cast (Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifAsliValue * Drd.tblCodhayeDaramadiElamAvarez.fldTedad  as bigint) ),
                          SUM(cast(Drd.tblCodhayeDaramadiElamAvarez.fldAsliValue * Drd.tblCodhayeDaramadiElamAvarez.fldTedad  as bigint))) AS MablaghKhales,
                         ISNULL(SUM( cast(Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifAvarezValue as bigint)),SUM( cast(Drd.tblCodhayeDaramadiElamAvarez.fldAvarezValue as bigint) )) AS Avarez,
						 ISNULL(SUM( cast(Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifMaliyatValue as bigint)),SUM(cast( Drd.tblCodhayeDaramadiElamAvarez.fldMaliyatValue as bigint))) AS Maliyat
                          ,ISNULL(SUM( cast(Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifAmuzeshParvareshValue as bigint)),SUM(cast( Drd.tblCodhayeDaramadiElamAvarez.fldAmuzeshParvareshValue as bigint))) AS fldAmuzeshParvareshValue
						  ,fldMablaghAvarezGerdShode as MablaghGhabelPardakht,N'' TarikhPardakht,N'' AS TarikhVariz,N'' AS fldTitle

FROM            Drd.tblSodoorFish inner JOIN
                         Drd.tblSodoorFish_Detail ON Drd.tblSodoorFish.fldId = Drd.tblSodoorFish_Detail.fldFishId INNER JOIN
                         Drd.tblCodhayeDaramadiElamAvarez ON Drd.tblSodoorFish_Detail.fldCodeElamAvarezId = Drd.tblCodhayeDaramadiElamAvarez.fldID INNER JOIN
                         Drd.tblShomareHesabCodeDaramad ON Drd.tblCodhayeDaramadiElamAvarez.fldShomareHesabCodeDaramadId = Drd.tblShomareHesabCodeDaramad.fldId INNER JOIN
                         Drd.tblCodhayeDaramd AS tblCodhayeDaramd_1 ON Drd.tblShomareHesabCodeDaramad.fldCodeDaramadId = tblCodhayeDaramd_1.fldId INNER JOIN
                         Com.tblShomareHesabeOmoomi ON Drd.tblSodoorFish.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                         Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId)
						 AND CAST( tblSodoorFish.fldDate AS DATE) BETWEEN @StartDate AND @EndDate
						and tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblPardakhtFish)	
							AND Drd.tblElamAvarez.fldOrganId=@organid	 
		AND tblSodoorFish.fldShomareHesabId=@ShomareHesabId	
		GROUP BY tblSodoorFish.fldId,fldAshakhasID,Drd.tblSodoorFish.fldTarikh,Com.tblShomareHesabeOmoomi.fldShomareHesab,fldMablaghAvarezGerdShode
union all

SELECT        tblSodoorFish.fldId as FishId,
                             (SELECT        CASE WHEN fldHaghighiId IS NOT NULL THEN
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
                                WHERE        (fldId = Drd.tblElamAvarez.fldAshakhasID)) AS Codemeli,
								tblSodoorFish.fldTarikh as TarikhSodoor ,Com.tblShomareHesabeOmoomi.fldShomareHesab as ShomareHesab, 
						fldMablaghAvarezGerdShode AS MablaghKhales,
                        0 AS Avarez,
						 0 AS Maliyat,0 as  fldAmuzeshParvareshValue
						     ,fldMablaghAvarezGerdShode as MablaghGhabelPardakht,'' TarikhPardakht,N'' AS TarikhVariz,N'' AS fldTitle

FROM            Drd.tblSodoorFish INNER JOIN
                         Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId INNER JOIN
                         Drd.tblCodhayeDaramadiElamAvarez ON Drd.tblElamAvarez.fldId = Drd.tblCodhayeDaramadiElamAvarez.fldElamAvarezId INNER JOIN
                         Drd.tblShomareHesabCodeDaramad ON Drd.tblCodhayeDaramadiElamAvarez.fldShomareHesabCodeDaramadId = Drd.tblShomareHesabCodeDaramad.fldId INNER JOIN
                         Com.tblShomareHesabeOmoomi ON Drd.tblSodoorFish.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId AND 
                         Drd.tblCodhayeDaramadiElamAvarez.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                         Drd.tblCodhayeDaramd AS tblCodhayeDaramd_1 ON tblCodhayeDaramd_1.fldId = Drd.tblShomareHesabCodeDaramad.fldCodeDaramadId                       
						  WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId)
						 AND CAST( tblSodoorFish.fldDate AS DATE) BETWEEN @StartDate AND @EndDate
						 and tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblPardakhtFish)
						AND tblSodoorFish.fldShomareHesabId=@ShomareHesabId	
						 and tblSodoorFish.fldId NOT IN (select tblSodoorFish_Detail.fldFishId from drd.tblSodoorFish_Detail where fldFishId=tblSodoorFish.fldId)
							AND Drd.tblElamAvarez.fldOrganId=@organid
							GROUP BY tblSodoorFish.fldId,fldAshakhasID,Drd.tblSodoorFish.fldTarikh,Com.tblShomareHesabeOmoomi.fldShomareHesab,fldMablaghAvarezGerdShode
ELSE
SELECT        tblSodoorFish.fldId as FishId,
                             (SELECT        CASE WHEN fldHaghighiId IS NOT NULL THEN
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
                                WHERE        (fldId = Drd.tblElamAvarez.fldAshakhasID)) AS Codemeli,
								tblSodoorFish.fldTarikh as TarikhSodoor,Com.tblShomareHesabeOmoomi.fldShomareHesab as ShomareHesab, 
						ISNULL(SUM(cast (Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifAsliValue * Drd.tblCodhayeDaramadiElamAvarez.fldTedad  as bigint) ),
                          SUM(cast(Drd.tblCodhayeDaramadiElamAvarez.fldAsliValue * Drd.tblCodhayeDaramadiElamAvarez.fldTedad  as bigint))) AS MablaghKhales,
                         ISNULL(SUM( cast(Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifAvarezValue as bigint)),SUM( cast(Drd.tblCodhayeDaramadiElamAvarez.fldAvarezValue as bigint) )) AS Avarez,
						 ISNULL(SUM( cast(Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifMaliyatValue as bigint)),SUM(cast( Drd.tblCodhayeDaramadiElamAvarez.fldMaliyatValue as bigint))) AS Maliyat
                           ,ISNULL(SUM( cast(Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifAmuzeshParvareshValue as bigint)),SUM(cast( Drd.tblCodhayeDaramadiElamAvarez.fldAmuzeshParvareshValue as bigint))) AS fldAmuzeshParvareshValue
						  ,fldMablaghAvarezGerdShode as MablaghGhabelPardakht,N'' TarikhPardakht,N'' AS TarikhVariz,N'' AS fldTitle

FROM            Drd.tblSodoorFish inner JOIN
                         Drd.tblSodoorFish_Detail ON Drd.tblSodoorFish.fldId = Drd.tblSodoorFish_Detail.fldFishId INNER JOIN
                         Drd.tblCodhayeDaramadiElamAvarez ON Drd.tblSodoorFish_Detail.fldCodeElamAvarezId = Drd.tblCodhayeDaramadiElamAvarez.fldID INNER JOIN
                         Drd.tblShomareHesabCodeDaramad ON Drd.tblCodhayeDaramadiElamAvarez.fldShomareHesabCodeDaramadId = Drd.tblShomareHesabCodeDaramad.fldId INNER JOIN
                         Drd.tblCodhayeDaramd AS tblCodhayeDaramd_1 ON Drd.tblShomareHesabCodeDaramad.fldCodeDaramadId = tblCodhayeDaramd_1.fldId INNER JOIN
                         Com.tblShomareHesabeOmoomi ON Drd.tblSodoorFish.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                         Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId)
						 AND CAST( tblSodoorFish.fldDate AS DATE) BETWEEN @StartDate AND @EndDate
						and tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblPardakhtFish)			 
			AND Drd.tblElamAvarez.fldOrganId=@organid
		GROUP BY tblSodoorFish.fldId,fldAshakhasID,Drd.tblSodoorFish.fldTarikh,Com.tblShomareHesabeOmoomi.fldShomareHesab,fldMablaghAvarezGerdShode
union all

SELECT        tblSodoorFish.fldId as FishId,
                             (SELECT        CASE WHEN fldHaghighiId IS NOT NULL THEN
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
                                WHERE        (fldId = Drd.tblElamAvarez.fldAshakhasID)) AS Codemeli,
								tblSodoorFish.fldTarikh as TarikhSodoor ,Com.tblShomareHesabeOmoomi.fldShomareHesab as ShomareHesab, 
						fldMablaghAvarezGerdShode AS MablaghKhales,
                        0 AS Avarez,
						 0 AS Maliyat,0 as fldAmuzeshParvareshValue 
						     ,fldMablaghAvarezGerdShode as MablaghGhabelPardakht,N'' TarikhPardakht,N'' AS TarikhVariz,N'' AS fldTitle

FROM            Drd.tblSodoorFish INNER JOIN
                         Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId INNER JOIN
                         Drd.tblCodhayeDaramadiElamAvarez ON Drd.tblElamAvarez.fldId = Drd.tblCodhayeDaramadiElamAvarez.fldElamAvarezId INNER JOIN
                         Drd.tblShomareHesabCodeDaramad ON Drd.tblCodhayeDaramadiElamAvarez.fldShomareHesabCodeDaramadId = Drd.tblShomareHesabCodeDaramad.fldId INNER JOIN
                         Com.tblShomareHesabeOmoomi ON Drd.tblSodoorFish.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId AND 
                         Drd.tblCodhayeDaramadiElamAvarez.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                         Drd.tblCodhayeDaramd AS tblCodhayeDaramd_1 ON tblCodhayeDaramd_1.fldId = Drd.tblShomareHesabCodeDaramad.fldCodeDaramadId                       
						  WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId)
						 AND CAST( tblSodoorFish.fldDate AS DATE) BETWEEN @StartDate AND @EndDate
						 and tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblPardakhtFish)
						  and tblSodoorFish.fldId NOT IN (select tblSodoorFish_Detail.fldFishId from drd.tblSodoorFish_Detail where fldFishId=tblSodoorFish.fldId)
						AND Drd.tblElamAvarez.fldOrganId=@organid
							GROUP BY tblSodoorFish.fldId,fldAshakhasID,Drd.tblSodoorFish.fldTarikh,Com.tblShomareHesabeOmoomi.fldShomareHesab,fldMablaghAvarezGerdShode
			 
			 

 end
 IF(@FieldName='PardakhtNaShode_Naghdi')
BEGIN	
IF(@ShomareHesabId<>0) 
 SELECT        tblSodoorFish.fldId as FishId,
                             (SELECT        CASE WHEN fldHaghighiId IS NOT NULL THEN
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
                                WHERE        (fldId = Drd.tblElamAvarez.fldAshakhasID)) AS Codemeli,
								tblSodoorFish.fldTarikh as TarikhSodoor,Com.tblShomareHesabeOmoomi.fldShomareHesab as ShomareHesab, 
						ISNULL(SUM(cast (Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifAsliValue * Drd.tblCodhayeDaramadiElamAvarez.fldTedad  as bigint) ),
                          SUM(cast(Drd.tblCodhayeDaramadiElamAvarez.fldAsliValue * Drd.tblCodhayeDaramadiElamAvarez.fldTedad  as bigint))) AS MablaghKhales,
                         ISNULL(SUM( cast(Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifAvarezValue as bigint)),SUM( cast(Drd.tblCodhayeDaramadiElamAvarez.fldAvarezValue as bigint) )) AS Avarez,
						 ISNULL(SUM( cast(Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifMaliyatValue as bigint)),SUM(cast( Drd.tblCodhayeDaramadiElamAvarez.fldMaliyatValue as bigint))) AS Maliyat
                        ,ISNULL(SUM( cast(Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifAmuzeshParvareshValue as bigint)),SUM(cast( Drd.tblCodhayeDaramadiElamAvarez.fldAmuzeshParvareshValue as bigint))) AS fldAmuzeshParvareshValue
					      ,fldMablaghAvarezGerdShode as MablaghGhabelPardakht,N'' TarikhPardakht,N'' AS TarikhVariz,N'' AS fldTitle

FROM            Drd.tblSodoorFish inner JOIN
                         Drd.tblSodoorFish_Detail ON Drd.tblSodoorFish.fldId = Drd.tblSodoorFish_Detail.fldFishId INNER JOIN
                         Drd.tblCodhayeDaramadiElamAvarez ON Drd.tblSodoorFish_Detail.fldCodeElamAvarezId = Drd.tblCodhayeDaramadiElamAvarez.fldID INNER JOIN
                         Drd.tblShomareHesabCodeDaramad ON Drd.tblCodhayeDaramadiElamAvarez.fldShomareHesabCodeDaramadId = Drd.tblShomareHesabCodeDaramad.fldId INNER JOIN
                         Drd.tblCodhayeDaramd AS tblCodhayeDaramd_1 ON Drd.tblShomareHesabCodeDaramad.fldCodeDaramadId = tblCodhayeDaramd_1.fldId INNER JOIN
                         Com.tblShomareHesabeOmoomi ON Drd.tblSodoorFish.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                         Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId inner join 
						 drd.tblNaghdi_Talab on tblSodoorFish.fldId=tblNaghdi_Talab.fldFishId
						 WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId)
						 AND CAST( tblSodoorFish.fldDate AS DATE) BETWEEN @StartDate AND @EndDate
						and tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblPardakhtFish)	
							AND Drd.tblElamAvarez.fldOrganId=@organid	 
		AND tblSodoorFish.fldShomareHesabId=@ShomareHesabId	
		GROUP BY tblSodoorFish.fldId,fldAshakhasID,Drd.tblSodoorFish.fldTarikh,Com.tblShomareHesabeOmoomi.fldShomareHesab,fldMablaghAvarezGerdShode
union all

SELECT        tblSodoorFish.fldId as FishId,
                             (SELECT        CASE WHEN fldHaghighiId IS NOT NULL THEN
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
                                WHERE        (fldId = Drd.tblElamAvarez.fldAshakhasID)) AS Codemeli,
								tblSodoorFish.fldTarikh as TarikhSodoor ,Com.tblShomareHesabeOmoomi.fldShomareHesab as ShomareHesab, 
						fldMablaghAvarezGerdShode AS MablaghKhales,
                        0 AS Avarez,
						 0 AS Maliyat,0 as fldAmuzeshParvareshValue
						     ,fldMablaghAvarezGerdShode as MablaghGhabelPardakht,'' TarikhPardakht,N'' AS TarikhVariz,N'' AS fldTitle

FROM            Drd.tblSodoorFish INNER JOIN
                         Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId INNER JOIN
                         Drd.tblCodhayeDaramadiElamAvarez ON Drd.tblElamAvarez.fldId = Drd.tblCodhayeDaramadiElamAvarez.fldElamAvarezId INNER JOIN
                         Drd.tblShomareHesabCodeDaramad ON Drd.tblCodhayeDaramadiElamAvarez.fldShomareHesabCodeDaramadId = Drd.tblShomareHesabCodeDaramad.fldId INNER JOIN
                         Com.tblShomareHesabeOmoomi ON Drd.tblSodoorFish.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId AND 
                         Drd.tblCodhayeDaramadiElamAvarez.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                         Drd.tblCodhayeDaramd AS tblCodhayeDaramd_1 ON tblCodhayeDaramd_1.fldId = Drd.tblShomareHesabCodeDaramad.fldCodeDaramadId inner join 
						 drd.tblNaghdi_Talab on tblSodoorFish.fldId=tblNaghdi_Talab.fldFishId                      
						  WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId)
						 AND CAST( tblSodoorFish.fldDate AS DATE) BETWEEN @StartDate AND @EndDate
						 and tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblPardakhtFish)
						AND tblSodoorFish.fldShomareHesabId=@ShomareHesabId	
						 and tblSodoorFish.fldId NOT IN (select tblSodoorFish_Detail.fldFishId from drd.tblSodoorFish_Detail where fldFishId=tblSodoorFish.fldId)
							AND Drd.tblElamAvarez.fldOrganId=@organid
							GROUP BY tblSodoorFish.fldId,fldAshakhasID,Drd.tblSodoorFish.fldTarikh,Com.tblShomareHesabeOmoomi.fldShomareHesab,fldMablaghAvarezGerdShode
ELSE
SELECT        tblSodoorFish.fldId as FishId,
                             (SELECT        CASE WHEN fldHaghighiId IS NOT NULL THEN
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
                                WHERE        (fldId = Drd.tblElamAvarez.fldAshakhasID)) AS Codemeli,
								tblSodoorFish.fldTarikh as TarikhSodoor,Com.tblShomareHesabeOmoomi.fldShomareHesab as ShomareHesab, 
						ISNULL(SUM(cast (Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifAsliValue * Drd.tblCodhayeDaramadiElamAvarez.fldTedad  as bigint) ),
                          SUM(cast(Drd.tblCodhayeDaramadiElamAvarez.fldAsliValue * Drd.tblCodhayeDaramadiElamAvarez.fldTedad  as bigint))) AS MablaghKhales,
                         ISNULL(SUM( cast(Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifAvarezValue as bigint)),SUM( cast(Drd.tblCodhayeDaramadiElamAvarez.fldAvarezValue as bigint) )) AS Avarez,
						 ISNULL(SUM( cast(Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifMaliyatValue as bigint)),SUM(cast( Drd.tblCodhayeDaramadiElamAvarez.fldMaliyatValue as bigint))) AS Maliyat
                           ,ISNULL(SUM( cast(Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifAmuzeshParvareshValue as bigint)),SUM(cast( Drd.tblCodhayeDaramadiElamAvarez.fldAmuzeshParvareshValue as bigint))) AS fldAmuzeshParvareshValue
						  ,fldMablaghAvarezGerdShode as MablaghGhabelPardakht,N'' TarikhPardakht,N'' AS TarikhVariz,N'' AS fldTitle

FROM            Drd.tblSodoorFish inner JOIN
                         Drd.tblSodoorFish_Detail ON Drd.tblSodoorFish.fldId = Drd.tblSodoorFish_Detail.fldFishId INNER JOIN
                         Drd.tblCodhayeDaramadiElamAvarez ON Drd.tblSodoorFish_Detail.fldCodeElamAvarezId = Drd.tblCodhayeDaramadiElamAvarez.fldID INNER JOIN
                         Drd.tblShomareHesabCodeDaramad ON Drd.tblCodhayeDaramadiElamAvarez.fldShomareHesabCodeDaramadId = Drd.tblShomareHesabCodeDaramad.fldId INNER JOIN
                         Drd.tblCodhayeDaramd AS tblCodhayeDaramd_1 ON Drd.tblShomareHesabCodeDaramad.fldCodeDaramadId = tblCodhayeDaramd_1.fldId INNER JOIN
                         Com.tblShomareHesabeOmoomi ON Drd.tblSodoorFish.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                         Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId inner join 
						 drd.tblNaghdi_Talab on tblSodoorFish.fldId=tblNaghdi_Talab.fldFishId
						 WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId)
						 AND CAST( tblSodoorFish.fldDate AS DATE) BETWEEN @StartDate AND @EndDate
						and tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblPardakhtFish)			 
			AND Drd.tblElamAvarez.fldOrganId=@organid
		GROUP BY tblSodoorFish.fldId,fldAshakhasID,Drd.tblSodoorFish.fldTarikh,Com.tblShomareHesabeOmoomi.fldShomareHesab,fldMablaghAvarezGerdShode
union all

SELECT        tblSodoorFish.fldId as FishId,
                             (SELECT        CASE WHEN fldHaghighiId IS NOT NULL THEN
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
                                WHERE        (fldId = Drd.tblElamAvarez.fldAshakhasID)) AS Codemeli,
								tblSodoorFish.fldTarikh as TarikhSodoor ,Com.tblShomareHesabeOmoomi.fldShomareHesab as ShomareHesab, 
						fldMablaghAvarezGerdShode AS MablaghKhales,
                        0 AS Avarez,
						 0 AS Maliyat,0 as fldAmuzeshParvareshValue
						     ,fldMablaghAvarezGerdShode as MablaghGhabelPardakht,N'' TarikhPardakht,N'' AS TarikhVariz,N'' AS fldTitle

FROM            Drd.tblSodoorFish INNER JOIN
                         Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId INNER JOIN
                         Drd.tblCodhayeDaramadiElamAvarez ON Drd.tblElamAvarez.fldId = Drd.tblCodhayeDaramadiElamAvarez.fldElamAvarezId INNER JOIN
                         Drd.tblShomareHesabCodeDaramad ON Drd.tblCodhayeDaramadiElamAvarez.fldShomareHesabCodeDaramadId = Drd.tblShomareHesabCodeDaramad.fldId INNER JOIN
                         Com.tblShomareHesabeOmoomi ON Drd.tblSodoorFish.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId AND 
                         Drd.tblCodhayeDaramadiElamAvarez.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                         Drd.tblCodhayeDaramd AS tblCodhayeDaramd_1 ON tblCodhayeDaramd_1.fldId = Drd.tblShomareHesabCodeDaramad.fldCodeDaramadId  inner join 
						 drd.tblNaghdi_Talab on tblSodoorFish.fldId=tblNaghdi_Talab.fldFishId                     
						  WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId)
						 AND CAST( tblSodoorFish.fldDate AS DATE) BETWEEN @StartDate AND @EndDate
						 and tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblPardakhtFish)
						  and tblSodoorFish.fldId NOT IN (select tblSodoorFish_Detail.fldFishId from drd.tblSodoorFish_Detail where fldFishId=tblSodoorFish.fldId)
						AND Drd.tblElamAvarez.fldOrganId=@organid
							GROUP BY tblSodoorFish.fldId,fldAshakhasID,Drd.tblSodoorFish.fldTarikh,Com.tblShomareHesabeOmoomi.fldShomareHesab,fldMablaghAvarezGerdShode
			 
			 

 end

IF(@FieldName='EbtalShode')
BEGIN	
IF(@ShomareHesabId<>0) 
 SELECT        tblSodoorFish.fldId as FishId,
                             (SELECT        CASE WHEN fldHaghighiId IS NOT NULL THEN
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
                                WHERE        (fldId = Drd.tblElamAvarez.fldAshakhasID)) AS Codemeli,
								tblSodoorFish.fldTarikh as TarikhSodoor,Com.tblShomareHesabeOmoomi.fldShomareHesab as ShomareHesab, 
						ISNULL(SUM(cast (Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifAsliValue * Drd.tblCodhayeDaramadiElamAvarez.fldTedad  as bigint) ),
                          SUM(cast(Drd.tblCodhayeDaramadiElamAvarez.fldAsliValue * Drd.tblCodhayeDaramadiElamAvarez.fldTedad  as bigint))) AS MablaghKhales,
                         ISNULL(SUM( cast(Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifAvarezValue as bigint)),SUM( cast(Drd.tblCodhayeDaramadiElamAvarez.fldAvarezValue as bigint) )) AS Avarez,
						 ISNULL(SUM( cast(Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifMaliyatValue as bigint)),SUM(cast( Drd.tblCodhayeDaramadiElamAvarez.fldMaliyatValue as bigint))) AS Maliyat
                           ,ISNULL(SUM( cast(Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifAmuzeshParvareshValue as bigint)),SUM(cast( Drd.tblCodhayeDaramadiElamAvarez.fldAmuzeshParvareshValue as bigint))) AS fldAmuzeshParvareshValue
						  ,fldMablaghAvarezGerdShode as MablaghGhabelPardakht,N'' TarikhPardakht,dbo.Fn_AssembelyMiladiToShamsi(tblEbtal.fldDate) AS TarikhVariz,(SELECT    
                           Com.tblEmployee.fldName+' '+ Com.tblEmployee.fldFamily
FROM         Com.tblUser INNER JOIN
                      Com.tblEmployee ON Com.tblUser.fldEmployId = Com.tblEmployee.fldId
                      WHERE tblUser.fldId=tblEbtal.fldUserId) AS fldTitle

FROM            Drd.tblSodoorFish inner JOIN
                         Drd.tblSodoorFish_Detail ON Drd.tblSodoorFish.fldId = Drd.tblSodoorFish_Detail.fldFishId INNER JOIN
                         Drd.tblCodhayeDaramadiElamAvarez ON Drd.tblSodoorFish_Detail.fldCodeElamAvarezId = Drd.tblCodhayeDaramadiElamAvarez.fldID INNER JOIN
                         Drd.tblShomareHesabCodeDaramad ON Drd.tblCodhayeDaramadiElamAvarez.fldShomareHesabCodeDaramadId = Drd.tblShomareHesabCodeDaramad.fldId INNER JOIN
                         Drd.tblCodhayeDaramd AS tblCodhayeDaramd_1 ON Drd.tblShomareHesabCodeDaramad.fldCodeDaramadId = tblCodhayeDaramd_1.fldId INNER JOIN
                         Com.tblShomareHesabeOmoomi ON Drd.tblSodoorFish.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                         Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId INNER JOIN 
                         Drd.tblEbtal ON tblEbtal.fldFishId = tblSodoorFish.fldId
                         WHERE/* tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId)
						 AND*/ CAST( tblEbtal.fldDate AS DATE) BETWEEN @StartDate AND @EndDate
						--and tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblPardakhtFish)	
							AND Drd.tblElamAvarez.fldOrganId=@organid	 
		AND tblSodoorFish.fldShomareHesabId=@ShomareHesabId	
		GROUP BY tblSodoorFish.fldId,fldAshakhasID,Drd.tblSodoorFish.fldTarikh,Com.tblShomareHesabeOmoomi.fldShomareHesab,fldMablaghAvarezGerdShode
		,tblEbtal.fldUserId,Drd.tblEbtal.fldDate
union all

SELECT        tblSodoorFish.fldId as FishId,
                             (SELECT        CASE WHEN fldHaghighiId IS NOT NULL THEN
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
                                WHERE        (fldId = Drd.tblElamAvarez.fldAshakhasID)) AS Codemeli,
								tblSodoorFish.fldTarikh as TarikhSodoor ,Com.tblShomareHesabeOmoomi.fldShomareHesab as ShomareHesab, 
						fldMablaghAvarezGerdShode AS MablaghKhales,
                        0 AS Avarez,
						 0 AS Maliyat,0 as fldAmuzeshParvareshValue
						     ,fldMablaghAvarezGerdShode as MablaghGhabelPardakht,N'' TarikhPardakht,dbo.Fn_AssembelyMiladiToShamsi(tblEbtal.fldDate) AS TarikhVariz,(SELECT    
                           Com.tblEmployee.fldName+' '+ Com.tblEmployee.fldFamily
FROM         Com.tblUser INNER JOIN
                      Com.tblEmployee ON Com.tblUser.fldEmployId = Com.tblEmployee.fldId
                      WHERE tblUser.fldId=tblEbtal.fldUserId) AS fldTitle

FROM            Drd.tblSodoorFish INNER JOIN
                         Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId INNER JOIN
                         Drd.tblCodhayeDaramadiElamAvarez ON Drd.tblElamAvarez.fldId = Drd.tblCodhayeDaramadiElamAvarez.fldElamAvarezId INNER JOIN
                         Drd.tblShomareHesabCodeDaramad ON Drd.tblCodhayeDaramadiElamAvarez.fldShomareHesabCodeDaramadId = Drd.tblShomareHesabCodeDaramad.fldId INNER JOIN
                         Com.tblShomareHesabeOmoomi ON Drd.tblSodoorFish.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId AND 
                         Drd.tblCodhayeDaramadiElamAvarez.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                         Drd.tblCodhayeDaramd AS tblCodhayeDaramd_1 ON tblCodhayeDaramd_1.fldId = Drd.tblShomareHesabCodeDaramad.fldCodeDaramadId                       
						 INNER JOIN 
                         Drd.tblEbtal ON tblEbtal.fldFishId = tblSodoorFish.fldId
						  WHERE /*tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId)
						 AND */CAST( tblEbtal.fldDate AS DATE) BETWEEN @StartDate AND @EndDate
						-- and tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblPardakhtFish)
						AND tblSodoorFish.fldShomareHesabId=@ShomareHesabId	
						 and tblSodoorFish.fldId NOT IN (select tblSodoorFish_Detail.fldFishId from drd.tblSodoorFish_Detail where fldFishId=tblSodoorFish.fldId)
							AND Drd.tblElamAvarez.fldOrganId=@organid
							GROUP BY tblSodoorFish.fldId,fldAshakhasID,Drd.tblEbtal.fldDate,Drd.tblSodoorFish.fldTarikh,Com.tblShomareHesabeOmoomi.fldShomareHesab,fldMablaghAvarezGerdShode,tblEbtal.fldUserId
ELSE
SELECT        tblSodoorFish.fldId as FishId,
                             (SELECT        CASE WHEN fldHaghighiId IS NOT NULL THEN
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
                                WHERE        (fldId = Drd.tblElamAvarez.fldAshakhasID)) AS Codemeli,
								tblSodoorFish.fldTarikh as TarikhSodoor,Com.tblShomareHesabeOmoomi.fldShomareHesab as ShomareHesab, 
						ISNULL(SUM(cast (Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifAsliValue * Drd.tblCodhayeDaramadiElamAvarez.fldTedad  as bigint) ),
                          SUM(cast(Drd.tblCodhayeDaramadiElamAvarez.fldAsliValue * Drd.tblCodhayeDaramadiElamAvarez.fldTedad  as bigint))) AS MablaghKhales,
                         ISNULL(SUM( cast(Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifAvarezValue as bigint)),SUM( cast(Drd.tblCodhayeDaramadiElamAvarez.fldAvarezValue as bigint) )) AS Avarez,
						 ISNULL(SUM( cast(Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifMaliyatValue as bigint)),SUM(cast( Drd.tblCodhayeDaramadiElamAvarez.fldMaliyatValue as bigint))) AS Maliyat
                           ,ISNULL(SUM( cast(Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifAmuzeshParvareshValue as bigint)),SUM(cast( Drd.tblCodhayeDaramadiElamAvarez.fldAmuzeshParvareshValue as bigint))) AS fldAmuzeshParvareshValue
						  ,fldMablaghAvarezGerdShode as MablaghGhabelPardakht,N'' TarikhPardakht,dbo.Fn_AssembelyMiladiToShamsi(tblEbtal.fldDate) AS TarikhVariz,(SELECT    
                           Com.tblEmployee.fldName+' '+ Com.tblEmployee.fldFamily
FROM         Com.tblUser INNER JOIN
                      Com.tblEmployee ON Com.tblUser.fldEmployId = Com.tblEmployee.fldId
                      WHERE tblUser.fldId=tblEbtal.fldUserId) AS fldTitle

FROM            Drd.tblSodoorFish inner JOIN
                         Drd.tblSodoorFish_Detail ON Drd.tblSodoorFish.fldId = Drd.tblSodoorFish_Detail.fldFishId INNER JOIN
                         Drd.tblCodhayeDaramadiElamAvarez ON Drd.tblSodoorFish_Detail.fldCodeElamAvarezId = Drd.tblCodhayeDaramadiElamAvarez.fldID INNER JOIN
                         Drd.tblShomareHesabCodeDaramad ON Drd.tblCodhayeDaramadiElamAvarez.fldShomareHesabCodeDaramadId = Drd.tblShomareHesabCodeDaramad.fldId INNER JOIN
                         Drd.tblCodhayeDaramd AS tblCodhayeDaramd_1 ON Drd.tblShomareHesabCodeDaramad.fldCodeDaramadId = tblCodhayeDaramd_1.fldId INNER JOIN
                         Com.tblShomareHesabeOmoomi ON Drd.tblSodoorFish.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                         Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId INNER JOIN 
                         Drd.tblEbtal ON tblEbtal.fldFishId = tblSodoorFish.fldId
                          WHERE /*tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId)
						 AND*/ CAST(  Drd.tblEbtal.fldDate AS DATE) BETWEEN @StartDate AND @EndDate
						--and tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblPardakhtFish)			 
			AND Drd.tblElamAvarez.fldOrganId=@organid
		GROUP BY tblSodoorFish.fldId,Drd.tblEbtal.fldDate,fldAshakhasID,Drd.tblSodoorFish.fldTarikh,tblEbtal.fldUserId,Com.tblShomareHesabeOmoomi.fldShomareHesab,fldMablaghAvarezGerdShode
union all

SELECT        tblSodoorFish.fldId as FishId,
                             (SELECT        CASE WHEN fldHaghighiId IS NOT NULL THEN
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
                                WHERE        (fldId = Drd.tblElamAvarez.fldAshakhasID)) AS Codemeli,
								tblSodoorFish.fldTarikh as TarikhSodoor ,Com.tblShomareHesabeOmoomi.fldShomareHesab as ShomareHesab, 
						fldMablaghAvarezGerdShode AS MablaghKhales,
                        0 AS Avarez,
						 0 AS Maliyat,0 as fldAmuzeshParvareshValue 
						     ,fldMablaghAvarezGerdShode as MablaghGhabelPardakht,N'' TarikhPardakht,dbo.Fn_AssembelyMiladiToShamsi(tblEbtal.fldDate) AS TarikhVariz,(SELECT    
                           Com.tblEmployee.fldName+' '+ Com.tblEmployee.fldFamily
FROM         Com.tblUser INNER JOIN
                      Com.tblEmployee ON Com.tblUser.fldEmployId = Com.tblEmployee.fldId
                      WHERE tblUser.fldId=tblEbtal.fldUserId) AS fldTitle

FROM            Drd.tblSodoorFish INNER JOIN
                         Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId INNER JOIN
                         Drd.tblCodhayeDaramadiElamAvarez ON Drd.tblElamAvarez.fldId = Drd.tblCodhayeDaramadiElamAvarez.fldElamAvarezId INNER JOIN
                         Drd.tblShomareHesabCodeDaramad ON Drd.tblCodhayeDaramadiElamAvarez.fldShomareHesabCodeDaramadId = Drd.tblShomareHesabCodeDaramad.fldId INNER JOIN
                         Com.tblShomareHesabeOmoomi ON Drd.tblSodoorFish.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId AND 
                         Drd.tblCodhayeDaramadiElamAvarez.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                         Drd.tblCodhayeDaramd AS tblCodhayeDaramd_1 ON tblCodhayeDaramd_1.fldId = Drd.tblShomareHesabCodeDaramad.fldCodeDaramadId                       
						 INNER JOIN 
                         Drd.tblEbtal ON tblEbtal.fldFishId = tblSodoorFish.fldId 
						  WHERE /*tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId)
						 AND*/ CAST( tblEbtal.fldDate AS DATE) BETWEEN @StartDate AND @EndDate
						 --and tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblPardakhtFish)
						  and tblSodoorFish.fldId NOT IN (select tblSodoorFish_Detail.fldFishId from drd.tblSodoorFish_Detail where fldFishId=tblSodoorFish.fldId)
						AND Drd.tblElamAvarez.fldOrganId=@organid
							GROUP BY tblSodoorFish.fldId,fldAshakhasID,Drd.tblEbtal.fldDate,Drd.tblSodoorFish.fldTarikh,tblEbtal.fldUserId,Com.tblShomareHesabeOmoomi.fldShomareHesab,fldMablaghAvarezGerdShode
			 
			 

 end
 IF(@FieldName='EbtalShode_Naghdi')
BEGIN	
IF(@ShomareHesabId<>0) 
 SELECT        tblSodoorFish.fldId as FishId,
                             (SELECT        CASE WHEN fldHaghighiId IS NOT NULL THEN
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
                                WHERE        (fldId = Drd.tblElamAvarez.fldAshakhasID)) AS Codemeli,
								tblSodoorFish.fldTarikh as TarikhSodoor,Com.tblShomareHesabeOmoomi.fldShomareHesab as ShomareHesab, 
						ISNULL(SUM(cast (Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifAsliValue * Drd.tblCodhayeDaramadiElamAvarez.fldTedad  as bigint) ),
                          SUM(cast(Drd.tblCodhayeDaramadiElamAvarez.fldAsliValue * Drd.tblCodhayeDaramadiElamAvarez.fldTedad  as bigint))) AS MablaghKhales,
                         ISNULL(SUM( cast(Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifAvarezValue as bigint)),SUM( cast(Drd.tblCodhayeDaramadiElamAvarez.fldAvarezValue as bigint) )) AS Avarez,
						 ISNULL(SUM( cast(Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifMaliyatValue as bigint)),SUM(cast( Drd.tblCodhayeDaramadiElamAvarez.fldMaliyatValue as bigint))) AS Maliyat
                          ,ISNULL(SUM( cast(Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifAmuzeshParvareshValue as bigint)),SUM(cast( Drd.tblCodhayeDaramadiElamAvarez.fldAmuzeshParvareshValue as bigint))) AS fldAmuzeshParvareshValue
						 ,fldMablaghAvarezGerdShode as MablaghGhabelPardakht,N'' TarikhPardakht,dbo.Fn_AssembelyMiladiToShamsi(tblEbtal.fldDate) AS TarikhVariz,(SELECT    
                           Com.tblEmployee.fldName+' '+ Com.tblEmployee.fldFamily
FROM         Com.tblUser INNER JOIN
                      Com.tblEmployee ON Com.tblUser.fldEmployId = Com.tblEmployee.fldId
                      WHERE tblUser.fldId=tblEbtal.fldUserId) AS fldTitle

FROM            Drd.tblSodoorFish inner JOIN
                         Drd.tblSodoorFish_Detail ON Drd.tblSodoorFish.fldId = Drd.tblSodoorFish_Detail.fldFishId INNER JOIN
                         Drd.tblCodhayeDaramadiElamAvarez ON Drd.tblSodoorFish_Detail.fldCodeElamAvarezId = Drd.tblCodhayeDaramadiElamAvarez.fldID INNER JOIN
                         Drd.tblShomareHesabCodeDaramad ON Drd.tblCodhayeDaramadiElamAvarez.fldShomareHesabCodeDaramadId = Drd.tblShomareHesabCodeDaramad.fldId INNER JOIN
                         Drd.tblCodhayeDaramd AS tblCodhayeDaramd_1 ON Drd.tblShomareHesabCodeDaramad.fldCodeDaramadId = tblCodhayeDaramd_1.fldId INNER JOIN
                         Com.tblShomareHesabeOmoomi ON Drd.tblSodoorFish.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                         Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId INNER JOIN 
                         Drd.tblEbtal ON tblEbtal.fldFishId = tblSodoorFish.fldId inner join 
						 drd.tblNaghdi_Talab on tblSodoorFish.fldId=tblNaghdi_Talab.fldFishId
                         WHERE/* tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId)
						 AND*/ CAST( tblEbtal.fldDate AS DATE) BETWEEN @StartDate AND @EndDate
						--and tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblPardakhtFish)	
							AND Drd.tblElamAvarez.fldOrganId=@organid	 
		AND tblSodoorFish.fldShomareHesabId=@ShomareHesabId	
		GROUP BY tblSodoorFish.fldId,fldAshakhasID,Drd.tblSodoorFish.fldTarikh,Com.tblShomareHesabeOmoomi.fldShomareHesab,fldMablaghAvarezGerdShode
		,tblEbtal.fldUserId,Drd.tblEbtal.fldDate
union all

SELECT        tblSodoorFish.fldId as FishId,
                             (SELECT        CASE WHEN fldHaghighiId IS NOT NULL THEN
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
                                WHERE        (fldId = Drd.tblElamAvarez.fldAshakhasID)) AS Codemeli,
								tblSodoorFish.fldTarikh as TarikhSodoor ,Com.tblShomareHesabeOmoomi.fldShomareHesab as ShomareHesab, 
						fldMablaghAvarezGerdShode AS MablaghKhales,
                        0 AS Avarez,
						 0 AS Maliyat,0 as  fldAmuzeshParvareshValue
						     ,fldMablaghAvarezGerdShode as MablaghGhabelPardakht,N'' TarikhPardakht,dbo.Fn_AssembelyMiladiToShamsi(tblEbtal.fldDate) AS TarikhVariz,(SELECT    
                           Com.tblEmployee.fldName+' '+ Com.tblEmployee.fldFamily
FROM         Com.tblUser INNER JOIN
                      Com.tblEmployee ON Com.tblUser.fldEmployId = Com.tblEmployee.fldId
                      WHERE tblUser.fldId=tblEbtal.fldUserId) AS fldTitle

FROM            Drd.tblSodoorFish INNER JOIN
                         Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId INNER JOIN
                         Drd.tblCodhayeDaramadiElamAvarez ON Drd.tblElamAvarez.fldId = Drd.tblCodhayeDaramadiElamAvarez.fldElamAvarezId INNER JOIN
                         Drd.tblShomareHesabCodeDaramad ON Drd.tblCodhayeDaramadiElamAvarez.fldShomareHesabCodeDaramadId = Drd.tblShomareHesabCodeDaramad.fldId INNER JOIN
                         Com.tblShomareHesabeOmoomi ON Drd.tblSodoorFish.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId AND 
                         Drd.tblCodhayeDaramadiElamAvarez.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                         Drd.tblCodhayeDaramd AS tblCodhayeDaramd_1 ON tblCodhayeDaramd_1.fldId = Drd.tblShomareHesabCodeDaramad.fldCodeDaramadId                       
						 INNER JOIN 
                         Drd.tblEbtal ON tblEbtal.fldFishId = tblSodoorFish.fldId inner join 
						 drd.tblNaghdi_Talab on tblSodoorFish.fldId=tblNaghdi_Talab.fldFishId
						  WHERE /*tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId)
						 AND */CAST( tblEbtal.fldDate AS DATE) BETWEEN @StartDate AND @EndDate
						-- and tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblPardakhtFish)
						AND tblSodoorFish.fldShomareHesabId=@ShomareHesabId	
						 and tblSodoorFish.fldId NOT IN (select tblSodoorFish_Detail.fldFishId from drd.tblSodoorFish_Detail where fldFishId=tblSodoorFish.fldId)
							AND Drd.tblElamAvarez.fldOrganId=@organid
							GROUP BY tblSodoorFish.fldId,fldAshakhasID,Drd.tblEbtal.fldDate,Drd.tblSodoorFish.fldTarikh,Com.tblShomareHesabeOmoomi.fldShomareHesab,fldMablaghAvarezGerdShode,tblEbtal.fldUserId
ELSE
SELECT        tblSodoorFish.fldId as FishId,
                             (SELECT        CASE WHEN fldHaghighiId IS NOT NULL THEN
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
                                WHERE        (fldId = Drd.tblElamAvarez.fldAshakhasID)) AS Codemeli,
								tblSodoorFish.fldTarikh as TarikhSodoor,Com.tblShomareHesabeOmoomi.fldShomareHesab as ShomareHesab, 
						ISNULL(SUM(cast (Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifAsliValue * Drd.tblCodhayeDaramadiElamAvarez.fldTedad  as bigint) ),
                          SUM(cast(Drd.tblCodhayeDaramadiElamAvarez.fldAsliValue * Drd.tblCodhayeDaramadiElamAvarez.fldTedad  as bigint))) AS MablaghKhales,
                         ISNULL(SUM( cast(Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifAvarezValue as bigint)),SUM( cast(Drd.tblCodhayeDaramadiElamAvarez.fldAvarezValue as bigint) )) AS Avarez,
						 ISNULL(SUM( cast(Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifMaliyatValue as bigint)),SUM(cast( Drd.tblCodhayeDaramadiElamAvarez.fldMaliyatValue as bigint))) AS Maliyat
                          ,ISNULL(SUM( cast(Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifAmuzeshParvareshValue as bigint)),SUM(cast( Drd.tblCodhayeDaramadiElamAvarez.fldAmuzeshParvareshValue as bigint))) AS fldAmuzeshParvareshValue
						  ,fldMablaghAvarezGerdShode as MablaghGhabelPardakht,N'' TarikhPardakht,dbo.Fn_AssembelyMiladiToShamsi(tblEbtal.fldDate) AS TarikhVariz,(SELECT    
                           Com.tblEmployee.fldName+' '+ Com.tblEmployee.fldFamily
FROM         Com.tblUser INNER JOIN
                      Com.tblEmployee ON Com.tblUser.fldEmployId = Com.tblEmployee.fldId
                      WHERE tblUser.fldId=tblEbtal.fldUserId) AS fldTitle

FROM            Drd.tblSodoorFish inner JOIN
                         Drd.tblSodoorFish_Detail ON Drd.tblSodoorFish.fldId = Drd.tblSodoorFish_Detail.fldFishId INNER JOIN
                         Drd.tblCodhayeDaramadiElamAvarez ON Drd.tblSodoorFish_Detail.fldCodeElamAvarezId = Drd.tblCodhayeDaramadiElamAvarez.fldID INNER JOIN
                         Drd.tblShomareHesabCodeDaramad ON Drd.tblCodhayeDaramadiElamAvarez.fldShomareHesabCodeDaramadId = Drd.tblShomareHesabCodeDaramad.fldId INNER JOIN
                         Drd.tblCodhayeDaramd AS tblCodhayeDaramd_1 ON Drd.tblShomareHesabCodeDaramad.fldCodeDaramadId = tblCodhayeDaramd_1.fldId INNER JOIN
                         Com.tblShomareHesabeOmoomi ON Drd.tblSodoorFish.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                         Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId INNER JOIN 
                         Drd.tblEbtal ON tblEbtal.fldFishId = tblSodoorFish.fldId inner join 
						 drd.tblNaghdi_Talab on tblSodoorFish.fldId=tblNaghdi_Talab.fldFishId
                          WHERE /*tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId)
						 AND*/ CAST(  Drd.tblEbtal.fldDate AS DATE) BETWEEN @StartDate AND @EndDate
						--and tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblPardakhtFish)			 
			AND Drd.tblElamAvarez.fldOrganId=@organid
		GROUP BY tblSodoorFish.fldId,Drd.tblEbtal.fldDate,fldAshakhasID,Drd.tblSodoorFish.fldTarikh,tblEbtal.fldUserId,Com.tblShomareHesabeOmoomi.fldShomareHesab,fldMablaghAvarezGerdShode
union all

SELECT        tblSodoorFish.fldId as FishId,
                             (SELECT        CASE WHEN fldHaghighiId IS NOT NULL THEN
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
                                WHERE        (fldId = Drd.tblElamAvarez.fldAshakhasID)) AS Codemeli,
								tblSodoorFish.fldTarikh as TarikhSodoor ,Com.tblShomareHesabeOmoomi.fldShomareHesab as ShomareHesab, 
						fldMablaghAvarezGerdShode AS MablaghKhales,
                        0 AS Avarez,
						 0 AS Maliyat,0 as fldAmuzeshParvareshValue
						     ,fldMablaghAvarezGerdShode as MablaghGhabelPardakht,N'' TarikhPardakht,dbo.Fn_AssembelyMiladiToShamsi(tblEbtal.fldDate) AS TarikhVariz,(SELECT    
                           Com.tblEmployee.fldName+' '+ Com.tblEmployee.fldFamily
FROM         Com.tblUser INNER JOIN
                      Com.tblEmployee ON Com.tblUser.fldEmployId = Com.tblEmployee.fldId
                      WHERE tblUser.fldId=tblEbtal.fldUserId) AS fldTitle

FROM            Drd.tblSodoorFish INNER JOIN
                         Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId INNER JOIN
                         Drd.tblCodhayeDaramadiElamAvarez ON Drd.tblElamAvarez.fldId = Drd.tblCodhayeDaramadiElamAvarez.fldElamAvarezId INNER JOIN
                         Drd.tblShomareHesabCodeDaramad ON Drd.tblCodhayeDaramadiElamAvarez.fldShomareHesabCodeDaramadId = Drd.tblShomareHesabCodeDaramad.fldId INNER JOIN
                         Com.tblShomareHesabeOmoomi ON Drd.tblSodoorFish.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId AND 
                         Drd.tblCodhayeDaramadiElamAvarez.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                         Drd.tblCodhayeDaramd AS tblCodhayeDaramd_1 ON tblCodhayeDaramd_1.fldId = Drd.tblShomareHesabCodeDaramad.fldCodeDaramadId                       
						 INNER JOIN 
                         Drd.tblEbtal ON tblEbtal.fldFishId = tblSodoorFish.fldId  inner join 
						 drd.tblNaghdi_Talab on tblSodoorFish.fldId=tblNaghdi_Talab.fldFishId
						  WHERE /*tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId)
						 AND*/ CAST( tblEbtal.fldDate AS DATE) BETWEEN @StartDate AND @EndDate
						 --and tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblPardakhtFish)
						  and tblSodoorFish.fldId NOT IN (select tblSodoorFish_Detail.fldFishId from drd.tblSodoorFish_Detail where fldFishId=tblSodoorFish.fldId)
						AND Drd.tblElamAvarez.fldOrganId=@organid
							GROUP BY tblSodoorFish.fldId,fldAshakhasID,Drd.tblEbtal.fldDate,Drd.tblSodoorFish.fldTarikh,tblEbtal.fldUserId,Com.tblShomareHesabeOmoomi.fldShomareHesab,fldMablaghAvarezGerdShode
			 
			 

 end
GO
