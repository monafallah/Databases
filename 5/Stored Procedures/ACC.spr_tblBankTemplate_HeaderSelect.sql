SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [ACC].[spr_tblBankTemplate_HeaderSelect] 
@fieldname nvarchar(50),
@value nvarchar(50),
@h int
AS 
 
	--set @value=com.fn_TextNormalize(@value)
	if (@h=0) set @h=2147483647 
	BEGIN TRAN
	if (@fieldname='fldId')
	SELECT top(@h)h.[fldId], [fldNamePattern], [fldStartRow], h.[fldDesc], h.[fldDate], h.[fldIP], h.[fldUserId] ,d.fldBankName
	,f.fldPasvand,h.fldFileId,b.fldBankId,i.fldDetailsId
	FROM   [ACC].[tblBankTemplate_Header]  as h
	inner join com.tblFile as f on f.fldId=h.fldFileId
	cross apply(select(select b.fldBankName+',' from acc.tblBankTemplate_Details as d inner join com.tblBank as b on d.fldBankId=b.fldId and fldHeaderId=h.fldId for xml path('')) as fldBankName)d
	cross apply(select(select cast(d.fldBankId as varchar(5))+',' from acc.tblBankTemplate_Details as d where fldHeaderId=h.fldId for xml path('')) as fldBankId)b
	cross apply(select(select cast(d.fldId as  varchar(5))+',' from acc.tblBankTemplate_Details as d where fldHeaderId=h.fldId for xml path('')) as fldDetailsId)i
	WHERE  h.fldId=@value
	
	if (@fieldname='fldFileId')
	SELECT top(@h)h.[fldId], [fldNamePattern], [fldStartRow], h.[fldDesc], h.[fldDate], h.[fldIP], h.[fldUserId] ,d.fldBankName
	,f.fldPasvand,h.fldFileId,b.fldBankId,i.fldDetailsId
	FROM   [ACC].[tblBankTemplate_Header]  as h
	inner join com.tblFile as f on f.fldId=h.fldFileId
	cross apply(select(select b.fldBankName+',' from acc.tblBankTemplate_Details as d inner join com.tblBank as b on d.fldBankId=b.fldId and fldHeaderId=h.fldId for xml path('')) as fldBankName)d
	cross apply(select(select cast(d.fldBankId as varchar(5))+',' from acc.tblBankTemplate_Details as d where fldHeaderId=h.fldId for xml path('')) as fldBankId)b
	cross apply(select(select cast(d.fldId as  varchar(5))+',' from acc.tblBankTemplate_Details as d where fldHeaderId=h.fldId for xml path('')) as fldDetailsId)i
	WHERE  h.fldFileId=@value

	if (@fieldname='fldStartRow')
	SELECT top(@h)h.[fldId], [fldNamePattern], [fldStartRow], h.[fldDesc], h.[fldDate], h.[fldIP], h.[fldUserId] ,d.fldBankName
	,f.fldPasvand,h.fldFileId,b.fldBankId,i.fldDetailsId
	FROM   [ACC].[tblBankTemplate_Header]  as h
	inner join com.tblFile as f on f.fldId=h.fldFileId
	cross apply(select(select b.fldBankName+',' from acc.tblBankTemplate_Details as d inner join com.tblBank as b on d.fldBankId=b.fldId and fldHeaderId=h.fldId for xml path('')) as fldBankName)d
	cross apply(select(select cast(d.fldBankId as varchar(5))+',' from acc.tblBankTemplate_Details as d where fldHeaderId=h.fldId for xml path('')) as fldBankId)b
	cross apply(select(select cast(d.fldId as  varchar(5))+',' from acc.tblBankTemplate_Details as d where fldHeaderId=h.fldId for xml path('')) as fldDetailsId)i
	WHERE  h.fldStartRow like @value

	if (@fieldname='fldNamePattern')
	SELECT top(@h)h.[fldId], [fldNamePattern], [fldStartRow], h.[fldDesc], h.[fldDate], h.[fldIP], h.[fldUserId] ,d.fldBankName
	,f.fldPasvand,h.fldFileId,b.fldBankId,i.fldDetailsId
	FROM   [ACC].[tblBankTemplate_Header]  as h
	inner join com.tblFile as f on f.fldId=h.fldFileId
	cross apply(select(select b.fldBankName+',' from acc.tblBankTemplate_Details as d inner join com.tblBank as b on d.fldBankId=b.fldId and fldHeaderId=h.fldId for xml path('')) as fldBankName)d
	cross apply(select(select cast(d.fldBankId as varchar(5))+',' from acc.tblBankTemplate_Details as d where fldHeaderId=h.fldId for xml path('')) as fldBankId)b
	cross apply(select(select cast(d.fldId as  varchar(5))+',' from acc.tblBankTemplate_Details as d where fldHeaderId=h.fldId for xml path('')) as fldDetailsId)i
	WHERE  h.fldNamePattern like @value

	if (@fieldname='fldBankName')
	SELECT top(@h)h.[fldId], [fldNamePattern], [fldStartRow], h.[fldDesc], h.[fldDate], h.[fldIP], h.[fldUserId] ,d.fldBankName
	,f.fldPasvand,h.fldFileId,b.fldBankId,i.fldDetailsId
	FROM   [ACC].[tblBankTemplate_Header]  as h
	inner join com.tblFile as f on f.fldId=h.fldFileId
	cross apply(select(select b.fldBankName+',' from acc.tblBankTemplate_Details as d inner join com.tblBank as b on d.fldBankId=b.fldId and fldHeaderId=h.fldId for xml path('')) as fldBankName)d
	cross apply(select(select cast(d.fldBankId as varchar(5))+',' from acc.tblBankTemplate_Details as d where fldHeaderId=h.fldId for xml path('')) as fldBankId)b
	cross apply(select(select cast(d.fldId as  varchar(5))+',' from acc.tblBankTemplate_Details as d where fldHeaderId=h.fldId for xml path('')) as fldDetailsId)i
	WHERE  d.fldBankName like @value

	if (@fieldname='fldBankId')
	SELECT top(@h)h.[fldId], [fldNamePattern], [fldStartRow], h.[fldDesc], h.[fldDate], h.[fldIP], h.[fldUserId] ,b.fldBankName
	,f.fldPasvand,h.fldFileId,cast (d.fldBankId as varchar(5))fldBankId ,cast((d.fldId ) as varchar(5))as fldDetailsId
	FROM   [ACC].[tblBankTemplate_Header]  as h
	inner join com.tblFile as f on f.fldId=h.fldFileId
	inner join acc.tblBankTemplate_details as d on d.fldHeaderId=h.fldid
	inner join com.tblBank as b on d.fldBankId=b.fldId
	--cross apply(select(select b.fldBankName+',' from acc.tblBankTemplate_Details as d inner join com.tblBank as b on d.fldBankId=b.fldId and fldHeaderId=h.fldId for xml path('')) as fldBankName)d,
	--cross apply(select(select cast(d.fldBankId as varchar(5))+',' from acc.tblBankTemplate_Details as d where fldHeaderId=h.fldId for xml path('')) as fldBankId)b
	--cross apply(select(select cast(d.fldId as  varchar(5))+',' from acc.tblBankTemplate_Details as d where fldHeaderId=h.fldId for xml path('')) as fldDetailsId)i
	WHERE  d.fldBankId = @value


	if (@fieldname='')
	SELECT top(@h)h.[fldId], [fldNamePattern], [fldStartRow], h.[fldDesc], h.[fldDate], h.[fldIP], h.[fldUserId] ,d.fldBankName
	,f.fldPasvand,h.fldFileId,b.fldBankId,i.fldDetailsId
	FROM   [ACC].[tblBankTemplate_Header]  as h
	inner join com.tblFile as f on f.fldId=h.fldFileId
	cross apply(select(select b.fldBankName+',' from acc.tblBankTemplate_Details as d inner join com.tblBank as b on d.fldBankId=b.fldId and fldHeaderId=h.fldId for xml path('')) as fldBankName)d
	cross apply(select(select cast(d.fldBankId as varchar(5))+',' from acc.tblBankTemplate_Details as d where fldHeaderId=h.fldId for xml path('')) as fldBankId)b
	cross apply(select(select cast(d.fldId as  varchar(5))+',' from acc.tblBankTemplate_Details as d where fldHeaderId=h.fldId for xml path('')) as fldDetailsId)i

	


	COMMIT
GO
