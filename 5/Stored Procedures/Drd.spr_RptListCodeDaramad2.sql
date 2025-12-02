SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_RptListCodeDaramad2](@AzTarikh NVARCHAR(10),@TaTarikh NVARCHAR(10),@ShomareHesabId INT,@CodeDaramadId INT,@OrganId INT,@fieldname NVARCHAR(50))
AS
--DECLARE @AzTarikh NVARCHAR(10)='1397/09/01',@TaTarikh NVARCHAR(10)='1397/09/10',@ShomareHesabId INT=0,@CodeDaramadId INT=261,@OrganId INT=1
DECLARE @temp TABLE(Daramadcode NVARCHAR(50),sharhecode NVARCHAR(300),shomareHesab NVARCHAR(50),mablaghcodeDaramad BIGINT,fldtype NVARCHAR(1),hid HIERARCHYID,fldtarikh nvarchar (10),c int,ShomareHId int)
DECLARE @temp_Hid TABLE(Daramadcode NVARCHAR(50),sharhecode NVARCHAR(300),shomareHesab NVARCHAR(50),mablaghcodeDaramad BIGINT,hid HIERARCHYID)
DECLARE @code table(id int ,CodeDaramad NVARCHAR(50),fldLevel NVARCHAR(50))
DECLARE @StartDate DATE=com.ShamsiToMiladi(@Aztarikh)
DECLARE @EndDate DATE=com.ShamsiToMiladi(@TaTarikh)
--select * from drd.tblCodhayeDaramd where fldDaramadCode='402005/08'
if(@fieldname='Detail')
BEGIN
	IF(@OrganId<>0)
	BEGIN
			INSERT INTO @temp
			--( Daramadcode ,sharhecode , shomareHesab , mablaghcodeDaramad,fldtype,hid ,fldtarikh )

			SELECT        tblCodhayeDaramd_1.fldDaramadCode, Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad, Com.tblShomareHesabeOmoomi.fldShomareHesab, 
								   ISNULL(cast((Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifAsliValue * Drd.tblCodhayeDaramadiElamAvarez.fldTedad + Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifAvarezValue + Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifMaliyatValue)as bigint),
									  cast((Drd.tblCodhayeDaramadiElamAvarez.fldAsliValue * Drd.tblCodhayeDaramadiElamAvarez.fldTedad + Drd.tblCodhayeDaramadiElamAvarez.fldAvarezValue + Drd.tblCodhayeDaramadiElamAvarez.fldMaliyatValue)as bigint))
				AS fldmablaghCodeDaramad, '0' AS Expr1, tblCodhayeDaramd_1.fldDaramadId,tblPardakhtFish.fldTarikh,tblPardakhtFish.fldId,tblSodoorFish.fldShomareHesabId
			FROM            Drd.tblSodoorFish INNER JOIN
							 Drd.tblSodoorFish_Detail ON Drd.tblSodoorFish.fldId = Drd.tblSodoorFish_Detail.fldFishId INNER JOIN
							 Drd.tblCodhayeDaramadiElamAvarez ON Drd.tblSodoorFish_Detail.fldCodeElamAvarezId = Drd.tblCodhayeDaramadiElamAvarez.fldID INNER JOIN
							 Drd.tblShomareHesabCodeDaramad ON Drd.tblCodhayeDaramadiElamAvarez.fldShomareHesabCodeDaramadId = Drd.tblShomareHesabCodeDaramad.fldId AND 
							 Drd.tblCodhayeDaramadiElamAvarez.fldShomareHesabCodeDaramadId = Drd.tblShomareHesabCodeDaramad.fldId INNER JOIN
							 Drd.tblCodhayeDaramd AS tblCodhayeDaramd_1 ON Drd.tblShomareHesabCodeDaramad.fldCodeDaramadId = tblCodhayeDaramd_1.fldId INNER JOIN
							 Drd.tblPardakhtFish ON Drd.tblSodoorFish.fldId = Drd.tblPardakhtFish.fldFishId AND Drd.tblSodoorFish.fldId = Drd.tblPardakhtFish.fldFishId INNER JOIN
							 Com.tblShomareHesabeOmoomi ON Drd.tblSodoorFish.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId
			WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId)
							 AND CAST( tblPardakhtFish.fldDatePardakht AS DATE) BETWEEN @StartDate AND @EndDate
							 AND fldOrganId=@OrganId
							 
							 
			--GROUP BY tblCodhayeDaramd_1.fldDaramadCode, Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad,fldShomareHesab,fldDaramadId

			
			union all
			SELECT fldDaramadCode,fldSharheCodeDaramad,fldShomareHesab, (CAST((CAST(fldMablaghNaghdi AS BIGINT)*CAST(fldmablaghCodeDaramad AS bigint))AS BIGINT)/CAST(fldmablaghKoli AS bigint)),'1'
			,fldDaramadId,fldTarikh,fldId,fldShomareHesabId
			 FROM 
			(SELECT   DISTINCT    Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId, tblCodhayeDaramd_1.fldDaramadCode, 
									 Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad
									-- ,SUM(fldMablagh) OVER (PARTITION BY fldReplyTaghsitId,tblNaghdi_Talab.fldShomareHesabId) AS fldMablaghNaghdi
									,Drd.fn_SumMablaghNaghdi('Naghdi_Talab',fldReplyTaghsitId,tblNaghdi_Talab.fldShomareHesabId,'','') AS fldMablaghNaghdi
									,fldShomareHesab ,fldReplyTaghsitId
				,ISNULL(SUM(fldTakhfifAsliValue*fldTedad+fldTakhfifAvarezValue+fldTakhfifMaliyatValue),SUM(fldAsliValue*fldTedad+fldAvarezValue+fldMaliyatValue)) AS fldmablaghCodeDaramad
				,(SELECT TOP(1) ISNULL(SUM(fldTakhfifAsliValue*fldTedad+fldTakhfifAvarezValue+fldTakhfifMaliyatValue) OVER (PARTITION BY tblCodhayeDaramadiElamAvarez.fldElamAvarezId),SUM(fldAsliValue*fldTedad+fldAvarezValue+fldMaliyatValue) OVER (PARTITION BY tblCodhayeDaramadiElamAvarez.fldElamAvarezId)) FROM Drd.tblCodhayeDaramadiElamAvarez AS a WHERE a.fldElamAvarezId =Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId) AS fldmablaghKoli
			,tblCodhayeDaramd_1.fldDaramadId,tblPardakhtFish.fldTarikh,tblPardakhtFish.fldId,Drd.tblNaghdi_Talab.fldShomareHesabId
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
						
							 )t


		
	------------------------------------------------------- وصول شده

							INSERT INTO @temp
							 
							SELECT  fldDaramadCode,fldSharheCodeDaramad,fldShomareHesab, (CAST((CAST(fldMablagh AS BIGINT)*CAST(fldmablaghCodeDaramad AS bigint))AS BIGINT)/CAST(fldmablaghKoli AS BIGINT)),'2',fldDaramadId,fldDateStatus,
							fldid,fldShomareHesabIdOrgan
							 FROM 
							(SELECT   DISTINCT    Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId, tblCodhayeDaramd_1.fldDaramadCode, 
													 Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad
													-- ,SUM(fldMablagh) OVER (PARTITION BY fldReplyTaghsitId,tblNaghdi_Talab.fldShomareHesabId) AS fldMablaghNaghdi
													,Drd.fn_SumMablaghNaghdi('Check',fldReplyTaghsitId,tblCheck.fldShomareHesabIdOrgan,@azTarikh ,@Tatarikh) AS fldMablagh
													,fldShomareHesab ,fldReplyTaghsitId
								,ISNULL(SUM(fldTakhfifAsliValue*fldTedad+fldTakhfifAvarezValue+fldTakhfifMaliyatValue),SUM(fldAsliValue*fldTedad+fldAvarezValue+fldMaliyatValue)) AS fldmablaghCodeDaramad
								,(SELECT TOP(1) ISNULL(SUM(fldTakhfifAsliValue*fldTedad+fldTakhfifAvarezValue+fldTakhfifMaliyatValue) OVER (PARTITION BY tblCodhayeDaramadiElamAvarez.fldElamAvarezId),SUM(fldAsliValue*fldTedad+fldAvarezValue+fldMaliyatValue) OVER (PARTITION BY tblCodhayeDaramadiElamAvarez.fldElamAvarezId)) FROM Drd.tblCodhayeDaramadiElamAvarez AS a WHERE a.fldElamAvarezId =Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId) AS fldmablaghKoli
							,tblCodhayeDaramd_1.fldDaramadId,fldDateStatus,tblcheck.fldid,tblCheck.fldShomareHesabIdOrgan
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
							AND tblCheck.fldStatus=2 AND fldTypeSanad=0 AND tblShomareHesabCodeDaramad.fldOrganId=@OrganId
							AND (Drd.tblCheck.fldDateStatus ) BETWEEN @AzTarikh AND @TaTarikh
							 GROUP BY tblRequestTaghsit_Takhfif.fldElamAvarezId,tblCodhayeDaramd_1.fldDaramadCode, 
							 Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad,fldMablaghSanad,fldReplyTaghsitId, tblCodhayeDaramadiElamAvarez.fldElamAvarezId
							 ,tblCheck.fldShomareHesabIdOrgan,fldShomareHesab,fldDaramadId,fldDateStatus,tblcheck.fldid,fldShomareHesabIdOrgan
							 )t


					INSERT INTO @temp
	       
							 SELECT  fldDaramadCode,fldSharheCodeDaramad,fldShomareHesab, (CAST((CAST(fldMablagh AS BIGINT)*CAST(fldmablaghCodeDaramad AS bigint))AS BIGINT)/CAST(fldmablaghKoli AS BIGINT)),'3'
							 ,fldDaramadId,fldDateStatus,fldid ,fldShomareHesadId
							 FROM 
						(SELECT   DISTINCT    Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId, tblCodhayeDaramd_1.fldDaramadCode, 
												 Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad
												-- ,SUM(fldMablagh) OVER (PARTITION BY fldReplyTaghsitId,tblNaghdi_Talab.fldShomareHesabId) AS fldMablaghNaghdi
												,Drd.fn_SumMablaghNaghdi('Safte',fldReplyTaghsitId,tblShomareHesabCodeDaramad.fldShomareHesadId,@AzTarikh , @Tatarikh) AS fldMablagh
												,fldShomareHesab ,fldReplyTaghsitId
							,ISNULL(SUM(fldTakhfifAsliValue*fldTedad+fldTakhfifAvarezValue+fldTakhfifMaliyatValue),SUM(fldAsliValue*fldTedad+fldAvarezValue+fldMaliyatValue)) AS fldmablaghCodeDaramad
							,(SELECT TOP(1) ISNULL(SUM(fldTakhfifAsliValue*fldTedad+fldTakhfifAvarezValue+fldTakhfifMaliyatValue) OVER (PARTITION BY tblCodhayeDaramadiElamAvarez.fldElamAvarezId),SUM(fldAsliValue*fldTedad+fldAvarezValue+fldMaliyatValue) OVER (PARTITION BY tblCodhayeDaramadiElamAvarez.fldElamAvarezId)) FROM Drd.tblCodhayeDaramadiElamAvarez AS a WHERE a.fldElamAvarezId =Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId) AS fldmablaghKoli
						,tblCodhayeDaramd_1.fldDaramadId,fldDateStatus,tblSafte.fldid,tblShomareHesabCodeDaramad.fldShomareHesadId
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
							AND tblSafte.fldStatus=2 AND tblShomareHesabCodeDaramad.fldOrganId=@OrganId
							AND (Drd.tblSafte.fldDateStatus ) BETWEEN @AzTarikh AND @TaTarikh
							--AND CAST(Drd.tblSafte.fldDate AS  DATE) BETWEEN @StartDate AND @EndDate
							 GROUP BY tblRequestTaghsit_Takhfif.fldElamAvarezId,tblCodhayeDaramd_1.fldDaramadCode, 
							 Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad,fldMablaghSanad,fldReplyTaghsitId, tblCodhayeDaramadiElamAvarez.fldElamAvarezId
							 ,tblShomareHesabCodeDaramad.fldShomareHesadId,fldShomareHesab,fldDaramadId,fldDateStatus,tblSafte.fldid,fldShomareHesadId
							 )t

					INSERT INTO @temp
					SELECT  fldDaramadCode,fldSharheCodeDaramad,fldShomareHesab, (CAST((CAST(fldMablagh AS BIGINT)*CAST(fldmablaghCodeDaramad AS bigint))AS BIGINT)/CAST(fldmablaghKoli AS BIGINT)),'4',fldDaramadId
					,fldDateStatus,fldid,fldShomareHesadId FROM 
					(SELECT   DISTINCT    Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId, tblCodhayeDaramd_1.fldDaramadCode, 
						 Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad
							-- ,SUM(fldMablagh) OVER (PARTITION BY fldReplyTaghsitId,tblNaghdi_Talab.fldShomareHesabId) AS fldMablaghNaghdi
							,Drd.fn_SumMablaghNaghdi('Barat',fldReplyTaghsitId,tblShomareHesabCodeDaramad.fldShomareHesadId,@AzTarikh,@TaTarikh) AS fldMablagh
							,fldShomareHesab ,fldReplyTaghsitId
							,ISNULL(SUM(fldTakhfifAsliValue*fldTedad+fldTakhfifAvarezValue+fldTakhfifMaliyatValue),SUM(fldAsliValue*fldTedad+fldAvarezValue+fldMaliyatValue)) AS fldmablaghCodeDaramad
							,(SELECT TOP(1) ISNULL(SUM(fldTakhfifAsliValue*fldTedad+fldTakhfifAvarezValue+fldTakhfifMaliyatValue) OVER (PARTITION BY tblCodhayeDaramadiElamAvarez.fldElamAvarezId),SUM(fldAsliValue*fldTedad+fldAvarezValue+fldMaliyatValue) OVER (PARTITION BY tblCodhayeDaramadiElamAvarez.fldElamAvarezId)) FROM Drd.tblCodhayeDaramadiElamAvarez AS a WHERE a.fldElamAvarezId =Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId) AS fldmablaghKoli
						,tblCodhayeDaramd_1.fldDaramadId,fldDateStatus,tblbarat.fldid, tblShomareHesabCodeDaramad.fldShomareHesadId
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
							AND tblBarat.fldStatus=2 AND tblShomareHesabCodeDaramad.fldOrganId=@OrganId
							AND (Drd.tblBarat.fldDateStatus ) BETWEEN @AzTarikh AND @TaTarikh
							--AND CAST(Drd.tblBarat.fldDate AS  DATE) BETWEEN @StartDate AND @EndDate
							 GROUP BY tblRequestTaghsit_Takhfif.fldElamAvarezId,tblCodhayeDaramd_1.fldDaramadCode, 
							 Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad,fldMablaghSanad,fldReplyTaghsitId, tblCodhayeDaramadiElamAvarez.fldElamAvarezId
							 ,tblShomareHesabCodeDaramad.fldShomareHesadId,fldShomareHesab,fldDaramadId,fldDateStatus,tblbarat.fldid,fldShomareHesadId
							 )t

							 --select * from @temp where  daramadcode='402005/08' order by fldtarikh

	--DECLARE @code table(id int ,CodeDaramad NVARCHAR(50),fldLevel NVARCHAR(50))
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
			SELECT DISTINCT * FROM (
			SELECT  fldStrhid AS hidChilde,fldDaramadCode AS DaramdCodeChilde,fldDaramadTitle AS DaramadTitleChilde,fldLevel AS lvlChilde,
			ISNULL((SELECT d.fldStrhid FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_hid,
			ISNULL((SELECT fldDaramadCode FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_DaramadCode,
			ISNULL((SELECT fldDaramadTitle FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_DaramadTitle,
			ISNULL((SELECT fldLevel FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_Level
			--,ISNULL((SELECT SUM(mablaghcodeDaramad) FROM @temp WHERE Daramadcode=C.fldDaramadCode) ,ISNULL((SELECT SUM(mablaghcodeDaramad) FROM @temp AS t WHERE t.hid.ToString() LIKE c.fldStrhid+'%'),0)) AS Mablagh
			,sum(mablaghcodeDaramad) over (partition by fldtarikh,e.Daramadcode) as Mablagh
			,count(c)over (partition by fldtarikh,e.Daramadcode) as [Count],e.fldtarikh
			--,ISNULL((SELECT fldtarikh FROM @temp WHERE Daramadcode=C.fldDaramadCode group by fldtarikh),'') as fldtarikh
			,(SELECT  TOP(1)  fldShomareHesab FROM        
								  Com.tblShomareHesabeOmoomi WHERE tblShomareHesabeOmoomi.fldid=ShomareHId /*AND fldOrganId=@OrganId*/) fldShomareHesab
			 ,/*(SELECT  TOP(1)  fldShomareHesadId FROM  Drd.tblShomareHesabCodeDaramad WHERE fldCodeDaramadId=C.fldId /*AND fldOrganId=@OrganId*/) */ @ShomareHesabId as fldShomareHesabId
			 ,CASE WHEN fldid IN (SELECT  s.fldId FROM     Drd.tblCodhayeDaramd AS s left JOIN
							  Drd.tblCodhayeDaramd AS p ON  s.fldDaramadId = p.fldDaramadId.GetAncestor(1)
							  WHERE p.fldDaramadId IS NULL AND s.fldId=c.fldid) THEN N'1' ELSE '0' END AS LastNode
			 FROM Drd.tblCodhayeDaramd AS C  inner join @temp as e on e.Daramadcode=c.fldDaramadCode
			 WHERE C.fldLevel<>0  and ShomareHId=@ShomareHesabId  AND C.fldId IN (SELECT id FROM @code))s
			 WHERE     LastNode=1 and Mablagh<>0
			 order by fldtarikh
			 

			 IF(@ShomareHesabId=0 AND @CodeDaramadId=0)
			 
			 SELECT DISTINCT * from (SELECT fldStrhid AS hidChilde,fldDaramadCode AS DaramdCodeChilde,fldDaramadTitle AS DaramadTitleChilde,fldLevel AS lvlChilde,
			ISNULL((SELECT d.fldStrhid FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_hid,
			ISNULL((SELECT fldDaramadCode FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_DaramadCode,
			ISNULL((SELECT fldDaramadTitle FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_DaramadTitle,
			ISNULL((SELECT fldLevel FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_Level
			--,ISNULL((SELECT SUM(mablaghcodeDaramad) FROM @temp WHERE Daramadcode=C.fldDaramadCode) ,ISNULL((SELECT SUM(mablaghcodeDaramad) FROM @temp AS t WHERE t.hid.ToString() LIKE c.fldStrhid+'%'),0)) AS Mablagh
			--,ISNULL((SELECT top(1) fldtarikh FROM @temp WHERE Daramadcode=C.fldDaramadCode group by fldtarikh),'') as fldtarikh
			--,ISNULL((SELECT top(1)  count(c) FROM @temp WHERE Daramadcode=C.fldDaramadCode group by fldtarikh,Daramadcode),'') as c
			,sum(mablaghcodeDaramad) over (partition by fldtarikh,e.Daramadcode) as Mablagh
			,count(c)over (partition by fldtarikh,e.Daramadcode) as [Count],e.fldtarikh
			,(SELECT  TOP(1)  fldShomareHesab FROM        
								  Com.tblShomareHesabeOmoomi WHERE tblShomareHesabeOmoomi.fldid=ShomareHId /*AND fldOrganId=@OrganId*/) fldShomareHesab
			 --,(SELECT  TOP(1)  fldShomareHesadId FROM  Drd.tblShomareHesabCodeDaramad WHERE fldCodeDaramadId=C.fldId /*AND fldOrganId=@OrganId*/) 
			,ShomareHId as  fldShomareHesabId
			 ,CASE WHEN fldid IN (SELECT  s.fldId FROM     Drd.tblCodhayeDaramd AS s left JOIN
							  Drd.tblCodhayeDaramd AS p ON  s.fldDaramadId = p.fldDaramadId.GetAncestor(1)
							  WHERE p.fldDaramadId IS NULL AND s.fldId=c.fldid) THEN N'1' ELSE '0' END AS LastNode
			 FROM Drd.tblCodhayeDaramd AS C  inner join @temp as e on e.Daramadcode=c.fldDaramadCode
			 WHERE C.fldLevel<>0) t
			 where  LastNode=1 and Mablagh<>0 
			 order by fldtarikh
			 
			 IF(@ShomareHesabId=0 AND @CodeDaramadId<>0)
			select distinct * from(SELECT fldStrhid AS hidChilde,fldDaramadCode AS DaramdCodeChilde,fldDaramadTitle AS DaramadTitleChilde,fldLevel AS lvlChilde,
			ISNULL((SELECT d.fldStrhid FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_hid,
			ISNULL((SELECT fldDaramadCode FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_DaramadCode,
			ISNULL((SELECT fldDaramadTitle FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_DaramadTitle,
			ISNULL((SELECT fldLevel FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_Level
			--,ISNULL((SELECT SUM(mablaghcodeDaramad)over (partition by fldtarikh) FROM @temp WHERE Daramadcode=C.fldDaramadCode) ,ISNULL((SELECT SUM(mablaghcodeDaramad) FROM @temp AS t WHERE t.hid.ToString() LIKE c.fldStrhid+'%'),0)) AS Mablagh
			,sum(mablaghcodeDaramad) over (partition by fldtarikh,e.Daramadcode) as Mablagh
			,count(c)over (partition by fldtarikh,e.Daramadcode) as [Count],e.fldtarikh
			,(SELECT  TOP(1)  fldShomareHesab FROM        
								  Com.tblShomareHesabeOmoomi WHERE tblShomareHesabeOmoomi.fldid=ShomareHId /*AND fldOrganId=@OrganId*/) fldShomareHesab
			 --,(SELECT  TOP(1)  fldShomareHesadId FROM  Drd.tblShomareHesabCodeDaramad WHERE fldCodeDaramadId=C.fldId /*AND fldOrganId=@OrganId*/)
			  ,ShomareHId as fldShomareHesabId
			  ,CASE WHEN fldid IN (SELECT  s.fldId FROM     Drd.tblCodhayeDaramd AS s left JOIN
							  Drd.tblCodhayeDaramd AS p ON  s.fldDaramadId = p.fldDaramadId.GetAncestor(1)
							  WHERE p.fldDaramadId IS NULL AND s.fldId=c.fldid) THEN N'1' ELSE '0' END AS LastNode
			 FROM Drd.tblCodhayeDaramd AS C inner join @temp as e on e.Daramadcode=c.fldDaramadCode
			 WHERE C.fldLevel<>0   AND C.fldId IN (SELECT id FROM @code))t
			 where    LastNode=1 and Mablagh<>0
			  order by fldtarikh

			 IF(@ShomareHesabId<>0 AND @CodeDaramadId=0)
			SELECT DISTINCT * from(SELECT fldStrhid AS hidChilde,fldDaramadCode AS DaramdCodeChilde,fldDaramadTitle AS DaramadTitleChilde,fldLevel AS lvlChilde,
			ISNULL((SELECT d.fldStrhid FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_hid,
			ISNULL((SELECT fldDaramadCode FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_DaramadCode,
			ISNULL((SELECT fldDaramadTitle FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_DaramadTitle,
			ISNULL((SELECT fldLevel FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_Level
			--,ISNULL((SELECT SUM(mablaghcodeDaramad) FROM @temp WHERE Daramadcode=C.fldDaramadCode) ,ISNULL((SELECT SUM(mablaghcodeDaramad) FROM @temp AS t WHERE t.hid.ToString() LIKE c.fldStrhid+'%'),0)) AS Mablagh
			--,ISNULL((SELECT fldtarikh FROM @temp WHERE Daramadcode=C.fldDaramadCode group by fldtarikh),'') as fldtarikh
			,sum(mablaghcodeDaramad) over (partition by fldtarikh,e.Daramadcode) as Mablagh
			,count(c)over (partition by fldtarikh,e.Daramadcode) as [Count],e.fldtarikh
			,(SELECT  TOP(1)  fldShomareHesab FROM        
								  Com.tblShomareHesabeOmoomi WHERE tblShomareHesabeOmoomi.fldid=ShomareHId /*AND fldOrganId=@OrganId*/) fldShomareHesab
			 --,(SELECT  TOP(1)  fldShomareHesadId FROM  Drd.tblShomareHesabCodeDaramad WHERE fldCodeDaramadId=C.fldId /*AND fldOrganId=@OrganId*/) 
			 ,ShomareHId as fldShomareHesabId
			  ,CASE WHEN fldid IN (SELECT  s.fldId FROM     Drd.tblCodhayeDaramd AS s left JOIN
							  Drd.tblCodhayeDaramd AS p ON  s.fldDaramadId = p.fldDaramadId.GetAncestor(1)
							  WHERE p.fldDaramadId IS NULL AND s.fldId=c.fldid) THEN N'1' ELSE '0' END AS LastNode
			 FROM Drd.tblCodhayeDaramd AS C  inner join @temp as e on e.Daramadcode=c.fldDaramadCode
			 WHERE C.fldLevel<>0  and ShomareHId LIKE @ShomareHesabId)t
			  WHERE   LastNode=1 and Mablagh<>0
			   order by fldtarikh
			END
	ELSE
	BEGIN
				INSERT INTO @temp
				--( Daramadcode ,sharhecode , shomareHesab , mablaghcodeDaramad,fldtype,hid ,fldtarikh )

				SELECT        tblCodhayeDaramd_1.fldDaramadCode, Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad, Com.tblShomareHesabeOmoomi.fldShomareHesab, 
									   ISNULL(cast((Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifAsliValue * Drd.tblCodhayeDaramadiElamAvarez.fldTedad + Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifAvarezValue + Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifMaliyatValue)as bigint),
										  cast((Drd.tblCodhayeDaramadiElamAvarez.fldAsliValue * Drd.tblCodhayeDaramadiElamAvarez.fldTedad + Drd.tblCodhayeDaramadiElamAvarez.fldAvarezValue + Drd.tblCodhayeDaramadiElamAvarez.fldMaliyatValue)as bigint))
					AS fldmablaghCodeDaramad, '0' AS Expr1, tblCodhayeDaramd_1.fldDaramadId,tblPardakhtFish.fldTarikh,tblPardakhtFish.fldId,Drd.tblSodoorFish.fldShomareHesabId
				FROM            Drd.tblSodoorFish INNER JOIN
										 Drd.tblSodoorFish_Detail ON Drd.tblSodoorFish.fldId = Drd.tblSodoorFish_Detail.fldFishId INNER JOIN
										 Drd.tblCodhayeDaramadiElamAvarez ON Drd.tblSodoorFish_Detail.fldCodeElamAvarezId = Drd.tblCodhayeDaramadiElamAvarez.fldID INNER JOIN
										 Drd.tblShomareHesabCodeDaramad ON Drd.tblCodhayeDaramadiElamAvarez.fldShomareHesabCodeDaramadId = Drd.tblShomareHesabCodeDaramad.fldId AND 
										 Drd.tblCodhayeDaramadiElamAvarez.fldShomareHesabCodeDaramadId = Drd.tblShomareHesabCodeDaramad.fldId INNER JOIN
										 Drd.tblCodhayeDaramd AS tblCodhayeDaramd_1 ON Drd.tblShomareHesabCodeDaramad.fldCodeDaramadId = tblCodhayeDaramd_1.fldId INNER JOIN
										 Drd.tblPardakhtFish ON Drd.tblSodoorFish.fldId = Drd.tblPardakhtFish.fldFishId AND Drd.tblSodoorFish.fldId = Drd.tblPardakhtFish.fldFishId INNER JOIN
										 Com.tblShomareHesabeOmoomi ON Drd.tblSodoorFish.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId
				 WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId)
										 AND CAST( tblPardakhtFish.fldDatePardakht AS DATE) BETWEEN @StartDate AND @EndDate
								
								 
								 
				--GROUP BY tblCodhayeDaramd_1.fldDaramadCode, Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad,fldShomareHesab,fldDaramadId

				
				UNION all
				SELECT fldDaramadCode,fldSharheCodeDaramad,fldShomareHesab, (CAST((CAST(fldMablaghNaghdi AS BIGINT)*CAST(fldmablaghCodeDaramad AS bigint))AS BIGINT)/CAST(fldmablaghKoli AS bigint)),'1'
				,fldDaramadId,fldTarikh,fldId,fldShomareHesabId
				 FROM 
				(SELECT   DISTINCT    Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId, tblCodhayeDaramd_1.fldDaramadCode, 
										 Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad
										-- ,SUM(fldMablagh) OVER (PARTITION BY fldReplyTaghsitId,tblNaghdi_Talab.fldShomareHesabId) AS fldMablaghNaghdi
										,Drd.fn_SumMablaghNaghdi('Naghdi_Talab',fldReplyTaghsitId,tblNaghdi_Talab.fldShomareHesabId,'','') AS fldMablaghNaghdi
										,fldShomareHesab ,fldReplyTaghsitId
					,ISNULL(SUM(fldTakhfifAsliValue*fldTedad+fldTakhfifAvarezValue+fldTakhfifMaliyatValue),SUM(fldAsliValue*fldTedad+fldAvarezValue+fldMaliyatValue)) AS fldmablaghCodeDaramad
					,(SELECT TOP(1) ISNULL(SUM(fldTakhfifAsliValue*fldTedad+fldTakhfifAvarezValue+fldTakhfifMaliyatValue) OVER (PARTITION BY tblCodhayeDaramadiElamAvarez.fldElamAvarezId),SUM(fldAsliValue*fldTedad+fldAvarezValue+fldMaliyatValue) OVER (PARTITION BY tblCodhayeDaramadiElamAvarez.fldElamAvarezId)) FROM Drd.tblCodhayeDaramadiElamAvarez AS a WHERE a.fldElamAvarezId =Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId) AS fldmablaghKoli
				,tblCodhayeDaramd_1.fldDaramadId,tblPardakhtFish.fldTarikh,tblPardakhtFish.fldId,Drd.tblNaghdi_Talab.fldShomareHesabId
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
										
										 
										 GROUP BY tblRequestTaghsit_Takhfif.fldElamAvarezId,tblCodhayeDaramd_1.fldDaramadCode, 
										 Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad,fldMablagh,fldReplyTaghsitId, tblCodhayeDaramadiElamAvarez.fldElamAvarezId
										 ,tblNaghdi_Talab.fldShomareHesabId,fldShomareHesab,fldDaramadId,tblPardakhtFish.fldTarikh,tblPardakhtFish.fldId,Drd.tblNaghdi_Talab.fldShomareHesabId
									
										 )t


					
					------------------------------------------------------- وصول شده

				INSERT INTO @temp
				 
				SELECT  fldDaramadCode,fldSharheCodeDaramad,fldShomareHesab, (CAST((CAST(fldMablagh AS BIGINT)*CAST(fldmablaghCodeDaramad AS bigint))AS BIGINT)/CAST(fldmablaghKoli AS BIGINT)),'2',fldDaramadId,fldDateStatus,
				fldid,fldShomareHesabIdOrgan
				 FROM 
				(SELECT   DISTINCT    Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId, tblCodhayeDaramd_1.fldDaramadCode, 
										 Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad
										-- ,SUM(fldMablagh) OVER (PARTITION BY fldReplyTaghsitId,tblNaghdi_Talab.fldShomareHesabId) AS fldMablaghNaghdi
										,Drd.fn_SumMablaghNaghdi('Check',fldReplyTaghsitId,tblCheck.fldShomareHesabIdOrgan,@azTarikh ,@Tatarikh) AS fldMablagh
										,fldShomareHesab ,fldReplyTaghsitId
					,ISNULL(SUM(fldTakhfifAsliValue*fldTedad+fldTakhfifAvarezValue+fldTakhfifMaliyatValue),SUM(fldAsliValue*fldTedad+fldAvarezValue+fldMaliyatValue)) AS fldmablaghCodeDaramad
					,(SELECT TOP(1) ISNULL(SUM(fldTakhfifAsliValue*fldTedad+fldTakhfifAvarezValue+fldTakhfifMaliyatValue) OVER (PARTITION BY tblCodhayeDaramadiElamAvarez.fldElamAvarezId),SUM(fldAsliValue*fldTedad+fldAvarezValue+fldMaliyatValue) OVER (PARTITION BY tblCodhayeDaramadiElamAvarez.fldElamAvarezId)) FROM Drd.tblCodhayeDaramadiElamAvarez AS a WHERE a.fldElamAvarezId =Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId) AS fldmablaghKoli
				,tblCodhayeDaramd_1.fldDaramadId,fldDateStatus,tblcheck.fldid,tblCheck.fldShomareHesabIdOrgan
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
										 ,tblCheck.fldShomareHesabIdOrgan,fldShomareHesab,fldDaramadId,fldDateStatus,tblcheck.fldid,tblCheck.fldShomareHesabIdOrgan
										 )t


				INSERT INTO @temp
				       
										 SELECT  fldDaramadCode,fldSharheCodeDaramad,fldShomareHesab, (CAST((CAST(fldMablagh AS BIGINT)*CAST(fldmablaghCodeDaramad AS bigint))AS BIGINT)/CAST(fldmablaghKoli AS BIGINT)),'3',fldDaramadId,fldDateStatus,fldid ,fldShomareHesadId
										 FROM 
				(SELECT   DISTINCT    Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId, tblCodhayeDaramd_1.fldDaramadCode, 
										 Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad
										-- ,SUM(fldMablagh) OVER (PARTITION BY fldReplyTaghsitId,tblNaghdi_Talab.fldShomareHesabId) AS fldMablaghNaghdi
										,Drd.fn_SumMablaghNaghdi('Safte',fldReplyTaghsitId,tblShomareHesabCodeDaramad.fldShomareHesadId,@AzTarikh , @Tatarikh) AS fldMablagh
										,fldShomareHesab ,fldReplyTaghsitId
					,ISNULL(SUM(fldTakhfifAsliValue*fldTedad+fldTakhfifAvarezValue+fldTakhfifMaliyatValue),SUM(fldAsliValue*fldTedad+fldAvarezValue+fldMaliyatValue)) AS fldmablaghCodeDaramad
					,(SELECT TOP(1) ISNULL(SUM(fldTakhfifAsliValue*fldTedad+fldTakhfifAvarezValue+fldTakhfifMaliyatValue) OVER (PARTITION BY tblCodhayeDaramadiElamAvarez.fldElamAvarezId),SUM(fldAsliValue*fldTedad+fldAvarezValue+fldMaliyatValue) OVER (PARTITION BY tblCodhayeDaramadiElamAvarez.fldElamAvarezId)) FROM Drd.tblCodhayeDaramadiElamAvarez AS a WHERE a.fldElamAvarezId =Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId) AS fldmablaghKoli
				,tblCodhayeDaramd_1.fldDaramadId,fldDateStatus,tblSafte.fldid,tblShomareHesabCodeDaramad.fldShomareHesadId
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
										 ,tblShomareHesabCodeDaramad.fldShomareHesadId,fldShomareHesab,fldDaramadId,fldDateStatus,tblSafte.fldid,tblShomareHesabCodeDaramad.fldShomareHesadId
										 )t

				INSERT INTO @temp
				SELECT  fldDaramadCode,fldSharheCodeDaramad,fldShomareHesab, (CAST((CAST(fldMablagh AS BIGINT)*CAST(fldmablaghCodeDaramad AS bigint))AS BIGINT)/CAST(fldmablaghKoli AS BIGINT)),'4',fldDaramadId,fldDateStatus,fldid 
				,fldShomareHesadId 
				FROM 
				(SELECT   DISTINCT    Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId, tblCodhayeDaramd_1.fldDaramadCode, 
										 Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad
										-- ,SUM(fldMablagh) OVER (PARTITION BY fldReplyTaghsitId,tblNaghdi_Talab.fldShomareHesabId) AS fldMablaghNaghdi
										,Drd.fn_SumMablaghNaghdi('Barat',fldReplyTaghsitId,tblShomareHesabCodeDaramad.fldShomareHesadId,@AzTarikh,@TaTarikh) AS fldMablagh
										,fldShomareHesab ,fldReplyTaghsitId
					,ISNULL(SUM(fldTakhfifAsliValue*fldTedad+fldTakhfifAvarezValue+fldTakhfifMaliyatValue),SUM(fldAsliValue*fldTedad+fldAvarezValue+fldMaliyatValue)) AS fldmablaghCodeDaramad
					,(SELECT TOP(1) ISNULL(SUM(fldTakhfifAsliValue*fldTedad+fldTakhfifAvarezValue+fldTakhfifMaliyatValue) OVER (PARTITION BY tblCodhayeDaramadiElamAvarez.fldElamAvarezId),SUM(fldAsliValue*fldTedad+fldAvarezValue+fldMaliyatValue) OVER (PARTITION BY tblCodhayeDaramadiElamAvarez.fldElamAvarezId)) FROM Drd.tblCodhayeDaramadiElamAvarez AS a WHERE a.fldElamAvarezId =Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId) AS fldmablaghKoli
				,tblCodhayeDaramd_1.fldDaramadId,fldDateStatus,tblbarat.fldid,tblShomareHesabCodeDaramad.fldShomareHesadId
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
										 ,tblShomareHesabCodeDaramad.fldShomareHesadId,fldShomareHesab,fldDaramadId,fldDateStatus,tblbarat.fldid,tblShomareHesabCodeDaramad.fldShomareHesadId
										 )t

										 --select * from @temp where  daramadcode='402005/08' order by fldtarikh


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
				SELECT DISTINCT * FROM (
				SELECT  fldStrhid AS hidChilde,fldDaramadCode AS DaramdCodeChilde,fldDaramadTitle AS DaramadTitleChilde,fldLevel AS lvlChilde,
				ISNULL((SELECT d.fldStrhid FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_hid,
				ISNULL((SELECT fldDaramadCode FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_DaramadCode,
				ISNULL((SELECT fldDaramadTitle FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_DaramadTitle,
				ISNULL((SELECT fldLevel FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_Level
				--,ISNULL((SELECT SUM(mablaghcodeDaramad) FROM @temp WHERE Daramadcode=C.fldDaramadCode) ,ISNULL((SELECT SUM(mablaghcodeDaramad) FROM @temp AS t WHERE t.hid.ToString() LIKE c.fldStrhid+'%'),0)) AS Mablagh
				,sum(mablaghcodeDaramad) over (partition by fldtarikh,e.Daramadcode) as Mablagh
				,count(c)over (partition by fldtarikh,e.Daramadcode) as [Count],e.fldtarikh
				--,ISNULL((SELECT fldtarikh FROM @temp WHERE Daramadcode=C.fldDaramadCode group by fldtarikh),'') as fldtarikh
				,(SELECT  TOP(1)  fldShomareHesab FROM   
									  Com.tblShomareHesabeOmoomi  WHERE tblShomareHesabeOmoomi.fldid=e.ShomareHId /*AND fldOrganId=@OrganId*/) fldShomareHesab
				 --,(SELECT  TOP(1)  fldShomareHesadId FROM  Drd.tblShomareHesabCodeDaramad WHERE fldCodeDaramadId=C.fldId /*AND fldOrganId=@OrganId*/)
				 ,@ShomareHesabId as  fldShomareHesabId
				 ,CASE WHEN fldid IN (SELECT  s.fldId FROM     Drd.tblCodhayeDaramd AS s left JOIN
								  Drd.tblCodhayeDaramd AS p ON  s.fldDaramadId = p.fldDaramadId.GetAncestor(1)
								  WHERE p.fldDaramadId IS NULL AND s.fldId=c.fldid) THEN N'1' ELSE '0' END AS LastNode
				 FROM Drd.tblCodhayeDaramd AS C  inner join @temp as e on e.Daramadcode=c.fldDaramadCode
				 WHERE C.fldLevel<>0 and ShomareHId=@ShomareHesabId  AND C.fldId IN (SELECT id FROM @code))s
				 WHERE     LastNode=1 and Mablagh<>0
				 order by fldtarikh
				 

				 IF(@ShomareHesabId=0 AND @CodeDaramadId=0)
				 
				 SELECT DISTINCT * from (SELECT fldStrhid AS hidChilde,fldDaramadCode AS DaramdCodeChilde,fldDaramadTitle AS DaramadTitleChilde,fldLevel AS lvlChilde,
				ISNULL((SELECT d.fldStrhid FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_hid,
				ISNULL((SELECT fldDaramadCode FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_DaramadCode,
				ISNULL((SELECT fldDaramadTitle FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_DaramadTitle,
				ISNULL((SELECT fldLevel FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_Level
				--,ISNULL((SELECT SUM(mablaghcodeDaramad) FROM @temp WHERE Daramadcode=C.fldDaramadCode) ,ISNULL((SELECT SUM(mablaghcodeDaramad) FROM @temp AS t WHERE t.hid.ToString() LIKE c.fldStrhid+'%'),0)) AS Mablagh
				--,ISNULL((SELECT top(1) fldtarikh FROM @temp WHERE Daramadcode=C.fldDaramadCode group by fldtarikh),'') as fldtarikh
				--,ISNULL((SELECT top(1)  count(c) FROM @temp WHERE Daramadcode=C.fldDaramadCode group by fldtarikh,Daramadcode),'') as c
				,sum(mablaghcodeDaramad) over (partition by fldtarikh,e.Daramadcode) as Mablagh
				,count(c)over (partition by fldtarikh,e.Daramadcode) as [Count],e.fldtarikh
				,(SELECT  TOP(1)  fldShomareHesab FROM   
									  Com.tblShomareHesabeOmoomi  WHERE tblShomareHesabeOmoomi.fldid=e.ShomareHId /*AND fldOrganId=@OrganId*/) fldShomareHesab
				 --,(SELECT  TOP(1)  fldShomareHesadId FROM  Drd.tblShomareHesabCodeDaramad WHERE fldCodeDaramadId=C.fldId /*AND fldOrganId=@OrganId*/)
				 ,ShomareHId as  fldShomareHesabId				
				  ,CASE WHEN fldid IN (SELECT  s.fldId FROM     Drd.tblCodhayeDaramd AS s left JOIN
								  Drd.tblCodhayeDaramd AS p ON  s.fldDaramadId = p.fldDaramadId.GetAncestor(1)
								  WHERE p.fldDaramadId IS NULL AND s.fldId=c.fldid) THEN N'1' ELSE '0' END AS LastNode
				 FROM Drd.tblCodhayeDaramd AS C  inner join @temp as e on e.Daramadcode=c.fldDaramadCode
				 WHERE C.fldLevel<>0) t
				 where  LastNode=1 and Mablagh<>0 
				 order by fldtarikh
				 
				 IF(@ShomareHesabId=0 AND @CodeDaramadId<>0)
				select distinct * from(SELECT fldStrhid AS hidChilde,fldDaramadCode AS DaramdCodeChilde,fldDaramadTitle AS DaramadTitleChilde,fldLevel AS lvlChilde,
				ISNULL((SELECT d.fldStrhid FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_hid,
				ISNULL((SELECT fldDaramadCode FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_DaramadCode,
				ISNULL((SELECT fldDaramadTitle FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_DaramadTitle,
				ISNULL((SELECT fldLevel FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_Level
				--,ISNULL((SELECT SUM(mablaghcodeDaramad)over (partition by fldtarikh) FROM @temp WHERE Daramadcode=C.fldDaramadCode) ,ISNULL((SELECT SUM(mablaghcodeDaramad) FROM @temp AS t WHERE t.hid.ToString() LIKE c.fldStrhid+'%'),0)) AS Mablagh
				,sum(mablaghcodeDaramad) over (partition by fldtarikh,e.Daramadcode) as Mablagh
				,count(c)over (partition by fldtarikh,e.Daramadcode) as [Count],e.fldtarikh
				,(SELECT  TOP(1)  fldShomareHesab FROM   
									  Com.tblShomareHesabeOmoomi  WHERE tblShomareHesabeOmoomi.fldid=e.ShomareHId /*AND fldOrganId=@OrganId*/) fldShomareHesab
				 --,(SELECT  TOP(1)  fldShomareHesadId FROM  Drd.tblShomareHesabCodeDaramad WHERE fldCodeDaramadId=C.fldId /*AND fldOrganId=@OrganId*/)
				 ,ShomareHId as  fldShomareHesabId				
				  ,CASE WHEN fldid IN (SELECT  s.fldId FROM     Drd.tblCodhayeDaramd AS s left JOIN
								  Drd.tblCodhayeDaramd AS p ON  s.fldDaramadId = p.fldDaramadId.GetAncestor(1)
								  WHERE p.fldDaramadId IS NULL AND s.fldId=c.fldid) THEN N'1' ELSE '0' END AS LastNode
				 FROM Drd.tblCodhayeDaramd AS C inner join @temp as e on e.Daramadcode=c.fldDaramadCode
				 WHERE C.fldLevel<>0   AND C.fldId IN (SELECT id FROM @code))t
				 where    LastNode=1 and Mablagh<>0
				  order by fldtarikh

				 IF(@ShomareHesabId<>0 AND @CodeDaramadId=0)
				SELECT DISTINCT * from(SELECT fldStrhid AS hidChilde,fldDaramadCode AS DaramdCodeChilde,fldDaramadTitle AS DaramadTitleChilde,fldLevel AS lvlChilde,
				ISNULL((SELECT d.fldStrhid FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_hid,
				ISNULL((SELECT fldDaramadCode FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_DaramadCode,
				ISNULL((SELECT fldDaramadTitle FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_DaramadTitle,
				ISNULL((SELECT fldLevel FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_Level
				--,ISNULL((SELECT SUM(mablaghcodeDaramad) FROM @temp WHERE Daramadcode=C.fldDaramadCode) ,ISNULL((SELECT SUM(mablaghcodeDaramad) FROM @temp AS t WHERE t.hid.ToString() LIKE c.fldStrhid+'%'),0)) AS Mablagh
				--,ISNULL((SELECT fldtarikh FROM @temp WHERE Daramadcode=C.fldDaramadCode group by fldtarikh),'') as fldtarikh
				,sum(mablaghcodeDaramad) over (partition by fldtarikh,e.Daramadcode) as Mablagh
				,count(c)over (partition by fldtarikh,e.Daramadcode) as [Count],e.fldtarikh
				,(SELECT  TOP(1)  fldShomareHesab FROM   
									  Com.tblShomareHesabeOmoomi  WHERE tblShomareHesabeOmoomi.fldid=e.ShomareHId /*AND fldOrganId=@OrganId*/) fldShomareHesab
				 --,(SELECT  TOP(1)  fldShomareHesadId FROM  Drd.tblShomareHesabCodeDaramad WHERE fldCodeDaramadId=C.fldId /*AND fldOrganId=@OrganId*/)
				 ,@ShomareHesabId as  fldShomareHesabId				
				  ,CASE WHEN fldid IN (SELECT  s.fldId FROM     Drd.tblCodhayeDaramd AS s left JOIN
								  Drd.tblCodhayeDaramd AS p ON  s.fldDaramadId = p.fldDaramadId.GetAncestor(1)
								  WHERE p.fldDaramadId IS NULL AND s.fldId=c.fldid) THEN N'1' ELSE '0' END AS LastNode
				 FROM Drd.tblCodhayeDaramd AS C  inner join @temp as e on e.Daramadcode=c.fldDaramadCode
				 WHERE C.fldLevel<>0 and ShomareHId  LIKE @ShomareHesabId  )t
				  WHERE     LastNode=1 and Mablagh<>0
				   order by fldtarikh
	end
END

IF(@fieldname='All')
BEGIN
		IF(@OrganId<>0)
		BEGIN
			INSERT INTO @temp
			SELECT        tblCodhayeDaramd_1.fldDaramadCode, Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad, Com.tblShomareHesabeOmoomi.fldShomareHesab, 
								   ISNULL(cast((Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifAsliValue * Drd.tblCodhayeDaramadiElamAvarez.fldTedad + Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifAvarezValue + Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifMaliyatValue)as bigint),
									  cast((Drd.tblCodhayeDaramadiElamAvarez.fldAsliValue * Drd.tblCodhayeDaramadiElamAvarez.fldTedad + Drd.tblCodhayeDaramadiElamAvarez.fldAvarezValue + Drd.tblCodhayeDaramadiElamAvarez.fldMaliyatValue)as bigint))
				AS fldmablaghCodeDaramad, '0' AS Expr1, tblCodhayeDaramd_1.fldDaramadId,'',0,Drd.tblSodoorFish.fldShomareHesabId 
			FROM            Drd.tblSodoorFish INNER JOIN
								 Drd.tblSodoorFish_Detail ON Drd.tblSodoorFish.fldId = Drd.tblSodoorFish_Detail.fldFishId INNER JOIN
								 Drd.tblCodhayeDaramadiElamAvarez ON Drd.tblSodoorFish_Detail.fldCodeElamAvarezId = Drd.tblCodhayeDaramadiElamAvarez.fldID INNER JOIN
								 Drd.tblShomareHesabCodeDaramad ON Drd.tblCodhayeDaramadiElamAvarez.fldShomareHesabCodeDaramadId = Drd.tblShomareHesabCodeDaramad.fldId AND 
								 Drd.tblCodhayeDaramadiElamAvarez.fldShomareHesabCodeDaramadId = Drd.tblShomareHesabCodeDaramad.fldId INNER JOIN
								 Drd.tblCodhayeDaramd AS tblCodhayeDaramd_1 ON Drd.tblShomareHesabCodeDaramad.fldCodeDaramadId = tblCodhayeDaramd_1.fldId INNER JOIN
								 Drd.tblPardakhtFish ON Drd.tblSodoorFish.fldId = Drd.tblPardakhtFish.fldFishId AND Drd.tblSodoorFish.fldId = Drd.tblPardakhtFish.fldFishId INNER JOIN
								 Com.tblShomareHesabeOmoomi ON Drd.tblSodoorFish.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId
			WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId)
								 AND CAST( tblPardakhtFish.fldDatePardakht AS DATE) BETWEEN @StartDate AND @EndDate
								 AND tblShomareHesabCodeDaramad.fldOrganId=@OrganId
								 
				--GROUP BY tblCodhayeDaramd_1.fldDaramadCode, Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad,fldShomareHesab,fldDaramadId

				
		union all
		SELECT fldDaramadCode,fldSharheCodeDaramad,fldShomareHesab, (CAST((CAST(fldMablaghNaghdi AS BIGINT)*CAST(fldmablaghCodeDaramad AS bigint))AS BIGINT)/CAST(fldmablaghKoli AS bigint)),'1'
		,fldDaramadId,'',0,fldShomareHesabId
		 FROM 
		(SELECT   DISTINCT    Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId, tblCodhayeDaramd_1.fldDaramadCode, 
								 Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad
								-- ,SUM(fldMablagh) OVER (PARTITION BY fldReplyTaghsitId,tblNaghdi_Talab.fldShomareHesabId) AS fldMablaghNaghdi
								,Drd.fn_SumMablaghNaghdi('Naghdi_Talab',fldReplyTaghsitId,tblNaghdi_Talab.fldShomareHesabId,'','') AS fldMablaghNaghdi
								,fldShomareHesab ,fldReplyTaghsitId
			,ISNULL(SUM(fldTakhfifAsliValue*fldTedad+fldTakhfifAvarezValue+fldTakhfifMaliyatValue),SUM(fldAsliValue*fldTedad+fldAvarezValue+fldMaliyatValue)) AS fldmablaghCodeDaramad
			,(SELECT TOP(1) ISNULL(SUM(fldTakhfifAsliValue*fldTedad+fldTakhfifAvarezValue+fldTakhfifMaliyatValue) OVER (PARTITION BY tblCodhayeDaramadiElamAvarez.fldElamAvarezId),SUM(fldAsliValue*fldTedad+fldAvarezValue+fldMaliyatValue) OVER (PARTITION BY tblCodhayeDaramadiElamAvarez.fldElamAvarezId)) FROM Drd.tblCodhayeDaramadiElamAvarez AS a WHERE a.fldElamAvarezId =Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId) AS fldmablaghKoli
		,tblCodhayeDaramd_1.fldDaramadId,Drd.tblNaghdi_Talab.fldShomareHesabId 
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
								 GROUP BY tblRequestTaghsit_Takhfif.fldElamAvarezId,tblCodhayeDaramd_1.fldDaramadCode, 
								 Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad,fldMablagh,fldReplyTaghsitId, tblCodhayeDaramadiElamAvarez.fldElamAvarezId
								 ,tblNaghdi_Talab.fldShomareHesabId,fldShomareHesab,fldDaramadId,Drd.tblNaghdi_Talab.fldShomareHesabId 
								
								 )t



		------------------------------------------------------- وصول شده

		INSERT INTO @temp
		 
		SELECT  fldDaramadCode,fldSharheCodeDaramad,fldShomareHesab, (CAST((CAST(fldMablagh AS BIGINT)*CAST(fldmablaghCodeDaramad AS bigint))AS BIGINT)/CAST(fldmablaghKoli AS BIGINT)),'2',fldDaramadId
		,'',0,fldShomareHesabIdOrgan FROM 
		(SELECT   DISTINCT    Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId, tblCodhayeDaramd_1.fldDaramadCode, 
								 Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad
								-- ,SUM(fldMablagh) OVER (PARTITION BY fldReplyTaghsitId,tblNaghdi_Talab.fldShomareHesabId) AS fldMablaghNaghdi
								,Drd.fn_SumMablaghNaghdi('Check',fldReplyTaghsitId,tblCheck.fldShomareHesabIdOrgan,@azTarikh ,@Tatarikh) AS fldMablagh
								,fldShomareHesab ,fldReplyTaghsitId
			,ISNULL(SUM(fldTakhfifAsliValue*fldTedad+fldTakhfifAvarezValue+fldTakhfifMaliyatValue),SUM(fldAsliValue*fldTedad+fldAvarezValue+fldMaliyatValue)) AS fldmablaghCodeDaramad
			,(SELECT TOP(1) ISNULL(SUM(fldTakhfifAsliValue*fldTedad+fldTakhfifAvarezValue+fldTakhfifMaliyatValue) OVER (PARTITION BY tblCodhayeDaramadiElamAvarez.fldElamAvarezId),SUM(fldAsliValue*fldTedad+fldAvarezValue+fldMaliyatValue) OVER (PARTITION BY tblCodhayeDaramadiElamAvarez.fldElamAvarezId)) FROM Drd.tblCodhayeDaramadiElamAvarez AS a WHERE a.fldElamAvarezId =Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId) AS fldmablaghKoli
		,tblCodhayeDaramd_1.fldDaramadId,tblCheck.fldShomareHesabIdOrgan
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
								AND tblCheck.fldStatus=2 AND fldTypeSanad=0 AND tblShomareHesabCodeDaramad.fldOrganId=@OrganId
								AND (Drd.tblCheck.fldDateStatus ) BETWEEN @AzTarikh AND @TaTarikh
								 GROUP BY tblRequestTaghsit_Takhfif.fldElamAvarezId,tblCodhayeDaramd_1.fldDaramadCode, 
								 Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad,fldMablaghSanad,fldReplyTaghsitId, tblCodhayeDaramadiElamAvarez.fldElamAvarezId
								 ,tblCheck.fldShomareHesabIdOrgan,fldShomareHesab,fldDaramadId,tblCheck.fldShomareHesabIdOrgan
								 )t


				INSERT INTO @temp
								 SELECT  fldDaramadCode,fldSharheCodeDaramad,fldShomareHesab, (CAST((CAST(fldMablagh AS BIGINT)*CAST(fldmablaghCodeDaramad AS bigint))AS BIGINT)/CAST(fldmablaghKoli AS BIGINT)),'3',fldDaramadId 
								 ,'',0,fldShomareHesadId FROM 
				(SELECT   DISTINCT    Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId, tblCodhayeDaramd_1.fldDaramadCode, 
								 Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad
								-- ,SUM(fldMablagh) OVER (PARTITION BY fldReplyTaghsitId,tblNaghdi_Talab.fldShomareHesabId) AS fldMablaghNaghdi
								,Drd.fn_SumMablaghNaghdi('Safte',fldReplyTaghsitId,tblShomareHesabCodeDaramad.fldShomareHesadId,@AzTarikh , @Tatarikh) AS fldMablagh
								,fldShomareHesab ,fldReplyTaghsitId
					,ISNULL(SUM(fldTakhfifAsliValue*fldTedad+fldTakhfifAvarezValue+fldTakhfifMaliyatValue),SUM(fldAsliValue*fldTedad+fldAvarezValue+fldMaliyatValue)) AS fldmablaghCodeDaramad
					,(SELECT TOP(1) ISNULL(SUM(fldTakhfifAsliValue*fldTedad+fldTakhfifAvarezValue+fldTakhfifMaliyatValue) OVER (PARTITION BY tblCodhayeDaramadiElamAvarez.fldElamAvarezId),SUM(fldAsliValue*fldTedad+fldAvarezValue+fldMaliyatValue) OVER (PARTITION BY tblCodhayeDaramadiElamAvarez.fldElamAvarezId)) FROM Drd.tblCodhayeDaramadiElamAvarez AS a WHERE a.fldElamAvarezId =Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId) AS fldmablaghKoli
				,tblCodhayeDaramd_1.fldDaramadId, tblShomareHesabCodeDaramad.fldShomareHesadId
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
								AND tblSafte.fldStatus=2 AND tblShomareHesabCodeDaramad.fldOrganId=@OrganId
								AND (Drd.tblSafte.fldDateStatus ) BETWEEN @AzTarikh AND @TaTarikh
								--AND CAST(Drd.tblSafte.fldDate AS  DATE) BETWEEN @StartDate AND @EndDate
								 GROUP BY tblRequestTaghsit_Takhfif.fldElamAvarezId,tblCodhayeDaramd_1.fldDaramadCode, 
								 Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad,fldMablaghSanad,fldReplyTaghsitId, tblCodhayeDaramadiElamAvarez.fldElamAvarezId
								 ,tblShomareHesabCodeDaramad.fldShomareHesadId,fldShomareHesab,fldDaramadId, tblShomareHesabCodeDaramad.fldShomareHesadId
								 )t

							INSERT INTO @temp
							SELECT  fldDaramadCode,fldSharheCodeDaramad,fldShomareHesab, (CAST((CAST(fldMablagh AS BIGINT)*CAST(fldmablaghCodeDaramad AS bigint))AS BIGINT)/CAST(fldmablaghKoli AS BIGINT)),'4',fldDaramadId 
							,'',0,fldShomareHesadId
							FROM 
							(SELECT   DISTINCT    Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId, tblCodhayeDaramd_1.fldDaramadCode, 
													 Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad
													-- ,SUM(fldMablagh) OVER (PARTITION BY fldReplyTaghsitId,tblNaghdi_Talab.fldShomareHesabId) AS fldMablaghNaghdi
													,Drd.fn_SumMablaghNaghdi('Barat',fldReplyTaghsitId,tblShomareHesabCodeDaramad.fldShomareHesadId,@AzTarikh,@TaTarikh) AS fldMablagh
													,fldShomareHesab ,fldReplyTaghsitId
								,ISNULL(SUM(fldTakhfifAsliValue*fldTedad+fldTakhfifAvarezValue+fldTakhfifMaliyatValue),SUM(fldAsliValue*fldTedad+fldAvarezValue+fldMaliyatValue)) AS fldmablaghCodeDaramad
								,(SELECT TOP(1) ISNULL(SUM(fldTakhfifAsliValue*fldTedad+fldTakhfifAvarezValue+fldTakhfifMaliyatValue) OVER (PARTITION BY tblCodhayeDaramadiElamAvarez.fldElamAvarezId),SUM(fldAsliValue*fldTedad+fldAvarezValue+fldMaliyatValue) OVER (PARTITION BY tblCodhayeDaramadiElamAvarez.fldElamAvarezId)) FROM Drd.tblCodhayeDaramadiElamAvarez AS a WHERE a.fldElamAvarezId =Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId) AS fldmablaghKoli
							,tblCodhayeDaramd_1.fldDaramadId,tblShomareHesabCodeDaramad.fldShomareHesadId
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
								AND tblBarat.fldStatus=2 AND tblShomareHesabCodeDaramad.fldOrganId=@OrganId
								AND (Drd.tblBarat.fldDateStatus ) BETWEEN @AzTarikh AND @TaTarikh
								--AND CAST(Drd.tblBarat.fldDate AS  DATE) BETWEEN @StartDate AND @EndDate
								 GROUP BY tblRequestTaghsit_Takhfif.fldElamAvarezId,tblCodhayeDaramd_1.fldDaramadCode, 
								 Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad,fldMablaghSanad,fldReplyTaghsitId, tblCodhayeDaramadiElamAvarez.fldElamAvarezId
								 ,tblShomareHesabCodeDaramad.fldShomareHesadId,fldShomareHesab,fldDaramadId,tblShomareHesabCodeDaramad.fldShomareHesadId
								 )t


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
				SELECT distinct * FROM (
				SELECT fldStrhid AS hidChilde,fldDaramadCode AS DaramdCodeChilde,fldDaramadTitle AS DaramadTitleChilde,fldLevel AS lvlChilde,
				ISNULL((SELECT d.fldStrhid FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_hid,
				ISNULL((SELECT fldDaramadCode FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_DaramadCode,
				ISNULL((SELECT fldDaramadTitle FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_DaramadTitle,
				ISNULL((SELECT fldLevel FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_Level
				,sum(mablaghcodeDaramad) over (partition by tem.Daramadcode,tem.ShomareHId)/*ISNULL((SELECT SUM(mablaghcodeDaramad) FROM @temp WHERE Daramadcode=C.fldDaramadCode) ,ISNULL((SELECT SUM(mablaghcodeDaramad) FROM @temp AS t WHERE t.hid.ToString() LIKE c.fldStrhid+'%'),0))*/ AS Mablagh

				,0 AS [Count],'' fldtarikh
				,(SELECT  TOP(1)  fldShomareHesab FROM      
									  Com.tblShomareHesabeOmoomi WHERE tblShomareHesabeOmoomi.fldid=ShomareHId ) fldShomareHesab
				 , ShomareHId fldShomareHesabId
				 ,CASE WHEN fldid IN (SELECT  s.fldId FROM     Drd.tblCodhayeDaramd AS s left JOIN
								  Drd.tblCodhayeDaramd AS p ON  s.fldDaramadId = p.fldDaramadId.GetAncestor(1)
								  WHERE p.fldDaramadId IS NULL AND s.fldId=c.fldid) THEN N'1' ELSE '0' END AS LastNode
				 FROM Drd.tblCodhayeDaramd AS C inner join @temp  as tem
				 on tem.Daramadcode=c.fldDaramadCode
				 WHERE C.fldLevel<>0 and ShomareHId LIKE @ShomareHesabId  AND C.fldId IN (SELECT id FROM @code))s
				 WHERE    LastNode=1 and Mablagh<>0
				 

				 IF(@ShomareHesabId=0 AND @CodeDaramadId=0)
				 
				 select distinct * from (SELECT fldStrhid AS hidChilde,fldDaramadCode AS DaramdCodeChilde,fldDaramadTitle AS DaramadTitleChilde,fldLevel AS lvlChilde,
				ISNULL((SELECT d.fldStrhid FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_hid,
				ISNULL((SELECT fldDaramadCode FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_DaramadCode,
				ISNULL((SELECT fldDaramadTitle FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_DaramadTitle,
				ISNULL((SELECT fldLevel FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_Level
				,sum(mablaghcodeDaramad) over (partition by tem.Daramadcode,tem.ShomareHId)/*ISNULL((SELECT SUM(mablaghcodeDaramad) FROM @temp WHERE Daramadcode=C.fldDaramadCode) ,ISNULL((SELECT SUM(mablaghcodeDaramad) FROM @temp AS t WHERE t.hid.ToString() LIKE c.fldStrhid+'%'),0))*/ AS Mablagh
				,0 AS [Count],'' fldtarikh
				,(SELECT  TOP(1)  fldShomareHesab FROM      
									  Com.tblShomareHesabeOmoomi WHERE tblShomareHesabeOmoomi.fldid=ShomareHId ) fldShomareHesab
				 , ShomareHId fldShomareHesabId
				 				 ,CASE WHEN fldid IN (SELECT  s.fldId FROM     Drd.tblCodhayeDaramd AS s left JOIN
								  Drd.tblCodhayeDaramd AS p ON  s.fldDaramadId = p.fldDaramadId.GetAncestor(1)
								  WHERE p.fldDaramadId IS NULL AND s.fldId=c.fldid) THEN N'1' ELSE '0' END AS LastNode
				 FROM Drd.tblCodhayeDaramd AS C inner join @temp  as tem
				 on tem.Daramadcode=c.fldDaramadCode
				 WHERE C.fldLevel<>0) t
				 where  LastNode=1 and Mablagh<>0 
				 
				 IF(@ShomareHesabId=0 AND @CodeDaramadId<>0)
				select distinct * from(SELECT fldStrhid AS hidChilde,fldDaramadCode AS DaramdCodeChilde,fldDaramadTitle AS DaramadTitleChilde,fldLevel AS lvlChilde,
				ISNULL((SELECT d.fldStrhid FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_hid,
				ISNULL((SELECT fldDaramadCode FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_DaramadCode,
				ISNULL((SELECT fldDaramadTitle FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_DaramadTitle,
				ISNULL((SELECT fldLevel FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_Level
				,sum(mablaghcodeDaramad) over (partition by tem.Daramadcode,tem.ShomareHId)/*ISNULL((SELECT SUM(mablaghcodeDaramad) FROM @temp WHERE Daramadcode=C.fldDaramadCode) ,ISNULL((SELECT SUM(mablaghcodeDaramad) FROM @temp AS t WHERE t.hid.ToString() LIKE c.fldStrhid+'%'),0))*/ AS Mablagh
				,0 AS [Count],'' fldtarikh
				,(SELECT  TOP(1)  fldShomareHesab FROM      
									  Com.tblShomareHesabeOmoomi WHERE tblShomareHesabeOmoomi.fldid=ShomareHId ) fldShomareHesab
				 , ShomareHId fldShomareHesabId				  ,CASE WHEN fldid IN (SELECT  s.fldId FROM     Drd.tblCodhayeDaramd AS s left JOIN
								  Drd.tblCodhayeDaramd AS p ON  s.fldDaramadId = p.fldDaramadId.GetAncestor(1)
								  WHERE p.fldDaramadId IS NULL AND s.fldId=c.fldid) THEN N'1' ELSE '0' END AS LastNode
				 FROM Drd.tblCodhayeDaramd AS C inner join @temp  as tem
				 on tem.Daramadcode=c.fldDaramadCode
				 WHERE C.fldLevel<>0   AND C.fldId IN (SELECT id FROM @code))t
				 where    LastNode=1 and Mablagh<>0

				
				 IF(@ShomareHesabId<>0 AND @CodeDaramadId=0)
				SELECT distinct * from(SELECT fldStrhid AS hidChilde,fldDaramadCode AS DaramdCodeChilde,fldDaramadTitle AS DaramadTitleChilde,fldLevel AS lvlChilde,
				ISNULL((SELECT d.fldStrhid FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_hid,
				ISNULL((SELECT fldDaramadCode FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_DaramadCode,
				ISNULL((SELECT fldDaramadTitle FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_DaramadTitle,
				ISNULL((SELECT fldLevel FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_Level
				,sum(mablaghcodeDaramad) over (partition by tem.Daramadcode,tem.ShomareHId)/*ISNULL((SELECT SUM(mablaghcodeDaramad) FROM @temp WHERE Daramadcode=C.fldDaramadCode) ,ISNULL((SELECT SUM(mablaghcodeDaramad) FROM @temp AS t WHERE t.hid.ToString() LIKE c.fldStrhid+'%'),0))*/ AS Mablagh
				,0 AS [Count],'' fldtarikh
				,(SELECT  TOP(1)  fldShomareHesab FROM      
									  Com.tblShomareHesabeOmoomi WHERE tblShomareHesabeOmoomi.fldid=ShomareHId ) fldShomareHesab
				 , ShomareHId fldShomareHesabId				  ,CASE WHEN fldid IN (SELECT  s.fldId FROM     Drd.tblCodhayeDaramd AS s left JOIN
								  Drd.tblCodhayeDaramd AS p ON  s.fldDaramadId = p.fldDaramadId.GetAncestor(1)
								  WHERE p.fldDaramadId IS NULL AND s.fldId=c.fldid) THEN N'1' ELSE '0' END AS LastNode
				 FROM Drd.tblCodhayeDaramd AS C inner join @temp  as tem
				 on tem.Daramadcode=c.fldDaramadCode
				 WHERE C.fldLevel<>0 and ShomareHId  LIKE @ShomareHesabId )t
				  WHERE   LastNode=1 and Mablagh<>0
				  END
	ELSE
		BEGIN
				INSERT INTO @temp
			

			SELECT        tblCodhayeDaramd_1.fldDaramadCode, Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad, Com.tblShomareHesabeOmoomi.fldShomareHesab, 
								   ISNULL(cast((Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifAsliValue * Drd.tblCodhayeDaramadiElamAvarez.fldTedad + Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifAvarezValue + Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifMaliyatValue)as bigint),
								  cast((Drd.tblCodhayeDaramadiElamAvarez.fldAsliValue * Drd.tblCodhayeDaramadiElamAvarez.fldTedad + Drd.tblCodhayeDaramadiElamAvarez.fldAvarezValue + Drd.tblCodhayeDaramadiElamAvarez.fldMaliyatValue)as bigint))
			AS fldmablaghCodeDaramad, '0' AS Expr1, tblCodhayeDaramd_1.fldDaramadId,'',0,Drd.tblSodoorFish.fldShomareHesabId 
			FROM            Drd.tblSodoorFish INNER JOIN
								 Drd.tblSodoorFish_Detail ON Drd.tblSodoorFish.fldId = Drd.tblSodoorFish_Detail.fldFishId INNER JOIN
								 Drd.tblCodhayeDaramadiElamAvarez ON Drd.tblSodoorFish_Detail.fldCodeElamAvarezId = Drd.tblCodhayeDaramadiElamAvarez.fldID INNER JOIN
								 Drd.tblShomareHesabCodeDaramad ON Drd.tblCodhayeDaramadiElamAvarez.fldShomareHesabCodeDaramadId = Drd.tblShomareHesabCodeDaramad.fldId AND 
								 Drd.tblCodhayeDaramadiElamAvarez.fldShomareHesabCodeDaramadId = Drd.tblShomareHesabCodeDaramad.fldId INNER JOIN
								 Drd.tblCodhayeDaramd AS tblCodhayeDaramd_1 ON Drd.tblShomareHesabCodeDaramad.fldCodeDaramadId = tblCodhayeDaramd_1.fldId INNER JOIN
								 Drd.tblPardakhtFish ON Drd.tblSodoorFish.fldId = Drd.tblPardakhtFish.fldFishId AND Drd.tblSodoorFish.fldId = Drd.tblPardakhtFish.fldFishId INNER JOIN
								 Com.tblShomareHesabeOmoomi ON Drd.tblSodoorFish.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId
		 WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId)
								 AND CAST( tblPardakhtFish.fldDatePardakht AS DATE) BETWEEN @StartDate AND @EndDate
								 
				--GROUP BY tblCodhayeDaramd_1.fldDaramadCode, Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad,fldShomareHesab,fldDaramadId

				
		union all
		SELECT fldDaramadCode,fldSharheCodeDaramad,fldShomareHesab, (CAST((CAST(fldMablaghNaghdi AS BIGINT)*CAST(fldmablaghCodeDaramad AS bigint))AS BIGINT)/CAST(fldmablaghKoli AS bigint)),'1'
		,fldDaramadId,'',0,fldShomareHesabId
		 FROM 
		(SELECT   DISTINCT    Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId, tblCodhayeDaramd_1.fldDaramadCode, 
								 Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad
								-- ,SUM(fldMablagh) OVER (PARTITION BY fldReplyTaghsitId,tblNaghdi_Talab.fldShomareHesabId) AS fldMablaghNaghdi
								,Drd.fn_SumMablaghNaghdi('Naghdi_Talab',fldReplyTaghsitId,tblNaghdi_Talab.fldShomareHesabId,'','') AS fldMablaghNaghdi
								,fldShomareHesab ,fldReplyTaghsitId
			,ISNULL(SUM(fldTakhfifAsliValue*fldTedad+fldTakhfifAvarezValue+fldTakhfifMaliyatValue),SUM(fldAsliValue*fldTedad+fldAvarezValue+fldMaliyatValue)) AS fldmablaghCodeDaramad
			,(SELECT TOP(1) ISNULL(SUM(fldTakhfifAsliValue*fldTedad+fldTakhfifAvarezValue+fldTakhfifMaliyatValue) OVER (PARTITION BY tblCodhayeDaramadiElamAvarez.fldElamAvarezId),SUM(fldAsliValue*fldTedad+fldAvarezValue+fldMaliyatValue) OVER (PARTITION BY tblCodhayeDaramadiElamAvarez.fldElamAvarezId)) FROM Drd.tblCodhayeDaramadiElamAvarez AS a WHERE a.fldElamAvarezId =Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId) AS fldmablaghKoli
		,tblCodhayeDaramd_1.fldDaramadId,Drd.tblNaghdi_Talab.fldShomareHesabId 
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
								 ,tblNaghdi_Talab.fldShomareHesabId,fldShomareHesab,fldDaramadId,Drd.tblNaghdi_Talab.fldShomareHesabId 
								
								 )t



		------------------------------------------------------- وصول شده

		INSERT INTO @temp
		 
		SELECT  fldDaramadCode,fldSharheCodeDaramad,fldShomareHesab, (CAST((CAST(fldMablagh AS BIGINT)*CAST(fldmablaghCodeDaramad AS bigint))AS BIGINT)/CAST(fldmablaghKoli AS BIGINT)),'2',fldDaramadId 
		,'' ,0,fldShomareHesabIdOrgan
		FROM 
		(SELECT   DISTINCT    Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId, tblCodhayeDaramd_1.fldDaramadCode, 
								 Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad
								-- ,SUM(fldMablagh) OVER (PARTITION BY fldReplyTaghsitId,tblNaghdi_Talab.fldShomareHesabId) AS fldMablaghNaghdi
								,Drd.fn_SumMablaghNaghdi('Check',fldReplyTaghsitId,tblCheck.fldShomareHesabIdOrgan,@azTarikh ,@Tatarikh) AS fldMablagh
								,fldShomareHesab ,fldReplyTaghsitId
			,ISNULL(SUM(fldTakhfifAsliValue*fldTedad+fldTakhfifAvarezValue+fldTakhfifMaliyatValue),SUM(fldAsliValue*fldTedad+fldAvarezValue+fldMaliyatValue)) AS fldmablaghCodeDaramad
			,(SELECT TOP(1) ISNULL(SUM(fldTakhfifAsliValue*fldTedad+fldTakhfifAvarezValue+fldTakhfifMaliyatValue) OVER (PARTITION BY tblCodhayeDaramadiElamAvarez.fldElamAvarezId),SUM(fldAsliValue*fldTedad+fldAvarezValue+fldMaliyatValue) OVER (PARTITION BY tblCodhayeDaramadiElamAvarez.fldElamAvarezId)) FROM Drd.tblCodhayeDaramadiElamAvarez AS a WHERE a.fldElamAvarezId =Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId) AS fldmablaghKoli
		,tblCodhayeDaramd_1.fldDaramadId,tblCheck.fldShomareHesabIdOrgan
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
								 ,tblCheck.fldShomareHesabIdOrgan,fldShomareHesab,fldDaramadId,tblCheck.fldShomareHesabIdOrgan
								 )t


		INSERT INTO @temp
		       
								 SELECT  fldDaramadCode,fldSharheCodeDaramad,fldShomareHesab, (CAST((CAST(fldMablagh AS BIGINT)*CAST(fldmablaghCodeDaramad AS bigint))AS BIGINT)/CAST(fldmablaghKoli AS BIGINT)),'3',fldDaramadId 
								 ,'',0,fldShomareHesadId
								 FROM 
		(SELECT   DISTINCT    Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId, tblCodhayeDaramd_1.fldDaramadCode, 
								 Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad
								-- ,SUM(fldMablagh) OVER (PARTITION BY fldReplyTaghsitId,tblNaghdi_Talab.fldShomareHesabId) AS fldMablaghNaghdi
								,Drd.fn_SumMablaghNaghdi('Safte',fldReplyTaghsitId,tblShomareHesabCodeDaramad.fldShomareHesadId,@AzTarikh , @Tatarikh) AS fldMablagh
								,fldShomareHesab ,fldReplyTaghsitId
			,ISNULL(SUM(fldTakhfifAsliValue*fldTedad+fldTakhfifAvarezValue+fldTakhfifMaliyatValue),SUM(fldAsliValue*fldTedad+fldAvarezValue+fldMaliyatValue)) AS fldmablaghCodeDaramad
			,(SELECT TOP(1) ISNULL(SUM(fldTakhfifAsliValue*fldTedad+fldTakhfifAvarezValue+fldTakhfifMaliyatValue) OVER (PARTITION BY tblCodhayeDaramadiElamAvarez.fldElamAvarezId),SUM(fldAsliValue*fldTedad+fldAvarezValue+fldMaliyatValue) OVER (PARTITION BY tblCodhayeDaramadiElamAvarez.fldElamAvarezId)) FROM Drd.tblCodhayeDaramadiElamAvarez AS a WHERE a.fldElamAvarezId =Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId) AS fldmablaghKoli
		,tblCodhayeDaramd_1.fldDaramadId,tblShomareHesabCodeDaramad.fldShomareHesadId
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
								 ,tblShomareHesabCodeDaramad.fldShomareHesadId,fldShomareHesab,fldDaramadId,tblShomareHesabCodeDaramad.fldShomareHesadId
								 )t

				INSERT INTO @temp
				SELECT  fldDaramadCode,fldSharheCodeDaramad,fldShomareHesab, (CAST((CAST(fldMablagh AS BIGINT)*CAST(fldmablaghCodeDaramad AS bigint))AS BIGINT)/CAST(fldmablaghKoli AS BIGINT)),'4',fldDaramadId
				,'',0,fldShomareHesadId
				 FROM 
				(SELECT   DISTINCT    Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId, tblCodhayeDaramd_1.fldDaramadCode, 
								 Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad
								-- ,SUM(fldMablagh) OVER (PARTITION BY fldReplyTaghsitId,tblNaghdi_Talab.fldShomareHesabId) AS fldMablaghNaghdi
								,Drd.fn_SumMablaghNaghdi('Barat',fldReplyTaghsitId,tblShomareHesabCodeDaramad.fldShomareHesadId,@AzTarikh,@TaTarikh) AS fldMablagh
								,fldShomareHesab ,fldReplyTaghsitId
			,ISNULL(SUM(fldTakhfifAsliValue*fldTedad+fldTakhfifAvarezValue+fldTakhfifMaliyatValue),SUM(fldAsliValue*fldTedad+fldAvarezValue+fldMaliyatValue)) AS fldmablaghCodeDaramad
			,(SELECT TOP(1) ISNULL(SUM(fldTakhfifAsliValue*fldTedad+fldTakhfifAvarezValue+fldTakhfifMaliyatValue) OVER (PARTITION BY tblCodhayeDaramadiElamAvarez.fldElamAvarezId),SUM(fldAsliValue*fldTedad+fldAvarezValue+fldMaliyatValue) OVER (PARTITION BY tblCodhayeDaramadiElamAvarez.fldElamAvarezId)) FROM Drd.tblCodhayeDaramadiElamAvarez AS a WHERE a.fldElamAvarezId =Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId) AS fldmablaghKoli
			,tblCodhayeDaramd_1.fldDaramadId,tblShomareHesabCodeDaramad.fldShomareHesadId
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
								 ,tblShomareHesabCodeDaramad.fldShomareHesadId,fldShomareHesab,fldDaramadId,tblShomareHesabCodeDaramad.fldShomareHesadId
								 )t


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
			SELECT distinct * FROM (
			SELECT fldStrhid AS hidChilde,fldDaramadCode AS DaramdCodeChilde,fldDaramadTitle AS DaramadTitleChilde,fldLevel AS lvlChilde,
			ISNULL((SELECT d.fldStrhid FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_hid,
			ISNULL((SELECT fldDaramadCode FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_DaramadCode,
			ISNULL((SELECT fldDaramadTitle FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_DaramadTitle,
			ISNULL((SELECT fldLevel FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_Level
				,sum(mablaghcodeDaramad) over (partition by tem.Daramadcode,tem.ShomareHId)/*ISNULL((SELECT SUM(mablaghcodeDaramad) FROM @temp WHERE Daramadcode=C.fldDaramadCode) ,ISNULL((SELECT SUM(mablaghcodeDaramad) FROM @temp AS t WHERE t.hid.ToString() LIKE c.fldStrhid+'%'),0))*/ AS Mablagh
				,0 AS [Count],'' fldtarikh
				,(SELECT  TOP(1)  fldShomareHesab FROM      
									  Com.tblShomareHesabeOmoomi WHERE tblShomareHesabeOmoomi.fldid=ShomareHId ) fldShomareHesab
				 , ShomareHId fldShomareHesabId	
				 			 ,CASE WHEN fldid IN (SELECT  s.fldId FROM     Drd.tblCodhayeDaramd AS s left JOIN
							  Drd.tblCodhayeDaramd AS p ON  s.fldDaramadId = p.fldDaramadId.GetAncestor(1)
							  WHERE p.fldDaramadId IS NULL AND s.fldId=c.fldid) THEN N'1' ELSE '0' END AS LastNode
			 FROM Drd.tblCodhayeDaramd AS C inner join @temp as tem
			 on tem.Daramadcode=c.fldDaramadCode
			 WHERE C.fldLevel<>0   AND C.fldId IN (SELECT id FROM @code))s
			 WHERE fldShomareHesabId LIKE @ShomareHesabId and    LastNode=1 and Mablagh<>0
			 

			 IF(@ShomareHesabId=0 AND @CodeDaramadId=0)
			 
			 select  distinct* from (SELECT fldStrhid AS hidChilde,fldDaramadCode AS DaramdCodeChilde,fldDaramadTitle AS DaramadTitleChilde,fldLevel AS lvlChilde,
			ISNULL((SELECT d.fldStrhid FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_hid,
			ISNULL((SELECT fldDaramadCode FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_DaramadCode,
			ISNULL((SELECT fldDaramadTitle FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_DaramadTitle,
			ISNULL((SELECT fldLevel FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_Level
				,sum(mablaghcodeDaramad) over (partition by tem.Daramadcode,tem.ShomareHId)/*ISNULL((SELECT SUM(mablaghcodeDaramad) FROM @temp WHERE Daramadcode=C.fldDaramadCode) ,ISNULL((SELECT SUM(mablaghcodeDaramad) FROM @temp AS t WHERE t.hid.ToString() LIKE c.fldStrhid+'%'),0))*/ AS Mablagh
				,0 AS [Count],'' fldtarikh
				,(SELECT  TOP(1)  fldShomareHesab FROM      
									  Com.tblShomareHesabeOmoomi WHERE tblShomareHesabeOmoomi.fldid=ShomareHId ) fldShomareHesab
				 , ShomareHId fldShomareHesabId	
				 			 ,CASE WHEN fldid IN (SELECT  s.fldId FROM     Drd.tblCodhayeDaramd AS s left JOIN
							  Drd.tblCodhayeDaramd AS p ON  s.fldDaramadId = p.fldDaramadId.GetAncestor(1)
							  WHERE p.fldDaramadId IS NULL AND s.fldId=c.fldid) THEN N'1' ELSE '0' END AS LastNode
			 FROM Drd.tblCodhayeDaramd AS C inner join @temp as tem
			 on tem.Daramadcode=c.fldDaramadCode
			 WHERE C.fldLevel<>0) t
			 where  LastNode=1 and Mablagh<>0 
			 
			 IF(@ShomareHesabId=0 AND @CodeDaramadId<>0)
			select distinct * from(SELECT fldStrhid AS hidChilde,fldDaramadCode AS DaramdCodeChilde,fldDaramadTitle AS DaramadTitleChilde,fldLevel AS lvlChilde,
			ISNULL((SELECT d.fldStrhid FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_hid,
			ISNULL((SELECT fldDaramadCode FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_DaramadCode,
			ISNULL((SELECT fldDaramadTitle FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_DaramadTitle,
			ISNULL((SELECT fldLevel FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_Level
				,sum(mablaghcodeDaramad) over (partition by tem.Daramadcode,tem.ShomareHId)/*ISNULL((SELECT SUM(mablaghcodeDaramad) FROM @temp WHERE Daramadcode=C.fldDaramadCode) ,ISNULL((SELECT SUM(mablaghcodeDaramad) FROM @temp AS t WHERE t.hid.ToString() LIKE c.fldStrhid+'%'),0))*/ AS Mablagh
				,0 AS [Count],'' fldtarikh
				,(SELECT  TOP(1)  fldShomareHesab FROM      
									  Com.tblShomareHesabeOmoomi WHERE tblShomareHesabeOmoomi.fldid=ShomareHId ) fldShomareHesab
				 , ShomareHId fldShomareHesabId	
				 			  ,CASE WHEN fldid IN (SELECT  s.fldId FROM     Drd.tblCodhayeDaramd AS s left JOIN
							  Drd.tblCodhayeDaramd AS p ON  s.fldDaramadId = p.fldDaramadId.GetAncestor(1)
							  WHERE p.fldDaramadId IS NULL AND s.fldId=c.fldid) THEN N'1' ELSE '0' END AS LastNode
			 FROM Drd.tblCodhayeDaramd AS C inner join @temp as tem
			 on tem.Daramadcode=c.fldDaramadCode
			 WHERE C.fldLevel<>0   AND C.fldId IN (SELECT id FROM @code))t
			 where    LastNode=1 and Mablagh<>0

			 IF(@ShomareHesabId<>0 AND @CodeDaramadId=0)
			SELECT distinct * from(SELECT fldStrhid AS hidChilde,fldDaramadCode AS DaramdCodeChilde,fldDaramadTitle AS DaramadTitleChilde,fldLevel AS lvlChilde,
			ISNULL((SELECT d.fldStrhid FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_hid,
			ISNULL((SELECT fldDaramadCode FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_DaramadCode,
			ISNULL((SELECT fldDaramadTitle FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_DaramadTitle,
			ISNULL((SELECT fldLevel FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_Level
				,sum(mablaghcodeDaramad) over (partition by tem.Daramadcode,tem.ShomareHId)/*ISNULL((SELECT SUM(mablaghcodeDaramad) FROM @temp WHERE Daramadcode=C.fldDaramadCode) ,ISNULL((SELECT SUM(mablaghcodeDaramad) FROM @temp AS t WHERE t.hid.ToString() LIKE c.fldStrhid+'%'),0))*/ AS Mablagh
				,0 AS [Count],'' fldtarikh
				,(SELECT  TOP(1)  fldShomareHesab FROM      
									  Com.tblShomareHesabeOmoomi WHERE tblShomareHesabeOmoomi.fldid=ShomareHId ) fldShomareHesab
				 , ShomareHId fldShomareHesabId	
				 			  ,CASE WHEN fldid IN (SELECT  s.fldId FROM     Drd.tblCodhayeDaramd AS s left JOIN
							  Drd.tblCodhayeDaramd AS p ON  s.fldDaramadId = p.fldDaramadId.GetAncestor(1)
							  WHERE p.fldDaramadId IS NULL AND s.fldId=c.fldid) THEN N'1' ELSE '0' END AS LastNode
			 FROM Drd.tblCodhayeDaramd AS C inner join @temp as tem
			 on tem.Daramadcode=c.fldDaramadCode
			 WHERE C.fldLevel<>0  and ShomareHId LIKE @ShomareHesabId  )t
			  WHERE    LastNode=1 and Mablagh<>0
			end  
end
GO
