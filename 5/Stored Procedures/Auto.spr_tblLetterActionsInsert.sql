SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Auto].[spr_tblLetterActionsInsert] 
  
    @fldLetterId bigint,
   
    @fldLetterActionTypeId int,
    @fldUserId int,
    @fldOrganId int,
    @fldDesc nvarchar(100),
   
    @fldIP nvarchar(16)
AS 

	
	BEGIN TRAN
	set @fldDesc=com.fn_TextNormalize(@fldDesc)
	declare @fldID int  ,@fldTarikhAnjam nvarchar(10),
    @fldTimeAnjam nvarchar(8)
	set @fldTarikhAnjam=dbo.Fn_AssembelyMiladiToShamsi(getdate())
	set @fldTimeAnjam =cast(cast(getdate() as time(0))as varchar(8))
	select @fldID =ISNULL(max(fldId),0)+1 from [Auto].[tblLetterActions] 

	INSERT INTO [Auto].[tblLetterActions] ([fldId], [fldLetterId], [fldTarikhAnjam], [fldTimeAnjam], [fldLetterActionTypeId], [fldUserId], [fldOrganId], [fldDesc], [fldDate], [fldIP])
	SELECT @fldId, @fldLetterId, @fldTarikhAnjam, @fldTimeAnjam, @fldLetterActionTypeId, @fldUserId, @fldOrganId, @fldDesc, getdate(), @fldIP
	if(@@Error<>0)
        rollback       
	COMMIT
GO
