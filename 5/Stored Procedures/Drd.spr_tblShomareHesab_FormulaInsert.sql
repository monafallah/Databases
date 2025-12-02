SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblShomareHesab_FormulaInsert] 
   
    @fldShomareHesab_CodeId int,
    @fldFormolsaz nvarchar(MAX) = NULL,
    @fldFormulKoliId int = NULL,
    @fldFormulMohasebatId int = NULL,
    @fldTarikhEjra varchar(10),
    @fldUserId int
AS 

	
	BEGIN TRAN
	declare  @fldId int

	select @fldID =ISNULL(max(fldId),0)+1 from [Drd].[tblShomareHesab_Formula] 

	INSERT INTO [Drd].[tblShomareHesab_Formula] ([fldId], [fldShomareHesab_CodeId], [fldFormolsaz], [fldFormulKoliId], [fldFormulMohasebatId], [fldTarikhEjra], [fldDate], [fldUserId],fldActive)
	SELECT @fldId, @fldShomareHesab_CodeId, @fldFormolsaz, @fldFormulKoliId, @fldFormulMohasebatId, @fldTarikhEjra, getdate(), @fldUserId,1
	if(@@Error<>0)
        rollback       
	COMMIT
GO
