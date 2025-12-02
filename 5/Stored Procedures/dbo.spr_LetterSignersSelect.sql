SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[spr_LetterSignersSelect]
@LetterMinutId INT,
@UserId int
AS 
BEGIN TRAN
SELECT        Com.tblOrganizationalPosts.fldTitle, Com.tblEmployee.fldName + ' ' + Com.tblEmployee.fldFamily AS fldName
FROM            Drd.tblLetterSigners INNER JOIN
                         Com.tblOrganizationalPosts ON Drd.tblLetterSigners.fldOrganizationalPostsId = Com.tblOrganizationalPosts.fldId INNER JOIN
                         Com.tblMasuolin_Detail ON Com.tblOrganizationalPosts.fldId = Com.tblMasuolin_Detail.fldOrganPostId INNER JOIN
                         Com.tblEmployee ON Com.tblMasuolin_Detail.fldEmployId = Com.tblEmployee.fldId
						 WHERE fldLetterMinutId=@LetterMinutId AND fldMasuolinId IN (SELECT TOP(1) tblMasuolin.fldId FROM Com.tblMasuolin INNER JOIN
Com.tblModule_Organ ON Com.tblMasuolin.fldModule_OrganId = Com.tblModule_Organ.fldId
WHERE fldModuleId=5 AND fldTarikhEjra<=dbo.Fn_AssembelyMiladiToShamsi(tblMasuolin.fldDate)
ORDER BY fldTarikhEjra DESC)

UNION
SELECT N'تنظیم کننده',(SELECT   Com.tblEmployee.fldName+' '+ Com.tblEmployee.fldFamily
FROM            Com.tblUser INNER JOIN
                         Com.tblEmployee ON Com.tblUser.fldEmployId = Com.tblEmployee.fldId  WHERE com.tblUser.fldid=@UserId) AS fldName
						  FROM Drd.tblLetterMinut
WHERE fldTanzimkonande=1 AND fldid=@LetterMinutId
COMMIT TRAN
GO
