SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblPcPosInfoSelect] 
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
SELECT TOP (@h) Drd.tblPcPosInfo.fldId, Drd.tblPcPosInfo.fldPspId, Drd.tblPcPosInfo.fldOrganId, Drd.tblPcPosInfo.fldUserId, Drd.tblPcPosInfo.fldDesc, Drd.tblPcPosInfo.fldDate, 
                  ISNULL(Com.fn_stringDecode(Com.tblOrganization.fldName), '') AS fldOrganName, fldTitle+N'('+fldModel+N')' AS fldPspName
FROM     Drd.tblPcPosInfo INNER JOIN
                  Com.tblOrganization ON Drd.tblPcPosInfo.fldOrganId = Com.tblOrganization.fldId INNER JOIN
                  Drd.tblPspModel ON Drd.tblPcPosInfo.fldPspId = Drd.tblPspModel.fldId INNER JOIN
                  Drd.tblPsp ON Drd.tblPspModel.fldPspId = Drd.tblPsp.fldId AND Drd.tblPspModel.fldPspId = Drd.tblPsp.fldId
	WHERE  Drd.tblPcPosInfo.fldId = @Value   and Drd.tblPcPosInfo.fldOrganId=@Value1

	if (@fieldname=N'fldPspId')
SELECT TOP (@h) Drd.tblPcPosInfo.fldId, Drd.tblPcPosInfo.fldPspId, Drd.tblPcPosInfo.fldOrganId, Drd.tblPcPosInfo.fldUserId, Drd.tblPcPosInfo.fldDesc, Drd.tblPcPosInfo.fldDate, 
                  ISNULL(Com.fn_stringDecode(Com.tblOrganization.fldName), '') AS fldOrganName, fldTitle+N'('+fldModel+N')' AS fldPspName
FROM     Drd.tblPcPosInfo INNER JOIN
                  Com.tblOrganization ON Drd.tblPcPosInfo.fldOrganId = Com.tblOrganization.fldId INNER JOIN
                  Drd.tblPspModel ON Drd.tblPcPosInfo.fldPspId = Drd.tblPspModel.fldId INNER JOIN
                  Drd.tblPsp ON Drd.tblPspModel.fldPspId = Drd.tblPsp.fldId AND Drd.tblPspModel.fldPspId = Drd.tblPsp.fldId
	WHERE  Drd.tblPcPosInfo.fldPspId = @Value   and Drd.tblPcPosInfo.fldOrganId=@Value1

	if (@fieldname=N'fldOrganId')
SELECT TOP (@h) Drd.tblPcPosInfo.fldId, Drd.tblPcPosInfo.fldPspId, Drd.tblPcPosInfo.fldOrganId, Drd.tblPcPosInfo.fldUserId, Drd.tblPcPosInfo.fldDesc, Drd.tblPcPosInfo.fldDate, 
                  ISNULL(Com.fn_stringDecode(Com.tblOrganization.fldName), '') AS fldOrganName, fldTitle+N'('+fldModel+N')' AS fldPspName
FROM     Drd.tblPcPosInfo INNER JOIN
                  Com.tblOrganization ON Drd.tblPcPosInfo.fldOrganId = Com.tblOrganization.fldId INNER JOIN
                  Drd.tblPspModel ON Drd.tblPcPosInfo.fldPspId = Drd.tblPspModel.fldId INNER JOIN
                  Drd.tblPsp ON Drd.tblPspModel.fldPspId = Drd.tblPsp.fldId AND Drd.tblPspModel.fldPspId = Drd.tblPsp.fldId
	WHERE  fldOrganId = @Value and Drd.tblPcPosInfo.fldOrganId=@Value1

		if (@fieldname=N'fldPspName')
