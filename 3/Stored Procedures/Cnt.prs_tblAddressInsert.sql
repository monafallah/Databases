SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Cnt].[prs_tblAddressInsert] 

    @fldShahrId int,
    @fldContactId int,
	@fldLatitude nvarchar(50),
	@fldLongitude nvarchar(50),
	@inputid int,
	@fldJsonParametr nvarchar(2000)
AS 

	
	BEGIN TRAN
	Declare  @fldRowId varbinary(8)
	declare @fldID int 

	select @fldID =ISNULL(max(fldId),0)+1 from [Cnt].[tblAddress] 

	INSERT INTO [Cnt].[tblAddress] ([fldId], [fldShahrId], [fldContactId],fldLatitude,fldLongitude,fldInputId)
	SELECT @fldId, @fldShahrId, @fldContactId,@fldLatitude,@fldLongitude,@inputid
	if (@@ERROR<>0)
	begin
		rollback	
	end
	else
	begin
		select @fldRowId=tblAddress.%%physLoc%% from tblAddress WHERE  [fldId] = @fldId
		exec  [Trans].[prs_tblSubTransactionInsert] '',
													@inputId ,
													1 ,
													1 ,
													'tblAddress' ,
													@fldRowId,
													null ,
													@fldJsonParametr 
		if(@@ERROR<>0)
		rollback
	end       
	COMMIT
GO
