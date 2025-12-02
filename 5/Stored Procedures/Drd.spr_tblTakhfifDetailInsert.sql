SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblTakhfifDetailInsert] 
    
    @fldTakhfifId int,
    @fldShCodeDaramad int,
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	
	BEGIN TRAN
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [Drd].[tblTakhfifDetail] 
	INSERT INTO [Drd].[tblTakhfifDetail] ([fldId], [fldTakhfifId], [fldShCodeDaramad], [fldUserId], [fldDesc], [fldDate])
	SELECT @fldId, @fldTakhfifId, @fldShCodeDaramad, @fldUserId, @fldDesc, GETDATE()
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
