SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_Pay_RptFishEzafekari_TatilKari](@FieldName NVARCHAR(50), @Year SMALLINT ,@Month TINYINT,@PersonalId INT,@NobatPardakht INT,@Type TINYINT,@organId INT)
--DECLARE @FieldName NVARCHAR(50), @Year SMALLINT ,@Month TINYINT,@PersonalId INT,@NobatPardakht INT,@Type TINYINT
as
DECLARE @temp TABLE (fldName NVARCHAR(50),fldFamily NVARCHAR(100),fldShomareHesab NVARCHAR(30),fldFatherName NVARCHAR(50),fldPersonalId int,fldSh_Personali NVARCHAR(50),fldMablagh INT,fldTitle NVARCHAR(50),fldType TINYINT,fldKhalesPardakhti INT,Mah NVARCHAR(50),Sal SMALLINT,MahalKhedmat NVARCHAR(150))
IF(@FieldName='EzafeKari')
BEGIN
		INSERT INTO @temp ( fldName ,fldFamily ,fldShomareHesab ,fldFatherName , fldPersonalId ,fldSh_Personali ,fldMablagh  ,fldTitle ,fldType,fldKhalesPardakhti,Mah,Sal,MahalKhedmat)
SELECT     tblEmployee.fldName, tblEmployee.fldFamily, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblEmployee_Detail.fldFatherName, Pay.Pay_tblPersonalInfo.fldId, 
                      Prs.Prs_tblPersonalInfo.fldSh_Personali, Pay.tblMohasebatEzafeKari_TatilKari.fldMablagh, N'مبلغ اضافه کاری' AS Expr1, CAST(1 AS TINYINT) AS Expr2, 
                      Pay.tblMohasebatEzafeKari_TatilKari.fldKhalesPardakhti,Com.fn_month(@Month),@Year, Com.fn_MahaleKhedmat(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId) AS Expr3
