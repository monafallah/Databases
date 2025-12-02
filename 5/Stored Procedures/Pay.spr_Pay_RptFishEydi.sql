SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_Pay_RptFishEydi](@Year SMALLINT,@Month TINYINT,@NobatPardakht TINYINT ,@Personal INT,@type TINYINT,@OrganId int)
as
--DECLARE @Year SMALLINT=1394,@Month TINYINT=4,@NobatPardakht TINYINT=1 ,@Personal INT=0
 --IF(@Personal<>0)
 --SET @Personal=0
DECLARE  @temp TABLE (fldMablagh INT,fldShomareHesab NVARCHAR(50),fldSh_Personali NVARCHAR(50),fldPersonalId INT,fldName NVARCHAR(50),fldFamily NVARCHAR(50),fldFatherName NVARCHAR(50),fldType TINYINT,Title NVARCHAR(50),fldMahaleKhedmat NVARCHAR(150))
IF(@Personal<>0)
BEGIN
INSERT INTO @temp( fldMablagh ,fldShomareHesab ,fldSh_Personali ,fldPersonalId ,fldName ,fldFamily ,fldFatherName ,fldType ,Title,fldMahaleKhedmat)
SELECT     Pay.tblMohasebat_Eydi.fldMablagh, Com.tblShomareHesabeOmoomi.fldShomareHesab, Prs.Prs_tblPersonalInfo.fldSh_Personali, Pay.Pay_tblPersonalInfo.fldId
,tblEmployee.fldName,tblEmployee.fldFamily,fldFatherName,CAST(1 AS TINYINT) fldType,N'مبلغ عیدی' AS Title,Com.fn_stringDecode(tblOrganization.fldName)+'_'+tblChartOrgan.fldTitle AS fldMahaleKhedmat
FROM         Pay.tblMohasebat_Eydi INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebat_Eydi.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatEydiId INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Pay.tblMohasebat_PersonalInfo.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblMohasebat_Eydi.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId=tblEmployee.fldId INNER JOIN
                      Com.tblOrganizationalPosts AS tblOrganizationalPosts ON Prs.Prs_tblPersonalInfo.fldOrganPostId=tblOrganizationalPosts.fldId INNER JOIN
                      Com.tblChartOrgan AS tblChartOrgan ON tblOrganizationalPosts.fldChartOrganId=tblChartOrgan.fldId INNER JOIN
                      Com.tblOrganization AS tblOrganization ON tblChartOrgan.fldOrganId=tblOrganization.fldId INNER JOIN 
                      Com.tblEmployee_Detail ON tblemployee.fldId =Com.tblEmployee_Detail.fldEmployeeId
                      WHERE Pay.tblMohasebat_Eydi.fldYear=@Year /*AND Pay.tblMohasebat_Eydi.fldMonth=@Month*/ AND Pay.tblMohasebat_Eydi.fldNobatPardakht=@NobatPardakht and tblMohasebat_PersonalInfo.fldOrganId=@OrganId AND Pay.tblMohasebat_Eydi.fldPersonalId=@Personal
                    AND Pay.tblMohasebat_PersonalInfo.fldOrganId=@OrganId
                      --AND tblOrganization.fldid IN (SELECT Id FROM Com.fn_GetOrganTree(@UserId))
                     
     
 
 INSERT INTO @temp( fldMablagh ,fldShomareHesab ,fldSh_Personali ,fldPersonalId ,fldName ,fldFamily ,fldFatherName ,fldType ,Title,fldMahaleKhedmat)    
  SELECT     Pay.tblMohasebat_Eydi.fldMaliyat, Com.tblShomareHesabeOmoomi.fldShomareHesab, Prs.Prs_tblPersonalInfo.fldSh_Personali, Pay.Pay_tblPersonalInfo.fldId
