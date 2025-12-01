SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Cnt].[prs_tblContact_TreeGroupInsert] 
 
    @fldTreeGroupId int,
    @fldContactId int,
	@inputid int,
    @fldJsonParametr nvarchar(2000)
AS 

	
	BEGIN TRAN
	Declare  @fldRowId varbinary(8)
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [Cnt].[tblContact_TreeGroup] 

	INSERT INTO [Cnt].[tblContact_TreeGroup] ([fldId], [fldTreeGroupId], [fldContactId],fldInputId)
	SELECT @fldId, @fldTreeGroupId, @fldContactId,@inputid
	if (@@ERROR<>0)
	begin
		rollback	
	end
	else
	begin
		select @fldRowId=tblContact_TreeGroup.%%physLoc%% from cnt.tblContact_TreeGroup WHERE  [fldId] = @fldId
		exec  [Trans].[prs_tblSubTransactionInsert] '',
													@inputId ,
													1 ,
													1 ,
													'tblContact_TreeGroup' ,
													@fldRowId,
													null ,
													@fldJsonParametr 
		if(@@ERROR<>0)
		rollback
	end       
	COMMIT
GO
