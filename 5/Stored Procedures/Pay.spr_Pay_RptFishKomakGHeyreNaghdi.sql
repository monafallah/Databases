SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_Pay_RptFishKomakGHeyreNaghdi](@Sal SMALLINT,@Mah TINYINT,@PersonalId INT,@NoeMostamar BIT,@type TINYINT,@organId int)
AS
DECLARE @temp TABLE (fldName NVARCHAR(50),fldFamily NVARCHAR(100),fldFatherName NVARCHAR(50),fldShomareHesab NVARCHAR(50),PersonalId INT,fldSh_Personali NVARCHAR(50),fldKhalesPardakhti INT,fldMablagh INT,Title NVARCHAR(50),fldtype TINYINT,MahalKhedmat NVARCHAR(max))
INSERT INTO @temp  ( fldName ,fldFamily ,fldFatherName ,fldShomareHesab ,PersonalId ,fldSh_Personali ,fldKhalesPardakhti ,fldMablagh ,Title ,fldtype,MahalKhedmat)
       
SELECT     fldName,tblEmployee.fldFamily,fldFatherName,fldShomareHesab,Pay.Pay_tblPersonalInfo.fldId,fldSh_Personali,fldKhalesPardakhti,
fldMablagh,N'مبلغ',CAST(1 AS TINYINT),Com.fn_MahaleKhedmat(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId)
FROM         Pay.tblKomakGheyerNaghdi INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblKomakGheyerNaghdi.fldId = Pay.tblMohasebat_PersonalInfo.fldKomakGheyerNaghdiId INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Pay.tblMohasebat_PersonalInfo.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblKomakGheyerNaghdi.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN 
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId=tblEmployee.fldId INNER JOIN 
                      Com.tblEmployee_Detail ON tblEmployee.fldid=Com.tblEmployee_Detail.fldEmployeeId
					  WHERE fldYear=@Sal AND fldMonth=@Mah AND fldNoeMostamer=@NoeMostamar AND Pay.tblMohasebat_PersonalInfo.fldOrganId=@OrganId

INSERT INTO @temp  ( fldName ,fldFamily ,fldFatherName ,fldShomareHesab ,PersonalId ,fldSh_Personali ,fldKhalesPardakhti ,fldMablagh ,Title ,fldtype,MahalKhedmat)
SELECT     fldName,tblEmployee.fldFamily,fldFatherName,fldShomareHesab,Pay.Pay_tblPersonalInfo.fldId,fldSh_Personali,fldKhalesPardakhti,
fldMaliyat,N'مالیات',CAST(2 AS TINYINT),Com.fn_MahaleKhedmat(Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId)
FROM         Pay.tblKomakGheyerNaghdi INNER JOIN
                      Pay.tblMohasebat_PersonalInfo ON Pay.tblKomakGheyerNaghdi.fldId = Pay.tblMohasebat_PersonalInfo.fldKomakGheyerNaghdiId INNER JOIN
                      Com.tblShomareHesabeOmoomi ON Pay.tblMohasebat_PersonalInfo.fldShomareHesabId = Com.tblShomareHesabeOmoomi.fldId INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblKomakGheyerNaghdi.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN 
                      Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId=tblEmployee.fldId INNER JOIN 
                      Com.tblEmployee_Detail ON tblEmployee.fldid=Com.tblEmployee_Detail.fldEmployeeId
                        WHERE fldYear=@Sal AND fldMonth=@Mah AND fldNoeMostamer=@NoeMostamar AND Pay.tblMohasebat_PersonalInfo.fldOrganId=@OrganId

IF(@PersonalId<>0)
BEGIN
	IF(@type=1)
	SELECT * FROM @temp WHERE fldtype=1 AND PersonalId=@PersonalId
	else IF(@type=2)
	SELECT * FROM @temp WHERE fldtype=2 AND PersonalId=@PersonalId
	else
	SELECT  fldName ,fldFamily ,fldFatherName ,fldShomareHesab ,PersonalId ,fldSh_Personali ,fldKhalesPardakhti ,0 AS fldMablagh ,'' Title ,0 AS fldtype ,MahalKhedmat FROM @temp WHERE PersonalId=@PersonalId
	GROUP BY fldName ,fldFamily ,fldFatherName ,fldShomareHesab ,PersonalId ,fldSh_Personali ,fldKhalesPardakhti,MahalKhedmat
END

ELSE
BEGIN
	IF(@type=1)
	SELECT * FROM @temp WHERE fldtype=1
	ELSE IF(@type=2)
	SELECT * FROM @temp WHERE fldtype=2
	else
	SELECT   fldName ,fldFamily ,fldFatherName ,fldShomareHesab ,PersonalId ,fldSh_Personali ,fldKhalesPardakhti ,0 AS fldMablagh ,'' Title ,0 AS fldtype,MahalKhedmat FROM @temp 
	GROUP BY fldName ,fldFamily ,fldFatherName ,fldShomareHesab ,PersonalId ,fldSh_Personali ,fldKhalesPardakhti,MahalKhedmat
END
GO
