SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Dead].[spr_tblGhabreAmanatInsert] 
 
    @fldShomareId int,
  
    @fldEmployeeId int,
    @fldOrganId int,
    @fldTarikhRezerv int = NULL,
    @fldUserId int,
    @fldDesc nvarchar(100),
    @fldIP nvarchar(15)
AS 

	
	BEGIN TRAN
	set @fldDesc=com.fn_TextNormalize(@fldDesc)
	declare @fldID int ,  @fldShomareTabaghe tinyint
	select @fldID =ISNULL(max(fldId),0)+1 from [Dead].[tblGhabreAmanat] 

	INSERT INTO [Dead].[tblGhabreAmanat] ([fldId], [fldShomareId], [fldShomareTabaghe], [fldEmployeeId], [fldOrganId], [fldTarikhRezerv], [fldUserId], [fldDesc], [fldDate], [fldIP])
	SELECT @fldId, @fldShomareId, NUll, @fldEmployeeId, @fldOrganId, @fldTarikhRezerv, @fldUserId, @fldDesc, GETDATE(), @fldIP
	if(@@Error<>0)
        rollback       
	COMMIT
GO
