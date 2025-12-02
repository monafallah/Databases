SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_SelectDetailSodoorFish](@fldElamAvarezId INT,@fldShomareHesabId INT,@fldShorooshenaseGhabz TINYINT)
as
SELECT     Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad, 
                      Drd.tblCodhayeDaramadiElamAvarez.fldAsliValue * Drd.tblCodhayeDaramadiElamAvarez.fldTedad AS fldAsliValue, 
                      Drd.tblCodhayeDaramadiElamAvarez.fldAvarezValue * Drd.tblCodhayeDaramadiElamAvarez.fldTedad AS fldAvarezValue, 
                      Drd.tblCodhayeDaramadiElamAvarez.fldMaliyatValue * Drd.tblCodhayeDaramadiElamAvarez.fldTedad AS fldMaliyatValue, 
					   Drd.tblCodhayeDaramadiElamAvarez.fldAmuzeshParvareshValue * Drd.tblCodhayeDaramadiElamAvarez.fldTedad AS fldAmuzeshParvareshValue,
                      Drd.tblShomareHesabCodeDaramad.fldCodeDaramadId, Drd.tblCodhayeDaramadiElamAvarez.fldShomareHesabId, 
                      Com.tblShomareHesabeOmoomi.fldShomareHesab,fldShorooshenaseGhabz
FROM         Drd.tblCodhayeDaramadiElamAvarez INNER JOIN
                      Drd.tblShomareHesabCodeDaramad ON 
                      Drd.tblCodhayeDaramadiElamAvarez.fldShomareHesabCodeDaramadId = Drd.tblShomareHesabCodeDaramad.fldId INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblCodhayeDaramadiElamAvarez.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId
                      WHERE fldElamAvarezId=@fldElamAvarezId  AND Drd.tblShomareHesabCodeDaramad.fldOrganId IN (SELECT fldOrganId FROM Drd.tblElamAvarez WHERE fldId=@fldElamAvarezId) AND fldShomareHesabId=@fldShomareHesabId AND fldShorooshenaseGhabz=@fldShorooshenaseGhabz
GO
