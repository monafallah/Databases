SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Cntr].[spr_tblFactorDetailSelect] 
@fieldname nvarchar(50),
@value nvarchar(50),
@organId int,
@h int
AS 
 
	set @value=com.fn_TextNormalize(@value)
	if (@h=0) set @h=2147483647 
	BEGIN TRAN
	if (@fieldname='fldId')
	SELECT top(@h) c.fldTitle+' ('+c.fldCode+')' fldTitle, f.[fldId], [fldHeaderId], [fldMablagh], [fldMablaghMaliyat], [fldCodingDetailId], [fldOrganId], f.[fldUserId], f.[fldDesc], f.[fldIP], f.[fldDate] 
	,fldSharhArtikl,fldTax,case when fldTax=1 then  N'هست'  when fldTax=0 then N'نیست' end as fldTaxName 
	FROM   [Cntr].[tblFactorDetail] f
	inner join acc.tblCoding_Details c on f.fldCodingDetailId=c.fldId
	WHERE  f.fldId=@value
	
	if (@fieldname='')
	SELECT  top(@h) c.fldTitle+' ('+c.fldCode+')' fldTitle, f.[fldId], [fldHeaderId], [fldMablagh], [fldMablaghMaliyat], [fldCodingDetailId], [fldOrganId], f.[fldUserId], f.[fldDesc],f.[fldIP], f.[fldDate] 
	,fldSharhArtikl,fldTax,case when fldTax=1 then  N'هست'  when fldTax=0 then N'نیست' end as fldTaxName 
	FROM   [Cntr].[tblFactorDetail] f
	inner join acc.tblCoding_Details c on f.fldCodingDetailId=c.fldId
	

	if (@fieldname='fldOrganId')
	SELECT  top(@h) c.fldTitle+' ('+c.fldCode+')' fldTitle, f.[fldId], [fldHeaderId], [fldMablagh], [fldMablaghMaliyat], [fldCodingDetailId], [fldOrganId], f.[fldUserId], f.[fldDesc], f.[fldIP], f.[fldDate] 
	,fldSharhArtikl,fldTax,case when fldTax=1 then  N'هست'  when fldTax=0 then N'نیست' end as fldTaxName  
	FROM   [Cntr].[tblFactorDetail] f
	inner join acc.tblCoding_Details c on f.fldCodingDetailId=c.fldId
	where fldOrganId=@organId

	if (@fieldname='fldHeaderId')
	begin 
	if (@value=0)
	SELECT  '' fldTitle, 0[fldId],0 [fldHeaderId], cast(0 as bigint)[fldMablagh], cast(0 as bigint)[fldMablaghMaliyat],0 [fldCodingDetailId], 0[fldOrganId], 0[fldUserId], ''[fldDesc], ''[fldIP], getdate() fldDate
	,''fldSharhArtikl,cast(0 as bit)fldTax, N'نیست' fldTaxName 

	else 
	SELECT  top(@h) c.fldTitle+' ('+c.fldCode+')' fldTitle, f.[fldId], [fldHeaderId], [fldMablagh], [fldMablaghMaliyat], [fldCodingDetailId], [fldOrganId], f.[fldUserId], f.[fldDesc], f.[fldIP], f.[fldDate] 
	,fldSharhArtikl,fldTax,case when fldTax=1 then  N'هست'  when fldTax=0 then N'نیست' end as fldTaxName 
	FROM   [Cntr].[tblFactorDetail] f
	inner join acc.tblCoding_Details c on f.fldCodingDetailId=c.fldId
	where fldHeaderId=@value and fldOrganId=@organId

	end
	if (@fieldname='fldContractId')/*فرق داره*/
	SELECT  top(@h) c.fldTitle+' ('+c.fldCode+')' fldTitle, f.[fldId], [fldHeaderId], [fldMablagh], [fldMablaghMaliyat], [fldCodingDetailId], f.[fldOrganId], f.[fldUserId], f.[fldDesc], f.[fldIP], f.[fldDate] 
	,fldSharhArtikl,fldTax,case when fldTax=1 then  N'هست'  when fldTax=0 then N'نیست' end as fldTaxName 
	FROM   [Cntr].[tblFactorDetail] f
	inner join acc.tblCoding_Details c on f.fldCodingDetailId=c.fldId
	inner join cntr.tblContract_Factor on f.fldHeaderId=tblContract_Factor.fldFactorId
	where fldContractId=@value and f.fldOrganId=@organId


	if (@fieldname='fldTankhahGroupId')/*فرق داره*/
	SELECT  top(@h) c.fldTitle+' ('+c.fldCode+')' fldTitle, f.[fldId], [fldHeaderId], [fldMablagh], [fldMablaghMaliyat], [fldCodingDetailId], f.[fldOrganId], f.[fldUserId], f.[fldDesc], f.[fldIP], f.[fldDate] 
	,fldSharhArtikl,fldTax,case when fldTax=1 then  N'هست'  when fldTax=0 then N'نیست' end as fldTaxName 
	FROM   [Cntr].[tblFactorDetail] f
	inner join acc.tblCoding_Details c on f.fldCodingDetailId=c.fldId
	inner join cntr.tblFactorMostaghel on f.fldHeaderId=tblFactorMostaghel.fldFactorId
	where fldTankhahGroupId=@value and f.fldOrganId=@organId


	COMMIT
GO
