SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblItems_EstekhdamSelect] 
@fieldname nvarchar(Max),
	@NoeEstekhdam nvarchar(Max),
	@HokmId int,
	@h int
AS 
	BEGIN TRAN
	if (@h=0) set @h=2147483647
	set @NoeEstekhdam= Com.fn_TextNormalize( @NoeEstekhdam)
	if (@fieldname=N'fldId')
	SELECT     TOP (@h) Com.tblItems_Estekhdam.fldId, Com.tblItems_Estekhdam.fldItemsHoghughiId, Com.tblItems_Estekhdam.fldTypeEstekhdamId, 
                      Com.tblItems_Estekhdam.fldTitle, Com.tblItems_Estekhdam.fldHasZarib, CASE WHEN (fldHasZarib = 1) THEN N'بله' ELSE N'خیر' END AS fldHasZaribstring, 
                      Com.tblItems_Estekhdam.fldUserId, Com.tblItems_Estekhdam.fldDate, Com.tblItems_Estekhdam.fldDesc, Com.tblItemsHoghughi.fldTitle AS fldTitleItemsHoghughi,Com.tblTypeEstekhdam.fldTitle AS fldTypeEstekhdamTitle, 
                      
                      ISNULL
                          ((SELECT     fldMablagh
                              FROM         Prs.tblHokm_Item
                              WHERE     (fldItems_EstekhdamId = Com.tblItems_Estekhdam.fldId) AND (fldPersonalHokmId = @HokmId)), 0) AS fldMablagh,
                      ISNULL
                          ((SELECT     fldZarib
                              FROM         Prs.tblHokm_Item AS tblHokm_Item_1
                              WHERE     (fldItems_EstekhdamId = Com.tblItems_Estekhdam.fldId) AND (fldPersonalHokmId = @HokmId) AND (fldPersonalHokmId = @HokmId)), 0) AS fldZarib, 
                      Com.tblItemsHoghughi.fldNameEN
FROM         Com.tblItems_Estekhdam INNER JOIN
                      Com.tblItemsHoghughi ON Com.tblItems_Estekhdam.fldItemsHoghughiId = Com.tblItemsHoghughi.fldId INNER JOIN
                      Com.tblTypeEstekhdam ON Com.tblItems_Estekhdam.fldTypeEstekhdamId = Com.tblTypeEstekhdam.fldId 
		WHERE  Com.tblItems_Estekhdam.fldId = @NoeEstekhdam
	
	if (@fieldname=N'fldTypeEstekhdamId')
	SELECT     TOP (@h) Com.tblItems_Estekhdam.fldId, Com.tblItems_Estekhdam.fldItemsHoghughiId, Com.tblItems_Estekhdam.fldTypeEstekhdamId, 
                      Com.tblItems_Estekhdam.fldTitle, Com.tblItems_Estekhdam.fldHasZarib, CASE WHEN (fldHasZarib = 1) THEN N'بله' ELSE N'خیر' END AS fldHasZaribstring, 
                      Com.tblItems_Estekhdam.fldUserId, Com.tblItems_Estekhdam.fldDate, Com.tblItems_Estekhdam.fldDesc, Com.tblItemsHoghughi.fldTitle AS fldTitleItemsHoghughi, Com.tblTypeEstekhdam.fldTitle AS fldTypeEstekhdamTitle, 
                      ISNULL
                          ((SELECT  top 1   fldMablagh
                              FROM         Prs.tblHokm_Item
                              WHERE     (fldItems_EstekhdamId = Com.tblItems_Estekhdam.fldId) AND (fldPersonalHokmId = @HokmId)), 0) AS fldMablagh, ISNULL
                          ((SELECT  top 1   fldZarib
                              FROM         Prs.tblHokm_Item  as h
							  inner join com.tblItems_Estekhdam as i on i.fldId=h.fldItems_EstekhdamId
                              WHERE     (fldItems_EstekhdamId = Com.tblItems_Estekhdam.fldId or i.fldItemsHoghughiId=tblItemsHoghughi.fldId) AND (fldPersonalHokmId = @HokmId) AND (fldPersonalHokmId = @HokmId)), 0) AS fldZarib, 
                      Com.tblItemsHoghughi.fldNameEN
