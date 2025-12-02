SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE procedure [Drd].[spr_InsertSodoorFishForNaghdi_Talab]
@fldId int output,
@fldOrganId int,
@fldMablagh bigint,
@fldElamAvarezId int,
@NaghdiTalabId int,
@fldShomareHesabId INT,
@fldUserId int,
@fldDesc nvarchar(MAX)

AS
BEGIN TRAN

declare @fldSh_HesabFishNaghdiId int ,@fldShorooshenaseGhabz tinyint,@fldMablaghGerdKardan bigint,@flag bit=0,@MablaghFish bigint,@JamKol INT
SELECT @fldShorooshenaseGhabz=fldShorooshenaseGhabz,@fldMablaghGerdKardan=fldMablaghGerdKardan from Drd.tblTanzimateDaramad where fldOrganId=@fldOrganId
if(@fldMablaghGerdKardan is not null and  @fldMablaghGerdKardan<>0)
begin
SET @MablaghFish=(@fldMablagh/@fldMablaghGerdKardan)*@fldMablaghGerdKardan
end
else 
begin
SET @MablaghFish=@fldMablagh
end


	SELECT @fldID =ISNULL(max(fldId),0)+1 from [Drd].[tblSodoorFish] 
	INSERT INTO [Drd].[tblSodoorFish] ([fldId], [fldElamAvarezId], [fldShomareHesabId], [fldShenaseGhabz],fldShenasePardakht ,[fldMablaghAvarezGerdShode], [fldShorooShenaseGhabz] , [fldUserId], [fldDesc], [fldDate],fldJamKol,fldBarcode,fldSendToMaliFlag,fldFishSentFlag,fldDateSendToMali,fldDateFishSent)
	SELECT @fldID, @fldElamAvarezId, @fldShomareHesabId, '','' ,@MablaghFish, @fldShorooShenaseGhabz,@fldUserId, @fldDesc, GETDATE(),@fldMablagh,'',0,0,NULL,NULL
		if (@@ERROR<>0)
			 begin
			  set @flag=1
			  ROLLBACK
			 end
	if(@flag=0)
	begin
		UPDATE [Drd].[tblNaghdi_Talab]
		SET    fldFishId=@fldID 
		WHERE  fldID=@NaghdiTalabId
			IF (@@ERROR<>0)
			 begin
			  set @flag=1
			  ROLLBACK
			END	    
   end



COMMIT
GO
