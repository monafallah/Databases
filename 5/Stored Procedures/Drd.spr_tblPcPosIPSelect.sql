SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblPcPosIPSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@Value1 nvarchar(50),
	@h int
AS 
	BEGIN TRAN
	--DECLARE @organ TABLE (id int)
	--;WITH organ as	(
	--SELECT    fldId    
	--FROM            Com.tblOrganization
	--WHERE fldId=@Value1
	--UNION ALL
	--SELECT t.fldId FROM Com.tblOrganization AS t
	--INNER JOIN organ ON t.fldPId=organ.fldId
	-- )
	-- INSERT INTO @organ 
	--		 ( id )
	-- SELECT organ.fldId FROM organ

	set  @Value=com.fn_TextNormalize(@Value)
	if (@h=0) set @h=2147483647
	if (@fieldname=N'fldId')
SELECT        TOP (@h) Drd.tblPcPosIP.fldId, Drd.tblPcPosIP.fldPcPosInfoId, Drd.tblPcPosIP.fldSerial, Drd.tblPcPosIP.fldUserId, Drd.tblPcPosIP.fldDesc, Drd.tblPcPosIP.fldDate, Drd.tblPcPosIP.fldIp, 
                         Com.fn_stringDecode(Com.tblOrganization.fldName) AS fldOrganName, Drd.tblPsp.fldTitle + N'(' + Drd.tblPspModel.fldModel + N')' AS fldPspName
FROM            Drd.tblPcPosIP INNER JOIN
                         Drd.tblPcPosInfo ON Drd.tblPcPosIP.fldPcPosInfoId = Drd.tblPcPosInfo.fldId INNER JOIN
                         Com.tblOrganization ON Drd.tblPcPosInfo.fldOrganId = Com.tblOrganization.fldId INNER JOIN
                         Drd.tblPspModel ON Drd.tblPcPosInfo.fldPspId = Drd.tblPspModel.fldId INNER JOIN
                         Drd.tblPsp ON Drd.tblPspModel.fldPspId = Drd.tblPsp.fldId AND Drd.tblPspModel.fldPspId = Drd.tblPsp.fldId
	WHERE  Drd.tblPcPosIP.fldId = @Value and Drd.tblPcPosInfo.fldOrganId=@Value1

	if (@fieldname=N'fldDesc')
SELECT        TOP (@h) Drd.tblPcPosIP.fldId, Drd.tblPcPosIP.fldPcPosInfoId, Drd.tblPcPosIP.fldSerial, Drd.tblPcPosIP.fldUserId, Drd.tblPcPosIP.fldDesc, Drd.tblPcPosIP.fldDate, Drd.tblPcPosIP.fldIp, 
                         Com.fn_stringDecode(Com.tblOrganization.fldName) AS fldOrganName, Drd.tblPsp.fldTitle + N'(' + Drd.tblPspModel.fldModel + N')' AS fldPspName
FROM            Drd.tblPcPosIP INNER JOIN
                         Drd.tblPcPosInfo ON Drd.tblPcPosIP.fldPcPosInfoId = Drd.tblPcPosInfo.fldId INNER JOIN
                         Com.tblOrganization ON Drd.tblPcPosInfo.fldOrganId = Com.tblOrganization.fldId INNER JOIN
                         Drd.tblPspModel ON Drd.tblPcPosInfo.fldPspId = Drd.tblPspModel.fldId INNER JOIN
                         Drd.tblPsp ON Drd.tblPspModel.fldPspId = Drd.tblPsp.fldId AND Drd.tblPspModel.fldPspId = Drd.tblPsp.fldId
	WHERE  Drd.tblPcPosIP.fldDesc like  @Value and Drd.tblPcPosInfo.fldOrganId=@Value1

		if (@fieldname=N'fldPspName')
SELECT TOP (@h) * FROM (SELECT  Drd.tblPcPosIP.fldId, Drd.tblPcPosIP.fldPcPosInfoId, Drd.tblPcPosIP.fldSerial, Drd.tblPcPosIP.fldUserId, Drd.tblPcPosIP.fldDesc, Drd.tblPcPosIP.fldDate, Drd.tblPcPosIP.fldIp, 
                         Com.fn_stringDecode(Com.tblOrganization.fldName) AS fldOrganName, Drd.tblPsp.fldTitle + N'(' + Drd.tblPspModel.fldModel + N')' AS fldPspName
FROM            Drd.tblPcPosIP INNER JOIN
                         Drd.tblPcPosInfo ON Drd.tblPcPosIP.fldPcPosInfoId = Drd.tblPcPosInfo.fldId INNER JOIN
                         Com.tblOrganization ON Drd.tblPcPosInfo.fldOrganId = Com.tblOrganization.fldId INNER JOIN
                         Drd.tblPspModel ON Drd.tblPcPosInfo.fldPspId = Drd.tblPspModel.fldId INNER JOIN
                         Drd.tblPsp ON Drd.tblPspModel.fldPspId = Drd.tblPsp.fldId AND Drd.tblPspModel.fldPspId = Drd.tblPsp.fldId
						 WHERE fldOrganId=@Value1) AS t
	WHERE  fldPspName like @Value 

		if (@fieldname=N'fldOrganName')
