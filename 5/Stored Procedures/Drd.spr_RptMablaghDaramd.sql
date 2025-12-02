SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_RptMablaghDaramd](@fieldname nvarchar(50),@value INt)
as
--declare @value INT=996,@fieldname nvarchar(50)='taghsit'
DECLARE @organId INT
declare @temp table (id int identity,fldID int ,fldDaramadCode nvarchar(50),fldMablaghDaramad bigint,fldSharheCodeDaramad nvarchar(max),Takhfif bigint)
if (@fieldname='Fish')
begin
SELECT @organId=fldOrganId FROM Drd.tblElamAvarez WHERE fldId IN (SELECT fldElamAvarezId FROM Drd.tblSodoorFish WHERE fldId=@value)
insert into @temp
 SELECT   tblCodhayeDaramadiElamAvarez.fldID ,  fldDaramadCode, 
                     --ISNULL(((tblCodhayeDaramadiElamAvarez.fldTakhfifAsliValue*fldTedad )), ((CAST(Drd.tblCodhayeDaramadiElamAvarez.fldAsliValue AS BIGINT)  * Drd.tblCodhayeDaramadiElamAvarez.fldTedad )))AS fldMablaghDaramad
					CAST(Drd.tblCodhayeDaramadiElamAvarez.fldSumAsli AS BIGINT) AS fldMablaghDaramad
					 , ISNULL((SELECT '*' FROM Drd.tblCodhayeDaramd AS a WHERE (fldMashmooleArzesheAfzoode=1 ) and  a.fldid=Drd.tblCodhayeDaramd.fldID),'')+Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad AS fldSharheCodeDaramad
				,isnull([Drd].[Fn_MablaghTakhfif_Sodoor]('MablaghTakhfif',fldElamAvarezId,tblCodhayeDaramadiElamAvarez.fldShomareHesabId,(select tblElamAvarez.fldOrganId from drd.tblElamAvarez where fldid= Drd.tblCodhayeDaramadiElamAvarez.fldElamAvarezId),tblShomareHesabCodeDaramad.fldShorooshenaseGhabz) ,CAST(0 AS bigint))
				
FROM         Drd.tblCodhayeDaramadiElamAvarez INNER JOIN
                      Drd.tblShomareHesabCodeDaramad ON 
                      Drd.tblCodhayeDaramadiElamAvarez.fldShomareHesabCodeDaramadId = Drd.tblShomareHesabCodeDaramad.fldId INNER JOIN
                      Drd.tblCodhayeDaramd ON Drd.tblShomareHesabCodeDaramad.fldCodeDaramadId = Drd.tblCodhayeDaramd.fldId
WHERE tblCodhayeDaramadiElamAvarez.fldID IN (SELECT fldCodeElamAvarezId FROM Drd.tblSodoorFish_Detail WHERE fldFishId=@value )
AND drd.tblShomareHesabCodeDaramad.fldOrganId IN (SELECT fldOrganId FROM Drd.tblElamAvarez WHERE fldid IN (SELECT fldElamAvarezId FROM Drd.tblSodoorFish WHERE fldId=@value))

INSERT into @temp
SELECT fldId,'',fldMablaghAvarezGerdShode,fldDesc,CAST(0 AS BIGINT) FROM Drd.tblSodoorFish
WHERE fldid=@value AND fldid NOT IN (SELECT fldFishId FROM Drd.tblSodoorFish_Detail )

IF EXISTS (SELECT * FROM Drd.tblTanzimateDaramad WHERE fldSumMaliyat_Avarez=1 AND fldOrganId=@organId)/*مالیات وعوارض باهم جمع شوند*/
begin
INSERT into @temp 
SELECT  TOP(1)  /*(SELECT fldMaliyatId FROM Drd.tblTanzimateDaramad WHERE fldOrganId=Drd.tblElamAvarez.fldOrganId)*/0,
/*(select c.fldCode from acc.tblCoding_Details c inner join drd.tblTanzimateDaramad t on t.fldMaliyatId=c.fldid where  t.fldOrganId=Drd.tblElamAvarez.fldOrganId)*/'_'/*jadid*/
--(SELECT fldDaramadCode FROM Drd.tblCodhayeDaramd WHERE fldId IN (SELECT fldCodeDaramadId FROM Drd.tblShomareHesabCodeDaramad WHERE fldid IN (SELECT fldMaliyatId FROM Drd.tblTanzimateDaramad WHERE fldOrganId=Drd.tblElamAvarez.fldOrganId ) ))
,
case when fldTakhfifMaliyatValue is null and fldTakhfifAvarezValue is null 
then  SUM((CAST(fldMaliyatValue+fldAvarezValue AS BIGINT) ))OVER(PARTITION BY tblCodhayeDaramadiElamAvarez.fldElamAvarezId) 
else SUM((CAST(isnull(fldTakhfifMaliyatValue,0)+isnull(fldTakhfifAvarezValue,0) AS BIGINT) ))OVER(PARTITION BY tblCodhayeDaramadiElamAvarez.fldElamAvarezId)  end fldMablagh

