SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_Pay_RptFishMorakhasi](@Year SMALLINT,@Month TINYINT,@NobatPardakht TINYINT,@PersonalId INT,@organId INT,@type TINYINT)
AS
--DECLARE @Year SMALLINT,@Month TINYINT,@NobatPardakht TINYINT,@PersonalId INT
DECLARE @temp TABLE (fldName NVARCHAR(50),fldFamily NVARCHAR(100),fldSh_Personali NVARCHAR(50),fldShomareHesab NVARCHAR(50),fldFatherName NVARCHAR(50),fldPersonalId INT,fldTitle NVARCHAR(50),fldMablagh INT,MahaleKhedmat NVARCHAR(150),fldtype TINYINT)
INSERT INTO @temp( fldName ,fldFamily ,fldSh_Personali ,fldShomareHesab,fldFatherName , fldPersonalId ,fldTitle ,fldMablagh,MahaleKhedmat,fldtype)
SELECT tblEmployee.fldName,tblEmployee.fldFamily,fldSh_Personali,fldShomareHesab,fldFatherName,Pay.Pay_tblPersonalInfo.fldId,N'تعداد ساعت',fldTedad,.Com.fn_MahaleKhedmat(Prs.Prs_tblPersonalInfo.fldId),1
FROM         Pay.tblMohasebat_Morakhasi INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebat_Morakhasi.fldId = Pay.tblMohasebat_PersonalInfo.fldMorakhasiId INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Pay.tblMohasebat_PersonalInfo.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Pay.Pay_tblPersonalInfo ON  Pay.tblMohasebat_Morakhasi.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId=tblEmployee.fldId INNER JOIN 
                      Com.tblEmployee_Detail ON tblEmployee.fldid=Com.tblEmployee_Detail.fldEmployeeId
                      WHERE fldYear=@Year AND fldMonth=@Month AND fldNobatPardakht=@NobatPardakht AND Pay.tblMohasebat_PersonalInfo.fldOrganId=@OrganId
   
                      
 INSERT INTO @temp( fldName ,fldFamily ,fldSh_Personali ,fldShomareHesab,fldFatherName , fldPersonalId ,fldTitle ,fldMablagh,MahaleKhedmat,fldtype)                     
SELECT tblEmployee.fldName,tblEmployee.fldFamily,fldSh_Personali,fldShomareHesab,fldFatherName,Pay.Pay_tblPersonalInfo.fldId,N'مبلغ مرخصی',fldMablagh, .Com.fn_MahaleKhedmat(Prs.Prs_tblPersonalInfo.fldId)   ,1
FROM         Pay.tblMohasebat_Morakhasi INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebat_Morakhasi.fldId = Pay.tblMohasebat_PersonalInfo.fldMorakhasiId INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Pay.tblMohasebat_PersonalInfo.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Pay.Pay_tblPersonalInfo ON  Pay.tblMohasebat_Morakhasi.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId=tblEmployee.fldId INNER JOIN 
                      Com.tblEmployee_Detail ON tblEmployee.fldid=Com.tblEmployee_Detail.fldEmployeeId 
                       WHERE fldYear=@Year AND fldMonth=@Month AND fldNobatPardakht=@NobatPardakht  AND Pay.tblMohasebat_PersonalInfo.fldOrganId=@OrganId     
                       
                       
 IF(@PersonalId<>0)
 BEGIN
	IF(@type=1)
	SELECT * FROM @temp WHERE fldPersonalId=@PersonalId AND fldtype=@type
	ELSE
	SELECT * FROM @temp WHERE fldPersonalId=@PersonalId
 end
 ELSE
 BEGIN
 IF(@type=1)
 SELECT * FROM @temp  WHERE fldtype=@type
 ELSE
 SELECT fldName ,fldFamily ,fldSh_Personali ,fldShomareHesab,fldFatherName , fldPersonalId ,'' fldTitle ,0 AS fldMablagh,MahaleKhedmat,0 AS fldtype FROM @temp
 GROUP BY fldName ,fldFamily ,fldSh_Personali ,fldShomareHesab,fldFatherName , fldPersonalId,MahaleKhedmat
 end
GO
