SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_Pay_rptFishHoghoghi]

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

--declare
-- @fieldName NVARCHAR(50)='',
--@value INT='',
--@NobatPardakht TINYINT=1,
--@Year SMALLINT=1403,
--@Month TINYINT=9,
--@organID INT=1
--,@userId int=1

IF(@fieldName='fldPersonalId')
SELECT     Pay.Pay_tblPersonalInfo.fldId AS fldPersonalId, tblEmployee.fldName + ' ' + tblEmployee.fldFamily AS fldName, Com.tblEmployee_Detail.fldFatherName, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali, tblEmployee.fldCodemeli, (SELECT Com.fn_stringDecode(tblOrganization.fldName) FROM Com.tblOrganization WHERE fldId=com.fn_OrganName(fldOrganPostId)) + '_' + tblChartOrgan.fldTitle AS fldServiceLocationTitle, 
                      Com.tblShomareHesabeOmoomi.fldShomareHesab, tblMohasebat_1.fldMashmolBime + ISNULL
                          ((SELECT     SUM(fldMashmolBime) AS Expr1
                              FROM         Pay.tblMoavaghat
                              WHERE     (fldMohasebatId = tblMohasebat_1.fldId)), 0) AS fldMashmolBime, tblMohasebat_1.fldBimeKarFarma + tblMohasebat_1.fldBimeBikari + ISNULL
                          ((SELECT     SUM(fldBimeKarFarma + fldBimeBikari) AS Expr1
                              FROM         Pay.tblMoavaghat AS tblMoavaghat_1
                              WHERE     (fldMohasebatId = tblMohasebat_1.fldId)), 0) AS fldBimeKarFarma, (SELECT SUM(Pay.tblMandehPasAndaz.FldMablagh)  FROM Pay.tblMandehPasAndaz WHERE fldPersonalId=Pay.Pay_tblPersonalInfo.fldId)  + ISNULL
                          ((SELECT    ISNULL( SUM(fldPasAndaz),0) AS Expr1
                              FROM         Pay.tblMohasebat
                              WHERE     (fldPersonalId = Pay.Pay_tblPersonalInfo.fldId)) +
                          (SELECT    ISNULL( SUM(fldPasAndaz),0) AS Expr1
                            FROM          Pay.tblMoavaghat AS tblMoavaghat_6
                            WHERE      (fldMohasebatId = tblMohasebat_1.fldId)), 0) AS fldMandePasAndaz, tblMohasebat_1.fldMashmolMaliyat + ISNULL
                          ((SELECT     SUM(fldMashmolMaliyat) AS Expr1
                              FROM         Pay.tblMoavaghat AS tblMoavaghat_5
                              WHERE     (fldMohasebatId = tblMohasebat_1.fldId)), 0) AS fldMashmolMaliyat, tblMohasebat_1.fldKarkard, CONVERT(INT, ROUND( (tblMohasebat_1.fldTedadEzafeKar), 0)) AS fldEzafeKar, 
                      tblMohasebat_1.fldGheybat, tblMohasebat_1.fldBaBeytute + tblMohasebat_1.fldBedunBeytute AS fldMamoriyat, CONVERT(INT, ROUND( (tblMohasebat_1.fldTedadTatilKar/7.33), 0)) AS fldTatilKar,fldEstelagi, 
                      tblMohasebat_1.fldYear, Com.fn_month(tblMohasebat_1.fldMonth) AS fldMonth, Com.fn_MandeVam(tblMohasebat_1.fldYear, tblMohasebat_1.fldMonth, 
                      tblMohasebat_1.fldPersonalId) AS fldMandeVam,fldshift,tblMohasebat_1.fldTedadNobatKari
					  ,tblFile.fldImage,fldTypeEstekhamId 
FROM         Prs.Prs_tblPersonalInfo INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Prs.Prs_tblPersonalInfo.fldId = Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId INNER JOIN
                      Pay.tblMohasebat AS tblMohasebat_1 ON Pay.Pay_tblPersonalInfo.fldId = tblMohasebat_1.fldPersonalId INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON tblMohasebat_1.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatId  INNER JOIN
					  com.tblAnvaEstekhdam as a on a.fldId=tblMohasebat_PersonalInfo.fldAnvaEstekhdamId inner join
                      Com.tblOrganizationalPosts AS tblOrganizationalPosts ON Prs.Prs_tblPersonalInfo.fldOrganPostId = tblOrganizationalPosts.fldId INNER JOIN
                      Com.tblChartOrgan AS tblChartOrgan ON tblOrganizationalPosts.fldChartOrganId = tblChartOrgan.fldId left JOIN
                      /*Com.tblOrganization AS tblOrgan ON tblChartOrgan.fldOrganId = tblOrgan.fldId INNER JOIN*/
                      Com.tblShomareHesabeOmoomi ON Pay.tblMohasebat_PersonalInfo.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
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
					 WHERE tblMohasebat_1.fldYear=@Year AND tblMohasebat_1.fldMonth=@Month AND tblMohasebat_1.fldNobatPardakht=@NobatPardakht AND tblMohasebat_1.fldPersonalId=@value
                     and fldCalcType=@CalcType
					-- AND tblOrgan.fldId IN (SELECT Id FROM .Com.fn_GetOrganTree(@UserId))
					 AND Pay.tblMohasebat_PersonalInfo.fldOrganId=@organID
                      
