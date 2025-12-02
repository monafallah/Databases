SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblPcPosParametrSelect] 
	@fieldname nvarchar(50),
	@Value NVARCHAR(50),
    @OrganId INT,
	@h int
AS 
	BEGIN TRAN
	set  @Value=com.fn_TextNormalize(@Value)
	if (@h=0) set @h=2147483647

	--DECLARE @organ TABLE (id int)
	--;WITH organ as	(
	--SELECT    fldId    
	--FROM            Com.tblOrganization
	--WHERE fldId=@OrganId
	--UNION ALL
	--SELECT t.fldId FROM Com.tblOrganization AS t
	--INNER JOIN organ ON t.fldPId=organ.fldId
	-- )
	-- INSERT INTO @organ 
	--		 ( id )
	-- SELECT organ.fldId FROM organ

	if (@fieldname=N'fldId')
SELECT TOP (@h) Drd.tblPcPosParametr.fldId, Drd.tblPcPosParametr.fldFaName, Drd.tblPcPosParametr.fldEnName, Drd.tblPcPosParametr.fldPspId, Drd.tblPcPosParametr.fldUserId, 
                  Drd.tblPcPosParametr.fldDesc, Drd.tblPcPosParametr.fldDate, fldTitle+N'('+fldModel+N')' AS fldPspName
FROM     Drd.tblPcPosParametr INNER JOIN
                  Drd.tblPspModel ON Drd.tblPcPosParametr.fldPspId = Drd.tblPspModel.fldId INNER JOIN
                  Drd.tblPsp ON Drd.tblPspModel.fldPspId = Drd.tblPsp.fldId
	WHERE  Drd.tblPcPosParametr.fldId = @Value AND Drd.tblPcPosParametr.fldPspId  IN (SELECT fldPspId FROM Drd.tblPcPosInfo WHERE fldOrganId=@OrganId)

	if (@fieldname=N'fldDesc')
SELECT TOP (@h) Drd.tblPcPosParametr.fldId, Drd.tblPcPosParametr.fldFaName, Drd.tblPcPosParametr.fldEnName, Drd.tblPcPosParametr.fldPspId, Drd.tblPcPosParametr.fldUserId, 
                  Drd.tblPcPosParametr.fldDesc, Drd.tblPcPosParametr.fldDate, fldTitle+N'('+fldModel+N')' AS fldPspName
FROM     Drd.tblPcPosParametr INNER JOIN
                  Drd.tblPspModel ON Drd.tblPcPosParametr.fldPspId = Drd.tblPspModel.fldId INNER JOIN
                  Drd.tblPsp ON Drd.tblPspModel.fldPspId = Drd.tblPsp.fldId
	WHERE  Drd.tblPcPosParametr.fldDesc like @Value AND Drd.tblPcPosParametr.fldPspId  IN (SELECT fldPspId FROM Drd.tblPcPosInfo WHERE fldOrganId=@OrganId)

	if (@fieldname=N'fldPspId')
SELECT TOP (@h) Drd.tblPcPosParametr.fldId, Drd.tblPcPosParametr.fldFaName, Drd.tblPcPosParametr.fldEnName, Drd.tblPcPosParametr.fldPspId, Drd.tblPcPosParametr.fldUserId, 
                  Drd.tblPcPosParametr.fldDesc, Drd.tblPcPosParametr.fldDate, fldTitle+N'('+fldModel+N')' AS fldPspName
FROM     Drd.tblPcPosParametr INNER JOIN
                  Drd.tblPspModel ON Drd.tblPcPosParametr.fldPspId = Drd.tblPspModel.fldId INNER JOIN
                  Drd.tblPsp ON Drd.tblPspModel.fldPspId = Drd.tblPsp.fldId
	WHERE  Drd.tblPcPosParametr.fldPspId = @Value AND  Drd.tblPcPosParametr.fldPspId  IN (SELECT fldPspId FROM Drd.tblPcPosInfo WHERE fldOrganId=@OrganId)

		if (@fieldname=N'fldFaName')
SELECT TOP (@h) Drd.tblPcPosParametr.fldId, Drd.tblPcPosParametr.fldFaName, Drd.tblPcPosParametr.fldEnName, Drd.tblPcPosParametr.fldPspId, Drd.tblPcPosParametr.fldUserId, 
                  Drd.tblPcPosParametr.fldDesc, Drd.tblPcPosParametr.fldDate, fldTitle+N'('+fldModel+N')' AS fldPspName
FROM     Drd.tblPcPosParametr INNER JOIN
                  Drd.tblPspModel ON Drd.tblPcPosParametr.fldPspId = Drd.tblPspModel.fldId INNER JOIN
                  Drd.tblPsp ON Drd.tblPspModel.fldPspId = Drd.tblPsp.fldId
	WHERE  Drd.tblPcPosParametr.fldFaName like @Value AND Drd.tblPcPosParametr.fldPspId  IN (SELECT fldPspId FROM Drd.tblPcPosInfo WHERE fldOrganId=@OrganId)

		if (@fieldname=N'fldEnName')
SELECT TOP (@h) Drd.tblPcPosParametr.fldId, Drd.tblPcPosParametr.fldFaName, Drd.tblPcPosParametr.fldEnName, Drd.tblPcPosParametr.fldPspId, Drd.tblPcPosParametr.fldUserId, 
                  Drd.tblPcPosParametr.fldDesc, Drd.tblPcPosParametr.fldDate, fldTitle+N'('+fldModel+N')' AS fldPspName
