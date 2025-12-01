SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE proc [Trans].[prs_tblNameTablesInsert]
as
begin tran
insert [Trans].[tblNameTables]
	select t.name,object_id, cast(value as nvarchar(100)) as PersianName
	from sys.tables as t
	inner join  sys.extended_properties as e on major_id=object_id and e.name='PersianName'
	where temporal_type=2 and  not exists (
	select * from [Trans].[tblNameTables] where fldEnNameTables=t.name)

	--INSERT INTO [Trans].[tblTransactionType] ([fldName], [fldTransactionGroupId])
	--SELECT fldName, 2 from tblNameTable as n
	--where fldName<>'' and not exists(select * from [Trans].[tblTransactionType] as t where n.fldName=t.fldName) 
commit tran

GO
