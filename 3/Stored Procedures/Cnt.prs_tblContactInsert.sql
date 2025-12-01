SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Cnt].[prs_tblContactInsert] 
  @fldId int out,
    @fldTypeContactId tinyint,
    @fldValue nvarchar(300),
    @fldType tinyint,
    @fldUserId int,
	@fldMarakezTeb int,
	@fldAshkhasId int,
	@fldAshkhashoghooghi int,
   @inputid int,
    @fldJsonParametr nvarchar(2000)
AS 

	begin try 
	BEGIN TRAN
	Declare  @fldRowId varbinary(8),@IdAshkhasCont int,@IdMarakezCont int,@IdAshkhasHoghooghi int
	--declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [Cnt].[tblContact] 
	INSERT INTO [Cnt].[tblContact] ([fldId], [fldTypeContactId], [fldValue], [fldType], [fldUserId],fldinputid)
	SELECT @fldId, @fldTypeContactId, @fldValue, @fldType, @fldUserId,@inputid 

	select @fldRowId=tblContact.%%physLoc%% from cnt.tblContact WHERE  [fldId] = @fldId
	exec  [Trans].[prs_tblSubTransactionInsert] '',
													@inputId ,
													1 ,
													1 ,
													'tblContact' ,
													@fldRowId,
													null ,
													@fldJsonParametr 
		
		
		if(@fldAshkhasId is not null and @fldAshkhasId<>0)
		begin
			select @IdAshkhasCont =ISNULL(max(fldId),0)+1 from  [Cnt].[tblContact_Ashkhas]
			insert into  [Cnt].[tblContact_Ashkhas]
			select @IdAshkhasCont,@fldAshkhasId,@fldid
		end
	/*	else if(@fldMarakezTeb is not null and @fldMarakezTeb<>0)
		begin
			select @IdMarakezCont =ISNULL(max(fldId),0)+1 from  [Cnt].[tblContact_MarakezTeb]
			insert into  [Cnt].[tblContact_MarakezTeb]
			select @IdMarakezCont,@fldMarakezTeb,@fldid
			if (@@ERROR<>0)
			begin
				rollback	
				/*exec  [Trans].[prs_tblSubTransactionInsert] '',
															@inputId ,
															1 ,
															0 ,
															'tblContact' ,
															@fldRowId,
															null ,
															@fldJsonParametr */
			end
		end
		if(@fldAshkhashoghooghi is not null and @fldAshkhashoghooghi<>0)
		begin
			select @IdAshkhasHoghooghi =ISNULL(max(fldId),0)+1 from  [Cnt].[tblContact_AshkhasHoghooghi]
			insert into  [Cnt].[tblContact_AshkhasHoghooghi]
			select @IdAshkhasHoghooghi,@fldAshkhashoghooghi,@fldid
			if (@@ERROR<>0)
			begin
				rollback	
				/*exec  [Trans].[prs_tblSubTransactionInsert] '',
															@inputId ,
															1 ,
															0 ,
															'tblContact' ,
															@fldRowId,
															null ,
															@fldJsonParametr */
			end
		end*/

	 
     select 0 as Errorcode,'' as ErrorMsg
	COMMIT
	end try
begin catch
 rollback
 select @@ERROR as Errorcode,ERROR_MESSAGE() as ErrorMsg
end catch
GO
