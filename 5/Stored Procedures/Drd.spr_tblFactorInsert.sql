SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblFactorInsert] 
   
    @fldFishId int,
    @fldUserId int,
    @fldDesc nvarchar(MAX)
  
AS 
	
	BEGIN TRAN
	set @fldDesc=com.fn_TextNormalize(@fldDesc)
	declare @fldID int 
	if not exists (select fldFishId from [Drd].[tblFactor] where fldFishId=@fldFishId)
	  begin
		select @fldID =ISNULL(max(fldId),0)+1 from [Drd].[tblFactor] 
		INSERT INTO [Drd].[tblFactor] ([fldId], [fldFishId], [fldUserId], [fldDesc], [fldDate])
		SELECT @fldId, @fldFishId, @fldUserId, @fldDesc, getdate()
	      if (@@ERROR<>0)
		    ROLLBACK
       end
    else
	UPDATE [Drd].[tblFactor]
	SET     [fldDate] = getdate()
	WHERE  [fldFishId] = @fldFishId

	COMMIT

	
GO
