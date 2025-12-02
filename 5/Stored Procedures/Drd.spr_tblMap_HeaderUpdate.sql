SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblMap_HeaderUpdate] 
    @fldId int,
    @fldSalMada smallint,
    @fldSalMaghsad smallint,
    @fldMarja nvarchar(15),
	@fldUserId int
AS 
	 
	
	BEGIN TRAN

	UPDATE [Drd].[tblMap_Header]
	SET    [fldSalMada] = @fldSalMada, [fldSalMaghsad] = @fldSalMaghsad, [fldMarja] = @fldMarja, [fldDate] = getdate(),fldUserId=@fldUserId
	WHERE  [fldId] = @fldId
	
	if (@@error<>0)
		rollback

	COMMIT
GO
