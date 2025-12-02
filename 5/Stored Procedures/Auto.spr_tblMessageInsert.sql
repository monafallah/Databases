SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Auto].[spr_tblMessageInsert] 
 @fldID int out,
    @fldCommisionId int,
    @fldTitle nvarchar(50),
    @fldMatn nvarchar(MAX),
    @fldUserId int,
    @fldDesc nvarchar(MAX),
  
    @fldOrganId int,
    @fldIP nvarchar(15)
AS 

	
	BEGIN TRAN

	set @fldMatn=com.fn_TextNormalize(@fldMatn)
	set @fldDesc=com.fn_TextNormalize(@fldDesc)
	set @fldTitle=com.fn_TextNormalize(@fldTitle)
	--declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [Auto].[tblMessage] 

	INSERT INTO [Auto].[tblMessage] ([fldId], [fldCommisionId], [fldTitle], [fldMatn], [fldUserId], [fldDesc], [fldDate], [fldOrganId], [fldIP],fldTarikhShamsi)
	SELECT @fldId, @fldCommisionId, @fldTitle, @fldMatn, @fldUserId, @fldDesc, getdate(), @fldOrganId, @fldIP,dbo.Fn_AssembelyMiladiToShamsi(getdate())
	if(@@Error<>0)
        rollback       
	COMMIT
GO