--SUM((CAST(fldMaliyatValue+fldAvarezValue AS BIGINT) ))OVER(PARTITION BY tblCodhayeDaramadiElamAvarez.fldElamAvarezId)   AS fldMablagh,
,(SELECT TOP(1)SUBSTRING(CAST(fldDarsadeMaliyat+fldDarsadeAvarez AS NVARCHAR(10)),1,LEN(fldDarsadeMaliyat+fldDarsadeAvarez)-3) FROM Com.tblMaliyatArzesheAfzoode WHERE (SELECT TOP(1) fldTarikh FROM Drd.tblSodoorFish WHERE fldId=@Value) BETWEEN fldFromDate AND fldEndDate ORDER BY fldFromDate DESC,fldEndDate DESC)+N'%'+N' مالیات'/*برا شاهرود  عنوان مالیات - عوارض است برای بقیه جاها باید مالیات باشد .*/
--,ISNULL(SUM((fldTakhfifMaliyatValue )) OVER(PARTITION BY tblCodhayeDaramadiElamAvarez.fldElamAvarezId),CAST(0 AS BIGINT))
,CAST(0 AS BIGINT)
FROM         Drd.tblCodhayeDaramadiElamAvarez INNER JOIN
                      Drd.tblElamAvarez ON Drd.tblCodhayeDaramadiElamAvarez.fldElamAvarezId = Drd.tblElamAvarez.fldId INNER JOIN
                      Drd.tblShomareHesabCodeDaramad ON 
                      Drd.tblCodhayeDaramadiElamAvarez.fldShomareHesabCodeDaramadId = Drd.tblShomareHesabCodeDaramad.fldId INNER JOIN
                      Drd.tblCodhayeDaramd ON Drd.tblShomareHesabCodeDaramad.fldCodeDaramadId = Drd.tblCodhayeDaramd.fldId
                      WHERE tblCodhayeDaramadiElamAvarez.fldID IN (SELECT fldCodeElamAvarezId FROM Drd.tblSodoorFish_Detail WHERE fldFishId=@value AND fldFishId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=@value))
