SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblItemsEstekhdam_MoteghayerHoghoghiSelect] 
@fieldname nvarchar(Max),
	@NoeEstekhdam nvarchar(Max),
	@HeaderId int,
	@h int
AS 
	BEGIN TRAN
	if (@h=0) set @h=2147483647
	SET @NoeEstekhdam=Com.fn_TextNormalize(@NoeEstekhdam)
	if (@fieldname=N'fldId')
	SELECT     TOP (@h) Com.tblItems_Estekhdam.fldId, Com.tblItems_Estekhdam.fldItemsHoghughiId, Com.tblItems_Estekhdam.fldTypeEstekhdamId, 
                      Com.tblItems_Estekhdam.fldTitle, Com.tblItems_Estekhdam.fldHasZarib, CASE WHEN (fldHasZarib = 1) THEN N'بله' ELSE N'خیر' END AS fldHasZaribstring, 
                      Com.tblItems_Estekhdam.fldUserId, Com.tblItems_Estekhdam.fldDate, Com.tblItems_Estekhdam.fldDesc, Com.tblItemsHoghughi.fldTitle AS fldTitleItemsHoghughi, 
                     Com.tblAnvaEstekhdam.fldId AS flAnvaeEstekhdamId, Com.tblAnvaEstekhdam.fldTitle AS fldAnvaeEstekhdamTitle,isnull(fldMazayaMashmool,cast (0 as bit)) as fldMazayaMashmool
FROM         Com.tblItems_Estekhdam INNER JOIN
                      Com.tblItemsHoghughi ON Com.tblItems_Estekhdam.fldItemsHoghughiId = Com.tblItemsHoghughi.fldId INNER JOIN
                      Com.tblTypeEstekhdam ON Com.tblItems_Estekhdam.fldTypeEstekhdamId = Com.tblTypeEstekhdam.fldId INNER JOIN
                      Com.tblAnvaEstekhdam ON Com.tblTypeEstekhdam.fldId = Com.tblAnvaEstekhdam.fldNoeEstekhdamId
					  outer apply(select isnull(fldMazayaMashmool,cast (0 as bit)) as fldMazayaMashmool from pay.tblMoteghayerhayeHoghoghi_Detail as m where m.fldMoteghayerhayeHoghoghiId=@HeaderId and m.fldItemEstekhdamId=tblItems_Estekhdam.fldId)m

		WHERE  Com.tblItems_Estekhdam.fldId = @NoeEstekhdam
	
	if (@fieldname=N'fldTypeEstekhdamId')
	SELECT     TOP (@h) Com.tblItems_Estekhdam.fldId, Com.tblItems_Estekhdam.fldItemsHoghughiId, Com.tblItems_Estekhdam.fldTypeEstekhdamId, 
                      Com.tblItems_Estekhdam.fldTitle, Com.tblItems_Estekhdam.fldHasZarib, CASE WHEN (fldHasZarib = 1) THEN N'بله' ELSE N'خیر' END AS fldHasZaribstring, 
                      Com.tblItems_Estekhdam.fldUserId, Com.tblItems_Estekhdam.fldDate, Com.tblItems_Estekhdam.fldDesc, Com.tblItemsHoghughi.fldTitle AS fldTitleItemsHoghughi, 
                     Com.tblAnvaEstekhdam.fldId AS flAnvaeEstekhdamId, Com.tblAnvaEstekhdam.fldTitle AS fldAnvaeEstekhdamTitle,isnull(fldMazayaMashmool,cast (0 as bit)) as fldMazayaMashmool
FROM         Com.tblItems_Estekhdam INNER JOIN
                      Com.tblItemsHoghughi ON Com.tblItems_Estekhdam.fldItemsHoghughiId = Com.tblItemsHoghughi.fldId INNER JOIN
                      Com.tblTypeEstekhdam ON Com.tblItems_Estekhdam.fldTypeEstekhdamId = Com.tblTypeEstekhdam.fldId INNER JOIN
                      Com.tblAnvaEstekhdam ON Com.tblTypeEstekhdam.fldId = Com.tblAnvaEstekhdam.fldNoeEstekhdamId
					  outer apply(select isnull(fldMazayaMashmool,cast (0 as bit)) as fldMazayaMashmool from pay.tblMoteghayerhayeHoghoghi_Detail as m where m.fldMoteghayerhayeHoghoghiId=@HeaderId and m.fldItemEstekhdamId=tblItems_Estekhdam.fldId)m
		WHERE     (Com.tblItems_Estekhdam.fldTypeEstekhdamId = @NoeEstekhdam)

if (@fieldname=N'fldAnvaEstekhdamId')
	SELECT     TOP (@h) Com.tblItems_Estekhdam.fldId, Com.tblItems_Estekhdam.fldItemsHoghughiId, Com.tblItems_Estekhdam.fldTypeEstekhdamId, 
                      Com.tblItems_Estekhdam.fldTitle, Com.tblItems_Estekhdam.fldHasZarib, CASE WHEN (fldHasZarib = 1) THEN N'بله' ELSE N'خیر' END AS fldHasZaribstring, 
                      Com.tblItems_Estekhdam.fldUserId, Com.tblItems_Estekhdam.fldDate, Com.tblItems_Estekhdam.fldDesc, Com.tblItemsHoghughi.fldTitle AS fldTitleItemsHoghughi, 
                     Com.tblAnvaEstekhdam.fldId AS flAnvaeEstekhdamId, Com.tblAnvaEstekhdam.fldTitle AS fldAnvaeEstekhdamTitle,isnull(fldMazayaMashmool,cast (0 as bit)) as fldMazayaMashmool
