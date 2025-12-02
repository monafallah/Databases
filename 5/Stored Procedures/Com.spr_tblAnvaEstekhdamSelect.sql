SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblAnvaEstekhdamSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@h int
AS 
	BEGIN TRAN
	if (@h=0) set @h=2147483647
	SET @value =Com.fn_TextNormalize(@value)
	if (@fieldname=N'fldId')
SELECT     TOP (@h) Com.tblAnvaEstekhdam.fldId, Com.tblAnvaEstekhdam.fldTitle, Com.tblAnvaEstekhdam.fldNoeEstekhdamId, Com.tblAnvaEstekhdam.fldUserId, 
                      Com.tblAnvaEstekhdam.fldDesc, Com.tblAnvaEstekhdam.fldDate, Com.tblTypeEstekhdam.fldTitle AS fldTitleNoeEstekhdam,fldPatternNoeEstekhdamId
					  ,t.fldTitlePattern,fldTypeEstekhdamFormul
FROM         Com.tblAnvaEstekhdam INNER JOIN
                     Com.tblTypeEstekhdam ON Com.tblAnvaEstekhdam.fldNoeEstekhdamId = Com.tblTypeEstekhdam.fldId
					 outer apply(select a.fldTitle as fldTitlePattern  from Com.tblAnvaEstekhdam as a 
								where a.fldId=tblAnvaEstekhdam.fldPatternNoeEstekhdamId)t
	WHERE  Com.tblAnvaEstekhdam.fldId = @Value

		if (@fieldname=N'fldNoeEstekhdamId')
SELECT     TOP (@h) Com.tblAnvaEstekhdam.fldId, Com.tblAnvaEstekhdam.fldTitle, Com.tblAnvaEstekhdam.fldNoeEstekhdamId, Com.tblAnvaEstekhdam.fldUserId, 
                      Com.tblAnvaEstekhdam.fldDesc, Com.tblAnvaEstekhdam.fldDate, Com.tblTypeEstekhdam.fldTitle AS fldTitleNoeEstekhdam,fldPatternNoeEstekhdamId
					  ,t.fldTitlePattern,fldTypeEstekhdamFormul
FROM         Com.tblAnvaEstekhdam INNER JOIN
                     Com.tblTypeEstekhdam ON Com.tblAnvaEstekhdam.fldNoeEstekhdamId = Com.tblTypeEstekhdam.fldId
					 outer apply(select a.fldTitle as fldTitlePattern  from Com.tblAnvaEstekhdam as a
								where a.fldId=tblAnvaEstekhdam.fldPatternNoeEstekhdamId)t
	WHERE  Com.tblAnvaEstekhdam.fldNoeEstekhdamId = @Value
	
		if (@fieldname=N'fldTitle')
SELECT     TOP (@h) Com.tblAnvaEstekhdam.fldId, Com.tblAnvaEstekhdam.fldTitle, Com.tblAnvaEstekhdam.fldNoeEstekhdamId, Com.tblAnvaEstekhdam.fldUserId, 
                      Com.tblAnvaEstekhdam.fldDesc, Com.tblAnvaEstekhdam.fldDate, Com.tblTypeEstekhdam.fldTitle AS fldTitleNoeEstekhdam,fldPatternNoeEstekhdamId
					  ,t.fldTitlePattern,fldTypeEstekhdamFormul
FROM         Com.tblAnvaEstekhdam INNER JOIN
                     Com.tblTypeEstekhdam ON Com.tblAnvaEstekhdam.fldNoeEstekhdamId = Com.tblTypeEstekhdam.fldId
					 outer apply(select a.fldTitle as fldTitlePattern  from Com.tblAnvaEstekhdam as a 
								where a.fldId=tblAnvaEstekhdam.fldPatternNoeEstekhdamId)t
	WHERE  Com.tblAnvaEstekhdam.fldTitle LIKE @Value
	
			if (@fieldname=N'fldTitleNoeEstekhdam')
SELECT     TOP (@h) Com.tblAnvaEstekhdam.fldId, Com.tblAnvaEstekhdam.fldTitle, Com.tblAnvaEstekhdam.fldNoeEstekhdamId, Com.tblAnvaEstekhdam.fldUserId, 
                      Com.tblAnvaEstekhdam.fldDesc, Com.tblAnvaEstekhdam.fldDate, Com.tblTypeEstekhdam.fldTitle AS fldTitleNoeEstekhdam,fldPatternNoeEstekhdamId
					  ,t.fldTitlePattern,fldTypeEstekhdamFormul
FROM         Com.tblAnvaEstekhdam INNER JOIN
                     Com.tblTypeEstekhdam ON Com.tblAnvaEstekhdam.fldNoeEstekhdamId = Com.tblTypeEstekhdam.fldId
					 outer apply(select a.fldTitle as fldTitlePattern  from Com.tblAnvaEstekhdam as a
								where a.fldId=tblAnvaEstekhdam.fldPatternNoeEstekhdamId)t
	WHERE  Com.tblTypeEstekhdam.fldTitle LIKE @Value

		if (@fieldname=N'fldDesc')
SELECT     TOP (@h) Com.tblAnvaEstekhdam.fldId, Com.tblAnvaEstekhdam.fldTitle, Com.tblAnvaEstekhdam.fldNoeEstekhdamId, Com.tblAnvaEstekhdam.fldUserId, 
                      Com.tblAnvaEstekhdam.fldDesc, Com.tblAnvaEstekhdam.fldDate, Com.tblTypeEstekhdam.fldTitle AS fldTitleNoeEstekhdam,fldPatternNoeEstekhdamId
					  ,t.fldTitlePattern,fldTypeEstekhdamFormul
