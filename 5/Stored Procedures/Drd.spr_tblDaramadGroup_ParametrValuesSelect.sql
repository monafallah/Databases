SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblDaramadGroup_ParametrValuesSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@h int
AS 
	BEGIN TRAN

	SET @Value=com.fn_TextNormalize(@Value)
	if (@h=0) set @h=2147483647
	if (@fieldname=N'fldId')
	SELECT        TOP (@h) Drd.tblDaramadGroup_ParametrValues.fldId, Drd.tblDaramadGroup_ParametrValues.fldElamAvarezId, Drd.tblDaramadGroup_ParametrValues.fldParametrGroupDaramadId, 
                         Drd.tblDaramadGroup_ParametrValues.fldValue, Drd.tblDaramadGroup_ParametrValues.fldUserId, Drd.tblDaramadGroup_ParametrValues.fldDesc, Drd.tblDaramadGroup_ParametrValues.fldDate, 
                         Drd.tblDaramadGroup_Parametr.fldFnName
FROM            Drd.tblDaramadGroup_ParametrValues INNER JOIN
                         Drd.tblDaramadGroup_Parametr ON Drd.tblDaramadGroup_ParametrValues.fldParametrGroupDaramadId = Drd.tblDaramadGroup_Parametr.fldId
	WHERE  tblDaramadGroup_ParametrValues.fldId = @Value
	
	if (@fieldname=N'fldParametrGroupDaramadId')
	SELECT        TOP (@h) Drd.tblDaramadGroup_ParametrValues.fldId, Drd.tblDaramadGroup_ParametrValues.fldElamAvarezId, Drd.tblDaramadGroup_ParametrValues.fldParametrGroupDaramadId, 
                         Drd.tblDaramadGroup_ParametrValues.fldValue, Drd.tblDaramadGroup_ParametrValues.fldUserId, Drd.tblDaramadGroup_ParametrValues.fldDesc, Drd.tblDaramadGroup_ParametrValues.fldDate, 
                         Drd.tblDaramadGroup_Parametr.fldFnName
FROM            Drd.tblDaramadGroup_ParametrValues INNER JOIN
                         Drd.tblDaramadGroup_Parametr ON Drd.tblDaramadGroup_ParametrValues.fldParametrGroupDaramadId = Drd.tblDaramadGroup_Parametr.fldId
	WHERE  fldParametrGroupDaramadId = @Value
	
	if (@fieldname=N'fldElamAvarezId')
	SELECT        TOP (@h) Drd.tblDaramadGroup_ParametrValues.fldId, Drd.tblDaramadGroup_ParametrValues.fldElamAvarezId, Drd.tblDaramadGroup_ParametrValues.fldParametrGroupDaramadId, 
                         Drd.tblDaramadGroup_ParametrValues.fldValue, Drd.tblDaramadGroup_ParametrValues.fldUserId, Drd.tblDaramadGroup_ParametrValues.fldDesc, Drd.tblDaramadGroup_ParametrValues.fldDate, 
                         Drd.tblDaramadGroup_Parametr.fldFnName
FROM            Drd.tblDaramadGroup_ParametrValues INNER JOIN
                         Drd.tblDaramadGroup_Parametr ON Drd.tblDaramadGroup_ParametrValues.fldParametrGroupDaramadId = Drd.tblDaramadGroup_Parametr.fldId
	WHERE  fldElamAvarezId = @Value

	if (@fieldname=N'fldDesc')
	SELECT        TOP (@h) Drd.tblDaramadGroup_ParametrValues.fldId, Drd.tblDaramadGroup_ParametrValues.fldElamAvarezId, Drd.tblDaramadGroup_ParametrValues.fldParametrGroupDaramadId, 
                         Drd.tblDaramadGroup_ParametrValues.fldValue, Drd.tblDaramadGroup_ParametrValues.fldUserId, Drd.tblDaramadGroup_ParametrValues.fldDesc, Drd.tblDaramadGroup_ParametrValues.fldDate, 
                         Drd.tblDaramadGroup_Parametr.fldFnName
FROM            Drd.tblDaramadGroup_ParametrValues INNER JOIN
                         Drd.tblDaramadGroup_Parametr ON Drd.tblDaramadGroup_ParametrValues.fldParametrGroupDaramadId = Drd.tblDaramadGroup_Parametr.fldId
	WHERE tblDaramadGroup_ParametrValues.fldDesc like  @Value

	if (@fieldname=N'')
	SELECT        TOP (@h) Drd.tblDaramadGroup_ParametrValues.fldId, Drd.tblDaramadGroup_ParametrValues.fldElamAvarezId, Drd.tblDaramadGroup_ParametrValues.fldParametrGroupDaramadId, 
                         Drd.tblDaramadGroup_ParametrValues.fldValue, Drd.tblDaramadGroup_ParametrValues.fldUserId, Drd.tblDaramadGroup_ParametrValues.fldDesc, Drd.tblDaramadGroup_ParametrValues.fldDate, 
                         Drd.tblDaramadGroup_Parametr.fldFnName
FROM            Drd.tblDaramadGroup_ParametrValues INNER JOIN
                         Drd.tblDaramadGroup_Parametr ON Drd.tblDaramadGroup_ParametrValues.fldParametrGroupDaramadId = Drd.tblDaramadGroup_Parametr.fldId

	COMMIT
GO
