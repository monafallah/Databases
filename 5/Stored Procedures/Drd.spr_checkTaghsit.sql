SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_checkTaghsit](@fldElamAvarezId INT)
as
--DECLARE @fldElamAvarezId INT=2
DECLARE @temp TABLE (fish INT,[check] INT,Barat INT,Safte int)
INSERT INTO  @temp
        ( fish, [check], Barat, Safte )
SELECT 0,0,0,0
IF EXISTS (SELECT * FROM Drd.tblSodoorFish WHERE fldElamAvarezId=@fldElamAvarezId AND fldid IN (SELECT fldFishId FROM Drd.tblPardakhtFish WHERE fldFishId =Drd.tblSodoorFish.fldId))
BEGIN
UPDATE @temp
SET fish=1
END

ELSE IF EXISTS ( SELECT fldid FROM (SELECT TOP(1)* FROM Drd.tblSodoorFish WHERE fldElamAvarezId=@fldElamAvarezId AND fldid NOT IN (SELECT fldFishId FROM Drd.tblPardakhtFish WHERE fldFishId =Drd.tblSodoorFish.fldId) ORDER BY fldId DESC)t
where fldid NOT IN (SELECT fldFishId FROM Drd.tblEbtal WHERE fldFishId=t.fldId) )
BEGIN
UPDATE @temp
SET fish=2
END

if  exists (SELECT TOP(1) *
FROM         Drd.tblCheck INNER JOIN
                      Drd.tblReplyTaghsit ON Drd.tblCheck.fldReplyTaghsitId = Drd.tblReplyTaghsit.fldId INNER JOIN
                      Drd.tblStatusTaghsit_Takhfif ON Drd.tblReplyTaghsit.fldStatusId = Drd.tblStatusTaghsit_Takhfif.fldId INNER JOIN
                      Drd.tblRequestTaghsit_Takhfif ON Drd.tblStatusTaghsit_Takhfif.fldRequestId = Drd.tblRequestTaghsit_Takhfif.fldId
					  inner join acc.tblcase c on c.fldsourceid=tblCheck.fldid and fldcasetypeId=3
					  inner join acc.tblDocumentRecord_Details d on d.fldCaseId=c.fldid
                      WHERE tblReplyTaghsit.fldElamAvarezId=@fldElamAvarezId )

BEGIN 
UPDATE @temp
SET [check]=2
end  

else IF EXISTS (SELECT TOP(1) *
FROM         Drd.tblCheck INNER JOIN
                      Drd.tblReplyTaghsit ON Drd.tblCheck.fldReplyTaghsitId = Drd.tblReplyTaghsit.fldId INNER JOIN
                      Drd.tblStatusTaghsit_Takhfif ON Drd.tblReplyTaghsit.fldStatusId = Drd.tblStatusTaghsit_Takhfif.fldId INNER JOIN
                      Drd.tblRequestTaghsit_Takhfif ON Drd.tblStatusTaghsit_Takhfif.fldRequestId = Drd.tblRequestTaghsit_Takhfif.fldId
                      WHERE tblReplyTaghsit.fldElamAvarezId=@fldElamAvarezId AND Drd.tblCheck.fldStatus=2)
BEGIN 
UPDATE @temp
SET [check]=1
end  

IF EXISTS (SELECT *
FROM         Drd.tblSafte INNER JOIN
                      Drd.tblReplyTaghsit ON Drd.tblSafte.fldReplyTaghsitId = Drd.tblReplyTaghsit.fldId INNER JOIN
                      Drd.tblStatusTaghsit_Takhfif ON Drd.tblReplyTaghsit.fldStatusId = Drd.tblStatusTaghsit_Takhfif.fldId INNER JOIN
                      Drd.tblRequestTaghsit_Takhfif ON Drd.tblStatusTaghsit_Takhfif.fldRequestId = Drd.tblRequestTaghsit_Takhfif.fldId
                      WHERE tblReplyTaghsit.fldElamAvarezId=@fldElamAvarezId AND Drd.tblSafte.fldStatus=2)
BEGIN 
UPDATE @temp
SET Safte=1
end                         

IF EXISTS (SELECT *
FROM         Drd.tblBarat INNER JOIN
                      Drd.tblReplyTaghsit ON Drd.tblBarat.fldReplyTaghsitId = Drd.tblReplyTaghsit.fldId INNER JOIN
                      Drd.tblStatusTaghsit_Takhfif ON Drd.tblReplyTaghsit.fldStatusId = Drd.tblStatusTaghsit_Takhfif.fldId INNER JOIN
                      Drd.tblRequestTaghsit_Takhfif ON Drd.tblStatusTaghsit_Takhfif.fldRequestId = Drd.tblRequestTaghsit_Takhfif.fldId
                      WHERE tblReplyTaghsit.fldElamAvarezId=@fldElamAvarezId AND Drd.tblBarat.fldStatus=2)
BEGIN 
UPDATE @temp
SET Barat=1
end                         

SELECT * FROM @temp
GO
