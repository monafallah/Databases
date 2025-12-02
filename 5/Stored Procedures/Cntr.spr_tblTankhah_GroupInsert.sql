SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Cntr].[spr_tblTankhah_GroupInsert] 

    @fldTankhahId int,
    @fldTitle nvarchar(300),
    @fldUserId int,
    @fldOrganId int,
    @fldDesc nvarchar(100),
    @fldIP varchar(15)
AS 
	 
	
	BEGIN TRAN
declare @fldid int
set @fldTitle= com.fn_TextNormalize(@fldTitle)
	select @fldid=isnull(max(fldId),0)+1  FROM   [Cntr].[tblTankhah_Group] 
	INSERT INTO [Cntr].[tblTankhah_Group] ([fldId], [fldTankhahId], [fldTitle], [fldUserId], [fldOrganId], [fldDesc], [fldIP], [fldDate])
	SELECT @fldId, @fldTankhahId, @fldTitle, @fldUserId, @fldOrganId, @fldDesc, @fldIP, getdate()
	
	if (@@error<>0)
		rollback
		
				
               
	COMMIT
GO
