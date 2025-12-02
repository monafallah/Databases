SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblEmployeeInsert] 
  
    @fldName nvarchar(100),
    @fldFamily nvarchar(100),
    @fldCodemeli NVARCHAR(50),
    @fldStatus BIT,
    @fldUserId int,
    @fldDesc nvarchar(MAX),
    @AshkhasId INT out,
	@fldTypeShakhs tinyint
AS 
	
	BEGIN TRAN
	SET @fldName=Com.fn_TextNormalize(@fldName)
	SET @fldFamily=Com.fn_TextNormalize(@fldFamily)
	SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
	declare   @fldId int,@flag bit=0
	select @fldID =ISNULL(max(fldId),0)+1 from [Com].[tblEmployee] 
	INSERT INTO [Com].[tblEmployee] ([fldId], [fldName], [fldFamily], [fldCodemeli],  [fldUserId], [fldDesc], [fldDate],fldStatus ,fldTypeShakhs)
	SELECT @fldId, @fldName, @fldFamily, @fldCodemeli, @fldUserId, @fldDesc, GETDATE(),@fldStatus ,@fldTypeShakhs
	if (@@ERROR<>0)
	begin
		set @flag=1
		rollback
    end
	if(@flag=0)
	begin
	select @AshkhasId =ISNULL(max(fldId),0)+1 from [com].[tblAshkhas] 
	INSERT INTO [com].[tblAshkhas] ([fldId], [fldHaghighiId], [fldHoghoghiId], [fldUserId], [fldDesc], [fldDate])
	SELECT @AshkhasId, @fldID,NULL, @fldUserId, @fldDesc, getdate()
	if (@@ERROR<>0)
	begin
		set @flag=1
		rollback
    end
	end
	
	
	
	COMMIT


	 
	


GO
