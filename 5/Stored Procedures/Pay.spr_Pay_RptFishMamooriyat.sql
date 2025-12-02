SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_Pay_RptFishMamooriyat](@Sal SMALLINT,@mah TINYINT ,@PersonalId INT ,@NobatPardakht TINYINT ,@type TINYINT,@organId int
)
as
--DECLARE @Sal SMALLINT,@mah TINYINT ,@PersonalId INT ,@NobatPardakht TINYINT ,@type TINYINT
DECLARE @t TABLE (fldName NVARCHAR(50),fldFamily NVARCHAR(100),fldFatherName NVARCHAR(50),fldShomareHesab NVARCHAR(50),PersonalId INT,Mablagh  INT,Title NVARCHAR(50),fldType TINYINT,sal SMALLINT,mah NVARCHAR(50),MahaleKhedmat NVARCHAR(150),fldSh_Personali NVARCHAR(50))
INSERT INTO @t( fldName ,fldFamily ,fldFatherName ,fldShomareHesab ,PersonalId ,Mablagh ,Title ,fldType ,sal ,mah,MahaleKhedmat ,fldSh_Personali)
SELECT   tblEmployee.fldName,tblEmployee.fldFamily,fldFatherName,fldShomareHesab,Pay.Pay_tblPersonalInfo.fldId,fldTashilat,N'تسهیلات',CAST(1 AS TINYINT)  ,@sal,Com.fn_month(@mah),.Com.fn_MahaleKhedmat(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId)
,fldSh_Personali
FROM         Pay.tblMohasebat_Mamuriyat INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebat_Mamuriyat.fldId = Pay.tblMohasebat_PersonalInfo.fldMamuriyatId INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblMohasebat_Mamuriyat.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Pay.tblMohasebat_PersonalInfo.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId
                      WHERE fldYear=@Sal AND fldMonth=@mah AND fldNobatePardakht=@NobatPardakht AND Pay.tblMohasebat_PersonalInfo.fldOrganId=@OrganId
                      
INSERT INTO @t( fldName ,fldFamily ,fldFatherName ,fldShomareHesab ,PersonalId ,Mablagh ,Title ,fldType ,sal ,mah,MahaleKhedmat,fldSh_Personali )                      
 SELECT   tblEmployee.fldName,tblEmployee.fldFamily,fldFatherName,fldShomareHesab,Pay.Pay_tblPersonalInfo.fldId,fldTedadBaBeytute+fldTedadBedunBeytute,N'تعداد',CAST(1 AS TINYINT) ,@sal,Com.fn_month(@mah)  ,.Com.fn_MahaleKhedmat(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId)
,fldSh_Personali

FROM         Pay.tblMohasebat_Mamuriyat INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebat_Mamuriyat.fldId = Pay.tblMohasebat_PersonalInfo.fldMamuriyatId INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblMohasebat_Mamuriyat.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Pay.tblMohasebat_PersonalInfo.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId
                      WHERE fldYear=@Sal AND fldMonth=@mah AND fldNobatePardakht=@NobatPardakht AND Pay.tblMohasebat_PersonalInfo.fldOrganId=@OrganId
                           
 INSERT INTO @t( fldName ,fldFamily ,fldFatherName ,fldShomareHesab ,PersonalId ,Mablagh ,Title ,fldType ,sal ,mah ,MahaleKhedmat,fldSh_Personali)                     
SELECT   tblEmployee.fldName,tblEmployee.fldFamily,fldFatherName,fldShomareHesab,Pay.Pay_tblPersonalInfo.fldId,fldMaliyat,N'مالیات',CAST(2 AS TINYINT)  ,@sal,Com.fn_month(@mah)   ,.Com.fn_MahaleKhedmat(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId)
,fldSh_Personali

FROM         Pay.tblMohasebat_Mamuriyat INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebat_Mamuriyat.fldId = Pay.tblMohasebat_PersonalInfo.fldMamuriyatId INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblMohasebat_Mamuriyat.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Pay.tblMohasebat_PersonalInfo.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId
                      WHERE fldYear=@Sal AND fldMonth=@mah AND fldNobatePardakht=@NobatPardakht AND Pay.tblMohasebat_PersonalInfo.fldOrganId=@OrganId
                      
 INSERT INTO @t( fldName ,fldFamily ,fldFatherName ,fldShomareHesab ,PersonalId ,Mablagh ,Title ,fldType ,sal ,mah ,MahaleKhedmat,fldSh_Personali)                     
SELECT   tblEmployee.fldName,tblEmployee.fldFamily,fldFatherName,fldShomareHesab,Pay.Pay_tblPersonalInfo.fldId,fldBimePersonal,N'بیمه پرسنل',CAST(2 AS TINYINT) ,@sal,Com.fn_month(@mah)    ,.Com.fn_MahaleKhedmat(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId)
,fldSh_Personali

FROM         Pay.tblMohasebat_Mamuriyat INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebat_Mamuriyat.fldId = Pay.tblMohasebat_PersonalInfo.fldMamuriyatId INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblMohasebat_Mamuriyat.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Pay.tblMohasebat_PersonalInfo.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId
                      WHERE fldYear=@Sal AND fldMonth=@mah AND fldNobatePardakht=@NobatPardakht  AND Pay.tblMohasebat_PersonalInfo.fldOrganId=@OrganId 
                      
 IF(@PersonalId<>0)
 BEGIN
 	IF(@type=1)
 	SELECT * FROM @t WHERE PersonalId=@PersonalId AND fldType=1
 	ELSE IF(@type=2)
 	SELECT * FROM @t WHERE PersonalId=@PersonalId AND fldType=2
 	ELSE 
 	SELECT fldName ,fldFamily ,fldFatherName ,fldShomareHesab ,PersonalId ,0 AS Mablagh ,'' AS Title ,0 AS fldType ,sal ,mah,MahaleKhedmat ,fldSh_Personali FROM @t WHERE PersonalId=@PersonalId
 	GROUP BY fldName ,fldFamily ,fldFatherName ,fldShomareHesab ,PersonalId  ,sal ,mah,MahaleKhedmat ,fldSh_Personali 
 END         
 ELSE

 BEGIN
 	IF(@type=1)
 	SELECT * FROM @t WHERE fldType=1
 	ELSE IF(@type=2)
 	SELECT * FROM @t WHERE fldType=2
 	ELSE 
 	SELECT fldName ,fldFamily ,fldFatherName ,fldShomareHesab ,PersonalId ,0 AS Mablagh ,'' AS Title ,0 AS fldType ,sal ,mah,MahaleKhedmat ,fldSh_Personali FROM @t
	 	GROUP BY fldName ,fldFamily ,fldFatherName ,fldShomareHesab ,PersonalId ,sal ,mah,MahaleKhedmat ,fldSh_Personali 
 END
GO