FROM         Com.tblItems_Estekhdam INNER JOIN
                      Com.tblItemsHoghughi ON Com.tblItems_Estekhdam.fldItemsHoghughiId = Com.tblItemsHoghughi.fldId INNER JOIN
                      Com.tblTypeEstekhdam ON Com.tblItems_Estekhdam.fldTypeEstekhdamId = Com.tblTypeEstekhdam.fldId 
		WHERE     (Com.tblItems_Estekhdam.fldTypeEstekhdamId = @NoeEstekhdam) AND Com.tblItemsHoghughi.fldType=1
		
		if (@fieldname=N'fldNameEN')
select Com.tblItems_Estekhdam.fldId, Com.tblItems_Estekhdam.fldItemsHoghughiId, Com.tblItems_Estekhdam.fldTypeEstekhdamId, 
                      Com.tblItems_Estekhdam.fldTitle, Com.tblItems_Estekhdam.fldHasZarib, CASE WHEN (fldHasZarib = 1) THEN N'بله' ELSE N'خیر' END AS fldHasZaribstring, 
                      Com.tblItems_Estekhdam.fldUserId, Com.tblItems_Estekhdam.fldDate, Com.tblItems_Estekhdam.fldDesc, Com.tblItemsHoghughi.fldTitle AS fldTitleItemsHoghughi,Com.tblTypeEstekhdam.fldTitle  AS fldTypeEstekhdamTitle,
                      ISNULL
                          ((SELECT     fldMablagh
                              FROM         Prs.tblHokm_Item
                              WHERE     (fldItems_EstekhdamId = Com.tblItems_Estekhdam.fldId) AND (fldPersonalHokmId = @HokmId)), 0) AS fldMablagh, ISNULL
                          ((SELECT     fldZarib
                              FROM         Prs.tblHokm_Item AS tblHokm_Item_1
                              WHERE     (fldItems_EstekhdamId = Com.tblItems_Estekhdam.fldId) AND (fldPersonalHokmId = @HokmId) AND (fldPersonalHokmId = @HokmId)), 0) AS fldZarib, 
                      Com.tblItemsHoghughi.fldNameEN
FROM         Com.tblItems_Estekhdam INNER JOIN
                      Com.tblItemsHoghughi ON Com.tblItems_Estekhdam.fldItemsHoghughiId = Com.tblItemsHoghughi.fldId INNER JOIN
                      Com.tblTypeEstekhdam ON Com.tblItems_Estekhdam.fldTypeEstekhdamId = Com.tblTypeEstekhdam.fldId 
		WHERE  fldNameEN  like @NoeEstekhdam 

		if (@fieldname=N'fldTitle')
select Com.tblItems_Estekhdam.fldId, Com.tblItems_Estekhdam.fldItemsHoghughiId, Com.tblItems_Estekhdam.fldTypeEstekhdamId, 
                      Com.tblItems_Estekhdam.fldTitle, Com.tblItems_Estekhdam.fldHasZarib, CASE WHEN (fldHasZarib = 1) THEN N'بله' ELSE N'خیر' END AS fldHasZaribstring, 
                      Com.tblItems_Estekhdam.fldUserId, Com.tblItems_Estekhdam.fldDate, Com.tblItems_Estekhdam.fldDesc, Com.tblItemsHoghughi.fldTitle AS fldTitleItemsHoghughi, Com.tblTypeEstekhdam.fldTitle AS  fldTypeEstekhdamTitle,  
                      
                      ISNULL
                          ((SELECT     fldMablagh
                              FROM         Prs.tblHokm_Item
                              WHERE     (fldItems_EstekhdamId = Com.tblItems_Estekhdam.fldId) AND (fldPersonalHokmId = @HokmId)), 0) AS fldMablagh,
                      ISNULL
                          ((SELECT     fldZarib
                              FROM         Prs.tblHokm_Item AS tblHokm_Item_1
                              WHERE     (fldItems_EstekhdamId = Com.tblItems_Estekhdam.fldId) AND (fldPersonalHokmId = @HokmId) AND (fldPersonalHokmId = @HokmId)), 0) AS fldZarib, 
                      Com.tblItemsHoghughi.fldNameEN
