SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[prs_tblCityInsert] 
 
    @fldNameCity nvarchar(150),
    @fldStateId tinyint,
	@inputid int,
	@fldJsonParametr nvarchar(2000)
AS 

	
	BEGIN TRAN
	Declare  @fldRowId varbinary(8),@flag bit=0
	set @fldNameCity =dbo.fn_TextNormalize(@fldNameCity)
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [dbo].[tblCity] 

	INSERT INTO [dbo].[tblCity] ([fldId], [fldNameCity], [fldStateId],fldInputId)
	SELECT @fldId, @fldNameCity, @fldStateId,@inputid
	if(@@Error<>0)
        rollback 
	else
	begin
		select @fldRowId=tblCity.%%physLoc%% from tblCity WHERE  [fldId] = @fldId
		exec  [Trans].[prs_tblSubTransactionInsert] '',
													@inputId ,
													1 ,
													1 ,
													'tblCity' ,
													@fldRowId,
													null ,
													@fldJsonParametr 
		if(@@ERROR<>0)
		rollback
	end  	      
	COMMIT
GO