IF(@fieldName='')
SELECT     Pay.Pay_tblPersonalInfo.fldId AS fldPersonalId, tblEmployee.fldName + ' ' + tblEmployee.fldFamily AS fldName,fldFatherName, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali, tblEmployee.fldCodemeli, (SELECT Com.fn_stringDecode(tblOrganization.fldName) FROM Com.tblOrganization WHERE fldId=com.fn_OrganName(fldOrganPostId)) + '_' + tblChartOrgan.fldTitle AS fldServiceLocationTitle, 
                      Com.tblShomareHesabeOmoomi.fldShomareHesab, tblMohasebat_1.fldMashmolBime + ISNULL
                          ((SELECT     SUM(fldMashmolBime) AS Expr1
                              FROM         Pay.tblMoavaghat
                              WHERE     (fldMohasebatId = tblMohasebat_1.fldId)), 0) AS fldMashmolBime, tblMohasebat_1.fldBimeKarFarma+tblMohasebat_1.fldBimeBikari + ISNULL
                          ((SELECT     SUM(fldBimeKarFarma+tblMoavaghat_1.fldBimeBikari) AS Expr1
                              FROM         Pay.tblMoavaghat AS tblMoavaghat_1
                              WHERE     (fldMohasebatId = tblMohasebat_1.fldId)), 0) AS fldBimeKarFarma,(SELECT ISNULL(SUM(Pay.tblMandehPasAndaz.FldMablagh),0)  FROM Pay.tblMandehPasAndaz WHERE fldPersonalId=Pay.Pay_tblPersonalInfo.fldId) + ISNULL
                          ((SELECT     ISNULL(SUM(fldPasAndaz),0) AS Expr1
                              FROM         Pay.tblMohasebat
                              WHERE     (fldPersonalId = pay.pay_tblPersonalInfo.fldId)) +
                          (SELECT     ISNULL(SUM(fldPasAndaz),0) AS Expr1
                            FROM          Pay.tblMoavaghat AS tblMoavaghat_6
                            WHERE      (fldMohasebatId = tblMohasebat_1.fldId)), 0) AS fldMandePasAndaz, tblMohasebat_1.fldMashmolMaliyat + ISNULL
                          ((SELECT     SUM(cast(fldMashmolMaliyat as bigint)) AS Expr1
                              FROM         Pay.tblMoavaghat AS tblMoavaghat_5
                              WHERE     (fldMohasebatId = tblMohasebat_1.fldId)), 0) AS fldMashmolMaliyat, tblMohasebat_1.fldKarkard, 
                      CONVERT(INT, ROUND( (tblMohasebat_1.fldTedadEzafeKar), 0)) AS fldEzafeKar, tblMohasebat_1.fldGheybat, 
                      tblMohasebat_1.fldBaBeytute + tblMohasebat_1.fldBedunBeytute AS fldMamoriyat, CONVERT(INT, ROUND( (tblMohasebat_1.fldTedadTatilKar/7.33), 0)) AS fldTatilKar,fldEstelagi,
                      tblMohasebat_1.fldYear, Com.fn_month(tblMohasebat_1.fldMonth) AS fldMonth, Com.fn_MandeVam(tblMohasebat_1.fldYear, 
                      tblMohasebat_1.fldMonth, tblMohasebat_1.fldPersonalId) AS fldMandeVam,fldshift,tblMohasebat_1.fldTedadNobatKari
					  ,tblFile.fldImage,fldTypeEstekhamId 