FROM         Com.tblItems_Estekhdam INNER JOIN
                      Com.tblItemsHoghughi ON Com.tblItems_Estekhdam.fldItemsHoghughiId = Com.tblItemsHoghughi.fldId INNER JOIN
                      Com.tblTypeEstekhdam ON Com.tblItems_Estekhdam.fldTypeEstekhdamId = Com.tblTypeEstekhdam.fldId 
		WHERE Com.tblItems_Estekhdam.fldTitle like @NoeEstekhdam
	
		if (@fieldname=N'fldAnvaeEstekhdamId')

select Com.tblItems_Estekhdam.fldId, Com.tblItems_Estekhdam.fldItemsHoghughiId, Com.tblItems_Estekhdam.fldTypeEstekhdamId, 
                      Com.tblItems_Estekhdam.fldTitle, Com.tblItems_Estekhdam.fldHasZarib, CASE WHEN (fldHasZarib = 1) THEN N'بله' ELSE N'خیر' END AS fldHasZaribstring, 
                      Com.tblItems_Estekhdam.fldUserId, Com.tblItems_Estekhdam.fldDate, Com.tblItems_Estekhdam.fldDesc, Com.tblItemsHoghughi.fldTitle AS fldTitleItemsHoghughi, Com.tblTypeEstekhdam.fldTitle AS  fldTypeEstekhdamTitle,  
                      
                      ISNULL
                          ((SELECT     fldMablagh
                              FROM         Prs.tblHokm_Item
                              WHERE     (fldItems_EstekhdamId = Com.tblItems_Estekhdam.fldId) AND (fldPersonalHokmId = @HokmId)), 0) AS fldMablagh,
                      ISNULL
                          ((SELECT     fldZarib
                              FROM         Prs.tblHokm_Item AS tblHokm_Item_1
                              WHERE     (fldItems_EstekhdamId = Com.tblItems_Estekhdam.fldId) AND (fldPersonalHokmId = @HokmId) AND (fldPersonalHokmId = @HokmId)), 0) AS fldZarib, 
                      Com.tblItemsHoghughi.fldNameEN
