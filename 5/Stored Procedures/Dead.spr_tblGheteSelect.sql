SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Dead].[spr_tblGheteSelect] 
@FieldName nvarchar(50),
@Value nvarchar(50),
@id int,
@organid int,
@h int
AS 
 
	set @value=com.fn_TextNormalize(@value)
	if (@h=0) set @h=2147483647 
	BEGIN TRAN
	
	if (@fieldname='fldId')
	SELECT top(@h)g.[fldId], [fldVadiSalamId], [fldNameGhete], g.[fldUserId], g.[fldIP], g.[fldDesc], g.[fldDate] 
	,v.fldName as NameVadiSalam,g.fldorganid,cast(0 as bit)ExistsRecored 
	,0 as CountRadif,0as CountShomare
	FROM   [Dead].[tblGhete] g
	inner join  [Dead].tblVadiSalam v
	on g.fldVadiSalamId=v.fldid
	WHERE  g.fldId=@value

	if (@FieldName='fldDesc')
	SELECT top(@h)g.[fldId], [fldVadiSalamId], [fldNameGhete], g.[fldUserId], g.[fldIP], g.[fldDesc], g.[fldDate] 
	,v.fldName as NameVadiSalam,g.fldorganid,cast(0 as bit)ExistsRecored 
	,0 as CountRadif,0as CountShomare
	FROM   [Dead].[tblGhete] g
	inner join  [Dead].tblVadiSalam v
	on g.fldVadiSalamId=v.fldid
	WHERE  g.fldDesc like @Value and g.fldorganid=@organid
	

		if (@FieldName='fldNameGhete')
	SELECT top(@h)g.[fldId], [fldVadiSalamId], [fldNameGhete], g.[fldUserId], g.[fldIP], g.[fldDesc], g.[fldDate] 
	,v.fldName as NameVadiSalam,g.fldorganid,cast(0 as bit)ExistsRecored 
	,0 as CountRadif,0as CountShomare
	FROM   [Dead].[tblGhete] g
	inner join  [Dead].tblVadiSalam v
	on g.fldVadiSalamId=v.fldid
WHERE  fldNameGhete like @Value and g.fldorganid=@organid
	
	if (@FieldName='fldVadiSalamId')
	SELECT top(@h)g.[fldId], [fldVadiSalamId], [fldNameGhete], g.[fldUserId], g.[fldIP], g.[fldDesc], g.[fldDate] 
	,v.fldName as NameVadiSalam,g.fldorganid,cast(0 as bit)ExistsRecored 
	,0 as CountRadif,0as CountShomare
	FROM   [Dead].[tblGhete] g
	inner join  [Dead].tblVadiSalam v
	on g.fldVadiSalamId=v.fldid
	WHERE  fldVadiSalamId like @Value and g.fldorganid=@organid

	if (@FieldName='CheckVadiSalamId')
	SELECT top(@h)g.[fldId], [fldVadiSalamId], [fldNameGhete], g.[fldUserId], g.[fldIP], g.[fldDesc], g.[fldDate] 
	,v.fldName as NameVadiSalam,g.fldorganid,cast(0 as bit)ExistsRecored 
	,0 as CountRadif,0as CountShomare
	FROM   [Dead].[tblGhete] g
	inner join  [Dead].tblVadiSalam v
	on g.fldVadiSalamId=v.fldid
	WHERE  fldVadiSalamId like @Value 

	if (@fieldname='')
	SELECT top(@h)g.[fldId], [fldVadiSalamId], [fldNameGhete], g.[fldUserId], g.[fldIP], g.[fldDesc], g.[fldDate] 
	,v.fldName as NameVadiSalam,g.fldorganid,cast(0 as bit)ExistsRecored 
	,0 as CountRadif,0as CountShomare
	FROM   [Dead].[tblGhete] g
	inner join  [Dead].tblVadiSalam v
	on g.fldVadiSalamId=v.fldid
		where  g.fldorganid=@organid
	
	if (@FieldName='CheckNameGhete')
	SELECT top(@h)g.[fldId], [fldVadiSalamId], [fldNameGhete], g.[fldUserId], g.[fldIP], g.[fldDesc], g.[fldDate] 
	,v.fldName as NameVadiSalam,g.fldorganid,cast(0 as bit)ExistsRecored 
	,0 as CountRadif,0as CountShomare
	FROM   [Dead].[tblGhete] g
	inner join  [Dead].tblVadiSalam v
	on g.fldVadiSalamId=v.fldid
		WHERE  fldNameGhete like @Value
	COMMIT
GO
