SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblItemsEstekhdam_FiscalTitleSelect] 
@fieldname nvarchar(Max),
	@NoeEstekhdam nvarchar(Max),
	@fldFiscalHeaderId int,
	@h int
AS 
	BEGIN TRAN
	if (@h=0) set @h=2147483647
	set @NoeEstekhdam= Com.fn_TextNormalize( @NoeEstekhdam)
	if (@fieldname=N'fldId')
	SELECT     TOP (@h) Com.tblItems_Estekhdam.fldId, Com.tblItems_Estekhdam.fldItemsHoghughiId, Com.tblItems_Estekhdam.fldTypeEstekhdamId, 
                      Com.tblItems_Estekhdam.fldTitle, Com.tblItems_Estekhdam.fldHasZarib, CASE WHEN (fldHasZarib = 1) THEN N'بله' ELSE N'خیر' END AS fldHasZaribName, 
                      Com.tblItems_Estekhdam.fldUserId, Com.tblItems_Estekhdam.fldDate, Com.tblItems_Estekhdam.fldDesc, Com.tblItemsHoghughi.fldTitle AS fldTitleItemsHoghughi, 
                      Com.tblAnvaEstekhdam.fldId AS flAnvaEstekhdamId, Com.tblAnvaEstekhdam.fldTitle AS fldAnvaEstekhdamTitle, 
                          cast(0 AS bit) AS fldMashmul,N'' as fldNameDefaultTax,cast(0 as bit) as fldMashmoolDefaultTax
FROM         Com.tblItems_Estekhdam INNER JOIN
                      Com.tblItemsHoghughi ON Com.tblItems_Estekhdam.fldItemsHoghughiId = Com.tblItemsHoghughi.fldId INNER JOIN
                      Com.tblTypeEstekhdam ON Com.tblItems_Estekhdam.fldTypeEstekhdamId = Com.tblTypeEstekhdam.fldId INNER JOIN
                      Com.tblAnvaEstekhdam ON Com.tblTypeEstekhdam.fldId = Com.tblAnvaEstekhdam.fldNoeEstekhdamId
		WHERE  Com.tblItems_Estekhdam.fldId = @NoeEstekhdam
	
	if (@fieldname=N'fldTypeEstekhdamId')
	SELECT     TOP (@h) Com.tblItems_Estekhdam.fldId, Com.tblItems_Estekhdam.fldItemsHoghughiId, Com.tblItems_Estekhdam.fldTypeEstekhdamId, 
                      Com.tblItems_Estekhdam.fldTitle, Com.tblItems_Estekhdam.fldHasZarib, CASE WHEN (fldHasZarib = 1) THEN N'بله' ELSE N'خیر' END AS fldHasZaribName, 
                      Com.tblItems_Estekhdam.fldUserId, Com.tblItems_Estekhdam.fldDate, Com.tblItems_Estekhdam.fldDesc, Com.tblItemsHoghughi.fldTitle AS fldTitleItemsHoghughi, 
                      Com.tblAnvaEstekhdam.fldId AS flAnvaEstekhdamId, Com.tblAnvaEstekhdam.fldTitle AS fldAnvaEstekhdamTitle, 
                          CAST(0 AS bit) AS fldMashmul,N'' as fldNameDefaultTax,cast(0 as bit) as fldMashmoolDefaultTax
FROM         Com.tblItems_Estekhdam INNER JOIN
                      Com.tblItemsHoghughi ON Com.tblItems_Estekhdam.fldItemsHoghughiId = Com.tblItemsHoghughi.fldId INNER JOIN
                      Com.tblTypeEstekhdam ON Com.tblItems_Estekhdam.fldTypeEstekhdamId = Com.tblTypeEstekhdam.fldId INNER JOIN
                      Com.tblAnvaEstekhdam ON Com.tblTypeEstekhdam.fldId = Com.tblAnvaEstekhdam.fldNoeEstekhdamId
		WHERE     (Com.tblItems_Estekhdam.fldTypeEstekhdamId = @NoeEstekhdam)
		
if (@fieldname=N'fldAnvaeEstekhdamId')
SELECT     TOP (@h) Com.tblItems_Estekhdam.fldId, Com.tblItems_Estekhdam.fldItemsHoghughiId, Com.tblItems_Estekhdam.fldTypeEstekhdamId, 
                      Com.tblItems_Estekhdam.fldTitle, Com.tblItems_Estekhdam.fldHasZarib, CASE WHEN (fldHasZarib = 1) THEN N'بله' ELSE N'خیر' END AS fldHasZaribName, 
                      Com.tblItems_Estekhdam.fldUserId, Com.tblItems_Estekhdam.fldDate, Com.tblItems_Estekhdam.fldDesc, Com.tblItemsHoghughi.fldTitle AS fldTitleItemsHoghughi, 
                      Com.tblAnvaEstekhdam.fldId AS flAnvaEstekhdamId, Com.tblAnvaEstekhdam.fldTitle AS fldAnvaEstekhdamTitle, CAST(0 AS bit) AS fldMashmul
					   ,N'' as fldNameDefaultTax,cast(0 as bit) as fldMashmoolDefaultTax