FROM         Com.tblItems_Estekhdam INNER JOIN
                      Com.tblItemsHoghughi ON Com.tblItems_Estekhdam.fldItemsHoghughiId = Com.tblItemsHoghughi.fldId INNER JOIN
                      Com.tblTypeEstekhdam ON Com.tblItems_Estekhdam.fldTypeEstekhdamId = Com.tblTypeEstekhdam.fldId
		WHERE (Com.tblTypeEstekhdam.fldid = @NoeEstekhdam)
	
	if (@fieldname=N'fldTitleItemsHoghughi')
 select * from(	SELECT     TOP (@h) Com.tblItems_Estekhdam.fldId, Com.tblItems_Estekhdam.fldItemsHoghughiId, Com.tblItems_Estekhdam.fldTypeEstekhdamId, 
                      Com.tblItems_Estekhdam.fldTitle, Com.tblItems_Estekhdam.fldHasZarib, CASE WHEN (fldHasZarib = 1) THEN N'بله' ELSE N'خیر' END AS fldHasZaribstring, 
                      Com.tblItems_Estekhdam.fldUserId, Com.tblItems_Estekhdam.fldDate, Com.tblItems_Estekhdam.fldDesc, Com.tblItemsHoghughi.fldTitle AS fldTitleItemsHoghughi, Com.tblTypeEstekhdam.fldTitle AS fldTypeEstekhdamTitle, 
                      ISNULL
                          ((SELECT     fldMablagh
                              FROM         Prs.tblHokm_Item
                              WHERE     (fldItems_EstekhdamId = Com.tblItems_Estekhdam.fldId) AND (fldPersonalHokmId = @HokmId)), 0) AS fldMablagh, ISNULL
                          ((SELECT     fldZarib
                              FROM         Prs.tblHokm_Item AS tblHokm_Item_1
                              WHERE     (fldItems_EstekhdamId = Com.tblItems_Estekhdam.fldId) AND (fldPersonalHokmId = @HokmId) AND (fldPersonalHokmId = @HokmId)), 0) AS fldZarib, 
                      Com.tblItemsHoghughi.fldNameEN
FROM         Com.tblItems_Estekhdam INNER JOIN
                      Com.tblItemsHoghughi ON Com.tblItems_Estekhdam.fldItemsHoghughiId = Com.tblItemsHoghughi.fldId INNER JOIN
                      Com.tblTypeEstekhdam ON Com.tblItems_Estekhdam.fldTypeEstekhdamId = Com.tblTypeEstekhdam.fldId ) temp
		WHERE     (temp.fldTitleItemsHoghughi like @NoeEstekhdam)
	
		if (@fieldname=N'fldTypeEstekhdamTitle')
 select * from(	SELECT     TOP (@h) Com.tblItems_Estekhdam.fldId, Com.tblItems_Estekhdam.fldItemsHoghughiId, Com.tblItems_Estekhdam.fldTypeEstekhdamId, 
                      Com.tblItems_Estekhdam.fldTitle, Com.tblItems_Estekhdam.fldHasZarib, CASE WHEN (fldHasZarib = 1) THEN N'بله' ELSE N'خیر' END AS fldHasZaribstring, 
                      Com.tblItems_Estekhdam.fldUserId, Com.tblItems_Estekhdam.fldDate, Com.tblItems_Estekhdam.fldDesc, Com.tblItemsHoghughi.fldTitle AS fldTitleItemsHoghughi, Com.tblTypeEstekhdam.fldTitle AS fldTypeEstekhdamTitle, 
                      ISNULL
                          ((SELECT     fldMablagh
                              FROM         Prs.tblHokm_Item
                              WHERE     (fldItems_EstekhdamId = Com.tblItems_Estekhdam.fldId) AND (fldPersonalHokmId = @HokmId)), 0) AS fldMablagh, ISNULL
                          ((SELECT     fldZarib
                              FROM         Prs.tblHokm_Item AS tblHokm_Item_1
                              WHERE     (fldItems_EstekhdamId = Com.tblItems_Estekhdam.fldId) AND (fldPersonalHokmId = @HokmId) AND (fldPersonalHokmId = @HokmId)), 0) AS fldZarib, 
                      Com.tblItemsHoghughi.fldNameEN
FROM         Com.tblItems_Estekhdam INNER JOIN
                      Com.tblItemsHoghughi ON Com.tblItems_Estekhdam.fldItemsHoghughiId = Com.tblItemsHoghughi.fldId INNER JOIN
                      Com.tblTypeEstekhdam ON Com.tblItems_Estekhdam.fldTypeEstekhdamId = Com.tblTypeEstekhdam.fldId ) temp
		WHERE     (temp.fldTypeEstekhdamTitle like @NoeEstekhdam)

		if (@fieldname=N'fldDesc')
	SELECT     TOP (@h) Com.tblItems_Estekhdam.fldId, Com.tblItems_Estekhdam.fldItemsHoghughiId, Com.tblItems_Estekhdam.fldTypeEstekhdamId, 
                      Com.tblItems_Estekhdam.fldTitle, Com.tblItems_Estekhdam.fldHasZarib, CASE WHEN (fldHasZarib = 1) THEN N'بله' ELSE N'خیر' END AS fldHasZaribstring, 
                      Com.tblItems_Estekhdam.fldUserId, Com.tblItems_Estekhdam.fldDate, Com.tblItems_Estekhdam.fldDesc, Com.tblItemsHoghughi.fldTitle AS fldTitleItemsHoghughi,Com.tblTypeEstekhdam.fldTitle AS fldTypeEstekhdamTitle, 
                      
                      ISNULL
                          ((SELECT     fldMablagh
                              FROM         Prs.tblHokm_Item
                              WHERE     (fldItems_EstekhdamId = Com.tblItems_Estekhdam.fldId) AND (fldPersonalHokmId = @HokmId)), 0) AS fldMablagh,
                      ISNULL
                          ((SELECT     fldZarib
                              FROM         Prs.tblHokm_Item AS tblHokm_Item_1
                              WHERE     (fldItems_EstekhdamId = Com.tblItems_Estekhdam.fldId) AND (fldPersonalHokmId = @HokmId) AND (fldPersonalHokmId = @HokmId)), 0) AS fldZarib, 
                      Com.tblItemsHoghughi.fldNameEN
