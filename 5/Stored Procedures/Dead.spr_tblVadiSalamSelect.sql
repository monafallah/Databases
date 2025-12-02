SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Dead].[spr_tblVadiSalamSelect] 
@FieldName nvarchar(50),
@Value nvarchar(50),
@organid int,
@h int

AS 

	BEGIN TRAN
	if (@h=0) set @h=2147483647
	set @Value=com.fn_TextNormalize(@Value)

	if (@FieldName='fldId')
	SELECT top(@h) v.[fldId], v.[fldName], v.[fldStateId], [fldCityId],fldOrganId, [fldAddress], v.[fldLatitude], v.[fldLongitude], v.[fldDate],v. [fldUserID], v.[fldDesc], [fldIP] 
	,tblState. fldname as fldNameState,c.fldName as fldNameCity
 	FROM   [Dead].[tblVadiSalam] v inner join com.tblState 
	on fldStateId=tblState.fldid inner join com.tblCity c
	on c.fldid=fldcityid
	WHERE  v.fldId=@Value and fldorganid=@organid

		if (@FieldName='fldOrganId')
	SELECT top(@h) v.[fldId], v.[fldName], v.[fldStateId], [fldCityId],fldOrganId, [fldAddress], v.[fldLatitude], v.[fldLongitude], v.[fldDate],v. [fldUserID], v.[fldDesc], [fldIP] 
	,tblState. fldname as fldNameState,c.fldName as fldNameCity
 	FROM   [Dead].[tblVadiSalam] v inner join com.tblState 
	on fldStateId=tblState.fldid inner join com.tblCity c
	on c.fldid=fldcityid
	WHERE   fldorganid=@organid

	if (@FieldName='fldDesc')
	SELECT top(@h) v.[fldId], v.[fldName], v.[fldStateId], [fldCityId],fldOrganId, [fldAddress], v.[fldLatitude], v.[fldLongitude], v.[fldDate],v. [fldUserID], v.[fldDesc], [fldIP] 
	,tblState. fldname as fldNameState,c.fldName as fldNameCity
 	FROM   [Dead].[tblVadiSalam] v inner join com.tblState 
	on fldStateId=tblState.fldid inner join com.tblCity c
	on c.fldid=fldcityid
	WHERE  v.fldDesc like @Value and fldorganid=@organid


		if (@FieldName='fldAddress')
	SELECT top(@h) v.[fldId], v.[fldName], v.[fldStateId], [fldCityId],fldOrganId, [fldAddress], v.[fldLatitude], v.[fldLongitude], v.[fldDate],v. [fldUserID], v.[fldDesc], [fldIP] 
	,tblState. fldname as fldNameState,c.fldName as fldNameCity
 	FROM   [Dead].[tblVadiSalam] v inner join com.tblState 
	on fldStateId=tblState.fldid inner join com.tblCity c
	on c.fldid=fldcityid
	WHERE  v.fldAddress like @Value and fldorganid=@organid

		if (@FieldName='fldName')
	SELECT top(@h) v.[fldId], v.[fldName], v.[fldStateId], [fldCityId],fldOrganId, [fldAddress], v.[fldLatitude], v.[fldLongitude], v.[fldDate],v. [fldUserID], v.[fldDesc], [fldIP] 
	,tblState. fldname as fldNameState,c.fldName as fldNameCity
 	FROM   [Dead].[tblVadiSalam] v inner join com.tblState 
	on fldStateId=tblState.fldid inner join com.tblCity c
	on c.fldid=fldcityid
	WHERE  v.fldName like @Value and fldorganid=@organid


	if (@FieldName='fldStateId')
	SELECT top(@h) v.[fldId], v.[fldName], v.[fldStateId], [fldCityId],fldOrganId, [fldAddress], v.[fldLatitude], v.[fldLongitude], v.[fldDate],v. [fldUserID], v.[fldDesc], [fldIP] 
	,tblState. fldname as fldNameState,c.fldName as fldNameCity
 	FROM   [Dead].[tblVadiSalam] v inner join com.tblState 
	on fldStateId=tblState.fldid inner join com.tblCity c
	on c.fldid=fldcityid
	WHERE  v.fldStateId like @Value and fldorganid=@organid

	if (@FieldName='fldCityId')
	SELECT top(@h) v.[fldId], v.[fldName], v.[fldStateId], [fldCityId],fldOrganId, [fldAddress], v.[fldLatitude], v.[fldLongitude], v.[fldDate],v. [fldUserID], v.[fldDesc], [fldIP] 
	,tblState. fldname as fldNameState,c.fldName as fldNameCity
 	FROM   [Dead].[tblVadiSalam] v inner join com.tblState 
	on fldStateId=tblState.fldid inner join com.tblCity c
	on c.fldid=fldcityid
	WHERE  v.fldCityId like @Value and fldorganid=@organid


	if (@FieldName='fldNameState')
	SELECT top(@h) v.[fldId], v.[fldName], v.[fldStateId], [fldCityId],fldOrganId, [fldAddress], v.[fldLatitude], v.[fldLongitude], v.[fldDate],v. [fldUserID], v.[fldDesc], [fldIP] 
	,tblState. fldname as fldNameState,c.fldName as fldNameCity
 	FROM   [Dead].[tblVadiSalam] v inner join com.tblState 
	on fldStateId=tblState.fldid inner join com.tblCity c
	on c.fldid=fldcityid
	WHERE tblState. fldname like @Value and fldorganid=@organid

	
	if (@FieldName='fldNameCity')
	SELECT top(@h) v.[fldId], v.[fldName], v.[fldStateId], [fldCityId],fldOrganId, [fldAddress], v.[fldLatitude], v.[fldLongitude], v.[fldDate],v. [fldUserID], v.[fldDesc], [fldIP] 
	,tblState. fldname as fldNameState,c.fldName as fldNameCity
 	FROM   [Dead].[tblVadiSalam] v inner join com.tblState 
	on fldStateId=tblState.fldid inner join com.tblCity c
	on c.fldid=fldcityid
	WHERE c.fldName  like @Value and fldorganid=@organid


	if (@FieldName='')
	SELECT top(@h) v.[fldId], v.[fldName], v.[fldStateId], [fldCityId],fldOrganId, [fldAddress], v.[fldLatitude], v.[fldLongitude], v.[fldDate],v. [fldUserID], v.[fldDesc], [fldIP] 
	,tblState. fldname as fldNameState,c.fldName as fldNameCity
 	FROM   [Dead].[tblVadiSalam] v inner join com.tblState 
	on fldStateId=tblState.fldid inner join com.tblCity c
	on c.fldid=fldcityid
	where  fldorganid=@organid


		if (@FieldName='CheckName')
	SELECT top(@h) v.[fldId], v.[fldName], v.[fldStateId], [fldCityId],fldOrganId, [fldAddress], v.[fldLatitude], v.[fldLongitude], v.[fldDate],v. [fldUserID], v.[fldDesc], [fldIP] 
	,tblState. fldname as fldNameState,c.fldName as fldNameCity
 	FROM   [Dead].[tblVadiSalam] v inner join com.tblState 
	on fldStateId=tblState.fldid inner join com.tblCity c
	on c.fldid=fldcityid
	WHERE  v.fldName like @Value
	
	COMMIT
GO
