SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblTypeEstekhdam_UserGroupSelect] 
@FieldName nvarchar(50),
@Value nvarchar(50),
@OrganId int,
@h int

AS 

	BEGIN TRAN
	if (@h=0) set @h=2147483647
	set @Value=Com.fn_TextNormalize(@Value)

	if (@FieldName='fldId')
	SELECT top(@h)0 [fldId],  TypeEstekhdamId.[fldTypeEstekhamId], [tblTypeEstekhdam_UserGroup].[fldUseGroupId], [tblTypeEstekhdam_UserGroup].[fldOrganId], 
	[tblTypeEstekhdam_UserGroup].[fldUserId], [tblTypeEstekhdam_UserGroup].[fldDesc], [tblTypeEstekhdam_UserGroup].[fldIP], [tblTypeEstekhdam_UserGroup].[fldDate] 
	,u.fldTitle as fldTitleUserGroup,TypeEstekhdam.fldTypeEstekhdamTitle
	FROM   [Pay].[tblTypeEstekhdam_UserGroup] 
	cross apply (select (select  t.fldTitle +' ,'   from(select t.fldTitle
	from   [Pay].[tblTypeEstekhdam_UserGroup] tt
	inner join  com.tblTypeEstekhdam t on t.fldid=fldTypeEstekhamId
	where tt.fldUseGroupId=[tblTypeEstekhdam_UserGroup].fldUseGroupId and tt.fldOrganId=@OrganId
	)t for xml path ('') )fldTypeEstekhdamTitle)TypeEstekhdam
	cross apply (select (select cast(t.fldid as varchar(10)) +' ,'   from(select t.fldid
	from   [Pay].[tblTypeEstekhdam_UserGroup] tt
	inner join  com.tblTypeEstekhdam t on t.fldid=fldTypeEstekhamId
	where tt.fldUseGroupId=[tblTypeEstekhdam_UserGroup].fldUseGroupId and tt.fldOrganId=@OrganId
	)t for xml path ('') )fldTypeEstekhamId)TypeEstekhdamId
	inner join com.tblUserGroup u on u.fldid=[tblTypeEstekhdam_UserGroup].fldUseGroupId
	WHERE  [tblTypeEstekhdam_UserGroup].fldId=@Value and fldOrganId=@OrganId
	group by   TypeEstekhdamId.[fldTypeEstekhamId], [tblTypeEstekhdam_UserGroup].[fldUseGroupId], [tblTypeEstekhdam_UserGroup].[fldOrganId], 
	[tblTypeEstekhdam_UserGroup].[fldUserId], [tblTypeEstekhdam_UserGroup].[fldDesc], [tblTypeEstekhdam_UserGroup].[fldIP], [tblTypeEstekhdam_UserGroup].[fldDate] 
	,u.fldTitle ,TypeEstekhdam.fldTypeEstekhdamTitle




	if (@FieldName='fldDesc')
	SELECT top(@h) 0 [fldId],  TypeEstekhdamId.[fldTypeEstekhamId], [fldUseGroupId], [tblTypeEstekhdam_UserGroup].[fldOrganId], 
	[tblTypeEstekhdam_UserGroup].[fldUserId], [tblTypeEstekhdam_UserGroup].[fldDesc], [tblTypeEstekhdam_UserGroup].[fldIP], [tblTypeEstekhdam_UserGroup].[fldDate] 
	,u.fldTitle as fldTitleUserGroup,TypeEstekhdam.fldTypeEstekhdamTitle
	FROM   [Pay].[tblTypeEstekhdam_UserGroup] 
	cross apply (select (select  t.fldTitle +' ,'   from(select t.fldTitle
	from   [Pay].[tblTypeEstekhdam_UserGroup] tt
	inner join  com.tblTypeEstekhdam t on t.fldid=fldTypeEstekhamId
	where tt.fldUseGroupId=[tblTypeEstekhdam_UserGroup].fldUseGroupId and tt.fldOrganId=@OrganId
	)t for xml path ('') )fldTypeEstekhdamTitle)TypeEstekhdam
	cross apply (select (select cast(t.fldid as varchar(10)) +' ,'   from(select t.fldid
	from   [Pay].[tblTypeEstekhdam_UserGroup] tt
	inner join  com.tblTypeEstekhdam t on t.fldid=fldTypeEstekhamId
	where tt.fldUseGroupId=[tblTypeEstekhdam_UserGroup].fldUseGroupId and tt.fldOrganId=@OrganId
	)t for xml path ('') )fldTypeEstekhamId)TypeEstekhdamId
	inner join com.tblUserGroup u on u.fldid=fldUseGroupId
	WHERE  [tblTypeEstekhdam_UserGroup].fldDesc like @Value  and fldOrganId=@OrganId

		group by  TypeEstekhdamId.[fldTypeEstekhamId], [tblTypeEstekhdam_UserGroup].[fldUseGroupId], [tblTypeEstekhdam_UserGroup].[fldOrganId], 
	[tblTypeEstekhdam_UserGroup].[fldUserId], [tblTypeEstekhdam_UserGroup].[fldDesc], [tblTypeEstekhdam_UserGroup].[fldIP], [tblTypeEstekhdam_UserGroup].[fldDate] 
	,u.fldTitle ,TypeEstekhdam.fldTypeEstekhdamTitle



	if (@FieldName='fldTypeEstekhdamTitle')
	SELECT top(@h) 0 [fldId], TypeEstekhdamId.[fldTypeEstekhamId], [fldUseGroupId], [tblTypeEstekhdam_UserGroup].[fldOrganId], 
	[tblTypeEstekhdam_UserGroup].[fldUserId], [tblTypeEstekhdam_UserGroup].[fldDesc], [tblTypeEstekhdam_UserGroup].[fldIP], [tblTypeEstekhdam_UserGroup].[fldDate] 
	,u.fldTitle as fldTitleUserGroup,TypeEstekhdam.fldTypeEstekhdamTitle
	FROM   [Pay].[tblTypeEstekhdam_UserGroup] 
	cross apply (select (select  t.fldTitle +' ,'   from(select t.fldTitle
	from   [Pay].[tblTypeEstekhdam_UserGroup] tt
	inner join  com.tblTypeEstekhdam t on t.fldid=fldTypeEstekhamId
	where tt.fldUseGroupId=[tblTypeEstekhdam_UserGroup].fldUseGroupId and tt.fldOrganId=@OrganId
	)t for xml path ('') )fldTypeEstekhdamTitle)TypeEstekhdam
	cross apply (select (select cast(t.fldid as varchar(10)) +' ,'   from(select t.fldid
	from   [Pay].[tblTypeEstekhdam_UserGroup] tt
	inner join  com.tblTypeEstekhdam t on t.fldid=fldTypeEstekhamId
	where tt.fldUseGroupId=[tblTypeEstekhdam_UserGroup].fldUseGroupId and tt.fldOrganId=@OrganId
	)t for xml path ('') )fldTypeEstekhamId)TypeEstekhdamId
	inner join com.tblUserGroup u on u.fldid=fldUseGroupId
	WHERE TypeEstekhdam.fldTypeEstekhdamTitle like @Value  and fldOrganId=@OrganId

		group by   TypeEstekhdamId.[fldTypeEstekhamId], [tblTypeEstekhdam_UserGroup].[fldUseGroupId], [tblTypeEstekhdam_UserGroup].[fldOrganId], 
	[tblTypeEstekhdam_UserGroup].[fldUserId], [tblTypeEstekhdam_UserGroup].[fldDesc], [tblTypeEstekhdam_UserGroup].[fldIP], [tblTypeEstekhdam_UserGroup].[fldDate] 
	,u.fldTitle ,TypeEstekhdam.fldTypeEstekhdamTitle




	if (@FieldName='fldTitleUserGroup')
	SELECT top(@h) 0 [fldId],  TypeEstekhdamId.[fldTypeEstekhamId], [fldUseGroupId], [tblTypeEstekhdam_UserGroup].[fldOrganId], 
	[tblTypeEstekhdam_UserGroup].[fldUserId], [tblTypeEstekhdam_UserGroup].[fldDesc], [tblTypeEstekhdam_UserGroup].[fldIP], [tblTypeEstekhdam_UserGroup].[fldDate] 
	,u.fldTitle as fldTitleUserGroup,TypeEstekhdam.fldTypeEstekhdamTitle
	FROM   [Pay].[tblTypeEstekhdam_UserGroup] 
	cross apply (select (select  t.fldTitle +' ,'   from(select t.fldTitle
	from   [Pay].[tblTypeEstekhdam_UserGroup] tt
	inner join  com.tblTypeEstekhdam t on t.fldid=fldTypeEstekhamId
	where tt.fldUseGroupId=[tblTypeEstekhdam_UserGroup].fldUseGroupId and tt.fldOrganId=@OrganId
	)t for xml path ('') )fldTypeEstekhdamTitle)TypeEstekhdam
	cross apply (select (select cast(t.fldid as varchar(10))+' ,'   from(select t.fldid
	from   [Pay].[tblTypeEstekhdam_UserGroup] tt
	inner join  com.tblTypeEstekhdam t on t.fldid=fldTypeEstekhamId
	where tt.fldUseGroupId=[tblTypeEstekhdam_UserGroup].fldUseGroupId and tt.fldOrganId=@OrganId
	)t for xml path ('') )fldTypeEstekhamId)TypeEstekhdamId
	inner join com.tblUserGroup u on u.fldid=fldUseGroupId
	WHERE  u.fldTitle like @Value  and fldOrganId=@OrganId

		group by  TypeEstekhdamId.[fldTypeEstekhamId], [tblTypeEstekhdam_UserGroup].[fldUseGroupId], [tblTypeEstekhdam_UserGroup].[fldOrganId], 
	[tblTypeEstekhdam_UserGroup].[fldUserId], [tblTypeEstekhdam_UserGroup].[fldDesc], [tblTypeEstekhdam_UserGroup].[fldIP], [tblTypeEstekhdam_UserGroup].[fldDate] 
	,u.fldTitle ,TypeEstekhdam.fldTypeEstekhdamTitle



	if (@FieldName='fldTypeEstekhamId')
	SELECT top(@h) 0 [fldId],  TypeEstekhdamId.[fldTypeEstekhamId], [fldUseGroupId], [tblTypeEstekhdam_UserGroup].[fldOrganId], 
	[tblTypeEstekhdam_UserGroup].[fldUserId], [tblTypeEstekhdam_UserGroup].[fldDesc], [tblTypeEstekhdam_UserGroup].[fldIP], [tblTypeEstekhdam_UserGroup].[fldDate] 
	,u.fldTitle as fldTitleUserGroup,TypeEstekhdam.fldTypeEstekhdamTitle
	FROM   [Pay].[tblTypeEstekhdam_UserGroup] 
	cross apply (select (select  t.fldTitle +' ,'   from(select t.fldTitle
	from   [Pay].[tblTypeEstekhdam_UserGroup] tt
	inner join  com.tblTypeEstekhdam t on t.fldid=fldTypeEstekhamId
	where tt.fldUseGroupId=[tblTypeEstekhdam_UserGroup].fldUseGroupId and tt.fldOrganId=@OrganId
	)t for xml path ('') )fldTypeEstekhdamTitle)TypeEstekhdam
	cross apply (select (select cast(t.fldid as varchar(10))+' ,'   from(select t.fldid
	from   [Pay].[tblTypeEstekhdam_UserGroup] tt
	inner join  com.tblTypeEstekhdam t on t.fldid=fldTypeEstekhamId
	where tt.fldUseGroupId=[tblTypeEstekhdam_UserGroup].fldUseGroupId and tt.fldOrganId=@OrganId
	)t for xml path ('') )fldTypeEstekhamId)TypeEstekhdamId
	inner join com.tblUserGroup u on u.fldid=fldUseGroupId
	WHERE   TypeEstekhdamId.[fldTypeEstekhamId] like @Value  and fldOrganId=@OrganId

		group by TypeEstekhdamId.[fldTypeEstekhamId], [tblTypeEstekhdam_UserGroup].[fldUseGroupId], [tblTypeEstekhdam_UserGroup].[fldOrganId], 
	[tblTypeEstekhdam_UserGroup].[fldUserId], [tblTypeEstekhdam_UserGroup].[fldDesc], [tblTypeEstekhdam_UserGroup].[fldIP], [tblTypeEstekhdam_UserGroup].[fldDate] 
	,u.fldTitle ,TypeEstekhdam.fldTypeEstekhdamTitle



	if (@FieldName='fldUserGroupId')/*fargh dare*/
	SELECT top(@h) 0 [fldId],cast([fldTypeEstekhamId] as varchar(10))[fldTypeEstekhamId], [fldUseGroupId], [tblTypeEstekhdam_UserGroup].[fldOrganId], 
	[tblTypeEstekhdam_UserGroup].[fldUserId], [tblTypeEstekhdam_UserGroup].[fldDesc], [tblTypeEstekhdam_UserGroup].[fldIP], [tblTypeEstekhdam_UserGroup].[fldDate] 
	,u.fldTitle as fldTitleUserGroup,tblTypeEstekhdam.fldTitle fldTypeEstekhdamTitle
	FROM   [Pay].[tblTypeEstekhdam_UserGroup] 
	inner join com.tblTypeEstekhdam on fldTypeEstekhamId=tblTypeEstekhdam.fldid
	inner join com.tblUserGroup u on u.fldid=fldUseGroupId
	WHERE  fldUseGroupId like @Value  and fldOrganId=@OrganId




	if (@FieldName='')
	SELECT top(@h) 0 [fldId], TypeEstekhdamId.[fldTypeEstekhamId], [fldUseGroupId], [tblTypeEstekhdam_UserGroup].[fldOrganId], 
	[tblTypeEstekhdam_UserGroup].[fldUserId], [tblTypeEstekhdam_UserGroup].[fldDesc], [tblTypeEstekhdam_UserGroup].[fldIP], [tblTypeEstekhdam_UserGroup].[fldDate] 
	,u.fldTitle as fldTitleUserGroup,TypeEstekhdam.fldTypeEstekhdamTitle
	FROM   [Pay].[tblTypeEstekhdam_UserGroup] 
	cross apply (select (select  t.fldTitle +' ,'   from(select t.fldTitle
	from   [Pay].[tblTypeEstekhdam_UserGroup] tt
	inner join  com.tblTypeEstekhdam t on t.fldid=fldTypeEstekhamId
	where tt.fldUseGroupId=[tblTypeEstekhdam_UserGroup].fldUseGroupId and tt.fldOrganId=@OrganId
	)t for xml path ('') )fldTypeEstekhdamTitle)TypeEstekhdam
	cross apply (select (select  cast(t.fldid as varchar(10)) +' ,'   from(select t.fldid
	from   [Pay].[tblTypeEstekhdam_UserGroup] tt
	inner join  com.tblTypeEstekhdam t on t.fldid=fldTypeEstekhamId
	where tt.fldUseGroupId=[tblTypeEstekhdam_UserGroup].fldUseGroupId and tt.fldOrganId=@OrganId
	)t for xml path ('') )fldTypeEstekhamId)TypeEstekhdamId
	inner join com.tblUserGroup u on u.fldid=fldUseGroupId
	where   fldOrganId=@OrganId
	group by  TypeEstekhdamId.[fldTypeEstekhamId], [tblTypeEstekhdam_UserGroup].[fldUseGroupId], [tblTypeEstekhdam_UserGroup].[fldOrganId], 
	[tblTypeEstekhdam_UserGroup].[fldUserId], [tblTypeEstekhdam_UserGroup].[fldDesc], [tblTypeEstekhdam_UserGroup].[fldIP], [tblTypeEstekhdam_UserGroup].[fldDate] 
	,u.fldTitle ,TypeEstekhdam.fldTypeEstekhdamTitle





	COMMIT
GO
