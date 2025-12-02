SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_DisketPasAndaz](@Sal SMALLINT,@Mah TINYINT,@Nobat TINYINT,@organid int)
as
SELECT   * FROM (SELECT  tblMohasebat.fldPasAndaz +
                            isnull((SELECT        SUM(fldPasAndaz) AS Expr1
                                FROM            Pay.tblMoavaghat
                                WHERE        (fldMohasebatId = Pay.tblMohasebat.fldId)),0) AS fldPasAndaz,
                            fldShPasAndazPersonal,fldShPasAndazKarFarma,
							 (SELECT        TOP (1) Com.tblAnvaEstekhdam.fldId
                                FROM            Prs.tblHistoryNoeEstekhdam INNER JOIN
                                                         Com.tblAnvaEstekhdam ON Prs.tblHistoryNoeEstekhdam.fldNoeEstekhdamId = Com.tblAnvaEstekhdam.fldId
                                WHERE        (Prs.tblHistoryNoeEstekhdam.fldPrsPersonalInfoId = Prs.Prs_tblPersonalInfo.fldId)
                                ORDER BY Prs.tblHistoryNoeEstekhdam.fldId DESC) AS fldNoeEstekhdam
								,fldName,fldFamily,fldFatherName,fldCodemeli
FROM            Pay.tblMohasebat INNER JOIN
                         Pay.Pay_tblPersonalInfo ON Pay.tblMohasebat.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                         Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId INNER JOIN
                         Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebat.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatId  INNER JOIN
                    Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId = tblEmployee.fldId INNER JOIN
                      Pay.tblTabJobOfBime ON Pay.Pay_tblPersonalInfo.fldJobeCode = Pay.tblTabJobOfBime.fldJobCode INNER JOIN 
                      Com.tblEmployee_Detail ON tblemployee.fldId=Com.tblEmployee_Detail.fldEmployeeId
WHERE fldYear=@Sal AND fldmonth=@Mah AND fldNobatPardakht=@Nobat AND Pay_tblPersonalInfo.fldPasAndaz=1 and Pay.tblMohasebat_PersonalInfo.fldOrganId=@organid
and fldCalcType=1
)t
WHERE fldNoeEstekhdam<>1
GO
