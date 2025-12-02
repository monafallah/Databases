SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblMonasebatHeaderInsert] 
    @fldActiveDate int,
    @fldIP varchar(15),
    @fldUserId int
AS 
	
	BEGIN TRAN
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [Pay].[tblMonasebatHeader] 
	INSERT INTO [Pay].[tblMonasebatHeader] ([fldId], [fldActiveDate], [fldDeactiveDate], [fldActive], [fldIP], [fldUserId], [fldDate])
	SELECT @fldId, @fldActiveDate, null, 1, @fldIP, @fldUserId, getdate()
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
