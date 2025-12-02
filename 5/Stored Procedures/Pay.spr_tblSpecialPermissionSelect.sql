SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblSpecialPermissionSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@h int
AS 
	BEGIN TRAN
	if (@h=0) set @h=2147483647
	if (@fieldname=N'fldId')
		SELECT     TOP (@h) Pay.tblSpecialPermission.fldId, Pay.tblSpecialPermission.fldUserSelectId, Pay.tblSpecialPermission.fldChartOrganId, 
                      Pay.tblSpecialPermission.fldOpertionId, Pay.tblSpecialPermission.fldUserId, Pay.tblSpecialPermission.fldDesc, Pay.tblSpecialPermission.fldDate, 
                      Com.tblEmployee.fldName + '_' + Com.tblEmployee.fldFamily AS fldNameEmloyee, Com.tblChartOrgan.fldTitle AS fldTitleChart, 
                      Pay.tblOperation.fldTitle AS fldTitleOpr
FROM         Pay.tblSpecialPermission INNER JOIN
                      Com.tblUser ON Pay.tblSpecialPermission.fldUserSelectId = Com.tblUser.fldId INNER JOIN
                      Com.tblEmployee ON Com.tblEmployee.fldId = Com.tblUser.fldEmployId INNER JOIN
                      Com.tblChartOrgan ON Pay.tblSpecialPermission.fldChartOrganId = Com.tblChartOrgan.fldId INNER JOIN
                      Pay.tblOperation ON Pay.tblSpecialPermission.fldOpertionId = Pay.tblOperation.fldId
	WHERE  tblSpecialPermission.fldId = @Value

	if (@fieldname=N'fldDesc')
	SELECT     TOP (@h) Pay.tblSpecialPermission.fldId, Pay.tblSpecialPermission.fldUserSelectId, Pay.tblSpecialPermission.fldChartOrganId, 
                      Pay.tblSpecialPermission.fldOpertionId, Pay.tblSpecialPermission.fldUserId, Pay.tblSpecialPermission.fldDesc, Pay.tblSpecialPermission.fldDate, 
                      Com.tblEmployee.fldName + '_' + Com.tblEmployee.fldFamily AS fldNameEmloyee, Com.tblChartOrgan.fldTitle AS fldTitleChart, 
                      Pay.tblOperation.fldTitle AS fldTitleOpr
FROM         Pay.tblSpecialPermission INNER JOIN
                      Com.tblUser ON Pay.tblSpecialPermission.fldUserSelectId = Com.tblUser.fldId INNER JOIN
                      Com.tblEmployee ON Com.tblEmployee.fldId = Com.tblUser.fldEmployId INNER JOIN
                      Com.tblChartOrgan ON Pay.tblSpecialPermission.fldChartOrganId = Com.tblChartOrgan.fldId INNER JOIN
                      Pay.tblOperation ON Pay.tblSpecialPermission.fldOpertionId = Pay.tblOperation.fldId
	WHERE  tblSpecialPermission.fldDesc like  @Value
	
		if (@fieldname=N'fldNameEmloyee')
	SELECT     TOP (@h) * FROM(	SELECT     Pay.tblSpecialPermission.fldId, Pay.tblSpecialPermission.fldUserSelectId, Pay.tblSpecialPermission.fldChartOrganId, 
                      Pay.tblSpecialPermission.fldOpertionId, Pay.tblSpecialPermission.fldUserId, Pay.tblSpecialPermission.fldDesc, Pay.tblSpecialPermission.fldDate, 
                      Com.tblEmployee.fldName + '_' + Com.tblEmployee.fldFamily AS fldNameEmloyee, Com.tblChartOrgan.fldTitle AS fldTitleChart, 
                      Pay.tblOperation.fldTitle AS fldTitleOpr
FROM         Pay.tblSpecialPermission INNER JOIN
                      Com.tblUser ON Pay.tblSpecialPermission.fldUserSelectId = Com.tblUser.fldId INNER JOIN
                      Com.tblEmployee ON Com.tblEmployee.fldId = Com.tblUser.fldEmployId INNER JOIN
                      Com.tblChartOrgan ON Pay.tblSpecialPermission.fldChartOrganId = Com.tblChartOrgan.fldId INNER JOIN
                      Pay.tblOperation ON Pay.tblSpecialPermission.fldOpertionId = Pay.tblOperation.fldId)t
	WHERE  fldNameEmloyee like  @Value
	
		if (@fieldname=N'fldTitleChart')
	SELECT     TOP (@h) * FROM(	SELECT     Pay.tblSpecialPermission.fldId, Pay.tblSpecialPermission.fldUserSelectId, Pay.tblSpecialPermission.fldChartOrganId, 
                      Pay.tblSpecialPermission.fldOpertionId, Pay.tblSpecialPermission.fldUserId, Pay.tblSpecialPermission.fldDesc, Pay.tblSpecialPermission.fldDate, 
                      Com.tblEmployee.fldName + '_' + Com.tblEmployee.fldFamily AS fldNameEmloyee, Com.tblChartOrgan.fldTitle AS fldTitleChart, 
                      Pay.tblOperation.fldTitle AS fldTitleOpr
FROM         Pay.tblSpecialPermission INNER JOIN
                      Com.tblUser ON Pay.tblSpecialPermission.fldUserSelectId = Com.tblUser.fldId INNER JOIN
                      Com.tblEmployee ON Com.tblEmployee.fldId = Com.tblUser.fldEmployId INNER JOIN
                      Com.tblChartOrgan ON Pay.tblSpecialPermission.fldChartOrganId = Com.tblChartOrgan.fldId INNER JOIN
                      Pay.tblOperation ON Pay.tblSpecialPermission.fldOpertionId = Pay.tblOperation.fldId)t
	WHERE  fldTitleChart like  @Value
	
	
			if (@fieldname=N'fldTitleOpr')
	SELECT     TOP (@h) * FROM(	SELECT     Pay.tblSpecialPermission.fldId, Pay.tblSpecialPermission.fldUserSelectId, Pay.tblSpecialPermission.fldChartOrganId, 
                      Pay.tblSpecialPermission.fldOpertionId, Pay.tblSpecialPermission.fldUserId, Pay.tblSpecialPermission.fldDesc, Pay.tblSpecialPermission.fldDate, 
                      Com.tblEmployee.fldName + '_' + Com.tblEmployee.fldFamily AS fldNameEmloyee, Com.tblChartOrgan.fldTitle AS fldTitleChart, 
                      Pay.tblOperation.fldTitle AS fldTitleOpr
FROM         Pay.tblSpecialPermission INNER JOIN
                      Com.tblUser ON Pay.tblSpecialPermission.fldUserSelectId = Com.tblUser.fldId INNER JOIN
                      Com.tblEmployee ON Com.tblEmployee.fldId = Com.tblUser.fldEmployId INNER JOIN
                      Com.tblChartOrgan ON Pay.tblSpecialPermission.fldChartOrganId = Com.tblChartOrgan.fldId INNER JOIN
                      Pay.tblOperation ON Pay.tblSpecialPermission.fldOpertionId = Pay.tblOperation.fldId)t
	WHERE  fldTitleOpr like  @Value

	if (@fieldname=N'fldChartOrganId')
		SELECT     TOP (@h) Pay.tblSpecialPermission.fldId, Pay.tblSpecialPermission.fldUserSelectId, Pay.tblSpecialPermission.fldChartOrganId, 
                      Pay.tblSpecialPermission.fldOpertionId, Pay.tblSpecialPermission.fldUserId, Pay.tblSpecialPermission.fldDesc, Pay.tblSpecialPermission.fldDate, 
                      Com.tblEmployee.fldName + '_' + Com.tblEmployee.fldFamily AS fldNameEmloyee, Com.tblChartOrgan.fldTitle AS fldTitleChart, 
                      Pay.tblOperation.fldTitle AS fldTitleOpr
