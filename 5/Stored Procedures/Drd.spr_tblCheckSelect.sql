SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblCheckSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@h int
AS 
	BEGIN TRAN
	set  @Value=com.fn_TextNormalize(@Value)
	if (@h=0) set @h=2147483647
	if (@fieldname=N'fldId')
SELECT TOP (@h) c.fldId, fldShomareHesabId, fldShomareSanad, fldReplyTaghsitId, fldTarikhSarResid, CAST(fldMablaghSanad AS BIGINT)fldMablaghSanad, fldStatus, fldTypeSanad, c.fldUserId, c.fldDesc, c.fldDate, 
                  CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N' چک ضمانتی' END AS fldTypeSanadName, 
                  CASE WHEN fldStatus = 1 THEN N'در انتظار وصول' WHEN fldStatus = 2 THEN N'وصول شده' WHEN fldStatus = 3 THEN N'برگشت خورده' WHEN fldStatus = 4 THEN N'حقوقی شده' WHEN fldStatus
                   = 5 THEN N'عودت داده شده' END AS fldStatusName, fldShomareHesabIdOrgan,fldSendToMali,fldSendToMaliDate
				   ,s.fldShomareHesab ,s.fldShomareHesab  fldShomareHesabOrgan
FROM     Drd.tblCheck c
inner join com.tblShomareHesabeOmoomi s on s.fldid=fldShomareHesabId
inner join com.tblShomareHesabeOmoomi  s1 on s1.fldid=fldShomareHesabIdOrgan
	WHERE  c.fldId = @Value


	if (@fieldname=N'fldShomareHesabId')
	SELECT TOP (@h) c.fldId, fldShomareHesabId, fldShomareSanad, fldReplyTaghsitId, fldTarikhSarResid, CAST(fldMablaghSanad AS BIGINT)fldMablaghSanad, fldStatus, fldTypeSanad, c.fldUserId, c.fldDesc, c.fldDate, 
                  CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N' چک ضمانتی' END AS fldTypeSanadName, 
                  CASE WHEN fldStatus = 1 THEN N'در انتظار وصول' WHEN fldStatus = 2 THEN N'وصول شده' WHEN fldStatus = 3 THEN N'برگشت خورده' WHEN fldStatus = 4 THEN N'حقوقی شده' WHEN fldStatus
                   = 5 THEN N'عودت داده شده' END AS fldStatusName, fldShomareHesabIdOrgan,fldSendToMali,fldSendToMaliDate
				   ,s.fldShomareHesab ,s.fldShomareHesab  fldShomareHesabOrgan
FROM     Drd.tblCheck c
inner join com.tblShomareHesabeOmoomi s on s.fldid=fldShomareHesabId
inner join com.tblShomareHesabeOmoomi  s1 on s1.fldid=fldShomareHesabIdOrgan
	WHERE  fldShomareHesabId = @Value and fldReplyTaghsitId is not null

	if (@fieldname=N'fldReplyTaghsitId')
	SELECT TOP (@h) c.fldId, fldShomareHesabId, fldShomareSanad, fldReplyTaghsitId, fldTarikhSarResid, CAST(fldMablaghSanad AS BIGINT)fldMablaghSanad, fldStatus, fldTypeSanad, c.fldUserId, c.fldDesc, c.fldDate, 
                  CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N' چک ضمانتی' END AS fldTypeSanadName, 
                  CASE WHEN fldStatus = 1 THEN N'در انتظار وصول' WHEN fldStatus = 2 THEN N'وصول شده' WHEN fldStatus = 3 THEN N'برگشت خورده' WHEN fldStatus = 4 THEN N'حقوقی شده' WHEN fldStatus
                   = 5 THEN N'عودت داده شده' END AS fldStatusName, fldShomareHesabIdOrgan,fldSendToMali,fldSendToMaliDate
				   ,s.fldShomareHesab ,s.fldShomareHesab  fldShomareHesabOrgan
FROM     Drd.tblCheck c
inner join com.tblShomareHesabeOmoomi s on s.fldid=fldShomareHesabId
inner join com.tblShomareHesabeOmoomi  s1 on s1.fldid=fldShomareHesabIdOrgan
	WHERE  fldReplyTaghsitId = @Value

	if (@fieldname=N'fldDesc')
SELECT TOP (@h) c.fldId, fldShomareHesabId, fldShomareSanad, fldReplyTaghsitId, fldTarikhSarResid, CAST(fldMablaghSanad AS BIGINT)fldMablaghSanad, fldStatus, fldTypeSanad, c.fldUserId, c.fldDesc, c.fldDate, 
                  CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N' چک ضمانتی' END AS fldTypeSanadName, 
                  CASE WHEN fldStatus = 1 THEN N'در انتظار وصول' WHEN fldStatus = 2 THEN N'وصول شده' WHEN fldStatus = 3 THEN N'برگشت خورده' WHEN fldStatus = 4 THEN N'حقوقی شده' WHEN fldStatus
                   = 5 THEN N'عودت داده شده' END AS fldStatusName, fldShomareHesabIdOrgan,fldSendToMali,fldSendToMaliDate
				   ,s.fldShomareHesab ,s.fldShomareHesab  fldShomareHesabOrgan
