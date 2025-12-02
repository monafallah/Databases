SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_Pay_rptFishBonKart]
--declare
 @fieldName NVARCHAR(50),
@value INT,
@NobatPardakht TINYINT,
@Year SMALLINT,
@Month TINYINT,
@organID INT
,@userId int,
@CalcType TINYINT=1
as 
BEGIN TRAN



IF(@fieldName='fldPersonalId')
SELECT     Pay.Pay_tblPersonalInfo.fldId AS fldPersonalId, tblEmployee.fldName + ' ' + tblEmployee.fldFamily AS fldName, Com.tblEmployee_Detail.fldFatherName, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali, tblEmployee.fldCodemeli, (SELECT Com.fn_stringDecode(tblOrganization.fldName) FROM Com.tblOrganization WHERE fldId=com.fn_OrganName(fldOrganPostId)) + '_' + tblChartOrgan.fldTitle AS fldServiceLocationTitle, 
                      ISNULL(i.fldShomareHesab,K.fldShomareHesab) fldShomareHesab, tblMohasebat_1.fldKarkard
					  , tblMohasebat_1.fldYear, Com.fn_month(tblMohasebat_1.fldMonth) AS fldMonth
					  ,tblFile.fldImage,fldTypeEstekhamId 
FROM         Prs.Prs_tblPersonalInfo INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Prs.Prs_tblPersonalInfo.fldId = Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId INNER JOIN
                      Pay.tblMohasebat AS tblMohasebat_1 ON Pay.Pay_tblPersonalInfo.fldId = tblMohasebat_1.fldPersonalId INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON tblMohasebat_1.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatId  INNER JOIN
					  com.tblAnvaEstekhdam as a on a.fldId=tblMohasebat_PersonalInfo.fldAnvaEstekhdamId inner join
                      Com.tblOrganizationalPosts AS tblOrganizationalPosts ON Prs.Prs_tblPersonalInfo.fldOrganPostId = tblOrganizationalPosts.fldId INNER JOIN
                      Com.tblChartOrgan AS tblChartOrgan ON tblOrganizationalPosts.fldChartOrganId = tblChartOrgan.fldId  INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId left JOIN
                      Com.tblFile AS tblFile ON Com.tblEmployee_Detail.fldFileId = tblFile.fldId 
					 /*jadid*/ cross apply(select t.fldTypeEstekhamId from com.tblUser_Group u
											inner join pay.tblTypeEstekhdam_UserGroup t on t.fldUseGroupId=u.fldUserGroupId
											cross apply (select top(1) a.fldNoeEstekhdamId from prs.tblHistoryNoeEstekhdam  h
														inner join com.tblAnvaEstekhdam a on a.fldid=h.fldNoeEstekhdamId
														where fldPrsPersonalInfoId= Prs.Prs_tblPersonalInfo.fldid
														order by fldTarikh desc)history
							where fldUserSelectId=@userId and history.fldNoeEstekhdamId=t.fldTypeEstekhamId
							group by t.fldTypeEstekhamId)typeestekhdam
						OUTER apply(select top(1) s.fldShomareHesab from pay.tblMohasebat_Items as  i 
														inner join com.tblShomareHesabeOmoomi as s on s.fldId=i.fldShomareHesabItemId
														where i.fldMohasebatId=tblMohasebat_1.fldid and i.fldHesabTypeItemId=1)i
						OUTER apply(select top(1) s.fldShomareHesab from pay.[tblMohasebat_kosorat/MotalebatParam] as  i 
														inner join com.tblShomareHesabeOmoomi as s on s.fldId=i.fldShomareHesabParamId
														where i.fldMohasebatId=tblMohasebat_1.fldid and i.fldHesabTypeParamId=1)K
					 WHERE tblMohasebat_1.fldYear=@Year AND tblMohasebat_1.fldMonth=@Month AND tblMohasebat_1.fldNobatPardakht=@NobatPardakht AND tblMohasebat_1.fldPersonalId=@value
                   and fldCalcType=@CalcType
					-- AND tblOrgan.fldId IN (SELECT Id FROM .Com.fn_GetOrganTree(@UserId))
					 AND Pay.tblMohasebat_PersonalInfo.fldOrganId=@organID
						and(i.fldShomareHesab is not null or k.fldShomareHesab is not null)
                      
