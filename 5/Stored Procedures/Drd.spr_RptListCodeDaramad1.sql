SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_RptListCodeDaramad1](@AzTarikh NVARCHAR(10),@TaTarikh NVARCHAR(10),@ShomareHesabId INT,@CodeDaramadId INT,@OrganId INT)
AS
--DECLARE @AzTarikh NVARCHAR(10)='1397/07/10',@TaTarikh NVARCHAR(10)='1397/07/10',@ShomareHesabId INT=0,@CodeDaramadId INT=0,@OrganId INT=1
DECLARE @temp TABLE(Daramadcode NVARCHAR(50),sharhecode NVARCHAR(300),shomareHesab NVARCHAR(50),mablaghcodeDaramad BIGINT,fldtype NVARCHAR(1),hid HIERARCHYID)
DECLARE @temp_Hid TABLE(Daramadcode NVARCHAR(50),sharhecode NVARCHAR(300),shomareHesab NVARCHAR(50),mablaghcodeDaramad BIGINT,hid HIERARCHYID)
DECLARE @StartDate DATE=com.ShamsiToMiladi(@Aztarikh)
DECLARE @EndDate DATE=com.ShamsiToMiladi(@TaTarikh)

INSERT INTO @temp
        ( Daramadcode ,sharhecode , shomareHesab , mablaghcodeDaramad,fldtype,hid  )

SELECT        tblCodhayeDaramd_1.fldDaramadCode, Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad, Com.tblShomareHesabeOmoomi.fldShomareHesab, 
                       ISNULL(cast((Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifAsliValue * Drd.tblCodhayeDaramadiElamAvarez.fldTedad + Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifAvarezValue + Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifMaliyatValue)as bigint),
                          cast((Drd.tblCodhayeDaramadiElamAvarez.fldAsliValue * Drd.tblCodhayeDaramadiElamAvarez.fldTedad + Drd.tblCodhayeDaramadiElamAvarez.fldAvarezValue + Drd.tblCodhayeDaramadiElamAvarez.fldMaliyatValue)as bigint))
    AS fldmablaghCodeDaramad, '0' AS Expr1, tblCodhayeDaramd_1.fldDaramadId
FROM            Drd.tblSodoorFish INNER JOIN
                         Drd.tblSodoorFish_Detail ON Drd.tblSodoorFish.fldId = Drd.tblSodoorFish_Detail.fldFishId INNER JOIN
                         Drd.tblCodhayeDaramadiElamAvarez ON Drd.tblSodoorFish_Detail.fldCodeElamAvarezId = Drd.tblCodhayeDaramadiElamAvarez.fldID INNER JOIN
                         Drd.tblShomareHesabCodeDaramad ON Drd.tblCodhayeDaramadiElamAvarez.fldShomareHesabCodeDaramadId = Drd.tblShomareHesabCodeDaramad.fldId AND 
                         Drd.tblCodhayeDaramadiElamAvarez.fldShomareHesabCodeDaramadId = Drd.tblShomareHesabCodeDaramad.fldId INNER JOIN
                         Drd.tblCodhayeDaramd AS tblCodhayeDaramd_1 ON Drd.tblShomareHesabCodeDaramad.fldCodeDaramadId = tblCodhayeDaramd_1.fldId INNER JOIN
                         Drd.tblPardakhtFish ON Drd.tblSodoorFish.fldId = Drd.tblPardakhtFish.fldFishId AND Drd.tblSodoorFish.fldId = Drd.tblPardakhtFish.fldFishId INNER JOIN
                         Com.tblShomareHesabeOmoomi ON Drd.tblShomareHesabCodeDaramad.fldShomareHesadId = Com.tblShomareHesabeOmoomi.fldId
 WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId)
						 AND CAST( tblPardakhtFish.fldDatePardakht AS DATE) BETWEEN @StartDate AND @EndDate
						 
		--GROUP BY tblCodhayeDaramd_1.fldDaramadCode, Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad,fldShomareHesab,fldDaramadId

		
union all
SELECT fldDaramadCode,fldSharheCodeDaramad,fldShomareHesab, (CAST((CAST(fldMablaghNaghdi AS BIGINT)*CAST(fldmablaghCodeDaramad AS bigint))AS BIGINT)/CAST(fldmablaghKoli AS bigint)),'1'
,fldDaramadId
 FROM 
