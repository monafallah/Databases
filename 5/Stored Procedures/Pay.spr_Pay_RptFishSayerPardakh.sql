SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_Pay_RptFishSayerPardakh](@Sal SMALLINT ,@mah TINYINT,@PersonalId INT,@NobatPardakht TINYINT,@MarhalePardakht TINYINT,@Type TINYINT,@organId INT)
AS

--DECLARE @Sal SMALLINT ,@mah TINYINT,@PersonalId INT,@NobatPardakht TINYINT,@MarhalePardakht TINYINT
DECLARE @temp TABLE (fldName NVARCHAR(50),fldFamily NVARCHAR(100),fldFatherName NVARCHAR(50),fldShomareHesab NVARCHAR(50),fldPersonalId INT,fldTitle NVARCHAR(100), fldMablagh INT,fldType TINYINT,fldSal SMALLINT,fldmah NVARCHAR(20),fldKhalesPardakhti INT,MahaleKhedmat NVARCHAR(150),fldSh_Personali NVARCHAR(20))
INSERT INTO @temp( fldName ,fldFamily ,fldFatherName,fldShomareHesab ,fldPersonalId ,fldTitle ,fldMablagh ,fldType , fldSal ,fldmah,fldKhalesPardakhti,MahaleKhedmat,fldSh_Personali)
SELECT     tblEmployee.fldName, tblEmployee.fldFamily, fldFatherName,fldShomareHesab,Pay.Pay_tblPersonalInfo.fldId,fldTitle,fldAmount,CAST(1 AS TINYINT),@Sal,Com.fn_month(@mah) ,fldKhalesPardakhti,.Com.fn_MahaleKhedmat(Prs.Prs_tblPersonalInfo.fldId),fldSh_Personali
FROM         Pay.tblSayerPardakhts INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblSayerPardakhts.fldId = Pay.tblMohasebat_PersonalInfo.fldSayerPardakhthaId INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Pay.tblMohasebat_PersonalInfo.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblSayerPardakhts.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = Com.tblEmployee.fldId  INNER JOIN
                      Com.tblEmployee_Detail ON Com.tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId
                      WHERE fldYear=@Sal AND fldMonth=@mah AND fldNobatePardakt=@NobatPardakht AND fldMarhalePardakht=@MarhalePardakht AND Pay.tblMohasebat_PersonalInfo.fldOrganId=@OrganId
                      
INSERT INTO @temp( fldName ,fldFamily ,fldFatherName,fldShomareHesab ,fldPersonalId ,fldTitle ,fldMablagh ,fldType , fldSal ,fldmah,fldKhalesPardakhti,MahaleKhedmat,fldSh_Personali)                      
SELECT     tblEmployee.fldName, tblEmployee.fldFamily, fldFatherName,fldShomareHesab,Pay.Pay_tblPersonalInfo.fldId,N'مالیات',fldMaliyat,CAST(2 AS TINYINT) ,@Sal,Com.fn_month(@mah) ,fldKhalesPardakhti,.Com.fn_MahaleKhedmat(Prs.Prs_tblPersonalInfo.fldId),fldSh_Personali
FROM         Pay.tblSayerPardakhts INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblSayerPardakhts.fldId = Pay.tblMohasebat_PersonalInfo.fldSayerPardakhthaId INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Pay.tblMohasebat_PersonalInfo.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblSayerPardakhts.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = Com.tblEmployee.fldId  INNER JOIN
                      Com.tblEmployee_Detail ON Com.tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId
                       WHERE fldYear=@Sal AND fldMonth=@mah AND fldNobatePardakt=@NobatPardakht AND fldMarhalePardakht=@MarhalePardakht   AND Pay.tblMohasebat_PersonalInfo.fldOrganId=@OrganId
                       
  IF(@PersonalId<>0)
  BEGIN
	IF (@type=1)
  		SELECT * FROM @temp WHERE fldPersonalId=@PersonalId AND fldType=1
  	ELSE IF(@type=2)
  		SELECT * FROM @temp WHERE fldPersonalId=@PersonalId AND fldType=2
  	ELSE
  		SELECT fldName ,fldFamily ,fldFatherName,fldShomareHesab ,fldPersonalId ,'' AS fldTitle ,0 AS fldMablagh ,0 AS fldType , fldSal ,fldmah,fldKhalesPardakhti,MahaleKhedmat,fldSh_Personali FROM @temp	 WHERE fldPersonalId=@PersonalId
  		GROUP BY fldName ,fldFamily ,fldFatherName,fldShomareHesab ,fldPersonalId , fldSal ,fldmah,fldKhalesPardakhti,MahaleKhedmat,fldSh_Personali
  END    
  ELSE
  BEGIN
	IF (@type=1)
		SELECT * FROM @temp WHERE fldType=1
  	ELSE IF(@type=2)
  		SELECT * FROM @temp WHERE fldType=2
  	ELSE
  		SELECT fldName ,fldFamily ,fldFatherName,fldShomareHesab ,fldPersonalId ,'' AS fldTitle ,0 AS fldMablagh ,0 AS fldType , fldSal ,fldmah,fldKhalesPardakhti,MahaleKhedmat,fldSh_Personali FROM @temp	 
		GROUP BY fldName ,fldFamily ,fldFatherName,fldShomareHesab ,fldPersonalId , fldSal ,fldmah,fldKhalesPardakhti,MahaleKhedmat,fldSh_Personali
  END
GO
