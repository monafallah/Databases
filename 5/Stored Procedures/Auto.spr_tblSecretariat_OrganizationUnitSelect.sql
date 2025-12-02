SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Auto].[spr_tblSecretariat_OrganizationUnitSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@fldOrganId INT,
	@h int
AS 
	BEGIN TRAN
	SET @Value=Com.fn_TextNormalize(@Value)
	if (@h=0) set @h=2147483647
	if (@fieldname=N'fldId')
	SELECT     TOP (@h) Auto.tblSecretariat_OrganizationUnit.fldID, Auto.tblSecretariat_OrganizationUnit.fldSecretariatID, Auto.tblSecretariat_OrganizationUnit.fldOrganizationUnitID, 
                      Auto.tblSecretariat_OrganizationUnit.fldDate, Auto.tblSecretariat_OrganizationUnit.fldUserID, Auto.tblSecretariat_OrganizationUnit.fldDesc, 
                      Auto.tblSecretariat_OrganizationUnit.fldIP, Auto.tblSecretariat_OrganizationUnit.fldOrganId, Com.tblChartOrganEjraee.fldTitle
FROM         Auto.tblSecretariat_OrganizationUnit INNER JOIN
                      Com.tblChartOrganEjraee ON Auto.tblSecretariat_OrganizationUnit.fldOrganizationUnitID = Com.tblChartOrganEjraee.fldId
	WHERE  Auto.tblSecretariat_OrganizationUnit.fldId = @Value AND Auto.tblSecretariat_OrganizationUnit.fldOrganId=@fldOrganId

	
	
	IF (@fieldname=N'fldDesc')
	SELECT     TOP (@h) Auto.tblSecretariat_OrganizationUnit.fldID, Auto.tblSecretariat_OrganizationUnit.fldSecretariatID, Auto.tblSecretariat_OrganizationUnit.fldOrganizationUnitID, 
                      Auto.tblSecretariat_OrganizationUnit.fldDate, Auto.tblSecretariat_OrganizationUnit.fldUserID, Auto.tblSecretariat_OrganizationUnit.fldDesc, 
                      Auto.tblSecretariat_OrganizationUnit.fldIP, Auto.tblSecretariat_OrganizationUnit.fldOrganId, Com.tblChartOrganEjraee.fldTitle
FROM         Auto.tblSecretariat_OrganizationUnit INNER JOIN
                      Com.tblChartOrganEjraee ON Auto.tblSecretariat_OrganizationUnit.fldOrganizationUnitID = Com.tblChartOrganEjraee.fldId
	WHERE Auto.tblSecretariat_OrganizationUnit.fldDesc like  @Value AND Auto.tblSecretariat_OrganizationUnit.fldOrganId=@fldOrganId



	
	IF (@fieldname=N'')
		SELECT     TOP (@h) Auto.tblSecretariat_OrganizationUnit.fldID, Auto.tblSecretariat_OrganizationUnit.fldSecretariatID, Auto.tblSecretariat_OrganizationUnit.fldOrganizationUnitID, 
                      Auto.tblSecretariat_OrganizationUnit.fldDate, Auto.tblSecretariat_OrganizationUnit.fldUserID, Auto.tblSecretariat_OrganizationUnit.fldDesc, 
                      Auto.tblSecretariat_OrganizationUnit.fldIP, Auto.tblSecretariat_OrganizationUnit.fldOrganId, Com.tblChartOrganEjraee.fldTitle
FROM         Auto.tblSecretariat_OrganizationUnit INNER JOIN
                      Com.tblChartOrganEjraee ON Auto.tblSecretariat_OrganizationUnit.fldOrganizationUnitID = Com.tblChartOrganEjraee.fldId
					  where tblSecretariat_OrganizationUnit.fldOrganId=@fldOrganId


IF(@fieldname=N'fldOrganId')
	SELECT     TOP (@h) Auto.tblSecretariat_OrganizationUnit.fldID, Auto.tblSecretariat_OrganizationUnit.fldSecretariatID, Auto.tblSecretariat_OrganizationUnit.fldOrganizationUnitID, 
                      Auto.tblSecretariat_OrganizationUnit.fldDate, Auto.tblSecretariat_OrganizationUnit.fldUserID, Auto.tblSecretariat_OrganizationUnit.fldDesc, 
                      Auto.tblSecretariat_OrganizationUnit.fldIP, Auto.tblSecretariat_OrganizationUnit.fldOrganId, Com.tblChartOrganEjraee.fldTitle
FROM         Auto.tblSecretariat_OrganizationUnit INNER JOIN
                      Com.tblChartOrganEjraee ON Auto.tblSecretariat_OrganizationUnit.fldOrganizationUnitID = Com.tblChartOrganEjraee.fldId
	WHERE Auto.tblSecretariat_OrganizationUnit.fldOrganId=@fldOrganId	


	
	IF (@fieldname=N'fldTitle')
	SELECT     TOP (@h) Auto.tblSecretariat_OrganizationUnit.fldID, Auto.tblSecretariat_OrganizationUnit.fldSecretariatID, Auto.tblSecretariat_OrganizationUnit.fldOrganizationUnitID, 
                      Auto.tblSecretariat_OrganizationUnit.fldDate, Auto.tblSecretariat_OrganizationUnit.fldUserID, Auto.tblSecretariat_OrganizationUnit.fldDesc, 
                      Auto.tblSecretariat_OrganizationUnit.fldIP, Auto.tblSecretariat_OrganizationUnit.fldOrganId, Com.tblChartOrganEjraee.fldTitle
FROM         Auto.tblSecretariat_OrganizationUnit INNER JOIN
                      Com.tblChartOrganEjraee ON Auto.tblSecretariat_OrganizationUnit.fldOrganizationUnitID = Com.tblChartOrganEjraee.fldId
	WHERE Com.tblChartOrganEjraee.fldTitle like  @Value AND Auto.tblSecretariat_OrganizationUnit.fldOrganId=@fldOrganId
	

  
  
  IF(@fieldname=N'fldSecretariatID')
	SELECT     TOP (@h) Auto.tblSecretariat_OrganizationUnit.fldID, Auto.tblSecretariat_OrganizationUnit.fldSecretariatID, Auto.tblSecretariat_OrganizationUnit.fldOrganizationUnitID, 
                      Auto.tblSecretariat_OrganizationUnit.fldDate, Auto.tblSecretariat_OrganizationUnit.fldUserID, Auto.tblSecretariat_OrganizationUnit.fldDesc, 
                      Auto.tblSecretariat_OrganizationUnit.fldIP, Auto.tblSecretariat_OrganizationUnit.fldOrganId, Com.tblChartOrganEjraee.fldTitle
FROM         Auto.tblSecretariat_OrganizationUnit INNER JOIN
                      Com.tblChartOrganEjraee ON Auto.tblSecretariat_OrganizationUnit.fldOrganizationUnitID = Com.tblChartOrganEjraee.fldId
	WHERE Auto.tblSecretariat_OrganizationUnit.fldSecretariatID like  @Value AND Auto.tblSecretariat_OrganizationUnit.fldOrganId=@fldOrganId	
	

	IF(@fieldname=N'fldOrganizationUnitID')
	SELECT     TOP (@h) Auto.tblSecretariat_OrganizationUnit.fldID, Auto.tblSecretariat_OrganizationUnit.fldSecretariatID, Auto.tblSecretariat_OrganizationUnit.fldOrganizationUnitID, 
                      Auto.tblSecretariat_OrganizationUnit.fldDate, Auto.tblSecretariat_OrganizationUnit.fldUserID, Auto.tblSecretariat_OrganizationUnit.fldDesc, 
                      Auto.tblSecretariat_OrganizationUnit.fldIP, Auto.tblSecretariat_OrganizationUnit.fldOrganId, Com.tblChartOrganEjraee.fldTitle
FROM         Auto.tblSecretariat_OrganizationUnit INNER JOIN
                      Com.tblChartOrganEjraee ON Auto.tblSecretariat_OrganizationUnit.fldOrganizationUnitID = Com.tblChartOrganEjraee.fldId
	WHERE Auto.tblSecretariat_OrganizationUnit.fldOrganizationUnitID like  @Value AND Auto.tblSecretariat_OrganizationUnit.fldOrganId=@fldOrganId	
	



IF(@fieldname=N'checkChartOrgan')/*فرق داره*/
	SELECT     TOP (@h) Auto.tblSecretariat_OrganizationUnit.fldID, Auto.tblSecretariat_OrganizationUnit.fldSecretariatID, Auto.tblSecretariat_OrganizationUnit.fldOrganizationUnitID, 
                      Auto.tblSecretariat_OrganizationUnit.fldDate, Auto.tblSecretariat_OrganizationUnit.fldUserID, Auto.tblSecretariat_OrganizationUnit.fldDesc, 
                      Auto.tblSecretariat_OrganizationUnit.fldIP, Auto.tblSecretariat_OrganizationUnit.fldOrganId,''fldTitle
FROM         Auto.tblSecretariat_OrganizationUnit 
inner join auto.tblSecretariat s on s.fldid= Auto.tblSecretariat_OrganizationUnit.fldSecretariatID
	WHERE s.fldChartOrganEjraeeId like  @Value AND Auto.tblSecretariat_OrganizationUnit.fldOrganId=@fldOrganId	
	



	COMMIT
GO