(SELECT   DISTINCT    Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId, tblCodhayeDaramd_1.fldDaramadCode, 
                         Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad
						-- ,SUM(fldMablagh) OVER (PARTITION BY fldReplyTaghsitId,tblNaghdi_Talab.fldShomareHesabId) AS fldMablaghNaghdi
						,Drd.fn_SumMablaghNaghdi('Naghdi_Talab',fldReplyTaghsitId,tblNaghdi_Talab.fldShomareHesabId,'','') AS fldMablaghNaghdi
						,fldShomareHesab ,fldReplyTaghsitId
	,ISNULL(SUM(fldTakhfifAsliValue*fldTedad+fldTakhfifAvarezValue+fldTakhfifMaliyatValue),SUM(fldAsliValue*fldTedad+fldAvarezValue+fldMaliyatValue)) AS fldmablaghCodeDaramad
	,(SELECT TOP(1) ISNULL(SUM(fldTakhfifAsliValue*fldTedad+fldTakhfifAvarezValue+fldTakhfifMaliyatValue) OVER (PARTITION BY tblCodhayeDaramadiElamAvarez.fldElamAvarezId),SUM(fldAsliValue*fldTedad+fldAvarezValue+fldMaliyatValue) OVER (PARTITION BY tblCodhayeDaramadiElamAvarez.fldElamAvarezId)) FROM Drd.tblCodhayeDaramadiElamAvarez AS a WHERE a.fldElamAvarezId =Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId) AS fldmablaghKoli
,tblCodhayeDaramd_1.fldDaramadId
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
						AND CAST(tblPardakhtFish.fldDatePardakht AS  DATE) BETWEEN @StartDate AND @EndDate
						
						 GROUP BY tblRequestTaghsit_Takhfif.fldElamAvarezId,tblCodhayeDaramd_1.fldDaramadCode, 
                         Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad,fldMablagh,fldReplyTaghsitId, tblCodhayeDaramadiElamAvarez.fldElamAvarezId
						 ,tblNaghdi_Talab.fldShomareHesabId,fldShomareHesab,fldDaramadId
						
						 )t


--SELECT        tblCodhayeDaramd_1.fldDaramadCode, Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad, Com.tblShomareHesabeOmoomi.fldShomareHesab, 
--                      ISNULL(SUM(fldMablaghAvarezGerdShode),0)
--                          AS fldmablaghCodeDaramad, '0' AS Expr1, tblCodhayeDaramd_1.fldDaramadId
--FROM            Drd.tblSodoorFish INNER JOIN
--                         Drd.tblElamAvarez ON Drd.tblSodoorFish.fldElamAvarezId = Drd.tblElamAvarez.fldId INNER JOIN
--                         Drd.tblCodhayeDaramadiElamAvarez ON Drd.tblElamAvarez.fldId = Drd.tblCodhayeDaramadiElamAvarez.fldElamAvarezId INNER JOIN
--                         Drd.tblShomareHesabCodeDaramad ON Drd.tblCodhayeDaramadiElamAvarez.fldShomareHesabCodeDaramadId = Drd.tblShomareHesabCodeDaramad.fldId INNER JOIN
--                         Drd.tblCodhayeDaramd AS tblCodhayeDaramd_1 ON Drd.tblShomareHesabCodeDaramad.fldCodeDaramadId = tblCodhayeDaramd_1.fldId INNER JOIN
--                         Com.tblShomareHesabeOmoomi ON Drd.tblSodoorFish.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
--                         Drd.tblPardakhtFish ON Drd.tblSodoorFish.fldId = Drd.tblPardakhtFish.fldFishId		
-- WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId)
--						 AND CAST( tblPardakhtFish.fldDatePardakht AS DATE) BETWEEN @StartDate AND @EndDate
--						 and Drd.tblSodoorFish.fldID not in (select fldFishId from drd.tblSodoorFish_Detail WHERE fldFishId=tblSodoorFish.fldId)
						 
--		GROUP BY tblCodhayeDaramd_1.fldDaramadCode, Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad,fldShomareHesab,fldDaramadId


------------------------------------------------------- وصول شده

INSERT INTO @temp
 