FROM         Com.tblItems_Estekhdam INNER JOIN
                      Com.tblItemsHoghughi ON Com.tblItems_Estekhdam.fldItemsHoghughiId = Com.tblItemsHoghughi.fldId INNER JOIN
                      Com.tblTypeEstekhdam ON Com.tblItems_Estekhdam.fldTypeEstekhdamId = Com.tblTypeEstekhdam.fldId INNER JOIN
                      Com.tblAnvaEstekhdam ON Com.tblTypeEstekhdam.fldId = Com.tblAnvaEstekhdam.fldNoeEstekhdamId  
		WHERE     (Com.tblAnvaEstekhdam.fldid = @NoeEstekhdam)

if (@fieldname=N'fldAnvaeEstekhdamId_Tax')
SELECT     TOP (@h) Com.tblItems_Estekhdam.fldId, Com.tblItems_Estekhdam.fldItemsHoghughiId, Com.tblItems_Estekhdam.fldTypeEstekhdamId, 
                      Com.tblItems_Estekhdam.fldTitle, Com.tblItems_Estekhdam.fldHasZarib, CASE WHEN (fldHasZarib = 1) THEN N'بله' ELSE N'خیر' END AS fldHasZaribName, 
                      Com.tblItems_Estekhdam.fldUserId, Com.tblItems_Estekhdam.fldDate, Com.tblItems_Estekhdam.fldDesc, Com.tblItemsHoghughi.fldTitle AS fldTitleItemsHoghughi, 
                      Com.tblAnvaEstekhdam.fldId AS flAnvaEstekhdamId, Com.tblAnvaEstekhdam.fldTitle AS fldAnvaEstekhdamTitle, CAST(0 AS bit) AS fldMashmul
					   ,d.fldName as fldNameDefaultTax,d.fldMashmool as fldMashmoolDefaultTax
FROM         Com.tblItems_Estekhdam INNER JOIN
                      Com.tblItemsHoghughi ON Com.tblItems_Estekhdam.fldItemsHoghughiId = Com.tblItemsHoghughi.fldId INNER JOIN
                      Com.tblTypeEstekhdam ON Com.tblItems_Estekhdam.fldTypeEstekhdamId = Com.tblTypeEstekhdam.fldId INNER JOIN
                      Com.tblAnvaEstekhdam ON Com.tblTypeEstekhdam.fldId = Com.tblAnvaEstekhdam.fldNoeEstekhdamId  INNER JOIN
					  pay.tblDefaultTax as d  on d.fldItemHoghoghiId=tblItems_Estekhdam.fldItemsHoghughiId
		WHERE     (Com.tblAnvaEstekhdam.fldid = @NoeEstekhdam)

		
	if (@fieldname=N'FiscalTitle')
	begin
		declare @AnvaEstekhdam int,@FiscalHeaderId int

		select top 1 @AnvaEstekhdam=fldNoeEstekhdamId from prs.tblHistoryNoeEstekhdam
		where fldPrsPersonalInfoId=@NoeEstekhdam
		order by fldTarikh desc

		select top 1  @FiscalHeaderId=fldFiscalHeaderId from Pay.tblFiscalTitle as f
		inner join pay.tblFiscal_Header as h on h.fldId=f.fldFiscalHeaderId
		 where fldAnvaEstekhdamId=@AnvaEstekhdam 
		 order by h.fldDateOfIssue desc

		SELECT     TOP (@h) Com.tblItems_Estekhdam.fldId, Com.tblItems_Estekhdam.fldItemsHoghughiId, Com.tblItems_Estekhdam.fldTypeEstekhdamId, 
                      Com.tblItems_Estekhdam.fldTitle, Com.tblItems_Estekhdam.fldHasZarib, CASE WHEN (fldHasZarib = 1) THEN N'بله' ELSE N'خیر' END AS fldHasZaribName, 
                      Com.tblItems_Estekhdam.fldUserId, Com.tblItems_Estekhdam.fldDate, Com.tblItems_Estekhdam.fldDesc, Com.tblItemsHoghughi.fldTitle AS fldTitleItemsHoghughi, 
                      Com.tblAnvaEstekhdam.fldId AS flAnvaEstekhdamId, Com.tblAnvaEstekhdam.fldTitle AS fldAnvaEstekhdamTitle, CAST(0 AS bit) AS fldMashmul
		,N'' as fldNameDefaultTax,cast(0 as bit) as fldMashmoolDefaultTax
		FROM         Com.tblItems_Estekhdam INNER JOIN
                      Com.tblItemsHoghughi ON Com.tblItems_Estekhdam.fldItemsHoghughiId = Com.tblItemsHoghughi.fldId INNER JOIN
                      Com.tblTypeEstekhdam ON Com.tblItems_Estekhdam.fldTypeEstekhdamId = Com.tblTypeEstekhdam.fldId INNER JOIN
                      Com.tblAnvaEstekhdam ON Com.tblTypeEstekhdam.fldId = Com.tblAnvaEstekhdam.fldNoeEstekhdamId inner join
					  Pay.tblFiscalTitle as f on f.fldAnvaEstekhdamId=Com.tblAnvaEstekhdam.fldid and f.fldItemEstekhdamId= Com.tblItems_Estekhdam.fldId
		WHERE     (Com.tblAnvaEstekhdam.fldid = @AnvaEstekhdam) and fldFiscalHeaderId=@FiscalHeaderId
	end

	if (@fieldname=N'fldTitle')
	SELECT     TOP (@h) Com.tblItems_Estekhdam.fldId, Com.tblItems_Estekhdam.fldItemsHoghughiId, Com.tblItems_Estekhdam.fldTypeEstekhdamId, 
                      Com.tblItems_Estekhdam.fldTitle, Com.tblItems_Estekhdam.fldHasZarib, CASE WHEN (fldHasZarib = 1) THEN N'بله' ELSE N'خیر' END AS fldHasZaribName, 
                      Com.tblItems_Estekhdam.fldUserId, Com.tblItems_Estekhdam.fldDate, Com.tblItems_Estekhdam.fldDesc, Com.tblItemsHoghughi.fldTitle AS fldTitleItemsHoghughi, 
                      Com.tblAnvaEstekhdam.fldId AS flAnvaEstekhdamId, Com.tblAnvaEstekhdam.fldTitle AS fldAnvaEstekhdamTitle,  CAST(0 AS bit) AS fldMashmul
					  ,N'' as fldNameDefaultTax,cast(0 as bit) as fldMashmoolDefaultTax
