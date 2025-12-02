SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Prs].[spr_tblHokmReportSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@h int
AS 
	BEGIN TRAN
	if (@h=0) set @h=2147483647
	SET @Value=Com.fn_TextNormalize(@Value)
			if (@fieldname=N'fldId')
	SELECT     TOP (@h) tblHokmReport.fldId, tblHokmReport.fldName, tblHokmReport.fldFileId, tblHokmReport.fldAnvaEstekhdamId, tblHokmReport.fldUserId, 
                      tblHokmReport.fldDesc, tblHokmReport.fldDate, Com.tblAnvaEstekhdam.fldTitle AS fldAnvaEstekhdamName
FROM         tblHokmReport INNER JOIN
                      Com.tblAnvaEstekhdam ON tblHokmReport.fldAnvaEstekhdamId = Com.tblAnvaEstekhdam.fldId
	WHERE  tblHokmReport.fldId = @Value

	if (@fieldname=N'fldDesc')
	SELECT     TOP (@h) tblHokmReport.fldId, tblHokmReport.fldName, tblHokmReport.fldFileId, tblHokmReport.fldAnvaEstekhdamId, tblHokmReport.fldUserId, 
                      tblHokmReport.fldDesc, tblHokmReport.fldDate, Com.tblAnvaEstekhdam.fldTitle AS fldAnvaEstekhdamName
FROM         tblHokmReport INNER JOIN
                      Com.tblAnvaEstekhdam ON tblHokmReport.fldAnvaEstekhdamId = Com.tblAnvaEstekhdam.fldId
	WHERE  tblHokmReport.fldDesc LIKE @Value
	

		if (@fieldname=N'fldAnvaEstekhdamId')
	SELECT     TOP (@h) tblHokmReport.fldId, tblHokmReport.fldName, tblHokmReport.fldFileId, tblHokmReport.fldAnvaEstekhdamId, tblHokmReport.fldUserId, 
                      tblHokmReport.fldDesc, tblHokmReport.fldDate, Com.tblAnvaEstekhdam.fldTitle AS fldAnvaEstekhdamName
FROM         tblHokmReport INNER JOIN
                      Com.tblAnvaEstekhdam ON tblHokmReport.fldAnvaEstekhdamId = Com.tblAnvaEstekhdam.fldId
	WHERE  tblHokmReport.fldAnvaEstekhdamId = @Value

	if (@fieldname=N'fldAnvaEstekhdamName')
	SELECT     TOP (@h) tblHokmReport.fldId, tblHokmReport.fldName, tblHokmReport.fldFileId, tblHokmReport.fldAnvaEstekhdamId, tblHokmReport.fldUserId, 
                      tblHokmReport.fldDesc, tblHokmReport.fldDate, Com.tblAnvaEstekhdam.fldTitle AS fldAnvaEstekhdamName
FROM         tblHokmReport INNER JOIN
                      Com.tblAnvaEstekhdam ON tblHokmReport.fldAnvaEstekhdamId = Com.tblAnvaEstekhdam.fldId
	WHERE  Com.tblAnvaEstekhdam.fldTitle LIKE @Value
	
	if (@fieldname=N'fldName')
	SELECT     TOP (@h) tblHokmReport.fldId, tblHokmReport.fldName, tblHokmReport.fldFileId, tblHokmReport.fldAnvaEstekhdamId, tblHokmReport.fldUserId, 
                      tblHokmReport.fldDesc, tblHokmReport.fldDate, Com.tblAnvaEstekhdam.fldTitle AS fldAnvaEstekhdamName
FROM         tblHokmReport INNER JOIN
                      Com.tblAnvaEstekhdam ON tblHokmReport.fldAnvaEstekhdamId = Com.tblAnvaEstekhdam.fldId
	WHERE  fldName LIKE @Value

	if (@fieldname=N'')
	SELECT     TOP (@h) tblHokmReport.fldId, tblHokmReport.fldName, tblHokmReport.fldFileId, tblHokmReport.fldAnvaEstekhdamId, tblHokmReport.fldUserId, 
                      tblHokmReport.fldDesc, tblHokmReport.fldDate, Com.tblAnvaEstekhdam.fldTitle AS fldAnvaEstekhdamName
FROM         tblHokmReport INNER JOIN
                      Com.tblAnvaEstekhdam ON tblHokmReport.fldAnvaEstekhdamId = Com.tblAnvaEstekhdam.fldId

	COMMIT
GO
