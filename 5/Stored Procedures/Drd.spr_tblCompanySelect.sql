SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblCompanySelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@h int
AS 
	BEGIN TRAN
	if (@h=0) set @h=2147483647
	if (@fieldname=N'fldId')
SELECT     TOP (@h) Drd.tblCompany.fldId, Drd.tblCompany.fldTitle, Drd.tblCompany.fldShenaseMeli, Drd.tblCompany.fldKarbarId, Drd.tblCompany.fldURL, 
                      Drd.tblCompany.fldUserId, Drd.tblCompany.fldDesc, Drd.tblCompany.fldDate, Drd.tblCompany.fldUserNameService, Drd.tblCompany.fldPassService, Com.tblUser.fldUserName
                      ,fldOrganId,ISNULL(fldName,'') AS fldNameOrgan
FROM         Drd.tblCompany INNER JOIN
                      Com.tblUser ON Drd.tblCompany.fldKarbarId = Com.tblUser.fldId
                      LEFT JOIN Com.tblOrganization ON tblOrganization.fldId = tblCompany.fldOrganId
	WHERE  tblCompany.fldId = @Value

	if (@fieldname=N'fldTitle')
SELECT     TOP (@h) Drd.tblCompany.fldId, Drd.tblCompany.fldTitle, Drd.tblCompany.fldShenaseMeli, Drd.tblCompany.fldKarbarId, Drd.tblCompany.fldURL, 
                      Drd.tblCompany.fldUserId, Drd.tblCompany.fldDesc, Drd.tblCompany.fldDate, Drd.tblCompany.fldUserNameService, Drd.tblCompany.fldPassService, Com.tblUser.fldUserName
                      ,fldOrganId,ISNULL(fldName,'') AS fldNameOrgan
FROM         Drd.tblCompany INNER JOIN
                      Com.tblUser ON Drd.tblCompany.fldKarbarId = Com.tblUser.fldId
                      LEFT JOIN Com.tblOrganization ON tblOrganization.fldId = tblCompany.fldOrganId
	WHERE tblCompany.fldTitle like  @Value

		if (@fieldname=N'fldShenaseMeli')
SELECT     TOP (@h) Drd.tblCompany.fldId, Drd.tblCompany.fldTitle, Drd.tblCompany.fldShenaseMeli, Drd.tblCompany.fldKarbarId, Drd.tblCompany.fldURL, 
                      Drd.tblCompany.fldUserId, Drd.tblCompany.fldDesc, Drd.tblCompany.fldDate, Drd.tblCompany.fldUserNameService, Drd.tblCompany.fldPassService, Com.tblUser.fldUserName
                      ,fldOrganId,ISNULL(fldName,'') AS fldNameOrgan
FROM         Drd.tblCompany INNER JOIN
                      Com.tblUser ON Drd.tblCompany.fldKarbarId = Com.tblUser.fldId
                      LEFT JOIN Com.tblOrganization ON tblOrganization.fldId = tblCompany.fldOrganId
	WHERE tblCompany.fldShenaseMeli like  @Value

			if (@fieldname=N'fldURL')
SELECT     TOP (@h) Drd.tblCompany.fldId, Drd.tblCompany.fldTitle, Drd.tblCompany.fldShenaseMeli, Drd.tblCompany.fldKarbarId, Drd.tblCompany.fldURL, 
                      Drd.tblCompany.fldUserId, Drd.tblCompany.fldDesc, Drd.tblCompany.fldDate, Drd.tblCompany.fldUserNameService, Drd.tblCompany.fldPassService, Com.tblUser.fldUserName
                      ,fldOrganId,ISNULL(fldName,'') AS fldNameOrgan
FROM         Drd.tblCompany INNER JOIN
                      Com.tblUser ON Drd.tblCompany.fldKarbarId = Com.tblUser.fldId
                      LEFT JOIN Com.tblOrganization ON tblOrganization.fldId = tblCompany.fldOrganId
	WHERE tblCompany.fldURL like  @Value
	
			if (@fieldname=N'fldUserName')
SELECT     TOP (@h) Drd.tblCompany.fldId, Drd.tblCompany.fldTitle, Drd.tblCompany.fldShenaseMeli, Drd.tblCompany.fldKarbarId, Drd.tblCompany.fldURL, 
                      Drd.tblCompany.fldUserId, Drd.tblCompany.fldDesc, Drd.tblCompany.fldDate, Drd.tblCompany.fldUserNameService, Drd.tblCompany.fldPassService, Com.tblUser.fldUserName
                      ,fldOrganId,ISNULL(fldName,'') AS fldNameOrgan
FROM         Drd.tblCompany INNER JOIN
                      Com.tblUser ON Drd.tblCompany.fldKarbarId = Com.tblUser.fldId
                      LEFT JOIN Com.tblOrganization ON tblOrganization.fldId = tblCompany.fldOrganId
	WHERE Com.tblUser.fldUserName like  @Value

	if (@fieldname=N'fldDesc')
SELECT     TOP (@h) Drd.tblCompany.fldId, Drd.tblCompany.fldTitle, Drd.tblCompany.fldShenaseMeli, Drd.tblCompany.fldKarbarId, Drd.tblCompany.fldURL, 
                      Drd.tblCompany.fldUserId, Drd.tblCompany.fldDesc, Drd.tblCompany.fldDate, Drd.tblCompany.fldUserNameService, Drd.tblCompany.fldPassService, Com.tblUser.fldUserName
                      ,fldOrganId,ISNULL(fldName,'') AS fldNameOrgan
FROM         Drd.tblCompany INNER JOIN
                      Com.tblUser ON Drd.tblCompany.fldKarbarId = Com.tblUser.fldId
                      LEFT JOIN Com.tblOrganization ON tblOrganization.fldId = tblCompany.fldOrganId
	WHERE tblCompany.fldDesc like  @Value
	
	
		if (@fieldname=N'fldOrganId')
SELECT     TOP (@h) Drd.tblCompany.fldId, Drd.tblCompany.fldTitle, Drd.tblCompany.fldShenaseMeli, Drd.tblCompany.fldKarbarId, Drd.tblCompany.fldURL, 
                      Drd.tblCompany.fldUserId, Drd.tblCompany.fldDesc, Drd.tblCompany.fldDate, Drd.tblCompany.fldUserNameService, Drd.tblCompany.fldPassService, Com.tblUser.fldUserName
                      ,fldOrganId,ISNULL(fldName,'') AS fldNameOrgan
FROM         Drd.tblCompany INNER JOIN
                      Com.tblUser ON Drd.tblCompany.fldKarbarId = Com.tblUser.fldId
                      LEFT JOIN Com.tblOrganization ON tblOrganization.fldId = tblCompany.fldOrganId
	WHERE fldOrganId like  @Value

	if (@fieldname=N'')
SELECT     TOP (@h) Drd.tblCompany.fldId, Drd.tblCompany.fldTitle, Drd.tblCompany.fldShenaseMeli, Drd.tblCompany.fldKarbarId, Drd.tblCompany.fldURL, 
                      Drd.tblCompany.fldUserId, Drd.tblCompany.fldDesc, Drd.tblCompany.fldDate, Drd.tblCompany.fldUserNameService, Drd.tblCompany.fldPassService, Com.tblUser.fldUserName
                      ,fldOrganId,ISNULL(fldName,'') AS fldNameOrgan
FROM         Drd.tblCompany INNER JOIN
                      Com.tblUser ON Drd.tblCompany.fldKarbarId = Com.tblUser.fldId
                      LEFT JOIN Com.tblOrganization ON tblOrganization.fldId = tblCompany.fldOrganId

	COMMIT
GO
