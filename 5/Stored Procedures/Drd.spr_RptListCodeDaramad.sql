SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_RptListCodeDaramad](@AzTarikh NVARCHAR(10),@TaTarikh NVARCHAR(10),@ShomareHesabId INT,@CodeDaramadId INT,@OrganId INT,@fieldname NVARCHAR(50),@DateType tinyint)
AS
--DECLARE @fieldname NVARCHAR(50)='detail', @AzTarikh NVARCHAR(10)='1403/08/19',@TaTarikh NVARCHAR(10)='1403/08/19',@ShomareHesabId INT=0,@CodeDaramadId INT=-3,@OrganId INT=1,@DateType tinyint=1
DECLARE @temp TABLE(fldidCodid int,Daramadcode NVARCHAR(50),sharhecode NVARCHAR(300),shomareHesab NVARCHAR(50),mablaghcodeDaramad BIGINT,fldtype NVARCHAR(1),hid HIERARCHYID,fldtarikh nvarchar (10),c int,ShomareHId INT,Maliyat bigint,Avarez bigint,fldAmuzesh bigint)
DECLARE @temp_Hid TABLE(Daramadcode NVARCHAR(50),sharhecode NVARCHAR(300),shomareHesab NVARCHAR(50),mablaghcodeDaramad BIGINT,hid HIERARCHYID)
DECLARE @code table(id int ,CodeDaramad NVARCHAR(50),fldLevel NVARCHAR(50))
DECLARE @StartDate DATE=com.ShamsiToMiladi(@Aztarikh)
DECLARE @EndDate DATE=com.ShamsiToMiladi(@TaTarikh)
DECLARE @MaliyatId INT,@AvarezId INT,@CodeMaliyat varchar(100),@CodeAvarez varchar(100)
SELECT @MaliyatId=fldMaliyatId ,@AvarezId=fldAvarezId FROM Drd.tblTanzimateDaramad WHERE fldOrganId=@OrganId
/*ghadimi*/--SELECT @CodeMaliyat=fldCodeDaramadId FROM Drd.tblShomareHesabCodeDaramad WHERE fldid=@MaliyatId
--SELECT @CodeAvarez=fldCodeDaramadId FROM Drd.tblShomareHesabCodeDaramad WHERE fldid=@AvarezId
------jadid
/*declare @c_Maliyat varchar(10)='',@c_Avarez varchar(10)='' 
SELECT @c_Maliyat=fldCode FROM acc.tblCoding_Details WHERE fldid=@MaliyatId
SELECT @c_Avarez=fldCode FROM acc.tblCoding_Details WHERE fldid=@AvarezId

select  @CodeMaliyat=c.fldId from drd.tblCodhayeDaramd c inner join drd.tblShomareHesabCodeDaramad s 
on c.fldId=s.fldCodeDaramadId where fldDaramadCode=@c_Maliyat
select @CodeAvarez=c.fldid from drd.tblCodhayeDaramd  c inner join drd.tblShomareHesabCodeDaramad s 
on c.fldId=s.fldCodeDaramadId where fldDaramadCode=@c_Avarez*/
select @CodeAvarez=c.fldcode,@CodeMaliyat=c1.fldcode from drd.tblTanzimateDaramad t inner join  acc.tblCoding_Details c
on c.fldid=t.fldAvarezId
inner join acc.tblCoding_Details c1
on c1.fldid=t.fldMaliyatId
 where fldOrganId=@OrganId



