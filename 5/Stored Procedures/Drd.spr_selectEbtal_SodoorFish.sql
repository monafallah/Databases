SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_selectEbtal_SodoorFish](@IdAvarez int)
as
--SELECT 0 AS fldId ,0 AS fldElamAvarezId,0 AS fldShomareHesabId ,'' AS fldShomareHesab,0 AS fldItem,100000000 AS fldMaliyat ,
--120000000 AS fldAvarez,15487200000 AS fldJamKol,14524020 AS fldJamFish,'' AS fldShenaseGhabz,'' AS fldShenasePardakht,CAST(10 AS TINYINT) AS fldShorooShenaseGhabz
--,CAST(0 AS bit) AS fldStatus
--DECLARE @IdAvarez INT=62
DECLARE @fldIsExternal bit
SELECT @fldIsExternal=fldIsExternal FROM Drd.tblElamAvarez WHERE fldId=@IdAvarez
IF (@fldIsExternal=1)

 SELECT fldId,ISNULL(fldElamAvarezId,0)fldElamAvarezId,fldShomareHesabId,fldShomareHesab,fldItem,fldMaliyat,fldAvarez,fldAsliValue,fldAmuzeshParvareshValue
 ,/*ISNULL(CAST((drd.Fn_MablaghTakhfif_Sodoor('mablaghkol',@IdAvarez,fldShomareHesabId,fldOrganId,fldShorooshenaseGhabz)) AS BIGINT),0 )*/cast(isnull(fldJamKol,0)as bigint) AS fldjamkol,
 /*ISNULL((CASE WHEN GerdKardan<>0 THEN ((drd.Fn_MablaghTakhfif_Sodoor('mablaghkol',@IdAvarez,fldShomareHesabId,fldOrganId,fldShorooshenaseGhabz)/GerdKardan)*GerdKardan) END),ISNULL(CAST(drd.Fn_MablaghTakhfif_Sodoor('mablaghkol',@IdAvarez,fldShomareHesabId,fldOrganId,fldShorooshenaseGhabz) AS BIGINT),0) )*/ cast(isnull(CASE WHEN GerdKardan<>0 THEN fldJamKol/GerdKardan*GerdKardan else fldJamKol end,0)as bigint)AS fldJamFish
