SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblShomareHesab_FormulaUpdate] 
    @fldId int,
    @fldShomareHesab_CodeId int,
    @fldFormolsaz nvarchar(MAX) = NULL,
    @fldTarikhEjra varchar(10),
    @fldUserId int
AS 

	BEGIN TRAN
	DECLARE @mohasebatid INT=NULL
	SELECT @mohasebatid=fldFormulMohasebatId FROM drd.tblShomareHesab_Formula WHERE fldid=@fldId
	UPDATE [Drd].[tblShomareHesab_Formula]
	SET    [fldShomareHesab_CodeId] = @fldShomareHesab_CodeId, [fldFormolsaz] = @fldFormolsaz, [fldTarikhEjra] = @fldTarikhEjra, [fldDate] = getdate(), [fldUserId] = @fldUserId
	,fldFormulMohasebatId=NULL
	WHERE  fldId=@fldId
	if(@@Error<>0)
        rollback   
	ELSE
    BEGIN
		IF (@mohasebatid IS NOT null)
		DELETE FROM com.tblComputationFormula
		WHERE fldid=@mohasebatid
		if(@@Error<>0)
			ROLLBACK  
	end
	COMMIT
GO
