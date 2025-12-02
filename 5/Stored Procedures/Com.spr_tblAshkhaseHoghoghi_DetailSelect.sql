SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblAshkhaseHoghoghi_DetailSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@h int
AS 
	BEGIN TRAN
	set  @Value=com.fn_TextNormalize(@Value)
	if (@h=0) set @h=2147483647
	if (@fieldname=N'fldId')
	SELECT        TOP (@h) ISNULL(Com.tblAshkhaseHoghoghi_Detail.fldId,0)AS fldId, tblAshkhaseHoghoghi.fldId AS fldAshkhaseHoghoghiId,ISNULL( Com.tblAshkhaseHoghoghi_Detail.fldCodEghtesadi,'') AS fldCodEghtesadi, ISNULL(Com.tblAshkhaseHoghoghi_Detail.fldAddress,'')AS fldAddress, 
                         ISNULL(Com.tblAshkhaseHoghoghi_Detail.fldCodePosti,'') AS fldCodePosti, ISNULL(Com.tblAshkhaseHoghoghi_Detail.fldShomareTelephone,'')AS fldShomareTelephone, ISNULL(Com.tblAshkhaseHoghoghi_Detail.fldUserId,Com.tblAshkhaseHoghoghi.fldUserId)AS fldUserId ,ISNULL( Com.tblAshkhaseHoghoghi_Detail.fldDesc,'') AS fldDesc , 
                         ISNULL(Com.tblAshkhaseHoghoghi_Detail.fldDate,Com.tblAshkhaseHoghoghi.fldDate)AS fldDate, Com.tblAshkhaseHoghoghi.fldShenaseMelli, Com.tblAshkhaseHoghoghi.fldName, Com.tblAshkhaseHoghoghi.fldShomareSabt
						  ,fldTypeShakhs,case when fldTypeShakhs=0 then N'اتباع داخلی' else N'اتباع خارجی' end as fldTypeShakhsName
FROM            Com.tblAshkhaseHoghoghi_Detail INNER JOIN
                         Com.tblAshkhaseHoghoghi ON Com.tblAshkhaseHoghoghi_Detail.fldAshkhaseHoghoghiId = Com.tblAshkhaseHoghoghi.fldId
	WHERE  Com.tblAshkhaseHoghoghi_Detail.fldId = @Value
	
	if (@fieldname=N'fldAshkhaseHoghoghiId')
	SELECT        TOP (@h) ISNULL(Com.tblAshkhaseHoghoghi_Detail.fldId,0)AS fldId, tblAshkhaseHoghoghi.fldId AS fldAshkhaseHoghoghiId,ISNULL( Com.tblAshkhaseHoghoghi_Detail.fldCodEghtesadi,'') AS fldCodEghtesadi, ISNULL(Com.tblAshkhaseHoghoghi_Detail.fldAddress,'')AS fldAddress, 
                         ISNULL(Com.tblAshkhaseHoghoghi_Detail.fldCodePosti,'') AS fldCodePosti, ISNULL(Com.tblAshkhaseHoghoghi_Detail.fldShomareTelephone,'')AS fldShomareTelephone, ISNULL(Com.tblAshkhaseHoghoghi_Detail.fldUserId,Com.tblAshkhaseHoghoghi.fldUserId)AS fldUserId ,ISNULL( Com.tblAshkhaseHoghoghi_Detail.fldDesc,'') AS fldDesc , 
                         ISNULL(Com.tblAshkhaseHoghoghi_Detail.fldDate,Com.tblAshkhaseHoghoghi.fldDate)AS fldDate, Com.tblAshkhaseHoghoghi.fldShenaseMelli, Com.tblAshkhaseHoghoghi.fldName, Com.tblAshkhaseHoghoghi.fldShomareSabt
						  ,fldTypeShakhs,case when fldTypeShakhs=0 then N'اتباع داخلی' else N'اتباع خارجی' end as fldTypeShakhsName
