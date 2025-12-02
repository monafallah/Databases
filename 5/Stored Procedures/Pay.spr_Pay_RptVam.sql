SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_Pay_RptVam]
@StartDate NVARCHAR(10),
@EndDate NVARCHAR(10),
@OrganId INT
AS
BEGIN TRAN

SELECT     Pay.tblVam.fldId, Pay.tblVam.fldPersonalId, Pay.tblVam.fldTypeVam, Pay.tblVam.fldTarikhDaryaft, Pay.tblVam.fldMablaghVam, Pay.tblVam.fldStartDate, 
                      Pay.tblVam.fldCount, Pay.tblVam.fldMablagh, Pay.tblVam.fldMandeVam - ISNULL
                          ((SELECT     SUM(Pay.tblMohasebat.fldGhestVam) AS Expr1
                              FROM         Pay.tblMohasebat INNER JOIN
                                                    Pay.tblMohasebat_PersonalInfo ON Pay.tblMohasebat.fldId = Pay.tblMohasebat_PersonalInfo.fldMohasebatId
                              WHERE     (Pay.tblMohasebat.fldPersonalId = Pay.tblVam.fldPersonalId) AND (Pay.tblMohasebat_PersonalInfo.fldVamId = Pay.tblVam.fldId)), 0) AS fldMandeVam, 
                      Pay.tblVam.fldStatus, Com.fn_FamilyEmployee(Prs.Prs_tblPersonalInfo.fldEmployeeId) AS fldName, Prs.Prs_tblPersonalInfo.fldSh_Personali, 
                      CASE WHEN (fldTypeVam = 1) THEN N'کوتاه مدت' WHEN (fldTypeVam = 2) THEN N'بلند مدت' WHEN (fldTypeVam = 3) THEN N'مسکن' END AS fldTypeVamS, 
                      CASE WHEN (fldStatus = 0) THEN N'تسویه شده' ELSE N'تسویه نشده' END AS fldStatusS, Pay.tblVam.fldStartDate AS StartDate,dbo.Fn_AssembelyMiladiToShamsi(dateadd(month,Pay.tblVam.fldCount-1,dbo.Fn_AssembelyShamsiToMiladiDate(Pay.tblVam.fldStartDate))) AS EndDate
FROM         Pay.tblVam INNER JOIN 
                      Pay.Pay_tblPersonalInfo ON Pay.tblVam.fldPersonalId = Pay.Pay_tblPersonalInfo.fldId INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId
                      WHERE pay.tblVam.fldStatus=1 AND Com.fn_OrganId(Prs.Prs_tblPersonalInfo.fldId)=@OrganId
                      
                     
                      
                    
ROLLBACK
GO