FROM         Com.tblItems_Estekhdam INNER JOIN
                      Com.tblItemsHoghughi ON Com.tblItems_Estekhdam.fldItemsHoghughiId = Com.tblItemsHoghughi.fldId INNER JOIN
                      Com.tblTypeEstekhdam ON Com.tblItems_Estekhdam.fldTypeEstekhdamId = Com.tblTypeEstekhdam.fldId INNER JOIN
                      Com.tblAnvaEstekhdam ON Com.tblTypeEstekhdam.fldId = Com.tblAnvaEstekhdam.fldNoeEstekhdamId
					  outer apply(select isnull(fldMazayaMashmool,cast (0 as bit)) as fldMazayaMashmool from pay.tblMoteghayerhayeHoghoghi_Detail as m where m.fldMoteghayerhayeHoghoghiId=@HeaderId and m.fldItemEstekhdamId=tblItems_Estekhdam.fldId)m
	WHERE (Com.tblAnvaEstekhdam.fldId=@NoeEstekhdam)
	
	if (@fieldname=N'fldTitle')
	SELECT     TOP (@h) Com.tblItems_Estekhdam.fldId, Com.tblItems_Estekhdam.fldItemsHoghughiId, Com.tblItems_Estekhdam.fldTypeEstekhdamId, 
                      Com.tblItems_Estekhdam.fldTitle, Com.tblItems_Estekhdam.fldHasZarib, CASE WHEN (fldHasZarib = 1) THEN N'بله' ELSE N'خیر' END AS fldHasZaribstring, 
                      Com.tblItems_Estekhdam.fldUserId, Com.tblItems_Estekhdam.fldDate, Com.tblItems_Estekhdam.fldDesc, Com.tblItemsHoghughi.fldTitle AS fldTitleItemsHoghughi, 
                     Com.tblAnvaEstekhdam.fldId AS flAnvaeEstekhdamId, Com.tblAnvaEstekhdam.fldTitle AS fldAnvaeEstekhdamTitle,isnull(fldMazayaMashmool,cast (0 as bit)) as fldMazayaMashmool
FROM         Com.tblItems_Estekhdam INNER JOIN
                      Com.tblItemsHoghughi ON Com.tblItems_Estekhdam.fldItemsHoghughiId = Com.tblItemsHoghughi.fldId INNER JOIN
                      Com.tblTypeEstekhdam ON Com.tblItems_Estekhdam.fldTypeEstekhdamId = Com.tblTypeEstekhdam.fldId INNER JOIN
                      Com.tblAnvaEstekhdam ON Com.tblTypeEstekhdam.fldId = Com.tblAnvaEstekhdam.fldNoeEstekhdamId
					  outer apply(select isnull(fldMazayaMashmool,cast (0 as bit)) as fldMazayaMashmool from pay.tblMoteghayerhayeHoghoghi_Detail as m where m.fldMoteghayerhayeHoghoghiId=@HeaderId and m.fldItemEstekhdamId=tblItems_Estekhdam.fldId)m
		WHERE  Com.tblItems_Estekhdam.fldTitle like @NoeEstekhdam
	
	if (@fieldname=N'')
	SELECT     TOP (@h) Com.tblItems_Estekhdam.fldId, Com.tblItems_Estekhdam.fldItemsHoghughiId, Com.tblItems_Estekhdam.fldTypeEstekhdamId, 
                      Com.tblItems_Estekhdam.fldTitle, Com.tblItems_Estekhdam.fldHasZarib, CASE WHEN (fldHasZarib = 1) THEN N'بله' ELSE N'خیر' END AS fldHasZaribstring, 
                      Com.tblItems_Estekhdam.fldUserId, Com.tblItems_Estekhdam.fldDate, Com.tblItems_Estekhdam.fldDesc, Com.tblItemsHoghughi.fldTitle AS fldTitleItemsHoghughi, 
                     Com.tblAnvaEstekhdam.fldId AS flAnvaeEstekhdamId, Com.tblAnvaEstekhdam.fldTitle AS fldAnvaeEstekhdamTitle,isnull(fldMazayaMashmool,cast (0 as bit)) as fldMazayaMashmool
FROM         Com.tblItems_Estekhdam INNER JOIN
                      Com.tblItemsHoghughi ON Com.tblItems_Estekhdam.fldItemsHoghughiId = Com.tblItemsHoghughi.fldId INNER JOIN
                      Com.tblTypeEstekhdam ON Com.tblItems_Estekhdam.fldTypeEstekhdamId = Com.tblTypeEstekhdam.fldId INNER JOIN
                      Com.tblAnvaEstekhdam ON Com.tblTypeEstekhdam.fldId = Com.tblAnvaEstekhdam.fldNoeEstekhdamId
					  outer apply(select isnull(fldMazayaMashmool,cast (0 as bit)) as fldMazayaMashmool from pay.tblMoteghayerhayeHoghoghi_Detail as m where m.fldMoteghayerhayeHoghoghiId=@HeaderId and m.fldItemEstekhdamId=tblItems_Estekhdam.fldId)m

	COMMIT
GO
