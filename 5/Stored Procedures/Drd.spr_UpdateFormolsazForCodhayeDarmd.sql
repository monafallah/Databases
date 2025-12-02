SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROC [Drd].[spr_UpdateFormolsazForCodhayeDarmd]
 @fldShomareHesabCodeDaramadId INT,
 @fldFormolsaz nvarchar(MAX)

AS
DECLARE @fldFormulMohasebatId INT,@flag BIT=0
SELECT @fldFormulMohasebatId=fldFormulMohasebatId FROM Drd.tblShomareHesabCodeDaramad WHERE fldId=@fldShomareHesabCodeDaramadId
   IF((SELECT fldFormulMohasebatId FROM Drd.tblShomareHesabCodeDaramad WHERE fldId=@fldShomareHesabCodeDaramadId) IS NOT NULL)
   BEGIN
		UPDATE Drd.tblShomareHesabCodeDaramad
		SET fldFormulMohasebatId=NULL
		WHERE fldId=@fldShomareHesabCodeDaramadId
		IF(@@ERROR<>0)
		BEGIN
			SET @flag=1
			ROLLBACK
		END
		IF(@flag=0)
		BEGIN
		DELETE FROM Com.tblComputationFormula
		WHERE fldId=@fldFormulMohasebatId
			IF(@@ERROR<>0)
			ROLLBACK
		END
	eND
		
		UPDATE [Drd].[tblShomareHesabCodeDaramad]
		SET   fldFormolsaz=@fldFormolsaz
		WHERE   [fldId] = @fldShomareHesabCodeDaramadId



GO
