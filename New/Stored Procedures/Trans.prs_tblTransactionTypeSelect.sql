SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Trans].[prs_tblTransactionTypeSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@h int
AS 
	BEGIN TRAN
	SET @Value=dbo.fn_TextNormalize(@Value)
	if (@h=0) set @h=2147483647
	if (@fieldname=N'fldId')
SELECT     top(@h) tblTransactionType. fldId, Trans.tblTransactionType.fldName, Trans.tblTransactionType.fldTransactionGroupId, Trans.tblTransactionGroup.fldName AS fldNameGroup
,fldFileId ,fldFile,fldPasvand,fldFileName
FROM        Trans.tblTransactionType INNER JOIN
                  Trans.tblTransactionGroup ON Trans.tblTransactionType.fldTransactionGroupId = Trans.tblTransactionGroup.fldId
	left join tblfile on fldfileid=tblfile.fldid
	WHERE  tblTransactionType.fldId = @Value

	if (@fieldname=N'fldTransactionGroupId')
SELECT     top(@h) tblTransactionType. fldId, Trans.tblTransactionType.fldName, Trans.tblTransactionType.fldTransactionGroupId, Trans.tblTransactionGroup.fldName AS fldNameGroup
,fldFileId ,fldFile,fldPasvand,fldFileName
FROM        Trans.tblTransactionType INNER JOIN
                  Trans.tblTransactionGroup ON Trans.tblTransactionType.fldTransactionGroupId = Trans.tblTransactionGroup.fldId
	left join tblfile on fldfileid=tblfile.fldid	
	WHERE  tblTransactionType.fldTransactionGroupId = @Value

	if (@fieldname=N'fldName')
SELECT     top(@h) tblTransactionType. fldId, Trans.tblTransactionType.fldName, Trans.tblTransactionType.fldTransactionGroupId, Trans.tblTransactionGroup.fldName AS fldNameGroup
,fldFileId ,fldFile,fldPasvand,fldFileName
FROM        Trans.tblTransactionType INNER JOIN
                  Trans.tblTransactionGroup ON Trans.tblTransactionType.fldTransactionGroupId = Trans.tblTransactionGroup.fldId
	left join tblfile on fldfileid=tblfile.fldid	
	WHERE  tblTransactionType.fldName like @Value

	if (@fieldname=N'fldNameGroup')
select * from( SELECT     tblTransactionType. fldId, Trans.tblTransactionType.fldName, Trans.tblTransactionType.fldTransactionGroupId, Trans.tblTransactionGroup.fldName AS fldNameGroup
,fldFileId ,fldFile,fldPasvand,fldFileName
FROM        Trans.tblTransactionType INNER JOIN
                  Trans.tblTransactionGroup ON Trans.tblTransactionType.fldTransactionGroupId = Trans.tblTransactionGroup.fldId
	left join tblfile on fldfileid=tblfile.fldid)t
	WHERE  fldNameGroup like @Value

	if (@fieldname=N'')
	SELECT     top(@h) tblTransactionType. fldId, Trans.tblTransactionType.fldName, Trans.tblTransactionType.fldTransactionGroupId, Trans.tblTransactionGroup.fldName AS fldNameGroup
,fldFileId ,fldFile,fldPasvand,fldFileName
FROM        Trans.tblTransactionType INNER JOIN
                  Trans.tblTransactionGroup ON Trans.tblTransactionType.fldTransactionGroupId = Trans.tblTransactionGroup.fldId
	left join tblfile on fldfileid=tblfile.fldid

	COMMIT
GO