AND drd.tblShomareHesabCodeDaramad.fldOrganId IN (SELECT fldOrganId FROM Drd.tblElamAvarez WHERE fldid IN (SELECT fldElamAvarezId FROM Drd.tblSodoorFish WHERE fldId=@value))
AND fldMashmooleArzesheAfzoode=1 --AND Drd.tblShomareHesabCodeDaramad.fldId IN (SELECT fldMaliyatId FROM Drd.tblTanzimateDaramad WHERE fldOrganId=Drd.tblElamAvarez.fldOrganId)
end
ELSE
BEGIN
INSERT into @temp 
SELECT  TOP(1)  /*(SELECT fldMaliyatId FROM Drd.tblTanzimateDaramad WHERE fldOrganId=Drd.tblElamAvarez.fldOrganId)*/0,
/*(select c.fldCode from acc.tblCoding_Details c inner join drd.tblTanzimateDaramad t on t.fldMaliyatId=c.fldid where  t.fldOrganId=Drd.tblElamAvarez.fldOrganId)*/'_'/*jadid*/
--(SELECT fldDaramadCode FROM Drd.tblCodhayeDaramd WHERE fldId IN (SELECT fldCodeDaramadId FROM Drd.tblShomareHesabCodeDaramad WHERE fldid IN (SELECT fldMaliyatId FROM Drd.tblTanzimateDaramad WHERE fldOrganId=Drd.tblElamAvarez.fldOrganId ) ))
,
SUM(isnull(fldtakhfifMaliyatValue ,fldMaliyatValue))OVER(PARTITION BY tblCodhayeDaramadiElamAvarez.fldElamAvarezId)   AS fldMaliyat,(SELECT TOP(1)SUBSTRING(CAST(fldDarsadeMaliyat AS NVARCHAR(10)),1,LEN(fldDarsadeMaliyat)-3) FROM Com.tblMaliyatArzesheAfzoode WHERE (SELECT TOP(1) fldTarikh FROM Drd.tblSodoorFish WHERE fldId=@Value) BETWEEN fldFromDate AND fldEndDate ORDER BY fldFromDate DESC,fldEndDate DESC)+N'%'+N'مالیات'
--,ISNULL(SUM((fldTakhfifMaliyatValue )) OVER(PARTITION BY tblCodhayeDaramadiElamAvarez.fldElamAvarezId),CAST(0 AS BIGINT))
,CAST(0 AS BIGINT)
FROM         Drd.tblCodhayeDaramadiElamAvarez INNER JOIN
                      Drd.tblElamAvarez ON Drd.tblCodhayeDaramadiElamAvarez.fldElamAvarezId = Drd.tblElamAvarez.fldId INNER JOIN
                      Drd.tblShomareHesabCodeDaramad ON 
                      Drd.tblCodhayeDaramadiElamAvarez.fldShomareHesabCodeDaramadId = Drd.tblShomareHesabCodeDaramad.fldId INNER JOIN
                      Drd.tblCodhayeDaramd ON Drd.tblShomareHesabCodeDaramad.fldCodeDaramadId = Drd.tblCodhayeDaramd.fldId
                      WHERE tblCodhayeDaramadiElamAvarez.fldID IN (SELECT fldCodeElamAvarezId FROM Drd.tblSodoorFish_Detail WHERE fldFishId=@value AND fldFishId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=@value))
AND drd.tblShomareHesabCodeDaramad.fldOrganId IN (SELECT fldOrganId FROM Drd.tblElamAvarez WHERE fldid IN (SELECT fldElamAvarezId FROM Drd.tblSodoorFish WHERE fldId=@value))
AND fldMashmooleArzesheAfzoode=1 --AND Drd.tblShomareHesabCodeDaramad.fldId IN (SELECT fldMaliyatId FROM Drd.tblTanzimateDaramad WHERE fldOrganId=Drd.tblElamAvarez.fldOrganId)



insert into @temp 
SELECT TOP(1) /*(SELECT fldAvarezId FROM Drd.tblTanzimateDaramad WHERE fldOrganId=Drd.tblElamAvarez.fldOrganId)*/0,
/*(select c.fldCode from acc.tblCoding_Details c inner join drd.tblTanzimateDaramad t on t.fldAvarezId=c.fldid where  t.fldOrganId=Drd.tblElamAvarez.fldOrganId)*/'_'/*jadid*/
--(SELECT fldDaramadCode FROM Drd.tblCodhayeDaramd WHERE fldId IN (SELECT fldCodeDaramadId FROM Drd.tblShomareHesabCodeDaramad WHERE fldid IN (SELECT fldAvarezId FROM Drd.tblTanzimateDaramad WHERE fldOrganId=Drd.tblElamAvarez.fldOrganId ) ))

,SUM(isnull(fldtakhfifAvarezValue,fldAvarezValue )) OVER(PARTITION BY tblCodhayeDaramadiElamAvarez.fldElamAvarezId)  AS fldAvarez,(SELECT TOP(1)SUBSTRING(CAST(fldDarsadeAvarez AS NVARCHAR(10)),1,LEN(fldDarsadeMaliyat)-3) FROM Com.tblMaliyatArzesheAfzoode WHERE (SELECT TOP(1) fldTarikh FROM Drd.tblSodoorFish WHERE fldId=@value) BETWEEN fldFromDate AND fldEndDate ORDER BY fldFromDate DESC,fldEndDate DESC)+N'%'+N'عوارض'
--,ISNULL(SUM((fldTakhfifAvarezValue ))OVER(PARTITION BY tblCodhayeDaramadiElamAvarez.fldElamAvarezId),CAST(0 AS BIGINT) )
,CAST(0 AS BIGINT)
FROM         Drd.tblCodhayeDaramadiElamAvarez INNER JOIN
                      Drd.tblElamAvarez ON Drd.tblCodhayeDaramadiElamAvarez.fldElamAvarezId = Drd.tblElamAvarez.fldId INNER JOIN
                      Drd.tblShomareHesabCodeDaramad ON 
                      Drd.tblCodhayeDaramadiElamAvarez.fldShomareHesabCodeDaramadId = Drd.tblShomareHesabCodeDaramad.fldId INNER JOIN
                      Drd.tblCodhayeDaramd ON Drd.tblShomareHesabCodeDaramad.fldCodeDaramadId = Drd.tblCodhayeDaramd.fldId
                      WHERE tblCodhayeDaramadiElamAvarez.fldID IN (SELECT fldCodeElamAvarezId FROM Drd.tblSodoorFish_Detail WHERE fldFishId=@value AND fldFishId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=@value))