FROM         Prs.Prs_tblPersonalInfo INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Prs.Prs_tblPersonalInfo.fldId = Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId INNER JOIN
                      Pay.tblMohasebat AS tblMohasebat_1 ON Pay.Pay_tblPersonalInfo.fldId = tblMohasebat_1.fldPersonalId INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON tblMohasebat_1.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatId INNER JOIN
					  com.tblAnvaEstekhdam as a on a.fldId=tblMohasebat_PersonalInfo.fldAnvaEstekhdamId inner join
                      Com.tblOrganizationalPosts AS tblOrganizationalPosts ON Prs.Prs_tblPersonalInfo.fldOrganPostId = tblOrganizationalPosts.fldId INNER JOIN
                      Com.tblChartOrgan AS tblChartOrgan ON tblOrganizationalPosts.fldChartOrganId = tblChartOrgan.fldId INNER JOIN                      
                      Com.tblShomareHesabeOmoomi ON Pay.tblMohasebat_PersonalInfo.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN 
                      Com.tblEmployee_Detail ON tblEmployee.fldId=Com.tblEmployee_Detail.fldEmployeeId left JOIN
                      Com.tblFile AS tblFile ON Com.tblEmployee_Detail.fldFileId = tblFile.fldId 
                     /*jadid*/ cross apply(select t.fldTypeEstekhamId from com.tblUser_Group u
											inner join pay.tblTypeEstekhdam_UserGroup t on t.fldUseGroupId=u.fldUserGroupId
											cross apply (select top(1) a.fldNoeEstekhdamId from prs.tblHistoryNoeEstekhdam  h
														inner join com.tblAnvaEstekhdam a on a.fldid=h.fldNoeEstekhdamId
														where fldPrsPersonalInfoId= Prs.Prs_tblPersonalInfo.fldid
														order by fldTarikh desc)history
							where fldUserSelectId=@userId and history.fldNoeEstekhdamId=t.fldTypeEstekhamId
							group by t.fldTypeEstekhamId)typeestekhdam
					   WHERE tblMohasebat_1.fldYear=@Year AND tblMohasebat_1.fldMonth=@Month AND tblMohasebat_1.fldNobatPardakht=@NobatPardakht 
                       --  AND tblOrgan.fldId IN (SELECT Id FROM .Com.fn_GetOrganTree(@UserId))
					   AND Pay.tblMohasebat_PersonalInfo.fldOrganId=@organID and fldCalcType=@CalcType
IF(@fieldName='CostCenter')
SELECT     Pay.Pay_tblPersonalInfo.fldId AS fldPersonalId, tblEmployee.fldName + ' ' + tblEmployee.fldFamily AS fldName,fldFatherName, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali, tblEmployee.fldCodemeli,(SELECT Com.fn_stringDecode(tblOrganization.fldName) FROM Com.tblOrganization WHERE fldId=com.fn_OrganName(fldOrganPostId)) + '_' + tblChartOrgan.fldTitle AS fldServiceLocationTitle, 
                      Com.tblShomareHesabeOmoomi.fldShomareHesab, tblMohasebat_1.fldMashmolBime + ISNULL
                          ((SELECT     SUM(fldMashmolBime) AS Expr1
                              FROM         Pay.tblMoavaghat
                              WHERE     (fldMohasebatId = tblMohasebat_1.fldId)), 0) AS fldMashmolBime, tblMohasebat_1.fldBimeKarFarma+tblMohasebat_1.fldBimeBikari + ISNULL
                          ((SELECT     SUM(fldBimeKarFarma+tblMoavaghat_1.fldBimeBikari) AS Expr1
                              FROM         Pay.tblMoavaghat AS tblMoavaghat_1
                              WHERE     (fldMohasebatId = tblMohasebat_1.fldId)), 0) AS fldBimeKarFarma,(SELECT ISNULL(SUM(Pay.tblMandehPasAndaz.FldMablagh),0)  FROM Pay.tblMandehPasAndaz WHERE fldPersonalId=Pay.Pay_tblPersonalInfo.fldId) + ISNULL
                          ((SELECT     ISNULL(SUM(fldPasAndaz),0) AS Expr1
                              FROM         Pay.tblMohasebat
                              WHERE     (fldPersonalId = pay.pay_tblPersonalInfo.fldId)) +
                          (SELECT     ISNULL(SUM(fldPasAndaz),0) AS Expr1
                            FROM          Pay.tblMoavaghat AS tblMoavaghat_6
                            WHERE      (fldMohasebatId = tblMohasebat_1.fldId)), 0) AS fldMandePasAndaz, tblMohasebat_1.fldMashmolMaliyat + ISNULL
                          ((SELECT     SUM(fldMashmolMaliyat) AS Expr1
                              FROM         Pay.tblMoavaghat AS tblMoavaghat_5
                              WHERE     (fldMohasebatId = tblMohasebat_1.fldId)), 0) AS fldMashmolMaliyat, tblMohasebat_1.fldKarkard, 
                      CONVERT(INT, ROUND( (tblMohasebat_1.fldTedadEzafeKar), 0)) AS fldEzafeKar, tblMohasebat_1.fldGheybat, 
                      tblMohasebat_1.fldBaBeytute + tblMohasebat_1.fldBedunBeytute AS fldMamoriyat, CONVERT(INT, ROUND( (tblMohasebat_1.fldTedadTatilKar/7.33), 0)) AS fldTatilKar,fldEstelagi,
                      tblMohasebat_1.fldYear, Com.fn_month(tblMohasebat_1.fldMonth) AS fldMonth, Com.fn_MandeVam(tblMohasebat_1.fldYear, 
                      tblMohasebat_1.fldMonth, tblMohasebat_1.fldPersonalId) AS fldMandeVam,fldshift,tblMohasebat_1.fldTedadNobatKari
					  ,tblFile.fldImage,fldTypeEstekhamId 