,tblEmployee.fldName,tblEmployee.fldFamily,fldFatherName,CAST(2 AS TINYINT) fldType,N'مالیات' AS Title,Com.fn_stringDecode(tblOrganization.fldName)+'_'+tblChartOrgan.fldTitle AS fldMahaleKhedmat
FROM         Pay.tblMohasebat_Eydi INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebat_Eydi.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatEydiId INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Pay.tblMohasebat_PersonalInfo.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblMohasebat_Eydi.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId=tblEmployee.fldId INNER JOIN
                      Com.tblOrganizationalPosts AS tblOrganizationalPosts ON Prs.Prs_tblPersonalInfo.fldOrganPostId=tblOrganizationalPosts.fldId INNER JOIN
                      Com.tblChartOrgan AS tblChartOrgan ON tblOrganizationalPosts.fldChartOrganId=tblChartOrgan.fldId INNER JOIN
                      Com.tblOrganization AS tblOrganization ON tblChartOrgan.fldOrganId=tblOrganization.fldId INNER JOIN 
                      Com.tblEmployee_Detail ON tblemployee.fldId =Com.tblEmployee_Detail.fldEmployeeId
                      WHERE Pay.tblMohasebat_Eydi.fldYear=@Year AND /*Pay.tblMohasebat_Eydi.fldMonth=@Month AND*/ Pay.tblMohasebat_Eydi.fldNobatPardakht=@NobatPardakht and tblMohasebat_PersonalInfo.fldOrganId=@OrganId AND Pay.tblMohasebat_Eydi.fldPersonalId=@Personal
					AND Pay.tblMohasebat_PersonalInfo.fldOrganId=@OrganId
					--AND tblOrganization.fldid IN (SELECT Id FROM Com.fn_GetOrganTree(@UserId))	
						
INSERT INTO @temp( fldMablagh ,fldShomareHesab ,fldSh_Personali ,fldPersonalId ,fldName ,fldFamily ,fldFatherName ,fldType ,Title,fldMahaleKhedmat)
SELECT     Pay.tblMohasebat_Eydi.fldKosurat, Com.tblShomareHesabeOmoomi.fldShomareHesab, Prs.Prs_tblPersonalInfo.fldSh_Personali, Pay.Pay_tblPersonalInfo.fldId
,tblEmployee.fldName,tblEmployee.fldFamily,fldFatherName,CAST(2 AS TINYINT) fldType,N'کسورات' AS Title,Com.fn_stringDecode(tblOrganization.fldName)+'_'+tblChartOrgan.fldTitle AS fldMahaleKhedmat
FROM         Pay.tblMohasebat_Eydi INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebat_Eydi.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatEydiId INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Pay.tblMohasebat_PersonalInfo.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblMohasebat_Eydi.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId=tblEmployee.fldId INNER JOIN
                      Com.tblOrganizationalPosts AS tblOrganizationalPosts ON Prs.Prs_tblPersonalInfo.fldOrganPostId=tblOrganizationalPosts.fldId INNER JOIN
                      Com.tblChartOrgan AS tblChartOrgan ON tblOrganizationalPosts.fldChartOrganId=tblChartOrgan.fldId  INNER JOIN
                      Com.tblOrganization AS tblOrganization ON tblChartOrgan.fldOrganId=tblOrganization.fldId INNER JOIN 
                      Com.tblEmployee_Detail ON tblemployee.fldId =Com.tblEmployee_Detail.fldEmployeeId
                      WHERE Pay.tblMohasebat_Eydi.fldYear=@Year /*AND Pay.tblMohasebat_Eydi.fldMonth=@Month*/ AND Pay.tblMohasebat_Eydi.fldNobatPardakht=@NobatPardakht and tblMohasebat_PersonalInfo.fldOrganId=@OrganId AND Pay.tblMohasebat_Eydi.fldPersonalId=@Personal
					 AND Pay.tblMohasebat_PersonalInfo.fldOrganId=@OrganId
					--AND tblOrganization.fldid IN (SELECT Id FROM Com.fn_GetOrganTree(@UserId))

