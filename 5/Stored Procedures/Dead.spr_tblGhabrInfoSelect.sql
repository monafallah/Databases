SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Dead].[spr_tblGhabrInfoSelect] 
@fieldname nvarchar(50),
@value nvarchar(50),
@value2 nvarchar(50),
@h int
AS 
 
	set @value=com.fn_TextNormalize(@value)
	if (@h=0) set @h=2147483647 
	BEGIN TRAN
	if (@fieldname='fldId')
	SELECT top(@h)i.[fldId],ltrim( i.[fldName])[fldName],ltrim( i.[fldFamily])[fldFamily], ltrim(i.[fldNameFather])[fldNameFather], ltrim(i.[fldBDate])[fldBDate], ltrim(i.[fldDeathDate])[fldDeathDate],fldObjectId, i.[fldUserId], i.[fldOrganId],i.[fldDate] 
	,i.fldStatus,case when i.fldStatus=1 then N'خالی' when i. fldStatus=2 then N'پر' when i.fldStatus=3 then N'امانت' end  fldStatusName
	,i.fldTabaghe/*,'https://www.google.com/maps?q=36.3818,54.913' fldLocationGoogle--*/,dead.fn_LinkGoogleMap(fldObjectId) as fldLocationGoogle  
	,i.fldGheteId, isnull(g.fldNameGhete,'')fldNameGhete,c.fldName as fldNameCity,v.fldName as fldVadiName,fldMeliCode 
	FROM   [Dead].[tblGhabrInfo] i
	/*inner join AramDB.dbo.RECATANGLE_8 r
	on r.OBJECTID=fldObjectId*/
	left  join Dead.tblGhete g on g.fldid=fldGheteId
	left join dead.tblVadiSalam v on v.fldid=fldVadiSalamId
	left join com.tblCity c on c.fldid=fldCityId
	WHERE  i.fldId=@value
	
	if (@fieldname='fldName')
	begin
	if (@value2='1')
	SELECT top(@h)i.[fldId],ltrim( i.[fldName])[fldName],ltrim( i.[fldFamily])[fldFamily], ltrim(i.[fldNameFather])[fldNameFather], ltrim(i.[fldBDate])[fldBDate], ltrim(i.[fldDeathDate])[fldDeathDate],fldObjectId, i.[fldUserId], i.[fldOrganId],i.[fldDate] 
	,i.fldStatus,case when i.fldStatus=1 then N'خالی' when i. fldStatus=2 then N'پر' when i.fldStatus=3 then N'امانت' end  fldStatusName
	,i.fldTabaghe/*,'https://www.google.com/maps?q=36.3818,54.913' fldLocationGoogle--*/,dead.fn_LinkGoogleMap(fldObjectId) as fldLocationGoogle  
	,i.fldGheteId, isnull(g.fldNameGhete,'')fldNameGhete,c.fldName as fldNameCity,v.fldName as fldVadiName,fldMeliCode 
	FROM   [Dead].[tblGhabrInfo] i
