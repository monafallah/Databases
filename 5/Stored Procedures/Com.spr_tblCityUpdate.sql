SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblCityUpdate] 
    @fldId int,
    @fldName nvarchar(150),
    @fldStateId int,
	@fldLatitude nvarchar(50),
	@fldLongitude nvarchar(50),
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	BEGIN TRAN
	SET @fldName=Com.fn_TextNormalize(@fldName)
	SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
	UPDATE [Com].[tblCity]
	SET    [fldId] = @fldId, [fldName] = @fldName, [fldStateId] = @fldStateId, [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = GETDATE()
	,fldLatitude=@fldLatitude
	,fldLongitude=@fldLongitude
	WHERE  [fldId] = @fldId
	COMMIT TRAN
GO
