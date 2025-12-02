SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_CheckTakhfif](@IdElamAvarez INT,@ShomareHesabId INT,@ShooroShenaseGhabz TINYINT)
AS

DECLARE @mablaghtakhfif BIT=0
DECLARE @table TABLE (id INT,tarikh NVARCHAR(10))
INSERT INTO  @table
        ( id,tarikh )
SELECT        Drd.tblCodhayeDaramadiElamAvarez.fldShomareHesabCodeDaramadId, dbo.Fn_AssembelyMiladiToShamsi(Drd.tblCodhayeDaramadiElamAvarez.fldDate) AS Expr1
FROM            Drd.tblCodhayeDaramadiElamAvarez INNER JOIN
                         Drd.tblShomareHesabCodeDaramad ON Drd.tblCodhayeDaramadiElamAvarez.fldShomareHesabCodeDaramadId = Drd.tblShomareHesabCodeDaramad.fldId
WHERE fldElamAvarezId=@IdElamAvarez AND Drd.tblCodhayeDaramadiElamAvarez.fldShomareHesabId=@ShomareHesabId AND fldShorooshenaseGhabz=@ShooroShenaseGhabz
--SELECT * FROM @table

SELECT  @mablaghtakhfif=CAST(1 AS bit)
FROM         Drd.tblTakhfif INNER JOIN
                      Drd.tblTakhfifDetail ON Drd.tblTakhfif.fldId = Drd.tblTakhfifDetail.fldTakhfifId
                      WHERE fldShCodeDaramad IN (SELECT id FROM @table WHERE tarikh  BETWEEN fldAzTarikh AND fldTaTarikh) 
                      AND (fldTakhfifKoli IS NOT NULL OR fldTakhfifNaghdi IS NOT NULL)
                      
 SELECT @mablaghtakhfif AS Takhfif
                    
GO
