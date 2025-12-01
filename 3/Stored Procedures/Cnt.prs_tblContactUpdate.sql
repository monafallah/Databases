SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Cnt].[prs_tblContactUpdate] 
    @fldId int,
    @fldTypeContactId tinyint,
    @fldValue nvarchar(300),
    @fldType tinyint,
    @fldUserId int,
	@fldAshkhasId int,
	@fldAshkhasHoghooghiId int,
	@fldMarakezTebId int,
	@inputid int,
	@fldTimeStamp int
AS 
	begin try
	BEGIN TRAN
	Declare @flag tinyint,@flag2 bit=0
	if not exists(select * from [Cnt].[tblContact] where fldId=@fldId )
			set @flag= 2 
		else if exists( select * from [Cnt].[tblContact] where fldId=@fldId and fldTimeStamp=@fldTimeStamp)
			set @flag=1 
		else if not exists(select * from [Cnt].[tblContact] where fldId=@fldId and fldTimeStamp=@fldTimeStamp)
			set @flag=0 
	
	if(@flag=1)
	begin
	UPDATE [Cnt].[tblContact]
	SET    [fldTypeContactId] = @fldTypeContactId, [fldValue] = @fldValue, [fldType] = @fldType, [fldUserId] = @fldUserId
	,fldInputId=@inputid 
	WHERE  fldId=@fldId
	
		if(@fldAshkhasId is not null)
		begin
			update cnt.tblContact_Ashkhas
			set fldAshkhasId=@fldAshkhasId
			where fldContactId=@fldId
			
			end
			
			/*else if(@fldAshkhasHoghooghiId is not null)
				begin
				update cnt.tblContact_AshkhasHoghooghi
				set fldAshkhasHoghooghiId=@fldAshkhasHoghooghiId
				where fldContactId=@fldId
				if(@@ERROR<>0)
					Begin
						rollback
						
					end
				end*/
		
		
	end
	
		select @flag as flag,'' as ErrorMsg
	COMMIT
	end try
	begin catch
	rollback
	select @@ERROR flag,ERROR_MESSAGE() as ErrorMsg
	end catch
GO
