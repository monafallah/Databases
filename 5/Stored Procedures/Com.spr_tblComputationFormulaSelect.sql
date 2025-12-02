SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblComputationFormulaSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@Value2 NVARCHAR(50),
	@Value3 NVARCHAR(50),
	@OrganId INT,
	@h int
AS 
	BEGIN TRAN
	if (@h=0) set @h=2147483647
	SET @value =Com.fn_TextNormalize(@value)
	if (@fieldname=N'fldId')
	BEGIN
	IF(@OrganId <>0)
	SELECT     TOP (@h) Com.tblComputationFormula.fldId, Com.tblComputationFormula.fldType,(Com.tblComputationFormula.fldFormule)fldFormule, Com.tblComputationFormula.fldOrganId, 
                      Com.tblComputationFormula.fldLibrary, Com.tblComputationFormula.fldAzTarikh, Com.tblComputationFormula.fldUserId, Com.tblComputationFormula.fldDesc, 
                      Com.tblComputationFormula.fldDate, Com.fn_stringDecode(tblOrgan.fldName) AS NameOrgan
                      ,CASE WHEN fldtype=1 THEN N'حقوق' ELSE N'احکام' END AS fldTypeName
FROM         Com.tblComputationFormula LEFT outer JOIN
                      Com.tblOrganization AS tblOrgan ON Com.tblComputationFormula.fldOrganId = tblOrgan.fldId
	WHERE  Com.tblComputationFormula.fldId = @Value  AND fldOrganId =@OrganId
	ELSE
		SELECT     TOP (@h) Com.tblComputationFormula.fldId, Com.tblComputationFormula.fldType,/* com.fn_stringDecode*/(Com.tblComputationFormula.fldFormule)fldFormule, Com.tblComputationFormula.fldOrganId, 
                      Com.tblComputationFormula.fldLibrary, Com.tblComputationFormula.fldAzTarikh, Com.tblComputationFormula.fldUserId, Com.tblComputationFormula.fldDesc, 
                      Com.tblComputationFormula.fldDate, Com.fn_stringDecode(tblOrgan.fldName) AS NameOrgan
                      ,CASE WHEN fldtype=1 THEN N'حقوق' ELSE N'احکام' END AS fldTypeName
FROM         Com.tblComputationFormula LEFT outer JOIN
                      Com.tblOrganization AS tblOrgan ON Com.tblComputationFormula.fldOrganId = tblOrgan.fldId
	WHERE  Com.tblComputationFormula.fldId = @Value
	END 
	if (@fieldname=N'fldFormule_fldLibrary')
SELECT     TOP (@h) Com.tblComputationFormula.fldId, Com.tblComputationFormula.fldType,  (Com.tblComputationFormula.fldFormule)fldFormule, Com.tblComputationFormula.fldOrganId, 
                      Com.tblComputationFormula.fldLibrary, Com.tblComputationFormula.fldAzTarikh, Com.tblComputationFormula.fldUserId, Com.tblComputationFormula.fldDesc, 
                      Com.tblComputationFormula.fldDate,Com.fn_stringDecode(tblOrgan.fldName)  AS NameOrgan
                      ,CASE WHEN fldtype=1 THEN N'حقوق' ELSE N'احکام' END AS fldTypeName
FROM         Com.tblComputationFormula INNER JOIN
                      Com.tblOrganization AS tblOrgan ON Com.tblComputationFormula.fldOrganId = tblOrgan.fldId
	WHERE  fldOrganId = @Value  AND fldType=@Value2 AND fldOrganId =@OrganId
	
		if (@fieldname=N'fldOrgan_fldType')
SELECT     TOP (@h) Com.tblComputationFormula.fldId, Com.tblComputationFormula.fldType, (Com.tblComputationFormula.fldFormule)fldFormule, Com.tblComputationFormula.fldOrganId, 
                      Com.tblComputationFormula.fldLibrary, Com.tblComputationFormula.fldAzTarikh, Com.tblComputationFormula.fldUserId, Com.tblComputationFormula.fldDesc, 
                      Com.tblComputationFormula.fldDate,Com.fn_stringDecode(tblOrgan.fldName)  AS NameOrgan
                      ,CASE WHEN fldtype=1 THEN N'حقوق' ELSE N'احکام' END AS fldTypeName
FROM         Com.tblComputationFormula INNER JOIN
                      Com.tblOrganization AS tblOrgan ON Com.tblComputationFormula.fldOrganId = tblOrgan.fldId
	WHERE  fldOrganId = @Value  AND fldType=@Value2	AND fldOrganId =@OrganId
	ORDER BY fldAzTarikh desc
	
	if (@fieldname=N'fldAzTarikh')
