SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- Stored Procedure

CREATE PROC [Drd].[spr_SelectForEmalTakhfif](@fldElamAvarezId INT)
as
SELECT     Drd.tblCodhayeDaramadiElamAvarez.fldID, Drd.tblCodhayeDaramadiElamAvarez.fldTedad, ISNULL(
                          (SELECT     fldTakhfifAsli
                            FROM          Drd.tblMablaghTakhfif
                            WHERE      (fldCodeDaramadElamAvarezId = Drd.tblCodhayeDaramadiElamAvarez.fldID) AND (fldType = 1)), Drd.tblCodhayeDaramadiElamAvarez.fldAsliValue) 
                      * Drd.tblCodhayeDaramadiElamAvarez.fldTedad AS AsliValue, 
                      ISNULL(Drd.tblCodhayeDaramadiElamAvarez.fldAsliValue - Drd.tblCodhayeDaramadiElamAvarez.fldTakhfifAsliValue, 0) 
                      * Drd.tblCodhayeDaramadiElamAvarez.fldTedad AS fldTakhfifAsliValue, Drd.tblCodhayeDaramadiElamAvarez.fldSharheCodeDaramad, 
                      Drd.tblCodhayeDaramd.fldDaramadCode
FROM         Drd.tblCodhayeDaramadiElamAvarez INNER JOIN
                      Drd.tblShomareHesabCodeDaramad ON 
                      Drd.tblCodhayeDaramadiElamAvarez.fldShomareHesabCodeDaramadId = Drd.tblShomareHesabCodeDaramad.fldId INNER JOIN
                      Drd.tblCodhayeDaramd ON Drd.tblCodhayeDaramd.fldId = Drd.tblShomareHesabCodeDaramad.fldCodeDaramadId
WHERE     (Drd.tblCodhayeDaramadiElamAvarez.fldElamAvarezId = @fldElamAvarezId)
ORDER BY fldTedad desc
GO
