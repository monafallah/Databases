SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Trans].[prs_tblEventSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@h int
AS 
	BEGIN TRAN
	SET @Value=dbo.fn_TextNormalize(@Value)
	if (@h=0) set @h=2147483647
	if (@fieldname=N'fldId')
	SELECT     top(@h) tblEvent. fldId, Trans.tblEvent.fldTransactionTypeId,fldTransactionGroupId, Trans.tblEvent.fldFormulId, Trans.tblEvent.fldFlag
,tblEvent.fldDesc,
 Trans.tblTransactionType.fldName AS fldTypeName,Trans.tblTransactionGroup.fldName AS fldGroupName
,case when fldFlag=0 then N'Theard اصلی'else N'Theard جدا' end as fldNameFlag
FROM        Trans.tblEvent INNER JOIN
                  Trans.tblTransactionType ON Trans.tblEvent.fldTransactionTypeId = Trans.tblTransactionType.fldId INNER JOIN
                  Trans.tblTransactionGroup ON Trans.tblTransactionType.fldTransactionGroupId = Trans.tblTransactionGroup.fldId
	WHERE  tblEvent.fldId = @Value

	if (@fieldname=N'fldGroupName')
	SELECT     top(@h) tblEvent. fldId, Trans.tblEvent.fldTransactionTypeId,fldTransactionGroupId, Trans.tblEvent.fldFormulId, Trans.tblEvent.fldFlag
,tblEvent.fldDesc,
 Trans.tblTransactionType.fldName AS fldTypeName,Trans.tblTransactionGroup.fldName AS fldGroupName
,case when fldFlag=0 then N'Theard اصلی'else N'Theard جدا' end as fldNameFlag
FROM        Trans.tblEvent INNER JOIN
                  Trans.tblTransactionType ON Trans.tblEvent.fldTransactionTypeId = Trans.tblTransactionType.fldId INNER JOIN
                  Trans.tblTransactionGroup ON Trans.tblTransactionType.fldTransactionGroupId = Trans.tblTransactionGroup.fldId
	WHERE  Trans.tblTransactionGroup.fldName like @Value

	if (@fieldname=N'fldTypeName')
	SELECT     top(@h) tblEvent. fldId, Trans.tblEvent.fldTransactionTypeId,fldTransactionGroupId, Trans.tblEvent.fldFormulId, Trans.tblEvent.fldFlag
,tblEvent.fldDesc,
 Trans.tblTransactionType.fldName AS fldTypeName,Trans.tblTransactionGroup.fldName AS fldGroupName
,case when fldFlag=0 then N'Theard اصلی'else N'Theard جدا' end as fldNameFlag
FROM        Trans.tblEvent INNER JOIN
                  Trans.tblTransactionType ON Trans.tblEvent.fldTransactionTypeId = Trans.tblTransactionType.fldId INNER JOIN
                  Trans.tblTransactionGroup ON Trans.tblTransactionType.fldTransactionGroupId = Trans.tblTransactionGroup.fldId
	WHERE  Trans.tblTransactionType.fldName  like @Value
	
	if (@fieldname=N'fldNameFlag')
	select  top(@h)* from(SELECT     tblEvent. fldId, Trans.tblEvent.fldTransactionTypeId,fldTransactionGroupId, Trans.tblEvent.fldFormulId, Trans.tblEvent.fldFlag
,tblEvent.fldDesc,
 Trans.tblTransactionType.fldName AS fldTypeName,Trans.tblTransactionGroup.fldName AS fldGroupName
,case when fldFlag=0 then N'Theard اصلی'else N'Theard جدا' end as fldNameFlag
FROM        Trans.tblEvent INNER JOIN
                  Trans.tblTransactionType ON Trans.tblEvent.fldTransactionTypeId = Trans.tblTransactionType.fldId INNER JOIN
                  Trans.tblTransactionGroup ON Trans.tblTransactionType.fldTransactionGroupId = Trans.tblTransactionGroup.fldId)t
	WHERE  fldNameFlag  like @Value
	
	if (@fieldname=N'fldTransactionTypeId')
	SELECT     top(@h) tblEvent. fldId, Trans.tblEvent.fldTransactionTypeId,fldTransactionGroupId, Trans.tblEvent.fldFormulId, Trans.tblEvent.fldFlag
,tblEvent.fldDesc,
 Trans.tblTransactionType.fldName AS fldTypeName,Trans.tblTransactionGroup.fldName AS fldGroupName
,case when fldFlag=0 then N'Theard اصلی'else N'Theard جدا' end as fldNameFlag
FROM        Trans.tblEvent INNER JOIN
                  Trans.tblTransactionType ON Trans.tblEvent.fldTransactionTypeId = Trans.tblTransactionType.fldId INNER JOIN
                  Trans.tblTransactionGroup ON Trans.tblTransactionType.fldTransactionGroupId = Trans.tblTransactionGroup.fldId
WHERE  tblEvent.fldTransactionTypeId = @Value
	
	if (@fieldname=N'')
	SELECT     top(@h) tblEvent. fldId, Trans.tblEvent.fldTransactionTypeId,fldTransactionGroupId, Trans.tblEvent.fldFormulId, Trans.tblEvent.fldFlag
,tblEvent.fldDesc,
 Trans.tblTransactionType.fldName AS fldTypeName,Trans.tblTransactionGroup.fldName AS fldGroupName
,case when fldFlag=0 then N'Theard اصلی'else N'Theard جدا' end as fldNameFlag
FROM        Trans.tblEvent INNER JOIN
                  Trans.tblTransactionType ON Trans.tblEvent.fldTransactionTypeId = Trans.tblTransactionType.fldId INNER JOIN
                  Trans.tblTransactionGroup ON Trans.tblTransactionType.fldTransactionGroupId = Trans.tblTransactionGroup.fldId


	COMMIT
GO
