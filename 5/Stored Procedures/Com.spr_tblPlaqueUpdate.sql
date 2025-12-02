SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblPlaqueUpdate] 
    @fldId int,
    @fldSerialPlaque tinyint,
     @Haraf nvarchar(1),
    @Plaque1 varchar(2),
	@Plaque2 varchar(3),
    @fldUserId int,
    @fldDesc nvarchar(50),

    @fldIP nvarchar(16)
AS 

	BEGIN TRAN
	declare @fldPlaque nvarchar(13)
	set @fldPlaque='-'+@Plaque2+@Haraf+@Plaque1 
	UPDATE [Com].[tblPlaque]
	SET    [fldSerialPlaque] = @fldSerialPlaque, [fldPlaque] = @fldPlaque, [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = getdate(), [fldIP] = @fldIP
	WHERE  fldId=@fldId
	if(@@Error<>0)
        rollback   

	COMMIT
GO