FROM         Com.tblItems_Estekhdam INNER JOIN
                      Com.tblItemsHoghughi ON Com.tblItems_Estekhdam.fldItemsHoghughiId = Com.tblItemsHoghughi.fldId INNER JOIN
                      Com.tblTypeEstekhdam ON Com.tblItems_Estekhdam.fldTypeEstekhdamId = Com.tblTypeEstekhdam.fldId INNER JOIN
                      Com.tblAnvaEstekhdam ON Com.tblTypeEstekhdam.fldId = Com.tblAnvaEstekhdam.fldNoeEstekhdamId
		WHERE  Com.tblAnvaEstekhdam.fldTitle like @NoeEstekhdam
	
	if (@fieldname=N'')
	SELECT     TOP (@h) Com.tblItems_Estekhdam.fldId, Com.tblItems_Estekhdam.fldItemsHoghughiId, Com.tblItems_Estekhdam.fldTypeEstekhdamId, 
                      Com.tblItems_Estekhdam.fldTitle, Com.tblItems_Estekhdam.fldHasZarib, CASE WHEN (fldHasZarib = 1) THEN N'بله' ELSE N'خیر' END AS fldHasZaribName, 
                      Com.tblItems_Estekhdam.fldUserId, Com.tblItems_Estekhdam.fldDate, Com.tblItems_Estekhdam.fldDesc, Com.tblItemsHoghughi.fldTitle AS fldTitleItemsHoghughi, 
                      Com.tblAnvaEstekhdam.fldId AS flAnvaEstekhdamId, Com.tblAnvaEstekhdam.fldTitle AS fldAnvaEstekhdamTitle,  CAST(0 AS bit) AS fldMashmul
					  ,N'' as fldNameDefaultTax,cast(0 as bit) as fldMashmoolDefaultTax
FROM         Com.tblItems_Estekhdam INNER JOIN
                      Com.tblItemsHoghughi ON Com.tblItems_Estekhdam.fldItemsHoghughiId = Com.tblItemsHoghughi.fldId INNER JOIN
                      Com.tblTypeEstekhdam ON Com.tblItems_Estekhdam.fldTypeEstekhdamId = Com.tblTypeEstekhdam.fldId INNER JOIN
                      Com.tblAnvaEstekhdam ON Com.tblTypeEstekhdam.fldId = Com.tblAnvaEstekhdam.fldNoeEstekhdamId

	COMMIT
GO