AND drd.tblShomareHesabCodeDaramad.fldOrganId IN (SELECT fldOrganId FROM Drd.tblElamAvarez WHERE fldid IN (SELECT fldElamAvarezId FROM Drd.tblSodoorFish WHERE fldId=@value))
AND fldMashmooleArzesheAfzoode=1

END


INSERT into @temp 
SELECT  TOP(1)  /*(SELECT fldMaliyatId FROM Drd.tblTanzimateDaramad WHERE fldOrganId=Drd.tblElamAvarez.fldOrganId)*/0,
/*(select c.fldCode from acc.tblCoding_Details c inner join drd.tblTanzimateDaramad t on t.fldMaliyatId=c.fldid where  t.fldOrganId=Drd.tblElamAvarez.fldOrganId)*/'_'/*jadid*/
--(SELECT fldDaramadCode FROM Drd.tblCodhayeDaramd WHERE fldId IN (SELECT fldCodeDaramadId FROM Drd.tblShomareHesabCodeDaramad WHERE fldid IN (SELECT fldMaliyatId FROM Drd.tblTanzimateDaramad WHERE fldOrganId=Drd.tblElamAvarez.fldOrganId ) ))
,
SUM(isnull(fldTakhfifAmuzeshParvareshValue ,fldAmuzeshParvareshValue))OVER(PARTITION BY tblCodhayeDaramadiElamAvarez.fldElamAvarezId)   AS fldMaliyat,(SELECT TOP(1)SUBSTRING(CAST(fldDarsadAmuzeshParvaresh AS NVARCHAR(10)),1,LEN(fldDarsadAmuzeshParvaresh)-3) FROM Com.tblMaliyatArzesheAfzoode WHERE (SELECT TOP(1) fldTarikh FROM Drd.tblSodoorFish WHERE fldId=@Value) BETWEEN fldFromDate AND fldEndDate ORDER BY fldFromDate DESC,fldEndDate DESC)+N'%'+N'آموزش و پرورش'
--,ISNULL(SUM((fldTakhfifMaliyatValue )) OVER(PARTITION BY tblCodhayeDaramadiElamAvarez.fldElamAvarezId),CAST(0 AS BIGINT))
,CAST(0 AS BIGINT)
FROM         Drd.tblCodhayeDaramadiElamAvarez INNER JOIN
                      Drd.tblElamAvarez ON Drd.tblCodhayeDaramadiElamAvarez.fldElamAvarezId = Drd.tblElamAvarez.fldId INNER JOIN
                      Drd.tblShomareHesabCodeDaramad ON 
                      Drd.tblCodhayeDaramadiElamAvarez.fldShomareHesabCodeDaramadId = Drd.tblShomareHesabCodeDaramad.fldId INNER JOIN
                      Drd.tblCodhayeDaramd ON Drd.tblShomareHesabCodeDaramad.fldCodeDaramadId = Drd.tblCodhayeDaramd.fldId
                      WHERE tblCodhayeDaramadiElamAvarez.fldID IN (SELECT fldCodeElamAvarezId FROM Drd.tblSodoorFish_Detail WHERE fldFishId=@value AND fldFishId NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=@value))
AND drd.tblShomareHesabCodeDaramad.fldOrganId IN (SELECT fldOrganId FROM Drd.tblElamAvarez WHERE fldid IN (SELECT fldElamAvarezId FROM Drd.tblSodoorFish WHERE fldId=@value))
AND fldAmuzeshParvaresh=1 

