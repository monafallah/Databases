SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblExternalFishUpdate] 
    @fldId int,
    @fldNameCompany nvarchar(350),
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	BEGIN TRAN
	UPDATE [Drd].[tblExternalFish]
	SET    [fldNameCompany] = @fldNameCompany, [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = GETDATE()
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
