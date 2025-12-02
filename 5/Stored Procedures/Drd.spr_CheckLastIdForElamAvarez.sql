SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_CheckLastIdForElamAvarez](@FieldName NVARCHAR(50),@ElamAvarezId int)
AS

--DECLARE @ElamAvarezId INT,
IF(@FieldName='LastFish')
BEGIN
IF EXISTS (SELECT * FROM Drd.tblSodoorFish WHERE fldElamAvarezId=@ElamAvarezId)
SELECT CAST(1 AS bit) AS fldType --با این Id داده وجود دارد
ELSE 
SELECT CAST(0 AS bit) AS fldType
end
IF(@FieldName='LastFishForTaghsit_Takhfif')
BEGIN
IF EXISTS(SELECT TOP(1) * FROM Drd.tblSodoorFish WHERE fldElamAvarezId=@ElamAvarezId  AND fldId IN (SELECT fldFishId  FROM Drd.tblEbtal) ORDER BY fldid desc )
SELECT CAST(1 AS bit) AS fldType--اگر آخرین Id فیش ابطال شده بود برای قسمت تقسیط و تخفیف 
ELSE 
SELECT CAST(0 AS bit) AS fldType
end
IF(@FieldName='LastTaghsit')
BEGIN
IF EXISTS (SELECT TOP(1) * FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=@ElamAvarezId AND fldRequestType=1 AND fldId IN (SELECT fldRequestTaghsit_TakhfifId  FROM Drd.tblEbtal) ORDER BY fldid desc)
SELECT CAST(1 AS bit) AS fldType--اگر آخرین Id تقسیط ابطال شده بود 
ELSE 
SELECT CAST(0 AS bit) AS fldType
end
IF(@FieldName='LastTakhfif')
BEGIN
IF EXISTS (SELECT TOP(1) * FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=@ElamAvarezId AND fldRequestType=2 AND fldId IN (SELECT fldRequestTaghsit_TakhfifId  FROM Drd.tblEbtal) ORDER BY fldid desc)
SELECT CAST(1 AS bit) AS fldType--اگر آخرین Id تخفیف ابطال شده بود 
ELSE 
SELECT CAST(0 AS bit) AS fldType
end
IF(@FieldName='CheckElamAvarez')
BEGIN
IF EXISTS(SELECT TOP(1) * FROM Drd.tblSodoorFish WHERE fldElamAvarezId=@ElamAvarezId AND fldId NOT IN(SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=Drd.tblSodoorFish.fldId) ORDER BY fldId DESC ) OR EXISTS(SELECT TOP(1) * FROM Drd.tblRequestTaghsit_Takhfif WHERE fldElamAvarezId=@ElamAvarezId AND fldId NOT IN(SELECT fldRequestTaghsit_TakhfifId FROM Drd.tblEbtal WHERE fldRequestTaghsit_TakhfifId=Drd.tblRequestTaghsit_Takhfif.fldId) ORDER BY fldId DESC)
SELECT CAST(1 AS bit) AS fldType--اگر Id اعلام عوارض در جایی دیگر استفاده شده بود
ELSE 
SELECT CAST(0 AS bit) AS fldType
end
GO
