SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Prs].[spr_tblDetailHoghoghMabnaSelect] 
	@fieldname nvarchar(50),
	
	@Value nvarchar(50),
		@Type bit,
	@h int
AS 
	BEGIN TRAN
	SET @Value=Com.fn_TextNormalize(@Value)
	if (@h=0) set @h=2147483647
	if (@fieldname=N'fldId')
	SELECT     TOP (@h) tblDetailHoghoghMabna.fldId, tblDetailHoghoghMabna.fldHoghoghMabnaId, tblDetailHoghoghMabna.fldGroh, 
                      tblDetailHoghoghMabna.fldMablagh, tblDetailHoghoghMabna.fldUserId, tblDetailHoghoghMabna.fldDate, tblDetailHoghoghMabna.fldDesc, 
                      tblHoghoghMabna.fldType, tblHoghoghMabna.fldYear
	FROM         tblDetailHoghoghMabna INNER JOIN
                      tblHoghoghMabna ON tblDetailHoghoghMabna.fldHoghoghMabnaId = tblHoghoghMabna.fldId
	WHERE     (tblDetailHoghoghMabna.fldId = @Value)
	order by fldGroh


		if (@fieldname=N'fldDesc')
	SELECT     TOP (@h) tblDetailHoghoghMabna.fldId, tblDetailHoghoghMabna.fldHoghoghMabnaId, tblDetailHoghoghMabna.fldGroh, 
                      tblDetailHoghoghMabna.fldMablagh, tblDetailHoghoghMabna.fldUserId, tblDetailHoghoghMabna.fldDate, tblDetailHoghoghMabna.fldDesc, 
                      tblHoghoghMabna.fldType, tblHoghoghMabna.fldYear
	FROM         tblDetailHoghoghMabna INNER JOIN
                      tblHoghoghMabna ON tblDetailHoghoghMabna.fldHoghoghMabnaId = tblHoghoghMabna.fldId
	WHERE    tblDetailHoghoghMabna.fldDesc LIKE @Value
	order by fldGroh

	if (@fieldname=N'fldHoghoghMabnaId')
	SELECT     TOP (@h) tblDetailHoghoghMabna.fldId, tblDetailHoghoghMabna.fldHoghoghMabnaId, tblDetailHoghoghMabna.fldGroh, 
                      tblDetailHoghoghMabna.fldMablagh, tblDetailHoghoghMabna.fldUserId, tblDetailHoghoghMabna.fldDate, tblDetailHoghoghMabna.fldDesc, 
                      tblHoghoghMabna.fldType, tblHoghoghMabna.fldYear
	FROM         tblDetailHoghoghMabna INNER JOIN
                      tblHoghoghMabna ON tblDetailHoghoghMabna.fldHoghoghMabnaId = tblHoghoghMabna.fldId
	WHERE     (tblDetailHoghoghMabna.fldHoghoghMabnaId = @Value)
	order by fldGroh

	
	if (@fieldname=N'fldYear_Type')
	SELECT     TOP (@h) tblDetailHoghoghMabna.fldId, tblDetailHoghoghMabna.fldHoghoghMabnaId, tblDetailHoghoghMabna.fldGroh, 
                      tblDetailHoghoghMabna.fldMablagh, tblDetailHoghoghMabna.fldUserId, tblDetailHoghoghMabna.fldDate, tblDetailHoghoghMabna.fldDesc, 
                      tblHoghoghMabna.fldType, tblHoghoghMabna.fldYear
	FROM         tblDetailHoghoghMabna INNER JOIN
                      tblHoghoghMabna ON tblDetailHoghoghMabna.fldHoghoghMabnaId = tblHoghoghMabna.fldId
	WHERE     (tblHoghoghMabna.fldYear = @Value and tblHoghoghMabna.fldType=@Type)
	order by fldGroh


	if (@fieldname=N'fldGroh_Type')
	SELECT     TOP (@h) tblDetailHoghoghMabna.fldId, tblDetailHoghoghMabna.fldHoghoghMabnaId, tblDetailHoghoghMabna.fldGroh, 
                      tblDetailHoghoghMabna.fldMablagh, tblDetailHoghoghMabna.fldUserId, tblDetailHoghoghMabna.fldDate, tblDetailHoghoghMabna.fldDesc, 
                      tblHoghoghMabna.fldType, tblHoghoghMabna.fldYear
	FROM         tblDetailHoghoghMabna INNER JOIN
                      tblHoghoghMabna ON tblDetailHoghoghMabna.fldHoghoghMabnaId = tblHoghoghMabna.fldId
	WHERE     (tblDetailHoghoghMabna.fldGroh = @Value and tblHoghoghMabna.fldType=@Type)
	order by fldGroh


	if (@fieldname=N'')
	SELECT     TOP (@h) tblDetailHoghoghMabna.fldId, tblDetailHoghoghMabna.fldHoghoghMabnaId, tblDetailHoghoghMabna.fldGroh, 
                      tblDetailHoghoghMabna.fldMablagh, tblDetailHoghoghMabna.fldUserId, tblDetailHoghoghMabna.fldDate, tblDetailHoghoghMabna.fldDesc, 
                      tblHoghoghMabna.fldType, tblHoghoghMabna.fldYear
	FROM         tblDetailHoghoghMabna INNER JOIN
                      tblHoghoghMabna ON tblDetailHoghoghMabna.fldHoghoghMabnaId = tblHoghoghMabna.fldId
order by fldGroh
	COMMIT
GO
