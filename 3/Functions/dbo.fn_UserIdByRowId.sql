SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE function [dbo].[fn_UserIdByRowId](@Rowid varbinary(8),@EnName varchar(100))
returns table
as
return
(select top(1) fldRowId,fldUserSecondId as fldUserId from Trans.tblSubTransaction inner join Trans.tblSubTransactionTables
on fldSubTransactionId=tblSubTransaction.fldid
inner join tblInputInfo on fldInputId=tblInputInfo.fldId inner join Trans.tblNameTables
on fldNameTablesId=tblNameTables.fldId

where fldEnNameTables=@EnName and fldRowId=@Rowid
order by tblSubTransactionTables.fldid desc)
GO
