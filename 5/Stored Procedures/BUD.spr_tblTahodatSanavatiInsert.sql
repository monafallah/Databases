SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
create PROC [BUD].[spr_tblTahodatSanavatiInsert] 

    @fldD1 bigint = NULL,
    @fldD2 bigint = NULL,
    @fldD3 bigint = NULL,
    @fldH1 bigint = NULL,
    @fldH2 bigint = NULL,
    @fldH3 bigint = NULL,
    @fldH4 bigint = NULL,
    @fldFiscalYearId int,
    @fldUserId int,
    @fldIp varchar(15)
AS 
	
	BEGIN TRAN
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [BUD].[tblTahodatSanavati] 
	INSERT INTO [BUD].[tblTahodatSanavati] ([fldId], [fldD1], [fldD2], [fldD3], [fldH1], [fldH2], [fldH3], [fldH4], [fldFiscalYearId], [fldUserId], [fldIp], [fldDate])
	SELECT @fldId, @fldD1, @fldD2, @fldD3, @fldH1, @fldH2, @fldH3, @fldH4, @fldFiscalYearId, @fldUserId, @fldIp, getdate()
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
