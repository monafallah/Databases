SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
	CREATE PROC [Drd].[spr_RptListCodeDaramad_6Raghami](@AzTarikh NVARCHAR(10),@TaTarikh NVARCHAR(10),@OrganId INt,@DateType tinyint)
AS
--DECLARE @fieldname NVARCHAR(50)='all', @AzTarikh NVARCHAR(10)='1404/03/01',@TaTarikh NVARCHAR(10)='1404/03/03',@ShomareHesabId INT=0,@CodeDaramadId INT=0,@OrganId INT=1,@DateType tinyint=0
DECLARE @temp TABLE(idcode int,Daramadcode NVARCHAR(50),sharhecode NVARCHAR(300),shomareHesab NVARCHAR(50),mablaghcodeDaramad BIGINT,fldtype NVARCHAR(1),hid HIERARCHYID,fldtarikh nvarchar (10),c int,ShomareHId INT,Maliyat bigint,Avarez bigint ,fldAmuzesh bigint)
DECLARE @temp_Hid TABLE(Daramadcode NVARCHAR(50),sharhecode NVARCHAR(300),shomareHesab NVARCHAR(50),mablaghcodeDaramad BIGINT,hid HIERARCHYID)
DECLARE @code table(id int ,CodeDaramad NVARCHAR(50),fldLevel NVARCHAR(50))
DECLARE @StartDate DATE=com.ShamsiToMiladi(@Aztarikh)
DECLARE @EndDate DATE=com.ShamsiToMiladi(@TaTarikh)
declare @table table (P_DaramdCode nvarchar(max),P_DaramadTitle nvarchar(max),Mablagh bigint,Tedad int,fldTarikh nvarchar(10),fldShomareHesab nvarchar(max),fldShomareHesabId int,P_Idcode int)
declare @salJari int,@headerAccid int
set @salJari=substring(dbo.Fn_AssembelyMiladiToShamsi (getdate()),1,4)
select @headerAccid=fldid from acc.tblCoding_Header
where fldYear=@salJari and fldOrganId=@OrganId
	/*if(@DateType=1)/*براساس تاریخ پرداخت*/
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
			begin*/
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
									AND( ( tblPardakhtFish.fldDateVariz is not null and  CAST( tblPardakhtFish.fldDateVariz AS DATE) BETWEEN @StartDate AND @EndDate)
										or ( tblPardakhtFish.fldDateVariz is  null and  CAST( tblPardakhtFish.fldDatePardakht AS DATE) BETWEEN @StartDate AND @EndDate)
									 )	 AND tblShomareHesabCodeDaramad.fldOrganId=@OrganId
								 
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
									AND( ( tblPardakhtFish.fldDateVariz is not null and  CAST( tblPardakhtFish.fldDateVariz AS DATE) BETWEEN @StartDate AND @EndDate)
										or ( tblPardakhtFish.fldDateVariz is  null and  CAST( tblPardakhtFish.fldDatePardakht AS DATE) BETWEEN @StartDate AND @EndDate)
									 )
									AND tblShomareHesabCodeDaramad.fldOrganId=@OrganId
									 GROUP BY tblRequestTaghsit_Takhfif.fldElamAvarezId,tblCodhayeDaramd_1.fldDaramadCode,tblCodhayeDaramd_1.fldid, 
									 Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad,fldMablagh,fldReplyTaghsitId, tblCodhayeDaramadiElamAvarez.fldElamAvarezId
									 ,tblNaghdi_Talab.fldShomareHesabId,fldShomareHesab,fldDaramadId,Drd.tblNaghdi_Talab.fldShomareHesabId 
										,fldMaliyatValue,fldAvarezValue,fldTakhfifMaliyatValue,fldTakhfifAvarezValue,tblNaghdi_Talab.fldFishId 
										,fldTakhfifAmuzeshParvareshValue,fldAmuzeshParvareshValue
									 )t
		--end

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
--select t.* from @temp t --where Daramadcode='130102001'
--left  join  acc.tblCoding_Details d on d.fldDaramadCode=t.Daramadcode and  fldHeaderCodId=6 and fldcode like '4%'
--where d.fldid is null --and Daramadcode like '130102%'
--order by Daramadcode
			
		select parent.fldDaramadCode DaramadCode, parent.fldDaramadTitle DaramadTitle ,sum(mablaghcodeDaramad)Mablagh,
		 -- parent.fldDaramadId.ToString() AS NodePath,
    parent.fldDaramadId.GetLevel() AS fldLevel
		/* CASE 
        WHEN EXISTS (
            SELECT 1 
            FROM drd.tblCodhayeDaramd c 
            WHERE c.fldDaramadId.GetAncestor(1) = parent.fldDaramadId
        ) THEN N'پدر'
        ELSE N'فرزند'
    END AS NodeType*/
		from @temp child
		join drd.tblCodhayeDaramd  parent   ON child.hid.IsDescendantOf(parent.fldDaramadId) = 1
		inner join drd.tblShomareHedabCodeDaramd_Detail dd on dd.fldCodeDaramdId=parent.fldId and fldEndYear=@salJari
		 join  acc.tblCoding_Details d on d.fldDaramadCode=parent.fldDaramadCode and  fldHeaderCodId=@headerAccid and fldcode like '4%'
		group by parent.fldDaramadTitle,parent.fldDaramadCode,fldDaramadId
		order by parent.fldDaramadCode
	
		select parent.fldDaramadCode DaramadCode, parent.fldDaramadTitle DaramadTitle ,sum(mablaghcodeDaramad)Mablagh,
		 -- parent.fldDaramadId.ToString() AS NodePath,
    parent.fldDaramadId.GetLevel() AS fldLevel
			 from (select isnull(fldidNew,idcode)IdAsliCode,isnull(c.fldDaramadId,hid)hid,isnull(c.fldDaramadCode,Daramadcode)DarmadCodeAsli,
isnull(c.fldDaramadTitle,sharhecode)sharhecode,mablaghcodeDaramad,fldtype
 from @temp t --where Daramadcode='130102001'
left join   drd.tblMapCodDaramad m on m.fldidOld=t.idcode
left join drd.tblCodhayeDaramd c on c.fldid=fldidnew
)child
		join drd.tblCodhayeDaramd  parent   ON child.hid.IsDescendantOf(parent.fldDaramadId) = 1
		inner join drd.tblShomareHedabCodeDaramd_Detail dd on dd.fldCodeDaramdId=parent.fldId and fldEndYear=@salJari
		 join  acc.tblCoding_Details d on d.fldDaramadCode=parent.fldDaramadCode and  fldHeaderCodId=@headerAccid and fldcode like '4%'
		group by parent.fldDaramadTitle,parent.fldDaramadCode,fldDaramadId
		order by parent.fldDaramadCode
 
				 
				
GO