IF(@type=1)
SELECT * FROM @temp WHERE fldType=1
else IF(@type=2)
SELECT * FROM @temp WHERE fldType=2 and fldMablagh<>0
ELSE
SELECT 0  AS fldMablagh,fldShomareHesab ,fldSh_Personali ,fldPersonalId ,fldName ,fldFamily ,fldFatherName ,0 AS fldType ,'' AS Title,fldMahaleKhedmat FROM @temp
GROUP BY fldShomareHesab ,fldSh_Personali ,fldPersonalId ,fldName ,fldFamily ,fldFatherName  ,fldMahaleKhedmat
END
ELSE
BEGIN
INSERT INTO @temp( fldMablagh ,fldShomareHesab ,fldSh_Personali ,fldPersonalId ,fldName ,fldFamily ,fldFatherName ,fldType ,Title,fldMahaleKhedmat)
SELECT     Pay.tblMohasebat_Eydi.fldMablagh, Com.tblShomareHesabeOmoomi.fldShomareHesab, Prs.Prs_tblPersonalInfo.fldSh_Personali, Pay.Pay_tblPersonalInfo.fldId
,tblEmployee.fldName,tblEmployee.fldFamily,fldFatherName,CAST(1 AS TINYINT) fldType,N'مبلغ عیدی' AS Title,Com.fn_stringDecode(tblOrganization.fldName)+'_'+tblChartOrgan.fldTitle AS fldMahaleKhedmat
FROM         Pay.tblMohasebat_Eydi INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebat_Eydi.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatEydiId INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Pay.tblMohasebat_PersonalInfo.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblMohasebat_Eydi.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId=tblEmployee.fldId INNER JOIN
                      Com.tblOrganizationalPosts AS tblOrganizationalPosts ON Prs.Prs_tblPersonalInfo.fldOrganPostId=tblOrganizationalPosts.fldId INNER JOIN
                      Com.tblChartOrgan AS tblChartOrgan ON tblOrganizationalPosts.fldChartOrganId=tblChartOrgan.fldId INNER JOIN
                      Com.tblOrganization AS tblOrganization ON tblChartOrgan.fldOrganId=tblOrganization.fldId INNER JOIN 
                      Com.tblEmployee_Detail ON tblemployee.fldId =Com.tblEmployee_Detail.fldEmployeeId
                                           WHERE Pay.tblMohasebat_Eydi.fldYear=@Year /*AND Pay.tblMohasebat_Eydi.fldMonth=@Month*/ AND Pay.tblMohasebat_Eydi.fldNobatPardakht=@NobatPardakht and tblMohasebat_PersonalInfo.fldOrganId=@OrganId
     --AND tblOrganization.fldid IN (SELECT Id FROM Com.fn_GetOrganTree(@UserId))
 
 INSERT INTO @temp( fldMablagh ,fldShomareHesab ,fldSh_Personali ,fldPersonalId ,fldName ,fldFamily ,fldFatherName ,fldType ,Title,fldMahaleKhedmat)    
  SELECT     Pay.tblMohasebat_Eydi.fldMaliyat, Com.tblShomareHesabeOmoomi.fldShomareHesab, Prs.Prs_tblPersonalInfo.fldSh_Personali, Pay.Pay_tblPersonalInfo.fldId
