SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Auto].[spr_CHartEjraee_Comissoin]
@fldPId INT


as
BEGIN TRAN
--DECLARE @fldPID INT=2

if (@fldPID=0)
SELECT     CASE WHEN Com.tblOrganizationalPostsEjraee.fldTitle IS NULL THEN N'_' ELSE Com.tblOrganizationalPostsEjraee.fldTitle END AS fldPost, 
                      Com.tblOrganizationalPosts.fldTitle, Com.tblEmployee.fldName + ' ' + Com.tblEmployee.fldFamily AS fldFamily, Com.tblOrganizationalPosts.fldPID
FROM         Com.tblOrganizationalPostsEjraee INNER JOIN
                      Com.tblOrganizationalPosts ON Com.tblOrganizationalPostsEjraee.fldId = Com.tblOrganizationalPosts.fldId INNER JOIN
                      Com.tblEmployee ON Com.tblOrganizationalPostsEjraee.fldId = Com.tblEmployee.fldId
                      WHERE Com.tblOrganizationalPostsEjraee.fldPID IS null	
    
	ELSE
SELECT     CASE WHEN Com.tblOrganizationalPostsEjraee.fldTitle IS NULL THEN N'_' ELSE Com.tblOrganizationalPostsEjraee.fldTitle END AS fldPost, 
                      Com.tblOrganizationalPosts.fldTitle, Com.tblEmployee.fldName + ' ' + Com.tblEmployee.fldFamily AS fldFamily, Com.tblOrganizationalPosts.fldPID
FROM         Com.tblOrganizationalPostsEjraee INNER JOIN
                      Com.tblOrganizationalPosts ON Com.tblOrganizationalPostsEjraee.fldId = Com.tblOrganizationalPosts.fldId INNER JOIN
                      Com.tblEmployee ON Com.tblOrganizationalPostsEjraee.fldId = Com.tblEmployee.fldId	
                      WHERE Com.tblOrganizationalPostsEjraee.fldPID=@fldPId
	
	COMMIT TRAN
	
GO
