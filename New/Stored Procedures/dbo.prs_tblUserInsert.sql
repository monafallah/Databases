SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[prs_tblUserInsert] 
	@fldID INT OUT,
    @fldUserName nvarchar(100),
    @fldPassword varchar(100),
    @fldActive_Deactive bit,
	@fldShakhsId INT,
    @fldUserId int,
	@fldInputID int,
    @fldDesc nvarchar(MAX)
AS 
	
	BEGIN TRAN
	--declare @fldID int 
	sET @fldDesc=dbo.fn_TextNormalize(@fldDesc)
	select @fldID =ISNULL(max(fldId),0)+1 from [dbo].[tblUser] 
	INSERT INTO [dbo].[tblUser] ([fldId],  [fldUserName], [fldPassword], [fldActive_Deactive],  [fldUserId], [fldDesc], [fldDate],fldShakhsId,fldInputID)
	SELECT @fldId,  @fldUserName, @fldPassword, @fldActive_Deactive,  @fldUserId, @fldDesc, GETDATE(),@fldShakhsId,@fldInputID
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
