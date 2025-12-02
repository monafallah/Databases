SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblMasuolin_DetailSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@h int
AS 
	BEGIN TRAN
	if (@h=0) set @h=2147483647
	SET @Value=Com.fn_TextNormalize(@Value)
	if (@fieldname=N'fldId')
SELECT     TOP (@h) Com.tblMasuolin_Detail.fldId, Com.tblMasuolin_Detail.fldEmployId, Com.tblMasuolin_Detail.fldOrganPostId, Com.tblMasuolin_Detail.fldMasuolinId, 
                      Com.tblMasuolin_Detail.fldOrderId, Com.tblMasuolin_Detail.fldUserId, Com.tblMasuolin_Detail.fldDesc, Com.tblMasuolin_Detail.fldDate, 
                      Com.tblMasuolin.fldTarikhEjra, Com.tblMasuolin.fldModule_OrganId, Com.tblEmployee.fldName + ' ' + Com.tblEmployee.fldFamily AS fldNameEmployee,
                          (SELECT     Com.fn_stringDecode(fldName) AS Expr1
                            FROM          Com.tblOrganization
                            WHERE      (fldId = Com.fn_OrganName(Com.tblOrganizationalPosts.fldId))) AS fldNameOrgan, ISNULL(Com.tblOrganizationalPosts.fldTitle, '') AS NamePostOrgan, 
                      Com.tblOrganizationalPosts.fldTitle AS TitlePost
FROM         Com.tblMasuolin_Detail LEFT OUTER JOIN
                      Com.tblEmployee ON Com.tblMasuolin_Detail.fldEmployId = Com.tblEmployee.fldId LEFT OUTER JOIN
                      Com.tblChartOrgan INNER JOIN
                      Com.tblOrganizationalPosts ON Com.tblChartOrgan.fldId = Com.tblOrganizationalPosts.fldChartOrganId ON 
                      Com.tblMasuolin_Detail.fldOrganPostId = Com.tblOrganizationalPosts.fldId left outer JOIN
                      Com.tblMasuolin ON Com.tblMasuolin_Detail.fldMasuolinId = Com.tblMasuolin.fldId
                      WHERE   tblMasuolin_Detail.fldId = @Value
	
	if (@fieldname=N'fldMasuolinId')
SELECT     TOP (@h) Com.tblMasuolin_Detail.fldId, Com.tblMasuolin_Detail.fldEmployId, Com.tblMasuolin_Detail.fldOrganPostId, Com.tblMasuolin_Detail.fldMasuolinId, 
                      Com.tblMasuolin_Detail.fldOrderId, Com.tblMasuolin_Detail.fldUserId, Com.tblMasuolin_Detail.fldDesc, Com.tblMasuolin_Detail.fldDate, 
                      Com.tblMasuolin.fldTarikhEjra, Com.tblMasuolin.fldModule_OrganId, Com.tblEmployee.fldName + ' ' + Com.tblEmployee.fldFamily AS fldNameEmployee,
                          (SELECT     Com.fn_stringDecode(fldName) AS Expr1
                            FROM          Com.tblOrganization
                            WHERE      (fldId = Com.fn_OrganName(Com.tblOrganizationalPosts.fldId))) AS fldNameOrgan, ISNULL(Com.tblOrganizationalPosts.fldTitle, '') AS NamePostOrgan, 
                      Com.tblOrganizationalPosts.fldTitle AS TitlePost
FROM         Com.tblMasuolin_Detail LEFT OUTER JOIN
                      Com.tblEmployee ON Com.tblMasuolin_Detail.fldEmployId = Com.tblEmployee.fldId LEFT OUTER JOIN
                      Com.tblChartOrgan INNER JOIN
                      Com.tblOrganizationalPosts ON Com.tblChartOrgan.fldId = Com.tblOrganizationalPosts.fldChartOrganId ON 
                      Com.tblMasuolin_Detail.fldOrganPostId = Com.tblOrganizationalPosts.fldId left outer JOIN
                      Com.tblMasuolin ON Com.tblMasuolin_Detail.fldMasuolinId = Com.tblMasuolin.fldId
                      	WHERE  fldMasuolinId = @Value
	
		if (@fieldname=N'fldOrganPostId')
