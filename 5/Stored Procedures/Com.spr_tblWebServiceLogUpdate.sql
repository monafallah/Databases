SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblWebServiceLogUpdate] 
    @fldId int,
    @fldMatn nvarchar(MAX),
    @fldUser nvarchar(50)
AS 
	BEGIN TRAN
	UPDATE [Com].[tblWebServiceLog]
	SET    [fldMatn] = @fldMatn, [fldUser] = @fldUser, [flddate] = GETDATE()
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