FROM         Prs.Prs_tblPersonalInfo INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Prs.Prs_tblPersonalInfo.fldId = Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId INNER JOIN
                      Pay.tblMohasebat AS tblMohasebat_1 ON Pay.Pay_tblPersonalInfo.fldId = tblMohasebat_1.fldPersonalId INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON tblMohasebat_1.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatId INNER JOIN
					  com.tblAnvaEstekhdam as a on a.fldId=tblMohasebat_PersonalInfo.fldAnvaEstekhdamId inner join
                      Com.tblOrganizationalPosts AS tblOrganizationalPosts ON Prs.Prs_tblPersonalInfo.fldOrganPostId = tblOrganizationalPosts.fldId INNER JOIN
                      Com.tblChartOrgan AS tblChartOrgan ON tblOrganizationalPosts.fldChartOrganId = tblChartOrgan.fldId INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Pay.tblMohasebat_PersonalInfo.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN 
                      Com.tblEmployee_Detail ON tblEmployee.fldId=Com.tblEmployee_Detail.fldEmployeeId left JOIN
                      Com.tblFile AS tblFile ON Com.tblEmployee_Detail.fldFileId = tblFile.fldId 
                      /*jadid*/ cross apply(select t.fldTypeEstekhamId from com.tblUser_Group u
											inner join pay.tblTypeEstekhdam_UserGroup t on t.fldUseGroupId=u.fldUserGroupId
											cross apply (select top(1) a.fldNoeEstekhdamId from prs.tblHistoryNoeEstekhdam  h
														inner join com.tblAnvaEstekhdam a on a.fldid=h.fldNoeEstekhdamId
														where fldPrsPersonalInfoId= Prs.Prs_tblPersonalInfo.fldid
														order by fldTarikh desc)history
							where fldUserSelectId=@userId and history.fldNoeEstekhdamId=t.fldTypeEstekhamId
							group by t.fldTypeEstekhamId)typeestekhdam
					   WHERE tblMohasebat_1.fldYear=@Year AND tblMohasebat_1.fldMonth=@Month AND tblMohasebat_1.fldNobatPardakht=@NobatPardakht 
					   AND tblMohasebat_PersonalInfo.fldCostCenterId=@value
					    AND Pay.tblMohasebat_PersonalInfo.fldOrganId=@organID and fldCalcType=@CalcType
