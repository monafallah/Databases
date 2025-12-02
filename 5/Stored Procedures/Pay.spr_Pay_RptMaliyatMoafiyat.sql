SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE proc [Pay].[spr_Pay_RptMaliyatMoafiyat]
 @year SMALLINT,@month TINYINT,@organId INT
as
--declare @year SMALLINT=1403,@month TINYINT=6,@organId INT=1
select * from(
SELECT  fldFamily+'_'+fldName+' ('+ fldFatherName+')' AS fldName_Family,fldCodemeli,isnull(fldMablagh,0)fldMablagh,fldNameEN
FROM PAY.tblMohasebat as m
INNER JOIN Pay.tblMohasebat_PersonalInfo ON m.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatId
INNER JOIN pay.tblMohasebat_Items as i on i.fldMohasebatId=m.fldId
INNER JOIN com.tblItems_Estekhdam as e on e.fldId=i.fldItemEstekhdamId
INNER JOIN com.tblItemsHoghughi as h on h.fldId=e.fldItemsHoghughiId
INNER JOIN Pay.Pay_tblPersonalInfo ON m.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId 
INNER JOIN Prs.Prs_tblPersonalInfo ON Prs.Prs_tblPersonalInfo.fldId = Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId 
INNER JOIN Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId 
INNER JOIN  Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId 
where fldYear=@year and fldMonth=@month and fldOrganId=@organId and fldCalcType=1
 AND (i.fldMaliyatMashmool=0 ) --and (i.fldMostamar=1 or fldItemsHoghughiId=34) and i.fldHesabTypeItemId>1
 and (fldItemsHoghughiId not IN (33,  35, 36,55))
 )p 
 pivot (
 sum(fldMablagh) for fldNameEN in([khoraki],[kalaBehdashti],[olad],[ayelemandi],[maskan],[mazayaRefahi],[mamoriat],[mahdeKodak],[sayer],[refahi],[Monasebat],[javani]
 ,[madares])
 )t
GO
