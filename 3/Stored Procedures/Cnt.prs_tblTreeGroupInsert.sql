SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Cnt].[prs_tblTreeGroupInsert] 
   @fldTitle nvarchar(150),
    @fldGroupId int,
    @fldPId int = NULL,
	@inputid int,
    @fldJsonParametr nvarchar(2000)
AS 

	
	BEGIN TRAN
	Declare  @fldRowId varbinary(8)
	set @fldTitle=dbo.fn_TextNormalize(@fldTitle)
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [Cnt].[tblTreeGroup] 
	INSERT INTO [Cnt].[tblTreeGroup] ([fldId], [fldGroupId], [fldPId],fldTitle,fldInputId)
	SELECT @fldId, @fldGroupId, @fldPId,@fldTitle,	@inputid 
	if (@@ERROR<>0)
	begin
		rollback	
		
	end
	else
	begin
		select @fldRowId=tblTreeGroup.%%physLoc%% from cnt.tblTreeGroup WHERE  [fldId] = @fldId
		exec  [Trans].[prs_tblSubTransactionInsert] '',
													@inputId ,
													1 ,
													1 ,
													'tblTreeGroup' ,
													@fldRowId,
													null ,
													@fldJsonParametr 
		if(@@ERROR<>0)
		rollback
	end        
	COMMIT
GO