SELECT  fldDaramadCode,fldSharheCodeDaramad,fldShomareHesab, (CAST((CAST(fldMablagh AS BIGINT)*CAST(fldmablaghCodeDaramad AS bigint))AS BIGINT)/CAST(fldmablaghKoli AS BIGINT)),'2',fldDaramadId FROM 
(SELECT   DISTINCT    Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId, tblCodhayeDaramd_1.fldDaramadCode, 
                         Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad
						-- ,SUM(fldMablagh) OVER (PARTITION BY fldReplyTaghsitId,tblNaghdi_Talab.fldShomareHesabId) AS fldMablaghNaghdi
						,Drd.fn_SumMablaghNaghdi('Check',fldReplyTaghsitId,tblCheck.fldShomareHesabIdOrgan,@azTarikh ,@Tatarikh) AS fldMablagh
						,fldShomareHesab ,fldReplyTaghsitId
	,ISNULL(SUM(fldTakhfifAsliValue*fldTedad+fldTakhfifAvarezValue+fldTakhfifMaliyatValue),SUM(fldAsliValue*fldTedad+fldAvarezValue+fldMaliyatValue)) AS fldmablaghCodeDaramad
	,(SELECT TOP(1) ISNULL(SUM(fldTakhfifAsliValue*fldTedad+fldTakhfifAvarezValue+fldTakhfifMaliyatValue) OVER (PARTITION BY tblCodhayeDaramadiElamAvarez.fldElamAvarezId),SUM(fldAsliValue*fldTedad+fldAvarezValue+fldMaliyatValue) OVER (PARTITION BY tblCodhayeDaramadiElamAvarez.fldElamAvarezId)) FROM Drd.tblCodhayeDaramadiElamAvarez AS a WHERE a.fldElamAvarezId =Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId) AS fldmablaghKoli
,tblCodhayeDaramd_1.fldDaramadId
FROM            Drd.tblRequestTaghsit_Takhfif INNER JOIN
                         Drd.tblStatusTaghsit_Takhfif ON Drd.tblRequestTaghsit_Takhfif.fldId = Drd.tblStatusTaghsit_Takhfif.fldRequestId INNER JOIN
                         Drd.tblReplyTaghsit ON Drd.tblStatusTaghsit_Takhfif.fldId = Drd.tblReplyTaghsit.fldStatusId INNER JOIN
                         Drd.tblElamAvarez ON Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId = Drd.tblElamAvarez.fldId INNER JOIN
                         Drd.tblCodhayeDaramadiElamAvarez ON Drd.tblElamAvarez.fldId = Drd.tblCodhayeDaramadiElamAvarez.fldElamAvarezId INNER JOIN
                         Drd.tblShomareHesabCodeDaramad ON Drd.tblCodhayeDaramadiElamAvarez.fldShomareHesabCodeDaramadId = Drd.tblShomareHesabCodeDaramad.fldId INNER JOIN
                         Drd.tblCodhayeDaramd AS tblCodhayeDaramd_1 ON Drd.tblShomareHesabCodeDaramad.fldCodeDaramadId = tblCodhayeDaramd_1.fldId INNER JOIN
                         Drd.tblCheck ON Drd.tblReplyTaghsit.fldId = Drd.tblCheck.fldReplyTaghsitId INNER JOIN
						 com.tblShomareHesabeOmoomi ON tblShomareHesabeOmoomi.fldId = tblCheck.fldShomareHesabIdOrgan

						 WHERE fldRequestId NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=fldRequestId)
						AND tblCheck.fldStatus=2 AND fldTypeSanad=0
						AND (Drd.tblCheck.fldDateStatus ) BETWEEN @AzTarikh AND @TaTarikh
						 GROUP BY tblRequestTaghsit_Takhfif.fldElamAvarezId,tblCodhayeDaramd_1.fldDaramadCode, 
                         Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad,fldMablaghSanad,fldReplyTaghsitId, tblCodhayeDaramadiElamAvarez.fldElamAvarezId
						 ,tblCheck.fldShomareHesabIdOrgan,fldShomareHesab,fldDaramadId
						 )t


INSERT INTO @temp
       
						 SELECT  fldDaramadCode,fldSharheCodeDaramad,fldShomareHesab, (CAST((CAST(fldMablagh AS BIGINT)*CAST(fldmablaghCodeDaramad AS bigint))AS BIGINT)/CAST(fldmablaghKoli AS BIGINT)),'3',fldDaramadId FROM 