/*DECLARE @t bigint
SELECT top(1) @t=takhfif FROM @temp
IF(@t<>0)
BEGIN
INSERT INTO  @temp
        ( fldID ,fldDaramadCode ,fldMablaghDaramad ,fldSharheCodeDaramad ,Takhfif)
SELECT 0,'',CAST(max(Takhfif) AS BIGINT)*(-1), N'مشمول تخفیف',0 FROM @temp
select fldID  ,fldDaramadCode ,fldMablaghDaramad ,fldSharheCodeDaramad  from @temp
order by id  --AND Drd.tblShomareHesabCodeDaramad.fldId IN (SELECT fldAvarezId FROM Drd.tblTanzimateDaramad WHERE fldOrganId=Drd.tblElamAvarez.fldOrganId)
END
ELSE*/
select fldID  ,fldDaramadCode ,fldMablaghDaramad ,fldSharheCodeDaramad  from @temp
order by id


end
if (@fieldname='Taghsit')
begin 
SELECT @organId=fldOrganId FROM Drd.tblElamAvarez WHERE fldId =@value
insert into @temp
 SELECT   tblCodhayeDaramadiElamAvarez.fldID ,  fldDaramadCode, 
                     --ISNULL(((tblCodhayeDaramadiElamAvarez.fldTakhfifAsliValue*fldTedad )), ((CAST(Drd.tblCodhayeDaramadiElamAvarez.fldAsliValue AS BIGINT)  * Drd.tblCodhayeDaramadiElamAvarez.fldTedad )))AS fldMablaghDaramad
					CAST(Drd.tblCodhayeDaramadiElamAvarez.fldSumAsli AS BIGINT) AS fldMablaghDaramad
					 , ISNULL((SELECT '*' FROM Drd.tblCodhayeDaramd AS a WHERE (fldMashmooleArzesheAfzoode=1 ) and  a.fldid=Drd.tblCodhayeDaramd.fldID),'')+Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad AS fldSharheCodeDaramad
				,CAST(0 AS bigint)
				
FROM         Drd.tblCodhayeDaramadiElamAvarez INNER JOIN
                      Drd.tblShomareHesabCodeDaramad ON 
                      Drd.tblCodhayeDaramadiElamAvarez.fldShomareHesabCodeDaramadId = Drd.tblShomareHesabCodeDaramad.fldId INNER JOIN
                      Drd.tblCodhayeDaramd ON Drd.tblShomareHesabCodeDaramad.fldCodeDaramadId = Drd.tblCodhayeDaramd.fldId
WHERE  fldElamAvarezId=@value and tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad<>N'کارمزد تقسیط'
AND drd.tblShomareHesabCodeDaramad.fldOrganId IN (SELECT fldOrganId FROM Drd.tblElamAvarez WHERE fldid =@value)



IF EXISTS (SELECT * FROM Drd.tblTanzimateDaramad WHERE fldSumMaliyat_Avarez=1 AND fldOrganId=@organId)/*مالیات وعوارض باهم جمع شوند*/
begin
INSERT into @temp 
SELECT  TOP(1)  /*(SELECT fldMaliyatId FROM Drd.tblTanzimateDaramad WHERE fldOrganId=Drd.tblElamAvarez.fldOrganId)*/0,
/*(select c.fldCode from acc.tblCoding_Details c inner join drd.tblTanzimateDaramad t on t.fldMaliyatId=c.fldid where  t.fldOrganId=Drd.tblElamAvarez.fldOrganId)*/'_'/*jadid*/
--(SELECT fldDaramadCode FROM Drd.tblCodhayeDaramd WHERE fldId IN (SELECT fldCodeDaramadId FROM Drd.tblShomareHesabCodeDaramad WHERE fldid IN (SELECT fldMaliyatId FROM Drd.tblTanzimateDaramad WHERE fldOrganId=Drd.tblElamAvarez.fldOrganId ) ))
,
case when fldTakhfifMaliyatValue is null and fldTakhfifAvarezValue is null 
then  SUM((CAST(fldMaliyatValue+fldAvarezValue AS BIGINT) ))OVER(PARTITION BY tblCodhayeDaramadiElamAvarez.fldElamAvarezId) 
else SUM((CAST(isnull(fldTakhfifMaliyatValue,0)+isnull(fldTakhfifAvarezValue,0) AS BIGINT) ))OVER(PARTITION BY tblCodhayeDaramadiElamAvarez.fldElamAvarezId)  end fldMablagh