,fldShenaseGhabz,fldShenasePardakht,fldShorooshenaseGhabz,fldStatus,fldOrganId, ISNULL(CAST(drd.Fn_MablaghTakhfif_Sodoor('mablaghTakhfif',@IdAvarez,fldShomareHesabId,fldOrganId,fldShorooshenaseGhabz)AS BIGINT),0)fldMablaghTakhfif
  ,PardakhtStatus
   FROM(
SELECT  
  ISNULL((SELECT TOP(1) CASE WHEN EXISTS (SELECT * FROM Drd.tblEbtal WHERE fldFishId=Drd.tblSodoorFish.fldId) THEN 0 ELSE fldId end FROM Drd.tblSodoorFish 
	WHERE  fldElamAvarezId=@IdAvarez 
	ORDER BY fldId desc),0) AS fldId,@IdAvarez AS fldElamAvarezId,tblCodhayeDaramadiElamAvarez.fldShomareHesabId AS fldShomareHesabId,fldShomareHesab AS fldShomareHesab,ISNULL(COUNT(tblShomareHesabCodeDaramad.fldShomareHesadId),0) AS  fldItem
	,ISNULL(SUM(fldTakhfifMaliyatValue),SUM(fldMaliyatValue)) AS fldMaliyat,ISNULL(SUM(fldTakhfifAvarezValue),sum(fldAvarezValue)) AS fldAvarez,ISNULL(SUM(fldTakhfifAmuzeshParvareshValue),sum(fldAmuzeshParvareshValue)) AS fldAmuzeshParvareshValue,ISNULL(SUM(fldSumAsli),0 ) AS fldAsliValue, ISNULL(CAST(SUM((fldSumAsli+fldtakhfifMaliyatValue+fldtakhfifAvarezValue+fldTakhfifAmuzeshParvareshValue))AS bigINT),CAST(SUM((fldSumAsli+fldMaliyatValue+fldAvarezValue+fldAmuzeshParvareshValue))AS bigINT)) AS fldJamKol,
	--ISNULL(((SUM(((fldAsliValue*fldTedad)+fldMaliyatValue+fldAvarezValue))/(SELECT CASE WHEN fldChapShenaseGhabz_Pardakht=1 THEN 1000 ELSE fldMablaghGerdKardan end FROM Drd.tblTanzimateDaramad WHERE fldOrganId=Drd.tblElamAvarez.fldOrganId AND fldMablaghGerdKardan<>0))*(SELECT  CASE WHEN fldChapShenaseGhabz_Pardakht=1 THEN 1000 ELSE fldMablaghGerdKardan end  FROM Drd.tblTanzimateDaramad WHERE fldOrganId=Drd.tblElamAvarez.fldOrganId AND fldMablaghGerdKardan<>0)),CAST(SUM(((fldAsliValue*fldTedad)+fldMaliyatValue+fldAvarezValue))AS INT)) AS fldJamFish
	ISNULL((SELECT CASE WHEN fldChapShenaseGhabz_Pardakht=1 THEN 1000 ELSE fldMablaghGerdKardan end FROM Drd.tblTanzimateDaramad WHERE fldOrganId=Drd.tblElamAvarez.fldOrganId AND fldMablaghGerdKardan<>0),0) AS GerdKardan,
	ISNULL((SELECT TOP(1) CASE WHEN EXISTS (SELECT * FROM Drd.tblEbtal WHERE fldFishId=Drd.tblSodoorFish.fldId) THEN '' ELSE fldShenaseGhabz end FROM Drd.tblSodoorFish 
	WHERE fldShomareHesabId=tblCodhayeDaramadiElamAvarez.fldShomareHesabId AND fldShorooShenaseGhabz=Drd.tblShomareHesabCodeDaramad.fldShorooshenaseGhabz AND fldElamAvarezId=@IdAvarez 
	ORDER BY fldId desc),'') AS fldShenaseGhabz,ISNULL((SELECT TOP(1) CASE WHEN EXISTS (SELECT * FROM Drd.tblEbtal WHERE fldFishId=Drd.tblSodoorFish.fldId) THEN '' ELSE fldShenasePardakht end FROM Drd.tblSodoorFish 
	WHERE fldShomareHesabId=tblCodhayeDaramadiElamAvarez.fldShomareHesabId AND fldShorooShenaseGhabz=Drd.tblShomareHesabCodeDaramad.fldShorooshenaseGhabz AND fldElamAvarezId=@IdAvarez 
	ORDER BY fldId desc),'')  AS fldShenasePardakht,ISNULL(fldShorooshenaseGhabz,0)fldShorooshenaseGhabz,
	(SELECT TOP(1) CASE WHEN EXISTS (SELECT * FROM Drd.tblEbtal WHERE fldFishId=Drd.tblSodoorFish.fldId) THEN N'1' 
	WHEN EXISTS (SELECT * FROM Drd.tblSodoorFish WHERE fldElamAvarezId=@IdAvarez) THEN N'2'
	 end FROM Drd.tblSodoorFish 
	WHERE fldElamAvarezId=@IdAvarez
	ORDER BY fldId desc) fldStatus,Drd.tblElamAvarez.fldOrganId
	,CASE WHEN EXISTS (SELECT * FROM Drd.tblSodoorFish WHERE fldElamAvarezId=@IdAvarez AND tblSodoorFish.fldId IN (SELECT fldFishId FROM Drd.tblPardakhtFish WHERE fldFishId=tblSodoorFish.fldId ))
	THEN '1' ELSE '0' END AS PardakhtStatus
FROM         Drd.tblElamAvarez INNER JOIN
                      Drd.tblCodhayeDaramadiElamAvarez ON Drd.tblElamAvarez.fldId = Drd.tblCodhayeDaramadiElamAvarez.fldElamAvarezId INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblCodhayeDaramadiElamAvarez.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Drd.tblShomareHesabCodeDaramad INNER JOIN
                      Drd.tblCodhayeDaramd ON Drd.tblShomareHesabCodeDaramad.fldCodeDaramadId = Drd.tblCodhayeDaramd.fldId ON 
                      Drd.tblCodhayeDaramadiElamAvarez.fldShomareHesabCodeDaramadId = Drd.tblShomareHesabCodeDaramad.fldId
                      WHERE fldElamAvarezId=@IdAvarez AND Drd.tblShomareHesabCodeDaramad.fldOrganId IN (SELECT fldOrganId FROM Drd.tblElamAvarez WHERE fldId=@IdAvarez)
                     GROUP BY tblCodhayeDaramadiElamAvarez.fldShomareHesabId,fldShorooshenaseGhabz,tblElamAvarez.fldOrganId,fldShomareHesab
                     )t

