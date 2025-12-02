SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_ListShomareHesabWithElamAvarezId](@Fieldname NVARCHAR(50),@Value NVARCHAR(50))
AS
IF (@Fieldname='ShomareHesab')
SELECT  tblShomareHesabeOmoomi.fldID , Com.tblShomareHesabeOmoomi.fldShomareHesab
FROM         Drd.tblShomareHesabCodeDaramad INNER JOIN
                      Drd.tblCodhayeDaramadiElamAvarez ON 
                      Drd.tblShomareHesabCodeDaramad.fldId = Drd.tblCodhayeDaramadiElamAvarez.fldShomareHesabCodeDaramadId INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Drd.tblShomareHesabCodeDaramad.fldShomareHesadId = Com.tblShomareHesabeOmoomi.fldId
                      WHERE fldElamAvarezId=@Value
                      GROUP BY fldShomareHesadId,fldShomareHesab,  tblShomareHesabeOmoomi.fldID
                      
IF(@Fieldname='ShorooShenaseGhabz')                      
SELECT    0 as fldID, Drd.tblShomareHesabCodeDaramad.fldShorooshenaseGhabz
FROM         Drd.tblShomareHesabCodeDaramad INNER JOIN
                      Drd.tblCodhayeDaramadiElamAvarez ON Drd.tblShomareHesabCodeDaramad.fldId = Drd.tblCodhayeDaramadiElamAvarez.fldShomareHesabCodeDaramadId
                      WHERE fldElamAvarezId=@Value   
                      GROUP BY fldShorooshenaseGhabz                   
GO
