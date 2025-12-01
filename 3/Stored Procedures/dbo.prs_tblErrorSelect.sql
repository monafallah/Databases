SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[prs_tblErrorSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@h int
AS 
	BEGIN TRAN
	if (@h=0) set @h=2147483647
	if (@fieldname=N'fldId')
	SELECT     TOP (@h) 
    tblError.fldId, tblError.fldMatn, tblError.fldTarikh,  tblError.fldUserId, tblError.fldDesc, tblError.fldDate, dbo.MiladiTOShamsi(tblError.fldDate) 
                      + ' ' + CAST(CAST(tblError.fldDate AS TIME) AS NVARCHAR(8)) AS fldTarikhShamsi, tblAshkhas.fldName+' '+ tblAshkhas.fldFamily AS fldName_Family,tblError.fldInputID
FROM         tblError INNER JOIN
                      tblUser ON tblError.fldUserId = tblUser.fldId INNER JOIN
                      dbo.tblAshkhas ON tblUser.fldShakhsId = tblAshkhas.fldId
                      	WHERE  tblError.fldId = @Value order by fldDate desc

	if (@fieldname=N'fldDesc')
	SELECT     TOP (@h)     tblError.fldId, tblError.fldMatn, tblError.fldTarikh, tblError.fldUserId, tblError.fldDesc, tblError.fldDate, dbo.MiladiTOShamsi(tblError.fldDate) 
                      + ' ' + CAST(CAST(tblError.fldDate AS TIME) AS NVARCHAR(8)) AS fldTarikhShamsi, tblAshkhas.fldName+' '+ tblAshkhas.fldFamily AS fldName_Family,tblError.fldInputID
FROM         tblError INNER JOIN
                      tblUser ON tblError.fldUserId = tblUser.fldId INNER JOIN
                      tblAshkhas ON tblUser.fldShakhsId = tblAshkhas.fldId
                      WHERE tblError.fldDesc like  @Value

	if (@fieldname=N'fldMatn')
	SELECT     TOP (@h)  tblError.fldId, tblError.fldMatn, tblError.fldTarikh, tblError.fldUserId, tblError.fldDesc, tblError.fldDate, dbo.MiladiTOShamsi(tblError.fldDate) 
                      + ' ' + CAST(CAST(tblError.fldDate AS TIME) AS NVARCHAR(8)) AS fldTarikhShamsi, tblAshkhas.fldName+' '+ tblAshkhas.fldFamily AS fldName_Family,tblError.fldInputID
FROM         tblError INNER JOIN
                      tblUser ON tblError.fldUserId = tblUser.fldId INNER JOIN
                      tblAshkhas ON tblUser.fldShakhsId = tblAshkhas.fldId
  WHERE fldMatn like  @Value and tblError.fldDesc='' order by fldDate desc
  
  
  	if (@fieldname=N'fldTarikhShamsi')
	SELECT     TOP (@h)* FROM (

SELECT     tblError.fldId, tblError.fldMatn, tblError.fldTarikh,  tblError.fldUserId, tblError.fldDesc, tblError.fldDate, dbo.MiladiTOShamsi(tblError.fldDate) 
                      + ' ' + CAST(CAST(tblError.fldDate AS TIME) AS NVARCHAR(8)) AS fldTarikhShamsi, tblAshkhas.fldName+' '+ tblAshkhas.fldFamily AS fldName_Family,tblError.fldInputID
FROM         tblError INNER JOIN
                      tblUser ON tblError.fldUserId = tblUser.fldId INNER JOIN
                      tblAshkhas ON tblUser.fldShakhsId = tblAshkhas.fldId)t
  WHERE fldTarikhShamsi like  @Value and fldDesc='' order by fldDate desc
  
  	if (@fieldname=N'fldName_Family')
	SELECT     TOP (@h)* FROM (

SELECT     tblError.fldId, tblError.fldMatn, tblError.fldTarikh,  tblError.fldUserId, tblError.fldDesc, tblError.fldDate, dbo.MiladiTOShamsi(tblError.fldDate) 
                      + ' ' + CAST(CAST(tblError.fldDate AS TIME) AS NVARCHAR(8)) AS fldTarikhShamsi, tblAshkhas.fldName+' '+ tblAshkhas.fldFamily AS fldName_Family,tblError.fldInputID
FROM         tblError INNER JOIN
                      tblUser ON tblError.fldUserId = tblUser.fldId INNER JOIN
                      tblAshkhas ON tblUser.fldShakhsId = tblAshkhas.fldId)t
  WHERE fldName_Family like  @Value and fldDesc='' order by fldDate desc
  

	if (@fieldname=N'')
select top(@h) * from(	

SELECT      tblError.fldId, tblError.fldMatn, tblError.fldTarikh, tblError.fldUserId, tblError.fldDesc, tblError.fldDate, dbo.MiladiTOShamsi(tblError.fldDate) 
                      + ' ' + CAST(CAST(tblError.fldDate AS TIME) AS NVARCHAR(8)) AS fldTarikhShamsi, dbo.tblAshkhas.fldName+' '+ tblAshkhas.fldFamily AS fldName_Family,tblError.fldInputID
FROM         tblError INNER JOIN
                      tblUser ON tblError.fldUserId = tblUser.fldId INNER JOIN
                      tblAshkhas ON tblUser.fldShakhsId = tblAshkhas.fldId)t
					    WHERE fldDesc='' order by fldDate desc
	COMMIT

GO
