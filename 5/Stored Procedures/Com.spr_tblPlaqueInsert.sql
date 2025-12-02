SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblPlaqueInsert] 

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
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [Com].[tblPlaque] 

	INSERT INTO [Com].[tblPlaque] ([fldId], [fldSerialPlaque], [fldPlaque], [fldUserId], [fldDesc], [fldDate], [fldIP])
	SELECT @fldId, @fldSerialPlaque, @fldPlaque, @fldUserId, @fldDesc, getdate(), @fldIP
	if(@@Error<>0)
        rollback       
	COMMIT
GO