SELECT     TOP (@h) Com.tblMasuolin_Detail.fldId, Com.tblMasuolin_Detail.fldEmployId, Com.tblMasuolin_Detail.fldOrganPostId, Com.tblMasuolin_Detail.fldMasuolinId, 
                      Com.tblMasuolin_Detail.fldOrderId, Com.tblMasuolin_Detail.fldUserId, Com.tblMasuolin_Detail.fldDesc, Com.tblMasuolin_Detail.fldDate, 
                      Com.tblMasuolin.fldTarikhEjra, Com.tblMasuolin.fldModule_OrganId, Com.tblEmployee.fldName + ' ' + Com.tblEmployee.fldFamily AS fldNameEmployee,
                          (SELECT     Com.fn_stringDecode(fldName) AS Expr1
                            FROM          Com.tblOrganization
                            WHERE      (fldId = Com.fn_OrganName(Com.tblOrganizationalPosts.fldId))) AS fldNameOrgan, ISNULL(Com.tblOrganizationalPosts.fldTitle, '') AS NamePostOrgan, 
                      Com.tblOrganizationalPosts.fldTitle AS TitlePost
FROM         Com.tblMasuolin_Detail LEFT OUTER JOIN
                      Com.tblEmployee ON Com.tblMasuolin_Detail.fldEmployId = Com.tblEmployee.fldId LEFT OUTER JOIN
                      Com.tblChartOrgan INNER JOIN
                      Com.tblOrganizationalPosts ON Com.tblChartOrgan.fldId = Com.tblOrganizationalPosts.fldChartOrganId ON 
                      Com.tblMasuolin_Detail.fldOrganPostId = Com.tblOrganizationalPosts.fldId left outer JOIN
                      Com.tblMasuolin ON Com.tblMasuolin_Detail.fldMasuolinId = Com.tblMasuolin.fldId
	WHERE  tblMasuolin_Detail.fldOrganPostId = @Value
	
		if (@fieldname=N'fldEmployId')
SELECT     TOP (@h) Com.tblMasuolin_Detail.fldId, Com.tblMasuolin_Detail.fldEmployId, Com.tblMasuolin_Detail.fldOrganPostId, Com.tblMasuolin_Detail.fldMasuolinId, 
                      Com.tblMasuolin_Detail.fldOrderId, Com.tblMasuolin_Detail.fldUserId, Com.tblMasuolin_Detail.fldDesc, Com.tblMasuolin_Detail.fldDate, 
                      Com.tblMasuolin.fldTarikhEjra, Com.tblMasuolin.fldModule_OrganId, Com.tblEmployee.fldName + ' ' + Com.tblEmployee.fldFamily AS fldNameEmployee,
                          (SELECT     Com.fn_stringDecode(fldName) AS Expr1
                            FROM          Com.tblOrganization
                            WHERE      (fldId = Com.fn_OrganName(Com.tblOrganizationalPosts.fldId))) AS fldNameOrgan, ISNULL(Com.tblOrganizationalPosts.fldTitle, '') AS NamePostOrgan, 
                      Com.tblOrganizationalPosts.fldTitle AS TitlePost
FROM         Com.tblMasuolin_Detail LEFT OUTER JOIN
                      Com.tblEmployee ON Com.tblMasuolin_Detail.fldEmployId = Com.tblEmployee.fldId LEFT OUTER JOIN
                      Com.tblChartOrgan INNER JOIN
                      Com.tblOrganizationalPosts ON Com.tblChartOrgan.fldId = Com.tblOrganizationalPosts.fldChartOrganId ON 
                      Com.tblMasuolin_Detail.fldOrganPostId = Com.tblOrganizationalPosts.fldId left outer JOIN
                      Com.tblMasuolin ON Com.tblMasuolin_Detail.fldMasuolinId = Com.tblMasuolin.fldId
	WHERE  fldEmployId = @Value

		if (@fieldname=N'fldDesc')
