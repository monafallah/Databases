SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Prs].[spr_tblDetailPayeSanavatiSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@h int
AS 
	BEGIN TRAN
	if (@h=0) set @h=2147483647
	SET @Value=Com.fn_TextNormalize(@Value)
	if (@fieldname=N'fldId')
	SELECT     TOP (@h) tblDetailPayeSanavati.fldId, tblDetailPayeSanavati.fldPayeSanavatiId, tblDetailPayeSanavati.fldGroh, tblDetailPayeSanavati.fldMablagh, 
                      tblDetailPayeSanavati.fldUserId, tblDetailPayeSanavati.fldDate, tblDetailPayeSanavati.fldDesc, tblPayeSanavati.fldYear
	FROM         prs.tblDetailPayeSanavati INNER JOIN
                       prs.tblPayeSanavati ON tblDetailPayeSanavati.fldPayeSanavatiId = tblPayeSanavati.fldId
	WHERE     (tblDetailPayeSanavati.fldId = @Value)
	order by fldGroh

		if (@fieldname=N'fldDesc')
	SELECT     TOP (@h) tblDetailPayeSanavati.fldId, tblDetailPayeSanavati.fldPayeSanavatiId, tblDetailPayeSanavati.fldGroh, tblDetailPayeSanavati.fldMablagh, 
                      tblDetailPayeSanavati.fldUserId, tblDetailPayeSanavati.fldDate, tblDetailPayeSanavati.fldDesc, tblPayeSanavati.fldYear
	FROM         prs.tblDetailPayeSanavati INNER JOIN
                       prs.tblPayeSanavati ON tblDetailPayeSanavati.fldPayeSanavatiId = tblPayeSanavati.fldId
	WHERE     (tblDetailPayeSanavati.fldDesc = @Value)
	order by fldGroh
	
	if (@fieldname=N'fldYear')
	SELECT     TOP (@h) tblDetailPayeSanavati.fldId, tblDetailPayeSanavati.fldPayeSanavatiId, tblDetailPayeSanavati.fldGroh, tblDetailPayeSanavati.fldMablagh, 
                      tblDetailPayeSanavati.fldUserId, tblDetailPayeSanavati.fldDate, tblDetailPayeSanavati.fldDesc, tblPayeSanavati.fldYear
	FROM         prs.tblDetailPayeSanavati INNER JOIN
                       prs.tblPayeSanavati ON tblDetailPayeSanavati.fldPayeSanavatiId = tblPayeSanavati.fldId 
	WHERE  fldYear = @Value
	order by fldGroh
	
	if (@fieldname=N'fldGroh')
	SELECT     TOP (@h) tblDetailPayeSanavati.fldId, tblDetailPayeSanavati.fldPayeSanavatiId, tblDetailPayeSanavati.fldGroh, tblDetailPayeSanavati.fldMablagh, 
                      tblDetailPayeSanavati.fldUserId, tblDetailPayeSanavati.fldDate, tblDetailPayeSanavati.fldDesc, tblPayeSanavati.fldYear
	FROM         prs.tblDetailPayeSanavati INNER JOIN
                       prs.tblPayeSanavati ON tblDetailPayeSanavati.fldPayeSanavatiId = tblPayeSanavati.fldId 
	WHERE  fldGroh = @Value
	order by fldGroh
	
	if (@fieldname=N'fldPayeSanavatiId')
	SELECT     TOP (@h) tblDetailPayeSanavati.fldId, tblDetailPayeSanavati.fldPayeSanavatiId, tblDetailPayeSanavati.fldGroh, tblDetailPayeSanavati.fldMablagh, 
                      tblDetailPayeSanavati.fldUserId, tblDetailPayeSanavati.fldDate, tblDetailPayeSanavati.fldDesc, tblPayeSanavati.fldYear
	FROM         prs.tblDetailPayeSanavati INNER JOIN
                       prs.tblPayeSanavati ON tblDetailPayeSanavati.fldPayeSanavatiId = tblPayeSanavati.fldId 
	WHERE  fldPayeSanavatiId = @Value
	order by fldGroh

	if (@fieldname=N'')
	SELECT     TOP (@h) tblDetailPayeSanavati.fldId, tblDetailPayeSanavati.fldPayeSanavatiId, tblDetailPayeSanavati.fldGroh, tblDetailPayeSanavati.fldMablagh, 
                      tblDetailPayeSanavati.fldUserId, tblDetailPayeSanavati.fldDate, tblDetailPayeSanavati.fldDesc, tblPayeSanavati.fldYear
	FROM         prs.tblDetailPayeSanavati INNER JOIN
                      prs.tblPayeSanavati ON tblDetailPayeSanavati.fldPayeSanavatiId = tblPayeSanavati.fldId
					  order by fldGroh

	COMMIT
GO