FROM         Com.tblAnvaEstekhdam INNER JOIN
                     Com.tblTypeEstekhdam ON Com.tblAnvaEstekhdam.fldNoeEstekhdamId = Com.tblTypeEstekhdam.fldId
					 outer apply(select a.fldTitle as fldTitlePattern  from Com.tblAnvaEstekhdam as a 
								where a.fldId=tblAnvaEstekhdam.fldPatternNoeEstekhdamId)t
	WHERE  Com.tblAnvaEstekhdam.fldDesc like @Value

			if (@fieldname=N'fldIsPattern')
SELECT     TOP (@h) Com.tblAnvaEstekhdam.fldId, Com.tblAnvaEstekhdam.fldTitle, Com.tblAnvaEstekhdam.fldNoeEstekhdamId, Com.tblAnvaEstekhdam.fldUserId, 
                      Com.tblAnvaEstekhdam.fldDesc, Com.tblAnvaEstekhdam.fldDate, Com.tblTypeEstekhdam.fldTitle AS fldTitleNoeEstekhdam,fldPatternNoeEstekhdamId
					  ,t.fldTitlePattern,fldTypeEstekhdamFormul
FROM         Com.tblAnvaEstekhdam INNER JOIN
                     Com.tblTypeEstekhdam ON Com.tblAnvaEstekhdam.fldNoeEstekhdamId = Com.tblTypeEstekhdam.fldId
					 outer apply(select a.fldTitle as fldTitlePattern  from Com.tblAnvaEstekhdam as a 
								where a.fldId=tblAnvaEstekhdam.fldPatternNoeEstekhdamId)t
	WHERE  Com.tblAnvaEstekhdam.fldIsPattern =1

	if (@fieldname=N'fldTitlePattern')
SELECT     TOP (@h) Com.tblAnvaEstekhdam.fldId, Com.tblAnvaEstekhdam.fldTitle, Com.tblAnvaEstekhdam.fldNoeEstekhdamId, Com.tblAnvaEstekhdam.fldUserId, 
                      Com.tblAnvaEstekhdam.fldDesc, Com.tblAnvaEstekhdam.fldDate, Com.tblTypeEstekhdam.fldTitle AS fldTitleNoeEstekhdam,fldPatternNoeEstekhdamId
					  ,t.fldTitlePattern,fldTypeEstekhdamFormul
FROM         Com.tblAnvaEstekhdam INNER JOIN
                     Com.tblTypeEstekhdam ON Com.tblAnvaEstekhdam.fldNoeEstekhdamId = Com.tblTypeEstekhdam.fldId
					 outer apply(select a.fldTitle as fldTitlePattern  from Com.tblAnvaEstekhdam as a 
								where a.fldId=tblAnvaEstekhdam.fldPatternNoeEstekhdamId)t
	WHERE t.fldTitlePattern  like @Value

	if (@fieldname=N'fldPatternNoeEstekhdamId')
SELECT     TOP (@h) Com.tblAnvaEstekhdam.fldId, Com.tblAnvaEstekhdam.fldTitle, Com.tblAnvaEstekhdam.fldNoeEstekhdamId, Com.tblAnvaEstekhdam.fldUserId, 
                      Com.tblAnvaEstekhdam.fldDesc, Com.tblAnvaEstekhdam.fldDate, Com.tblTypeEstekhdam.fldTitle AS fldTitleNoeEstekhdam,fldPatternNoeEstekhdamId
					  ,t.fldTitlePattern,fldTypeEstekhdamFormul
FROM         Com.tblAnvaEstekhdam INNER JOIN
                     Com.tblTypeEstekhdam ON Com.tblAnvaEstekhdam.fldNoeEstekhdamId = Com.tblTypeEstekhdam.fldId
					 outer apply(select a.fldTitle as fldTitlePattern  from Com.tblAnvaEstekhdam as a 
								where a.fldId=tblAnvaEstekhdam.fldPatternNoeEstekhdamId)t
	WHERE fldPatternNoeEstekhdamId  = @Value

	if (@fieldname=N'')
SELECT     TOP (@h) Com.tblAnvaEstekhdam.fldId, Com.tblAnvaEstekhdam.fldTitle, Com.tblAnvaEstekhdam.fldNoeEstekhdamId, Com.tblAnvaEstekhdam.fldUserId, 
                      Com.tblAnvaEstekhdam.fldDesc, Com.tblAnvaEstekhdam.fldDate, Com.tblTypeEstekhdam.fldTitle AS fldTitleNoeEstekhdam,fldPatternNoeEstekhdamId
					  ,t.fldTitlePattern,fldTypeEstekhdamFormul
FROM         Com.tblAnvaEstekhdam INNER JOIN
                     Com.tblTypeEstekhdam ON Com.tblAnvaEstekhdam.fldNoeEstekhdamId = Com.tblTypeEstekhdam.fldId
					 outer apply(select a.fldTitle as fldTitlePattern  from Com.tblAnvaEstekhdam as a 
								where a.fldId=tblAnvaEstekhdam.fldPatternNoeEstekhdamId)t
	COMMIT
GO
