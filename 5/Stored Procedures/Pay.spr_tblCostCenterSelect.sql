SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblCostCenterSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@Value2 nvarchar(50),
	@h int
AS 
	BEGIN TRAN
	if (@h=0) set @h=2147483647
	SET @Value=Com.fn_TextNormalize(@value)
	if (@fieldname=N'fldId')
	SELECT     TOP (@h) Pay.tblCostCenter.fldId, Pay.tblCostCenter.fldTitle, Pay.tblCostCenter.fldReportTypeId, Pay.tblCostCenter.fldTypeOfCostCenterId, 
                      Pay.tblCostCenter.fldEmploymentCenterId, Pay.tblCostCenter.fldUserId, Pay.tblCostCenter.fldDate, Pay.tblCostCenter.fldDesc, 
                      Pay.tblReportType.fldName AS fldReportTypeName, Pay.tblTypeOfEmploymentCenter.fldTitle AS EmploymentName, 
                      Pay.tblTypeOfCostCenters.fldTitle AS TypecenterTitle,fldorganid
FROM         Pay.tblCostCenter INNER JOIN
                      Pay.tblReportType ON Pay.tblCostCenter.fldReportTypeId = Pay.tblReportType.fldId INNER JOIN
                      Pay.tblTypeOfCostCenters ON Pay.tblCostCenter.fldTypeOfCostCenterId = Pay.tblTypeOfCostCenters.fldId INNER JOIN
                      Pay.tblTypeOfEmploymentCenter ON Pay.tblCostCenter.fldEmploymentCenterId = Pay.tblTypeOfEmploymentCenter.fldId
	where Pay.tblCostCenter.fldId=@Value
	
	if (@fieldname=N'fldEmploymentCenterId')
	SELECT     TOP (@h) Pay.tblCostCenter.fldId, Pay.tblCostCenter.fldTitle, Pay.tblCostCenter.fldReportTypeId, Pay.tblCostCenter.fldTypeOfCostCenterId, 
                      Pay.tblCostCenter.fldEmploymentCenterId, Pay.tblCostCenter.fldUserId, Pay.tblCostCenter.fldDate, Pay.tblCostCenter.fldDesc, 
                      Pay.tblReportType.fldName AS fldReportTypeName, Pay.tblTypeOfEmploymentCenter.fldTitle AS EmploymentName, 
                      Pay.tblTypeOfCostCenters.fldTitle AS TypecenterTitle,fldorganid
FROM         Pay.tblCostCenter INNER JOIN
                      Pay.tblReportType ON Pay.tblCostCenter.fldReportTypeId = Pay.tblReportType.fldId INNER JOIN
                      Pay.tblTypeOfCostCenters ON Pay.tblCostCenter.fldTypeOfCostCenterId = Pay.tblTypeOfCostCenters.fldId INNER JOIN
                      Pay.tblTypeOfEmploymentCenter ON Pay.tblCostCenter.fldEmploymentCenterId = Pay.tblTypeOfEmploymentCenter.fldId
	where Pay.tblCostCenter.fldEmploymentCenterId=@Value
	
	if (@fieldname=N'fldTypeOfCostCenterId')
	SELECT     TOP (@h) Pay.tblCostCenter.fldId, Pay.tblCostCenter.fldTitle, Pay.tblCostCenter.fldReportTypeId, Pay.tblCostCenter.fldTypeOfCostCenterId, 
                      Pay.tblCostCenter.fldEmploymentCenterId, Pay.tblCostCenter.fldUserId, Pay.tblCostCenter.fldDate, Pay.tblCostCenter.fldDesc, 
                      Pay.tblReportType.fldName AS fldReportTypeName, Pay.tblTypeOfEmploymentCenter.fldTitle AS EmploymentName, 
                      Pay.tblTypeOfCostCenters.fldTitle AS TypecenterTitle,fldorganid
FROM         Pay.tblCostCenter INNER JOIN
                      Pay.tblReportType ON Pay.tblCostCenter.fldReportTypeId = Pay.tblReportType.fldId INNER JOIN
                      Pay.tblTypeOfCostCenters ON Pay.tblCostCenter.fldTypeOfCostCenterId = Pay.tblTypeOfCostCenters.fldId INNER JOIN
                      Pay.tblTypeOfEmploymentCenter ON Pay.tblCostCenter.fldEmploymentCenterId = Pay.tblTypeOfEmploymentCenter.fldId
	where Pay.tblCostCenter.fldTypeOfCostCenterId=@Value
	
	if (@fieldname=N'fldTitle')
	SELECT     TOP (@h) Pay.tblCostCenter.fldId, Pay.tblCostCenter.fldTitle, Pay.tblCostCenter.fldReportTypeId, Pay.tblCostCenter.fldTypeOfCostCenterId, 
                      Pay.tblCostCenter.fldEmploymentCenterId, Pay.tblCostCenter.fldUserId, Pay.tblCostCenter.fldDate, Pay.tblCostCenter.fldDesc, 
                      Pay.tblReportType.fldName AS fldReportTypeName, Pay.tblTypeOfEmploymentCenter.fldTitle AS EmploymentName, 
                      Pay.tblTypeOfCostCenters.fldTitle AS TypecenterTitle,fldorganid
