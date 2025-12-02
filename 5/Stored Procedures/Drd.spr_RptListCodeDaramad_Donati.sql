SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_RptListCodeDaramad_Donati](@AzTarikh NVARCHAR(10),@TaTarikh NVARCHAR(10),@OrganId INT,@DateType tinyint)
AS
--DECLARE @AzTarikh NVARCHAR(10)='1397/06/10',@TaTarikh NVARCHAR(10)='1397/07/30',@ShomareHesabId INT=0,@OrganId INT=1
DECLARE @CodeDaramadId INT=0
DECLARE @temp TABLE(idcode int,Daramadcode NVARCHAR(50),sharhecode NVARCHAR(300),shomareHesab NVARCHAR(50),mablaghcodeDaramad BIGINT,fldtype NVARCHAR(1),hid HIERARCHYID)
DECLARE @temp_Hid TABLE(Daramadcode NVARCHAR(50),sharhecode NVARCHAR(300),shomareHesab NVARCHAR(50),mablaghcodeDaramad BIGINT,hid HIERARCHYID)
DECLARE @StartDate DATE=com.ShamsiToMiladi(@Aztarikh)
DECLARE @EndDate DATE=com.ShamsiToMiladi(@TaTarikh)

if(@DateType=1)/*براساس تاریخ پرداخت*/
begin
	INSERT INTO @temp
			(idcode, Daramadcode ,sharhecode , shomareHesab , mablaghcodeDaramad,fldtype,hid  )

	SELECT     tblCodhayeDaramd_1.fldid,   tblCodhayeDaramd_1.fldDaramadCode, Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad, Com.tblShomareHesabeOmoomi.fldShomareHesab, 
						   ISNULL((cast((Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifAsliValue * Drd.tblCodhayeDaramadiElamAvarez.fldTedad + Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifAvarezValue + Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifMaliyatValue+fldTakhfifAmuzeshParvareshValue) as bigint)),
							 ( cast((Drd.tblCodhayeDaramadiElamAvarez.fldAsliValue * Drd.tblCodhayeDaramadiElamAvarez.fldTedad + Drd.tblCodhayeDaramadiElamAvarez.fldAvarezValue + Drd.tblCodhayeDaramadiElamAvarez.fldMaliyatValue+fldAmuzeshParvareshValue) as bigint)))
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
						 AND tblShomareHesabCodeDaramad.fldOrganId=@OrganId
						 
		--GROUP BY tblCodhayeDaramd_1.fldDaramadCode, Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad,fldShomareHesab,fldDaramadId

		
union all
SELECT  idcode,fldDaramadCode,fldSharheCodeDaramad,fldShomareHesab, ((CAST(fldMablaghNaghdi AS BIGINT)*CAST(fldmablaghCodeDaramad AS numeric))/CAST(fldmablaghKoli AS bigint)),'1'
,fldDaramadId
 FROM 