FROM         Pay.tblSpecialPermission INNER JOIN
                      Com.tblUser ON Pay.tblSpecialPermission.fldUserSelectId = Com.tblUser.fldId INNER JOIN
                      Com.tblEmployee ON Com.tblEmployee.fldId = Com.tblUser.fldEmployId INNER JOIN
                      Com.tblChartOrgan ON Pay.tblSpecialPermission.fldChartOrganId = Com.tblChartOrgan.fldId INNER JOIN
                      Pay.tblOperation ON Pay.tblSpecialPermission.fldOpertionId = Pay.tblOperation.fldId
	WHERE  fldChartOrganId like  @Value

	
	if (@fieldname=N'fldUserSelectId')
		SELECT     TOP (@h) Pay.tblSpecialPermission.fldId, Pay.tblSpecialPermission.fldUserSelectId, Pay.tblSpecialPermission.fldChartOrganId, 
                      Pay.tblSpecialPermission.fldOpertionId, Pay.tblSpecialPermission.fldUserId, Pay.tblSpecialPermission.fldDesc, Pay.tblSpecialPermission.fldDate, 
                      Com.tblEmployee.fldName + '_' + Com.tblEmployee.fldFamily AS fldNameEmloyee, Com.tblChartOrgan.fldTitle AS fldTitleChart, 
                      Pay.tblOperation.fldTitle AS fldTitleOpr
FROM         Pay.tblSpecialPermission INNER JOIN
                      Com.tblUser ON Pay.tblSpecialPermission.fldUserSelectId = Com.tblUser.fldId INNER JOIN
                      Com.tblEmployee ON Com.tblEmployee.fldId = Com.tblUser.fldEmployId INNER JOIN
                      Com.tblChartOrgan ON Pay.tblSpecialPermission.fldChartOrganId = Com.tblChartOrgan.fldId INNER JOIN
                      Pay.tblOperation ON Pay.tblSpecialPermission.fldOpertionId = Pay.tblOperation.fldId
	WHERE  fldUserSelectId like  @Value

	if (@fieldname=N'')
		SELECT     TOP (@h) Pay.tblSpecialPermission.fldId, Pay.tblSpecialPermission.fldUserSelectId, Pay.tblSpecialPermission.fldChartOrganId, 
                      Pay.tblSpecialPermission.fldOpertionId, Pay.tblSpecialPermission.fldUserId, Pay.tblSpecialPermission.fldDesc, Pay.tblSpecialPermission.fldDate, 
                      Com.tblEmployee.fldName + '_' + Com.tblEmployee.fldFamily AS fldNameEmloyee, Com.tblChartOrgan.fldTitle AS fldTitleChart, 
                      Pay.tblOperation.fldTitle AS fldTitleOpr
FROM         Pay.tblSpecialPermission INNER JOIN
                      Com.tblUser ON Pay.tblSpecialPermission.fldUserSelectId = Com.tblUser.fldId INNER JOIN
                      Com.tblEmployee ON Com.tblEmployee.fldId = Com.tblUser.fldEmployId INNER JOIN
                      Com.tblChartOrgan ON Pay.tblSpecialPermission.fldChartOrganId = Com.tblChartOrgan.fldId INNER JOIN
                      Pay.tblOperation ON Pay.tblSpecialPermission.fldOpertionId = Pay.tblOperation.fldId
	COMMIT
GO
