SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Auto].[spr_tblAshkhaseHoghoghiTitlesSelect] 
@fieldname nvarchar(50),
@value nvarchar(50),
@organid int,
@h int
AS 
 
	set @value=com.fn_TextNormalize(@value)
	if (@h=0) set @h=2147483647 
	BEGIN TRAN
	if (@fieldname='fldId')
	SELECT top(@h)t.[fldId], t.[fldName], [fldAshkhasHoghoghiId], [fldIP], t.[fldDesc], t.[fldDate], t.[fldUserId], [fldOrganId] 
	,a.fldName as fldNameHoghoghi
	FROM   [Auto].[tblAshkhaseHoghoghiTitles] t 
	inner join com.tblAshkhaseHoghoghi a on a.fldid=[fldAshkhasHoghoghiId]
	WHERE  t.fldId=@value

	if (@fieldname='fldName')
	SELECT top(@h)t.[fldId], t.[fldName], [fldAshkhasHoghoghiId], [fldIP], t.[fldDesc], t.[fldDate], t.[fldUserId], [fldOrganId] 
	,a.fldName as fldNameHoghoghi
	FROM   [Auto].[tblAshkhaseHoghoghiTitles] t 
	inner join com.tblAshkhaseHoghoghi a on a.fldid=[fldAshkhasHoghoghiId]
	WHERE  t.[fldName] like @value and t.fldOrganId=@organid
	
	if (@fieldname='fldAshkhasHoghoghiId')
	SELECT top(@h)t.[fldId], t.[fldName], [fldAshkhasHoghoghiId], [fldIP], t.[fldDesc], t.[fldDate], t.[fldUserId], [fldOrganId] 
	,a.fldName as fldNameHoghoghi
	FROM   [Auto].[tblAshkhaseHoghoghiTitles] t 
	inner join com.tblAshkhaseHoghoghi a on a.fldid=[fldAshkhasHoghoghiId]
	WHERE  fldAshkhasHoghoghiId like @value and t.fldOrganId=@organid

	if (@fieldname='fldNameHoghoghi')
	SELECT top(@h)t.[fldId], t.[fldName], [fldAshkhasHoghoghiId], [fldIP], t.[fldDesc], t.[fldDate], t.[fldUserId], [fldOrganId] 
	,a.fldName as fldNameHoghoghi
	FROM   [Auto].[tblAshkhaseHoghoghiTitles] t 
	inner join com.tblAshkhaseHoghoghi a on a.fldid=[fldAshkhasHoghoghiId]
	WHERE  a.fldName like @value and t.fldOrganId=@organid

	if (@fieldname='fldOrganId')
	SELECT top(@h)t.[fldId], t.[fldName], [fldAshkhasHoghoghiId], [fldIP], t.[fldDesc], t.[fldDate], t.[fldUserId], [fldOrganId] 
	,a.fldName as fldNameHoghoghi
	FROM   [Auto].[tblAshkhaseHoghoghiTitles] t 
	inner join com.tblAshkhaseHoghoghi a on a.fldid=[fldAshkhasHoghoghiId]
	where  t.fldOrganId=@organid
	
	if (@fieldname='')
	SELECT top(@h)t.[fldId], t.[fldName], [fldAshkhasHoghoghiId], [fldIP], t.[fldDesc], t.[fldDate], t.[fldUserId], [fldOrganId] 
	,a.fldName as fldNameHoghoghi
	FROM   [Auto].[tblAshkhaseHoghoghiTitles] t 
	inner join com.tblAshkhaseHoghoghi a on a.fldid=[fldAshkhasHoghoghiId]

	COMMIT
GO
