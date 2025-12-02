SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblParametreSabet_ValueDelete] 
	@fldElamAvarezId int,
	@fldShomareHesabCodeDaramadId int,
	@fldUserID int
AS 
	BEGIN TRAN

	--DELETE
---	FROM   [Drd].[tblParametreSabet_Value]
	--WHERE  fldId = @fldId
	if(@fldShomareHesabCodeDaramadId<>0)
	begin
	DECLARE @t TABLE (Id INT)
	INSERT INTO @t 
	        ( Id )
	SELECT fldId FROM Drd.tblParametreSabet WHERE fldShomareHesabCodeDaramadId=@fldShomareHesabCodeDaramadId	
	
	
		UPDATE  Drd.tblParametreSabet_Value
		SET fldUserId=@fldUserId , flddate=GETDATE()
		WHERE fldParametreSabetId IN (SELECT id FROM @t) AND fldElamAvarezId=@fldElamAvarezId
	DELETE FROM Drd.tblParametreSabet_Value
	WHERE fldParametreSabetId IN (SELECT id FROM @t) AND fldElamAvarezId=@fldElamAvarezId
	end
	else
	DELETE FROM Drd.tblParametreSabet_Value 
	where fldCodeDaramadElamAvarezId=@fldElamAvarezId

	COMMIT
GO