FROM         Pay.tblCostCenter INNER JOIN
                      Pay.tblReportType ON Pay.tblCostCenter.fldReportTypeId = Pay.tblReportType.fldId INNER JOIN
                      Pay.tblTypeOfCostCenters ON Pay.tblCostCenter.fldTypeOfCostCenterId = Pay.tblTypeOfCostCenters.fldId INNER JOIN
                      Pay.tblTypeOfEmploymentCenter ON Pay.tblCostCenter.fldEmploymentCenterId = Pay.tblTypeOfEmploymentCenter.fldId
	where Pay.tblCostCenter.fldTitle like @Value and fldOrganId=@Value2
	
	if (@fieldname=N'TypecenterTitle')
	SELECT     TOP (@h) Pay.tblCostCenter.fldId, Pay.tblCostCenter.fldTitle, Pay.tblCostCenter.fldReportTypeId, Pay.tblCostCenter.fldTypeOfCostCenterId, 
                      Pay.tblCostCenter.fldEmploymentCenterId, Pay.tblCostCenter.fldUserId, Pay.tblCostCenter.fldDate, Pay.tblCostCenter.fldDesc, 
                      Pay.tblReportType.fldName AS fldReportTypeName, Pay.tblTypeOfEmploymentCenter.fldTitle AS EmploymentName, 
                      Pay.tblTypeOfCostCenters.fldTitle AS TypecenterTitle,fldorganid
FROM         Pay.tblCostCenter INNER JOIN
                      Pay.tblReportType ON Pay.tblCostCenter.fldReportTypeId = Pay.tblReportType.fldId INNER JOIN
                      Pay.tblTypeOfCostCenters ON Pay.tblCostCenter.fldTypeOfCostCenterId = Pay.tblTypeOfCostCenters.fldId INNER JOIN
                      Pay.tblTypeOfEmploymentCenter ON Pay.tblCostCenter.fldEmploymentCenterId = Pay.tblTypeOfEmploymentCenter.fldId
	where Pay.tblTypeOfCostCenters.fldTitle like @Value and fldOrganId=@Value2
	
	if (@fieldname=N'EmploymentName')
	SELECT     TOP (@h) Pay.tblCostCenter.fldId, Pay.tblCostCenter.fldTitle, Pay.tblCostCenter.fldReportTypeId, Pay.tblCostCenter.fldTypeOfCostCenterId, 
                      Pay.tblCostCenter.fldEmploymentCenterId, Pay.tblCostCenter.fldUserId, Pay.tblCostCenter.fldDate, Pay.tblCostCenter.fldDesc, 
                      Pay.tblReportType.fldName AS fldReportTypeName, Pay.tblTypeOfEmploymentCenter.fldTitle AS EmploymentName, 
                      Pay.tblTypeOfCostCenters.fldTitle AS TypecenterTitle,fldorganid
FROM         Pay.tblCostCenter INNER JOIN
                      Pay.tblReportType ON Pay.tblCostCenter.fldReportTypeId = Pay.tblReportType.fldId INNER JOIN
                      Pay.tblTypeOfCostCenters ON Pay.tblCostCenter.fldTypeOfCostCenterId = Pay.tblTypeOfCostCenters.fldId INNER JOIN
                      Pay.tblTypeOfEmploymentCenter ON Pay.tblCostCenter.fldEmploymentCenterId = Pay.tblTypeOfEmploymentCenter.fldId
	where Pay.tblTypeOfEmploymentCenter.fldTitle like @Value and fldOrganId=@Value2
	
	if (@fieldname=N'fldReportTypeName')
	SELECT     TOP (@h) Pay.tblCostCenter.fldId, Pay.tblCostCenter.fldTitle, Pay.tblCostCenter.fldReportTypeId, Pay.tblCostCenter.fldTypeOfCostCenterId, 
                      Pay.tblCostCenter.fldEmploymentCenterId, Pay.tblCostCenter.fldUserId, Pay.tblCostCenter.fldDate, Pay.tblCostCenter.fldDesc, 
                      Pay.tblReportType.fldName AS fldReportTypeName, Pay.tblTypeOfEmploymentCenter.fldTitle AS EmploymentName, 
                      Pay.tblTypeOfCostCenters.fldTitle AS TypecenterTitle,fldorganid
