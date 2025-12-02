SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Arch].[spr_tblPropertiesValuesSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@h int
AS 
	BEGIN TRAN
		SET @Value=Com.fn_TextNormalize(@Value)
	if (@h=0) set @h=2147483647
	if (@fieldname=N'fldId')
SELECT        TOP (@h) Arch.tblPropertiesValues.fldId, Arch.tblPropertiesValues.fldParticularId, Arch.tblPropertiesValues.fldValue, Arch.tblPropertiesValues.fldUserId, Arch.tblPropertiesValues.fldDesc, 
                         Arch.tblPropertiesValues.fldDate,tblArchiveTree.fldTitle+' ('+ tblProperties.fldNameFn+')'fldNameFn, Arch.tblArchiveTree.fldTitle
FROM            Arch.tblPropertiesValues INNER JOIN
                         Arch.tblParticularProperties ON Arch.tblPropertiesValues.fldParticularId = Arch.tblParticularProperties.fldId INNER JOIN
                         Arch.tblArchiveTree ON Arch.tblParticularProperties.fldArchiveTreeId = Arch.tblArchiveTree.fldId INNER JOIN
                         Arch.tblProperties ON Arch.tblParticularProperties.fldPropertiesId = Arch.tblProperties.fldId
	WHERE  tblPropertiesValues.fldId = @Value

	if (@fieldname=N'fldParticularId')
	SELECT        TOP (@h) Arch.tblPropertiesValues.fldId, Arch.tblPropertiesValues.fldParticularId, Arch.tblPropertiesValues.fldValue, Arch.tblPropertiesValues.fldUserId, Arch.tblPropertiesValues.fldDesc, 
                         Arch.tblPropertiesValues.fldDate,tblArchiveTree.fldTitle+' ('+ tblProperties.fldNameFn+')'fldNameFn, Arch.tblArchiveTree.fldTitle
FROM            Arch.tblPropertiesValues INNER JOIN
                         Arch.tblParticularProperties ON Arch.tblPropertiesValues.fldParticularId = Arch.tblParticularProperties.fldId INNER JOIN
                         Arch.tblArchiveTree ON Arch.tblParticularProperties.fldArchiveTreeId = Arch.tblArchiveTree.fldId INNER JOIN
                         Arch.tblProperties ON Arch.tblParticularProperties.fldPropertiesId = Arch.tblProperties.fldId
	WHERE fldParticularId =  @Value

	if (@fieldname=N'fldDesc')
	SELECT        TOP (@h) Arch.tblPropertiesValues.fldId, Arch.tblPropertiesValues.fldParticularId, Arch.tblPropertiesValues.fldValue, Arch.tblPropertiesValues.fldUserId, Arch.tblPropertiesValues.fldDesc, 
                         Arch.tblPropertiesValues.fldDate,tblArchiveTree.fldTitle+' ('+ tblProperties.fldNameFn+')'fldNameFn, Arch.tblArchiveTree.fldTitle
FROM            Arch.tblPropertiesValues INNER JOIN
                         Arch.tblParticularProperties ON Arch.tblPropertiesValues.fldParticularId = Arch.tblParticularProperties.fldId INNER JOIN
                         Arch.tblArchiveTree ON Arch.tblParticularProperties.fldArchiveTreeId = Arch.tblArchiveTree.fldId INNER JOIN
                         Arch.tblProperties ON Arch.tblParticularProperties.fldPropertiesId = Arch.tblProperties.fldId
	WHERE tblPropertiesValues.fldDesc like  @Value

	if (@fieldname=N'fldNameFn')
select  TOP (@h)  * from(	SELECT       Arch.tblPropertiesValues.fldId, Arch.tblPropertiesValues.fldParticularId, Arch.tblPropertiesValues.fldValue, Arch.tblPropertiesValues.fldUserId, Arch.tblPropertiesValues.fldDesc, 
                         Arch.tblPropertiesValues.fldDate,tblArchiveTree.fldTitle+' ('+ tblProperties.fldNameFn+')'fldNameFn, Arch.tblArchiveTree.fldTitle
FROM            Arch.tblPropertiesValues INNER JOIN
                         Arch.tblParticularProperties ON Arch.tblPropertiesValues.fldParticularId = Arch.tblParticularProperties.fldId INNER JOIN
                         Arch.tblArchiveTree ON Arch.tblParticularProperties.fldArchiveTreeId = Arch.tblArchiveTree.fldId INNER JOIN
                         Arch.tblProperties ON Arch.tblParticularProperties.fldPropertiesId = Arch.tblProperties.fldId)t
	WHERE fldNameFn like  @Value

	if (@fieldname=N'fldValue')
	SELECT        TOP (@h) Arch.tblPropertiesValues.fldId, Arch.tblPropertiesValues.fldParticularId, Arch.tblPropertiesValues.fldValue, Arch.tblPropertiesValues.fldUserId, Arch.tblPropertiesValues.fldDesc, 
                         Arch.tblPropertiesValues.fldDate,tblArchiveTree.fldTitle+' ('+ tblProperties.fldNameFn+')'fldNameFn, Arch.tblArchiveTree.fldTitle
FROM            Arch.tblPropertiesValues INNER JOIN
                         Arch.tblParticularProperties ON Arch.tblPropertiesValues.fldParticularId = Arch.tblParticularProperties.fldId INNER JOIN
                         Arch.tblArchiveTree ON Arch.tblParticularProperties.fldArchiveTreeId = Arch.tblArchiveTree.fldId INNER JOIN
                         Arch.tblProperties ON Arch.tblParticularProperties.fldPropertiesId = Arch.tblProperties.fldId
	WHERE tblPropertiesValues.fldValue like  @Value

	if (@fieldname=N'')
	SELECT        TOP (@h) Arch.tblPropertiesValues.fldId, Arch.tblPropertiesValues.fldParticularId, Arch.tblPropertiesValues.fldValue, Arch.tblPropertiesValues.fldUserId, Arch.tblPropertiesValues.fldDesc, 
                         Arch.tblPropertiesValues.fldDate,tblArchiveTree.fldTitle+' ('+ tblProperties.fldNameFn+')'fldNameFn, Arch.tblArchiveTree.fldTitle
FROM            Arch.tblPropertiesValues INNER JOIN
                         Arch.tblParticularProperties ON Arch.tblPropertiesValues.fldParticularId = Arch.tblParticularProperties.fldId INNER JOIN
                         Arch.tblArchiveTree ON Arch.tblParticularProperties.fldArchiveTreeId = Arch.tblArchiveTree.fldId INNER JOIN
                         Arch.tblProperties ON Arch.tblParticularProperties.fldPropertiesId = Arch.tblProperties.fldId

	COMMIT
GO
