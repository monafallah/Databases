SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE  PROC [Prs].[spr_RptAfradTahtePooshesh](@OrganId INT)
as
SELECT     Prs.tblAfradTahtePooshesh.fldId, Prs.tblAfradTahtePooshesh.fldPersonalId, Prs.tblAfradTahtePooshesh.fldName, Prs.tblAfradTahtePooshesh.fldFamily, 
                      Prs.tblAfradTahtePooshesh.fldBirthDate, Prs.tblAfradTahtePooshesh.fldStatus, Prs.tblAfradTahtePooshesh.fldMashmul, Prs.tblAfradTahtePooshesh.fldNesbat, 
                      Prs.tblAfradTahtePooshesh.fldCodeMeli, Prs.tblAfradTahtePooshesh.fldSh_Shenasname, Prs.tblAfradTahtePooshesh.fldFatherName, 
                      Prs.tblAfradTahtePooshesh.fldUserId, Prs.tblAfradTahtePooshesh.fldDate, Prs.tblAfradTahtePooshesh.fldDesc, CASE WHEN (fldStatus = 1) 
                      THEN N'عادی' WHEN (fldStatus = 2) THEN N'محصل' WHEN (fldStatus = 3) THEN N'بیمار' END AS fldStatusName, CASE WHEN (fldMashmul = 1) 
                      THEN N'بله' ELSE N'خیر' END AS fldMashmulName, 
                      CASE WHEN fldNesbat = 1 THEN N'فرزند' WHEN fldNesbat = 2 THEN N'همسر' WHEN fldNesbat = 3 THEN N'(تحت تکفل(تبعی3' WHEN fldNesbat = 4 THEN N'(مازاد(تبعی2' END
                       AS fldNameNesbat
FROM         Pay.Pay_tblPersonalInfo INNER JOIN
                      Prs.tblAfradTahtePooshesh INNER JOIN
                      Prs.Prs_tblPersonalInfo ON Prs.tblAfradTahtePooshesh.fldPersonalId = Prs.Prs_tblPersonalInfo.fldId ON 
                      Pay.Pay_tblPersonalInfo.fldPrs_PersonalInfoId = Prs.Prs_tblPersonalInfo.fldId
                      WHERE Com.fn_OrganId(tblAfradTahtePooshesh.fldPersonalId) =@OrganId
GO
