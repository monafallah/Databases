SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Weigh].[spr_tblLoadingPlaceInsert] 
   
    @fldName nvarchar(150),
    @fldUserId int,
    @fldDesc nvarchar(100),

    @fldIP varchar(50)
AS 

	
	BEGIN TRAN
	set @fldDesc =com.fn_TextNormalize(@fldDesc)
	set @fldName =com.fn_TextNormalize(@fldName)
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [Weigh].[tblLoadingPlace] 

	INSERT INTO [Weigh].[tblLoadingPlace] ([fldId], [fldName], [fldUserId], [fldDesc], [fldDate], [fldIP])
	SELECT @fldId, @fldName, @fldUserId, @fldDesc, getdate(), @fldIP
	if(@@Error<>0)
        rollback       
	COMMIT
GO