FROM         Pay.tblMohasebatEzafeKari_TatilKari INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebatEzafeKari_TatilKari.fldId = Pay.tblMohasebat_PersonalInfo.fldEzafe_TatilKariId INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Pay.tblMohasebat_PersonalInfo.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblMohasebatEzafeKari_TatilKari.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId
							  WHERE Pay.tblMohasebatEzafeKari_TatilKari.fldYear=@Year AND Pay.tblMohasebatEzafeKari_TatilKari.fldMonth=@Month AND fldNobatPardakht=@NobatPardakht AND Pay.tblMohasebatEzafeKari_TatilKari.fldType=1
		                      AND Pay.tblMohasebat_PersonalInfo.fldOrganId=@OrganId
		
		INSERT INTO @temp ( fldName ,fldFamily ,fldShomareHesab ,fldFatherName , fldPersonalId ,fldSh_Personali ,fldMablagh  ,fldTitle ,fldType,fldKhalesPardakhti,Mah,Sal,MahalKhedmat) 
		 SELECT     tblEmployee.fldName,tblEmployee.fldFamily,fldShomareHesab, Com.tblEmployee_Detail.fldFatherName,Pay.Pay_tblPersonalInfo.fldId,fldSh_Personali,
		fldTedad,N'تعداد ',CAST(1 AS TINYINT),fldKhalesPardakhti,Com.fn_month(@Month),@Year,Com.fn_MahaleKhedmat(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId)
		FROM         Pay.tblMohasebatEzafeKari_TatilKari INNER JOIN
							  Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebatEzafeKari_TatilKari.fldId = Pay.tblMohasebat_PersonalInfo.fldEzafe_TatilKariId INNER JOIN
							  Com.tblShomareHesabeOmoomi ON Pay.tblMohasebat_PersonalInfo.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
							  Pay.Pay_tblPersonalInfo ON Pay.tblMohasebatEzafeKari_TatilKari.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
							  Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
							  Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId=tblEmployee.fldId INNER JOIN 
                      Com.tblEmployee_Detail ON tblemployee.fldId =Com.tblEmployee_Detail.fldEmployeeId
								 WHERE Pay.tblMohasebatEzafeKari_TatilKari.fldYear=@Year AND Pay.tblMohasebatEzafeKari_TatilKari.fldMonth=@Month AND fldNobatPardakht=@NobatPardakht AND Pay.tblMohasebatEzafeKari_TatilKari.fldType=1
								AND Pay.tblMohasebat_PersonalInfo.fldOrganId=@OrganId
		 
		 INSERT INTO @temp ( fldName ,fldFamily ,fldShomareHesab ,fldFatherName , fldPersonalId ,fldSh_Personali ,fldMablagh  ,fldTitle ,fldType,fldKhalesPardakhti,Mah,Sal,MahalKhedmat) 
		 SELECT     tblEmployee.fldName,tblEmployee.fldFamily,fldShomareHesab, Com.tblEmployee_Detail.fldFatherName,Pay.Pay_tblPersonalInfo.fldId,fldSh_Personali,
		fldMaliyat,N'مالیات',CAST(2 AS TINYINT),fldKhalesPardakhti,Com.fn_month(@Month),@Year,Com.fn_MahaleKhedmat(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId)
		FROM         Pay.tblMohasebatEzafeKari_TatilKari INNER JOIN
							  Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebatEzafeKari_TatilKari.fldId = Pay.tblMohasebat_PersonalInfo.fldEzafe_TatilKariId INNER JOIN
							  Com.tblShomareHesabeOmoomi ON Pay.tblMohasebat_PersonalInfo.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
							  Pay.Pay_tblPersonalInfo ON Pay.tblMohasebatEzafeKari_TatilKari.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
							  Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
							  Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId=tblEmployee.fldId  INNER JOIN 
                      Com.tblEmployee_Detail ON tblemployee.fldId =Com.tblEmployee_Detail.fldEmployeeId
								WHERE Pay.tblMohasebatEzafeKari_TatilKari.fldYear=@Year AND Pay.tblMohasebatEzafeKari_TatilKari.fldMonth=@Month AND fldNobatPardakht=@NobatPardakht AND Pay.tblMohasebatEzafeKari_TatilKari.fldType=1
		                        AND Pay.tblMohasebat_PersonalInfo.fldOrganId=@OrganId
		
		 INSERT INTO @temp ( fldName ,fldFamily ,fldShomareHesab ,fldFatherName , fldPersonalId ,fldSh_Personali ,fldMablagh  ,fldTitle ,fldType,fldKhalesPardakhti,Mah,Sal,MahalKhedmat) 
		 SELECT     tblEmployee.fldName,tblEmployee.fldFamily,fldShomareHesab, Com.tblEmployee_Detail.fldFatherName,Pay.Pay_tblPersonalInfo.fldId,fldSh_Personali,
		fldBimePersonal,N'بیمه پرسنل',CAST(2 AS TINYINT),fldKhalesPardakhti,Com.fn_month(@Month),@Year,.Com.fn_MahaleKhedmat(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId)
		FROM         Pay.tblMohasebatEzafeKari_TatilKari INNER JOIN
							  Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebatEzafeKari_TatilKari.fldId = Pay.tblMohasebat_PersonalInfo.fldEzafe_TatilKariId INNER JOIN
							  Com.tblShomareHesabeOmoomi ON Pay.tblMohasebat_PersonalInfo.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
							  Pay.Pay_tblPersonalInfo ON Pay.tblMohasebatEzafeKari_TatilKari.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
							  Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
							  Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId=tblEmployee.fldId   INNER JOIN 
                      Com.tblEmployee_Detail ON tblemployee.fldId =Com.tblEmployee_Detail.fldEmployeeId
								WHERE Pay.tblMohasebatEzafeKari_TatilKari.fldYear=@Year AND Pay.tblMohasebatEzafeKari_TatilKari.fldMonth=@Month AND fldNobatPardakht=@NobatPardakht AND Pay.tblMohasebatEzafeKari_TatilKari.fldType=1
								AND Pay.tblMohasebat_PersonalInfo.fldOrganId=@OrganId
		
		IF(@PersonalId<>0)
		BEGIN
			IF (@type=1)
			SELECT * FROM @temp WHERE fldType=1	AND fldPersonalId=@PersonalId
			ELSE IF (@type=2)
			SELECT * FROM @temp WHERE fldType=2	AND fldPersonalId=@PersonalId
			ELSE
			SELECT fldName ,fldFamily ,fldShomareHesab ,fldFatherName , fldPersonalId ,fldSh_Personali ,0 AS fldMablagh  ,'' fldTitle ,0 AS fldType,fldKhalesPardakhti,Mah,Sal ,MahalKhedmat
			FROM @temp WHERE fldPersonalId=@PersonalId
			GROUP BY fldName ,fldFamily ,fldShomareHesab ,fldFatherName , fldPersonalId ,fldSh_Personali,fldKhalesPardakhti,Mah,Sal,MahalKhedmat

		END                      
		ELSE 
		BEGIN
			IF (@type=1)
			SELECT * FROM @temp WHERE fldType=1
			ELSE IF (@type=2)
			SELECT * FROM @temp WHERE fldType=2
			ELSE
			SELECT  fldName ,fldFamily ,fldShomareHesab ,fldFatherName , fldPersonalId ,fldSh_Personali ,0 AS fldMablagh  ,'' fldTitle ,0 AS fldType,fldKhalesPardakhti,Mah,Sal ,MahalKhedmat
			FROM @temp
			GROUP BY fldName ,fldFamily ,fldShomareHesab ,fldFatherName , fldPersonalId ,fldSh_Personali,fldKhalesPardakhti,Mah,Sal,MahalKhedmat


		END 
