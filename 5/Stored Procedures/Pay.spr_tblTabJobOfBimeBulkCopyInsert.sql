SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblTabJobOfBimeBulkCopyInsert] 
AS 
	BEGIN TRAN
		update t set fldJobDesc=b.fldJobDesc
		from pay.tblTabJobOfBime as t
		inner join pay.tblTabJobOfBimeBulkCopy as b on t.fldJobCode=b.fldJobCode
		where t.fldJobDesc<>b.fldJobDesc

		insert pay.tblTabJobOfBime(fldJobCode,fldJobDesc)
		select b.fldJobCode,b.fldJobDesc
		from pay.tblTabJobOfBime as t
		right join pay.tblTabJobOfBimeBulkCopy as b on t.fldJobCode=b.fldJobCode
		where t.fldJobCode is null
	COMMIT
GO
