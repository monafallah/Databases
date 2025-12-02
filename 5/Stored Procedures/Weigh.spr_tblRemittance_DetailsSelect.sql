SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Weigh].[spr_tblRemittance_DetailsSelect] 
@FieldName nvarchar(50),
@Value nvarchar(50),
@organId int,
@h int

AS 

	BEGIN TRAN
	if (@h=0) set @h=2147483647
	set @Value=com.fn_TextNormalize(@Value)

	if (@FieldName='fldId')
	SELECT top(@h) d.[fldId], [fldRemittanceId], [fldKalaId], isnull((cast( d.[fldMaxTon] as varchar(20))),'') as fldMaxTon, [fldControlLimit], d.[fldUserId], d.[fldOrganId], d.[fldDesc]
	, d.[fldDate], d.[fldIP] ,k.fldName as fldKalaName,h.fldtitle as fldTitleHeader,isnull(ExistsVazn,0)fldExistsVazn
	FROM   [Weigh].[tblRemittance_Details] as d
	inner join com.tblKala as k on k.fldId=d.fldKalaId
	inner join weigh.tblRemittance_Header h on h.fldid=fldRemittanceId
	outer apply (select 1 as ExistsVazn  from Weigh.tblVazn_Baskool  v
					where v.fldKalaId=d.fldKalaId and v.fldRemittanceId=d.fldRemittanceId and v.fldOrganId=d.fldOrganId
					and fldEbtal=0)vazn
	WHERE  d.fldId=@Value and d.fldorganId=@organId

	if (@FieldName='fldDesc')
		SELECT top(@h) d.[fldId], [fldRemittanceId], [fldKalaId], isnull((cast( d.[fldMaxTon] as varchar(20))),'') as fldMaxTon, [fldControlLimit], d.[fldUserId], d.[fldOrganId], d.[fldDesc]
	, d.[fldDate], d.[fldIP] ,k.fldName as fldKalaName,h.fldtitle as fldTitleHeader,isnull(ExistsVazn,0)fldExistsVazn
	FROM   [Weigh].[tblRemittance_Details] as d
	inner join com.tblKala as k on k.fldId=d.fldKalaId
	inner join weigh.tblRemittance_Header h on h.fldid=fldRemittanceId
	outer apply (select 1 as ExistsVazn  from Weigh.tblVazn_Baskool  v
					where v.fldKalaId=d.fldKalaId and v.fldRemittanceId=d.fldRemittanceId and v.fldOrganId=d.fldOrganId
					and fldEbtal=0)vazn
	WHERE  d.fldDesc like @Value and d.fldorganId=@organId

	if (@FieldName='fldKalaName')
		SELECT top(@h) d.[fldId], [fldRemittanceId], [fldKalaId], isnull((cast( d.[fldMaxTon] as varchar(20))),'') as fldMaxTon, [fldControlLimit], d.[fldUserId], d.[fldOrganId], d.[fldDesc]
	, d.[fldDate], d.[fldIP] ,k.fldName as fldKalaName,h.fldtitle as fldTitleHeader,isnull(ExistsVazn,0)fldExistsVazn
	FROM   [Weigh].[tblRemittance_Details] as d
	inner join com.tblKala as k on k.fldId=d.fldKalaId
	inner join weigh.tblRemittance_Header h on h.fldid=fldRemittanceId
	outer apply (select 1 as ExistsVazn  from Weigh.tblVazn_Baskool  v
					where v.fldKalaId=d.fldKalaId and v.fldRemittanceId=d.fldRemittanceId and v.fldOrganId=d.fldOrganId
					and fldEbtal=0)vazn
	WHERE k.fldName like @Value and d.fldorganId=@organId

	if (@FieldName='fldOrganId')
		SELECT top(@h) d.[fldId], [fldRemittanceId], [fldKalaId], isnull((cast( d.[fldMaxTon] as varchar(20))),'') as fldMaxTon, [fldControlLimit], d.[fldUserId], d.[fldOrganId], d.[fldDesc]
	, d.[fldDate], d.[fldIP] ,k.fldName as fldKalaName,h.fldtitle as fldTitleHeader,isnull(ExistsVazn,0)fldExistsVazn
	FROM   [Weigh].[tblRemittance_Details] as d
	inner join com.tblKala as k on k.fldId=d.fldKalaId
	inner join weigh.tblRemittance_Header h on h.fldid=fldRemittanceId
	outer apply (select 1 as ExistsVazn  from Weigh.tblVazn_Baskool  v
					where v.fldKalaId=d.fldKalaId and v.fldRemittanceId=d.fldRemittanceId and v.fldOrganId=d.fldOrganId
					and fldEbtal=0)vazn
	WHERE   d.fldorganId=@organId

	if (@FieldName='HeaderId')
	SELECT top(@h) d.[fldId], [fldRemittanceId], [fldKalaId], isnull((cast( d.[fldMaxTon] as varchar(20))),'') as fldMaxTon, [fldControlLimit], d.[fldUserId], d.[fldOrganId], d.[fldDesc]
	, d.[fldDate], d.[fldIP] ,k.fldName as fldKalaName,h.fldtitle as fldTitleHeader,isnull(ExistsVazn,0)fldExistsVazn
	FROM   [Weigh].[tblRemittance_Details] as d
	inner join com.tblKala as k on k.fldId=d.fldKalaId
	inner join weigh.tblRemittance_Header h on h.fldid=fldRemittanceId
	outer apply (select 1 as ExistsVazn  from Weigh.tblVazn_Baskool  v
					where v.fldKalaId=d.fldKalaId and v.fldRemittanceId=d.fldRemittanceId and v.fldOrganId=d.fldOrganId
					and fldEbtal=0)vazn
	WHERE   d.[fldRemittanceId]=@Value

	if (@FieldName='fldRemittanceId')
	SELECT top(@h) isnull(d.[fldId],0) as [fldId], isnull([fldRemittanceId],0) as fldRemittanceId,ISNULL( k.fldId,0) as fldKalaId
	,isnull((cast( d.[fldMaxTon] as varchar(20))),'') as fldMaxTon, isnull([fldControlLimit],cast(1 as bit)) as fldControlLimit, isnull(d.[fldUserId],0) as fldUserId
	, isnull(d.[fldOrganId],0) as fldOrganId, isnull(d.[fldDesc],'') as fldDesc
	, isnull(d.[fldDate],getdate()) as fldDate, isnull(d.[fldIP],'') as fldIP,isnull(k.fldName,'') as fldKalaName
	,isnull(h.fldtitle,'')fldTitleHeader,isnull(ExistsVazn,0)fldExistsVazn
	FROM   [Weigh].[tblRemittance_Details] as d
	inner join weigh.tblRemittance_Header h on h.fldid=fldRemittanceId
	right join com.tblKala as k on k.fldId=d.fldKalaId and d.fldRemittanceId=@Value
	outer apply (select 1 as ExistsVazn  from Weigh.tblVazn_Baskool  v
					where v.fldKalaId=d.fldKalaId and v.fldRemittanceId=d.fldRemittanceId and v.fldOrganId=d.fldOrganId
					and fldEbtal=0)vazn
	
	--right join weigh.tblRemittance_Header h on h.fldid=fldRemittanceId
	
	if (@FieldName='')
	SELECT top(@h) d.[fldId], [fldRemittanceId], [fldKalaId], isnull((cast( d.[fldMaxTon] as varchar(20))),'') as fldMaxTon, [fldControlLimit], d.[fldUserId], d.[fldOrganId], d.[fldDesc]
	, d.[fldDate], d.[fldIP] ,k.fldName as fldKalaName,h.fldtitle as fldTitleHeader,isnull(ExistsVazn,0)fldExistsVazn
	FROM   [Weigh].[tblRemittance_Details] as d
	inner join com.tblKala as k on k.fldId=d.fldKalaId
	inner join weigh.tblRemittance_Header h on h.fldid=fldRemittanceId
	outer apply (select top(1) 1 as ExistsVazn  from Weigh.tblVazn_Baskool  v
					where v.fldKalaId=d.fldKalaId and v.fldRemittanceId=d.fldRemittanceId and v.fldOrganId=d.fldOrganId
					and fldEbtal=0)vazn

	
	COMMIT
GO