(SELECT   DISTINCT    Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId, tblCodhayeDaramd_1.fldDaramadCode,tblCodhayeDaramd_1.fldid idcode, 
                         Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad
						-- ,SUM(fldMablagh) OVER (PARTITION BY fldReplyTaghsitId,tblNaghdi_Talab.fldShomareHesabId) AS fldMablaghNaghdi
						,Drd.fn_SumMablaghNaghdi('Naghdi_Talab',tblNaghdi_Talab.fldFishId,tblNaghdi_Talab.fldShomareHesabId,@AzTarikh,@TaTarikh) AS fldMablaghNaghdi
						,fldShomareHesab ,fldReplyTaghsitId
	,ISNULL(SUM(fldTakhfifAsliValue*fldTedad+fldTakhfifAvarezValue+fldTakhfifMaliyatValue+fldTakhfifAmuzeshParvareshValue),SUM(fldAsliValue*fldTedad+fldAvarezValue+fldMaliyatValue+fldAmuzeshParvareshValue)) AS fldmablaghCodeDaramad
	,(SELECT TOP(1) ISNULL(SUM(fldTakhfifAsliValue*fldTedad+fldTakhfifAvarezValue+fldTakhfifMaliyatValue+fldTakhfifAmuzeshParvareshValue) OVER (PARTITION BY tblCodhayeDaramadiElamAvarez.fldElamAvarezId),SUM(fldAsliValue*fldTedad+fldAvarezValue+fldMaliyatValue+fldAmuzeshParvareshValue) OVER (PARTITION BY tblCodhayeDaramadiElamAvarez.fldElamAvarezId)) FROM Drd.tblCodhayeDaramadiElamAvarez AS a WHERE a.fldElamAvarezId =Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId) AS fldmablaghKoli
,tblCodhayeDaramd_1.fldDaramadId,tblNaghdi_Talab.fldFishId
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
						AND tblShomareHesabCodeDaramad.fldOrganId=@OrganId
						 GROUP BY tblRequestTaghsit_Takhfif.fldElamAvarezId,tblCodhayeDaramd_1.fldDaramadCode, tblCodhayeDaramd_1.fldid ,
                         Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad,fldMablagh,fldReplyTaghsitId, tblCodhayeDaramadiElamAvarez.fldElamAvarezId
						 ,tblNaghdi_Talab.fldShomareHesabId,fldShomareHesab,fldDaramadId,tblNaghdi_Talab.fldFishId,fldTakhfifAmuzeshParvareshValue,fldAmuzeshParvareshValue
						
						 )t
		end
else if(@DateType=0)/*براساس تاریخ واریز*/
begin
		INSERT INTO @temp
			(idcode, Daramadcode ,sharhecode , shomareHesab , mablaghcodeDaramad,fldtype,hid  )

	SELECT    tblCodhayeDaramd_1.fldid,    tblCodhayeDaramd_1.fldDaramadCode, Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad, Com.tblShomareHesabeOmoomi.fldShomareHesab, 
						   ISNULL((cast((Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifAsliValue * Drd.tblCodhayeDaramadiElamAvarez.fldTedad + Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifAvarezValue + Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifMaliyatValue+fldTakhfifAmuzeshParvareshValue) as bigint)),
							 ( cast((Drd.tblCodhayeDaramadiElamAvarez.fldAsliValue * Drd.tblCodhayeDaramadiElamAvarez.fldTedad + Drd.tblCodhayeDaramadiElamAvarez.fldAvarezValue + Drd.tblCodhayeDaramadiElamAvarez.fldMaliyatValue+fldAmuzeshParvareshValue) as bigint)))
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
						 AND CAST( tblPardakhtFish.fldDateVariz AS DATE) BETWEEN @StartDate AND @EndDate
						 AND tblShomareHesabCodeDaramad.fldOrganId=@OrganId
						 
		--GROUP BY tblCodhayeDaramd_1.fldDaramadCode, Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad,fldShomareHesab,fldDaramadId

		
union all
SELECT idcode,fldDaramadCode,fldSharheCodeDaramad,fldShomareHesab, ((CAST(fldMablaghNaghdi AS BIGINT)*CAST(fldmablaghCodeDaramad AS numeric))/CAST(fldmablaghKoli AS bigint)),'1'
,fldDaramadId
 FROM 