FROM     Drd.tblCheck c
inner join com.tblShomareHesabeOmoomi s on s.fldid=fldShomareHesabId
inner join com.tblShomareHesabeOmoomi  s1 on s1.fldid=fldShomareHesabIdOrgan
	WHERE  c.fldDesc like @Value and fldReplyTaghsitId is not null


	if (@fieldname=N'fldShomareSanad')
	SELECT TOP (@h) c.fldId, fldShomareHesabId, fldShomareSanad, fldReplyTaghsitId, fldTarikhSarResid, CAST(fldMablaghSanad AS BIGINT)fldMablaghSanad, fldStatus, fldTypeSanad, c.fldUserId, c.fldDesc, c.fldDate, 
                  CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N' چک ضمانتی' END AS fldTypeSanadName, 
                  CASE WHEN fldStatus = 1 THEN N'در انتظار وصول' WHEN fldStatus = 2 THEN N'وصول شده' WHEN fldStatus = 3 THEN N'برگشت خورده' WHEN fldStatus = 4 THEN N'حقوقی شده' WHEN fldStatus
                   = 5 THEN N'عودت داده شده' END AS fldStatusName, fldShomareHesabIdOrgan,fldSendToMali,fldSendToMaliDate
				   ,s.fldShomareHesab ,s.fldShomareHesab  fldShomareHesabOrgan
FROM     Drd.tblCheck c
inner join com.tblShomareHesabeOmoomi s on s.fldid=fldShomareHesabId
inner join com.tblShomareHesabeOmoomi  s1 on s1.fldid=fldShomareHesabIdOrgan
	WHERE  fldShomareSanad like @Value and fldReplyTaghsitId is not null

	if (@fieldname=N'')
	SELECT TOP (@h) c.fldId, fldShomareHesabId, fldShomareSanad, fldReplyTaghsitId, fldTarikhSarResid, CAST(fldMablaghSanad AS BIGINT)fldMablaghSanad, fldStatus, fldTypeSanad, c.fldUserId, c.fldDesc, c.fldDate, 
                  CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N' چک ضمانتی' END AS fldTypeSanadName, 
                  CASE WHEN fldStatus = 1 THEN N'در انتظار وصول' WHEN fldStatus = 2 THEN N'وصول شده' WHEN fldStatus = 3 THEN N'برگشت خورده' WHEN fldStatus = 4 THEN N'حقوقی شده' WHEN fldStatus
                   = 5 THEN N'عودت داده شده' END AS fldStatusName, fldShomareHesabIdOrgan,fldSendToMali,fldSendToMaliDate
				   ,s.fldShomareHesab ,s.fldShomareHesab  fldShomareHesabOrgan
FROM     Drd.tblCheck c
inner join com.tblShomareHesabeOmoomi s on s.fldid=fldShomareHesabId
inner join com.tblShomareHesabeOmoomi  s1 on s1.fldid=fldShomareHesabIdOrgan
	where  fldReplyTaghsitId is not null


	if (@fieldname=N'ListCheck_Sanad')
	SELECT TOP (@h) c1.fldId, fldShomareHesabId, fldShomareSanad, fldReplyTaghsitId, fldTarikhSarResid, CAST(fldMablaghSanad AS BIGINT)fldMablaghSanad, fldStatus, fldTypeSanad, c1.fldUserId, c1.fldDesc, c1.fldDate, 
                  CASE WHEN fldTypeSanad = 0 THEN N'چک عادی' ELSE N' چک ضمانتی' END AS fldTypeSanadName, 
                  CASE WHEN fldStatus = 1 THEN N'در انتظار وصول' WHEN fldStatus = 2 THEN N'وصول شده' WHEN fldStatus = 3 THEN N'برگشت خورده' WHEN fldStatus = 4 THEN N'حقوقی شده' WHEN fldStatus
                   = 5 THEN N'عودت داده شده' END AS fldStatusName, fldShomareHesabIdOrgan,fldSendToMali,fldSendToMaliDate
				   ,s.fldShomareHesab ,s.fldShomareHesab  fldShomareHesabOrgan
FROM     Drd.tblCheck c1
inner join com.tblShomareHesabeOmoomi s on s.fldid=fldShomareHesabId
inner join com.tblShomareHesabeOmoomi  s1 on s1.fldid=fldShomareHesabIdOrgan
	cross apply (select fldSourceId from [ACC].[tblDocumentRecord_Details] left join 
			[ACC].tblCase	on tblCase.fldId=tblDocumentRecord_Details.fldCaseId inner join 
			acc.tblCoding_Details c on c.fldid=fldCodingId left outer join 
			ACC.tblCenterCost on tblCenterCost.fldId=fldCenterCoId
			INNER JOIN acc.tblDocumentRecord_Header h on h.fldid=[tblDocumentRecord_Details].fldDocument_HedearId
			inner join acc.tblDocumentRecord_Header1 h1 on h1.fldDocument_HedearId=h.fldid
			WHERE  fldCaseTypeId=3 and fldSourceId=  c1.fldid  and fldModuleErsalId=12
			and (fldDocument_HedearId1=h1.fldId or 
					(not exists(select * from Acc.tblDocumentRecord_Details as d2 where d2.fldDocument_HedearId1=h1.fldId )   and fldDocument_HedearId1 is null)) 
	and fldFiscalYearId=@value
)acc
	where  fldStatus =1  
	

	COMMIT
GO
