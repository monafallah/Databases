SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Cnt].[prs_tblContact_TreeGroupSelect] 
@FieldName nvarchar(50),
@Value nvarchar(50),
@value2 int,
@h int

AS 

	BEGIN TRAN
	if (@h=0) set @h=2147483647
	set @Value=dbo.fn_TextNormalize(@Value)

	if (@FieldName='fldId')
	SELECT top(@h) tblContact_TreeGroup.[fldId], [fldTreeGroupId], [fldContactId] ,fldNameGroup
	FROM   [Cnt].[tblContact_TreeGroup] inner join tblTreeGroup
	on fldTreeGroupId=tblTreeGroup.fldid
	 inner join cnt.tblContactGroup
	on fldgroupid=tblContactGroup.fldId
	WHERE  tblContact_TreeGroup.fldId=@Value

	if (@FieldName='fldTreeGroupId')
	SELECT top(@h) tblContact_TreeGroup.[fldId], [fldTreeGroupId], [fldContactId] ,fldNameGroup
	FROM   [Cnt].[tblContact_TreeGroup] inner join tblTreeGroup
	on fldTreeGroupId=tblTreeGroup.fldid
	 inner join cnt.tblContactGroup
	on fldgroupid=tblContactGroup.fldId
	WHERE  fldTreeGroupId=@Value

	if (@FieldName='fldContactId')
	SELECT top(@h) tblContact_TreeGroup.[fldId], [fldTreeGroupId], [fldContactId] ,fldNameGroup
	FROM   [Cnt].[tblContact_TreeGroup] inner join tblTreeGroup
	on fldTreeGroupId=tblTreeGroup.fldid
	 inner join cnt.tblContactGroup
	on fldgroupid=tblContactGroup.fldId
	WHERE  fldContactId=@Value

	if (@FieldName='fldTreeGroupId_ContactId')
	SELECT top(@h) tblContact_TreeGroup.[fldId], [fldTreeGroupId], [fldContactId] ,fldNameGroup
	FROM   [Cnt].[tblContact_TreeGroup] inner join tblTreeGroup
	on fldTreeGroupId=tblTreeGroup.fldid
	 inner join cnt.tblContactGroup
	on fldgroupid=tblContactGroup.fldId
	WHERE  fldTreeGroupId=@Value and fldContactId=@value2

	if (@FieldName='')
SELECT top(@h) tblContact_TreeGroup.[fldId], [fldTreeGroupId], [fldContactId] ,fldNameGroup
	FROM   [Cnt].[tblContact_TreeGroup] inner join tblTreeGroup
	on fldTreeGroupId=tblTreeGroup.fldid
	 inner join cnt.tblContactGroup
	on fldgroupid=tblContactGroup.fldId

	
	COMMIT
GO
