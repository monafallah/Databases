SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_InfoPardakhtFTP]
@OrganId INT,
@fldShenaseGhabz nvarchar(13),
@fldShenasePardakht nvarchar(13)
AS 
BEGIN TRAN

SELECT        fldId, fldName, fldCodAnformatic, fldCodKhedmat
,(SELECT TOP(1) fldShorooShenaseGhabz FROM Drd.tblSodoorFish WHERE fldShenaseGhabz=@fldShenaseGhabz AND fldShenasePardakht=@fldShenasePardakht ORDER BY fldId DESC) AS fldShorooShenaseGhabz
FROM            Com.tblOrganization
WHERE fldId=@OrganId

COMMIT TRAN
GO
