SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROC [Pay].[spr_tblShomareHesabGroupSelect]
    @noehesab bit,
    @idbank INT,
    @OrganId INT
AS    

	BEGIN TRAN


SELECT     Pay.Pay_tblPersonalInfo.fldId, tblEmployee.fldFamily + '_' + tblEmployee.fldName + ' (' + fldFatherName + ')' AS fldName, tblEmployee.fldCodemeli, 
            Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId,Prs_tblPersonalInfo.fldSh_Personali
			,ISNULL(b.fldShomareHesab, N'') AS fldShomareHesab, 
            ISNULL(b.fldShomareKart, N'') AS fldShomareKart, 
            ISNULL(b.fldId, 0) AS fldShomareHesabId,
			ISNULL (b.fldShobeId  , ISNULL((SELECT TOP(1) fldId  FROM  Com.tblSHobe WHERE fldBankId=@idbank ORDER BY fldid ),0)) AS fldShobeId
			,ISNULL(b.fldName     , (SELECT TOP(1) fldName  FROM  Com.tblSHobe WHERE fldBankId=@idbank  ORDER BY fldid)) AS fldShobeName
FROM         Pay.Pay_tblPersonalInfo INNER JOIN
                    prs.Prs_tblPersonalInfo as  Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs_tblPersonalInfo.fldId INNER JOIN
                      Com.tblEmployee AS tblEmployee ON Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId --inner join 
					  outer apply( SELECT    top(1)  fldName,Com.tblShomareHesabeOmoomi.fldId,Com.tblShomareHesabeOmoomi.fldShobeId, Com.tblShomareHesabeOmoomi.fldShomareHesab,fldShomareKart
									  FROM         Com.tblShomareHesabeOmoomi INNER JOIN
									  Com.tblShomareHesabOmoomi_Detail ON Com.tblShomareHesabeOmoomi.fldId = Com.tblShomareHesabOmoomi_Detail.fldShomareHesabId INNER JOIN
									  Com.tblSHobe ON Com.tblShomareHesabeOmoomi.fldShobeId = Com.tblSHobe.fldId inner join
									  com.tblAshkhas as a on a.fldId=fldAshkhasId


											  WHERE     /*(fldAshkhasId = com.fn_AshkhasIdwithPersonalId(Pay_tblPersonalInfo.fldId)*/ (a.fldHaghighiId=tblEmployee.fldId AND (fldTypeHesab = @noehesab) AND (tblShomareHesabeOmoomi.fldBankId = @idbank)))b            
 WHERE Com.fn_MaxPersonalStatus(Pay.Pay_tblPersonalInfo.fldId,'hoghoghi')=1  
 AND Com.fn_OrganId(Prs_tblPersonalInfo.fldId) =@OrganId

 ORDER BY fldFamily,fldName ASC

 	COMMIT
GO
