SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Cnt].[prs_tblTreeGroupSelect] 
@FieldName nvarchar(50),
@Value nvarchar(50),
@GroupId int,
@h int

AS 

	BEGIN TRAN
	if (@h=0) set @h=2147483647
	set @Value=dbo.fn_TextNormalize(@Value)

	if (@FieldName='fldId')
	SELECT top(@h) tblTreeGroup.[fldId], [fldGroupId], [fldPId] ,tblContactGroup.fldNameGroup,fldTitle
	FROM   [Cnt].[tblTreeGroup] inner join Cnt.tblContactGroup
	on fldGroupId=tblContactGroup.fldid
	WHERE  tblTreeGroup.fldId=@Value

	if (@FieldName='fldGroupId')
		SELECT top(@h) tblTreeGroup.[fldId], [fldGroupId], [fldPId] ,tblContactGroup.fldNameGroup,fldTitle
	FROM   [Cnt].[tblTreeGroup] inner join Cnt.tblContactGroup
	on fldGroupId=tblContactGroup.fldid
	WHERE  fldGroupId=@Value


	
	if (@FieldName='fldPId')
	begin
		if(@Value=0)
				SELECT top(@h) tblTreeGroup.[fldId], [fldGroupId], [fldPId] ,tblContactGroup.fldNameGroup,fldTitle
			FROM   [Cnt].[tblTreeGroup] inner join Cnt.tblContactGroup
			on fldGroupId=tblContactGroup.fldid
			WHERE [fldGroupId]=@GroupId and fldPId is null 
		else
			SELECT top(@h) tblTreeGroup.[fldId], [fldGroupId], [fldPId] ,tblContactGroup.fldNameGroup,fldTitle
			FROM   [Cnt].[tblTreeGroup] inner join Cnt.tblContactGroup
			on fldGroupId=tblContactGroup.fldid
			WHERE   [fldGroupId]=@GroupId and fldPId=@Value
	end

	if (@FieldName='')
				SELECT top(@h) tblTreeGroup.[fldId], [fldGroupId], [fldPId] ,tblContactGroup.fldNameGroup,fldTitle
			FROM   [Cnt].[tblTreeGroup] inner join Cnt.tblContactGroup
			on fldGroupId=tblContactGroup.fldid
	COMMIT
GO
