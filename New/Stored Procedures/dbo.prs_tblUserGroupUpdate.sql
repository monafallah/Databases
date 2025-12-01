SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[prs_tblUserGroupUpdate] 
    @fldID int,
    @fldTitle nvarchar(100),
    
    @fldInputID int,
    @fldDesc nvarchar(MAX),
    @fldUserType TINYINT,
    @fldUserId int,
	@fldTimeStamp int
AS 
	BEGIN TRAN
		Declare @flag tinyint,@fldRowId varbinary(8),
	@fldRowId_Next_Up_Del varbinary(8)
	SET @fldDesc=dbo.fn_TextNormalize(@fldDesc)
	SET @fldTitle=dbo.fn_TextNormalize(@fldTitle)
	if not exists(select * from tblUserGroup where fldId=@fldId )
			set @flag= 2 
		else if exists( select * from tblUserGroup where fldId=@fldId and fldTimeStamp=@fldTimeStamp)
			set @flag=1 
		else if not exists(select * from tblUserGroup where fldId=@fldId and fldTimeStamp=@fldTimeStamp)
			set @flag=0 
	if(@flag=1)
	begin
	UPDATE [dbo].[tblUserGroup]
	SET [fldTitle] = @fldTitle,[fldInputID] = @fldInputID, [fldDesc] = @fldDesc, [fldDate] = GETDATE(),[fldUserType]=@fldUserType,[fldUserId]=@fldUserId
	WHERE  [fldID] = @fldID
		select @fldRowId=tblUserGroup.%%physLoc%% from tblUserGroup WHERE  [fldId] = @fldId
	if(@@ERROR<>0)
		Begin
		
			rollback
		end
		select @flag as flag
	end		
	else
		select @flag as flag
	COMMIT TRAN
GO