(SELECT   DISTINCT    Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId, tblCodhayeDaramd_1.fldDaramadCode, tblCodhayeDaramd_1.fldid idcode,
                         Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad
						-- ,SUM(fldMablagh) OVER (PARTITION BY fldReplyTaghsitId,tblNaghdi_Talab.fldShomareHesabId) AS fldMablaghNaghdi
						,Drd.fn_SumMablaghNaghdiVariz('Naghdi_Talab',tblNaghdi_Talab.fldFishId,tblNaghdi_Talab.fldShomareHesabId,@AzTarikh,@TaTarikh) AS fldMablaghNaghdi
						,fldShomareHesab ,fldReplyTaghsitId
	,ISNULL(SUM(fldTakhfifAsliValue*fldTedad+fldTakhfifAvarezValue+fldTakhfifMaliyatValue+fldTakhfifAmuzeshParvareshValue),SUM(fldAsliValue*fldTedad+fldAvarezValue+fldMaliyatValue+fldAmuzeshParvareshValue)) AS fldmablaghCodeDaramad
	,(SELECT TOP(1) ISNULL(SUM(fldTakhfifAsliValue*fldTedad+fldTakhfifAvarezValue+fldTakhfifMaliyatValue+fldTakhfifAmuzeshParvareshValue) OVER (PARTITION BY tblCodhayeDaramadiElamAvarez.fldElamAvarezId),SUM(fldAsliValue*fldTedad+fldAvarezValue+fldMaliyatValue+fldAmuzeshParvareshValue) OVER (PARTITION BY tblCodhayeDaramadiElamAvarez.fldElamAvarezId)) FROM Drd.tblCodhayeDaramadiElamAvarez AS a WHERE a.fldElamAvarezId =Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId) AS fldmablaghKoli
,tblCodhayeDaramd_1.fldDaramadId,tblNaghdi_Talab.fldFishId
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
						AND CAST(tblPardakhtFish.fldDateVariz AS  DATE) BETWEEN @StartDate AND @EndDate
						AND tblShomareHesabCodeDaramad.fldOrganId=@OrganId
						 GROUP BY tblRequestTaghsit_Takhfif.fldElamAvarezId,tblCodhayeDaramd_1.fldDaramadCode, tblCodhayeDaramd_1.fldid,
                         Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad,fldMablagh,fldReplyTaghsitId, tblCodhayeDaramadiElamAvarez.fldElamAvarezId
						 ,tblNaghdi_Talab.fldShomareHesabId,fldShomareHesab,fldDaramadId,tblNaghdi_Talab.fldFishId,fldTakhfifAmuzeshParvareshValue,fldAmuzeshParvareshValue
						
						 )t
	end

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
 
SELECT idcode, fldDaramadCode,fldSharheCodeDaramad,fldShomareHesab, ((CAST(fldMablagh AS BIGINT)*CAST(fldmablaghCodeDaramad AS numeric))/CAST(fldmablaghKoli AS BIGINT)),'2',fldDaramadId FROM 
(SELECT   DISTINCT    Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId, tblCodhayeDaramd_1.fldDaramadCode, tblCodhayeDaramd_1.fldid idcode,
                         Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad
						-- ,SUM(fldMablagh) OVER (PARTITION BY fldReplyTaghsitId,tblNaghdi_Talab.fldShomareHesabId) AS fldMablaghNaghdi
						,Drd.fn_SumMablaghNaghdi('Check',tblCheck.fldid,tblCheck.fldShomareHesabIdOrgan,@AzTarikh,@TaTarikh) AS fldMablagh
						,fldShomareHesab ,fldReplyTaghsitId
	,ISNULL(SUM(fldTakhfifAsliValue*fldTedad+fldTakhfifAvarezValue+fldTakhfifMaliyatValue+fldTakhfifAmuzeshParvareshValue),SUM(fldAsliValue*fldTedad+fldAvarezValue+fldMaliyatValue+fldAmuzeshParvareshValue)) AS fldmablaghCodeDaramad
	,(SELECT TOP(1) ISNULL(SUM(fldTakhfifAsliValue*fldTedad+fldTakhfifAvarezValue+fldTakhfifMaliyatValue+fldTakhfifAmuzeshParvareshValue) OVER (PARTITION BY tblCodhayeDaramadiElamAvarez.fldElamAvarezId),SUM(fldAsliValue*fldTedad+fldAvarezValue+fldMaliyatValue+fldAmuzeshParvareshValue) OVER (PARTITION BY tblCodhayeDaramadiElamAvarez.fldElamAvarezId)) FROM Drd.tblCodhayeDaramadiElamAvarez AS a WHERE a.fldElamAvarezId =Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId) AS fldmablaghKoli
,tblCodhayeDaramd_1.fldDaramadId,tblCheck.fldid
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
						 AND tblShomareHesabCodeDaramad.fldOrganId=@OrganId
						 GROUP BY tblRequestTaghsit_Takhfif.fldElamAvarezId,tblCodhayeDaramd_1.fldDaramadCode, tblCodhayeDaramd_1.fldid,
                         Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad,fldMablaghSanad,fldReplyTaghsitId, tblCodhayeDaramadiElamAvarez.fldElamAvarezId
						 ,tblCheck.fldShomareHesabIdOrgan,fldShomareHesab,fldDaramadId,tblCheck.fldid
						 )t


