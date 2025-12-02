SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Com].[spr_tblCompanyPostInsert] 

    @fldTitle nvarchar(150),
    @fldUserId int,
    @fldDesc nvarchar(100)
AS 

	
	BEGIN TRAN
	set @fldTitle=com.fn_TextNormalize(@fldTitle)

	set @fldDesc=com.fn_TextNormalize(@fldDesc)
	declare @fldID smallint 
	select @fldID =ISNULL(max(fldId),0)+1 from [Com].[tblCompanyPost] 

	INSERT INTO [Com].[tblCompanyPost] ([fldId], [fldTitle], [fldUserId], [fldDesc], [fldDate])
	SELECT @fldId, @fldTitle, @fldUserId, @fldDesc, getdate()
	if(@@Error<>0)
        rollback       
	COMMIT
GO