IF(@fieldName='')
SELECT     Pay.Pay_tblPersonalInfo.fldId AS fldPersonalId, tblEmployee.fldName + ' ' + tblEmployee.fldFamily AS fldName, Com.tblEmployee_Detail.fldFatherName, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali, tblEmployee.fldCodemeli, (SELECT Com.fn_stringDecode(tblOrganization.fldName) FROM Com.tblOrganization WHERE fldId=com.fn_OrganName(fldOrganPostId)) + '_' + tblChartOrgan.fldTitle AS fldServiceLocationTitle, 
                        ISNULL(i.fldShomareHesab,K.fldShomareHesab)  as fldShomareHesab, tblMohasebat_1.fldKarkard
					  , tblMohasebat_1.fldYear, Com.fn_month(tblMohasebat_1.fldMonth) AS fldMonth
					  ,tblFile.fldImage,fldTypeEstekhamId 
FROM         Prs.Prs_tblPersonalInfo INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Prs.Prs_tblPersonalInfo.fldId = Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId INNER JOIN
                      Pay.tblMohasebat AS tblMohasebat_1 ON Pay.Pay_tblPersonalInfo.fldId = tblMohasebat_1.fldPersonalId INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON tblMohasebat_1.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatId  INNER JOIN
					  com.tblAnvaEstekhdam as a on a.fldId=tblMohasebat_PersonalInfo.fldAnvaEstekhdamId inner join
                      Com.tblOrganizationalPosts AS tblOrganizationalPosts ON Prs.Prs_tblPersonalInfo.fldOrganPostId = tblOrganizationalPosts.fldId INNER JOIN
                      Com.tblChartOrgan AS tblChartOrgan ON tblOrganizationalPosts.fldChartOrganId = tblChartOrgan.fldId  INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId left JOIN
                      Com.tblFile AS tblFile ON Com.tblEmployee_Detail.fldFileId = tblFile.fldId 
					 /*jadid*/ cross apply(select t.fldTypeEstekhamId from com.tblUser_Group u
											inner join pay.tblTypeEstekhdam_UserGroup t on t.fldUseGroupId=u.fldUserGroupId
											cross apply (select top(1) a.fldNoeEstekhdamId from prs.tblHistoryNoeEstekhdam  h
														inner join com.tblAnvaEstekhdam a on a.fldid=h.fldNoeEstekhdamId
														where fldPrsPersonalInfoId= Prs.Prs_tblPersonalInfo.fldid
														order by fldTarikh desc)history
							where fldUserSelectId=@userId and history.fldNoeEstekhdamId=t.fldTypeEstekhamId
							group by t.fldTypeEstekhamId)typeestekhdam
						OUTER apply(select top(1) s.fldShomareHesab from pay.tblMohasebat_Items as  i 
														inner join com.tblShomareHesabeOmoomi as s on s.fldId=i.fldShomareHesabItemId
														where i.fldMohasebatId=tblMohasebat_1.fldid and i.fldHesabTypeItemId=1)i
						OUTER apply(select top(1) s.fldShomareHesab from pay.[tblMohasebat_kosorat/MotalebatParam] as  i 
														inner join com.tblShomareHesabeOmoomi as s on s.fldId=i.fldShomareHesabParamId
														where i.fldMohasebatId=tblMohasebat_1.fldid and i.fldHesabTypeParamId=1)K
					   WHERE tblMohasebat_1.fldYear=@Year AND tblMohasebat_1.fldMonth=@Month AND tblMohasebat_1.fldNobatPardakht=@NobatPardakht 
                       --  AND tblOrgan.fldId IN (SELECT Id FROM .Com.fn_GetOrganTree(@UserId))
					   AND Pay.tblMohasebat_PersonalInfo.fldOrganId=@organID and fldCalcType=@CalcType
						and(i.fldShomareHesab is not null or k.fldShomareHesab is not null)
