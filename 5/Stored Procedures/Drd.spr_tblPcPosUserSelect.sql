SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblPcPosUserSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@h int
AS 
	BEGIN TRAN
	if (@h=0) set @h=2147483647
	set  @Value=com.fn_TextNormalize(@Value)
	if (@fieldname=N'fldId')
	SELECT TOP (@h) Drd.tblPcPosUser.fldId, Drd.tblPcPosUser.fldPosIpId, Drd.tblPcPosUser.fldIdUser, Drd.tblPcPosUser.fldUserId, Drd.tblPcPosUser.fldDesc, Drd.tblPcPosUser.fldDate, 
                 (SELECT fldName + N' '+fldFamily FROM Com.tblEmployee WHERE Com.tblEmployee.fldId=fldEmployId)AS  fldUserName
FROM     Drd.tblPcPosUser INNER JOIN
                  Com.tblUser ON  Drd.tblPcPosUser.fldIdUser = Com.tblUser.fldId 
	WHERE  Drd.tblPcPosUser.fldId = @Value

	if (@fieldname=N'fldDesc')
	SELECT TOP (@h) Drd.tblPcPosUser.fldId, Drd.tblPcPosUser.fldPosIpId, Drd.tblPcPosUser.fldIdUser, Drd.tblPcPosUser.fldUserId, Drd.tblPcPosUser.fldDesc, Drd.tblPcPosUser.fldDate, 
                   (SELECT fldName + N' '+fldFamily FROM Com.tblEmployee WHERE Com.tblEmployee.fldId=fldEmployId)AS  fldUserName
FROM     Drd.tblPcPosUser INNER JOIN
                  Com.tblUser ON  Drd.tblPcPosUser.fldIdUser = Com.tblUser.fldId  
	WHERE  Drd.tblPcPosUser.fldDesc like @Value
	
	if (@fieldname=N'fldIdUser')
	SELECT TOP (@h) Drd.tblPcPosUser.fldId, Drd.tblPcPosUser.fldPosIpId, Drd.tblPcPosUser.fldIdUser, Drd.tblPcPosUser.fldUserId, Drd.tblPcPosUser.fldDesc, Drd.tblPcPosUser.fldDate, 
                   (SELECT fldName + N' '+fldFamily FROM Com.tblEmployee WHERE Com.tblEmployee.fldId=fldEmployId)AS  fldUserName
FROM     Drd.tblPcPosUser INNER JOIN
                  Com.tblUser ON  Drd.tblPcPosUser.fldIdUser = Com.tblUser.fldId  
	WHERE  Drd.tblPcPosUser.fldIdUser like @Value

	if (@fieldname=N'fldPosIpId')
	SELECT TOP (@h) Drd.tblPcPosUser.fldId, Drd.tblPcPosUser.fldPosIpId, Drd.tblPcPosUser.fldIdUser, Drd.tblPcPosUser.fldUserId, Drd.tblPcPosUser.fldDesc, Drd.tblPcPosUser.fldDate, 
                   (SELECT fldName + N' '+fldFamily FROM Com.tblEmployee WHERE Com.tblEmployee.fldId=fldEmployId)AS  fldUserName
FROM     Drd.tblPcPosUser INNER JOIN
                  Com.tblUser ON  Drd.tblPcPosUser.fldIdUser = Com.tblUser.fldId 
	WHERE  fldPosIpId = @Value

	if (@fieldname=N'')
SELECT TOP (@h) Drd.tblPcPosUser.fldId, Drd.tblPcPosUser.fldPosIpId, Drd.tblPcPosUser.fldIdUser, Drd.tblPcPosUser.fldUserId, Drd.tblPcPosUser.fldDesc, Drd.tblPcPosUser.fldDate, 
                  (SELECT fldName + N' '+fldFamily FROM Com.tblEmployee WHERE Com.tblEmployee.fldId=fldEmployId)AS  fldUserName
FROM     Drd.tblPcPosUser INNER JOIN
                  Com.tblUser ON  Drd.tblPcPosUser.fldIdUser = Com.tblUser.fldId 

	COMMIT
GO