(SELECT   DISTINCT    Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId, tblCodhayeDaramd_1.fldDaramadCode, 
                         Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad
						-- ,SUM(fldMablagh) OVER (PARTITION BY fldReplyTaghsitId,tblNaghdi_Talab.fldShomareHesabId) AS fldMablaghNaghdi
						,Drd.fn_SumMablaghNaghdi('Safte',fldReplyTaghsitId,tblShomareHesabCodeDaramad.fldShomareHesadId,@AzTarikh , @Tatarikh) AS fldMablagh
						,fldShomareHesab ,fldReplyTaghsitId
	,ISNULL(SUM(fldTakhfifAsliValue*fldTedad+fldTakhfifAvarezValue+fldTakhfifMaliyatValue),SUM(fldAsliValue*fldTedad+fldAvarezValue+fldMaliyatValue)) AS fldmablaghCodeDaramad
	,(SELECT TOP(1) ISNULL(SUM(fldTakhfifAsliValue*fldTedad+fldTakhfifAvarezValue+fldTakhfifMaliyatValue) OVER (PARTITION BY tblCodhayeDaramadiElamAvarez.fldElamAvarezId),SUM(fldAsliValue*fldTedad+fldAvarezValue+fldMaliyatValue) OVER (PARTITION BY tblCodhayeDaramadiElamAvarez.fldElamAvarezId)) FROM Drd.tblCodhayeDaramadiElamAvarez AS a WHERE a.fldElamAvarezId =Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId) AS fldmablaghKoli
,tblCodhayeDaramd_1.fldDaramadId
FROM            Drd.tblRequestTaghsit_Takhfif INNER JOIN
                         Drd.tblStatusTaghsit_Takhfif ON Drd.tblRequestTaghsit_Takhfif.fldId = Drd.tblStatusTaghsit_Takhfif.fldRequestId INNER JOIN
                         Drd.tblReplyTaghsit ON Drd.tblStatusTaghsit_Takhfif.fldId = Drd.tblReplyTaghsit.fldStatusId INNER JOIN
                         Drd.tblElamAvarez ON Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId = Drd.tblElamAvarez.fldId INNER JOIN
                         Drd.tblCodhayeDaramadiElamAvarez ON Drd.tblElamAvarez.fldId = Drd.tblCodhayeDaramadiElamAvarez.fldElamAvarezId INNER JOIN
                         Drd.tblShomareHesabCodeDaramad ON Drd.tblCodhayeDaramadiElamAvarez.fldShomareHesabCodeDaramadId = Drd.tblShomareHesabCodeDaramad.fldId INNER JOIN
                         Drd.tblCodhayeDaramd AS tblCodhayeDaramd_1 ON Drd.tblShomareHesabCodeDaramad.fldCodeDaramadId = tblCodhayeDaramd_1.fldId INNER JOIN
                         Drd.tblSafte ON Drd.tblReplyTaghsit.fldId = Drd.tblSafte.fldReplyTaghsitId INNER JOIN
						 com.tblShomareHesabeOmoomi ON tblShomareHesabeOmoomi.fldId = tblShomareHesabCodeDaramad.fldShomareHesadId

						 WHERE fldRequestId NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=fldRequestId)
						AND tblSafte.fldStatus=2 
						AND (Drd.tblSafte.fldDateStatus ) BETWEEN @AzTarikh AND @TaTarikh
						--AND CAST(Drd.tblSafte.fldDate AS  DATE) BETWEEN @StartDate AND @EndDate
						 GROUP BY tblRequestTaghsit_Takhfif.fldElamAvarezId,tblCodhayeDaramd_1.fldDaramadCode, 
                         Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad,fldMablaghSanad,fldReplyTaghsitId, tblCodhayeDaramadiElamAvarez.fldElamAvarezId
						 ,tblShomareHesabCodeDaramad.fldShomareHesadId,fldShomareHesab,fldDaramadId
						 )t

