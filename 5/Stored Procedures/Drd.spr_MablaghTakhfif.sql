SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_MablaghTakhfif](@Id INT,@Mablagh INT OUT)
as
DECLARE @mablaghKol bigint,@mablaghtakhfif bigint
DECLARE @table TABLE (id INT,tarikh NVARCHAR(10))
INSERT INTO  @table
        ( id,tarikh )
SELECT fldShomareHesabCodeDaramadId,dbo.Fn_AssembelyMiladiToShamsi(fldDate) FROM Drd.tblCodhayeDaramadiElamAvarez
WHERE fldElamAvarezId=@Id

SELECT @mablaghKol=SUM((fldAsliValue*fldTedad)+fldMaliyatValue+fldAvarezValue+fldAmuzeshParvareshValue) FROM Drd.tblCodhayeDaramadiElamAvarez
WHERE fldElamAvarezId=@Id
--SELECT @mablaghKol
-------------تخفیف کلی
SELECT   @mablaghKol=@mablaghKol-(@mablaghKol*(SUM(CAST(fldTakhfifKoli AS DECIMAL(5,2)))/100))
FROM         Drd.tblTakhfif INNER JOIN
                      Drd.tblTakhfifDetail ON Drd.tblTakhfif.fldId = Drd.tblTakhfifDetail.fldTakhfifId
                      WHERE fldShCodeDaramad IN (SELECT id FROM @table WHERE tarikh  BETWEEN fldAzTarikh AND fldTaTarikh) 
                      AND fldTakhfifKoli IS NOT NULL
                      
  --SELECT @mablaghKol                    
--IF EXISTS (SELECT  *
--FROM         Drd.tblReplyTakhfif INNER JOIN
--                      Drd.tblStatusTaghsit_Takhfif ON Drd.tblReplyTakhfif.fldStatusId = Drd.tblStatusTaghsit_Takhfif.fldId INNER JOIN
--                      Drd.tblRequestTaghsit_Takhfif ON Drd.tblStatusTaghsit_Takhfif.fldRequestId = Drd.tblRequestTaghsit_Takhfif.fldId
--                      WHERE  Drd.tblStatusTaghsit_Takhfif.fldTypeMojavez=1 AND  Drd.tblRequestTaghsit_Takhfif.fldRequestType=2 AND fldElamAvarezId=36 AND tblRequestTaghsit_Takhfif.fldId NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId))
               

----------------------تخفیف
SELECT    @mablaghKol=@mablaghKol-fldMablagh
FROM         Drd.tblReplyTakhfif INNER JOIN
                      Drd.tblStatusTaghsit_Takhfif ON Drd.tblReplyTakhfif.fldStatusId = Drd.tblStatusTaghsit_Takhfif.fldId INNER JOIN
                      Drd.tblRequestTaghsit_Takhfif ON Drd.tblStatusTaghsit_Takhfif.fldRequestId = Drd.tblRequestTaghsit_Takhfif.fldId
                      WHERE  Drd.tblStatusTaghsit_Takhfif.fldTypeMojavez=1 AND  Drd.tblRequestTaghsit_Takhfif.fldRequestType=2 AND fldElamAvarezId=@Id AND tblRequestTaghsit_Takhfif.fldId NOT IN (SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId)
                    
 --SELECT @mablaghKol              
-----------------------تخفیف نقدی
IF EXISTS ( SELECT * from(SELECT TOP(1) * FROM Drd.tblSodoorFish WHERE fldElamAvarezId=@Id ORDER BY fldId)t 
			INNER JOIN Drd.tblSodoorFish_Detail ON t.fldId=Drd.tblSodoorFish_Detail.fldFishId
WHERE t.fldid NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=t.fldId)
HAVING COUNT(tblSodoorFish_Detail.fldId)=(SELECT COUNT(*) FROM @table) )

SELECT   @mablaghKol=@mablaghKol-(@mablaghKol*(SUM(CAST(fldTakhfifNaghdi AS DECIMAL(5,2)))/100))
FROM         Drd.tblTakhfif INNER JOIN
                      Drd.tblTakhfifDetail ON Drd.tblTakhfif.fldId = Drd.tblTakhfifDetail.fldTakhfifId
                      WHERE fldShCodeDaramad IN (SELECT id FROM @table WHERE tarikh  BETWEEN fldAzTarikh AND fldTaTarikh) 
                      AND fldTakhfifNaghdi IS NOT NULL
--SELECT @mablaghKol
SET @Mablagh=@mablaghKol
GO
