SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[prs_tblStateInsert] 
   
    @fldNameState nvarchar(150),
    @fldCountryId smallint,
	@inputid int,
	@fldJsonParametr nvarchar(2000)
AS 

	
	BEGIN TRAN
	Declare  @fldRowId varbinary(8),@flag bit=0
	set @fldNameState=dbo.fn_TextNormalize(@fldNameState)
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [dbo].[tblState] 

	INSERT INTO [dbo].[tblState] ([fldId], [fldNameState], [fldCountryId])
	SELECT @fldId, @fldNameState, @fldCountryId
	if(@@Error<>0)
        rollback 
	else
	begin
		select @fldRowId=tblState.%%physLoc%% from tblState WHERE  [fldId] = @fldId
		exec  [Trans].[prs_tblSubTransactionInsert] '',
													@inputId ,
													1 ,
													1 ,
													'tblState' ,
													@fldRowId,
													null ,
													@fldJsonParametr 
		if(@@ERROR<>0)
		rollback
	end        
	COMMIT
GO