INSERT INTO @temp
SELECT  fldDaramadCode,fldSharheCodeDaramad,fldShomareHesab, (CAST((CAST(fldMablagh AS BIGINT)*CAST(fldmablaghCodeDaramad AS bigint))AS BIGINT)/CAST(fldmablaghKoli AS BIGINT)),'4',fldDaramadId FROM 
(SELECT   DISTINCT    Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId, tblCodhayeDaramd_1.fldDaramadCode, 
                         Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad
						-- ,SUM(fldMablagh) OVER (PARTITION BY fldReplyTaghsitId,tblNaghdi_Talab.fldShomareHesabId) AS fldMablaghNaghdi
						,Drd.fn_SumMablaghNaghdi('Barat',fldReplyTaghsitId,tblShomareHesabCodeDaramad.fldShomareHesadId,@AzTarikh,@TaTarikh) AS fldMablagh
						,fldShomareHesab ,fldReplyTaghsitId
	,ISNULL(SUM(fldTakhfifAsliValue*fldTedad+fldTakhfifAvarezValue+fldTakhfifMaliyatValue),SUM(fldAsliValue*fldTedad+fldAvarezValue+fldMaliyatValue)) AS fldmablaghCodeDaramad
	,(SELECT TOP(1) ISNULL(SUM(fldTakhfifAsliValue*fldTedad+fldTakhfifAvarezValue+fldTakhfifMaliyatValue) OVER (PARTITION BY tblCodhayeDaramadiElamAvarez.fldElamAvarezId),SUM(fldAsliValue*fldTedad+fldAvarezValue+fldMaliyatValue) OVER (PARTITION BY tblCodhayeDaramadiElamAvarez.fldElamAvarezId)) FROM Drd.tblCodhayeDaramadiElamAvarez AS a WHERE a.fldElamAvarezId =Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId) AS fldmablaghKoli
,tblCodhayeDaramd_1.fldDaramadId
FROM            Drd.tblRequestTaghsit_Takhfif INNER JOIN
                         Drd.tblStatusTaghsit_Takhfif ON Drd.tblRequestTaghsit_Takhfif.fldId = Drd.tblStatusTaghsit_Takhfif.fldRequestId INNER JOIN
                         Drd.tblReplyTaghsit ON Drd.tblStatusTaghsit_Takhfif.fldId = Drd.tblReplyTaghsit.fldStatusId INNER JOIN
                         Drd.tblElamAvarez ON Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId = Drd.tblElamAvarez.fldId INNER JOIN
                         Drd.tblCodhayeDaramadiElamAvarez ON Drd.tblElamAvarez.fldId = Drd.tblCodhayeDaramadiElamAvarez.fldElamAvarezId INNER JOIN
                         Drd.tblShomareHesabCodeDaramad ON Drd.tblCodhayeDaramadiElamAvarez.fldShomareHesabCodeDaramadId = Drd.tblShomareHesabCodeDaramad.fldId INNER JOIN
                         Drd.tblCodhayeDaramd AS tblCodhayeDaramd_1 ON Drd.tblShomareHesabCodeDaramad.fldCodeDaramadId = tblCodhayeDaramd_1.fldId INNER JOIN
                         Drd.tblBarat ON Drd.tblReplyTaghsit.fldId = Drd.tblBarat.fldReplyTaghsitId INNER JOIN
						 com.tblShomareHesabeOmoomi ON tblShomareHesabeOmoomi.fldId = tblShomareHesabCodeDaramad.fldShomareHesadId

						 WHERE fldRequestId NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=fldRequestId)
						AND tblBarat.fldStatus=2 
						AND (Drd.tblBarat.fldDateStatus ) BETWEEN @AzTarikh AND @TaTarikh
						--AND CAST(Drd.tblBarat.fldDate AS  DATE) BETWEEN @StartDate AND @EndDate
						 GROUP BY tblRequestTaghsit_Takhfif.fldElamAvarezId,tblCodhayeDaramd_1.fldDaramadCode, 
                         Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad,fldMablaghSanad,fldReplyTaghsitId, tblCodhayeDaramadiElamAvarez.fldElamAvarezId
						 ,tblShomareHesabCodeDaramad.fldShomareHesadId,fldShomareHesab,fldDaramadId
						 )t

DECLARE @code table(id int ,CodeDaramad NVARCHAR(50),fldLevel NVARCHAR(50))
;WITH code AS (
SELECT  fldId, fldDaramadCode ,fldDaramadId,fldLevel FROM Drd.tblCodhayeDaramd
WHERE fldId=@CodeDaramadId
UNION ALL
SELECT  c.fldId, c.fldDaramadCode    ,c.fldDaramadId   ,c.fldLevel        
FROM     Drd.tblCodhayeDaramd AS c INNER JOIN
                 code AS p ON  c.fldDaramadId.GetAncestor(1) = p.fldDaramadId 

)
INSERT INTO @code
        ( id, CodeDaramad,fldLevel )
