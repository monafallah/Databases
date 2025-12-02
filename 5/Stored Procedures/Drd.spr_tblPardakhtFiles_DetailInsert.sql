SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblPardakhtFiles_DetailInsert] 
   
    @fldShenaseGhabz nvarchar(100),
    @fldShenasePardakht nvarchar(100),
    @fldTarikhPardakht nvarchar(10),
    @fldCodeRahgiry nvarchar(100),
    @fldPardakhtFileId int,
    @fldOrganId int,
	@CodePardakht NVARCHAR(2),
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	
	BEGIN TRAN
	set @fldShenaseGhabz=com.fn_TextNormalize(@fldShenaseGhabz)
	set @fldShenasePardakht=com.fn_TextNormalize(@fldShenasePardakht)
	set @fldTarikhPardakht=com.fn_TextNormalize(@fldTarikhPardakht)
	set @fldCodeRahgiry=com.fn_TextNormalize(@fldCodeRahgiry)
	set @fldDesc=com.fn_TextNormalize(@fldDesc)
	declare @fldID INT,@Flag TINYINT=0,@FishId INT=0,@NahvePardakhtId INT=0,@PardakhtFish INT=0
	
	SELECT @NahvePardakhtId=fldId FROM Drd.tblNahvePardakht WHERE cast(fldCodePardakht as int)=@CodePardakht
	IF EXISTS (SELECT * FROM Drd.tblPardakhtFiles_Detail WHERE fldShenaseGhabz=@fldShenaseGhabz AND fldShenasePardakht=@fldShenasePardakht)
	begin
		SELECT @fldID=fldid FROM Drd.tblPardakhtFiles_Detail WHERE fldShenaseGhabz=@fldShenaseGhabz AND fldShenasePardakht=@fldShenasePardakht
		UPDATE Drd.tblPardakhtFiles_Detail 
		SET fldTarikhPardakht=@fldTarikhPardakht,fldCodeRahgiry=@fldCodeRahgiry,fldUserId=@fldUserId,fldDate=GETDATE(),fldDesc=@fldDesc,fldPardakhtFileId=@fldPardakhtFileId
		WHERE fldShenaseGhabz=@fldShenaseGhabz AND fldShenasePardakht=@fldShenasePardakht 
			if (@@ERROR<>0)
			BEGIN
				SET @Flag=1
				ROLLBACK
			END
	END
else
begin
	select @fldID =ISNULL(max(fldId),0)+1 from [Drd].[tblPardakhtFiles_Detail] 
	INSERT INTO [Drd].[tblPardakhtFiles_Detail] ([fldId], [fldShenaseGhabz], [fldShenasePardakht], [fldTarikhPardakht], [fldCodeRahgiry], [fldNahvePardakhtId], [fldPardakhtFileId], [fldOrganId], [fldUserId], [fldDesc], [fldDate])
	SELECT @fldId, @fldShenaseGhabz, @fldShenasePardakht, @fldTarikhPardakht, @fldCodeRahgiry, @NahvePardakhtId, @fldPardakhtFileId, @fldOrganId, @fldUserId, @fldDesc, GETDATE()
	if (@@ERROR<>0)
	BEGIN
		SET @Flag=1
		ROLLBACK
	END
end
	IF(@Flag=0)
	begin
		SELECT @FishId=fldId FROM Drd.tblSodoorFish WHERE fldShenaseGhabz=@fldShenaseGhabz AND fldShenasePardakht=@fldShenasePardakht
		
		IF EXISTS(SELECT * FROM Drd.tblPardakhtFish WHERE fldFishId=@FishId)
		BEGIN
			UPDATE Drd.tblPardakhtFish 
			SET fldDateVariz=Com.ShamsiToMiladi(@fldTarikhPardakht),fldDatePardakht=Com.ShamsiToMiladi(@fldTarikhPardakht)
			,fldNahvePardakhtId=@NahvePardakhtId,fldPardakhtFiles_DetailId=@fldID,
			fldDesc=N'پرداخت از طریق شناسه قبض و شناسه پرداخت',
			fldDate=GETDATE(),fldUserId=@fldUserId
		    WHERE fldFishId=@FishId
			if (@@ERROR<>0)
			BEGIN
				SET @Flag=1
				ROLLBACK
			END
		end
		ELSE
			BEGIN
				select @PardakhtFish =ISNULL(max(fldId),0)+1 from [Drd].tblPardakhtFish 
				INSERT INTO Drd.tblPardakhtFish
				        ( fldId ,
				          fldFishId ,
				          fldDatePardakht ,
				          fldNahvePardakhtId ,
				          fldUserId ,
				          fldDesc ,
				          fldDate,
						  fldPardakhtFiles_DetailId,
						  fldDateVariz
				        )
				VALUES  ( @PardakhtFish , -- fldId - int
				          @FishId , -- fldFishId - int
				          Com.ShamsiToMiladi(@fldTarikhPardakht) , -- fldDatePardakht - datetime
				          @NahvePardakhtId , -- fldNahvePardakhtId - int
				          @fldUserId , -- fldUserId - int
				          N'پرداخت از طریق شناسه قبض و شناسه پرداخت' , -- fldDesc - nvarchar(max)
				          GETDATE()  -- fldDate - datetime
						  ,@fldID,
						  com.ShamsiToMiladi(@fldTarikhPardakht)
				        )
			END 
		END 
declare @organid int,@sal smallint,@salmaliid int,@fldip varchar(15)=''
set @sal=substring(@fldTarikhPardakht,1,4)
	select @salmaliid=fldid from acc.tblFiscalYear where fldOrganId=@fldOrganId and fldYear=@sal
 
 if exists (	select * from com.tblModule_Organ where fldOrganId=@fldOrganId and fldModuleId=10)

	exec [ACC].[spr_DocumentInsert_DaramadFish] @salmaliid,@FishId,@fldOrganId,@fldDesc,@fldip,@fldUserId,10,5
	

	COMMIT
GO