--SUM((CAST(fldMaliyatValue+fldAvarezValue AS BIGINT) ))OVER(PARTITION BY tblCodhayeDaramadiElamAvarez.fldElamAvarezId)   AS fldMablagh,
,(SELECT TOP(1)SUBSTRING(CAST(fldDarsadeMaliyat+fldDarsadeAvarez AS NVARCHAR(10)),1,LEN(fldDarsadeMaliyat+fldDarsadeAvarez)-3) FROM Com.tblMaliyatArzesheAfzoode WHERE (SELECT TOP(1) fldTarikh FROM Drd.tblElamAvarez WHERE fldId=@Value) BETWEEN fldFromDate AND fldEndDate ORDER BY fldFromDate DESC,fldEndDate DESC)+N'%'+N' مالیات'/*برا شاهرود  عنوان مالیات - عوارض است برای بقیه جاها باید مالیات باشد .*/
--,ISNULL(SUM((fldTakhfifMaliyatValue )) OVER(PARTITION BY tblCodhayeDaramadiElamAvarez.fldElamAvarezId),CAST(0 AS BIGINT))
,CAST(0 AS BIGINT)
FROM         Drd.tblCodhayeDaramadiElamAvarez INNER JOIN
                      Drd.tblElamAvarez ON Drd.tblCodhayeDaramadiElamAvarez.fldElamAvarezId = Drd.tblElamAvarez.fldId INNER JOIN
                      Drd.tblShomareHesabCodeDaramad ON 
                      Drd.tblCodhayeDaramadiElamAvarez.fldShomareHesabCodeDaramadId = Drd.tblShomareHesabCodeDaramad.fldId INNER JOIN
                      Drd.tblCodhayeDaramd ON Drd.tblShomareHesabCodeDaramad.fldCodeDaramadId = Drd.tblCodhayeDaramd.fldId
                      WHERE fldElamAvarezId=@value
AND drd.tblShomareHesabCodeDaramad.fldOrganId IN (SELECT fldOrganId FROM Drd.tblElamAvarez WHERE fldid =@value)
AND fldMashmooleArzesheAfzoode=1 --AND Drd.tblShomareHesabCodeDaramad.fldId IN (SELECT fldMaliyatId FROM Drd.tblTanzimateDaramad WHERE fldOrganId=Drd.tblElamAvarez.fldOrganId)
end
ELSE
BEGIN
INSERT into @temp 
SELECT  TOP(1)  /*(SELECT fldMaliyatId FROM Drd.tblTanzimateDaramad WHERE fldOrganId=Drd.tblElamAvarez.fldOrganId)*/0,
/*(select c.fldCode from acc.tblCoding_Details c inner join drd.tblTanzimateDaramad t on t.fldMaliyatId=c.fldid where  t.fldOrganId=Drd.tblElamAvarez.fldOrganId)*/'_'/*jadid*/
--(SELECT fldDaramadCode FROM Drd.tblCodhayeDaramd WHERE fldId IN (SELECT fldCodeDaramadId FROM Drd.tblShomareHesabCodeDaramad WHERE fldid IN (SELECT fldMaliyatId FROM Drd.tblTanzimateDaramad WHERE fldOrganId=Drd.tblElamAvarez.fldOrganId ) ))
,
SUM(isnull(fldtakhfifMaliyatValue ,fldMaliyatValue))OVER(PARTITION BY tblCodhayeDaramadiElamAvarez.fldElamAvarezId)   AS fldMaliyat,(SELECT TOP(1)SUBSTRING(CAST(fldDarsadeMaliyat AS NVARCHAR(10)),1,LEN(fldDarsadeMaliyat)-3) FROM Com.tblMaliyatArzesheAfzoode WHERE (SELECT TOP(1) fldTarikh FROM  Drd.tblElamAvarez WHERE fldId=@Value) BETWEEN fldFromDate AND fldEndDate ORDER BY fldFromDate DESC,fldEndDate DESC)+N'%'+N'مالیات'
--,ISNULL(SUM((fldTakhfifMaliyatValue )) OVER(PARTITION BY tblCodhayeDaramadiElamAvarez.fldElamAvarezId),CAST(0 AS BIGINT))
,CAST(0 AS BIGINT)
FROM         Drd.tblCodhayeDaramadiElamAvarez INNER JOIN
                      Drd.tblElamAvarez ON Drd.tblCodhayeDaramadiElamAvarez.fldElamAvarezId = Drd.tblElamAvarez.fldId INNER JOIN
                      Drd.tblShomareHesabCodeDaramad ON 
                      Drd.tblCodhayeDaramadiElamAvarez.fldShomareHesabCodeDaramadId = Drd.tblShomareHesabCodeDaramad.fldId INNER JOIN
                      Drd.tblCodhayeDaramd ON Drd.tblShomareHesabCodeDaramad.fldCodeDaramadId = Drd.tblCodhayeDaramd.fldId
                      WHERE fldElamAvarezId=@value and   drd.tblShomareHesabCodeDaramad.fldOrganId IN (SELECT fldOrganId FROM Drd.tblElamAvarez WHERE fldid =@value)
