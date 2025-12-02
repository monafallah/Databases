SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_RptListCodeDaramad_Asli](@AzTarikh NVARCHAR(10),@TaTarikh NVARCHAR(10),@ShomareHesabId INT,@CodeDaramadId INT,@OrganId INT,@fieldname NVARCHAR(50),@DateType tinyint)
AS
--DECLARE @fieldname NVARCHAR(50)='all', @AzTarikh NVARCHAR(10)='1403/08/01',@TaTarikh NVARCHAR(10)='1403/08/30',@ShomareHesabId INT=719,@CodeDaramadId INT=0,@OrganId INT=1,@DateType tinyint=1
DECLARE @temp TABLE(idcode int,Daramadcode NVARCHAR(50),sharhecode NVARCHAR(300),shomareHesab NVARCHAR(50),mablaghcodeDaramad BIGINT,fldtype NVARCHAR(1),hid HIERARCHYID,fldtarikh nvarchar (10),c int,ShomareHId INT,Maliyat bigint,Avarez bigint ,fldAmuzesh bigint)
DECLARE @temp_Hid TABLE(Daramadcode NVARCHAR(50),sharhecode NVARCHAR(300),shomareHesab NVARCHAR(50),mablaghcodeDaramad BIGINT,hid HIERARCHYID)
DECLARE @code table(id int ,CodeDaramad NVARCHAR(50),fldLevel NVARCHAR(50))
DECLARE @StartDate DATE=com.ShamsiToMiladi(@Aztarikh)
DECLARE @EndDate DATE=com.ShamsiToMiladi(@TaTarikh)
declare @table table (P_DaramdCode nvarchar(max),P_DaramadTitle nvarchar(max),Mablagh bigint,Tedad int,fldTarikh nvarchar(10),fldShomareHesab nvarchar(max),fldShomareHesabId int,P_Idcode int)