SELECT fldid,code.fldDaramadCode,fldLevel FROM code    
 
IF(@ShomareHesabId<>0 AND @CodeDaramadId<>0)
SELECT * FROM (
SELECT fldStrhid AS hidChilde,fldDaramadCode AS DaramdCodeChilde,fldDaramadTitle AS DaramadTitleChilde,fldLevel AS lvlChilde,
ISNULL((SELECT d.fldStrhid FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_hid,
ISNULL((SELECT fldDaramadCode FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_DaramadCode,
ISNULL((SELECT fldDaramadTitle FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_DaramadTitle,
ISNULL((SELECT fldLevel FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_Level
,ISNULL((SELECT SUM(mablaghcodeDaramad) FROM @temp WHERE Daramadcode=C.fldDaramadCode) ,ISNULL((SELECT SUM(mablaghcodeDaramad) FROM @temp AS t WHERE t.hid.ToString() LIKE c.fldStrhid+'%'),0)) AS Mablagh
,(SELECT  TOP(1)  fldShomareHesab FROM         Drd.tblShomareHesabCodeDaramad INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblShomareHesabCodeDaramad.fldShomareHesadId = Com.tblShomareHesabeOmoomi.fldId WHERE fldCodeDaramadId=c.fldId AND fldOrganId=@OrganId) fldShomareHesab
 ,(SELECT  TOP(1)  fldShomareHesadId FROM  Drd.tblShomareHesabCodeDaramad WHERE fldCodeDaramadId=C.fldId AND fldOrganId=@OrganId) fldShomareHesabId
 ,CASE WHEN fldid IN (SELECT  s.fldId FROM     Drd.tblCodhayeDaramd AS s left JOIN
                  Drd.tblCodhayeDaramd AS p ON  s.fldDaramadId = p.fldDaramadId.GetAncestor(1)
                  WHERE p.fldDaramadId IS NULL AND s.fldId=c.fldid) THEN N'1' ELSE '0' END AS LastNode
 FROM Drd.tblCodhayeDaramd AS C
 WHERE C.fldLevel<>0   AND C.fldId IN (SELECT id FROM @code))s
 WHERE fldShomareHesabId LIKE @ShomareHesabId and    LastNode=1 and Mablagh<>0
 

 IF(@ShomareHesabId=0 AND @CodeDaramadId=0)
 
 select * from (SELECT fldStrhid AS hidChilde,fldDaramadCode AS DaramdCodeChilde,fldDaramadTitle AS DaramadTitleChilde,fldLevel AS lvlChilde,
ISNULL((SELECT d.fldStrhid FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_hid,
ISNULL((SELECT fldDaramadCode FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_DaramadCode,
ISNULL((SELECT fldDaramadTitle FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_DaramadTitle,
ISNULL((SELECT fldLevel FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_Level
,ISNULL((SELECT SUM(mablaghcodeDaramad) FROM @temp WHERE Daramadcode=C.fldDaramadCode) ,ISNULL((SELECT SUM(mablaghcodeDaramad) FROM @temp AS t WHERE t.hid.ToString() LIKE c.fldStrhid+'%'),0)) AS Mablagh
,(SELECT  TOP(1)  fldShomareHesab FROM         Drd.tblShomareHesabCodeDaramad INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblShomareHesabCodeDaramad.fldShomareHesadId = Com.tblShomareHesabeOmoomi.fldId WHERE fldCodeDaramadId=c.fldId AND fldOrganId=@OrganId) fldShomareHesab
 ,(SELECT  TOP(1)  fldShomareHesadId FROM  Drd.tblShomareHesabCodeDaramad WHERE fldCodeDaramadId=C.fldId AND fldOrganId=@OrganId) fldShomareHesabId
 ,CASE WHEN fldid IN (SELECT  s.fldId FROM     Drd.tblCodhayeDaramd AS s left JOIN
                  Drd.tblCodhayeDaramd AS p ON  s.fldDaramadId = p.fldDaramadId.GetAncestor(1)
                  WHERE p.fldDaramadId IS NULL AND s.fldId=c.fldid) THEN N'1' ELSE '0' END AS LastNode
 FROM Drd.tblCodhayeDaramd AS C
 WHERE C.fldLevel<>0) t
 where  LastNode=1 and Mablagh<>0 
 
 IF(@ShomareHesabId=0 AND @CodeDaramadId<>0)
select * from(SELECT fldStrhid AS hidChilde,fldDaramadCode AS DaramdCodeChilde,fldDaramadTitle AS DaramadTitleChilde,fldLevel AS lvlChilde,
ISNULL((SELECT d.fldStrhid FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_hid,
ISNULL((SELECT fldDaramadCode FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_DaramadCode,
ISNULL((SELECT fldDaramadTitle FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_DaramadTitle,
ISNULL((SELECT fldLevel FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_Level
,ISNULL((SELECT SUM(mablaghcodeDaramad) FROM @temp WHERE Daramadcode=C.fldDaramadCode) ,ISNULL((SELECT SUM(mablaghcodeDaramad) FROM @temp AS t WHERE t.hid.ToString() LIKE c.fldStrhid+'%'),0)) AS Mablagh
,(SELECT  TOP(1)  fldShomareHesab FROM         Drd.tblShomareHesabCodeDaramad INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblShomareHesabCodeDaramad.fldShomareHesadId = Com.tblShomareHesabeOmoomi.fldId WHERE fldCodeDaramadId=c.fldId AND fldOrganId=@OrganId) fldShomareHesab
 ,(SELECT  TOP(1)  fldShomareHesadId FROM  Drd.tblShomareHesabCodeDaramad WHERE fldCodeDaramadId=C.fldId AND fldOrganId=@OrganId) fldShomareHesabId
  ,CASE WHEN fldid IN (SELECT  s.fldId FROM     Drd.tblCodhayeDaramd AS s left JOIN
                  Drd.tblCodhayeDaramd AS p ON  s.fldDaramadId = p.fldDaramadId.GetAncestor(1)
                  WHERE p.fldDaramadId IS NULL AND s.fldId=c.fldid) THEN N'1' ELSE '0' END AS LastNode
 FROM Drd.tblCodhayeDaramd AS C
 WHERE C.fldLevel<>0   AND C.fldId IN (SELECT id FROM @code))t
 where    LastNode=1 and Mablagh<>0

 IF(@ShomareHesabId<>0 AND @CodeDaramadId=0)
SELECT * from(SELECT fldStrhid AS hidChilde,fldDaramadCode AS DaramdCodeChilde,fldDaramadTitle AS DaramadTitleChilde,fldLevel AS lvlChilde,
ISNULL((SELECT d.fldStrhid FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_hid,
ISNULL((SELECT fldDaramadCode FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_DaramadCode,
ISNULL((SELECT fldDaramadTitle FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_DaramadTitle,
ISNULL((SELECT fldLevel FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_Level
,ISNULL((SELECT SUM(mablaghcodeDaramad) FROM @temp WHERE Daramadcode=C.fldDaramadCode) ,ISNULL((SELECT SUM(mablaghcodeDaramad) FROM @temp AS t WHERE t.hid.ToString() LIKE c.fldStrhid+'%'),0)) AS Mablagh
,(SELECT TOP(1) fldShomareHesab FROM         Drd.tblShomareHesabCodeDaramad INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblShomareHesabCodeDaramad.fldShomareHesadId = Com.tblShomareHesabeOmoomi.fldId WHERE fldCodeDaramadId=c.fldId AND fldOrganId=1) fldShomareHesab
 ,(SELECT  TOP(1)  fldShomareHesadId FROM  Drd.tblShomareHesabCodeDaramad WHERE fldCodeDaramadId=C.fldId AND fldOrganId=@OrganId) fldShomareHesabId
  ,CASE WHEN fldid IN (SELECT  s.fldId FROM     Drd.tblCodhayeDaramd AS s left JOIN
                  Drd.tblCodhayeDaramd AS p ON  s.fldDaramadId = p.fldDaramadId.GetAncestor(1)
                  WHERE p.fldDaramadId IS NULL AND s.fldId=c.fldid) THEN N'1' ELSE '0' END AS LastNode
 FROM Drd.tblCodhayeDaramd AS C
 WHERE C.fldLevel<>0  )t
  WHERE fldShomareHesabId LIKE @ShomareHesabId  and   LastNode=1 and Mablagh<>0
GO
