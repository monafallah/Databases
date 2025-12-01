SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[prs_tblLimitationTimeInsert] 
  
    @fldUserLimId int,
    @fldRoozHafte nvarchar(50),
    @fldAzSaat int,
    @fldTaSaat int,
    @fldDesc nvarchar(100),
	  @inputid int,
    @fldJsonParametr nvarchar(2000)
AS 

	
	BEGIN TRAN
		Declare  @fldRowId varbinary(8)
		set @fldDesc=dbo.fn_TextNormalize(@fldDesc)
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [dbo].[tblLimitationTime] 

	INSERT INTO [dbo].[tblLimitationTime] ([fldId], [fldUserLimId], [fldRoozHafte], [fldAzSaat], [fldTaSaat], [fldDesc],fldInputId)
	SELECT @fldId, @fldUserLimId, @fldRoozHafte, @fldAzSaat, @fldTaSaat, @fldDesc,@inputid
	if(@@Error<>0)
     begin 
	    rollback   
		end
	  else
	begin
		select @fldRowId=tblLimitationTime.%%physLoc%% from tblLimitationTime WHERE  [fldId] = @fldId
		exec  [Trans].[prs_tblSubTransactionInsert] '',
													@inputId ,
													1 ,
													1 ,
													'tblLimitationTime' ,
													@fldRowId,
													null ,
													@fldJsonParametr 
		if(@@ERROR<>0)
		rollback
	end
	COMMIT
GO