SELECT        TOP (@h) Drd.tblPcPosIP.fldId, Drd.tblPcPosIP.fldPcPosInfoId, Drd.tblPcPosIP.fldSerial, Drd.tblPcPosIP.fldUserId, Drd.tblPcPosIP.fldDesc, Drd.tblPcPosIP.fldDate, Drd.tblPcPosIP.fldIp, 
                         Com.fn_stringDecode(Com.tblOrganization.fldName) AS fldOrganName, Drd.tblPsp.fldTitle + N'(' + Drd.tblPspModel.fldModel + N')' AS fldPspName
FROM            Drd.tblPcPosIP INNER JOIN
                         Drd.tblPcPosInfo ON Drd.tblPcPosIP.fldPcPosInfoId = Drd.tblPcPosInfo.fldId INNER JOIN
                         Com.tblOrganization ON Drd.tblPcPosInfo.fldOrganId = Com.tblOrganization.fldId INNER JOIN
                         Drd.tblPspModel ON Drd.tblPcPosInfo.fldPspId = Drd.tblPspModel.fldId INNER JOIN
                         Drd.tblPsp ON Drd.tblPspModel.fldPspId = Drd.tblPsp.fldId AND Drd.tblPspModel.fldPspId = Drd.tblPsp.fldId
	WHERE  com.fn_stringDecode(Com.tblOrganization.fldName) like @Value and Drd.tblPcPosInfo.fldOrganId=@Value1


	if (@fieldname=N'fldPcPosInfoId')
SELECT        TOP (@h) Drd.tblPcPosIP.fldId, Drd.tblPcPosIP.fldPcPosInfoId, Drd.tblPcPosIP.fldSerial, Drd.tblPcPosIP.fldUserId, Drd.tblPcPosIP.fldDesc, Drd.tblPcPosIP.fldDate, Drd.tblPcPosIP.fldIp, 
                         Com.fn_stringDecode(Com.tblOrganization.fldName) AS fldOrganName, Drd.tblPsp.fldTitle + N'(' + Drd.tblPspModel.fldModel + N')' AS fldPspName
FROM            Drd.tblPcPosIP INNER JOIN
                         Drd.tblPcPosInfo ON Drd.tblPcPosIP.fldPcPosInfoId = Drd.tblPcPosInfo.fldId INNER JOIN
                         Com.tblOrganization ON Drd.tblPcPosInfo.fldOrganId = Com.tblOrganization.fldId INNER JOIN
                         Drd.tblPspModel ON Drd.tblPcPosInfo.fldPspId = Drd.tblPspModel.fldId INNER JOIN
                         Drd.tblPsp ON Drd.tblPspModel.fldPspId = Drd.tblPsp.fldId AND Drd.tblPspModel.fldPspId = Drd.tblPsp.fldId
	WHERE  Drd.tblPcPosIP.fldPcPosInfoId = @Value and Drd.tblPcPosInfo.fldOrganId=@Value1

		if (@fieldname=N'CheckPcPosInfoId')
SELECT        TOP (@h) Drd.tblPcPosIP.fldId, Drd.tblPcPosIP.fldPcPosInfoId, Drd.tblPcPosIP.fldSerial, Drd.tblPcPosIP.fldUserId, Drd.tblPcPosIP.fldDesc, Drd.tblPcPosIP.fldDate, Drd.tblPcPosIP.fldIp, 
                         Com.fn_stringDecode(Com.tblOrganization.fldName) AS fldOrganName, Drd.tblPsp.fldTitle + N'(' + Drd.tblPspModel.fldModel + N')' AS fldPspName
