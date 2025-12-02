SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblEmployeeSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@Value1 NVARCHAR(50)='',
	@h int
AS 
	BEGIN TRAN
	if (@h=0) set @h=2147483647
	SET @Value=Com.fn_TextNormalize(@Value)
	if (@fieldname=N'fldId')
SELECT  top(@h)   Com.tblEmployee.fldId, Com.tblEmployee.fldName, Com.tblEmployee.fldFamily, Com.tblEmployee.fldCodemeli, Com.tblEmployee.fldUserId, 
                      Com.tblEmployee.fldDesc, Com.tblEmployee.fldDate, Com.tblEmployee.fldStatus, 
                      CASE WHEN fldStatus = 1 THEN N'خصوصی' ELSE N'عمومی' END AS fldStatusName,
                      ISNULL(fldFatherName,'') AS fldFatherName
					  ,fldTypeShakhs,case when fldTypeShakhs=0 then N'اتباع داخلی' else N'اتباع خارجی' end as fldTypeShakhsName,fldSh_Shenasname
					  ,fldCodeMoshakhase,isnull(fldCodemeli,fldCodeMoshakhase)fldMeli_Moshakhase,isnull(organPost.fldTitle,'') fldPostEjraee,fldOrganPostEjraeeId
FROM         Com.tblEmployee LEFT OUTER JOIN
                      Com.tblEmployee_Detail ON Com.tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId
					  outer apply (select  o.fldTitle,fldOrganPostEjraeeId from prs.Prs_tblPersonalInfo p
									  inner join com.tblOrganizationalPostsEjraee o
									on o.fldid=fldOrganPostEjraeeId
									where p.fldEmployeeId=Com.tblEmployee.fldId)organPost
	WHERE  tblEmployee.fldId = @Value 
	ORDER BY tblEmployee.fldId DESC
	

if (@fieldname=N'fldCodemeli')
SELECT     TOP (@h) Com.tblEmployee.fldId, Com.tblEmployee.fldName, Com.tblEmployee.fldFamily, Com.tblEmployee.fldCodemeli, Com.tblEmployee.fldUserId, 
                      Com.tblEmployee.fldDesc, Com.tblEmployee.fldDate, Com.tblEmployee.fldStatus, 
                      CASE WHEN fldStatus = 1 THEN N'خصوصی' ELSE N'عمومی' END AS fldStatusName,
                      ISNULL(fldFatherName,'') AS fldFatherName
					  ,fldTypeShakhs,case when fldTypeShakhs=0 then N'اتباع داخلی' else N'اتباع خارجی' end as fldTypeShakhsName,fldSh_Shenasname
					  ,fldCodeMoshakhase,isnull(fldCodemeli,fldCodeMoshakhase)fldMeli_Moshakhase,isnull(organPost.fldTitle,'') fldPostEjraee,fldOrganPostEjraeeId
FROM         Com.tblEmployee LEFT OUTER JOIN
                      Com.tblEmployee_Detail ON Com.tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId
					  outer apply (select  o.fldTitle,fldOrganPostEjraeeId from prs.Prs_tblPersonalInfo p
									  inner join com.tblOrganizationalPostsEjraee o
									on o.fldid=fldOrganPostEjraeeId
									where p.fldEmployeeId=Com.tblEmployee.fldId)organPost
	WHERE  fldCodemeli like @Value AND (fldStatus IN (SELECT item FROM com.Split(@Value1,',')) or @Value1='')
	ORDER BY tblEmployee.fldId DESC
	

	if (@fieldname=N'fldCodeMoshakhase')
SELECT     TOP (@h) Com.tblEmployee.fldId, Com.tblEmployee.fldName, Com.tblEmployee.fldFamily, Com.tblEmployee.fldCodemeli, Com.tblEmployee.fldUserId, 
                      Com.tblEmployee.fldDesc, Com.tblEmployee.fldDate, Com.tblEmployee.fldStatus, 
                      CASE WHEN fldStatus = 1 THEN N'خصوصی' ELSE N'عمومی' END AS fldStatusName,
                      ISNULL(fldFatherName,'') AS fldFatherName
					  ,fldTypeShakhs,case when fldTypeShakhs=0 then N'اتباع داخلی' else N'اتباع خارجی' end as fldTypeShakhsName,fldSh_Shenasname
					  ,fldCodeMoshakhase,isnull(fldCodemeli,fldCodeMoshakhase)fldMeli_Moshakhase,isnull(organPost.fldTitle,'') fldPostEjraee,fldOrganPostEjraeeId