--select * from drd.tblCodhayeDaramd where fldDaramadCode='402005/08'
if(@fieldname='Detail')
BEGIN
	IF(@OrganId<>0)
	BEGIN
			if(@DateType=1)/*براساس تاریخ پرداخت*/
			begin
				INSERT INTO @temp
				--( Daramadcode ,sharhecode , shomareHesab , mablaghcodeDaramad,fldtype,hid ,fldtarikh )
				SELECT      tblCodhayeDaramd_1.fldid,  tblCodhayeDaramd_1.fldDaramadCode, Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad, Com.tblShomareHesabeOmoomi.fldShomareHesab, 
									   ISNULL(cast((Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifAsliValue * Drd.tblCodhayeDaramadiElamAvarez.fldTedad + Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifAvarezValue + Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifMaliyatValue+Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifAmuzeshParvareshValue)as bigint),
										  cast((Drd.tblCodhayeDaramadiElamAvarez.fldAsliValue * Drd.tblCodhayeDaramadiElamAvarez.fldTedad + Drd.tblCodhayeDaramadiElamAvarez.fldAvarezValue + Drd.tblCodhayeDaramadiElamAvarez.fldMaliyatValue+fldAmuzeshParvareshValue)as bigint))
					AS fldmablaghCodeDaramad, '0' AS Expr1, tblCodhayeDaramd_1.fldDaramadId,tblPardakhtFish.fldTarikh,tblPardakhtFish.fldId,tblSodoorFish.fldShomareHesabId,isnull(fldTakhfifMaliyatValue,fldMaliyatValue)fldMaliyatValue,isnull(fldTakhfifAvarezValue,fldAvarezValue)fldAvarezValue,isnull(fldTakhfifAmuzeshParvareshValue,fldAmuzeshParvareshValue)fldAmuzeshParvareshValue
			
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
				SELECT codid,fldDaramadCode,fldSharheCodeDaramad,fldShomareHesab, cast(cast(fldMablaghNaghdi as decimal(50))*cast(fldmablaghCodeDaramad as decimal(50))/cast(fldmablaghKoli as decimal(50))as bigint),'1'
				,fldDaramadId,fldTarikh,fldId,fldShomareHesabId,fldMaliyatValue,fldAvarezValue, cast(cast(fldMablaghNaghdi as decimal(50))*cast(fldAmuzeshParvareshValue as decimal(50))/cast(fldmablaghKoli as decimal(50))as bigint) fldAmuzeshParvareshValue
				 FROM 
				(SELECT   DISTINCT    Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId,tblCodhayeDaramd_1.fldid codid, tblCodhayeDaramd_1.fldDaramadCode, 
										 Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad
										,Drd.fn_SumMablaghNaghdi('Naghdi_Talab',tblNaghdi_Talab.fldFishId,tblNaghdi_Talab.fldShomareHesabId,@azTarikh ,@Tatarikh) AS fldMablaghNaghdi
										,fldShomareHesab ,fldReplyTaghsitId
					,ISNULL(SUM(fldTakhfifAsliValue*fldTedad+fldTakhfifAvarezValue+fldTakhfifMaliyatValue+fldTakhfifAmuzeshParvareshValue),SUM(fldAsliValue*fldTedad+fldAvarezValue+fldMaliyatValue+fldAmuzeshParvareshValue)) AS fldmablaghCodeDaramad
					,(SELECT TOP(1) ISNULL(SUM(fldTakhfifAsliValue*fldTedad+fldTakhfifAvarezValue+fldTakhfifMaliyatValue+fldTakhfifAmuzeshParvareshValue) OVER (PARTITION BY tblCodhayeDaramadiElamAvarez.fldElamAvarezId),SUM(fldAsliValue*fldTedad+fldAvarezValue+fldMaliyatValue+fldAmuzeshParvareshValue) OVER (PARTITION BY tblCodhayeDaramadiElamAvarez.fldElamAvarezId)) FROM Drd.tblCodhayeDaramadiElamAvarez AS a WHERE a.fldElamAvarezId =Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId) AS fldmablaghKoli
				,tblCodhayeDaramd_1.fldDaramadId,tblPardakhtFish.fldTarikh,tblPardakhtFish.fldId,Drd.tblNaghdi_Talab.fldShomareHesabId,isnull(fldTakhfifMaliyatValue,fldMaliyatValue)fldMaliyatValue,isnull(fldTakhfifAvarezValue,fldAvarezValue)fldAvarezValue,isnull(fldTakhfifAmuzeshParvareshValue,fldAmuzeshParvareshValue)fldAmuzeshParvareshValue
				,tblNaghdi_Talab.fldFishId
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
							 
								 GROUP BY tblCodhayeDaramd_1.fldid,tblRequestTaghsit_Takhfif.fldElamAvarezId,tblCodhayeDaramd_1.fldDaramadCode, 
								 Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad,fldMablagh,fldReplyTaghsitId, tblCodhayeDaramadiElamAvarez.fldElamAvarezId
								 ,tblNaghdi_Talab.fldShomareHesabId,fldShomareHesab,fldDaramadId,tblPardakhtFish.fldTarikh,tblPardakhtFish.fldId,tblNaghdi_Talab.fldShomareHesabId
							,fldMaliyatValue,fldAvarezValue,fldTakhfifMaliyatValue,fldTakhfifAvarezValue,tblNaghdi_Talab.fldFishId,fldTakhfifAmuzeshParvareshValue,fldAmuzeshParvareshValue
								 )t

			end
		else if(@DateType=0)/*براساس تاریخ واریز*/
			begin
				INSERT INTO @temp
				--( Daramadcode ,sharhecode , shomareHesab , mablaghcodeDaramad,fldtype,hid ,fldtarikh )
				SELECT    tblCodhayeDaramd_1.fldid,    tblCodhayeDaramd_1.fldDaramadCode, Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad, Com.tblShomareHesabeOmoomi.fldShomareHesab, 
									   ISNULL(cast((Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifAsliValue * Drd.tblCodhayeDaramadiElamAvarez.fldTedad + Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifAvarezValue + Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifMaliyatValue+tblCodhayeDaramadiElamAvarez.fldTakhfifAmuzeshParvareshValue)as bigint),
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
				SELECT codid,fldDaramadCode,fldSharheCodeDaramad,fldShomareHesab, cast(cast(fldMablaghNaghdi as decimal(50))*cast(fldmablaghCodeDaramad as decimal(50))/cast(fldmablaghKoli as decimal(50))as bigint),'1'
				,fldDaramadId,fldTarikhVariz,fldId,fldShomareHesabId,fldMaliyatValue,fldAvarezValue, cast(cast(fldMablaghNaghdi as decimal(50))*cast(fldAmuzeshParvareshValue as decimal(50))/cast(fldmablaghKoli as decimal(50))as bigint) fldAmuzeshParvareshValue
				 FROM 
				(SELECT   DISTINCT    Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId,tblCodhayeDaramd_1.fldid codid, tblCodhayeDaramd_1.fldDaramadCode, 
										 Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad
										,Drd.fn_SumMablaghNaghdiVariz('Naghdi_Talab',tblNaghdi_Talab.fldFishId,tblNaghdi_Talab.fldShomareHesabId,@azTarikh ,@Tatarikh) AS fldMablaghNaghdi
										,fldShomareHesab ,fldReplyTaghsitId
					,ISNULL(SUM(fldTakhfifAsliValue*fldTedad+fldTakhfifAvarezValue+fldTakhfifMaliyatValue+fldTakhfifAmuzeshParvareshValue),SUM(fldAsliValue*fldTedad+fldAvarezValue+fldMaliyatValue+fldAmuzeshParvareshValue)) AS fldmablaghCodeDaramad
					,(SELECT TOP(1) ISNULL(SUM(fldTakhfifAsliValue*fldTedad+fldTakhfifAvarezValue+fldTakhfifMaliyatValue+fldTakhfifAmuzeshParvareshValue) OVER (PARTITION BY tblCodhayeDaramadiElamAvarez.fldElamAvarezId),SUM(fldAsliValue*fldTedad+fldAvarezValue+fldMaliyatValue+fldAmuzeshParvareshValue) OVER (PARTITION BY tblCodhayeDaramadiElamAvarez.fldElamAvarezId)) FROM Drd.tblCodhayeDaramadiElamAvarez AS a WHERE a.fldElamAvarezId =Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId) AS fldmablaghKoli
				,tblCodhayeDaramd_1.fldDaramadId,tblPardakhtFish.fldTarikhVariz,tblPardakhtFish.fldId,Drd.tblNaghdi_Talab.fldShomareHesabId,isnull(fldTakhfifMaliyatValue,fldMaliyatValue)fldMaliyatValue,isnull(fldTakhfifAvarezValue,fldAvarezValue)fldAvarezValue,isnull(fldTakhfifAmuzeshParvareshValue,fldAmuzeshParvareshValue)fldAmuzeshParvareshValue
				,tblNaghdi_Talab.fldFishId
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
							 
								 GROUP BY tblCodhayeDaramd_1.fldid ,tblRequestTaghsit_Takhfif.fldElamAvarezId,tblCodhayeDaramd_1.fldDaramadCode, 
								 Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad,fldMablagh,fldReplyTaghsitId, tblCodhayeDaramadiElamAvarez.fldElamAvarezId
								 ,tblNaghdi_Talab.fldShomareHesabId,fldShomareHesab,fldDaramadId,tblPardakhtFish.fldTarikhVariz,tblPardakhtFish.fldId,tblNaghdi_Talab.fldShomareHesabId
							,fldMaliyatValue,fldAvarezValue,fldTakhfifMaliyatValue,fldTakhfifAvarezValue,tblNaghdi_Talab.fldFishId,fldTakhfifAmuzeshParvareshValue,fldAmuzeshParvareshValue
								 )t

			end
	------------------------------------------------------- وصول شده

							INSERT INTO @temp
							 
							SELECT codeid, fldDaramadCode,fldSharheCodeDaramad,fldShomareHesab,cast((cast(cast(fldMablagh as numeric)/cast(fldmablaghKoli as  numeric)as  numeric(38,20))*fldmablaghCodeDaramad)  as bigint) ,'2',fldDaramadId,fldDateStatus,
							fldid,fldShomareHesabIdOrgan,fldMaliyatValue,fldAvarezValue, cast((cast(cast(fldMablagh as numeric)/cast(fldmablaghKoli as  numeric)as  numeric(38,20))*fldAmuzeshParvareshValue)  as bigint) fldAmuzeshParvareshValue
							 FROM 
							(SELECT   DISTINCT    Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId,tblCodhayeDaramd_1.fldid codeid, tblCodhayeDaramd_1.fldDaramadCode, 
													 Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad
													,Drd.fn_SumMablaghNaghdi('Check',tblcheck.fldId,tblCheck.fldShomareHesabIdOrgan,@azTarikh ,@Tatarikh) AS fldMablagh
													,fldShomareHesab ,fldReplyTaghsitId
								,ISNULL(SUM(fldTakhfifAsliValue*fldTedad+fldTakhfifAvarezValue+fldTakhfifMaliyatValue+fldTakhfifAmuzeshParvareshValue),SUM(fldAsliValue*fldTedad+fldAvarezValue+fldMaliyatValue+fldAmuzeshParvareshValue)) AS fldmablaghCodeDaramad
								,(SELECT TOP(1) ISNULL(SUM(fldTakhfifAsliValue*fldTedad+fldTakhfifAvarezValue+fldTakhfifMaliyatValue+fldTakhfifAmuzeshParvareshValue) OVER (PARTITION BY tblCodhayeDaramadiElamAvarez.fldElamAvarezId),SUM(fldAsliValue*fldTedad+fldAvarezValue+fldMaliyatValue+fldAmuzeshParvareshValue) OVER (PARTITION BY tblCodhayeDaramadiElamAvarez.fldElamAvarezId)) FROM Drd.tblCodhayeDaramadiElamAvarez AS a WHERE a.fldElamAvarezId =Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId) AS fldmablaghKoli
							,tblCodhayeDaramd_1.fldDaramadId,fldDateStatus,tblcheck.fldid,tblCheck.fldShomareHesabIdOrgan,isnull(fldTakhfifMaliyatValue,fldMaliyatValue)fldMaliyatValue,isnull(fldTakhfifAvarezValue,fldAvarezValue)fldAvarezValue,isnull(fldTakhfifAmuzeshParvareshValue,fldAmuzeshParvareshValue)fldAmuzeshParvareshValue
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
							 GROUP BY tblCodhayeDaramd_1.fldid,tblRequestTaghsit_Takhfif.fldElamAvarezId,tblCodhayeDaramd_1.fldDaramadCode, 
							 Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad,fldMablaghSanad,fldReplyTaghsitId, tblCodhayeDaramadiElamAvarez.fldElamAvarezId
							 ,tblCheck.fldShomareHesabIdOrgan,fldShomareHesab,fldDaramadId,fldDateStatus,tblcheck.fldid,fldShomareHesabIdOrgan,fldMaliyatValue,fldAvarezValue
							,fldTakhfifMaliyatValue,fldTakhfifAvarezValue,fldTakhfifAmuzeshParvareshValue,fldAmuzeshParvareshValue
							 )t


					INSERT INTO @temp
	       
							 SELECT  codid,fldDaramadCode,fldSharheCodeDaramad,fldShomareHesab,cast((cast(cast(fldMablagh as numeric)/cast(fldmablaghKoli as  numeric)as  numeric(38,20))*fldmablaghCodeDaramad)  as bigint) ,'3'
							 ,fldDaramadId,fldDateStatus,fldid ,fldShomareHesadId,fldMaliyatValue,fldAvarezValue, cast((cast(cast(fldMablagh as numeric)/cast(fldmablaghKoli as  numeric)as  numeric(38,20))*fldAmuzeshParvareshValue)  as bigint) fldAmuzeshParvareshValue
							 FROM 
						(SELECT   DISTINCT    Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId,tblCodhayeDaramd_1.fldid codid, tblCodhayeDaramd_1.fldDaramadCode, 
												 Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad
												-- ,SUM(fldMablagh) OVER (PARTITION BY fldReplyTaghsitId,tblNaghdi_Talab.fldShomareHesabId) AS fldMablaghNaghdi
												,Drd.fn_SumMablaghNaghdi('Safte',fldReplyTaghsitId,tblShomareHesabCodeDaramad.fldShomareHesadId,@AzTarikh , @Tatarikh) AS fldMablagh
												,fldShomareHesab ,fldReplyTaghsitId
							,ISNULL(SUM(fldTakhfifAsliValue*fldTedad+fldTakhfifAvarezValue+fldTakhfifMaliyatValue+fldTakhfifAmuzeshParvareshValue),SUM(fldAsliValue*fldTedad+fldAvarezValue+fldMaliyatValue+fldAmuzeshParvareshValue)) AS fldmablaghCodeDaramad
							,(SELECT TOP(1) ISNULL(SUM(fldTakhfifAsliValue*fldTedad+fldTakhfifAvarezValue+fldTakhfifMaliyatValue+fldTakhfifAmuzeshParvareshValue) OVER (PARTITION BY tblCodhayeDaramadiElamAvarez.fldElamAvarezId),SUM(fldAsliValue*fldTedad+fldAvarezValue+fldMaliyatValue+fldAmuzeshParvareshValue) OVER (PARTITION BY tblCodhayeDaramadiElamAvarez.fldElamAvarezId)) FROM Drd.tblCodhayeDaramadiElamAvarez AS a WHERE a.fldElamAvarezId =Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId) AS fldmablaghKoli
						,tblCodhayeDaramd_1.fldDaramadId,fldDateStatus,tblSafte.fldid,tblShomareHesabCodeDaramad.fldShomareHesadId
						,isnull(fldTakhfifMaliyatValue,fldMaliyatValue)fldMaliyatValue,isnull(fldTakhfifAvarezValue,fldAvarezValue)fldAvarezValue,isnull(fldTakhfifAmuzeshParvareshValue,fldAmuzeshParvareshValue)fldAmuzeshParvareshValue
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
							 GROUP BY tblCodhayeDaramd_1.fldid,tblRequestTaghsit_Takhfif.fldElamAvarezId,tblCodhayeDaramd_1.fldDaramadCode, 
							 Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad,fldMablaghSanad,fldReplyTaghsitId, tblCodhayeDaramadiElamAvarez.fldElamAvarezId
							 ,tblShomareHesabCodeDaramad.fldShomareHesadId,fldShomareHesab,fldDaramadId,fldDateStatus,tblSafte.fldid,fldShomareHesadId
							,fldMaliyatValue,fldAvarezValue,fldTakhfifMaliyatValue,fldTakhfifAvarezValue,fldAmuzeshParvareshValue,fldTakhfifAmuzeshParvareshValue
							 )t

					INSERT INTO @temp
					SELECT codid, fldDaramadCode,fldSharheCodeDaramad,fldShomareHesab,cast((cast(cast(fldMablagh as numeric)/cast(fldmablaghKoli as  numeric)as  numeric(38,20))*fldmablaghCodeDaramad)  as bigint),'4',fldDaramadId
					,fldDateStatus,fldid,fldShomareHesadId ,fldMaliyatValue,fldAvarezValue, cast((cast(cast(fldMablagh as numeric)/cast(fldmablaghKoli as  numeric)as  numeric(38,20))*fldAmuzeshParvareshValue)  as bigint) fldAmuzeshParvareshValue
					FROM 
					(SELECT   DISTINCT    Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId,tblCodhayeDaramd_1.fldid codid, tblCodhayeDaramd_1.fldDaramadCode, 
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
							 GROUP BY tblCodhayeDaramd_1.fldid,tblRequestTaghsit_Takhfif.fldElamAvarezId,tblCodhayeDaramd_1.fldDaramadCode, 
							 Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad,fldMablaghSanad,fldReplyTaghsitId, tblCodhayeDaramadiElamAvarez.fldElamAvarezId
							 ,tblShomareHesabCodeDaramad.fldShomareHesadId,fldShomareHesab,fldDaramadId,fldDateStatus,tblbarat.fldid,fldShomareHesadId,fldMaliyatValue,fldAvarezValue
							,fldTakhfifMaliyatValue,fldTakhfifAvarezValue,fldAmuzeshParvareshValue,fldTakhfifAmuzeshParvareshValue
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
			
			
			
			 IF(@ShomareHesabId<>0 AND /*@CodeMaliyat=*/@CodeDaramadId=-2)/*مالیات*/
			SELECT DISTINCT * FROM (
			SELECT /* (select fldStrhid from drd.tblCodhayeDaramd where fldid=@CodeMaliyat)*/'' AS hidChilde,
			/*(select tblCodhayeDaramd.fldDaramadCode from drd.tblCodhayeDaramd where fldid=@CodeMaliyat)*/'_' AS DaramdCodeChilde
			,/*(select fldCodeHesab from drd.tblParametrHesabdari where fldShomareHesabCodeDaramadId=(select fldId from drd.tblShomareHesabCodeDaramad as d where d.fldCodeDaramadId=@CodeDaramadId))*/@codeMaliyat AS DaramdCodeChilde1
			,N'مالیات' AS DaramadTitleChilde
			,/*(select tblCodhayeDaramd.fldLevel from drd.tblCodhayeDaramd where fldid=@CodeMaliyat)*/cast(0 as smallint) AS lvlChilde,
			'' AS P_hid,''AS P_DaramadCode,'' AS P_DaramadTitle,cast(0 as smallint) AS P_Level
			,sum(e.Maliyat) over (partition by fldtarikh,e.fldidcodid) as Mablagh
			,count(c)over (partition by fldtarikh,e.fldidcodid) as [Count],e.fldtarikh
			,(SELECT  TOP(1)  fldShomareHesab FROM        
			 Com.tblShomareHesabeOmoomi WHERE tblShomareHesabeOmoomi.fldid=ShomareHId /*AND fldOrganId=@OrganId*/) fldShomareHesab
			 , '1'  AS LastNode
			 FROM  @temp as e
			 WHERE ShomareHId=@ShomareHesabId  /*AND C.fldId IN (SELECT id FROM @code)*/)s
			 WHERE     LastNode=1 and Mablagh<>0
			 order by fldtarikh
			 

			 
			 IF(@ShomareHesabId<>0 AND /*@CodeMaliyat=*/@CodeDaramadId=-3)/*آموزش و پرورش*/
			SELECT DISTINCT * FROM (
			SELECT /* (select fldStrhid from drd.tblCodhayeDaramd where fldid=@CodeMaliyat)*/'' AS hidChilde,
			/*(select tblCodhayeDaramd.fldDaramadCode from drd.tblCodhayeDaramd where fldid=@CodeMaliyat)*/'_' AS DaramdCodeChilde
			,/*(select fldCodeHesab from drd.tblParametrHesabdari where fldShomareHesabCodeDaramadId=(select fldId from drd.tblShomareHesabCodeDaramad as d where d.fldCodeDaramadId=@CodeDaramadId))*/@codeMaliyat AS DaramdCodeChilde1
			,N'آموزش و پرورش' AS DaramadTitleChilde
			,/*(select tblCodhayeDaramd.fldLevel from drd.tblCodhayeDaramd where fldid=@CodeMaliyat)*/cast(0 as smallint) AS lvlChilde,
			'' AS P_hid,''AS P_DaramadCode,'' AS P_DaramadTitle,cast(0 as smallint) AS P_Level
			,sum(e.fldAmuzesh) over (partition by fldtarikh) as Mablagh
			,count(c)over (partition by fldtarikh) as [Count],e.fldtarikh
			,(SELECT  TOP(1)  fldShomareHesab FROM        
			 Com.tblShomareHesabeOmoomi WHERE tblShomareHesabeOmoomi.fldid=ShomareHId /*AND fldOrganId=@OrganId*/) fldShomareHesab
			 , '1'  AS LastNode
			 FROM  @temp as e
			 WHERE ShomareHId=@ShomareHesabId  /*AND C.fldId IN (SELECT id FROM @code)*/)s
			 WHERE     LastNode=1 and Mablagh<>0
			 order by fldtarikh
			 
			else IF(@ShomareHesabId=0 AND /*@CodeMaliyat=*/@CodeDaramadId=-3)/*آموزش و پرورش*/
			SELECT DISTINCT * FROM (
			SELECT  /*(select fldStrhid from drd.tblCodhayeDaramd where fldid=@CodeMaliyat)*/'' AS hidChilde,
			/*(select tblCodhayeDaramd.fldDaramadCode from drd.tblCodhayeDaramd where fldid=@CodeMaliyat)*/'_' AS DaramdCodeChilde
			,/*(select fldCodeHesab from drd.tblParametrHesabdari where fldShomareHesabCodeDaramadId=(select fldId from drd.tblShomareHesabCodeDaramad as d where d.fldCodeDaramadId=@CodeDaramadId))*/'_' AS DaramdCodeChilde1
			,N'آموزش و پرورش' AS DaramadTitleChilde
			,/*(select tblCodhayeDaramd.fldLevel from drd.tblCodhayeDaramd where fldid=@CodeMaliyat) */0AS lvlChilde,
			'' AS P_hid,''AS P_DaramadCode,'' AS P_DaramadTitle,cast(0 as smallint) AS P_Level
			,sum(e.fldAmuzesh) over (partition by fldtarikh) as Mablagh
			,count(c)over (partition by fldtarikh) as [Count],e.fldtarikh
			,(SELECT  TOP(1)  fldShomareHesab FROM        
			Com.tblShomareHesabeOmoomi WHERE tblShomareHesabeOmoomi.fldid=ShomareHId /*AND fldOrganId=@OrganId*/) fldShomareHesab
			 , '1'  AS LastNode
			 FROM  @temp as e
			 /*WHERE ShomareHId=@ShomareHesabId  AND C.fldId IN (SELECT id FROM @code)*/)s
			 WHERE     LastNode=1 and Mablagh<>0
			 order by fldtarikh
			 
			 
			else IF(@ShomareHesabId<>0 AND /*@CodeAvarez=*/@CodeDaramadId=-1)/*عوارض*/
				SELECT DISTINCT * FROM (
				SELECT  /*(select fldStrhid from drd.tblCodhayeDaramd where fldid=@CodeAvarez)*/'' AS hidChilde,
				/*(select tblCodhayeDaramd.fldDaramadCode from drd.tblCodhayeDaramd where fldid=@CodeAvarez)*/'_' AS DaramdCodeChilde
				,/*(select fldCodeHesab from drd.tblParametrHesabdari where fldShomareHesabCodeDaramadId=(select fldId from drd.tblShomareHesabCodeDaramad as d where d.fldCodeDaramadId=@CodeDaramadId))*/@CodeAvarez AS DaramdCodeChilde1
				,N'عوارض' AS DaramadTitleChilde
				,/*(select tblCodhayeDaramd.fldLevel from drd.tblCodhayeDaramd where fldid=@CodeAvarez)*/cast(0 as smallint) AS lvlChilde,
				'' AS P_hid,''AS P_DaramadCode,'' AS P_DaramadTitle,cast(0 as smallint) AS P_Level
				,sum(e.Avarez) over (partition by fldtarikh,e.fldidcodid) as Mablagh
				,count(c)over (partition by fldtarikh,e.fldidcodid) as [Count],e.fldtarikh
				,(SELECT  TOP(1)  fldShomareHesab FROM        
				 Com.tblShomareHesabeOmoomi WHERE tblShomareHesabeOmoomi.fldid=ShomareHId /*AND fldOrganId=@OrganId*/) fldShomareHesab
				 , '1'  AS LastNode
				 FROM  @temp as e
				 WHERE ShomareHId=@ShomareHesabId  /*AND C.fldId IN (SELECT id FROM @code)*/)s
				 WHERE     LastNode=1 and Mablagh<>0
				 order by fldtarikh
			 
			ELSE IF(@ShomareHesabId=0 AND /*@CodeAvarez=*/@CodeDaramadId=-1)/*عوارض*/
			SELECT DISTINCT * FROM (
			SELECT /* (select fldStrhid from drd.tblCodhayeDaramd where fldid=@CodeAvarez)*/'' AS hidChilde,
			/*(select tblCodhayeDaramd.fldDaramadCode from drd.tblCodhayeDaramd where fldid=@CodeAvarez)*/'_' AS DaramdCodeChilde
			,/*(select fldCodeHesab from drd.tblParametrHesabdari where fldShomareHesabCodeDaramadId=(select fldId from drd.tblShomareHesabCodeDaramad as d where d.fldCodeDaramadId=@CodeDaramadId))*/@CodeAvarez AS DaramdCodeChilde1
			,N'عوارض' AS DaramadTitleChilde
			,/*(select tblCodhayeDaramd.fldLevel from drd.tblCodhayeDaramd where fldid=@CodeAvarez)*/cast(0 as smallint) AS lvlChilde,
			'' AS P_hid,''AS P_DaramadCode,'' AS P_DaramadTitle,cast(0 as smallint) AS P_Level
			,sum(e.Avarez) over (partition by fldtarikh,e.fldidcodid) as Mablagh
			,count(c)over (partition by fldtarikh,e.fldidcodid) as [Count],e.fldtarikh
			,(SELECT  TOP(1)  fldShomareHesab FROM        
								  Com.tblShomareHesabeOmoomi WHERE tblShomareHesabeOmoomi.fldid=ShomareHId /*AND fldOrganId=@OrganId*/) fldShomareHesab
			 , '1'  AS LastNode
			 FROM  @temp as e
			/* WHERE ShomareHId=@ShomareHesabId  AND C.fldId IN (SELECT id FROM @code)*/)s
			 WHERE     LastNode=1 and Mablagh<>0
			 order by fldtarikh  
			 
			 ELSE IF(@ShomareHesabId<>0 AND @CodeDaramadId<>0)
			SELECT DISTINCT * FROM (
			SELECT  fldStrhid AS hidChilde,fldDaramadCode AS DaramdCodeChilde,(select fldCodeHesab from drd.tblParametrHesabdari where fldShomareHesabCodeDaramadId=(select fldId from drd.tblShomareHesabCodeDaramad as d where d.fldCodeDaramadId=c.fldId)) AS DaramdCodeChilde1,fldDaramadTitle AS DaramadTitleChilde,fldLevel AS lvlChilde,
			ISNULL((SELECT d.fldStrhid FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_hid,
			ISNULL((SELECT fldDaramadCode FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_DaramadCode,
			ISNULL((SELECT fldDaramadTitle FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_DaramadTitle,
			ISNULL((SELECT fldLevel FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_Level
			--,ISNULL((SELECT SUM(mablaghcodeDaramad) FROM @temp WHERE Daramadcode=C.fldDaramadCode) ,ISNULL((SELECT SUM(mablaghcodeDaramad) FROM @temp AS t WHERE t.hid.ToString() LIKE c.fldStrhid+'%'),0)) AS Mablagh
			,sum(mablaghcodeDaramad) over (partition by fldtarikh,e.fldidcodid) as Mablagh
			,count(c)over (partition by fldtarikh,e.fldidcodid) as [Count],e.fldtarikh
			--,ISNULL((SELECT fldtarikh FROM @temp WHERE Daramadcode=C.fldDaramadCode group by fldtarikh),'') as fldtarikh
			,(SELECT  TOP(1)  fldShomareHesab FROM        
								  Com.tblShomareHesabeOmoomi WHERE tblShomareHesabeOmoomi.fldid=ShomareHId /*AND fldOrganId=@OrganId*/) fldShomareHesab
			 ,/*(SELECT  TOP(1)  fldShomareHesadId FROM  Drd.tblShomareHesabCodeDaramad WHERE fldCodeDaramadId=C.fldId /*AND fldOrganId=@OrganId*/) */ @ShomareHesabId as fldShomareHesabId
			 ,CASE WHEN fldid IN (SELECT  s.fldId FROM     Drd.tblCodhayeDaramd AS s left JOIN
							  Drd.tblCodhayeDaramd AS p ON  s.fldDaramadId = p.fldDaramadId.GetAncestor(1)
							  WHERE p.fldDaramadId IS NULL AND s.fldId=c.fldid) THEN N'1' ELSE '0' END AS LastNode
			 FROM Drd.tblCodhayeDaramd AS C  inner join @temp as e on e.fldidcodid=c.fldid
			 WHERE C.fldLevel<>0  and ShomareHId=@ShomareHesabId  AND C.fldId IN (SELECT id FROM @code))s
			 WHERE     LastNode=1 and Mablagh<>0
			 order by fldtarikh
			 

			 ELSE IF(@ShomareHesabId=0 AND @CodeDaramadId=0)
			 
			 SELECT DISTINCT * from (SELECT fldStrhid AS hidChilde,fldDaramadCode AS DaramdCodeChilde,(select fldCodeHesab from drd.tblParametrHesabdari where fldShomareHesabCodeDaramadId=(select fldId from drd.tblShomareHesabCodeDaramad as d where d.fldCodeDaramadId=c.fldId)) AS DaramdCodeChilde1,fldDaramadTitle AS DaramadTitleChilde,fldLevel AS lvlChilde,
			ISNULL((SELECT d.fldStrhid FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_hid,
			ISNULL((SELECT fldDaramadCode FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_DaramadCode,
			ISNULL((SELECT fldDaramadTitle FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_DaramadTitle,
			ISNULL((SELECT fldLevel FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_Level
			--,ISNULL((SELECT SUM(mablaghcodeDaramad) FROM @temp WHERE Daramadcode=C.fldDaramadCode) ,ISNULL((SELECT SUM(mablaghcodeDaramad) FROM @temp AS t WHERE t.hid.ToString() LIKE c.fldStrhid+'%'),0)) AS Mablagh
			--,ISNULL((SELECT top(1) fldtarikh FROM @temp WHERE Daramadcode=C.fldDaramadCode group by fldtarikh),'') as fldtarikh
			--,ISNULL((SELECT top(1)  count(c) FROM @temp WHERE Daramadcode=C.fldDaramadCode group by fldtarikh,Daramadcode),'') as c
			,sum(mablaghcodeDaramad) over (partition by fldtarikh,e.fldidcodid) as Mablagh
			,count(c)over (partition by fldtarikh,e.fldidcodid) as [Count],e.fldtarikh
			,(SELECT  TOP(1)  fldShomareHesab FROM        
								  Com.tblShomareHesabeOmoomi WHERE tblShomareHesabeOmoomi.fldid=ShomareHId /*AND fldOrganId=@OrganId*/) fldShomareHesab
			 --,(SELECT  TOP(1)  fldShomareHesadId FROM  Drd.tblShomareHesabCodeDaramad WHERE fldCodeDaramadId=C.fldId /*AND fldOrganId=@OrganId*/) 
			,ShomareHId as  fldShomareHesabId
			 ,CASE WHEN fldid IN (SELECT  s.fldId FROM     Drd.tblCodhayeDaramd AS s left JOIN
							  Drd.tblCodhayeDaramd AS p ON  s.fldDaramadId = p.fldDaramadId.GetAncestor(1)
							  WHERE p.fldDaramadId IS NULL AND s.fldId=c.fldid) THEN N'1' ELSE '0' END AS LastNode
			 FROM Drd.tblCodhayeDaramd AS C  inner join @temp as e on e.fldidCodid=c.fldid
			 WHERE C.fldLevel<>0) t
			 where  LastNode=1 and Mablagh<>0 
			 order by fldtarikh
			 
			 ELSE IF(@ShomareHesabId=0 AND @CodeDaramadId<>0)
			select distinct * from(SELECT fldStrhid AS hidChilde,fldDaramadCode AS DaramdCodeChilde,(select fldCodeHesab from drd.tblParametrHesabdari where fldShomareHesabCodeDaramadId=(select fldId from drd.tblShomareHesabCodeDaramad as d where d.fldCodeDaramadId=c.fldId)) AS DaramdCodeChilde1,fldDaramadTitle AS DaramadTitleChilde,fldLevel AS lvlChilde,
			ISNULL((SELECT d.fldStrhid FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_hid,
			ISNULL((SELECT fldDaramadCode FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_DaramadCode,
			ISNULL((SELECT fldDaramadTitle FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_DaramadTitle,
			ISNULL((SELECT fldLevel FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_Level
			--,ISNULL((SELECT SUM(mablaghcodeDaramad)over (partition by fldtarikh) FROM @temp WHERE Daramadcode=C.fldDaramadCode) ,ISNULL((SELECT SUM(mablaghcodeDaramad) FROM @temp AS t WHERE t.hid.ToString() LIKE c.fldStrhid+'%'),0)) AS Mablagh
			,sum(mablaghcodeDaramad) over (partition by fldtarikh,e.fldidcodid) as Mablagh
			,count(c)over (partition by fldtarikh,e.fldidcodid) as [Count],e.fldtarikh
			,(SELECT  TOP(1)  fldShomareHesab FROM        
								  Com.tblShomareHesabeOmoomi WHERE tblShomareHesabeOmoomi.fldid=ShomareHId /*AND fldOrganId=@OrganId*/) fldShomareHesab
			 --,(SELECT  TOP(1)  fldShomareHesadId FROM  Drd.tblShomareHesabCodeDaramad WHERE fldCodeDaramadId=C.fldId /*AND fldOrganId=@OrganId*/)
			  ,ShomareHId as fldShomareHesabId
			  ,CASE WHEN fldid IN (SELECT  s.fldId FROM     Drd.tblCodhayeDaramd AS s left JOIN
							  Drd.tblCodhayeDaramd AS p ON  s.fldDaramadId = p.fldDaramadId.GetAncestor(1)
							  WHERE p.fldDaramadId IS NULL AND s.fldId=c.fldid) THEN N'1' ELSE '0' END AS LastNode
			 FROM Drd.tblCodhayeDaramd AS C inner join @temp as e on e.fldidCodid=c.fldId
			 WHERE C.fldLevel<>0   AND C.fldId IN (SELECT id FROM @code))t
			 where    LastNode=1 and Mablagh<>0
			  order by fldtarikh

			else IF(@ShomareHesabId<>0 AND @CodeDaramadId=0)
			SELECT DISTINCT * from(SELECT fldStrhid AS hidChilde,fldDaramadCode AS DaramdCodeChilde,(select fldCodeHesab from drd.tblParametrHesabdari where fldShomareHesabCodeDaramadId=(select fldId from drd.tblShomareHesabCodeDaramad as d where d.fldCodeDaramadId=c.fldId)) AS DaramdCodeChilde1,fldDaramadTitle AS DaramadTitleChilde,fldLevel AS lvlChilde,
			ISNULL((SELECT d.fldStrhid FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_hid,
			ISNULL((SELECT fldDaramadCode FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_DaramadCode,
			ISNULL((SELECT fldDaramadTitle FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_DaramadTitle,
			ISNULL((SELECT fldLevel FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_Level
			--,ISNULL((SELECT SUM(mablaghcodeDaramad) FROM @temp WHERE Daramadcode=C.fldDaramadCode) ,ISNULL((SELECT SUM(mablaghcodeDaramad) FROM @temp AS t WHERE t.hid.ToString() LIKE c.fldStrhid+'%'),0)) AS Mablagh
			--,ISNULL((SELECT fldtarikh FROM @temp WHERE Daramadcode=C.fldDaramadCode group by fldtarikh),'') as fldtarikh
			,sum(mablaghcodeDaramad) over (partition by fldtarikh,e.fldidcodid) as Mablagh
			,count(c)over (partition by fldtarikh,e.fldidcodid) as [Count],e.fldtarikh
			,(SELECT  TOP(1)  fldShomareHesab FROM        
								  Com.tblShomareHesabeOmoomi WHERE tblShomareHesabeOmoomi.fldid=ShomareHId /*AND fldOrganId=@OrganId*/) fldShomareHesab
			 --,(SELECT  TOP(1)  fldShomareHesadId FROM  Drd.tblShomareHesabCodeDaramad WHERE fldCodeDaramadId=C.fldId /*AND fldOrganId=@OrganId*/) 
			 ,ShomareHId as fldShomareHesabId
			  ,CASE WHEN fldid IN (SELECT  s.fldId FROM     Drd.tblCodhayeDaramd AS s left JOIN
							  Drd.tblCodhayeDaramd AS p ON  s.fldDaramadId = p.fldDaramadId.GetAncestor(1)
							  WHERE p.fldDaramadId IS NULL AND s.fldId=c.fldid) THEN N'1' ELSE '0' END AS LastNode
			 FROM Drd.tblCodhayeDaramd AS C  inner join @temp as e on e.fldidcodid=c.fldid
			 WHERE C.fldLevel<>0  and ShomareHId LIKE @ShomareHesabId)t
			  WHERE   LastNode=1 and Mablagh<>0
			   order by fldtarikh
			END
	ELSE
	BEGIN
			if(@DateType=1)/*براساس تاریخ پرداخت*/
			begin
				INSERT INTO @temp
				--( Daramadcode ,sharhecode , shomareHesab , mablaghcodeDaramad,fldtype,hid ,fldtarikh )

				SELECT     tblCodhayeDaramd_1.fldid,   tblCodhayeDaramd_1.fldDaramadCode, Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad, Com.tblShomareHesabeOmoomi.fldShomareHesab, 
									   ISNULL(cast((Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifAsliValue * Drd.tblCodhayeDaramadiElamAvarez.fldTedad + Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifAvarezValue + Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifMaliyatValue+Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifAmuzeshParvareshValue)as bigint),
										  cast((Drd.tblCodhayeDaramadiElamAvarez.fldAsliValue * Drd.tblCodhayeDaramadiElamAvarez.fldTedad + Drd.tblCodhayeDaramadiElamAvarez.fldAvarezValue + Drd.tblCodhayeDaramadiElamAvarez.fldMaliyatValue+Drd.tblCodhayeDaramadiElamAvarez.fldAmuzeshParvareshValue)as bigint))
					AS fldmablaghCodeDaramad, '0' AS Expr1, tblCodhayeDaramd_1.fldDaramadId,tblPardakhtFish.fldTarikh,tblPardakhtFish.fldId,Drd.tblSodoorFish.fldShomareHesabId
					,isnull(fldTakhfifMaliyatValue,fldMaliyatValue)fldMaliyatValue,isnull(fldTakhfifAvarezValue,fldAvarezValue)fldAvarezValue,isnull(fldTakhfifAmuzeshParvareshValue,fldAmuzeshParvareshValue)fldAmuzeshParvareshValue
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
				SELECT codid, fldDaramadCode,fldSharheCodeDaramad,fldShomareHesab, cast(cast(fldMablaghNaghdi as decimal(50))*cast(fldmablaghCodeDaramad as decimal(50))/cast(fldmablaghKoli as decimal(50))as bigint),'1'
				,fldDaramadId,fldTarikh,fldId,fldShomareHesabId	,fldMaliyatValue,fldAvarezValue,  cast(cast(fldMablaghNaghdi as decimal(50))*cast(fldAmuzeshParvareshValue as decimal(50))/cast(fldmablaghKoli as decimal(50))as bigint) fldAmuzeshParvareshValue
				 FROM 
				(SELECT   DISTINCT    Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId,tblCodhayeDaramd_1.fldid codid, tblCodhayeDaramd_1.fldDaramadCode, 
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
										
										 
										 GROUP BY tblCodhayeDaramd_1.fldid,tblRequestTaghsit_Takhfif.fldElamAvarezId,tblCodhayeDaramd_1.fldDaramadCode, 
										 Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad,fldMablagh,fldReplyTaghsitId, tblCodhayeDaramadiElamAvarez.fldElamAvarezId
										 ,tblNaghdi_Talab.fldShomareHesabId,fldShomareHesab,fldDaramadId,tblPardakhtFish.fldTarikh,tblPardakhtFish.fldId,Drd.tblNaghdi_Talab.fldShomareHesabId
										,fldMaliyatValue,fldAvarezValue,fldTakhfifMaliyatValue,fldTakhfifAvarezValue,tblNaghdi_Talab.fldFishId,fldTakhfifAmuzeshParvareshValue,fldAmuzeshParvareshValue
										 )t

							end
			if(@DateType=0)/*براساس تاریخ واریز*/
			begin
				INSERT INTO @temp
				--( Daramadcode ,sharhecode , shomareHesab , mablaghcodeDaramad,fldtype,hid ,fldtarikh )

				SELECT         tblCodhayeDaramd_1.fldid,       tblCodhayeDaramd_1.fldDaramadCode, Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad, Com.tblShomareHesabeOmoomi.fldShomareHesab, 
									   ISNULL(cast((Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifAsliValue * Drd.tblCodhayeDaramadiElamAvarez.fldTedad + Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifAvarezValue + Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifMaliyatValue+fldTakhfifAmuzeshParvareshValue)as bigint),
										  cast((Drd.tblCodhayeDaramadiElamAvarez.fldAsliValue * Drd.tblCodhayeDaramadiElamAvarez.fldTedad + Drd.tblCodhayeDaramadiElamAvarez.fldAvarezValue + Drd.tblCodhayeDaramadiElamAvarez.fldMaliyatValue+fldAmuzeshParvareshValue)as bigint))
					AS fldmablaghCodeDaramad, '0' AS Expr1, tblCodhayeDaramd_1.fldDaramadId,tblPardakhtFish.fldTarikhVariz fldTarikh,tblPardakhtFish.fldId,Drd.tblSodoorFish.fldShomareHesabId
					,isnull(fldTakhfifMaliyatValue,fldMaliyatValue)fldMaliyatValue,isnull(fldTakhfifAvarezValue,fldAvarezValue)fldAvarezValue,isnull(fldTakhfifAmuzeshParvareshValue,fldAmuzeshParvareshValue)fldAmuzeshParvareshValue
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
				SELECT codid, fldDaramadCode,fldSharheCodeDaramad,fldShomareHesab, cast(cast(fldMablaghNaghdi as decimal(50))*cast(fldmablaghCodeDaramad as decimal(50))/cast(fldmablaghKoli as decimal(50))as bigint),'1'
				,fldDaramadId,fldTarikhVariz ,fldId,fldShomareHesabId	,fldMaliyatValue,fldAvarezValue, cast(cast(fldMablaghNaghdi as decimal(50))*cast(fldAmuzeshParvareshValue as decimal(50))/cast(fldmablaghKoli as decimal(50))as bigint) fldAmuzeshParvareshValue
				 FROM 
				(SELECT   DISTINCT    Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId,tblCodhayeDaramd_1.fldid codid, tblCodhayeDaramd_1.fldDaramadCode, 
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
										
										 
										 GROUP BY tblCodhayeDaramd_1.fldid,tblRequestTaghsit_Takhfif.fldElamAvarezId,tblCodhayeDaramd_1.fldDaramadCode, 
										 Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad,fldMablagh,fldReplyTaghsitId, tblCodhayeDaramadiElamAvarez.fldElamAvarezId
										 ,tblNaghdi_Talab.fldShomareHesabId,fldShomareHesab,fldDaramadId,tblPardakhtFish.fldTarikhVariz ,tblPardakhtFish.fldId,Drd.tblNaghdi_Talab.fldShomareHesabId
										,fldMaliyatValue,fldAvarezValue,fldTakhfifMaliyatValue,fldTakhfifAvarezValue,fldTakhfifAmuzeshParvareshValue,fldAmuzeshParvareshValue,tblNaghdi_Talab.fldFishId
										 )t

							end
					------------------------------------------------------- وصول شده

				INSERT INTO @temp
				 
				SELECT codid, fldDaramadCode,fldSharheCodeDaramad,fldShomareHesab,cast((cast(cast(fldMablagh as numeric)/cast(fldmablaghKoli as  numeric)as  numeric(38,20))*fldmablaghCodeDaramad)  as bigint),'2',fldDaramadId,fldDateStatus,
				fldid,fldShomareHesabIdOrgan,	fldMaliyatValue,fldAvarezValue, cast((cast(cast(fldMablagh as numeric)/cast(fldmablaghKoli as  numeric)as  numeric(38,20))*fldAmuzeshParvareshValue)  as bigint) fldAmuzeshParvareshValue
				 FROM 
				(SELECT   DISTINCT    Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId,tblCodhayeDaramd_1.fldid codid, tblCodhayeDaramd_1.fldDaramadCode, 
										 Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad
										-- ,SUM(fldMablagh) OVER (PARTITION BY fldReplyTaghsitId,tblNaghdi_Talab.fldShomareHesabId) AS fldMablaghNaghdi
										,Drd.fn_SumMablaghNaghdi('Check',tblcheck.fldId,tblCheck.fldShomareHesabIdOrgan,@azTarikh ,@Tatarikh) AS fldMablagh
										,fldShomareHesab ,fldReplyTaghsitId
					,ISNULL(SUM(fldTakhfifAsliValue*fldTedad+fldTakhfifAvarezValue+fldTakhfifMaliyatValue+fldTakhfifAmuzeshParvareshValue),SUM(fldAsliValue*fldTedad+fldAvarezValue+fldMaliyatValue+fldAmuzeshParvareshValue)) AS fldmablaghCodeDaramad
					,(SELECT TOP(1) ISNULL(SUM(fldTakhfifAsliValue*fldTedad+fldTakhfifAvarezValue+fldTakhfifMaliyatValue+fldTakhfifAmuzeshParvareshValue) OVER (PARTITION BY tblCodhayeDaramadiElamAvarez.fldElamAvarezId),SUM(fldAsliValue*fldTedad+fldAvarezValue+fldMaliyatValue+fldAmuzeshParvareshValue) OVER (PARTITION BY tblCodhayeDaramadiElamAvarez.fldElamAvarezId)) FROM Drd.tblCodhayeDaramadiElamAvarez AS a WHERE a.fldElamAvarezId =Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId) AS fldmablaghKoli
				,tblCodhayeDaramd_1.fldDaramadId,fldDateStatus,tblcheck.fldid,tblCheck.fldShomareHesabIdOrgan
				,isnull(fldTakhfifMaliyatValue,fldMaliyatValue)fldMaliyatValue,isnull(fldTakhfifAvarezValue,fldAvarezValue)fldAvarezValue,isnull(fldTakhfifAmuzeshParvareshValue,fldAmuzeshParvareshValue)fldAmuzeshParvareshValue
					
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
										 GROUP BY tblCodhayeDaramd_1.fldid,tblRequestTaghsit_Takhfif.fldElamAvarezId,tblCodhayeDaramd_1.fldDaramadCode, 
										 Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad,fldMablaghSanad,fldReplyTaghsitId, tblCodhayeDaramadiElamAvarez.fldElamAvarezId
										 ,tblCheck.fldShomareHesabIdOrgan,fldShomareHesab,fldDaramadId,fldDateStatus,tblcheck.fldid,tblCheck.fldShomareHesabIdOrgan
										 	,fldMaliyatValue,fldAvarezValue,fldTakhfifMaliyatValue,fldTakhfifAvarezValue,fldAmuzeshParvareshValue,fldTakhfifAmuzeshParvareshValue
										 )t


				INSERT INTO @temp
			
				 SELECT codid, fldDaramadCode,fldSharheCodeDaramad,fldShomareHesab,cast((cast(cast(fldMablagh as numeric)/cast(fldmablaghKoli as  numeric)as  numeric(38,20))*fldmablaghCodeDaramad)  as bigint)
				 ,'3',fldDaramadId,fldDateStatus,fldid ,fldShomareHesadId
			,fldMaliyatValue,fldAvarezValue, cast((cast(cast(fldMablagh as numeric)/cast(fldmablaghKoli as  numeric)as  numeric(38,20))*fldAmuzeshParvareshValue)  as bigint) fldAmuzeshParvareshValue
			FROM 
				(SELECT   DISTINCT    Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId,tblCodhayeDaramd_1.fldid codid, tblCodhayeDaramd_1.fldDaramadCode, 
										 Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad
										-- ,SUM(fldMablagh) OVER (PARTITION BY fldReplyTaghsitId,tblNaghdi_Talab.fldShomareHesabId) AS fldMablaghNaghdi
										,Drd.fn_SumMablaghNaghdi('Safte',fldReplyTaghsitId,tblShomareHesabCodeDaramad.fldShomareHesadId,@AzTarikh , @Tatarikh) AS fldMablagh
										,fldShomareHesab ,fldReplyTaghsitId
					,ISNULL(SUM(fldTakhfifAsliValue*fldTedad+fldTakhfifAvarezValue+fldTakhfifMaliyatValue+fldTakhfifAmuzeshParvareshValue),SUM(fldAsliValue*fldTedad+fldAvarezValue+fldMaliyatValue+fldAmuzeshParvareshValue)) AS fldmablaghCodeDaramad
					,(SELECT TOP(1) ISNULL(SUM(fldTakhfifAsliValue*fldTedad+fldTakhfifAvarezValue+fldTakhfifMaliyatValue+fldTakhfifAmuzeshParvareshValue) OVER (PARTITION BY tblCodhayeDaramadiElamAvarez.fldElamAvarezId),
					SUM(fldAsliValue*fldTedad+fldAvarezValue+fldMaliyatValue+fldAmuzeshParvareshValue) OVER (PARTITION BY tblCodhayeDaramadiElamAvarez.fldElamAvarezId)) FROM Drd.tblCodhayeDaramadiElamAvarez AS a WHERE a.fldElamAvarezId =Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId) AS fldmablaghKoli
				,tblCodhayeDaramd_1.fldDaramadId,fldDateStatus,tblSafte.fldid,tblShomareHesabCodeDaramad.fldShomareHesadId
				,isnull(fldTakhfifMaliyatValue,fldMaliyatValue) AS fldMaliyatValue,isnull(fldTakhfifAvarezValue,fldAvarezValue) AS fldAvarezValue,isnull(fldTakhfifAmuzeshParvareshValue,fldAmuzeshParvareshValue) AS fldAmuzeshParvareshValue
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
										 GROUP BY tblCodhayeDaramd_1.fldid,tblRequestTaghsit_Takhfif.fldElamAvarezId,tblCodhayeDaramd_1.fldDaramadCode, 
										 Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad,fldMablaghSanad,fldReplyTaghsitId, tblCodhayeDaramadiElamAvarez.fldElamAvarezId
										 ,tblShomareHesabCodeDaramad.fldShomareHesadId,fldShomareHesab,fldDaramadId,fldDateStatus,tblSafte.fldid,tblShomareHesabCodeDaramad.fldShomareHesadId
										 	,fldMaliyatValue,fldAvarezValue,fldTakhfifMaliyatValue,fldTakhfifAvarezValue,fldTakhfifAmuzeshParvareshValue,fldAmuzeshParvareshValue
										 )t

				INSERT INTO @temp
				SELECT codid, fldDaramadCode,fldSharheCodeDaramad,fldShomareHesab,cast((cast(cast(fldMablagh as numeric)/cast(fldmablaghKoli as  numeric)as  numeric(38,20))*fldmablaghCodeDaramad)  as bigint),'4',fldDaramadId,fldDateStatus,fldid 
				,fldShomareHesadId 	,fldMaliyatValue,fldAvarezValue, cast((cast(cast(fldMablagh as numeric)/cast(fldmablaghKoli as  numeric)as  numeric(38,20))*fldAmuzeshParvareshValue)  as bigint) fldAmuzeshParvareshValue
				FROM 
				(SELECT   DISTINCT    Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId,tblCodhayeDaramd_1.fldid codid, tblCodhayeDaramd_1.fldDaramadCode, 
										 Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad
										-- ,SUM(fldMablagh) OVER (PARTITION BY fldReplyTaghsitId,tblNaghdi_Talab.fldShomareHesabId) AS fldMablaghNaghdi
										,Drd.fn_SumMablaghNaghdi('Barat',fldReplyTaghsitId,tblShomareHesabCodeDaramad.fldShomareHesadId,@AzTarikh,@TaTarikh) AS fldMablagh
										,fldShomareHesab ,fldReplyTaghsitId
					,ISNULL(SUM(fldTakhfifAsliValue*fldTedad+fldTakhfifAvarezValue+fldTakhfifMaliyatValue+fldTakhfifAmuzeshParvareshValue),SUM(fldAsliValue*fldTedad+fldAvarezValue+fldMaliyatValue+fldAmuzeshParvareshValue)) AS fldmablaghCodeDaramad
					,(SELECT TOP(1) ISNULL(SUM(fldTakhfifAsliValue*fldTedad+fldTakhfifAvarezValue+fldTakhfifMaliyatValue+fldTakhfifAmuzeshParvareshValue) OVER (PARTITION BY tblCodhayeDaramadiElamAvarez.fldElamAvarezId),SUM(fldAsliValue*fldTedad+fldAvarezValue+fldMaliyatValue+fldAmuzeshParvareshValue) OVER (PARTITION BY tblCodhayeDaramadiElamAvarez.fldElamAvarezId)) FROM Drd.tblCodhayeDaramadiElamAvarez AS a WHERE a.fldElamAvarezId =Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId) AS fldmablaghKoli
				,tblCodhayeDaramd_1.fldDaramadId,fldDateStatus,tblbarat.fldid,tblShomareHesabCodeDaramad.fldShomareHesadId
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
										AND tblBarat.fldStatus=2 
										AND (Drd.tblBarat.fldDateStatus ) BETWEEN @AzTarikh AND @TaTarikh
										--AND CAST(Drd.tblBarat.fldDate AS  DATE) BETWEEN @StartDate AND @EndDate
										 GROUP BY  tblCodhayeDaramd_1.fldid ,tblRequestTaghsit_Takhfif.fldElamAvarezId,tblCodhayeDaramd_1.fldDaramadCode, 
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
				
				
				
				IF(@ShomareHesabId<>0 AND /*@CodeMaliyat=*/@CodeDaramadId=-2)/*مالیات*/
				SELECT DISTINCT * FROM (
				SELECT  /*(select fldStrhid from drd.tblCodhayeDaramd where fldid=@CodeMaliyat)**/'' AS hidChilde
				,/*(select tblCodhayeDaramd.fldDaramadCode from drd.tblCodhayeDaramd where fldid=@CodeMaliyat)*/'_' AS DaramdCodeChilde
				,/*(select fldCodeHesab from drd.tblParametrHesabdari where fldShomareHesabCodeDaramadId=(select fldId from drd.tblShomareHesabCodeDaramad as d where d.fldCodeDaramadId=@CodeDaramadId))*/@CodeMaliyat AS DaramdCodeChilde1
				,N'مالیات' AS DaramadTitleChilde
				,(select tblCodhayeDaramd.fldLevel from drd.tblCodhayeDaramd where fldid=@CodeMaliyat) AS lvlChilde,
				'' AS P_hid,''AS P_DaramadCode,'' AS P_DaramadTitle,cast(0 as smallint) AS P_Level
				,sum(e.Maliyat) over (partition by fldtarikh,e.fldidcodid) as Mablagh
				,count(c)over (partition by fldtarikh,e.fldidcodid) as [Count],e.fldtarikh
				,(SELECT  TOP(1)  fldShomareHesab FROM        
				 Com.tblShomareHesabeOmoomi WHERE tblShomareHesabeOmoomi.fldid=ShomareHId /*AND fldOrganId=@OrganId*/) fldShomareHesab
				 , '1'  AS LastNode
				 FROM  @temp as e
				 WHERE ShomareHId=@ShomareHesabId  /*AND C.fldId IN (SELECT id FROM @code)*/)s
				 WHERE     LastNode=1 and Mablagh<>0
				 order by fldtarikh

				 IF(@ShomareHesabId<>0 AND /*@CodeMaliyat=*/@CodeDaramadId=-3)/*N'آموزش و پرورش' */
				SELECT DISTINCT * FROM (
				SELECT  /*(select fldStrhid from drd.tblCodhayeDaramd where fldid=@CodeMaliyat)**/'' AS hidChilde
				,/*(select tblCodhayeDaramd.fldDaramadCode from drd.tblCodhayeDaramd where fldid=@CodeMaliyat)*/'_' AS DaramdCodeChilde
				,/*(select fldCodeHesab from drd.tblParametrHesabdari where fldShomareHesabCodeDaramadId=(select fldId from drd.tblShomareHesabCodeDaramad as d where d.fldCodeDaramadId=@CodeDaramadId))*/'' AS DaramdCodeChilde1
				,N'آموزش و پرورش' AS DaramadTitleChilde
				,/*(select tblCodhayeDaramd.fldLevel from drd.tblCodhayeDaramd where fldid=@CodeMaliyat)*/0 AS lvlChilde,
				'' AS P_hid,''AS P_DaramadCode,'' AS P_DaramadTitle,cast(0 as smallint) AS P_Level
				,sum(e.fldAmuzesh) over (partition by fldtarikh) as Mablagh
				,count(c)over (partition by fldtarikh) as [Count],e.fldtarikh
				,(SELECT  TOP(1)  fldShomareHesab FROM        
				 Com.tblShomareHesabeOmoomi WHERE tblShomareHesabeOmoomi.fldid=ShomareHId /*AND fldOrganId=@OrganId*/) fldShomareHesab
				 , '1'  AS LastNode
				 FROM  @temp as e
				 WHERE ShomareHId=@ShomareHesabId  /*AND C.fldId IN (SELECT id FROM @code)*/)s
				 WHERE     LastNode=1 and Mablagh<>0
				 order by fldtarikh
				 
				 
				else IF(@ShomareHesabId=0 AND /*@CodeMaliyat=*/@CodeDaramadId=-2)/*مالیات*/
				SELECT DISTINCT * FROM (
				SELECT  /*(select fldStrhid from drd.tblCodhayeDaramd where fldid=@CodeMaliyat)*/'' AS hidChilde
				,/*(select tblCodhayeDaramd.fldDaramadCode from drd.tblCodhayeDaramd where fldid=@CodeMaliyat)*/'_' AS DaramdCodeChilde
				,/*(select fldCodeHesab from drd.tblParametrHesabdari where fldShomareHesabCodeDaramadId=(select fldId from drd.tblShomareHesabCodeDaramad as d where d.fldCodeDaramadId=@CodeDaramadId))*/@codemaliyat AS DaramdCodeChilde1
				,N'مالیات' AS DaramadTitleChilde
				,(select tblCodhayeDaramd.fldLevel from drd.tblCodhayeDaramd where fldid=@CodeMaliyat) AS lvlChilde,
				'' AS P_hid,''AS P_DaramadCode,'' AS P_DaramadTitle,cast(0 as smallint) AS P_Level
				,sum(e.Maliyat) over (partition by fldtarikh,e.fldidcodid) as Mablagh
				,count(c)over (partition by fldtarikh,e.fldidcodid) as [Count],e.fldtarikh
				,(SELECT  TOP(1)  fldShomareHesab FROM        
				Com.tblShomareHesabeOmoomi WHERE tblShomareHesabeOmoomi.fldid=ShomareHId /*AND fldOrganId=@OrganId*/) fldShomareHesab
				 , '1'  AS LastNode
				 FROM  @temp as e
				 /*WHERE ShomareHId=@ShomareHesabId  AND C.fldId IN (SELECT id FROM @code)*/)s
				 WHERE     LastNode=1 and Mablagh<>0
				 order by fldtarikh
				 
				 else IF(@ShomareHesabId=0 AND /*@CodeMaliyat=*/@CodeDaramadId=-3)/*آموزش و پرورش*/
				SELECT DISTINCT * FROM (
				SELECT  /*(select fldStrhid from drd.tblCodhayeDaramd where fldid=@CodeMaliyat)*/'' AS hidChilde
				,/*(select tblCodhayeDaramd.fldDaramadCode from drd.tblCodhayeDaramd where fldid=@CodeMaliyat)*/'_' AS DaramdCodeChilde
				,/*(select fldCodeHesab from drd.tblParametrHesabdari where fldShomareHesabCodeDaramadId=(select fldId from drd.tblShomareHesabCodeDaramad as d where d.fldCodeDaramadId=@CodeDaramadId))*/'' AS DaramdCodeChilde1
				,N'آموزش و پرورش' AS DaramadTitleChilde
				,/*(select tblCodhayeDaramd.fldLevel from drd.tblCodhayeDaramd where fldid=@CodeMaliyat)*/0 AS lvlChilde,
				'' AS P_hid,''AS P_DaramadCode,'' AS P_DaramadTitle,cast(0 as smallint) AS P_Level
				,sum(e.fldAmuzesh) over (partition by fldtarikh) as Mablagh
				,count(c)over (partition by fldtarikh) as [Count],e.fldtarikh
				,(SELECT  TOP(1)  fldShomareHesab FROM        
				Com.tblShomareHesabeOmoomi WHERE tblShomareHesabeOmoomi.fldid=ShomareHId /*AND fldOrganId=@OrganId*/) fldShomareHesab
				 , '1'  AS LastNode
				 FROM  @temp as e
				 /*WHERE ShomareHId=@ShomareHesabId  AND C.fldId IN (SELECT id FROM @code)*/)s
				 WHERE     LastNode=1 and Mablagh<>0
				 order by fldtarikh

				else IF(@ShomareHesabId<>0 AND /*@CodeAvarez=*/@CodeDaramadId=-1)/*عوارض*/
					SELECT DISTINCT * FROM (
					SELECT  /*(select fldStrhid from drd.tblCodhayeDaramd where fldid=@CodeAvarez)*/'' AS hidChilde,
					/*(select tblCodhayeDaramd.fldDaramadCode from drd.tblCodhayeDaramd where fldid=@CodeAvarez)*/'_' AS DaramdCodeChilde
					,/*(select fldCodeHesab from drd.tblParametrHesabdari where fldShomareHesabCodeDaramadId=(select fldId from drd.tblShomareHesabCodeDaramad as d where d.fldCodeDaramadId=@CodeDaramadId))*/@CodeAvarez AS DaramdCodeChilde1
					,N'عوارض' AS DaramadTitleChilde
					,(select tblCodhayeDaramd.fldLevel from drd.tblCodhayeDaramd where fldid=@CodeAvarez) AS lvlChilde,
					'' AS P_hid,''AS P_DaramadCode,'' AS P_DaramadTitle,cast(0 as smallint) AS P_Level
					,sum(e.Avarez) over (partition by fldtarikh,e.fldidcodid) as Mablagh
					,count(c)over (partition by fldtarikh,e.fldidcodid) as [Count],e.fldtarikh
					,(SELECT  TOP(1)  fldShomareHesab FROM        
					 Com.tblShomareHesabeOmoomi WHERE tblShomareHesabeOmoomi.fldid=ShomareHId /*AND fldOrganId=@OrganId*/) fldShomareHesab
					 , '1'  AS LastNode
					 FROM  @temp as e
					 WHERE ShomareHId=@ShomareHesabId  /*AND C.fldId IN (SELECT id FROM @code)*/)s
					 WHERE     LastNode=1 and Mablagh<>0
					 order by fldtarikh
				 
				ELSE IF(@ShomareHesabId=0 AND /*@CodeAvarez=*/@CodeDaramadId=-1)/*عوارض*/
				SELECT DISTINCT * FROM (
				SELECT  /*(select fldStrhid from drd.tblCodhayeDaramd where fldid=@CodeAvarez)*/'' AS hidChilde,
				/*(select tblCodhayeDaramd.fldDaramadCode from drd.tblCodhayeDaramd where fldid=@CodeAvarez)*/'_' AS DaramdCodeChilde
				,/*(select fldCodeHesab from drd.tblParametrHesabdari where fldShomareHesabCodeDaramadId=(select fldId from drd.tblShomareHesabCodeDaramad as d where d.fldCodeDaramadId=@CodeDaramadId))*/@CodeAvarez AS DaramdCodeChilde1
				,N'عوارض' AS DaramadTitleChilde
				,/*(select tblCodhayeDaramd.fldLevel from drd.tblCodhayeDaramd where fldid=@CodeAvarez)*/cast(0 as smallint) AS lvlChilde,
				'' AS P_hid,''AS P_DaramadCode,'' AS P_DaramadTitle,cast(0 as smallint) AS P_Level
				,sum(e.Avarez) over (partition by fldtarikh,e.fldidcodid) as Mablagh
				,count(c)over (partition by fldtarikh,e.fldidcodid) as [Count],e.fldtarikh
				,(SELECT  TOP(1)  fldShomareHesab FROM        
									  Com.tblShomareHesabeOmoomi WHERE tblShomareHesabeOmoomi.fldid=ShomareHId /*AND fldOrganId=@OrganId*/) fldShomareHesab
				 , '1'  AS LastNode
				 FROM  @temp as e
				/* WHERE ShomareHId=@ShomareHesabId  AND C.fldId IN (SELECT id FROM @code)*/)s
				 WHERE     LastNode=1 and Mablagh<>0
				 order by fldtarikh  
				 
				ELSE IF(@ShomareHesabId<>0 AND @CodeDaramadId<>0)
				SELECT DISTINCT * FROM (
				SELECT  fldStrhid AS hidChilde,fldDaramadCode AS DaramdCodeChilde,(select fldCodeHesab from drd.tblParametrHesabdari where fldShomareHesabCodeDaramadId=(select fldId from drd.tblShomareHesabCodeDaramad as d where d.fldCodeDaramadId=c.fldId)) AS DaramdCodeChilde1,fldDaramadTitle AS DaramadTitleChilde,fldLevel AS lvlChilde,
				ISNULL((SELECT d.fldStrhid FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_hid,
				ISNULL((SELECT fldDaramadCode FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_DaramadCode,
				ISNULL((SELECT fldDaramadTitle FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_DaramadTitle,
				ISNULL((SELECT fldLevel FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_Level
				--,ISNULL((SELECT SUM(mablaghcodeDaramad) FROM @temp WHERE Daramadcode=C.fldDaramadCode) ,ISNULL((SELECT SUM(mablaghcodeDaramad) FROM @temp AS t WHERE t.hid.ToString() LIKE c.fldStrhid+'%'),0)) AS Mablagh
				,sum(mablaghcodeDaramad) over (partition by fldtarikh,e.fldidcodid) as Mablagh
				,count(c)over (partition by fldtarikh,e.fldidcodid) as [Count],e.fldtarikh
				--,ISNULL((SELECT fldtarikh FROM @temp WHERE Daramadcode=C.fldDaramadCode group by fldtarikh),'') as fldtarikh
				,(SELECT  TOP(1)  fldShomareHesab FROM   
									  Com.tblShomareHesabeOmoomi  WHERE tblShomareHesabeOmoomi.fldid=e.ShomareHId /*AND fldOrganId=@OrganId*/) fldShomareHesab
				 --,(SELECT  TOP(1)  fldShomareHesadId FROM  Drd.tblShomareHesabCodeDaramad WHERE fldCodeDaramadId=C.fldId /*AND fldOrganId=@OrganId*/)
				 ,@ShomareHesabId as  fldShomareHesabId
				 ,CASE WHEN fldid IN (SELECT  s.fldId FROM     Drd.tblCodhayeDaramd AS s left JOIN
								  Drd.tblCodhayeDaramd AS p ON  s.fldDaramadId = p.fldDaramadId.GetAncestor(1)
								  WHERE p.fldDaramadId IS NULL AND s.fldId=c.fldid) THEN N'1' ELSE '0' END AS LastNode
				 FROM Drd.tblCodhayeDaramd AS C  inner join @temp as e on e.fldidcodid=c.fldid
				 WHERE C.fldLevel<>0 and ShomareHId=@ShomareHesabId  AND C.fldId IN (SELECT id FROM @code))s
				 WHERE     LastNode=1 and Mablagh<>0
				 order by fldtarikh
				 

				 ELSE IF(@ShomareHesabId=0 AND @CodeDaramadId=0)
				 
				 SELECT DISTINCT * from (SELECT fldStrhid AS hidChilde,fldDaramadCode AS DaramdCodeChilde,(select fldCodeHesab from drd.tblParametrHesabdari where fldShomareHesabCodeDaramadId=(select fldId from drd.tblShomareHesabCodeDaramad as d where d.fldCodeDaramadId=c.fldId)) AS DaramdCodeChilde1,fldDaramadTitle AS DaramadTitleChilde,fldLevel AS lvlChilde,
				ISNULL((SELECT d.fldStrhid FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_hid,
				ISNULL((SELECT fldDaramadCode FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_DaramadCode,
				ISNULL((SELECT fldDaramadTitle FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_DaramadTitle,
				ISNULL((SELECT fldLevel FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_Level
				--,ISNULL((SELECT SUM(mablaghcodeDaramad) FROM @temp WHERE Daramadcode=C.fldDaramadCode) ,ISNULL((SELECT SUM(mablaghcodeDaramad) FROM @temp AS t WHERE t.hid.ToString() LIKE c.fldStrhid+'%'),0)) AS Mablagh
				--,ISNULL((SELECT top(1) fldtarikh FROM @temp WHERE Daramadcode=C.fldDaramadCode group by fldtarikh),'') as fldtarikh
				--,ISNULL((SELECT top(1)  count(c) FROM @temp WHERE Daramadcode=C.fldDaramadCode group by fldtarikh,Daramadcode),'') as c
				,sum(mablaghcodeDaramad) over (partition by fldtarikh,e.fldidcodid) as Mablagh
				,count(c)over (partition by fldtarikh,e.fldidcodid) as [Count],e.fldtarikh
				,(SELECT  TOP(1)  fldShomareHesab FROM   
									  Com.tblShomareHesabeOmoomi  WHERE tblShomareHesabeOmoomi.fldid=e.ShomareHId /*AND fldOrganId=@OrganId*/) fldShomareHesab
				 --,(SELECT  TOP(1)  fldShomareHesadId FROM  Drd.tblShomareHesabCodeDaramad WHERE fldCodeDaramadId=C.fldId /*AND fldOrganId=@OrganId*/)
				 ,ShomareHId as  fldShomareHesabId				
				  ,CASE WHEN fldid IN (SELECT  s.fldId FROM     Drd.tblCodhayeDaramd AS s left JOIN
								  Drd.tblCodhayeDaramd AS p ON  s.fldDaramadId = p.fldDaramadId.GetAncestor(1)
								  WHERE p.fldDaramadId IS NULL AND s.fldId=c.fldid) THEN N'1' ELSE '0' END AS LastNode
				 FROM Drd.tblCodhayeDaramd AS C  inner join @temp as e on e.fldidCodid=c.fldid
				 WHERE C.fldLevel<>0) t
				 where  LastNode=1 and Mablagh<>0 
				 order by fldtarikh
				 
				else IF(@ShomareHesabId=0 AND @CodeDaramadId<>0)
				select distinct * from(SELECT fldStrhid AS hidChilde,fldDaramadCode AS DaramdCodeChilde,(select fldCodeHesab from drd.tblParametrHesabdari where fldShomareHesabCodeDaramadId=(select fldId from drd.tblShomareHesabCodeDaramad as d where d.fldCodeDaramadId=c.fldId)) AS DaramdCodeChilde1,fldDaramadTitle AS DaramadTitleChilde,fldLevel AS lvlChilde,
				ISNULL((SELECT d.fldStrhid FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_hid,
				ISNULL((SELECT fldDaramadCode FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_DaramadCode,
				ISNULL((SELECT fldDaramadTitle FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_DaramadTitle,
				ISNULL((SELECT fldLevel FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_Level
				--,ISNULL((SELECT SUM(mablaghcodeDaramad)over (partition by fldtarikh) FROM @temp WHERE Daramadcode=C.fldDaramadCode) ,ISNULL((SELECT SUM(mablaghcodeDaramad) FROM @temp AS t WHERE t.hid.ToString() LIKE c.fldStrhid+'%'),0)) AS Mablagh
				,sum(mablaghcodeDaramad) over (partition by fldtarikh,e.fldidcodid) as Mablagh
				,count(c)over (partition by fldtarikh,e.fldidcodid) as [Count],e.fldtarikh
				,(SELECT  TOP(1)  fldShomareHesab FROM   
									  Com.tblShomareHesabeOmoomi  WHERE tblShomareHesabeOmoomi.fldid=e.ShomareHId /*AND fldOrganId=@OrganId*/) fldShomareHesab
				 --,(SELECT  TOP(1)  fldShomareHesadId FROM  Drd.tblShomareHesabCodeDaramad WHERE fldCodeDaramadId=C.fldId /*AND fldOrganId=@OrganId*/)
				 ,ShomareHId as  fldShomareHesabId				
				  ,CASE WHEN fldid IN (SELECT  s.fldId FROM     Drd.tblCodhayeDaramd AS s left JOIN
								  Drd.tblCodhayeDaramd AS p ON  s.fldDaramadId = p.fldDaramadId.GetAncestor(1)
								  WHERE p.fldDaramadId IS NULL AND s.fldId=c.fldid) THEN N'1' ELSE '0' END AS LastNode
				 FROM Drd.tblCodhayeDaramd AS C inner join @temp as e on e.fldidCodid=c.fldid
				 WHERE C.fldLevel<>0   AND C.fldId IN (SELECT id FROM @code))t
				 where    LastNode=1 and Mablagh<>0
				  order by fldtarikh

				ELSE  IF(@ShomareHesabId<>0 AND @CodeDaramadId=0)
				SELECT DISTINCT * from(SELECT fldStrhid AS hidChilde,fldDaramadCode AS DaramdCodeChilde,(select fldCodeHesab from drd.tblParametrHesabdari where fldShomareHesabCodeDaramadId=(select fldId from drd.tblShomareHesabCodeDaramad as d where d.fldCodeDaramadId=c.fldId)) AS DaramdCodeChilde1,fldDaramadTitle AS DaramadTitleChilde,fldLevel AS lvlChilde,
				ISNULL((SELECT d.fldStrhid FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_hid,
				ISNULL((SELECT fldDaramadCode FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_DaramadCode,
				ISNULL((SELECT fldDaramadTitle FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_DaramadTitle,
				ISNULL((SELECT fldLevel FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_Level
				--,ISNULL((SELECT SUM(mablaghcodeDaramad) FROM @temp WHERE Daramadcode=C.fldDaramadCode) ,ISNULL((SELECT SUM(mablaghcodeDaramad) FROM @temp AS t WHERE t.hid.ToString() LIKE c.fldStrhid+'%'),0)) AS Mablagh
				--,ISNULL((SELECT fldtarikh FROM @temp WHERE Daramadcode=C.fldDaramadCode group by fldtarikh),'') as fldtarikh
				,sum(mablaghcodeDaramad) over (partition by fldtarikh,e.fldidcodid) as Mablagh
				,count(c)over (partition by fldtarikh,e.fldidcodid) as [Count],e.fldtarikh
				,(SELECT  TOP(1)  fldShomareHesab FROM   
									  Com.tblShomareHesabeOmoomi  WHERE tblShomareHesabeOmoomi.fldid=e.ShomareHId /*AND fldOrganId=@OrganId*/) fldShomareHesab
				 --,(SELECT  TOP(1)  fldShomareHesadId FROM  Drd.tblShomareHesabCodeDaramad WHERE fldCodeDaramadId=C.fldId /*AND fldOrganId=@OrganId*/)
				 ,@ShomareHesabId as  fldShomareHesabId				
				  ,CASE WHEN fldid IN (SELECT  s.fldId FROM     Drd.tblCodhayeDaramd AS s left JOIN
								  Drd.tblCodhayeDaramd AS p ON  s.fldDaramadId = p.fldDaramadId.GetAncestor(1)
								  WHERE p.fldDaramadId IS NULL AND s.fldId=c.fldid) THEN N'1' ELSE '0' END AS LastNode
				 FROM Drd.tblCodhayeDaramd AS C  inner join @temp as e on e.fldidCodid=c.fldid
				 WHERE C.fldLevel<>0 and ShomareHId  LIKE @ShomareHesabId  )t
				  WHERE     LastNode=1 and Mablagh<>0
				   order by fldtarikh
	end
END

IF(@fieldname='All')
BEGIN
		IF(@OrganId<>0)
		BEGIN
			if(@DateType=1)/*براساس تاریخ پرداخت*/
			begin
				INSERT INTO @temp
				SELECT   tblCodhayeDaramd_1.fldid,     tblCodhayeDaramd_1.fldDaramadCode, Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad, Com.tblShomareHesabeOmoomi.fldShomareHesab, 
									   ISNULL(cast((Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifAsliValue * Drd.tblCodhayeDaramadiElamAvarez.fldTedad + Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifAvarezValue + Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifMaliyatValue+fldTakhfifAmuzeshParvareshValue)as bigint),
										  cast((Drd.tblCodhayeDaramadiElamAvarez.fldAsliValue * Drd.tblCodhayeDaramadiElamAvarez.fldTedad + Drd.tblCodhayeDaramadiElamAvarez.fldAvarezValue + Drd.tblCodhayeDaramadiElamAvarez.fldMaliyatValue+fldAmuzeshParvareshValue)as bigint))
					AS fldmablaghCodeDaramad, '0' AS Expr1, tblCodhayeDaramd_1.fldDaramadId,'',0,Drd.tblSodoorFish.fldShomareHesabId 
				,isnull(fldTakhfifMaliyatValue,fldMaliyatValue)fldMaliyatValue,isnull(fldTakhfifAvarezValue,fldAvarezValue)fldAvarezValue,isnull(fldTakhfifAmuzeshParvareshValue,fldAmuzeshParvareshValue)fldAmuzeshParvareshValue
			
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
			SELECT fldid, fldDaramadCode,fldSharheCodeDaramad,fldShomareHesab,cast(cast(fldMablaghNaghdi as decimal(50))*cast(fldmablaghCodeDaramad as decimal(50))/cast(fldmablaghKoli as decimal(50))as bigint),'1'
			,fldDaramadId,'',0,fldShomareHesabId	,fldMaliyatValue,fldAvarezValue, cast(cast(fldMablaghNaghdi as decimal(50))*cast(fldAmuzeshParvareshValue as decimal(50))/cast(fldmablaghKoli as decimal(50))as bigint) fldAmuzeshParvareshValue
			 FROM 
			(SELECT   DISTINCT    Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId,tblCodhayeDaramd_1.fldid, tblCodhayeDaramd_1.fldDaramadCode, 
									 Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad
									-- ,SUM(fldMablagh) OVER (PARTITION BY fldReplyTaghsitId,tblNaghdi_Talab.fldShomareHesabId) AS fldMablaghNaghdi
									,Drd.fn_SumMablaghNaghdi1('Naghdi_Talab',tblNaghdi_Talab.fldFishId,tblNaghdi_Talab.fldShomareHesabId,@azTarikh ,@Tatarikh) AS fldMablaghNaghdi
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
									 GROUP BY tblCodhayeDaramd_1.fldid,tblRequestTaghsit_Takhfif.fldElamAvarezId,tblCodhayeDaramd_1.fldDaramadCode, 
									 Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad,fldMablagh,fldReplyTaghsitId, tblCodhayeDaramadiElamAvarez.fldElamAvarezId
									 ,tblNaghdi_Talab.fldShomareHesabId,fldShomareHesab,fldDaramadId,Drd.tblNaghdi_Talab.fldShomareHesabId 
										,fldMaliyatValue,fldAvarezValue,fldTakhfifMaliyatValue,fldTakhfifAvarezValue,fldTakhfifAmuzeshParvareshValue,fldAmuzeshParvareshValue,tblNaghdi_Talab.fldFishId
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
									 AND tblShomareHesabCodeDaramad.fldOrganId=@OrganId
								 
					--GROUP BY tblCodhayeDaramd_1.fldDaramadCode, Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad,fldShomareHesab,fldDaramadId

				
			union all
			SELECT fldid, fldDaramadCode,fldSharheCodeDaramad,fldShomareHesab,cast(cast(fldMablaghNaghdi as decimal(50))*cast(fldmablaghCodeDaramad as decimal(50))/cast(fldmablaghKoli as decimal(50))as bigint),'1'
			,fldDaramadId,'',0,fldShomareHesabId	,fldMaliyatValue,fldAvarezValue, cast(cast(fldMablaghNaghdi as decimal(50))*cast(fldAmuzeshParvareshValue as decimal(50))/cast(fldmablaghKoli as decimal(50))as bigint) fldAmuzeshParvareshValue
			 FROM 
			(SELECT   DISTINCT    Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId,tblCodhayeDaramd_1.fldid, tblCodhayeDaramd_1.fldDaramadCode, 
									 Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad
									-- ,SUM(fldMablagh) OVER (PARTITION BY fldReplyTaghsitId,tblNaghdi_Talab.fldShomareHesabId) AS fldMablaghNaghdi
									,Drd.fn_SumMablaghNaghdi1Variz('Naghdi_Talab',tblNaghdi_Talab.fldFishId,tblNaghdi_Talab.fldShomareHesabId,@azTarikh ,@Tatarikh) AS fldMablaghNaghdi
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
									 GROUP BY tblCodhayeDaramd_1.fldid,tblRequestTaghsit_Takhfif.fldElamAvarezId,tblCodhayeDaramd_1.fldDaramadCode, 
									 Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad,fldMablagh,fldReplyTaghsitId, tblCodhayeDaramadiElamAvarez.fldElamAvarezId
									 ,tblNaghdi_Talab.fldShomareHesabId,fldShomareHesab,fldDaramadId,Drd.tblNaghdi_Talab.fldShomareHesabId 
										,fldMaliyatValue,fldAvarezValue,fldTakhfifMaliyatValue,fldTakhfifAvarezValue,tblNaghdi_Talab.fldFishId,fldTakhfifAmuzeshParvareshValue,fldAmuzeshParvareshValue
									 )t
			end

		------------------------------------------------------- وصول شده

		INSERT INTO @temp
		 
		--SELECT  fldDaramadCode,fldSharheCodeDaramad,fldShomareHesab,cast((cast(cast(fldMablagh as numeric)/cast(fldmablaghKoli as  numeric)as  numeric(38,20))*fldmablaghCodeDaramad)  as bigint),'2',fldDaramadId
		--,'',0,fldShomareHesabIdOrgan 	,fldMaliyatValue,fldAvarezValue
		--FROM 
		--(SELECT   DISTINCT    Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId, tblCodhayeDaramd_1.fldDaramadCode, 
		--						 Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad
		--						-- ,SUM(fldMablagh) OVER (PARTITION BY fldReplyTaghsitId,tblNaghdi_Talab.fldShomareHesabId) AS fldMablaghNaghdi
		--						,Drd.fn_SumMablaghNaghdi('Check',tblCheck.fldid,tblCheck.fldShomareHesabIdOrgan,@azTarikh ,@Tatarikh) AS fldMablagh
		--						,fldShomareHesab ,fldReplyTaghsitId
		--	,ISNULL(SUM(fldTakhfifAsliValue*fldTedad+fldTakhfifAvarezValue+fldTakhfifMaliyatValue),SUM(fldAsliValue*fldTedad+fldAvarezValue+fldMaliyatValue)) AS fldmablaghCodeDaramad
		--	,(SELECT TOP(1) ISNULL(SUM(fldTakhfifAsliValue*fldTedad+fldTakhfifAvarezValue+fldTakhfifMaliyatValue) OVER (PARTITION BY tblCodhayeDaramadiElamAvarez.fldElamAvarezId),SUM(fldAsliValue*fldTedad+fldAvarezValue+fldMaliyatValue) OVER (PARTITION BY tblCodhayeDaramadiElamAvarez.fldElamAvarezId)) FROM Drd.tblCodhayeDaramadiElamAvarez AS a WHERE a.fldElamAvarezId =Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId) AS fldmablaghKoli
		--,tblCodhayeDaramd_1.fldDaramadId,tblCheck.fldShomareHesabIdOrgan
		--,isnull(fldTakhfifMaliyatValue,fldMaliyatValue)fldMaliyatValue,isnull(fldTakhfifAvarezValue,fldAvarezValue)fldAvarezValue
		--FROM            Drd.tblRequestTaghsit_Takhfif INNER JOIN
		--						 Drd.tblStatusTaghsit_Takhfif ON Drd.tblRequestTaghsit_Takhfif.fldId = Drd.tblStatusTaghsit_Takhfif.fldRequestId INNER JOIN
		--						 Drd.tblReplyTaghsit ON Drd.tblStatusTaghsit_Takhfif.fldId = Drd.tblReplyTaghsit.fldStatusId INNER JOIN
		--						 Drd.tblElamAvarez ON Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId = Drd.tblElamAvarez.fldId INNER JOIN
		--						 Drd.tblCodhayeDaramadiElamAvarez ON Drd.tblElamAvarez.fldId = Drd.tblCodhayeDaramadiElamAvarez.fldElamAvarezId INNER JOIN
		--						 Drd.tblShomareHesabCodeDaramad ON Drd.tblCodhayeDaramadiElamAvarez.fldShomareHesabCodeDaramadId = Drd.tblShomareHesabCodeDaramad.fldId INNER JOIN
		--						 Drd.tblCodhayeDaramd AS tblCodhayeDaramd_1 ON Drd.tblShomareHesabCodeDaramad.fldCodeDaramadId = tblCodhayeDaramd_1.fldId INNER JOIN
		--						 Drd.tblCheck ON Drd.tblReplyTaghsit.fldId = Drd.tblCheck.fldReplyTaghsitId INNER JOIN
		--						 com.tblShomareHesabeOmoomi ON tblShomareHesabeOmoomi.fldId = tblCheck.fldShomareHesabIdOrgan

		--						 WHERE fldRequestId NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=fldRequestId)
		--						AND tblCheck.fldStatus=2 AND fldTypeSanad=0 AND tblShomareHesabCodeDaramad.fldOrganId=@OrganId
		--						AND (Drd.tblCheck.fldDateStatus ) BETWEEN @AzTarikh AND @TaTarikh
		--						 GROUP BY tblRequestTaghsit_Takhfif.fldElamAvarezId,tblCodhayeDaramd_1.fldDaramadCode, 
		--						 Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad,fldMablaghSanad,fldReplyTaghsitId, tblCodhayeDaramadiElamAvarez.fldElamAvarezId
		--						 ,tblCheck.fldShomareHesabIdOrgan,fldShomareHesab,fldDaramadId,tblCheck.fldShomareHesabIdOrgan
		--							,fldMaliyatValue,fldAvarezValue,fldTakhfifMaliyatValue,fldTakhfifAvarezValue,tblCheck.fldid
		--						 )t

		SELECT  codid,fldDaramadCode,fldSharheCodeDaramad,fldShomareHesab,cast((cast(cast(fldMablagh as numeric)/cast(fldmablaghKoli as  numeric)as  numeric(38,20))*fldmablaghCodeDaramad)  as bigint),'2',fldDaramadId
		,'',0,fldShomareHesabIdOrgan 	,fldMaliyatValue,fldAvarezValue, cast((cast(cast(fldMablagh as numeric)/cast(fldmablaghKoli as  numeric)as  numeric(38,20))*fldAmuzeshParvareshValue)  as bigint) fldAmuzeshParvareshValue
		FROM 
		(SELECT   DISTINCT    Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId,tblCodhayeDaramd_1.fldid codid, tblCodhayeDaramd_1.fldDaramadCode, 
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
								 GROUP BY  tblCodhayeDaramd_1.fldid,tblRequestTaghsit_Takhfif.fldElamAvarezId,tblCodhayeDaramd_1.fldDaramadCode, 
								 Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad,fldMablaghSanad,fldReplyTaghsitId, tblCodhayeDaramadiElamAvarez.fldElamAvarezId
								 ,tblCheck.fldShomareHesabIdOrgan,fldShomareHesab,fldDaramadId,tblCheck.fldShomareHesabIdOrgan
									,fldMaliyatValue,fldAvarezValue,fldTakhfifMaliyatValue,fldTakhfifAvarezValue,tblCheck.fldid
									,fldTakhfifAmuzeshParvareshValue,fldAmuzeshParvareshValue



								 )t


				INSERT INTO @temp
								 SELECT fldid,  fldDaramadCode,fldSharheCodeDaramad,fldShomareHesab,cast((cast(cast(fldMablagh as numeric)/cast(fldmablaghKoli as  numeric)as  numeric(38,20))*fldmablaghCodeDaramad)  as bigint),'3',fldDaramadId 
								 ,'',0,fldShomareHesadId	,fldMaliyatValue,fldAvarezValue, cast((cast(cast(fldMablagh as numeric)/cast(fldmablaghKoli as  numeric)as  numeric(38,20))*fldAmuzeshParvareshValue)  as bigint) fldAmuzeshParvareshValue
								  FROM 
				(SELECT   DISTINCT    Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId,tblCodhayeDaramd_1.fldid, tblCodhayeDaramd_1.fldDaramadCode, 
								 Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad
								-- ,SUM(fldMablagh) OVER (PARTITION BY fldReplyTaghsitId,tblNaghdi_Talab.fldShomareHesabId) AS fldMablaghNaghdi
								,Drd.fn_SumMablaghNaghdi('Safte',fldReplyTaghsitId,tblShomareHesabCodeDaramad.fldShomareHesadId,@AzTarikh , @Tatarikh) AS fldMablagh
								,fldShomareHesab ,fldReplyTaghsitId
					,ISNULL(SUM(fldTakhfifAsliValue*fldTedad+fldTakhfifAvarezValue+fldTakhfifMaliyatValue+fldTakhfifAmuzeshParvareshValue),SUM(fldAsliValue*fldTedad+fldAvarezValue+fldMaliyatValue+fldAmuzeshParvareshValue)) AS fldmablaghCodeDaramad
					,(SELECT TOP(1) ISNULL(SUM(fldTakhfifAsliValue*fldTedad+fldTakhfifAvarezValue+fldTakhfifMaliyatValue+fldTakhfifAmuzeshParvareshValue) OVER (PARTITION BY tblCodhayeDaramadiElamAvarez.fldElamAvarezId),SUM(fldAsliValue*fldTedad+fldAvarezValue+fldMaliyatValue+fldAmuzeshParvareshValue) OVER (PARTITION BY tblCodhayeDaramadiElamAvarez.fldElamAvarezId)) FROM Drd.tblCodhayeDaramadiElamAvarez AS a WHERE a.fldElamAvarezId =Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId) AS fldmablaghKoli
				,tblCodhayeDaramd_1.fldDaramadId, tblShomareHesabCodeDaramad.fldShomareHesadId
							,isnull(fldTakhfifMaliyatValue,fldMaliyatValue)fldMaliyatValue,isnull(fldTakhfifAvarezValue,fldAvarezValue)fldAvarezValue,isnull(fldTakhfifAmuzeshParvareshValue,fldAmuzeshParvareshValue)fldAmuzeshParvareshValue
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
								 GROUP BY tblCodhayeDaramd_1.fldid,tblRequestTaghsit_Takhfif.fldElamAvarezId,tblCodhayeDaramd_1.fldDaramadCode, 
								 Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad,fldMablaghSanad,fldReplyTaghsitId, tblCodhayeDaramadiElamAvarez.fldElamAvarezId
								 ,tblShomareHesabCodeDaramad.fldShomareHesadId,fldShomareHesab,fldDaramadId, tblShomareHesabCodeDaramad.fldShomareHesadId
								 	,fldMaliyatValue,fldAvarezValue,fldTakhfifMaliyatValue,fldTakhfifAvarezValue,fldTakhfifAmuzeshParvareshValue,fldAmuzeshParvareshValue
								 )t

							INSERT INTO @temp
							SELECT  fldid,fldDaramadCode,fldSharheCodeDaramad,fldShomareHesab,cast((cast(cast(fldMablagh as numeric)/cast(fldmablaghKoli as  numeric)as  numeric(38,20))*fldmablaghCodeDaramad)  as bigint),'4',fldDaramadId 
							,'',0,fldShomareHesadId	,fldMaliyatValue,fldAvarezValue, cast((cast(cast(fldMablagh as numeric)/cast(fldmablaghKoli as  numeric)as  numeric(38,20))*fldAmuzeshParvareshValue)  as bigint) fldAmuzeshParvareshValue
							FROM 
							(SELECT   DISTINCT    Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId,tblCodhayeDaramd_1.fldid, tblCodhayeDaramd_1.fldDaramadCode, 
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
								AND tblBarat.fldStatus=2 AND tblShomareHesabCodeDaramad.fldOrganId=@OrganId
								AND (Drd.tblBarat.fldDateStatus ) BETWEEN @AzTarikh AND @TaTarikh
								--AND CAST(Drd.tblBarat.fldDate AS  DATE) BETWEEN @StartDate AND @EndDate
								 GROUP BY tblCodhayeDaramd_1.fldid,tblRequestTaghsit_Takhfif.fldElamAvarezId,tblCodhayeDaramd_1.fldDaramadCode, 
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
			
		 IF(@ShomareHesabId<>0 AND /*@CodeMaliyat=*/@CodeDaramadId=-2)/*مالیات*/
					SELECT DISTINCT hidChilde,DaramdCodeChilde,/*(select fldCodeHesab from drd.tblParametrHesabdari where fldShomareHesabCodeDaramadId=(select fldId from drd.tblShomareHesabCodeDaramad as d where d.fldCodeDaramadId=@CodeDaramadId))*/@CodeMaliyat AS DaramdCodeChilde1,DaramadTitleChilde,lvlChilde,P_hid,P_DaramadCode,P_DaramadTitle,P_Level,sum(Mablagh)   Mablagh
					,[Count],fldtarikh,fldShomareHesab,LastNode
					FROM (
					SELECT  /*(select fldStrhid from drd.tblCodhayeDaramd where fldid=@CodeMaliyat) */''AS hidChilde,
					/*(select tblCodhayeDaramd.fldDaramadCode from drd.tblCodhayeDaramd where fldid=@CodeMaliyat)*/'_' AS DaramdCodeChilde,N'مالیات' AS DaramadTitleChilde
					,/*(select tblCodhayeDaramd.fldLevel from drd.tblCodhayeDaramd where fldid=@CodeMaliyat)*/cast(0 as smallint) AS lvlChilde,
					'' AS P_hid,''AS P_DaramadCode,'' AS P_DaramadTitle,cast(0 as smallint) AS P_Level
					,e.Maliyat  as Mablagh 
					,0 AS [Count],'' fldtarikh
					,(SELECT  TOP(1)  fldShomareHesab FROM        
										  Com.tblShomareHesabeOmoomi WHERE tblShomareHesabeOmoomi.fldid=ShomareHId /*AND fldOrganId=@OrganId*/) fldShomareHesab
					 , '1'  AS LastNode
					 FROM  @temp as e
					where ShomareHId=@ShomareHesabId
					group by ShomareHId,Daramadcode,Maliyat )s
					 WHERE     LastNode=1 and Mablagh<>0
					 --order by fldtarikh 	
					 group by hidChilde,DaramdCodeChilde,DaramadTitleChilde,lvlChilde,P_hid,P_DaramadCode,P_DaramadTitle,P_Level
					,[Count],fldtarikh,fldShomareHesab,LastNode
			 
				 IF(@ShomareHesabId<>0 AND /*@CodeMaliyat=*/@CodeDaramadId=-3)/*آموزش و پرورش*/
					SELECT DISTINCT hidChilde,DaramdCodeChilde,/*(select fldCodeHesab from drd.tblParametrHesabdari where fldShomareHesabCodeDaramadId=(select fldId from drd.tblShomareHesabCodeDaramad as d where d.fldCodeDaramadId=@CodeDaramadId))*/@CodeMaliyat AS DaramdCodeChilde1,DaramadTitleChilde,lvlChilde,P_hid,P_DaramadCode,P_DaramadTitle,P_Level,sum(Mablagh)   Mablagh
					,[Count],fldtarikh,fldShomareHesab,LastNode
					FROM (
					SELECT  /*(select fldStrhid from drd.tblCodhayeDaramd where fldid=@CodeMaliyat) */''AS hidChilde,
					/*(select tblCodhayeDaramd.fldDaramadCode from drd.tblCodhayeDaramd where fldid=@CodeMaliyat)*/'_' AS DaramdCodeChilde,N'آموزش و پرورش' AS DaramadTitleChilde
					,/*(select tblCodhayeDaramd.fldLevel from drd.tblCodhayeDaramd where fldid=@CodeMaliyat)*/cast(0 as smallint) AS lvlChilde,
					'' AS P_hid,''AS P_DaramadCode,'' AS P_DaramadTitle,cast(0 as smallint) AS P_Level
					,e.fldAmuzesh  as Mablagh 
					,0 AS [Count],'' fldtarikh
					,(SELECT  TOP(1)  fldShomareHesab FROM        
										  Com.tblShomareHesabeOmoomi WHERE tblShomareHesabeOmoomi.fldid=ShomareHId /*AND fldOrganId=@OrganId*/) fldShomareHesab
					 , '1'  AS LastNode
					 FROM  @temp as e
					where ShomareHId=@ShomareHesabId
					group by ShomareHId,Daramadcode,fldAmuzesh )s
					 WHERE     LastNode=1 and Mablagh<>0
					 --order by fldtarikh 	
					 group by hidChilde,DaramdCodeChilde,DaramadTitleChilde,lvlChilde,P_hid,P_DaramadCode,P_DaramadTitle,P_Level
					,[Count],fldtarikh,fldShomareHesab,LastNode


			else IF(@ShomareHesabId=0 AND /*@CodeMaliyat=*/@CodeDaramadId=-2)/*مالیات*/
				SELECT DISTINCT hidChilde,DaramdCodeChilde,/*(select fldCodeHesab from drd.tblParametrHesabdari where fldShomareHesabCodeDaramadId=(select fldId from drd.tblShomareHesabCodeDaramad as d where d.fldCodeDaramadId=@CodeDaramadId))*/@CodeMaliyat AS DaramdCodeChilde1,DaramadTitleChilde,lvlChilde,P_hid,P_DaramadCode,P_DaramadTitle,P_Level,sum(Mablagh)   Mablagh
					,[Count],fldtarikh,fldShomareHesab,LastNode
					FROM (
					SELECT  /*(select fldStrhid from drd.tblCodhayeDaramd where fldid=@CodeMaliyat)*/'' AS hidChilde,/*(select tblCodhayeDaramd.fldDaramadCode from drd.tblCodhayeDaramd where fldid=@CodeMaliyat)*/ '_'AS DaramdCodeChilde,/*N'عوارض'*/N'مالیات' AS DaramadTitleChilde
					,/*(select tblCodhayeDaramd.fldLevel from drd.tblCodhayeDaramd where fldid=@CodeMaliyat)*/cast(0 as smallint) AS lvlChilde,
					'' AS P_hid,''AS P_DaramadCode,'' AS P_DaramadTitle,cast(0 as smallint) AS P_Level
					,e.Maliyat  as Mablagh 
					,0 AS [Count],'' fldtarikh
					,(SELECT  TOP(1)  fldShomareHesab FROM        
										  Com.tblShomareHesabeOmoomi WHERE tblShomareHesabeOmoomi.fldid=ShomareHId /*AND fldOrganId=@OrganId*/) fldShomareHesab
					 , '1'  AS LastNode
					 FROM  @temp as e
					
					group by ShomareHId,Daramadcode,Maliyat )s
					 WHERE     LastNode=1 and Mablagh<>0
					 --order by fldtarikh 	
					 group by hidChilde,DaramdCodeChilde,DaramadTitleChilde,lvlChilde,P_hid,P_DaramadCode,P_DaramadTitle,P_Level
					,[Count],fldtarikh,fldShomareHesab,LastNode
			 
				else IF(@ShomareHesabId=0 AND /*@CodeMaliyat=*/@CodeDaramadId=-3)/*آموزش و پرورش*/
				SELECT DISTINCT hidChilde,DaramdCodeChilde,/*(select fldCodeHesab from drd.tblParametrHesabdari where fldShomareHesabCodeDaramadId=(select fldId from drd.tblShomareHesabCodeDaramad as d where d.fldCodeDaramadId=@CodeDaramadId))*/@CodeMaliyat AS DaramdCodeChilde1,DaramadTitleChilde,lvlChilde,P_hid,P_DaramadCode,P_DaramadTitle,P_Level,sum(Mablagh)   Mablagh
					,[Count],fldtarikh,fldShomareHesab,LastNode
					FROM (
					SELECT  /*(select fldStrhid from drd.tblCodhayeDaramd where fldid=@CodeMaliyat)*/'' AS hidChilde,/*(select tblCodhayeDaramd.fldDaramadCode from drd.tblCodhayeDaramd where fldid=@CodeMaliyat)*/ '_'AS DaramdCodeChilde,/*N'عوارض'*/N'آموزش و پرورش' AS DaramadTitleChilde
					,/*(select tblCodhayeDaramd.fldLevel from drd.tblCodhayeDaramd where fldid=@CodeMaliyat)*/cast(0 as smallint) AS lvlChilde,
					'' AS P_hid,''AS P_DaramadCode,'' AS P_DaramadTitle,cast(0 as smallint) AS P_Level
					,e.fldAmuzesh  as Mablagh 
					,0 AS [Count],'' fldtarikh
					,(SELECT  TOP(1)  fldShomareHesab FROM        
										  Com.tblShomareHesabeOmoomi WHERE tblShomareHesabeOmoomi.fldid=ShomareHId /*AND fldOrganId=@OrganId*/) fldShomareHesab
					 , '1'  AS LastNode
					 FROM  @temp as e
					
					group by ShomareHId,Daramadcode,fldAmuzesh )s
					 WHERE     LastNode=1 and Mablagh<>0
					 --order by fldtarikh 	
					 group by hidChilde,DaramdCodeChilde,DaramadTitleChilde,lvlChilde,P_hid,P_DaramadCode,P_DaramadTitle,P_Level
					,[Count],fldtarikh,fldShomareHesab,LastNode

			 
			else IF(@ShomareHesabId<>0 AND /*@CodeAvarez=*/@CodeDaramadId=-1)/*عوارض*/
					SELECT DISTINCT hidChilde,DaramdCodeChilde,/*(select fldCodeHesab from drd.tblParametrHesabdari where fldShomareHesabCodeDaramadId=(select fldId from drd.tblShomareHesabCodeDaramad as d where d.fldCodeDaramadId=@CodeDaramadId))*/@codeavarez AS DaramdCodeChilde1,DaramadTitleChilde,lvlChilde,P_hid,P_DaramadCode,P_DaramadTitle,P_Level,sum(Mablagh)   Mablagh
					,[Count],fldtarikh,fldShomareHesab,LastNode
					FROM (
					SELECT  /*(select fldStrhid from drd.tblCodhayeDaramd where fldid=@CodeAvarez)*/'' AS hidChilde,
					/*(select tblCodhayeDaramd.fldDaramadCode from drd.tblCodhayeDaramd where fldid=@CodeAvarez)*/'_' AS DaramdCodeChilde,N'عوارض' AS DaramadTitleChilde
					,/*(select tblCodhayeDaramd.fldLevel from drd.tblCodhayeDaramd where fldid=@CodeAvarez) */0AS lvlChilde,
					'' AS P_hid,''AS P_DaramadCode,'' AS P_DaramadTitle,cast(0 as smallint) AS P_Level
					,e.Avarez  as Mablagh 
					,0 AS [Count],'' fldtarikh
					,(SELECT  TOP(1)  fldShomareHesab FROM        
										  Com.tblShomareHesabeOmoomi WHERE tblShomareHesabeOmoomi.fldid=ShomareHId /*AND fldOrganId=@OrganId*/) fldShomareHesab
					 , '1'  AS LastNode
					 FROM  @temp as e
					where ShomareHId=@ShomareHesabId
					group by ShomareHId,Daramadcode,Avarez )s
					 WHERE     LastNode=1 and Mablagh<>0
					 --order by fldtarikh 	
					 group by hidChilde,DaramdCodeChilde,DaramadTitleChilde,lvlChilde,P_hid,P_DaramadCode,P_DaramadTitle,P_Level
					,[Count],fldtarikh,fldShomareHesab,LastNode
			 
			ELSE IF(@ShomareHesabId=0 AND/* @CodeAvarez=*/@CodeDaramadId=-1)/*عوارض*/
					SELECT DISTINCT hidChilde,DaramdCodeChilde,
					/*(select fldCodeHesab from drd.tblParametrHesabdari where fldShomareHesabCodeDaramadId=(select fldId from drd.tblShomareHesabCodeDaramad as d where d.fldCodeDaramadId=@CodeDaramadId))*/@CodeAvarez AS DaramdCodeChilde1,DaramadTitleChilde,lvlChilde,P_hid,P_DaramadCode,P_DaramadTitle,P_Level,sum(Mablagh)   Mablagh
					,[Count],fldtarikh,fldShomareHesab,LastNode
					FROM (
					SELECT  /*(select fldStrhid from drd.tblCodhayeDaramd where fldid=@CodeAvarez)*/'' AS hidChilde,/*(select tblCodhayeDaramd.fldDaramadCode from drd.tblCodhayeDaramd where fldid=@CodeAvarez)*/'_' AS DaramdCodeChilde,N'عوارض' AS DaramadTitleChilde
					,/*(select tblCodhayeDaramd.fldLevel from drd.tblCodhayeDaramd where fldid=@CodeAvarez)*/0 AS lvlChilde,
					'' AS P_hid,''AS P_DaramadCode,'' AS P_DaramadTitle,cast(0 as smallint) AS P_Level
					,e.Avarez  as Mablagh 
					,0 AS [Count],'' fldtarikh
					,(SELECT  TOP(1)  fldShomareHesab FROM        
										  Com.tblShomareHesabeOmoomi WHERE tblShomareHesabeOmoomi.fldid=ShomareHId /*AND fldOrganId=@OrganId*/) fldShomareHesab
					 , '1'  AS LastNode
					 FROM  @temp as e
					group by ShomareHId,Daramadcode,Avarez )s
					 WHERE     LastNode=1 and Mablagh<>0
					 --order by fldtarikh 	
					 group by hidChilde,DaramdCodeChilde,DaramadTitleChilde,lvlChilde,P_hid,P_DaramadCode,P_DaramadTitle,P_Level
					,[Count],fldtarikh,fldShomareHesab,LastNode
			
				   
				ELSE IF(@ShomareHesabId<>0 AND @CodeDaramadId<>0)
				SELECT distinct * FROM (
				SELECT fldStrhid AS hidChilde,fldDaramadCode AS DaramdCodeChilde,(select fldCodeHesab from drd.tblParametrHesabdari where fldShomareHesabCodeDaramadId=(select fldId from drd.tblShomareHesabCodeDaramad as d where d.fldCodeDaramadId=c.fldId)) AS DaramdCodeChilde1,fldDaramadTitle AS DaramadTitleChilde,fldLevel AS lvlChilde,
				ISNULL((SELECT d.fldStrhid FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_hid,
				ISNULL((SELECT fldDaramadCode FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_DaramadCode,
				ISNULL((SELECT fldDaramadTitle FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_DaramadTitle,
				ISNULL((SELECT fldLevel FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_Level
				,sum(mablaghcodeDaramad) over (partition by tem.fldidcodid,tem.ShomareHId)/*ISNULL((SELECT SUM(mablaghcodeDaramad) FROM @temp WHERE Daramadcode=C.fldDaramadCode) ,ISNULL((SELECT SUM(mablaghcodeDaramad) FROM @temp AS t WHERE t.hid.ToString() LIKE c.fldStrhid+'%'),0))*/ AS Mablagh

				,0 AS [Count],'' fldtarikh
				,(SELECT  TOP(1)  fldShomareHesab FROM      
									  Com.tblShomareHesabeOmoomi WHERE tblShomareHesabeOmoomi.fldid=ShomareHId ) fldShomareHesab
				 , ShomareHId fldShomareHesabId
				 ,CASE WHEN fldid IN (SELECT  s.fldId FROM     Drd.tblCodhayeDaramd AS s left JOIN
								  Drd.tblCodhayeDaramd AS p ON  s.fldDaramadId = p.fldDaramadId.GetAncestor(1)
								  WHERE p.fldDaramadId IS NULL AND s.fldId=c.fldid) THEN N'1' ELSE '0' END AS LastNode
				 FROM Drd.tblCodhayeDaramd AS C inner join @temp  as tem
				 on tem.fldidcodid=c.fldid
				 WHERE C.fldLevel<>0 and ShomareHId LIKE @ShomareHesabId  AND C.fldId IN (SELECT id FROM @code))s
				 WHERE    LastNode=1 and Mablagh<>0
				 

				 ELSE IF(@ShomareHesabId=0 AND @CodeDaramadId=0)
				 
				 select distinct * from (SELECT fldStrhid AS hidChilde,fldDaramadCode AS DaramdCodeChilde,isnull((select cast(fldCodeHesab as bigint) from drd.tblParametrHesabdari where fldShomareHesabCodeDaramadId=(select fldId from drd.tblShomareHesabCodeDaramad as d where d.fldCodeDaramadId=c.fldId)),cast(0 as bigint))AS DaramdCodeChilde1,fldDaramadTitle AS DaramadTitleChilde,fldLevel AS lvlChilde,
				ISNULL((SELECT d.fldStrhid FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_hid,
				ISNULL((SELECT fldDaramadCode FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_DaramadCode,
				ISNULL((SELECT fldDaramadTitle FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_DaramadTitle,
				ISNULL((SELECT fldLevel FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_Level
				,sum(mablaghcodeDaramad) over (partition by tem.fldidcodid,tem.ShomareHId)/*ISNULL((SELECT SUM(mablaghcodeDaramad) FROM @temp WHERE Daramadcode=C.fldDaramadCode) ,ISNULL((SELECT SUM(mablaghcodeDaramad) FROM @temp AS t WHERE t.hid.ToString() LIKE c.fldStrhid+'%'),0))*/ AS Mablagh
				,0 AS [Count],'' fldtarikh
				,(SELECT  TOP(1)  fldShomareHesab FROM      
									  Com.tblShomareHesabeOmoomi WHERE tblShomareHesabeOmoomi.fldid=ShomareHId ) fldShomareHesab
				 , ShomareHId fldShomareHesabId
				 				 ,CASE WHEN c.fldid IN (SELECT  s.fldId FROM     Drd.tblCodhayeDaramd AS s left JOIN
								  Drd.tblCodhayeDaramd AS p ON  s.fldDaramadId = p.fldDaramadId.GetAncestor(1)
								  WHERE p.fldDaramadId IS NULL AND s.fldId=c.fldid) THEN N'1' ELSE '0' END AS LastNode
				 FROM Drd.tblCodhayeDaramd AS C inner join @temp  as tem
				 on tem.fldidCodid=c.fldid
				-- inner join [Drd].[tblShomareHedabCodeDaramd_Detail] c1
				--on c1.fldcodedaramdid=c.fldid
				 WHERE C.fldLevel<>0) t
				 where  LastNode=1 and Mablagh<>0 
				 
				ELSE  IF(@ShomareHesabId=0 AND @CodeDaramadId<>0)
				select distinct * from(SELECT fldStrhid AS hidChilde,fldDaramadCode AS DaramdCodeChilde,(select fldCodeHesab from drd.tblParametrHesabdari where fldShomareHesabCodeDaramadId=(select fldId from drd.tblShomareHesabCodeDaramad as d where d.fldCodeDaramadId=c.fldId)) AS DaramdCodeChilde1,fldDaramadTitle AS DaramadTitleChilde,fldLevel AS lvlChilde,
				ISNULL((SELECT d.fldStrhid FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_hid,
				ISNULL((SELECT fldDaramadCode FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_DaramadCode,
				ISNULL((SELECT fldDaramadTitle FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_DaramadTitle,
				ISNULL((SELECT fldLevel FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_Level
				,sum(mablaghcodeDaramad) over (partition by tem.fldidcodid,tem.ShomareHId)/*ISNULL((SELECT SUM(mablaghcodeDaramad) FROM @temp WHERE Daramadcode=C.fldDaramadCode) ,ISNULL((SELECT SUM(mablaghcodeDaramad) FROM @temp AS t WHERE t.hid.ToString() LIKE c.fldStrhid+'%'),0))*/ AS Mablagh
				,0 AS [Count],'' fldtarikh
				,(SELECT  TOP(1)  fldShomareHesab FROM      
									  Com.tblShomareHesabeOmoomi WHERE tblShomareHesabeOmoomi.fldid=ShomareHId ) fldShomareHesab
				 , ShomareHId fldShomareHesabId				  ,CASE WHEN fldid IN (SELECT  s.fldId FROM     Drd.tblCodhayeDaramd AS s left JOIN
								  Drd.tblCodhayeDaramd AS p ON  s.fldDaramadId = p.fldDaramadId.GetAncestor(1)
								  WHERE p.fldDaramadId IS NULL AND s.fldId=c.fldid) THEN N'1' ELSE '0' END AS LastNode
				 FROM Drd.tblCodhayeDaramd AS C inner join @temp  as tem
				 on tem.fldidCodid=c.fldid
				 WHERE C.fldLevel<>0   AND C.fldId IN (SELECT id FROM @code))t
				 where    LastNode=1 and Mablagh<>0

				
				 ELSE IF(@ShomareHesabId<>0 AND @CodeDaramadId=0)
				SELECT distinct * from(SELECT fldStrhid AS hidChilde,fldDaramadCode AS DaramdCodeChilde,(select fldCodeHesab from drd.tblParametrHesabdari where fldShomareHesabCodeDaramadId=(select fldId from drd.tblShomareHesabCodeDaramad as d where d.fldCodeDaramadId=c.fldId)) AS DaramdCodeChilde1,fldDaramadTitle AS DaramadTitleChilde,fldLevel AS lvlChilde,
				ISNULL((SELECT d.fldStrhid FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_hid,
				ISNULL((SELECT fldDaramadCode FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_DaramadCode,
				ISNULL((SELECT fldDaramadTitle FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_DaramadTitle,
				ISNULL((SELECT fldLevel FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_Level
				,sum(mablaghcodeDaramad) over (partition by tem.fldidcodid,tem.ShomareHId)/*ISNULL((SELECT SUM(mablaghcodeDaramad) FROM @temp WHERE Daramadcode=C.fldDaramadCode) ,ISNULL((SELECT SUM(mablaghcodeDaramad) FROM @temp AS t WHERE t.hid.ToString() LIKE c.fldStrhid+'%'),0))*/ AS Mablagh
				,0 AS [Count],'' fldtarikh
				,(SELECT  TOP(1)  fldShomareHesab FROM      
									  Com.tblShomareHesabeOmoomi WHERE tblShomareHesabeOmoomi.fldid=ShomareHId ) fldShomareHesab
				 , ShomareHId fldShomareHesabId				  ,CASE WHEN c.fldid IN (SELECT  s.fldId FROM     Drd.tblCodhayeDaramd AS s left JOIN
								  Drd.tblCodhayeDaramd AS p ON  s.fldDaramadId = p.fldDaramadId.GetAncestor(1)
								  WHERE p.fldDaramadId IS NULL AND s.fldId=c.fldid) THEN N'1' ELSE '0' END AS LastNode
				
				 FROM Drd.tblCodhayeDaramd AS C inner join @temp  as tem
				 on tem.fldidCodid=c.fldid
				

				 WHERE C.fldLevel<>0 and ShomareHId  LIKE @ShomareHesabId )t
				  WHERE   LastNode=1 and Mablagh<>0
				  END
	ELSE
		BEGIN
			if(@DateType=1)/*براساس تاریخ پرداخت*/
			begin
				INSERT INTO @temp
				SELECT       tblCodhayeDaramd_1.fldid, tblCodhayeDaramd_1.fldDaramadCode, Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad, Com.tblShomareHesabeOmoomi.fldShomareHesab, 
									   ISNULL(cast((Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifAsliValue * Drd.tblCodhayeDaramadiElamAvarez.fldTedad + Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifAvarezValue + Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifMaliyatValue+fldTakhfifAmuzeshParvareshValue)as bigint),
									  cast((Drd.tblCodhayeDaramadiElamAvarez.fldAsliValue * Drd.tblCodhayeDaramadiElamAvarez.fldTedad + Drd.tblCodhayeDaramadiElamAvarez.fldAvarezValue + Drd.tblCodhayeDaramadiElamAvarez.fldMaliyatValue+fldAmuzeshParvareshValue)as bigint))
				AS fldmablaghCodeDaramad, '0' AS Expr1, tblCodhayeDaramd_1.fldDaramadId,'',0,Drd.tblSodoorFish.fldShomareHesabId 
				,isnull(fldTakhfifMaliyatValue,fldMaliyatValue)fldMaliyatValue,isnull(fldTakhfifAvarezValue,fldAvarezValue)fldAvarezValue,isnull(fldTakhfifAmuzeshParvareshValue,fldAmuzeshParvareshValue)fldAmuzeshParvareshValue
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
					SELECT codid,fldDaramadCode,fldSharheCodeDaramad,fldShomareHesab, cast(cast(fldMablaghNaghdi as decimal(50))*cast(fldmablaghCodeDaramad as decimal(50))/cast(fldmablaghKoli as decimal(50))as bigint),'1'
					,fldDaramadId,'',0,fldShomareHesabId	,fldMaliyatValue,fldAvarezValue,cast(cast(fldMablaghNaghdi as decimal(50))*cast(fldAmuzeshParvareshValue as decimal(50))/cast(fldmablaghKoli as decimal(50))as bigint) fldAmuzeshParvareshValue
					 FROM 
					(SELECT   DISTINCT    tblCodhayeDaramd_1.fldid codid,Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId, tblCodhayeDaramd_1.fldDaramadCode, 
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
								
									 GROUP BY tblCodhayeDaramd_1.fldid,tblRequestTaghsit_Takhfif.fldElamAvarezId,tblCodhayeDaramd_1.fldDaramadCode, 
									 Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad,fldMablagh,fldReplyTaghsitId, tblCodhayeDaramadiElamAvarez.fldElamAvarezId
									 ,tblNaghdi_Talab.fldShomareHesabId,fldShomareHesab,fldDaramadId,Drd.tblNaghdi_Talab.fldShomareHesabId 
									,fldMaliyatValue,fldAvarezValue,fldTakhfifMaliyatValue,fldTakhfifAvarezValue,tblNaghdi_Talab.fldFishId,fldTakhfifAmuzeshParvareshValue,fldAmuzeshParvareshValue
									 )t

				end
				else if(@DateType=0)/*براساس تاریخ واریز*/
			begin
				INSERT INTO @temp
				SELECT     tblCodhayeDaramd_1.fldid,   tblCodhayeDaramd_1.fldDaramadCode, Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad, Com.tblShomareHesabeOmoomi.fldShomareHesab, 
									   ISNULL(cast((Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifAsliValue * Drd.tblCodhayeDaramadiElamAvarez.fldTedad + Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifAvarezValue + Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifMaliyatValue+Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifAmuzeshParvareshValue)as bigint),
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
					SELECT codid,fldDaramadCode,fldSharheCodeDaramad,fldShomareHesab, cast(cast(fldMablaghNaghdi as decimal(50))*cast(fldmablaghCodeDaramad as decimal(50))/cast(fldmablaghKoli as decimal(50))as bigint),'1'
					,fldDaramadId,'',0,fldShomareHesabId	,fldMaliyatValue,fldAvarezValue,cast(cast(fldMablaghNaghdi as decimal(50))*cast(fldAmuzeshParvareshValue as decimal(50))/cast(fldmablaghKoli as decimal(50))as bigint) fldAmuzeshParvareshValue
					 FROM 
					(SELECT   DISTINCT    Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId,tblCodhayeDaramd_1.fldid codid, tblCodhayeDaramd_1.fldDaramadCode, 
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
								
									 GROUP BY tblCodhayeDaramd_1.fldid,tblRequestTaghsit_Takhfif.fldElamAvarezId,tblCodhayeDaramd_1.fldDaramadCode, 
									 Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad,fldMablagh,fldReplyTaghsitId, tblCodhayeDaramadiElamAvarez.fldElamAvarezId
									 ,tblNaghdi_Talab.fldShomareHesabId,fldShomareHesab,fldDaramadId,Drd.tblNaghdi_Talab.fldShomareHesabId 
									,fldMaliyatValue,fldAvarezValue,fldTakhfifMaliyatValue,fldTakhfifAvarezValue,tblNaghdi_Talab.fldFishId
									,fldAmuzeshParvareshValue,fldTakhfifAmuzeshParvareshValue
									 )t

				end
		------------------------------------------------------- وصول شده

		INSERT INTO @temp
		 
		SELECT  codid,fldDaramadCode,fldSharheCodeDaramad,fldShomareHesab,cast((cast(cast(fldMablagh as numeric)/cast(fldmablaghKoli as  numeric)as  numeric(38,20))*fldmablaghCodeDaramad)  as bigint),'2',fldDaramadId 
		,'' ,0,fldShomareHesabIdOrgan,fldMaliyatValue,fldAvarezValue, cast((cast(cast(fldMablagh as numeric)/cast(fldmablaghKoli as  numeric)as  numeric(38,20))*fldAmuzeshParvareshValue)  as bigint) fldAmuzeshParvareshValue
		FROM 
		(SELECT   DISTINCT    Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId,tblCodhayeDaramd_1.fldid codid, tblCodhayeDaramd_1.fldDaramadCode, 
								 Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad
								-- ,SUM(fldMablagh) OVER (PARTITION BY fldReplyTaghsitId,tblNaghdi_Talab.fldShomareHesabId) AS fldMablaghNaghdi
								,Drd.fn_SumMablaghNaghdi('Check',tblcheck.fldId,tblCheck.fldShomareHesabIdOrgan,@azTarikh ,@Tatarikh) AS fldMablagh
								,fldShomareHesab ,fldReplyTaghsitId
			,ISNULL(SUM(fldTakhfifAsliValue*fldTedad+fldTakhfifAvarezValue+fldTakhfifMaliyatValue+fldTakhfifAmuzeshParvareshValue),SUM(fldAsliValue*fldTedad+fldAvarezValue+fldMaliyatValue+fldAmuzeshParvareshValue)) AS fldmablaghCodeDaramad
			,(SELECT TOP(1) ISNULL(SUM(fldTakhfifAsliValue*fldTedad+fldTakhfifAvarezValue+fldTakhfifMaliyatValue+fldTakhfifAmuzeshParvareshValue) OVER (PARTITION BY tblCodhayeDaramadiElamAvarez.fldElamAvarezId),SUM(fldAsliValue*fldTedad+fldAvarezValue+fldMaliyatValue+fldAmuzeshParvareshValue) OVER (PARTITION BY tblCodhayeDaramadiElamAvarez.fldElamAvarezId)) FROM Drd.tblCodhayeDaramadiElamAvarez AS a WHERE a.fldElamAvarezId =Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId) AS fldmablaghKoli
		,tblCodhayeDaramd_1.fldDaramadId,tblCheck.fldShomareHesabIdOrgan
		,isnull(fldTakhfifMaliyatValue,fldMaliyatValue)fldMaliyatValue,isnull(fldTakhfifAvarezValue,fldAvarezValue)fldAvarezValue,tblcheck.fldId,isnull(fldTakhfifAmuzeshParvareshValue,fldAmuzeshParvareshValue)fldAmuzeshParvareshValue
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
								 GROUP BY tblCodhayeDaramd_1.fldid,tblRequestTaghsit_Takhfif.fldElamAvarezId,tblCodhayeDaramd_1.fldDaramadCode, 
								 Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad,fldMablaghSanad,fldReplyTaghsitId, tblCodhayeDaramadiElamAvarez.fldElamAvarezId
								 ,tblCheck.fldShomareHesabIdOrgan,fldShomareHesab,fldDaramadId,tblCheck.fldShomareHesabIdOrgan
								 ,fldMaliyatValue,fldAvarezValue,fldTakhfifMaliyatValue,fldTakhfifAvarezValue,tblcheck.fldId
								 ,fldAmuzeshParvareshValue,fldTakhfifAmuzeshParvareshValue
								 )t


		INSERT INTO @temp
  					 SELECT  codid,fldDaramadCode,fldSharheCodeDaramad,fldShomareHesab,cast((cast(cast(fldMablagh as numeric)/cast(fldmablaghKoli as  numeric)as  numeric(38,20))*fldmablaghCodeDaramad)  as bigint),'3',fldDaramadId 
					 ,'',0,fldShomareHesadId,fldMaliyatValue,fldAvarezValue,cast((cast(cast(fldMablagh as numeric)/cast(fldmablaghKoli as  numeric)as  numeric(38,20))*fldAmuzeshParvareshValue)  as bigint) fldAmuzeshParvareshValue
								 FROM 
		(SELECT   DISTINCT    Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId,tblCodhayeDaramd_1.fldid codid, tblCodhayeDaramd_1.fldDaramadCode, 
								 Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad
								-- ,SUM(fldMablagh) OVER (PARTITION BY fldReplyTaghsitId,tblNaghdi_Talab.fldShomareHesabId) AS fldMablaghNaghdi
								,Drd.fn_SumMablaghNaghdi('Safte',fldReplyTaghsitId,tblShomareHesabCodeDaramad.fldShomareHesadId,@AzTarikh , @Tatarikh) AS fldMablagh
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
								 Drd.tblSafte ON Drd.tblReplyTaghsit.fldId = Drd.tblSafte.fldReplyTaghsitId INNER JOIN
								 com.tblShomareHesabeOmoomi ON tblShomareHesabeOmoomi.fldId = tblShomareHesabCodeDaramad.fldShomareHesadId

								 WHERE fldRequestId NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=fldRequestId)
								AND tblSafte.fldStatus=2 
								AND (Drd.tblSafte.fldDateStatus ) BETWEEN @AzTarikh AND @TaTarikh
								--AND CAST(Drd.tblSafte.fldDate AS  DATE) BETWEEN @StartDate AND @EndDate
								 GROUP BY tblCodhayeDaramd_1.fldid,tblRequestTaghsit_Takhfif.fldElamAvarezId,tblCodhayeDaramd_1.fldDaramadCode, 
								 Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad,fldMablaghSanad,fldReplyTaghsitId, tblCodhayeDaramadiElamAvarez.fldElamAvarezId
								 ,tblShomareHesabCodeDaramad.fldShomareHesadId,fldShomareHesab,fldDaramadId,tblShomareHesabCodeDaramad.fldShomareHesadId
								 ,fldMaliyatValue,fldAvarezValue,fldTakhfifMaliyatValue,fldTakhfifAvarezValue,fldTakhfifAmuzeshParvareshValue,fldAmuzeshParvareshValue
								 )t

				INSERT INTO @temp
				SELECT codid, fldDaramadCode,fldSharheCodeDaramad,fldShomareHesab,cast((cast(cast(fldMablagh as numeric)/cast(fldmablaghKoli as  numeric)as  numeric(38,20))*fldmablaghCodeDaramad)  as bigint),'4',fldDaramadId
				,'',0,fldShomareHesadId,fldMaliyatValue,fldAvarezValue,cast((cast(cast(fldMablagh as numeric)/cast(fldmablaghKoli as  numeric)as  numeric(38,20))*fldAmuzeshParvareshValue)  as bigint) fldAmuzeshParvareshValue
				 FROM 
				(SELECT   DISTINCT    Drd.tblRequestTaghsit_Takhfif.fldElamAvarezId,tblCodhayeDaramd_1.fldid codid, tblCodhayeDaramd_1.fldDaramadCode, 
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
								AND tblBarat.fldStatus=2 
								AND (Drd.tblBarat.fldDateStatus ) BETWEEN @AzTarikh AND @TaTarikh
								--AND CAST(Drd.tblBarat.fldDate AS  DATE) BETWEEN @StartDate AND @EndDate
								 GROUP BY tblCodhayeDaramd_1.fldid, tblRequestTaghsit_Takhfif.fldElamAvarezId,tblCodhayeDaramd_1.fldDaramadCode, 
								 Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad,fldMablaghSanad,fldReplyTaghsitId, tblCodhayeDaramadiElamAvarez.fldElamAvarezId
								 ,tblShomareHesabCodeDaramad.fldShomareHesadId,fldShomareHesab,fldDaramadId,tblShomareHesabCodeDaramad.fldShomareHesadId
								 ,fldMaliyatValue,fldAvarezValue,fldTakhfifMaliyatValue,fldTakhfifAvarezValue,fldAmuzeshParvareshValue,fldTakhfifAmuzeshParvareshValue
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
			
			 IF(@ShomareHesabId<>0 AND /*@CodeMaliyat=*/@CodeDaramadId=-2)/*مالیات*/
					SELECT DISTINCT hidChilde,DaramdCodeChilde,/*(select fldCodeHesab from drd.tblParametrHesabdari where fldShomareHesabCodeDaramadId=(select fldId from drd.tblShomareHesabCodeDaramad as d where d.fldCodeDaramadId=@CodeDaramadId)) */@CodeMaliyat AS DaramdCodeChilde1,DaramadTitleChilde,lvlChilde,P_hid,P_DaramadCode,P_DaramadTitle,P_Level,sum(Mablagh)   Mablagh
					,[Count],fldtarikh,fldShomareHesab,LastNode
					FROM (
					SELECT  /*(select fldStrhid from drd.tblCodhayeDaramd where fldid=@CodeMaliyat)*/'' AS hidChilde,
					/*(select tblCodhayeDaramd.fldDaramadCode from drd.tblCodhayeDaramd where fldid=@CodeMaliyat)*/'_' AS DaramdCodeChilde,/*N'عوارض'*/N'مالیات' AS DaramadTitleChilde
					,/*(select tblCodhayeDaramd.fldLevel from drd.tblCodhayeDaramd where fldid=@CodeMaliyat)*/0 AS lvlChilde,
					'' AS P_hid,''AS P_DaramadCode,'' AS P_DaramadTitle,cast(0 as smallint) AS P_Level
					,e.Maliyat  as Mablagh 
					,0 AS [Count],'' fldtarikh
					,(SELECT  TOP(1)  fldShomareHesab FROM        
										  Com.tblShomareHesabeOmoomi WHERE tblShomareHesabeOmoomi.fldid=ShomareHId /*AND fldOrganId=@OrganId*/) fldShomareHesab
					 , '1'  AS LastNode
					 FROM  @temp as e
					where ShomareHId=@ShomareHesabId
					group by ShomareHId,Daramadcode,Maliyat )s
					 WHERE     LastNode=1 and Mablagh<>0
					 --order by fldtarikh 	
					 group by hidChilde,DaramdCodeChilde,DaramadTitleChilde,lvlChilde,P_hid,P_DaramadCode,P_DaramadTitle,P_Level
					,[Count],fldtarikh,fldShomareHesab,LastNode
			 
			  IF(@ShomareHesabId<>0 AND /*@CodeMaliyat=*/@CodeDaramadId=-3)/*آموزش و پرورش*/
					SELECT DISTINCT hidChilde,DaramdCodeChilde,/*(select fldCodeHesab from drd.tblParametrHesabdari where fldShomareHesabCodeDaramadId=(select fldId from drd.tblShomareHesabCodeDaramad as d where d.fldCodeDaramadId=@CodeDaramadId)) */@CodeMaliyat AS DaramdCodeChilde1,DaramadTitleChilde,lvlChilde,P_hid,P_DaramadCode,P_DaramadTitle,P_Level,sum(Mablagh)   Mablagh
					,[Count],fldtarikh,fldShomareHesab,LastNode
					FROM (
					SELECT  /*(select fldStrhid from drd.tblCodhayeDaramd where fldid=@CodeMaliyat)*/'' AS hidChilde,
					/*(select tblCodhayeDaramd.fldDaramadCode from drd.tblCodhayeDaramd where fldid=@CodeMaliyat)*/'_' AS DaramdCodeChilde,/*N'عوارض'*/N'آموزش و پرورش' AS DaramadTitleChilde
					,/*(select tblCodhayeDaramd.fldLevel from drd.tblCodhayeDaramd where fldid=@CodeMaliyat)*/0 AS lvlChilde,
					'' AS P_hid,''AS P_DaramadCode,'' AS P_DaramadTitle,cast(0 as smallint) AS P_Level
					,e.fldAmuzesh  as Mablagh 
					,0 AS [Count],'' fldtarikh
					,(SELECT  TOP(1)  fldShomareHesab FROM        
										  Com.tblShomareHesabeOmoomi WHERE tblShomareHesabeOmoomi.fldid=ShomareHId /*AND fldOrganId=@OrganId*/) fldShomareHesab
					 , '1'  AS LastNode
					 FROM  @temp as e
					where ShomareHId=@ShomareHesabId
					group by ShomareHId,Daramadcode,fldAmuzesh )s
					 WHERE     LastNode=1 and Mablagh<>0
					 --order by fldtarikh 	
					 group by hidChilde,DaramdCodeChilde,DaramadTitleChilde,lvlChilde,P_hid,P_DaramadCode,P_DaramadTitle,P_Level
					,[Count],fldtarikh,fldShomareHesab,LastNode

					else IF(@ShomareHesabId=0 AND/* @CodeMaliyat=*/@CodeDaramadId=-3)/*آموزش و پرورش*/
				SELECT DISTINCT hidChilde,DaramdCodeChilde,/*(select fldCodeHesab from drd.tblParametrHesabdari where fldShomareHesabCodeDaramadId=(select fldId from drd.tblShomareHesabCodeDaramad as d where d.fldCodeDaramadId=@CodeDaramadId))*/@CodeMaliyat AS DaramdCodeChilde1,DaramadTitleChilde,lvlChilde,P_hid,P_DaramadCode,P_DaramadTitle,P_Level,sum(Mablagh)   Mablagh
					,[Count],fldtarikh,fldShomareHesab,LastNode
					FROM (
					SELECT  /*(select fldStrhid from drd.tblCodhayeDaramd where fldid=@CodeMaliyat)*/'' AS hidChilde,/*(select tblCodhayeDaramd.fldDaramadCode from drd.tblCodhayeDaramd where fldid=@CodeMaliyat) */'_'AS DaramdCodeChilde,/*N'عوارض'*/N'آموزش و پرورش' AS DaramadTitleChilde
					,/*(select tblCodhayeDaramd.fldLevel from drd.tblCodhayeDaramd where fldid=@CodeMaliyat)*/'' AS lvlChilde,
					'' AS P_hid,''AS P_DaramadCode,'' AS P_DaramadTitle,cast(0 as smallint) AS P_Level
					,e.fldAmuzesh  as Mablagh 
					,0 AS [Count],'' fldtarikh
					,(SELECT  TOP(1)  fldShomareHesab FROM        
										  Com.tblShomareHesabeOmoomi WHERE tblShomareHesabeOmoomi.fldid=ShomareHId /*AND fldOrganId=@OrganId*/) fldShomareHesab
					 , '1'  AS LastNode
					 FROM  @temp as e
					
					group by ShomareHId,Daramadcode,fldAmuzesh )s
					 WHERE     LastNode=1 and Mablagh<>0
					 --order by fldtarikh 	
					 group by hidChilde,DaramdCodeChilde,DaramadTitleChilde,lvlChilde,P_hid,P_DaramadCode,P_DaramadTitle,P_Level
					,[Count],fldtarikh,fldShomareHesab,LastNode
			 


			else IF(@ShomareHesabId=0 AND/* @CodeMaliyat=*/@CodeDaramadId=-2)/*مالیات*/
				SELECT DISTINCT hidChilde,DaramdCodeChilde,/*(select fldCodeHesab from drd.tblParametrHesabdari where fldShomareHesabCodeDaramadId=(select fldId from drd.tblShomareHesabCodeDaramad as d where d.fldCodeDaramadId=@CodeDaramadId))*/@CodeMaliyat AS DaramdCodeChilde1,DaramadTitleChilde,lvlChilde,P_hid,P_DaramadCode,P_DaramadTitle,P_Level,sum(Mablagh)   Mablagh
					,[Count],fldtarikh,fldShomareHesab,LastNode
					FROM (
					SELECT  /*(select fldStrhid from drd.tblCodhayeDaramd where fldid=@CodeMaliyat)*/'' AS hidChilde,/*(select tblCodhayeDaramd.fldDaramadCode from drd.tblCodhayeDaramd where fldid=@CodeMaliyat) */'_'AS DaramdCodeChilde,/*N'عوارض'*/N'مالیات' AS DaramadTitleChilde
					,/*(select tblCodhayeDaramd.fldLevel from drd.tblCodhayeDaramd where fldid=@CodeMaliyat)*/'' AS lvlChilde,
					'' AS P_hid,''AS P_DaramadCode,'' AS P_DaramadTitle,cast(0 as smallint) AS P_Level
					,e.Maliyat  as Mablagh 
					,0 AS [Count],'' fldtarikh
					,(SELECT  TOP(1)  fldShomareHesab FROM        
										  Com.tblShomareHesabeOmoomi WHERE tblShomareHesabeOmoomi.fldid=ShomareHId /*AND fldOrganId=@OrganId*/) fldShomareHesab
					 , '1'  AS LastNode
					 FROM  @temp as e
					
					group by ShomareHId,Daramadcode,Maliyat )s
					 WHERE     LastNode=1 and Mablagh<>0
					 --order by fldtarikh 	
					 group by hidChilde,DaramdCodeChilde,DaramadTitleChilde,lvlChilde,P_hid,P_DaramadCode,P_DaramadTitle,P_Level
					,[Count],fldtarikh,fldShomareHesab,LastNode
			 
			 
			else IF(@ShomareHesabId<>0 AND /*@CodeAvarez=*/@CodeDaramadId=-1)/*عوارض*/
					SELECT DISTINCT hidChilde,DaramdCodeChilde,/*(select fldCodeHesab from drd.tblParametrHesabdari where fldShomareHesabCodeDaramadId=(select fldId from drd.tblShomareHesabCodeDaramad as d where d.fldCodeDaramadId=@CodeDaramadId))*/@CodeAvarez AS DaramdCodeChilde1,DaramadTitleChilde,lvlChilde,P_hid,P_DaramadCode,P_DaramadTitle,P_Level,sum(Mablagh)   Mablagh
					,[Count],fldtarikh,fldShomareHesab,LastNode
					FROM (
					SELECT  /*(select fldStrhid from drd.tblCodhayeDaramd where fldid=@CodeAvarez)*/'' AS hidChilde,/*(select tblCodhayeDaramd.fldDaramadCode from drd.tblCodhayeDaramd where fldid=@CodeAvarez)*/'_' AS DaramdCodeChilde,N'عوارض' AS DaramadTitleChilde
					,/*(select tblCodhayeDaramd.fldLevel from drd.tblCodhayeDaramd where fldid=@CodeAvarez)*/0 AS lvlChilde,
					'' AS P_hid,''AS P_DaramadCode,'' AS P_DaramadTitle,cast(0 as smallint) AS P_Level
					,e.Avarez  as Mablagh 
					,0 AS [Count],'' fldtarikh
					,(SELECT  TOP(1)  fldShomareHesab FROM        
										  Com.tblShomareHesabeOmoomi WHERE tblShomareHesabeOmoomi.fldid=ShomareHId /*AND fldOrganId=@OrganId*/) fldShomareHesab
					 , '1'  AS LastNode
					 FROM  @temp as e
					where ShomareHId=@ShomareHesabId
					group by ShomareHId,Daramadcode,Avarez )s
					 WHERE     LastNode=1 and Mablagh<>0
					 --order by fldtarikh 	
					 group by hidChilde,DaramdCodeChilde,DaramadTitleChilde,lvlChilde,P_hid,P_DaramadCode,P_DaramadTitle,P_Level
					,[Count],fldtarikh,fldShomareHesab,LastNode
			 
			ELSE IF(@ShomareHesabId=0 AND /*@CodeAvarez=*/@CodeDaramadId=-1)/*عوارض	*/
					SELECT DISTINCT hidChilde,DaramdCodeChilde,/*(select fldCodeHesab from drd.tblParametrHesabdari where fldShomareHesabCodeDaramadId=(select fldId from drd.tblShomareHesabCodeDaramad as d where d.fldCodeDaramadId=@CodeDaramadId))*/@CodeAvarez AS DaramdCodeChilde1,DaramadTitleChilde,lvlChilde,P_hid,P_DaramadCode,P_DaramadTitle,P_Level,sum(Mablagh)   Mablagh
					,[Count],fldtarikh,fldShomareHesab,LastNode
					FROM (
					SELECT  /*(select fldStrhid from drd.tblCodhayeDaramd where fldid=@CodeAvarez)*/'' AS hidChilde,/*(select tblCodhayeDaramd.fldDaramadCode from drd.tblCodhayeDaramd where fldid=@CodeAvarez)*/'_' AS DaramdCodeChilde,N'عوارض' AS DaramadTitleChilde
					,/*(select tblCodhayeDaramd.fldLevel from drd.tblCodhayeDaramd where fldid=@CodeAvarez)*/cast(0 as smallint) AS lvlChilde,
					'' AS P_hid,''AS P_DaramadCode,'' AS P_DaramadTitle,cast(0 as smallint) AS P_Level
					,e.Avarez  as Mablagh 
					,0 AS [Count],'' fldtarikh
					,(SELECT  TOP(1)  fldShomareHesab FROM        
										  Com.tblShomareHesabeOmoomi WHERE tblShomareHesabeOmoomi.fldid=ShomareHId /*AND fldOrganId=@OrganId*/) fldShomareHesab
					 , '1'  AS LastNode
					 FROM  @temp as e
					group by ShomareHId,Daramadcode,Avarez )s
					 WHERE     LastNode=1 and Mablagh<>0
					 --order by fldtarikh 	
					 group by hidChilde,DaramdCodeChilde,DaramadTitleChilde,lvlChilde,P_hid,P_DaramadCode,P_DaramadTitle,P_Level
					,[Count],fldtarikh,fldShomareHesab,LastNode
			
			ELSE IF(@ShomareHesabId<>0 AND @CodeDaramadId<>0)
			SELECT distinct * FROM (
			SELECT fldStrhid AS hidChilde,fldDaramadCode AS DaramdCodeChilde,(select fldCodeHesab from drd.tblParametrHesabdari where fldShomareHesabCodeDaramadId=(select fldId from drd.tblShomareHesabCodeDaramad as d where d.fldCodeDaramadId=@CodeDaramadId)) AS DaramdCodeChilde1,fldDaramadTitle AS DaramadTitleChilde,fldLevel AS lvlChilde,
			ISNULL((SELECT d.fldStrhid FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_hid,
			ISNULL((SELECT fldDaramadCode FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_DaramadCode,
			ISNULL((SELECT fldDaramadTitle FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_DaramadTitle,
			ISNULL((SELECT fldLevel FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_Level
				,sum(mablaghcodeDaramad) over (partition by tem.fldidcodid,tem.ShomareHId)/*ISNULL((SELECT SUM(mablaghcodeDaramad) FROM @temp WHERE Daramadcode=C.fldDaramadCode) ,ISNULL((SELECT SUM(mablaghcodeDaramad) FROM @temp AS t WHERE t.hid.ToString() LIKE c.fldStrhid+'%'),0))*/ AS Mablagh
				,0 AS [Count],'' fldtarikh
				,(SELECT  TOP(1)  fldShomareHesab FROM      
									  Com.tblShomareHesabeOmoomi WHERE tblShomareHesabeOmoomi.fldid=ShomareHId ) fldShomareHesab
				 , ShomareHId fldShomareHesabId	
				 			 ,CASE WHEN fldid IN (SELECT  s.fldId FROM     Drd.tblCodhayeDaramd AS s left JOIN
							  Drd.tblCodhayeDaramd AS p ON  s.fldDaramadId = p.fldDaramadId.GetAncestor(1)
							  WHERE p.fldDaramadId IS NULL AND s.fldId=c.fldid) THEN N'1' ELSE '0' END AS LastNode
			 FROM Drd.tblCodhayeDaramd AS C inner join @temp as tem
			 on tem.fldidcodid=c.fldid
			 WHERE C.fldLevel<>0   AND C.fldId IN (SELECT id FROM @code))s
			 WHERE fldShomareHesabId LIKE @ShomareHesabId and    LastNode=1 and Mablagh<>0
			 

			 ELSE IF(@ShomareHesabId=0 AND @CodeDaramadId=0)
			 select  distinct* from (SELECT fldStrhid AS hidChilde,fldDaramadCode AS DaramdCodeChilde,(select fldCodeHesab from drd.tblParametrHesabdari where fldShomareHesabCodeDaramadId=(select fldId from drd.tblShomareHesabCodeDaramad as d where d.fldCodeDaramadId=c.fldId)) AS DaramdCodeChilde1,fldDaramadTitle AS DaramadTitleChilde,fldLevel AS lvlChilde,
			ISNULL((SELECT d.fldStrhid FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_hid,
			ISNULL((SELECT fldDaramadCode FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_DaramadCode,
			ISNULL((SELECT fldDaramadTitle FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_DaramadTitle,
			ISNULL((SELECT fldLevel FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_Level
				,sum(mablaghcodeDaramad) over (partition by tem.fldidcodid,tem.ShomareHId) /*ISNULL((SELECT SUM(mablaghcodeDaramad) FROM @temp WHERE Daramadcode=C.fldDaramadCode) ,ISNULL((SELECT SUM(mablaghcodeDaramad) FROM @temp AS t WHERE t.hid.ToString() LIKE c.fldStrhid+'%'),0))*/ AS Mablagh
				,0 AS [Count],'' fldtarikh
				,(SELECT  TOP(1)  fldShomareHesab FROM      
									  Com.tblShomareHesabeOmoomi WHERE tblShomareHesabeOmoomi.fldid=ShomareHId ) fldShomareHesab
				 , ShomareHId fldShomareHesabId	
				 			 ,CASE WHEN fldid IN (SELECT  s.fldId FROM     Drd.tblCodhayeDaramd AS s left JOIN
							  Drd.tblCodhayeDaramd AS p ON  s.fldDaramadId = p.fldDaramadId.GetAncestor(1)
							  WHERE p.fldDaramadId IS NULL AND s.fldId=c.fldid) THEN N'1' ELSE '0' END AS LastNode
			 FROM Drd.tblCodhayeDaramd AS C inner join @temp as tem
			 on tem.fldidCodid=c.fldid
			 WHERE C.fldLevel<>0) t
			 where  LastNode=1 and Mablagh<>0 
			 
			 ELSE IF(@ShomareHesabId=0 AND @CodeDaramadId<>0)
			select distinct * from(SELECT fldStrhid AS hidChilde,fldDaramadCode AS DaramdCodeChilde,(select fldCodeHesab from drd.tblParametrHesabdari where fldShomareHesabCodeDaramadId=(select fldId from drd.tblShomareHesabCodeDaramad as d where d.fldCodeDaramadId=c.fldId)) AS DaramdCodeChilde1,fldDaramadTitle AS DaramadTitleChilde,fldLevel AS lvlChilde,
			ISNULL((SELECT d.fldStrhid FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_hid,
			ISNULL((SELECT fldDaramadCode FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_DaramadCode,
			ISNULL((SELECT fldDaramadTitle FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_DaramadTitle,
			ISNULL((SELECT fldLevel FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_Level
				,sum(mablaghcodeDaramad) over (partition by tem.fldidcodid,tem.ShomareHId)/*ISNULL((SELECT SUM(mablaghcodeDaramad) FROM @temp WHERE Daramadcode=C.fldDaramadCode) ,ISNULL((SELECT SUM(mablaghcodeDaramad) FROM @temp AS t WHERE t.hid.ToString() LIKE c.fldStrhid+'%'),0))*/ AS Mablagh
				,0 AS [Count],'' fldtarikh
				,(SELECT  TOP(1)  fldShomareHesab FROM      
									  Com.tblShomareHesabeOmoomi WHERE tblShomareHesabeOmoomi.fldid=ShomareHId ) fldShomareHesab
				 , ShomareHId fldShomareHesabId	
				 			  ,CASE WHEN fldid IN (SELECT  s.fldId FROM     Drd.tblCodhayeDaramd AS s left JOIN
							  Drd.tblCodhayeDaramd AS p ON  s.fldDaramadId = p.fldDaramadId.GetAncestor(1)
							  WHERE p.fldDaramadId IS NULL AND s.fldId=c.fldid) THEN N'1' ELSE '0' END AS LastNode
			 FROM Drd.tblCodhayeDaramd AS C inner join @temp as tem
			 on tem.fldidCodid=c.fldid
			 WHERE C.fldLevel<>0   AND C.fldId IN (SELECT id FROM @code))t
			 where    LastNode=1 and Mablagh<>0

			 ELSE IF(@ShomareHesabId<>0 AND @CodeDaramadId=0)
			SELECT distinct * from(SELECT fldStrhid AS hidChilde,fldDaramadCode AS DaramdCodeChilde,(select fldCodeHesab from drd.tblParametrHesabdari where fldShomareHesabCodeDaramadId=(select fldId from drd.tblShomareHesabCodeDaramad as d where d.fldCodeDaramadId=c.fldId)) AS DaramdCodeChilde1,fldDaramadTitle AS DaramadTitleChilde,fldLevel AS lvlChilde,
			ISNULL((SELECT d.fldStrhid FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_hid,
			ISNULL((SELECT fldDaramadCode FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_DaramadCode,
			ISNULL((SELECT fldDaramadTitle FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_DaramadTitle,
			ISNULL((SELECT fldLevel FROM Drd.tblCodhayeDaramd AS d WHERE c.flddaramadId.GetAncestor(1)=d.fldDaramadId AND d.fldLevel<>0),'') AS P_Level
				,sum(mablaghcodeDaramad) over (partition by tem.fldidcodid,tem.ShomareHId)/*ISNULL((SELECT SUM(mablaghcodeDaramad) FROM @temp WHERE Daramadcode=C.fldDaramadCode) ,ISNULL((SELECT SUM(mablaghcodeDaramad) FROM @temp AS t WHERE t.hid.ToString() LIKE c.fldStrhid+'%'),0))*/ AS Mablagh
				,0 AS [Count],'' fldtarikh
				,(SELECT  TOP(1)  fldShomareHesab FROM      
									  Com.tblShomareHesabeOmoomi WHERE tblShomareHesabeOmoomi.fldid=ShomareHId ) fldShomareHesab
				 , ShomareHId fldShomareHesabId	
				 			  ,CASE WHEN fldid IN (SELECT  s.fldId FROM     Drd.tblCodhayeDaramd AS s left JOIN
							  Drd.tblCodhayeDaramd AS p ON  s.fldDaramadId = p.fldDaramadId.GetAncestor(1)
							  WHERE p.fldDaramadId IS NULL AND s.fldId=c.fldid) THEN N'1' ELSE '0' END AS LastNode
			 FROM Drd.tblCodhayeDaramd AS C inner join @temp as tem
			 on tem.fldidCodid=c.fldid
			 WHERE C.fldLevel<>0  and ShomareHId LIKE @ShomareHesabId  )t
			  WHERE    LastNode=1 and Mablagh<>0
			end  
end
GO