INSERT INTO @temp
       
						 SELECT idcode, fldDaramadCode,fldSharheCodeDaramad,fldShomareHesab, ((CAST(fldMablagh AS BIGINT)*CAST(fldmablaghCodeDaramad AS numeric))/CAST(fldmablaghKoli AS BIGINT)),'3',fldDaramadId FROM 
(SELECT   DISTINCT    Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId, tblCodhayeDaramd_1.fldDaramadCode, tblCodhayeDaramd_1.fldid idcode,
                         Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad
						-- ,SUM(fldMablagh) OVER (PARTITION BY fldReplyTaghsitId,tblNaghdi_Talab.fldShomareHesabId) AS fldMablaghNaghdi
						,Drd.fn_SumMablaghNaghdi('Safte',fldReplyTaghsitId,tblShomareHesabCodeDaramad.fldShomareHesadId,@AzTarikh,@TaTarikh) AS fldMablagh
						,fldShomareHesab ,fldReplyTaghsitId
	,ISNULL(SUM(fldTakhfifAsliValue*fldTedad+fldTakhfifAvarezValue+fldTakhfifMaliyatValue+fldTakhfifAmuzeshParvareshValue),SUM(fldAsliValue*fldTedad+fldAvarezValue+fldMaliyatValue+fldAmuzeshParvareshValue)) AS fldmablaghCodeDaramad
	,(SELECT TOP(1) ISNULL(SUM(fldTakhfifAsliValue*fldTedad+fldTakhfifAvarezValue+fldTakhfifMaliyatValue+fldTakhfifAmuzeshParvareshValue) OVER (PARTITION BY tblCodhayeDaramadiElamAvarez.fldElamAvarezId),SUM(fldAsliValue*fldTedad+fldAvarezValue+fldMaliyatValue+fldAmuzeshParvareshValue) OVER (PARTITION BY tblCodhayeDaramadiElamAvarez.fldElamAvarezId)) FROM Drd.tblCodhayeDaramadiElamAvarez AS a WHERE a.fldElamAvarezId =Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId) AS fldmablaghKoli
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
						--AND CAST(Drd.tblSafte.fldDate AS  DATE) BETWEEN @StartDate AND @EndDate
						AND (Drd.tblSafte.fldDateStatus ) BETWEEN @AzTarikh AND @TaTarikh
						 AND tblShomareHesabCodeDaramad.fldOrganId=@OrganId
						 GROUP BY tblRequestTaghsit_Takhfif.fldElamAvarezId,tblCodhayeDaramd_1.fldDaramadCode, tblCodhayeDaramd_1.fldid,
                         Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad,fldMablaghSanad,fldReplyTaghsitId, tblCodhayeDaramadiElamAvarez.fldElamAvarezId
						 ,tblShomareHesabCodeDaramad.fldShomareHesadId,fldShomareHesab,fldDaramadId,fldTakhfifAmuzeshParvareshValue,fldAmuzeshParvareshValue
						 )t

