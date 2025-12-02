SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Dead].[spr_tblKartablSelect] 
@FieldName nvarchar(50),
@Value nvarchar(50),
@OrganId int,
@h int

AS 

	BEGIN TRAN
	if (@h=0) set @h=2147483647
	set @Value=com.fn_TextNormalize(@Value)

	if (@FieldName='fldId')
	SELECT top(@h) [fldId], [fldTitleKartabl], [fldUserId], [fldIP], [fldDesc], [fldDate] ,fldOrganId 
	,fldorderid,fldHaveEbtal,fldHaveEtmam,
	case when fldHaveEbtal=1 then  N'دارد' when fldHaveEbtal=0 then  N'ندارد' end as fldTitleEbtal,
	case when fldHaveEtmam=1 then  N'دارد' when fldHaveEtmam=0 then  N'ندارد' end as fldTitleEtmam
	FROM   [Dead].[tblKartabl] 
	WHERE  fldId=@Value and fldOrganId=@OrganId
order by fldorderid


if (@FieldName='fldTitleEbtal')
	SELECT top(@h)* from (select  [fldId], [fldTitleKartabl], [fldUserId], [fldIP], [fldDesc], [fldDate] ,fldOrganId 
	,fldorderid,fldHaveEbtal,fldHaveEtmam,
	case when fldHaveEbtal=1 then  N'دارد' when fldHaveEbtal=0 then  N'ندارد' end as fldTitleEbtal,
	case when fldHaveEtmam=1 then  N'دارد' when fldHaveEtmam=0 then  N'ندارد' end as fldTitleEtmam
	FROM   [Dead].[tblKartabl] )t
	WHERE  fldTitleEbtal like @Value and fldOrganId=@OrganId
order by fldorderid

if (@FieldName='fldTitleEtmam')
	SELECT top(@h)* from (select  [fldId], [fldTitleKartabl], [fldUserId], [fldIP], [fldDesc], [fldDate] ,fldOrganId 
	,fldorderid,fldHaveEbtal,fldHaveEtmam,
	case when fldHaveEbtal=1 then  N'دارد' when fldHaveEbtal=0 then  N'ندارد' end as fldTitleEbtal,
	case when fldHaveEtmam=1 then  N'دارد' when fldHaveEtmam=0 then  N'ندارد' end as fldTitleEtmam
	FROM   [Dead].[tblKartabl] )t
	WHERE  fldTitleEtmam like @Value and fldOrganId=@OrganId
order by fldorderid

	if (@FieldName='fldDesc')
	SELECT top(@h) [fldId], [fldTitleKartabl], [fldUserId], [fldIP], [fldDesc], [fldDate] ,fldOrganId
	,fldorderid ,fldHaveEbtal,fldHaveEtmam,
	case when fldHaveEbtal=1 then  N'دارد' when fldHaveEbtal=0 then  N'ندارد' end as fldTitleEbtal,
	case when fldHaveEtmam=1 then  N'دارد' when fldHaveEtmam=0 then  N'ندارد' end as fldTitleEtmam
	FROM   [Dead].[tblKartabl] 
	WHERE  fldDesc like @Value and  fldOrganId=@OrganId
	order by fldorderid


	if (@FieldName='fldTitleKartabl')
	SELECT top(@h) [fldId], [fldTitleKartabl], [fldUserId], [fldIP], [fldDesc], [fldDate] ,fldOrganId 
	,fldorderid,fldHaveEbtal,fldHaveEtmam,
	case when fldHaveEbtal=1 then  N'دارد' when fldHaveEbtal=0 then  N'ندارد' end as fldTitleEbtal,
	case when fldHaveEtmam=1 then  N'دارد' when fldHaveEtmam=0 then  N'ندارد' end as fldTitleEtmam
	FROM   [Dead].[tblKartabl] 
	WHERE  fldTitleKartabl like @Value and  fldOrganId=@OrganId
	order by fldorderid


	if (@FieldName='')
	SELECT top(@h) [fldId], [fldTitleKartabl], [fldUserId], [fldIP], [fldDesc], [fldDate] ,fldOrganId 
	,fldorderid,fldHaveEbtal,fldHaveEtmam,
	case when fldHaveEbtal=1 then  N'دارد' when fldHaveEbtal=0 then  N'ندارد' end as fldTitleEbtal,
	case when fldHaveEtmam=1 then  N'دارد' when fldHaveEtmam=0 then  N'ندارد' end as fldTitleEtmam
	FROM   [Dead].[tblKartabl]  
	where   fldOrganId=@OrganId
	order by fldorderid


	if (@FieldName='fldOrganId')
	SELECT top(@h) [fldId], [fldTitleKartabl], [fldUserId], [fldIP], [fldDesc], [fldDate] ,fldOrganId 
	,fldorderid,fldHaveEbtal,fldHaveEtmam,
	case when fldHaveEbtal=1 then  N'دارد' when fldHaveEbtal=0 then  N'ندارد' end as fldTitleEbtal,
	case when fldHaveEtmam=1 then  N'دارد' when fldHaveEtmam=0 then  N'ندارد' end as fldTitleEtmam
	FROM   [Dead].[tblKartabl] 
	WHERE    fldOrganId=@OrganId
	order by fldorderid

	
	COMMIT
GO
