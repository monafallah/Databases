SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblPspModelSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@h int
AS 
	BEGIN TRAN
	set  @Value=com.fn_TextNormalize(@Value)
	if (@h=0) set @h=2147483647
	if (@fieldname=N'fldId')
	SELECT        TOP (@h) Drd.tblPspModel.fldId, Drd.tblPspModel.fldPspId, Drd.tblPspModel.fldModel, Drd.tblPspModel.fldUserId, Drd.tblPspModel.fldDesc, Drd.tblPspModel.fldDate, Drd.tblPsp.fldTitle
					,fldTitle+N'('+fldModel+N')' AS fldTitleModel,fldMultiHesab,CASE WHEN fldMultiHesab=0 THEN N'تک حسابی' ELSE N'چند حسابی' END fldMultiHesabName
FROM            Drd.tblPspModel INNER JOIN
                         Drd.tblPsp ON Drd.tblPspModel.fldPspId = Drd.tblPsp.fldId
	WHERE  Drd.tblPspModel.fldId = @Value

    if (@fieldname=N'fldModel')
	SELECT        TOP (@h) Drd.tblPspModel.fldId, Drd.tblPspModel.fldPspId, Drd.tblPspModel.fldModel, Drd.tblPspModel.fldUserId, Drd.tblPspModel.fldDesc, Drd.tblPspModel.fldDate, Drd.tblPsp.fldTitle
					,fldTitle+N'('+fldModel+N')' AS fldTitleModel,fldMultiHesab,CASE WHEN fldMultiHesab=0 THEN N'تک حسابی' ELSE N'چند حسابی' END fldMultiHesabName
FROM            Drd.tblPspModel INNER JOIN
                         Drd.tblPsp ON Drd.tblPspModel.fldPspId = Drd.tblPsp.fldId
	WHERE  fldModel like @Value
	
	if (@fieldname=N'fldPspId')
	SELECT        TOP (@h) Drd.tblPspModel.fldId, Drd.tblPspModel.fldPspId, Drd.tblPspModel.fldModel, Drd.tblPspModel.fldUserId, Drd.tblPspModel.fldDesc, Drd.tblPspModel.fldDate, Drd.tblPsp.fldTitle
					,fldTitle+N'('+fldModel+N')' AS fldTitleModel,fldMultiHesab,CASE WHEN fldMultiHesab=0 THEN N'تک حسابی' ELSE N'چند حسابی' END fldMultiHesabName
FROM            Drd.tblPspModel INNER JOIN
                         Drd.tblPsp ON Drd.tblPspModel.fldPspId = Drd.tblPsp.fldId
	WHERE  fldPspId like @Value

	if (@fieldname=N'fldTitle')
	SELECT        TOP (@h) Drd.tblPspModel.fldId, Drd.tblPspModel.fldPspId, Drd.tblPspModel.fldModel, Drd.tblPspModel.fldUserId, Drd.tblPspModel.fldDesc, Drd.tblPspModel.fldDate, Drd.tblPsp.fldTitle
					,fldTitle+N'('+fldModel+N')' AS fldTitleModel,fldMultiHesab,CASE WHEN fldMultiHesab=0 THEN N'تک حسابی' ELSE N'چند حسابی' END fldMultiHesabName
FROM            Drd.tblPspModel INNER JOIN
                         Drd.tblPsp ON Drd.tblPspModel.fldPspId = Drd.tblPsp.fldId
	WHERE  fldTitle like @Value


	if (@fieldname=N'fldDesc')
	SELECT        TOP (@h) Drd.tblPspModel.fldId, Drd.tblPspModel.fldPspId, Drd.tblPspModel.fldModel, Drd.tblPspModel.fldUserId, Drd.tblPspModel.fldDesc, Drd.tblPspModel.fldDate, Drd.tblPsp.fldTitle
					,fldTitle+N'('+fldModel+N')' AS fldTitleModel,fldMultiHesab,CASE WHEN fldMultiHesab=0 THEN N'تک حسابی' ELSE N'چند حسابی' END fldMultiHesabName
FROM            Drd.tblPspModel INNER JOIN
                         Drd.tblPsp ON Drd.tblPspModel.fldPspId = Drd.tblPsp.fldId
	WHERE  Drd.tblPspModel.fldDesc like @Value

	if (@fieldname=N'fldMultiHesabName')
	SELECT        TOP (@h) * FROM (SELECT        TOP (@h) Drd.tblPspModel.fldId, Drd.tblPspModel.fldPspId, Drd.tblPspModel.fldModel, Drd.tblPspModel.fldUserId, Drd.tblPspModel.fldDesc, Drd.tblPspModel.fldDate, Drd.tblPsp.fldTitle
					,fldTitle+N'('+fldModel+N')' AS fldTitleModel,fldMultiHesab,CASE WHEN fldMultiHesab=0 THEN N'تک حسابی' ELSE N'چند حسابی' END fldMultiHesabName
FROM            Drd.tblPspModel INNER JOIN
                         Drd.tblPsp ON Drd.tblPspModel.fldPspId = Drd.tblPsp.fldId) AS t
	WHERE  t.fldMultiHesabName like @Value

	if (@fieldname=N'')
	SELECT        TOP (@h) Drd.tblPspModel.fldId, Drd.tblPspModel.fldPspId, Drd.tblPspModel.fldModel, Drd.tblPspModel.fldUserId, Drd.tblPspModel.fldDesc, Drd.tblPspModel.fldDate, Drd.tblPsp.fldTitle
					,fldTitle+N'('+fldModel+N')' AS fldTitleModel,fldMultiHesab,CASE WHEN fldMultiHesab=0 THEN N'تک حسابی' ELSE N'چند حسابی' END fldMultiHesabName
FROM            Drd.tblPspModel INNER JOIN
                         Drd.tblPsp ON Drd.tblPspModel.fldPspId = Drd.tblPsp.fldId

	COMMIT
GO
