SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Auto].[spr_tblAshkhaseHoghoghiTitlesInsert] 
  
    @fldName nvarchar(300),
    @fldAshkhasHoghoghiId int,
    @fldIP varchar(15),
    @fldDesc nvarchar(100),
  
    @fldUserId int,
    @fldOrganId int
AS 
	 
	
	BEGIN TRAN
	set @fldName=com.fn_TextNormalize(@fldName)
	set @fldDesc=com.fn_TextNormalize(@fldDesc)
declare @fldid int
	select @fldid=isnull(max(fldId),0)+1  FROM   [Auto].[tblAshkhaseHoghoghiTitles] 
	INSERT INTO [Auto].[tblAshkhaseHoghoghiTitles] ([fldId], [fldName], [fldAshkhasHoghoghiId], [fldIP], [fldDesc], [fldDate], [fldUserId], [fldOrganId])
	SELECT @fldId, @fldName, @fldAshkhasHoghoghiId, @fldIP, @fldDesc, getdate(), @fldUserId, @fldOrganId
	
	if (@@error<>0)
		rollback
		
				
               
	COMMIT
GO
