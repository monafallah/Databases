SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Cntr].[spr_tblTanKhahGardanSelect] 
@fieldname nvarchar(50),
@value nvarchar(50),
@OrganId int,
@h int
AS 
 
	set @value=com.fn_TextNormalize(@value)
	if (@h=0) set @h=2147483647 
	BEGIN TRAN
	if (@fieldname='fldId')
	SELECT top(@h)t.[fldId], [fldEmployeeId], t.[fldStatus], t.[fldOrganId], t.[fldUserId], t.[fldDesc], t.[fldDate], t.[fldIP] 
	,case when t.[fldStatus]=1 then N'فعال 'else N'غیر فعال ' end as fldStatusName
	,e.fldName+' '+e.fldFamily as fldName_Family
	FROM   [Cntr].[tblTanKhahGardan] t 
	inner join com.tblEmployee e on e.fldid=fldEmployeeId
	WHERE  t.fldId=@value

	if (@fieldname='fldEmployeeId')
	SELECT top(@h)t.[fldId], [fldEmployeeId], t.[fldStatus], t.[fldOrganId], t.[fldUserId], t.[fldDesc], t.[fldDate], t.[fldIP] 
	,case when t.[fldStatus]=1 then N'فعال 'else N'غیر فعال ' end as fldStatusName
	,e.fldName+' '+e.fldFamily as fldName_Family
	FROM   [Cntr].[tblTanKhahGardan] t 
	inner join com.tblEmployee e on e.fldid=fldEmployeeId
	WHERE fldEmployeeId=@value and fldOrganId=@OrganId


	if (@fieldname='fldName_Family')
	SELECT top(@h)* from (select t.[fldId], [fldEmployeeId], t.[fldStatus], t.[fldOrganId], t.[fldUserId], t.[fldDesc], t.[fldDate], t.[fldIP] 
	,case when t.[fldStatus]=1 then N'فعال 'else N'غیر فعال ' end as fldStatusName
	,e.fldName+' '+e.fldFamily as fldName_Family
	FROM   [Cntr].[tblTanKhahGardan] t 
	inner join com.tblEmployee e on e.fldid=fldEmployeeId  and fldOrganId=@OrganId
	)t
	WHERE fldName_Family like @value
	
	if (@fieldname='')
	SELECT top(@h)t.[fldId], [fldEmployeeId], t.[fldStatus], t.[fldOrganId], t.[fldUserId], t.[fldDesc], t.[fldDate], t.[fldIP] 
	,case when t.[fldStatus]=1 then N'فعال 'else N'غیر فعال ' end as fldStatusName
	,e.fldName+' '+e.fldFamily as fldName_Family
	FROM   [Cntr].[tblTanKhahGardan] t 
	inner join com.tblEmployee e on e.fldid=fldEmployeeId  and fldOrganId=@OrganId
	

	if (@fieldname='fldUserId')
	begin
		/*اگر یوزر ورودی به تنخواه گردان دسترسی داشت همه تنخواه براش لیست شود */
		if exists (select * from com.tblUser_Group u
					inner join com.tblUserGroup_ModuleOrgan um on u.fldUserGroupId=um.fldUserGroupId
					inner join com.tblModule_Organ m on m.fldid=um.fldModuleOrganId
					inner join com.tblPermission p on p.fldUserGroup_ModuleOrganID=um.fldid
					where fldUserSelectId=@value and fldApplicationPartID=1310 and m.fldOrganId=@OrganId)


		SELECT top(@h)t.[fldId], [fldEmployeeId], t.[fldStatus], t.[fldOrganId], t.[fldUserId], t.[fldDesc], t.[fldDate], t.[fldIP] 
		,case when t.[fldStatus]=1 then N'فعال 'else N'غیر فعال ' end as fldStatusName
		,e.fldName+' '+e.fldFamily as fldName_Family
		FROM   [Cntr].[tblTanKhahGardan] t 
		inner join com.tblEmployee e on e.fldid=fldEmployeeId 
		where fldOrganId=@OrganId

	else
		 /*اگر دسترسی نداشت فقط تنخواه مربوط به آن یوزر لیست شود*/
		SELECT top(@h)t.[fldId], [fldEmployeeId], t.[fldStatus], t.[fldOrganId], t.[fldUserId], t.[fldDesc], t.[fldDate], t.[fldIP] 
		,case when t.[fldStatus]=1 then N'فعال 'else N'غیر فعال ' end as fldStatusName
		,e.fldName+' '+e.fldFamily as fldName_Family
		FROM   [Cntr].[tblTanKhahGardan] t 
		inner join com.tblEmployee e on e.fldid=fldEmployeeId 
		inner join com.tblUser u on u.fldEmployId=e.fldId
		where fldOrganId=@OrganId and u.fldid=@value

	end

	COMMIT
GO