FROM     Drd.tblPcPosParametr INNER JOIN
                  Drd.tblPspModel ON Drd.tblPcPosParametr.fldPspId = Drd.tblPspModel.fldId INNER JOIN
                  Drd.tblPsp ON Drd.tblPspModel.fldPspId = Drd.tblPsp.fldId
	WHERE  Drd.tblPcPosParametr.fldEnName like @Value AND  Drd.tblPcPosParametr.fldPspId  IN (SELECT fldPspId FROM Drd.tblPcPosInfo WHERE fldOrganId=@OrganId)

	if (@fieldname=N'fldPspName')
SELECT TOP (@h) * FROM(SELECT  Drd.tblPcPosParametr.fldId, Drd.tblPcPosParametr.fldFaName, Drd.tblPcPosParametr.fldEnName, Drd.tblPcPosParametr.fldPspId, Drd.tblPcPosParametr.fldUserId, 
                  Drd.tblPcPosParametr.fldDesc, Drd.tblPcPosParametr.fldDate, fldTitle+N'('+fldModel+N')' AS fldPspName
FROM     Drd.tblPcPosParametr INNER JOIN
                  Drd.tblPspModel ON Drd.tblPcPosParametr.fldPspId = Drd.tblPspModel.fldId INNER JOIN
                  Drd.tblPsp ON Drd.tblPspModel.fldPspId = Drd.tblPsp.fldId)t
	WHERE  fldPspName like @Value AND fldPspId  IN (SELECT fldPspId FROM Drd.tblPcPosInfo WHERE fldOrganId=@OrganId)


	if (@fieldname=N'fldFaName_PspId')
	SELECT TOP (@h) Drd.tblPcPosParametr.fldId, Drd.tblPcPosParametr.fldFaName, Drd.tblPcPosParametr.fldEnName, Drd.tblPcPosParametr.fldPspId, Drd.tblPcPosParametr.fldUserId, 
                  Drd.tblPcPosParametr.fldDesc, Drd.tblPcPosParametr.fldDate, fldTitle+N'('+fldModel+N')' AS fldPspName
FROM     Drd.tblPcPosParametr INNER JOIN
                  Drd.tblPspModel ON Drd.tblPcPosParametr.fldPspId = Drd.tblPspModel.fldId INNER JOIN
                  Drd.tblPsp ON Drd.tblPspModel.fldPspId = Drd.tblPsp.fldId
	WHERE  Drd.tblPcPosParametr.fldFaName like @Value AND Drd.tblPcPosParametr.fldPspId=@OrganId


	if (@fieldname=N'fldEnName_PspId')
SELECT TOP (@h) Drd.tblPcPosParametr.fldId, Drd.tblPcPosParametr.fldFaName, Drd.tblPcPosParametr.fldEnName, Drd.tblPcPosParametr.fldPspId, Drd.tblPcPosParametr.fldUserId, 
                  Drd.tblPcPosParametr.fldDesc, Drd.tblPcPosParametr.fldDate, fldTitle+N'('+fldModel+N')' AS fldPspName
FROM     Drd.tblPcPosParametr INNER JOIN
                  Drd.tblPspModel ON Drd.tblPcPosParametr.fldPspId = Drd.tblPspModel.fldId INNER JOIN
                  Drd.tblPsp ON Drd.tblPspModel.fldPspId = Drd.tblPsp.fldId
	WHERE  Drd.tblPcPosParametr.fldEnName like @Value AND  Drd.tblPcPosParametr.fldPspId=@OrganId


	if (@fieldname=N'CheckPspId')
SELECT TOP (@h) Drd.tblPcPosParametr.fldId, Drd.tblPcPosParametr.fldFaName, Drd.tblPcPosParametr.fldEnName, Drd.tblPcPosParametr.fldPspId, Drd.tblPcPosParametr.fldUserId, 
                  Drd.tblPcPosParametr.fldDesc, Drd.tblPcPosParametr.fldDate, fldTitle+N'('+fldModel+N')' AS fldPspName
FROM     Drd.tblPcPosParametr INNER JOIN
                  Drd.tblPspModel ON Drd.tblPcPosParametr.fldPspId = Drd.tblPspModel.fldId INNER JOIN
                  Drd.tblPsp ON Drd.tblPspModel.fldPspId = Drd.tblPsp.fldId
	WHERE  Drd.tblPcPosParametr.fldPspId = @Value 
	
	if (@fieldname=N'')
SELECT TOP (@h) Drd.tblPcPosParametr.fldId, Drd.tblPcPosParametr.fldFaName, Drd.tblPcPosParametr.fldEnName, Drd.tblPcPosParametr.fldPspId, Drd.tblPcPosParametr.fldUserId, 
                  Drd.tblPcPosParametr.fldDesc, Drd.tblPcPosParametr.fldDate, fldTitle+N'('+fldModel+N')' AS fldPspName
FROM     Drd.tblPcPosParametr INNER JOIN
                  Drd.tblPspModel ON Drd.tblPcPosParametr.fldPspId = Drd.tblPspModel.fldId INNER JOIN
                  Drd.tblPsp ON Drd.tblPspModel.fldPspId = Drd.tblPsp.fldId
		WHERE Drd.tblPcPosParametr.fldPspId  IN (SELECT fldPspId FROM Drd.tblPcPosInfo WHERE fldOrganId=@OrganId)
	COMMIT
GO