INSERT INTO @temp
SELECT idcode, fldDaramadCode,fldSharheCodeDaramad,fldShomareHesab, ((CAST(fldMablagh AS BIGINT)*CAST(fldmablaghCodeDaramad AS numeric))/CAST(fldmablaghKoli AS BIGINT)),'4',fldDaramadId FROM 
(SELECT   DISTINCT    Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId, tblCodhayeDaramd_1.fldDaramadCode,tblCodhayeDaramd_1.fldid idcode, 
                         Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad
						-- ,SUM(fldMablagh) OVER (PARTITION BY fldReplyTaghsitId,tblNaghdi_Talab.fldShomareHesabId) AS fldMablaghNaghdi
						,Drd.fn_SumMablaghNaghdi('Barat',fldReplyTaghsitId,tblShomareHesabCodeDaramad.fldShomareHesadId,@AzTarikh,@TaTarikh) AS fldMablagh
						,fldShomareHesab ,fldReplyTaghsitId
	,ISNULL(SUM(fldTakhfifAsliValue*fldTedad+fldTakhfifAvarezValue+fldTakhfifMaliyatValue+fldTakhfifAmuzeshParvareshValue),SUM(fldAsliValue*fldTedad+fldAvarezValue+fldMaliyatValue+fldAmuzeshParvareshValue)) AS fldmablaghCodeDaramad
	,(SELECT TOP(1) ISNULL(SUM(fldTakhfifAsliValue*fldTedad+fldTakhfifAvarezValue+fldTakhfifMaliyatValue+fldTakhfifAmuzeshParvareshValue) OVER (PARTITION BY tblCodhayeDaramadiElamAvarez.fldElamAvarezId),SUM(fldAsliValue*fldTedad+fldAvarezValue+fldMaliyatValue+fldAmuzeshParvareshValue) OVER (PARTITION BY tblCodhayeDaramadiElamAvarez.fldElamAvarezId)) FROM Drd.tblCodhayeDaramadiElamAvarez AS a WHERE a.fldElamAvarezId =Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId) AS fldmablaghKoli
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
						--AND CAST(Drd.tblBarat.fldDate AS  DATE) BETWEEN @StartDate AND @EndDate
						AND (Drd.tblBarat.fldDateStatus ) BETWEEN @AzTarikh AND @TaTarikh
						 AND tblShomareHesabCodeDaramad.fldOrganId=@OrganId
						 GROUP BY tblRequestTaghsit_Takhfif.fldElamAvarezId,tblCodhayeDaramd_1.fldDaramadCode, tblCodhayeDaramd_1.fldid,
                         Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad,fldMablaghSanad,fldReplyTaghsitId, tblCodhayeDaramadiElamAvarez.fldElamAvarezId
						 ,tblShomareHesabCodeDaramad.fldShomareHesadId,fldShomareHesab,fldDaramadId,fldTakhfifAmuzeshParvareshValue,fldAmuzeshParvareshValue
						 )t
--SELECT * FROM @temp
--DECLARE @code table(id int ,CodeDaramad NVARCHAR(50),fldLevel NVARCHAR(50))
--;WITH code AS (
--SELECT  fldId, fldDaramadCode ,fldDaramadId,fldLevel FROM Drd.tblCodhayeDaramd
--WHERE fldId=@CodeDaramadId
--UNION ALL
--SELECT  c.fldId, c.fldDaramadCode    ,c.fldDaramadId   ,c.fldLevel        
--FROM     Drd.tblCodhayeDaramd AS c INNER JOIN
--                 code AS p ON  c.fldDaramadId.GetAncestor(1) = p.fldDaramadId 

--)
--INSERT INTO @code
--        ( id, CodeDaramad,fldLevel )
--SELECT fldid,code.fldDaramadCode,fldLevel FROM code    
 DECLARE @temp2 TABLE(hidChilde NVARCHAR(50),DaramadCodeTitle NVARCHAR(50),DaramdTitleChilde NVARCHAR(max),lvlChilde NVARCHAR(10),P_hid NVARCHAR(50),P_DaramadCode NVARCHAR(50),P_DaramadTitle NVARCHAR(MAX),P_Level NVARCHAR(50),Mablagh bigint,fldShomareHesab NVARCHAR(50),fldShomareHesabId INT ,LastNode  NCHAR(2))
 INSERT INTO @temp2
