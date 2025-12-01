SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROC [dbo].[prs_tblErrorInsert] 
    @fldID  INT out,
    @fldMatn nvarchar(MAX),
    @fldTarikh date,

	@fldInputID int,
    @fldDesc nvarchar(MAX)
AS 
	
	BEGIN TRAN
	declare @fldUserId int

	select @fldUserId=flduserid from tblInputInfo where fldid=@fldInputID
	select @fldID =ISNULL(max(fldId),0)+1 from [dbo].[tblError] 
	INSERT INTO [dbo].[tblError] ([fldId], [fldMatn], [fldTarikh], [fldUserId], [fldDesc], [fldDate],fldInputID)
	SELECT @fldId, @fldMatn, @fldTarikh,  @fldUserId, @fldDesc, GETDATE(),@fldInputID
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
