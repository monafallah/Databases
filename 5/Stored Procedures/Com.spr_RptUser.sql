SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_RptUser](@OrganId INT)
as
SELECT     Com.tblUser.fldId, Com.tblUser.fldEmployId, Com.tblUser.fldUserName, Com.tblUser.fldPassword, Com.tblUser.fldActive_Deactive, tblChartOrgan.fldOrganId, 
                      Com.tblUser.fldUserId, Com.tblUser.fldDesc, Com.tblUser.fldDate, CASE WHEN fldActive_Deactive = 0 THEN N'غیر فعال' ELSE N'فعال' END AS fldActive_DeactiveName, 
                      Com.fn_stringDecode(Com.tblOrganization.fldName) AS fldNameOrgan, Com.tblEmployee.fldName + ' ' + Com.tblEmployee.fldFamily AS fldNameEmployee, 
                      Com.tblFile.fldImage
FROM         Com.tblUser INNER JOIN
                      Com.tblEmployee ON Com.tblUser.fldEmployId = Com.tblEmployee.fldId INNER JOIN
                      Com.tblEmployee_Detail ON Com.tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId INNER JOIN
                      Com.tblFile ON Com.tblEmployee_Detail.fldFileId = Com.tblFile.fldId INNER JOIN
					  prs.Prs_tblPersonalInfo as p on p.fldEmployeeId=Com.tblEmployee.fldId INNER JOIN
                      Com.tblOrganizationalPosts ON p.fldOrganPostId = Com.tblOrganizationalPosts.fldId INNER JOIN
                      Com.tblChartOrgan ON Com.tblOrganizationalPosts.fldChartOrganId = Com.tblChartOrgan.fldId INNER JOIN			  
					  Com.tblOrganization on Com.tblOrganization.fldId=tblChartOrgan.fldOrganId
                      WHERE tblOrganization.fldId =@organId
GO
