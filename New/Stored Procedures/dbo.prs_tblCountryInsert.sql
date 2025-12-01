SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[prs_tblCountryInsert] 

    @fldNameCountry nvarchar(100),
	@inputid int,
    @fldJsonParametr nvarchar(2000)
AS 

	
	BEGIN TRAN
	Declare  @fldRowId varbinary(8)
	set @fldNameCountry=dbo.fn_TextNormalize(@fldNameCountry)
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [dbo].[tblCountry] 

	INSERT INTO [dbo].[tblCountry] ([fldId], [fldNameCountry],fldInputId)
	SELECT @fldId, @fldNameCountry,@inputid
	if(@@Error<>0)
        rollback 
	else
	begin
		select @fldRowId=tblCountry.%%physLoc%% from tblCountry WHERE  [fldId] = @fldId
		exec  [Trans].[prs_tblSubTransactionInsert] '',
													@inputId ,
													1 ,
													1 ,
													'tblCountry' ,
													@fldRowId,
													null ,
													@fldJsonParametr 
		if(@@ERROR<>0)
		rollback
	end	      
	COMMIT
GO
