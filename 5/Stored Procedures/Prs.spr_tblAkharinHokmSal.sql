SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Prs].[spr_tblAkharinHokmSal]
@PersonalId INT,
@Year NVARCHAR(4)
as
BEGIN TRAN
SELECT   TOP(1)  fldId, fldPrs_PersonalInfoId, fldTarikhEjra, fldTarikhSodoor, fldTarikhEtmam, fldAnvaeEstekhdamId, fldStatusTaaholId, fldGroup, fldMoreGroup, 
                      fldShomarePostSazmani, fldTedadFarzand, fldTedadAfradTahteTakafol, fldTypehokm, fldShomareHokm, fldStatusHokm, fldDescriptionHokm, fldCodeShoghl, fldUserId, 
                      fldDate, fldDesc,fldTarikhEjra AS fldYear
FROM         tblPersonalHokm
WHERE fldPrs_PersonalInfoId=@PersonalId AND fldTarikhEjra<=@Year
ORDER BY fldTarikhEjra DESC 
,fldTarikhSodoor DESC 
commit
GO
