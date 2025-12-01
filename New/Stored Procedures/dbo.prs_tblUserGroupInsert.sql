SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[prs_tblUserGroupInsert] 

    @fldTitle nvarchar(100),
   
    @fldInputID INT,
    @fldDesc nvarchar(MAX),
    @fldUserType TINYINT,
    @fldUserId int,
    @fldJsonParametr nvarchar(2000)
AS 
	
	BEGIN TRAN
	SET @fldDesc=dbo.fn_TextNormalize(@fldDesc)
	SET @fldTitle=dbo.fn_TextNormalize(@fldTitle)
	declare @fldID int
	Declare  @fldRowId varbinary(8) 
	select @fldID =ISNULL(max(fldId),0)+1 from [dbo].[tblUserGroup] 
	INSERT INTO [dbo].[tblUserGroup] ([fldID], [fldTitle],[fldInputID], [fldDesc], [fldDate],[fldUserType],[fldUserId],fldOrder)
	SELECT @fldID, @fldTitle ,@fldInputID, @fldDesc, GETDATE(),@fldUserType,@fldUserId,@fldID
	if (@@ERROR<>0)
	begin	
		rollback
		
	end
	else
	begin
		select @fldRowId=tblUserGroup.%%physLoc%% from tblUserGroup WHERE  [fldId] = @fldId
		exec  [Trans].[prs_tblSubTransactionInsert] '',
													@fldInputId ,
													1 ,
													1 ,
													'tblUserGroup' ,
													@fldRowId,
													null ,
													@fldJsonParametr 
		if(@@ERROR<>0)
		rollback
	end
	COMMIT
GO
