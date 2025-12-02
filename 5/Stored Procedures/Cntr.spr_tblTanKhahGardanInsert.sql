SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Cntr].[spr_tblTanKhahGardanInsert] 
   
    @fldEmployeeId int,
  
    @fldOrganId int,
    @fldUserId int,
    @fldDesc nvarchar(150),

    @fldIP varchar(15)
AS 
	 
	
	BEGIN TRAN
declare @fldid int
SET @fldDesc=com.fn_TextNormalize(@fldDesc)
	select @fldid=isnull(max(fldId),0)+1  FROM   [Cntr].[tblTanKhahGardan] 
	INSERT INTO [Cntr].[tblTanKhahGardan] ([fldId], [fldEmployeeId], [fldStatus], [fldOrganId], [fldUserId], [fldDesc], [fldDate], [fldIP])
	SELECT @fldId, @fldEmployeeId, 1, @fldOrganId, @fldUserId, @fldDesc, getdate(), @fldIP
	
	if (@@error<>0)
		rollback
		
				
               
	COMMIT
GO
