SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblFileInsert] 

    @fldImage varbinary(MAX),
    @fldPasvand NVARCHAR(5),
    @fldUserId int,
    @fldDesc nvarchar(MAX)
AS 
	
	BEGIN TRAN
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [Com].[tblFile] 
	INSERT INTO [Com].[tblFile] ([fldId], [fldImage],fldPasvand, [fldUserId], [fldDesc], [fldDate])
	SELECT @fldId, @fldImage,@fldPasvand, @fldUserId, @fldDesc, GETDATE()
	if (@@ERROR<>0)
		ROLLBACK

	COMMIT
GO
