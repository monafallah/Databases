SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_Pay_RptListKhamKarkard](@FieldName NVARCHAR(50),@sal SMALLINT,@mah TINYINT,@costcenterId INT,@organId INT)
AS
--IF(@costcenterId<>0)
IF(@FieldName='CostCenter')
SELECT * FROM (SELECT        Pay.tblCostCenter.fldTitle, Com.fn_NameFamily(Pay.Pay_tblPersonalInfo.fldId) AS Name_Family
 ,cast(0 as tinyint)fldKarkard,cast(0.0 as decimal)fldEzafeKari,cast(0.0 as decimal)fldTatileKari,cast(0 as tinyint) as fldMamoriat,cast(0 as tinyint)fldNobateKari,cast(0 as tinyint)fldGheybat
FROM            Pay.Pay_tblPersonalInfo INNER JOIN
                         Pay.tblCostCenter ON Pay.Pay_tblPersonalInfo.fldCostCenterId = Pay.tblCostCenter.fldId 
                      WHERE   fldCostCenterId=@costcenterId AND Com.fn_organIdWithPayPersonal(Pay.Pay_tblPersonalInfo.fldId)=@organId
					  and com.fn_MaxPersonalStatus(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId,'kargozini')=1
                      GROUP BY fldCostCenterId,fldTitle,Pay.Pay_tblPersonalInfo.fldId  )t
					  ORDER BY Name_Family ,fldKarkard,fldEzafeKari,fldTatileKari, fldMamoriat,fldNobateKari,fldGheybat
					  
IF(@FieldName='ChartOrgan') 
SELECT * FROM (SELECT     Com.tblChartOrganEjraee.fldTitle, Com.fn_NameFamily(Pay.Pay_tblPersonalInfo.fldId) AS Name_Family
 ,cast(0 as tinyint)fldKarkard,cast(0.0 as decimal)fldEzafeKari,cast(0.0 as decimal)fldTatileKari,cast(0 as tinyint) as fldMamoriat,cast(0 as tinyint)fldNobateKari,cast(0 as tinyint)fldGheybat
FROM         Pay.Pay_tblPersonalInfo INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblOrganizationalPostsEjraee ON Prs.Prs_tblPersonalInfo.fldOrganPostEjraeeId = Com.tblOrganizationalPostsEjraee.fldId INNER JOIN
                      Com.tblChartOrganEjraee ON Com.tblChartOrganEjraee.fldId = Com.tblOrganizationalPostsEjraee.fldChartOrganId 
                      WHERE fldChartOrganId=@costcenterId AND Com.fn_organIdWithPayPersonal(Pay.Pay_tblPersonalInfo.fldId)=@organId
					  and com.fn_MaxPersonalStatus(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId,'kargozini')=1
                      GROUP BY fldChartOrganId, Com.tblChartOrganEjraee.fldTitle,Pay.Pay_tblPersonalInfo.fldId 
					   )t
					  ORDER BY Name_Family ,fldKarkard,fldEzafeKari,fldTatileKari, fldMamoriat,fldNobateKari,fldGheybat

IF(@FieldName='')
 SELECT * FROM (SELECT        Com.tblChartOrgan.fldTitle, Com.fn_NameFamily(Pay.Pay_tblPersonalInfo.fldId) AS Name_Family,fldFamily,fldName
 ,cast(0 as tinyint)fldKarkard,cast(0.0 as decimal)fldEzafeKari,cast(0.0 as decimal)fldTatileKari,cast(0 as tinyint) as fldMamoriat,cast(0 as tinyint)fldNobateKari,cast(0 as tinyint)fldGheybat
FROM            Com.tblOrganizationalPosts INNER JOIN
                         Com.tblChartOrgan ON Com.tblOrganizationalPosts.fldChartOrganId = Com.tblChartOrgan.fldId INNER JOIN
                         Prs.Prs_tblPersonalInfo ON Com.tblOrganizationalPosts.fldId = Prs.Prs_tblPersonalInfo.fldOrganPostId INNER JOIN
                         Pay.Pay_tblPersonalInfo ON Prs.Prs_tblPersonalInfo.fldId = Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId INNER JOIN
                         Com.tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = Com.tblEmployee.fldId 
WHERE   (Com.fn_organIdWithPayPersonal(Pay.Pay_tblPersonalInfo.fldId) = @organId) AND (Com.fn_MaxPersonalStatus(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId, N'kargozini') = 1)
)s
					   ORDER BY fldFamily,fldName