ELSE
SELECT fldId,ISNULL(fldElamAvarezId,0)fldElamAvarezId,fldShomareHesabId,fldShomareHesab,fldItem,fldMaliyat,fldAvarez,fldAsliValue,fldAmuzeshParvareshValue
 ,/*ISNULL(CAST((drd.Fn_MablaghTakhfif_Sodoor('mablaghkol',@IdAvarez,fldShomareHesabId,fldOrganId,fldShorooshenaseGhabz)) AS BIGINT),0 ) */cast(isnull(fldJamKol,0)as bigint) AS fldjamkol,
 /*ISNULL((CASE WHEN GerdKardan<>0 THEN ((drd.Fn_MablaghTakhfif_Sodoor('mablaghkol',@IdAvarez,fldShomareHesabId,fldOrganId,fldShorooshenaseGhabz)/GerdKardan)*GerdKardan) END),ISNULL(CAST(drd.Fn_MablaghTakhfif_Sodoor('mablaghkol',@IdAvarez,fldShomareHesabId,fldOrganId,fldShorooshenaseGhabz) AS BIGINT),0) )*/cast(isnull(CASE WHEN GerdKardan<>0 THEN fldJamKol/GerdKardan*GerdKardan else fldJamKol end,0)as bigint)AS fldJamFish
