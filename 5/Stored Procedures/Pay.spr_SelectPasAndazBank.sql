SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_SelectPasAndazBank](@Year SMALLINT,@month TINYINT,@organId int)
as
SELECT fldBankId FROM Com.tblShomareHesabeOmoomi
WHERE fldShomareHesab = (SELECT    TOP(1)    fldShPasAndazPersonal
FROM            Pay.tblMohasebat INNER JOIN
                         Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebat.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatId
						  WHERE fldShPasAndazPersonal<>'' AND fldYear=@year AND fldmonth=@month and fldOrganId=@organId and fldCalcType=1
						 )
GO