FROM         Com.tblEmployee LEFT OUTER JOIN
                      Com.tblEmployee_Detail ON Com.tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId
					  outer apply (select  o.fldTitle,fldOrganPostEjraeeId from prs.Prs_tblPersonalInfo p
									  inner join com.tblOrganizationalPostsEjraee o
									on o.fldid=fldOrganPostEjraeeId
									where p.fldEmployeeId=Com.tblEmployee.fldId)organPost
	WHERE  fldCodeMoshakhase like @Value  AND (fldStatus IN (SELECT item FROM com.Split(@Value1,',')) or @Value1='')
	ORDER BY tblEmployee.fldId DESC
	
	if (@fieldname=N'CheckCodemeli')
SELECT     Com.tblEmployee.fldId, Com.tblEmployee.fldName, Com.tblEmployee.fldFamily, Com.tblEmployee.fldCodemeli, Com.tblEmployee.fldUserId, 
                      Com.tblEmployee.fldDesc, Com.tblEmployee.fldDate, Com.tblEmployee.fldStatus, 
                      CASE WHEN fldStatus = 1 THEN N'خصوصی' ELSE N'عمومی' END AS fldStatusName,
                      ISNULL(fldFatherName,'') AS fldFatherName
					  ,fldTypeShakhs,case when fldTypeShakhs=0 then N'اتباع داخلی' else N'اتباع خارجی' end as fldTypeShakhsName,fldSh_Shenasname
					  ,fldCodeMoshakhase,isnull(fldCodemeli,fldCodeMoshakhase)fldMeli_Moshakhase,isnull(organPost.fldTitle,'') fldPostEjraee,fldOrganPostEjraeeId
FROM         Com.tblEmployee LEFT OUTER JOIN
                      Com.tblEmployee_Detail ON Com.tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId
					  outer apply (select  o.fldTitle,fldOrganPostEjraeeId from prs.Prs_tblPersonalInfo p
									  inner join com.tblOrganizationalPostsEjraee o
									on o.fldid=fldOrganPostEjraeeId
									where p.fldEmployeeId=Com.tblEmployee.fldId)organPost
	WHERE  fldCodemeli like @Value 
	ORDER BY tblEmployee.fldId DESC
	
	if (@fieldname=N'fldName')
SELECT     Com.tblEmployee.fldId, Com.tblEmployee.fldName, Com.tblEmployee.fldFamily, Com.tblEmployee.fldCodemeli, Com.tblEmployee.fldUserId, 
                      Com.tblEmployee.fldDesc, Com.tblEmployee.fldDate, Com.tblEmployee.fldStatus, 
                      CASE WHEN fldStatus = 1 THEN N'خصوصی' ELSE N'عمومی' END AS fldStatusName,
                      ISNULL(fldFatherName,'') AS fldFatherName
					  ,fldTypeShakhs,case when fldTypeShakhs=0 then N'اتباع داخلی' else N'اتباع خارجی' end as fldTypeShakhsName,fldSh_Shenasname
					  ,fldCodeMoshakhase,isnull(fldCodemeli,fldCodeMoshakhase)fldMeli_Moshakhase,isnull(organPost.fldTitle,'') fldPostEjraee,fldOrganPostEjraeeId
FROM         Com.tblEmployee LEFT OUTER JOIN
                      Com.tblEmployee_Detail ON Com.tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId
					  outer apply (select  o.fldTitle,fldOrganPostEjraeeId from prs.Prs_tblPersonalInfo p
									  inner join com.tblOrganizationalPostsEjraee o
									on o.fldid=fldOrganPostEjraeeId
									where p.fldEmployeeId=Com.tblEmployee.fldId)organPost
	WHERE  fldName like @Value AND   (fldStatus IN (SELECT item FROM com.Split(@Value1,',')) or @Value1='' )
	ORDER BY tblEmployee.fldId DESC
	
	if (@fieldname=N'fldFamily')
SELECT      Com.tblEmployee.fldId, Com.tblEmployee.fldName, Com.tblEmployee.fldFamily, Com.tblEmployee.fldCodemeli, Com.tblEmployee.fldUserId, 
                      Com.tblEmployee.fldDesc, Com.tblEmployee.fldDate, Com.tblEmployee.fldStatus, 
                      CASE WHEN fldStatus = 1 THEN N'خصوصی' ELSE N'عمومی' END AS fldStatusName,
                      ISNULL(fldFatherName,'') AS fldFatherName
					  ,fldTypeShakhs,case when fldTypeShakhs=0 then N'اتباع داخلی' else N'اتباع خارجی' end as fldTypeShakhsName,fldSh_Shenasname
					  ,fldCodeMoshakhase,isnull(fldCodemeli,fldCodeMoshakhase)fldMeli_Moshakhase,isnull(organPost.fldTitle,'') fldPostEjraee,fldOrganPostEjraeeId