END

IF(@FieldName='TatilKari')
BEGIN
		INSERT INTO @temp ( fldName ,fldFamily ,fldShomareHesab ,fldFatherName , fldPersonalId ,fldSh_Personali ,fldMablagh  ,fldTitle ,fldType,fldKhalesPardakhti,Mah,Sal,MahalKhedmat)
		SELECT     tblEmployee.fldName, tblEmployee.fldFamily, Com.tblShomareHesabeOmoomi.fldShomareHesab, Com.tblEmployee_Detail.fldFatherName, Pay.Pay_tblPersonalInfo.fldId, 
							  Prs.Prs_tblPersonalInfo.fldSh_Personali, Pay.tblMohasebatEzafeKari_TatilKari.fldMablagh, N'مبلغ تعطیل کاری' AS Expr1, CAST(1 AS TINYINT) AS Expr2, 
							  Pay.tblMohasebatEzafeKari_TatilKari.fldKhalesPardakhti,Com.fn_month(@Month),@Year,Com.fn_MahaleKhedmat(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId)
		FROM         Pay.tblMohasebatEzafeKari_TatilKari INNER JOIN
							  Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebatEzafeKari_TatilKari.fldId = Pay.tblMohasebat_PersonalInfo.fldEzafe_TatilKariId INNER JOIN
							  Com.tblShomareHesabeOmoomi ON Pay.tblMohasebat_PersonalInfo.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
							  Pay.Pay_tblPersonalInfo ON Pay.tblMohasebatEzafeKari_TatilKari.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
							  Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
							  Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId  INNER JOIN 
                      Com.tblEmployee_Detail ON tblemployee.fldId =Com.tblEmployee_Detail.fldEmployeeId
							  WHERE Pay.tblMohasebatEzafeKari_TatilKari.fldYear=@Year 
							  AND Pay.tblMohasebatEzafeKari_TatilKari.fldMonth=@Month 
							  AND fldNobatPardakht=@NobatPardakht AND Pay.tblMohasebatEzafeKari_TatilKari.fldType=2
							  and Pay.tblMohasebat_PersonalInfo.fldOrganId=@organId
		                      
		INSERT INTO @temp ( fldName ,fldFamily ,fldShomareHesab ,fldFatherName , fldPersonalId ,fldSh_Personali ,fldMablagh  ,fldTitle ,fldType,fldKhalesPardakhti,Mah,Sal,MahalKhedmat) 
		 SELECT     tblEmployee.fldName,tblEmployee.fldFamily,fldShomareHesab,fldFatherName,Pay.Pay_tblPersonalInfo.fldId,fldSh_Personali,
		fldTedad,N'تعداد ',CAST(1 AS TINYINT),fldKhalesPardakhti,Com.fn_month(@Month),@Year,.Com.fn_MahaleKhedmat(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId)
		FROM         Pay.tblMohasebatEzafeKari_TatilKari INNER JOIN
							  Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebatEzafeKari_TatilKari.fldId = Pay.tblMohasebat_PersonalInfo.fldEzafe_TatilKariId INNER JOIN
							  Com.tblShomareHesabeOmoomi ON Pay.tblMohasebat_PersonalInfo.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
							  Pay.Pay_tblPersonalInfo ON Pay.tblMohasebatEzafeKari_TatilKari.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
							  Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
							  Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId  INNER JOIN 
                      Com.tblEmployee_Detail ON tblemployee.fldId =Com.tblEmployee_Detail.fldEmployeeId
								 WHERE Pay.tblMohasebatEzafeKari_TatilKari.fldYear=@Year AND Pay.tblMohasebatEzafeKari_TatilKari.fldMonth=@Month AND fldNobatPardakht=@NobatPardakht AND Pay.tblMohasebatEzafeKari_TatilKari.fldType=2
								 and Pay.tblMohasebat_PersonalInfo.fldOrganId=@organId
		 
		 INSERT INTO @temp ( fldName ,fldFamily ,fldShomareHesab ,fldFatherName , fldPersonalId ,fldSh_Personali ,fldMablagh  ,fldTitle ,fldType,fldKhalesPardakhti,Mah,Sal,MahalKhedmat) 
		 SELECT     tblEmployee.fldName,tblEmployee.fldFamily,fldShomareHesab, Com.tblEmployee_Detail.fldFatherName,Pay.Pay_tblPersonalInfo.fldId,fldSh_Personali,
		fldMaliyat,N'مالیات',CAST(2 AS TINYINT),fldKhalesPardakhti,Com.fn_month(@Month),@Year,Com.fn_MahaleKhedmat(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId)
		FROM         Pay.tblMohasebatEzafeKari_TatilKari INNER JOIN
							  Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebatEzafeKari_TatilKari.fldId = Pay.tblMohasebat_PersonalInfo.fldEzafe_TatilKariId INNER JOIN
							  Com.tblShomareHesabeOmoomi ON Pay.tblMohasebat_PersonalInfo.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
							  Pay.Pay_tblPersonalInfo ON Pay.tblMohasebatEzafeKari_TatilKari.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
							  Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
							  Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId=tblEmployee.fldId  INNER JOIN 
                      Com.tblEmployee_Detail ON tblemployee.fldId =Com.tblEmployee_Detail.fldEmployeeId
								WHERE Pay.tblMohasebatEzafeKari_TatilKari.fldYear=@Year AND Pay.tblMohasebatEzafeKari_TatilKari.fldMonth=@Month AND fldNobatPardakht=@NobatPardakht AND Pay.tblMohasebatEzafeKari_TatilKari.fldType=2
								and Pay.tblMohasebat_PersonalInfo.fldOrganId=@organId
		                        
		 INSERT INTO @temp ( fldName ,fldFamily ,fldShomareHesab ,fldFatherName , fldPersonalId ,fldSh_Personali ,fldMablagh  ,fldTitle ,fldType,fldKhalesPardakhti,Mah,Sal,MahalKhedmat) 
		 SELECT     tblEmployee.fldName,tblEmployee.fldFamily,fldShomareHesab, Com.tblEmployee_Detail.fldFatherName,Pay.Pay_tblPersonalInfo.fldId,fldSh_Personali,
		fldBimePersonal,N'بیمه پرسنل',CAST(2 AS TINYINT),fldKhalesPardakhti,Com.fn_month(@Month),@Year,Com.fn_MahaleKhedmat(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId)
		FROM         Pay.tblMohasebatEzafeKari_TatilKari INNER JOIN
							  Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebatEzafeKari_TatilKari.fldId = Pay.tblMohasebat_PersonalInfo.fldEzafe_TatilKariId INNER JOIN
							  Com.tblShomareHesabeOmoomi ON Pay.tblMohasebat_PersonalInfo.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
							  Pay.Pay_tblPersonalInfo ON Pay.tblMohasebatEzafeKari_TatilKari.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
							  Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
							  Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId=tblEmployee.fldId   INNER JOIN 
                      Com.tblEmployee_Detail ON tblemployee.fldId =Com.tblEmployee_Detail.fldEmployeeId
								WHERE Pay.tblMohasebatEzafeKari_TatilKari.fldYear=@Year AND Pay.tblMohasebatEzafeKari_TatilKari.fldMonth=@Month AND fldNobatPardakht=@NobatPardakht AND Pay.tblMohasebatEzafeKari_TatilKari.fldType=2
								and Pay.tblMohasebat_PersonalInfo.fldOrganId=@organId
		IF(@PersonalId<>0)
		BEGIN
			IF (@type=1)
			SELECT * FROM @temp WHERE fldType=1	AND fldPersonalId=@PersonalId
			ELSE IF (@type=2)
			SELECT * FROM @temp WHERE fldType=2	AND fldPersonalId=@PersonalId
			ELSE
			SELECT  fldName ,fldFamily ,fldShomareHesab ,fldFatherName , fldPersonalId ,fldSh_Personali ,0 AS fldMablagh  ,'' fldTitle ,0 AS fldType,fldKhalesPardakhti,Mah,Sal ,MahalKhedmat
			FROM @temp WHERE fldPersonalId=@PersonalId
			GROUP BY fldName ,fldFamily ,fldShomareHesab ,fldFatherName , fldPersonalId ,fldSh_Personali,fldKhalesPardakhti,Mah,Sal,MahalKhedmat

		END                      
		ELSE 
		BEGIN
			IF (@type=1)
			SELECT * FROM @temp WHERE fldType=1
			ELSE IF (@type=2)
			SELECT * FROM @temp WHERE fldType=2
			ELSE
			SELECT  fldName ,fldFamily ,fldShomareHesab ,fldFatherName , fldPersonalId ,fldSh_Personali ,0 AS fldMablagh  ,'' fldTitle ,0 AS fldType,fldKhalesPardakhti,Mah,Sal ,MahalKhedmat
			FROM @temp
			GROUP BY fldName ,fldFamily ,fldShomareHesab ,fldFatherName , fldPersonalId ,fldSh_Personali,fldKhalesPardakhti,Mah,Sal,MahalKhedmat

		END 
end
GO
