SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Pay].[spr_tblMonasebatHeaderUpdate] 
    @fldId int,
    @fldActiveDate int,
    @fldDeactiveDate int,
    @fldActive bit,
    @fldIP varchar(15),
    @fldUserId int
AS 
	BEGIN TRAN
	UPDATE [Pay].[tblMonasebatHeader]
	SET    [fldActiveDate] = @fldActiveDate, [fldDeactiveDate] = @fldDeactiveDate, [fldActive] = @fldActive, [fldIP] = @fldIP, [fldUserId] = @fldUserId, [fldDate] =  getdate()
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
