SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[prs_tblLimitationIPInsert] 
 
    @fldUserLimId int,
    @fldIPValid varchar(50),
    @fldDesc nvarchar(100),
    @inputid int,
    @fldJsonParametr nvarchar(2000)
AS 

	
	BEGIN TRAN
		Declare  @fldRowId varbinary(8)
	declare @fldID int 
	set @fldDesc=dbo.fn_TextNormalize(@fldDesc)
	select @fldID =ISNULL(max(fldId),0)+1 from [dbo].[tblLimitationIP] 

	INSERT INTO [dbo].[tblLimitationIP] ([fldId], fldUserLimId, [fldIPValid],  [fldDesc],fldInputId)
	SELECT @fldId, @fldUserLimId, @fldIPValid, @fldDesc,@inputid
	if(@@Error<>0)
     begin 
	    rollback   
		end
	  else
	begin
		select @fldRowId=tblLimitationIP.%%physLoc%% from tblLimitationIP WHERE  [fldId] = @fldId
		exec  [Trans].[prs_tblSubTransactionInsert] '',
													@inputId ,
													1 ,
													1 ,
													'tblLimitationIP' ,
													@fldRowId,
													null ,
													@fldJsonParametr 
		if(@@ERROR<>0)
		rollback
	end
	COMMIT
GO
