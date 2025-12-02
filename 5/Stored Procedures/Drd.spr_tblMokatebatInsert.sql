SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [Drd].[spr_tblMokatebatInsert] 
	@fldID INT OUT,
    @fldCodhayeDaramadiElamAvarezId int,
    @fldUserId int,
    @fldDesc nvarchar(MAX)
	
   
AS 
	
	BEGIN TRAN

     	select @fldID =ISNULL(max(fldId),0)+1 from [Drd].[tblMokatebat] 
	    INSERT INTO [Drd].[tblMokatebat] ([fldId], [fldCodhayeDaramadiElamAvarezId], [fldFileId], [fldUserId], [fldDesc], [fldDate])
	    SELECT @fldID, @fldCodhayeDaramadiElamAvarezId, NULL, @fldUserId, @fldDesc, getdate()
        if(@@ERROR<>0)
		   BEGIN
	
			  Rollback
		  END
      
	COMMIT
GO