SELECT     TOP (@h) Com.tblMasuolin_Detail.fldId, Com.tblMasuolin_Detail.fldEmployId, Com.tblMasuolin_Detail.fldOrganPostId, Com.tblMasuolin_Detail.fldMasuolinId, 
                      Com.tblMasuolin_Detail.fldOrderId, Com.tblMasuolin_Detail.fldUserId, Com.tblMasuolin_Detail.fldDesc, Com.tblMasuolin_Detail.fldDate, 
                      Com.tblMasuolin.fldTarikhEjra, Com.tblMasuolin.fldModule_OrganId, Com.tblEmployee.fldName + ' ' + Com.tblEmployee.fldFamily AS fldNameEmployee,
                          (SELECT     Com.fn_stringDecode(fldName) AS Expr1
                            FROM          Com.tblOrganization
                            WHERE      (fldId = Com.fn_OrganName(Com.tblOrganizationalPosts.fldId))) AS fldNameOrgan, ISNULL(Com.tblOrganizationalPosts.fldTitle, '') AS NamePostOrgan, 
                      Com.tblOrganizationalPosts.fldTitle AS TitlePost
FROM         Com.tblMasuolin_Detail LEFT OUTER JOIN
                      Com.tblEmployee ON Com.tblMasuolin_Detail.fldEmployId = Com.tblEmployee.fldId LEFT OUTER JOIN
                      Com.tblChartOrgan INNER JOIN
                      Com.tblOrganizationalPosts ON Com.tblChartOrgan.fldId = Com.tblOrganizationalPosts.fldChartOrganId ON 
                      Com.tblMasuolin_Detail.fldOrganPostId = Com.tblOrganizationalPosts.fldId left outer JOIN
                      Com.tblMasuolin ON Com.tblMasuolin_Detail.fldMasuolinId = Com.tblMasuolin.fldId
                      WHERE   tblMasuolin_Detail.fldDesc like @Value

	if (@fieldname=N'')
SELECT     TOP (@h) Com.tblMasuolin_Detail.fldId, Com.tblMasuolin_Detail.fldEmployId, Com.tblMasuolin_Detail.fldOrganPostId, Com.tblMasuolin_Detail.fldMasuolinId, 
                      Com.tblMasuolin_Detail.fldOrderId, Com.tblMasuolin_Detail.fldUserId, Com.tblMasuolin_Detail.fldDesc, Com.tblMasuolin_Detail.fldDate, 
                      Com.tblMasuolin.fldTarikhEjra, Com.tblMasuolin.fldModule_OrganId, Com.tblEmployee.fldName + ' ' + Com.tblEmployee.fldFamily AS fldNameEmployee,
                          (SELECT     Com.fn_stringDecode(fldName) AS Expr1
                            FROM          Com.tblOrganization
                            WHERE      (fldId = Com.fn_OrganName(Com.tblOrganizationalPosts.fldId))) AS fldNameOrgan, ISNULL(Com.tblOrganizationalPosts.fldTitle, '') AS NamePostOrgan, 
                      Com.tblOrganizationalPosts.fldTitle AS TitlePost
FROM         Com.tblMasuolin_Detail LEFT OUTER JOIN
                      Com.tblEmployee ON Com.tblMasuolin_Detail.fldEmployId = Com.tblEmployee.fldId LEFT OUTER JOIN
                      Com.tblChartOrgan INNER JOIN
                      Com.tblOrganizationalPosts ON Com.tblChartOrgan.fldId = Com.tblOrganizationalPosts.fldChartOrganId ON 
                      Com.tblMasuolin_Detail.fldOrganPostId = Com.tblOrganizationalPosts.fldId left outer JOIN
                      Com.tblMasuolin ON Com.tblMasuolin_Detail.fldMasuolinId = Com.tblMasuolin.fldId
	COMMIT
GO