FROM         Com.tblEmployee LEFT OUTER JOIN
                      Com.tblEmployee_Detail ON Com.tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId
					  outer apply (select  o.fldTitle,fldOrganPostEjraeeId from prs.Prs_tblPersonalInfo p
									  inner join com.tblOrganizationalPostsEjraee o
									on o.fldid=fldOrganPostEjraeeId
									where p.fldEmployeeId=Com.tblEmployee.fldId)organPost
	WHERE  fldFamily like @Value  AND (fldStatus IN (SELECT item FROM com.Split(@Value1,',')) or @Value1='')
	ORDER BY tblEmployee.fldId DESC

	--
	if (@fieldname=N'fldStatusName')
SELECT     TOP (@h) * from(SELECT     Com.tblEmployee.fldId, Com.tblEmployee.fldName, Com.tblEmployee.fldFamily, Com.tblEmployee.fldCodemeli, Com.tblEmployee.fldUserId, 
                      Com.tblEmployee.fldDesc, Com.tblEmployee.fldDate, Com.tblEmployee.fldStatus, 
                      CASE WHEN fldStatus = 1 THEN N'خصوصی' ELSE N'عمومی' END AS fldStatusName,
                      ISNULL(fldFatherName,'') AS fldFatherName
					  ,fldTypeShakhs,case when fldTypeShakhs=0 then N'اتباع داخلی' else N'اتباع خارجی' end as fldTypeShakhsName,fldSh_Shenasname
					  ,fldCodeMoshakhase,isnull(fldCodemeli,fldCodeMoshakhase)fldMeli_Moshakhase,isnull(organPost.fldTitle,'') fldPostEjraee,fldOrganPostEjraeeId
FROM         Com.tblEmployee LEFT OUTER JOIN
                      Com.tblEmployee_Detail ON Com.tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId
					  outer apply (select  o.fldTitle,fldOrganPostEjraeeId from prs.Prs_tblPersonalInfo p
									  inner join com.tblOrganizationalPostsEjraee o
									on o.fldid=fldOrganPostEjraeeId
									where p.fldEmployeeId=Com.tblEmployee.fldId)organPost
									)as t
WHERE  fldStatusName like @Value
ORDER BY t.fldId DESC

if (@fieldname=N'fldTypeShakhsName')
SELECT     TOP (@h) * from(SELECT     TOP (@h) Com.tblEmployee.fldId, Com.tblEmployee.fldName, Com.tblEmployee.fldFamily, Com.tblEmployee.fldCodemeli, Com.tblEmployee.fldUserId, 
                      Com.tblEmployee.fldDesc, Com.tblEmployee.fldDate, Com.tblEmployee.fldStatus, 
                      CASE WHEN fldStatus = 1 THEN N'خصوصی' ELSE N'عمومی' END AS fldStatusName,
                      ISNULL(fldFatherName,'') AS fldFatherName
					  ,fldTypeShakhs,case when fldTypeShakhs=0 then N'اتباع داخلی' else N'اتباع خارجی' end as fldTypeShakhsName,fldSh_Shenasname
					  ,fldCodeMoshakhase,isnull(fldCodemeli,fldCodeMoshakhase)fldMeli_Moshakhase,isnull(organPost.fldTitle,'') fldPostEjraee,fldOrganPostEjraeeId
FROM         Com.tblEmployee LEFT OUTER JOIN
                      Com.tblEmployee_Detail ON Com.tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId
					  outer apply (select  o.fldTitle,fldOrganPostEjraeeId from prs.Prs_tblPersonalInfo p
									  inner join com.tblOrganizationalPostsEjraee o
									on o.fldid=fldOrganPostEjraeeId
									where p.fldEmployeeId=Com.tblEmployee.fldId)organPost
									)as t
WHERE  fldTypeShakhsName like @Value
ORDER BY t.fldId DESC

	if (@fieldname=N'fldDesc')