SELECT     TOP (1) Com.tblComputationFormula.fldId, Com.tblComputationFormula.fldType, (Com.tblComputationFormula.fldFormule)fldFormule, Com.tblComputationFormula.fldOrganId, 
                      Com.tblComputationFormula.fldLibrary, Com.tblComputationFormula.fldAzTarikh, Com.tblComputationFormula.fldUserId, Com.tblComputationFormula.fldDesc, 
                      Com.tblComputationFormula.fldDate, Com.fn_stringDecode(tblOrgan.fldName)  AS NameOrgan
                      ,CASE WHEN fldtype=1 THEN N'حقوق' ELSE N'احکام' END AS fldTypeName
FROM         Com.tblComputationFormula INNER JOIN
                      Com.tblOrganization AS tblOrgan ON Com.tblComputationFormula.fldOrganId = tblOrgan.fldId
	WHERE   fldOrganId = @Value  AND fldType=@Value2  AND fldAzTarikh<=@value3 
	ORDER BY fldAzTarikh  DESC
	
	
	if (@fieldname=N'UserId')
SELECT     TOP (@h) Com.tblComputationFormula.fldId, Com.tblComputationFormula.fldType, (Com.tblComputationFormula.fldFormule)fldFormule, Com.tblComputationFormula.fldOrganId, 
                      Com.tblComputationFormula.fldLibrary, Com.tblComputationFormula.fldAzTarikh, Com.tblComputationFormula.fldUserId, Com.tblComputationFormula.fldDesc, 
                      Com.tblComputationFormula.fldDate,Com.fn_stringDecode(tblOrgan.fldName) AS NameOrgan
                      ,CASE WHEN fldtype=1 THEN N'حقوق' ELSE N'احکام' END AS fldTypeName
FROM         Com.tblComputationFormula INNER JOIN
                      Com.tblOrganization AS tblOrgan ON Com.tblComputationFormula.fldOrganId = tblOrgan.fldId
					WHERE  fldOrganId =@OrganId


		if (@fieldname=N'fldDesc')
	BEGIN
	IF(@OrganId <>0)
	SELECT     TOP (@h) Com.tblComputationFormula.fldId, Com.tblComputationFormula.fldType,(Com.tblComputationFormula.fldFormule)fldFormule, Com.tblComputationFormula.fldOrganId, 
                      Com.tblComputationFormula.fldLibrary, Com.tblComputationFormula.fldAzTarikh, Com.tblComputationFormula.fldUserId, Com.tblComputationFormula.fldDesc, 
                      Com.tblComputationFormula.fldDate, Com.fn_stringDecode(tblOrgan.fldName) AS NameOrgan
                      ,CASE WHEN fldtype=1 THEN N'حقوق' ELSE N'احکام' END AS fldTypeName
FROM         Com.tblComputationFormula LEFT outer JOIN
                      Com.tblOrganization AS tblOrgan ON Com.tblComputationFormula.fldOrganId = tblOrgan.fldId
	WHERE  Com.tblComputationFormula.fldId = @Value  AND fldOrganId =@OrganId
	ELSE
		SELECT     TOP (@h) Com.tblComputationFormula.fldId, Com.tblComputationFormula.fldType,/* com.fn_stringDecode*/(Com.tblComputationFormula.fldFormule)fldFormule, Com.tblComputationFormula.fldOrganId, 
                      Com.tblComputationFormula.fldLibrary, Com.tblComputationFormula.fldAzTarikh, Com.tblComputationFormula.fldUserId, Com.tblComputationFormula.fldDesc, 
                      Com.tblComputationFormula.fldDate, Com.fn_stringDecode(tblOrgan.fldName) AS NameOrgan
                      ,CASE WHEN fldtype=1 THEN N'حقوق' ELSE N'احکام' END AS fldTypeName
FROM         Com.tblComputationFormula LEFT outer JOIN
                      Com.tblOrganization AS tblOrgan ON Com.tblComputationFormula.fldOrganId = tblOrgan.fldId
	WHERE  Com.tblComputationFormula.fldDesc like @Value
	END 

	if (@fieldname=N'')
SELECT     TOP (@h) Com.tblComputationFormula.fldId, Com.tblComputationFormula.fldType,  /*com.fn_stringDecode*/(Com.tblComputationFormula.fldFormule)fldFormule, Com.tblComputationFormula.fldOrganId, 
                      Com.tblComputationFormula.fldLibrary, Com.tblComputationFormula.fldAzTarikh, Com.tblComputationFormula.fldUserId, Com.tblComputationFormula.fldDesc, 
                      Com.tblComputationFormula.fldDate,Com.fn_stringDecode(tblOrgan.fldName)  AS NameOrgan
                      ,CASE WHEN fldtype=1 THEN N'حقوق' ELSE N'احکام' END AS fldTypeName
FROM         Com.tblComputationFormula INNER JOIN
                      Com.tblOrganization AS tblOrgan ON Com.tblComputationFormula.fldOrganId = tblOrgan.fldId
                      WHERE   fldOrganId =@OrganId
	
	

	COMMIT
GO