FROM            Drd.tblPcPosIP INNER JOIN
                         Drd.tblPcPosInfo ON Drd.tblPcPosIP.fldPcPosInfoId = Drd.tblPcPosInfo.fldId INNER JOIN
                         Com.tblOrganization ON Drd.tblPcPosInfo.fldOrganId = Com.tblOrganization.fldId INNER JOIN
                         Drd.tblPspModel ON Drd.tblPcPosInfo.fldPspId = Drd.tblPspModel.fldId INNER JOIN
                         Drd.tblPsp ON Drd.tblPspModel.fldPspId = Drd.tblPsp.fldId AND Drd.tblPspModel.fldPspId = Drd.tblPsp.fldId
	WHERE  Drd.tblPcPosIP.fldPcPosInfoId = @Value 


	if (@fieldname=N'fldSerial')
	SELECT        TOP (@h) Drd.tblPcPosIP.fldId, Drd.tblPcPosIP.fldPcPosInfoId, Drd.tblPcPosIP.fldSerial, Drd.tblPcPosIP.fldUserId, Drd.tblPcPosIP.fldDesc, Drd.tblPcPosIP.fldDate, Drd.tblPcPosIP.fldIp, 
                         Com.fn_stringDecode(Com.tblOrganization.fldName) AS fldOrganName, Drd.tblPsp.fldTitle + N'(' + Drd.tblPspModel.fldModel + N')' AS fldPspName
FROM            Drd.tblPcPosIP INNER JOIN
                         Drd.tblPcPosInfo ON Drd.tblPcPosIP.fldPcPosInfoId = Drd.tblPcPosInfo.fldId INNER JOIN
                         Com.tblOrganization ON Drd.tblPcPosInfo.fldOrganId = Com.tblOrganization.fldId INNER JOIN
                         Drd.tblPspModel ON Drd.tblPcPosInfo.fldPspId = Drd.tblPspModel.fldId INNER JOIN
                         Drd.tblPsp ON Drd.tblPspModel.fldPspId = Drd.tblPsp.fldId AND Drd.tblPspModel.fldPspId = Drd.tblPsp.fldId
	WHERE  Drd.tblPcPosIP.fldSerial LIKE @Value and Drd.tblPcPosInfo.fldOrganId=@Value1

		if (@fieldname=N'fldIp')
	SELECT        TOP (@h) Drd.tblPcPosIP.fldId, Drd.tblPcPosIP.fldPcPosInfoId, Drd.tblPcPosIP.fldSerial, Drd.tblPcPosIP.fldUserId, Drd.tblPcPosIP.fldDesc, Drd.tblPcPosIP.fldDate, Drd.tblPcPosIP.fldIp, 
                         Com.fn_stringDecode(Com.tblOrganization.fldName) AS fldOrganName, Drd.tblPsp.fldTitle + N'(' + Drd.tblPspModel.fldModel + N')' AS fldPspName
FROM            Drd.tblPcPosIP INNER JOIN
                         Drd.tblPcPosInfo ON Drd.tblPcPosIP.fldPcPosInfoId = Drd.tblPcPosInfo.fldId INNER JOIN
                         Com.tblOrganization ON Drd.tblPcPosInfo.fldOrganId = Com.tblOrganization.fldId INNER JOIN
                         Drd.tblPspModel ON Drd.tblPcPosInfo.fldPspId = Drd.tblPspModel.fldId INNER JOIN
                         Drd.tblPsp ON Drd.tblPspModel.fldPspId = Drd.tblPsp.fldId AND Drd.tblPspModel.fldPspId = Drd.tblPsp.fldId
	WHERE  Drd.tblPcPosIP.fldIp LIKE @Value and Drd.tblPcPosInfo.fldOrganId=@Value1


	if (@fieldname=N'')
SELECT        TOP (@h) Drd.tblPcPosIP.fldId, Drd.tblPcPosIP.fldPcPosInfoId, Drd.tblPcPosIP.fldSerial, Drd.tblPcPosIP.fldUserId, Drd.tblPcPosIP.fldDesc, Drd.tblPcPosIP.fldDate, Drd.tblPcPosIP.fldIp, 
                         Com.fn_stringDecode(Com.tblOrganization.fldName) AS fldOrganName, Drd.tblPsp.fldTitle + N'(' + Drd.tblPspModel.fldModel + N')' AS fldPspName
FROM            Drd.tblPcPosIP INNER JOIN
                         Drd.tblPcPosInfo ON Drd.tblPcPosIP.fldPcPosInfoId = Drd.tblPcPosInfo.fldId INNER JOIN
                         Com.tblOrganization ON Drd.tblPcPosInfo.fldOrganId = Com.tblOrganization.fldId INNER JOIN
                         Drd.tblPspModel ON Drd.tblPcPosInfo.fldPspId = Drd.tblPspModel.fldId INNER JOIN
                         Drd.tblPsp ON Drd.tblPspModel.fldPspId = Drd.tblPsp.fldId AND Drd.tblPspModel.fldPspId = Drd.tblPsp.fldId
				where  Drd.tblPcPosInfo.fldOrganId=@Value1
	COMMIT
GO