FROM            Com.tblAshkhaseHoghoghi_Detail INNER JOIN
                         Com.tblAshkhaseHoghoghi ON Com.tblAshkhaseHoghoghi_Detail.fldAshkhaseHoghoghiId = Com.tblAshkhaseHoghoghi.fldId 
	WHERE  fldAshkhaseHoghoghiId = @Value

	if (@fieldname=N'')
	SELECT        TOP (@h) ISNULL(Com.tblAshkhaseHoghoghi_Detail.fldId,0)AS fldId, tblAshkhaseHoghoghi.fldId AS fldAshkhaseHoghoghiId,ISNULL( Com.tblAshkhaseHoghoghi_Detail.fldCodEghtesadi,'') AS fldCodEghtesadi, ISNULL(Com.tblAshkhaseHoghoghi_Detail.fldAddress,'')AS fldAddress, 
                         ISNULL(Com.tblAshkhaseHoghoghi_Detail.fldCodePosti,'') AS fldCodePosti, ISNULL(Com.tblAshkhaseHoghoghi_Detail.fldShomareTelephone,'')AS fldShomareTelephone, ISNULL(Com.tblAshkhaseHoghoghi_Detail.fldUserId,Com.tblAshkhaseHoghoghi.fldUserId)AS fldUserId ,ISNULL( Com.tblAshkhaseHoghoghi_Detail.fldDesc,'') AS fldDesc , 
                         ISNULL(Com.tblAshkhaseHoghoghi_Detail.fldDate,Com.tblAshkhaseHoghoghi.fldDate)AS fldDate, Com.tblAshkhaseHoghoghi.fldShenaseMelli, Com.tblAshkhaseHoghoghi.fldName, Com.tblAshkhaseHoghoghi.fldShomareSabt
						  ,fldTypeShakhs,case when fldTypeShakhs=0 then N'اتباع داخلی' else N'اتباع خارجی' end as fldTypeShakhsName
FROM            Com.tblAshkhaseHoghoghi_Detail INNER JOIN
                         Com.tblAshkhaseHoghoghi ON Com.tblAshkhaseHoghoghi_Detail.fldAshkhaseHoghoghiId = Com.tblAshkhaseHoghoghi.fldId

if (@fieldname=N'AshkhasHoghoghi')
	SELECT        TOP (@h) ISNULL(Com.tblAshkhaseHoghoghi_Detail.fldId,0)AS fldId, tblAshkhaseHoghoghi.fldId AS fldAshkhaseHoghoghiId,ISNULL( Com.tblAshkhaseHoghoghi_Detail.fldCodEghtesadi,'') AS fldCodEghtesadi, ISNULL(Com.tblAshkhaseHoghoghi_Detail.fldAddress,'')AS fldAddress, 
                         ISNULL(Com.tblAshkhaseHoghoghi_Detail.fldCodePosti,'') AS fldCodePosti, ISNULL(Com.tblAshkhaseHoghoghi_Detail.fldShomareTelephone,'')AS fldShomareTelephone, ISNULL(Com.tblAshkhaseHoghoghi_Detail.fldUserId,Com.tblAshkhaseHoghoghi.fldUserId)AS fldUserId ,ISNULL( Com.tblAshkhaseHoghoghi_Detail.fldDesc,'') AS fldDesc , 
                         ISNULL(Com.tblAshkhaseHoghoghi_Detail.fldDate,Com.tblAshkhaseHoghoghi.fldDate)AS fldDate, Com.tblAshkhaseHoghoghi.fldShenaseMelli, Com.tblAshkhaseHoghoghi.fldName, Com.tblAshkhaseHoghoghi.fldShomareSabt
						  ,fldTypeShakhs,case when fldTypeShakhs=0 then N'اتباع داخلی' else N'اتباع خارجی' end as fldTypeShakhsName
FROM            Com.tblAshkhaseHoghoghi_Detail RIGHT OUTER JOIN
                         Com.tblAshkhaseHoghoghi ON Com.tblAshkhaseHoghoghi_Detail.fldAshkhaseHoghoghiId = Com.tblAshkhaseHoghoghi.fldId
	
	if (@fieldname=N'AshkhasHoghoghi_fldName')
	SELECT        TOP (@h) ISNULL(Com.tblAshkhaseHoghoghi_Detail.fldId,0)AS fldId, tblAshkhaseHoghoghi.fldId AS fldAshkhaseHoghoghiId,ISNULL( Com.tblAshkhaseHoghoghi_Detail.fldCodEghtesadi,'') AS fldCodEghtesadi, ISNULL(Com.tblAshkhaseHoghoghi_Detail.fldAddress,'')AS fldAddress, 
                         ISNULL(Com.tblAshkhaseHoghoghi_Detail.fldCodePosti,'') AS fldCodePosti, ISNULL(Com.tblAshkhaseHoghoghi_Detail.fldShomareTelephone,'')AS fldShomareTelephone, ISNULL(Com.tblAshkhaseHoghoghi_Detail.fldUserId,Com.tblAshkhaseHoghoghi.fldUserId)AS fldUserId ,ISNULL( Com.tblAshkhaseHoghoghi_Detail.fldDesc,'') AS fldDesc , 
                         ISNULL(Com.tblAshkhaseHoghoghi_Detail.fldDate,Com.tblAshkhaseHoghoghi.fldDate)AS fldDate, Com.tblAshkhaseHoghoghi.fldShenaseMelli, Com.tblAshkhaseHoghoghi.fldName, Com.tblAshkhaseHoghoghi.fldShomareSabt
						  ,fldTypeShakhs,case when fldTypeShakhs=0 then N'اتباع داخلی' else N'اتباع خارجی' end as fldTypeShakhsName