FROM         Pay.tblCostCenter INNER JOIN
                      Pay.tblReportType ON Pay.tblCostCenter.fldReportTypeId = Pay.tblReportType.fldId INNER JOIN
                      Pay.tblTypeOfCostCenters ON Pay.tblCostCenter.fldTypeOfCostCenterId = Pay.tblTypeOfCostCenters.fldId INNER JOIN
                      Pay.tblTypeOfEmploymentCenter ON Pay.tblCostCenter.fldEmploymentCenterId = Pay.tblTypeOfEmploymentCenter.fldId
	where Pay.tblReportType.fldName like @Value and fldOrganId=@Value2

	if (@fieldname=N'fldDesc')
	SELECT     TOP (@h) Pay.tblCostCenter.fldId, Pay.tblCostCenter.fldTitle, Pay.tblCostCenter.fldReportTypeId, Pay.tblCostCenter.fldTypeOfCostCenterId, 
                      Pay.tblCostCenter.fldEmploymentCenterId, Pay.tblCostCenter.fldUserId, Pay.tblCostCenter.fldDate, Pay.tblCostCenter.fldDesc, 
                      Pay.tblReportType.fldName AS fldReportTypeName, Pay.tblTypeOfEmploymentCenter.fldTitle AS EmploymentName, 
                      Pay.tblTypeOfCostCenters.fldTitle AS TypecenterTitle,fldorganid
FROM         Pay.tblCostCenter INNER JOIN
                      Pay.tblReportType ON Pay.tblCostCenter.fldReportTypeId = Pay.tblReportType.fldId INNER JOIN
                      Pay.tblTypeOfCostCenters ON Pay.tblCostCenter.fldTypeOfCostCenterId = Pay.tblTypeOfCostCenters.fldId INNER JOIN
                      Pay.tblTypeOfEmploymentCenter ON Pay.tblCostCenter.fldEmploymentCenterId = Pay.tblTypeOfEmploymentCenter.fldId
	where Pay.tblCostCenter.fldDesc like @Value and fldOrganId=@Value2
	if (@fieldname=N'fldOrganId')
	SELECT   TOP (@h)   Pay.tblCostCenter.fldId, Pay.tblCostCenter.fldTitle, Pay.tblCostCenter.fldReportTypeId, Pay.tblCostCenter.fldTypeOfCostCenterId, 
                      Pay.tblCostCenter.fldEmploymentCenterId, Pay.tblCostCenter.fldUserId, Pay.tblCostCenter.fldDate, Pay.tblCostCenter.fldDesc, 
                      Pay.tblReportType.fldName AS fldReportTypeName, Pay.tblTypeOfEmploymentCenter.fldTitle AS EmploymentName, 
                      Pay.tblTypeOfCostCenters.fldTitle AS TypecenterTitle,fldorganid
FROM         Pay.tblCostCenter INNER JOIN
                      Pay.tblReportType ON Pay.tblCostCenter.fldReportTypeId = Pay.tblReportType.fldId INNER JOIN
                      Pay.tblTypeOfCostCenters ON Pay.tblCostCenter.fldTypeOfCostCenterId = Pay.tblTypeOfCostCenters.fldId INNER JOIN
                      Pay.tblTypeOfEmploymentCenter ON Pay.tblCostCenter.fldEmploymentCenterId = Pay.tblTypeOfEmploymentCenter.fldId
					  where fldOrganId=@Value
	if (@fieldname=N'')
	SELECT   TOP (@h)   Pay.tblCostCenter.fldId, Pay.tblCostCenter.fldTitle, Pay.tblCostCenter.fldReportTypeId, Pay.tblCostCenter.fldTypeOfCostCenterId, 
                      Pay.tblCostCenter.fldEmploymentCenterId, Pay.tblCostCenter.fldUserId, Pay.tblCostCenter.fldDate, Pay.tblCostCenter.fldDesc, 
                      Pay.tblReportType.fldName AS fldReportTypeName, Pay.tblTypeOfEmploymentCenter.fldTitle AS EmploymentName, 
                      Pay.tblTypeOfCostCenters.fldTitle AS TypecenterTitle,fldorganid
FROM         Pay.tblCostCenter INNER JOIN
                      Pay.tblReportType ON Pay.tblCostCenter.fldReportTypeId = Pay.tblReportType.fldId INNER JOIN
                      Pay.tblTypeOfCostCenters ON Pay.tblCostCenter.fldTypeOfCostCenterId = Pay.tblTypeOfCostCenters.fldId INNER JOIN
                      Pay.tblTypeOfEmploymentCenter ON Pay.tblCostCenter.fldEmploymentCenterId = Pay.tblTypeOfEmploymentCenter.fldId

	COMMIT
GO
