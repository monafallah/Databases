SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Trans].[prs_tblEventTablesSelect] 
	@fieldname nvarchar(50),
	@Value nvarchar(50),
	@h int
AS 
	BEGIN TRAN
	SET @Value=dbo.fn_TextNormalize(@Value)
	if (@h=0) set @h=2147483647
	if (@fieldname=N'fldId')
	SELECT     top(@h) tblEventTables. fldId, Trans.tblEventTables.fldNameTablesId, Trans.tblEventTables.fldEventTypeId, Trans.tblEventTables.fldFormulId, Trans.tblEventTables.fldFlag, 
	Trans.tblEventType.fldName as fldNameType, Trans.tblNameTables.fldFaName
,fldEnNameTables,case when fldFlag=0 then N'Theard اصلی'else N'Theard جدا' end as fldNameFlag
FROM        Trans.tblEventTables INNER JOIN
                  Trans.tblNameTables ON Trans.tblEventTables.fldNameTablesId = Trans.tblNameTables.fldId INNER JOIN
                  Trans.tblEventType ON Trans.tblEventTables.fldEventTypeId = Trans.tblEventType.fldId
	WHERE  tblEventTables.fldId = @Value
	
	if (@fieldname=N'fldEnNameTables')
	SELECT     top(@h) tblEventTables. fldId, Trans.tblEventTables.fldNameTablesId, Trans.tblEventTables.fldEventTypeId, Trans.tblEventTables.fldFormulId, Trans.tblEventTables.fldFlag, 
	Trans.tblEventType.fldName as fldNameType, Trans.tblNameTables.fldFaName 
,fldEnNameTables,case when fldFlag=0 then N'Theard اصلی'else N'Theard جدا' end as fldNameFlag
FROM        Trans.tblEventTables INNER JOIN
                  Trans.tblNameTables ON Trans.tblEventTables.fldNameTablesId = Trans.tblNameTables.fldId INNER JOIN
                  Trans.tblEventType ON Trans.tblEventTables.fldEventTypeId = Trans.tblEventType.fldId
	WHERE  fldEnNameTables = @Value
	

	if (@fieldname=N'')
	SELECT     top(@h) tblEventTables. fldId, Trans.tblEventTables.fldNameTablesId, Trans.tblEventTables.fldEventTypeId, Trans.tblEventTables.fldFormulId, Trans.tblEventTables.fldFlag, 
	Trans.tblEventType.fldName as fldNameType, Trans.tblNameTables.fldFaName 
,fldEnNameTables,case when fldFlag=0 then N'Theard اصلی'else N'Theard جدا' end as fldNameFlag
FROM        Trans.tblEventTables INNER JOIN
                  Trans.tblNameTables ON Trans.tblEventTables.fldNameTablesId = Trans.tblNameTables.fldId INNER JOIN
                  Trans.tblEventType ON Trans.tblEventTables.fldEventTypeId = Trans.tblEventType.fldId

	COMMIT
GO