SELECT TOP (@h) * FROM ( SELECT  Drd.tblPcPosInfo.fldId, Drd.tblPcPosInfo.fldPspId, Drd.tblPcPosInfo.fldOrganId, Drd.tblPcPosInfo.fldUserId, Drd.tblPcPosInfo.fldDesc, Drd.tblPcPosInfo.fldDate, 
                  ISNULL(Com.fn_stringDecode(Com.tblOrganization.fldName), '') AS fldOrganName, fldTitle+N'('+fldModel+N')' AS fldPspName
FROM     Drd.tblPcPosInfo INNER JOIN
                  Com.tblOrganization ON Drd.tblPcPosInfo.fldOrganId = Com.tblOrganization.fldId INNER JOIN
                  Drd.tblPspModel ON Drd.tblPcPosInfo.fldPspId = Drd.tblPspModel.fldId INNER JOIN
                  Drd.tblPsp ON Drd.tblPspModel.fldPspId = Drd.tblPsp.fldId AND Drd.tblPspModel.fldPspId = Drd.tblPsp.fldId) AS t
	WHERE fldPspName like @Value and fldOrganId=@Value1


		if (@fieldname=N'fldOrganName')
	SELECT top(@h)* from(SELECT Drd.tblPcPosInfo.fldId, Drd.tblPcPosInfo.fldPspId, Drd.tblPcPosInfo.fldOrganId, Drd.tblPcPosInfo.fldUserId, Drd.tblPcPosInfo.fldDesc, Drd.tblPcPosInfo.fldDate, 
                  ISNULL(Com.fn_stringDecode(Com.tblOrganization.fldName), '') AS fldOrganName, fldTitle+N'('+fldModel+N')' AS fldPspName
FROM     Drd.tblPcPosInfo INNER JOIN
                  Com.tblOrganization ON Drd.tblPcPosInfo.fldOrganId = Com.tblOrganization.fldId INNER JOIN
                  Drd.tblPspModel ON Drd.tblPcPosInfo.fldPspId = Drd.tblPspModel.fldId INNER JOIN
                  Drd.tblPsp ON Drd.tblPspModel.fldPspId = Drd.tblPsp.fldId AND Drd.tblPspModel.fldPspId = Drd.tblPsp.fldId)as t
	WHERE  fldOrganName like @Value and  t.fldOrganId=@Value1


	if (@fieldname=N'fldDesc')
SELECT TOP (@h) Drd.tblPcPosInfo.fldId, Drd.tblPcPosInfo.fldPspId, Drd.tblPcPosInfo.fldOrganId, Drd.tblPcPosInfo.fldUserId, Drd.tblPcPosInfo.fldDesc, Drd.tblPcPosInfo.fldDate, 
                  ISNULL(Com.fn_stringDecode(Com.tblOrganization.fldName), '') AS fldOrganName, fldTitle+N'('+fldModel+N')' AS fldPspName
FROM     Drd.tblPcPosInfo INNER JOIN
                  Com.tblOrganization ON Drd.tblPcPosInfo.fldOrganId = Com.tblOrganization.fldId INNER JOIN
                  Drd.tblPspModel ON Drd.tblPcPosInfo.fldPspId = Drd.tblPspModel.fldId INNER JOIN
                  Drd.tblPsp ON Drd.tblPspModel.fldPspId = Drd.tblPsp.fldId AND Drd.tblPspModel.fldPspId = Drd.tblPsp.fldId
	WHERE  Drd.tblPcPosInfo.fldDesc like @Value  and Drd.tblPcPosInfo.fldOrganId=@Value1

		if (@fieldname=N'CheckPspId')
SELECT TOP (@h) Drd.tblPcPosInfo.fldId, Drd.tblPcPosInfo.fldPspId, Drd.tblPcPosInfo.fldOrganId, Drd.tblPcPosInfo.fldUserId, Drd.tblPcPosInfo.fldDesc, Drd.tblPcPosInfo.fldDate, 
                  ISNULL(Com.fn_stringDecode(Com.tblOrganization.fldName), '') AS fldOrganName, fldTitle+N'('+fldModel+N')' AS fldPspName
