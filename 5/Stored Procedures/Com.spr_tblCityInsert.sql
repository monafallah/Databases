SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblCityInsert] 
 
    @fldName nvarchar(150),
    @fldStateId int,
	@fldLatitude nvarchar(50),
	@fldLongitude nvarchar(50),
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	
	BEGIN TRAN
	declare @fldID int 
	SET @fldName=Com.fn_TextNormalize(@fldname)
	SET @fldDesc=Com.fn_TextNormalize(@fldDesc)
	select @fldID =ISNULL(max(fldId),0)+1 from [Com].[tblCity] 
	INSERT INTO [Com].[tblCity] ([fldId], [fldName], [fldStateId], [fldUserId], [fldDesc], [fldDate], fldLatitude, fldLongitude)
	SELECT @fldId, @fldName, @fldStateId, @fldUserId, @fldDesc, GETDATE(),@fldLatitude,@fldLongitude
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
