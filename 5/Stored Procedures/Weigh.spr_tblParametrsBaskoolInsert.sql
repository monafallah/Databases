SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Weigh].[spr_tblParametrsBaskoolInsert] 
 
    @fldEnName varchar(300),
    @fldFaName nvarchar(400),
    @fldUserId int,

    @fldDesc nvarchar(100),
  
    @fldIP nvarchar(16)
AS 

	
	BEGIN TRAN
	set @fldFaName=com.fn_TextNormalize(@fldFaName)
	declare @fldID int 
	select @fldID =ISNULL(max(fldId),0)+1 from [Weigh].[tblParametrsBaskool] 

	INSERT INTO [Weigh].[tblParametrsBaskool] ([fldId], [fldEnName], [fldFaName], [fldUserId], [fldDesc], [fldDate], [fldIP])
	SELECT @fldId, @fldEnName, @fldFaName, @fldUserId, @fldDesc, getdate(), @fldIP
	if(@@Error<>0)
        rollback       
	COMMIT
GO
