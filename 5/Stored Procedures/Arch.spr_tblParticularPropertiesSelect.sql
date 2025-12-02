SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Arch].[spr_tblParticularPropertiesSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@h int
AS 
	BEGIN TRAN
	SET @Value=Com.fn_TextNormalize(@Value)
	if (@h=0) set @h=2147483647
	if (@fieldname=N'fldId')
	SELECT top(@h) tblParticularProperties.fldId, [fldArchiveTreeId], [fldPropertiesId], tblParticularProperties.fldUserId, tblParticularProperties.fldDesc,
	tblParticularProperties .fldDate ,tblArchiveTree.fldTitle,tblArchiveTree.fldTitle+' ('+ tblProperties.fldNameFn+')'fldNameFn
	  
	FROM   [Arch].[tblParticularProperties] 
	inner join tblArchiveTree on tblParticularProperties.fldArchiveTreeId= tblArchiveTree.fldId
	inner join tblProperties on tblParticularProperties.fldPropertiesId=tblProperties.fldId
	WHERE  tblParticularProperties.fldId = @Value

	if (@fieldname=N'fldDesc')
	SELECT top(@h) tblParticularProperties.fldId, [fldArchiveTreeId], [fldPropertiesId], tblParticularProperties.fldUserId, tblParticularProperties.fldDesc,
	tblParticularProperties .fldDate ,tblArchiveTree.fldTitle,tblArchiveTree.fldTitle+' ('+ tblProperties.fldNameFn+')'fldNameFn
	FROM   [Arch].[tblParticularProperties] 
	inner join tblArchiveTree on tblParticularProperties.fldArchiveTreeId= tblArchiveTree.fldId
	inner join tblProperties on tblParticularProperties.fldPropertiesId=tblProperties.fldId
	WHERE tblParticularProperties.fldDesc like  @Value

	if (@fieldname=N'fldNameFn')
	select  top(@h) * from( SELECT tblParticularProperties.fldId, [fldArchiveTreeId], [fldPropertiesId], tblParticularProperties.fldUserId, tblParticularProperties.fldDesc,
	tblParticularProperties .fldDate ,tblArchiveTree.fldTitle,tblArchiveTree.fldTitle+' ('+ tblProperties.fldNameFn+')'fldNameFn
	FROM   [Arch].[tblParticularProperties] 
	inner join tblArchiveTree on tblParticularProperties.fldArchiveTreeId= tblArchiveTree.fldId
	inner join tblProperties on tblParticularProperties.fldPropertiesId=tblProperties.fldId)t
	WHERE fldNameFn like  @Value

	if (@fieldname=N'fldTitle')
	SELECT top(@h) tblParticularProperties.fldId, [fldArchiveTreeId], [fldPropertiesId], tblParticularProperties.fldUserId, tblParticularProperties.fldDesc,
	tblParticularProperties .fldDate ,tblArchiveTree.fldTitle,tblArchiveTree.fldTitle+' ('+ tblProperties.fldNameFn+')'fldNameFn
	FROM   [Arch].[tblParticularProperties] 
	inner join tblArchiveTree on tblParticularProperties.fldArchiveTreeId= tblArchiveTree.fldId
	inner join tblProperties on tblParticularProperties.fldPropertiesId=tblProperties.fldId
	WHERE tblArchiveTree.fldTitle like  @Value

	if (@fieldname=N'fldArchiveTreeId')
	SELECT top(@h) tblParticularProperties.fldId, [fldArchiveTreeId], [fldPropertiesId], tblParticularProperties.fldUserId, tblParticularProperties.fldDesc,
	tblParticularProperties .fldDate ,tblArchiveTree.fldTitle,tblArchiveTree.fldTitle+' ('+ tblProperties.fldNameFn+')'fldNameFn
	  
	FROM   [Arch].[tblParticularProperties] 
	inner join tblArchiveTree on tblParticularProperties.fldArchiveTreeId= tblArchiveTree.fldId
	inner join tblProperties on tblParticularProperties.fldPropertiesId=tblProperties.fldId
	WHERE fldArchiveTreeId like  @Value

	if (@fieldname=N'fldPropertiesId')
	SELECT top(@h) tblParticularProperties.fldId, [fldArchiveTreeId], [fldPropertiesId], tblParticularProperties.fldUserId, tblParticularProperties.fldDesc,
	tblParticularProperties .fldDate ,tblArchiveTree.fldTitle,tblArchiveTree.fldTitle+' ('+ tblProperties.fldNameFn+')'fldNameFn
	  
	FROM   [Arch].[tblParticularProperties] 
	inner join tblArchiveTree on tblParticularProperties.fldArchiveTreeId= tblArchiveTree.fldId
	inner join tblProperties on tblParticularProperties.fldPropertiesId=tblProperties.fldId 
	WHERE fldPropertiesId like  @Value

	if (@fieldname=N'')
SELECT top(@h) tblParticularProperties.fldId, [fldArchiveTreeId], [fldPropertiesId], tblParticularProperties.fldUserId, tblParticularProperties.fldDesc,
	tblParticularProperties .fldDate ,tblArchiveTree.fldTitle,tblArchiveTree.fldTitle+' ('+ tblProperties.fldNameFn+')'fldNameFn
	  
	FROM   [Arch].[tblParticularProperties] 
	inner join tblArchiveTree on tblParticularProperties.fldArchiveTreeId= tblArchiveTree.fldId
	inner join tblProperties on tblParticularProperties.fldPropertiesId=tblProperties.fldId

	COMMIT
GO