/*	inner join AramDB.dbo.RECATANGLE_8 r
	on r.OBJECTID=fldObjectId*/
	left  join Dead.tblGhete g on g.fldid=fldGheteId
	left join dead.tblVadiSalam v on v.fldid=fldVadiSalamId
	left join com.tblCity c on c.fldid=fldCityId
	 where i.fldName like @value 

	if (@value2='2')
	SELECT top(@h)i.[fldId],ltrim( i.[fldName])[fldName],ltrim( i.[fldFamily])[fldFamily], ltrim(i.[fldNameFather])[fldNameFather], ltrim(i.[fldBDate])[fldBDate], ltrim(i.[fldDeathDate])[fldDeathDate],fldObjectId, i.[fldUserId], i.[fldOrganId],i.[fldDate] 
	,i.fldStatus,case when i.fldStatus=1 then N'خالی' when i. fldStatus=2 then N'پر' when i.fldStatus=3 then N'امانت' end  fldStatusName
	,i.fldTabaghe/*,'https://www.google.com/maps?q=36.3818,54.913' fldLocationGoogle--*/,dead.fn_LinkGoogleMap(fldObjectId) as fldLocationGoogle  
	,i.fldGheteId, isnull(g.fldNameGhete,'')fldNameGhete,c.fldName as fldNameCity,v.fldName as fldVadiName,fldMeliCode 
	FROM   [Dead].[tblGhabrInfo] i
	/*inner join AramDB.dbo.RECATANGLE_8 r
	on r.OBJECTID=fldObjectId*/
	left  join Dead.tblGhete g on g.fldid=fldGheteId
	left join dead.tblVadiSalam v on v.fldid=fldVadiSalamId
	left join com.tblCity c on c.fldid=fldCityId
	where i.fldName='' and i.fldFamily='' and i.fldName like @value

	if (@value2='3')
	SELECT top(@h)i.[fldId],ltrim( i.[fldName])[fldName],ltrim( i.[fldFamily])[fldFamily], ltrim(i.[fldNameFather])[fldNameFather], ltrim(i.[fldBDate])[fldBDate], ltrim(i.[fldDeathDate])[fldDeathDate],fldObjectId, i.[fldUserId], i.[fldOrganId],i.[fldDate] 
	,i.fldStatus,case when i.fldStatus=1 then N'خالی' when i. fldStatus=2 then N'پر' when i.fldStatus=3 then N'امانت' end  fldStatusName
	,i.fldTabaghe/*,'https://www.google.com/maps?q=36.3818,54.913' fldLocationGoogle--*/,dead.fn_LinkGoogleMap(fldObjectId) as fldLocationGoogle  
	,i.fldGheteId, isnull(g.fldNameGhete,'')fldNameGhete,c.fldName as fldNameCity,v.fldName as fldVadiName,fldMeliCode 
	FROM   [Dead].[tblGhabrInfo] i
	/*inner join AramDB.dbo.RECATANGLE_8 r
	on r.OBJECTID=fldObjectId*/
	left  join Dead.tblGhete g on g.fldid=fldGheteId
	left join dead.tblVadiSalam v on v.fldid=fldVadiSalamId
	left join com.tblCity c on c.fldid=fldCityId
	where i.fldName<>'' and i.fldFamily<>'' and i.fldName like @value
	order by fldid desc
	end

	
	if (@fieldname='fldFamily')
	begin
	if (@value2='1')
	SELECT top(@h)i.[fldId],ltrim( i.[fldName])[fldName],ltrim( i.[fldFamily])[fldFamily], ltrim(i.[fldNameFather])[fldNameFather], ltrim(i.[fldBDate])[fldBDate], ltrim(i.[fldDeathDate])[fldDeathDate],fldObjectId, i.[fldUserId], i.[fldOrganId],i.[fldDate] 
	,i.fldStatus,case when i.fldStatus=1 then N'خالی' when i. fldStatus=2 then N'پر' when i.fldStatus=3 then N'امانت' end  fldStatusName
	,i.fldTabaghe/*,'https://www.google.com/maps?q=36.3818,54.913' fldLocationGoogle--*/,dead.fn_LinkGoogleMap(fldObjectId) as fldLocationGoogle  
	,i.fldGheteId, isnull(g.fldNameGhete,'')fldNameGhete,c.fldName as fldNameCity,v.fldName as fldVadiName,fldMeliCode 
	FROM   [Dead].[tblGhabrInfo] i
	/*inner join AramDB.dbo.RECATANGLE_8 r
	on r.OBJECTID=fldObjectId*/
	left  join Dead.tblGhete g on g.fldid=fldGheteId
	left join dead.tblVadiSalam v on v.fldid=fldVadiSalamId
	left join com.tblCity c on c.fldid=fldCityId
	 where i.fldFamily like @value 

	if (@value2='2')
	SELECT top(@h)i.[fldId],ltrim( i.[fldName])[fldName],ltrim( i.[fldFamily])[fldFamily], ltrim(i.[fldNameFather])[fldNameFather], ltrim(i.[fldBDate])[fldBDate], ltrim(i.[fldDeathDate])[fldDeathDate],fldObjectId, i.[fldUserId], i.[fldOrganId],i.[fldDate] 
	,i.fldStatus,case when i.fldStatus=1 then N'خالی' when i. fldStatus=2 then N'پر' when i.fldStatus=3 then N'امانت' end  fldStatusName
	,i.fldTabaghe/*,'https://www.google.com/maps?q=36.3818,54.913' fldLocationGoogle--*/,dead.fn_LinkGoogleMap(fldObjectId) as fldLocationGoogle  
	,i.fldGheteId, isnull(g.fldNameGhete,'')fldNameGhete,c.fldName as fldNameCity,v.fldName as fldVadiName,fldMeliCode 
	FROM   [Dead].[tblGhabrInfo] i
	/*inner join AramDB.dbo.RECATANGLE_8 r
	on r.OBJECTID=fldObjectId*/
	left  join Dead.tblGhete g on g.fldid=fldGheteId
	left join dead.tblVadiSalam v on v.fldid=fldVadiSalamId
	left join com.tblCity c on c.fldid=fldCityId 
	where i.fldName='' and i.fldFamily='' and i.fldFamily like @value

	if (@value2='3')
	SELECT top(@h)i.[fldId],ltrim( i.[fldName])[fldName],ltrim( i.[fldFamily])[fldFamily], ltrim(i.[fldNameFather])[fldNameFather], ltrim(i.[fldBDate])[fldBDate], ltrim(i.[fldDeathDate])[fldDeathDate],fldObjectId, i.[fldUserId], i.[fldOrganId],i.[fldDate] 
	,i.fldStatus,case when i.fldStatus=1 then N'خالی' when i. fldStatus=2 then N'پر' when i.fldStatus=3 then N'امانت' end  fldStatusName
	,i.fldTabaghe/*,'https://www.google.com/maps?q=36.3818,54.913' fldLocationGoogle--*/,dead.fn_LinkGoogleMap(fldObjectId) as fldLocationGoogle  
	,i.fldGheteId, isnull(g.fldNameGhete,'')fldNameGhete,c.fldName as fldNameCity,v.fldName as fldVadiName,fldMeliCode 
	FROM   [Dead].[tblGhabrInfo] i
	/*inner join AramDB.dbo.RECATANGLE_8 r
	on r.OBJECTID=fldObjectId*/
	left  join Dead.tblGhete g on g.fldid=fldGheteId
	left join dead.tblVadiSalam v on v.fldid=fldVadiSalamId
	left join com.tblCity c on c.fldid=fldCityId
	where i.fldName<>'' and i.fldFamily<>'' and i.fldFamily like @value
	order by fldid desc
	end

	
	if (@fieldname='fldNameFather')
	begin
	if (@value2='1')
	SELECT top(@h)i.[fldId],ltrim( i.[fldName])[fldName],ltrim( i.[fldFamily])[fldFamily], ltrim(i.[fldNameFather])[fldNameFather], ltrim(i.[fldBDate])[fldBDate], ltrim(i.[fldDeathDate])[fldDeathDate],fldObjectId, i.[fldUserId], i.[fldOrganId],i.[fldDate] 
	,i.fldStatus,case when i.fldStatus=1 then N'خالی' when i. fldStatus=2 then N'پر' when i.fldStatus=3 then N'امانت' end  fldStatusName
	,i.fldTabaghe/*,'https://www.google.com/maps?q=36.3818,54.913' fldLocationGoogle--*/,dead.fn_LinkGoogleMap(fldObjectId) as fldLocationGoogle  
	,i.fldGheteId, isnull(g.fldNameGhete,'')fldNameGhete,c.fldName as fldNameCity,v.fldName as fldVadiName,fldMeliCode 
	FROM   [Dead].[tblGhabrInfo] i
	/*inner join AramDB.dbo.RECATANGLE_8 r
	on r.OBJECTID=fldObjectId*/
	left  join Dead.tblGhete g on g.fldid=fldGheteId
	left join dead.tblVadiSalam v on v.fldid=fldVadiSalamId
	left join com.tblCity c on c.fldid=fldCityId
	 where i.fldNameFather like @value 

	if (@value2='2')
	SELECT top(@h)i.[fldId],ltrim( i.[fldName])[fldName],ltrim( i.[fldFamily])[fldFamily], ltrim(i.[fldNameFather])[fldNameFather], ltrim(i.[fldBDate])[fldBDate], ltrim(i.[fldDeathDate])[fldDeathDate],fldObjectId, i.[fldUserId], i.[fldOrganId],i.[fldDate] 
	,i.fldStatus,case when i.fldStatus=1 then N'خالی' when i. fldStatus=2 then N'پر' when i.fldStatus=3 then N'امانت' end  fldStatusName
	,i.fldTabaghe/*,'https://www.google.com/maps?q=36.3818,54.913' fldLocationGoogle--*/,dead.fn_LinkGoogleMap(fldObjectId) as fldLocationGoogle  
	,i.fldGheteId, isnull(g.fldNameGhete,'')fldNameGhete,c.fldName as fldNameCity,v.fldName as fldVadiName,fldMeliCode 
	FROM   [Dead].[tblGhabrInfo] i
	/*inner join AramDB.dbo.RECATANGLE_8 r
	on r.OBJECTID=fldObjectId*/
	left  join Dead.tblGhete g on g.fldid=fldGheteId
	left join dead.tblVadiSalam v on v.fldid=fldVadiSalamId
	left join com.tblCity c on c.fldid=fldCityId
	where i.fldName='' and i.fldFamily='' and i.fldNameFather like @value

	if (@value2='3')
	SELECT top(@h)i.[fldId],ltrim( i.[fldName])[fldName],ltrim( i.[fldFamily])[fldFamily], ltrim(i.[fldNameFather])[fldNameFather], ltrim(i.[fldBDate])[fldBDate], ltrim(i.[fldDeathDate])[fldDeathDate],fldObjectId, i.[fldUserId], i.[fldOrganId],i.[fldDate] 
	,i.fldStatus,case when i.fldStatus=1 then N'خالی' when i. fldStatus=2 then N'پر' when i.fldStatus=3 then N'امانت' end  fldStatusName
	,i.fldTabaghe/*,'https://www.google.com/maps?q=36.3818,54.913' fldLocationGoogle--*/,dead.fn_LinkGoogleMap(fldObjectId) as fldLocationGoogle  
	,i.fldGheteId, isnull(g.fldNameGhete,'')fldNameGhete,c.fldName as fldNameCity,v.fldName as fldVadiName,fldMeliCode 
	FROM   [Dead].[tblGhabrInfo] i
	/*inner join AramDB.dbo.RECATANGLE_8 r
	on r.OBJECTID=fldObjectId*/
	left  join Dead.tblGhete g on g.fldid=fldGheteId
	left join dead.tblVadiSalam v on v.fldid=fldVadiSalamId
	left join com.tblCity c on c.fldid=fldCityId
	where i.fldName<>'' and i.fldFamily<>'' and i.fldNameFather like @value
	order by fldid desc
	end

	if (@fieldname='fldMeliCode')
	begin
	if (@value2='1')
	SELECT top(@h)i.[fldId],ltrim( i.[fldName])[fldName],ltrim( i.[fldFamily])[fldFamily], ltrim(i.[fldNameFather])[fldNameFather], ltrim(i.[fldBDate])[fldBDate], ltrim(i.[fldDeathDate])[fldDeathDate],fldObjectId, i.[fldUserId], i.[fldOrganId],i.[fldDate] 
	,i.fldStatus,case when i.fldStatus=1 then N'خالی' when i. fldStatus=2 then N'پر' when i.fldStatus=3 then N'امانت' end  fldStatusName
	,i.fldTabaghe/*,'https://www.google.com/maps?q=36.3818,54.913' fldLocationGoogle--*/,dead.fn_LinkGoogleMap(fldObjectId) as fldLocationGoogle  
	,i.fldGheteId, isnull(g.fldNameGhete,'')fldNameGhete,c.fldName as fldNameCity,v.fldName as fldVadiName,fldMeliCode 
	FROM   [Dead].[tblGhabrInfo] i
	/*inner join AramDB.dbo.RECATANGLE_8 r
	on r.OBJECTID=fldObjectId*/
	left  join Dead.tblGhete g on g.fldid=fldGheteId
	left join dead.tblVadiSalam v on v.fldid=fldVadiSalamId
	left join com.tblCity c on c.fldid=fldCityId
	 where fldMeliCode like @value 

	if (@value2='2')
	SELECT top(@h)i.[fldId],ltrim( i.[fldName])[fldName],ltrim( i.[fldFamily])[fldFamily], ltrim(i.[fldNameFather])[fldNameFather], ltrim(i.[fldBDate])[fldBDate], ltrim(i.[fldDeathDate])[fldDeathDate],fldObjectId, i.[fldUserId], i.[fldOrganId],i.[fldDate] 
	,i.fldStatus,case when i.fldStatus=1 then N'خالی' when i. fldStatus=2 then N'پر' when i.fldStatus=3 then N'امانت' end  fldStatusName
	,i.fldTabaghe/*,'https://www.google.com/maps?q=36.3818,54.913' fldLocationGoogle--*/,dead.fn_LinkGoogleMap(fldObjectId) as fldLocationGoogle  
	,i.fldGheteId, isnull(g.fldNameGhete,'')fldNameGhete,c.fldName as fldNameCity,v.fldName as fldVadiName,fldMeliCode 
	FROM   [Dead].[tblGhabrInfo] i
	/*inner join AramDB.dbo.RECATANGLE_8 r
	on r.OBJECTID=fldObjectId*/
	left  join Dead.tblGhete g on g.fldid=fldGheteId
	left join dead.tblVadiSalam v on v.fldid=fldVadiSalamId
	left join com.tblCity c on c.fldid=fldCityId
	where i.fldName='' and i.fldFamily='' and fldMeliCode like @value

	if (@value2='3')
	SELECT top(@h)i.[fldId],ltrim( i.[fldName])[fldName],ltrim( i.[fldFamily])[fldFamily], ltrim(i.[fldNameFather])[fldNameFather], ltrim(i.[fldBDate])[fldBDate], ltrim(i.[fldDeathDate])[fldDeathDate],fldObjectId, i.[fldUserId], i.[fldOrganId],i.[fldDate] 
	,i.fldStatus,case when i.fldStatus=1 then N'خالی' when i. fldStatus=2 then N'پر' when i.fldStatus=3 then N'امانت' end  fldStatusName
	,i.fldTabaghe/*,'https://www.google.com/maps?q=36.3818,54.913' fldLocationGoogle--*/,dead.fn_LinkGoogleMap(fldObjectId) as fldLocationGoogle  
	,i.fldGheteId, isnull(g.fldNameGhete,'')fldNameGhete,c.fldName as fldNameCity,v.fldName as fldVadiName,fldMeliCode 
	FROM   [Dead].[tblGhabrInfo] i
	/*inner join AramDB.dbo.RECATANGLE_8 r
	on r.OBJECTID=fldObjectId*/
	left  join Dead.tblGhete g on g.fldid=fldGheteId
	left join dead.tblVadiSalam v on v.fldid=fldVadiSalamId
	left join com.tblCity c on c.fldid=fldCityId
	where i.fldName<>'' and i.fldFamily<>'' and fldMeliCode like @value
	order by fldid desc
	end


	if (@fieldname='fldBDate')
	begin
	if (@value2='1')
	SELECT top(@h)i.[fldId],ltrim( i.[fldName])[fldName],ltrim( i.[fldFamily])[fldFamily], ltrim(i.[fldNameFather])[fldNameFather], ltrim(i.[fldBDate])[fldBDate], ltrim(i.[fldDeathDate])[fldDeathDate],fldObjectId, i.[fldUserId], i.[fldOrganId],i.[fldDate] 
	,i.fldStatus,case when i.fldStatus=1 then N'خالی' when i. fldStatus=2 then N'پر' when i.fldStatus=3 then N'امانت' end  fldStatusName
	,i.fldTabaghe/*,'https://www.google.com/maps?q=36.3818,54.913' fldLocationGoogle--*/,dead.fn_LinkGoogleMap(fldObjectId) as fldLocationGoogle  
	,i.fldGheteId, isnull(g.fldNameGhete,'')fldNameGhete,c.fldName as fldNameCity,v.fldName as fldVadiName,fldMeliCode 
	FROM   [Dead].[tblGhabrInfo] i
	/*inner join AramDB.dbo.RECATANGLE_8 r
	on r.OBJECTID=fldObjectId*/
	left  join Dead.tblGhete g on g.fldid=fldGheteId
	left join dead.tblVadiSalam v on v.fldid=fldVadiSalamId
	left join com.tblCity c on c.fldid=fldCityId
	 where i.fldBDate like @value 

	if (@value2='2')
	SELECT top(@h)i.[fldId],ltrim( i.[fldName])[fldName],ltrim( i.[fldFamily])[fldFamily], ltrim(i.[fldNameFather])[fldNameFather], ltrim(i.[fldBDate])[fldBDate], ltrim(i.[fldDeathDate])[fldDeathDate],fldObjectId, i.[fldUserId], i.[fldOrganId],i.[fldDate] 
	,i.fldStatus,case when i.fldStatus=1 then N'خالی' when i. fldStatus=2 then N'پر' when i.fldStatus=3 then N'امانت' end  fldStatusName
	,i.fldTabaghe/*,'https://www.google.com/maps?q=36.3818,54.913' fldLocationGoogle--*/,dead.fn_LinkGoogleMap(fldObjectId) as fldLocationGoogle  
	,i.fldGheteId, isnull(g.fldNameGhete,'')fldNameGhete,c.fldName as fldNameCity,v.fldName as fldVadiName,fldMeliCode 
	FROM   [Dead].[tblGhabrInfo] i
	/*inner join AramDB.dbo.RECATANGLE_8 r
	on r.OBJECTID=fldObjectId*/
	left  join Dead.tblGhete g on g.fldid=fldGheteId
	left join dead.tblVadiSalam v on v.fldid=fldVadiSalamId
	left join com.tblCity c on c.fldid=fldCityId
	where i.fldName='' and i.fldFamily='' and i.fldBDate like @value

	if (@value2='3')
	SELECT top(@h)i.[fldId],ltrim( i.[fldName])[fldName],ltrim( i.[fldFamily])[fldFamily], ltrim(i.[fldNameFather])[fldNameFather], ltrim(i.[fldBDate])[fldBDate], ltrim(i.[fldDeathDate])[fldDeathDate],fldObjectId, i.[fldUserId], i.[fldOrganId],i.[fldDate] 
	,i.fldStatus,case when i.fldStatus=1 then N'خالی' when i. fldStatus=2 then N'پر' when i.fldStatus=3 then N'امانت' end  fldStatusName
	,i.fldTabaghe/*,'https://www.google.com/maps?q=36.3818,54.913' fldLocationGoogle--*/,dead.fn_LinkGoogleMap(fldObjectId) as fldLocationGoogle  
	,i.fldGheteId, isnull(g.fldNameGhete,'')fldNameGhete,c.fldName as fldNameCity,v.fldName as fldVadiName,fldMeliCode 
	FROM   [Dead].[tblGhabrInfo] i
	/*inner join AramDB.dbo.RECATANGLE_8 r
	on r.OBJECTID=fldObjectId*/
	left  join Dead.tblGhete g on g.fldid=fldGheteId
	left join dead.tblVadiSalam v on v.fldid=fldVadiSalamId
	left join com.tblCity c on c.fldid=fldCityId
	where i.fldName<>'' and i.fldFamily<>'' and i.fldBDate like @value
	order by fldid desc
	end


	
	if (@fieldname='fldDeathDate')
	begin
	if (@value2='1')
	SELECT top(@h)i.[fldId],ltrim( i.[fldName])[fldName],ltrim( i.[fldFamily])[fldFamily], ltrim(i.[fldNameFather])[fldNameFather], ltrim(i.[fldBDate])[fldBDate], ltrim(i.[fldDeathDate])[fldDeathDate],fldObjectId, i.[fldUserId], i.[fldOrganId],i.[fldDate] 
	,i.fldStatus,case when i.fldStatus=1 then N'خالی' when i. fldStatus=2 then N'پر' when i.fldStatus=3 then N'امانت' end  fldStatusName
	,i.fldTabaghe/*,'https://www.google.com/maps?q=36.3818,54.913' fldLocationGoogle--*/,dead.fn_LinkGoogleMap(fldObjectId) as fldLocationGoogle  
	,i.fldGheteId, isnull(g.fldNameGhete,'')fldNameGhete,c.fldName as fldNameCity,v.fldName as fldVadiName,fldMeliCode 
	FROM   [Dead].[tblGhabrInfo] i
	/*inner join AramDB.dbo.RECATANGLE_8 r
	on r.OBJECTID=fldObjectId*/
	left  join Dead.tblGhete g on g.fldid=fldGheteId
	left join dead.tblVadiSalam v on v.fldid=fldVadiSalamId
	left join com.tblCity c on c.fldid=fldCityId
	 where i.fldDeathDate like @value 

	if (@value2='2')
	SELECT top(@h)i.[fldId],ltrim( i.[fldName])[fldName],ltrim( i.[fldFamily])[fldFamily], ltrim(i.[fldNameFather])[fldNameFather], ltrim(i.[fldBDate])[fldBDate], ltrim(i.[fldDeathDate])[fldDeathDate],fldObjectId, i.[fldUserId], i.[fldOrganId],i.[fldDate] 
	,i.fldStatus,case when i.fldStatus=1 then N'خالی' when i. fldStatus=2 then N'پر' when i.fldStatus=3 then N'امانت' end  fldStatusName
	,i.fldTabaghe/*,'https://www.google.com/maps?q=36.3818,54.913' fldLocationGoogle--*/,dead.fn_LinkGoogleMap(fldObjectId) as fldLocationGoogle  
	,i.fldGheteId, isnull(g.fldNameGhete,'')fldNameGhete,c.fldName as fldNameCity,v.fldName as fldVadiName,fldMeliCode 
	FROM   [Dead].[tblGhabrInfo] i
	/*inner join AramDB.dbo.RECATANGLE_8 r
	on r.OBJECTID=fldObjectId*/
	left  join Dead.tblGhete g on g.fldid=fldGheteId
	left join dead.tblVadiSalam v on v.fldid=fldVadiSalamId
	left join com.tblCity c on c.fldid=fldCityId
	where i.fldName='' and i.fldFamily='' and i.fldDeathDate like @value

	if (@value2='3')
	SELECT top(@h)i.[fldId],ltrim( i.[fldName])[fldName],ltrim( i.[fldFamily])[fldFamily], ltrim(i.[fldNameFather])[fldNameFather], ltrim(i.[fldBDate])[fldBDate], ltrim(i.[fldDeathDate])[fldDeathDate],fldObjectId, i.[fldUserId], i.[fldOrganId],i.[fldDate] 
	,i.fldStatus,case when i.fldStatus=1 then N'خالی' when i. fldStatus=2 then N'پر' when i.fldStatus=3 then N'امانت' end  fldStatusName
	,i.fldTabaghe/*,'https://www.google.com/maps?q=36.3818,54.913' fldLocationGoogle--*/,dead.fn_LinkGoogleMap(fldObjectId) as fldLocationGoogle  
	,i.fldGheteId, isnull(g.fldNameGhete,'')fldNameGhete,c.fldName as fldNameCity,v.fldName as fldVadiName,fldMeliCode 
	FROM   [Dead].[tblGhabrInfo] i
	/*inner join AramDB.dbo.RECATANGLE_8 r
	on r.OBJECTID=fldObjectId*/
	left  join Dead.tblGhete g on g.fldid=fldGheteId
	left join dead.tblVadiSalam v on v.fldid=fldVadiSalamId
	left join com.tblCity c on c.fldid=fldCityId
	where i.fldName<>'' and i.fldFamily<>'' and i.fldDeathDate like @value
	order by fldid desc
	end


	
	if (@fieldname='fldObjectId')
	begin
	if (@value2='1')
	SELECT top(@h)i.[fldId],ltrim( i.[fldName])[fldName],ltrim( i.[fldFamily])[fldFamily], ltrim(i.[fldNameFather])[fldNameFather], ltrim(i.[fldBDate])[fldBDate], ltrim(i.[fldDeathDate])[fldDeathDate],fldObjectId, i.[fldUserId], i.[fldOrganId],i.[fldDate] 
	,i.fldStatus,case when i.fldStatus=1 then N'خالی' when i. fldStatus=2 then N'پر' when i.fldStatus=3 then N'امانت' end  fldStatusName
	,i.fldTabaghe/*,'https://www.google.com/maps?q=36.3818,54.913' fldLocationGoogle--*/,dead.fn_LinkGoogleMap(fldObjectId) as fldLocationGoogle  
	,i.fldGheteId, isnull(g.fldNameGhete,'')fldNameGhete,c.fldName as fldNameCity,v.fldName as fldVadiName,fldMeliCode 
	FROM   [Dead].[tblGhabrInfo] i
	/*inner join AramDB.dbo.RECATANGLE_8 r
	on r.OBJECTID=fldObjectId*/
	left  join Dead.tblGhete g on g.fldid=fldGheteId
	left join dead.tblVadiSalam v on v.fldid=fldVadiSalamId
	left join com.tblCity c on c.fldid=fldCityId
	 where fldObjectId like @value 

	if (@value2='2')
	SELECT top(@h)i.[fldId],ltrim( i.[fldName])[fldName],ltrim( i.[fldFamily])[fldFamily], ltrim(i.[fldNameFather])[fldNameFather], ltrim(i.[fldBDate])[fldBDate], ltrim(i.[fldDeathDate])[fldDeathDate],fldObjectId, i.[fldUserId], i.[fldOrganId],i.[fldDate] 
	,i.fldStatus,case when i.fldStatus=1 then N'خالی' when i. fldStatus=2 then N'پر' when i.fldStatus=3 then N'امانت' end  fldStatusName
	,i.fldTabaghe/*,'https://www.google.com/maps?q=36.3818,54.913' fldLocationGoogle--*/,dead.fn_LinkGoogleMap(fldObjectId) as fldLocationGoogle  
	,i.fldGheteId, isnull(g.fldNameGhete,'')fldNameGhete,c.fldName as fldNameCity,v.fldName as fldVadiName,fldMeliCode 
	FROM   [Dead].[tblGhabrInfo] i
	/*inner join AramDB.dbo.RECATANGLE_8 r
	on r.OBJECTID=fldObjectId*/
	left  join Dead.tblGhete g on g.fldid=fldGheteId
	left join dead.tblVadiSalam v on v.fldid=fldVadiSalamId
	left join com.tblCity c on c.fldid=fldCityId
	where i.fldName='' and i.fldFamily='' and fldObjectId like @value

	if (@value2='3')
	SELECT top(@h)i.[fldId],ltrim( i.[fldName])[fldName],ltrim( i.[fldFamily])[fldFamily], ltrim(i.[fldNameFather])[fldNameFather], ltrim(i.[fldBDate])[fldBDate], ltrim(i.[fldDeathDate])[fldDeathDate],fldObjectId, i.[fldUserId], i.[fldOrganId],i.[fldDate] 
	,i.fldStatus,case when i.fldStatus=1 then N'خالی' when i. fldStatus=2 then N'پر' when i.fldStatus=3 then N'امانت' end  fldStatusName
	,i.fldTabaghe/*,'https://www.google.com/maps?q=36.3818,54.913' fldLocationGoogle--*/,dead.fn_LinkGoogleMap(fldObjectId) as fldLocationGoogle  
	,i.fldGheteId, isnull(g.fldNameGhete,'')fldNameGhete,c.fldName as fldNameCity,v.fldName as fldVadiName,fldMeliCode 
	FROM   [Dead].[tblGhabrInfo] i
	/*inner join AramDB.dbo.RECATANGLE_8 r
	on r.OBJECTID=fldObjectId*/
	left  join Dead.tblGhete g on g.fldid=fldGheteId
	left join dead.tblVadiSalam v on v.fldid=fldVadiSalamId
	left join com.tblCity c on c.fldid=fldCityId
	where i.fldName<>'' and i.fldFamily<>'' and fldObjectId like @value
	order by fldid desc
	end


	
	if (@fieldname='')
	begin
	if (@value2='1')
	SELECT top(@h)i.[fldId],ltrim( i.[fldName])[fldName],ltrim( i.[fldFamily])[fldFamily], ltrim(i.[fldNameFather])[fldNameFather], ltrim(i.[fldBDate])[fldBDate], ltrim(i.[fldDeathDate])[fldDeathDate],fldObjectId, i.[fldUserId], i.[fldOrganId],i.[fldDate] 
	,i.fldStatus,case when i.fldStatus=1 then N'خالی' when i. fldStatus=2 then N'پر' when i.fldStatus=3 then N'امانت' end  fldStatusName
	,i.fldTabaghe/*,'https://www.google.com/maps?q=36.3818,54.913' fldLocationGoogle--*/,dead.fn_LinkGoogleMap(fldObjectId) as fldLocationGoogle  
	,i.fldGheteId, isnull(g.fldNameGhete,'')fldNameGhete,c.fldName as fldNameCity,v.fldName as fldVadiName,fldMeliCode 
	FROM   [Dead].[tblGhabrInfo] i
	/*inner join AramDB.dbo.RECATANGLE_8 r
	on r.OBJECTID=fldObjectId*/
	left  join Dead.tblGhete g on g.fldid=fldGheteId
	left join dead.tblVadiSalam v on v.fldid=fldVadiSalamId
	left join com.tblCity c on c.fldid=fldCityId
	
	if (@value2='2')
	SELECT top(@h)i.[fldId],ltrim( i.[fldName])[fldName],ltrim( i.[fldFamily])[fldFamily], ltrim(i.[fldNameFather])[fldNameFather], ltrim(i.[fldBDate])[fldBDate], ltrim(i.[fldDeathDate])[fldDeathDate],fldObjectId, i.[fldUserId], i.[fldOrganId],i.[fldDate] 
	,i.fldStatus,case when i.fldStatus=1 then N'خالی' when i. fldStatus=2 then N'پر' when i.fldStatus=3 then N'امانت' end  fldStatusName
	,i.fldTabaghe/*,'https://www.google.com/maps?q=36.3818,54.913' fldLocationGoogle--*/,dead.fn_LinkGoogleMap(fldObjectId) as fldLocationGoogle  
	,i.fldGheteId, isnull(g.fldNameGhete,'')fldNameGhete,c.fldName as fldNameCity,v.fldName as fldVadiName,fldMeliCode 
	FROM   [Dead].[tblGhabrInfo] i
	/*inner join AramDB.dbo.RECATANGLE_8 r
	on r.OBJECTID=fldObjectId*/
	left  join Dead.tblGhete g on g.fldid=fldGheteId
	left join dead.tblVadiSalam v on v.fldid=fldVadiSalamId
	left join com.tblCity c on c.fldid=fldCityId
	
	where i.fldName='' and i.fldFamily='' 

	if (@value2='3')
	SELECT top(@h)i.[fldId],ltrim( i.[fldName])[fldName],ltrim( i.[fldFamily])[fldFamily], ltrim(i.[fldNameFather])[fldNameFather], ltrim(i.[fldBDate])[fldBDate], ltrim(i.[fldDeathDate])[fldDeathDate],fldObjectId, i.[fldUserId], i.[fldOrganId],i.[fldDate] 
	,i.fldStatus,case when i.fldStatus=1 then N'خالی' when i. fldStatus=2 then N'پر' when i.fldStatus=3 then N'امانت' end  fldStatusName
	,i.fldTabaghe/*,'https://www.google.com/maps?q=36.3818,54.913' fldLocationGoogle--*/,dead.fn_LinkGoogleMap(fldObjectId) as fldLocationGoogle  
	,i.fldGheteId, isnull(g.fldNameGhete,'')fldNameGhete,c.fldName as fldNameCity,v.fldName as fldVadiName,fldMeliCode 
	FROM   [Dead].[tblGhabrInfo] i
	/*inner join AramDB.dbo.RECATANGLE_8 r
	on r.OBJECTID=fldObjectId*/
	left  join Dead.tblGhete g on g.fldid=fldGheteId
	left join dead.tblVadiSalam v on v.fldid=fldVadiSalamId
	left join com.tblCity c on c.fldid=fldCityId
	where i.fldName<>'' and i.fldFamily<>'' 
	order by fldid desc
	end


	if (@fieldname='fldStatusName')
	begin
	if (@value2='1')
	SELECT top(@h)* from (SELECT i.[fldId],ltrim( i.[fldName])[fldName],ltrim( i.[fldFamily])[fldFamily], ltrim(i.[fldNameFather])[fldNameFather], ltrim(i.[fldBDate])[fldBDate], ltrim(i.[fldDeathDate])[fldDeathDate],fldObjectId, i.[fldUserId], i.[fldOrganId],i.[fldDate] 
	,i.fldStatus,case when i.fldStatus=1 then N'خالی' when i. fldStatus=2 then N'پر' when i.fldStatus=3 then N'امانت' end  fldStatusName
	,i.fldTabaghe/*,'https://www.google.com/maps?q=36.3818,54.913' fldLocationGoogle--*/,dead.fn_LinkGoogleMap(fldObjectId) as fldLocationGoogle  
	,i.fldGheteId, isnull(g.fldNameGhete,'')fldNameGhete,c.fldName as fldNameCity,v.fldName as fldVadiName,fldMeliCode 
	FROM   [Dead].[tblGhabrInfo] i
	/*inner join AramDB.dbo.RECATANGLE_8 r
	on r.OBJECTID=fldObjectId*/
	left  join Dead.tblGhete g on g.fldid=fldGheteId
	left join dead.tblVadiSalam v on v.fldid=fldVadiSalamId
	left join com.tblCity c on c.fldid=fldCityId
	)t where fldStatusName like @value

	if (@value2='2')
	SELECT top(@h)* from (SELECT i.[fldId],ltrim( i.[fldName])[fldName],ltrim( i.[fldFamily])[fldFamily], ltrim(i.[fldNameFather])[fldNameFather], ltrim(i.[fldBDate])[fldBDate], ltrim(i.[fldDeathDate])[fldDeathDate],fldObjectId, i.[fldUserId], i.[fldOrganId],i.[fldDate] 
	,i.fldStatus,case when i.fldStatus=1 then N'خالی' when i. fldStatus=2 then N'پر' when i.fldStatus=3 then N'امانت' end  fldStatusName
	,i.fldTabaghe/*,'https://www.google.com/maps?q=36.3818,54.913' fldLocationGoogle--*/,dead.fn_LinkGoogleMap(fldObjectId) as fldLocationGoogle  
	,i.fldGheteId, isnull(g.fldNameGhete,'')fldNameGhete,c.fldName as fldNameCity,v.fldName as fldVadiName,fldMeliCode 
	FROM   [Dead].[tblGhabrInfo] i
	/*inner join AramDB.dbo.RECATANGLE_8 r
	on r.OBJECTID=fldObjectId*/
	left  join Dead.tblGhete g on g.fldid=fldGheteId
	left join dead.tblVadiSalam v on v.fldid=fldVadiSalamId
	left join com.tblCity c on c.fldid=fldCityId
	where i.fldName='' and i.fldFamily='' 
	)t
	where fldStatusName like @value

	if (@value2='3')
	SELECT top(@h)* from (SELECT top(@h)i.[fldId],ltrim( i.[fldName])[fldName],ltrim( i.[fldFamily])[fldFamily], ltrim(i.[fldNameFather])[fldNameFather], ltrim(i.[fldBDate])[fldBDate], ltrim(i.[fldDeathDate])[fldDeathDate],fldObjectId, i.[fldUserId], i.[fldOrganId],i.[fldDate] 
	,i.fldStatus,case when i.fldStatus=1 then N'خالی' when i. fldStatus=2 then N'پر' when i.fldStatus=3 then N'امانت' end  fldStatusName
	,i.fldTabaghe/*,'https://www.google.com/maps?q=36.3818,54.913' fldLocationGoogle--*/,dead.fn_LinkGoogleMap(fldObjectId) as fldLocationGoogle  
	,i.fldGheteId, isnull(g.fldNameGhete,'')fldNameGhete,c.fldName as fldNameCity,v.fldName as fldVadiName,fldMeliCode 
	FROM   [Dead].[tblGhabrInfo] i
	/*inner join AramDB.dbo.RECATANGLE_8 r
	on r.OBJECTID=fldObjectId*/
	left  join Dead.tblGhete g on g.fldid=fldGheteId
	left join dead.tblVadiSalam v on v.fldid=fldVadiSalamId
	left join com.tblCity c on c.fldid=fldCityId
	where i.fldName<>'' and i.fldFamily<>'' 
	)t
	where fldStatusName like @value
	order by fldid desc
	end


	if (@fieldname='fldTabaghe')
	begin
	if (@value2='1')
	SELECT top(@h)* from (SELECT top(@h)i.[fldId],ltrim( i.[fldName])[fldName],ltrim( i.[fldFamily])[fldFamily], ltrim(i.[fldNameFather])[fldNameFather], ltrim(i.[fldBDate])[fldBDate], ltrim(i.[fldDeathDate])[fldDeathDate],fldObjectId, i.[fldUserId], i.[fldOrganId],i.[fldDate] 
	,i.fldStatus,case when i.fldStatus=1 then N'خالی' when i. fldStatus=2 then N'پر' when i.fldStatus=3 then N'امانت' end  fldStatusName
	,i.fldTabaghe/*,'https://www.google.com/maps?q=36.3818,54.913' fldLocationGoogle--*/,dead.fn_LinkGoogleMap(fldObjectId) as fldLocationGoogle  
	,i.fldGheteId, isnull(g.fldNameGhete,'')fldNameGhete,c.fldName as fldNameCity,v.fldName as fldVadiName,fldMeliCode 
	FROM   [Dead].[tblGhabrInfo] i
	/*inner join AramDB.dbo.RECATANGLE_8 r
	on r.OBJECTID=fldObjectId*/
	left  join Dead.tblGhete g on g.fldid=fldGheteId
	left join dead.tblVadiSalam v on v.fldid=fldVadiSalamId
	left join com.tblCity c on c.fldid=fldCityId
	)t where fldTabaghe like @value

	if (@value2='2')
	SELECT top(@h)* from (SELECT top(@h)i.[fldId],ltrim( i.[fldName])[fldName],ltrim( i.[fldFamily])[fldFamily], ltrim(i.[fldNameFather])[fldNameFather], ltrim(i.[fldBDate])[fldBDate], ltrim(i.[fldDeathDate])[fldDeathDate],fldObjectId, i.[fldUserId], i.[fldOrganId],i.[fldDate] 
	,i.fldStatus,case when i.fldStatus=1 then N'خالی' when i. fldStatus=2 then N'پر' when i.fldStatus=3 then N'امانت' end  fldStatusName
	,i.fldTabaghe/*,'https://www.google.com/maps?q=36.3818,54.913' fldLocationGoogle--*/,dead.fn_LinkGoogleMap(fldObjectId) as fldLocationGoogle  
	,i.fldGheteId, isnull(g.fldNameGhete,'')fldNameGhete,c.fldName as fldNameCity,v.fldName as fldVadiName,fldMeliCode 
	FROM   [Dead].[tblGhabrInfo] i
	/*inner join AramDB.dbo.RECATANGLE_8 r
	on r.OBJECTID=fldObjectId*/
	left  join Dead.tblGhete g on g.fldid=fldGheteId
	left join dead.tblVadiSalam v on v.fldid=fldVadiSalamId
	left join com.tblCity c on c.fldid=fldCityId 
	where i.fldName='' and i.fldFamily='' 
	)t
	where fldTabaghe like @value

	if (@value2='3')
	SELECT top(@h)* from (SELECT top(@h)i.[fldId],ltrim( i.[fldName])[fldName],ltrim( i.[fldFamily])[fldFamily], ltrim(i.[fldNameFather])[fldNameFather], ltrim(i.[fldBDate])[fldBDate], ltrim(i.[fldDeathDate])[fldDeathDate],fldObjectId, i.[fldUserId], i.[fldOrganId],i.[fldDate] 
	,i.fldStatus,case when i.fldStatus=1 then N'خالی' when i. fldStatus=2 then N'پر' when i.fldStatus=3 then N'امانت' end  fldStatusName
	,i.fldTabaghe/*,'https://www.google.com/maps?q=36.3818,54.913' fldLocationGoogle--*/,dead.fn_LinkGoogleMap(fldObjectId) as fldLocationGoogle  
	,i.fldGheteId, isnull(g.fldNameGhete,'')fldNameGhete,c.fldName as fldNameCity,v.fldName as fldVadiName,fldMeliCode 
	FROM   [Dead].[tblGhabrInfo] i
	/*inner join AramDB.dbo.RECATANGLE_8 r
	on r.OBJECTID=fldObjectId*/
	left  join Dead.tblGhete g on g.fldid=fldGheteId
	left join dead.tblVadiSalam v on v.fldid=fldVadiSalamId
	left join com.tblCity c on c.fldid=fldCityId
	where i.fldName<>'' and i.fldFamily<>'' 
	)t
	where fldTabaghe like @value
	order by fldid desc
	end

	if (@fieldname='fldNameGhete')
	begin
	if (@value2='1')
	SELECT top(@h)* from (SELECT top(@h)i.[fldId],ltrim( i.[fldName])[fldName],ltrim( i.[fldFamily])[fldFamily], ltrim(i.[fldNameFather])[fldNameFather], ltrim(i.[fldBDate])[fldBDate], ltrim(i.[fldDeathDate])[fldDeathDate],fldObjectId, i.[fldUserId], i.[fldOrganId],i.[fldDate] 
	,i.fldStatus,case when i.fldStatus=1 then N'خالی' when i. fldStatus=2 then N'پر' when i.fldStatus=3 then N'امانت' end  fldStatusName
	,i.fldTabaghe/*,'https://www.google.com/maps?q=36.3818,54.913' fldLocationGoogle--*/,dead.fn_LinkGoogleMap(fldObjectId) as fldLocationGoogle  
	,i.fldGheteId, isnull(g.fldNameGhete,'')fldNameGhete,c.fldName as fldNameCity,v.fldName as fldVadiName,fldMeliCode 
	FROM   [Dead].[tblGhabrInfo] i
	inner join AramDB.dbo.RECATANGLE_8 r
	on r.OBJECTID=fldObjectId
	left  join Dead.tblGhete g on g.fldid=fldGheteId
	left join dead.tblVadiSalam v on v.fldid=fldVadiSalamId
	left join com.tblCity c on c.fldid=fldCityId
	)t where fldNameGhete like @value

	if (@value2='2')
	SELECT top(@h)* from (SELECT top(@h)i.[fldId],ltrim( i.[fldName])[fldName],ltrim( i.[fldFamily])[fldFamily], ltrim(i.[fldNameFather])[fldNameFather], ltrim(i.[fldBDate])[fldBDate], ltrim(i.[fldDeathDate])[fldDeathDate],fldObjectId, i.[fldUserId], i.[fldOrganId],i.[fldDate] 
	,i.fldStatus,case when i.fldStatus=1 then N'خالی' when i. fldStatus=2 then N'پر' when i.fldStatus=3 then N'امانت' end  fldStatusName
	,i.fldTabaghe/*,'https://www.google.com/maps?q=36.3818,54.913' fldLocationGoogle--*/,dead.fn_LinkGoogleMap(fldObjectId) as fldLocationGoogle  
	,i.fldGheteId, isnull(g.fldNameGhete,'')fldNameGhete,c.fldName as fldNameCity,v.fldName as fldVadiName,fldMeliCode 
	FROM   [Dead].[tblGhabrInfo] i
	inner join AramDB.dbo.RECATANGLE_8 r
	on r.OBJECTID=fldObjectId
	left  join Dead.tblGhete g on g.fldid=fldGheteId
	left join dead.tblVadiSalam v on v.fldid=fldVadiSalamId
	left join com.tblCity c on c.fldid=fldCityId
	where i.fldName='' and i.fldFamily='' 
	)t
	where fldNameGhete like @value

	if (@value2='3')
	SELECT top(@h)* from (SELECT top(@h)i.[fldId],ltrim( i.[fldName])[fldName],ltrim( i.[fldFamily])[fldFamily], ltrim(i.[fldNameFather])[fldNameFather], ltrim(i.[fldBDate])[fldBDate], ltrim(i.[fldDeathDate])[fldDeathDate],fldObjectId, i.[fldUserId], i.[fldOrganId],i.[fldDate] 
	,i.fldStatus,case when i.fldStatus=1 then N'خالی' when i. fldStatus=2 then N'پر' when i.fldStatus=3 then N'امانت' end  fldStatusName
	,i.fldTabaghe/*,'https://www.google.com/maps?q=36.3818,54.913' fldLocationGoogle--*/,dead.fn_LinkGoogleMap(fldObjectId) as fldLocationGoogle  
	,i.fldGheteId, isnull(g.fldNameGhete,'')fldNameGhete,c.fldName as fldNameCity,v.fldName as fldVadiName,fldMeliCode 
	FROM   [Dead].[tblGhabrInfo] i
	inner join AramDB.dbo.RECATANGLE_8 r
	on r.OBJECTID=fldObjectId
	left  join Dead.tblGhete g on g.fldid=fldGheteId
	left join dead.tblVadiSalam v on v.fldid=fldVadiSalamId
	left join com.tblCity c on c.fldid=fldCityId
	where i.fldName<>'' and i.fldFamily<>'' 
	)t
	where fldNameGhete like @value
	order by fldid desc
	end


	if (@fieldname='fldGheteId')
	begin
	if (@value2='1')
	SELECT top(@h)* from (SELECT top(@h)i.[fldId],ltrim( i.[fldName])[fldName],ltrim( i.[fldFamily])[fldFamily], ltrim(i.[fldNameFather])[fldNameFather], ltrim(i.[fldBDate])[fldBDate], ltrim(i.[fldDeathDate])[fldDeathDate],fldObjectId, i.[fldUserId], i.[fldOrganId],i.[fldDate] 
	,i.fldStatus,case when i.fldStatus=1 then N'خالی' when i. fldStatus=2 then N'پر' when i.fldStatus=3 then N'امانت' end  fldStatusName
	,i.fldTabaghe/*,'https://www.google.com/maps?q=36.3818,54.913' fldLocationGoogle--*/,dead.fn_LinkGoogleMap(fldObjectId) as fldLocationGoogle  
	,i.fldGheteId, isnull(g.fldNameGhete,'')fldNameGhete,c.fldName as fldNameCity,v.fldName as fldVadiName,fldMeliCode 
	FROM   [Dead].[tblGhabrInfo] i
	inner join AramDB.dbo.RECATANGLE_8 r
	on r.OBJECTID=fldObjectId
	left  join Dead.tblGhete g on g.fldid=fldGheteId
	left join dead.tblVadiSalam v on v.fldid=fldVadiSalamId
	left join com.tblCity c on c.fldid=fldCityId
	)t where fldGheteId like @value

	if (@value2='2')
	SELECT top(@h)* from (SELECT top(@h)i.[fldId],ltrim( i.[fldName])[fldName],ltrim( i.[fldFamily])[fldFamily], ltrim(i.[fldNameFather])[fldNameFather], ltrim(i.[fldBDate])[fldBDate], ltrim(i.[fldDeathDate])[fldDeathDate],fldObjectId, i.[fldUserId], i.[fldOrganId],i.[fldDate] 
	,i.fldStatus,case when i.fldStatus=1 then N'خالی' when i. fldStatus=2 then N'پر' when i.fldStatus=3 then N'امانت' end  fldStatusName
	,i.fldTabaghe/*,'https://www.google.com/maps?q=36.3818,54.913' fldLocationGoogle--*/,dead.fn_LinkGoogleMap(fldObjectId) as fldLocationGoogle  
	,i.fldGheteId, isnull(g.fldNameGhete,'')fldNameGhete,c.fldName as fldNameCity,v.fldName as fldVadiName,fldMeliCode 
	FROM   [Dead].[tblGhabrInfo] i
	inner join AramDB.dbo.RECATANGLE_8 r
	on r.OBJECTID=fldObjectId
	left  join Dead.tblGhete g on g.fldid=fldGheteId
	left join dead.tblVadiSalam v on v.fldid=fldVadiSalamId
	left join com.tblCity c on c.fldid=fldCityId
	where i.fldName='' and i.fldFamily='' 
	)t
	where fldGheteId like @value

	if (@value2='3')
	SELECT top(@h)* from (SELECT top(@h)i.[fldId],ltrim( i.[fldName])[fldName],ltrim( i.[fldFamily])[fldFamily], ltrim(i.[fldNameFather])[fldNameFather], ltrim(i.[fldBDate])[fldBDate], ltrim(i.[fldDeathDate])[fldDeathDate],fldObjectId, i.[fldUserId], i.[fldOrganId],i.[fldDate] 
	,i.fldStatus,case when i.fldStatus=1 then N'خالی' when i. fldStatus=2 then N'پر' when i.fldStatus=3 then N'امانت' end  fldStatusName
	,i.fldTabaghe/*,'https://www.google.com/maps?q=36.3818,54.913' fldLocationGoogle--*/,dead.fn_LinkGoogleMap(fldObjectId) as fldLocationGoogle  
	,i.fldGheteId, isnull(g.fldNameGhete,'')fldNameGhete,c.fldName as fldNameCity,v.fldName as fldVadiName,fldMeliCode 
	FROM   [Dead].[tblGhabrInfo] i
	/*inner join AramDB.dbo.RECATANGLE_8 r
	on r.OBJECTID=fldObjectId*/
	left  join Dead.tblGhete g on g.fldid=fldGheteId
	left join dead.tblVadiSalam v on v.fldid=fldVadiSalamId
	left join com.tblCity c on c.fldid=fldCityId
	where i.fldName<>'' and i.fldFamily<>'' 
	)t
	where fldGheteId like @value
	order by fldid desc
	end

	if (@fieldname='ObjectId_Tabaghe')
	SELECT top(@h)i.[fldId],ltrim( i.[fldName])[fldName],ltrim( i.[fldFamily])[fldFamily], ltrim(i.[fldNameFather])[fldNameFather], ltrim(i.[fldBDate])[fldBDate], ltrim(i.[fldDeathDate])[fldDeathDate],fldObjectId, i.[fldUserId], i.[fldOrganId],i.[fldDate] 
	,i.fldStatus,case when i.fldStatus=1 then N'خالی' when i. fldStatus=2 then N'پر' when i.fldStatus=3 then N'امانت' end  fldStatusName
	,i.fldTabaghe/*,'https://www.google.com/maps?q=36.3818,54.913' fldLocationGoogle--*/,dead.fn_LinkGoogleMap(fldObjectId) as fldLocationGoogle  
	,i.fldGheteId, isnull(g.fldNameGhete,'')fldNameGhete,c.fldName as fldNameCity,v.fldName as fldVadiName,fldMeliCode 
	FROM   [Dead].[tblGhabrInfo] i
	inner join AramDB.dbo.RECATANGLE_8 r
	on r.OBJECTID=fldObjectId
	left  join Dead.tblGhete g on g.fldid=fldGheteId
	left join dead.tblVadiSalam v on v.fldid=fldVadiSalamId
	left join com.tblCity c on c.fldid=fldCityId
	WHERE  fldObjectId=@value and i.fldTabaghe=@value2


	if (@fieldname='ObjectId')
	SELECT top(@h)i.[fldId],ltrim( i.[fldName])[fldName],ltrim( i.[fldFamily])[fldFamily], ltrim(i.[fldNameFather])[fldNameFather], ltrim(i.[fldBDate])[fldBDate], ltrim(i.[fldDeathDate])[fldDeathDate],fldObjectId, i.[fldUserId], i.[fldOrganId],i.[fldDate] 
	,i.fldStatus,case when i.fldStatus=1 then N'خالی' when i. fldStatus=2 then N'پر' when i.fldStatus=3 then N'امانت' end  fldStatusName
	,i.fldTabaghe/*,'https://www.google.com/maps?q=36.3818,54.913' fldLocationGoogle--*/,dead.fn_LinkGoogleMap(fldObjectId) as fldLocationGoogle  
	,i.fldGheteId, isnull(g.fldNameGhete,'')fldNameGhete,c.fldName as fldNameCity,v.fldName as fldVadiName,fldMeliCode 
	FROM   [Dead].[tblGhabrInfo] i
	/*inner join AramDB.dbo.RECATANGLE_8 r
	on r.OBJECTID=fldObjectId*/
	left  join Dead.tblGhete g on g.fldid=fldGheteId
	left join dead.tblVadiSalam v on v.fldid=fldVadiSalamId
	left join com.tblCity c on c.fldid=fldCityId
	WHERE  fldObjectId=@value 
	COMMIT
GO
