SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblCodhayeDaramadiElamAvarezDelete] 
	@fieldName nvarchar(50),
	@fldID int,
	@fldElamAvarezId int,
	@fldCodhayeDaramdId int,
	@fldUserId int
	as
	declare @flag bit=0
	if (@fieldname=N'fldId') 
	BEGIN
	DELETE FROM Drd.tblMablaghTakhfif 
	WHERE fldCodeDaramadElamAvarezId=@fldID
	IF(@@ERROR<>0)
	BEGIN
		set @flag=1
		rollback
	END
	IF(@flag=0)
	BEGIN
	UPDATE   Drd.tblSodoorFish_Detail 
		SET fldUserId=@fldUserId , flddate=GETDATE()
		WHERE  fldCodeElamAvarezId=@fldID
		
	DELETE FROM Drd.tblSodoorFish_Detail 
	WHERE fldCodeElamAvarezId=@fldID
	if(@@Error<>0)
		begin
		set @flag=1
		rollback
		END
	end
	if(@flag=0)
	BEGIN
	UPDATE  tblParametreSabet_Value
		SET fldUserId=@fldUserId , flddate=GETDATE()
		WHERE fldCodeDaramadElamAvarezId=@fldid
		
		delete from tblParametreSabet_Value
		where fldCodeDaramadElamAvarezId=@fldid
		if(@@Error<>0)
		begin
			set @flag=1
			rollback
		END
		
	end
	if(@flag=0)
		BEGIN
			UPDATE   [Drd].[tblCodhayeDaramadiElamAvarez]
		SET fldUserId=@fldUserId , flddate=GETDATE()
		WHERE  fldId = @fldId
		
		DELETE
		FROM   [Drd].[tblCodhayeDaramadiElamAvarez]
		WHERE  fldId = @fldId 
		if(@@Error<>0)
			begin
			set @flag=1
			rollback
			end
		END
	end
	--if (@fieldname=N'fldElamAvarezId_CodDaramadId') 
	--DELETE
	--FROM   [Drd].[tblCodhayeDaramadiElamAvarez]
	--WHERE  fldElamAvarezId=@fldElamAvarezId and fldCodhayeDaramdId=@fldCodhayeDaramdId
GO