IF(@fieldName='ChartOrgan')
SELECT     Pay.Pay_tblPersonalInfo.fldId AS fldPersonalId, tblEmployee.fldName + ' ' + tblEmployee.fldFamily AS fldName,fldFatherName, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali, tblEmployee.fldCodemeli, (SELECT Com.fn_stringDecode(tblOrganization.fldName) FROM Com.tblOrganization WHERE fldId=com.fn_OrganName(fldOrganPostId)) + '_' + tblChartOrgan.fldTitle AS fldServiceLocationTitle, 
                      Com.tblShomareHesabeOmoomi.fldShomareHesab, tblMohasebat_1.fldMashmolBime + ISNULL
                          ((SELECT     SUM(fldMashmolBime) AS Expr1
                              FROM         Pay.tblMoavaghat
                              WHERE     (fldMohasebatId = tblMohasebat_1.fldId)), 0) AS fldMashmolBime, tblMohasebat_1.fldBimeKarFarma+tblMohasebat_1.fldBimeBikari + ISNULL
                          ((SELECT     SUM(fldBimeKarFarma+tblMoavaghat_1.fldBimeBikari) AS Expr1
                              FROM         Pay.tblMoavaghat AS tblMoavaghat_1
                              WHERE     (fldMohasebatId = tblMohasebat_1.fldId)), 0) AS fldBimeKarFarma,(SELECT ISNULL(SUM(Pay.tblMandehPasAndaz.FldMablagh),0)  FROM Pay.tblMandehPasAndaz WHERE fldPersonalId=Pay.Pay_tblPersonalInfo.fldId) + ISNULL
                          ((SELECT     ISNULL(SUM(fldPasAndaz),0) AS Expr1
                              FROM         Pay.tblMohasebat
                              WHERE     (fldPersonalId = pay.pay_tblPersonalInfo.fldId)) +
                          (SELECT     ISNULL(SUM(fldPasAndaz),0) AS Expr1
                            FROM          Pay.tblMoavaghat AS tblMoavaghat_6
                            WHERE      (fldMohasebatId = tblMohasebat_1.fldId)), 0) AS fldMandePasAndaz, tblMohasebat_1.fldMashmolMaliyat + ISNULL
                          ((SELECT     SUM(fldMashmolMaliyat) AS Expr1
                              FROM         Pay.tblMoavaghat AS tblMoavaghat_5
                              WHERE     (fldMohasebatId = tblMohasebat_1.fldId)), 0) AS fldMashmolMaliyat, tblMohasebat_1.fldKarkard, 
                      CONVERT(INT, ROUND( (tblMohasebat_1.fldTedadEzafeKar), 0)) AS fldEzafeKar, tblMohasebat_1.fldGheybat, 
                      tblMohasebat_1.fldBaBeytute + tblMohasebat_1.fldBedunBeytute AS fldMamoriyat, CONVERT(INT, ROUND( (tblMohasebat_1.fldTedadTatilKar/7.33), 0)) AS fldTatilKar,fldEstelagi,
                      tblMohasebat_1.fldYear, Com.fn_month(tblMohasebat_1.fldMonth) AS fldMonth, Com.fn_MandeVam(tblMohasebat_1.fldYear, 
                      tblMohasebat_1.fldMonth, tblMohasebat_1.fldPersonalId) AS fldMandeVam,fldshift,tblMohasebat_1.fldTedadNobatKari
					  ,tblFile.fldImage,fldTypeEstekhamId 
FROM         Prs.Prs_tblPersonalInfo INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Prs.Prs_tblPersonalInfo.fldId = Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId INNER JOIN
                      Pay.tblMohasebat AS tblMohasebat_1 ON Pay.Pay_tblPersonalInfo.fldId = tblMohasebat_1.fldPersonalId INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON tblMohasebat_1.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatId INNER JOIN
					  com.tblAnvaEstekhdam as a on a.fldId=tblMohasebat_PersonalInfo.fldAnvaEstekhdamId inner join
                      Com.tblOrganizationalPostsEjraee AS tblOrganizationalPosts ON Prs.Prs_tblPersonalInfo.fldOrganPostEjraeeId = tblOrganizationalPosts.fldId INNER JOIN
                      Com.tblChartOrganEjraee AS tblChartOrgan ON tblOrganizationalPosts.fldChartOrganId = tblChartOrgan.fldId INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Pay.tblMohasebat_PersonalInfo.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN 
                      Com.tblEmployee_Detail ON tblEmployee.fldId=Com.tblEmployee_Detail.fldEmployeeId left JOIN
                      Com.tblFile AS tblFile ON Com.tblEmployee_Detail.fldFileId = tblFile.fldId 
                       /*jadid*/ cross apply(select t.fldTypeEstekhamId from com.tblUser_Group u
											inner join pay.tblTypeEstekhdam_UserGroup t on t.fldUseGroupId=u.fldUserGroupId
											cross apply (select top(1) a.fldNoeEstekhdamId from prs.tblHistoryNoeEstekhdam  h
														inner join com.tblAnvaEstekhdam a on a.fldid=h.fldNoeEstekhdamId
														where fldPrsPersonalInfoId= Prs.Prs_tblPersonalInfo.fldid
														order by fldTarikh desc)history
							where fldUserSelectId=@userId and history.fldNoeEstekhdamId=t.fldTypeEstekhamId
							group by t.fldTypeEstekhamId)typeestekhdam
					   WHERE tblMohasebat_1.fldYear=@Year AND tblMohasebat_1.fldMonth=@Month AND tblMohasebat_1.fldNobatPardakht=@NobatPardakht 
					   AND tblMohasebat_PersonalInfo.fldChartOrganId=@value
					    AND Pay.tblMohasebat_PersonalInfo.fldOrganId=@organID and fldCalcType=@CalcType
ROLLBACK
GO