FROM         Com.tblItems_Estekhdam INNER JOIN
                      Com.tblItemsHoghughi ON Com.tblItems_Estekhdam.fldItemsHoghughiId = Com.tblItemsHoghughi.fldId INNER JOIN
                      Com.tblTypeEstekhdam ON Com.tblItems_Estekhdam.fldTypeEstekhdamId = Com.tblTypeEstekhdam.fldId 
		WHERE  Com.tblItems_Estekhdam.fldDesc like @NoeEstekhdam

	if (@fieldname=N'')
	SELECT    TOP (@h) Com.tblItems_Estekhdam.fldId, Com.tblItems_Estekhdam.fldItemsHoghughiId, Com.tblItems_Estekhdam.fldTypeEstekhdamId, 
                      Com.tblItems_Estekhdam.fldTitle, Com.tblItems_Estekhdam.fldHasZarib, CASE WHEN (fldHasZarib = 1) THEN N'بله' ELSE N'خیر' END AS fldHasZaribstring, 
                      Com.tblItems_Estekhdam.fldUserId, Com.tblItems_Estekhdam.fldDate, Com.tblItems_Estekhdam.fldDesc, Com.tblItemsHoghughi.fldTitle AS fldTitleItemsHoghughi, Com.tblTypeEstekhdam.fldTitle AS fldTypeEstekhdamTitle, 
                     
                      ISNULL
                          ((SELECT     fldMablagh
                              FROM         Prs.tblHokm_Item
                              WHERE     (fldItems_EstekhdamId = Com.tblItems_Estekhdam.fldId) AND (fldPersonalHokmId = @HokmId)), 0) AS fldMablagh,
                      ISNULL
                          ((SELECT     fldZarib
                              FROM         Prs.tblHokm_Item AS tblHokm_Item_1
                              WHERE     (fldItems_EstekhdamId = Com.tblItems_Estekhdam.fldId) AND (fldPersonalHokmId = @HokmId) AND (fldPersonalHokmId = @HokmId)), 0) AS fldZarib, 
                      Com.tblItemsHoghughi.fldNameEN
FROM         Com.tblItems_Estekhdam INNER JOIN
                      Com.tblItemsHoghughi ON Com.tblItems_Estekhdam.fldItemsHoghughiId = Com.tblItemsHoghughi.fldId INNER JOIN
                      Com.tblTypeEstekhdam ON Com.tblItems_Estekhdam.fldTypeEstekhdamId = Com.tblTypeEstekhdam.fldId 
		

	COMMIT

GO
