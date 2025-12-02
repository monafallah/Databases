SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblUser_GroupSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@h int
AS 
	BEGIN TRAN
	if (@h=0) set @h=2147483647
	SET @Value=Com.fn_TextNormalize(@Value)
	if (@fieldname=N'fldId')
SELECT        TOP (@h) Com.tblUser_Group.fldId, Com.tblUser_Group.fldUserGroupId, Com.tblUser_Group.fldUserSelectId, Com.tblUser_Group.fldUserId, Com.tblUser_Group.fldGrant, Com.tblUser_Group.fldWithGrant, 
                         Com.tblUser_Group.fldDesc, Com.tblUser_Group.fldDate, Com.tblEmployee.fldName + ' ' + Com.tblEmployee.fldFamily AS fldName, Com.tblEmployee.fldCodemeli, Com.tblEmployee_Detail.fldFatherName
FROM            Com.tblUser_Group INNER JOIN
                         Com.tblUser ON Com.tblUser_Group.fldUserSelectId = Com.tblUser.fldId INNER JOIN
                         Com.tblEmployee ON Com.tblUser.fldEmployId = Com.tblEmployee.fldId LEFT OUTER JOIN
                         Com.tblEmployee_Detail ON Com.tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId
						 WHERE tblUser_Group.fldId = @Value
	
	if (@fieldname=N'fldUserSelectId')
SELECT        TOP (@h) Com.tblUser_Group.fldId, Com.tblUser_Group.fldUserGroupId, Com.tblUser_Group.fldUserSelectId, Com.tblUser_Group.fldUserId, Com.tblUser_Group.fldGrant, Com.tblUser_Group.fldWithGrant, 
                         Com.tblUser_Group.fldDesc, Com.tblUser_Group.fldDate, Com.tblEmployee.fldName + ' ' + Com.tblEmployee.fldFamily AS fldName, Com.tblEmployee.fldCodemeli, Com.tblEmployee_Detail.fldFatherName
FROM            Com.tblUser_Group INNER JOIN
                         Com.tblUser ON Com.tblUser_Group.fldUserSelectId = Com.tblUser.fldId INNER JOIN
                         Com.tblEmployee ON Com.tblUser.fldEmployId = Com.tblEmployee.fldId LEFT OUTER JOIN
                         Com.tblEmployee_Detail ON Com.tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId
							WHERE  fldUserSelectId like @Value

		if (@fieldname=N'fldName')
SELECT        TOP (@h) * from (select  Com.tblUser_Group.fldId, Com.tblUser_Group.fldUserGroupId, Com.tblUser_Group.fldUserSelectId, Com.tblUser_Group.fldUserId, Com.tblUser_Group.fldGrant, Com.tblUser_Group.fldWithGrant, 
                         Com.tblUser_Group.fldDesc, Com.tblUser_Group.fldDate, Com.tblEmployee.fldName + ' ' + Com.tblEmployee.fldFamily AS fldName, Com.tblEmployee.fldCodemeli, Com.tblEmployee_Detail.fldFatherName
FROM            Com.tblUser_Group INNER JOIN
                         Com.tblUser ON Com.tblUser_Group.fldUserSelectId = Com.tblUser.fldId INNER JOIN
                         Com.tblEmployee ON Com.tblUser.fldEmployId = Com.tblEmployee.fldId LEFT OUTER JOIN
                         Com.tblEmployee_Detail ON Com.tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId)t
						 WHERE  t.fldName like @Value

							if (@fieldname=N'fldCodemeli')
SELECT        TOP (@h) Com.tblUser_Group.fldId, Com.tblUser_Group.fldUserGroupId, Com.tblUser_Group.fldUserSelectId, Com.tblUser_Group.fldUserId, Com.tblUser_Group.fldGrant, Com.tblUser_Group.fldWithGrant, 
                         Com.tblUser_Group.fldDesc, Com.tblUser_Group.fldDate, Com.tblEmployee.fldName + ' ' + Com.tblEmployee.fldFamily AS fldName, Com.tblEmployee.fldCodemeli, Com.tblEmployee_Detail.fldFatherName
FROM            Com.tblUser_Group INNER JOIN
                         Com.tblUser ON Com.tblUser_Group.fldUserSelectId = Com.tblUser.fldId INNER JOIN
                         Com.tblEmployee ON Com.tblUser.fldEmployId = Com.tblEmployee.fldId LEFT OUTER JOIN
                         Com.tblEmployee_Detail ON Com.tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId
						where fldCodemeli like @Value

						
							if (@fieldname=N'fldUserGroupId')
