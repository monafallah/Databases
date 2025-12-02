SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_SelectAshkhas_Fish](@ElamAvarezId int)
AS 
BEGIN TRAN
SELECT     Drd.tblSodoorFish.fldId, Drd.tblSodoorFish.fldShomareHesabId, Drd.tblSodoorFish.fldShenaseGhabz, 
                      Drd.tblSodoorFish.fldShenasePardakht, Drd.tblSodoorFish.fldMablaghAvarezGerdShode, Drd.tblSodoorFish.fldShorooShenaseGhabz, 
                      Drd.tblSodoorFish.fldDesc,  Drd.tblSodoorFish.fldJamKol, Drd.tblSodoorFish.fldBarcode, Drd.tblSodoorFish.fldTarikh, 
                      Com.tblShomareHesabeOmoomi.fldShomareHesab,
                      ISNULL((SELECT fldTarikh FROM Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldid AND Drd.tblSodoorFish.fldid NOT IN (SELECT Drd.tblEbtal.fldFishId FROM Drd.tblEbtal WHERE tblebtal.fldFishId=Drd.tblSodoorFish.fldid)),'')fldTarikhPardakht,
                     ISNULL((SELECT fldTarikhVariz FROM Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldid AND Drd.tblSodoorFish.fldid NOT IN (SELECT Drd.tblEbtal.fldFishId FROM Drd.tblEbtal WHERE tblebtal.fldFishId=Drd.tblSodoorFish.fldid)),'')fldTarikhVariz,
					 isnull( (SELECT  Drd.tblNahvePardakht.fldTitle
FROM         Drd.tblPardakhtFish INNER JOIN
                      Drd.tblNahvePardakht ON Drd.tblPardakhtFish.fldNahvePardakhtId = Drd.tblNahvePardakht.fldId
WHERE     (Drd.tblPardakhtFish.fldFishId = Drd.tblSodoorFish.fldid) AND Drd.tblSodoorFish.fldid NOT IN (SELECT Drd.tblEbtal.fldFishId FROM Drd.tblEbtal WHERE tblebtal.fldFishId=Drd.tblSodoorFish.fldid)),'')NoePardakht
,CASE WHEN EXISTS (SELECT * FROM Drd.tblPardakhtFish WHERE fldFishId=Drd.tblSodoorFish.fldid AND Drd.tblSodoorFish.fldid NOT IN (SELECT Drd.tblEbtal.fldFishId FROM Drd.tblEbtal WHERE tblebtal.fldFishId=Drd.tblSodoorFish.fldid))
THEN N'پرداخت شده' ELSE N'پرداخت نشده' END fldStatus,
(SELECT ISNULL(SUM(a.fldAsliValue),0)  FROM Drd.tblCodhayeDaramadiElamAvarez AS a WHERE a.fldElamAvarezId=tblSodoorFish.fldElamAvarezId AND a.fldShomareHesabId=Drd.tblSodoorFish.fldShomareHesabId)fldAsliValue
                         ,(SELECT ISNULL(SUM(fldMaliyatValue),0)  FROM Drd.tblCodhayeDaramadiElamAvarez AS a WHERE a.fldElamAvarezId=tblSodoorFish.fldElamAvarezId AND a.fldShomareHesabId=Drd.tblSodoorFish.fldShomareHesabId)fldMaliyatValue
                          ,(SELECT ISNULL(SUM(a.fldAvarezValue),0)  FROM Drd.tblCodhayeDaramadiElamAvarez AS a WHERE a.fldElamAvarezId=tblSodoorFish.fldElamAvarezId AND a.fldShomareHesabId=Drd.tblSodoorFish.fldShomareHesabId)fldAvarezValue
						   ,(SELECT ISNULL(SUM(a.fldAmuzeshParvareshValue),0)  FROM Drd.tblCodhayeDaramadiElamAvarez AS a WHERE a.fldElamAvarezId=tblSodoorFish.fldElamAvarezId AND a.fldShomareHesabId=Drd.tblSodoorFish.fldShomareHesabId)fldAmuzeshParvareshValue

                      
FROM         Drd.tblSodoorFish INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblSodoorFish.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId
                      WHERE fldElamAvarezId=@ElamAvarezId AND tblSodoorFish.fldId NOT IN (SELECT tblEbtal.fldFishId FROM Drd.tblEbtal WHERE tblSodoorFish.fldId=tblEbtal.fldFishId)
 COMMIT
GO