IF(@fieldName='CostCenter')
SELECT     Pay.Pay_tblPersonalInfo.fldId AS fldPersonalId, tblEmployee.fldName + ' ' + tblEmployee.fldFamily AS fldName, Com.tblEmployee_Detail.fldFatherName, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali, tblEmployee.fldCodemeli, (SELECT Com.fn_stringDecode(tblOrganization.fldName) FROM Com.tblOrganization WHERE fldId=com.fn_OrganName(fldOrganPostId)) + '_' + tblChartOrgan.fldTitle AS fldServiceLocationTitle, 
                       ISNULL(i.fldShomareHesab,K.fldShomareHesab) fldShomareHesab, tblMohasebat_1.fldKarkard
					  , tblMohasebat_1.fldYear, Com.fn_month(tblMohasebat_1.fldMonth) AS fldMonth
					  ,tblFile.fldImage,fldTypeEstekhamId 
FROM         Prs.Prs_tblPersonalInfo INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Prs.Prs_tblPersonalInfo.fldId = Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId INNER JOIN
                      Pay.tblMohasebat AS tblMohasebat_1 ON Pay.Pay_tblPersonalInfo.fldId = tblMohasebat_1.fldPersonalId INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON tblMohasebat_1.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatId  INNER JOIN
					  com.tblAnvaEstekhdam as a on a.fldId=tblMohasebat_PersonalInfo.fldAnvaEstekhdamId inner join
                      Com.tblOrganizationalPosts AS tblOrganizationalPosts ON Prs.Prs_tblPersonalInfo.fldOrganPostId = tblOrganizationalPosts.fldId INNER JOIN
                      Com.tblChartOrgan AS tblChartOrgan ON tblOrganizationalPosts.fldChartOrganId = tblChartOrgan.fldId  INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId left JOIN
                      Com.tblFile AS tblFile ON Com.tblEmployee_Detail.fldFileId = tblFile.fldId 
					 /*jadid*/ cross apply(select t.fldTypeEstekhamId from com.tblUser_Group u
											inner join pay.tblTypeEstekhdam_UserGroup t on t.fldUseGroupId=u.fldUserGroupId
											cross apply (select top(1) a.fldNoeEstekhdamId from prs.tblHistoryNoeEstekhdam  h
														inner join com.tblAnvaEstekhdam a on a.fldid=h.fldNoeEstekhdamId
														where fldPrsPersonalInfoId= Prs.Prs_tblPersonalInfo.fldid
														order by fldTarikh desc)history
							where fldUserSelectId=@userId and history.fldNoeEstekhdamId=t.fldTypeEstekhamId
							group by t.fldTypeEstekhamId)typeestekhdam
							OUTER apply(select top(1) s.fldShomareHesab from pay.tblMohasebat_Items as  i 
														inner join com.tblShomareHesabeOmoomi as s on s.fldId=i.fldShomareHesabItemId
														where i.fldMohasebatId=tblMohasebat_1.fldid and i.fldHesabTypeItemId=1)i
						OUTER apply(select top(1) s.fldShomareHesab from pay.[tblMohasebat_kosorat/MotalebatParam] as  i 
														inner join com.tblShomareHesabeOmoomi as s on s.fldId=i.fldShomareHesabParamId
														where i.fldMohasebatId=tblMohasebat_1.fldid and i.fldHesabTypeParamId=1)K
					   WHERE tblMohasebat_1.fldYear=@Year AND tblMohasebat_1.fldMonth=@Month AND tblMohasebat_1.fldNobatPardakht=@NobatPardakht 
					   AND tblMohasebat_PersonalInfo.fldCostCenterId=@value
					    AND Pay.tblMohasebat_PersonalInfo.fldOrganId=@organID and fldCalcType=@CalcType
						and(i.fldShomareHesab is not null or k.fldShomareHesab is not null)
