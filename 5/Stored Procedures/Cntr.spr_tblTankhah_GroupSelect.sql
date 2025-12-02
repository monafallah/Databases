SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Cntr].[spr_tblTankhah_GroupSelect] 
@fieldname nvarchar(50),
@value nvarchar(50),
@OrganId int,
@h int
AS 
 
	set @value=com.fn_TextNormalize(@value)
	if (@h=0) set @h=2147483647 
	BEGIN TRAN
	if (@fieldname='fldId')
	SELECT top(@h)g.[fldId], [fldTankhahId], [fldTitle], g.[fldUserId], g.[fldOrganId], g.[fldDesc], g.[fldIP], g.[fldDate] 
		,e.fldName+' '+e.fldFamily as fldTankhahName,fldEmployeeId 
	FROM   [Cntr].[tblTankhah_Group]  g
	inner join cntr.tblTanKhahGardan t on t.fldid=fldTankhahId
	inner join com.tblEmployee e on e.fldid=fldEmployeeId
	WHERE  g.fldId=@value
	
	if (@fieldname='')
	SELECT top(@h)g.[fldId], [fldTankhahId], [fldTitle], g.[fldUserId], g.[fldOrganId], g.[fldDesc], g.[fldIP], g.[fldDate] 
		,e.fldName+' '+e.fldFamily as fldTankhahName,fldEmployeeId 
	FROM   [Cntr].[tblTankhah_Group]  g
	inner join cntr.tblTanKhahGardan t on t.fldid=fldTankhahId
	inner join com.tblEmployee e on e.fldid=fldEmployeeId
	
	if (@fieldname='fldOrganId')
	SELECT top(@h)g.[fldId], [fldTankhahId], [fldTitle], g.[fldUserId], g.[fldOrganId], g.[fldDesc], g.[fldIP], g.[fldDate] 
		,e.fldName+' '+e.fldFamily as fldTankhahName,fldEmployeeId 
	FROM   [Cntr].[tblTankhah_Group]  g
	inner join cntr.tblTanKhahGardan t on t.fldid=fldTankhahId
	inner join com.tblEmployee e on e.fldid=fldEmployeeId
	where g.fldOrganId=@OrganId


		if (@fieldname='fldTankhahId')
	SELECT top(@h)g.[fldId], [fldTankhahId], [fldTitle], g.[fldUserId], g.[fldOrganId], g.[fldDesc], g.[fldIP], g.[fldDate] 
		,e.fldName+' '+e.fldFamily as fldTankhahName,fldEmployeeId 
	FROM   [Cntr].[tblTankhah_Group]  g
	inner join cntr.tblTanKhahGardan t on t.fldid=fldTankhahId
	inner join com.tblEmployee e on e.fldid=fldEmployeeId
	where fldTankhahId=@value and g.fldOrganId=@OrganId

	
		if (@fieldname='fldTitle')
	SELECT top(@h)g.[fldId], [fldTankhahId], [fldTitle], g.[fldUserId], g.[fldOrganId], g.[fldDesc], g.[fldIP], g.[fldDate] 
		,e.fldName+' '+e.fldFamily as fldTankhahName,fldEmployeeId 
	FROM   [Cntr].[tblTankhah_Group]  g
	inner join cntr.tblTanKhahGardan t on t.fldid=fldTankhahId
	inner join com.tblEmployee e on e.fldid=fldEmployeeId
	where fldTitle like @value and g.fldOrganId=@OrganId


		if (@fieldname='fldTankhahName')
	SELECT top(@h)* from (select g.[fldId], [fldTankhahId], [fldTitle], g.[fldUserId], g.[fldOrganId], g.[fldDesc], g.[fldIP], g.[fldDate] 
		,e.fldName+' '+e.fldFamily as fldTankhahName,fldEmployeeId 
	FROM   [Cntr].[tblTankhah_Group]  g
	inner join cntr.tblTanKhahGardan t on t.fldid=fldTankhahId
	inner join com.tblEmployee e on e.fldid=fldEmployeeId
	where  g.fldOrganId=@OrganId
	)t where fldTankhahName like @value 

		if (@fieldname='AllFactorTrue')
	SELECT top(@h)g.[fldId], [fldTankhahId], [fldTitle], g.[fldUserId], g.[fldOrganId], g.[fldDesc], g.[fldIP], g.[fldDate] 
		,e.fldName+' '+e.fldFamily as fldTankhahName,fldEmployeeId 
	FROM   [Cntr].[tblTankhah_Group]  g
	inner join cntr.tblTanKhahGardan t on t.fldid=fldTankhahId
	inner join com.tblEmployee e on e.fldid=fldEmployeeId
	where/* g.[fldId]=@value  and*/ g.fldOrganId=@OrganId
	and exists (select  * from cntr.tblFactorMostaghel c1  	where c1.fldTankhahGroupId=g.fldid  ) 
	and not exists (select * from cntr.tblFactorMostaghel m inner join cntr.tblFactor f 
	on f.fldid=m.fldFactorId where fldTankhahGroupId=g.fldid and f.fldStatus<>1)

		if (@fieldname='FactorNotFalse')
	SELECT top(@h)g.[fldId], [fldTankhahId], [fldTitle], g.[fldUserId], g.[fldOrganId], g.[fldDesc], g.[fldIP], g.[fldDate] 
		,e.fldName+' '+e.fldFamily as fldTankhahName,fldEmployeeId 
	FROM   [Cntr].[tblTankhah_Group]  g
	inner join cntr.tblTanKhahGardan t on t.fldid=fldTankhahId
	inner join com.tblEmployee e on e.fldid=fldEmployeeId
	where/* g.[fldId]=@value  and*/ g.fldOrganId=@OrganId
	and not exists (select * from cntr.tblFactorMostaghel m inner join cntr.tblFactor f 
	on f.fldid=m.fldFactorId where fldTankhahGroupId=g.fldid and f.fldStatus<>1)


		if (@fieldname='FactorIsFalse')
	SELECT top(@h)g.[fldId], [fldTankhahId], [fldTitle], g.[fldUserId], g.[fldOrganId], g.[fldDesc], g.[fldIP], g.[fldDate] 
		,e.fldName+' '+e.fldFamily as fldTankhahName,fldEmployeeId 
	FROM   [Cntr].[tblTankhah_Group]  g
	inner join cntr.tblTanKhahGardan t on t.fldid=fldTankhahId
	inner join com.tblEmployee e on e.fldid=fldEmployeeId
	where/* g.[fldId]=@value  and*/ g.fldOrganId=@OrganId
	and  exists (select * from cntr.tblFactorMostaghel m inner join cntr.tblFactor f 
	on f.fldid=m.fldFactorId where fldTankhahGroupId=g.fldid and f.fldStatus=0)


	COMMIT
GO
