SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_Pay_RptListMandePasAndaz]
--DECLARE
@Year SMALLINT,
@Month TINYINT,
@organId INT
AS 
BEGIN TRAN
DECLARE @r NVARCHAR(10)
SET @r=CASE WHEN LEN (@month)=1 THEN CAST(@Year AS NVARCHAR(4))+'0'+CAST(@Month AS NVARCHAR(2)) ELSE CAST(@Year AS NVARCHAR(4))+CAST(@Month AS NVARCHAR(2)) END 

SELECT DISTINCT SUM(fldMablagh) OVER(PARTITION BY t.fldPersonalId) as fldMablagh,fldName,fldYear,fldSh_Personali
FROM( SELECT
ISNULL( SUM(tblMohasebat.fldPasAndaz ),0)+
ISNULL((SELECT    SUM( Pay.tblMoavaghat.fldPasAndaz) 
FROM         Pay.tblMoavaghat WHERE fldMohasebatId = Pay.tblMohasebat.fldId),0)
                     + isnull((SELECT   SUM(FldMablagh) FROM Pay.tblMandehPasAndaz WHERE fldPersonalId=Pay.tblMohasebat.fldPersonalId AND CAST(SUBSTRING(tblMandehPasAndaz.fldTarikhSabt,1,4)+SUBSTRING(tblMandehPasAndaz.fldTarikhSabt,6,2) AS bigint)<=CAST(@r AS INT) ),0 ) AS fldMablagh
                     , Com.fn_FamilyEmployee(Prs.Prs_tblPersonalInfo.fldEmployeeId) AS fldName
                    , @Year AS fldYear,fldSh_Personali
    ,Pay.tblMohasebat.fldId,fldPersonalId
FROM         Pay.tblMohasebat INNER JOIN
                      Pay.Pay_tblPersonalInfo ON Pay.tblMohasebat.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId
                      INNER JOIN  Com.tblEmployee AS tblEmployee ON Prs.Prs_tblPersonalInfo.fldEmployeeId=tblEmployee.fldId          
                             --WHERE cast(CAST(fldYear AS NVARCHAR(4))+(CAST(fldMonth AS NVARCHAR(2)))AS bigint)<=CAST(@r AS INT) AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId)=@organId
                             WHERE CASE WHEN LEN(fldmonth)=1 then cast(CAST(fldYear AS NVARCHAR(4))+('0'+CAST(fldMonth AS NVARCHAR(2)))AS bigint) ELSE  cast(CAST(fldYear AS NVARCHAR(4))+(CAST(fldMonth AS NVARCHAR(2)))AS bigint) END <=CAST(@r AS INT) AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId)=@organId
                             and fldCalcType=1
							 GROUP BY fldPersonalId,fldEmployeeId,fldSh_Personali,Pay.tblMohasebat.fldId
                             )t
							 ORDER BY t.fldName
ROLLBACK
GO
