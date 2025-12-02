SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


CREATE PROC [Pay].[spr_Pay_RptListTakmilShodeKarkard](@fieldname NVARCHAR(50),@sal SMALLINT,@mah TINYINT,@organId INT)
AS
IF(@fieldname ='CostCenter')
SELECT * FROM ( SELECT    Pay.tblCostCenter.fldTitle, Com.fn_FamilyEmployee(fldEmployeeId) AS Name_Family, Pay.tblKarKardeMahane.fldKarkard, 
                      Pay.tblKarKardeMahane.fldGheybat, CAST(Pay.tblKarKardeMahane.fldTatileKari AS FLOAT)fldTatileKari, CAST(Pay.tblKarKardeMahane.fldEzafeKari AS FLOAT) fldEzafeKari, Pay.tblKarKardeMahane.fldNobateKari, 
                      Pay.tblKarKardeMahane.fldMamoriatBaBeitote + Pay.tblKarKardeMahane.fldMamoriatBedoneBeitote AS fldMamoriyat
FROM         Pay.tblKarKardeMahane INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblKarKardeMahane.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Pay.tblCostCenter ON Pay.Pay_tblPersonalInfo.fldCostCenterId = Pay.tblCostCenter.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = Com.tblEmployee.fldId
                      WHERE fldYear=@sal AND fldMah=@Mah and [Com].[fn_MaxPersonalStatus]( Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId,'kargozini')=1  AND Com.fn_OrganId(fldPrs_PersonalInfoId) =@organId
                      GROUP BY fldCostCenterId,fldTitle,Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId  ,fldKarkard  ,
                      fldGheybat,fldTatileKari,fldEzafeKari,fldNobateKari,fldMamoriatBaBeitote,fldMamoriatBedoneBeitote,fldEmployeeId
                      
                 )t
                 ORDER BY Name_Family

IF(@fieldname='ChartOrgan')
SELECT * FROM (SELECT   tblChartOrganEjraee.fldTitle,  Com.fn_FamilyEmployee(Prs.Prs_tblPersonalInfo.fldEmployeeId) AS Name_Family, Pay.tblKarKardeMahane.fldKarkard, Pay.tblKarKardeMahane.fldGheybat, 
                    CAST(Pay.tblKarKardeMahane.fldTatileKari AS FLOAT)fldTatileKari, CAST(Pay.tblKarKardeMahane.fldEzafeKari AS FLOAT) fldEzafeKari, Pay.tblKarKardeMahane.fldNobateKari, 
                      Pay.tblKarKardeMahane.fldMamoriatBaBeitote + Pay.tblKarKardeMahane.fldMamoriatBedoneBeitote AS fldMamoriyat
FROM         Pay.tblKarKardeMahane INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblKarKardeMahane.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = Com.tblEmployee.fldId INNER JOIN
                      Com.tblOrganizationalPostsEjraee ON Prs.Prs_tblPersonalInfo.fldOrganPostEjraeeId = Com.tblOrganizationalPostsEjraee.fldId INNER JOIN
                      Com.tblChartOrganEjraee ON Com.tblOrganizationalPostsEjraee.fldChartOrganId = Com.tblChartOrganEjraee.fldId                      WHERE fldYear=@sal AND fldMah=@Mah and [Com].[fn_MaxPersonalStatus](fldPrs_PersonalInfoId,'kargozini')=1  AND Com.fn_OrganId(fldPrs_PersonalInfoId) =@organId
                      GROUP BY fldChartOrganId,  tblChartOrganEjraee.fldTitle,Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId  ,fldKarkard  ,
                      fldGheybat,fldTatileKari,fldEzafeKari,fldNobateKari,fldMamoriatBaBeitote,fldMamoriatBedoneBeitote,fldEmployeeId
                      
                 )t
                 ORDER BY Name_Family
                 
  IF(@fieldname ='')
SELECT * FROM ( SELECT    Pay.tblCostCenter.fldTitle, Com.fn_FamilyEmployee(fldEmployeeId) AS Name_Family, Pay.tblKarKardeMahane.fldKarkard, 
                      Pay.tblKarKardeMahane.fldGheybat,CAST(Pay.tblKarKardeMahane.fldTatileKari AS FLOAT)fldTatileKari, CAST(Pay.tblKarKardeMahane.fldEzafeKari AS FLOAT) fldEzafeKari, Pay.tblKarKardeMahane.fldNobateKari, 
                      Pay.tblKarKardeMahane.fldMamoriatBaBeitote + Pay.tblKarKardeMahane.fldMamoriatBedoneBeitote AS fldMamoriyat
FROM         Pay.tblKarKardeMahane INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblKarKardeMahane.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Pay.tblCostCenter ON Pay.Pay_tblPersonalInfo.fldCostCenterId = Pay.tblCostCenter.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = Com.tblEmployee.fldId
                      WHERE fldYear=@sal AND fldMah=@Mah and [Com].[fn_MaxPersonalStatus]( Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId,'kargozini')=1  AND Com.fn_OrganId(fldPrs_PersonalInfoId) =@organId
                      GROUP BY fldCostCenterId,fldTitle,Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId  ,fldKarkard  ,
                      fldGheybat,fldTatileKari,fldEzafeKari,fldNobateKari,fldMamoriatBaBeitote,fldMamoriatBedoneBeitote,fldEmployeeId
                      
                 )t
                 ORDER BY Name_Family               
GO