SELECT TOP(4) * from (SELECT fldStrhid AS hidChilde,fldDaramadCode AS DaramdCodeChilde,ISNULL((SELECT MAX(sharhecode) FROM @temp WHERE idcode=C.fldid GROUP BY idcode),fldDaramadTitle)  AS DaramadTitleChilde,fldLevel AS lvlChilde,
ISNULL((SELECT d.fldStrhid FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_hid,
ISNULL((SELECT fldDaramadCode FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_DaramadCode,
ISNULL((SELECT fldDaramadTitle FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_DaramadTitle,
ISNULL((SELECT fldLevel FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_Level
,ISNULL((SELECT SUM(mablaghcodeDaramad) FROM @temp WHERE idcode=C.fldid) ,ISNULL((SELECT SUM(mablaghcodeDaramad) FROM @temp AS t WHERE t.hid.ToString() LIKE c.fldStrhid+'%'),0)) AS Mablagh
,(SELECT  TOP(1)  fldShomareHesab FROM         Drd.tblShomareHesabCodeDaramad INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblShomareHesabCodeDaramad.fldShomareHesadId = Com.tblShomareHesabeOmoomi.fldId WHERE fldCodeDaramadId=c.fldId AND fldOrganId=@OrganId) fldShomareHesab
 ,(SELECT  TOP(1)  fldShomareHesadId FROM  Drd.tblShomareHesabCodeDaramad WHERE fldCodeDaramadId=C.fldId AND fldOrganId=@OrganId) fldShomareHesabId
 ,CASE WHEN fldid IN (SELECT  s.fldId FROM     Drd.tblCodhayeDaramd AS s left JOIN
                  Drd.tblCodhayeDaramd AS p ON  s.fldDaramadId = p.fldDaramadId.GetAncestor(1)
                  WHERE p.fldDaramadId IS NULL AND s.fldId=c.fldid) THEN N'1' ELSE '0' END AS LastNode
 FROM Drd.tblCodhayeDaramd AS C
 WHERE C.fldLevel<>0) t
 where  LastNode=1 and Mablagh<>0
 ORDER BY Mablagh DESC
 
 
 INSERT INTO @temp2
 SELECT '','',N'سایر موارد','','','','','',SUM(t.Mablagh),'' ,0,1 FROM (SELECT fldStrhid AS hidChilde,fldDaramadCode AS DaramdCodeChilde,ISNULL((SELECT sharhecode FROM @temp WHERE idcode=C.fldid GROUP BY idcode,sharhecode),fldDaramadTitle) AS DaramadTitleChilde,fldLevel AS lvlChilde,
ISNULL((SELECT d.fldStrhid FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_hid,
ISNULL((SELECT fldDaramadCode FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_DaramadCode,
ISNULL((SELECT fldDaramadTitle FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_DaramadTitle,
ISNULL((SELECT fldLevel FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_Level
,ISNULL((SELECT SUM(mablaghcodeDaramad) FROM @temp WHERE idcode=C.fldid) ,ISNULL((SELECT SUM(mablaghcodeDaramad) FROM @temp AS t WHERE t.hid.ToString() LIKE c.fldStrhid+'%'),0)) AS Mablagh
,(SELECT  TOP(1)  fldShomareHesab FROM         Drd.tblShomareHesabCodeDaramad INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblShomareHesabCodeDaramad.fldShomareHesadId = Com.tblShomareHesabeOmoomi.fldId WHERE fldCodeDaramadId=c.fldId AND fldOrganId=@OrganId) fldShomareHesab
 ,(SELECT  TOP(1)  fldShomareHesadId FROM  Drd.tblShomareHesabCodeDaramad WHERE fldCodeDaramadId=C.fldId AND fldOrganId=@OrganId) fldShomareHesabId
 ,CASE WHEN fldid IN (SELECT  s.fldId FROM     Drd.tblCodhayeDaramd AS s left JOIN
                  Drd.tblCodhayeDaramd AS p ON  s.fldDaramadId = p.fldDaramadId.GetAncestor(1)
                  WHERE p.fldDaramadId IS NULL AND s.fldId=c.fldid) THEN N'1' ELSE '0' END AS LastNode
 FROM Drd.tblCodhayeDaramd AS C
 WHERE C.fldLevel<>0) t
 where  LastNode=1 and Mablagh<>0 AND t.DaramdCodeChilde NOT IN (SELECT DaramadCodeTitle FROM @temp2)

 
 SELECT * FROM @temp2 WHERE Mablagh<>0
GO
