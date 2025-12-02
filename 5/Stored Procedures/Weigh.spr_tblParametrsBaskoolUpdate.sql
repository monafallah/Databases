SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Weigh].[spr_tblParametrsBaskoolUpdate] 
    @fldId int,
    @fldEnName varchar(300),
    @fldFaName nvarchar(400),
    @fldUserId int,
  
    @fldDesc nvarchar(100),
   
    @fldIP nvarchar(16)
AS 

	BEGIN TRAN
	set @fldFaName=com.fn_TextNormalize(@fldFaName)
	UPDATE [Weigh].[tblParametrsBaskool]
	SET    [fldEnName] = @fldEnName, [fldFaName] = @fldFaName, [fldUserId] = @fldUserId, [fldDesc] = @fldDesc, [fldDate] = getdate(), [fldIP] = @fldIP
	WHERE  fldId=@fldId
	if(@@Error<>0)
        rollback   

	COMMIT
GO
