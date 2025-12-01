SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[prs_tblTimeLimit_UserInsert] 
    @fldAppId int,
    @fldTimeLimit smallint,
    @fldUserId int,
	@fldInputid int
AS 
	
	BEGIN TRAN
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [dbo].[tblTimeLimit_User] 
	INSERT INTO [dbo].[tblTimeLimit_User] ([fldId], [fldAppId], [fldTimeLimit], [fldUserId])
	SELECT @fldId, @fldAppId, @fldTimeLimit, @fldUserId
	if (@@ERROR<>0)
		begin
		ROLLBACK
	end
	
	COMMIT
GO