SELECT        TOP (@h) Com.tblUser_Group.fldId, Com.tblUser_Group.fldUserGroupId, Com.tblUser_Group.fldUserSelectId, Com.tblUser_Group.fldUserId, Com.tblUser_Group.fldGrant, Com.tblUser_Group.fldWithGrant, 
                         Com.tblUser_Group.fldDesc, Com.tblUser_Group.fldDate, Com.tblEmployee.fldName + ' ' + Com.tblEmployee.fldFamily AS fldName, Com.tblEmployee.fldCodemeli, Com.tblEmployee_Detail.fldFatherName
FROM            Com.tblUser_Group INNER JOIN
                         Com.tblUser ON Com.tblUser_Group.fldUserSelectId = Com.tblUser.fldId INNER JOIN
                         Com.tblEmployee ON Com.tblUser.fldEmployId = Com.tblEmployee.fldId LEFT OUTER JOIN
                         Com.tblEmployee_Detail ON Com.tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId
						 	where fldUserGroupId like @VALUE



						if (@fieldname=N'fldFatherName')
SELECT        TOP (@h) Com.tblUser_Group.fldId, Com.tblUser_Group.fldUserGroupId, Com.tblUser_Group.fldUserSelectId, Com.tblUser_Group.fldUserId, Com.tblUser_Group.fldGrant, Com.tblUser_Group.fldWithGrant, 
                         Com.tblUser_Group.fldDesc, Com.tblUser_Group.fldDate, Com.tblEmployee.fldName + ' ' + Com.tblEmployee.fldFamily AS fldName, Com.tblEmployee.fldCodemeli, Com.tblEmployee_Detail.fldFatherName
FROM            Com.tblUser_Group INNER JOIN
                         Com.tblUser ON Com.tblUser_Group.fldUserSelectId = Com.tblUser.fldId INNER JOIN
                         Com.tblEmployee ON Com.tblUser.fldEmployId = Com.tblEmployee.fldId LEFT OUTER JOIN
                         Com.tblEmployee_Detail ON Com.tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId
						where fldFatherName like @Value




	if (@fieldname=N'fldDesc')
SELECT        TOP (@h) Com.tblUser_Group.fldId, Com.tblUser_Group.fldUserGroupId, Com.tblUser_Group.fldUserSelectId, Com.tblUser_Group.fldUserId, Com.tblUser_Group.fldGrant, Com.tblUser_Group.fldWithGrant, 
                         Com.tblUser_Group.fldDesc, Com.tblUser_Group.fldDate, Com.tblEmployee.fldName + ' ' + Com.tblEmployee.fldFamily AS fldName, Com.tblEmployee.fldCodemeli, Com.tblEmployee_Detail.fldFatherName
FROM            Com.tblUser_Group INNER JOIN
                         Com.tblUser ON Com.tblUser_Group.fldUserSelectId = Com.tblUser.fldId INNER JOIN
                         Com.tblEmployee ON Com.tblUser.fldEmployId = Com.tblEmployee.fldId LEFT OUTER JOIN
                         Com.tblEmployee_Detail ON Com.tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId
							WHERE  Com.tblUser_Group.fldDesc like @Value
							
							
							if (@fieldname=N'fldUserGroupId_Active')
SELECT        TOP (@h) Com.tblUser_Group.fldId, Com.tblUser_Group.fldUserGroupId, Com.tblUser_Group.fldUserSelectId, Com.tblUser_Group.fldUserId, Com.tblUser_Group.fldGrant, Com.tblUser_Group.fldWithGrant, 
                         Com.tblUser_Group.fldDesc, Com.tblUser_Group.fldDate, Com.tblEmployee.fldName + ' ' + Com.tblEmployee.fldFamily AS fldName, Com.tblEmployee.fldCodemeli, Com.tblEmployee_Detail.fldFatherName
FROM            Com.tblUser_Group INNER JOIN
                         Com.tblUser ON Com.tblUser_Group.fldUserSelectId = Com.tblUser.fldId INNER JOIN
                         Com.tblEmployee ON Com.tblUser.fldEmployId = Com.tblEmployee.fldId LEFT OUTER JOIN
                         Com.tblEmployee_Detail ON Com.tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId
						 	where fldUserGroupId like @VALUE AND fldActive_Deactive=1
						 	
								if (@fieldname=N'fldFatherName_Active')
SELECT        TOP (@h) Com.tblUser_Group.fldId, Com.tblUser_Group.fldUserGroupId, Com.tblUser_Group.fldUserSelectId, Com.tblUser_Group.fldUserId, Com.tblUser_Group.fldGrant, Com.tblUser_Group.fldWithGrant, 
                         Com.tblUser_Group.fldDesc, Com.tblUser_Group.fldDate, Com.tblEmployee.fldName + ' ' + Com.tblEmployee.fldFamily AS fldName, Com.tblEmployee.fldCodemeli, Com.tblEmployee_Detail.fldFatherName