IF(@fieldName='ChartOrgan')
SELECT     Pay.Pay_tblPersonalInfo.fldId AS fldPersonalId, tblEmployee.fldName + ' ' + tblEmployee.fldFamily AS fldName, Com.tblEmployee_Detail.fldFatherName, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali, tblEmployee.fldCodemeli, (SELECT Com.fn_stringDecode(tblOrganization.fldName) FROM Com.tblOrganization WHERE fldId=com.fn_OrganName(fldOrganPostId)) + '_' + tblChartOrgan.fldTitle AS fldServiceLocationTitle, 
                      ISNULL(i.fldShomareHesab,K.fldShomareHesab) fldShomareHesab, tblMohasebat_1.fldKarkard
					  , tblMohasebat_1.fldYear, Com.fn_month(tblMohasebat_1.fldMonth) AS fldMonth
					  ,tblFile.fldImage,fldTypeEstekhamId 
FROM         Prs.Prs_tblPersonalInfo INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Prs.Prs_tblPersonalInfo.fldId = Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId INNER JOIN
                      Pay.tblMohasebat AS tblMohasebat_1 ON Pay.Pay_tblPersonalInfo.fldId = tblMohasebat_1.fldPersonalId INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON tblMohasebat_1.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatId  INNER JOIN
					  com.tblAnvaEstekhdam as a on a.fldId=tblMohasebat_PersonalInfo.fldAnvaEstekhdamId inner join
                      Com.tblOrganizationalPosts AS tblOrganizationalPosts ON Prs.Prs_tblPersonalInfo.fldOrganPostId = tblOrganizationalPosts.fldId INNER JOIN
                      Com.tblChartOrgan AS tblChartOrgan ON tblOrganizationalPosts.fldChartOrganId = tblChartOrgan.fldId  INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId left JOIN
                      Com.tblFile AS tblFile ON Com.tblEmployee_Detail.fldFileId = tblFile.fldId 
					 /*jadid*/ cross apply(select t.fldTypeEstekhamId from com.tblUser_Group u
											inner join pay.tblTypeEstekhdam_UserGroup t on t.fldUseGroupId=u.fldUserGroupId
											cross apply (select top(1) a.fldNoeEstekhdamId from prs.tblHistoryNoeEstekhdam  h
														inner join com.tblAnvaEstekhdam a on a.fldid=h.fldNoeEstekhdamId
														where fldPrsPersonalInfoId= Prs.Prs_tblPersonalInfo.fldid
														order by fldTarikh desc)history
							where fldUserSelectId=@userId and history.fldNoeEstekhdamId=t.fldTypeEstekhamId
							group by t.fldTypeEstekhamId)typeestekhdam
							OUTER apply(select top(1) s.fldShomareHesab from pay.tblMohasebat_Items as  i 
														inner join com.tblShomareHesabeOmoomi as s on s.fldId=i.fldShomareHesabItemId
														where i.fldMohasebatId=tblMohasebat_1.fldid and i.fldHesabTypeItemId=1)i
						OUTER apply(select top(1) s.fldShomareHesab from pay.[tblMohasebat_kosorat/MotalebatParam] as  i 
														inner join com.tblShomareHesabeOmoomi as s on s.fldId=i.fldShomareHesabParamId
														where i.fldMohasebatId=tblMohasebat_1.fldid and i.fldHesabTypeParamId=1)K
					   WHERE tblMohasebat_1.fldYear=@Year AND tblMohasebat_1.fldMonth=@Month AND tblMohasebat_1.fldNobatPardakht=@NobatPardakht 
					   AND tblMohasebat_PersonalInfo.fldChartOrganId=@value
					    AND Pay.tblMohasebat_PersonalInfo.fldOrganId=@organID and fldCalcType=@CalcType
						and(i.fldShomareHesab is not null or k.fldShomareHesab is not null)
ROLLBACK
GO