FROM            Com.tblAshkhaseHoghoghi_Detail RIGHT OUTER JOIN
                         Com.tblAshkhaseHoghoghi ON Com.tblAshkhaseHoghoghi_Detail.fldAshkhaseHoghoghiId = Com.tblAshkhaseHoghoghi.fldId
WHERE  fldName like @Value
if (@fieldname=N'AshkhasHoghoghi_fldShomareSabt')
	SELECT        TOP (@h) ISNULL(Com.tblAshkhaseHoghoghi_Detail.fldId,0)AS fldId, tblAshkhaseHoghoghi.fldId AS fldAshkhaseHoghoghiId,ISNULL( Com.tblAshkhaseHoghoghi_Detail.fldCodEghtesadi,'') AS fldCodEghtesadi, ISNULL(Com.tblAshkhaseHoghoghi_Detail.fldAddress,'')AS fldAddress, 
                         ISNULL(Com.tblAshkhaseHoghoghi_Detail.fldCodePosti,'') AS fldCodePosti, ISNULL(Com.tblAshkhaseHoghoghi_Detail.fldShomareTelephone,'')AS fldShomareTelephone, ISNULL(Com.tblAshkhaseHoghoghi_Detail.fldUserId,Com.tblAshkhaseHoghoghi.fldUserId)AS fldUserId ,ISNULL( Com.tblAshkhaseHoghoghi_Detail.fldDesc,'') AS fldDesc , 
                         ISNULL(Com.tblAshkhaseHoghoghi_Detail.fldDate,Com.tblAshkhaseHoghoghi.fldDate)AS fldDate, Com.tblAshkhaseHoghoghi.fldShenaseMelli, Com.tblAshkhaseHoghoghi.fldName, Com.tblAshkhaseHoghoghi.fldShomareSabt
 ,fldTypeShakhs,case when fldTypeShakhs=0 then N'اتباع داخلی' else N'اتباع خارجی' end as fldTypeShakhsName
FROM            Com.tblAshkhaseHoghoghi_Detail RIGHT OUTER JOIN
                         Com.tblAshkhaseHoghoghi ON Com.tblAshkhaseHoghoghi_Detail.fldAshkhaseHoghoghiId = Com.tblAshkhaseHoghoghi.fldId
WHERE  fldShomareSabt like @Value
if (@fieldname=N'AshkhasHoghoghi_fldShenaseMelli')
	SELECT        TOP (@h) ISNULL(Com.tblAshkhaseHoghoghi_Detail.fldId,0)AS fldId, tblAshkhaseHoghoghi.fldId AS fldAshkhaseHoghoghiId,ISNULL( Com.tblAshkhaseHoghoghi_Detail.fldCodEghtesadi,'') AS fldCodEghtesadi, ISNULL(Com.tblAshkhaseHoghoghi_Detail.fldAddress,'')AS fldAddress, 
                         ISNULL(Com.tblAshkhaseHoghoghi_Detail.fldCodePosti,'') AS fldCodePosti, ISNULL(Com.tblAshkhaseHoghoghi_Detail.fldShomareTelephone,'')AS fldShomareTelephone, ISNULL(Com.tblAshkhaseHoghoghi_Detail.fldUserId,Com.tblAshkhaseHoghoghi.fldUserId)AS fldUserId ,ISNULL( Com.tblAshkhaseHoghoghi_Detail.fldDesc,'') AS fldDesc , 
                         ISNULL(Com.tblAshkhaseHoghoghi_Detail.fldDate,Com.tblAshkhaseHoghoghi.fldDate)AS fldDate, Com.tblAshkhaseHoghoghi.fldShenaseMelli, Com.tblAshkhaseHoghoghi.fldName, Com.tblAshkhaseHoghoghi.fldShomareSabt
 ,fldTypeShakhs,case when fldTypeShakhs=0 then N'اتباع داخلی' else N'اتباع خارجی' end as fldTypeShakhsName
FROM            Com.tblAshkhaseHoghoghi_Detail RIGHT OUTER JOIN
                         Com.tblAshkhaseHoghoghi ON Com.tblAshkhaseHoghoghi_Detail.fldAshkhaseHoghoghiId = Com.tblAshkhaseHoghoghi.fldId
WHERE  fldShenaseMelli like @Value
	COMMIT
GO
