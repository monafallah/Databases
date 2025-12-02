SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblCitySelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@h int
AS 
	BEGIN TRAN
	if (@h=0) set @h=2147483647
	SET @Value=Com.fn_TextNormalize(@Value)
	if (@fieldname=N'fldId')
SELECT     TOP (@h) tblCity.fldId, tblCity.fldName, tblCity.fldStateId, tblCity.fldUserId, tblCity.fldDesc, tblCity.fldDate, tblState.fldName AS fldStateName, fldLatitude, fldLongitude
FROM         tblCity INNER JOIN
                      tblState ON tblCity.fldStateId = tblState.fldId
	WHERE  tblCity.fldId = @Value
	ORDER BY tblCity.fldName
	
	if (@fieldname=N'fldStateId')
SELECT     TOP (@h) tblCity.fldId, tblCity.fldName, tblCity.fldStateId, tblCity.fldUserId, tblCity.fldDesc, tblCity.fldDate, tblState.fldName AS fldStateName, fldLatitude, fldLongitude
FROM         tblCity INNER JOIN
                      tblState ON tblCity.fldStateId = tblState.fldId
	WHERE  tblCity.fldStateId = @Value
ORDER BY tblCity.fldName
	if (@fieldname=N'fldName')
SELECT     TOP (@h) tblCity.fldId, tblCity.fldName, tblCity.fldStateId, tblCity.fldUserId, tblCity.fldDesc, tblCity.fldDate, tblState.fldName AS fldStateName, fldLatitude, fldLongitude
FROM         tblCity INNER JOIN
                      tblState ON tblCity.fldStateId = tblState.fldId
	WHERE  tblCity.fldName like @Value
	ORDER BY tblCity.fldName
		if (@fieldname=N'fldStateName')
SELECT     TOP (@h) tblCity.fldId, tblCity.fldName, tblCity.fldStateId, tblCity.fldUserId, tblCity.fldDesc, tblCity.fldDate, tblState.fldName AS fldStateName, fldLatitude, fldLongitude
FROM         tblCity INNER JOIN
                      tblState ON tblCity.fldStateId = tblState.fldId
	WHERE  tblState.fldName like @Value
ORDER BY tblCity.fldName

	if (@fieldname=N'fldDesc')
SELECT     TOP (@h) tblCity.fldId, tblCity.fldName, tblCity.fldStateId, tblCity.fldUserId, tblCity.fldDesc, tblCity.fldDate, tblState.fldName AS fldStateName, fldLatitude, fldLongitude
FROM         tblCity INNER JOIN
                      tblState ON tblCity.fldStateId = tblState.fldId
	WHERE  tblCity.fldDesc like @Value
	ORDER BY tblCity.fldName


	if (@fieldname=N'')
SELECT     TOP (@h) tblCity.fldId, tblCity.fldName, tblCity.fldStateId, tblCity.fldUserId, tblCity.fldDesc, tblCity.fldDate, tblState.fldName AS fldStateName, fldLatitude, fldLongitude
FROM         tblCity INNER JOIN
                      tblState ON tblCity.fldStateId = tblState.fldId
                      ORDER BY tblCity.fldName

	COMMIT
GO