--select * from drd.tblCodhayeDaramd where fldDaramadCode='402005/08'
if(@fieldname='Detail')
BEGIN
	IF(@OrganId<>0)
	BEGIN
		if(@DateType=1)/*براساس تاریخ پرداخت*/
		begin
			INSERT INTO @temp
			SELECT      tblCodhayeDaramd_1.fldid,  tblCodhayeDaramd_1.fldDaramadCode, Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad, Com.tblShomareHesabeOmoomi.fldShomareHesab, 
								   ISNULL(cast((Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifAsliValue * Drd.tblCodhayeDaramadiElamAvarez.fldTedad + Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifAvarezValue + Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifMaliyatValue+fldTakhfifAmuzeshParvareshValue)as bigint),
									  cast((Drd.tblCodhayeDaramadiElamAvarez.fldAsliValue * Drd.tblCodhayeDaramadiElamAvarez.fldTedad + Drd.tblCodhayeDaramadiElamAvarez.fldAvarezValue + Drd.tblCodhayeDaramadiElamAvarez.fldMaliyatValue+fldAmuzeshParvareshValue)as bigint))
				AS fldmablaghCodeDaramad, '0' AS Expr1, tblCodhayeDaramd_1.fldDaramadId,tblPardakhtFish.fldTarikh,tblPardakhtFish.fldId,tblSodoorFish.fldShomareHesabId,isnull(fldTakhfifMaliyatValue,fldMaliyatValue)fldMaliyatValue,isnull(fldTakhfifAvarezValue,fldAvarezValue)fldAvarezValue
				,isnull(fldTakhfifAmuzeshParvareshValue,fldAmuzeshParvareshValue)fldAmuzeshParvareshValue
			-- ,tblShomareHesabCodeDaramad.fldShomareHesadId
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
							 
			
			union all
			SELECT idcode, fldDaramadCode,fldSharheCodeDaramad,fldShomareHesab, cast(cast(fldMablaghNaghdi as numeric(50))*cast(fldmablaghCodeDaramad as numeric(50))/cast(fldmablaghKoli as numeric(50))as bigint),'1'
			,fldDaramadId,fldTarikh,fldId,fldShomareHesabId,fldMaliyatValue,fldAvarezValue ,  cast(cast(fldMablaghNaghdi as numeric(50)) *cast(fldAmuzeshParvareshValue as numeric(50))/cast(fldmablaghKoli as numeric(50))as bigint)fldAmuzeshParvareshValue
			 FROM 
			(SELECT   DISTINCT   Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId, tblCodhayeDaramd_1.fldDaramadCode, tblCodhayeDaramd_1.fldid idCode,
									 Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad
									,Drd.fn_SumMablaghNaghdi('Naghdi_Talab',tblNaghdi_Talab.fldFishId,tblNaghdi_Talab.fldShomareHesabId,@azTarikh ,@Tatarikh) AS fldMablaghNaghdi
									,fldShomareHesab ,fldReplyTaghsitId
				,ISNULL(SUM(fldTakhfifAsliValue*fldTedad+fldTakhfifAvarezValue+fldTakhfifMaliyatValue+fldTakhfifAmuzeshParvareshValue),SUM(fldAsliValue*fldTedad+fldAvarezValue+fldMaliyatValue+fldAmuzeshParvareshValue)) AS fldmablaghCodeDaramad
				,(SELECT TOP(1) ISNULL(SUM(fldTakhfifAsliValue*fldTedad+fldTakhfifAvarezValue+fldTakhfifMaliyatValue) OVER (PARTITION BY tblCodhayeDaramadiElamAvarez.fldElamAvarezId),SUM(fldAsliValue*fldTedad+fldAvarezValue+fldMaliyatValue) OVER (PARTITION BY tblCodhayeDaramadiElamAvarez.fldElamAvarezId)) FROM Drd.tblCodhayeDaramadiElamAvarez AS a WHERE a.fldElamAvarezId =Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId) AS fldmablaghKoli
			,tblCodhayeDaramd_1.fldDaramadId,tblPardakhtFish.fldTarikh,tblPardakhtFish.fldId,Drd.tblNaghdi_Talab.fldShomareHesabId,tblNaghdi_Talab.fldFishId,isnull(fldTakhfifMaliyatValue,fldMaliyatValue)fldMaliyatValue,isnull(fldTakhfifAvarezValue,fldAvarezValue)fldAvarezValue
			,isnull(fldTakhfifAmuzeshParvareshValue,fldAmuzeshParvareshValue)fldAmuzeshParvareshValue
			 
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
							 
							 GROUP BY  tblCodhayeDaramd_1.fldid,tblRequestTaghsit_Takhfif.fldElamAvarezId,tblCodhayeDaramd_1.fldDaramadCode, 
							 Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad,fldMablagh,fldReplyTaghsitId, tblCodhayeDaramadiElamAvarez.fldElamAvarezId
							 ,tblNaghdi_Talab.fldShomareHesabId,fldShomareHesab,fldDaramadId,tblPardakhtFish.fldTarikh,tblPardakhtFish.fldId,tblNaghdi_Talab.fldShomareHesabId
						,fldMaliyatValue,fldAvarezValue,fldTakhfifMaliyatValue,fldTakhfifAvarezValue,tblNaghdi_Talab.fldFishId ,fldTakhfifAmuzeshParvareshValue,fldAmuzeshParvareshValue
							 )t

			end
			else if(@DateType=0)/*براساس تاریخ واریز*/
			begin
				INSERT INTO @temp
			SELECT     tblCodhayeDaramd_1.fldid,   tblCodhayeDaramd_1.fldDaramadCode, Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad, Com.tblShomareHesabeOmoomi.fldShomareHesab, 
								   ISNULL(cast((Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifAsliValue * Drd.tblCodhayeDaramadiElamAvarez.fldTedad + Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifAvarezValue + Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifMaliyatValue+fldTakhfifAmuzeshParvareshValue)as bigint),
									  cast((Drd.tblCodhayeDaramadiElamAvarez.fldAsliValue * Drd.tblCodhayeDaramadiElamAvarez.fldTedad + Drd.tblCodhayeDaramadiElamAvarez.fldAvarezValue + Drd.tblCodhayeDaramadiElamAvarez.fldMaliyatValue+fldAmuzeshParvareshValue)as bigint))
				AS fldmablaghCodeDaramad, '0' AS Expr1, tblCodhayeDaramd_1.fldDaramadId,tblPardakhtFish.fldTarikhVariz,tblPardakhtFish.fldId,tblSodoorFish.fldShomareHesabId,isnull(fldTakhfifMaliyatValue,fldMaliyatValue)fldMaliyatValue,isnull(fldTakhfifAvarezValue,fldAvarezValue)fldAvarezValue
				,isnull(fldTakhfifAmuzeshParvareshValue,fldAmuzeshParvareshValue)fldAmuzeshParvareshValue
			 
			FROM            Drd.tblSodoorFish INNER JOIN
							 Drd.tblSodoorFish_Detail ON Drd.tblSodoorFish.fldId = Drd.tblSodoorFish_Detail.fldFishId INNER JOIN
							 Drd.tblCodhayeDaramadiElamAvarez ON Drd.tblSodoorFish_Detail.fldCodeElamAvarezId = Drd.tblCodhayeDaramadiElamAvarez.fldID INNER JOIN
							 Drd.tblShomareHesabCodeDaramad ON Drd.tblCodhayeDaramadiElamAvarez.fldShomareHesabCodeDaramadId = Drd.tblShomareHesabCodeDaramad.fldId AND 
							 Drd.tblCodhayeDaramadiElamAvarez.fldShomareHesabCodeDaramadId = Drd.tblShomareHesabCodeDaramad.fldId INNER JOIN
							 Drd.tblCodhayeDaramd AS tblCodhayeDaramd_1 ON Drd.tblShomareHesabCodeDaramad.fldCodeDaramadId = tblCodhayeDaramd_1.fldId INNER JOIN
							 Drd.tblPardakhtFish ON Drd.tblSodoorFish.fldId = Drd.tblPardakhtFish.fldFishId AND Drd.tblSodoorFish.fldId = Drd.tblPardakhtFish.fldFishId INNER JOIN
							 Com.tblShomareHesabeOmoomi ON Drd.tblSodoorFish.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId
			WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId)
							 AND CAST( tblPardakhtFish.fldDateVariz AS DATE) BETWEEN @StartDate AND @EndDate
							 AND fldOrganId=@OrganId
							 
			
			union all
			SELECT idcode, fldDaramadCode,fldSharheCodeDaramad,fldShomareHesab, cast(cast(fldMablaghNaghdi as numeric(50))*cast(fldmablaghCodeDaramad as numeric(50))/cast(fldmablaghKoli as numeric(50))as bigint),'1'
			,fldDaramadId,fldTarikhVariz,fldId,fldShomareHesabId,fldMaliyatValue,fldAvarezValue ,cast(cast(fldMablaghNaghdi as numeric(50))*cast(fldAmuzeshParvareshValue as numeric(50))/cast(fldmablaghKoli as numeric(50))as bigint) fldAmuzeshParvareshValue
			 FROM 
			(SELECT   DISTINCT    Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId, tblCodhayeDaramd_1.fldDaramadCode, tblCodhayeDaramd_1.fldid idcode,
									 Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad
									,Drd.fn_SumMablaghNaghdiVariz('Naghdi_Talab',tblNaghdi_Talab.fldFishId,tblNaghdi_Talab.fldShomareHesabId,@azTarikh ,@Tatarikh) AS fldMablaghNaghdi
									,fldShomareHesab ,fldReplyTaghsitId
				,ISNULL(SUM(fldTakhfifAsliValue*fldTedad+fldTakhfifAvarezValue+fldTakhfifMaliyatValue+fldTakhfifAmuzeshParvareshValue),SUM(fldAsliValue*fldTedad+fldAvarezValue+fldMaliyatValue+fldAmuzeshParvareshValue)) AS fldmablaghCodeDaramad
				,(SELECT TOP(1) ISNULL(SUM(fldTakhfifAsliValue*fldTedad+fldTakhfifAvarezValue+fldTakhfifMaliyatValue+fldTakhfifAmuzeshParvareshValue) OVER (PARTITION BY tblCodhayeDaramadiElamAvarez.fldElamAvarezId),SUM(fldAsliValue*fldTedad+fldAvarezValue+fldMaliyatValue+fldAmuzeshParvareshValue) OVER (PARTITION BY tblCodhayeDaramadiElamAvarez.fldElamAvarezId)) FROM Drd.tblCodhayeDaramadiElamAvarez AS a WHERE a.fldElamAvarezId =Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId) AS fldmablaghKoli
			,tblCodhayeDaramd_1.fldDaramadId,tblPardakhtFish.fldTarikhVariz,tblPardakhtFish.fldId,Drd.tblNaghdi_Talab.fldShomareHesabId,tblNaghdi_Talab.fldFishId,isnull(fldTakhfifMaliyatValue,fldMaliyatValue)fldMaliyatValue,isnull(fldTakhfifAvarezValue,fldAvarezValue)fldAvarezValue ,isnull(fldTakhfifAmuzeshParvareshValue,fldAmuzeshParvareshValue)fldAmuzeshParvareshValue 
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
							 
							 GROUP BY tblRequestTaghsit_Takhfif.fldElamAvarezId,tblCodhayeDaramd_1.fldDaramadCode, tblCodhayeDaramd_1.fldid,
							 Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad,fldMablagh,fldReplyTaghsitId, tblCodhayeDaramadiElamAvarez.fldElamAvarezId
							 ,tblNaghdi_Talab.fldShomareHesabId,fldShomareHesab,fldDaramadId,tblPardakhtFish.fldTarikhVariz,tblPardakhtFish.fldId,tblNaghdi_Talab.fldShomareHesabId
						,fldMaliyatValue,fldAvarezValue,fldTakhfifMaliyatValue,fldTakhfifAvarezValue,tblNaghdi_Talab.fldFishId,fldTakhfifAmuzeshParvareshValue,fldAmuzeshParvareshValue  
							 )t

			end

		
	------------------------------------------------------- وصول شده

							INSERT INTO @temp
							 
							SELECT idcode, fldDaramadCode,fldSharheCodeDaramad,fldShomareHesab, cast((cast(cast(fldMablagh as numeric)/cast(fldmablaghKoli as  numeric)as  numeric(38,20))*fldmablaghCodeDaramad)  as bigint),'2',fldDaramadId,fldDateStatus,
							fldid,fldShomareHesabIdOrgan,fldMaliyatValue,fldAvarezValue ,cast((cast(cast(fldMablagh as numeric)/cast(fldmablaghKoli as  numeric)as  numeric(38,20))*fldAmuzeshParvareshValue)  as bigint) fldAmuzeshParvareshValue
							 FROM 
							(SELECT   DISTINCT    Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId, tblCodhayeDaramd_1.fldDaramadCode, tblCodhayeDaramd_1.fldid idcode,
													 Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad
													,Drd.fn_SumMablaghNaghdi('Check',tblcheck.fldid,tblCheck.fldShomareHesabIdOrgan,@azTarikh ,@Tatarikh) AS fldMablagh
													,fldShomareHesab ,fldReplyTaghsitId
								,ISNULL(SUM(fldTakhfifAsliValue*fldTedad+fldTakhfifAvarezValue+fldTakhfifMaliyatValue+fldTakhfifAmuzeshParvareshValue),SUM(fldAsliValue*fldTedad+fldAvarezValue+fldMaliyatValue+fldAmuzeshParvareshValue)) AS fldmablaghCodeDaramad
								,(SELECT TOP(1) ISNULL(SUM(fldTakhfifAsliValue*fldTedad+fldTakhfifAvarezValue+fldTakhfifMaliyatValue+fldTakhfifAmuzeshParvareshValue) OVER (PARTITION BY tblCodhayeDaramadiElamAvarez.fldElamAvarezId),SUM(fldAsliValue*fldTedad+fldAvarezValue+fldMaliyatValue+fldAmuzeshParvareshValue) OVER (PARTITION BY tblCodhayeDaramadiElamAvarez.fldElamAvarezId)) FROM Drd.tblCodhayeDaramadiElamAvarez AS a WHERE a.fldElamAvarezId =Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId) AS fldmablaghKoli
							,tblCodhayeDaramd_1.fldDaramadId,fldDateStatus,tblcheck.fldid,tblCheck.fldShomareHesabIdOrgan,isnull(fldTakhfifMaliyatValue,fldMaliyatValue)fldMaliyatValue,isnull(fldTakhfifAvarezValue,fldAvarezValue)fldAvarezValue
							,isnull(fldTakhfifAmuzeshParvareshValue,fldAmuzeshParvareshValue)fldAmuzeshParvareshValue
							 
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
							 GROUP BY tblRequestTaghsit_Takhfif.fldElamAvarezId,tblCodhayeDaramd_1.fldDaramadCode, tblCodhayeDaramd_1.fldid,
							 Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad,fldMablaghSanad,fldReplyTaghsitId, tblCodhayeDaramadiElamAvarez.fldElamAvarezId
							 ,tblCheck.fldShomareHesabIdOrgan,fldShomareHesab,fldDaramadId,fldDateStatus,tblcheck.fldid,fldShomareHesabIdOrgan,fldMaliyatValue,fldAvarezValue
							,fldTakhfifMaliyatValue,fldTakhfifAvarezValue,fldTakhfifAmuzeshParvareshValue,fldAmuzeshParvareshValue
							 )t


					INSERT INTO @temp
	       
							 SELECT idcode, fldDaramadCode,fldSharheCodeDaramad,fldShomareHesab, cast((cast(cast(fldMablagh as numeric)/cast(fldmablaghKoli as  numeric)as  numeric(38,20))*fldmablaghCodeDaramad)  as bigint),'3'
							 ,fldDaramadId,fldDateStatus,fldid ,fldShomareHesadId,fldMaliyatValue,fldAvarezValue ,cast((cast(cast(fldMablagh as numeric)/cast(fldmablaghKoli as  numeric)as  numeric(38,20))*fldAmuzeshParvareshValue) as bigint) fldAmuzeshParvareshValue
							 FROM 
						(SELECT   DISTINCT    Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId, tblCodhayeDaramd_1.fldDaramadCode, tblCodhayeDaramd_1.fldid idcode,
												 Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad
												-- ,SUM(fldMablagh) OVER (PARTITION BY fldReplyTaghsitId,tblNaghdi_Talab.fldShomareHesabId) AS fldMablaghNaghdi
												,Drd.fn_SumMablaghNaghdi('Safte',fldReplyTaghsitId,tblShomareHesabCodeDaramad.fldShomareHesadId,@AzTarikh , @Tatarikh) AS fldMablagh
												,fldShomareHesab ,fldReplyTaghsitId
							,ISNULL(SUM(fldTakhfifAsliValue*fldTedad+fldTakhfifAvarezValue+fldTakhfifMaliyatValue+fldTakhfifAmuzeshParvareshValue),SUM(fldAsliValue*fldTedad+fldAvarezValue+fldMaliyatValue+fldAmuzeshParvareshValue)) AS fldmablaghCodeDaramad
							,(SELECT TOP(1) ISNULL(SUM(fldTakhfifAsliValue*fldTedad+fldTakhfifAvarezValue+fldTakhfifMaliyatValue+fldTakhfifAmuzeshParvareshValue) OVER (PARTITION BY tblCodhayeDaramadiElamAvarez.fldElamAvarezId),SUM(fldAsliValue*fldTedad+fldAvarezValue+fldMaliyatValue+fldAmuzeshParvareshValue) OVER (PARTITION BY tblCodhayeDaramadiElamAvarez.fldElamAvarezId)) FROM Drd.tblCodhayeDaramadiElamAvarez AS a WHERE a.fldElamAvarezId =Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId) AS fldmablaghKoli
						,tblCodhayeDaramd_1.fldDaramadId,fldDateStatus,tblSafte.fldid,tblShomareHesabCodeDaramad.fldShomareHesadId
						,isnull(fldTakhfifMaliyatValue,fldMaliyatValue)fldMaliyatValue,isnull(fldTakhfifAvarezValue,fldAvarezValue)fldAvarezValue ,isnull(fldTakhfifAmuzeshParvareshValue,fldAmuzeshParvareshValue)fldAmuzeshParvareshValue
						 
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
							 GROUP BY tblRequestTaghsit_Takhfif.fldElamAvarezId,tblCodhayeDaramd_1.fldDaramadCode, tblCodhayeDaramd_1.fldid,
							 Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad,fldMablaghSanad,fldReplyTaghsitId, tblCodhayeDaramadiElamAvarez.fldElamAvarezId
							 ,tblShomareHesabCodeDaramad.fldShomareHesadId,fldShomareHesab,fldDaramadId,fldDateStatus,tblSafte.fldid,fldShomareHesadId
							,fldMaliyatValue,fldAvarezValue,fldTakhfifMaliyatValue,fldTakhfifAvarezValue,fldTakhfifAmuzeshParvareshValue,fldAmuzeshParvareshValue
							 )t

					INSERT INTO @temp
					SELECT idcode, fldDaramadCode,fldSharheCodeDaramad,fldShomareHesab, cast((cast(cast(fldMablagh as numeric)/cast(fldmablaghKoli as  numeric)as  numeric(38,20))*fldmablaghCodeDaramad)  as bigint),'4',fldDaramadId
					,fldDateStatus,fldid,fldShomareHesadId ,fldMaliyatValue,fldAvarezValue ,cast((cast(cast(fldMablagh as numeric)/cast(fldmablaghKoli as  numeric)as  numeric(38,20))*fldAmuzeshParvareshValue)  as bigint) fldAmuzeshParvareshValue
					FROM 
					(SELECT   DISTINCT    Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId, tblCodhayeDaramd_1.fldDaramadCode, tblCodhayeDaramd_1.fldid idcode,
						 Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad
							-- ,SUM(fldMablagh) OVER (PARTITION BY fldReplyTaghsitId,tblNaghdi_Talab.fldShomareHesabId) AS fldMablaghNaghdi
							,Drd.fn_SumMablaghNaghdi('Barat',fldReplyTaghsitId,tblShomareHesabCodeDaramad.fldShomareHesadId,@AzTarikh,@TaTarikh) AS fldMablagh
							,fldShomareHesab ,fldReplyTaghsitId
							,ISNULL(SUM(fldTakhfifAsliValue*fldTedad+fldTakhfifAvarezValue+fldTakhfifMaliyatValue+fldTakhfifAmuzeshParvareshValue),SUM(fldAsliValue*fldTedad+fldAvarezValue+fldMaliyatValue+fldAmuzeshParvareshValue)) AS fldmablaghCodeDaramad
							,(SELECT TOP(1) ISNULL(SUM(fldTakhfifAsliValue*fldTedad+fldTakhfifAvarezValue+fldTakhfifMaliyatValue+fldTakhfifAmuzeshParvareshValue) OVER (PARTITION BY tblCodhayeDaramadiElamAvarez.fldElamAvarezId),SUM(fldAsliValue*fldTedad+fldAvarezValue+fldMaliyatValue+fldAmuzeshParvareshValue) OVER (PARTITION BY tblCodhayeDaramadiElamAvarez.fldElamAvarezId)) FROM Drd.tblCodhayeDaramadiElamAvarez AS a WHERE a.fldElamAvarezId =Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId) AS fldmablaghKoli
						,tblCodhayeDaramd_1.fldDaramadId,fldDateStatus,tblbarat.fldid, tblShomareHesabCodeDaramad.fldShomareHesadId
						,isnull(fldTakhfifMaliyatValue,fldMaliyatValue)fldMaliyatValue,isnull(fldTakhfifAvarezValue,fldAvarezValue)fldAvarezValue,isnull(fldTakhfifAmuzeshParvareshValue,fldAmuzeshParvareshValue)fldAmuzeshParvareshValue
						 
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
							 GROUP BY tblRequestTaghsit_Takhfif.fldElamAvarezId,tblCodhayeDaramd_1.fldDaramadCode, tblCodhayeDaramd_1.fldid,
							 Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad,fldMablaghSanad,fldReplyTaghsitId, tblCodhayeDaramadiElamAvarez.fldElamAvarezId
							 ,tblShomareHesabCodeDaramad.fldShomareHesadId,fldShomareHesab,fldDaramadId,fldDateStatus,tblbarat.fldid,fldShomareHesadId,fldMaliyatValue,fldAvarezValue
							,fldTakhfifMaliyatValue,fldTakhfifAvarezValue,fldTakhfifAmuzeshParvareshValue,fldAmuzeshParvareshValue
							 )t

							 --select * from @temp -- where -- daramadcode='402005/08' order by fldtarikh

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
			
			IF(@ShomareHesabId<>0 AND @CodeDaramadId<>0 and @CodeDaramadId<>-3)
			BEGIN
			INSERT INTO @table
			select b,a,mablagh,[count],fldtarikh,fldShomareHesab,fldShomareHesabId,P_IdCode from
			 (SELECT distinct  *, case when fldLevel=1 and P_Level=0 then fldDaramadCode  else P_DaramadCode end as b   ,case when fldLevel=1 and P_Level=0 then fldDaramadTitle else P_DaramadTitle end  as a 
				 FROM (
				SELECT 
			ISNULL((SELECT d.fldStrhid FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_hid,
			ISNULL((SELECT fldDaramadCode FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_DaramadCode,
			ISNULL((SELECT d.fldid FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId),'') AS P_IdCode,
			ISNULL((SELECT fldDaramadTitle FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_DaramadTitle,
			ISNULL((SELECT fldLevel FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_Level
			--,ISNULL((SELECT SUM(mablaghcodeDaramad) FROM @temp WHERE Daramadcode=C.fldDaramadCode) ,ISNULL((SELECT SUM(mablaghcodeDaramad) FROM @temp AS t WHERE t.hid.ToString() LIKE c.fldStrhid+'%'),0)) AS Mablagh
			,sum(mablaghcodeDaramad) over (partition by fldtarikh,e.idcode,ShomareHId) as Mablagh
			,count(c)over (partition by fldtarikh,e.idcode,ShomareHId) as [Count],e.fldtarikh
			,fldLevel,fldDaramadCode,fldDaramadTitle
			--,ISNULL((SELECT fldtarikh FROM @temp WHERE Daramadcode=C.fldDaramadCode group by fldtarikh),'') as fldtarikh
			,(SELECT  TOP(1)  fldShomareHesab FROM        
								  Com.tblShomareHesabeOmoomi WHERE tblShomareHesabeOmoomi.fldid=ShomareHId /*AND fldOrganId=@OrganId*/) fldShomareHesab
			 ,/*(SELECT  TOP(1)  fldShomareHesadId FROM  Drd.tblShomareHesabCodeDaramad WHERE fldCodeDaramadId=C.fldId /*AND fldOrganId=@OrganId*/) */ @ShomareHesabId as fldShomareHesabId
			 ,CASE WHEN fldid IN (SELECT  s.fldId FROM     Drd.tblCodhayeDaramd AS s left JOIN
							  Drd.tblCodhayeDaramd AS p ON  s.fldDaramadId = p.fldDaramadId.GetAncestor(1)
							  WHERE p.fldDaramadId IS NULL AND s.fldId=c.fldid) THEN N'1' ELSE '0' END AS LastNode
			 FROM Drd.tblCodhayeDaramd AS C  inner join @temp as e on e.idcode=c.fldid
			 WHERE C.fldLevel<>0  and ShomareHId=@ShomareHesabId  AND C.fldId IN (SELECT id FROM @code))s
			 WHERE     LastNode=1 and Mablagh<>0
			)t
			 
			 select P_DaramdCode,P_DaramadTitle,SUM(Mablagh) AS Mablagh,Sum(Tedad) AS [Count],fldTarikh,fldShomareHesab,fldShomareHesabId from @table
			 group by P_DaramdCode,P_DaramadTitle,fldTarikh,fldShomareHesab,fldShomareHesabId,P_Idcode
			 order by min(fldtarikh)
			 
			 END

			 IF(@ShomareHesabId<>0 AND @CodeDaramadId=-3)/*آموزش و پرورش*/
			BEGIN
			INSERT INTO @table
			select b,a,mablagh,[count],fldtarikh,fldShomareHesab,@ShomareHesabId fldShomareHesabId,0  P_IdCode from
			 (SELECT distinct  *,'_' b   ,N'آموزش و پرورش'as a 
				 FROM (
				SELECT 
			
						--,ISNULL((SELECT SUM(mablaghcodeDaramad) FROM @temp WHERE Daramadcode=C.fldDaramadCode) ,ISNULL((SELECT SUM(mablaghcodeDaramad) FROM @temp AS t WHERE t.hid.ToString() LIKE c.fldStrhid+'%'),0)) AS Mablagh
			sum(fldAmuzesh) over (partition by fldtarikh,ShomareHId) as Mablagh
			,count(c)over (partition by fldtarikh,ShomareHId) as [Count],e.fldtarikh
			
			--,ISNULL((SELECT fldtarikh FROM @temp WHERE Daramadcode=C.fldDaramadCode group by fldtarikh),'') as fldtarikh
			,(SELECT  TOP(1)  fldShomareHesab FROM        
								  Com.tblShomareHesabeOmoomi WHERE tblShomareHesabeOmoomi.fldid=ShomareHId /*AND fldOrganId=@OrganId*/) fldShomareHesab
			
			 FROM @temp as e 
			 WHERe ShomareHId=@ShomareHesabId  )s
			 WHERE     Mablagh<>0
			)t
			 
			 select P_DaramdCode,P_DaramadTitle,SUM(Mablagh) AS Mablagh,Sum(Tedad) AS [Count],fldTarikh,fldShomareHesab,fldShomareHesabId from @table
			 group by P_DaramdCode,P_DaramadTitle,fldTarikh,fldShomareHesab,fldShomareHesabId,P_Idcode
			 order by min(fldtarikh)
			 
			 END


			 ELSE IF(@ShomareHesabId=0 AND @CodeDaramadId=0)
			 BEGIN
				 INSERT INTO @table
				select b,a,mablagh,[count],fldtarikh,fldShomareHesab,fldShomareHesabId,P_Idcode from 
				(SELECT distinct  *, case when fldLevel=1 and P_Level=0 then fldDaramadCode  else P_DaramadCode end as b   
				,case when fldLevel=1 and P_Level=0 then fldDaramadTitle else P_DaramadTitle end  as a 
				 FROM (
				SELECT 
				 ISNULL((SELECT d.fldStrhid FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_hid,
				 ISNULL((SELECT fldDaramadCode FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_DaramadCode,
				 ISNULL((SELECT d.fldid FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId ),'') AS P_Idcode,
				 ISNULL((SELECT fldDaramadTitle FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_DaramadTitle,
				 ISNULL((SELECT fldLevel FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_Level
				--,ISNULL((SELECT SUM(mablaghcodeDaramad) FROM @temp WHERE Daramadcode=C.fldDaramadCode) ,ISNULL((SELECT SUM(mablaghcodeDaramad) FROM @temp AS t WHERE t.hid.ToString() LIKE c.fldStrhid+'%'),0)) AS Mablagh
				--,ISNULL((SELECT top(1) fldtarikh FROM @temp WHERE Daramadcode=C.fldDaramadCode group by fldtarikh),'') as fldtarikh
				--,ISNULL((SELECT top(1)  count(c) FROM @temp WHERE Daramadcode=C.fldDaramadCode group by fldtarikh,Daramadcode),'') as c
				 ,sum(mablaghcodeDaramad) over (partition by fldtarikh,e.idcode,ShomareHId) as Mablagh
				 ,count(c)over (partition by fldtarikh,e.idcode,ShomareHId) as [Count],e.fldtarikh,
				 fldLevel,fldDaramadCode,fldDaramadTitle
				 ,(SELECT  TOP(1)  fldShomareHesab FROM        
									  Com.tblShomareHesabeOmoomi WHERE tblShomareHesabeOmoomi.fldid=ShomareHId /*AND fldOrganId=@OrganId*/) fldShomareHesab
				 --,(SELECT  TOP(1)  fldShomareHesadId FROM  Drd.tblShomareHesabCodeDaramad WHERE fldCodeDaramadId=C.fldId /*AND fldOrganId=@OrganId*/) 
				 ,ShomareHId as  fldShomareHesabId
				 ,CASE WHEN fldid IN (SELECT  s.fldId FROM     Drd.tblCodhayeDaramd AS s left JOIN
								  Drd.tblCodhayeDaramd AS p ON  s.fldDaramadId = p.fldDaramadId.GetAncestor(1)
								  WHERE p.fldDaramadId IS NULL AND s.fldId=c.fldid) THEN N'1' ELSE '0' END AS LastNode
				 FROM Drd.tblCodhayeDaramd AS C  inner join @temp as e on e.idcode=c.fldid
				) t
				 where  LastNode=1 and Mablagh<>0 
				 )r
				
				INSERT INTO @table/*آموزش و پرورش*/
				select b,a,mablagh,[count],fldtarikh,fldShomareHesab,@ShomareHesabId fldShomareHesabId,0 P_IdCode from
				 (SELECT distinct  *,'_' b   ,N'آموزش و پرورش'as a 
				 FROM (
							SELECT 	sum(fldAmuzesh) over (partition by fldtarikh,ShomareHId) as Mablagh
							,count(c)over (partition by fldtarikh,ShomareHId) as [Count],e.fldtarikh
			
							,(SELECT  TOP(1)  fldShomareHesab FROM        
								  Com.tblShomareHesabeOmoomi WHERE tblShomareHesabeOmoomi.fldid=ShomareHId /*AND fldOrganId=@OrganId*/) fldShomareHesab
			
						 FROM @temp as e 
					  )s
					 WHERE     Mablagh<>0
				)t

				 select P_DaramdCode,P_DaramadTitle,SUM(Mablagh) AS Mablagh,Sum(Tedad) AS [Count],fldTarikh,fldShomareHesab,fldShomareHesabId from @table
				 group by P_DaramdCode,P_DaramadTitle,fldTarikh,fldShomareHesab,fldShomareHesabId,P_Idcode
				 order by min(fldtarikh)
			
			 end
			
			
			 ELSE IF(@ShomareHesabId=0 AND @CodeDaramadId<>0 AND @CodeDaramadId<>-3)
			 BEGIN
				  INSERT INTO @table
				 	select b,a,mablagh,[count],fldtarikh,fldShomareHesab,fldShomareHesabId,P_Idcode from 
					(SELECT distinct  *, case when fldLevel=1 and P_Level=0 then fldDaramadCode  else P_DaramadCode end as b   ,case when fldLevel=1 and P_Level=0 then fldDaramadTitle else P_DaramadTitle end  as a 
				 FROM (
				SELECT 
				ISNULL((SELECT d.fldStrhid FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_hid,
				ISNULL((SELECT fldDaramadCode FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_DaramadCode,
				ISNULL((SELECT d.fldid FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId ),'') AS P_Idcode,
				ISNULL((SELECT fldDaramadTitle FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_DaramadTitle,
				ISNULL((SELECT fldLevel FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_Level
				--,ISNULL((SELECT SUM(mablaghcodeDaramad)over (partition by fldtarikh) FROM @temp WHERE Daramadcode=C.fldDaramadCode) ,ISNULL((SELECT SUM(mablaghcodeDaramad) FROM @temp AS t WHERE t.hid.ToString() LIKE c.fldStrhid+'%'),0)) AS Mablagh
				,sum(mablaghcodeDaramad) over (partition by fldtarikh,e.idcode,ShomareHId) as Mablagh
				,count(c)over (partition by fldtarikh,e.idcode,ShomareHId) as [Count],e.fldtarikh
				,fldLevel,fldDaramadCode,fldDaramadTitle
				,(SELECT  TOP(1)  fldShomareHesab FROM        
									  Com.tblShomareHesabeOmoomi WHERE tblShomareHesabeOmoomi.fldid=ShomareHId /*AND fldOrganId=@OrganId*/) fldShomareHesab
				 --,(SELECT  TOP(1)  fldShomareHesadId FROM  Drd.tblShomareHesabCodeDaramad WHERE fldCodeDaramadId=C.fldId /*AND fldOrganId=@OrganId*/)
				  ,ShomareHId as fldShomareHesabId
				  ,CASE WHEN fldid IN (SELECT  s.fldId FROM     Drd.tblCodhayeDaramd AS s left JOIN
								  Drd.tblCodhayeDaramd AS p ON  s.fldDaramadId = p.fldDaramadId.GetAncestor(1)
								  WHERE p.fldDaramadId IS NULL AND s.fldId=c.fldid) THEN N'1' ELSE '0' END AS LastNode
				 FROM Drd.tblCodhayeDaramd AS C inner join @temp as e on e.idcode=c.fldid
				 WHERE C.fldLevel<>0   AND C.fldId IN (SELECT id FROM @code))t
				 where    LastNode=1 and Mablagh<>0
				 )t
				
				SELECT P_DaramdCode,P_DaramadTitle,SUM(Mablagh) AS Mablagh,Sum(Tedad) AS [Count],fldTarikh,fldShomareHesab,fldShomareHesabId from @table
				 group by P_DaramdCode,P_DaramadTitle,fldTarikh,fldShomareHesab,fldShomareHesabId,P_Idcode
				 order by min(fldtarikh)
			END

			 ELSE IF(@ShomareHesabId=0 AND @CodeDaramadId=-3)
			 begin
			INSERT INTO @table/*آموزش و پرورش*/
				select b,a,mablagh,[count],fldtarikh,fldShomareHesab,@ShomareHesabId fldShomareHesabId,0  P_IdCode from
				 (SELECT distinct  *,'_' b   ,N'آموزش و پرورش'as a 
				 FROM (
				SELECT 
			
						--,ISNULL((SELECT SUM(mablaghcodeDaramad) FROM @temp WHERE Daramadcode=C.fldDaramadCode) ,ISNULL((SELECT SUM(mablaghcodeDaramad) FROM @temp AS t WHERE t.hid.ToString() LIKE c.fldStrhid+'%'),0)) AS Mablagh
			sum(fldAmuzesh) over (partition by fldtarikh,ShomareHId) as Mablagh
			,count(c)over (partition by fldtarikh,ShomareHId) as [Count],e.fldtarikh
			
			--,ISNULL((SELECT fldtarikh FROM @temp WHERE Daramadcode=C.fldDaramadCode group by fldtarikh),'') as fldtarikh
			,(SELECT  TOP(1)  fldShomareHesab FROM        
								  Com.tblShomareHesabeOmoomi WHERE tblShomareHesabeOmoomi.fldid=ShomareHId /*AND fldOrganId=@OrganId*/) fldShomareHesab
			 FROM @temp as e 
			   )s
				 WHERE     Mablagh<>0
			)t
				 select P_DaramdCode,P_DaramadTitle,SUM(Mablagh) AS Mablagh,Sum(Tedad) AS [Count],fldTarikh,fldShomareHesab,fldShomareHesabId from @table
				 group by P_DaramdCode,P_DaramadTitle,fldTarikh,fldShomareHesab,fldShomareHesabId,P_Idcode
				 order by min(fldtarikh)
			end

			else IF(@ShomareHesabId<>0 AND @CodeDaramadId=0)
			BEGIN
				INSERT INTO @table
					select b,a,mablagh,[count],fldtarikh,fldShomareHesab,fldShomareHesabId,P_IdCode from (SELECT distinct  *, case when fldLevel=1 and P_Level=0 then fldDaramadCode  else P_DaramadCode end as b   ,case when fldLevel=1 and P_Level=0 then fldDaramadTitle else P_DaramadTitle end  as a 
				 FROM (
				SELECT 
				ISNULL((SELECT d.fldStrhid FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_hid,
				ISNULL((SELECT fldDaramadCode FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_DaramadCode,
				ISNULL((SELECT d.fldId FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId ),'') AS P_IdCode,
				ISNULL((SELECT fldDaramadTitle FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_DaramadTitle,
				ISNULL((SELECT fldLevel FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_Level
				--,ISNULL((SELECT SUM(mablaghcodeDaramad) FROM @temp WHERE Daramadcode=C.fldDaramadCode) ,ISNULL((SELECT SUM(mablaghcodeDaramad) FROM @temp AS t WHERE t.hid.ToString() LIKE c.fldStrhid+'%'),0)) AS Mablagh
				--,ISNULL((SELECT fldtarikh FROM @temp WHERE Daramadcode=C.fldDaramadCode group by fldtarikh),'') as fldtarikh
				,sum(mablaghcodeDaramad) over (partition by fldtarikh,e.idcode,ShomareHId) as Mablagh
				,count(c)over (partition by fldtarikh,e.idcode,ShomareHId) as [Count],e.fldtarikh
				,fldLevel,fldDaramadCode,fldDaramadTitle
				,(SELECT  TOP(1)  fldShomareHesab FROM        
									  Com.tblShomareHesabeOmoomi WHERE tblShomareHesabeOmoomi.fldid=ShomareHId /*AND fldOrganId=@OrganId*/) fldShomareHesab
				 --,(SELECT  TOP(1)  fldShomareHesadId FROM  Drd.tblShomareHesabCodeDaramad WHERE fldCodeDaramadId=C.fldId /*AND fldOrganId=@OrganId*/) 
				 ,ShomareHId as fldShomareHesabId
				  ,CASE WHEN fldid IN (SELECT  s.fldId FROM     Drd.tblCodhayeDaramd AS s left JOIN
								  Drd.tblCodhayeDaramd AS p ON  s.fldDaramadId = p.fldDaramadId.GetAncestor(1)
								  WHERE p.fldDaramadId IS NULL AND s.fldId=c.fldid) THEN N'1' ELSE '0' END AS LastNode
				 FROM Drd.tblCodhayeDaramd AS C  inner join @temp as e on e.idcode=c.fldid
				 WHERE C.fldLevel<>0  and ShomareHId LIKE @ShomareHesabId)t
				  WHERE   LastNode=1 and Mablagh<>0
				  )t

				  INSERT INTO @table/*آموزش و پرورش*/
				select b,a,mablagh,[count],fldtarikh,fldShomareHesab,@ShomareHesabId fldShomareHesabId,0  P_IdCode from
				 (SELECT distinct  *,'_' b   ,N'آموزش و پرورش'as a 
				 FROM (	SELECT sum(fldAmuzesh) over (partition by fldtarikh,ShomareHId) as Mablagh
							,count(c)over (partition by fldtarikh,ShomareHId) as [Count],e.fldtarikh
							,(SELECT  TOP(1)  fldShomareHesab FROM        
								  Com.tblShomareHesabeOmoomi WHERE tblShomareHesabeOmoomi.fldid=ShomareHId /*AND fldOrganId=@OrganId*/) fldShomareHesab
			
							 FROM @temp as e 
					 where ShomareHId LIKE @ShomareHesabId
					 )s
				WHERE     Mablagh<>0
				)t

				SELECT P_DaramdCode,P_DaramadTitle,SUM(Mablagh) AS Mablagh,Sum(Tedad) AS [Count],fldTarikh,fldShomareHesab,fldShomareHesabId from @table
				 group by P_DaramdCode,P_DaramadTitle,fldTarikh,fldShomareHesab,fldShomareHesabId,P_Idcode
				 order by min(fldtarikh)
				END
			end
	ELSE
	BEGIN
			if(@DateType=1)/*براساس تاریخ پرداخت*/
			begin
				INSERT INTO @temp
				SELECT     tblCodhayeDaramd_1.fldid,   tblCodhayeDaramd_1.fldDaramadCode, Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad, Com.tblShomareHesabeOmoomi.fldShomareHesab, 
									   ISNULL(cast((Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifAsliValue * Drd.tblCodhayeDaramadiElamAvarez.fldTedad + Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifAvarezValue + Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifMaliyatValue+fldTakhfifAmuzeshParvareshValue)as bigint),
										  cast((Drd.tblCodhayeDaramadiElamAvarez.fldAsliValue * Drd.tblCodhayeDaramadiElamAvarez.fldTedad + Drd.tblCodhayeDaramadiElamAvarez.fldAvarezValue + Drd.tblCodhayeDaramadiElamAvarez.fldMaliyatValue+fldAmuzeshParvareshValue)as bigint))
					AS fldmablaghCodeDaramad, '0' AS Expr1, tblCodhayeDaramd_1.fldDaramadId,tblPardakhtFish.fldTarikh,tblPardakhtFish.fldId,Drd.tblSodoorFish.fldShomareHesabId
					,isnull(fldTakhfifMaliyatValue,fldMaliyatValue)fldMaliyatValue,isnull(fldTakhfifAvarezValue,fldAvarezValue)fldAvarezValue ,isnull(fldTakhfifAmuzeshParvareshValue,fldAmuzeshParvareshValue)fldAmuzeshParvareshValue 
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
				SELECT idcode,fldDaramadCode,fldSharheCodeDaramad,fldShomareHesab, cast(cast(fldMablaghNaghdi as numeric(50))*cast(fldmablaghCodeDaramad as numeric(50))/cast(fldmablaghKoli as numeric(50))as bigint),'1'
				,fldDaramadId,fldTarikh,fldId,fldShomareHesabId	,fldMaliyatValue,fldAvarezValue ,cast(cast(fldMablaghNaghdi as numeric(50))*cast(fldAmuzeshParvareshValue as numeric(50))/cast(fldmablaghKoli as numeric(50))as bigint) fldAmuzeshParvareshValue
				 FROM 
				(SELECT   DISTINCT    Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId, tblCodhayeDaramd_1.fldDaramadCode, tblCodhayeDaramd_1.fldid idcode,
										 Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad
										-- ,SUM(fldMablagh) OVER (PARTITION BY fldReplyTaghsitId,tblNaghdi_Talab.fldShomareHesabId) AS fldMablaghNaghdi
										,Drd.fn_SumMablaghNaghdi('Naghdi_Talab',tblNaghdi_Talab.fldFishId,tblNaghdi_Talab.fldShomareHesabId,@azTarikh ,@Tatarikh) AS fldMablaghNaghdi
										,fldShomareHesab ,fldReplyTaghsitId
					,ISNULL(SUM(fldTakhfifAsliValue*fldTedad+fldTakhfifAvarezValue+fldTakhfifMaliyatValue+fldTakhfifAmuzeshParvareshValue),SUM(fldAsliValue*fldTedad+fldAvarezValue+fldMaliyatValue+fldAmuzeshParvareshValue)) AS fldmablaghCodeDaramad
					,(SELECT TOP(1) ISNULL(SUM(fldTakhfifAsliValue*fldTedad+fldTakhfifAvarezValue+fldTakhfifMaliyatValue+fldTakhfifAmuzeshParvareshValue) OVER (PARTITION BY tblCodhayeDaramadiElamAvarez.fldElamAvarezId),SUM(fldAsliValue*fldTedad+fldAvarezValue+fldMaliyatValue+fldAmuzeshParvareshValue) OVER (PARTITION BY tblCodhayeDaramadiElamAvarez.fldElamAvarezId)) FROM Drd.tblCodhayeDaramadiElamAvarez AS a WHERE a.fldElamAvarezId =Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId) AS fldmablaghKoli
				,tblCodhayeDaramd_1.fldDaramadId,tblPardakhtFish.fldTarikh,tblPardakhtFish.fldId,Drd.tblNaghdi_Talab.fldShomareHesabId
				,isnull(fldTakhfifMaliyatValue,fldMaliyatValue)fldMaliyatValue,isnull(fldTakhfifAvarezValue,fldAvarezValue)fldAvarezValue,isnull(fldTakhfifAmuzeshParvareshValue,fldAmuzeshParvareshValue)fldAmuzeshParvareshValue,tblNaghdi_Talab.fldFishId 
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
										
										 
										 GROUP BY tblRequestTaghsit_Takhfif.fldElamAvarezId,tblCodhayeDaramd_1.fldDaramadCode,tblCodhayeDaramd_1.fldid, 
										 Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad,fldMablagh,fldReplyTaghsitId, tblCodhayeDaramadiElamAvarez.fldElamAvarezId
										 ,tblNaghdi_Talab.fldShomareHesabId,fldShomareHesab,fldDaramadId,tblPardakhtFish.fldTarikh,tblPardakhtFish.fldId,Drd.tblNaghdi_Talab.fldShomareHesabId
										,fldMaliyatValue,fldAvarezValue,fldTakhfifMaliyatValue,fldTakhfifAvarezValue,tblNaghdi_Talab.fldFishId ,fldTakhfifAmuzeshParvareshValue,fldAmuzeshParvareshValue
										 )t

				end
				else if(@DateType=0)/*براساس تاریخ واریز*/
				begin
					INSERT INTO @temp
				SELECT      tblCodhayeDaramd_1.fldid,  tblCodhayeDaramd_1.fldDaramadCode, Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad, Com.tblShomareHesabeOmoomi.fldShomareHesab, 
									   ISNULL(cast((Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifAsliValue * Drd.tblCodhayeDaramadiElamAvarez.fldTedad + Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifAvarezValue + Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifMaliyatValue+fldTakhfifAmuzeshParvareshValue)as bigint),
										  cast((Drd.tblCodhayeDaramadiElamAvarez.fldAsliValue * Drd.tblCodhayeDaramadiElamAvarez.fldTedad + Drd.tblCodhayeDaramadiElamAvarez.fldAvarezValue + Drd.tblCodhayeDaramadiElamAvarez.fldMaliyatValue+fldAmuzeshParvareshValue)as bigint))
					AS fldmablaghCodeDaramad, '0' AS Expr1, tblCodhayeDaramd_1.fldDaramadId,tblPardakhtFish.fldTarikhVariz,tblPardakhtFish.fldId,Drd.tblSodoorFish.fldShomareHesabId
					,isnull(fldTakhfifMaliyatValue,fldMaliyatValue)fldMaliyatValue,isnull(fldTakhfifAvarezValue,fldAvarezValue)fldAvarezValue ,isnull(fldTakhfifAmuzeshParvareshValue,fldAmuzeshParvareshValue)fldAmuzeshParvareshValue 
				FROM            Drd.tblSodoorFish INNER JOIN
										 Drd.tblSodoorFish_Detail ON Drd.tblSodoorFish.fldId = Drd.tblSodoorFish_Detail.fldFishId INNER JOIN
										 Drd.tblCodhayeDaramadiElamAvarez ON Drd.tblSodoorFish_Detail.fldCodeElamAvarezId = Drd.tblCodhayeDaramadiElamAvarez.fldID INNER JOIN
										 Drd.tblShomareHesabCodeDaramad ON Drd.tblCodhayeDaramadiElamAvarez.fldShomareHesabCodeDaramadId = Drd.tblShomareHesabCodeDaramad.fldId AND 
										 Drd.tblCodhayeDaramadiElamAvarez.fldShomareHesabCodeDaramadId = Drd.tblShomareHesabCodeDaramad.fldId INNER JOIN
										 Drd.tblCodhayeDaramd AS tblCodhayeDaramd_1 ON Drd.tblShomareHesabCodeDaramad.fldCodeDaramadId = tblCodhayeDaramd_1.fldId INNER JOIN
										 Drd.tblPardakhtFish ON Drd.tblSodoorFish.fldId = Drd.tblPardakhtFish.fldFishId AND Drd.tblSodoorFish.fldId = Drd.tblPardakhtFish.fldFishId INNER JOIN
										 Com.tblShomareHesabeOmoomi ON Drd.tblSodoorFish.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId
				 WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId)
										 AND CAST( tblPardakhtFish.fldDateVariz AS DATE) BETWEEN @StartDate AND @EndDate
								
								 
								 
				--GROUP BY tblCodhayeDaramd_1.fldDaramadCode, Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad,fldShomareHesab,fldDaramadId

				
				UNION all
				SELECT idcode, fldDaramadCode,fldSharheCodeDaramad,fldShomareHesab, cast(cast(fldMablaghNaghdi as numeric(50))*cast(fldmablaghCodeDaramad as numeric(50))/cast(fldmablaghKoli as numeric(50))as bigint),'1'
				,fldDaramadId,fldTarikhVariz,fldId,fldShomareHesabId	,fldMaliyatValue,fldAvarezValue ,cast(cast(fldMablaghNaghdi as numeric(50))*cast(fldAmuzeshParvareshValue as numeric(50))/cast(fldmablaghKoli as numeric(50))as bigint) fldAmuzeshParvareshValue
				 FROM 
				(SELECT   DISTINCT    Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId, tblCodhayeDaramd_1.fldDaramadCode, tblCodhayeDaramd_1.fldid idcode,
										 Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad
										-- ,SUM(fldMablagh) OVER (PARTITION BY fldReplyTaghsitId,tblNaghdi_Talab.fldShomareHesabId) AS fldMablaghNaghdi
										,Drd.fn_SumMablaghNaghdiVariz('Naghdi_Talab',tblNaghdi_Talab.fldFishId,tblNaghdi_Talab.fldShomareHesabId,@azTarikh ,@Tatarikh) AS fldMablaghNaghdi
										,fldShomareHesab ,fldReplyTaghsitId
					,ISNULL(SUM(fldTakhfifAsliValue*fldTedad+fldTakhfifAvarezValue+fldTakhfifMaliyatValue+fldTakhfifAmuzeshParvareshValue),SUM(fldAsliValue*fldTedad+fldAvarezValue+fldMaliyatValue+fldAmuzeshParvareshValue)) AS fldmablaghCodeDaramad
					,(SELECT TOP(1) ISNULL(SUM(fldTakhfifAsliValue*fldTedad+fldTakhfifAvarezValue+fldTakhfifMaliyatValue+fldTakhfifAmuzeshParvareshValue) OVER (PARTITION BY tblCodhayeDaramadiElamAvarez.fldElamAvarezId),SUM(fldAsliValue*fldTedad+fldAvarezValue+fldMaliyatValue+fldAmuzeshParvareshValue) OVER (PARTITION BY tblCodhayeDaramadiElamAvarez.fldElamAvarezId)) FROM Drd.tblCodhayeDaramadiElamAvarez AS a WHERE a.fldElamAvarezId =Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId) AS fldmablaghKoli
				,tblCodhayeDaramd_1.fldDaramadId,tblPardakhtFish.fldTarikhVariz,tblPardakhtFish.fldId,Drd.tblNaghdi_Talab.fldShomareHesabId
				,isnull(fldTakhfifMaliyatValue,fldMaliyatValue)fldMaliyatValue,isnull(fldTakhfifAvarezValue,fldAvarezValue)fldAvarezValue,isnull(fldTakhfifAmuzeshParvareshValue,fldAmuzeshParvareshValue)fldAmuzeshParvareshValue,tblNaghdi_Talab.fldFishId 
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
										
										 
										 GROUP BY tblRequestTaghsit_Takhfif.fldElamAvarezId,tblCodhayeDaramd_1.fldDaramadCode, tblCodhayeDaramd_1.fldid,
										 Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad,fldMablagh,fldReplyTaghsitId, tblCodhayeDaramadiElamAvarez.fldElamAvarezId
										 ,tblNaghdi_Talab.fldShomareHesabId,fldShomareHesab,fldDaramadId,tblPardakhtFish.fldTarikhVariz,tblPardakhtFish.fldId,Drd.tblNaghdi_Talab.fldShomareHesabId
										,fldMaliyatValue,fldAvarezValue,fldTakhfifMaliyatValue,fldTakhfifAvarezValue,tblNaghdi_Talab.fldFishId ,fldAmuzeshParvareshValue,fldTakhfifAmuzeshParvareshValue
										 )t
				end	
					------------------------------------------------------- وصول شده

				INSERT INTO @temp
				 
				SELECT  idcode,fldDaramadCode,fldSharheCodeDaramad,fldShomareHesab, cast((cast(cast(fldMablagh as numeric)/cast(fldmablaghKoli as  numeric)as  numeric(38,20))*fldmablaghCodeDaramad)  as bigint),'2',fldDaramadId,fldDateStatus,
				fldid,fldShomareHesabIdOrgan,	fldMaliyatValue,fldAvarezValue ,cast((cast(cast(fldMablagh as numeric)/cast(fldmablaghKoli as  numeric)as  numeric(38,20))*fldAmuzeshParvareshValue)  as bigint) fldAmuzeshParvareshValue
				 FROM 
				(SELECT   DISTINCT    Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId, tblCodhayeDaramd_1.fldDaramadCode, tblCodhayeDaramd_1.fldid idcode,
										 Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad
										-- ,SUM(fldMablagh) OVER (PARTITION BY fldReplyTaghsitId,tblNaghdi_Talab.fldShomareHesabId) AS fldMablaghNaghdi
										,Drd.fn_SumMablaghNaghdi('Check',fldReplyTaghsitId,tblCheck.fldShomareHesabIdOrgan,@azTarikh ,@Tatarikh) AS fldMablagh
										,fldShomareHesab ,fldReplyTaghsitId
					,ISNULL(SUM(fldTakhfifAsliValue*fldTedad+fldTakhfifAvarezValue+fldTakhfifMaliyatValue+fldTakhfifAmuzeshParvareshValue),SUM(fldAsliValue*fldTedad+fldAvarezValue+fldMaliyatValue+fldAmuzeshParvareshValue)) AS fldmablaghCodeDaramad
					,(SELECT TOP(1) ISNULL(SUM(fldTakhfifAsliValue*fldTedad+fldTakhfifAvarezValue+fldTakhfifMaliyatValue+fldTakhfifAmuzeshParvareshValue) OVER (PARTITION BY tblCodhayeDaramadiElamAvarez.fldElamAvarezId),SUM(fldAsliValue*fldTedad+fldAvarezValue+fldMaliyatValue+fldAmuzeshParvareshValue) OVER (PARTITION BY tblCodhayeDaramadiElamAvarez.fldElamAvarezId)) FROM Drd.tblCodhayeDaramadiElamAvarez AS a WHERE a.fldElamAvarezId =Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId) AS fldmablaghKoli
				,tblCodhayeDaramd_1.fldDaramadId,fldDateStatus,tblcheck.fldid,tblCheck.fldShomareHesabIdOrgan
				,isnull(fldTakhfifMaliyatValue,fldMaliyatValue)fldMaliyatValue,isnull(fldTakhfifAvarezValue,fldAvarezValue)fldAvarezValue ,isnull(fldTakhfifAmuzeshParvareshValue,fldAmuzeshParvareshValue)fldAmuzeshParvareshValue
					
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
										AND tblCheck .fldStatus=2 AND fldTypeSanad=0 
										AND (Drd.tblCheck.fldDateStatus ) BETWEEN @AzTarikh AND @TaTarikh
										 GROUP BY tblRequestTaghsit_Takhfif.fldElamAvarezId,tblCodhayeDaramd_1.fldDaramadCode, tblCodhayeDaramd_1.fldid,
										 Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad,fldMablaghSanad,fldReplyTaghsitId, tblCodhayeDaramadiElamAvarez.fldElamAvarezId
										 ,tblCheck.fldShomareHesabIdOrgan,fldShomareHesab,fldDaramadId,fldDateStatus,tblcheck.fldid,tblCheck.fldShomareHesabIdOrgan
										 	,fldMaliyatValue,fldAvarezValue,fldTakhfifMaliyatValue,fldTakhfifAvarezValue,fldTakhfifAmuzeshParvareshValue,fldAmuzeshParvareshValue
										 )t


				INSERT INTO @temp
			
				 SELECT idcode, fldDaramadCode,fldSharheCodeDaramad,fldShomareHesab, cast((cast(cast(fldMablagh as numeric)/cast(fldmablaghKoli as  numeric)as  numeric(38,20))*fldmablaghCodeDaramad)  as bigint)
				 ,'3',fldDaramadId,fldDateStatus,fldid ,fldShomareHesadId
			,fldMaliyatValue,fldAvarezValue ,cast((cast(cast(fldMablagh as numeric)/cast(fldmablaghKoli as  numeric)as  numeric(38,20))*fldAmuzeshParvareshValue)  as bigint) fldAmuzeshParvareshValue
			FROM 
				(SELECT   DISTINCT    Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId, tblCodhayeDaramd_1.fldDaramadCode, tblCodhayeDaramd_1.fldid idcode,
										 Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad
										-- ,SUM(fldMablagh) OVER (PARTITION BY fldReplyTaghsitId,tblNaghdi_Talab.fldShomareHesabId) AS fldMablaghNaghdi
										,Drd.fn_SumMablaghNaghdi('Safte',fldReplyTaghsitId,tblShomareHesabCodeDaramad.fldShomareHesadId,@AzTarikh , @Tatarikh) AS fldMablagh
										,fldShomareHesab ,fldReplyTaghsitId
					,ISNULL(SUM(fldTakhfifAsliValue*fldTedad+fldTakhfifAvarezValue+fldTakhfifMaliyatValue+fldTakhfifAmuzeshParvareshValue),SUM(fldAsliValue*fldTedad+fldAvarezValue+fldMaliyatValue+fldAmuzeshParvareshValue)) AS fldmablaghCodeDaramad
					,(SELECT TOP(1) ISNULL(SUM(fldTakhfifAsliValue*fldTedad+fldTakhfifAvarezValue+fldTakhfifMaliyatValue+fldTakhfifAmuzeshParvareshValue) OVER (PARTITION BY tblCodhayeDaramadiElamAvarez.fldElamAvarezId),
					SUM(fldAsliValue*fldTedad+fldAvarezValue+fldMaliyatValue+fldAmuzeshParvareshValue) OVER (PARTITION BY tblCodhayeDaramadiElamAvarez.fldElamAvarezId)) FROM Drd.tblCodhayeDaramadiElamAvarez AS a WHERE a.fldElamAvarezId =Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId) AS fldmablaghKoli
				,tblCodhayeDaramd_1.fldDaramadId,fldDateStatus,tblSafte.fldid,tblShomareHesabCodeDaramad.fldShomareHesadId
				,isnull(fldTakhfifMaliyatValue,fldMaliyatValue) AS fldMaliyatValue,isnull(fldTakhfifAvarezValue,fldAvarezValue) AS fldAvarezValue ,isnull(fldTakhfifAmuzeshParvareshValue,fldAmuzeshParvareshValue) AS fldAmuzeshParvareshValue 
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
										 GROUP BY tblRequestTaghsit_Takhfif.fldElamAvarezId,tblCodhayeDaramd_1.fldDaramadCode,tblCodhayeDaramd_1.fldid, 
										 Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad,fldMablaghSanad,fldReplyTaghsitId, tblCodhayeDaramadiElamAvarez.fldElamAvarezId
										 ,tblShomareHesabCodeDaramad.fldShomareHesadId,fldShomareHesab,fldDaramadId,fldDateStatus,tblSafte.fldid,tblShomareHesabCodeDaramad.fldShomareHesadId
										 	,fldMaliyatValue,fldAvarezValue,fldTakhfifMaliyatValue,fldTakhfifAvarezValue,fldTakhfifAmuzeshParvareshValue,fldAmuzeshParvareshValue
										 )t

				INSERT INTO @temp
				SELECT idcode, fldDaramadCode,fldSharheCodeDaramad,fldShomareHesab, cast((cast(cast(fldMablagh as numeric)/cast(fldmablaghKoli as  numeric)as  numeric(38,20))*fldmablaghCodeDaramad)  as bigint),'4',fldDaramadId,fldDateStatus,fldid 
				,fldShomareHesadId 	,fldMaliyatValue,fldAvarezValue ,  cast((cast(cast(fldMablagh as numeric)/cast(fldmablaghKoli as  numeric)as  numeric(38,20))*fldAmuzeshParvareshValue)  as bigint) fldAmuzeshParvareshValue
				FROM 
				(SELECT   DISTINCT    Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId, tblCodhayeDaramd_1.fldDaramadCode, tblCodhayeDaramd_1.fldid idcode, 
										 Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad
										-- ,SUM(fldMablagh) OVER (PARTITION BY fldReplyTaghsitId,tblNaghdi_Talab.fldShomareHesabId) AS fldMablaghNaghdi
										,Drd.fn_SumMablaghNaghdi('Barat',fldReplyTaghsitId,tblShomareHesabCodeDaramad.fldShomareHesadId,@AzTarikh,@TaTarikh) AS fldMablagh
										,fldShomareHesab ,fldReplyTaghsitId
					,ISNULL(SUM(fldTakhfifAsliValue*fldTedad+fldTakhfifAvarezValue+fldTakhfifMaliyatValue+fldTakhfifAmuzeshParvareshValue),SUM(fldAsliValue*fldTedad+fldAvarezValue+fldMaliyatValue+fldAmuzeshParvareshValue)) AS fldmablaghCodeDaramad
					,(SELECT TOP(1) ISNULL(SUM(fldTakhfifAsliValue*fldTedad+fldTakhfifAvarezValue+fldTakhfifMaliyatValue+fldTakhfifAmuzeshParvareshValue) OVER (PARTITION BY tblCodhayeDaramadiElamAvarez.fldElamAvarezId),SUM(fldAsliValue*fldTedad+fldAvarezValue+fldMaliyatValue+fldAmuzeshParvareshValue) OVER (PARTITION BY tblCodhayeDaramadiElamAvarez.fldElamAvarezId)) FROM Drd.tblCodhayeDaramadiElamAvarez AS a WHERE a.fldElamAvarezId =Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId) AS fldmablaghKoli
				,tblCodhayeDaramd_1.fldDaramadId,fldDateStatus,tblbarat.fldid,tblShomareHesabCodeDaramad.fldShomareHesadId
				,isnull(fldTakhfifMaliyatValue,fldMaliyatValue)fldMaliyatValue,isnull(fldTakhfifAvarezValue,fldAvarezValue)fldAvarezValue,isnull(fldTakhfifAmuzeshParvareshValue,fldAmuzeshParvareshValue)fldAmuzeshParvareshValue 
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
										 GROUP BY tblRequestTaghsit_Takhfif.fldElamAvarezId,tblCodhayeDaramd_1.fldDaramadCode, tblCodhayeDaramd_1.fldid,
										 Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad,fldMablaghSanad,fldReplyTaghsitId, tblCodhayeDaramadiElamAvarez.fldElamAvarezId
										 ,tblShomareHesabCodeDaramad.fldShomareHesadId,fldShomareHesab,fldDaramadId,fldDateStatus,tblbarat.fldid,tblShomareHesabCodeDaramad.fldShomareHesadId
											,fldMaliyatValue,fldAvarezValue,fldTakhfifMaliyatValue,fldTakhfifAvarezValue,fldTakhfifAmuzeshParvareshValue,fldAmuzeshParvareshValue
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
				
								 
				IF(@ShomareHesabId<>0 AND @CodeDaramadId<>0 and @CodeDaramadId<>-3)
				BEGIN
				INSERT INTO @table
				 SELECT DISTINCT P_DaramadCode,P_DaramadTitle,Mablagh,[Count],fldtarikh,fldShomareHesab,fldShomareHesabId ,p_IdCode
				 FROM
				(SELECT	ISNULL((SELECT d.fldStrhid FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_hid,
				ISNULL((SELECT fldDaramadCode FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_DaramadCode,
				ISNULL((SELECT d.fldid FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId ),'') AS p_IdCode,
				ISNULL((SELECT fldDaramadTitle FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_DaramadTitle,
				ISNULL((SELECT fldLevel FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_Level
				--,ISNULL((SELECT SUM(mablaghcodeDaramad) FROM @temp WHERE Daramadcode=C.fldDaramadCode) ,ISNULL((SELECT SUM(mablaghcodeDaramad) FROM @temp AS t WHERE t.hid.ToString() LIKE c.fldStrhid+'%'),0)) AS Mablagh
				,sum(mablaghcodeDaramad) over (partition by fldtarikh,e.idcode) as Mablagh
				,count(c)over (partition by fldtarikh,e.idcode) as [Count],e.fldtarikh
				--,ISNULL((SELECT fldtarikh FROM @temp WHERE Daramadcode=C.fldDaramadCode group by fldtarikh),'') as fldtarikh
				,(SELECT  TOP(1)  fldShomareHesab FROM   
									  Com.tblShomareHesabeOmoomi  WHERE tblShomareHesabeOmoomi.fldid=e.ShomareHId /*AND fldOrganId=@OrganId*/) fldShomareHesab
				 --,(SELECT  TOP(1)  fldShomareHesadId FROM  Drd.tblShomareHesabCodeDaramad WHERE fldCodeDaramadId=C.fldId /*AND fldOrganId=@OrganId*/)
				 ,@ShomareHesabId as  fldShomareHesabId
				 ,CASE WHEN fldid IN (SELECT  s.fldId FROM     Drd.tblCodhayeDaramd AS s left JOIN
								  Drd.tblCodhayeDaramd AS p ON  s.fldDaramadId = p.fldDaramadId.GetAncestor(1)
								  WHERE p.fldDaramadId IS NULL AND s.fldId=c.fldid) THEN N'1' ELSE '0' END AS LastNode
				 FROM Drd.tblCodhayeDaramd AS C  inner join @temp as e on e.idcode=c.fldid
				 WHERE C.fldLevel<>0 and ShomareHId=@ShomareHesabId  AND C.fldId IN (SELECT id FROM @code))s
				 WHERE     LastNode=1 and Mablagh<>0
				 order by fldtarikh
				 
				 SELECT P_DaramdCode,P_DaramadTitle,SUM(Mablagh) AS Mablagh,Sum(Tedad) AS [Count],fldTarikh,fldShomareHesab,fldShomareHesabId from @table
				 group by P_DaramdCode,P_DaramadTitle,fldTarikh,fldShomareHesab,fldShomareHesabId,P_Idcode
				 order by min(fldtarikh)
				 END


				 IF(@ShomareHesabId<>0 AND @CodeDaramadId=-3)
				BEGIN
				INSERT INTO @table
				 SELECT DISTINCT '_' P_DaramadCode,N'آموزش پرورش'P_DaramadTitle,Mablagh,[Count],fldtarikh,fldShomareHesab,fldShomareHesabId ,0  P_IdCode
				 FROM
				(select sum(fldAmuzesh) over (partition by fldtarikh) as Mablagh
				,count(c)over (partition by fldtarikh) as [Count],e.fldtarikh
				--,ISNULL((SELECT fldtarikh FROM @temp WHERE Daramadcode=C.fldDaramadCode group by fldtarikh),'') as fldtarikh
				,(SELECT  TOP(1)  fldShomareHesab FROM   
									  Com.tblShomareHesabeOmoomi  WHERE tblShomareHesabeOmoomi.fldid=e.ShomareHId /*AND fldOrganId=@OrganId*/) fldShomareHesab
				 --,(SELECT  TOP(1)  fldShomareHesadId FROM  Drd.tblShomareHesabCodeDaramad WHERE fldCodeDaramadId=C.fldId /*AND fldOrganId=@OrganId*/)
				 ,@ShomareHesabId as  fldShomareHesabId
				
				 FROM  @temp e
				 WHERE  ShomareHId=@ShomareHesabId  )s
				 WHERE    Mablagh<>0
				 order by fldtarikh
				 
				 SELECT P_DaramdCode,P_DaramadTitle,SUM(Mablagh) AS Mablagh,Sum(Tedad) AS [Count],fldTarikh,fldShomareHesab,fldShomareHesabId from @table
				 group by P_DaramdCode,P_DaramadTitle,fldTarikh,fldShomareHesab,fldShomareHesabId,P_Idcode
				 order by min(fldtarikh)
				 END

				 
				 ELSE IF(@ShomareHesabId=0 AND @CodeDaramadId=0)
				 BEGIN
					 INSERT INTO @table
					 SELECT DISTINCT P_DaramadCode,P_DaramadTitle,Mablagh,[Count],fldtarikh,fldShomareHesab,fldShomareHesabId ,P_IdCode
					 FROM
					(SELECT
					ISNULL((SELECT d.fldStrhid FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_hid,
					ISNULL((SELECT fldDaramadCode FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_DaramadCode,
					ISNULL((SELECT d.fldid FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId ),'') AS P_IdCode,
					ISNULL((SELECT fldDaramadTitle FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_DaramadTitle,
					ISNULL((SELECT fldLevel FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_Level
					--,ISNULL((SELECT SUM(mablaghcodeDaramad) FROM @temp WHERE Daramadcode=C.fldDaramadCode) ,ISNULL((SELECT SUM(mablaghcodeDaramad) FROM @temp AS t WHERE t.hid.ToString() LIKE c.fldStrhid+'%'),0)) AS Mablagh
					--,ISNULL((SELECT top(1) fldtarikh FROM @temp WHERE Daramadcode=C.fldDaramadCode group by fldtarikh),'') as fldtarikh
					--,ISNULL((SELECT top(1)  count(c) FROM @temp WHERE Daramadcode=C.fldDaramadCode group by fldtarikh,Daramadcode),'') as c
					,sum(mablaghcodeDaramad) over (partition by fldtarikh,e.idcode) as Mablagh
					,count(c)over (partition by fldtarikh,e.idcode) as [Count],e.fldtarikh
					,(SELECT  TOP(1)  fldShomareHesab FROM   
										  Com.tblShomareHesabeOmoomi  WHERE tblShomareHesabeOmoomi.fldid=e.ShomareHId /*AND fldOrganId=@OrganId*/) fldShomareHesab
					 --,(SELECT  TOP(1)  fldShomareHesadId FROM  Drd.tblShomareHesabCodeDaramad WHERE fldCodeDaramadId=C.fldId /*AND fldOrganId=@OrganId*/)
					 ,ShomareHId as  fldShomareHesabId				
					  ,CASE WHEN fldid IN (SELECT  s.fldId FROM     Drd.tblCodhayeDaramd AS s left JOIN
									  Drd.tblCodhayeDaramd AS p ON  s.fldDaramadId = p.fldDaramadId.GetAncestor(1)
									  WHERE p.fldDaramadId IS NULL AND s.fldId=c.fldid) THEN N'1' ELSE '0' END AS LastNode
					 FROM Drd.tblCodhayeDaramd AS C  inner join @temp as e on e.idcode=c.fldid
					 WHERE C.fldLevel<>0) t
					 where  LastNode=1 and Mablagh<>0 
					 order by fldtarikh

					 INSERT INTO @table
					 SELECT DISTINCT '_' P_DaramadCode,N'آموزش پرورش'P_DaramadTitle,Mablagh,[Count],fldtarikh,fldShomareHesab,fldShomareHesabId ,0  P_IdCode
					 FROM
					(select sum(fldAmuzesh) over (partition by fldtarikh) as Mablagh
					,count(c)over (partition by fldtarikh) as [Count],e.fldtarikh
					--,ISNULL((SELECT fldtarikh FROM @temp WHERE Daramadcode=C.fldDaramadCode group by fldtarikh),'') as fldtarikh
					,(SELECT  TOP(1)  fldShomareHesab FROM   
										  Com.tblShomareHesabeOmoomi  WHERE tblShomareHesabeOmoomi.fldid=e.ShomareHId /*AND fldOrganId=@OrganId*/) fldShomareHesab
					 --,(SELECT  TOP(1)  fldShomareHesadId FROM  Drd.tblShomareHesabCodeDaramad WHERE fldCodeDaramadId=C.fldId /*AND fldOrganId=@OrganId*/)
					 ,@ShomareHesabId as  fldShomareHesabId
				
					 FROM  @temp e
					    )s
					 WHERE    Mablagh<>0
					 order by fldtarikh
				 	
				 	SELECT P_DaramdCode,P_DaramadTitle,SUM(Mablagh) AS Mablagh,Sum(Tedad) AS [Count],fldTarikh,fldShomareHesab,fldShomareHesabId from @table
					GROUP BY P_DaramdCode,P_DaramadTitle,fldTarikh,fldShomareHesab,fldShomareHesabId,P_Idcode
					ORDER by min(fldtarikh)
				 end
			
				  ELSE IF(@ShomareHesabId=0 AND @CodeDaramadId=-3)
				 BEGIN
					 INSERT INTO @table
					 SELECT DISTINCT '_'P_DaramadCode,N'آموزش و پرورش'P_DaramadTitle,Mablagh,[Count],fldtarikh,fldShomareHesab,fldShomareHesabId ,0  P_IdCode
					 FROM
					(SELECT sum(fldAmuzesh) over (partition by fldtarikh) as Mablagh
					,count(c)over (partition by fldtarikh) as [Count],e.fldtarikh
					,(SELECT  TOP(1)  fldShomareHesab FROM   
										  Com.tblShomareHesabeOmoomi  WHERE tblShomareHesabeOmoomi.fldid=e.ShomareHId /*AND fldOrganId=@OrganId*/) fldShomareHesab
					 --,(SELECT  TOP(1)  fldShomareHesadId FROM  Drd.tblShomareHesabCodeDaramad WHERE fldCodeDaramadId=C.fldId /*AND fldOrganId=@OrganId*/)
					 ,ShomareHId as  fldShomareHesabId				
					
					 FROM  @temp as e
					  ) t
					 where   Mablagh<>0 
					 order by fldtarikh
				 	
				 	SELECT P_DaramdCode,P_DaramadTitle,SUM(Mablagh) AS Mablagh,Sum(Tedad) AS [Count],fldTarikh,fldShomareHesab,fldShomareHesabId from @table
					GROUP BY P_DaramdCode,P_DaramadTitle,fldTarikh,fldShomareHesab,fldShomareHesabId,P_Idcode
					ORDER by min(fldtarikh)
				 end
				
				ELSE IF(@ShomareHesabId=0 AND @CodeDaramadId<>0 and  @CodeDaramadId<>-3)
				BEGIN
					 INSERT INTO @table
					 SELECT DISTINCT P_DaramadCode,P_DaramadTitle,Mablagh,[Count],fldtarikh,fldShomareHesab,fldShomareHesabId ,P_IdCode
					 FROM
					(SELECT
					ISNULL((SELECT d.fldStrhid FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_hid,
					ISNULL((SELECT fldDaramadCode FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_DaramadCode,
					ISNULL((SELECT d.fldid FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId ),'') AS P_IdCode,
					ISNULL((SELECT fldDaramadTitle FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_DaramadTitle,
					ISNULL((SELECT fldLevel FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_Level
					--,ISNULL((SELECT SUM(mablaghcodeDaramad)over (partition by fldtarikh) FROM @temp WHERE Daramadcode=C.fldDaramadCode) ,ISNULL((SELECT SUM(mablaghcodeDaramad) FROM @temp AS t WHERE t.hid.ToString() LIKE c.fldStrhid+'%'),0)) AS Mablagh
					,sum(mablaghcodeDaramad) over (partition by fldtarikh,e.idcode) as Mablagh
					,count(c)over (partition by fldtarikh,e.idcode) as [Count],e.fldtarikh
					,(SELECT  TOP(1)  fldShomareHesab FROM   
										  Com.tblShomareHesabeOmoomi  WHERE tblShomareHesabeOmoomi.fldid=e.ShomareHId /*AND fldOrganId=@OrganId*/) fldShomareHesab
					 --,(SELECT  TOP(1)  fldShomareHesadId FROM  Drd.tblShomareHesabCodeDaramad WHERE fldCodeDaramadId=C.fldId /*AND fldOrganId=@OrganId*/)
					 ,ShomareHId as  fldShomareHesabId				
					  ,CASE WHEN fldid IN (SELECT  s.fldId FROM     Drd.tblCodhayeDaramd AS s left JOIN
									  Drd.tblCodhayeDaramd AS p ON  s.fldDaramadId = p.fldDaramadId.GetAncestor(1)
									  WHERE p.fldDaramadId IS NULL AND s.fldId=c.fldid) THEN N'1' ELSE '0' END AS LastNode
					 FROM Drd.tblCodhayeDaramd AS C inner join @temp as e on e.idcode=c.fldid
					 WHERE C.fldLevel<>0   AND C.fldId IN (SELECT id FROM @code))t
					 where    LastNode=1 and Mablagh<>0
					  order by fldtarikh
					  
			   		 SELECT P_DaramdCode,P_DaramadTitle,SUM(Mablagh) AS Mablagh,Sum(Tedad) AS [Count],fldTarikh,fldShomareHesab,fldShomareHesabId from @table
					 group by P_DaramdCode,P_DaramadTitle,fldTarikh,fldShomareHesab,fldShomareHesabId,P_Idcode
					 ORDER by min(fldtarikh)
				END 


				ELSE  IF(@ShomareHesabId<>0 AND @CodeDaramadId=0)
				BEGIN
					INSERT INTO @table
					 SELECT DISTINCT P_DaramadCode,P_DaramadTitle,Mablagh,[Count],fldtarikh,fldShomareHesab,fldShomareHesabId ,P_IdCode
					 FROM(SELECT
					ISNULL((SELECT d.fldStrhid FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_hid,
					ISNULL((SELECT fldDaramadCode FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_DaramadCode,
					ISNULL((SELECT d.fldId FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId ),'') AS P_IdCode,
					ISNULL((SELECT fldDaramadTitle FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_DaramadTitle,
					ISNULL((SELECT fldLevel FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_Level
					--,ISNULL((SELECT SUM(mablaghcodeDaramad) FROM @temp WHERE Daramadcode=C.fldDaramadCode) ,ISNULL((SELECT SUM(mablaghcodeDaramad) FROM @temp AS t WHERE t.hid.ToString() LIKE c.fldStrhid+'%'),0)) AS Mablagh
					--,ISNULL((SELECT fldtarikh FROM @temp WHERE Daramadcode=C.fldDaramadCode group by fldtarikh),'') as fldtarikh
					,sum(mablaghcodeDaramad) over (partition by fldtarikh,e.idcode) as Mablagh
					,count(c)over (partition by fldtarikh,e.idcode) as [Count],e.fldtarikh
					,(SELECT  TOP(1)  fldShomareHesab FROM   
										  Com.tblShomareHesabeOmoomi  WHERE tblShomareHesabeOmoomi.fldid=e.ShomareHId /*AND fldOrganId=@OrganId*/) fldShomareHesab
					 --,(SELECT  TOP(1)  fldShomareHesadId FROM  Drd.tblShomareHesabCodeDaramad WHERE fldCodeDaramadId=C.fldId /*AND fldOrganId=@OrganId*/)
					 ,@ShomareHesabId as  fldShomareHesabId				
					  ,CASE WHEN fldid IN (SELECT  s.fldId FROM     Drd.tblCodhayeDaramd AS s left JOIN
									  Drd.tblCodhayeDaramd AS p ON  s.fldDaramadId = p.fldDaramadId.GetAncestor(1)
									  WHERE p.fldDaramadId IS NULL AND s.fldId=c.fldid) THEN N'1' ELSE '0' END AS LastNode
					 FROM Drd.tblCodhayeDaramd AS C  inner join @temp as e on e.idcode=c.fldid
					 WHERE C.fldLevel<>0 and ShomareHId  LIKE @ShomareHesabId  )t
					  WHERE     LastNode=1 and Mablagh<>0
					   order by fldtarikh

					INSERT INTO @table
				 SELECT DISTINCT '_' P_DaramadCode,N'آموزش پرورش'P_DaramadTitle,Mablagh,[Count],fldtarikh,fldShomareHesab,fldShomareHesabId ,0  P_IdCode
				 FROM
				(select sum(fldAmuzesh) over (partition by fldtarikh) as Mablagh
				,count(c)over (partition by fldtarikh) as [Count],e.fldtarikh
				--,ISNULL((SELECT fldtarikh FROM @temp WHERE Daramadcode=C.fldDaramadCode group by fldtarikh),'') as fldtarikh
				,(SELECT  TOP(1)  fldShomareHesab FROM   
									  Com.tblShomareHesabeOmoomi  WHERE tblShomareHesabeOmoomi.fldid=e.ShomareHId /*AND fldOrganId=@OrganId*/) fldShomareHesab
				 --,(SELECT  TOP(1)  fldShomareHesadId FROM  Drd.tblShomareHesabCodeDaramad WHERE fldCodeDaramadId=C.fldId /*AND fldOrganId=@OrganId*/)
				 ,@ShomareHesabId as  fldShomareHesabId
				
				 FROM  @temp e
				 WHERE  ShomareHId=@ShomareHesabId  )s
				 WHERE    Mablagh<>0
				 order by fldtarikh

					 SELECT P_DaramdCode,P_DaramadTitle,SUM(Mablagh) AS Mablagh,Sum(Tedad) AS [Count],fldTarikh,fldShomareHesab,fldShomareHesabId from @table
					 GROUP BY P_DaramdCode,P_DaramadTitle,fldTarikh,fldShomareHesab,fldShomareHesabId,P_Idcode
					 order by min(fldtarikh)
				END
	end
end

IF(@fieldname='All')
BEGIN
		IF(@OrganId<>0)
		BEGIN
			if(@DateType=1)/*براساس تاریخ پرداخت*/
			begin
				INSERT INTO @temp
				SELECT      tblCodhayeDaramd_1.fldid,  tblCodhayeDaramd_1.fldDaramadCode, Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad, Com.tblShomareHesabeOmoomi.fldShomareHesab, 
									   ISNULL(cast((Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifAsliValue * Drd.tblCodhayeDaramadiElamAvarez.fldTedad + Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifAvarezValue + Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifMaliyatValue+fldTakhfifAmuzeshParvareshValue)as bigint),
										  cast((Drd.tblCodhayeDaramadiElamAvarez.fldAsliValue * Drd.tblCodhayeDaramadiElamAvarez.fldTedad + Drd.tblCodhayeDaramadiElamAvarez.fldAvarezValue + Drd.tblCodhayeDaramadiElamAvarez.fldMaliyatValue+fldAmuzeshParvareshValue)as bigint))
					AS fldmablaghCodeDaramad, '0' AS Expr1, tblCodhayeDaramd_1.fldDaramadId,'',0,Drd.tblSodoorFish.fldShomareHesabId 
				,isnull(fldTakhfifMaliyatValue,fldMaliyatValue)fldMaliyatValue,isnull(fldTakhfifAvarezValue,fldAvarezValue)fldAvarezValue ,isnull(fldTakhfifAmuzeshParvareshValue,fldAmuzeshParvareshValue)fldAmuzeshParvareshValue 
			
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
			SELECT  idcode,fldDaramadCode,fldSharheCodeDaramad,fldShomareHesab, cast(cast(fldMablaghNaghdi as numeric(50))*cast(fldmablaghCodeDaramad as numeric(50))/cast(fldmablaghKoli as numeric(50))as bigint),'1'
			,fldDaramadId,'',0,fldShomareHesabId	,fldMaliyatValue,fldAvarezValue ,  cast(cast(fldMablaghNaghdi as numeric(50)) *cast(fldAmuzeshParvareshValue as numeric(50))/cast(fldmablaghKoli as numeric(50))as bigint) fldAmuzeshParvareshValue
			 FROM 
			(SELECT   DISTINCT    Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId, tblCodhayeDaramd_1.fldDaramadCode, tblCodhayeDaramd_1.FLDID idcode,
									 Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad
									-- ,SUM(fldMablagh) OVER (PARTITION BY fldReplyTaghsitId,tblNaghdi_Talab.fldShomareHesabId) AS fldMablaghNaghdi
									,Drd.fn_SumMablaghNaghdi('Naghdi_Talab',tblNaghdi_Talab.fldFishId,tblNaghdi_Talab.fldShomareHesabId,@azTarikh ,@Tatarikh) AS fldMablaghNaghdi
									,fldShomareHesab ,fldReplyTaghsitId
				,ISNULL(SUM(fldTakhfifAsliValue*fldTedad+fldTakhfifAvarezValue+fldTakhfifMaliyatValue+fldTakhfifAmuzeshParvareshValue),SUM(fldAsliValue*fldTedad+fldAvarezValue+fldMaliyatValue+fldAmuzeshParvareshValue)) AS fldmablaghCodeDaramad
				,(SELECT TOP(1) ISNULL(SUM(fldTakhfifAsliValue*fldTedad+fldTakhfifAvarezValue+fldTakhfifMaliyatValue+fldTakhfifAmuzeshParvareshValue) OVER (PARTITION BY tblCodhayeDaramadiElamAvarez.fldElamAvarezId),SUM(fldAsliValue*fldTedad+fldAvarezValue+fldMaliyatValue+fldAmuzeshParvareshValue) OVER (PARTITION BY tblCodhayeDaramadiElamAvarez.fldElamAvarezId)) FROM Drd.tblCodhayeDaramadiElamAvarez AS a WHERE a.fldElamAvarezId =Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId) AS fldmablaghKoli
			,tblCodhayeDaramd_1.fldDaramadId,Drd.tblNaghdi_Talab.fldShomareHesabId 
			,isnull(fldTakhfifMaliyatValue,fldMaliyatValue)fldMaliyatValue,isnull(fldTakhfifAvarezValue,fldAvarezValue)fldAvarezValue,isnull(fldTakhfifAmuzeshParvareshValue,fldAmuzeshParvareshValue)fldAmuzeshParvareshValue,tblNaghdi_Talab.fldFishId 
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
									 GROUP BY tblRequestTaghsit_Takhfif.fldElamAvarezId,tblCodhayeDaramd_1.fldDaramadCode, tblCodhayeDaramd_1.fldid,
									 Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad,fldMablagh,fldReplyTaghsitId, tblCodhayeDaramadiElamAvarez.fldElamAvarezId
									 ,tblNaghdi_Talab.fldShomareHesabId,fldShomareHesab,fldDaramadId,Drd.tblNaghdi_Talab.fldShomareHesabId 
										,fldMaliyatValue,fldAvarezValue,fldTakhfifMaliyatValue,fldTakhfifAvarezValue,tblNaghdi_Talab.fldFishId 
										,fldTakhfifAmuzeshParvareshValue,fldAmuzeshParvareshValue
									 )t
			end
			else if(@DateType=0)/*براساس تاریخ واریز*/
			begin
					INSERT INTO @temp
				SELECT     tblCodhayeDaramd_1.fldid,   tblCodhayeDaramd_1.fldDaramadCode, Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad, Com.tblShomareHesabeOmoomi.fldShomareHesab, 
									   ISNULL(cast((Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifAsliValue * Drd.tblCodhayeDaramadiElamAvarez.fldTedad + Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifAvarezValue + Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifMaliyatValue+fldTakhfifAmuzeshParvareshValue)as bigint),
										  cast((Drd.tblCodhayeDaramadiElamAvarez.fldAsliValue * Drd.tblCodhayeDaramadiElamAvarez.fldTedad + Drd.tblCodhayeDaramadiElamAvarez.fldAvarezValue + Drd.tblCodhayeDaramadiElamAvarez.fldMaliyatValue+fldAmuzeshParvareshValue)as bigint))
					AS fldmablaghCodeDaramad, '0' AS Expr1, tblCodhayeDaramd_1.fldDaramadId,'',0,Drd.tblSodoorFish.fldShomareHesabId 
				,isnull(fldTakhfifMaliyatValue,fldMaliyatValue)fldMaliyatValue,isnull(fldTakhfifAvarezValue,fldAvarezValue)fldAvarezValue ,isnull(fldTakhfifAmuzeshParvareshValue,fldAmuzeshParvareshValue)fldAmuzeshParvareshValue 
			
				FROM            Drd.tblSodoorFish INNER JOIN
									 Drd.tblSodoorFish_Detail ON Drd.tblSodoorFish.fldId = Drd.tblSodoorFish_Detail.fldFishId INNER JOIN
									 Drd.tblCodhayeDaramadiElamAvarez ON Drd.tblSodoorFish_Detail.fldCodeElamAvarezId = Drd.tblCodhayeDaramadiElamAvarez.fldID INNER JOIN
									 Drd.tblShomareHesabCodeDaramad ON Drd.tblCodhayeDaramadiElamAvarez.fldShomareHesabCodeDaramadId = Drd.tblShomareHesabCodeDaramad.fldId AND 
									 Drd.tblCodhayeDaramadiElamAvarez.fldShomareHesabCodeDaramadId = Drd.tblShomareHesabCodeDaramad.fldId INNER JOIN
									 Drd.tblCodhayeDaramd AS tblCodhayeDaramd_1 ON Drd.tblShomareHesabCodeDaramad.fldCodeDaramadId = tblCodhayeDaramd_1.fldId INNER JOIN
									 Drd.tblPardakhtFish ON Drd.tblSodoorFish.fldId = Drd.tblPardakhtFish.fldFishId AND Drd.tblSodoorFish.fldId = Drd.tblPardakhtFish.fldFishId INNER JOIN
									 Com.tblShomareHesabeOmoomi ON Drd.tblSodoorFish.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId
				WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId)
									 AND CAST( tblPardakhtFish.fldDateVariz AS DATE) BETWEEN @StartDate AND @EndDate
									 AND tblShomareHesabCodeDaramad.fldOrganId=@OrganId
								 
					--GROUP BY tblCodhayeDaramd_1.fldDaramadCode, Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad,fldShomareHesab,fldDaramadId

				
			union all
			SELECT idcode,fldDaramadCode,fldSharheCodeDaramad,fldShomareHesab, cast(cast(fldMablaghNaghdi as numeric(50))*cast(fldmablaghCodeDaramad as numeric(50))/cast(fldmablaghKoli as numeric(50))as bigint),'1'
			,fldDaramadId,'',0,fldShomareHesabId	,fldMaliyatValue,fldAvarezValue ,  cast(cast(fldMablaghNaghdi as numeric(50)) *cast(fldAmuzeshParvareshValue as numeric(50))/cast(fldmablaghKoli as numeric(50))as bigint) fldAmuzeshParvareshValue
			 FROM 
			(SELECT   DISTINCT    Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId, tblCodhayeDaramd_1.fldDaramadCode, tblCodhayeDaramd_1.fldid idcode,
									 Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad
									-- ,SUM(fldMablagh) OVER (PARTITION BY fldReplyTaghsitId,tblNaghdi_Talab.fldShomareHesabId) AS fldMablaghNaghdi
									,Drd.fn_SumMablaghNaghdiVariz('Naghdi_Talab',tblNaghdi_Talab.fldFishId,tblNaghdi_Talab.fldShomareHesabId,@azTarikh ,@Tatarikh) AS fldMablaghNaghdi
									,fldShomareHesab ,fldReplyTaghsitId
				,ISNULL(SUM(fldTakhfifAsliValue*fldTedad+fldTakhfifAvarezValue+fldTakhfifMaliyatValue+fldTakhfifAmuzeshParvareshValue),SUM(fldAsliValue*fldTedad+fldAvarezValue+fldMaliyatValue+fldAmuzeshParvareshValue)) AS fldmablaghCodeDaramad
				,(SELECT TOP(1) ISNULL(SUM(fldTakhfifAsliValue*fldTedad+fldTakhfifAvarezValue+fldTakhfifMaliyatValue+fldTakhfifAmuzeshParvareshValue) OVER (PARTITION BY tblCodhayeDaramadiElamAvarez.fldElamAvarezId),SUM(fldAsliValue*fldTedad+fldAvarezValue+fldMaliyatValue+fldAmuzeshParvareshValue) OVER (PARTITION BY tblCodhayeDaramadiElamAvarez.fldElamAvarezId)) FROM Drd.tblCodhayeDaramadiElamAvarez AS a WHERE a.fldElamAvarezId =Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId) AS fldmablaghKoli
			,tblCodhayeDaramd_1.fldDaramadId,Drd.tblNaghdi_Talab.fldShomareHesabId 
			,isnull(fldTakhfifMaliyatValue,fldMaliyatValue)fldMaliyatValue,isnull(fldTakhfifAvarezValue,fldAvarezValue)fldAvarezValue,isnull(fldTakhfifAmuzeshParvareshValue,fldAmuzeshParvareshValue)fldAmuzeshParvareshValue,tblNaghdi_Talab.fldFishId 
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
									 GROUP BY tblRequestTaghsit_Takhfif.fldElamAvarezId,tblCodhayeDaramd_1.fldDaramadCode,tblCodhayeDaramd_1.fldid, 
									 Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad,fldMablagh,fldReplyTaghsitId, tblCodhayeDaramadiElamAvarez.fldElamAvarezId
									 ,tblNaghdi_Talab.fldShomareHesabId,fldShomareHesab,fldDaramadId,Drd.tblNaghdi_Talab.fldShomareHesabId 
										,fldMaliyatValue,fldAvarezValue,fldTakhfifMaliyatValue,fldTakhfifAvarezValue,tblNaghdi_Talab.fldFishId 
										,fldTakhfifAmuzeshParvareshValue,fldAmuzeshParvareshValue
									 )t
		end

		------------------------------------------------------- وصول شده

		insert into @temp
		SELECT idcode, fldDaramadCode,fldSharheCodeDaramad,fldShomareHesab,cast((cast(cast(fldMablagh as numeric)/cast(fldmablaghKoli as  numeric)as  numeric(38,20))*fldmablaghCodeDaramad)  as bigint),'2',fldDaramadId
		,'',0,fldShomareHesabIdOrgan 	,fldMaliyatValue,fldAvarezValue ,cast((cast(cast(fldMablagh as numeric)/cast(fldmablaghKoli as  numeric)as  numeric(38,20))*fldAmuzeshParvareshValue)  as bigint) fldAmuzeshParvareshValue
		FROM 
		(SELECT   DISTINCT    Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId, tblCodhayeDaramd_1.fldDaramadCode, tblCodhayeDaramd_1.fldid idcode,
								 Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad
								-- ,SUM(fldMablagh) OVER (PARTITION BY fldReplyTaghsitId,tblNaghdi_Talab.fldShomareHesabId) AS fldMablaghNaghdi
								,Drd.fn_SumMablaghNaghdi('Check',tblcheck.fldid,tblCheck.fldShomareHesabIdOrgan,@Aztarikh,@TaTarikh) AS fldMablagh
								,fldShomareHesab ,fldReplyTaghsitId
			,ISNULL(SUM(fldTakhfifAsliValue*fldTedad+fldTakhfifAvarezValue+fldTakhfifMaliyatValue+fldTakhfifAmuzeshParvareshValue),SUM(fldAsliValue*fldTedad+fldAvarezValue+fldMaliyatValue+fldAmuzeshParvareshValue)) AS fldmablaghCodeDaramad
			,(SELECT TOP(1) ISNULL(SUM(fldTakhfifAsliValue*fldTedad+fldTakhfifAvarezValue+fldTakhfifMaliyatValue+fldTakhfifAmuzeshParvareshValue) OVER (PARTITION BY tblCodhayeDaramadiElamAvarez.fldElamAvarezId),SUM(fldAsliValue*fldTedad+fldAvarezValue+fldMaliyatValue+fldAmuzeshParvareshValue) OVER (PARTITION BY tblCodhayeDaramadiElamAvarez.fldElamAvarezId)) FROM Drd.tblCodhayeDaramadiElamAvarez AS a WHERE a.fldElamAvarezId =Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId) AS fldmablaghKoli
		,tblCodhayeDaramd_1.fldDaramadId,tblCheck.fldShomareHesabIdOrgan
		,isnull(fldTakhfifMaliyatValue,fldMaliyatValue)fldMaliyatValue,isnull(fldTakhfifAvarezValue,fldAvarezValue)fldAvarezValue,isnull(fldTakhfifAmuzeshParvareshValue,fldAmuzeshParvareshValue)fldAmuzeshParvareshValue,tblCheck.fldid 
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
								AND (Drd.tblCheck.fldDateStatus ) BETWEEN @Aztarikh and @TaTarikh
								 GROUP BY tblRequestTaghsit_Takhfif.fldElamAvarezId,tblCodhayeDaramd_1.fldDaramadCode,tblCodhayeDaramd_1.fldid, 
								 Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad,fldMablaghSanad,fldReplyTaghsitId, tblCodhayeDaramadiElamAvarez.fldElamAvarezId
								 ,tblCheck.fldShomareHesabIdOrgan,fldShomareHesab,fldDaramadId,tblCheck.fldShomareHesabIdOrgan
									,fldMaliyatValue,fldAvarezValue,fldTakhfifMaliyatValue,fldTakhfifAvarezValue,tblCheck.fldid,fldAmuzeshParvareshValue,fldTakhfifAmuzeshParvareshValue



								 )t


				INSERT INTO @temp
								 SELECT  idcode,fldDaramadCode,fldSharheCodeDaramad,fldShomareHesab, cast((cast(cast(fldMablagh as numeric)/cast(fldmablaghKoli as  numeric)as  numeric(38,20))*fldmablaghCodeDaramad)  as bigint),'3',fldDaramadId 
								 ,'',0,fldShomareHesadId	,fldMaliyatValue,fldAvarezValue ,cast((cast(cast(fldMablagh as numeric)/cast(fldmablaghKoli as  numeric)as  numeric(38,20))*fldAmuzeshParvareshValue)  as bigint)  fldAmuzeshParvareshValue
								  FROM 
				(SELECT   DISTINCT    Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId, tblCodhayeDaramd_1.fldDaramadCode, tblCodhayeDaramd_1.fldid idcode,
								 Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad
								-- ,SUM(fldMablagh) OVER (PARTITION BY fldReplyTaghsitId,tblNaghdi_Talab.fldShomareHesabId) AS fldMablaghNaghdi
								,Drd.fn_SumMablaghNaghdi('Safte',fldReplyTaghsitId,tblShomareHesabCodeDaramad.fldShomareHesadId,@AzTarikh , @Tatarikh) AS fldMablagh
								,fldShomareHesab ,fldReplyTaghsitId
					,ISNULL(SUM(fldTakhfifAsliValue*fldTedad+fldTakhfifAvarezValue+fldTakhfifMaliyatValue+fldTakhfifAmuzeshParvareshValue),SUM(fldAsliValue*fldTedad+fldAvarezValue+fldMaliyatValue+fldAmuzeshParvareshValue)) AS fldmablaghCodeDaramad
					,(SELECT TOP(1) ISNULL(SUM(fldTakhfifAsliValue*fldTedad+fldTakhfifAvarezValue+fldTakhfifMaliyatValue+fldTakhfifAmuzeshParvareshValue) OVER (PARTITION BY tblCodhayeDaramadiElamAvarez.fldElamAvarezId),SUM(fldAsliValue*fldTedad+fldAvarezValue+fldMaliyatValue+fldAmuzeshParvareshValue) OVER (PARTITION BY tblCodhayeDaramadiElamAvarez.fldElamAvarezId)) FROM Drd.tblCodhayeDaramadiElamAvarez AS a WHERE a.fldElamAvarezId =Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId) AS fldmablaghKoli
				,tblCodhayeDaramd_1.fldDaramadId, tblShomareHesabCodeDaramad.fldShomareHesadId
							,isnull(fldTakhfifMaliyatValue,fldMaliyatValue)fldMaliyatValue,isnull(fldTakhfifAvarezValue,fldAvarezValue)fldAvarezValue ,isnull(fldTakhfifAmuzeshParvareshValue,fldAmuzeshParvareshValue)fldAmuzeshParvareshValue 
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
								 GROUP BY tblRequestTaghsit_Takhfif.fldElamAvarezId,tblCodhayeDaramd_1.fldDaramadCode,tblCodhayeDaramd_1.fldid, 
								 Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad,fldMablaghSanad,fldReplyTaghsitId, tblCodhayeDaramadiElamAvarez.fldElamAvarezId
								 ,tblShomareHesabCodeDaramad.fldShomareHesadId,fldShomareHesab,fldDaramadId, tblShomareHesabCodeDaramad.fldShomareHesadId
								 	,fldMaliyatValue,fldAvarezValue,fldTakhfifMaliyatValue,fldTakhfifAvarezValue,fldTakhfifAmuzeshParvareshValue,fldAmuzeshParvareshValue
								 )t

							INSERT INTO @temp
							SELECT idcode, fldDaramadCode,fldSharheCodeDaramad,fldShomareHesab, cast((cast(cast(fldMablagh as numeric)/cast(fldmablaghKoli as  numeric)as  numeric(38,20))*fldmablaghCodeDaramad)  as bigint),'4',fldDaramadId 
							,'',0,fldShomareHesadId	,fldMaliyatValue,fldAvarezValue ,cast((cast(cast(fldMablagh as numeric)/cast(fldmablaghKoli as  numeric)as  numeric(38,20))*fldAmuzeshParvareshValue)  as bigint)  fldAmuzeshParvareshValue
							FROM 
							(SELECT   DISTINCT    Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId, tblCodhayeDaramd_1.fldDaramadCode, tblCodhayeDaramd_1.fldid idcode,
													 Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad
													-- ,SUM(fldMablagh) OVER (PARTITION BY fldReplyTaghsitId,tblNaghdi_Talab.fldShomareHesabId) AS fldMablaghNaghdi
													,Drd.fn_SumMablaghNaghdi('Barat',fldReplyTaghsitId,tblShomareHesabCodeDaramad.fldShomareHesadId,@AzTarikh,@TaTarikh) AS fldMablagh
													,fldShomareHesab ,fldReplyTaghsitId
								,ISNULL(SUM(fldTakhfifAsliValue*fldTedad+fldTakhfifAvarezValue+fldTakhfifMaliyatValue+fldTakhfifAmuzeshParvareshValue),SUM(fldAsliValue*fldTedad+fldAvarezValue+fldMaliyatValue+fldAmuzeshParvareshValue)) AS fldmablaghCodeDaramad
								,(SELECT TOP(1) ISNULL(SUM(fldTakhfifAsliValue*fldTedad+fldTakhfifAvarezValue+fldTakhfifMaliyatValue+fldTakhfifAmuzeshParvareshValue) OVER (PARTITION BY tblCodhayeDaramadiElamAvarez.fldElamAvarezId),SUM(fldAsliValue*fldTedad+fldAvarezValue+fldMaliyatValue+fldAmuzeshParvareshValue) OVER (PARTITION BY tblCodhayeDaramadiElamAvarez.fldElamAvarezId)) FROM Drd.tblCodhayeDaramadiElamAvarez AS a WHERE a.fldElamAvarezId =Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId) AS fldmablaghKoli
							,tblCodhayeDaramd_1.fldDaramadId,tblShomareHesabCodeDaramad.fldShomareHesadId
							,isnull(fldTakhfifMaliyatValue,fldMaliyatValue)fldMaliyatValue,isnull(fldTakhfifAvarezValue,fldAvarezValue)fldAvarezValue ,isnull(fldTakhfifAmuzeshParvareshValue,fldAmuzeshParvareshValue)fldAmuzeshParvareshValue 
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
								 GROUP BY tblRequestTaghsit_Takhfif.fldElamAvarezId,tblCodhayeDaramd_1.fldDaramadCode, tblCodhayeDaramd_1.fldid ,
								 Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad,fldMablaghSanad,fldReplyTaghsitId, tblCodhayeDaramadiElamAvarez.fldElamAvarezId
								 ,tblShomareHesabCodeDaramad.fldShomareHesadId,fldShomareHesab,fldDaramadId,tblShomareHesabCodeDaramad.fldShomareHesadId
								 	,fldMaliyatValue,fldAvarezValue,fldTakhfifMaliyatValue,fldTakhfifAvarezValue,fldTakhfifAmuzeshParvareshValue,fldAmuzeshParvareshValue
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
		
			
			
			 IF(@ShomareHesabId<>0 AND @CodeDaramadId<>0 and @CodeDaramadId<>-3)
			 begin
				-- insert into @table 
				-- select b,a,mablagh,[count],fldtarikh,fldShomareHesab,fldShomareHesabId from
				--  (SELECT distinct  *, case when fldLevel=1 and P_Level=0 then fldDaramadCode  else P_DaramadCode end as b   ,case when fldLevel=1 and P_Level=0 then fldDaramadTitle else P_DaramadTitle end  as a 
				-- FROM (
				--SELECT
				--ISNULL((SELECT d.fldStrhid FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_hid,
				--ISNULL((SELECT fldDaramadCode FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_DaramadCode,
				--ISNULL((SELECT fldDaramadTitle FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_DaramadTitle,
				--ISNULL((SELECT fldLevel FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_Level
				--,sum(mablaghcodeDaramad) over (partition by tem.Daramadcode,tem.ShomareHId)/*ISNULL((SELECT SUM(mablaghcodeDaramad) FROM @temp WHERE Daramadcode=C.fldDaramadCode) ,ISNULL((SELECT SUM(mablaghcodeDaramad) FROM @temp AS t WHERE t.hid.ToString() LIKE c.fldStrhid+'%'),0))*/ AS Mablagh
				--,fldLevel,fldDaramadTitle,fldDaramadCode
				--,0 AS [Count],'' fldtarikh
				--,(SELECT  TOP(1)  fldShomareHesab FROM      
				--					  Com.tblShomareHesabeOmoomi WHERE tblShomareHesabeOmoomi.fldid=ShomareHId ) fldShomareHesab
				-- , ShomareHId fldShomareHesabId
				-- ,CASE WHEN fldid IN (SELECT  s.fldId FROM     Drd.tblCodhayeDaramd AS s left JOIN
				--				  Drd.tblCodhayeDaramd AS p ON  s.fldDaramadId = p.fldDaramadId.GetAncestor(1)
				--				  WHERE p.fldDaramadId IS NULL AND s.fldId=c.fldid) THEN N'1' ELSE '0' END AS LastNode
				-- FROM Drd.tblCodhayeDaramd AS C inner join @temp  as tem
				-- on tem.Daramadcode=c.fldDaramadCode
				-- WHERE C.fldLevel<>0 and ShomareHId LIKE @ShomareHesabId  AND C.fldId IN (SELECT id FROM @code))s
				-- WHERE    LastNode=1 and Mablagh<>0)t
				--  select P_DaramdCode,P_DaramadTitle,sum(Mablagh)Mablagh,tedad ,fldTarikh,fldShomareHesab,fldShomareHesabId from @table 
				-- group by P_DaramdCode,P_DaramadTitle,tedad,fldTarikh,fldShomareHesab,fldShomareHesabId
				insert into @table 
				 select substring(b,1,6),a,mablagh,[count],fldtarikh,fldShomareHesab,fldShomareHesabId,P_IdCode from
				  (SELECT distinct  *, case when fldLevel=1 and P_Level=0 then fldDaramadCode  else P_DaramadCode end as b   ,case when fldLevel=1 and P_Level=0 then fldDaramadTitle else P_DaramadTitle end  as a 
				 FROM (
				SELECT
				ISNULL((SELECT d.fldStrhid FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(0)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_hid,
				ISNULL((SELECT fldDaramadCode FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(0)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_DaramadCode,
				ISNULL((SELECT d.fldid FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(0)=d.fldDaramadId),0) AS P_IdCode,
				ISNULL((SELECT fldDaramadTitle FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(0)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_DaramadTitle,
				ISNULL((SELECT fldLevel FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(0)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_Level
				,sum(mablaghcodeDaramad) over (partition by tem.idcode,tem.ShomareHId)/*ISNULL((SELECT SUM(mablaghcodeDaramad) FROM @temp WHERE Daramadcode=C.fldDaramadCode) ,ISNULL((SELECT SUM(mablaghcodeDaramad) FROM @temp AS t WHERE t.hid.ToString() LIKE c.fldStrhid+'%'),0))*/ AS Mablagh
				,fldLevel,fldDaramadTitle,fldDaramadCode
				,0 AS [Count],'' fldtarikh
				,(SELECT  TOP(1)  fldShomareHesab FROM      
									  Com.tblShomareHesabeOmoomi WHERE tblShomareHesabeOmoomi.fldid=ShomareHId ) fldShomareHesab
				 , ShomareHId fldShomareHesabId
				 ,CASE WHEN fldid IN (SELECT  s.fldId FROM     Drd.tblCodhayeDaramd AS s left JOIN
								  Drd.tblCodhayeDaramd AS p ON  s.fldDaramadId = p.fldDaramadId.GetAncestor(1)
								  WHERE p.fldDaramadId IS NULL AND s.fldId=c.fldid) THEN N'1' ELSE '0' END AS LastNode
				 FROM Drd.tblCodhayeDaramd AS C inner join @temp  as tem
				 on tem.idcode=c.fldid
				 WHERE C.fldLevel<>0 and ShomareHId LIKE @ShomareHesabId  AND C.fldId IN (SELECT id FROM @code))s
				 WHERE    LastNode=1 and Mablagh<>0)t
				 
				 select P_DaramdCode,case when drd.tblCodhayeDaramd.fldDaramadTitle=N'پیش فرض' then d.P_DaramadTitle else  drd.tblCodhayeDaramd.fldDaramadTitle end as P_DaramadTitle/*P_DaramadTitle*/,sum(Mablagh)Mablagh,tedad ,fldTarikh,fldShomareHesab,fldShomareHesabId 
				from @table as d inner join drd.tblCodhayeDaramd on drd.tblCodhayeDaramd.fldid=d.P_Idcode
				 group by P_DaramdCode,fldDaramadTitle,tedad,fldTarikh,fldShomareHesab,fldShomareHesabId,P_Idcode,P_DaramadTitle
				 end
				 
				 IF(@ShomareHesabId<>0 AND @CodeDaramadId=-3)
			 begin
				insert into @table 
				 select '_',N'آموزش و پرورش'a,mablagh,[count],fldtarikh,fldShomareHesab,fldShomareHesabId,0  P_IdCode from
				  (SELECT distinct  * 
				 FROM (
				SELECT sum(fldAmuzesh) over (partition by tem.ShomareHId)/*ISNULL((SELECT SUM(mablaghcodeDaramad) FROM @temp WHERE Daramadcode=C.fldDaramadCode) ,ISNULL((SELECT SUM(mablaghcodeDaramad) FROM @temp AS t WHERE t.hid.ToString() LIKE c.fldStrhid+'%'),0))*/ AS Mablagh
				,0 AS [Count],'' fldtarikh
				,(SELECT  TOP(1)  fldShomareHesab FROM      
									  Com.tblShomareHesabeOmoomi WHERE tblShomareHesabeOmoomi.fldid=ShomareHId ) fldShomareHesab
				 , ShomareHId fldShomareHesabId
				 FROM  @temp  as tem
				
				 WHERE ShomareHId LIKE @ShomareHesabId )s
				 WHERE    Mablagh<>0)t
				 
				 select P_DaramdCode, P_DaramadTitle/*P_DaramadTitle*/,sum(Mablagh)Mablagh,tedad ,fldTarikh,fldShomareHesab,fldShomareHesabId 
				from @table as d
				 group by P_DaramdCode,P_DaramadTitle,tedad,fldTarikh,fldShomareHesab,fldShomareHesabId,P_Idcode
				 end




				 ELSE IF(@ShomareHesabId=0 AND @CodeDaramadId=0)
				 begin
				-- insert into @table 
				--select b,a,mablagh,[count],fldtarikh,fldShomareHesab,fldShomareHesabId from (SELECT distinct  *, case when fldLevel=1 and P_Level=0 then fldDaramadCode  else P_DaramadCode end as b   ,case when fldLevel=1 and P_Level=0 then fldDaramadTitle else P_DaramadTitle end  as a 
				-- FROM (
				--SELECT
				--ISNULL((SELECT d.fldStrhid FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_hid,
				--ISNULL((SELECT fldDaramadCode FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_DaramadCode,
				--ISNULL((SELECT fldDaramadTitle FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_DaramadTitle,
				--ISNULL((SELECT fldLevel FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_Level
				--,sum(mablaghcodeDaramad) over (partition by tem.Daramadcode,tem.ShomareHId)/*ISNULL((SELECT SUM(mablaghcodeDaramad) FROM @temp WHERE Daramadcode=C.fldDaramadCode) ,ISNULL((SELECT SUM(mablaghcodeDaramad) FROM @temp AS t WHERE t.hid.ToString() LIKE c.fldStrhid+'%'),0))*/ AS Mablagh
				--,fldLevel,fldDaramadTitle,fldDaramadCode
				--,0 AS [Count],'' fldtarikh
				--,(SELECT  TOP(1)  fldShomareHesab FROM      
				--					  Com.tblShomareHesabeOmoomi WHERE tblShomareHesabeOmoomi.fldid=ShomareHId ) fldShomareHesab
				-- , ShomareHId fldShomareHesabId
				-- 				 ,CASE WHEN fldid IN (SELECT  s.fldId FROM     Drd.tblCodhayeDaramd AS s left JOIN
				--				  Drd.tblCodhayeDaramd AS p ON  s.fldDaramadId = p.fldDaramadId.GetAncestor(1)
				--				  WHERE p.fldDaramadId IS NULL AND s.fldId=c.fldid) THEN N'1' ELSE '0' END AS LastNode
				-- FROM Drd.tblCodhayeDaramd AS C inner join @temp  as tem
				-- on tem.Daramadcode=c.fldDaramadCode
				-- WHERE C.fldLevel<>0) t
				-- where  LastNode=1 and Mablagh<>0 )s
				--select P_DaramdCode,P_DaramadTitle,sum(Mablagh)Mablagh,tedad ,fldTarikh,fldShomareHesab,fldShomareHesabId from @table 
				-- group by P_DaramdCode,P_DaramadTitle,tedad,fldTarikh,fldShomareHesab,fldShomareHesabId
				insert into @table
				select substring(b,1,6),a,mablagh,[count],fldtarikh,fldShomareHesab,fldShomareHesabId,P_IdCode from (
				SELECT distinct  *, case when fldLevel=1 and P_Level=0 then fldDaramadCode  else P_DaramadCode end as b   ,case when fldLevel=1 and P_Level=0 then fldDaramadTitle else P_DaramadTitle end  as a 
				 FROM (
				SELECT
				ISNULL((SELECT d.fldStrhid FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(0)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_hid,
				ISNULL((SELECT fldDaramadCode FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(0)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_DaramadCode,
				ISNULL((SELECT d.fldid FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(0)=d.fldDaramadId ),'') AS P_IdCode,
				ISNULL((SELECT fldDaramadTitle FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(0)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_DaramadTitle,
				ISNULL((SELECT fldLevel FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(0)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_Level
				,sum(mablaghcodeDaramad) over (partition by tem.idcode,tem.ShomareHId)/*ISNULL((SELECT SUM(mablaghcodeDaramad) FROM @temp WHERE Daramadcode=C.fldDaramadCode) ,ISNULL((SELECT SUM(mablaghcodeDaramad) FROM @temp AS t WHERE t.hid.ToString() LIKE c.fldStrhid+'%'),0))*/ AS Mablagh
				,fldLevel,fldDaramadTitle,fldDaramadCode
				,0 AS [Count],'' fldtarikh
				,(SELECT  TOP(1)  fldShomareHesab FROM      
									  Com.tblShomareHesabeOmoomi WHERE tblShomareHesabeOmoomi.fldid=ShomareHId ) fldShomareHesab
				 , ShomareHId fldShomareHesabId
				 				 ,CASE WHEN fldid IN (SELECT  s.fldId FROM     Drd.tblCodhayeDaramd AS s left JOIN
								  Drd.tblCodhayeDaramd AS p ON  s.fldDaramadId = p.fldDaramadId.GetAncestor(1)
								  WHERE p.fldDaramadId IS NULL AND s.fldId=c.fldid) THEN N'1' ELSE '0' END AS LastNode
				 FROM Drd.tblCodhayeDaramd AS C inner join @temp  as tem
				 on tem.idcode=c.fldid
				 WHERE C.fldLevel<>0) t
				 where  LastNode=1 and Mablagh<>0 )s

				 /*insert into @table 
				 select '_',N'آموزش و پرورش'a,mablagh,[count],fldtarikh,fldShomareHesab,fldShomareHesabId,0  P_IdCode from
				  (SELECT distinct  * 
				 FROM (
				SELECT sum(fldAmuzesh) over (partition by tem.ShomareHId)/*ISNULL((SELECT SUM(mablaghcodeDaramad) FROM @temp WHERE Daramadcode=C.fldDaramadCode) ,ISNULL((SELECT SUM(mablaghcodeDaramad) FROM @temp AS t WHERE t.hid.ToString() LIKE c.fldStrhid+'%'),0))*/ AS Mablagh
				,0 AS [Count],'' fldtarikh
				,(SELECT  TOP(1)  fldShomareHesab FROM      
									  Com.tblShomareHesabeOmoomi WHERE tblShomareHesabeOmoomi.fldid=ShomareHId ) fldShomareHesab
				 , ShomareHId fldShomareHesabId
				 FROM  @temp  as tem
				
				 )s
				 WHERE    Mablagh<>0)t*/

				select P_DaramdCode, case when drd.tblCodhayeDaramd.fldDaramadTitle=N'پیش فرض' then d.P_DaramadTitle else  drd.tblCodhayeDaramd.fldDaramadTitle end as P_DaramadTitle/*P_DaramadTitle*/,sum(Mablagh)Mablagh,tedad ,fldTarikh,fldShomareHesab,fldShomareHesabId 
				from @table as d    inner join drd.tblCodhayeDaramd on drd.tblCodhayeDaramd.fldid=d.P_Idcode
				 group by P_DaramdCode,P_DaramadTitle,tedad,fldTarikh,fldShomareHesab,fldShomareHesabId,P_Idcode,fldDaramadTitle
				 
				 union all
				  select '_',N'آموزش و پرورش'a,mablagh,[count],fldtarikh,fldShomareHesab,fldShomareHesabId from
				  (SELECT distinct  * 
				 FROM (
				SELECT sum(fldAmuzesh) over (partition by tem.ShomareHId)/*ISNULL((SELECT SUM(mablaghcodeDaramad) FROM @temp WHERE Daramadcode=C.fldDaramadCode) ,ISNULL((SELECT SUM(mablaghcodeDaramad) FROM @temp AS t WHERE t.hid.ToString() LIKE c.fldStrhid+'%'),0))*/ AS Mablagh
				,0 AS [Count],'' fldtarikh
				,(SELECT  TOP(1)  fldShomareHesab FROM      
									  Com.tblShomareHesabeOmoomi WHERE tblShomareHesabeOmoomi.fldid=ShomareHId ) fldShomareHesab
				 , ShomareHId fldShomareHesabId
				 FROM  @temp  as tem
				
				 )s
				 WHERE    Mablagh<>0)t
				 end
				ELSE  IF(@ShomareHesabId=0 AND @CodeDaramadId<>0 and @CodeDaramadId<>-3)
				begin
				-- insert into @table 
				--select b,a,mablagh,[count],fldtarikh,fldShomareHesab,fldShomareHesabId from (SELECT distinct  *, case when fldLevel=1 and P_Level=0 then fldDaramadCode  else P_DaramadCode end as b   ,case when fldLevel=1 and P_Level=0 then fldDaramadTitle else P_DaramadTitle end  as a 
				-- FROM (
				--SELECT
				--ISNULL((SELECT d.fldStrhid FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_hid,
				--ISNULL((SELECT fldDaramadCode FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_DaramadCode,
				--ISNULL((SELECT fldDaramadTitle FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_DaramadTitle,
				--ISNULL((SELECT fldLevel FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_Level
				--,sum(mablaghcodeDaramad) over (partition by tem.Daramadcode,tem.ShomareHId)/*ISNULL((SELECT SUM(mablaghcodeDaramad) FROM @temp WHERE Daramadcode=C.fldDaramadCode) ,ISNULL((SELECT SUM(mablaghcodeDaramad) FROM @temp AS t WHERE t.hid.ToString() LIKE c.fldStrhid+'%'),0))*/ AS Mablagh
				--,fldLevel,fldDaramadTitle,fldDaramadCode
				--,0 AS [Count],'' fldtarikh
				--,(SELECT  TOP(1)  fldShomareHesab FROM      
				--					  Com.tblShomareHesabeOmoomi WHERE tblShomareHesabeOmoomi.fldid=ShomareHId ) fldShomareHesab
				-- , ShomareHId fldShomareHesabId				  ,CASE WHEN fldid IN (SELECT  s.fldId FROM     Drd.tblCodhayeDaramd AS s left JOIN
				--				  Drd.tblCodhayeDaramd AS p ON  s.fldDaramadId = p.fldDaramadId.GetAncestor(1)
				--				  WHERE p.fldDaramadId IS NULL AND s.fldId=c.fldid) THEN N'1' ELSE '0' END AS LastNode
				-- FROM Drd.tblCodhayeDaramd AS C inner join @temp  as tem
				-- on tem.Daramadcode=c.fldDaramadCode
				-- WHERE C.fldLevel<>0   AND C.fldId IN (SELECT id FROM @code))t
				-- where    LastNode=1 and Mablagh<>0)t
				--  select P_DaramdCode,P_DaramadTitle,sum(Mablagh)Mablagh,tedad ,fldTarikh,fldShomareHesab,fldShomareHesabId from @table 
				-- group by P_DaramdCode,P_DaramadTitle,tedad,fldTarikh,fldShomareHesab,fldShomareHesabId
				insert into @table 
				select substring(b,1,6),a,mablagh,[count],fldtarikh,fldShomareHesab,fldShomareHesabId,P_IdCode from (SELECT distinct  *, case when fldLevel=1 and P_Level=0 then fldDaramadCode  else P_DaramadCode end as b   ,case when fldLevel=1 and P_Level=0 then fldDaramadTitle else P_DaramadTitle end  as a 
				 FROM (
				SELECT
				ISNULL((SELECT d.fldStrhid FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_hid,
				ISNULL((SELECT fldDaramadCode FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_DaramadCode,
				ISNULL((SELECT d.fldId FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId ),'') AS P_IdCode,
				ISNULL((SELECT fldDaramadTitle FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_DaramadTitle,
				ISNULL((SELECT fldLevel FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_Level
				,sum(mablaghcodeDaramad) over (partition by tem.idcode,tem.ShomareHId)/*ISNULL((SELECT SUM(mablaghcodeDaramad) FROM @temp WHERE Daramadcode=C.fldDaramadCode) ,ISNULL((SELECT SUM(mablaghcodeDaramad) FROM @temp AS t WHERE t.hid.ToString() LIKE c.fldStrhid+'%'),0))*/ AS Mablagh
				,fldLevel,fldDaramadTitle,fldDaramadCode
				,0 AS [Count],'' fldtarikh
				,(SELECT  TOP(1)  fldShomareHesab FROM      
									  Com.tblShomareHesabeOmoomi WHERE tblShomareHesabeOmoomi.fldid=ShomareHId ) fldShomareHesab
				 , ShomareHId fldShomareHesabId				  ,CASE WHEN fldid IN (SELECT  s.fldId FROM     Drd.tblCodhayeDaramd AS s left JOIN
								  Drd.tblCodhayeDaramd AS p ON  s.fldDaramadId = p.fldDaramadId.GetAncestor(1)
								  WHERE p.fldDaramadId IS NULL AND s.fldId=c.fldid) THEN N'1' ELSE '0' END AS LastNode
				 FROM Drd.tblCodhayeDaramd AS C inner join @temp  as tem
				 on tem.idcode=c.fldid
				 WHERE C.fldLevel<>0   AND C.fldId IN (SELECT id FROM @code))t
				 where    LastNode=1 and Mablagh<>0)t
				  select P_DaramdCode,case when drd.tblCodhayeDaramd.fldDaramadTitle=N'پیش فرض' then d.P_DaramadTitle else  drd.tblCodhayeDaramd.fldDaramadTitle end as P_DaramadTitle/*P_DaramadTitle*/,sum(Mablagh)Mablagh,tedad ,fldTarikh,fldShomareHesab,fldShomareHesabId 
				from @table as d inner join drd.tblCodhayeDaramd on drd.tblCodhayeDaramd.fldid=d.p_IdCode
				 group by P_DaramdCode,fldDaramadTitle,tedad,fldTarikh,fldShomareHesab,fldShomareHesabId,P_Idcode,P_DaramadTitle
				end
			
			 else if (@ShomareHesabId=0 AND @CodeDaramadId=-3)
				 begin
					 insert into @table 
				 select '_',N'آموزش و پرورش'a,mablagh,[count],fldtarikh,fldShomareHesab,fldShomareHesabId,0  P_IdCode from
				  (SELECT distinct  * 
				 FROM (
				SELECT sum(fldAmuzesh) over (partition by tem.ShomareHId)/*ISNULL((SELECT SUM(mablaghcodeDaramad) FROM @temp WHERE Daramadcode=C.fldDaramadCode) ,ISNULL((SELECT SUM(mablaghcodeDaramad) FROM @temp AS t WHERE t.hid.ToString() LIKE c.fldStrhid+'%'),0))*/ AS Mablagh
				,0 AS [Count],'' fldtarikh
				,(SELECT  TOP(1)  fldShomareHesab FROM      
									  Com.tblShomareHesabeOmoomi WHERE tblShomareHesabeOmoomi.fldid=ShomareHId ) fldShomareHesab
				 , ShomareHId fldShomareHesabId
				 FROM  @temp  as tem
				
				 )s
				 WHERE    Mablagh<>0)t

				select P_DaramdCode, P_DaramadTitle/*P_DaramadTitle*/,sum(Mablagh)Mablagh,tedad ,fldTarikh,fldShomareHesab,fldShomareHesabId 
				from @table as d 
				 group by P_DaramdCode,tedad,fldTarikh,fldShomareHesab,fldShomareHesabId,P_Idcode,P_DaramadTitle
				
				 end

				 ELSE IF(@ShomareHesabId<>0 AND @CodeDaramadId=0)
				 begin
				-- insert into @table 
				--select b,a,mablagh,[count],fldtarikh,fldShomareHesab,fldShomareHesabId from (SELECT distinct  *, case when fldLevel=1 and P_Level=0 then fldDaramadCode  else P_DaramadCode end as b   ,case when fldLevel=1 and P_Level=0 then fldDaramadTitle else P_DaramadTitle end  as a 
				-- FROM (
				--SELECT
				--ISNULL((SELECT d.fldStrhid FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_hid,
				--ISNULL((SELECT fldDaramadCode FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_DaramadCode,
				--ISNULL((SELECT fldDaramadTitle FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_DaramadTitle,
				--ISNULL((SELECT fldLevel FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_Level
				--,sum(mablaghcodeDaramad) over (partition by tem.Daramadcode,tem.ShomareHId)/*ISNULL((SELECT SUM(mablaghcodeDaramad) FROM @temp WHERE Daramadcode=C.fldDaramadCode) ,ISNULL((SELECT SUM(mablaghcodeDaramad) FROM @temp AS t WHERE t.hid.ToString() LIKE c.fldStrhid+'%'),0))*/ AS Mablagh
				--,fldLevel,fldDaramadTitle,fldDaramadCode				
				--,0 AS [Count],'' fldtarikh
				--,(SELECT  TOP(1)  fldShomareHesab FROM      
				--					  Com.tblShomareHesabeOmoomi WHERE tblShomareHesabeOmoomi.fldid=ShomareHId ) fldShomareHesab
				-- , ShomareHId fldShomareHesabId				  ,CASE WHEN fldid IN (SELECT  s.fldId FROM     Drd.tblCodhayeDaramd AS s left JOIN
				--				  Drd.tblCodhayeDaramd AS p ON  s.fldDaramadId = p.fldDaramadId.GetAncestor(1)
				--				  WHERE p.fldDaramadId IS NULL AND s.fldId=c.fldid) THEN N'1' ELSE '0' END AS LastNode
				-- FROM Drd.tblCodhayeDaramd AS C inner join @temp  as tem
				-- on tem.Daramadcode=c.fldDaramadCode
				-- WHERE C.fldLevel<>0 and ShomareHId  LIKE @ShomareHesabId )t
				--  WHERE   LastNode=1 and Mablagh<>0)q
				--   select P_DaramdCode,P_DaramadTitle,sum(Mablagh)Mablagh,tedad ,fldTarikh,fldShomareHesab,fldShomareHesabId from @table 
				-- group by P_DaramdCode,P_DaramadTitle,tedad,fldTarikh,fldShomareHesab,fldShomareHesabId
			
				insert into @table 
				select substring(b,1,6),a,mablagh,[count],fldtarikh,fldShomareHesab,fldShomareHesabId,P_IdCode from
				 (SELECT distinct  *, case when fldLevel=1 and P_Level=0 then fldDaramadCode  else P_DaramadCode end as b   ,case when fldLevel=1 and P_Level=0 then fldDaramadTitle else P_DaramadTitle end  as a 
				 FROM (
				SELECT
				ISNULL((SELECT d.fldStrhid FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_hid,
				ISNULL((SELECT fldDaramadCode FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_DaramadCode,
				ISNULL((SELECT d.fldId FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId ),'') AS P_IdCode,
				ISNULL((SELECT fldDaramadTitle FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_DaramadTitle,
				ISNULL((SELECT fldLevel FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_Level
				,sum(mablaghcodeDaramad) over (partition by tem.Idcode,tem.ShomareHId)/*ISNULL((SELECT SUM(mablaghcodeDaramad) FROM @temp WHERE Daramadcode=C.fldDaramadCode) ,ISNULL((SELECT SUM(mablaghcodeDaramad) FROM @temp AS t WHERE t.hid.ToString() LIKE c.fldStrhid+'%'),0))*/ AS Mablagh
				,fldLevel,fldDaramadTitle,fldDaramadCode				
				,0 AS [Count],'' fldtarikh
				,(SELECT  TOP(1)  fldShomareHesab FROM      
									  Com.tblShomareHesabeOmoomi WHERE tblShomareHesabeOmoomi.fldid=ShomareHId ) fldShomareHesab
				 , ShomareHId fldShomareHesabId				  ,CASE WHEN fldid IN (SELECT  s.fldId FROM     Drd.tblCodhayeDaramd AS s left JOIN
								  Drd.tblCodhayeDaramd AS p ON  s.fldDaramadId = p.fldDaramadId.GetAncestor(1)
								  WHERE p.fldDaramadId IS NULL AND s.fldId=c.fldid) THEN N'1' ELSE '0' END AS LastNode
				 FROM Drd.tblCodhayeDaramd AS C inner join @temp  as tem
				 on tem.idcode=c.fldid
				 WHERE C.fldLevel<>0 and ShomareHId  LIKE @ShomareHesabId )t
				 WHERE   LastNode=1 and Mablagh<>0
				 )q

				  select P_DaramdCode,case when drd.tblCodhayeDaramd.fldDaramadTitle=N'پیش فرض' then d.P_DaramadTitle else  drd.tblCodhayeDaramd.fldDaramadTitle end as P_DaramadTitle/*P_DaramadTitle*/,sum(Mablagh)Mablagh,tedad ,fldTarikh,fldShomareHesab,fldShomareHesabId 
				from @table as d inner join drd.tblCodhayeDaramd on drd.tblCodhayeDaramd.fldid=d.P_IdCode
				 group by P_DaramdCode,fldDaramadTitle,tedad,fldTarikh,fldShomareHesab,fldShomareHesabId,P_Idcode,d.P_DaramadTitle
				
				  union all
				 
				 select '_',N'آموزش و پرورش'a,mablagh,[count],fldtarikh,fldShomareHesab,fldShomareHesabId from
				  (SELECT distinct  * 
				 FROM (
				SELECT sum(fldAmuzesh) over (partition by tem.ShomareHId)/*ISNULL((SELECT SUM(mablaghcodeDaramad) FROM @temp WHERE Daramadcode=C.fldDaramadCode) ,ISNULL((SELECT SUM(mablaghcodeDaramad) FROM @temp AS t WHERE t.hid.ToString() LIKE c.fldStrhid+'%'),0))*/ AS Mablagh
				,0 AS [Count],'' fldtarikh
				,(SELECT  TOP(1)  fldShomareHesab FROM      
									  Com.tblShomareHesabeOmoomi WHERE tblShomareHesabeOmoomi.fldid=ShomareHId ) fldShomareHesab
				 , ShomareHId fldShomareHesabId
				 FROM  @temp  as tem
				where  ShomareHId  LIKE @ShomareHesabId 
				 )s
				 WHERE    Mablagh<>0)t
				
				  end
				

		 ELSE IF(@ShomareHesabId<>0 AND @CodeDaramadId=-3)
			 begin
			 insert into @table 
				select '',a,mablagh,[count],fldtarikh,fldShomareHesab,fldShomareHesabId,''P_IdCode from
				 (SELECT distinct  *, '_' b   ,N'آموزش و پرورش'  as a 
				 FROM (
				SELECT sum(fldAmuzesh) over (partition by tem.Idcode,tem.ShomareHId)/*ISNULL((SELECT SUM(mablaghcodeDaramad) FROM @temp WHERE Daramadcode=C.fldDaramadCode) ,ISNULL((SELECT SUM(mablaghcodeDaramad) FROM @temp AS t WHERE t.hid.ToString() LIKE c.fldStrhid+'%'),0))*/ AS Mablagh
							
				,0 AS [Count],'' fldtarikh
				,(SELECT  TOP(1)  fldShomareHesab FROM      
									  Com.tblShomareHesabeOmoomi WHERE tblShomareHesabeOmoomi.fldid=ShomareHId ) fldShomareHesab
				 , ShomareHId fldShomareHesabId				
				 FROM @temp  as tem
				
				 WHERE ShomareHId  LIKE @ShomareHesabId )t
				  WHERE Mablagh<>0)q
				
				  select P_DaramdCode, P_DaramadTitle/*P_DaramadTitle*/,sum(Mablagh)Mablagh,tedad ,fldTarikh,fldShomareHesab,fldShomareHesabId 
				from @table as d
				 group by P_DaramdCode,P_DaramadTitle,tedad,fldTarikh,fldShomareHesab,fldShomareHesabId,P_Idcode
				  end
			
		 END
	ELSE
		BEGIN
			if(@DateType=1)/*براساس تاریخ پرداخت*/
			begin
				INSERT INTO @temp
				SELECT     tblCodhayeDaramd_1.fldid,   tblCodhayeDaramd_1.fldDaramadCode, Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad, Com.tblShomareHesabeOmoomi.fldShomareHesab, 
									   ISNULL(cast((Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifAsliValue * Drd.tblCodhayeDaramadiElamAvarez.fldTedad + Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifAvarezValue + Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifMaliyatValue+fldTakhfifAmuzeshParvareshValue)as bigint),
									  cast((Drd.tblCodhayeDaramadiElamAvarez.fldAsliValue * Drd.tblCodhayeDaramadiElamAvarez.fldTedad + Drd.tblCodhayeDaramadiElamAvarez.fldAvarezValue + Drd.tblCodhayeDaramadiElamAvarez.fldMaliyatValue+fldAmuzeshParvareshValue)as bigint))
				AS fldmablaghCodeDaramad, '0' AS Expr1, tblCodhayeDaramd_1.fldDaramadId,'',0,Drd.tblSodoorFish.fldShomareHesabId 
				,isnull(fldTakhfifMaliyatValue,fldMaliyatValue)fldMaliyatValue,isnull(fldTakhfifAvarezValue,fldAvarezValue)fldAvarezValue ,isnull(fldTakhfifAmuzeshParvareshValue,fldAmuzeshParvareshValue)fldAmuzeshParvareshValue 
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
			SELECT idcode,fldDaramadCode,fldSharheCodeDaramad,fldShomareHesab, cast(cast(fldMablaghNaghdi as numeric(50))*cast(fldmablaghCodeDaramad as numeric(50))/cast(fldmablaghKoli as numeric(50))as bigint),'1'
			,fldDaramadId,'',0,fldShomareHesabId	,fldMaliyatValue,fldAvarezValue ,cast(cast(fldMablaghNaghdi as numeric(50))*cast(fldAmuzeshParvareshValue as numeric(50))/cast(fldmablaghKoli as numeric(50))as bigint) fldAmuzeshParvareshValue
			 FROM 
			(SELECT   DISTINCT    Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId, tblCodhayeDaramd_1.fldDaramadCode, tblCodhayeDaramd_1.fldid idcode,
									 Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad
									-- ,SUM(fldMablagh) OVER (PARTITION BY fldReplyTaghsitId,tblNaghdi_Talab.fldShomareHesabId) AS fldMablaghNaghdi
									,Drd.fn_SumMablaghNaghdi('Naghdi_Talab',tblNaghdi_Talab.fldFishId,tblNaghdi_Talab.fldShomareHesabId,@azTarikh ,@Tatarikh) AS fldMablaghNaghdi
									,fldShomareHesab ,fldReplyTaghsitId
				,ISNULL(SUM(fldTakhfifAsliValue*fldTedad+fldTakhfifAvarezValue+fldTakhfifMaliyatValue+fldTakhfifAmuzeshParvareshValue),SUM(fldAsliValue*fldTedad+fldAvarezValue+fldMaliyatValue+fldAmuzeshParvareshValue)) AS fldmablaghCodeDaramad
				,(SELECT TOP(1) ISNULL(SUM(fldTakhfifAsliValue*fldTedad+fldTakhfifAvarezValue+fldTakhfifMaliyatValue+fldTakhfifAmuzeshParvareshValue) OVER (PARTITION BY tblCodhayeDaramadiElamAvarez.fldElamAvarezId),SUM(fldAsliValue*fldTedad+fldAvarezValue+fldMaliyatValue+fldAmuzeshParvareshValue) OVER (PARTITION BY tblCodhayeDaramadiElamAvarez.fldElamAvarezId)) FROM Drd.tblCodhayeDaramadiElamAvarez AS a WHERE a.fldElamAvarezId =Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId) AS fldmablaghKoli
			,tblCodhayeDaramd_1.fldDaramadId,Drd.tblNaghdi_Talab.fldShomareHesabId 
			,isnull(fldTakhfifMaliyatValue,fldMaliyatValue)fldMaliyatValue,isnull(fldTakhfifAvarezValue,fldAvarezValue)fldAvarezValue,isnull(fldTakhfifAmuzeshParvareshValue,fldAmuzeshParvareshValue)fldAmuzeshParvareshValue,tblNaghdi_Talab.fldFishId 
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
								
									 GROUP BY tblRequestTaghsit_Takhfif.fldElamAvarezId,tblCodhayeDaramd_1.fldDaramadCode, tblCodhayeDaramd_1.fldid,
									 Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad,fldMablagh,fldReplyTaghsitId, tblCodhayeDaramadiElamAvarez.fldElamAvarezId
									 ,tblNaghdi_Talab.fldShomareHesabId,fldShomareHesab,fldDaramadId,Drd.tblNaghdi_Talab.fldShomareHesabId 
									,fldMaliyatValue,fldAvarezValue,fldTakhfifMaliyatValue,fldTakhfifAvarezValue,tblNaghdi_Talab.fldFishId ,fldTakhfifAmuzeshParvareshValue,fldAmuzeshParvareshValue
									 )t
		end
		else if(@DateType=0)/*براساس تاریخ واریز*/
			begin
				INSERT INTO @temp
				SELECT    tblCodhayeDaramd_1.fldid,    tblCodhayeDaramd_1.fldDaramadCode, Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad, Com.tblShomareHesabeOmoomi.fldShomareHesab, 
									   ISNULL(cast((Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifAsliValue * Drd.tblCodhayeDaramadiElamAvarez.fldTedad + Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifAvarezValue + Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifMaliyatValue+fldTakhfifAmuzeshParvareshValue)as bigint),
									  cast((Drd.tblCodhayeDaramadiElamAvarez.fldAsliValue * Drd.tblCodhayeDaramadiElamAvarez.fldTedad + Drd.tblCodhayeDaramadiElamAvarez.fldAvarezValue + Drd.tblCodhayeDaramadiElamAvarez.fldMaliyatValue+fldAmuzeshParvareshValue)as bigint))
				AS fldmablaghCodeDaramad, '0' AS Expr1, tblCodhayeDaramd_1.fldDaramadId,'',0,Drd.tblSodoorFish.fldShomareHesabId 
				,isnull(fldTakhfifMaliyatValue,fldMaliyatValue)fldMaliyatValue,isnull(fldTakhfifAvarezValue,fldAvarezValue)fldAvarezValue ,isnull(fldTakhfifAmuzeshParvareshValue,fldAmuzeshParvareshValue)fldAmuzeshParvareshValue 
				FROM            Drd.tblSodoorFish INNER JOIN
									 Drd.tblSodoorFish_Detail ON Drd.tblSodoorFish.fldId = Drd.tblSodoorFish_Detail.fldFishId INNER JOIN
									 Drd.tblCodhayeDaramadiElamAvarez ON Drd.tblSodoorFish_Detail.fldCodeElamAvarezId = Drd.tblCodhayeDaramadiElamAvarez.fldID INNER JOIN
									 Drd.tblShomareHesabCodeDaramad ON Drd.tblCodhayeDaramadiElamAvarez.fldShomareHesabCodeDaramadId = Drd.tblShomareHesabCodeDaramad.fldId AND 
									 Drd.tblCodhayeDaramadiElamAvarez.fldShomareHesabCodeDaramadId = Drd.tblShomareHesabCodeDaramad.fldId INNER JOIN
									 Drd.tblCodhayeDaramd AS tblCodhayeDaramd_1 ON Drd.tblShomareHesabCodeDaramad.fldCodeDaramadId = tblCodhayeDaramd_1.fldId INNER JOIN
									 Drd.tblPardakhtFish ON Drd.tblSodoorFish.fldId = Drd.tblPardakhtFish.fldFishId AND Drd.tblSodoorFish.fldId = Drd.tblPardakhtFish.fldFishId INNER JOIN
									 Com.tblShomareHesabeOmoomi ON Drd.tblSodoorFish.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId
			 WHERE tblSodoorFish.fldId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=tblSodoorFish.fldId)
									 AND CAST( tblPardakhtFish.fldDateVariz AS DATE) BETWEEN @StartDate AND @EndDate
								 
					--GROUP BY tblCodhayeDaramd_1.fldDaramadCode, Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad,fldShomareHesab,fldDaramadId

				
			union all
			SELECT idcode,fldDaramadCode,fldSharheCodeDaramad,fldShomareHesab, cast(cast(fldMablaghNaghdi as numeric(50))*cast(fldmablaghCodeDaramad as numeric(50))/cast(fldmablaghKoli as numeric(50))as bigint),'1'
			,fldDaramadId,'',0,fldShomareHesabId	,fldMaliyatValue,fldAvarezValue , cast(cast(fldMablaghNaghdi as numeric(50))*cast(fldAmuzeshParvareshValue as numeric(50))/cast(fldmablaghKoli as numeric(50))as bigint) fldAmuzeshParvareshValue
			 FROM 
			(SELECT   DISTINCT  tblCodhayeDaramd_1.fldid idcode,  Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId, tblCodhayeDaramd_1.fldDaramadCode, 
									 Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad
									-- ,SUM(fldMablagh) OVER (PARTITION BY fldReplyTaghsitId,tblNaghdi_Talab.fldShomareHesabId) AS fldMablaghNaghdi
									,Drd.fn_SumMablaghNaghdiVariz('Naghdi_Talab',tblNaghdi_Talab.fldFishId,tblNaghdi_Talab.fldShomareHesabId,@azTarikh ,@Tatarikh) AS fldMablaghNaghdi
									,fldShomareHesab ,fldReplyTaghsitId
				,ISNULL(SUM(fldTakhfifAsliValue*fldTedad+fldTakhfifAvarezValue+fldTakhfifMaliyatValue+fldTakhfifAmuzeshParvareshValue),SUM(fldAsliValue*fldTedad+fldAvarezValue+fldMaliyatValue+fldAmuzeshParvareshValue)) AS fldmablaghCodeDaramad
				,(SELECT TOP(1) ISNULL(SUM(fldTakhfifAsliValue*fldTedad+fldTakhfifAvarezValue+fldTakhfifMaliyatValue+fldTakhfifAmuzeshParvareshValue) OVER (PARTITION BY tblCodhayeDaramadiElamAvarez.fldElamAvarezId),SUM(fldAsliValue*fldTedad+fldAvarezValue+fldMaliyatValue+fldAmuzeshParvareshValue) OVER (PARTITION BY tblCodhayeDaramadiElamAvarez.fldElamAvarezId)) FROM Drd.tblCodhayeDaramadiElamAvarez AS a WHERE a.fldElamAvarezId =Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId) AS fldmablaghKoli
			,tblCodhayeDaramd_1.fldDaramadId,Drd.tblNaghdi_Talab.fldShomareHesabId 
			,isnull(fldTakhfifMaliyatValue,fldMaliyatValue)fldMaliyatValue,isnull(fldTakhfifAvarezValue,fldAvarezValue)fldAvarezValue,isnull(fldTakhfifAmuzeshParvareshValue,fldAmuzeshParvareshValue)fldAmuzeshParvareshValue,tblNaghdi_Talab.fldFishId 
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
								
									 GROUP BY tblRequestTaghsit_Takhfif.fldElamAvarezId,tblCodhayeDaramd_1.fldDaramadCode,tblCodhayeDaramd_1.fldid, 
									 Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad,fldMablagh,fldReplyTaghsitId, tblCodhayeDaramadiElamAvarez.fldElamAvarezId
									 ,tblNaghdi_Talab.fldShomareHesabId,fldShomareHesab,fldDaramadId,Drd.tblNaghdi_Talab.fldShomareHesabId 
									,fldMaliyatValue,fldAvarezValue,fldTakhfifMaliyatValue,fldTakhfifAvarezValue,fldAmuzeshParvareshValue,fldTakhfifAmuzeshParvareshValue,tblNaghdi_Talab.fldFishId 
									 )t
		end


		------------------------------------------------------- وصول شده

		INSERT INTO @temp
		 
		SELECT idcode, fldDaramadCode,fldSharheCodeDaramad,fldShomareHesab, cast((cast(cast(fldMablagh as numeric)/cast(fldmablaghKoli as  numeric)as  numeric(38,20))*fldmablaghCodeDaramad)  as bigint),'2',fldDaramadId 
		,'' ,0,fldShomareHesabIdOrgan,fldMaliyatValue,fldAvarezValue, cast((cast(cast(fldMablagh as numeric)/cast(fldmablaghKoli as  numeric)as  numeric(38,20))*fldAmuzeshParvareshValue)  as bigint) fldAmuzeshParvareshValue 
		FROM 
		(SELECT   DISTINCT    Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId, tblCodhayeDaramd_1.fldDaramadCode, tblCodhayeDaramd_1.fldid idcode,
								 Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad
								-- ,SUM(fldMablagh) OVER (PARTITION BY fldReplyTaghsitId,tblNaghdi_Talab.fldShomareHesabId) AS fldMablaghNaghdi
								,Drd.fn_SumMablaghNaghdi('Check',fldReplyTaghsitId,tblCheck.fldShomareHesabIdOrgan,@azTarikh ,@Tatarikh) AS fldMablagh
								,fldShomareHesab ,fldReplyTaghsitId
			,ISNULL(SUM(fldTakhfifAsliValue*fldTedad+fldTakhfifAvarezValue+fldTakhfifMaliyatValue+fldTakhfifAmuzeshParvareshValue),SUM(fldAsliValue*fldTedad+fldAvarezValue+fldMaliyatValue+fldAmuzeshParvareshValue)) AS fldmablaghCodeDaramad
			,(SELECT TOP(1) ISNULL(SUM(fldTakhfifAsliValue*fldTedad+fldTakhfifAvarezValue+fldTakhfifMaliyatValue+fldTakhfifAmuzeshParvareshValue) OVER (PARTITION BY tblCodhayeDaramadiElamAvarez.fldElamAvarezId),SUM(fldAsliValue*fldTedad+fldAvarezValue+fldMaliyatValue+fldAmuzeshParvareshValue) OVER (PARTITION BY tblCodhayeDaramadiElamAvarez.fldElamAvarezId)) FROM Drd.tblCodhayeDaramadiElamAvarez AS a WHERE a.fldElamAvarezId =Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId) AS fldmablaghKoli
		,tblCodhayeDaramd_1.fldDaramadId,tblCheck.fldShomareHesabIdOrgan
		,isnull(fldTakhfifMaliyatValue,fldMaliyatValue)fldMaliyatValue,isnull(fldTakhfifAvarezValue,fldAvarezValue)fldAvarezValue ,isnull(fldTakhfifAmuzeshParvareshValue,fldAmuzeshParvareshValue)fldAmuzeshParvareshValue 
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
								 GROUP BY tblRequestTaghsit_Takhfif.fldElamAvarezId,tblCodhayeDaramd_1.fldDaramadCode, tblCodhayeDaramd_1.fldid,
								 Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad,fldMablaghSanad,fldReplyTaghsitId, tblCodhayeDaramadiElamAvarez.fldElamAvarezId
								 ,tblCheck.fldShomareHesabIdOrgan,fldShomareHesab,fldDaramadId,tblCheck.fldShomareHesabIdOrgan
								 ,fldMaliyatValue,fldAvarezValue,fldTakhfifMaliyatValue,fldTakhfifAvarezValue,fldTakhfifAmuzeshParvareshValue,fldAmuzeshParvareshValue
								 )t


		INSERT INTO @temp
  					 SELECT  idcode,fldDaramadCode,fldSharheCodeDaramad,fldShomareHesab, cast((cast(cast(fldMablagh as numeric)/cast(fldmablaghKoli as  numeric)as  numeric(38,20))*fldmablaghCodeDaramad)  as bigint),'3',fldDaramadId 
					 ,'',0,fldShomareHesadId,fldMaliyatValue,fldAvarezValue ,cast((cast(cast(fldMablagh as numeric)/cast(fldmablaghKoli as  numeric)as  numeric(38,20))*fldAmuzeshParvareshValue)  as bigint) fldAmuzeshParvareshValue
								 FROM 
		(SELECT   DISTINCT    Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId, tblCodhayeDaramd_1.fldDaramadCode,tblCodhayeDaramd_1.fldid idcode, 
								 Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad
								-- ,SUM(fldMablagh) OVER (PARTITION BY fldReplyTaghsitId,tblNaghdi_Talab.fldShomareHesabId) AS fldMablaghNaghdi
								,Drd.fn_SumMablaghNaghdi('Safte',fldReplyTaghsitId,tblShomareHesabCodeDaramad.fldShomareHesadId,@AzTarikh , @Tatarikh) AS fldMablagh
								,fldShomareHesab ,fldReplyTaghsitId
			,ISNULL(SUM(fldTakhfifAsliValue*fldTedad+fldTakhfifAvarezValue+fldTakhfifMaliyatValue+fldTakhfifAmuzeshParvareshValue),SUM(fldAsliValue*fldTedad+fldAvarezValue+fldMaliyatValue+fldAmuzeshParvareshValue)) AS fldmablaghCodeDaramad
			,(SELECT TOP(1) ISNULL(SUM(fldTakhfifAsliValue*fldTedad+fldTakhfifAvarezValue+fldTakhfifMaliyatValue+fldTakhfifAmuzeshParvareshValue) OVER (PARTITION BY tblCodhayeDaramadiElamAvarez.fldElamAvarezId),SUM(fldAsliValue*fldTedad+fldAvarezValue+fldMaliyatValue+fldAmuzeshParvareshValue) OVER (PARTITION BY tblCodhayeDaramadiElamAvarez.fldElamAvarezId)) FROM Drd.tblCodhayeDaramadiElamAvarez AS a WHERE a.fldElamAvarezId =Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId) AS fldmablaghKoli
		,tblCodhayeDaramd_1.fldDaramadId,tblShomareHesabCodeDaramad.fldShomareHesadId
		,isnull(fldTakhfifMaliyatValue,fldMaliyatValue)fldMaliyatValue,isnull(fldTakhfifAvarezValue,fldAvarezValue)fldAvarezValue ,isnull(fldTakhfifAmuzeshParvareshValue,fldAmuzeshParvareshValue)fldAmuzeshParvareshValue
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
								 GROUP BY tblRequestTaghsit_Takhfif.fldElamAvarezId,tblCodhayeDaramd_1.fldDaramadCode, tblCodhayeDaramd_1.fldid,
								 Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad,fldMablaghSanad,fldReplyTaghsitId, tblCodhayeDaramadiElamAvarez.fldElamAvarezId
								 ,tblShomareHesabCodeDaramad.fldShomareHesadId,fldShomareHesab,fldDaramadId,tblShomareHesabCodeDaramad.fldShomareHesadId
								 ,fldMaliyatValue,fldAvarezValue,fldTakhfifMaliyatValue,fldTakhfifAvarezValue,fldTakhfifAmuzeshParvareshValue,fldAmuzeshParvareshValue
								 )t

				INSERT INTO @temp
				SELECT idcode, fldDaramadCode,fldSharheCodeDaramad,fldShomareHesab, cast((cast(cast(fldMablagh as numeric)/cast(fldmablaghKoli as  numeric)as  numeric(38,20))*fldmablaghCodeDaramad)  as bigint),'4',fldDaramadId
				,'',0,fldShomareHesadId,fldMaliyatValue,fldAvarezValue , cast((cast(cast(fldMablagh as numeric)/cast(fldmablaghKoli as  numeric)as  numeric(38,20))*fldAmuzeshParvareshValue)  as bigint) fldAmuzeshParvareshValue
				 FROM 
				(SELECT   DISTINCT    Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId, tblCodhayeDaramd_1.fldDaramadCode, tblCodhayeDaramd_1.fldid idcode,
								 Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad
								-- ,SUM(fldMablagh) OVER (PARTITION BY fldReplyTaghsitId,tblNaghdi_Talab.fldShomareHesabId) AS fldMablaghNaghdi
								,Drd.fn_SumMablaghNaghdi('Barat',fldReplyTaghsitId,tblShomareHesabCodeDaramad.fldShomareHesadId,@AzTarikh,@TaTarikh) AS fldMablagh
								,fldShomareHesab ,fldReplyTaghsitId
			,ISNULL(SUM(fldTakhfifAsliValue*fldTedad+fldTakhfifAvarezValue+fldTakhfifMaliyatValue+fldTakhfifAmuzeshParvareshValue),SUM(fldAsliValue*fldTedad+fldAvarezValue+fldMaliyatValue+fldAmuzeshParvareshValue)) AS fldmablaghCodeDaramad
			,(SELECT TOP(1) ISNULL(SUM(fldTakhfifAsliValue*fldTedad+fldTakhfifAvarezValue+fldTakhfifMaliyatValue+fldTakhfifAmuzeshParvareshValue) OVER (PARTITION BY tblCodhayeDaramadiElamAvarez.fldElamAvarezId),SUM(fldAsliValue*fldTedad+fldAvarezValue+fldMaliyatValue+fldAmuzeshParvareshValue) OVER (PARTITION BY tblCodhayeDaramadiElamAvarez.fldElamAvarezId)) FROM Drd.tblCodhayeDaramadiElamAvarez AS a WHERE a.fldElamAvarezId =Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId) AS fldmablaghKoli
			,tblCodhayeDaramd_1.fldDaramadId,tblShomareHesabCodeDaramad.fldShomareHesadId
			,isnull(fldTakhfifMaliyatValue,fldMaliyatValue)fldMaliyatValue,isnull(fldTakhfifAvarezValue,fldAvarezValue)fldAvarezValue,isnull(fldTakhfifAmuzeshParvareshValue,fldAmuzeshParvareshValue)fldAmuzeshParvareshValue 
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
								 GROUP BY tblRequestTaghsit_Takhfif.fldElamAvarezId,tblCodhayeDaramd_1.fldDaramadCode, tblCodhayeDaramd_1.fldid,
								 Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad,fldMablaghSanad,fldReplyTaghsitId, tblCodhayeDaramadiElamAvarez.fldElamAvarezId
								 ,tblShomareHesabCodeDaramad.fldShomareHesadId,fldShomareHesab,fldDaramadId,tblShomareHesabCodeDaramad.fldShomareHesadId
								 ,fldMaliyatValue,fldAvarezValue,fldTakhfifMaliyatValue,fldTakhfifAvarezValue,fldTakhfifAmuzeshParvareshValue,fldAmuzeshParvareshValue
								 )t
								 	--select * from @temp

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
					
			IF(@ShomareHesabId<>0 AND @CodeDaramadId<>0 and @CodeDaramadId<>-3)
			SELECT distinct P_hid,P_DaramadCode,P_DaramadTitle,P_Level,sum(Mablagh) over (partition by P_idcode)Mablagh,[Count]
				,fldtarikh,fldShomareHesab,fldShomareHesabId
				FROM (SELECT
			ISNULL((SELECT d.fldStrhid FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_hid,
			ISNULL((SELECT fldDaramadCode FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_DaramadCode,
			ISNULL((SELECT d.fldid FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId ),'') AS P_Idcode,
			ISNULL((SELECT fldDaramadTitle FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_DaramadTitle,
			ISNULL((SELECT fldLevel FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_Level
				,sum(mablaghcodeDaramad) over (partition by tem.idcode,tem.ShomareHId)/*ISNULL((SELECT SUM(mablaghcodeDaramad) FROM @temp WHERE Daramadcode=C.fldDaramadCode) ,ISNULL((SELECT SUM(mablaghcodeDaramad) FROM @temp AS t WHERE t.hid.ToString() LIKE c.fldStrhid+'%'),0))*/ AS Mablagh
				,0 AS [Count],'' fldtarikh
				,(SELECT  TOP(1)  fldShomareHesab FROM      
									  Com.tblShomareHesabeOmoomi WHERE tblShomareHesabeOmoomi.fldid=ShomareHId ) fldShomareHesab
				 , ShomareHId fldShomareHesabId	
				 			 ,CASE WHEN fldid IN (SELECT  s.fldId FROM     Drd.tblCodhayeDaramd AS s left JOIN
							  Drd.tblCodhayeDaramd AS p ON  s.fldDaramadId = p.fldDaramadId.GetAncestor(1)
							  WHERE p.fldDaramadId IS NULL AND s.fldId=c.fldid) THEN N'1' ELSE '0' END AS LastNode
			 FROM Drd.tblCodhayeDaramd AS C inner join @temp as tem
			 on tem.idcode=c.fldid
			 WHERE C.fldLevel<>0   AND C.fldId IN (SELECT id FROM @code))s
			 WHERE fldShomareHesabId LIKE @ShomareHesabId and    LastNode=1 and Mablagh<>0
			 
			 IF(@ShomareHesabId<>0 AND @CodeDaramadId=-3)
			SELECT distinct ''P_hid,''P_DaramadCode,'آموزش و پرورش'P_DaramadTitle,0 P_Level,sum(Mablagh)Mablagh,0[Count]
				,fldtarikh,fldShomareHesab,fldShomareHesabId
				FROM (SELECT sum(fldAmuzesh) over (partition by tem.ShomareHId)/*ISNULL((SELECT SUM(mablaghcodeDaramad) FROM @temp WHERE Daramadcode=C.fldDaramadCode) ,ISNULL((SELECT SUM(mablaghcodeDaramad) FROM @temp AS t WHERE t.hid.ToString() LIKE c.fldStrhid+'%'),0))*/ AS Mablagh
				,0 AS [Count],'' fldtarikh
				,(SELECT  TOP(1)  fldShomareHesab FROM      
									  Com.tblShomareHesabeOmoomi WHERE tblShomareHesabeOmoomi.fldid=ShomareHId ) fldShomareHesab
				 , ShomareHId fldShomareHesabId	
				 		
			 FROM  @temp as tem
			
			 )s
			 WHERE fldShomareHesabId LIKE @ShomareHesabId and Mablagh<>0
			 group by fldtarikh,fldShomareHesab,fldShomareHesabId


			 ELSE IF(@ShomareHesabId=0 AND @CodeDaramadId=0)
				SELECT distinct P_hid,P_DaramadCode,P_DaramadTitle,P_Level,sum(Mablagh) over (partition by p_Idcode)Mablagh,[Count]
				,fldtarikh,fldShomareHesab,fldShomareHesabId
				FROM (SELECT
			ISNULL((SELECT d.fldStrhid FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_hid,
			ISNULL((SELECT fldDaramadCode FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_DaramadCode,
			ISNULL((SELECT d.fldid FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId ),'') AS P_IdCode,
			ISNULL((SELECT fldDaramadTitle FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_DaramadTitle,
			ISNULL((SELECT fldLevel FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_Level
				,sum(mablaghcodeDaramad) over (partition by tem.idcode,tem.ShomareHId)/*ISNULL((SELECT SUM(mablaghcodeDaramad) FROM @temp WHERE Daramadcode=C.fldDaramadCode) ,ISNULL((SELECT SUM(mablaghcodeDaramad) FROM @temp AS t WHERE t.hid.ToString() LIKE c.fldStrhid+'%'),0))*/ AS Mablagh
				,0 AS [Count],'' fldtarikh
				,(SELECT  TOP(1)  fldShomareHesab FROM      
									  Com.tblShomareHesabeOmoomi WHERE tblShomareHesabeOmoomi.fldid=ShomareHId ) fldShomareHesab
				 , ShomareHId fldShomareHesabId	
				 			 ,CASE WHEN fldid IN (SELECT  s.fldId FROM     Drd.tblCodhayeDaramd AS s left JOIN
							  Drd.tblCodhayeDaramd AS p ON  s.fldDaramadId = p.fldDaramadId.GetAncestor(1)
							  WHERE p.fldDaramadId IS NULL AND s.fldId=c.fldid) THEN N'1' ELSE '0' END AS LastNode
			 FROM Drd.tblCodhayeDaramd AS C inner join @temp as tem
			 on tem.idcode=c.fldid
			 WHERE C.fldLevel<>0) t
			 where  LastNode=1 and Mablagh<>0 
			 union all
			 SELECT distinct ''P_hid,''P_DaramadCode,'آموزش و پرورش'P_DaramadTitle,0 P_Level,sum(Mablagh)Mablagh,0[Count]
				,fldtarikh,fldShomareHesab,fldShomareHesabId
				FROM (SELECT sum(fldAmuzesh) over (partition by tem.ShomareHId)/*ISNULL((SELECT SUM(mablaghcodeDaramad) FROM @temp WHERE Daramadcode=C.fldDaramadCode) ,ISNULL((SELECT SUM(mablaghcodeDaramad) FROM @temp AS t WHERE t.hid.ToString() LIKE c.fldStrhid+'%'),0))*/ AS Mablagh
				,0 AS [Count],'' fldtarikh
				,(SELECT  TOP(1)  fldShomareHesab FROM      
									  Com.tblShomareHesabeOmoomi WHERE tblShomareHesabeOmoomi.fldid=ShomareHId ) fldShomareHesab
				 , ShomareHId fldShomareHesabId	
				 		
			 FROM  @temp as tem
			
			 )s
			 WHERE Mablagh<>0
			 group by fldtarikh,fldShomareHesab,fldShomareHesabId
			 
			 ELSE IF(@ShomareHesabId=0 AND @CodeDaramadId<>0 and @CodeDaramadId<>-3)
			SELECT distinct P_hid,P_DaramadCode,P_DaramadTitle,P_Level,sum(Mablagh) over (partition by P_IdCode)Mablagh,[Count]
				,fldtarikh,fldShomareHesab,fldShomareHesabId
				FROM (SELECT
			ISNULL((SELECT d.fldStrhid FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_hid,
			ISNULL((SELECT fldDaramadCode FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_DaramadCode,
			ISNULL((SELECT d.fldid FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId ),'') AS P_IdCode,
			ISNULL((SELECT fldDaramadTitle FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_DaramadTitle,
			ISNULL((SELECT fldLevel FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_Level
				,sum(mablaghcodeDaramad) over (partition by tem.idcode,tem.ShomareHId)/*ISNULL((SELECT SUM(mablaghcodeDaramad) FROM @temp WHERE Daramadcode=C.fldDaramadCode) ,ISNULL((SELECT SUM(mablaghcodeDaramad) FROM @temp AS t WHERE t.hid.ToString() LIKE c.fldStrhid+'%'),0))*/ AS Mablagh
				,0 AS [Count],'' fldtarikh
				,(SELECT  TOP(1)  fldShomareHesab FROM      
									  Com.tblShomareHesabeOmoomi WHERE tblShomareHesabeOmoomi.fldid=ShomareHId ) fldShomareHesab
				 , ShomareHId fldShomareHesabId	
				 			  ,CASE WHEN fldid IN (SELECT  s.fldId FROM     Drd.tblCodhayeDaramd AS s left JOIN
							  Drd.tblCodhayeDaramd AS p ON  s.fldDaramadId = p.fldDaramadId.GetAncestor(1)
							  WHERE p.fldDaramadId IS NULL AND s.fldId=c.fldid) THEN N'1' ELSE '0' END AS LastNode
			 FROM Drd.tblCodhayeDaramd AS C inner join @temp as tem
			 on tem.idcode=c.fldid
			 WHERE C.fldLevel<>0   AND C.fldId IN (SELECT id FROM @code))t
			 where    LastNode=1 and Mablagh<>0

			  ELSE IF(@ShomareHesabId=0 AND @CodeDaramadId=-3)
			SELECT distinct ''P_hid,''P_DaramadCode,N'آموزش و پرورش'P_DaramadTitle,0P_Level,sum(Mablagh) over (partition by fldShomareHesabId)Mablagh,[Count]
				,fldtarikh,fldShomareHesab,fldShomareHesabId
				FROM (SELECT sum(fldAmuzesh) over (partition by tem.ShomareHId)/*ISNULL((SELECT SUM(mablaghcodeDaramad) FROM @temp WHERE Daramadcode=C.fldDaramadCode) ,ISNULL((SELECT SUM(mablaghcodeDaramad) FROM @temp AS t WHERE t.hid.ToString() LIKE c.fldStrhid+'%'),0))*/ AS Mablagh
				,0 AS [Count],'' fldtarikh
				,(SELECT  TOP(1)  fldShomareHesab FROM      
									  Com.tblShomareHesabeOmoomi WHERE tblShomareHesabeOmoomi.fldid=ShomareHId ) fldShomareHesab
				 , ShomareHId fldShomareHesabId	
				 			  
			 FROM @temp as tem
			 
			)t
			 where    Mablagh<>0


			 ELSE IF(@ShomareHesabId<>0 AND @CodeDaramadId=0)
			SELECT distinct P_hid,P_DaramadCode,P_DaramadTitle,P_Level,sum(Mablagh) over (partition by P_Idcode)Mablagh,[Count]
				,fldtarikh,fldShomareHesab,fldShomareHesabId
				FROM (SELECT
			ISNULL((SELECT d.fldStrhid FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_hid,
			ISNULL((SELECT fldDaramadCode FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_DaramadCode,
			ISNULL((SELECT d.fldid FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId),'') AS P_idcode,
			ISNULL((SELECT fldDaramadTitle FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_DaramadTitle,
			ISNULL((SELECT fldLevel FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_Level
				,sum(mablaghcodeDaramad) over (partition by tem.idcode,tem.ShomareHId)/*ISNULL((SELECT SUM(mablaghcodeDaramad) FROM @temp WHERE Daramadcode=C.fldDaramadCode) ,ISNULL((SELECT SUM(mablaghcodeDaramad) FROM @temp AS t WHERE t.hid.ToString() LIKE c.fldStrhid+'%'),0))*/ AS Mablagh
				,0 AS [Count],'' fldtarikh
				,(SELECT  TOP(1)  fldShomareHesab FROM      
									  Com.tblShomareHesabeOmoomi WHERE tblShomareHesabeOmoomi.fldid=ShomareHId ) fldShomareHesab
				 , ShomareHId fldShomareHesabId	
				 			  ,CASE WHEN fldid IN (SELECT  s.fldId FROM     Drd.tblCodhayeDaramd AS s left JOIN
							  Drd.tblCodhayeDaramd AS p ON  s.fldDaramadId = p.fldDaramadId.GetAncestor(1)
							  WHERE p.fldDaramadId IS NULL AND s.fldId=c.fldid) THEN N'1' ELSE '0' END AS LastNode
			 FROM Drd.tblCodhayeDaramd AS C inner join @temp as tem
			 on tem.idcode=c.fldid
			 WHERE C.fldLevel<>0  and ShomareHId LIKE @ShomareHesabId  )t
			  WHERE    LastNode=1 and Mablagh<>0

			  union all
			  SELECT distinct ''P_hid,''P_DaramadCode,'آموزش و پرورش'P_DaramadTitle,0 P_Level,sum(Mablagh)Mablagh,0[Count]
				,fldtarikh,fldShomareHesab,fldShomareHesabId
				FROM (SELECT sum(fldAmuzesh) over (partition by tem.ShomareHId)/*ISNULL((SELECT SUM(mablaghcodeDaramad) FROM @temp WHERE Daramadcode=C.fldDaramadCode) ,ISNULL((SELECT SUM(mablaghcodeDaramad) FROM @temp AS t WHERE t.hid.ToString() LIKE c.fldStrhid+'%'),0))*/ AS Mablagh
				,0 AS [Count],'' fldtarikh
				,(SELECT  TOP(1)  fldShomareHesab FROM      
									  Com.tblShomareHesabeOmoomi WHERE tblShomareHesabeOmoomi.fldid=ShomareHId ) fldShomareHesab
				 , ShomareHId fldShomareHesabId	
				 		
			 FROM  @temp as tem
			
			 )s
			 WHERE fldShomareHesabId LIKE @ShomareHesabId and Mablagh<>0
			 group by fldtarikh,fldShomareHesab,fldShomareHesabId
			end  
end
GO
