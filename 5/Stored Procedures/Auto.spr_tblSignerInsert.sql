SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

/****** Object:  StoredProcedure [dbo].[sp_tblSignerInsert]    Script Date: 10/25/22 12:49:57 PM ******/
CREATE PROC [Auto].[spr_tblSignerInsert] 
    @fldLetterID bigint,
    @fldSignerComisionID int,
    @fldIndexerID int,
    @fldFirstSigner int,
    @fldUserID int,
	@fldOrganId int,
    @fldDesc nvarchar(100),
	@fldIP nvarchar(16)
AS 
declare @fldId int 
select @fldId =ISNULL(max(fldId),0)+1 from [Auto].[tblSigner]
set @fldDesc=com.fn_TextNormalize(@fldDesc)
BEGIN TRAN
	INSERT INTO [Auto].[tblSigner] ([fldID], [fldLetterID], [fldSignerComisionID],  [fldIndexerID], [fldFirstSigner], [fldDate], [fldUserID], [fldDesc],fldOrganId ,fldIP)
	
	SELECT @fldID, @fldLetterID, @fldSignerComisionID, @fldIndexerID, @fldFirstSigner, GETDATE(), @fldUserID, @fldDesc,@fldOrganId,@fldIP
  IF(@@ERROR<>0)
   ROLLBACK
	   
COMMIT TRAN

GO
