SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_RptPardakhtFile](@FishId INT)
as
IF EXISTS (SELECT * FROM Drd.tblPardakhtFish WHERE fldFishId=@FishId AND fldPardakhtFiles_DetailId IS NOT null)
SELECT        Com.tblSHobe.fldName AS fldshobeName, Com.tblBank.fldBankName,  Drd.tblPardakhtFiles_Detail.fldTarikhPardakht , 
                         Drd.tblPardakhtFiles_Detail.fldCodeRahgiry, Drd.tblNahvePardakht.fldTitle AS fldNahvePardakhtTitle
FROM            Drd.tblPardakhtFile INNER JOIN
                         Drd.tblPardakhtFiles_Detail ON Drd.tblPardakhtFile.fldId = Drd.tblPardakhtFiles_Detail.fldOrganId INNER JOIN
                         Com.tblBank ON Drd.tblPardakhtFile.fldBankId = Com.tblBank.fldId INNER JOIN
                         Com.tblSHobe ON Com.tblBank.fldId = Com.tblSHobe.fldBankId INNER JOIN
                         Drd.tblNahvePardakht ON Drd.tblPardakhtFiles_Detail.fldNahvePardakhtId = Drd.tblNahvePardakht.fldId
						 WHERE tblPardakhtFiles_Detail.fldId =( SELECT fldPardakhtFiles_DetailId FROM Drd.tblPardakhtFish WHERE fldFishId=@FishId )
GO