FROM     Drd.tblPcPosInfo INNER JOIN
                  Com.tblOrganization ON Drd.tblPcPosInfo.fldOrganId = Com.tblOrganization.fldId INNER JOIN
                  Drd.tblPspModel ON Drd.tblPcPosInfo.fldPspId = Drd.tblPspModel.fldId INNER JOIN
                  Drd.tblPsp ON Drd.tblPspModel.fldPspId = Drd.tblPsp.fldId AND Drd.tblPspModel.fldPspId = Drd.tblPsp.fldId
	WHERE  Drd.tblPcPosInfo.fldPspId = @Value 

			if (@fieldname=N'CheckPsp_OrganId')
SELECT TOP (@h) Drd.tblPcPosInfo.fldId, Drd.tblPcPosInfo.fldPspId, Drd.tblPcPosInfo.fldOrganId, Drd.tblPcPosInfo.fldUserId, Drd.tblPcPosInfo.fldDesc, Drd.tblPcPosInfo.fldDate, 
                  ISNULL(Com.fn_stringDecode(Com.tblOrganization.fldName), '') AS fldOrganName, fldTitle+N'('+fldModel+N')' AS fldPspName
FROM     Drd.tblPcPosInfo INNER JOIN
                  Com.tblOrganization ON Drd.tblPcPosInfo.fldOrganId = Com.tblOrganization.fldId INNER JOIN
                  Drd.tblPspModel ON Drd.tblPcPosInfo.fldPspId = Drd.tblPspModel.fldId INNER JOIN
                  Drd.tblPsp ON Drd.tblPspModel.fldPspId = Drd.tblPsp.fldId AND Drd.tblPspModel.fldPspId = Drd.tblPsp.fldId
	WHERE   Drd.tblPcPosInfo.fldPspId like @Value and Drd.tblPcPosInfo.fldOrganId=@Value1
	
		if (@fieldname=N'CheckOrganId')
SELECT TOP (@h) Drd.tblPcPosInfo.fldId, Drd.tblPcPosInfo.fldPspId, Drd.tblPcPosInfo.fldOrganId, Drd.tblPcPosInfo.fldUserId, Drd.tblPcPosInfo.fldDesc, Drd.tblPcPosInfo.fldDate, 
                  ISNULL(Com.fn_stringDecode(Com.tblOrganization.fldName), '') AS fldOrganName, fldTitle+N'('+fldModel+N')' AS fldPspName
FROM     Drd.tblPcPosInfo INNER JOIN
                  Com.tblOrganization ON Drd.tblPcPosInfo.fldOrganId = Com.tblOrganization.fldId INNER JOIN
                  Drd.tblPspModel ON Drd.tblPcPosInfo.fldPspId = Drd.tblPspModel.fldId INNER JOIN
                  Drd.tblPsp ON Drd.tblPspModel.fldPspId = Drd.tblPsp.fldId AND Drd.tblPspModel.fldPspId = Drd.tblPsp.fldId
	WHERE  Drd.tblPcPosInfo.fldOrganId = @Value 

	if (@fieldname=N'')
SELECT TOP (@h) Drd.tblPcPosInfo.fldId, Drd.tblPcPosInfo.fldPspId, Drd.tblPcPosInfo.fldOrganId, Drd.tblPcPosInfo.fldUserId, Drd.tblPcPosInfo.fldDesc, Drd.tblPcPosInfo.fldDate, 
                  ISNULL(Com.fn_stringDecode(Com.tblOrganization.fldName), '') AS fldOrganName, fldTitle+N'('+fldModel+N')' AS fldPspName
FROM     Drd.tblPcPosInfo INNER JOIN
                  Com.tblOrganization ON Drd.tblPcPosInfo.fldOrganId = Com.tblOrganization.fldId INNER JOIN
                  Drd.tblPspModel ON Drd.tblPcPosInfo.fldPspId = Drd.tblPspModel.fldId INNER JOIN
                  Drd.tblPsp ON Drd.tblPspModel.fldPspId = Drd.tblPsp.fldId AND Drd.tblPspModel.fldPspId = Drd.tblPsp.fldId
          where Drd.tblPcPosInfo.fldOrganId=@Value1
          
	COMMIT
GO