FROM            Com.tblUser_Group INNER JOIN
                         Com.tblUser ON Com.tblUser_Group.fldUserSelectId = Com.tblUser.fldId INNER JOIN
                         Com.tblEmployee ON Com.tblUser.fldEmployId = Com.tblEmployee.fldId LEFT OUTER JOIN
                         Com.tblEmployee_Detail ON Com.tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId
						where fldFatherName like @Value AND fldActive_Deactive=1
						
						
			if (@fieldname=N'fldName_Active')
SELECT        TOP (@h) * from (select  Com.tblUser_Group.fldId, Com.tblUser_Group.fldUserGroupId, Com.tblUser_Group.fldUserSelectId, Com.tblUser_Group.fldUserId, Com.tblUser_Group.fldGrant, Com.tblUser_Group.fldWithGrant, 
                         Com.tblUser_Group.fldDesc, Com.tblUser_Group.fldDate, Com.tblEmployee.fldName + ' ' + Com.tblEmployee.fldFamily AS fldName, Com.tblEmployee.fldCodemeli, Com.tblEmployee_Detail.fldFatherName
FROM            Com.tblUser_Group INNER JOIN
                         Com.tblUser ON Com.tblUser_Group.fldUserSelectId = Com.tblUser.fldId INNER JOIN
                         Com.tblEmployee ON Com.tblUser.fldEmployId = Com.tblEmployee.fldId LEFT OUTER JOIN
                         Com.tblEmployee_Detail ON Com.tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId
                         WHERE   fldActive_Deactive=1)t
						 WHERE  t.fldName like @Value 

							if (@fieldname=N'fldCodemeli_Active')
SELECT        TOP (@h) Com.tblUser_Group.fldId, Com.tblUser_Group.fldUserGroupId, Com.tblUser_Group.fldUserSelectId, Com.tblUser_Group.fldUserId, Com.tblUser_Group.fldGrant, Com.tblUser_Group.fldWithGrant, 
                         Com.tblUser_Group.fldDesc, Com.tblUser_Group.fldDate, Com.tblEmployee.fldName + ' ' + Com.tblEmployee.fldFamily AS fldName, Com.tblEmployee.fldCodemeli, Com.tblEmployee_Detail.fldFatherName
FROM            Com.tblUser_Group INNER JOIN
                         Com.tblUser ON Com.tblUser_Group.fldUserSelectId = Com.tblUser.fldId INNER JOIN
                         Com.tblEmployee ON Com.tblUser.fldEmployId = Com.tblEmployee.fldId LEFT OUTER JOIN
                         Com.tblEmployee_Detail ON Com.tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId
						where fldCodemeli like @Value  AND fldActive_Deactive=1
									 	
						 	
							if (@fieldname=N'fldUserGroupId')
SELECT        TOP (@h) Com.tblUser_Group.fldId, Com.tblUser_Group.fldUserGroupId, Com.tblUser_Group.fldUserSelectId, Com.tblUser_Group.fldUserId, Com.tblUser_Group.fldGrant, Com.tblUser_Group.fldWithGrant, 
                         Com.tblUser_Group.fldDesc, Com.tblUser_Group.fldDate, Com.tblEmployee.fldName + ' ' + Com.tblEmployee.fldFamily AS fldName, Com.tblEmployee.fldCodemeli, Com.tblEmployee_Detail.fldFatherName
FROM            Com.tblUser_Group INNER JOIN
                         Com.tblUser ON Com.tblUser_Group.fldUserSelectId = Com.tblUser.fldId INNER JOIN
                         Com.tblEmployee ON Com.tblUser.fldEmployId = Com.tblEmployee.fldId LEFT OUTER JOIN
                         Com.tblEmployee_Detail ON Com.tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId
						 	where fldUserGroupId like @VALUE
						 	
						 	
						 	
						 							 	
						 								

	if (@fieldname=N'')
SELECT        TOP (@h) Com.tblUser_Group.fldId, Com.tblUser_Group.fldUserGroupId, Com.tblUser_Group.fldUserSelectId, Com.tblUser_Group.fldUserId, Com.tblUser_Group.fldGrant, Com.tblUser_Group.fldWithGrant, 
                         Com.tblUser_Group.fldDesc, Com.tblUser_Group.fldDate, Com.tblEmployee.fldName + ' ' + Com.tblEmployee.fldFamily AS fldName, Com.tblEmployee.fldCodemeli, Com.tblEmployee_Detail.fldFatherName
FROM            Com.tblUser_Group INNER JOIN
                         Com.tblUser ON Com.tblUser_Group.fldUserSelectId = Com.tblUser.fldId INNER JOIN
                         Com.tblEmployee ON Com.tblUser.fldEmployId = Com.tblEmployee.fldId LEFT OUTER JOIN
                         Com.tblEmployee_Detail ON Com.tblEmployee.fldId = Com.tblEmployee_Detail.fldEmployeeId
										
	COMMIT
GO
