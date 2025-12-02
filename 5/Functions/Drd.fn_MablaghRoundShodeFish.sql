SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE FUNCTION [Drd].[fn_MablaghRoundShodeFish](@ElamAvarezId INT)
RETURNS INT
AS
BEGIN
DECLARE @organId INT,@mablagh bigINT
SELECT @organId=fldOrganId FROM Drd.tblElamAvarez WHERE fldId=@ElamAvarezId
SELECT @mablagh=
(((SUM((fldAsliValue+fldMaliyatValue+fldAvarezValue+fldAmuzeshParvareshValue)*fldTedad))/(SELECT fldMablaghGerdKardan FROM Drd.tblTanzimateDaramad WHERE fldOrganId=@organId AND fldMablaghGerdKardan<>0))*(SELECT fldMablaghGerdKardan FROM Drd.tblTanzimateDaramad WHERE fldOrganId=@organId AND fldMablaghGerdKardan<>0))
FROM         Drd.tblElamAvarez INNER JOIN
                      Drd.tblCodhayeDaramadiElamAvarez ON Drd.tblElamAvarez.fldId = Drd.tblCodhayeDaramadiElamAvarez.fldElamAvarezId INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblCodhayeDaramadiElamAvarez.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Drd.tblShomareHesabCodeDaramad INNER JOIN
                      Drd.tblCodhayeDaramd ON Drd.tblShomareHesabCodeDaramad.fldCodeDaramadId = Drd.tblCodhayeDaramd.fldId ON 
                      Drd.tblCodhayeDaramadiElamAvarez.fldShomareHesabCodeDaramadId = Drd.tblShomareHesabCodeDaramad.fldShomareHesadId
                      WHERE fldElamAvarezId=@ElamAvarezId
                     GROUP BY Drd.tblShomareHesabCodeDaramad.fldShomareHesadId,fldShorooshenaseGhabz

IF( @mablagh =cast(0  as bigint))
SELECT  @mablagh=CAST((SUM((fldAsliValue+fldMaliyatValue+fldAvarezValue+fldAmuzeshParvareshValue)*fldTedad))AS INT)
 FROM         Drd.tblElamAvarez INNER JOIN
                      Drd.tblCodhayeDaramadiElamAvarez ON Drd.tblElamAvarez.fldId = Drd.tblCodhayeDaramadiElamAvarez.fldElamAvarezId INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblCodhayeDaramadiElamAvarez.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Drd.tblShomareHesabCodeDaramad INNER JOIN
                      Drd.tblCodhayeDaramd ON Drd.tblShomareHesabCodeDaramad.fldCodeDaramadId = Drd.tblCodhayeDaramd.fldId ON 
                      Drd.tblCodhayeDaramadiElamAvarez.fldShomareHesabCodeDaramadId = Drd.tblShomareHesabCodeDaramad.fldShomareHesadId
                      WHERE fldElamAvarezId=@ElamAvarezId
                     GROUP BY Drd.tblShomareHesabCodeDaramad.fldShomareHesadId,fldShorooshenaseGhabz
                     
 RETURN @mablagh                    
END
GO