,tblEmployee.fldName,tblEmployee.fldFamily,fldFatherName,CAST(2 AS TINYINT) fldType,N'مالیات' AS Title,Com.fn_stringDecode(tblOrganization.fldName)+'_'+tblChartOrgan.fldTitle AS fldMahaleKhedmat
FROM         Pay.tblMohasebat_Eydi INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebat_Eydi.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatEydiId INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Pay.tblMohasebat_PersonalInfo.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblMohasebat_Eydi.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId=tblEmployee.fldId INNER JOIN
                      Com.tblOrganizationalPosts AS tblOrganizationalPosts ON Prs.Prs_tblPersonalInfo.fldOrganPostId=tblOrganizationalPosts.fldId INNER JOIN
                      Com.tblChartOrgan AS tblChartOrgan ON tblOrganizationalPosts.fldChartOrganId=tblChartOrgan.fldId INNER JOIN
                      Com.tblOrganization AS tblOrganization ON tblChartOrgan.fldOrganId=tblOrganization.fldId INNER JOIN 
                      Com.tblEmployee_Detail ON tblemployee.fldId =Com.tblEmployee_Detail.fldEmployeeId
                       WHERE Pay.tblMohasebat_Eydi.fldYear=@Year /*AND Pay.tblMohasebat_Eydi.fldMonth=@Month*/ AND Pay.tblMohasebat_Eydi.fldNobatPardakht=@NobatPardakht and tblMohasebat_PersonalInfo.fldOrganId=@OrganId
						--AND tblOrganization.fldid IN (SELECT Id FROM Com.fn_GetOrganTree(@UserId))

INSERT INTO @temp( fldMablagh ,fldShomareHesab ,fldSh_Personali ,fldPersonalId ,fldName ,fldFamily ,fldFatherName ,fldType ,Title,fldMahaleKhedmat)
SELECT     Pay.tblMohasebat_Eydi.fldKosurat, Com.tblShomareHesabeOmoomi.fldShomareHesab, Prs.Prs_tblPersonalInfo.fldSh_Personali, Pay.Pay_tblPersonalInfo.fldId
,tblEmployee.fldName,tblEmployee.fldFamily,fldFatherName,CAST(2 AS TINYINT) fldType,N'کسورات' AS Title,Com.fn_stringDecode(tblOrganization.fldName)+'_'+tblChartOrgan.fldTitle AS fldMahaleKhedmat
FROM         Pay.tblMohasebat_Eydi INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebat_Eydi.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatEydiId INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Pay.tblMohasebat_PersonalInfo.fldShomareHesabId =Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblMohasebat_Eydi.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId=tblEmployee.fldId INNER JOIN
                      Com.tblOrganizationalPosts AS tblOrganizationalPosts ON Prs.Prs_tblPersonalInfo.fldOrganPostId=tblOrganizationalPosts.fldId INNER JOIN
                      Com.tblChartOrgan AS tblChartOrgan ON tblOrganizationalPosts.fldChartOrganId=tblChartOrgan.fldId INNER JOIN
                      Com.tblOrganization AS tblOrganization ON tblChartOrgan.fldOrganId=tblOrganization.fldId INNER JOIN 
                      Com.tblEmployee_Detail ON tblemployee.fldId =Com.tblEmployee_Detail.fldEmployeeId
                 WHERE Pay.tblMohasebat_Eydi.fldYear=@Year /*AND Pay.tblMohasebat_Eydi.fldMonth=@Month*/ AND Pay.tblMohasebat_Eydi.fldNobatPardakht=@NobatPardakht and tblMohasebat_PersonalInfo.fldOrganId=@OrganId
				--AND tblOrganization.fldid IN (SELECT Id FROM Com.fn_GetOrganTree(@UserId))

IF(@type=1)
SELECT * FROM @temp WHERE fldType=1
ELSE IF(@type=2)
SELECT * FROM @temp WHERE fldType=2  and fldMablagh<>0
ELSE
BEGIN
SELECT 0  AS fldMablagh,fldShomareHesab ,fldSh_Personali ,fldPersonalId ,fldName ,fldFamily ,fldFatherName ,0 AS fldType ,'' AS Title,fldMahaleKhedmat FROM @temp
GROUP BY fldShomareHesab ,fldSh_Personali ,fldPersonalId ,fldName ,fldFamily ,fldFatherName  ,fldMahaleKhedmat
end
END
GO
