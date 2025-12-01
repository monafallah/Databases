SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Cnt].[prs_tblContactGroupInsert] 
   
    @fldNameGroup nvarchar(250),
    @fldUserId int,
	@inputid int,
    @fldJsonParametr nvarchar(2000)
AS 

	
	BEGIN TRAN
	Declare  @fldRowId varbinary(8),@idtree int
	set @fldNameGroup=dbo.fn_TextNormalize(@fldNameGroup)
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [Cnt].[tblContactGroup] 

	INSERT INTO [Cnt].[tblContactGroup] ([fldId], [fldNameGroup], [fldUserId],fldInputId)
	SELECT @fldId, @fldNameGroup, @fldUserId,@inputid
	if (@@ERROR<>0)
	begin
		rollback	
		
	end
	else
	begin
		select @fldRowId=tblContactGroup.%%physLoc%% from tblContactGroup WHERE  [fldId] = @fldId
		exec  [Trans].[prs_tblSubTransactionInsert] '',
													@inputId ,
													1 ,
													1 ,
													'tblContactGroup' ,
													@fldRowId,
													null ,
													@fldJsonParametr 
		if(@@ERROR<>0)
		rollback

	/*select @idtree =ISNULL(max(fldId),0)+1 from [Cnt].[tblTreeGroup] 
	INSERT INTO [Cnt].[tblTreeGroup] ([fldId], [fldGroupId], [fldPId])
	SELECT @idtree, @fldid, @fldPId
	if (@@ERROR<>0)
	begin
		rollback	
		exec  [Trans].[prs_tblSubTransactionInsert] '',
													@inputId ,
													1 ,
													0 ,
													'tblContactGroup' ,
													@fldRowId,
													null ,
													@fldJsonParametr 
	end*/
	end      
	COMMIT
GO