,fldShenaseGhabz,fldShenasePardakht,fldShorooshenaseGhabz,fldStatus,fldOrganId, ISNULL(CAST(drd.Fn_MablaghTakhfif_Sodoor('mablaghTakhfif',@IdAvarez,fldShomareHesabId,fldOrganId,fldShorooshenaseGhabz)AS BIGINT),0)fldMablaghTakhfif
 ,PardakhtStatus
   FROM(
SELECT  
  ISNULL((SELECT TOP(1) CASE WHEN EXISTS (SELECT * FROM Drd.tblEbtal WHERE fldFishId=Drd.tblSodoorFish.fldId) THEN 0 ELSE fldId end FROM Drd.tblSodoorFish 
	WHERE fldShomareHesabId=tblCodhayeDaramadiElamAvarez.fldShomareHesabId AND fldShorooShenaseGhabz=Drd.tblShomareHesabCodeDaramad.fldShorooshenaseGhabz AND fldElamAvarezId=@IdAvarez 
	ORDER BY fldId desc),0) AS fldId,@IdAvarez AS fldElamAvarezId,tblCodhayeDaramadiElamAvarez.fldShomareHesabId AS fldShomareHesabId,fldShomareHesab AS fldShomareHesab,ISNULL(COUNT(tblShomareHesabCodeDaramad.fldShomareHesadId),0) AS  fldItem
	,ISNULL(SUM(fldtakhfifMaliyatValue),SUM(fldMaliyatValue)) AS fldMaliyat,ISNULL(SUM(fldtakhfifAvarezValue),SUM(fldAvarezValue)) AS fldAvarez,ISNULL(SUM(fldTakhfifAmuzeshParvareshValue),SUM(fldAmuzeshParvareshValue)) AS fldAmuzeshParvareshValue,ISNULL(SUM(fldSumAsli),0 ) AS fldAsliValue, ISNULL(CAST(SUM((fldSumAsli+fldtakhfifMaliyatValue+fldtakhfifAvarezValue+fldTakhfifAmuzeshParvareshValue))AS bigINT),CAST(SUM((fldSumAsli+fldMaliyatValue+fldAvarezValue+fldAmuzeshParvareshValue))AS bigINT)) AS fldJamKol,
	--ISNULL(((SUM(((fldAsliValue*fldTedad)+fldMaliyatValue+fldAvarezValue))/(SELECT CASE WHEN fldChapShenaseGhabz_Pardakht=1 THEN 1000 ELSE fldMablaghGerdKardan end FROM Drd.tblTanzimateDaramad WHERE fldOrganId=Drd.tblElamAvarez.fldOrganId AND fldMablaghGerdKardan<>0))*(SELECT  CASE WHEN fldChapShenaseGhabz_Pardakht=1 THEN 1000 ELSE fldMablaghGerdKardan end  FROM Drd.tblTanzimateDaramad WHERE fldOrganId=Drd.tblElamAvarez.fldOrganId AND fldMablaghGerdKardan<>0)),CAST(SUM(((fldAsliValue*fldTedad)+fldMaliyatValue+fldAvarezValue))AS INT)) AS fldJamFish
	ISNULL((SELECT CASE WHEN fldChapShenaseGhabz_Pardakht=1 THEN 1000 ELSE fldMablaghGerdKardan end FROM Drd.tblTanzimateDaramad WHERE fldOrganId=Drd.tblElamAvarez.fldOrganId AND fldMablaghGerdKardan<>0),0) AS GerdKardan,
	ISNULL((SELECT TOP(1) CASE WHEN EXISTS (SELECT * FROM Drd.tblEbtal WHERE fldFishId=Drd.tblSodoorFish.fldId) THEN '' ELSE fldShenaseGhabz end FROM Drd.tblSodoorFish 
	WHERE fldShomareHesabId=tblCodhayeDaramadiElamAvarez.fldShomareHesabId AND fldShorooShenaseGhabz=Drd.tblShomareHesabCodeDaramad.fldShorooshenaseGhabz AND fldElamAvarezId=@IdAvarez 
	ORDER BY fldId desc),'') AS fldShenaseGhabz,ISNULL((SELECT TOP(1) CASE WHEN EXISTS (SELECT * FROM Drd.tblEbtal WHERE fldFishId=Drd.tblSodoorFish.fldId) THEN '' ELSE fldShenasePardakht end FROM Drd.tblSodoorFish 
	WHERE fldShomareHesabId=tblCodhayeDaramadiElamAvarez.fldShomareHesabId AND fldShorooShenaseGhabz=Drd.tblShomareHesabCodeDaramad.fldShorooshenaseGhabz AND fldElamAvarezId=@IdAvarez 
	ORDER BY fldId desc),'')  AS fldShenasePardakht,ISNULL(fldShorooshenaseGhabz,0)fldShorooshenaseGhabz,
	ISNULL((SELECT TOP(1) CASE WHEN EXISTS (SELECT * FROM Drd.tblEbtal WHERE fldFishId=Drd.tblSodoorFish.fldId) THEN N'1' 
	WHEN EXISTS (SELECT * FROM Drd.tblSodoorFish WHERE fldShomareHesabId=tblCodhayeDaramadiElamAvarez.fldShomareHesabId AND fldShorooShenaseGhabz=Drd.tblShomareHesabCodeDaramad.fldShorooshenaseGhabz AND fldElamAvarezId=@IdAvarez) THEN N'2'
	 end FROM Drd.tblSodoorFish 
	WHERE fldShomareHesabId=tblCodhayeDaramadiElamAvarez.fldShomareHesabId AND tblSodoorFish.fldShorooShenaseGhabz=Drd.tblShomareHesabCodeDaramad.fldShorooshenaseGhabz AND fldElamAvarezId=@IdAvarez
	ORDER BY fldId desc),'3')fldStatus,Drd.tblElamAvarez.fldOrganId
	,CASE WHEN EXISTS (SELECT * FROM Drd.tblSodoorFish WHERE fldElamAvarezId=@IdAvarez AND tblSodoorFish.fldId IN (SELECT fldFishId FROM Drd.tblPardakhtFish WHERE fldFishId=tblSodoorFish.fldId ))
	THEN '1' ELSE '0' END AS PardakhtStatus
FROM         Drd.tblElamAvarez INNER JOIN
                      Drd.tblCodhayeDaramadiElamAvarez ON Drd.tblElamAvarez.fldId = Drd.tblCodhayeDaramadiElamAvarez.fldElamAvarezId INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblCodhayeDaramadiElamAvarez.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Drd.tblShomareHesabCodeDaramad INNER JOIN
                      Drd.tblCodhayeDaramd ON Drd.tblShomareHesabCodeDaramad.fldCodeDaramadId = Drd.tblCodhayeDaramd.fldId ON 
                      Drd.tblCodhayeDaramadiElamAvarez.fldShomareHesabCodeDaramadId = Drd.tblShomareHesabCodeDaramad.fldId
                      WHERE fldElamAvarezId=@IdAvarez AND Drd.tblShomareHesabCodeDaramad.fldOrganId IN (SELECT fldOrganId FROM Drd.tblElamAvarez WHERE fldId=@IdAvarez)
                     GROUP BY tblCodhayeDaramadiElamAvarez.fldShomareHesabId,fldShorooshenaseGhabz,tblElamAvarez.fldOrganId,fldShomareHesab
                     )t
GO
