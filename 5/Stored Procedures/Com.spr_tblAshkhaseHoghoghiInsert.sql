SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROC [Com].[spr_tblAshkhaseHoghoghiInsert] 
   
    @fldShenaseMelli nvarchar(11),
    @fldname nvarchar(250),
    @fldShomareSabt nvarchar(20) ,
    @fldUserId int,
    @fldDesc nvarchar(MAX),
    @AshkhasId INT out,
	@fldTypeShakhs TINYINT,
	@fldSayer TINYINT
    
AS 
	
	BEGIN TRAN
	set  @fldShenaseMelli=com.fn_TextNormalize(@fldShenaseMelli)
	set @fldname=com.fn_TextNormalize(@fldname)
	set @fldShomareSabt=com.fn_TextNormalize(@fldShomareSabt)
	set @fldDesc=com.fn_TextNormalize(@fldDesc)
	declare @fldID int ,@flag BIT =0
	select @fldID =ISNULL(max(fldId),0)+1 from [com].[tblAshkhaseHoghoghi] 
	INSERT INTO [com].[tblAshkhaseHoghoghi] ([fldId], [fldShenaseMelli], [fldname], [fldShomareSabt], [fldUserId], [fldDesc], [fldDate],fldTypeShakhs,fldSayer)
	SELECT @fldId, @fldShenaseMelli, @fldname, @fldShomareSabt, @fldUserId, @fldDesc, getdate(),@fldTypeShakhs,@fldSayer
	IF (@@ERROR<>0)
	BEGIN
		SET @flag=1
		ROLLBACK
	END
	IF (@flag=0)
	BEGIN
	select @AshkhasId =ISNULL(max(fldId),0)+1 from [com].[tblAshkhas] 
	INSERT INTO [com].[tblAshkhas] ([fldId], [fldHaghighiId], [fldHoghoghiId], [fldUserId], [fldDesc], [fldDate])
	SELECT @AshkhasId,NULL ,@fldID, @fldUserId, @fldDesc, getdate()
	IF (@@ERROR<>0)
	BEGIN
		SET @flag=1
		ROLLBACK
	END
	END 

	COMMIT
GO