SELECT     TOP (@h) Com.tblEmployee.fldId, Com.tblEmployee.fldName, Com.tblEmployee.fldFamily, Com.tblEmployee.fldCodemeli, Com.tblEmployee.fldUserId, 
                      Com.tblEmployee.fldDesc, Com.tblEmployee.fldDate, Com.tblEmployee.fldStatus, 
                      CASE WHEN fldStatus = 1 THEN N'خصوصی' ELSE N'عمومی' END AS fldStatusName,
                      ISNULL(fldFatherName,'') AS fldFatherName
					  ,fldTypeShakhs,case when fldTypeShakhs=0 then N'اتباع داخلی' else N'اتباع خارجی' end as fldTypeShakhsName,fldSh_Shenasname
					  ,fldCodeMoshakhase,isnull(fldCodemeli,fldCodeMoshakhase)fldMeli_Moshakhase,isnull(organPost.fldTitle,'') fldPostEjraee,fldOrganPostEjraeeId
FROM         Com.tblEmployee LEFT OUTER JOIN
                      Com.tblEmployee_Detail ON Com.tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId
					  outer apply (select  o.fldTitle,fldOrganPostEjraeeId from prs.Prs_tblPersonalInfo p
									  inner join com.tblOrganizationalPostsEjraee o
									on o.fldid=fldOrganPostEjraeeId
									where p.fldEmployeeId=Com.tblEmployee.fldId)organPost
	WHERE  tblEmployee.fldDesc like @Value
	ORDER BY tblEmployee.fldId DESC

		if (@fieldname=N'fldMeli_Moshakhase')
SELECT     TOP (@h) * from (SELECT     TOP (@h) Com.tblEmployee.fldId, Com.tblEmployee.fldName, Com.tblEmployee.fldFamily, Com.tblEmployee.fldCodemeli, Com.tblEmployee.fldUserId, 
                      Com.tblEmployee.fldDesc, Com.tblEmployee.fldDate, Com.tblEmployee.fldStatus, 
                      CASE WHEN fldStatus = 1 THEN N'خصوصی' ELSE N'عمومی' END AS fldStatusName,
                      ISNULL(fldFatherName,'') AS fldFatherName
					  ,fldTypeShakhs,case when fldTypeShakhs=0 then N'اتباع داخلی' else N'اتباع خارجی' end as fldTypeShakhsName,fldSh_Shenasname
					  ,fldCodeMoshakhase,isnull(fldCodemeli,fldCodeMoshakhase)fldMeli_Moshakhase,isnull(organPost.fldTitle,'') fldPostEjraee,fldOrganPostEjraeeId
FROM         Com.tblEmployee LEFT OUTER JOIN
                      Com.tblEmployee_Detail ON Com.tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId
					  outer apply (select  o.fldTitle,fldOrganPostEjraeeId from prs.Prs_tblPersonalInfo p
									  inner join com.tblOrganizationalPostsEjraee o
									on o.fldid=fldOrganPostEjraeeId
									where p.fldEmployeeId=Com.tblEmployee.fldId)organPost
									)t
	WHERE  fldMeli_Moshakhase like @Value
	ORDER BY t.fldId DESC

	if (@fieldname=N'')
SELECT     TOP (@h) Com.tblEmployee.fldId, Com.tblEmployee.fldName, Com.tblEmployee.fldFamily, Com.tblEmployee.fldCodemeli, Com.tblEmployee.fldUserId, 
                      Com.tblEmployee.fldDesc, Com.tblEmployee.fldDate, Com.tblEmployee.fldStatus, 
                      CASE WHEN fldStatus = 1 THEN N'خصوصی' ELSE N'عمومی' END AS fldStatusName,
                      ISNULL(fldFatherName,'') AS fldFatherName
					  ,fldTypeShakhs,case when fldTypeShakhs=0 then N'اتباع داخلی' else N'اتباع خارجی' end as fldTypeShakhsName,fldSh_Shenasname
					  ,fldCodeMoshakhase,isnull(fldCodemeli,fldCodeMoshakhase)fldMeli_Moshakhase,isnull(organPost.fldTitle,'') fldPostEjraee,fldOrganPostEjraeeId
FROM         Com.tblEmployee LEFT OUTER JOIN
                      Com.tblEmployee_Detail ON Com.tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId
					  outer apply (select  o.fldTitle,fldOrganPostEjraeeId from prs.Prs_tblPersonalInfo p
									  inner join com.tblOrganizationalPostsEjraee o
									on o.fldid=fldOrganPostEjraeeId
									where p.fldEmployeeId=Com.tblEmployee.fldId)organPost
                      WHERE    (fldStatus IN (SELECT item FROM com.Split(@Value1,',')) or @Value1='')
					  ORDER BY tblEmployee.fldId DESC



	COMMIT
GO