IF(@FieldName='CostCenter_Info')
SELECT * FROM (SELECT        Pay.tblCostCenter.fldTitle, Com.fn_NameFamily(Pay.Pay_tblPersonalInfo.fldId) AS Name_Family
 ,fldKarkard,fldEzafeKari,fldTatileKari,fldMamoriatBaBeitote+fldMamoriatBedoneBeitote as fldMamoriat,fldNobateKari,fldGheybat
FROM            Pay.Pay_tblPersonalInfo INNER JOIN
                         Pay.tblCostCenter ON Pay.Pay_tblPersonalInfo.fldCostCenterId = Pay.tblCostCenter.fldId inner join 
						 Pay.tblKarKardeMahane ON Pay.tblKarKardeMahane.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId
                      WHERE fldYear=@sal and fldMah=@mah and    fldCostCenterId=@costcenterId AND Com.fn_organIdWithPayPersonal(Pay.Pay_tblPersonalInfo.fldId)=@organId
					  and com.fn_MaxPersonalStatus(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId,'kargozini')=1
                      GROUP BY fldCostCenterId,fldTitle,Pay.Pay_tblPersonalInfo.fldId ,fldKarkard,fldEzafeKari,fldTatileKari,fldMamoriatBaBeitote,fldMamoriatBedoneBeitote ,fldNobateKari,fldGheybat )t
					  ORDER BY Name_Family ,fldKarkard,fldEzafeKari,fldTatileKari, fldMamoriat,fldNobateKari,fldGheybat
					  
IF(@FieldName='ChartOrgan_Info') 
SELECT * FROM (SELECT     Com.tblChartOrganEjraee.fldTitle, Com.fn_NameFamily(Pay.Pay_tblPersonalInfo.fldId) AS Name_Family
 ,fldKarkard,fldEzafeKari,fldTatileKari,fldMamoriatBaBeitote+fldMamoriatBedoneBeitote as fldMamoriat,fldNobateKari,fldGheybat
FROM         Pay.Pay_tblPersonalInfo INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblOrganizationalPostsEjraee ON Prs.Prs_tblPersonalInfo.fldOrganPostEjraeeId = Com.tblOrganizationalPostsEjraee.fldId INNER JOIN
                      Com.tblChartOrganEjraee ON Com.tblChartOrganEjraee.fldId = Com.tblOrganizationalPostsEjraee.fldChartOrganId inner join 
						 Pay.tblKarKardeMahane ON Pay.tblKarKardeMahane.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId
                      WHERE fldYear=@sal and fldMah=@mah and fldChartOrganId=@costcenterId AND Com.fn_organIdWithPayPersonal(Pay.Pay_tblPersonalInfo.fldId)=@organId
					  and com.fn_MaxPersonalStatus(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId,'kargozini')=1
                      GROUP BY fldChartOrganId, Com.tblChartOrganEjraee.fldTitle,Pay.Pay_tblPersonalInfo.fldId ,fldKarkard,fldEzafeKari,fldTatileKari,fldMamoriatBaBeitote,fldMamoriatBedoneBeitote ,fldNobateKari,fldGheybat )t
					  ORDER BY Name_Family ,fldKarkard,fldEzafeKari,fldTatileKari, fldMamoriat,fldNobateKari,fldGheybat

IF(@FieldName='Info')
 SELECT * FROM (SELECT        Com.tblChartOrgan.fldTitle, Com.fn_NameFamily(Pay.Pay_tblPersonalInfo.fldId) AS Name_Family,fldFamily,fldName
 ,fldKarkard,fldEzafeKari,fldTatileKari,fldMamoriatBaBeitote+fldMamoriatBedoneBeitote as fldMamoriat,fldNobateKari,fldGheybat
FROM            Com.tblOrganizationalPosts INNER JOIN
                         Com.tblChartOrgan ON Com.tblOrganizationalPosts.fldChartOrganId = Com.tblChartOrgan.fldId INNER JOIN
                         Prs.Prs_tblPersonalInfo ON Com.tblOrganizationalPosts.fldId = Prs.Prs_tblPersonalInfo.fldOrganPostId INNER JOIN
                         Pay.Pay_tblPersonalInfo ON Prs.Prs_tblPersonalInfo.fldId = Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId INNER JOIN
                         Com.tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = Com.tblEmployee.fldId inner join 
						 Pay.tblKarKardeMahane ON Pay.tblKarKardeMahane.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId
WHERE fldYear=@sal and fldMah=@mah and       (Com.fn_organIdWithPayPersonal(Pay.Pay_tblPersonalInfo.fldId) = @organId) AND (Com.fn_MaxPersonalStatus(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId, N'kargozini') = 1)
)s
					   ORDER BY fldFamily,fldName
GO
