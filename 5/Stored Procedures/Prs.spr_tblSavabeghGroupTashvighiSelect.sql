SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Prs].[spr_tblSavabeghGroupTashvighiSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@OrganId INT,
	@h int
AS 
	BEGIN TRAN
	if (@h=0) set @h=2147483647
	SET @Value=Com.fn_TextNormalize(@Value)
	if (@fieldname=N'fldId')
SELECT     TOP (@h) tblSavabeghGroupTashvighi.fldId, tblSavabeghGroupTashvighi.fldPersonalId, tblSavabeghGroupTashvighi.fldAnvaGroupId, 
                      tblSavabeghGroupTashvighi.fldTedadGroup, tblSavabeghGroupTashvighi.fldTarikh, tblSavabeghGroupTashvighi.fldUserId, 
                      tblSavabeghGroupTashvighi.fldDesc, tblSavabeghGroupTashvighi.fldDate, tblAnvaGroupTashvighi.fldTitle AS fldAnvaGroupTashvighiTitle
					
FROM         tblSavabeghGroupTashvighi INNER JOIN
                      tblAnvaGroupTashvighi ON tblSavabeghGroupTashvighi.fldAnvaGroupId = tblAnvaGroupTashvighi.fldId
	WHERE  tblSavabeghGroupTashvighi.fldId = @Value  AND Com.fn_OrganId(fldPersonalId)=@OrganId
	
		if (@fieldname=N'fldDesc')
SELECT     TOP (@h) tblSavabeghGroupTashvighi.fldId, tblSavabeghGroupTashvighi.fldPersonalId, tblSavabeghGroupTashvighi.fldAnvaGroupId, 
                      tblSavabeghGroupTashvighi.fldTedadGroup, tblSavabeghGroupTashvighi.fldTarikh, tblSavabeghGroupTashvighi.fldUserId, 
                      tblSavabeghGroupTashvighi.fldDesc, tblSavabeghGroupTashvighi.fldDate, tblAnvaGroupTashvighi.fldTitle AS fldAnvaGroupTashvighiTitle
					
FROM         tblSavabeghGroupTashvighi INNER JOIN
                      tblAnvaGroupTashvighi ON tblSavabeghGroupTashvighi.fldAnvaGroupId = tblAnvaGroupTashvighi.fldId
	WHERE  tblSavabeghGroupTashvighi.fldDesc LIKE @Value 
	

			if (@fieldname=N'CheckPersonalId')
SELECT     TOP (@h) tblSavabeghGroupTashvighi.fldId, tblSavabeghGroupTashvighi.fldPersonalId, tblSavabeghGroupTashvighi.fldAnvaGroupId, 
                      tblSavabeghGroupTashvighi.fldTedadGroup, tblSavabeghGroupTashvighi.fldTarikh, tblSavabeghGroupTashvighi.fldUserId, 
                      tblSavabeghGroupTashvighi.fldDesc, tblSavabeghGroupTashvighi.fldDate, tblAnvaGroupTashvighi.fldTitle AS fldAnvaGroupTashvighiTitle
FROM         tblSavabeghGroupTashvighi INNER JOIN
                      tblAnvaGroupTashvighi ON tblSavabeghGroupTashvighi.fldAnvaGroupId = tblAnvaGroupTashvighi.fldId
	WHERE  tblSavabeghGroupTashvighi.fldPersonalId = @Value
	
		if (@fieldname=N'fldPersonalId')
SELECT     TOP (@h) tblSavabeghGroupTashvighi.fldId, tblSavabeghGroupTashvighi.fldPersonalId, tblSavabeghGroupTashvighi.fldAnvaGroupId, 
                      tblSavabeghGroupTashvighi.fldTedadGroup, tblSavabeghGroupTashvighi.fldTarikh, tblSavabeghGroupTashvighi.fldUserId, 
                      tblSavabeghGroupTashvighi.fldDesc, tblSavabeghGroupTashvighi.fldDate, tblAnvaGroupTashvighi.fldTitle AS fldAnvaGroupTashvighiTitle
FROM         tblSavabeghGroupTashvighi INNER JOIN
                      tblAnvaGroupTashvighi ON tblSavabeghGroupTashvighi.fldAnvaGroupId = tblAnvaGroupTashvighi.fldId
	WHERE  tblSavabeghGroupTashvighi.fldPersonalId = @Value AND Com.fn_OrganId(fldPersonalId)=@OrganId
	
	if (@fieldname=N'CheckAnvaGroupId')
SELECT     TOP (@h) tblSavabeghGroupTashvighi.fldId, tblSavabeghGroupTashvighi.fldPersonalId, tblSavabeghGroupTashvighi.fldAnvaGroupId, 
                      tblSavabeghGroupTashvighi.fldTedadGroup, tblSavabeghGroupTashvighi.fldTarikh, tblSavabeghGroupTashvighi.fldUserId, 
                      tblSavabeghGroupTashvighi.fldDesc, tblSavabeghGroupTashvighi.fldDate, tblAnvaGroupTashvighi.fldTitle AS fldAnvaGroupTashvighiTitle
FROM         tblSavabeghGroupTashvighi INNER JOIN
                      tblAnvaGroupTashvighi ON tblSavabeghGroupTashvighi.fldAnvaGroupId = tblAnvaGroupTashvighi.fldId
	WHERE  tblSavabeghGroupTashvighi.fldAnvaGroupId = @Value 
	
		if (@fieldname=N'fldTedadGroup')
SELECT     TOP (@h) tblSavabeghGroupTashvighi.fldId, tblSavabeghGroupTashvighi.fldPersonalId, tblSavabeghGroupTashvighi.fldAnvaGroupId, 
                      tblSavabeghGroupTashvighi.fldTedadGroup, tblSavabeghGroupTashvighi.fldTarikh, tblSavabeghGroupTashvighi.fldUserId, 
                      tblSavabeghGroupTashvighi.fldDesc, tblSavabeghGroupTashvighi.fldDate, tblAnvaGroupTashvighi.fldTitle AS fldAnvaGroupTashvighiTitle
FROM         tblSavabeghGroupTashvighi INNER JOIN
                      tblAnvaGroupTashvighi ON tblSavabeghGroupTashvighi.fldAnvaGroupId = tblAnvaGroupTashvighi.fldId
	WHERE  tblSavabeghGroupTashvighi.fldTedadGroup LIKE @Value AND Com.fn_OrganId(fldPersonalId)=@OrganId
	
		if (@fieldname=N'fldTarikh')
SELECT     TOP (@h) tblSavabeghGroupTashvighi.fldId, tblSavabeghGroupTashvighi.fldPersonalId, tblSavabeghGroupTashvighi.fldAnvaGroupId, 
                      tblSavabeghGroupTashvighi.fldTedadGroup, tblSavabeghGroupTashvighi.fldTarikh, tblSavabeghGroupTashvighi.fldUserId, 
                      tblSavabeghGroupTashvighi.fldDesc, tblSavabeghGroupTashvighi.fldDate, tblAnvaGroupTashvighi.fldTitle AS fldAnvaGroupTashvighiTitle
FROM         tblSavabeghGroupTashvighi INNER JOIN
                      tblAnvaGroupTashvighi ON tblSavabeghGroupTashvighi.fldAnvaGroupId = tblAnvaGroupTashvighi.fldId
	WHERE  tblSavabeghGroupTashvighi.fldTarikh LIKE @Value AND Com.fn_OrganId(fldPersonalId)=@OrganId
	
		if (@fieldname=N'fldAnvaGroupTashvighiTitle')
SELECT     TOP (@h) tblSavabeghGroupTashvighi.fldId, tblSavabeghGroupTashvighi.fldPersonalId, tblSavabeghGroupTashvighi.fldAnvaGroupId, 
                      tblSavabeghGroupTashvighi.fldTedadGroup, tblSavabeghGroupTashvighi.fldTarikh, tblSavabeghGroupTashvighi.fldUserId, 
                      tblSavabeghGroupTashvighi.fldDesc, tblSavabeghGroupTashvighi.fldDate, tblAnvaGroupTashvighi.fldTitle AS fldAnvaGroupTashvighiTitle
FROM         tblSavabeghGroupTashvighi INNER JOIN
                      tblAnvaGroupTashvighi ON tblSavabeghGroupTashvighi.fldAnvaGroupId = tblAnvaGroupTashvighi.fldId
	WHERE   tblAnvaGroupTashvighi.fldTitle LIKE @Value AND Com.fn_OrganId(fldPersonalId)=@OrganId

	if (@fieldname=N'')
	SELECT     TOP (@h) tblSavabeghGroupTashvighi.fldId, tblSavabeghGroupTashvighi.fldPersonalId, tblSavabeghGroupTashvighi.fldAnvaGroupId, 
                      tblSavabeghGroupTashvighi.fldTedadGroup, tblSavabeghGroupTashvighi.fldTarikh, tblSavabeghGroupTashvighi.fldUserId, 
                      tblSavabeghGroupTashvighi.fldDesc, tblSavabeghGroupTashvighi.fldDate, tblAnvaGroupTashvighi.fldTitle AS fldAnvaGroupTashvighiTitle
FROM         tblSavabeghGroupTashvighi INNER JOIN
                      tblAnvaGroupTashvighi ON tblSavabeghGroupTashvighi.fldAnvaGroupId = tblAnvaGroupTashvighi.fldId
                      where Com.fn_OrganId(fldPersonalId)=@OrganId

IF (@fieldname=N'All')
	SELECT     TOP (@h) tblSavabeghGroupTashvighi.fldId, tblSavabeghGroupTashvighi.fldPersonalId, tblSavabeghGroupTashvighi.fldAnvaGroupId, 
                      tblSavabeghGroupTashvighi.fldTedadGroup, tblSavabeghGroupTashvighi.fldTarikh, tblSavabeghGroupTashvighi.fldUserId, 
                      tblSavabeghGroupTashvighi.fldDesc, tblSavabeghGroupTashvighi.fldDate, tblAnvaGroupTashvighi.fldTitle AS fldAnvaGroupTashvighiTitle
FROM         tblSavabeghGroupTashvighi INNER JOIN
                      tblAnvaGroupTashvighi ON tblSavabeghGroupTashvighi.fldAnvaGroupId = tblAnvaGroupTashvighi.fldId


COMMIT
GO
