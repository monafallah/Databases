SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblMohdoodiyatMohasebat_UserSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@h int
AS 
	BEGIN TRAN
	SET @value=com.fn_TextNormalize(@value) 
	if (@h=0) set @h=2147483647
	if (@fieldname=N'fldId')
	SELECT        TOP (@h) Drd.tblMohdoodiyatMohasebat_User.fldId, Drd.tblMohdoodiyatMohasebat_User.fldIdUser, Drd.tblMohdoodiyatMohasebat_User.fldMahdoodiyatMohasebatId, 
                         Drd.tblMohdoodiyatMohasebat_User.fldUserId, Drd.tblMohdoodiyatMohasebat_User.fldDesc, Drd.tblMohdoodiyatMohasebat_User.fldDate, 
						 Com.tblEmployee.fldName + ' ' + Com.tblEmployee.fldFamily AS fldNameEmployee
FROM            Drd.tblMohdoodiyatMohasebat_User INNER JOIN
                         Com.tblUser ON Drd.tblMohdoodiyatMohasebat_User.fldIdUser = Com.tblUser.fldId INNER JOIN
                         Com.tblEmployee ON Com.tblUser.fldEmployId = Com.tblEmployee.fldId
	WHERE  tblMohdoodiyatMohasebat_User.fldId = @Value

	if (@fieldname=N'fldIdUser')
	SELECT        TOP (@h) Drd.tblMohdoodiyatMohasebat_User.fldId, Drd.tblMohdoodiyatMohasebat_User.fldIdUser, Drd.tblMohdoodiyatMohasebat_User.fldMahdoodiyatMohasebatId, 
                         Drd.tblMohdoodiyatMohasebat_User.fldUserId, Drd.tblMohdoodiyatMohasebat_User.fldDesc, Drd.tblMohdoodiyatMohasebat_User.fldDate, 
						 Com.tblEmployee.fldName + ' ' + Com.tblEmployee.fldFamily AS fldNameEmployee
FROM            Drd.tblMohdoodiyatMohasebat_User INNER JOIN
                         Com.tblUser ON Drd.tblMohdoodiyatMohasebat_User.fldIdUser = Com.tblUser.fldId INNER JOIN
                         Com.tblEmployee ON Com.tblUser.fldEmployId = Com.tblEmployee.fldId
	WHERE  fldIdUser = @Value
	
	if (@fieldname=N'fldMahdoodiyatMohasebatId')
	SELECT        TOP (@h) Drd.tblMohdoodiyatMohasebat_User.fldId, Drd.tblMohdoodiyatMohasebat_User.fldIdUser, Drd.tblMohdoodiyatMohasebat_User.fldMahdoodiyatMohasebatId, 
                         Drd.tblMohdoodiyatMohasebat_User.fldUserId, Drd.tblMohdoodiyatMohasebat_User.fldDesc, Drd.tblMohdoodiyatMohasebat_User.fldDate, 
						 Com.tblEmployee.fldName + ' ' + Com.tblEmployee.fldFamily AS fldNameEmployee
FROM            Drd.tblMohdoodiyatMohasebat_User INNER JOIN
                         Com.tblUser ON Drd.tblMohdoodiyatMohasebat_User.fldIdUser = Com.tblUser.fldId INNER JOIN
                         Com.tblEmployee ON Com.tblUser.fldEmployId = Com.tblEmployee.fldId
	WHERE  fldMahdoodiyatMohasebatId = @Value

	if (@fieldname=N'fldDesc')
	SELECT        TOP (@h) Drd.tblMohdoodiyatMohasebat_User.fldId, Drd.tblMohdoodiyatMohasebat_User.fldIdUser, Drd.tblMohdoodiyatMohasebat_User.fldMahdoodiyatMohasebatId, 
                         Drd.tblMohdoodiyatMohasebat_User.fldUserId, Drd.tblMohdoodiyatMohasebat_User.fldDesc, Drd.tblMohdoodiyatMohasebat_User.fldDate, 
						 Com.tblEmployee.fldName + ' ' + Com.tblEmployee.fldFamily AS fldNameEmployee
FROM            Drd.tblMohdoodiyatMohasebat_User INNER JOIN
                         Com.tblUser ON Drd.tblMohdoodiyatMohasebat_User.fldIdUser = Com.tblUser.fldId INNER JOIN
                         Com.tblEmployee ON Com.tblUser.fldEmployId = Com.tblEmployee.fldId
	WHERE tblMohdoodiyatMohasebat_User.fldDesc like  @Value

	if (@fieldname=N'')
	SELECT        TOP (@h) Drd.tblMohdoodiyatMohasebat_User.fldId, Drd.tblMohdoodiyatMohasebat_User.fldIdUser, Drd.tblMohdoodiyatMohasebat_User.fldMahdoodiyatMohasebatId, 
                         Drd.tblMohdoodiyatMohasebat_User.fldUserId, Drd.tblMohdoodiyatMohasebat_User.fldDesc, Drd.tblMohdoodiyatMohasebat_User.fldDate, 
						 Com.tblEmployee.fldName + ' ' + Com.tblEmployee.fldFamily AS fldNameEmployee
FROM            Drd.tblMohdoodiyatMohasebat_User INNER JOIN
                         Com.tblUser ON Drd.tblMohdoodiyatMohasebat_User.fldIdUser = Com.tblUser.fldId INNER JOIN
                         Com.tblEmployee ON Com.tblUser.fldEmployId = Com.tblEmployee.fldId

	COMMIT
GO