AND fldMashmooleArzesheAfzoode=1 --AND Drd.tblShomareHesabCodeDaramad.fldId IN (SELECT fldMaliyatId FROM Drd.tblTanzimateDaramad WHERE fldOrganId=Drd.tblElamAvarez.fldOrganId)



insert into @temp 
SELECT TOP(1) /*(SELECT fldAvarezId FROM Drd.tblTanzimateDaramad WHERE fldOrganId=Drd.tblElamAvarez.fldOrganId)*/0,
/*(select c.fldCode from acc.tblCoding_Details c inner join drd.tblTanzimateDaramad t on t.fldAvarezId=c.fldid where  t.fldOrganId=Drd.tblElamAvarez.fldOrganId)*/'_'/*jadid*/
--(SELECT fldDaramadCode FROM Drd.tblCodhayeDaramd WHERE fldId IN (SELECT fldCodeDaramadId FROM Drd.tblShomareHesabCodeDaramad WHERE fldid IN (SELECT fldAvarezId FROM Drd.tblTanzimateDaramad WHERE fldOrganId=Drd.tblElamAvarez.fldOrganId ) ))

,SUM(isnull(fldtakhfifAvarezValue,fldAvarezValue )) OVER(PARTITION BY tblCodhayeDaramadiElamAvarez.fldElamAvarezId)  AS fldAvarez,(SELECT TOP(1)SUBSTRING(CAST(fldDarsadeAvarez AS NVARCHAR(10)),1,LEN(fldDarsadeMaliyat)-3) FROM Com.tblMaliyatArzesheAfzoode WHERE (SELECT TOP(1) fldTarikh FROM  Drd.tblElamAvarez WHERE fldId=@value) BETWEEN fldFromDate AND fldEndDate ORDER BY fldFromDate DESC,fldEndDate DESC)+N'%'+N'عوارض'
--,ISNULL(SUM((fldTakhfifAvarezValue ))OVER(PARTITION BY tblCodhayeDaramadiElamAvarez.fldElamAvarezId),CAST(0 AS BIGINT) )
,CAST(0 AS BIGINT)
FROM         Drd.tblCodhayeDaramadiElamAvarez INNER JOIN
                      Drd.tblElamAvarez ON Drd.tblCodhayeDaramadiElamAvarez.fldElamAvarezId = Drd.tblElamAvarez.fldId INNER JOIN
                      Drd.tblShomareHesabCodeDaramad ON 
                      Drd.tblCodhayeDaramadiElamAvarez.fldShomareHesabCodeDaramadId = Drd.tblShomareHesabCodeDaramad.fldId INNER JOIN
                      Drd.tblCodhayeDaramd ON Drd.tblShomareHesabCodeDaramad.fldCodeDaramadId = Drd.tblCodhayeDaramd.fldId
                      WHERE fldElamAvarezId=@value  AND drd.tblShomareHesabCodeDaramad.fldOrganId IN (SELECT fldOrganId FROM Drd.tblElamAvarez WHERE fldid =@value)
AND fldMashmooleArzesheAfzoode=1

END




select fldID  ,fldDaramadCode ,fldMablaghDaramad ,fldSharheCodeDaramad  from @temp
order by id
end 
GO
